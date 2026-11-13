Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590185;
	b=OlQffyc4XRdjO78z7x1xeTdzfziwxsLM5oNC7I3HrQ720QHvJhl0kcLVyNzvHPvGlS1r
	 Vg2sZOpkPhlhPKfhCVqQQiQEZiLGjNlrC5MT0M90SmOi6EgVpZ7wS4yJAVwVlNTRDb37I
	 vqog9XWJDiBcBTXxDB6KzUS3HGobH3IQ20w69ZRgTAyhVuos4YSymp6OtciYf+5iYLDac
	 PDG62KPiedc3I8aVIxRfGuRQli76VKB9tU5l6zSwkI4Zj3lqVLKEgY9BY4mF03zIESzWt
	 XKSLmKBsQ2sMlwzEpOBE/iF9i14Nc0WKlmbL5jbm7MbHgoZ5A7sa7iHJqhSYituPUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590185;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IqMhWr67DloLXKh8oNsaJo/V+9LWy4FfvFx8UFWGLdk=;
	b=2yxbLQp32ACgBCdbeOxCoMhQ2pew12TkuaIhr3e3fTRpj/O3v01t9Lp7gOWPaii6Xf84
	 8RT98JX/nq76Jg7roUtYhvqrxrETj5dSlmMay8/8NSWC/R5EMXIwqPngL6v+T3vJSEZAU
	 EhiIbg11WVNvPd2E2RIeigDzcYVyRFLni0Q1I0pEsfV3I4TmEAHcq0u2lg/qfsR0fCCt4
	 6eaBMR3GInxA7ggqfT1g5buElpANpo7gaRWkHyAzcT86rbOhh0Jf4wEGHn/BjA1KoNoZS
	 ns+J9SBHLqQ/eVUjpKtjcW0EQeSkabTX1LvfU+i1t34DZc9//tnGbFHDR/xqnbtc+cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KH4U9u4W;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="jS7m5/QO";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58178606B351
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 17:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58178606B351
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KH4U9u4W;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jS7m5/QO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqMhWr67DloLXKh8oNsaJo/V+9LWy4FfvFx8UFWGLdk=;
	b=KH4U9u4Wf7p4kQTv2EGOEAmcRAVp5+dIKY1JyYuQrrcEXDaPVxhnXU2mml7l+yibM2WMUO
	gPb2dRdF7+d/O/RL1O+ttnBdnwzNWCTFNelMv3Z+ncSOu15Senh/xHhFuti6G52ncGVw+H
	UWY2f/zEj9fQ0cVmQF1cHryB4AOrnuc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-wfz-woEUOfCzOJ1Dj8TFhQ-1; Fri, 13 Nov 2026 12:16:21 -0500
X-MC-Unique: wfz-woEUOfCzOJ1Dj8TFhQ-1
X-Mimecast-MFC-AGG-ID: wfz-woEUOfCzOJ1Dj8TFhQ_1794590180
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49205554e17so662429f8f.1
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794590179; x=1795194979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqMhWr67DloLXKh8oNsaJo/V+9LWy4FfvFx8UFWGLdk=;
        b=jS7m5/QOKCyaTqg2rcNEyw5O1f8frpL6wja5M1iLSlIFNfDF0zJEbzRSmm71S3qzQX
         uL1gnHWXOnmNmlDLhVbRJzwVxAGHzDlEri9B9DaPJJ+BSdfLG9N7wXkmsNsUh1rKnrRy
         IO+UJDnAd6V0dpRca3fr8D0GX2jO2puOUSt8fD4YEmDUKTTPWkOSkz2pPM9Zf7HH3Ud1
         SpNX5w3hR6+AJTmi3LN5tn6+O3yy7t1X/uOyeEnzHtCMw5qB/Do9RAqiP01h2+Lqx1RG
         Yq2A0/jAM/rXMHa0CqAG/RpjDavYD1Pvnz1wlY9K6SkgzjW6m+fbC9HXHtVWTEsg4hR/
         vE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590179; x=1795194979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqMhWr67DloLXKh8oNsaJo/V+9LWy4FfvFx8UFWGLdk=;
        b=lfNnINy9LgYOlm6GgDvjkAr6ShfPe2gXswpH5qC99HfXFT4VSk4CxHjKvEOD+bWKOW
         7BtC8f/3CiTJ95BhCYUl+nq5x5Le8lExsuTBqL3JqASbH/tBqFK9sIlTKqMePnExG709
         gNtYBwMeXTuQMWGdVLSqSERotcmeukUlw/miAVOueEP+xgIyUs1i9hK+S6IhNX5UN+ug
         NQ32Snz581aJJqSG90Esgmt3YBu/AH6L1QQNW7TfpSdlFobu62pAGF2jvVNCvt48LDUR
         DSumIaxQtjKSptYIIta2L1Ven6irYwmyGhf36Y6S5T7pQ0ckGpIQShsEFcKAFhVk3m8m
         Kapg==
X-Forwarded-Encrypted: i=1; AL+hErG22bQ7B2/yoEX+EYrvRdsjDAefBvBKHcy7JTqe+S3HOfLPVIwOm4pkQfc9WySfD+P2QL/NmvX6FEjLH08=@vger.kernel.org
X-Gm-Message-State: APuU4Z91UUIfuApayYxYEipVxe+BpFC5YWwSDeeJ3+dgJYDZHt+Is4Oq
	kh2SIG+SmQr46EXwY8KZb1Yiva2eAOVCroRnECZKgJVH/om8oToqSt7FHefcVo7l8wE6ztMdpuM
	SFfArYvF4HfzkqaPLfpGyDFEIYTGdP2PMnHB73Nqrlsq++kCzaEJH+DW/Z94twQh9tQ==
