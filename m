Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203507;
	b=m0rUL9cIijtdvqFVUsUeKUokJ/I37Kop/MzKbM+BTfJ86LusM8fsY7LSjz3pd2e83s8X
	 QsbWg541Qxs+v2zZbW8dbBmmnu8VIbRAZOk8i2pLNoK6wgFUqTuM+zSeGZZ7/7kn5nVSq
	 u6yKLlM20xVPUvKkcTRCwko32QZg+eo5on4PSJeLrmne6q0NaZ2NPzjZJLMNJEtemGfLf
	 Y0b0mfoiRAlq01sORAIDIMOA5tx0ov6ZhKJAhzfZkHGfy2Vj+L1rVRzFiGhCzz/eTOUum
	 U2/E9yu6HGTro6GsiO+jmZPI52Il7r9wdUfIwlrpmx4IsufE1Ejn8WQFcxuh4knGbtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203507;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
	b=NO6CRl5x7YKy6oHI7YOoYyRimrQhw/G5hbOVd7WXEfVBTkwZhyjKgSLvjaMNIqaE/9K+
	 W21m98oM4sT4dat+EA/X5aI/bcN4D4N5xgqQ1TP8c901Zn8vBjsf/tKgTWSt5M5yH+mCd
	 pgVOT+1q3qyjOIAQkiq15fOXMYXbQAH8GpLw8oHlBHLiX+dw8qcPVXMKLqYuBMu9T5LC/
	 Y7WLZX/T7Z6ZfUyHN2cm74oO+wKJzP43oJrkNTc/haFDSvh9mbFanPjB7+4qmA5VQy2mf
	 hjbYt5pHZ04y94NDoU8FwQo8yPMxIdEo4YzPHxjONol46bxZts8cVF1q84k21YCsa5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMfniXFe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A1Hl0Zel;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F360A2602
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 16:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 592F360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMfniXFe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A1Hl0Zel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
	b=EMfniXFeSLZeH2fsBZwE8rLg0gLIEcFXGHlvgQju4yb4IcQsVIPTfah3BUDxTQECChiLAH
	1k8gYrgbA5LAGmm5QvQt8VtvXBitDhBs/srJbPc4751gYxbhZpuoQVx5XdLwx+QH7AWy+p
	RslZ00Xarr1n/x1IWpuxhcv9fmql7dE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-d2lXK_ooPIiUvN3NWGfZDw-1; Wed, 28 Oct 2026 12:05:01 -0400
X-MC-Unique: d2lXK_ooPIiUvN3NWGfZDw-1
X-Mimecast-MFC-AGG-ID: d2lXK_ooPIiUvN3NWGfZDw_1793203501
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17741243eso8473045e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203500; x=1793808300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
        b=A1Hl0ZelyYhVuROqmr5LoBthsluF9Rmocxnno545d7OBshL7xo4tJnbtSXquJ/ywQc
         3b1aSYPO53ZdnnpXsfy7qJ3m8ZRaUW+1l9xjjvYykh4oQ3gwjT28Re0Bn4o0F8NenpmK
         cbJ06oIDXAjTYAjNC1Meye82e4F2mkyeclTwd9O3MEp3D+hb5I7p5PHivRo8BOYMp9+8
         lU9GPi8CyGvCBZkERmnxAxYzBR0Sze+ySUjrDKw8Q6KBUUO9XD0JUHSTfrT6QSRiwc48
         iAWd2to9Uh8SyO/jHV67f62ADQwrxVRBQb/mCVv5W+01VuofIYGuZUuMhevBNzlTg85u
         D7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203500; x=1793808300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NDQKX+0pUZ8dCzJ7P3zYiQzdIpJo7qVKKEaS6oMD8Q=;
        b=t22O4Ks22xL5KN6ROmkH1EFSZXa5LT6ZsovWRuj5j5k/nrUmdSWEkNuOYcENLNg0lr
         gqB8wFVo6JPBHvSQX/8+7pL7f+6+6yHZxQ3qXV4NT8fWnBJXRiOCeFXGNMbpsKVGCCnk
         xrIHInDFZOihM7e/CKQd3LFY+k8Tni/eDZCNht1qNfpqI38DMZGpqKSrUmHg9A6wIEUF
         NXgXCc6xfVR+tYH0tFJExD3fTX16epDxR46GobEfSzgatyzorV624BhZ22ve5+313aXR
         eiIiv3EN7X3ch1iXPqAhlh9RLt3fEeTIBCsLLkifmf3mBUWDti9P1B7Z+lkGxTe/WK2X
         cx5Q==
