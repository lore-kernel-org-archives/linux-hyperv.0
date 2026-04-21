Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B3126C0;
	Tue, 21 Apr 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793786; cv=none; b=RSPXgpObjWCIK/rFsxA2Qm8yuszpDkRdVVyBUd71qZ0rBm6Siv0pLLrob+scKuCezjRfaRxtCALm/a0a8wkhk6Itl80ypQiZ2dMLWCZd7vAp4SQGy1RpT3a7e7+EP8VJGywPDGNNZOgjbgDLeYt7hrqt6jrXGGCWZQaT+HKET6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793786; c=relaxed/simple;
	bh=F4Tkyfrx+UawR2rndKJ7N9scLmNrjCXZ024UODv9rWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIyYWrQogH2ieQGDjmcfXqkU2PSYC6l+b6zz16cLEMpgEJyOe9dgnHL0MzSX10q0YBT7SWAwjzV1wNzRoIpkRSYLChu5EmLHk6hNSiei1rnXIJGFshQEgueJ6O79yEvEFVfN2rZbGOh4OY70dB4L9zv0KjDIYfWUATCo4Zer2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 2E55120B6F01; Tue, 21 Apr 2026 10:49:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E55120B6F01
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	niuxuewei.nxw@antgroup.com,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net] hv_sock: Return -EIO for malformed/short packets
Date: Tue, 21 Apr 2026 10:49:31 -0700
Message-ID: <20260421174931.1152238-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f63152958994 fixes a regression, however it fails to report an
error for malformed/short packets -- normally we should never see such
packets, but let's report an error for them just in case.

Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Commit f63152958994 is currently only in net.git's master branch.

 net/vmw_vsock/hyperv_transport.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 76e78c83fdbc..8faaa14bccda 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -704,18 +704,27 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 		if (hvs->recv_desc) {
 			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
 			 * be NULL unless it points to the 0-byte-payload FIN
-			 * packet: see hvs_update_recv_data().
+			 * packet or a malformed/short packet: see
+			 * hvs_update_recv_data().
 			 *
-			 * Here all the payload has been dequeued, but
-			 * hvs_channel_readable_payload() still returns 1,
-			 * because the VMBus ringbuffer's read_index is not
-			 * updated for the FIN packet: hvs_stream_dequeue() ->
-			 * hv_pkt_iter_next() updates the cached priv_read_index
-			 * but has no opportunity to update the read_index in
-			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
-			 * 0 for the FIN packet, so it won't get dequeued.
+			 * If hvs->recv_desc points to the FIN packet, here all
+			 * the payload has been dequeued and the peer_shutdown
+			 * flag is set, but hvs_channel_readable_payload() still
+			 * returns 1, because the VMBus ringbuffer's read_index
+			 * is not updated for the FIN packet:
+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
+			 * the cached priv_read_index but has no opportunity to
+			 * update the read_index in hv_pkt_iter_close() as
+			 * hvs_stream_has_data() returns 0 for the FIN packet,
+			 * so it won't get dequeued.
+			 *
+			 * In case hvs->recv_desc points to a malformed/short
+			 * packet, return -EIO.
 			 */
-			return 0;
+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)
+				return 0;
+			else
+				return -EIO;
 		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
-- 
2.49.0

