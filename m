Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522905;
	b=1YqtxQZ7YJcLS57fz0730JQiHBU7Xf3O71M90Eldy4cZ9CwjFOatIszrK/zLV+E8vI1P
	 NCSt37p4avR74pISxsMao05vTeHEufxUn+ISOfC0Qbw9ofwib9+mJ+h3NxfnS8Ph4E3UM
	 FgCagzUS/eTKuPcUnSmCrQRbde07zBglxyl38e65IXiThVwIegTWJR9s7dCghzeB4CMXs
	 2Tf9avJHSOOgn8vclV4JlsVW0p0rTJP7F8yF19r+NLUfH3KiIhQ+SavVtECzS+KjrhOBM
	 iHtjiMdkijGD3j9IK5XcMV7U4UmMqqBl26nLxb5ibOJ+COJHb1ko6+V9sL0ab2Wj26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=BU6qpkE8xoPg4XrOMeNZd0BlwReqbgleWebnxZRkKnRWQ8twlU/nubTG4CfiWsax0hYd
	 2rbmVtA8Q1xft265UYPNq/hQ6arSWxkIXcW2bLn6zQ9WK0S/NKX5z0btIWFnymIqQhbt9
	 1+MKKTOAU324hl1aAjTHvPtICWHxNxwDKHyIgoWa05s8+kOVyhurxX3TFpyhcLq073wf5
	 o1pABPKPbPwUVopYTiX8SOjctpIY2l+CUl6eQccUUWrcS77k96dF16tnDZrvdk+79qriM
	 y4gHBvWy3sILtG3MdnPreDrgFsYUqhKe4jgY6Ny/eRxEA5LsmJl4aUX8KH92PqocBKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cMy3OPpf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2260A380B
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 12:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B2260A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cMy3OPpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=bgyGTggWD+oAFT8m6ORPS4OCJ653ll2PuLk/Ab3CD+7Y5F25DmWsRwApIop56P2hm7xyFQ
	CsQmAKPX0bc0jPeoE02H1O4BqawH7ltRdtttY/qGfqYuGmwU59T+1uN11B0+5ltDpnIUAc
	P+iiBBcaW4YcirqlGe6L55UlJIdhvQU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-R-LINAxlN9SnC-BeOQpvIQ-1; Tue, 24 Nov 2026 12:21:42 +0000
X-MC-Unique: R-LINAxlN9SnC-BeOQpvIQ-1
X-Mimecast-MFC-AGG-ID: R-LINAxlN9SnC-BeOQpvIQ_1795522901
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso31654225e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 04:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522901; x=1796127701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
        b=cMy3OPpfxxjHZdDd3wlrrvL96O06eMwf0KtSx2SQ6GOc6h0hz+Rj8HuGiYz5c7aNWE
         CnucRHhia16tqHU6OU83k4SlEH/ZNGnjZ4rXQ1Bk1ejCMji0Jk8g1XEgvFE3xsUQEKoo
         E/MX8IftNers9NLnn5HVLvHWGBfFlf/WFmI+z+3q3RXwimNv9V0DGcdh3ANKaL6KK+9I
         WfQ/9e+LepzuoKnzCwOnFUdWUqfPhCki/LXL7gTB7PahNMdo43FV2NqRE9OR22eNHDs6
         12CNyJUVufnML+O5fZRrdC2O1CUfs5YL0xYlDxVf0qCdyO2w6eF/x36vMoINjkrkSEkN
         qqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522901; x=1796127701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
        b=z67vxnURc6PBxi+29HxR8fYGskQL7YyX1JiAbljky2RwO1jq7rWnSV0w1KUlcGHjDH
         ncnsJDmldKj2Ts9HrfA7VF1e5aAg3+gDlepFN3kaJzd0coL8QVQpC/l+on83gmhRCSdA
         LMOlXehogj6nYs33PXea2K/TwpvfqMk2W88gmNDXs+VU37aeWN7vN0ZJPMxFh1gbtBc1
         LMu64RjGSZmHNQMMuXMZOXPsXzhzeS+KgliqTOa7KyMlRAMJEFY+mbvopqzOTLvQRaZU
         pQ4ZBKQ91xmJoZ+SZEMgFYD2j6SewYLF/dEtzx9H5GZuNeI3G5JvniDVWR7fpjrIOQuf
         hVHA==
X-Forwarded-Encrypted: i=1; AL+hErFT/VDTj52v4ZdHsp42eWBREGRb7b56ydwC4JHyWejFk3gyjop2meWkM750jP8q2Yg7t1yHWQ7qwzgUTGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BQqCPiNbi9HR/jUA2Gsx5KcloC0Ufe/fydea/+cP+IARzD3f8
	7PcbziXSz0B25Lw5gFKd1+5RQ4bdFzjt1fFksLjPvBLQiZGYZiYZoNvTNed/Rz3qnMP7RkZ7urx
	9WrMGFedHR5RG7rJa2UdzjmySNKbLryP87v6dsRx6qH/P1DDBf0v15Vycj01WX/Gesg==
