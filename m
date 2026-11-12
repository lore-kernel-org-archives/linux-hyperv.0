Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502641;
	b=F0sRmks1x6+xdQWcSagihSIg0+1rgRBZriMOqoiQ8baTluJZo6tHenzrEnhtXFY4PT0E
	 LDO5W1K/XIQA6jUXDHSPaeLodX+32IKOXBcKopUr66wIXmhnbAcKxSsGV+4j8m8Ri5JBg
	 vjqZ8tnTECFWBOiUhpvN6j0PTNjbhWS1lndksJ6oEe2VQ0N2MSDVDovHKfICv13YU4Hl3
	 Hp11UvNJYFBuZzDKU65QILC7YLBc2wV+BJfu5Oy34XN+ypxO1NUhNi5lXIJtEvRNUkyce
	 yBEt2MtuCykg/K0KnLF3iJfcR0I1+yzDPVKAh6uHlAzNquxMkfwb3zzQmAm3t3ev2Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502641;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=BN9CzZMRWLfccKtzG52M0tyc0JnEYOhCwVDjxbs3t0u+ekSSGZPJNjR8yNTCYZAVg9br
	 rHu4yWHK3DLGY2TDP49RzQ0KUUjdVYwom20MyWoxfhdrgSBU5Z3o099Cuu7zq79cDa0Ij
	 mvxghiTzwWWB1y3vZ4l+kc1Xx95M4grdvxbKEh62oC6LnZ9VG8bzQsFGhuGPzTQYiVoeD
	 ySXAGseKGDT/QoF/ji3s71L5OMSDn/lYW+HTpcSfTyQULjZLTZ/t4wc9/EIJ32E8GvvlX
	 s0d6/gXVYLFV+VKX03b8hy2z5/iL66xF9/UZlScwLNR0k9wA1PVtRbj2V9WnJOfA1bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR0iSL7E;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE6606A33F
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 16:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFE6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR0iSL7E;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=WR0iSL7ERJdv15vokbc34Ew1ggE2lIS9qgOjc2zhvCdoFhuBftBHZtUl8icwUUpw7ytzMC
	oOr+18BDQiYijHq6PtcpItyuYo35cPmk2z5GFLDrdubrAJ/JKeIDKfBGolvWEnRm1GXiwl
	Ghsuq+8o91RragwwPPTh65OyuOcWvWs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-o-L_GYu8Ok2SKUeo2fb3Kw-1; Thu, 12 Nov 2026 11:57:16 -0500
X-MC-Unique: o-L_GYu8Ok2SKUeo2fb3Kw-1
X-Mimecast-MFC-AGG-ID: o-L_GYu8Ok2SKUeo2fb3Kw_1794502636
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91e9a0eae11so318466d6.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 08:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502636; cv=none;
        d=google.com; s=arc-20260327;
        b=q+XFpq623twgWpdi+KcPJKYrkCudq+FQgMqmcQvUg+27FrnFMZB3S9RZreuFvFUKnS
         e5rXGWwUq6BVSn3a8T95KZnBJf8JyBwpylGDDKor0pU6BUv4BXCPtymhyQt9sLKgZvWc
         gF6X1ZasUMKKpgna1bQZ4XadfhSvbe1PXSB0JHTwbiD/Ut55Vyr7u9cl2cPsGUafWOWD
         I0nAcCnN4SbUj9lI67CTR1+19Wph0eEioQrW7kRbhGzapl4Glfu6+fuuTIewcoYf3sIb
         Sv8Eqsy/MmPjRIAg9KNtLan8/Pi7YjHydXDauBwrBtjYXCEHbV+tPUp6sLPbk2adVS3E
         fCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        fh=Nm1f7n/j41/ftL9j3ySWqFTjd0NvzkFVqpSCmm1WobU=;
        b=Wb7eV8Z6A1wmD5kwaUfw0pl07nM8cf5fNypUNHP2rg7kPbDkOmiJW1Bm0Q5UUWutB7
         aPmPrnhxqW2sggGuGLGxXuqUgyUXE/4wTXmAh2anwWvtXUQLw11lNYShlEjJP1ioWd5x
         p/ONtLBAPzOjxzwlA3klYVrg8dBff/Mg+w1AJhNznXMQDThqdSYMsUeoGoXjyTLq9eO8
         n6sIWLGJS1+5RZd229SklHxE9pkaXv0kdoJsrK8yMqxHJqXr5viV3I7np0Rz17pbfIn/
         z0kwO50d/kFOZhZd/mecOP/gQYuc9MEqOOZzhgbdWHcHLbv/u0QP6ww9ReyuWEkwn+7l
         vvMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502636; x=1795107436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=mfphcUTJmKpNNjKE/vba8sbrm2GA7Y+gcHku8cTk1a+y2dk3EloihtRyKAQeirIvDp
         wvg8gkhJ5lC1AkaK6heaVC6iCZhP3qCeGnLlBSZBpeyaU5rKFLySsduaBj+RJQrdj/E/
         IvWZE44ZUGb6gMSkTITxuIkeJPwmU9i14CTY5gqBw8ihusdtAVkW8q/898LYixqHhZYX
         YqpsLL6HWprFGBwF9Jr3IbUomVpiAGiwrOGlg3zjzrZwjD5T5QVv8bgZRv4HjYSAOgZf
         YjJaZhabEjQq3VWp4hxuQIFQlsqsnhAkHF8n3rCUYqLL+Up6ZKGZVhESekpKQ0IoL+2B
         u0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502636; x=1795107436;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=nehYig8Y0nb0sldFJykTs2D4aIagKCyPgGCUqJti/V/d2ZubhiDrgq6gExO767n5iQ
         hmVD5/6rz3UldRHeDZxC0u4/m3U7DiifLgKfM6tzjdpCPeR0YShm4HQZs7R1gg3WW56E
         Q/cfdJjxldFOCrhgzuCU3MgKVVGiea3CJ0G/8cn2Wbn3hRCbJaZjR8OAGAIONBjPueDc
         dI6r6BdIzjue0qV7W87A41VpuUS0M6vdV5fEof2Wqx+5/G0MqCmPYnkP92t1lhxVmxm6
         4QkyWjlJ7G0qxoAgAky1OLFBL9SiQHVvFuSgMCNi6hjNFuSRu3HU9qS6EJmzpVoGaz0F
         lPSQ==
