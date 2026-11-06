Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975963;
	b=G/veO/FRNGL0T2FnjQY6l7YVlHXaoIbvhoKWWbBI5FlrLw3IEFhAzXKsnDIkIpRwhmHK
	 1aOC5vZZt6t85ccEgYRXuihRegDB8Od2kCbm6SPHyBG0qEOeJcGJL9O1PDzLM/Bv0NWf6
	 eIwMWhVMyaC1R/bRENgadaodGrC7NohgbNqXH9jPJNqmoPvHkyBT/ALIfgFEHCengHDlJ
	 q9vjGEnZBzB9Td1nZO4G9HFrHar40/UPdu/L9mb00fWNVcdolxIvc0fIUH4LdaHCnryGx
	 DB/YA52ciGlZSdTVVgA0kQfSpXi2PeR7Jl3hp8cbSxKaQwy9lN69hOCkOMOMGw4f7tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975963;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=yu7bopFe6ZxII7vbgDFXULqzc5dPeq6DkDd1PaOyTjZDenBgTrtHks78/07tK0FFx3nr
	 lJc4rxnLVPdVnG1b7KVeyOhYs/xwMTgruGikhh9L1H9DxlfsoBI4vIHqZa33yXhKtvFFn
	 b7YcCcw73kENVY+8h9f41xZcskJfDXX6Z7ChN1TEFH1oR5NCpqpbxvTO0knGgL3K5wfY1
	 AI58z5BlrEnF12ls9mZWvzdh3iSWbP+TIxrE+v59dyO8nE9SYkdSUJgR2f8XLQ2SlHub/
	 eFZwMMGVrvrENc6tEufFGiPFduor1s8W44g1rYuCE/7SWpjiCxDt8NEwUkOov3OsB9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LoPcaZ2V;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="fAM6/AAk";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF7606A32D
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 14:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCF7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LoPcaZ2V;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fAM6/AAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793975961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=LoPcaZ2VXGIAu5ude8m/HeAv2AXC2qLPOXLK/+aSVZ2B+WXqfcCFzr1udS7ipv6C9hlU0u
	fYw014L8Uk4yzlGQH1Q1FeluVcmVrZS1vPy2vwZFJ7UaI3fAjvFNOvudHa3lBLMNcwKV1o
	vpvMn2ovzPUd8UJmqFFBQdI9TNjVcrM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-pLya8r4qN5O-2fSrwWvwfg-1; Fri, 06 Nov 2026 09:39:19 -0500
X-MC-Unique: pLya8r4qN5O-2fSrwWvwfg-1
X-Mimecast-MFC-AGG-ID: pLya8r4qN5O-2fSrwWvwfg_1793975958
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso766843f8f.0
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Nov 2026 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793975958; x=1794580758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
        b=fAM6/AAkZexi9ShT4PKSlVPSFrda+suPwTL5oZMjGDK2hGpPJqgPhlNRy+RYpqjkWf
         2JMG4IMJl2M34C7L+thWdoURU0kuca/K0IMjZjFfojQT/a6pFbyX1N9e3RnoJBusoB7Z
         4taG5137kJT944e02AtliUekeg5HaJ35thqj769B8rtEN48zv+io8HuVV4XNq/K2CQhE
         YP2VXsnMhq4HWxMdmwfFEkKQLJcWGXoktxmXYwTQLbsfHInpUhQmv2P/Lse9pSAfgr7A
         04i2/9jlTNS6LJlIdG1S9VvJMWEUTLA5VDg0VDhUs6UrhtJNJiRaA+t+SiiOfd9gPS22
         lzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975958; x=1794580758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
        b=nUCoYVwQM7QY48HEU0K2qgvoLDdbBIZCkq+Xe2aR7ODmKU9nmL7bv5oftAk/Vj9Ew6
         Xq8QfGW1gbhs28XHfofzYGkYDS7Stec96I5oYjBgyC1znP7Y3Bt8T7S3XjqSoQfMFs1F
         2xEovZgkhAfGMm7w350m1HFMKnttl7UiyxiiUgxIz1rUKkHn397ISddgIZCGGMEQGXCj
         REwoU38WuJ4pGpDiP7ENCtppOdXe2GSVzaPLHUbaS3zHOaLNRx4otGHM9nlQBCOLLeTJ
         cyiUYBHOBVJQJVOPBvGKeF922bI12gTGJJOL+NJa/TCLDJVoVPw6I35h8B6XILAl956o
         lfvg==