X-Gm-Gg: AYBFou088BE9jvrAFCi959e7/AEetrPhxywNjnMPnndo427BeJYZQ9twwC4EOqM4+qe
	oZhIi1FSp4Is38b6KL13QzBs0p5wXcO//JExA49Wy3Th++0R+TofdKNc+Rs61LDM+pmdIoZjd3b
	tpIV8r8LkMbG+XTXdBN7HMV4Ay990R514tFzsSHJ6H8mgc1w1+MnZlyOZLmV6DlF40hEKiulX+L
	bb8whkQyST9TOwWGoS6pTGgjOShISWn3So+PUWEMEd++1fld62dHCr++nuv9X78bxvXSp5EboTF
	gWtr6q7WDpVeZq1/I/W/mANAVygA/CFKZm8+lUa7/YCQLz+4/FuGmxlDxm24nczgAWAFfur2H1b
	Ds/S36L5kKuXzua2GFBzuIagTN4h/STaZdEW4ZUaanJA3UMQuV+AhCiDEQm5/Z1p89oygAd+nj6
	LXNJpfEpPCOiU=
X-Received: by 2002:a05:6000:29d3:b0:490:369b:f50e with SMTP id ffacd0b85a97d-49c73164881mr4540727f8f.19.1794590178905;
        Fri, 13 Nov 2026 09:16:18 -0800 (PST)
X-Received: by 2002:a05:6000:29d3:b0:490:369b:f50e with SMTP id ffacd0b85a97d-49c73164881mr4540648f8f.19.1794590178114;
        Fri, 13 Nov 2026 09:16:18 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:17 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:46 +0100
Subject: [PATCH RFC v3 6/8] vsock: allow datagrams to use directional
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
Message-Id: <20261113-vsock-dgram-support-v3-6-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=45672; i=slp@redhat.com;
 h=from:subject:message-id; bh=/nL+8kU8PwDWSobrCesPXOFu+68r3pOcNQdlkcdlUpo=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XLxBVGlrbdfvCxcPjWD9mSlWz2UkBnCxlzR
 NLVsFI2iTKJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFywAKCRD0aSeNLwwC
 NZ4OEACqiCQcY33qTBbV6I6zEjFxJcsvEk0MEJU22x+Qtpqmgez/Th7rJleof5yMbYFOKYhkhwi
 aEr2RRvDmZCl1mReBoq56/6fIsUECNogqv5KhYVrHMqiqJQVMmLJziC+85NQhzdBubNWaXsPJvf
 PsWaC/akoYOAiywrq8CKImEc+N+vXt+QTR1Z8gU42b0EhKbPEMF/FV5YUAe4ez21azC3R8D9TsB
 eEQ02my+5wyziapKRqnKvvZZF8CW1lZ2i0hc9UKpO16D83fqDRdlw46X+IhGbqDwmBtwPAxCM/e
 HtcEcnvL3Vv0aYhxD9eE0LaUi4udD1maR1VflcHtKfUzSQHZluDpGhjAcUAYc7GG3NkdOhjsdE3
 Q161M7UlXFYnk5QKpGCWDciuo7KYlwNsDQjm3OZVjmu1RIdHEkJA6KXU/Fh/oLkUiVnJMTOvYFK
 ff0a9IUeDjoTV/iEEEf0xGVrwZfxotEet1AhWVv9CzIErLjdwwV6VppqzQKKQHYod+QbuHcvre0
 rm5KMo7fCTuxH7+E3HuNkLXLdhuvHeJXfRau+YPj6B7VIN6y4N0/vMrdxaoJqVwwI6+s+uIdKHx
 uJHVNbL4crXfiQol8EBPB+UpW68eSD1kvx/NBsn0reWqVU4rJZxVYEAV6TamXRfPpH0Ar6DFTj/
 LwXxtIHXauGRDtw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Use the datagram fallback transport to own sockets that need transport-
specific bind state. VMCI needs this ownership to create and destroy its
receive handle. Without a fallback, initialize socket state through a
directional transport or loopback; use loopback if a directional transport
does not support datagrams. Hyper-V still rejects datagrams.

Share local, guest-to-host, host-to-guest, and parent-fallback route
selection with stream and seqpacket sockets. Choose a capable directional
transport for each datagram destination and use VMCI when none can serve
the peer. Keep VMCI as the socket owner across connect and send calls so
changing destinations cannot destroy its receive handle. Preserve parent
routing in returned addresses and when connecting through the guest-to-host
fallback. A host CID remains a loopback alias when the guest transport has
no active device.

Reserve VMCI-bound ports in the core table as well as in VMCI so virtio
and vhost can deliver to the same socket. Undo the core bind if VMCI
handle creation fails, and retry ephemeral ports that collide with VMCI
resources. Bind local namespace sockets only in the core table because
VMCI handles occupy a global port space.

Queue only datagram payloads with common source metadata in both receive
paths. Read the shared queue directly in core recvmsg() and report
payload size through SIOCINQ. Preserve the virtio TO_HOST source flag,
the VMCI source CID and port, peeking, truncation, and socket filtering.

Allow virtio datagram sends from a VMCI-owned socket without interpreting
VMCI private state as virtio state. The skb's socket ownership tracks send
memory regardless of which transport owns the socket. Per-send capability
checks still reject host traffic when virtio datagrams were not negotiated.

Check connected sources against the peer's selected route and exact CID
and port, including on loopback. Wildcard loopback senders use the
addressed local CID; explicit bindings retain their own CID. Reject
loopback source bindings whose reply address selects another transport.
Use a copy of the peer address during connected sends so a temporary
parent fallback does not pin later sends to the host. Remove sockets from
the core tables when transport initialization fails.

Paired stream, seqpacket, and datagram tests pass with virtio/vhost.
Datagram tests also pass with a temporary VMCI-like fallback owner. The
fallback tests cover mixed send and receive, VMCI-style bind rollback, and
an unclaimed destination. A child-disappearance reproducer confirms parent
fallback and direct-route recovery. VMCI and Hyper-V objects build; real
VMCI hardware has not been exercised.

Link: https://lore.kernel.org/all/DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com/
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 Documentation/admin-guide/sysctl/net.rst |   8 +-
 drivers/vhost/vsock.c                    |   2 +-
 include/linux/virtio_vsock.h             |   8 +-
 include/net/af_vsock.h                   |  30 ++-
 net/vmw_vsock/af_vsock.c                 | 373 +++++++++++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c         |  11 +-
 net/vmw_vsock/virtio_transport.c         |   2 +-
 net/vmw_vsock/virtio_transport_common.c  | 121 +++++-----
 net/vmw_vsock/vmci_transport.c           | 133 +++++------
 net/vmw_vsock/vsock_loopback.c           |   2 +-
 10 files changed, 455 insertions(+), 235 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index fe43e8595958..30d81128fd29 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -586,9 +586,11 @@ reachable through the hypervisor (e.g. Nitro Enclaves) to address both using
 a single CID space, without requiring applications to set
 ``VMADDR_FLAG_TO_HOST``.
 
