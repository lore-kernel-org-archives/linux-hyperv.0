Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522901;
	b=aN8axsqua6ohjYpv7kLQ22TwFZ/gLDNNJr3520M+OVz6oGs97WzdggrI8ingXgx9J1GD
	 aj4DDyRFr5hMBBR0V810PXzK98kup2Jnunf/h0yo73dnDkJyvyVppy74lGmMsS6p4Kv4Q
	 y5DekgxtSeXzbiLZBFnFd/DeIboO9ebw70mOjkxSDkx08bqUNBVr7P0A8ljVRS1Kg4A4c
	 iTGPuswLyavbl8qFaMPRsjDuCcYd4FaR6h7yhCvW261zcwifchDA63iNPo66Mcp9EhFBZ
	 03XGAjzM7rFGG8YXJms/bAlwPbZXvLWVVJCE1CpmaXmoHbjgjNrFlM11yi8Fy2Veuew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522901;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=fbWcCcyhg5zzYmzJFTeGb1WbApIJff+1uoEu+hku8yvZuneubH23ouSEEPApjf7kYh+v
	 09OsnvlVj0UEzhLf0AOWT2PSjkpQNhH2VCFDHngjVLZd0HBk9EJOh58p1P7HEifDGm4rK
	 xxcUfBnsscQTJAFHfXyloBahPd7YXed0EGKsYYb/DTnouP3XPFIfZCF7v4x+UYCzmnzNO
	 JzzlmRdKhi9Ims6przTDDLnTzb0+OY9bdMp/Vusx1mSU5wEP3W8iz6IRsi+9SI+6wq2P0
	 Ph3FV8zF3jRY/CfKb6ZfNfiHy18UcXLrIQPDexS/eVNrZb3R7xeWOdpD9lHR2XhbNww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsK+Lc1F;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="H8V/jAko";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C58606A6B7
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 12:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C58606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsK+Lc1F;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H8V/jAko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=fsK+Lc1FjdmRiPyUVj20oKj3MKueiiVuX1OYkpfFullvpdxosyM/jPJ8OT4440edXP15zK
	nKLOqMMTrs+gjzw92zQnQZGxp1UlVxkntrVq1F+a6VFm0aYAwNHnSOg/Z0neKo9zmsfjMb
	dRdl4zkjWcOMFMGuHxOCF/R1WANJJW0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-chXjAdHePCmPszyemM0t0g-1; Tue, 24 Nov 2026 12:21:37 +0000
X-MC-Unique: chXjAdHePCmPszyemM0t0g-1
X-Mimecast-MFC-AGG-ID: chXjAdHePCmPszyemM0t0g_1795522896
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02b91f9so2869720f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 04:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522896; x=1796127696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=H8V/jAkoh9Shjj6NPLmvFlrMxocRT1dn2vScjn6RxzmrcX0d+E248Xa6rQm3j5mFNW
         h36cMd1/cbladxc0dBlKRtiK57PGWgRpyfTFQds0KBEUJ101kAF5i2/36W9n9ba5nEu2
         xDsBPs3XYj5hQV5bNIEbgY5SPv3V1CVW5l6tO+nnDAJnAXNssvOfFBXJ36pgFt9HwEiY
         id5fCMaeGb4Fhr1mgVlK6PPGgCYa6u9DI9LTne5UsBUxyB+4us4slsdai5U49TpSyzv9
         7EH7/NNNBjfwGObxSJOttYeVR4CfAMFHo9TTWm0oPdbhWZWzQijNVbAPLMyUI82f2pcH
         3H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522896; x=1796127696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=JQeRs/Y5FVgo71XsxC830v/3uG233CNtavX76t976r/608/FU1tZ9mkIvKZlqJF97N
         JeE5iF1xHG3V1OZ438cTPdMW1gBxgZ1r7dvLlAHqdvDXr7i7BUH890sWoJFpxM336PFj
         q8/Jj1sVe0QIGWo5HBUmAh3tz+FUkyRExNjW08TjaqQbddQ9TOZTSnTZQZkW35KTKn7J
         KLX3XqQqPd5JAXv11FjkdkVoThNC7164MCme3qJOgV0O4LSSxOAltkf/PX5iUrm0LahZ
         PVrkBmYPw8OG90P3oUY4srH6sqNgypZvHhab4dSQxuuQJsT1FDLHZqm9q1NNww07fd0E
         LB2Q==
X-Forwarded-Encrypted: i=1; AL+hErEoE9tV2t5A15gznwmVsCx0uSUwp1awP7yOdbotXy5lb8P7RZYwf6uNsRgS/ePCfxfopcV2uKWkLx/SApw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/G4ww7XLmE8+JZlLlSvR6HZzrD3AZgwtD2sy+Ku6iVDnDYssVN
	zz+wXcMyQAQT+TGurlm9v854Nfhgwq34mMjO/VF725mjGio5f17EcBUeWRxEEAA3Y6Z+u5qa8w5
	4Q1nUZ2HitkXEc7VMwyOPeu7qQ4Kn7tQsWmjC8z4xdwQjyD9QuVfI6GyH3we9r6JBhQ==