X-Forwarded-Encrypted: i=1; AKwUvByyl+jR3EibI/bawJEHY5Wt4+YPXmL923EiOPD1On34yBVHE7y8+j2nXGq7b6p+UGKtBfouL5cbjgsPsto=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeuVKu4GeuAO5CFp2bMBr+NYhb9igOZmD95m3btE47n//gMnAT
	hxxqKd9cjd5GcQh0Ktvp6AfBX6hBt5VT8C0ZNKzIOQaf/OKWwQpf1LlOB5vQdGwiVaN9NsIppF+
	xsTfI+1rdCYUrZr+qQspncpi4Vgkx7ulGDpgYJtlZHAAFYIYErwzFpepLZOzimwpSCA==
X-Gm-Gg: AYBFou00yAlbTc4818NwXLsOPx2EYms1Vq1VlKWEQmtSZL6MEUvvl3PfpmBoMQ3iQVI
	5Pn5rbEA9bc1QqdRdMKtjxfDuFm7BNKbpMzWc1BsdAKtnvXzbasodvGPcsEIN7DyVp7qyaJxzDp
	wdNFXJM8Tt+tpc5cIwZsWYHcyxrnwyV4sGQLGtbLuWox4i4sG04eSgYGcb03YVDYA8iQK3wcHus
	mqVdy+zewEzDrY8ByJQH97M1dNCdEeYZmmvNuyV4koY2NxVTDu3wh+UAEiiB1jhs+laYYDxV7o8
	HzN0NDTU7ijHzE9BMyFhWO6HdyO5yf1MwZWP5elmIVLmZqto/s8z59v0gWh762wHBHOOuLMDpKP
	YXRaUfWmBtXXEjJhx94OnyyBMGa8biWazIJtyLdrwyA/JPB9QaHAGEmHQEgPWDUFz4BC70S6m7V
	oPQFpvte9glf4=
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr60856835e9.18.1793203500109;
        Wed, 28 Oct 2026 09:05:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a966a56974mr60856015e9.18.1793203499544;
        Wed, 28 Oct 2026 09:04:59 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:58 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:32 +0100
Subject: [PATCH RFC 3/8] vsock/virtio: implement the datagram data path
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11008; i=slp@sinrega.org;
 h=from:subject:message-id; bh=2s1omMpVu71TczRqOdlyG3N3goKIkmMx8d7/0woGC8E=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0dkB7en5W9wYnuKb478hOyMcWfDRePH2lfG
 WEALSgkofqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHQAKCRD0aSeNLwwC
 Nf7BD/sEJgQqf5tYnZDelctQWr02ptNl4W4PxnOQQ8n4YxE/ClpJGqwceWv4PcqioH2nWGJ8y0a
 3T/pQqT9qnqD+c3/iEF+FlFKz9Kyn7KSZ625DZFWrwGNCwlMXaFFDFhY/Um04TpKHrfYROvcwA8
 XPwBRAIX++sqGD1veaJBI8ts/U1TF8fVfL0xMVxHtExRIApVjSp7Bh57RKdshMyQ4lwywb8D0b+
 FNpUW6iBT6/vxJb9cdUySU8ocLQXlA+sOcRTEl/zXPVSo16Z0s4aRNnCDgjF4auPtem5zc63Ed0
 58Cp+dxXMs5VEtWf7TGbiw9ToblJ/VpLNLnpactpHzhUFrygsVUiuoDRfqsC+zMGpJZwdEKhFyl
 KPmXjNm3gBPCMZ/eAve678By4WC2mbqkPpjJSB5w92f/SlyLsvgYmsGzl7GZtCCY8wT/bMB0RM+
 HbmG8DmRSsgR9RzGlqPA9998xmyCweUOQuTJT9m9zR3yjXu4xukDX4OHFk0deWDTBeu9yycZ9Qb
 3zV1knHrwt0HnITgDZa61dIP5XBDE4jC3mlWxwvGjrBPMne1989NsGDUnMMqaypbImw2t2LLWSO
 bgHUIPdYo9kqCwIrRLi4DY1Tw1XptcMXszMTa6hOPJjDqySXnixUJVGXLqG+n6o9AZVuUHt6nYZ
 Of5qIl5flqNUlLQ==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Add the datagram feature bit and packet type, and implement the common