X-Forwarded-Encrypted: i=1; AL+hErHTfYKoGvaYn2gSEX9KPP3MJOVSmR+CnrNUFcvTZIqnBYBBY9qA1JkY5aGlkiQqz/WLeG57s/4VVwNrDfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Tj95/a+QPGtiSa93tMJfE+ePObtAN1x7LE6i7iMhYEBu085xX
	HNYCSooj3/5dnchNceLMtwkE+Gun5o9dqIH4fc3S9Qlvt10lq0mjpvdRpL+ncLLJtC7yiRwRxBg
	3p+abcL5hFmrzyckpThN42GSP/ZCh423mb6NSxak9ytpHCDmESS8ewlfE3igUDQ4PDKSbAdpT/G
	gYaUVYpm+tY82T28YLBfeaRVj5XIxz2uNp40xkZDQW
X-Gm-Gg: AYBFou2PybbwS3bgKuTgJ4368L/0zdzKt3nXSlbMVr7Fho2QDCqroENUx/4s6qlDwHY
	nwgje8WL4OV/j9rfc/k/frKUQmXUFUSMM8DAl6It/yFc/8KjrriQqlODyhqTUFrOR5jvWyvk7uT
	LP5H/b6Rjc5yftWj2fRFcZ3HUmdcSN8KeZ8NXBhHXmqaEDbEqINl4r5uc=
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id 6a1803df08f44-91f04024a36mr108416466d6.16.1794502636088;
        Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id
 6a1803df08f44-91f04024a36mr108415966d6.16.1794502635425; Thu, 12 Nov 2026
 08:57:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 10:57:14 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org> <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:57:14 -0600
X-Gm-Features: AclHuK97Vbt87h1PiWp1yuLFdgsXXBfxSod9rL7qWx7O4MzdkcMf0Vg2mTyClE4
Message-ID: <CAAiTLFV5g4XV7ZU+TYFboAi3n535murgSjh4SBw_PMnp=oQyww@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
>> Vhost splits large datagrams across guest RX buffers, delivering each
>> fragment as a separate message. Allocate full-size RX buffers with
>> page fragments when datagrams are negotiated, and drop whole datagrams
>> if a guest buffer is too small. Refill empty RX queues even when only
>> one full-size buffer fits in the ring.
>
> I wonder if it might be better to do what seqpacket does, and just split
> the datagram across the buffers (for seqpacket, until the EOM flag is
> seen)? I'd expect that we will get better utilization of our vq buffers
> this way?
>

Yeah, I do like that approach better. I'm going to implement it for v2.

Thanks!
Sergio.

