Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104411;
	b=XiOrnHzAnYovcyXRjAsN8J5KkSVZC13u96P+O17IkfxeN3GPMVaiH2CBMVSxfhlvFm62
	 RhZCkrmUlF4dayZLT0DUXzblGc0eFX5Jnp5Fufu0+/jmTiz33FPrfG8vOSq5C4hj2kHw5
	 2NJY+aViFCrS1D9TpyzQYMrc14BZZe9EoWKpG8SQKrwdlrfCu7wm/gV3bHTG+DpDPo/2t
	 lK4xjBAnXc9+y3Hlzoo7d5OnEn7VzmE0v80L3G1cxBZNzVSbjj1apFeV3hSfxBoEzm0Ki
	 jUWnz8R0jeY1P3k360tHEm8B4BtCHXfstJfVJS5dGD8dOCVjl7GtUITm0YcCt1tK9Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104411;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Dd1gd3HFQQdIECo6gd2+bO3Oskz1749IshHJlKLQ034=;
	b=smp4XfciG0hbtsLCbMvk+b6+FTvQzSxhmf7kuN47xQTsdNmIQ002BKFuz0gq1K6YTyO0
	 cozGIcUvFIMYry4LpIb5BxJnGwp+ZyCkPNfpVf8KdtFs38i3p62ICc02RI60b+kmN6vH4
	 OP9ridHxUr4nkYfXCinbRzEllI+1lW08rReR4N9URNATx3KPpIEjySS5EK6IEZ01t/rRe
	 0qh+Ad9KOMYNWPfc8iRURdBqLf11lznOBwELY816q1VBE+kZbZSW85fHB2zEy1sPYQVzh
	 hiwTCmYHjoQJOKP+gieI7FUYfbIjhFeQIPWwK8BNw0MPpHMzczg/qm8dmh/HczgDGkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W8CEMoSa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gjLDKr8h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57377606A324
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 16:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57377606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W8CEMoSa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gjLDKr8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795104409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dd1gd3HFQQdIECo6gd2+bO3Oskz1749IshHJlKLQ034=;
	b=W8CEMoSac/0OF0pYX2XaCXRvcDGZD+yWCUZA2HbdGCelxrDDaek8N/5pd7eSgtXw+bamE4
	Ybb7eF6j18shepnMchytmXlAyvG+g8JQS0lNg3CmVcUpA8eGVmS+EALfr6s5sigs3114fq
	UagJUL9N6mABZqYI/IGRYS4P7NuZZ/w=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-9Wal3VAkMWaZV63Ozy2JUQ-1; Thu, 19 Nov 2026 11:06:47 -0500