-When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
-the remote address so that userspace can determine the path via
-``getpeername()``.
+When a connect falls back, ``VMADDR_FLAG_TO_HOST`` is automatically set on
+the connected peer address so that userspace can determine the selected path
+via ``getpeername()``. A datagram send on an existing connection can also fall
+back; in that case the flag is set only on the per-send destination. Later
+sends can use H2G again if it takes ownership of the destination CID.
 
 Note: With this sysctl enabled, user space that attempts to talk to a guest
 CID which is not implemented by the H2G transport will create host vsock
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 7971f6f0b6a2..f4fb2ac732f5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -462,9 +462,9 @@ static struct virtio_transport vhost_transport = {
 		.cancel_pkt               = vhost_transport_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_allow              = vhost_transport_dgram_allow,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..221ce1a1c1dc 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -171,6 +171,7 @@ struct virtio_vsock_sock {
 
 struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
+	const struct virtio_transport *t_ops;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
 	struct net *net;
@@ -204,11 +205,6 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
 				size_t len,
 				int type);
 int
-virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
-			       struct msghdr *msg,
-			       size_t len, int flags);
-
-int
 virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 				   struct msghdr *msg,
 				   size_t len);
@@ -261,6 +257,7 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port);
 int virtio_transport_dgram_bind(struct vsock_sock *vsk,
 				struct sockaddr_vm *addr);
 bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port);
+bool virtio_transport_dgram_transport_match(const struct vsock_transport *t);
 
 int virtio_transport_connect(struct vsock_sock *vsk);
 
@@ -274,6 +271,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 				size_t len);
 int
 virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
+			       const struct vsock_transport *transport,
 			       struct sockaddr_vm *remote_addr,
 			       struct msghdr *msg,
 			       size_t len);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e4fbea3b0e46..29494297106c 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -26,6 +26,13 @@ extern spinlock_t vsock_table_lock;
 #define vsock_sk(__sk)    ((struct vsock_sock *)__sk)
 #define sk_vsock(__vsk)   (&(__vsk)->sk)
 
