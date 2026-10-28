Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203511;
	b=sAqVc+r6ytrMKIZegE1MScYebcSRqdCx0DwDmAjsBXDoRPMLml6NMsFSFyUxbJLHB/xW
	 CwiOdaN8W3OE7SyhpswUPgLZNdlq7T3CxgWZk90l0YVcIatpHzfDtqiNlBgN96FlOUR5e
	 F6U73Xf47CmfBTJn5lz6RNiXsTSGdI8QCGV96DwKs9Jf5z9rAoSknXhQuLFsTrYiQW+AR
	 P7bL0jyu281hvcg6aRo/bj7G3EV9tEelni6AWtiNn05kUatEmSK1RqQ7cXL8R1dK9jxJs
	 qzI3c8CGw1ughaqaRnQ+AlR9HbE+/2WoEV65eU4GOERXuLkRLx/2LJX41RtqjXuwwTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203511;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=a/kQnz5VVx7jUtQ37eAhb9Z0TqofKxUx9L3H4+3kw94=;
	b=umhXIbfTobjo4x0hOeIat09uq0mDQ34YMeCaHS4ggM3cWRaUMp+wlHEVX5Y4nL9LnctC
	 moYf+9NdXVh3wR5aRO7VWig0O8Lc8bVj2gFL1HJ6N7i7j5UtZ954ON4tGTDxz1CLOv/9t
	 gKLo7F9R3rZzuF23hEvqy5MubRpBMyWNnD3kESNczqb3JPG/Dvc37VLtku0bVMXa26sN4
	 p4BrHmaWFWBvfw5I0DgPCoV/yOHEo/gyp0PeEkadpL4aMuwEi4OIH5hz/C2Pc+mAlcUsZ
	 BPIdYuw7tba0EDUs9kdpZLZaL0JCVE1NWEuz1LM/e3qAanMbJC8bamoekPgzr0mqWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=efNEWFY7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O8cqZOUy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABD60A2607
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FABD60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=efNEWFY7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O8cqZOUy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/kQnz5VVx7jUtQ37eAhb9Z0TqofKxUx9L3H4+3kw94=;
	b=efNEWFY7aImTZT04DIhxOV7SYRISuX/hewbTvMYWom4wDSNnsRdunHFI+panDjYX+AZi1I
	4NL0Ya1nURDqeywHONVsUmRHseRus843928vjqap/UoaYuzenLIGoJjS7Bunj8bxKtngPc
	j+bYhjz5VGtYeam9NcleF6dLxjUfXhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-cDdCi6DVO96gdDDpG555Jw-1; Wed, 28 Oct 2026 12:05:08 -0400
X-MC-Unique: cDdCi6DVO96gdDDpG555Jw-1
X-Mimecast-MFC-AGG-ID: cDdCi6DVO96gdDDpG555Jw_1793203507
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1341956f8f.0
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203507; x=1793808307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/kQnz5VVx7jUtQ37eAhb9Z0TqofKxUx9L3H4+3kw94=;
        b=O8cqZOUyPcf7arPwtbpLNiBcwQWMxU/SeGGemxTWWnWX6RcXnwwGWAmvTTMMU8sgeq
         Gf65qzcGzT3bAVbVjseGwRWiRIMjQbaigcnXUEi2D5pmjlD0HcBY0geUw7UNth8OzwYe
         /uPBZpHpPazlJ5j0JMFr3wOtdUfHIWXg4zXixG0vBCV5iT5o5dXKyCYhm3+txQg8LYYt
         FuUh+2drjm0igM3V9Ni6clRhFlfaZt7BpRdf8XlVrzSt/VPpjYyFjQ9x/usmN0x8sa1u
         L3/OOqJ5zCCOPpbEILfpt7msxbYSlljl19PaFZtct13Xy/FNfzX5L4MhnW98EiUM25Sx
         I/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203507; x=1793808307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/kQnz5VVx7jUtQ37eAhb9Z0TqofKxUx9L3H4+3kw94=;
        b=vyk9s00lSvKjZM/QVg31AugRn2mKEMx1opU4leaTcRU81doZEHN+hyXS0tqP+dAky2
         8MiPcrRUSMQmoT2Aq8VU+AzFg7huEZ3jhAczryeZ8R2mWFr+UzaBByZLFiZpGZfgtsyD
         Ay2iAWGxqw9lchPwWbs6+Gu/i0i6vLrpomrEiZfcZ2BqVYK3UIYFHsc40sfQKU1893VA
         Rd9xDT8REeT0eLh5d38KJmjg5bFgjLRnF2EzzICvI+/HnB3vgmYshnuUP504bu9DhYeZ
         UAofEvANpvp4hMKtEWLpKsaa4VUW5NFDjeP93sdN79CrpmX+bSo8qWrdPOPBuWApJWLo
         96TA==
