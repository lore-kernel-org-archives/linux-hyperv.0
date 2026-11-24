Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522914;
	b=u5+J6xbxVQlbhn5tcGPHqto3+OHVtCJlY1xVVqX2QMfKZgAroKDQ+xFuzYxUip1Wgeu+
	 tnN26KUNeHcMDPwM+lfwVE0y8jilVc9521rGB9YeP83N5UQT+9lVlxH3k7TRJqifazRGk
	 ZcXtA6C5c6KG7XOFVLIJX7yFWVdS75e5wX7fkNy0H3x1KTTxiAz6T0snXhUMa87tmMrjl
	 BZ35Qf56Dp5/RSQIjCQY9gB4BsP5eYV274ooaySuKj0IHaMzxAURefTF3GJHgYKOOUwZ5
	 gWWBAf4CUM0/uL0PGx+xAHhOFw8cr4ADWcNUjrYkWVu3n6rj0zFVliMHkrH+LWDDadA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522914;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N5SMGwhfGZlL/35e5CCtpXUuqunfT/SrslPhESjFCRI=;
	b=ru1vDtOPRNdMjBzVGoKlQkyRHr30gqYa8J+MtRYPokWsIsfx05KNOz+MBMxc+3FNUDjo
	 VgUZBVrnqdecurcIfnF+FDGrtucHaDLe0IJBH1L/IiymeiaM7h+Ih2jYnl7tbWKpalNqC
	 BZAhOich1Bzg/gof7v5ukMGcTkqxjXEHSP7kyU+7GOuC3W47NoUopRSgYxeN/sygcPyt8
	 eIZyhkQKSP112VBASspExiK1YtB0iH23DxKEmX6+RP08eFb+N8UkOIal3e2tjzJpk2Amn
	 2YNyhhmtsuKHubIJueKYYYAOjBssRyS5VVAbMbt8eUBxHlRK3ontgsvGJFO4EWoShQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ByNHtJlY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Rj4Tz1LW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F760A2626
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 12:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA9F760A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ByNHtJlY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Rj4Tz1LW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5SMGwhfGZlL/35e5CCtpXUuqunfT/SrslPhESjFCRI=;
	b=ByNHtJlYXEQjvffdXnBJ2h6B79AtQjtJFGGpUNI6LMeHuQp6A4JDp2oC5Quot27nhK7xIc
	O5tsDu0KyZ3GYG0Jce/z5BMQDxR9Iqn/YhGdoWKbYK1M3nd7pZBjiUh9+Rw3kgOQzsXXrs
	byBJ5DZLFMZX/LwrZkWCZOmuzdZdp7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-aI7Et5dCMg-d_dqTKQysfw-1; Tue, 24 Nov 2026 12:21:49 +0000
X-MC-Unique: aI7Et5dCMg-d_dqTKQysfw-1
X-Mimecast-MFC-AGG-ID: aI7Et5dCMg-d_dqTKQysfw_1795522908
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so37575135e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522908; x=1796127708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5SMGwhfGZlL/35e5CCtpXUuqunfT/SrslPhESjFCRI=;
        b=Rj4Tz1LWikF03PtxZ8mi5NgtwFdWcS1SQweNuAPhO2Kfbnuunic/0Nrin7M+Uqnayk
         0icSht+K5g3pYpU3BQ6WBlebMrNg7cKWuT7bzW4nC5TxuCNCiKkAG/U0+oFCJ9znG87f
         0N46y4/FgG4DraZD/DYfdQowJErDAZ1EGTboCf+q/ASDhbSBL9mP8bAfurrO938539u/
         e4DmYUgT+55CrApIkxbAJ9eQdPuWBM87jiGkSuKLamVd3GoerrOQyEjMQLaeOse8v4lQ
         dvqGf61hb2sK6z9HQ59DiYvZeoBRDW2zu0CesIAmUR82/yAOgItXpcOeh91Kt37jqK9J
         WoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522908; x=1796127708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5SMGwhfGZlL/35e5CCtpXUuqunfT/SrslPhESjFCRI=;
        b=PABxfHbET07eGqZPb4fH3gziUI3hzVP3zW9onq+E0XtFsnKXECx8MeTicckurR3E5x
         DL0OcEIDp1hwk5qa8T++DN9vlh81iQW4WrLk0Zug4kEFs6AciFgK42Q7lJNjzKbXYLKq
         h3JVF6Nv6iSRr+L3nzZxW+TgW6uI6SBAyDt2Lcio9VqVFSzsPDnUVvogcqCn0OWoZ2Ab
         Ll81KYHzeqLPbrMYb3nSAhA0muHD7rgSNrSQZQiPUogmemxY8IELPmGIdEq2JqHeZWfV
         c2UZLPsHzWff7vruRnihi4UFs53bCo/6mNEYQ638A6wgsn1UgZjiXVZM2BKI7N4g93SL
         9s3A==
X-Forwarded-Encrypted: i=1; AL+hErGiTre+TIfd1dPQhpDnAOwDvvbm1MkzFKH8rvD8XasVUpHVWsYcAv8DZbzZx7PrjkazRtFBlGqjmeJWXk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hcHeHsV6B1zrJxuCiHwAHjHRHuDZUSSTiIBtgK+j55mFDxtyi
	kk3sI+yGPRndqECCuRSoD0XHbxIeNEDvxCCOnveCW8xtd38RJVBPKcQkoDmmcVnGJGlou/AArDM
	vDd4yZEkUcBbmxB9DPalDD6icxeP1SwAJXO78BEsP+ZfEAKY5bsK1QHxoWRCKrDSJzg==
X-Gm-Gg: AZFdTZcNa0JRZlUa9H2s1/lsoYFMzj4GybRRDfjAYgQVQkja+q5uTzATVX0d2OUA4Q9
	W3ifNO0SvnBWC8pcPKNr+RqTNzjM34sRjYm/KH98WbrXs3N3jZ1+1SMPTqCngIn/7HydSHJECym
	C5AiZGfaZHsi1OwHTMqs7kFTCJpEIP+qzf6qD87xeEmXCasCcypzib9K0U3TMFvRbfbAV4Z9O6V
	2Pg0ST7lDnbHjxZgRa0ML3a0AQ2tn8R+oQUO9XOLpNkpIrAMrK2YRsvadC5m/HhI8sgEIa+4KF1
	fx1V4AtzAg8zXPnXVu14DoJxgnf+A0DlCP+fbaAXtu737Nf1B03NULWFxkbu3bhlL701DSW/F7/
	x5NYfIz2WISkPT01Wq7hfuDf3/qvg2pC/FhuuMGtYsMhN+PUgD9C97mMWqoTPylf4hvLoEyv/cp
	sJVk/O03pW08c=
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr333572225e9.10.1795522906512;
        Tue, 24 Nov 2026 04:21:46 -0800 (PST)
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr333570985e9.10.1795522905720;
        Tue, 24 Nov 2026 04:21:45 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:45 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:26 +0100
Subject: [PATCH RFC v4 8/8] vsock: add datagram tests to vsock_test
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
Message-Id: <20261124-vsock-dgram-support-v4-8-3607484e85e8@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=59224; i=slp@redhat.com;
 h=from:subject:message-id; bh=4uDWWCEgemPmUZH9AsdJq8NKEW+nbALEf8Iez4W4kGo=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFJ92qxPuGLB9+SxD5wVVtBBKgqxIelJq85c
 mQs1ouenhSJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBSQAKCRD0aSeNLwwC
 NbZ7D/wP/04oSgT1DeUmqeFKP/71VMMGd/mBIcMYGHAKzfdhU/xZ6JHf+M7tK5i7IeOWmSCeNeV
 BCnx2aDwwMM6pPStZSok2fiVNe498K6O8cLMpwF0VzYutwhLABeaSLr2LpmNZntJ+7vlDVR9MGc
 ZwY5MkZyznHmpJQPEDgsaNx3oIlBAKuYVeqgvW6FokGtjp7ULR2gMTtUTsCAApDsYGMCkaMTw6u
 a/6xcF7Qc2krWLc8FRATEFUZZx5eyPweWJN4H3F3IZ37HQL/NCaWaYTSfn3JWAIuYryloNwr0Vi
 7WQ2P+DXkHZGfUHRyURH1rmCQHPc3LO14PfJRWiKVo3vO15w5q9ZPXwQBA7I3p8xkd9UMJMajbY
 Rksjdtb0VrDiyS0XHI3sCfT9ojb9VeLhl1S5oKvg94wR6cxjaBTGnUJtPYWL/j9EVzHV7f1DE83
 oDyndwwmkglxgAnzdQQcscDiXGc/nabLXhsCIuCXea6CfSJa7uKvfSVHLlN6yUMDQuft9LW9wgK
 KW2zVge7UjeOXibYWtu9e2vWec436v1pBAfnGOC1/qRKlJcvWq8mv+cagW36x70V0ZLi2MxqWjR
 jsdz7ORDQCjZop5gzcy/GyyPWFXuT+rpRqLqHoHcHFMFd9M5jGQKztW016wxcUw4TzKrCPBCtUt
 Nx7Fz2Xet6i+zMw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Cover local semantics, host/guest transfers, routing and queue
