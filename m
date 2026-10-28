Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203507;
	b=WfkQ8jewbYeTGsVjYRFTjCordBiF1yiQitJcWiL4qTNfOB66nrWtoCJ+4uCevbyX4+GU
	 d/+UFXPJif3zwlt/O7Ffcl8zw4J66DPAACcMSQYZUU06mKCFkH3Guros5vTl5uccSXiKL
	 r6uh1LjuupNobVjx3BGcbTKh+5wvXOVN6BVBbWjYpIAfhraA3bj6GAPOA/siq2FZcXg92
	 ncRwKZ5/p3YjyGw2ThPKYHWeizAbcx4FHrwGV+J/EWMntsXLtOxSqJyGqbwhyr4UBATxQ
	 qCdUGZNPbdHkITK+70XlmnKFJ6T4F2ww+KqYAJzEKXlzCJrNto+WvvpdNkD/wq3kgdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203507;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Z0FA11bOxHY5HkDWO0eNsWcvn7gmJjsqjKd8RCkdH3Q=;
	b=hazDCSNE+nFZAQ7Rm7Ng+f25zB0BBzu9uABWD0V5OyZRHyJU6F+oEcdpU7pqfwYD7Vvi
	 zdDqk0Bu7d661yUeDbR0RXAkCE/IpHuhzp1UxhNyWSSNpKQyk3H6PBFL7m1wqEErjuWje
	 Yuz3ONq7kXNjZQy1taHLoePnx0fBrdWUbWGEj9W2UvpR9JQBOJKD/mo59TAeYhS6qEE9w
	 QPQ8Nrcj2Fv7StB6HXSpr6XSoOi0NXQSoeA0eoyc71u5bkebiUswkdThpG4EIjZB6PQHs
	 O+jQ27TJrZJ/DsWzm90j5gfbJYajO1OMYo58h/Zd0MnFYx+WblPOM6jVm95OtvPO8jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiVgepAX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=exOFETOF;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398660A3834
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 16:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0398660A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiVgepAX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=exOFETOF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0FA11bOxHY5HkDWO0eNsWcvn7gmJjsqjKd8RCkdH3Q=;
	b=BiVgepAXR5w4s4smulHQzO7C8YfSI7n/rqb0LUr37VjxdXTPRV7Ti5hmwhDIxUsDlddSmJ
	XD8SkUSIlC76KcfXr/3QzG7b0aHqvVHqy4AhdpbPuyTC9j94FZjsgF06H73VXMtnsqqt7k
	mm+OaSQ2S+EVfCbdCfwC1hPghIt1voA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-ABDQUz9DNlCR8PXGq2JS1Q-1; Wed, 28 Oct 2026 12:05:03 -0400
X-MC-Unique: ABDQUz9DNlCR8PXGq2JS1Q-1
X-Mimecast-MFC-AGG-ID: ABDQUz9DNlCR8PXGq2JS1Q_1793203502
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfa054f26so908724f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203502; x=1793808302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0FA11bOxHY5HkDWO0eNsWcvn7gmJjsqjKd8RCkdH3Q=;
        b=exOFETOFE1sOq08udgug/17RZczo9q3CRhjvHcrT8fV6/LYUsaebz75chMdrmwCCyx
         4+pt1AqZGo0Qy8FfEPS4ERkj1XJID+hjcHJrIHcUEbbdCA5Cq5W3Mx9hs4S5lAlCMNHG
         M+IrJMGb9AYaM4PWpQCHh9wjbeYmjDT047kb/07C2EXnDKko8haqXaatxjgXCBTCAWp1
         s82vDT2kr7YveWiPSzHxKJany6eR4he+7PiaQxhJol93iGfVH8yblvAINqwwJngT7+Ok
         uhI9WZIfKBC6PO7hqzJqjqbzCtOWUKG8PBPGEYxyI+zKxVz+mwEjxITZXrhFFBo1mObk
         LGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203502; x=1793808302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0FA11bOxHY5HkDWO0eNsWcvn7gmJjsqjKd8RCkdH3Q=;
        b=hq6AItxcLP12Cn0L6vD3YFy6EnOJGPVm0BLTETGB3WPiwJgYHZ7DwC2DB6QS/WzxUN
         hJxwNHBZINd1fIDPp/k+3NQSTBGGeuR6wjadk3J+m0I5tmPpy65FGpmnbfi03/1q09xN
         aTFGoRZlz6j9JmceMd7a4K2AHQXIo85N6Le0ZI/P8rUefvO2S8zG1sd3VdydbN6M3ncn
         F3X1JdDPU7KDHqVwH5eXZ/zGj3Oj84qEA8fluO9PHR7F5s+YkkecN3AR5aAfRtu3r476
         01b41RCEfoCZHr6YN9aPFoC35yUvcDn0Of9CfwebZDIjohjza+9/93itCJoVk9NOSDRI
         JfEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzweMhtqLdKjdTy+bf1q+uhcyyqwVQkIIQ5+gEf067y2JB+2pxfmlgge6PKuptiMPujMsRaq+Ao4YndGGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQswedKy8/cTvRtzFG3DvohQ5Dc4NG940xXqKzzaGeCyvDXUIk
	OVyMcnQDCOdvqPor5m42PR76z3OrKHzvjpAiuF0iREIM/dB3fij0Kg42cb7n10/KLFpm2gO7Idt
	bqEuIOEJ232s5+t/w23gSdHPl/CyNCJl9sSI/TZvJbH/o+zxLg8zsT1Gn1vhsnmN3AA==
