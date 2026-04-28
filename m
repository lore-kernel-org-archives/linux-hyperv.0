Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB132ED2E;
	Tue, 28 Apr 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374358; cv=none; b=cApl7egSLmBFcJN7wNSk3Medr2X8okPG4nEa6JB6eWxekEngT1+b5OLf7esbCr353szLD3MkCtldKeACuki1TydZq+rbXoNRQk4kRVIFoRmtamEzYHWwa50tSn4xWOIrZh+BSqkcwhhd4uO90Ia5V2jj97ai57tSGogOgEIzoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374358; c=relaxed/simple;
	bh=caqIYwnjilOt3bBItl3kcLwumvLuFlnnC2aE+cxyUX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKxCPfWtNE1AfzW8422dbzNF10YTGFEO9qxlAVEHBb0q5pIuKvNfAiiQNqV3zZUOfot9axSKUFhZJx4VNVpJ2GOBl4RAB/KKLL/wJusAXNnG7gV/Afn3cb6DD9QJkarMKxYi5LjZeR0oFlfqnP0hT1m+ZH42nn90egRv2sMEaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hbmr2sxJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hbmr2sxJ"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id F3B3720B716A; Tue, 28 Apr 2026 04:05:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3B3720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777374352;
	bh=ADJ173LfL3gB3EbqBgQN86uuLabXnroNQ1GcY7gcpWk=;
	h=From:To:Cc:Subject:Date:From;
	b=hbmr2sxJCXIh7fSbYGTeBMsvMFyIWCcJb/C/T4CNBFCf8twFmv3XNUUYsRSAid30d
	 zOXXGkZ9IyoE7NIp2rrYfMtklo6A8WqwKOGMcHNqgOYHh1rdwAldxcF8dNQav8CeQP
	 L3Bdlg/xdUDIHvJm88f6bsW88DAIwaljDVo6b3Eg=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Himadri Pandya <himadrispandya@gmail.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@kernel.vger.org
Subject: [PATCH] hv_sock: fix ARM64 support
Date: Tue, 28 Apr 2026 07:05:30 -0400
Message-ID: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMBUS ring buffers must be page aligned. Therefore, the current value of
24K presents a challenge on ARM64 kernels (with 64K pages). So, use
VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
hold all of the relevant data.

Cc: stable@kernel.vger.org
Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..40f09b23efa3 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 	} else {
 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
+		sndbuf = VMBUS_RING_SIZE(sndbuf);
 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
 	}
 
 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
-- 
2.54.0

