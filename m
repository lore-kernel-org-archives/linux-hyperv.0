Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522904;
	b=hGsHSn/qckn1isDu5y+e95bOOiNx+iikwzwtw8JFp/O0+8druD5ihEk/S8/FvYnuWUvu
	 tLSGSnrZIeoLLTYMYADSMPcU20APPhaWEbHFsQ8XNascNRzNNjXayqeXGjOtFQtTAFPah
	 IdnmmRkUtGmC0g9uxMXfZ6JMmW3vj7dHkhqxUdivXX0sjS9mainXGTppjvNUPo4/QsnuV
	 nAFnB0gerJC0296X4eUUhqv4HcY4LeCZAA4liyZeA7bdBQIR4zopILP9ov206xw9wMVqG
	 ouuYth6o6F67UAnSWza+dkco+drb1L95xkmBNXKbDDreyMtPSCcQ3HvUV2+k9P567aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522904;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=ZtaSjy4pMYCjEvWaurfCijoVRMXGxZEfnircQ4wbuq++SJMvyPuOBlLUzRJB47lFDuXr
	 iEcAy0l0wPOPgNwTbpIRHYfLsx2woveh5+vcespSfbZVJKVr8S/kiA0tOfSDIFtJZkouN
	 eAkxPzjDnseTKFMQIwlDS84V4QMEjenDeytZ0buhDWH2+mR7UN7yzHH0DQf8GKDy5CdAO
	 7FH+iOjoRmQeneNXVm08hahmaHITLY9pfNh0ttHo1hQPO6mZIL+pDc0MFdS5gis+mRU/3
	 2rx4g2qJKg3Q6v8kt+uAegL1d4xLRzEomp9ztPxHCkHrSx8Qcjj9kve3bNeKE6T//8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OEytque7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8D606A6A5
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B8D606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OEytque7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=OEytque7EC7pQ5hmzmlmBV+Zq/2QROUbb5elUa4Qi4cIuO20umEWzk9MXJW6GMCY8id7lt
	zYeXmTd3lWK93WSDfKLjOq8bibEN2WySg7rj7c9LU6eWHIK8XT5189hIFTJ/TyBqh/1sv+
	fXNs8tmO8yei1ue+xJySyAc+u1yB4BU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-II4e26rZOQ6HHBZiXeforQ-1; Tue, 24 Nov 2026 12:21:40 +0000
X-MC-Unique: II4e26rZOQ6HHBZiXeforQ-1
X-Mimecast-MFC-AGG-ID: II4e26rZOQ6HHBZiXeforQ_1795522899
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e00f3929bso2749435f8f.0
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522899; x=1796127699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=IGGOKaGgnYTZC6uMNFphgEaAiBl+z7Ib/AzDlnlGJ/DneRYZzlK3fk9JXe+54ZSCdE
         KgaQ8QrsY3sctpasdziJODIS0SXAZqfY9wIHBPVwoB/40+5r8nJYemWV51OgiqsCCU/9
         epJDChCCnpOkqpuzXRQ5E+xKM4FwXGPWD0L1TCxO/12cUNR3qfHfogbIEO2h8nYin5fO
         5iazUkzKhxBkJvxNBtg5Je+Dt/9x8JGT75HmJUtNK5qdZFeEYcTIr/P6cf0pL6Me03sm
         gbHgYJyqtOOCLpEyPePrsmV6si1lQWN57cA20LZs9dwTIuqjUeT0TF26LEi4dXJmqT1V
         VaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522899; x=1796127699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=s90IAmQlFXivyzp/wJp07HPFJ9ap06UjuSumXgFr9f3p3sbTG9jd2yhsu8SXjse0b3
         MiI9CxJOxU0kjWCOvFt0kR+yLb5PlHXNBB1fX701gUMuLGd9lL1SNlNv7vQ8ssk1ahRw
         tIheRkA53GmZEiC4PrarDU1aupVHx7FDXM97Y2AWk5oqPrYUJYaR7MESYOAmcYAypVyv
         tk+gVDBtTPrjiSh+/gksghuMEXjUxfDU2tE77YXrVaIvPgacsoG7GAiXNPwlT7e+dRG9
         WQNTcUbqf1iDDJjR0WiEB9VH5eBO6/H8g00VlVa9p38fwzRW/tgSIb1y9mbOyprRI9tq
         pZVw==
