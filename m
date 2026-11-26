Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795718562;
	b=Dc8/G2PT0KNYm47FjFCnsYwWCykQrh1SStQQkk4dsh1ctP/ti5geF2ab7qYQSYgeyoNI
	 ygWhsEArqQa8iNkln8AU+sBoMtXpLwph8AFNjoO/TI3lbCgNwY8ayk/Tjv1tGA7qbD764
	 vvXtrgcCP834IB7q27L7ChjWmClBnau8QszLJ6UU1F95Y9/N3KBpxULmwes3hYr2stioV
	 EvJZOg/RpeBULtST0zgNYWhMhBu9XzqKgHPtbKdtuRg3ha+e0AH9FTmhzoLEvk9lHUhbY
	 RYcYCWwfxAndNUdnCn3peyZ4yPvDs+2EmU/Ljwxz/P88FKxzqHBEfIUmesY7H3YTalQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=Fh8pvW4fZRJF8Lf5w1PVAJDTPg1Vea2RLKk4xsHvlYAJLboet5yrDZx1Vt65rbXwfU9V
	 MaJmgvLv1lC9L+PfQLhm3lE7ShOoNtjq7tj+hFl/tImnsPuMEWNPPBLTEsuMfgyiCB6da
	 bivndAtYyPJt8wOm5qHdAfzimJERYz0ZEfWxqaOPdmyq8T5iqYZM/zXa4sCix48Af8L/r
	 NauKyizaEIzuEIBhGxfoAG14r6Pr+CE39w/JTqiNdiHGjpCXTCOhC3tjEmKpWvUh+XGvn
	 2AOyx0BceHb2asnaQBQuYIyGsz32HxVImwCHOn0dUnPjouywkN+Q1bUPVX2lmMmFsNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3370606A31E
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Nov 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3370606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795718561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=dSJV2yS5i5n4Y0qa8QpYgIlvjQkV6ztVeP14NykEmG4e8ZTbbOguUnFGnuZkgM1hfvob6r
	JsVpE2hnbjdJj2tNxhz/Zlwdqw/UfaoJiNIXP67HDDrgplpsiOxKUG+XGfh9aXwyPW8bpA
	cl83VPqy12HNsmZ2ziLdHqi20GJFVHs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-EeIPjbPnOAG0W8NPekh8og-1; Thu, 26 Nov 2026 18:42:38 +0000
X-MC-Unique: EeIPjbPnOAG0W8NPekh8og-1
X-Mimecast-MFC-AGG-ID: EeIPjbPnOAG0W8NPekh8og_1795718558
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-92179251e32so39015666d6.1
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Nov 2026 10:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795718558; cv=none;
        d=google.com; s=arc-20260327;
        b=UrjJmNQzq1JZxLrbYYQIygbZZYockYYgqc85tA6Zsa4H73bm3dLc24JYNeLqSoYTMM
         M0mtq4fzrUY5BHDWosGOyh/yk8w+14u96umP5D6LCmByJZEg2j2tk3V5KqAwH1PizSN+
         UK+ZHNqqgDx76Qx09Z08AlELR2KCs/X2IfLO2CWA4+2i+WEnFU7MM94iKfXekxiyLtoC
         eQ85aGJiE7S2sp1K6sdNlmEz3sSUUs/NSRFGn8l3+9xmL7EOyqs5CqRy3I0bIP8BfjgH
         YHYwZxRAwqTd50RnM+dR1XL7jkheB0NRv0pqPlAWLaOjE8+1R/3/GoGhlkce8fcWNI15
         YovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        fh=/rikNXiFhjPwL6kzqAbgDXuaOirBRK71ziC9M/OivMQ=;
        b=cPwshoo2eCDL9JYRucWoScdjwcl8abBOrSI2Gprz8nrMo6IBlLOZ4k1ZyYbVIs/9aD
         gp0gVOXan80uLocawk/q94LEEyABiK/++ESxRA/1ITFxHG1qGMqX+wUnmXA7BxMI/Mfk
         iEt4FZwExUN4DVwh30ztFvCaPPcbkSHgSLt85wXuHRgtsJVd5C+1aPbDg7VW6X6MLQfy
         hER7VYTWKkHeFe971aYl/rnFqOTZwAzqOafu0ty4fqPGIVXKXfsLKLCaLIKTA4BcfQfZ
         WvVzsuBTpnJS5iG3Gshfsj4ZvOkkfitPj8RYxVn+K2+qFBn7sCmp+yrRswUP/Vz88dgJ
         FIZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795718558; x=1796323358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=AfZRd78Tl2My6cFNYn6J2IoXlWU7jd9dGbwrI6sPcEv8IbdB7fLO2XDTbfQrF+Io//
         ixsvT2itMWfRas0wyep77elrun0b0HGJrXml5mtbVm6K8dyKkh0KXNx0lrSGsPUkPCd+
         htlBpxymRJe/MctD8/s3oBLQrenF1llfpvNVhQu32t7LIWWg1Bh7H8nsKdn3e7FAE3vz
         mQxf/6gLyv6dziabFgdbxxM1bskyM7oKpN9JDuuuJ0aXwEDBLVIA3qoPxkSditthi7C9
         qBl0dW/paw/ir3LbJm8JTGe5BmEL00jx/ma8TFxiJ/0OxfY1hFMGLr2/eSwDP5uNRg0l
         WIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795718558; x=1796323358;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=WAzuT2kSzf5ZNYO1B+m9FqGzsLSuegm13Sv2F4fM9t1cS8obxdfPnZtCI0cOIf3pzI
         RCx9pCY0OGspiEiaUSLUCxOslVoP8VlUHt/BpvaPRvQpa+PIYGZD5rnCxzWhquCqD32d
         sDZQhUPFYaAjB4Qj9lfEprqFSUe9hKiyNdXje8/gPgm2rd/pSFRVVnHxV9D0aZ99P+i+
         SGBERkXp2nMLIJ5j8PydHhK7YktyYr+X7FdcPQqwnoiAqmfemBgNp5Wyi2eksbKsr1MJ
         CRCA2pJNUE/k2MbKi0jq6C96PcZ5If1aPodgFLRKeLmAY4CNV/iZMRJAev2Ghy/EhnNJ
         p2bA==