X-Forwarded-Encrypted: i=1; AKwUvBy0kQD1Stf4nK9VkIRVPqOXPfRc4LQ+j63an6vQXkvqs4IMuAFvehKKxRFB3yC2c+sXV6CxVxBkPvSmZIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDgs2ggZd8Kv9J5W1SwEqsa9KyKFMb2FgMNN2+NIMw2VUwz/1s
	nt0XOvL/9nk5FTHT5xlmD3fmeQLIS7h8VNW28aHTHP1LQksqHbRzFcYD0gtOIRPz3gWrvYp2q9x
	SM5FId42hAiKc6/wHAMgAnZlSIIx2pSKWHMNT9lsm0iMYg0D7DG7iwqQcst4hHwlicg==
X-Gm-Gg: AYBFou3VrTbpCMvZpfev4zaS3tdWrotdEMwSOIIgymRkdmeO8WP1r1oBdUT3nkguS4m
	My0PAjKtUpq+g6hDITRbTQU9M5/6zbyJWNIXRSzCi+MtQ5uQC0vo+3rtl8vZUmerc8uqheC9c9y
	i9ytE2uZrcXADa1TTNv31mSZlQZKUvOQ9QpYDUlhcuXE+On/Nmz04DrCxjwur9UApDu0gLhowvU
	bNjkh5Kd8tzM4qE2vpKv1W6XL3di8VtGPpKxsbC/Szu/mqTML9yrdHzL3923Kaea++hiYeheaQA
	j8rLhsB7/uH4Px9+lMGFvOTG4Bsk2NyevQlV1J+3K//8jYYM0wQy1/CwzHUze9YfxJh1QOF/O/H
	oqtAL2y8h7K6029ycKIccj4CxhumZlDee3JkDZbiZZFGnE9yRKFWMqzvZmCShvPA/gE7lyCsHI3
	2vBTGTlObr6rI=
X-Received: by 2002:a05:6000:15c9:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48e646f4a52mr73279f8f.0.1793203506431;
        Wed, 28 Oct 2026 09:05:06 -0700 (PDT)
X-Received: by 2002:a05:6000:15c9:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48e646f4a52mr73194f8f.0.1793203505727;
        Wed, 28 Oct 2026 09:05:05 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:04 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:35 +0100
Subject: [PATCH RFC 6/8] vsock: allow datagrams to use directional
 transports
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
Message-Id: <20261028-vsock-dgram-support-v1-6-e457cf7cee78@sinrega.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19757; i=slp@sinrega.org;
 h=from:subject:message-id; bh=G9D7rfB+9wgPWTv/Fd9N31spiM1v/YEktO0G/fPf8vY=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0f71YiLMQ5l6M4m1NkCSfIb/eE2a9eHjMWA
 WHU5ROEGpuJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHwAKCRD0aSeNLwwC
 NcqtD/9j5FMaXQ/s0pfPV9jHtYr1uULAyzqUC+ezV6heIPDyNVjGKe4glzW+y0OVsB/QX/sPx6v
 oqP4BkiU7KiNsTo7f6IiVC6v6c8ptk8BfIZ9F4QXvrKqIuU24Em+JoUKEr8EoslKNq3edE47jsh
 CB4u43SMuhOtoGtP/1u1vD7Ndf/S0sF17cRCKzKC0BSYDPEQ0cOQ6pG402jbJChm4Gsuu+i4c9K
 75xnI7EIh0PQy747jBPXK2ilfMCrN+Qu3E0wflw5jKBTJpR+hQSKs1BxgDihbtzUYcjx+njiES5
 mBaWH4dafi19DhMAkcNMJaYQ6b6e7qS6q/OmFsUJ9hOVvcE/LNQQtMmTqbNHq12q2gpS6W/Lo3R
 oBPBqGQXMZ3xe4YSnO3s27WmaygoE89Dfp1labNXWqyIEe7d3Qias0fzlThbuARus4u70pUF3UO
 WMzzG0Kkuc8V2P/3duEb3/my1BdU3Yyh+m9TAZ3twdb6Rr2d5OP+J132e6ygadSehG8m8Z0Ds01
 7dWWIpKCVW84g43ZYqOYoSPImR9q2DfyK8ZHqmxpRUrtG7wpsMHas0ddWvMbvctXnUrue5DOAzU
 3OH7sM4Qv4jzuDdU1enCks84AqubbwkkZ48/2SpyVuqJCM6Yh/amnx2uCjoRuVzELmuZir29zc0
 QJDIENuONUdUQ+g==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Use a dedicated datagram transport when present; otherwise initialize
