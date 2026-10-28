Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203498;
	b=oobNrFI6KQrn2ZUNj1q3hXKnJpymAhX/0riqHWggSvzbOJlmJvPqzil9vExBG6IAap7a
	 HADojqQ1GFMc7w3ZUMas/uTJUKE9HMy5SNoobinA2GqvQabp+S2HKnz6CEsyCku3d89jo
	 /1q/PICOGq1tYnZHUZyU4Q/PkWEQQ4wSCp5Ry4EB0QVfLp671ejK7XxIFGi1s0Lpxq55e
	 EQb1MvNG9GsmKz7hx801oNmkQ81lnPWyerKHNJ7QJItwbXH5skzRk+uEf0iwYfJn9hZZk
	 PmrPGQaBRO6U3cDGrIZp1+XMgyY3Wt61OF7Biy9ob9Fjkf2Byp2Xqtl508Mvwme0Pkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203498;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=x15QOm72T9YFY+uaBlnKqrkJrea+yHrYEI0qs7KWdmmi3ZxS05r5UUVXQxj0big+/7pR
	 7KNgMQbvT+zG852K2sYEg0PMERaswBn8vUq5hr7R5mVHpbG5p3rteJJl4xtTSRfEzV33q
	 gSusoF4qdQegADiLCX2C2C8XaH07rcSavfXb6jiCWlJQrDz+haRpJGPaEng/AzmIrboDn
	 93r5bX4LZZFoiyjpsyCiBE4wlPXlLtCot4MJO74XPWAt2db6AITcCWyE+efDuJKBTNCsp
	 gZUIKY9DGaU8ETkzpmPU1pAoz19ZP5nE3NXjXHvsTa7UPBZ581JklHyqjVLEVz0CYCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFDQtIph;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8C606A31A
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 16:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFDQtIph;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=CFDQtIphP5shKMswdqNBhqjaLSznuJmmSkblgr+3ZQ8ay65tfzQX861avvQiH+s1hCVzu0
	OQLkFNgKvEz6KKd3RmJAdnCGhFch4aQGEfgTfQxEeHUzCLSTy1vWx07hHG74FcH+9dFyrl
	N80XnpmWKAEeAM3EFn/LFJAUSSPiRRU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-WHa9BGVbM-ayOflVaoX_oA-1; Wed, 28 Oct 2026 12:04:55 -0400
X-MC-Unique: WHa9BGVbM-ayOflVaoX_oA-1
X-Mimecast-MFC-AGG-ID: WHa9BGVbM-ayOflVaoX_oA_1793203494
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4163a5400eso210767566b.1
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203494; x=1793808294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=FQm719pgpZJsJPVOMbeCVPOFeqVtgdSaQLW5q4G1+LouBGH1LcY7GWMtSHET8KPc25
         Y+sb5/01dGAOR1x7QVxz2PcMbyEwhf58dTE1WstxW7n7/lQsNFXP2rM0KQuBuXewsCDp
         Qfs5nrWFKsM7mDh7N/QkijSplTTMXuOyOXfGzCNgQ4imR1o6B/JzpySRainwLccUD7Wv
         TbIFuiRDUep1SmmI+EmeTcwniOM8xSeLhWnHSp4WnttalMp22x90G5cO1Fx5csdh2bOW
         JY3W2Q+zKsxXqVSoZZ3ryIc3/YPDF8tcErp3rH5++QE7SX1gGzf5VjuQFDsiycSNkCn0
         qzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203494; x=1793808294;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=j3QDI4Ll/JiAW9HN4E9RkJu02rF5AkBdb57frGoKld/gS5eaiEsk6+FqLdVqSMmVfh
         +4oDo+lpgNO8p2U2U2U3Jz3sy2g62eCNPfDU3Z9KoRS4CCuKViHG4Pvz9+q7MleBGZOQ
         BWE0AEWx25bqwxNmcGHnW2rk6thi3QYH5lCn0dY2ILMXzPPfO8R8BxPkzcYoXmeEnQ36
         DyMuxZjL38IGwlQMDGV2ZMgFAeZGpU5/pyi1iedlll9LzwbslVX0uHpnO6+sdbjo0XFY
         mZCjBbgPRryZsv5dLzFPRBCX+VropyIz1YRPJPYKis5BaxNvyRZBcfkicfonGRCiR3xI
         m+3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTFNBV+ChWhpWzWLooWJEXgePaI6Ib6qagFiz62qvdmlddVve4rZO4ZNe1fJo7Og50YEeRSdS2x1ECMdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL09LJtDoIFV5iRbJAQ9KmRk3xpAe7vlbzzv1x5IVnA6aVlDVom
	2mdWh7wkczdbwjk2YO4VzAXjWqyCEwIX2iGEiZjQ0PIA/2BeEQvV+k68XWxlnXUiRX2hU4+5avO
	t71KKKpGRD9ekiV7oP+8eDa074LbwM5Fbmgfz23oF550oPolqFwnNOu7mm7e5CE37sw==
