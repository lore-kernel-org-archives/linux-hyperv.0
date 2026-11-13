Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574196;
	b=4R8vNXzfoM/CEggkQIkFgJPvGFJRoPZERxE7Pxot+vdxlf4P5EYouUnnYok88Y/3ADd6
	 Oj16dei6yzUwaqnJUGnSXxp66ajkpNwjpmaczjkhxMoa5RU2SKhg/laZVu2rlgQFcAyKM
	 tfyRXApRw46/9hT15k7mRdWIiJfOzeLkO9yEo/vkKTzK+ZxQIvtXxyhOJmxIfQA5cIowF
	 PDDAwwn5yBPXtWMvl19Wj/kZ1uU4OqsjvighblW3XcCQirZA4vzGMgBHNOsT7xSpUL4af
	 781ukMTLYKJdmMew+o74I/enZ6YTvvPBtpn/QYPMB58ARc0N3cP+O4W+4S10YJEAlUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574196;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ip7OqnOPWA382+L4zd800WcdSezVmBpGTHBVFqhAjEc=;
	b=4eRdYGvHFBBt2hZ5CxqndV97s8m7ILrxeRHkzlmrMBEvUFj+wYAs6fDqMbJhM5rJvccS
	 MNldnKxxpCJRPnszEhndI4gqXBoSrSFjcvDUITFn+skz/TCLrIPBu6uWX8c5kCklMRPuD
	 JePa/ISPWFigF79EZ6ZbCjn/5F4WN5qr/nZqKGw6EYZgkD8itWr/5E2YhIOrpp6sA87bj
	 LJeWTd2BJ2AxgeKJQwQQKwTzb6igK1xf8E0ijQxiRfh45hCnYqCSHD55Yg5iNYyVWMRLS
	 /ZA5HGI/3yC128thUmAoGDWR+cnNmIoiVQVVeNoX6nBJTX6QB5FWyC4yh7i1L/bMfsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FXI9Uszs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VYhnS12W;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FA60A2639
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 12:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 431FA60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FXI9Uszs;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VYhnS12W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ip7OqnOPWA382+L4zd800WcdSezVmBpGTHBVFqhAjEc=;
	b=FXI9UszsN4MfqlgBFaGrdLuZd/62fzs8tsCVik9OAwMH6lHz5VRHJ8dghMDt/Z7BjUI1RT
	7ruiECwJ4BvTuhDhDekVrBmeCENE78QRqwlymamw8NikoJzxDcnO2NXS0Fkx5/D+q1v0KK
	lgAOCrRvQb/AjMaT/ThEhDyc42PU8mM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-GyMew9yPODK-qVhtAdTPeQ-1; Fri, 13 Nov 2026 07:49:53 -0500
X-MC-Unique: GyMew9yPODK-qVhtAdTPeQ-1
X-Mimecast-MFC-AGG-ID: GyMew9yPODK-qVhtAdTPeQ_1794574192
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a17741243eso4625695e9.0
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 04:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574192; x=1795178992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ip7OqnOPWA382+L4zd800WcdSezVmBpGTHBVFqhAjEc=;
        b=VYhnS12Wt+GqYucq01JFLNw08vTYLwp+8GLcLIugYOr/NitlwG+1D+29cywk8Xs1Fp
         xO9WgSQ/wS0QjKzQtoU0LJB+Ya5glI8xcr8DNx/d3w6UXSf1vjg7czK+Ldz350Ntfj1m
         LTe0JuKXS9DIw+/x7o/bhJJtcB8H/y/GQ8nabNycL3wSRb/U9pcePTbn9rwLfWj6m8FG
         TKEgY/zhSt1VnniwBn/XB+URoLxUNuWs7eq+JEXkmCrpbdMVSrOPbsDTqYkxz9sU00w+
         U6O+ZSAdEtPJzGT9qxFoBV6CVU3RKxbLcdrSRJJqJurVP/A6Ky0Stj4wob7abRAclK2G
         wPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574192; x=1795178992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ip7OqnOPWA382+L4zd800WcdSezVmBpGTHBVFqhAjEc=;
        b=XayXpDAh36Jf6EpK3ty0HoM18b8tKlqwzfOq4UoUA6HFho0eehvAM+Kr/3GWN0lpoo
         Rag4k3n4DcdEadyFnYbJc3150yD5iJax91MrmpiMfC/2+9zgIknUYl5Q8SUvnAYrwS+5
         TpeI7SdylQE19aB7RbHW+EUPRnUupqdBlXdMqjELqgccZmGBemwL1+MAJlsPYzsBaJ+K
         Q4c+HEoM0ZcZBPhEhv7GOtUMGPgiblF0wXK9KCvL3BqfMgVzCJaLMyMqoiuxEj5irrqs
         xIVpFRv+2EdbAQEpz9DhEVu1Ks9A6RDg/ajl9u568AiYCzj0dDOQsaJmtYQ/Ty82mHnd
         Blfg==