X-Forwarded-Encrypted: i=1; AL+hErH9rJwvkAbWgyx++z0g3wl/I7T+R4c8p1YbB1gjRJvcaLKtuJ258OjUgJAYr2CpzoXIQqcVn0lpj7zO0Fw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eIViBFiKifCNRRYd9t0WLhC34hn8cMWTebOXBdw972TmTTBsU
	YuTUHpO/pkyNIcQ74f0uFxq1rYbVM7ZR8tPM3MzT13MG5OC7CHWB2vEUt3pr/L+fi0F6MiPZmyL
	dILesyxWyJQTJcb+5dvJf/ogWJSR4Ec4r8LRG/y+xac5isqYTl4dcFq8qtrPZAaLSQA==
X-Gm-Gg: AYBFou3bW+KLhn6Y7U1kc9hrYPnWeReTEydvHwba9NmQOPXrDmmUebg6aBd02WqE7TS
	+UVFZiQXva/Ygenaqq0+6B1nSQzIbtJlQiaVaRHA61p+80TMYGxaUtCmVXsfi8Y07u2xI3QLQC4
	xjLpc/bndaWTu+TkSowZmLpVpGBqrkWyViHtqze+Fi99HXF1fANxeYujO2bLQw98qIBB53UGzT4
	wohZmvVdGbGS7+W3d5BzDKVMlCHIalx88qyHX76CN5zRQCY9ofpXJu9dmyQb3L4TEzADPi7QIzd
	mSs2CIXDdLND8y6yemwLF+E6+a3ZKzSVgky3gMtKqi7l5MHJ8LHrZHa7tTACDRxifd/6Q5l33oH
	crCA0mDaEpirSj3olhKrJ/vQTQhDSY9kmuUVMERiGbUNmWZGrfI6M
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363044f8f.57.1793975958184;
        Fri, 06 Nov 2026 06:39:18 -0800 (PST)
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363018f8f.57.1793975957758;
        Fri, 06 Nov 2026 06:39:17 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ad7sm4518709f8f.15.2026.11.06.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:15 -0800 (PST)
Date: Fri, 6 Nov 2026 15:39:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>, Luigi Leonardi <leonardi@redhat.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3k0TggFXTn6usw@sgarzare-redhat>
References: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>

On Fri, Nov 06, 2026 at 01:39:18PM +0100, Andrea Parri wrote:
>The Hyper-V transport is assigned before the asynchronous VMBus channel
>offer completes.  Its zero-initialized hvsock therefore has a NULL chan
>until hvs_open_connection() associates the channel with the socket.
>
>SIOCINQ can query the assigned transport while the socket is connecting,
>or after connect() fails once the transport has been assigned.  Unlike
>poll(), that path does not check stream_is_active() before calling the
>transport's stream_has_data callback.  hvs_stream_has_data() then 
>passes
>the NULL channel to hvs_channel_readable_payload(), and any user in the
>guest can trigger an oops:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000178
>  RIP: 0010:hvs_stream_has_data+0x23/0x120
>  Call Trace:
>   <TASK>
>   ? vsock_ioctl+0x74/0xf0
>   sock_do_ioctl+0x42/0xf0
>   sock_ioctl+0x27d/0x310
>   do_vfs_ioctl+0x700/0x810
>   __x64_sys_ioctl+0x7d/0xf0
>
>Return zero unread bytes when no channel is available, before accessing
>the receive state or ring.  Leave the existing channel-backed receive
>handling unchanged.
>
>The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
>guest with a small user-space program, available on request.  With this
>patch, the program reports zero unread bytes and the kernel logs nothing.
>Other vsock_test cases were not run, as most of them need a host-side
>peer.
>
>AI assistance was used to identify the issue and develop the fix.
>
>Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
>An alternative is to check stream_is_active() in vsock_do_ioctl(), as
>vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
>are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
>limit it to the crash, and can send the generic check separately for
>net-next.

Yeah, I was going to suggest the same, but I agree that for net this is 
a better and self contained fix:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>The reproducer is a new vsock_test case.  I have not posted it, as
>Documentation/process/security-bugs.rst asks for reproducers of bugs
>found with AI assistance.  I can send it privately, and will post it
>once this fix is merged.

Yes please, post it upstream when merged.

Thanks,
Stefano