virtio transport operations needed to bind, send, and receive
datagrams.

Send each message as an OP_RW packet with a maximum 64 KiB payload,
including support for empty messages. Bound pending sends by the
socket send buffer instead of connection-oriented peer credits. Charge
pending payload bytes before handing the skb to the backend and
release that charge exactly once on completion, rejection, or queued
drops.

Deliver incoming datagrams through the bound table without entering
the connection state machine. Validate the transport and connected
peer under the socket lock, including after shutdown, and silently
discard undeliverable messages. Use the socket datagram queue for
recvmsg(), including source addresses, peeking, and truncation
reporting based on the payload length after socket filtering.  Reject
MSG_OOB and MSG_ERRQUEUE before accessing the receive queue.  Reject
datagram sockmap admission until its receive callbacks support it.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/linux/virtio_vsock.h            |   2 +
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/virtio_transport_common.c | 150 +++++++++++++++++++++++++++++---
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 4 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..0bccae661221 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -12,6 +12,8 @@
 struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
+	/* Datagram payload is still charged to bytes_unsent. */
+	bool tx_accounted;
 	u32 offset;
 };
 
diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..27b4b2b8bf13 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;
@@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..ae33630d99e7 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -204,10 +204,18 @@ static u16 virtio_transport_get_type(struct sock *sk)
 {
 	if (sk->sk_type == SOCK_STREAM)
 		return VIRTIO_VSOCK_TYPE_STREAM;
+	else if (sk->sk_type == SOCK_DGRAM)
+		return VIRTIO_VSOCK_TYPE_DGRAM;
 	else
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
 }
 
+static void virtio_transport_dgram_skb_destructor(struct sk_buff *skb)
+{
+	virtio_transport_consume_skb_sent(skb, false);
+	sock_wfree(skb);
+}
+
 /* Returns new sk_buff on success, otherwise returns NULL. */
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 						  size_t payload_len,
@@ -303,6 +311,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct iov_iter_state msg_iter_state;
+	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_sock *vvs;
 	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
@@ -329,12 +338,24 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	vvs = vsk->trans;
 
-	/* virtio_transport_get_credit might return less than pkt_len credit */
-	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
+		if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+			return -EMSGSIZE;
 
-	/* Do not send zero length OP_RW pkt */
-	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
-		return pkt_len;
+		/* Datagram sends are serialized by the socket lock. */
+		if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
+			sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			return -EAGAIN;
+		}
+	} else {
+		/* virtio_transport_get_credit might return less than pkt_len credit */
+		pkt_len = virtio_transport_get_credit(vvs, pkt_len);
+
+		/* Do not send zero length OP_RW pkt */
+		if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
+			return pkt_len;
+	}
 
 	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
 		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
@@ -348,7 +369,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
 						    NULL, false);
 			if (!uarg) {
-				virtio_transport_put_credit(vvs, pkt_len);
+				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+					virtio_transport_put_credit(vvs, pkt_len);
 				return -ENOMEM;
 			}
 
@@ -393,7 +415,15 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		virtio_transport_inc_tx_pkt(vvs, skb);
+		if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
+			spin_lock_bh(&vvs->tx_lock);
+			vvs->bytes_unsent += skb_len;
+			spin_unlock_bh(&vvs->tx_lock);
+			VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = true;
+			skb->destructor = virtio_transport_dgram_skb_destructor;
+		} else {
+			virtio_transport_inc_tx_pkt(vvs, skb);
+		}
 
 		ret = t_ops->send_pkt(skb, info->net);
 		if (ret < 0)
@@ -416,7 +446,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (info->msg && ret < 0)
 		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
 
-	virtio_transport_put_credit(vvs, rest_len);
+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+		virtio_transport_put_credit(vvs, rest_len);
 
 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
 	 * skb_zcopy_set() increases it for each skb, so we can drop that