socket state through a directional transport, falling back to vhost
when the guest transport lacks datagram support. Keep VMCI's existing
priority and reject datagrams during Hyper-V socket initialization.

Select a compatible transport for each datagram destination using the
stream routing policy. Keep the socket's transport state intact for
queued sends, pin the selected backend during dispatch, and check
connected sources against the peer's route. Preserve parent routing in
returned addresses and when connecting through the guest-to-host
fallback.  Preserve explicit source CIDs on loopback datagrams so
replies reach the bound socket. Reject loopback source bindings whose
reply addresses select another transport.

Remove sockets from the core tables even when transport initialization
fails.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c                   |   1 +
 include/linux/virtio_vsock.h            |   4 +
 include/net/af_vsock.h                  |  11 ++-
 net/vmw_vsock/af_vsock.c                | 143 +++++++++++++++++++++++++++++---
 net/vmw_vsock/hyperv_transport.c        |   4 +
 net/vmw_vsock/virtio_transport.c        |   1 +
 net/vmw_vsock/virtio_transport_common.c |  53 ++++++++++--
 net/vmw_vsock/vmci_transport.c          |   1 +
 net/vmw_vsock/vsock_loopback.c          |   1 +
 9 files changed, 201 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index eb2fbdb721aa..79ffdb28f4d9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -465,6 +465,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_allow              = vhost_transport_dgram_allow,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0bccae661221..91945031fcc5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -14,6 +14,7 @@ struct virtio_vsock_skb_cb {
 	bool tap_delivered;
 	/* Datagram payload is still charged to bytes_unsent. */
 	bool tx_accounted;
+	bool to_host;
 	u32 offset;
 };
 
@@ -173,6 +174,7 @@ struct virtio_vsock_sock {
 
 struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
+	const struct virtio_transport *t_ops;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
 	struct net *net;
@@ -263,6 +265,7 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port);
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr);
 bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port);
+bool virtio_transport_dgram_transport_match(const struct vsock_transport *t);
 
 int virtio_transport_connect(struct vsock_sock *vsk);
 
@@ -276,6 +279,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 				size_t len);
 int
 virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
+			       const struct vsock_transport *transport,
 			       struct sockaddr_vm *remote_addr,
 			       struct msghdr *msg,
 			       size_t len);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 0c8b8a815b04..f9bcd703a776 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -121,9 +121,13 @@ struct vsock_transport {
 	int (*dgram_bind)(struct vsock_sock *, struct sockaddr_vm *);
 	int (*dgram_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
 			     size_t len, int flags);
-	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
-			     struct msghdr *, size_t len);
+	int (*dgram_enqueue)(struct vsock_sock *vsk,
+			     const struct vsock_transport *transport,
+			     struct sockaddr_vm *remote_addr,
+			     struct msghdr *msg, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional: another transport can use this socket's datagram state. */
+	bool (*dgram_transport_match)(const struct vsock_transport *transport);
 	/* Optional payload length override, called with the receive queue locked. */
 	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
@@ -240,6 +244,9 @@ void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
+const struct vsock_transport *
+vsock_dgram_get_transport(struct vsock_sock *vsk,
+			  struct sockaddr_vm *remote_addr);
 bool vsock_find_cid(unsigned int cid);
 void vsock_linger(struct sock *sk);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index dc1add2d2e89..6419498a6fe2 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -136,6 +136,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/cred.h>
+#include <linux/err.h>
 #include <linux/errqueue.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -599,6 +600,7 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 {
 	const struct vsock_transport *new_transport;
+	const struct vsock_transport *fallback_transport = NULL;
 	struct sock *sk = sk_vsock(vsk);
 	unsigned int remote_cid = vsk->remote_addr.svm_cid;
 	__u8 remote_flags;
@@ -622,7 +624,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
-		new_transport = transport_dgram;
+		if (transport_dgram)
+			new_transport = transport_dgram;
+		else if (transport_g2h)
+			new_transport = transport_g2h;
+		else
+			new_transport = transport_h2g;
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
@@ -661,6 +668,11 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		ret = -ENODEV;
 		goto err;
 	}