+/* Datagrams from different transports share the socket receive queue. */
+struct vsock_dgram_skb_cb {
+	struct sockaddr_vm src;
+};
+
+#define VSOCK_DGRAM_SKB_CB(skb) ((struct vsock_dgram_skb_cb *)((skb)->cb))
+
 struct vsock_sock {
 	/* sk must be the first member. */
 	struct sock sk;
@@ -43,6 +50,7 @@ struct vsock_sock {
 					 * cached peer?
 					 */
 	u32 cached_peer;  /* Context ID of last dgram destination check. */
+	bool dgram_peer_is_vmci_self;	/* Wildcard connect chose VMCI self-send. */
 	const struct cred *owner;
 	/* Rest are SOCK_STREAM only. */
 	long connect_timeout;
@@ -98,8 +106,8 @@ struct vsock_transport_send_notify_data {
 #define VSOCK_TRANSPORT_F_H2G		0x00000001
 /* Transport provides guest->host communication */
 #define VSOCK_TRANSPORT_F_G2H		0x00000002
-/* Transport provides DGRAM communication */
-#define VSOCK_TRANSPORT_F_DGRAM		0x00000004
+/* Transport provides fallback DGRAM communication and owns its endpoint */
+#define VSOCK_TRANSPORT_F_DGRAM_FALLBACK	0x00000004
 /* Transport provides local (loopback) communication */
 #define VSOCK_TRANSPORT_F_LOCAL		0x00000008
 
@@ -119,13 +127,15 @@ struct vsock_transport {
 
 	/* DGRAM. */
 	int (*dgram_bind)(struct vsock_sock *, struct sockaddr_vm *);
-	int (*dgram_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
-			     size_t len, int flags);
-	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
-			     struct msghdr *, size_t len);
+	int (*dgram_enqueue)(struct vsock_sock *vsk,
+			     const struct vsock_transport *transport,
+			     struct sockaddr_vm *remote_addr,
+			     struct msghdr *msg, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
-	/* Optional payload length override, called with the receive queue locked. */
-	size_t (*dgram_payload_len)(const struct sk_buff *skb);
+	/* A fallback transport can share its datagram sockets with routed ones. */
+	bool dgram_fallback;
+	/* Optional: another transport can use this socket's datagram state. */
+	bool (*dgram_transport_match)(const struct vsock_transport *transport);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
@@ -223,6 +233,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
 int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr);
+void vsock_unbind_common(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
@@ -242,6 +253,9 @@ void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
+const struct vsock_transport *
+vsock_dgram_get_transport(struct vsock_sock *vsk,
+			  struct sockaddr_vm *remote_addr, bool vmci_self);
 bool vsock_find_cid(unsigned int cid);
 void vsock_linger(struct sock *sk);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index aef5389eeca2..e0d1a3e5d05c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -132,6 +132,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/cred.h>
+#include <linux/err.h>
 #include <linux/errqueue.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -198,8 +199,8 @@ struct proto vsock_proto = {
 static const struct vsock_transport *transport_h2g;
 /* Transport used for guest->host communication */
 static const struct vsock_transport *transport_g2h;
-/* Transport used for DGRAM communication */
-static const struct vsock_transport *transport_dgram;
+/* Transport owning fallback datagram endpoints */
+static const struct vsock_transport *transport_dgram_fallback;
 /* Transport used for local communication */
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
@@ -568,6 +569,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
 static bool vsock_use_local_transport(unsigned int remote_cid)
 {
+	u32 local_cid;
+
 	lockdep_assert_held(&vsock_register_mutex);
 
 	if (!transport_local)
@@ -576,11 +579,56 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
 	if (remote_cid == VMADDR_CID_LOCAL)
 		return true;
 
-	if (transport_g2h) {
-		return remote_cid == transport_g2h->get_local_cid();
-	} else {
-		return remote_cid == VMADDR_CID_HOST;
+	local_cid = transport_g2h ? transport_g2h->get_local_cid() :
+		VMADDR_CID_HOST;
+	/* A virtio device without a CID keeps the host loopback alias.
+	 * Hyper-V has no numeric CID even while it is active, so CID_HOST
+	 * must keep using its guest-to-host transport in that case.
+	 */
+	if (local_cid == VMADDR_CID_ANY && transport_g2h->dgram_transport_match)
+		local_cid = VMADDR_CID_HOST;
+
+	return remote_cid == local_cid;
+}
+
+/* Select a route without changing socket ownership. The caller holds
+ * vsock_register_mutex and pins the returned transport before releasing it.
+ */
+static const struct vsock_transport *
+vsock_select_transport(struct vsock_sock *vsk,
+		       const struct sockaddr_vm *remote_addr,
+		       const struct vsock_transport *dgram_owner,
+		       bool *to_host)
+{
+	struct sock *sk = sk_vsock(vsk);
+	u32 cid = remote_addr->svm_cid;
+
+	lockdep_assert_held(&vsock_register_mutex);
+	*to_host = false;
+
+	if (vsock_use_local_transport(cid))
+		return transport_local;
+	if (cid <= VMADDR_CID_HOST ||
+	    (remote_addr->svm_flags & VMADDR_FLAG_TO_HOST))
+		return transport_g2h;
+	/* VMCI may use a different local CID from the virtio transports.
+	 * A host destination still prefers a guest-to-host transport.
+	 */
+	if (dgram_owner && dgram_owner->dgram_fallback &&
+	    cid == dgram_owner->get_local_cid())
+		return dgram_owner;
+	if (transport_h2g &&
+	    (!transport_h2g->has_remote_cid ||
+	     transport_h2g->has_remote_cid(vsk, cid)))
+		return transport_h2g;
+	if (sock_net(sk)->vsock.g2h_fallback && transport_g2h &&
+	    transport_g2h->has_remote_cid &&
+	    transport_g2h->has_remote_cid(vsk, cid)) {
+		*to_host = true;
+		return transport_g2h;
 	}
+
+	return transport_h2g;
 }
 
 static void vsock_deassign_transport(struct vsock_sock *vsk)
@@ -612,9 +660,11 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 {
 	const struct vsock_transport *new_transport;
+	const struct vsock_transport *fallback_transport = NULL;
+	const struct vsock_transport *local_fallback = NULL;
 	struct sock *sk = sk_vsock(vsk);
 	unsigned int remote_cid = vsk->remote_addr.svm_cid;
-	__u8 remote_flags;
+	bool to_host;
 	int ret;
 
 	/* If the packet is coming with the source and destination CIDs higher
@@ -629,33 +679,28 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	    vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
 		vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
 
-	remote_flags = vsk->remote_addr.svm_flags;
-
 	mutex_lock(&vsock_register_mutex);
 
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
-		new_transport = transport_dgram;
+		/* VMCI must own bind() to create its receive handle, even when
+		 * directional transports serve individual destinations.
+		 */
+		if (transport_dgram_fallback)
+			new_transport = transport_dgram_fallback;
+		else if (transport_g2h)
+			new_transport = transport_g2h;
+		else if (transport_h2g)
+			new_transport = transport_h2g;
+		else
+			new_transport = transport_local;
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
-			new_transport = transport_local;
-		else if (remote_cid <= VMADDR_CID_HOST ||
-			 (remote_flags & VMADDR_FLAG_TO_HOST))
-			new_transport = transport_g2h;
-		else if (transport_h2g &&
-			 (!transport_h2g->has_remote_cid ||
-			  transport_h2g->has_remote_cid(vsk, remote_cid)))
-			new_transport = transport_h2g;
-		else if (sock_net(sk)->vsock.g2h_fallback &&
-			 transport_g2h && transport_g2h->has_remote_cid &&
-			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
+		new_transport = vsock_select_transport(vsk, &vsk->remote_addr,
+						       NULL, &to_host);
+		if (to_host)
 			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
-			new_transport = transport_g2h;
-		} else {
-			new_transport = transport_h2g;
-		}
 		break;
 	default:
 		ret = -ESOCKTNOSUPPORT;
@@ -674,6 +719,17 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		ret = -ENODEV;
 		goto err;
 	}
+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport == transport_g2h && transport_h2g &&
+	    transport_h2g != new_transport &&
+	    try_module_get(transport_h2g->module))
+		fallback_transport = transport_h2g;
+	/* Loopback can own datagram state when directional transports cannot. */
+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport != transport_local && transport_local &&
+	    transport_local != fallback_transport &&
+	    try_module_get(transport_local->module))
+		local_fallback = transport_local;
 
 	/* It's safe to release the mutex after a successful try_module_get().
 	 * Whichever transport `new_transport` points at, it won't go away until
@@ -710,6 +766,22 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	}
 
 	ret = new_transport->init(vsk, psk);
+	if (ret == -ESOCKTNOSUPPORT && fallback_transport) {
+		module_put(new_transport->module);
+		new_transport = fallback_transport;
+		fallback_transport = NULL;
+		ret = new_transport->init(vsk, psk);
+	}
+	if (ret == -ESOCKTNOSUPPORT && local_fallback) {
+		module_put(new_transport->module);
+		new_transport = local_fallback;
+		local_fallback = NULL;
+		ret = new_transport->init(vsk, psk);
+	}
+	if (fallback_transport)
+		module_put(fallback_transport->module);
+	if (local_fallback)
+		module_put(local_fallback->module);
 	if (ret) {
 		module_put(new_transport->module);
 		return ret;
@@ -724,6 +796,104 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/**
+ * vsock_dgram_get_transport - select a transport for a datagram destination
+ * @vsk: socket whose datagram state will be used
+ * @remote_addr: destination address
+ * @vmci_self: wildcard destination resolved to the VMCI owner's local CID
+ *
+ * The caller must hold the socket lock and release the returned transport's
+ * module reference after use. A datagram fallback owns its socket's binding,
+ * but a directional transport takes precedence when it can reach the peer.
+ * Parent fallback sets VMADDR_FLAG_TO_HOST to preserve that route on connect.
+ *
+ * Return: a referenced transport or an ERR_PTR on failure.
+ */
+const struct vsock_transport *
+vsock_dgram_get_transport(struct vsock_sock *vsk,
+			  struct sockaddr_vm *remote_addr, bool vmci_self)
+{
+	const struct vsock_transport *owner = vsk->transport;
+	const struct vsock_transport *transport;
+	u32 cid = remote_addr->svm_cid;
+	u32 local_cid;
+	bool to_host = false;
+	bool shared;
+	int err = -ENODEV;
+
+	if (!owner)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&vsock_register_mutex);
+	shared = owner->dgram_transport_match || owner->dgram_fallback;
+	if (!shared)
+		transport = owner;
+	else if (vmci_self && owner->dgram_fallback)
+		transport = owner;
+	else
+		transport = vsock_select_transport(vsk, remote_addr, owner,
+						   &to_host);
+
+	if (owner->dgram_fallback && transport != owner &&
+	    (!transport || !transport->dgram_transport_match ||
+	     !transport->dgram_transport_match(transport) ||
+	     !transport->dgram_allow ||
+	     !transport->dgram_allow(vsk, cid, remote_addr->svm_port))) {
+		transport = owner;
+		to_host = false;
+	}
+	if (owner->dgram_fallback && transport != owner &&
+	    transport->get_local_cid() != VMADDR_CID_LOCAL &&
+	    vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+	    vsk->local_addr.svm_cid != transport->get_local_cid()) {
+		transport = owner;
+		to_host = false;
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
+	if (shared && transport == transport_local &&
+	    vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+	    !vsock_use_local_transport(vsk->local_addr.svm_cid)) {
+		err = -EADDRNOTAVAIL;
+		goto out;
+	}
+	if (!try_module_get(transport->module))
+		goto out;
+	mutex_unlock(&vsock_register_mutex);
+
+	if (shared) {
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
@@ -924,6 +1094,17 @@ int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 }
 EXPORT_SYMBOL_GPL(vsock_bind_common);
 
+/* Undo a transport binding that could not be completed after reserving a port. */
+void vsock_unbind_common(struct vsock_sock *vsk)
+{
+	spin_lock_bh(&vsock_table_lock);
+	__vsock_remove_bound(vsk);
+	vsock_addr_unbind(&vsk->local_addr);
+	__vsock_insert_bound(vsock_unbound_sockets, vsk);
+	spin_unlock_bh(&vsock_table_lock);
+}
+EXPORT_SYMBOL_GPL(vsock_unbind_common);
+
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -938,7 +1119,10 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	 * like AF_INET prevents binding to a non-local IP address (in most
 	 * cases), we only allow binding to a local CID.
 	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
+	if (addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(addr->svm_cid) &&
+	    !(sk->sk_type == SOCK_DGRAM && vsk->transport->dgram_fallback &&
+	      addr->svm_cid == vsk->transport->get_local_cid()))
 		return -EADDRNOTAVAIL;
 
 	switch (sk->sk_socket->type) {
@@ -1055,7 +1239,7 @@ static void __vsock_release(struct sock *sk, int level)
 
 	if (vsk->transport)
 		vsk->transport->release(vsk);
-	else if (sock_type_connectible(sk->sk_type))
+	else
 		vsock_remove_sock(vsk);
 
 	sock_orphan(sk);
@@ -1461,6 +1645,27 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
 	return vsk->transport->read_skb(vsk, read_actor);
 }
 
+static int vsock_dgram_resolve_cid(struct vsock_sock *vsk,
+				   struct sockaddr_vm *remote_addr,
+				   bool *vmci_self)
+{
+	const struct vsock_transport *owner = vsk->transport;
+
+	if (remote_addr->svm_cid != VMADDR_CID_ANY)
+		return 0;
+
+	mutex_lock(&vsock_register_mutex);
+	if (transport_local || owner->dgram_transport_match) {
+		remote_addr->svm_cid = VMADDR_CID_LOCAL;
+	} else {
+		remote_addr->svm_cid = owner->get_local_cid();
+		*vmci_self = owner->dgram_fallback;
+	}
+	mutex_unlock(&vsock_register_mutex);
+
+	return remote_addr->svm_cid == VMADDR_CID_ANY ? -EADDRNOTAVAIL : 0;
+}
+
 static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len)
 {
@@ -1468,7 +1673,9 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	struct sockaddr_vm *remote_addr;
+	struct sockaddr_vm connected_addr;
 	const struct vsock_transport *transport;
+	bool vmci_self = false;
 
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
@@ -1480,8 +1687,6 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	transport = vsk->transport;
-
 	err = vsock_auto_bind(vsk);
 	if (err)
 		goto out;
@@ -1493,42 +1698,34 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_name &&
 	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
 			    &remote_addr) == 0) {
-		/* Ensure this address is of the right type and is a valid
-		 * destination.
-		 */
-
-		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
-
-		if (!vsock_addr_bound(remote_addr)) {
-			err = -EINVAL;
-			goto out;
-		}
+		connected_addr = *remote_addr;
+		remote_addr = &connected_addr;
 	} else if (sock->state == SS_CONNECTED) {
-		remote_addr = &vsk->remote_addr;
-
-		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
-
-		/* XXX Should connect() or this function ensure remote_addr is
-		 * bound?
-		 */
-		if (!vsock_addr_bound(&vsk->remote_addr)) {
-			err = -EINVAL;
-			goto out;
-		}
+		/* A fallback must not pin subsequent sends to the host. */
+		connected_addr = vsk->remote_addr;
+		remote_addr = &connected_addr;
+		vmci_self = vsk->dgram_peer_is_vmci_self;
 	} else {
 		err = -EINVAL;
 		goto out;
 	}
 
-	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
-				    remote_addr->svm_port)) {
+	err = vsock_dgram_resolve_cid(vsk, remote_addr, &vmci_self);
+	if (err)
+		goto out;
+	if (!vsock_addr_bound(remote_addr)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
+	transport = vsock_dgram_get_transport(vsk, remote_addr, vmci_self);
+	if (IS_ERR(transport)) {
+		err = PTR_ERR(transport);
+		goto out;
+	}
+
+	err = transport->dgram_enqueue(vsk, transport, remote_addr, msg, len);
+	module_put(transport->module);
 
 out:
 	release_sock(sk);
@@ -1542,6 +1739,9 @@ static int vsock_dgram_connect(struct socket *sock,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	struct sockaddr_vm *remote_addr;
+	struct sockaddr_vm connected_addr;
+	const struct vsock_transport *transport;
+	bool vmci_self = false;
 
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
@@ -1551,6 +1751,7 @@ static int vsock_dgram_connect(struct socket *sock,
 		lock_sock(sk);
 		vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY,
 				VMADDR_PORT_ANY);
+		vsk->dgram_peer_is_vmci_self = false;
 		sock->state = SS_UNCONNECTED;
 		release_sock(sk);
 		return 0;
@@ -1563,13 +1764,20 @@ static int vsock_dgram_connect(struct socket *sock,
 	if (err)
 		goto out;
 
-	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
-					 remote_addr->svm_port)) {
-		err = -EINVAL;
+	connected_addr = *remote_addr;
+	err = vsock_dgram_resolve_cid(vsk, &connected_addr, &vmci_self);
+	if (err)
+		goto out;
+
+	transport = vsock_dgram_get_transport(vsk, &connected_addr, vmci_self);
+	if (IS_ERR(transport)) {
+		err = PTR_ERR(transport);
 		goto out;
 	}
+	module_put(transport->module);
 
-	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
+	vsk->remote_addr = connected_addr;
+	vsk->dgram_peer_is_vmci_self = vmci_self;
 	sock->state = SS_CONNECTED;
 
 	/* sock map disallows redirection of non-TCP sockets with sk_state !=
@@ -1591,9 +1799,35 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			  size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
-	struct vsock_sock *vsk = vsock_sk(sk);
+	struct sk_buff *skb;
+	size_t copied;
+	int err;
+
+	if (flags & (MSG_OOB | MSG_ERRQUEUE))
+		return -EOPNOTSUPP;
+
+	skb = skb_recv_datagram(sk, flags, &err);
+	if (!skb)
+		return err;
+
+	copied = min_t(size_t, len, skb->len);
+	if (copied < skb->len)
+		msg->msg_flags |= MSG_TRUNC;
+
+	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, copied);
+	if (err)
+		goto out;
+
+	if (msg->msg_name) {
+		memcpy(msg->msg_name, &VSOCK_DGRAM_SKB_CB(skb)->src,
+		       sizeof(struct sockaddr_vm));
+		msg->msg_namelen = sizeof(struct sockaddr_vm);
+	}
 
-	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
+	err = flags & MSG_TRUNC ? skb->len : copied;
+out:
+	skb_free_datagram(sk, skb);
+	return err;
 }
 
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
@@ -1641,10 +1875,7 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 
 			spin_lock_bh(&sk->sk_receive_queue.lock);
 			skb = skb_peek(&sk->sk_receive_queue);
-			if (skb && vsk->transport->dgram_payload_len)
-				n_bytes = vsk->transport->dgram_payload_len(skb);
-			else
-				n_bytes = skb ? skb->len : 0;
+			n_bytes = skb ? skb->len : 0;
 			spin_unlock_bh(&sk->sk_receive_queue.lock);
 		} else {
 			n_bytes = vsock_stream_has_data(vsk);
@@ -3247,7 +3478,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 
 	t_h2g = transport_h2g;
 	t_g2h = transport_g2h;
-	t_dgram = transport_dgram;
+	t_dgram = transport_dgram_fallback;
 	t_local = transport_local;
 
 	if (features & VSOCK_TRANSPORT_F_H2G) {
@@ -3266,7 +3497,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 		t_g2h = t;
 	}
 
-	if (features & VSOCK_TRANSPORT_F_DGRAM) {
+	if (features & VSOCK_TRANSPORT_F_DGRAM_FALLBACK) {
 		if (t_dgram) {
 			err = -EBUSY;
 			goto err_busy;
@@ -3284,7 +3515,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 
 	transport_h2g = t_h2g;
 	transport_g2h = t_g2h;
-	transport_dgram = t_dgram;
+	transport_dgram_fallback = t_dgram;
 	transport_local = t_local;
 
 err_busy:
@@ -3303,8 +3534,8 @@ void vsock_core_unregister(const struct vsock_transport *t)
 	if (transport_g2h == t)
 		transport_g2h = NULL;
 
-	if (transport_dgram == t)
-		transport_dgram = NULL;
+	if (transport_dgram_fallback == t)
+		transport_dgram_fallback = NULL;
 
 	if (transport_local == t)
 		transport_local = NULL;
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 855b15971c35..015c5371ea98 100644
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
@@ -556,13 +559,8 @@ static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 	return -EOPNOTSUPP;
 }
 
-static int hvs_dgram_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
-			     size_t len, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
 static int hvs_dgram_enqueue(struct vsock_sock *vsk,
+			     const struct vsock_transport *transport,
 			     struct sockaddr_vm *remote, struct msghdr *msg,
 			     size_t dgram_len)
 {
@@ -871,7 +869,6 @@ static struct vsock_transport hvs_transport = {
 	.shutdown                 = hvs_shutdown,
 
 	.dgram_bind               = hvs_dgram_bind,
-	.dgram_dequeue            = hvs_dgram_dequeue,
 	.dgram_enqueue            = hvs_dgram_enqueue,
 	.dgram_allow              = hvs_dgram_allow,
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index fd10f20d7611..87a96e94c3c2 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -582,9 +582,9 @@ static struct virtio_transport virtio_transport = {
 		.cancel_pkt               = virtio_transport_cancel_pkt,
 
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow_check,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 08baa1181ba6..c540bc40755a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,21 +316,30 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	info->type = virtio_transport_get_type(sk_vsock(vsk));
 
-	t_ops = virtio_transport_get_ops(vsk);
+	t_ops = info->t_ops ?: virtio_transport_get_ops(vsk);
 	if (unlikely(!t_ops))
 		return -EFAULT;
 
 	src_cid = t_ops->transport.get_local_cid();
 	src_port = vsk->local_addr.svm_port;
-	if (!info->remote_cid) {
+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM && !info->remote_cid) {
 		dst_cid	= vsk->remote_addr.svm_cid;
 		dst_port = vsk->remote_addr.svm_port;
 	} else {
 		dst_cid = info->remote_cid;
 		dst_port = info->remote_port;
 	}
+	/* Explicit loopback bindings keep their CID; wildcard bindings use
+	 * the addressed local CID so connected peers can compare exact CIDs.
+	 */
+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM &&
+	    src_cid == VMADDR_CID_LOCAL)
+		src_cid = vsk->local_addr.svm_cid == VMADDR_CID_ANY ?
+			dst_cid : vsk->local_addr.svm_cid;
 
-	/* Datagram sends use socket memory accounting instead of peer credits. */
+	/* Datagram sends use socket memory accounting, including when VMCI
+	 * owns the socket and vsk->trans contains VMCI state.
+	 */
 	vvs = info->type == VIRTIO_VSOCK_TYPE_DGRAM ? NULL : vsk->trans;
 
 	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
@@ -1013,55 +1022,6 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
 
-int
-virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
-			       struct msghdr *msg,
-			       size_t len, int flags)
-{
-	struct sock *sk = sk_vsock(vsk);
-	struct virtio_vsock_hdr *hdr;
-	struct sk_buff *skb;
-	size_t payload_len;
-	int err;
-
-	if (flags & (MSG_OOB | MSG_ERRQUEUE))
-		return -EOPNOTSUPP;
-
-	skb = skb_recv_datagram(sk, flags, &err);
-	if (!skb)
-		return err;
-
-	hdr = virtio_vsock_hdr(skb);
-	payload_len = skb->len;
-
-	if (payload_len > len) {
-		payload_len = len;
-		msg->msg_flags |= MSG_TRUNC;
-	}
-
-	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
-	if (err)
-		goto out;
-
-	if (msg->msg_name) {
-		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
-
-		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
-				le32_to_cpu(hdr->src_port));
-		msg->msg_namelen = sizeof(*vm_addr);
-	}
-
-	if (flags & MSG_TRUNC)
-		err = skb->len;
-	else
-		err = payload_len;
-
-out:
-	skb_free_datagram(sk, skb);
-	return err;
-}
-EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
-
 s64 virtio_transport_stream_has_data(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
@@ -1271,6 +1231,13 @@ bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
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
@@ -1301,12 +1268,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
 
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
@@ -1844,6 +1813,34 @@ static bool virtio_transport_valid_type(u16 type)
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
+	if ((!virtio_transport_dgram_transport_match(vsk->transport) &&
+	     !vsk->transport->dgram_fallback) ||
+	    !virtio_transport_dgram_transport_match(transport))
+		return false;
+	/* Shutdown preserves the peer; only disconnect removes it. */
+	if (sk_vsock(vsk)->sk_socket->state == SS_UNCONNECTED)
+		return true;
+
+	peer_transport = vsock_dgram_get_transport(vsk, &peer,
+						   vsk->dgram_peer_is_vmci_self);
+	if (IS_ERR(peer_transport))
+		return false;
+	allow = peer_transport == transport &&
+		src->svm_port == vsk->remote_addr.svm_port &&
+		src->svm_cid == vsk->remote_addr.svm_cid;
+	module_put(peer_transport->module);
+	return allow;
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1890,15 +1887,29 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 		vsk = vsock_sk(sk);
 		lock_sock(sk);
+		/* Bind can publish the socket before a VMCI handle is created.
+		 * Recheck after taking the socket lock in case that bind rolled back.
+		 */
 		if (sock_flag(sk, SOCK_DEAD) ||
-		    vsk->transport != &t->transport ||
-		    (sk->sk_socket->state != SS_UNCONNECTED &&
-		     !vsock_check_source(vsk, &t->transport, &src))) {
+		    vsk->local_addr.svm_port != dst.svm_port ||
+		    (vsk->local_addr.svm_cid != VMADDR_CID_ANY &&
+		     vsk->local_addr.svm_cid != dst.svm_cid) ||
+		    !virtio_transport_dgram_source_allow(vsk, &t->transport, &src)) {
 			release_sock(sk);
 			sock_put(sk);
 			goto free_pkt;
 		}
 
+		/* Loopback can hand the TX skb to its receiver. Release TX
+		 * ownership before replacing its private control block.
+		 */
+		skb_orphan(skb);
+		vsock_addr_init(&VSOCK_DGRAM_SKB_CB(skb)->src,
+				src.svm_cid, src.svm_port);
+		if (t->transport.get_local_cid() > VMADDR_CID_HOST &&
+		    src.svm_cid > VMADDR_CID_HOST)
+			VSOCK_DGRAM_SKB_CB(skb)->src.svm_flags =
+				VMADDR_FLAG_TO_HOST;
 		if (sock_queue_rcv_skb(sk, skb))
 			kfree_skb(skb);
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 2b9493e987d1..72c1985ae537 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -629,18 +629,21 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	vsk = vsock_sk(sk);
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
+	if (dg->payload_size > VMCI_MAX_DG_PAYLOAD_SIZE)
+		return VMCI_ERROR_INVALID_ARGS;
 
-	size = VMCI_DG_SIZE(dg);
+	size = dg->payload_size;
 
-	/* Attach the packet to the socket's receive queue as an sk_buff. */
+	/* Queue only the payload, with transport-independent source metadata. */
 	skb = alloc_skb(size, GFP_ATOMIC);
 	if (!skb)
 		return VMCI_ERROR_NO_MEM;
 
 	/* sk_receive_skb() will do a sock_put(), so hold here. */
 	sock_hold(sk);
-	skb_put(skb, size);
-	memcpy(skb->data, dg, size);
+	skb_put_data(skb, VMCI_DG_PAYLOAD(dg), size);
+	vsock_addr_init(&VSOCK_DGRAM_SKB_CB(skb)->src,
+			dg->src.context, dg->src.resource);
 	sk_receive_skb(sk, skb, 0);
 
 	return VMCI_SUCCESS;
@@ -1690,39 +1693,62 @@ static void vmci_transport_release(struct vsock_sock *vsk)
 	}
 }
 
