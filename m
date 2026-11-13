Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574200;
	b=mtYbgkOqvTft0vAGoEOBGKJ73sZ5Qm3ThPIt+49kTEd+sdu+3YSlinoW7AGUO8Uj3P/D
	 iRiJ0uYALwWAgsy3Owp1DE7SQqIS/gmR99VR3CQwf2CGmktDFw0vlb61xyb1lKoixr6eZ
	 QlGgSMFzhrnRzw9LC2pSrh41E/9UygnfojW07x+M73melIxw0lGpmKgPio7EYNUkhM/bx
	 m22CrGxPXHVe0KP8faamjmZBOTiJqtZKMQdbcicG/uYa+1ZzXE8uVNcbgzTNx4UftxFpq
	 MDR8EudWtpvnLv7RzRLToG1lb7fTDsExBs5xCDHBR+RSv/ppNDWFYZjrMZ1+hkhzI1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574200;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=tf89FyWkrm9dEb+vNYtex08L0gx+RBKzoCl91oxtuanpB/5BH6OSYp1UMawjNQGR4zm5
	 8IxD+UR9HnVQh37QtiDSEdZMP7CKmDkT+1OWOUpvx6aK5JGakDy0N/9gHbKGZhP1+d7FV
	 y/WjpQ4cUyfBruoI7t3+MVqmQONCgzR4LXuhPyhhxRONAMC49WPmmyb4XPSOQ/3Yu23s3
	 eaQMDlmEdcO7i/G2UjlQJPQZgrICVU+ZYrzi7oisfQ8zejMfc+/D0kzsqVn2mhsWM1msQ
	 9MQC30+YZb+aAy1CzyD4XKRFrwOK07Er2CO5HnZycoqD78yMRZ3moRZgRiUQjarkfYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ty9WWgpo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apjf9lft;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF560A5BC8
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 12:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54CF560A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ty9WWgpo;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apjf9lft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=Ty9WWgpofTOYgPuUYv9ClD1MdCxapeqvgQ7sqxGtdjpmUT5rQIWbQQBz+EjdjyhTV1tEAy
	asYssGvKTJzzsQK3vUkY2zNY8gWgx6IZXV0duSbxrTOheW02LoJnNNCI0Of7bsUoPDsW3B
	Io1DgEKplcOUP+ZN1k9GClhrLzURdE0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-9qf9jw_0PxCG2A7ABBu-Uw-1; Fri, 13 Nov 2026 07:49:55 -0500
X-MC-Unique: 9qf9jw_0PxCG2A7ABBu-Uw-1
X-Mimecast-MFC-AGG-ID: 9qf9jw_0PxCG2A7ABBu-Uw_1794574194
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso6137585e9.1
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 04:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574194; x=1795178994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=apjf9lftw/kE6a4icDfCjPJV+XzSfXXVFmugu7Z63ERAvY4nSAMM7vUv/VbHq4sv/1
         aSDAd5mwq8wKUU2nqzwO/Riv8Kmv9duHb79Hk42e5FR/kJUenCbyeXmB5Lu4/e/AU6Jd
         KZHqldA2MOcR8ZJd24gY0AhgVwyZwW2ke2yQ4dov4IUwE2nEZbUXXGCEfgQofXyFf7eT
         aGQRKwecpywQYlUIVb17EXPpVLrvJHxuiu9mD1yyS70qiucYXo/oL7iTEo3kW4kNKT8z
         zNfzg2MnNTnmhFZi0n06ZpO3uZx+DtDMWkgl+ZVcxVsca7O2Sa6TWMDeLa5xU2hfMMjy
         ENsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574194; x=1795178994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=008tJcsKynbRMjS97v/wulhE6EhfEUf+5ktb0WXymvdlL41RA0iVfaM+1eHd0GKdsa
         Q0Fmdl+o1b4hQDKWbk3machBx+n7VVAgHHsHwddNm0R7e4DUtn/xuxaiMmiOkRCu/c0y
         RtOjzI4i4vXpp1kDnhFjbAKbFQhqvn7pupvwykfIRUS6qSt+xvPCqswbLiA7UbURUg0D
         GqpOzDMyiJqTNz1Waucqrf9ds/XPV32GHHB4qyg3IJ7+aZSBcDoqAKWavZZyVoJyjRkz
         sCQkX+9yTLb1Kn44vFfy/+68TN4LtV1EpV6Td9ey+d/QaZ7onOhkF+lpzV68NfzdgMue
         c1xA==