+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram &&
+	    new_transport == transport_g2h && transport_h2g &&
+	    transport_h2g != new_transport &&
+	    try_module_get(transport_h2g->module))
+		fallback_transport = transport_h2g;
 
 	/* It's safe to release the mutex after a successful try_module_get().
 	 * Whichever transport `new_transport` points at, it won't go away until
@@ -697,6 +709,14 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	}
 
 	ret = new_transport->init(vsk, psk);
+	if (ret == -ESOCKTNOSUPPORT && fallback_transport) {
+		module_put(new_transport->module);
+		new_transport = fallback_transport;
+		fallback_transport = NULL;
+		ret = new_transport->init(vsk, psk);
+	}
+	if (fallback_transport)
+		module_put(fallback_transport->module);
 	if (ret) {
 		module_put(new_transport->module);
 		return ret;
@@ -711,6 +731,98 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/**
+ * vsock_dgram_get_transport - select a transport for a datagram destination
+ * @vsk: socket whose datagram state will be used
+ * @remote_addr: destination address
+ *
+ * The caller must hold the socket lock and release the returned transport's
+ * module reference after use. Dedicated datagram transports retain their
+ * original selection; compatible transports share the socket's existing state.
+ * Parent fallback sets VMADDR_FLAG_TO_HOST to preserve that route on connect.
+ *
+ * Return: a referenced transport or an ERR_PTR on failure.
+ */
+const struct vsock_transport *
+vsock_dgram_get_transport(struct vsock_sock *vsk,
+			  struct sockaddr_vm *remote_addr)
+{
+	const struct vsock_transport *owner = vsk->transport;
+	const struct vsock_transport *transport;
+	struct sock *sk = sk_vsock(vsk);
+	u32 cid = remote_addr->svm_cid;
+	u32 local_cid;
+	bool to_host = false;
+	int err = -ENODEV;
+
+	if (!owner)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&vsock_register_mutex);
+	if (!owner->dgram_transport_match) {
+		transport = owner;
+	} else if (vsock_use_local_transport(cid)) {
+		transport = transport_local;
+	} else if (cid <= VMADDR_CID_HOST ||
+		   (remote_addr->svm_flags & VMADDR_FLAG_TO_HOST)) {
+		transport = transport_g2h;
+	} else if (transport_h2g &&
+		   (!transport_h2g->has_remote_cid ||
+		    transport_h2g->has_remote_cid(vsk, cid))) {
+		transport = transport_h2g;
+	} else if (sock_net(sk)->vsock.g2h_fallback && transport_g2h &&
+		   transport_g2h->has_remote_cid &&
+		   transport_g2h->has_remote_cid(vsk, cid)) {
+		transport = transport_g2h;
+		to_host = true;
+	} else {
+		transport = transport_h2g;
+	}
+
+	if (!transport)
+		goto out;
+	if (owner->dgram_transport_match &&
+	    !owner->dgram_transport_match(transport)) {
+		err = -ESOCKTNOSUPPORT;
+		goto out;
+	}
+	/* Loopback source addresses must route replies back to loopback. */
+	if (owner->dgram_transport_match && transport == transport_local &&
+	    vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+	    !vsock_use_local_transport(vsk->local_addr.svm_cid)) {
+		err = -EADDRNOTAVAIL;
+		goto out;
+	}
+	if (!try_module_get(transport->module))
+		goto out;
+	mutex_unlock(&vsock_register_mutex);
+
+	if (owner->dgram_transport_match) {
+		local_cid = transport->get_local_cid();
+		if (vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+		    local_cid != VMADDR_CID_LOCAL &&
+		    vsk->local_addr.svm_cid != local_cid) {
+			err = -EADDRNOTAVAIL;
+			goto put_transport;
+		}
+	}
+	if (!transport->dgram_allow(vsk, cid, remote_addr->svm_port)) {
+		err = -EINVAL;
+		goto put_transport;
+	}
+	if (to_host)
+		remote_addr->svm_flags |= VMADDR_FLAG_TO_HOST;
+	return transport;
+
+put_transport:
+	module_put(transport->module);
+	return ERR_PTR(err);
+out:
+	mutex_unlock(&vsock_register_mutex);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(vsock_dgram_get_transport);
+
 /*
  * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
  * Otherwise we may race with module removal. Do not use on `vsk->transport`.
@@ -1040,7 +1152,7 @@ static void __vsock_release(struct sock *sk, int level)
 
 	if (vsk->transport)
 		vsk->transport->release(vsk);
-	else if (sock_type_connectible(sk->sk_type))
+	else
 		vsock_remove_sock(vsk);
 
 	sock_orphan(sk);
@@ -1483,7 +1595,8 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		 */
 
 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