accounting. Synchronize capability-based skips and document manual
checks.

Probe VMCI and virtio/vhost independently for capability skips. VMCI can
own a datagram socket while a directional transport serves its peer.
Most local cases require loopback; they work without a directional
transport. The VMCI queue-length case skips when loopback would take
self-CID traffic, so a passing result exercises VMCI receive
accounting. Document this coexistence in the README.

Distinguish VMCI module presence from a usable self-send route. A
local-mode namespace may have a VMCI-owned datagram socket while VMCI
rejects its self-send. Module presence alone would run the queue-length
test and fail. With loopback absent, probe a wildcard datagram connect
before enabling that test. Keep the module check for the no-loopback
directional case, which must still exclude VMCI-owned sockets. On a
QEMU VMCI host personality, the queue-length case passes in global
mode and skips in local mode; with loopback loaded, both modes retain
the existing loopback skip.

Exercise VMCI host datagram routes to CID_HOST and CID_ANY, including a
connected wildcard send from an explicitly VMCI-CID-bound socket. This
case runs in a global namespace with the VMCI host context, whether or
not loopback is loaded. Update the README case IDs accordingly.

Test that connected loopback datagrams reject a different local CID at
the same port, including after write shutdown, and that wildcard senders
use the addressed CID and receive replies.

Add a delayed-read burst in both directions. Send 16 distinct 512-byte
datagrams before the receiver reads, with a bounded SO_RCVBUF. Check
message content and source address and verify no extra packet remains.

Test that datagrams and stream/SEQPACKET sockets can bind the same CID
and port in both orders, including wildcard CIDs, and that each receives
only its own traffic. Stream and SEQPACKET binds must still conflict.

Loopback rejects SEQPACKET connections in local-mode network namespaces.
Skip only the SEQPACKET iterations of the connected-lookup and shared-port
tests there, retaining their stream checks. Both tests pass in local and
global namespaces; the global runs still exercise SEQPACKET.

Peek twice at an empty datagram, both alone and with a later message
queued, to ensure MSG_PEEK does not skip it.

Add a no-loopback datagram case for CID_LOCAL and wildcard sends and
connects, plus connect to the guest's numeric own CID. It requires a
guest with negotiated virtio datagrams and skips when VMCI is present.
Run it with g2h_fallback enabled to check self-connect rejection. Keep
it last to preserve existing test IDs and document the configuration
in the README.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 tools/testing/vsock/Makefile           |    3 +-
 tools/testing/vsock/README             |   42 +-
 tools/testing/vsock/util.c             |   62 +-
 tools/testing/vsock/util.h             |   10 +
 tools/testing/vsock/vsock_test.c       |  189 ++++-
 tools/testing/vsock/vsock_test_dgram.c | 1230 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h |   34 +
 7 files changed, 1538 insertions(+), 32 deletions(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 88211fd132d2..78e2cb7b1193 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 all: test vsock_perf
 test: vsock_test vsock_diag_test vsock_uring_test
-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o
+vsock_test: vsock_test.o vsock_test_zerocopy.o vsock_test_dgram.o \
+	    timeout.o control.o util.o msg_zerocopy_common.o
 vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
 vsock_perf: vsock_perf.o msg_zerocopy_common.o
 
diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
index 680ce666ceb5..e525b80fcb67 100644
--- a/tools/testing/vsock/README
+++ b/tools/testing/vsock/README
@@ -5,7 +5,7 @@ Hyper-V.
 
 The following tests are available:
 
-  * vsock_test - core AF_VSOCK socket functionality
+  * vsock_test - stream, seqpacket and datagram functionality
   * vsock_diag_test - vsock_diag.ko module for listing open sockets
 
 The following prerequisite steps are not automated and must be performed prior
@@ -32,7 +32,7 @@ Invoke test binaries in both directions as follows:
                         --control-port=1234 \
                         --peer-cid=2
   (host)# $TEST_BINARY --mode=client \
-                       --control-port=$GUEST_IP \
+                       --control-host=$GUEST_IP \
                        --control-port=1234 \
                        --peer-cid=3
 
@@ -51,6 +51,44 @@ suite run, e.g.
 
 For more information see Documentation/dev-tools/kmemleak.rst.
 
+Datagram tests
+--------------
+vsock_test includes datagram cases in the client/server runs above. Unsupported
+cases print a skip reason.
+
+Virtio/vhost datagrams require kernel support on both sides and a VMM that
+negotiates VIRTIO_VSOCK_F_DGRAM. Load vsock_loopback on both host and guest for
+the ordinary local cases. Make /dev/vsock and a mounted sysfs available. The
+guest probe reads the negotiated virtio features from sysfs before running peer
+cases. VMCI's dedicated datagram transport can coexist with virtio/vhost: it
+owns the datagram endpoint while negotiated directional routes can serve
+individual destinations.
+
+Run only the local datagram cases without a peer or TCP control connection:
+
+  ./vsock_test --local
+
+Use --list and --pick <test_id> to select individual cases. The BPF admission
+test (51, requiring BPF privileges) and nested routing test (52, requiring both
+virtio and vhost transports) need explicit selection. The VMCI queue-length
+test (56) requires VMCI without vsock_loopback, so self-directed traffic uses
+VMCI rather than loopback. It skips when VMCI self-send is unavailable in the
+current vsock namespace.
+The VMCI host route test (57) checks CID_HOST and CID_ANY in a global namespace
+with or without loopback.
+The connected loopback peer test (58) checks same-port senders on different
+local CIDs and wildcard source addresses.
+The delayed-read burst test (59) queues 16 datagrams under a bounded receive
+buffer in each direction before the receiver reads them.
+The port-space test (60) binds a datagram and a stream or seqpacket listener
+to the same CID and port in both orders, then checks delivery to both sockets.
+In a local-mode network namespace, this test and the connected lookup test (50)
+run their stream iterations only; loopback rejects seqpacket connections there.
+The no-loopback route test (61) requires negotiated virtio datagrams in the
+guest, no VMCI fallback, and vsock_loopback unloaded. Run it with
+net.vsock.g2h_fallback=1 to check that CID_LOCAL, CID_ANY, and the guest's
+numeric CID are still rejected.
+
 vsock_perf utility
 -------------------
 'vsock_perf' is a simple tool to measure vsock performance. It works in
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 299a4e8ecb63..6ad97403697f 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -499,47 +499,55 @@ void run_tests(const struct test_case *test_cases,
 	int i;
 
 	for (i = 0; test_cases[i].name; i++) {
+		const struct test_case *test = &test_cases[i];
 		void (*run)(const struct test_opts *opts);
+		const char *reason;
 		char *line;
 
-		printf("%d - %s...", i, test_cases[i].name);
+		if (opts->local && !test->local)
+			continue;
+		printf("%d - %s...", i, test->name);
 		fflush(stdout);
 
-		/* Full barrier before executing the next test.  This
-		 * ensures that client and server are executing the
-		 * same test case.  In particular, it means whoever is
-		 * faster will not see the peer still executing the
-		 * last test.  This is important because port numbers
-		 * can be used by multiple test cases.
-		 */
-		if (test_cases[i].skip)
-			control_writeln("SKIP");
-		else
-			control_writeln("NEXT");
-
-		line = control_readln();
-		if (control_cmpln(line, "SKIP", false) || test_cases[i].skip) {
-
-			printf("skipped\n");
-
+		if (opts->local) {
+			if (test->skip) {
+				printf("skipped\n");
+				continue;
+			}
+		} else {
+			/* Agree on explicit selection before any capability check
+			 * or test can exchange messages on the control connection.
+			 */
+			control_writeln(test->skip ? "SKIP" : "NEXT");
+			line = control_readln();
+			if (control_cmpln(line, "SKIP", false) || test->skip) {
+				printf("skipped\n");
+				free(line);
+				continue;
+			}
+			control_cmpln(line, "NEXT", true);
 			free(line);
-			continue;
 		}
 
-		control_cmpln(line, "NEXT", true);
-		free(line);
-
-		if (opts->mode == TEST_MODE_CLIENT)
-			run = test_cases[i].run_client;
+		if (test->check) {
+			reason = test->check(opts);
+			if (reason) {
+				printf("skipped: %s\n", reason);
+				continue;
+			}
+		}
+		if (opts->local || opts->mode == TEST_MODE_CLIENT)
+			run = test->run_client;
 		else
-			run = test_cases[i].run_server;
-
+			run = test->run_server;
 		if (run)
 			run(opts);
-
 		printf("ok\n");
 	}
 
+	if (opts->local)
+		return;
+
 	printf("All tests have been executed. Waiting other peer...");
 	fflush(stdout);
 
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 9dabb547021e..e23290e7dcc6 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -51,6 +51,10 @@ struct test_opts {
 	enum test_mode mode;
 	unsigned int peer_cid;
 	unsigned int peer_port;
+	unsigned int bind_cid;
+	bool local;
+	bool to_host;
+	bool expect_to_host;
 };
 
 /* A test case definition.  Test functions must print failures to stderr and
@@ -66,6 +70,12 @@ struct test_case {
 	void (*run_server)(const struct test_opts *opts);
 
 	bool skip;
+	bool local; /* Can run without a control connection */
+
+	/* Return a skip reason or NULL after the selection barrier. Checks
+	 * that coordinate over the control channel must agree on both peers.
+	 */
+	const char *(*check)(const struct test_opts *opts);
 };
 
 void init_signals(void);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 10b9074fb87f..9ce4253c0262 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -27,6 +27,7 @@
 #include <linux/sockios.h>
 
 #include "vsock_test_zerocopy.h"
+#include "vsock_test_dgram.h"
 #include "timeout.h"
 #include "control.h"
 #include "util.h"
@@ -2912,6 +2913,130 @@ static struct test_case test_cases[] = {
 		.name = "SO_INQ option validation",
 		.run_client = test_so_inq_validation_client,
 	},
+	{
+		.name = "SOCK_DGRAM autobind, duplicate bind and wildcard destination",
+		.run_client = test_dgram_bind,
+		.run_server = test_dgram_bind,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM queue ioctls, poll, peek, truncation and empty messages",
+		.run_client = test_dgram_receive,
+		.run_server = test_dgram_receive,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM unsupported receive flags preserve normal data",
+		.run_client = test_dgram_receive_flags,
+		.run_server = test_dgram_receive_flags,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM socket filter trims receive length",
+		.run_client = test_dgram_filter,
+		.run_server = test_dgram_filter,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM connect, disconnect and shutdown peer filtering",
+		.run_client = test_dgram_connect,
+		.run_server = test_dgram_connect,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM explicit loopback source CIDs and reply addresses",
+		.run_client = test_dgram_source_cid,
+		.run_server = test_dgram_source_cid,
+		.check = vsock_dgram_check_local_cid,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM connected stream/seqpacket cannot shadow datagrams",
+		.run_client = test_dgram_bound_lookup,
+		.run_server = test_dgram_bound_lookup,
+		.check = vsock_dgram_check_local_cid,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM sockmap and sockhash reject datagrams (BPF privileges)",
+		.run_client = test_dgram_sockmap,
+		.run_server = test_dgram_sockmap,
+		.skip = true,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM nested CID_HOST loopback rejection (nested VM only)",
+		.run_client = test_dgram_nested_source,
+		.run_server = test_dgram_nested_source,
+		.skip = true,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM bidirectional sizes, 64 KiB boundaries and RX refill",
+		.run_client = test_dgram_sizes,
+		.run_server = test_dgram_sizes,
+		.check = vsock_dgram_check_peer,
+	},
+	{
+		.name = "SOCK_DGRAM connected socket alternates loopback and peer routes",
+		.run_client = test_dgram_routes,
+		.run_server = test_dgram_routes,
+		.check = vsock_dgram_check_routes,
+	},
+	{
+		.name = "SOCK_DGRAM peer filtering and disconnect across transports",
+		.run_client = test_dgram_peer_filter,
+		.run_server = test_dgram_peer_filter,
+		.check = vsock_dgram_check_peer,
+	},
+	{
+		.name = "SOCK_DGRAM VMCI ioctl(SIOCINQ) payload length",
+		.run_client = test_dgram_vmci_inq,
+		.run_server = test_dgram_vmci_inq,
+		.check = vsock_dgram_check_vmci,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM VMCI host CID_HOST and CID_ANY routes",
+		.run_client = test_dgram_vmci_host_routes,
+		.run_server = test_dgram_vmci_host_routes,
+		.check = vsock_dgram_check_vmci_host,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM connected loopback filters same-port CIDs",
+		.run_client = test_dgram_connected_cid,
+		.run_server = test_dgram_connected_cid,
+		.check = vsock_dgram_check_local_cid,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM delayed-read burst with bounded receive memory",
+		.run_client = test_dgram_burst,
+		.run_server = test_dgram_burst,
+		.check = vsock_dgram_check_peer,
+	},
+	{
+		.name = "SOCK_DGRAM shares port number with stream and seqpacket",
+		.run_client = test_dgram_port_space,
+		.run_server = test_dgram_port_space,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM CID_LOCAL and wildcard need loopback",
+		.run_client = test_dgram_no_loopback,
+		.run_server = test_dgram_no_loopback,
+		.check = vsock_dgram_check_no_loopback,
+		.local = true,
+	},
 	{},
 };
 
@@ -2957,6 +3082,26 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 't',
 	},
