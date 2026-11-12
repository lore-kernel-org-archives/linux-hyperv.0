Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503068;
	b=c6ztpmpBw0+f/IN6PPt5A72VYKN+FKXSfi6s7QxbK2Te+DNAgbko7Vs+VOmquW4Y0K7u
	 mvbkf8VOqFfl0xe0RImAaCAMpqwK6liAGAQ7+tBI/xkqXrdi5UjqN1LQJ0r3AZKnQCzvW
	 banVuZ2+SgzZjPBsS6rZolMxo4Wb9DyhXLivWuwtSQ+YdKJCGA2DOgEBmBeukpvlWV1tM
	 P6X4NOofDtHNZoj18JhwdneI/n34lSkD2VNB6HSLm0iLyxwHWfB3vlqOoPRNAb+/f8Omx
	 w6NLekoOvACLeFhrfC8a7U5NGDLHwndXQrhfcHAf26uXiTM/NbyLwfnAsnwocHm7/yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503068;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=lxXTR5+oUT965jibFIP7/sddWeIDdk1v3c1Ky4Z/No4gzNcEDhVdVbO0Ra/R0T2N2cFj
	 xazfjGfz3hwACiI9zzmfj0l+gH0K7U3peQibC41oNvQTJjPFOq/mwiQpZEvWWcWSg5eJ1
	 nC+OQG3BvPHcO7gEsEnVzwroZ3lfWvRvDpfNLgaB3TXMfPmBYuuJ5PuLnbhrxMkTWtMR6
	 kd9N7a61ULJTfNz1Be+QjsNq7oAdG8pdRsHQmIJ6FPPtQC3fXFav2XISQOxNbBQXcsx/Y
	 KOuOdOa65KaDw1a+TFOnWIY5M1TSZ3QzGA1tZlzPnZwgootgggSxWkLs83lXXeLlFsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e5txvaix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340F606A327
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 17:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8340F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e5txvaix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794503066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=RSM4jfOySxzjJPJjdouIzY7aahn6xYwmwQ426+YBqQwkDoWHGLgeqj8QRmvU57NPACXmsh
	zlikkXlCu202+ypjIEik6t9BI6oNtWjvXMqD6ktYDAPqn115ugNa+3Ye+Ves2Fl+fDHFmo
	IiZSu2po3bI721tRDFzdUrROBgpMv/E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qXwLOC_8MaSxcIgQlDtVAQ-1; Thu, 12 Nov 2026 12:04:25 -0500
X-MC-Unique: qXwLOC_8MaSxcIgQlDtVAQ-1
X-Mimecast-MFC-AGG-ID: qXwLOC_8MaSxcIgQlDtVAQ_1794503064
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f0938c499so353256d6.2
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 09:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503064; cv=none;
        d=google.com; s=arc-20260327;
        b=nAk/XMwRP0BMNJC44/OsDMZnc6gb/4WiZHh3PPyVC/FETj+qqDbxTdL68Ev57vn0vi
         1pk6yGfv/sOkJZ5Tl/N8iyh8baR7vMPPftvHQqTs3BMzSyBHDdE01D7WC5WRgV30ZLqY
         MAuhFO1MA6QWiBcaH0bQckle4MKoSCkjkodCq8T5vewCWJ95xktkpTC5yWu2WcParlb8
         wvPbf69cEwQlLLOGjhDrZ900mvFKNfAKQjsgSRAx6iasiiIXaUI2Mq/2LLijjnMFCw30
         YKlT3AlWKsSsnAqqU2nHbrPpPF3JDy4Zl93HjRVpJ1JLIBHHVmIVEQW9Lu3NEDPB7g22
         AUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        fh=iQMg/0KfKXBGvtD+xf7FLAzBwghqqVpUaVJoVZhqmPc=;
        b=B/sB3JCCWBMGm6pFl+k5u45f8Vh/jDQxhMG3iTS0NkIPxwMuiT7l/QjK3Yd/dlD7AJ
         4XF2Qo//XE57FlV3qsxxSnfvgrvU5xBKfIqvIXnWJkUjic2JZEQ0LMUR46KYmkxLE9G7
         HFsvmq2iDreiNKLDjoaHfQxHsIG0nAJdwscdn0mglcx2e6cLp5aRw+FMcpaw4JNLov/C
         qckLyen6xt92Sgly7bbbQQmBDQMu9bLbCjtzw4SD5e00RluxuTP1uV3W0r9207e0hQdA
         CItSqbTE8CWlg9BGycvuU6WUGdGcRHfwPavS6WO5MLy2TXn/pWE4DMGmwXDSAKSed/Lg
         CqoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794503064; x=1795107864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=e5txvaixuvNHqul+AWOdRXYydV2CRIOdF+h3W7bH/p7/mu/wQV+rRR0AggOfVeMj4b
         SYjy34d8t6Gk73gu2hks5YczKaU441O1G0I6qOpMQ+pKV6jRstxCEKCKICdZnTCkpgAL
         UYcH8Upb6118IKl5V62rqD5IHgK4RD4M/mthR0jOmsytXYOR//aQJ6A+IU30mlHHNeyC
         IhcNpD4JUQfFcvabxt9cYStBIpHAr7tTXKsN2dScD3Jg2z7IhCQ46YOOAM6jbDzz+RFx
         76MiizwYlDCNbPRCUT2uApQDm1x9dbQ/0zTEweG/KVhO72XTi+fpp0LfHQCWdcDZ1gQL
         Qpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503064; x=1795107864;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=Ul0C7LcVzIX5Hd/qCBCat/4u47Xq0kevKhc8zE22PqUzelqfZ6zPRxhMVQ8jwh47Kr
         Bw44QivbgrGLKuCX/M29ajCm6t2uIRZzIC511Biv9RLhC/xPPNp11Vquq4iOWlKRZySH
         cJWYD0vwyr5R+e3rdRj1pQvGSD+gDc9xPpGGm5iDldl69hASvGnjyw8XpRE/+ZJ1142l
         kmlWaSazTGqajc1ZaJevSNC40CDRnGgz8WCyP75R4m/8Z7NSWMfc+QjbxDRpIJaCqUVN
         KVOtuNMMSI0lmuDQSitv5uchNoi+6akBU/iCTci2EaZVpJs2WR8Dz6N03RTCSvzlbCeY
         ltEw==