@@ -620,7 +651,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 {
 	struct sock *s = skb->sk;
 
-	if (s && skb->len) {
+	if (s && skb->len &&
+	    (s->sk_type != SOCK_DGRAM ||
+	     VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted)) {
 		struct vsock_sock *vs = vsock_sk(s);
 		struct virtio_vsock_sock *vvs;
 
@@ -631,6 +664,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 		spin_unlock_bh(&vvs->tx_lock);
 	}
 
+	if (s && s->sk_type == SOCK_DGRAM)
+		VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = false;
+
 	if (consume)
 		consume_skb(skb);
 }
@@ -999,7 +1035,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
 			       size_t len, int flags)
 {
-	return -EOPNOTSUPP;
+	struct sock *sk = sk_vsock(vsk);
+	struct virtio_vsock_hdr *hdr;
+	struct sk_buff *skb;
+	size_t payload_len;
+	int err;
+
+	if (flags & (MSG_OOB | MSG_ERRQUEUE))
+		return -EOPNOTSUPP;
+
+	skb = skb_recv_datagram(sk, flags, &err);
+	if (!skb)
+		return err;
+
+	hdr = virtio_vsock_hdr(skb);
+	payload_len = skb->len;
+
+	if (payload_len > len) {
+		payload_len = len;
+		msg->msg_flags |= MSG_TRUNC;
+	}
+
+	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
+	if (err)
+		goto out;
+
+	if (msg->msg_name) {
+		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
+
+		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
+				le32_to_cpu(hdr->src_port));
+		msg->msg_namelen = sizeof(*vm_addr);
+	}
+
+	if (flags & MSG_TRUNC)
+		err = skb->len;
+	else
+		err = payload_len;
+
+out:
+	skb_free_datagram(sk, skb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
 
@@ -1202,13 +1278,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr)
 {
-	return -EOPNOTSUPP;
+	return vsock_bind_common(vsk, addr);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
 
 bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return false;
+	return true;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
 
@@ -1246,7 +1322,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
 			       size_t dgram_len)
 {
-	return -EOPNOTSUPP;
+	struct virtio_vsock_pkt_info info = {
+		.op = VIRTIO_VSOCK_OP_RW,
+		.msg = msg,
+		.pkt_len = dgram_len,
+		.vsk = vsk,
+		.remote_cid = remote_addr->svm_cid,
+		.remote_port = remote_addr->svm_port,
+		.net = sock_net(sk_vsock(vsk)),
+	};
+
+	return virtio_transport_send_pkt_info(vsk, &info);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
 
@@ -1771,7 +1857,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 static bool virtio_transport_valid_type(u16 type)
 {
 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1805,6 +1892,41 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
+	/* Dgram packets are delivered directly to bound sockets without
+	 * going through the connection state machine. Undeliverable
+	 * datagrams are silently dropped (no RST).
+	 */
+	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
+		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
+			goto free_pkt;
+
+		sk = vsock_find_bound_socket_net(&dst, net);
+
+		if (!sk || sk->sk_type != SOCK_DGRAM) {
+			if (sk)
+				sock_put(sk);
+			goto free_pkt;
+		}
+
+		vsk = vsock_sk(sk);
+		lock_sock(sk);
+		if (sock_flag(sk, SOCK_DEAD) ||
+		    vsk->transport != &t->transport ||
+		    (sk->sk_socket->state != SS_UNCONNECTED &&
+		     !vsock_check_source(vsk, &t->transport, &src))) {
+			release_sock(sk);
+			sock_put(sk);
+			goto free_pkt;
+		}
+
+		if (sock_queue_rcv_skb(sk, skb))
+			kfree_skb(skb);
+
+		release_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..296e1fa7970b 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -161,7 +161,8 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 	if (!vsk->transport)
 		return -ENODEV;
 
-	if (!vsk->transport->read_skb)
+	/* Datagram receive is not implemented by the sockmap callbacks. */
+	if (sk->sk_type == SOCK_DGRAM || !vsk->transport->read_skb)
 		return -EOPNOTSUPP;
 
 	vsock_bpf_check_needs_rebuild(psock->sk_proto);

-- 
2.56.0