+	{
+		.name = "local",
+		.has_arg = no_argument,
+		.val = 'L',
+	},
+	{
+		.name = "bind-cid",
+		.has_arg = required_argument,
+		.val = 'b',
+	},
+	{
+		.name = "to-host",
+		.has_arg = no_argument,
+		.val = 'T',
+	},
+	{
+		.name = "expect-to-host",
+		.has_arg = no_argument,
+		.val = 'E',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -2972,8 +3117,10 @@ static void usage(void)
 		"  Server: vsock_test --control-port=1234 --mode=server --peer-cid=3\n"
 		"  Client: vsock_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
 		"\n"
-		"Run vsock.ko tests.  Must be launched in both guest\n"
-		"and host.  One side must use --mode=client and\n"
+		"  Local: vsock_test --local [--pick=<test_id>]\n"
+		"\n"
+		"Run vsock.ko tests. Paired tests must be launched in both guest\n"
+		"and host. One side must use --mode=client and\n"
 		"the other side must use --mode=server.\n"
 		"\n"
 		"A TCP control socket connection is used to coordinate tests\n"
@@ -2986,8 +3133,14 @@ static void usage(void)
 		"specified with --peer-port=<port> (or the default port)\n"
 		"and the next one.\n"
 		"\n"
+		"--local runs local datagram cases without a control connection.\n"
+		"\n"
 		"Options:\n"
 		"  --help                 This help message\n"
+		"  --local                Run local datagram cases without a peer\n"
+		"  --bind-cid <cid>       Source CID for peer datagram tests [default: ANY]\n"
+		"  --to-host              Route peer datagrams through the frontend\n"
+		"  --expect-to-host       Expect the upstream datagram source flag\n"
 		"  --control-host <host>  Server IP address to connect to\n"
 		"  --control-port <port>  Server port to listen on/connect to\n"
 		"  --mode client|server   Server or client mode\n"
@@ -3011,7 +3164,10 @@ int main(int argc, char **argv)
 		.mode = TEST_MODE_UNSET,
 		.peer_cid = VMADDR_CID_ANY,
 		.peer_port = DEFAULT_PEER_PORT,
+		.bind_cid = VMADDR_CID_ANY,
 	};
+	bool picked = false;
+	size_t i;
 
 	srand(time(NULL));
 	init_signals();
@@ -3023,6 +3179,18 @@ int main(int argc, char **argv)
 			break;
 
 		switch (opt) {
+		case 'L':
+			opts.local = true;
+			break;
+		case 'b':
+			opts.bind_cid = parse_cid(optarg);
+			break;
+		case 'T':
+			opts.to_host = true;
+			break;
+		case 'E':
+			opts.expect_to_host = true;
+			break;
 		case 'H':
 			control_host = optarg;
 			break;
@@ -3055,6 +3223,7 @@ int main(int argc, char **argv)
 		case 't':
 			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
 				  optarg);
+			picked = true;
 			break;
 		case '?':
 		default:
@@ -3062,6 +3231,22 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (optind != argc)
+		usage();
+	if (opts.local) {
+		if (opts.mode != TEST_MODE_UNSET || control_host || control_port)
+			usage();
+		if (picked) {
+			for (i = 0; test_cases[i].name; i++) {
+				if (!test_cases[i].skip && !test_cases[i].local) {
+					fprintf(stderr, "test %zu requires paired mode\n", i);
+					exit(EXIT_FAILURE);
+				}
+			}
+		}
+		run_tests(test_cases, &opts);
+		return EXIT_SUCCESS;
+	}
 	if (!control_port)
 		usage();
 	if (opts.mode == TEST_MODE_UNSET)