X-MC-Unique: 9Wal3VAkMWaZV63Ozy2JUQ-1
X-Mimecast-MFC-AGG-ID: 9Wal3VAkMWaZV63Ozy2JUQ_1795104407
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99be6943b20so1667377241.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 08:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795104407; cv=none;
        d=google.com; s=arc-20260327;
        b=fPrFwLB2wfIlZmMKPsuzj0sG8XRnciieId0uhkqr1ZsuFPZdJHhr2d+6ZnckREtBxb
         JC9RSngNo4itjsfLhqezoEON2C911ekfkQgJtkuOA9sHM+MbUjM3tAgP2V0Ry/lwTdvK
         1LE4Y3ZAOVvIYu4ueDqjRUARGkC+T31/zygnPgvCJDrXHtXANl+5kQJ5vaEg7MEZf5rZ
         0OjtmuHZqH6LLA1cnKomEbRwMO+y4SCEhActL2ML2/h5AfyKyWQWjS8TYeZLdPndSE00
         ow1Pf2/dlvypmI93KRNc2U4tlZPXwnO3Cj+rDIY9eFDyJtznU8HiXsR09M2wKWzwX8rC
         ZkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Dd1gd3HFQQdIECo6gd2+bO3Oskz1749IshHJlKLQ034=;
        fh=lPdD6jQhitC2nW8n2Z7ASDGQnToZ8tfOPJwLsLefZDY=;
        b=FQFMgg0hf0p4jHs/xfD0ZxboJiX9V0FL3iytWtOfF6YYSPAFtBs51JvrXXhhLXJ1MZ
         gjh71LEd07MKIy+WFkAcIhwNVT/L93Eg6m7LhgS5XvV+o6Kgp5QFunomGSRRFb/qSCzP
         JtzFbEcmMIOrHBI/Af9omn0fTah6jdyPMMIFyGdT+G2h0bSOjA8TFen48dOfXWuuHSXI
         91SGNeFoksZixKI6uRTOsUQXuk71hTHaZCdqk9uf+dQAA56FQbdADsNaT6DtcIkpEaD7
         ANghjAIBCGDWOuDHl1Y9jec2rMLc3BsLac44s0Ps77xL6uIZiM8AsQizEOcGaLdRvxlQ
         AZ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795104407; x=1795709207; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dd1gd3HFQQdIECo6gd2+bO3Oskz1749IshHJlKLQ034=;
        b=gjLDKr8hS7NLNh4huyL7wrkffOFLh8hxDFSyRzdwJD5xQ+6vWndL0j3ZD9bBqCBLRK
         nfd+N+AITPG9weZOVZuHk17IoYJuAaqje+MSDtXXhTHNvyc7eDcPr4yaH4ErJ1o38DzE
         yf814ZyY9wgH0kCuMoxco6MS/GXtwtoFpIjaZe98j8M59+bZHJQnjGnqpQe7BBdQxnoJ
         27T0pu268PwVTr9y/q/TvBXxgUQSksYIXKrHDsKFYbQKu5r6jON1JwX8go9/t1rAS9Pz
         PKQ2b8/72YcfNswgyX3mSo51BrK4HOjkR8peOZLhkStp3PcA+xe0Mo609qkqQ7dptuG8
         0FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104407; x=1795709207;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dd1gd3HFQQdIECo6gd2+bO3Oskz1749IshHJlKLQ034=;
        b=pByIvqazscXBNUz3lPGbY4NJ8qOf291m5cQrbJsjD7YmEWwkdIVzraVdzjdqFHq8j1
         X6swOj/UOnN33McvNSZckGovIxsUE0YLVIUg7LMozsoZ++vozPXk4JD6hcfZWCKsmgCm
         tRDi+5pJ+dhdulR3UVnZPCIHQm0axmmZVvAZf8q5zNGwTe0qeCcYNtrcDI4ygJzb1USU
         ppP+pxD9ti5Y70mqgTNYo2KiR69krbGXLMVwc/cA6TLAyJEAVEdPLuxxntsLlBJsP22c
         Mcu3xP4FocnXiAIoeR7DuZfCDH49+PaynWaEZ29iY612kY4BmNtpx87Uh2NeA5tK3IK9
         aoBw==
X-Forwarded-Encrypted: i=1; AL+hErFVarqWvNLzc6LeP3zlmbKuCwEGT+/jYnqU/RL+j4HSIUgxS1J/VKdxve05Pndaq7Ep7SfoKXPeGcQX3oM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TWhzc6NrWdNbjq6BqY0HYYVOMlBh4oJne4Lec0ZW/cypXh7mB
	1Yzq95qPQWjJ6LdD8SMenuXFr+fpCWuAhpUYMfcpniCx3NOPFyORHmwqNZBXS80LN6/Q1k77eja
	Il954Eq1E5Xj+baUFzr4I7KdSZqAp19iLf1VVZ1PB84S6SkV3FNhdqJlGd+53tt4Zw8ZqcmEeOx
	jfDjb+3sa/VUsfMINRZDvfaxbGMWOr2oV+OD06S13f
X-Gm-Gg: AYBFou1jZaE6dA3IEfTDz3S68H5EUeJX8aMWNIdccsUty1d0HTJROOMbTNd9lf4hN4q
	Z/dIPGrotmJ+uaOG1/ZxVWJYZhxaXb9VJDIEAmmRC4om+5xo3JCFAUBZr4A0R63Is7VWgL86eET
	nSX0XyxNNfFAziUuKD3UKYeKLcBmARfdNiEtXo4xCdrox+yMVfQCCzn/o=