+#define VMCI_DGRAM_BIND_RETRIES 24
+
 static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
 				     struct sockaddr_vm *addr)
 {
+	const bool auto_port = addr->svm_port == VMADDR_PORT_ANY;
 	u32 port;
 	u32 flags;
+	unsigned int i;
 	int err;
 
-	/* VMCI will select a resource ID for us if we provide
-	 * VMCI_INVALID_ID.
+	/* VMCI handles occupy a global port space. Local namespaces use only
+	 * the core binding so they cannot receive external VMCI datagrams.
 	 */
-	port = addr->svm_port == VMADDR_PORT_ANY ?
-			VMCI_INVALID_ID : addr->svm_port;
+	if (!vsock_net_mode_global(vsk))
+		return vsock_bind_common(vsk, addr);
 
-	if (port <= LAST_RESERVED_PORT && !capable(CAP_NET_BIND_SERVICE))
-		return -EACCES;
+	/* A handle always uses VMCI's context ID. Other explicit CIDs can
+	 * receive through loopback or a directional transport only.
+	 */
+	if (addr->svm_cid != VMADDR_CID_ANY &&
+	    addr->svm_cid != vmci_get_context_id())
+		return vsock_bind_common(vsk, addr);
 
 	flags = addr->svm_cid == VMADDR_CID_ANY ?
 				VMCI_FLAG_ANYCID_DG_HND : 0;
 
-	err = vmci_transport_datagram_create_hnd(port, flags,
-						 vmci_transport_recv_dgram_cb,
-						 &vsk->sk,
-						 &vmci_trans(vsk)->dg_handle);
-	if (err < VMCI_SUCCESS)
-		return vmci_transport_error_to_vsock_error(err);
-	vsock_addr_init(&vsk->local_addr, addr->svm_cid,
-			vmci_trans(vsk)->dg_handle.resource);
+	/* Reserve the same port for VMCI and directional receive. A VMCI
+	 * resource may already occupy a core-selected ephemeral port.
+	 */
+	for (i = 0; i < VMCI_DGRAM_BIND_RETRIES; i++) {
+		err = vsock_bind_common(vsk, addr);
+		if (err)
+			return err;
 
-	return 0;
+		port = vsk->local_addr.svm_port;
+		err = vmci_transport_datagram_create_hnd(port, flags,
+							 vmci_transport_recv_dgram_cb,
+							 &vsk->sk,
+							 &vmci_trans(vsk)->dg_handle);
+		if (err >= VMCI_SUCCESS)
+			return 0;
+
+		vsock_unbind_common(vsk);
+		vmci_trans(vsk)->dg_handle = VMCI_INVALID_HANDLE;
+		if (!auto_port || (err != VMCI_ERROR_ALREADY_EXISTS &&
+				   err != VMCI_ERROR_DUPLICATE_ENTRY))
+			return vmci_transport_error_to_vsock_error(err);
+	}
+
+	return -EADDRNOTAVAIL;
 }
 
 static int vmci_transport_dgram_enqueue(
 	struct vsock_sock *vsk,
+	const struct vsock_transport *transport,
 	struct sockaddr_vm *remote_addr,
 	struct msghdr *msg,
 	size_t len)