diff --git a/tools/testing/vsock/vsock_test_dgram.c b/tools/testing/vsock/vsock_test_dgram.c
new file mode 100644
index 000000000000..16c3a6e59f79
--- /dev/null
+++ b/tools/testing/vsock/vsock_test_dgram.c
@@ -0,0 +1,1230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Datagram feature tests for vsock. */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <glob.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <linux/sockios.h>
+#include <linux/virtio_vsock.h>
+#include <poll.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "control.h"
+#include "timeout.h"
+#include "vsock_test_dgram.h"
+
+#define MAX_DGRAM (64 * 1024)
+
+static void fail(const char *fmt, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "\nFAIL: ");
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	exit(EXIT_FAILURE);
+}
+
+static void check(int ret, const char *operation)
+{
+	if (ret < 0)
+		fail("%s: %s", operation, strerror(errno));
+}
+
+static void expect_error(ssize_t ret, int error, const char *operation)
+{
+	if (ret != -1 || errno != error)
+		fail("%s: expected %s, got %zd (%s)", operation,
+		     strerror(error), ret, ret == -1 ? strerror(errno) : "success");
+}
+
+static int64_t now_ms(void)
+{
+	struct timespec ts;
+
+	check(clock_gettime(CLOCK_MONOTONIC, &ts), "clock_gettime");
+	return (int64_t)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+static short poll_fd(int fd, short events, int milliseconds)
+{
+	struct pollfd pfd = { .fd = fd, .events = events };
+	int ret;
+
+	do {
+		ret = poll(&pfd, 1, milliseconds);
+	} while (ret < 0 && errno == EINTR);
+	check(ret, "poll");
+	if (pfd.revents & (POLLERR | POLLNVAL))
+		fail("unexpected poll events %#x", pfd.revents);
+	return pfd.revents;
+}
+
+static void wait_readable(int fd)
+{
+	if (!(poll_fd(fd, POLLIN, TIMEOUT * 1000) & POLLIN))
+		fail("waiting for socket readability timed out");
+}
+
+static struct sockaddr_vm address(unsigned int cid, unsigned int port)
+{
+	return (struct sockaddr_vm) {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = port,
+	};
+}
+
+static struct sockaddr_vm sock_name(int fd, bool peer)
+{
+	struct sockaddr_vm addr;
+	socklen_t len = sizeof(addr);
+	int ret;
+
+	if (peer)
+		ret = getpeername(fd, (struct sockaddr *)&addr, &len);
+	else
+		ret = getsockname(fd, (struct sockaddr *)&addr, &len);
+	check(ret, peer ? "getpeername" : "getsockname");
+	if (len != sizeof(addr) || addr.svm_family != AF_VSOCK)
+		fail("invalid socket address");
+	return addr;
+}
+
+static unsigned int local_cid(void)
+{
+	unsigned int cid;
+	int fd;
+
+	fd = open("/dev/vsock", O_RDONLY | O_CLOEXEC);
+	check(fd, "open /dev/vsock");
+	check(ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid), "get local CID");
+	close(fd);
+	if (cid == VMADDR_CID_ANY || cid <= VMADDR_CID_LOCAL)
+		fail("a virtio or vhost transport is required (local CID %u)", cid);
+	return cid;
+}
+
+static void bind_fd(int fd, unsigned int cid, unsigned int port)
+{
+	struct sockaddr_vm addr = address(cid, port);
+
+	check(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), "bind");
+}
+
+static int dgram_socket(void)
+{
+	int fd = socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+	int rcvbuf = 1024 * 1024;
+
+	check(fd, "socket(AF_VSOCK, SOCK_DGRAM): check transport/feature support");
+	check(setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf)), "SO_RCVBUF");
+	return fd;
+}
+
+enum dgram_capability {
+	DGRAM_SOCKET = 1 << 0,
+	DGRAM_VIRTIO = 1 << 1,
+	DGRAM_VMCI_MODULE = 1 << 2,
+	DGRAM_LOOPBACK = 1 << 3,
+	DGRAM_PEER = 1 << 4,
+	DGRAM_CID = 1 << 5,
+	DGRAM_VMCI_SELF = 1 << 6,
+};
+
+static bool dgram_unavailable(int error)
+{
+	return error == EAFNOSUPPORT || error == EPROTONOSUPPORT ||
+	       error == ESOCKTNOSUPPORT || error == ENODEV;
+}
+
+static bool virtio_dgram_negotiated(void)
+{
+	glob_t paths = { 0 };
+	bool found = false;
+	size_t i;
+
+	if (glob("/sys/bus/virtio/drivers/vmw_vsock_virtio_transport/virtio*/features",
+		  0, NULL, &paths))
+		return false;
+
+	for (i = 0; i < paths.gl_pathc; i++) {
+		char features[VIRTIO_VSOCK_F_DGRAM + 2];
+		FILE *file = fopen(paths.gl_pathv[i], "r");
+
+		if (!file)
+			continue;
+		if (fread(features, 1, sizeof(features), file) == sizeof(features) &&
+		    features[VIRTIO_VSOCK_F_DGRAM] == '1')
+			found = true;
+		fclose(file);
+		if (found)
+			break;
+	}
+	globfree(&paths);
+	return found;
+}
+
+static bool usable_local_cid(void)
+{
+	unsigned int cid;
+	int fd, ret;
+
+	fd = open("/dev/vsock", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+	ret = ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid);
+	close(fd);
+	return ret == 0 && cid != VMADDR_CID_ANY && cid > VMADDR_CID_LOCAL;
+}
+
+static bool vmci_self_route(void)
+{
+	struct sockaddr_vm peer = address(VMADDR_CID_ANY, 12345);
+	bool available;
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return false;
+	/* Without loopback, CID_ANY selects the VMCI owner's local CID. */
+	available = !connect(fd, (struct sockaddr *)&peer, sizeof(peer));
+	close(fd);
+	return available;
+}
+
+static unsigned int dgram_capabilities(const struct test_opts *opts,
+				       unsigned int needs)
+{
+	unsigned int caps = DGRAM_SOCKET;
+	struct sockaddr_vm peer;
+	int fd, local_fd;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+	if (fd < 0) {
+		if (dgram_unavailable(errno))
+			return 0;
+		check(fd, "probe datagram socket");
+	}
+	/* VMCI may own the socket while a directional transport serves peers.
+	 * A nested guest can have both virtio and vhost registered. Probe the
+	 * requested direction so vhost registration cannot mask a virtio device
+	 * that did not negotiate datagrams.
+	 */
+	if (!access("/sys/module/vmw_vsock_vmci_transport", F_OK))
+		caps |= DGRAM_VMCI_MODULE;
+	if (opts->to_host || opts->peer_cid <= VMADDR_CID_HOST) {
+		if (virtio_dgram_negotiated())
+			caps |= DGRAM_VIRTIO;
+	} else if (!access("/sys/class/misc/vhost-vsock", F_OK)) {
+		caps |= DGRAM_VIRTIO;
+	}
+	if ((needs & DGRAM_CID) && usable_local_cid())
+		caps |= DGRAM_CID;
+
+	if ((needs & DGRAM_PEER) && (caps & DGRAM_VIRTIO)) {
+		bind_fd(fd, opts->bind_cid, VMADDR_PORT_ANY);
+		peer = address(opts->peer_cid, opts->peer_port);
+		if (opts->to_host)
+			peer.svm_flags = VMADDR_FLAG_TO_HOST;
+		if (!connect(fd, (struct sockaddr *)&peer, sizeof(peer)))
+			caps |= DGRAM_PEER;
+		else if (!dgram_unavailable(errno) && errno != EINVAL)
+			check(-1, "probe peer datagram route");
+	}
+	close(fd);
+
+	if (needs & DGRAM_LOOPBACK) {
+		/* Binding a stream socket to CID_LOCAL probes registration of
+		 * the loopback transport without sending a packet to the host.
+		 */
+		local_fd = vsock_bind_try(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_STREAM);
+		if (local_fd >= 0) {
+			caps |= DGRAM_LOOPBACK;
+			close(local_fd);
+		} else if (errno != EADDRNOTAVAIL) {
+			check(local_fd, "probe loopback transport");
+		}
+	}
+	/* A local namespace can have a VMCI-owned socket without a usable
+	 * VMCI datagram handle. Keep that distinct from module presence.
+	 */
+	if ((needs & DGRAM_VMCI_SELF) && (caps & DGRAM_VMCI_MODULE) &&
+	    !(caps & DGRAM_LOOPBACK) && vmci_self_route())
+		caps |= DGRAM_VMCI_SELF;
+	return caps;
+}
+
+static const char *dgram_check(const struct test_opts *opts, unsigned int needs)
+{
+	unsigned int probe = needs;
+	unsigned int local, both, either;
+
+	/* A VMCI self-send uses loopback when it is registered. */
+	if (needs & DGRAM_VMCI_MODULE)
+		probe |= DGRAM_LOOPBACK;
+	local = dgram_capabilities(opts, probe);
+	both = local;
+	either = local;
+
+	/* run_tests() has already synchronized explicit --pick/--skip
+	 * selection. Both peers can now safely exchange capabilities.
+	 */
+	if (!opts->local) {
+		unsigned int peer;
+
+		control_writeulong(local);
+		peer = control_readulong();
+		both &= peer;
+		either |= peer;
+	}
+	if (!(both & DGRAM_SOCKET))
+		return local & DGRAM_SOCKET ?
+			"datagrams unavailable at peer" : "datagrams unavailable locally";
+	if ((needs & DGRAM_VIRTIO) && !(both & DGRAM_VIRTIO))
+		return "requires virtio/vhost datagram transports on both peers";
+	if ((needs & DGRAM_VMCI_MODULE) && !(both & DGRAM_VMCI_MODULE))
+		return "requires VMCI datagram transports on both peers";
+	if ((needs & DGRAM_VMCI_MODULE) && (either & DGRAM_LOOPBACK))
+		return "unload vsock_loopback to exercise VMCI datagram receive";
+	if ((needs & DGRAM_VMCI_SELF) && !(both & DGRAM_VMCI_SELF))
+		return "VMCI self-send route unavailable";
+	if ((needs & DGRAM_LOOPBACK) && !(both & DGRAM_LOOPBACK))
+		return "load vsock_loopback on both peers";
+	if ((needs & DGRAM_CID) && !(both & DGRAM_CID))
+		return "requires a numeric local CID beyond CID_LOCAL";
+	if ((needs & DGRAM_PEER) && !(both & DGRAM_PEER))
+		return "peer route does not support datagrams";
+	return NULL;
+}
+
+const char *vsock_dgram_check_local(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_LOOPBACK);
+}
+
+const char *vsock_dgram_check_local_cid(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_LOOPBACK | DGRAM_CID);
+}
+
+const char *vsock_dgram_check_no_loopback(const struct test_opts *opts)
+{
+	unsigned int caps = dgram_capabilities(opts, DGRAM_LOOPBACK);
+
+	if (!(caps & DGRAM_SOCKET))
+		return "datagrams unavailable locally";
+	if (!virtio_dgram_negotiated())
+		return "requires negotiated virtio guest datagrams";
+	if (caps & DGRAM_VMCI_MODULE)
+		return "unload VMCI to exercise directional datagram routing";
+	if (caps & DGRAM_LOOPBACK)
+		return "unload vsock_loopback";
+	return NULL;
+}
+
+const char *vsock_dgram_check_peer(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VIRTIO | DGRAM_PEER);
+}
+
+const char *vsock_dgram_check_routes(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VIRTIO | DGRAM_PEER | DGRAM_LOOPBACK);
+}
+
+const char *vsock_dgram_check_vmci(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VMCI_MODULE | DGRAM_VMCI_SELF);
+}
+
+const char *vsock_dgram_check_vmci_host(const struct test_opts *opts)
+{
+	unsigned int caps = dgram_capabilities(opts, 0);
+	unsigned int cid;
+	char mode[16];
+	FILE *file;
+	int fd;
+
+	if (!(caps & DGRAM_SOCKET))
+		return "datagrams unavailable locally";
+	if (!(caps & DGRAM_VMCI_MODULE))
+		return "requires VMCI datagram transport";
+
+	file = fopen("/proc/sys/net/vsock/ns_mode", "r");
+	if (!file)
+		return "requires a mounted vsock namespace sysctl";
+	if (!fgets(mode, sizeof(mode), file)) {
+		fclose(file);
+		return "cannot read vsock namespace mode";
+	}
+	fclose(file);
+	if (strncmp(mode, "global", 6))
+		return "requires a global vsock namespace";
+
+	fd = open("/dev/vsock", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return "cannot open /dev/vsock";
+	if (ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid)) {
+		close(fd);
+		return "cannot read local CID";
+	}
+	close(fd);
+	if (cid != VMADDR_CID_HOST)
+		return "requires VMCI host CID without an active guest CID";
+	return NULL;
+}
+
+static int bound_socket(unsigned int cid)
+{
+	int fd = dgram_socket();
+
+	bind_fd(fd, cid, VMADDR_PORT_ANY);
+	return fd;
+}
+
+static struct sockaddr_vm local_address(int fd)
+{
+	struct sockaddr_vm addr = sock_name(fd, false);
+
+	addr.svm_cid = VMADDR_CID_LOCAL;
+	return addr;
+}
+
+static void connect_fd(int fd, const struct sockaddr_vm *addr)
+{
+	check(connect(fd, (const struct sockaddr *)addr, sizeof(*addr)), "connect");
+}
+
+static void disconnect_fd(int fd)
+{
+	struct sockaddr_vm addr = { .svm_family = AF_UNSPEC };
+	socklen_t len = sizeof(addr);
+
+	check(connect(fd, (struct sockaddr *)&addr, sizeof(addr)), "disconnect");
+	expect_error(getpeername(fd, (struct sockaddr *)&addr, &len),
+		     ENOTCONN, "getpeername after disconnect");
+}
+
+static int queue_bytes(int fd, unsigned long op)
+{
+	int bytes;
+
+	check(ioctl(fd, op, &bytes), "queue ioctl");
+	if (bytes < 0)
+		fail("negative queue length: %d", bytes);
+	return bytes;
+}
+
+static void expect_inq(int fd, int expected)
+{
+	int actual = queue_bytes(fd, SIOCINQ);
+
+	if (actual != expected)
+		fail("SIOCINQ: expected %d, got %d", expected, actual);
+}
+
+static void wait_sent(int fd)
+{
+	int64_t deadline = now_ms() + TIMEOUT * 1000;
+
+	while (queue_bytes(fd, SIOCOUTQ)) {
+		if (now_ms() >= deadline)
+			fail("SIOCOUTQ did not return to zero");
+		usleep(1000);
+	}
+}
+
+static void send_packet(int fd, const struct sockaddr_vm *addr,
+			const void *buf, size_t len)
+{
+	int64_t deadline = now_ms() + TIMEOUT * 1000;
+	ssize_t ret;
+
+	for (;;) {
+		ret = sendto(fd, buf, len, MSG_DONTWAIT | MSG_NOSIGNAL,
+			     (const struct sockaddr *)addr, addr ? sizeof(*addr) : 0);
+		if (ret >= 0)
+			break;
+		if (errno != EAGAIN && errno != EINTR)
+			fail("sendto(%zu bytes): %s", len, strerror(errno));
+		if (now_ms() >= deadline)
+			fail("sendto(%zu bytes) timed out", len);
+		poll_fd(fd, POLLOUT, 1);
+	}
+	if (ret != len)
+		fail("partial datagram send: %zd/%zu", ret, len);
+}
+
+static struct sockaddr_vm recv_packet(int fd, void *buf, size_t capacity,
+				      int flags, size_t expected, bool truncated)
+{
+	struct sockaddr_vm src = { 0 };
+	struct iovec iov = { .iov_base = buf, .iov_len = capacity };
+	struct msghdr msg = {
+		.msg_name = &src,
+		.msg_namelen = sizeof(src),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t ret;
+
+	wait_readable(fd);
+	ret = recvmsg(fd, &msg, flags | MSG_DONTWAIT);
+	check(ret, "recvmsg");
+	if (ret != expected || !!(msg.msg_flags & MSG_TRUNC) != truncated)
+		fail("recvmsg: expected %zu bytes, trunc=%d; got %zd, flags=%#x",
+		     expected, truncated, ret, msg.msg_flags);
+	if (msg.msg_namelen != sizeof(src) || src.svm_family != AF_VSOCK)
+		fail("invalid recvmsg source address");
+	return src;
+}
+
+static void expect_empty(int fd)
+{
+	char byte;
+
+	if (poll_fd(fd, POLLIN, 0) & POLLIN)
+		fail("unexpected queued datagram");
+	expect_error(recv(fd, &byte, 1, MSG_DONTWAIT), EAGAIN, "empty recv");
+	expect_inq(fd, 0);
+}
+
+void test_dgram_bind(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	int tx = dgram_socket();
+	int other = dgram_socket();
+	struct sockaddr_vm src;
+	char byte;
+
+	dest.svm_cid = VMADDR_CID_ANY;
+	expect_error(bind(other, (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRINUSE, "duplicate bind");
+	send_packet(tx, &dest, "A", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A' || src.svm_port != sock_name(tx, false).svm_port ||
+	    src.svm_cid != VMADDR_CID_LOCAL || src.svm_port < 1024)
+		fail("autobind or wildcard destination returned an invalid source");
+	close(rx);
+	bind_fd(other, VMADDR_CID_ANY, dest.svm_port);
+	close(other);
+	close(tx);
+}
+
+void test_dgram_receive(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	char buf[80];
+	char first[31], second[79];
+
+	memset(first, 'A', sizeof(first));
+	memset(second, 'B', sizeof(second));
+	expect_empty(rx);
+	if (!(poll_fd(tx, POLLOUT, 0) & POLLOUT))
+		fail("new socket is not writable");
+	if (queue_bytes(tx, SIOCOUTQ))
+		fail("new socket has pending output");
+	send_packet(tx, &dest, first, sizeof(first));
+	send_packet(tx, &dest, second, sizeof(second));
+	wait_readable(rx);
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, 5, MSG_PEEK, 5, true);
+	if (memcmp(buf, first, 5))
+		fail("MSG_PEEK payload mismatch");
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, 5, MSG_TRUNC, sizeof(first), true);
+	wait_readable(rx);
+	expect_inq(rx, sizeof(second));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(second), false);
+	if (memcmp(buf, second, sizeof(second)))
+		fail("datagram boundary or payload mismatch");
+	send_packet(tx, &dest, "", 0);
+	wait_readable(rx);
+	expect_inq(rx, 0);
+	recv_packet(rx, buf, sizeof(buf), MSG_PEEK, 0, false);
+	recv_packet(rx, buf, sizeof(buf), MSG_PEEK, 0, false);
+	/* Peeking must still see the empty message with a successor queued. */
+	send_packet(tx, &dest, first, sizeof(first));
+	wait_sent(tx);
+	recv_packet(rx, buf, sizeof(buf), MSG_PEEK, 0, false);
+	recv_packet(rx, buf, sizeof(buf), MSG_PEEK, 0, false);
+	recv_packet(rx, buf, sizeof(buf), 0, 0, false);
+	recv_packet(rx, buf, 0, MSG_TRUNC, sizeof(first), true);
+	expect_empty(rx);
+	wait_sent(tx);
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_receive_flags(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	const int flags[] = { MSG_OOB, MSG_ERRQUEUE };
+	char byte;
+	size_t i;
+
+	send_packet(tx, &dest, "A", 1);
+	wait_readable(rx);
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		expect_error(recv(rx, &byte, 1, flags[i] | MSG_DONTWAIT),
+			     EOPNOTSUPP, "unsupported receive flag");
+		expect_inq(rx, 1);
+	}
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A')
+		fail("unsupported flags consumed the normal packet");
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_no_loopback(const struct test_opts *opts)
+{
+	const unsigned int cids[] = { VMADDR_CID_LOCAL, VMADDR_CID_ANY };
+	struct sockaddr_vm own = address(local_cid(), VMADDR_PORT_ANY - 1);
+	size_t i;
+	int fd, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cids); i++) {
+		struct sockaddr_vm dest = address(cids[i], VMADDR_PORT_ANY - 1);
+
+		fd = dgram_socket();
+
+		expect_error(sendto(fd, "X", 1, MSG_DONTWAIT | MSG_NOSIGNAL,
+				    (struct sockaddr *)&dest, sizeof(dest)),
+			     ENODEV, "send without loopback");
+		close(fd);
+
+		fd = dgram_socket();
+		expect_error(connect(fd, (struct sockaddr *)&dest, sizeof(dest)),
+			     ENODEV, "connect without loopback");
+		close(fd);
+	}
+
+	fd = dgram_socket();
+	errno = 0;
+	ret = connect(fd, (struct sockaddr *)&own, sizeof(own));
+	if (ret != -1 || (errno != ENODEV && errno != EINVAL))
+		fail("own CID connect without loopback: got %d (%s)",
+		     ret, strerror(errno));
+	close(fd);
+}
+
+void test_dgram_vmci_inq(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = sock_name(rx, false);
+	char first[31], second[79], buf[80];
+
+	memset(first, 'A', sizeof(first));
+	memset(second, 'B', sizeof(second));
+	/* CID_ANY is resolved by the dedicated transport to its local CID. */
+	dest.svm_cid = VMADDR_CID_ANY;
+	send_packet(tx, &dest, first, sizeof(first));
+	send_packet(tx, &dest, second, sizeof(second));
+	wait_readable(rx);
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(first), false);
+	if (memcmp(buf, first, sizeof(first)))
+		fail("VMCI first payload mismatch");
+	wait_readable(rx);
+	expect_inq(rx, sizeof(second));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(second), false);
+	if (memcmp(buf, second, sizeof(second)))
+		fail("VMCI second payload mismatch");
+	send_packet(tx, &dest, "", 0);
+	wait_readable(rx);
+	expect_inq(rx, 0);
+	recv_packet(rx, buf, sizeof(buf), 0, 0, false);
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_vmci_host_routes(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_HOST);
+	int tx = bound_socket(VMADDR_CID_HOST);
+	struct sockaddr_vm dest = sock_name(rx, false);
+	struct sockaddr_vm src, peer;
+	char byte;
+
+	send_packet(tx, &dest, "H", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'H' || src.svm_cid != VMADDR_CID_HOST)
+		fail("VMCI CID_HOST route returned an unexpected datagram");
+
+	dest.svm_cid = VMADDR_CID_ANY;
+	send_packet(tx, &dest, "W", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'W' || src.svm_cid != VMADDR_CID_HOST)
+		fail("VMCI CID_ANY route returned an unexpected datagram");
+
+	connect_fd(tx, &dest);
+	peer = sock_name(tx, true);
+	if (peer.svm_cid != VMADDR_CID_HOST)
+		fail("VMCI CID_ANY connected to CID %u", peer.svm_cid);
+	send_packet(tx, NULL, "C", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'C' || src.svm_cid != VMADDR_CID_HOST)
+		fail("connected VMCI self-send returned an unexpected datagram");
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_filter(const struct test_opts *opts)
+{
+	struct sock_filter insn[] = { BPF_STMT(BPF_RET | BPF_K, 7) };
+	struct sock_fprog prog = { .len = ARRAY_SIZE(insn), .filter = insn };
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	char data[100], buf[100];
+
+	memset(data, 'F', sizeof(data));
+	check(setsockopt(rx, SOL_SOCKET, SO_ATTACH_FILTER, &prog, sizeof(prog)),
+	      "SO_ATTACH_FILTER");
+	send_packet(tx, &dest, data, sizeof(data));
+	wait_readable(rx);
+	expect_inq(rx, 7);
+	recv_packet(rx, buf, 1, MSG_PEEK | MSG_TRUNC, 7, true);
+	expect_inq(rx, 7);
+	memset(buf, 0, sizeof(buf));
+	recv_packet(rx, buf, sizeof(buf), MSG_TRUNC, 7, false);
+	if (memcmp(buf, data, 7) || buf[7])
+		fail("filtered receive copied beyond the filtered payload");
+	send_packet(tx, &dest, data, sizeof(data));
+	recv_packet(rx, buf, 1, MSG_TRUNC, 7, true);
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+static void check_peer_filter(int rx, int allowed, int stray)
+{
+	struct sockaddr_vm dest = local_address(rx);
+	char byte;
+
+	/* Both packets use the same ordered loopback worker. */
+	send_packet(stray, &dest, "B", 1);
+	send_packet(allowed, &dest, "A", 1);
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A')
+		fail("connected socket accepted a different peer");
+	expect_empty(rx);
+}
+
+void test_dgram_connect(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int allowed = bound_socket(VMADDR_CID_ANY);
+	int stray = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm peer = local_address(allowed);
+	struct sockaddr_vm dest = local_address(rx);
+	char byte;
+
+	connect_fd(rx, &peer);
+	check_peer_filter(rx, allowed, stray);
+	disconnect_fd(rx);
+	peer.svm_cid = VMADDR_CID_ANY;
+	connect_fd(rx, &peer);
+	if (sock_name(rx, true).svm_cid != VMADDR_CID_LOCAL)
+		fail("wildcard connect did not resolve to loopback");
+	check_peer_filter(rx, allowed, stray);
+	disconnect_fd(rx);
+	send_packet(stray, &dest, "B", 1);
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'B')
+		fail("disconnect did not remove peer filtering");
+	peer.svm_cid = VMADDR_CID_LOCAL;
+	connect_fd(rx, &peer);
+	check(shutdown(rx, SHUT_WR), "shutdown SHUT_WR");
+	if (poll_fd(rx, POLLOUT, 0) & POLLOUT)
+		fail("write-shutdown socket is still writable");
+	check_peer_filter(rx, allowed, stray);
+	check(shutdown(rx, SHUT_RD), "shutdown SHUT_RD");
+	if (!(poll_fd(rx, POLLIN | POLLRDHUP, 0) & POLLRDHUP))
+		fail("read shutdown did not report POLLRDHUP");
+	close(stray);
+	close(allowed);
+	close(rx);
+}
+
+static void check_connected_local_cid(unsigned int peer_cid,
+				      unsigned int stray_cid, bool shutdown_write)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int allowed = bound_socket(peer_cid);
+	int stray = dgram_socket();
+	struct sockaddr_vm peer = sock_name(allowed, false);
+	struct sockaddr_vm dest = local_address(rx);
+	struct sockaddr_vm src;
+	char byte;
+
+	bind_fd(stray, stray_cid, peer.svm_port);
+	connect_fd(rx, &peer);
+	if (shutdown_write)
+		check(shutdown(rx, SHUT_WR), "shutdown SHUT_WR");
+	/* Both sources have the connected peer's port on distinct local CIDs. */
+	send_packet(stray, &dest, "B", 1);
+	send_packet(allowed, &dest, "A", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A' || src.svm_cid != peer.svm_cid ||
+	    src.svm_port != peer.svm_port)
+		fail("connected socket accepted a different local CID");
+	expect_empty(rx);
+	close(stray);
+	close(allowed);
+	close(rx);
+}
+
+static void check_wildcard_local_cid(unsigned int cid)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm peer = address(cid, sock_name(tx, false).svm_port);
+	struct sockaddr_vm dest = address(cid, sock_name(rx, false).svm_port);
+	struct sockaddr_vm src;
+	char byte;
+
+	connect_fd(rx, &peer);
+	send_packet(tx, &dest, "W", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'W' || src.svm_cid != cid ||
+	    src.svm_port != peer.svm_port)
+		fail("wildcard loopback source did not use the addressed CID");
+	send_packet(rx, &src, "R", 1);
+	src = recv_packet(tx, &byte, 1, 0, 1, false);
+	if (byte != 'R' || src.svm_cid != cid ||
+	    src.svm_port != dest.svm_port)
+		fail("reply to wildcard loopback source failed");
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_connected_cid(const struct test_opts *opts)
+{
+	unsigned int cid = local_cid();
+
+	check_connected_local_cid(cid, VMADDR_CID_LOCAL, false);
+	check_connected_local_cid(VMADDR_CID_LOCAL, cid, false);
+	check_connected_local_cid(cid, VMADDR_CID_LOCAL, true);
+	check_wildcard_local_cid(cid);
+	check_wildcard_local_cid(VMADDR_CID_LOCAL);
+}
+
+void test_dgram_source_cid(const struct test_opts *opts)
+{
+	unsigned int cids[] = { VMADDR_CID_LOCAL, local_cid() };
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cids); i++) {
+		int rx = bound_socket(VMADDR_CID_ANY);
+		int tx = bound_socket(cids[i]);
+		struct sockaddr_vm dest = local_address(rx);
+		struct sockaddr_vm src;
+		char byte;
+
+		send_packet(tx, &dest, "A", 1);
+		src = recv_packet(rx, &byte, 1, 0, 1, false);
+		if (src.svm_cid != cids[i] || src.svm_flags ||
+		    src.svm_port != sock_name(tx, false).svm_port)
+			fail("explicit loopback source CID %u was not preserved", cids[i]);
+		send_packet(rx, &src, "R", 1);
+		recv_packet(tx, &byte, 1, 0, 1, false);
+		if (byte != 'R')
+			fail("reply to explicit source CID failed");
+		close(tx);
+		close(rx);
+	}
+}
+
+static bool local_vsock_namespace(void)
+{
+	char mode[16];
+	FILE *file;
+
+	file = fopen("/proc/sys/net/vsock/ns_mode", "r");
+	if (!file)
+		return false;
+	if (!fgets(mode, sizeof(mode), file)) {
+		fclose(file);
+		fail("cannot read vsock namespace mode");
+	}
+	fclose(file);
+	return !strncmp(mode, "local", 5);
+}
+
+void test_dgram_bound_lookup(const struct test_opts *opts)
+{
+	const int types[] = { SOCK_STREAM, SOCK_SEQPACKET };
+	bool local_mode = local_vsock_namespace();
+	unsigned int cid = local_cid();
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		struct sockaddr_vm listen_addr, src, dest;
+		int listener, stream, accepted, tx, rx;
+		char byte;
+
+		if (local_mode && types[i] == SOCK_SEQPACKET)
+			continue;
+
+		listener = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, types[i]);
+		stream = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, types[i]);
+		listen_addr = local_address(listener);
+		src = sock_name(stream, false);
+
+		check(listen(listener, 1), "listen");
+		if (vsock_connect_fd(stream, listen_addr.svm_cid, listen_addr.svm_port))
+			fail("%s loopback connect: %s",
+			     types[i] == SOCK_STREAM ? "stream" : "seqpacket", strerror(errno));
+		wait_readable(listener);
+		accepted = accept4(listener, NULL, NULL, SOCK_NONBLOCK | SOCK_CLOEXEC);
+		check(accepted, "accept");
+		if (sock_name(accepted, true).svm_cid != VMADDR_CID_LOCAL ||
+		    sock_name(accepted, true).svm_port != src.svm_port)
+			fail("unexpected accepted loopback peer");
+		close(listener);
+		rx = dgram_socket();
+		bind_fd(rx, cid, src.svm_port);
+		dest = sock_name(rx, false);
+		tx = dgram_socket();
+		/* Reuse the listener's port for the datagram source. The receive
+		 * socket uses the stream client's port at another local CID.
+		 * Connected lookup ignores the destination CID, so it would find
+		 * the stream client before the bound datagram socket.
+		 */
+		bind_fd(tx, VMADDR_CID_LOCAL, listen_addr.svm_port);
+		send_packet(tx, &dest, "D", 1);
+		recv_packet(rx, &byte, 1, 0, 1, false);
+		if (byte != 'D' || (poll_fd(stream, POLLIN, 0) & POLLIN) ||
+		    (poll_fd(accepted, POLLIN, 0) & POLLIN))
+			fail("connected socket shadowed the reused datagram port");
+		send_byte(stream, 1, 0);
+		wait_readable(accepted);
+		recv_byte(accepted, 1, 0);
+		send_byte(accepted, 1, 0);
+		wait_readable(stream);
+		recv_byte(stream, 1, 0);
+		close(tx);
+		close(rx);
+		close(accepted);
+		close(stream);
+	}
+}
+
+void test_dgram_sockmap(const struct test_opts *opts)
+{
+	const int types[] = { BPF_MAP_TYPE_SOCKMAP, BPF_MAP_TYPE_SOCKHASH };
+	int fd = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm addr = local_address(fd);
+	uint64_t value = fd;
+	uint32_t key = 0;
+	size_t i;
+
+	connect_fd(fd, &addr);
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		union bpf_attr attr = {
+			.map_type = types[i],
+			.key_size = sizeof(key),
+			.value_size = sizeof(value),
+			.max_entries = 1,
+		};
+		int map = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+
+		check(map, "BPF_MAP_CREATE (requires BPF privileges and CONFIG_BPF_SYSCALL)");
+		memset(&attr, 0, sizeof(attr));
+		attr.map_fd = map;
+		attr.key = (uintptr_t)&key;
+		attr.value = (uintptr_t)&value;
+		attr.flags = BPF_ANY;
+		expect_error(syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)),
+			     EOPNOTSUPP, "datagram sockmap admission");
+		close(map);
+	}
+	close(fd);
+}
+
+void test_dgram_nested_source(const struct test_opts *opts)
+{
+	int rx, tx;
+	struct sockaddr_vm dest;
+
+	if (local_cid() <= VMADDR_CID_HOST)
+		fail("this test requires both a guest frontend and vhost_vsock");
+	rx = bound_socket(VMADDR_CID_LOCAL);
+	tx = bound_socket(VMADDR_CID_HOST);
+	dest = local_address(rx);
+	expect_error(sendto(tx, "A", 1, MSG_NOSIGNAL,
+			    (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRNOTAVAIL, "nested CID_HOST loopback send");
+	expect_error(connect(tx, (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRNOTAVAIL, "nested CID_HOST loopback connect");
+	if (queue_bytes(tx, SIOCOUTQ))
+		fail("rejected route left pending output");
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+static int peer_socket(const struct test_opts *opts, struct sockaddr_vm *peer)
+{
+	int fd = bound_socket(opts->bind_cid);
+
+	control_writeulong(sock_name(fd, false).svm_port);
+	*peer = address(opts->peer_cid, control_readulong());
+	if (opts->to_host)
+		peer->svm_flags = VMADDR_FLAG_TO_HOST;
+	return fd;
+}
+
+static void check_source(const struct test_opts *opts,
+			 const struct sockaddr_vm *peer, const struct sockaddr_vm *src)
+{
+	bool upstream = opts->expect_to_host;
+
+	if (src->svm_cid != peer->svm_cid || src->svm_port != peer->svm_port ||
+	    src->svm_flags != (upstream ? VMADDR_FLAG_TO_HOST : 0))
+		fail("source expected %u:%u flags=%u, got %u:%u flags=%u",
+		     peer->svm_cid, peer->svm_port, upstream ? VMADDR_FLAG_TO_HOST : 0,
+		     src->svm_cid, src->svm_port, src->svm_flags);
+}
+
+static void fill_payload(char *buf, size_t len, unsigned int seed)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = (i * 131 + seed) & 0xff;
+}
+
+void test_dgram_sizes(const struct test_opts *opts)
+{
+	const size_t sizes[] = { 0, 1, 7, 255, 4095, 4096, 4097,
+				8192, 32768, 65535, MAX_DGRAM };
+	char *data = malloc(MAX_DGRAM + 1);
+	char *buf = malloc(MAX_DGRAM + 1);
+	struct sockaddr_vm peer, src;
+	unsigned int round;
+	int fd;
+	size_t i;
+
+	if (!data || !buf)
+		fail("malloc");
+	fd = peer_socket(opts, &peer);
+	fill_payload(data, MAX_DGRAM + 1, 0);
+	expect_error(sendto(fd, data, MAX_DGRAM + 1, MSG_NOSIGNAL,
+			    (struct sockaddr *)&peer, sizeof(peer)),
+		     EMSGSIZE, "oversized datagram");
+	if (queue_bytes(fd, SIOCOUTQ))
+		fail("oversized datagram left pending output");
+	/* More than a default RX ring's worth, including on small rings. */
+	for (round = 0; round < 32; round++) {
+		for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+			fill_payload(data, sizes[i], round * ARRAY_SIZE(sizes) + i);
+			if (opts->mode == TEST_MODE_CLIENT)
+				send_packet(fd, &peer, data, sizes[i]);
+			src = recv_packet(fd, buf, MAX_DGRAM + 1, 0, sizes[i], false);
+			check_source(opts, &peer, &src);
+			if (memcmp(data, buf, sizes[i]))
+				fail("payload mismatch: size %zu, round %u", sizes[i], round);
+			if (opts->mode == TEST_MODE_SERVER)
+				send_packet(fd, &src, buf, sizes[i]);
+		}
+	}
+	wait_sent(fd);
+	expect_empty(fd);
+	close(fd);
+	free(buf);
+	free(data);
+}
+
+void test_dgram_burst(const struct test_opts *opts)
+{
+	struct sockaddr_vm peer, src;
+	char data[512], buf[512];
+	int rcvbuf = 131072;
+	int fd = peer_socket(opts, &peer);
+	unsigned int phase, i;
+
+	for (phase = 0; phase < 2; phase++) {
+		bool sender = (opts->mode == TEST_MODE_CLIENT) == (phase == 0);
+
+		if (sender) {
+			control_expectln("BURST_READY");
+			for (i = 0; i < 16; i++) {
+				fill_payload(data, sizeof(data), phase * 16 + i);
+				send_packet(fd, &peer, data, sizeof(data));
+			}
+			wait_sent(fd);
+			control_writeln("BURST_DONE");
+		} else {
+			check(setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf,
+					 sizeof(rcvbuf)), "SO_RCVBUF");
+			control_writeln("BURST_READY");
+			control_expectln("BURST_DONE");
+			for (i = 0; i < 16; i++) {
+				fill_payload(data, sizeof(data), phase * 16 + i);
+				src = recv_packet(fd, buf, sizeof(buf), 0,
+						  sizeof(buf), false);
+				check_source(opts, &peer, &src);
+				if (memcmp(data, buf, sizeof(data)))
+					fail("delayed datagram %u in phase %u corrupted",
+					     i, phase);
+			}
+			expect_empty(fd);
+		}
+	}
+	close(fd);
+}
+
+void test_dgram_port_space(const struct test_opts *opts)
+{
+	const int types[] = { SOCK_STREAM, SOCK_SEQPACKET };
+	const unsigned int cids[] = { VMADDR_CID_LOCAL, VMADDR_CID_ANY };
+	bool local_mode = local_vsock_namespace();
+	size_t i, j;
+	int order;
+
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		if (local_mode && types[i] == SOCK_SEQPACKET)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(cids); j++) {
+			for (order = 0; order < 2; order++) {
+				struct sockaddr_vm bound, dest;
+				int listener, rx, tx, client, accepted, other;
+				char byte;
+
+				if (order) {
+					rx = bound_socket(cids[j]);
+					bound = sock_name(rx, false);
+					listener = vsock_bind(cids[j], bound.svm_port,
+							      types[i]);
+				} else {
+					listener = vsock_bind(cids[j], VMADDR_PORT_ANY,
+							      types[i]);
+					bound = sock_name(listener, false);
+					rx = dgram_socket();
+					bind_fd(rx, cids[j], bound.svm_port);
+				}
+
+				/* STREAM and SEQPACKET still share one port space. */
+				other = socket(AF_VSOCK,
+					       (types[i] == SOCK_STREAM ? SOCK_SEQPACKET :
+						SOCK_STREAM) | SOCK_CLOEXEC, 0);
+				check(other, "socket for connectible port collision");
+				expect_error(bind(other, (struct sockaddr *)&bound,
+						  sizeof(bound)), EADDRINUSE,
+					     "stream/seqpacket duplicate bind");
+				close(other);
+
+				check(listen(listener, 1), "listen on shared port");
+				dest = address(VMADDR_CID_LOCAL, bound.svm_port);
+				tx = dgram_socket();
+				send_packet(tx, &dest, "D", 1);
+				recv_packet(rx, &byte, 1, 0, 1, false);
+				if (byte != 'D')
+					fail("datagram lost on shared port");
+
+				client = vsock_bind(VMADDR_CID_LOCAL,
+						    VMADDR_PORT_ANY, types[i]);
+				if (vsock_connect_fd(client, VMADDR_CID_LOCAL,
+						     bound.svm_port))
+					fail("connect on shared port: %s",
+					     strerror(errno));
+				wait_readable(listener);
+				accepted = accept4(listener, NULL, NULL,
+						   SOCK_NONBLOCK | SOCK_CLOEXEC);
+				check(accepted, "accept on shared port");
+				send_byte(client, 1, 0);
+				wait_readable(accepted);
+				recv_byte(accepted, 1, 0);
+				expect_empty(rx);
+				close(accepted);
+				close(client);
+				close(tx);
+				close(rx);
+				close(listener);
+			}
+		}
+	}
+}
+
+void test_dgram_routes(const struct test_opts *opts)
+{
+	struct sockaddr_vm peer, src, stored, local;
+	int fd = peer_socket(opts, &peer);
+	int aux = bound_socket(VMADDR_CID_ANY);
+	unsigned int round;
+	char byte;
+
+	connect_fd(fd, &peer);
+	stored = sock_name(fd, true);
+	local = local_address(aux);
+	for (round = 0; round < 32; round++) {
+		send_packet(fd, &local, "L", 1);
+		recv_packet(aux, &byte, 1, 0, 1, false);
+		if (byte != 'L')
+			fail("sendto on a connected socket did not use loopback");
+		src = sock_name(fd, true);
+		if (src.svm_cid != stored.svm_cid || src.svm_port != stored.svm_port ||
+		    src.svm_flags != stored.svm_flags)
+			fail("per-message route changed the connected peer");
+		send_packet(fd, NULL, "P", 1);
+		src = recv_packet(fd, &byte, 1, 0, 1, false);
+		check_source(opts, &peer, &src);
+		if (byte != 'P')
+			fail("connected send did not retain the peer route");
+	}
+	wait_sent(fd);
+	close(aux);
+	close(fd);
+}
+
+void test_dgram_peer_filter(const struct test_opts *opts)
+{
+	struct sockaddr_vm peer, src;
+	int fd = peer_socket(opts, &peer);
+	int stray = bound_socket(opts->bind_cid);
+	char byte;
+
+	connect_fd(fd, &peer);
+	control_writeln("CONNECTED");
+	control_expectln("CONNECTED");
+	send_packet(stray, &peer, "B", 1);
+	send_packet(fd, NULL, "A", 1);
+	src = recv_packet(fd, &byte, 1, 0, 1, false);
+	check_source(opts, &peer, &src);
+	if (byte != 'A')
+		fail("connected socket accepted a different peer port");
+	disconnect_fd(fd);
+	control_writeln("DISCONNECTED");
+	control_expectln("DISCONNECTED");
+	send_packet(stray, &peer, "B", 1);
+	src = recv_packet(fd, &byte, 1, 0, 1, false);
+	if (byte != 'B' || src.svm_cid != peer.svm_cid || src.svm_port == peer.svm_port)
+		fail("disconnected socket did not accept the new peer");
+	close(stray);
+	close(fd);
+}
diff --git a/tools/testing/vsock/vsock_test_dgram.h b/tools/testing/vsock/vsock_test_dgram.h
new file mode 100644
index 000000000000..263c414da5c1
--- /dev/null
+++ b/tools/testing/vsock/vsock_test_dgram.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef VSOCK_TEST_DGRAM_H
+#define VSOCK_TEST_DGRAM_H
+
+#include "util.h"
+
+const char *vsock_dgram_check_local(const struct test_opts *opts);
+const char *vsock_dgram_check_local_cid(const struct test_opts *opts);
+const char *vsock_dgram_check_no_loopback(const struct test_opts *opts);
+const char *vsock_dgram_check_peer(const struct test_opts *opts);
+const char *vsock_dgram_check_routes(const struct test_opts *opts);
+const char *vsock_dgram_check_vmci(const struct test_opts *opts);
+const char *vsock_dgram_check_vmci_host(const struct test_opts *opts);
+
+void test_dgram_bind(const struct test_opts *opts);
+void test_dgram_receive(const struct test_opts *opts);
+void test_dgram_receive_flags(const struct test_opts *opts);
+void test_dgram_filter(const struct test_opts *opts);
+void test_dgram_connect(const struct test_opts *opts);
+void test_dgram_no_loopback(const struct test_opts *opts);
+void test_dgram_connected_cid(const struct test_opts *opts);
+void test_dgram_source_cid(const struct test_opts *opts);
+void test_dgram_bound_lookup(const struct test_opts *opts);
+void test_dgram_sockmap(const struct test_opts *opts);
+void test_dgram_nested_source(const struct test_opts *opts);
+void test_dgram_sizes(const struct test_opts *opts);
+void test_dgram_burst(const struct test_opts *opts);
+void test_dgram_port_space(const struct test_opts *opts);
+void test_dgram_routes(const struct test_opts *opts);
+void test_dgram_peer_filter(const struct test_opts *opts);
+void test_dgram_vmci_inq(const struct test_opts *opts);
+void test_dgram_vmci_host_routes(const struct test_opts *opts);
+
+#endif /* VSOCK_TEST_DGRAM_H */

-- 
2.56.0