X-Forwarded-Encrypted: i=1; AL+hErEShVBojwCPa39CFtlcVufRTX7fPzX9aOvX4b5h2WKOjxh5O0cdglnUZmy6gpRZrXPni4Wl5LWulTqwVtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wXceIZ2vWY6uaAI+QvjG4GMoTF227k+5O8Ca42lLJYEw+MDQp
	mhPj5CanpQhKPo2LX4oSA1JrACByGjCK+R/8BAhV0lIkGd44IS4N3Mr5dm7PKmhdz4UwWHWNH2L
	G/7oqwIYw+MqMHIJrjZEVNkIl9zLP4ZYCfdwJ1xs+mB/SYL/1bOOBFgp8n5qDcMZMB7wX1DA239
	QaoKoigKb80VKy79iMxo7MyQHxdxByBagRw5KnGpL0
X-Gm-Gg: AZFdTZfbzR05yVAeAAwcEooqpEMQe5GJi6JjCKDjotByu076uNE9jm9ZWsTS0VwZA9E
	53ogZvD/nNpDpzASKADeaD+tji7qg03PKB3YTCIOJ6lTAXMxUP596EM3KH4CFlpbiB+zu+kIrnc
	qhox6A09OTqXIdgrJ1xZlzLiOF3cCB1y4ls/i9nLZteDY6orZ64zXUNa0=
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id 6a1803df08f44-9217c1a5a29mr99542046d6.14.1795718558264;
        Thu, 26 Nov 2026 10:42:38 -0800 (PST)
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id
 6a1803df08f44-9217c1a5a29mr99541386d6.14.1795718557797; Thu, 26 Nov 2026
 10:42:37 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 10:42:36 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com> <awhAaTuR375RpyAE@sgarzare-redhat>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 10:42:36 -0800
X-Gm-Features: Aa3M54odw2FRTdRy2uflU_aL9ZEV5X35-hMgLihiDc4DudGmLOU2wiibEdItlhY
Message-ID: <CAAiTLFXT_Dqs8sUY+dL7KhXL=-QYudikb9kVFFRvGv9Ri7y7ow@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and vhost
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
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
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>>the existing AF_VSOCK API. It is intended for guest and host services
>>that exchange independent requests, responses, or events and need message
>>boundaries and sender addresses without a stream connection or application
>>framing.
>
> Thanks for restarting this work, I have finally found the time to took a
> quick look, sorry for the delay.
>
> Reading the cover letter, it is not clear to me the changes we are doing
> to the core and VMCI that was already supporting DGRAM. I'd like to
> understand better how the backward compatibility is handled and how VMCI
> behavior is preserved. Also reading commits, most of them just contains
> a description of what the code is doing, but they lack the reasons
> behind the changes (i.e. the why).
>
> Overall it seems the right direction, but I have some open questions
> (some of them discussed with Bobby, Stefan, and I at KVM Forum some
> weeks ago):
> - Can the virtio flow control be affected by a flood of dgrams ?
>    See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
>    and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb)
>    handling.
> - Did you test virtio transports when VMCI transport is also loaded?
>    That one is automatically loaded (for historical reasons) first time
>    AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be
>    a common scenario.
> - Any limitation of the current implementation that we will need to
>    fix/implement in next steps?
> - Any performance number?
>
>
> About patches, I started to review, but I hit a wall with patch 6. It's
> too big and really hard to review/maintain. Please split it (e.g. the
> refactoring for vsock_assign_transport can be moved out, etc.). Also
> there are too many if() with conditions duplicated and few comments on
> those conditions, for example:
>

I agree. I focused too much on quickly addressing Sashiko's feedback and
things went out of hand. I'll rework the series with a focus on
bisectability and readability.

Thanks for the review, Stefano!
Sergio.