@@ -1761,72 +1787,13 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
-static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
-{
-	if (skb->len < sizeof(struct vmci_datagram))
-		return 0;
-
-	return skb->len - sizeof(struct vmci_datagram);
-}
-
-static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
-					struct msghdr *msg, size_t len,
-					int flags)
-{
-	int err;
-	struct vmci_datagram *dg;
-	size_t payload_len;
-	struct sk_buff *skb;
-
-	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
-		return -EOPNOTSUPP;
-
-	/* Retrieve the head sk_buff from the socket's receive queue. */
-	err = 0;
-	skb = skb_recv_datagram(&vsk->sk, flags, &err);
-	if (!skb)
-		return err;
-
-	dg = (struct vmci_datagram *)skb->data;
-	if (!dg)
-		/* err is 0, meaning we read zero bytes. */
-		goto out;
-
-	payload_len = dg->payload_size;
-	/* Ensure the sk_buff matches the payload size claimed in the packet. */
-	if (payload_len != skb->len - sizeof(*dg)) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (payload_len > len) {
-		payload_len = len;
-		msg->msg_flags |= MSG_TRUNC;
-	}
-
-	/* Place the datagram payload in the user's iovec. */
-	err = skb_copy_datagram_msg(skb, sizeof(*dg), msg, payload_len);
-	if (err)
-		goto out;
-
-	if (msg->msg_name) {
-		/* Provide the address of the sender. */
-		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
-		vsock_addr_init(vm_addr, dg->src.context, dg->src.resource);
-		msg->msg_namelen = sizeof(*vm_addr);
-	}
-	err = payload_len;
-
-out:
-	skb_free_datagram(&vsk->sk, skb);
-	return err;
-}
-
 static bool vmci_transport_dgram_allow(struct vsock_sock *vsk, u32 cid,
 				       u32 port)
 {
 	if (!vsock_net_mode_global(vsk))
 		return false;
+	if (vmci_handle_is_invalid(vmci_trans(vsk)->dg_handle))
+		return false;
 
 	if (cid == VMADDR_CID_HYPERVISOR) {
 		/* Registrations of PBRPC Servers do not modify VMX/Hypervisor
@@ -2082,10 +2049,9 @@ static struct vsock_transport vmci_transport = {
 	.release = vmci_transport_release,
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
-	.dgram_dequeue = vmci_transport_dgram_dequeue,
-	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
+	.dgram_fallback = true,
 	.stream_dequeue = vmci_transport_stream_dequeue,
 	.stream_enqueue = vmci_transport_stream_enqueue,
 	.stream_has_data = vmci_transport_stream_has_data,
@@ -2153,7 +2119,8 @@ static int __init vmci_transport_init(void)
 	/* Register only with dgram feature, other features (H2G, G2H) will be
 	 * registered when the first host or guest becomes active.
 	 */
-	err = vsock_core_register(&vmci_transport, VSOCK_TRANSPORT_F_DGRAM);
+	err = vsock_core_register(&vmci_transport,
+				  VSOCK_TRANSPORT_F_DGRAM_FALLBACK);
 	if (err < 0)
 		goto err_unsubscribe;
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e851..645b10843f86 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -74,9 +74,9 @@ static struct virtio_transport loopback_transport = {
 		.cancel_pkt               = vsock_loopback_cancel_pkt,
 
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_transport_match    = virtio_transport_dgram_transport_match,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,

-- 
2.56.0