+			remote_addr->svm_cid = transport->dgram_transport_match ?
+				VMADDR_CID_LOCAL : transport->get_local_cid();
 
 		if (!vsock_addr_bound(remote_addr)) {
 			err = -EINVAL;
@@ -1493,7 +1606,8 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		remote_addr = &vsk->remote_addr;
 
 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
+			remote_addr->svm_cid = transport->dgram_transport_match ?
+				VMADDR_CID_LOCAL : transport->get_local_cid();
 
 		/* XXX Should connect() or this function ensure remote_addr is
 		 * bound?
@@ -1507,13 +1621,14 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 	}
 
-	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
-				    remote_addr->svm_port)) {
-		err = -EINVAL;
+	transport = vsock_dgram_get_transport(vsk, remote_addr);
+	if (IS_ERR(transport)) {
+		err = PTR_ERR(transport);
 		goto out;
 	}
 
-	err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
+	err = transport->dgram_enqueue(vsk, transport, remote_addr, msg, len);
+	module_put(transport->module);
 
 out:
 	release_sock(sk);
@@ -1527,6 +1642,7 @@ static int vsock_dgram_connect(struct socket *sock,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	struct sockaddr_vm *remote_addr;
+	const struct vsock_transport *transport;
 
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
@@ -1548,11 +1664,16 @@ static int vsock_dgram_connect(struct socket *sock,
 	if (err)
 		goto out;
 
-	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
-					 remote_addr->svm_port)) {
-		err = -EINVAL;
+	if (remote_addr->svm_cid == VMADDR_CID_ANY &&
+	    vsk->transport->dgram_transport_match)
+		remote_addr->svm_cid = VMADDR_CID_LOCAL;
+
+	transport = vsock_dgram_get_transport(vsk, remote_addr);
+	if (IS_ERR(transport)) {
+		err = PTR_ERR(transport);
 		goto out;
 	}
+	module_put(transport->module);
 
 	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
 	sock->state = SS_CONNECTED;
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 855b15971c35..6a276ef6964b 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -443,6 +443,9 @@ static int hvs_sock_init(struct vsock_sock *vsk, struct vsock_sock *psk)
 	struct hvsock *hvs;
 	struct sock *sk = sk_vsock(vsk);
 
+	if (sk->sk_type == SOCK_DGRAM)
+		return -ESOCKTNOSUPPORT;
+
 	hvs = kzalloc_obj(*hvs);
 	if (!hvs)
 		return -ENOMEM;
@@ -563,6 +566,7 @@ static int hvs_dgram_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
 }
 
 static int hvs_dgram_enqueue(struct vsock_sock *vsk,
+			     const struct vsock_transport *transport,
 			     struct sockaddr_vm *remote, struct msghdr *msg,
 			     size_t dgram_len)
 {
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 762e77895f28..14ce0836bc39 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -585,6 +585,7 @@ static struct virtio_transport virtio_transport = {
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow_check,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ae33630d99e7..7c1ec8feb853 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -322,13 +322,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	info->type = virtio_transport_get_type(sk_vsock(vsk));
 
-	t_ops = virtio_transport_get_ops(vsk);
+	t_ops = info->t_ops ?: virtio_transport_get_ops(vsk);
 	if (unlikely(!t_ops))
 		return -EFAULT;
 
 	src_cid = t_ops->transport.get_local_cid();
+	/* Preserve explicit datagram bindings so loopback replies can find them. */
+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM &&
+	    src_cid == VMADDR_CID_LOCAL &&
+	    vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		src_cid = vsk->local_addr.svm_cid;
 	src_port = vsk->local_addr.svm_port;
-	if (!info->remote_cid) {
+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM && !info->remote_cid) {
 		dst_cid	= vsk->remote_addr.svm_cid;
 		dst_port = vsk->remote_addr.svm_port;
 	} else {
@@ -1066,6 +1071,8 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
 		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
 				le32_to_cpu(hdr->src_port));
 		msg->msg_namelen = sizeof(*vm_addr);
+		if (VIRTIO_VSOCK_SKB_CB(skb)->to_host)
+			vm_addr->svm_flags = VMADDR_FLAG_TO_HOST;
 	}
 
 	if (flags & MSG_TRUNC)