X-Forwarded-Encrypted: i=1; AL+hErHy57p+31Mz/J9ICsQGpJ8xsuMoXnG00NsZ6fpIeBo9eDAPTKE3MCebK6KU303ly1fL5H8rRECQmV5c9VE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XNhGcp5XhIzQHNzcHGIXxyd9vpgGhBPGO0uJPJ4wcC91KJvD4
	/QNz57gjY/o3Cyckc1gDSttTmg8QWN2gpC0Q2L3QBYaYSolnQn4MoL9yjoRQh4CeQkvnOTXmUlv
	hi6GlQEmHXHzAwOsCattTaZ5bSKbtYSBJC3ZNBLt8xMxsEpJQ4cpAAs473Js5aUm/mvq+xvDHnA
	bY8+Dn6dN/2lF24jWsQNpK9xShkIyZZS/tdku/6/4F
X-Gm-Gg: AYBFou1yMqsL1FnDGyUZki9jr5edKz7xtUqd0iTjBlzpQBaC5EnqoUxviXtl3TCTTOC
	hcEyTsrveAEPphGnUKR+aitx4KYM8FEirG9xD7giXNo2bKUqtdp2t5CXHGnnKPCpd2L7b8HCoJS
	Xhjrme7jPGdFJx5U0XDEdwMnBMUMxnJyE9xYZpCIP93sr9wEhrlMT3aLc=
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91f040c0da4mr105357516d6.28.1794503064080;
        Thu, 12 Nov 2026 09:04:24 -0800 (PST)
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id
 6a1803df08f44-91f040c0da4mr105356616d6.28.1794503063345; Thu, 12 Nov 2026
 09:04:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:04:22 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org> <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:04:22 -0600
X-Gm-Features: AclHuK8-kXlDfbY9EpdjADOfLMjXVcZNZptS66ye_0dxL9--qQit5gRpAYjKWyc
Message-ID: <CAAiTLFVrvmrLoFxAdJ+ObY5trjgKvNJW5im7XaRQ+K1PG-_M-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
>> This series implements SOCK_DGRAM support for virtio-vsock and
>> vhost-vsock, allowing applications to exchange connectionless messages
>> through the existing AF_VSOCK datagram API.
>
> The cover doesn't say who needs it.
>
> Bobby and Amery took the same feature to v6:
> https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
> Stefano said there that it can work well and that the virtio spec change
> is the next step. The last mails of the thread have Amery's v7 WIP and a
> short list of what is left.
> The cover doesn't mention it. The spec change is still missing.
>
> Why not finish v7 instead ?

The previous series is more that two years old, and vsock has changed
significantly since then. I thought this deserved a complete refresh.

I should have linked the old series in the cover, though. I'll do that
in v2.

As for the spec, I asked Stefano and we agreed it'd be better to have a
series that's pretty close to be merged before sending the spec change,
and I agree that's a good idea. In fact, adopting SEQPACKET's strategy
for splitting up packets in the vq would have an impact on the spec.

> This RFC goes the other way in these places:
>
>   what               v6                        this RFC
>   -----------------  ------------------------  ----------------------------
>   (cid, port) space  own bind table for dgram  shared with stream. The 2nd
>                                                bind() gets EADDRINUSE
>   vsk->transport     empty until connect(),    g2h or h2g, picked in
>                      lookup per packet         socket(). -ENODEV with
>                                                vsock_loopback only
>   routing            one helper for stream     2nd copy of the chain in
>                      and dgram                 vsock_assign_transport()
>   recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
>                      no dgram_dequeue()        dgram_payload_len() is new
>   VMCI               fallback                  first. No virtio dgram when
>                                                its module is loaded
>   dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
>                      the error queue
>
>> Datagrams use destination-based routing across guest-to-host,
>> host-to-guest and loopback transports while retaining the socket's
>> transport state. VMCI keeps priority as the dedicated datagram
>
> A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
> bytes_unsent. They serve SIOCOUTQ only.
> virtio_transport_alloc_skb() does skb_set_owner_w() already.
> udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.
>
> Without them a dgram socket has no transport state, like in v6.
> Then no need for the owner transport, dgram_transport_match(),
> fallback_transport, tx_accounted, the skb destructor, etc.
>
>> transport.  Guest RX buffers accommodate complete messages when
>> datagrams are negotiated, preserving message boundaries.
>
> That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
> It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
> that each SKB fits in a 4K page").
>
> pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
> charges more than 64K to sk_rmem_alloc of the guest socket.
> The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
> queue is dropped.

Thanks for the review, I'm putting together a v2 addressing these
concerns.

Cheers,
Sergio.

