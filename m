Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F923E25B
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621363; cv=none; b=Ac6cjMc4VEEUwJPkG0TW+79BEHZR0ex7oTWBo2mp1rW9c80S0S/wWx72VAfIs3mHB0O6erwbQWCI529IQiaOn+ql7AGwDK9QJoi5MJdStGkli6eviThwwEgeL3pgaODvCGt9ARjI2wVvsrRagManczk7vLaS3GoL5WO7wSo+DNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621363; c=relaxed/simple;
	bh=VbN+Et8O+M81UON3mkIv3jA68onfR7gbv44zPP//V3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R+WHGSq+i+tKDXa1emso1tfocZsTtNEh4jZuhoMKJgncfOK5Uh63eZ+K/hVRIQaDsX+7FmjiL0Xv4f8dVNnCVw8P0BMWimaxNymE0BUJxVuBywvzNLSzZ79LeMHM9PD/+qPVGvIxKDVtIAYvkBrYkKbZ6IyjFJN5IOIweVk+BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSFS3yYZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=opn6Jrrq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSFS3yYZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="opn6Jrrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786621360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
	b=XSFS3yYZiYVGnJd1Wr7RELvLW4PjUOovysef3QXeCIXISZSw2DfJLuZ4ZZi1LljL+yeuPK
	nvZJT5oiPgHjMTXAGCbFI2v1PnmOMyd6H/cMFnasW3nXkDPNMrw1XyjFPsNwtEYUp5woqP
	wFwFbFZmlNPH93efNQvLNLVDd9d2Yic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-7aVZGiSqOmmweEDvQ_0_Dw-1; Thu, 13 Aug 2026 07:42:39 -0400
X-MC-Unique: 7aVZGiSqOmmweEDvQ_0_Dw-1
X-Mimecast-MFC-AGG-ID: 7aVZGiSqOmmweEDvQ_0_Dw_1786621358
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so19293355e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Aug 2026 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786621358; x=1787226158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
        b=opn6JrrqNUffshKC8YxKYQde5957jq20Ehfsrt/+GzL++Cgl1/q8ws2HsYQLbWLP9h
         JLxMmsdJ4NLDU56Vee/WiDHWLEeS6TiDLW1xfrJI14y9anF2zMN289ojDyzIm+yJzrhi
         Mf4z1hES0UwyB8IMxa8EEgSYVFXCeDM/43ClBmV1bIPPmQSMPf4aDH5S52FzloC80suD
         8rVheZbilXjHg/6+2RyFK9WhH7vReQUE6SLnaQ6lP9Bwc38J36grGEMbPd6ecFCHcU1Z
         hCrFOIjuzw1YHPh8RkJUFR8mNCFXFuBzpC7cHuGo9FqRZ6lIaZamjFuktthJmMlCsYdr
         KFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621358; x=1787226158;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
        b=rlj0z8+Ei7htRVKBq2R+NVXfMjfxOMr3ys4sTrjmIp1lUIc4e/39bFqs09EWmYnF3u
         3GUUWsD16oVnm0/I3tTGa9uJohb1RrcfcLV5AA8yQ9J2Vedl9dPEk3VInfC5xcu9jGgS
         ocP1gHfQOuprw7ySbhnex3kbdIP24Y0srFkwO5SnTtsAESrNzr+rr39vhjfMekSe1QgH
         K+RRrvINjSaPRd0C/r36auo7iH4pZr0Sy3O/si6TP+k102Kmc5VC4sfIZR5oQuZ3MqWQ
         SsT9PX1BKzNMyhHuk+ARjTuZTLNJ+PhNX7NaDFOCjyUM5BDuJV8dDqRi85IzmaB30vTe
         olZg==
X-Forwarded-Encrypted: i=1; AHgh+RrqeFX5c1v1Yqr1eSuBksymp6rHNUMxM2S5+3t5oqscWWiwoDwYv1u0FoXPfBJQHBIuf3ZmshdRk1xF8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VLg98WF0OGV9ARUti8VxkNSL9S8CLInH2eHEIrvntHYmpn17
	QrgxlkctmIwdyoaTveBZdkjiZGd8daYgPQeLx1Jd+ovQ0m5Co1JrGf272N8n+itDclceBugPK2d
	ZLPuuPw6R1IGSeP5hL7uW0FEXQvHaRLfwDju40WXqwqkh6P25ZbzBmuIYlq0ryU7MJg==