X-Gm-Gg: AZFdTZeMlNQgz2mEgnevbXWf+Bmrx0fx5BSKhmA8QfVpVB59mbiRGsZV8Z41dH+duJa
	7ilR+k3U6/SDL6UxoRlQmm5BGGruUD9Fo8vkcMsC+Zz+8gFg6CU4N5ZZbyw02nmLJbSYbv6XkdY
	fzPVuht3y1Tj/5VwKKAiwM+rCIrzGsTRWQyJGh7C+vqTTP8WziXL/DOtgrFy0nLOnsxl6VQhE1q
	mIBBXDXh3Wp8ymGq3QwEFM4UbHJyl8r5FhnbFEzf13mYWVwLonDS9rfv4OQI2+AgVFBsuxGscvR
	wW8wgf4H+/3dsjs+H7EfwgIUjiENQWvis2MrmjZ2K63bIRrFNxE0ab79pZcK1U4F4f18YsrT3SE
	bCUKb4x0R6JxRrXiX+I7JHR/D5kAOpVSoE6EPV1XEiRPZZfjjTHvdrqU3UvagvZ419fQBxvz903
	hDAaeL/2xIwEI=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003855e9.12.1795522900842;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003365e9.12.1795522900467;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:23 +0100
Subject: [PATCH RFC v4 5/8] vhost/vsock: negotiate datagram support with
 guests
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
Message-Id: <20261124-vsock-dgram-support-v4-5-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
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
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6390; i=slp@redhat.com;
 h=from:subject:message-id; bh=aPPGnkG3NRN8zsschNikrnYTRtwAoxBD04k3+bLVY5A=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFGF4yM5q7avlFZKV6kU2d6VP1EECVsasY5S
 PmvpH1ob/qJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRgAKCRD0aSeNLwwC
 NaLAEACrirJaOKWRU1EbZZ++DhiyHSznTCGcjrDOYWdLr60c9d5CUj4knGY7ONXawzgLD81/b6g
 0mKjlBlqBi55ipnSitwpkkEr1kGoxSnhnP8LdHEwOuAtxobUuqW88uUw0cqJzMpjqRwElfUAsEJ
 2KK4ko6Twsi2CoZ034N6h8S2Qct3i03TCjjpHy8exxDqMfMeQ9Q34Ua24S4aB/Yv3Gw+s1JFODW
 wvGVzPjSD3a9BltbymuORshWmmOWPMh82hQd+kwX0zw523OqsYePRvMv8jK+AVyTtqQzgk4e7DG
 CrNR8MZkxOTqtPfCWBeBYuT16g5DJvzKfpHvTn8rHPE2knPO7ICM+5KfW/zkxm5suF4zaTUoffa
 zs1qgbzFEoUZWBlcE5I+uo2v6gAXY081CkXnJTpsZ8PpJBCgfZ2FsiZQlGxGzepeO4e/NuKjfd7
 FcmdWiAjncq53kJe3Uq4r96SkkCMZkgr9PTxcraOSKQUx3w1IeLDTkYmlUJz7bRjeql4igG7jw6
 P0dViu2yKIMl5C0iCqk8rUingLToJMhY1AqpMzxkUVIznCpzAchEDglOtbLvMbWawzueQABWsxl
 MpPpvDP8dTPJ79vuyalKT2TNZczcwfgSOiZkp0CNfF7v0vuVLwN++vPypclEShPi9E9ogqJpU7T
 kXR84yhdnX71JCA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Reject guest datagrams on ingress unless the receiving virtqueue
acknowledged the feature. Complete rejected descriptors normally so the
queue can continue processing subsequent traffic.

Validate the guest TX header before allocating the skb, and size the
skb from its declared payload length rather than the descriptor chain.
A guest can post a descriptor much larger than the packet it sends.
The old allocation could then create a nonlinear skb whose data_len
exceeds len; a socket filter trimming a datagram could make recvmsg()
read beyond the skb data.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 66 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..767f28794c6b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -360,7 +362,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -378,34 +380,30 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	skb = virtio_vsock_alloc_skb(sizeof(hdr) + payload_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	*virtio_vsock_hdr(skb) = hdr;
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
@@ -436,6 +434,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +516,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -573,10 +591,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 		hdr = virtio_vsock_hdr(skb);
 
-		/* Only accept correctly addressed packets */
+		/* Check addressing and datagram feature negotiation. */
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
-		    vhost_transport_get_local_cid())
+		    vhost_transport_get_local_cid() &&
+		    (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_DGRAM ||
+		     vhost_has_feature(vq, VIRTIO_VSOCK_F_DGRAM)))
 			virtio_transport_recv_pkt(&vhost_transport, skb,
 						  vsock->net);
 		else
@@ -737,6 +757,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +911,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