X-Forwarded-Encrypted: i=1; AL+hErEU4tkgLx7BO6St6upEuglujBJqIFxMi78ple0Kl3rsJatD8tRM++S0VI9ZCQ/mQMgpRUgoeEzArvCNnxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z90krqTFl72vo50YT38vJ3hjV8wNaw74CoVmpTa6okcJErt2AAG
	8deLVN59abZLg5u+jQ+T2QT2rzm7Z+BUwjjAxAgbWsyP5nbEEze/SxbDxbMDW3AqxUUgwjeFKn+
	7gECzk7s5cr0QnCdhHD/z3wjz3UqBycWEmYNmGGgJ50X2WVacgGK955plRNHFE/KCUg==
X-Gm-Gg: AYBFou0nzhK+8Q5tuAfLadJR71sQlBFAZMUBBBIukQgspgDO5k7TtOqW4LgWKm/lnYY
	RccxT6bSf/n+ChM3jEFB9Ysd4cXKLy8/LGOq/gpVChXXG3B2EobU05bopmevCpjaZo14uYib4q1
	QVD8sy0l/sQ7cGrygTLJC3oY6ZFUD7ycsTeoTw7wdznJdqmGZ7ZVNTLGNueZq7elj5n13jsMp+h
	JiAe6yZoPih092CjeR3bJ/JR0l55C7OVruPSxagBwA0pTJgXjywb3+71JeATVsroho7k/rH/vcm
	1PLC0DdpUcVk9fCD+1eb/y3mc60+ul4tEjp++OLW+RT4zx+gEAjykcqHt0u3jsQcCUDKo9eQvHf
	V45egUl7JeUlcg94WAV0chc2ze1uwVGvtHdG4v/LJkzNWnzT3gEE8nRP0wyOpGymVtSNpON9rfq
	3fN0S4rSzN3hk=
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43805125e9.3.1794574193932;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43804695e9.3.1794574193541;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:52 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:37 +0100
Subject: [PATCH RFC v2 4/8] vsock/virtio: negotiate datagram support on the
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
Message-Id: <20261113-vsock-dgram-support-v2-4-bacfc85b71ce@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdeh/fbg8dtYF2DcAbRaFeKvm+icn7ibkHUI
 9UDc3bUTuCJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXgAKCRD0aSeNLwwC
 NawhD/4yNgrww43ef4iLOcszJW/Vt9MQ3fWu2LbAo/inVbx5U5pXTx6wb0mGebUaDw/EjjYsNd1
 hl7B6IFWykqjaE2K+qsEkL86SvLKJtPqHf+dhdgkXqTfgHzgYJq6zgLAfB2O+KREcuH4GuRa5iw
 /7IWcNoRiicOapx87Te+iwT7K+oYtdjTKzTkCXUumOL1KVCPl1EExuywDO2A+fAcsxfYUNBLknR
 hS+ExF4RKc4Ygx+nv9cPLZb2zNpA4ofI/GRvAivuDOl7gUhsZ9UMoqMTSTFdVm+hm7hp7WMxu9j
 mhGRMQkUqXf4yvCV/zb59WFbNAk0Y9fKthrj4aqZKKNsdNdJ5VYdPt2/aqNvtFfQXNzzy98qE1I
 QNrePr/T7btb19CqzTiGKYLjYeYUMqLRMzk8jTv4IsAWznc4LDyFD1arq8gK2JXOds4FHC9aOVd
 xxcnITpeQhtXqE0BH6pVM/aLJieAX/JPFhx2HbIA709Pv2Gp17nTtEXAmVPpYs8JJBxig6U8Q78
 AceTOeKwXHhQm5BfKSnAhUQj2Vf/qJwgH1Pr8Xla3pKX3o5kq7LAnmqXcADRUeDWIPDyp+5lkMN
 Nb9NTW8KBk/pEgvtH1GQXnINsSlthdAqlC3Q6vL8ED9yQwmPDh7D1VXTpYHb9DXvlL03WS02LHj
 NWJUmzBel0efycg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
negotiated it. Gate datagram socket initialization and destination
checks on the negotiated feature and the transport's supported network
namespace mode.

Perform device capability checks at socket creation without requiring
a remote address, which is not yet known for an unconnected datagram
socket. The common virtio implementation provides the datagram data
path.

Discard received datagrams when the device has not negotiated support,
including when a socket was initialized through another transport.
Reject packets addressed to a different CID using the full 64-bit wire
value before bound-socket lookup narrows it or matches a wildcard.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..fd10f20d7611 100644
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
@@ -677,6 +709,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
+			/* Check the full wire CID before socket lookup truncates it. */
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
+			    (!vsock->dgram_allow ||
+			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
@@ -835,6 +875,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -932,7 +975,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {

-- 
2.56.0