X-Gm-Gg: AYBFou1YaivnFAJwZj/QK4t0jL5t3d77h9kIUaO+MXFp3uxQdK3icPXu0jv25Rjb2O6
	XwYAhgKkPJ/lomirr6RGmIGgDY9Z6ieUixJMLVBTJ3Tt1EYsqEuyWQtlKryXDq1HTRpJdj5eHWX
	FxFSHLHGNJEpkSl8Do1yenEEaQNuz65o3j2m8Ye/Rl48DVuR+VT0sry2AOzfs9ULMbx+SmB2h3E
	VtXL9bBAUIum3sznTVmraSm5lh2DuwAJ5xCSFAa5YOeQMhr3jswEVBBBaaiJfp4sE6c0qcmbOKF
	eTM7x2OzP8ads+EjgbbE6U6r3LRlvuprbRn5tQcUqmDsL/Z2G1JasAzL00DjjH+m1yxWd++lfpn
	XLn8AE2IEcyxfo5owP0g4ej0A1ZhqNxk97JmeGe5+B+62fHg3cMBt4VKZFueUpF5+m/jbp5S5iO
	V93Vx/er9PJVI=
X-Received: by 2002:a5d:5889:0:b0:48a:fbcf:6f43 with SMTP id ffacd0b85a97d-48e5d5b8768mr6765989f8f.54.1793203502157;
        Wed, 28 Oct 2026 09:05:02 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:48a:fbcf:6f43 with SMTP id ffacd0b85a97d-48e5d5b8768mr6765937f8f.54.1793203501776;
        Wed, 28 Oct 2026 09:05:01 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:00 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:33 +0100
Subject: [PATCH RFC 4/8] vsock/virtio: negotiate datagram support on the
 guest
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
Message-Id: <20261028-vsock-dgram-support-v1-4-e457cf7cee78@sinrega.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=slp@sinrega.org;
 h=from:subject:message-id; bh=RkaWKJCxcxHXdPxdXdX3oirEBHyriyFpDG6O2HtFPHI=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0esEEolYlcXO3AWWFREjUhnRb3yqa4fC1Wy
 Q+BTyl4Pp6JAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHgAKCRD0aSeNLwwC
 NWmbD/4n4MXsz7IY8sy8f3RXeuu8QdlXVit9+D8MWb7HCsYMS8wpfg3FMx0KLvs9aOARYt6SnNk
 xRy5zbNgSUF+U14RnPFWE/1o4WNpg2l6dwo+HDxwoMa+PWfVKuVoRx4nvsxRA9EOFucbdvwQKwZ
 8uZu9K3ayiYH5oSNSXb3UQWO10ryNJhb4C3ZMpZFOUjn6WsC7/AACwx/p9Ug//pGSum3zesyjOs
 57z8Orf/AJEa+hnNeCY6kX3mdMqWUY0OG3+QMvLPuCI8GlrPDWIRtMpgE5ALRZyOai5ctsiuMTT
 plXs4dSFGEu5OFKPU2GERXjr1lYhOgo3N7E1YaN6fNKwy6tC64ccygpDY3xzWCD464WA3vNYWx1
 RDtHGq9pBphQvdCMPhfa6KD6o8wJcszyP+LEkdxEGP4EH5RLAC3teAGdvk+WmQ/E+z9Zh/m/q1+
 0ZfV+D6JF6XysegnKipfkxoZMm7WeJknqxAFx4tQmCa83WMKmzmoGZ8zFEVstvz6dCkbZ+vaHAI
 +5qPqwtnMd0eR3p/SRDUCuLMd1ZzBaXaLyg6P0uNgQFyvf9D2BLhpMFkFElnOTw8OkuCmEhU84C
 ODLoktQgqVcipxcE1zBZMTrvBCvIduTX9RlKDjn6boKE7DQs5cfAxvWPPvi2ASRY/enSBgbTszX
 SbuFuHOoeqxl0tw==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
negotiated it. Gate datagram socket initialization and destination
checks on the negotiated feature and the transport's supported network
namespace mode.

Perform device capability checks at socket creation without requiring
a remote address, which is not yet known for an unconnected datagram
socket. The common virtio implementation provides the datagram data
path.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..762e77895f28 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -57,6 +57,7 @@ struct virtio_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dgram_allow;
 
 	/* These fields are used only in tx path in function
 	 * 'virtio_transport_send_pkt_work()', so to save
@@ -547,6 +548,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
+static bool virtio_transport_dgram_allow_check(struct vsock_sock *vsk,
+					       u32 cid, u32 port);
+
+static int virtio_transport_socket_init(struct vsock_sock *vsk,
+					struct vsock_sock *psk)
+{
+	if (sk_vsock(vsk)->sk_type == SOCK_DGRAM &&
+	    !virtio_transport_dgram_allow_check(vsk, 0, 0))
+		return -ESOCKTNOSUPPORT;
+
+	return virtio_transport_do_socket_init(vsk, psk);
+}
 
 static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 {
@@ -561,7 +574,7 @@ static struct virtio_transport virtio_transport = {
 		.get_local_cid            = virtio_transport_get_local_cid,
 		.has_remote_cid           = virtio_transport_has_remote_cid,
 
-		.init                     = virtio_transport_do_socket_init,
+		.init                     = virtio_transport_socket_init,
 		.destruct                 = virtio_transport_destruct,
 		.release                  = virtio_transport_release,
 		.connect                  = virtio_transport_connect,
@@ -571,7 +584,7 @@ static struct virtio_transport virtio_transport = {
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = virtio_transport_dgram_allow_check,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
@@ -629,6 +642,25 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+static bool
+virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	struct virtio_vsock *vsock;
+	bool dgram_allow;
+
+	if (!vsock_net_mode_global(vsk))
+		return false;
+
+	dgram_allow = false;
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
@@ -835,6 +867,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -932,7 +967,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {

-- 
2.56.0