@@ -1288,6 +1295,13 @@ bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
 
+bool virtio_transport_dgram_transport_match(const struct vsock_transport *t)
+{
+	return t && t->dgram_transport_match ==
+		virtio_transport_dgram_transport_match;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_dgram_transport_match);
+
 int virtio_transport_connect(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_pkt_info info = {
@@ -1318,12 +1332,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
 
 int
 virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
+			       const struct vsock_transport *transport,
 			       struct sockaddr_vm *remote_addr,
 			       struct msghdr *msg,
 			       size_t dgram_len)
 {
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RW,
+		.t_ops = container_of(transport, struct virtio_transport, transport),
 		.msg = msg,
 		.pkt_len = dgram_len,
 		.vsk = vsk,
@@ -1861,6 +1877,33 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
+static bool
+virtio_transport_dgram_source_allow(struct vsock_sock *vsk,
+				    const struct vsock_transport *transport,
+				    const struct sockaddr_vm *src)
+{
+	const struct vsock_transport *peer_transport;
+	struct sockaddr_vm peer = vsk->remote_addr;
+	bool allow;
+
+	if (!virtio_transport_dgram_transport_match(vsk->transport) ||
+	    !virtio_transport_dgram_transport_match(transport))
+		return false;
+	/* Shutdown preserves the peer; only disconnect removes it. */
+	if (sk_vsock(vsk)->sk_socket->state == SS_UNCONNECTED)
+		return true;
+
+	peer_transport = vsock_dgram_get_transport(vsk, &peer);
+	if (IS_ERR(peer_transport))
+		return false;
+	allow = peer_transport == transport &&
+		src->svm_port == vsk->remote_addr.svm_port &&
+		(src->svm_cid == vsk->remote_addr.svm_cid ||
+		 transport->get_local_cid() == VMADDR_CID_LOCAL);
+	module_put(peer_transport->module);
+	return allow;
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1911,14 +1954,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		vsk = vsock_sk(sk);
 		lock_sock(sk);
 		if (sock_flag(sk, SOCK_DEAD) ||
-		    vsk->transport != &t->transport ||
-		    (sk->sk_socket->state != SS_UNCONNECTED &&
-		     !vsock_check_source(vsk, &t->transport, &src))) {
+		    !virtio_transport_dgram_source_allow(vsk, &t->transport, &src)) {
 			release_sock(sk);
 			sock_put(sk);
 			goto free_pkt;
 		}
 
+		VIRTIO_VSOCK_SKB_CB(skb)->to_host =
+			t->transport.get_local_cid() > VMADDR_CID_HOST;
 		if (sock_queue_rcv_skb(sk, skb))
 			kfree_skb(skb);
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 2b9493e987d1..410deb2493c6 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1723,6 +1723,7 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
 
 static int vmci_transport_dgram_enqueue(
 	struct vsock_sock *vsk,
+	const struct vsock_transport *transport,
 	struct sockaddr_vm *remote_addr,
 	struct msghdr *msg,
 	size_t len)
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e851..d7bff1da2b74 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -77,6 +77,7 @@ static struct virtio_transport loopback_transport = {
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,

-- 
2.56.0