X-Received: by 2002:a05:6102:688c:b0:7ce:62a0:6a14 with SMTP id ada2fe7eead31-7d6ba3e8aafmr3201262137.9.1795104406627;
        Thu, 19 Nov 2026 08:06:46 -0800 (PST)
X-Received: by 2002:a05:6102:688c:b0:7ce:62a0:6a14 with SMTP id
 ada2fe7eead31-7d6ba3e8aafmr3201158137.9.1795104405991; Thu, 19 Nov 2026
 08:06:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Nov 2026 08:06:44 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aveMxDqYQobWwXd/@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com> <aveMxDqYQobWwXd/@devvm29614.prn0.facebook.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 08:06:44 -0800
X-Gm-Features: Aa3M54q6YTJdYOifjLiE1IcEMjR2EM19BZZPYXZtaeWVDqOpof5x9jxPqyhxpz4
Message-ID: <CAAiTLFUQMyQXHAw1DbDKfJYus-Se+QA_SSHWQymQ9dK6-UmRTQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/8] vsock: add datagram support to virtio and vhost
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Fri, Nov 13, 2026 at 06:15:40PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket. Invalid or
>> incomplete messages are discarded. Datagram delivery is best effort:
>> there are no peer credits, acknowledgements, or retransmissions. Send
>> admission uses the socket send-memory limit, and SIOCOUTQ reports charged
>> send memory.
>>
>> Datagram sockets have a separate port space from stream and seqpacket
>> sockets. The latter two continue to share their port space. Datagram
>> routes are chosen per destination among guest-to-host, host-to-guest, and
>> loopback transports, with VMCI as a fallback. VMCI still owns its socket
>> handle when it is present; loopback works without a directional transport.
>> Hyper-V continues to reject datagram sockets.
>>
>> The Sashiko review of v2 also reported that a VMCI datagram bind in a
>> local-mode network namespace creates a receive handle in VMCI's global
>> port space, so a sender outside the namespace can deliver datagrams
>> across the namespace isolation boundary. The issue predates this series
>> and it's getting addressed in a separate patch:
>>
>> https://lore.kernel.org/all/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com
>>
>> Within this series, local-mode namespaces bind datagrams only in the
>> core table and never create a VMCI handle.
>>
>> Bobby Eshleman and Amery Hung explored this feature in their v6 series
>> and v7 work-in-progress branch. This series is a fresh implementation
>> against the current vsock code. It follows the separate datagram port
>> space, per-destination routing, and VMCI fallback requirements discussed
>> there. For guest receive buffers, it uses bounded fragmentation and
>> reassembly rather than full-message buffers or the earlier drop/error
>> queue approach:
>>
>> https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
>> https://github.com/ameryhung/linux/tree/vsock-dgram-v7
>>
>> A corresponding virtio specification update has been drafted separately.
>> The wire format and feature negotiation still need specification review
>> before this series can be considered for merging.
>>
>> The first patches expose the core port allocator and add datagram queue
>> reporting, then implement the common data path, guest and host feature
>> negotiation, routing, and RX fragmentation. The last patch extends
>> vsock_test with local and peer tests for message boundaries, routing,
>> connected peers, port sharing, queue accounting, and delayed reads.
>>
>> Testing used QEMU with the F_DGRAM property patch below, an x86-64
>> KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
>> backend. The tested paths include 64 KiB messages, delayed-read bursts,
>> feature-disabled ingress, stream and seqpacket controls, and header-only
>> guest RX buffers. A temporary userspace backend still fails stream test
>> 21 on both the series base and tip; that case passes with Linux vhost.
>> VMCI's host personality was exercised in a QEMU guest, including
>> coexistence with virtio and self-send without loopback. A VMware VMCI guest
>> device and Hyper-V hardware were not exercised.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html
>>
>> Code was written and reviewed both manually and assisted by Codex
>> (GPT-6.1-Sol) and Claude (Opus 4.6).
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>> Changes in v3:
>> - Preserve Hyper-V stream routing and prefer virtio for guest CID_HOST
>>   datagrams (thanks to Sashiko AI bot).
>> - Bind explicit non-VMCI CIDs and local-mode sockets without a VMCI
>>   handle, resolve wildcard destinations, and retain VMCI self routes
>>   (thanks to Sashiko AI bot).
>> - Recheck bound addresses after receive takes the socket lock and set
>>   TO_HOST only for forwarded guest sources (thanks to Sashiko AI bot).
>> - Probe negotiated virtio datagrams and numeric local CIDs before running
>>   dependent tests; cover wildcard and VMCI coexistence (thanks to Sashiko
>>   AI bot).
>> - Link to v2: https://lore.kernel.org/r/20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com
>>
>> Changes in v2:
>> - Keep guest RX buffers page-sized; add START/EOM framing and bounded
>>   datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
>> - Preserve stream and seqpacket data when an RX buffer has no payload
>>   room.
>> - Separate datagram and connection-oriented port spaces, and share
>>   receive metadata and queueing (thanks to Alexei Starovoitov).
>> - Check negotiated support and destination CID on ingress, and require
>>   an exact connected peer CID and port (thanks to Sashiko AI bot).
>> - Select a capable route for each destination, retain VMCI as fallback,
>>   and support loopback-only sockets (thanks to Alexei Starovoitov).
>> - Preserve the connected peer address across temporary parent fallback
>>   (thanks to Sashiko AI bot).
>> - Use socket write-memory accounting for datagram SIOCOUTQ instead of
>>   separate transport counters (thanks to Alexei Starovoitov).
>> - Extend selftests for fragmentation, delayed reads, port sharing,
>>   connected peers, and capability-based skips; fix the test build and
>>   README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
>>   and Sashiko AI bot).
>> - Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org
>>
>> ---
>> Sergio Lopez (8):
>>       vsock: expose the core port allocator to transports
>>       vsock: report datagram receive and send queue state
>>       vsock/virtio: implement the datagram data path
>>       vsock/virtio: negotiate datagram support on the guest
>>       vhost/vsock: negotiate datagram support with guests
>>       vsock: allow datagrams to use directional transports
>>       vsock: fragment datagrams across receive buffers
>>       vsock: add datagram tests to vsock_test
>>
>>  Documentation/admin-guide/sysctl/net.rst |    8 +-
>>  drivers/vhost/vsock.c                    |   51 +-
>>  include/linux/virtio_vsock.h             |    8 +-
>>  include/net/af_vsock.h                   |   31 +-
>>  include/uapi/linux/virtio_vsock.h        |   10 +
>>  net/vmw_vsock/af_vsock.c                 |  526 +++++++++++----
>>  net/vmw_vsock/hyperv_transport.c         |   11 +-
>>  net/vmw_vsock/virtio_transport.c         |  167 ++++-
>>  net/vmw_vsock/virtio_transport_common.c  |  172 ++++-
>>  net/vmw_vsock/vmci_transport.c           |  124 ++--
>>  net/vmw_vsock/vsock_bpf.c                |    3 +-
>>  net/vmw_vsock/vsock_loopback.c           |    2 +-
>>  tools/testing/vsock/Makefile             |    3 +-
>>  tools/testing/vsock/README               |   33 +-
>>  tools/testing/vsock/util.c               |   62 +-
>>  tools/testing/vsock/util.h               |   10 +
>>  tools/testing/vsock/vsock_test.c         |  175 ++++-
>>  tools/testing/vsock/vsock_test_dgram.c   | 1061 ++++++++++++++++++++++++++++++
>>  tools/testing/vsock/vsock_test_dgram.h   |   30 +
>>  19 files changed, 2195 insertions(+), 292 deletions(-)
>> ---
>> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
>> change-id: 20261027-vsock-dgram-support-683a4e0aebe7
>>
>> Best regards,
>> --
>> Sergio Lopez <slp@redhat.com>
>>
>
> Hey Sergio,
>
> Just a gentle heads up that net-next asks for 24hrs before reposting.

Whoops, sorry!

> I'll start working my way through the series, sorry if my reviews come
> back spread out across a few days, not sure I'll have enough time in a
> single sitting.

I was planning on sending a v4 fixing Sashiko's issues. Should I wait
for your review first?

Thanks!
Sergio.