X-Forwarded-Encrypted: i=1; AL+hErHN3H+QrGwOfDXHQJ9DYzz/1sDC13WDKjaPz5L5TsrYREn2pTS8tfipBtG8ig7dsojZ1eZSEYw0R3v9txQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aiJptMfL1dfrcjEcpVJpybonMT7pKSF599J54uBnZWTKcP4jt
	bcIMeoLwXUjVNspXjxHoNArWdA9cfKhDdSJ2YKRHujOnGZin9WAY7mNjsmeY+9tkH2Vx0ZXTytO
	/cxfpPmRIXrHtEZyNur7N7s5HWiRew+2bnYKlZT7nNQF/NXoq3qHQvq0nTwfnxuuhng==
X-Gm-Gg: AYBFou3ERcEvjvZIEiG/ye99guLouMvpIhEcIpY+Ea4KOeUi69WuBbLpqkcgANXuONQ
	jSyMHlNR81V12Z9RHcHTP3j9W7TlLi+sWOOjqu8qeDdbe+7DnciWpAJk/L0RHpuEozuGBrWnTQp
	s1wmHoxNBR5sMPNl82RPF6e+AFX00WZq1l/F+uy2n6fhDYG3L0K9xW8TIfOOGlrB59vPieYNYtF
	95Z8wp30eoh1d0eRk1mWo6ptyjGI4r6e10zPzteJAaN2I+DA2DVD14D7ygApC/fXFYJ3r8AtOAU
	Tfm4LaHJiTpaf336MxD65QG9NqiWKnkctnOaFJ4Hz3oDlrpN7tU8fbdGNzpF9HjpYWqE0PSjI/U
	mvBR5FBKC5eEX0OsXwFDtuJ8OsEoB+tXDmaTMWOSy4j2cOrR8cDlOqY17/kfXEFH84IINyVcX0v
	VKZc8cy+WKhg0=
X-Received: by 2002:a05:600c:1913:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb55a44c62mr54411065e9.7.1794574191485;
        Fri, 13 Nov 2026 04:49:51 -0800 (PST)
X-Received: by 2002:a05:600c:1913:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb55a44c62mr54410155e9.7.1794574191029;
        Fri, 13 Nov 2026 04:49:51 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:49 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:36 +0100
Subject: [PATCH RFC v2 3/8] vsock/virtio: implement the datagram data path
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
Message-Id: <20261113-vsock-dgram-support-v2-3-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11186; i=slp@redhat.com;
 h=from:subject:message-id; bh=HDuvzaYHkUWJ5X9Jj1YzuMXhUH5TfX/ACn0pbY3JQnw=;
 b=owEBbAKT/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wddjFFSvO+d3lalnHF/Z1FlIyhT1qv0H8o3e
 taGkI2mXn6JAjIEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXQAKCRD0aSeNLwwC
 NVCcD/Y5I8YcmuN1HwwP8pA3bIC6IP1/96SDZDZ+mFkNMtaY2+QvQKzdVmAKjCqUeHSpZeXBQKU
 fFxUDLPY5yAaY1TLxUPBe3prQYTV9rajFbogdOfFViXIltDUI54zDTH2Ixc0XAGWbxcz2AWKxkT
 b4RAnD2fef+R5Jo2T+fQKjyVtZgCXXHt1eFzU1Dcfhq7rnvVpunNBXPgCzWCzeIoANicw4/3lUt
 56695Yybl5axSp5i1xs7peu4dK+MAoDKAFuOeH3YpEmzFNtHH2Xtko93oBCWTG7z7f43HB7BTwk
 ahwt4sSvrD7PYTlAoEwO8jrdEGeWcg3oibzx2t1ThTFeRs7wtu+guiS3II70PJeIL7PwxSF15of
 HiWN5GdqfCr454jvIIpOaqvVymvILOTQ4bm5LqNWKWPXMemZ40zGA4nEKBymRPdjYXvBCUKiVXV
 OEblV/dJYV1+nNlyWKGajlnFDnYoPEx/ENSqlNqo6w+orfQnXwCs0/EuhaWgwY5YtheJk/SfUSG
 5zHGevZH7mZeghD8Lv1Ruw0TZ365uIYQO8q4gLNPzkiAdN5p7o1urZNGGM9fDP1f7xfAsrKhjeM
 7qGxcKBQUqjkoX9ipLvOPyhwIIGOsfMeB4IQ9Pj/ZHGH8XHa86+k4E1i3fP7tgHi+y3hjO2NOip
 ni2YHzRVipIXX
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Add the datagram feature bit and packet type, and implement the common
virtio transport operations needed to bind, send, and receive
datagrams.

