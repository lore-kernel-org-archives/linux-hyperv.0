Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0638CFFE;
	Sun, 17 May 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023443; cv=none; b=U7huSEPPIuIRHNM+Z0UzNefx8tRSrzI7k+VXDvr8a/uagLA0Dq+5AiOKdO0YLz/6+GrD0QFGXROrB2ujJUM5LiFhjooUKJ8k9fpk3KZ00Fa7RTGNsQX2TqhsGZdNPxe8yGxPXMgmQnQEl5TVtX2JPMT0tJ0hKbAZxHsGfZDWlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023443; c=relaxed/simple;
	bh=3DVmkJoAp/qaq00ml8gjYKeM1A4IlJloY1x5qjiSRSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnvDafwQdemnFMf+2A1qWNF+jt7EvQoFtSp4jOvaIlql9C/saSE4m+4jQ/OKawlTyAtaJSl+p3L1KOfebf1fcuZuNsJJQLlFL+pj4kSEWAGjOQ2Nkk6qJ/bSfSpCgD8MUMhxFRFcasIyMumwtVxGk1Rr599IUhjgsUtxtj7uNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=EoYmUfQ3; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="EoYmUfQ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PBjs0lncXBQIUANeQ0FdMkMsnlM+ULn4MUfrxqEcwrE=; b=EoYmUfQ3MeS4j3A1WqG8gqXVEv
	l+wOPiE6yg7icRPFywNqpc3i+6ozwTfquB6M/seo3tpuBWkRJJCGSSSsfPwGm/DbZ/svnqnB+c8H6
	Zyayagx0/uaNyE85357t2QLWWS57AOZKeb9/Yhh7AO2GTLNhvAMbNUjmRapgepuVhltnySdxHrBY9
	Du8lsN9IYdNGxtp7t0BOxmmT2wzDAla8taQoPtFoRUsH0SveqdgGhlnTrFICUPeHDuKBZU13Xmf/t
	inCqMt07/HluE4QOV53amG+wa+x+NJPjABi6TrtHEA4lMRCN/p3hoHDGLm6z1SCp6AR1XhmVrQIwf
	xkQzkb9A==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wObGF-00H5VV-0s;
	Sun, 17 May 2026 13:10:28 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 2/2] drm/hyperv: validate VMBus packet size in receive callback
Date: Sun, 17 May 2026 14:55:02 +0200
Message-ID: <20260517-drm-hyperv-patch2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

hyperv_receive() reads bytes_recvd from vmbus_recvpacket() but does not
forward that value to hyperv_receive_sub(). The sub-handler reads
msg->vid_hdr.type and msg->feature_chg.is_dirt_needed without knowing
how many bytes the host actually wrote, so a short packet leaves the
parser reading bytes that the host did not write in this packet. The
unconditional memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE) on the
wait-completion path also copies the full 16 KiB recv_buf regardless
of bytes_recvd, including any residue from the prior message.

Pass bytes_recvd into hyperv_receive_sub() and reject any packet shorter
than the pipe + synthvid header. The dirt-feature branch additionally
requires the feature_change payload size before reading is_dirt_needed.
The init_buf copy now uses bytes_recvd as the length argument, which
keeps it bounded by VMBUS_MAX_PACKET_SIZE through the new upper check.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 003bb118d64c..0d32d9944c43 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -420,26 +420,35 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev)
+static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
 	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
+	size_t hdr_size;
 
 	if (!hv)
 		return;
 
+	hdr_size = sizeof(struct pipe_msg_hdr) +
+		   sizeof(struct synthvid_msg_hdr);
+	if (bytes_recvd < hdr_size || bytes_recvd > VMBUS_MAX_PACKET_SIZE)
+		return;
+
 	msg = (struct synthvid_msg *)hv->recv_buf;
 
 	/* Complete the wait event */
 	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
+		memcpy(hv->init_buf, msg, bytes_recvd);
 		complete(&hv->wait);
 		return;
 	}
 
 	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+		if (bytes_recvd < hdr_size +
+		    sizeof(struct synthvid_feature_change))
+			return;
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
@@ -466,7 +475,7 @@ static void hyperv_receive(void *ctx)
 				       &bytes_recvd, &req_id);
 		if (bytes_recvd > 0 &&
 		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+			hyperv_receive_sub(hdev, bytes_recvd);
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
-- 
2.47.3