X-Gm-Gg: AZFdTZfXTDXmpEWj+1YGWpiAUsWZRzPfjC62wBjXe7j4TAHfXARo9u9clmVd01wNIHi
	qnXXfDLOUC8Sb3O/bQHoiq+Bz2VOp0esVs76BPECByJ4UWMFap2J5xZ10RK+zlrCLgg3ttdxlFA
	TTKAYQBJ66O+labQ40Wn87Vy3t5V3CxCWmWs4/fc3hBYIGbA+5CzKjkANLrWrDQVvYD6MSuERM0
	eVZEZ5Vcg/3eXzGsga32tzq38M39COqh8Qg49r7qZcWhMUBPeO59Da1kVQ0UTYw/hFW95QrvhSf
	m5Fb3oG5erIpBl2PicJ92NeQ9ZaeQw7UaLVBNI141S/OlDaJbZ/H1dE2CljN23VU28Zd42XvZqC
	gswyKpwHpJT4MaVjtGHd6zVU4+q5ReTp3e/HVTF7HSt3A2Wx+2akH5jBIPSvRTJjdXx2JX/3+rt
	jvdOrgh2tZZB0=
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20062044f8f.10.1795522895764;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20061998f8f.10.1795522895343;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:34 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:20 +0100
Subject: [PATCH RFC v4 2/8] vsock: report datagram receive and send queue
 state
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
Message-Id: <20261124-vsock-dgram-support-v4-2-3607484e85e8@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFDM0alN2qcB2uN4zvRdHQFPo6uBvEPQ9IoP
 7IXAHpQ1uGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBQwAKCRD0aSeNLwwC
 NWJyD/44s7CCvnIfT0+tJ3gDVvgHW2kGx/HIvC6vIhUFdUwaB4b7MkZLyBshjtahlGFOlshLTuY
 ow/X1/NpwQcGM4B8xChp9k6ohdYWRBFVtq7B338KPsfiiTo+6PELxlOXjGUmpQr+AmMQACmCiFa
 xXBT0v2dGfywk/SU42+Uy+ErfSkNh0z2BKMwQyfcNbD+bOV2UY97+Hk1EGbmKZj1/2TfU8a5xBX
 iamcB1oTr3FJtt9LIYrgJeuszuq3ZFy3zlFk3VSatzgaSEEpV1d/ULS5jjLgPDDCXagO9F3Y7hS
 G1vXj7H7QZ7mSs4b37bgPMcrsv5jkMCp5adznc+DLkOTrN0oGL3FuyPPJeB5To1I9C907U8YZAO
 j/8+TRIEITbFARS31o5OLIShXeSS0I9Ckzgagv/ykEYWOdR53sy+upqVpP2svj0zP4UXJTmMbzP
 ec/lvuViSv0xOnR/kgyVDT5ngLpYw+eTYFR9M2nfpveZD7NY67T8IteY11MhinqubZzQKYLw+I8
 1H8SiRk2kvi6D6tjEFEplZcdR4041IDA7C5kIWrwB20+8wMTnJwBnkICA6nxrZC8+/sqbsV7fZj
 BxN6w8I1EYQxYkQ7TTBNoJE65G8BPvDgVKNx7cE7MB2HLMieKCo+h+sD4u8CHDVBjbSAzaLgTdI
 f7oadBmJ3O/SWsQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Datagram receive queues hold whole messages, and transports may charge
queued datagrams to the socket send buffer. Report the size of the
next datagram payload for SIOCINQ under the receive-queue lock, so
concurrent recvmsg() cannot free the skb during the query. Let
transports override the length calculation to exclude headers such as
VMCI's.

Report datagram write readiness only while the send buffer has space.
Set the asynchronous no-space flag when it is full so freeing pending
send buffers can wake poll waiters.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h         |  2 ++
 net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
 net/vmw_vsock/vmci_transport.c |  9 +++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ac061115ed30..e4fbea3b0e46 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -124,6 +124,8 @@ struct vsock_transport {
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional payload length override, called with the receive queue locked. */
+	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d5cf240d4ece..8a271eb66860 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* For datagram sockets we can read if there is something in
-		 * the queue and write as long as the socket isn't shutdown for
-		 * sending.
+		 * the queue and write if the send buffer has space and the
+		 * socket isn't shutdown for sending.
 		 */
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			if (sock_writeable(sk))
+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+			else
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		}
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 			break;
 		}
 
-		n_bytes = vsock_stream_has_data(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+		if (sk->sk_type == SOCK_DGRAM) {
+			struct sk_buff *skb;
+
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb && vsk->transport->dgram_payload_len)
+				n_bytes = vsk->transport->dgram_payload_len(skb);
+			else
+				n_bytes = skb ? skb->len : 0;
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+		} else {
+			n_bytes = vsock_stream_has_data(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 		ret = put_user(n_bytes, arg);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..2b9493e987d1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct vmci_datagram))
+		return 0;
+
+	return skb->len - sizeof(struct vmci_datagram);
+}
+
 static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 					struct msghdr *msg, size_t len,
 					int flags)
@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
 	.dgram_dequeue = vmci_transport_dgram_dequeue,
+	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,

-- 
2.56.0