X-Forwarded-Encrypted: i=1; AL+hErEduXL6H4fJKFEjgejJE8TyadiBXcQaDq/+CBKoKIZ2JYv1sEfLcuqUBDgfqWZbUMyEcrn292wj8ppHG9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x91/BBKua/mF8qoKXIKqUIRdjfgYha3KERqT5d3Cq7/QDOFyV
	vgJRg9WaztXnluOOivzBYt9V/1UqRPiWC7sYrO400mpQ8qMaoHB3Sftok3tDJ6K53uenoUwaxsQ
	cRz0Tv4+rzX9PQ5oe3K3aMdjKWanh1s0zIBmM96kLygXHDVIZbObC1RYF1qZEUWtpog==
X-Gm-Gg: AZFdTZfy1vfL00qY0XPetHh2zEkS69Yd7u4axiqMUM5ww9P75hXk8V224BVQ1rrBeMI
	iaPQ05apQNgUAKeXkci+doucZjxlMWO5wL+vzBlI+vOEiQTG6AJ05oFtzFUdrk61o9k6zyXXsjn
	mRm9KdA82Alr2LengdtfFiWm3oRan80wp/Au9+JX5ctvxhMV6Bzkp66NDh7dyc82fmRSnC2tj6K
	hXj/KB000cEqNwLr7DqbHy2npDEXMzNXVp2zDdtFGNUZ6HSJ/ytyWsu0ycqnKlmR51RGgjdgxhr
	IrpavOZCBB9oAOqndr+jRh7qRkaqDMGvfoWDsUn/mpkVr/Cf2r1UKgkQonKSp7cVDrIiHvYf2BU
	ga2wSDW2pEWnb2cipCxXsFvf7yw0ZtgTIvHHEM+HYfUe1n1O4CEcK1AGK1vnKRITljkfDKlH8XJ
	zPFz2OkUqysVM=
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056225f8f.7.1795522899264;
        Tue, 24 Nov 2026 04:21:39 -0800 (PST)
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056186f8f.7.1795522898891;
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:22 +0100
Subject: [PATCH RFC v4 4/8] vsock/virtio: negotiate datagram support on the
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
Message-Id: <20261124-vsock-dgram-support-v4-4-3607484e85e8@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFF7IkOixcD6aeU8YwF6+Ac+NjB8ZTAX9VUt
 vhkX1UCGMOJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRQAKCRD0aSeNLwwC
 NQa7EACBjEJGAIQIYFtCJEK+zt/cuIT5TjQ0MPJoTh1Ut5YPjvEyOVH4wsLUDlJOSnOTMNi+1YC
 6JSXPs6dnaGdvBXQsAQiv28mRH9A7hX70dkt8B2Ni7fF2kFTvhpe1DM1S0JC+NSiGfGKv21EBAg
 cWYYLfw0I6bVFdD0DklYSAiDdbku6E1nUOCX4deyoGGqEERiquYKXorpSscKU3Pd+wzR4849Pxg
 GB0oJlSKQqC/eORSnlWttDW6D5ENxOkLKus5H6Avboc0UhbmMFHWtM/n5uJ/zBQT3LC+S6ew4zr
 e+hlUn+H/nR5blYN4QVotAr1n/EwwS7cSLVknfA7YxmCU6cNJA7sK2ms53f30hC5WmdrrwLiQrE
 vzRshVc0FHL5uOhh5GKsP8QWeuwQrTdQoEhU5S9L5GvhlBQCjUEA9+b2JLzW+uSsYyToaNDrTIS
 wyXQoML8Es651DUqrprc+4B7uMrUK5DDLUSBjidEo+ASDGfLpd2mU1CtBuyAZQx1kki8HrosAAD
 y8xF2UIX7cU4mZpDS/0P1tTWIuRsguaorUBhWGRKUCuSds+z3wLOk7vdf7CedmPDo2sbB7xYBUV
 IXSViTFKl6Wsz3KHWnDk7I5kRj+Lembhk1vZw0RG2hNYsY/TqTZVePZNKOrlX50a8FpumTjzj8I
 W57PdNgz/yXJ4kw==
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

