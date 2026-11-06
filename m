Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977464;
	b=OlY7hmSH9/FHZGa9Wg4iq9Dx2/kg0MFV63HrTajcGNPuB77ny1d60s9Nmp4kkEhAG1U/
	 A7VHszd81BfFgaGD7LdL4D7xwzfAtdY73Rseq7DJa0uhsyt43T4caB71AGl8EHSaBwQRE
	 r6W4onE1Dp+q7k8mCpI381RXEjgX5IOzD+MqGmergIfYe4JVwkhSGCuh2xnTnEkyjTLaN
	 3DEPThbXRugs8nT3YihP3xrwRPg3+Mr79cMg/MiRz6sKyL7eoNGPhdvzWRHmXtWFyODqB
	 e9mLTw/1LDPIKofAKenDBn6q2JS2Yp32nOwP2thojTLqs5LO1SA4eTlityABax53ihw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977464;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=IzOtaCkQvOJaYBlZ83hDd5RXagk6y78RoIrOXsOHNAJO1VAAm8i+PULnGdyRHB1uspev
	 Sp8sIMDshc17w0rRhMnn3Qd5/qTkMGOR6iEFahrc0bLuwuUJ5E4NdhQt5HVCfkSd80Jid
	 0tEpLJFa/Ec/SaxWYSM1JBY+5opxYbfwtBiSDjn9E3EBrbIChIZtMCRVO79VYskkcPylX
	 BdMMxQkVHqNWuMn8h08r0O8Y5I28D5deT2ktmyITXPBkhujwPKC9C+m/zseEV8jkHZ8V9
	 olzfLjACoAVkRBOR0DUj02a+obaaBt20xsPbq8e1ZONKgFYNtemOoeY+abLMkQ2UT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWJI0aR8;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S6xiJ5wq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18083606A326
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 15:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18083606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWJI0aR8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S6xiJ5wq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793977462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=YWJI0aR83JkRMYKC0xUEf5vevtX22MosZC0Oecjg+f3OnI1AzAu5y0AbeQ+nnnrl0dbVTy
	zZ4ilrR9UXX3PZMpj4qOjXR5a9A0numo2IMEuW0CPNvW8VecPl3lo+CsGzCfyrSNrE7V84
	Y4IO5afjsaMgUNEZKHibuxJSXkSqjpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-dEaodTxYMOOeOjPJ7tauqw-1; Fri, 06 Nov 2026 10:04:20 -0500
X-MC-Unique: dEaodTxYMOOeOjPJ7tauqw-1
X-Mimecast-MFC-AGG-ID: dEaodTxYMOOeOjPJ7tauqw_1793977460
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49090fde23aso766764f8f.2
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Nov 2026 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793977460; x=1794582260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
        b=S6xiJ5wqA/od7IZeJKfPCBCmLGnEDEfekLmT15O1Ac+R9YG0Aw0ZvJzxQjJPtRHpsL
         o1APzKoVg6LEr1p8ZDdWgP4NhMgVdovYLS6OB2R3Zn0BKKFo0VX84vpYZgejxXTackc+
         ONSCixlpOKR7RORqTMhBOOzLuFYBJsc7pCNkqS6CkLESwD6CsLEjyya50G6ZNUAkkTHH
         Jx6jdsD9/TPpXQGP/SIQDji8sWl+5c3hxCDFQ9i/Wy+OUbUrNL3es3PNYxvYnabwaulN
         epOf4U6AvYLKS7xhkc7+rOl2+JKpGmKEj+2ZeotAWLctJNwlUl+MktF15EncOy+LKERg
         XUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977460; x=1794582260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
        b=FbRhcpUe3vwhXdj91llQVZUWp/AkmyxKHmPWiULyuDRyL+af51yKMsg/NSUwC57YwA
         DPjZZA4/k7+Vchf4XkieataNLhHD9sZu0YK/+3Xmhd1pay7upWMabIs4DxJs1nRZo7XV
         03bxUf2gItvpRUe10VsWC0mD4VJPbcNBMyf+FxsNFSwpv2knbHeR/1X71SQ/IT+vbU6A
         5wQtEzrX/4Aa7KkcBz7e1eA15iATa6BVFie1jxgZB0gw92/MwmxzMTQHGBsj5vwqIlWe
         x7dr+wJ+HJoxgmCCk/KwNc/t+QPZHsrbtrTEsJSe7XW1k4GeCd1uxrWKSe7NIs5Yhaaf
         NYDg==
X-Forwarded-Encrypted: i=1; AKwUvBysMG9kf2i4wp7LArCqMewJLHQ0UfYzfrMxNfrBuHcIiROJ7j2JJtmtVj8Df2hzKijnvd0FWGOMcD9x8mk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X6hjEbiyLZHfng+OmzQb5QN783CtAocTGOWP1uzJXSx0CZR84
	klvFSbrpuALkTDoX/BOpjUwBpk1sVTD0m2rxmESZjOKPTi+iVJ4TxCdn8cM29EG0OiwEsy67DPA
	/AkQB0iJbiG7TwoecuqYqz5zjnbA0W6OSLWn9DhOooAMaffa9Wmmikl14Smsk4uw6pQ==
X-Gm-Gg: AYBFou1XplGu9XtxyO6eHarsn4dEIWZ2xQiTNCd/xboWflQInjaI/FhQ9kRATbcyZcm
	4U7B4l1BjpUCwmRh7aBVR3JxJWH3XY8uoOVt4JJV4MJoOVHGa/sV/sFG9f6af/e40rQKqbb0QVB
	tCNz2qMEZ79myyoz7o0fHfUtXj/MfXo97SzdQjQb7wHKfPRM9HwXNuzJ7O2h7tRrX9LIdZV0yIB
	dRY7fEgZgZeh0w0nxqK0Ew3IewbHcNbTYcn2pYMBfngVjJBR3zv16Gw/TuHOj2eASnqTGR80DdK
	UEBjZMZaqJfZKZ5mylZtquCQVyB+uAIY/nIMjXc5THuphieiVthCzVnD1PRYZx5LfDnbCl/6e4M
	K3WxRzl+B3yozth/KnDLOQ94NT4BpGN5qfAU00ZC93Q4Xsx1Lwf17CdAbdcMYfvqzMNKYOv0Ysg
	fSBBuahvzO
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42830065e9.21.1793977459550;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42829535e9.21.1793977459116;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
Received: from leonardi-redhat ([176.206.36.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7626a2804sm29251095e9.4.2026.11.06.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:04:17 -0800 (PST)
Date: Fri, 6 Nov 2026 16:04:15 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3sW3i2qjKDLMzq@leonardi-redhat>
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
>transport's stream_has_data callback.  hvs_stream_has_data() then passes
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

oops, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Luigi