Send each message as an OP_RW packet with a maximum 64 KiB payload,
including support for empty messages. Bound pending sends by the
socket send buffer instead of connection-oriented peer credits. Use
the socket's skb memory charge for datagram SIOCOUTQ, including empty
messages, and release it through the normal skb ownership lifetime on
completion, rejection, or queued drops.

Deliver incoming datagrams through the datagram bound-socket lookup
without entering the connection state machine. Connection-oriented
receive lookup excludes datagram sockets, so each class can use the
same destination CID and port. Validate the transport and connected
peer under the socket lock, including after shutdown, and silently
discard undeliverable messages. Use the socket datagram queue for
recvmsg(), including source addresses, peeking, and truncation
reporting based on the payload length after socket filtering. Reject
MSG_OOB and MSG_ERRQUEUE before accessing the receive queue. Reject
datagram sockmap admission until its receive callbacks support it.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                |  31 +++++---
 net/vmw_vsock/virtio_transport_common.c | 132 ++++++++++++++++++++++++++++----
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 4 files changed, 140 insertions(+), 28 deletions(-)

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
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 8a271eb66860..aef5389eeca2 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1659,20 +1659,27 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 
-		if (!vsk->transport || !vsk->transport->unsent_bytes) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
+		if (sk->sk_type == SOCK_DGRAM) {
+			/* Match UDP: report charged send memory, including skb
+			 * overhead and empty datagrams.
+			 */
+			n_bytes = sk_wmem_alloc_get(sk);
+		} else {
+			if (!vsk->transport || !vsk->transport->unsent_bytes) {
+				ret = -EOPNOTSUPP;
+				break;
+			}
 
-		if (sock_type_connectible(sk->sk_type) && sk->sk_state == TCP_LISTEN) {
-			ret = -EINVAL;
-			break;
-		}
+			if (sk->sk_state == TCP_LISTEN) {
+				ret = -EINVAL;
+				break;
+			}
 
-		n_bytes = vsk->transport->unsent_bytes(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+			n_bytes = vsk->transport->unsent_bytes(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 
 		ret = put_user(n_bytes, arg);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..08baa1181ba6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -204,6 +204,8 @@ static u16 virtio_transport_get_type(struct sock *sk)
 {
 	if (sk->sk_type == SOCK_STREAM)
 		return VIRTIO_VSOCK_TYPE_STREAM;
+	else if (sk->sk_type == SOCK_DGRAM)
+		return VIRTIO_VSOCK_TYPE_DGRAM;
 	else
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
 }
@@ -303,6 +305,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct iov_iter_state msg_iter_state;
+	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_sock *vvs;
 	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
@@ -327,14 +330,27 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		dst_port = info->remote_port;
 	}
 
-	vvs = vsk->trans;
+	/* Datagram sends use socket memory accounting instead of peer credits. */
+	vvs = info->type == VIRTIO_VSOCK_TYPE_DGRAM ? NULL : vsk->trans;
 
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
@@ -348,7 +364,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
 						    NULL, false);
 			if (!uarg) {
-				virtio_transport_put_credit(vvs, pkt_len);
+				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+					virtio_transport_put_credit(vvs, pkt_len);
 				return -ENOMEM;
 			}
 
@@ -393,7 +410,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		virtio_transport_inc_tx_pkt(vvs, skb);
+		if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+			virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
 		if (ret < 0)
@@ -416,7 +434,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (info->msg && ret < 0)
 		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
 
-	virtio_transport_put_credit(vvs, rest_len);
+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
+		virtio_transport_put_credit(vvs, rest_len);
 
 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
 	 * skb_zcopy_set() increases it for each skb, so we can drop that
@@ -620,7 +639,7 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 {
 	struct sock *s = skb->sk;
 
-	if (s && skb->len) {
+	if (s && skb->len && s->sk_type != SOCK_DGRAM) {
 		struct vsock_sock *vs = vsock_sk(s);
 		struct virtio_vsock_sock *vvs;
 
@@ -999,7 +1018,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
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
 
@@ -1202,13 +1261,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
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
 
@@ -1246,7 +1305,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
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
 
@@ -1771,7 +1840,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 static bool virtio_transport_valid_type(u16 type)
 {
 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1805,6 +1875,38 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
+		sk = vsock_find_bound_dgram_socket_net(&dst, net);
+
+		if (!sk)
+			goto free_pkt;
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