X-Gm-Gg: AR+sD103te4yFmwcWLMfiJduJQbqF6QHEB1t9OXUF7K0BrXrEGm6bgAVgBKFWes9BU/
	zKCLK7+o+h9qDpOzaRtj9Cu5WybJi2EDdJh6V/ziz2C/tSYMNT7IJsANANsILciadImpTlftIPo
	WTlxzwooDnJFVlvJpe8JRQeBvgS6wwzNBoDQpKBbEZkaPQ3vP5g7j9HOxly2lzqTvC7iokidkHN
	8Q9y/kdi3R1LX/UHilpQCEFXPg6/YE797cLrqn9Dvsp6jvmAgjyhlH21W4IR9NhQ6vOu16KAee7
	aW+7iUWKx7cOqkQii9qqgyKG3mORLlyCbNhWOnrKmDBjYMUglegm/BVO5AnrRzkLPNuKU7ukwi7
	XGB0bVpdrhtFfQGeJXfKI3hr854mCc7S/e97Vyui3yb2eruZMhqWdPJY6sVBudZJv3unC6LPE6C
	k=
X-Received: by 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr76377135e9.14.1786621357828;
        Thu, 13 Aug 2026 04:42:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr76376185e9.14.1786621357373;
        Thu, 13 Aug 2026 04:42:37 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820c2897sm107064505e9.0.2026.08.13.04.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:42:36 -0700 (PDT)
Message-ID: <711d525c-cfc6-472c-b073-0fcfc9f95b14@redhat.com>
Date: Thu, 13 Aug 2026 13:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: mana: Avoid DMA queue allocation
 failure under memory fragmentation
To: Aditya Garg <gargaditya@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, kotaranov@microsoft.com,
 horms@kernel.org, ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, kees@kernel.org,
 sgeorgejohn@microsoft.com, ssengar@linux.microsoft.com,
 gargaditya@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260807210002.1695263-1-gargaditya@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807210002.1695263-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:56 PM, Aditya Garg wrote:
> The MANA driver can fail to bring up its queues on systems with high
> memory utilization because every GDMA queue ring is allocated as a
> single dma_alloc_coherent() of the whole power-of-2 ring size. Under
> memory fragmentation these high-order allocations may fail, preventing
> the driver from creating queues when opening the interface, after a VF
> reset, or when reconfiguring channels, ring parameters or MTU.
> 
> Per-queue sizes that are problematic, with depth and size given as
> (default, max) over the ethtool ring settings:
> 
>   ring                  entry  depth          size
>   ------------------------------------------------------------
>   TX completion queue   64 B   (256, 16384)   (16 KB, 1024 KB)
>   TX send queue         32 B   (256, 16384)   ( 8 KB,  512 KB)
>   RX completion queue   64 B   (1024, 8192)   (64 KB,  512 KB)
>   RX receive queue      32 B   (1024, 8192)   (32 KB,  256 KB)
>   event queue           16 B   2048 (fixed)   32 KB
> 
> This series addresses the issue by:
>   1. Routing all CPU-side ring access through mana_gd_ring_ptr() and
>      mana_gd_ring_contig_avail(). On a contiguous ring these reduce to
>      simple arithmetic, so this patch is a pure refactor.
>   2. Falling back in mana_gd_alloc_memory() to a vector of scattered
>      order-0 coherent pages when the contiguous allocation fails. The
>      device sees the same page-list format either way, as
>      mana_gd_create_dma_region() already describes a ring as a list of
>      MANA_PAGE_SIZE addresses. The HW channel stays contiguous, as
>      advertising a scattered page list needs the HW channel itself.
> 
> Throughput testing confirms no regression. Since the fallback only
> triggers under memory fragmentation, the scattered-page path was enabled
> unconditionally for all eligible GDMA queue rings during testing (iperf3,
> Gbit/s):
> 
>                  Baseline    Patched     Patched
>   Connections   Contiguous  Contiguous  Scattered
>   -----------------------------------------------
>   1                  46.1        46.2       46.1
>   16                 182         182        182
>   32                 182         182        182
>   64                 182         182        182
Given the above, I suggest to follow-up and remove entirely the single
dma_alloc_coherent() allocation; you will get simpler code and less
pressure for later dma users.

/P