X-Gm-Gg: AYBFou2qJ0wABLICOLHiYwpFYdWgAxFd86m/wYKuNgN1zc/mCfri88Qy9rMSFtVXQbm
	k8q3qNZaFIFL2GCJCcJRqkPRAoR5A1RGRTDMT3xWs/3Nkxh+b3NhOBzCCTIJ+IgU6pyCucpnPBZ
	BV1dwDGG08TAQMrZ/P2iJ8H4m6772Yd05Xl/zN02I/Uncmq+/Wvm4kUKAXWRALdyJxRwhRcTfUI
	bNo1VbjEcX4Ol1h/I21zshRZGG5kX0ZfQzA0Eq3/i1kv/OJ88SOcBuIreaNOnz/5ECj1YYQnO9s
	GdTmKX1XpUeH5++XPfeGGjHusq6nqDwVggl1C298IO13rDxZlbKd86gTTEYNfnaPUJuDif4LS0B
	1b6z13DXD/cj3sHMJmxl8OwMwnPVl3A4cW9+hKaewUEusez0+IqKmm1ElXbY0MAtUv1+I7CpGGk
	BgdgdNSxgy0oM=
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551013366b.24.1793203493681;
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551001466b.24.1793203492607;
        Wed, 28 Oct 2026 09:04:52 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:51 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
Date: Wed, 28 Oct 2026 17:04:29 +0100
Message-Id: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bLi/ORs3ZT0osRc3eLSgoL8ohJdMwvjRJNUg8TUpFRzJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAP47zmGoAAAA=
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=slp@sinrega.org;
 h=from:subject:message-id; bh=IAsDh8eAGF2GwPL8C87LSOoOWcUAY+hEvje7pI2yfrQ=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0ayuzqJP9Rcnuf3cdPX7iTWVlDw8ysZGp8Z
 wGNuM7AzKqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGgAKCRD0aSeNLwwC
 NZFHD/99IaYlGVSilyovjaYh2x2j+28+Keg9pElFi2ecT8gYqUy06MR1kFmZOrZsoqHy7pYwssH
 V4esQeAgESGZQtmvBNjEYuJ+SvP+jxLEqWzkQ7r0RzpIRxnGb+YjcYrTZu4HDNzFxBwL64Wmn02
 8ajh2a9t7wNNH/rvCNCpGt0V3zBKlQTB76xmObSCX5LfXENqL+fkV40PShUObL9gFOh6lwDQbkm
 qaHV0S7DGuhCDKFx+bOHBcI1WPuv+TVqoambXNF/El5GBreBkVoRFTzO4RaSLa2YK4yYsXjGdoN
 T4z1quggOJHvkITVGN/GItwaAFEOf6Bq8jQZ7QjAixm96Pi5OTxx/GeCmlV78mrHFPJe2gvOy/g
 WO+59N02oABNlSNaS8u+RQGwPigjgXYNDrITmaZePAtwTHi19KyDSVtI1RUhuTpM0kax/tdgUaV
 +HtPuC0HnrBXjNsU8UMvsi3soX4qOp3udDj312ClRvwBLneCo83BNxkTIImVlxCYfVCefkaaI22
 pNdV/ATqALFUZ54VVwWAVjzTvFx+1P/2plUbjAvLPEVGAWqFJGfvWF62xj2IsgkQ5AIMMZX8XBR
 /jnziV7xCe4LIWvGgd17vYzux4WMnxHqSRgiv/xLo+Ur85IEENwWIklCMJecGG/MYbEJZzl6omK
 7+lvOZABr5ugX2g==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

This series implements SOCK_DGRAM support for virtio-vsock and
vhost-vsock, allowing applications to exchange connectionless messages
through the existing AF_VSOCK datagram API.

Support is negotiated through VIRTIO_VSOCK_F_DGRAM. Each datagram uses
a single VIRTIO_VSOCK_TYPE_DGRAM packet, supporting payloads from zero
bytes through 64 KiB. Pending sends are bounded by the socket send
buffer rather than peer credits, with queue accounting and poll
readiness reflecting pending output.

Datagrams use destination-based routing across guest-to-host,
host-to-guest and loopback transports while retaining the socket's
transport state. VMCI keeps priority as the dedicated datagram
transport.  Guest RX buffers accommodate complete messages when
datagrams are negotiated, preserving message boundaries.

The patches first expose the core port allocator and add datagram
queue reporting, then implement the common data path, guest and host
feature negotiation, directional routing and RX buffer handling. The
final patch extends vsock_test with local and host/guest datagram
coverage, including peer filtering, route changes, message boundaries
and queue ioctls.  Unsupported cases skip automatically.

Tested using QEMU with a patch that exposed the VIRTIO_VSOCK_F_DGRAM
feature:

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: preserve host-to-guest datagram boundaries
      vsock: add datagram tests to vsock_test

 drivers/vhost/vsock.c                   |  37 +-
 include/linux/virtio_vsock.h            |   6 +
 include/net/af_vsock.h                  |  14 +-
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                | 206 ++++++--
 net/vmw_vsock/hyperv_transport.c        |   4 +
 net/vmw_vsock/virtio_transport.c        |  71 ++-
 net/vmw_vsock/virtio_transport_common.c | 197 +++++++-
 net/vmw_vsock/vmci_transport.c          |  10 +
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 net/vmw_vsock/vsock_loopback.c          |   1 +
 tools/testing/vsock/Makefile            |   3 +-
 tools/testing/vsock/README              |  23 +-
 tools/testing/vsock/util.c              |  62 +--
 tools/testing/vsock/util.h              |  10 +
 tools/testing/vsock/vsock_test.c        | 154 +++++-
 tools/testing/vsock/vsock_test_dgram.c  | 809 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h  |  26 +
 18 files changed, 1545 insertions(+), 93 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@sinrega.org>

