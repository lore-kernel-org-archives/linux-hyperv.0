Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848035;
	b=rNyCsrjQT1D5YXybq7Re2MDZDkkFZnq8m0zRWKZtp5/DE8LIG0JT9gKRwJbYMmjp/t3w
	 N75KimA9qgS4wdgsRmNTmkcTSxQjs6vNERB9ouWS4pAM0JPB/PEVJWacBy4244uydY/05
	 dBx438GfOFgq2yKWSptxM/YPaMyh34YC986WMjSOx+h2TstXRV9tfymoXz9FgSTjmtFuT
	 C/S9tPsDV59L16KI2yW49deSbnyIGT4qdgXe15+iwdZSKSGTYMZccfTZbuep4z05zsWfM
	 Ug6vCeXH2OWo+ez2/4diuM8sd04lrGH3hoOvX2ZuNZhp4CoeJVGoTgthzUxntVfArmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848035;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=bqpnbYez4VTwdSzKiZ+UbbzzA5hwXKGpfw1yO2qEZlA=;
	b=R4/XtT8M18Rau4H4VARgAqTg+cN6EI2joe4FTzJRMMCiCyweMVwufhmCo9UjHiofZ40R
	 EMa/IQFwoyx7U5Tdb3Q6IIS7KC+QERW61Nmc5Pq2gUlgo0uDHRbUEP9JGqJCC9ccc+sPp
	 gyGshiMMm+qUcljTDP7HK0Ni1vcDQOQEghgXVxCbaUH3/Bdp2/R1rNQYCIb6y5gUTFLhA
	 dFxnSsiMzYsMKk7jlX5qyql35FmPjdn7tKAPkegsmJbIw2K9lUPJBss5+kwraAA9FJ0vZ
	 PS5z81ov5R4Rnk1MbINGs8WjtdTLhEtX+Aagvs/qvDdd1fLCZzo6xpKQ9aiNuwKxo7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MmXtWrBK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SE+07uiP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C6606A31C
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Nov 2026 16:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB9C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MmXtWrBK;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SE+07uiP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794848033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqpnbYez4VTwdSzKiZ+UbbzzA5hwXKGpfw1yO2qEZlA=;
	b=MmXtWrBKWWp2jTPLZoiJvi9rKllPkiYhEMUqnrQanPtqt01MLBTVmi/EUwIskCTVEieDX3
	K2Phx9HiUb1BK6zXgTCFlDHUTVf4M5Tty4wOHB/vfJGngbtfd0IotBuISAw9sNjTz9hM4s
	aLmACZgZ/1f1CYOL0PDfm1S+CEYOnF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-GV-3TJjvPmuTxosrSHysug-1; Mon, 16 Nov 2026 11:53:49 -0500
X-MC-Unique: GV-3TJjvPmuTxosrSHysug-1
X-Mimecast-MFC-AGG-ID: GV-3TJjvPmuTxosrSHysug_1794848022
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490a0e72578so2212619f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Nov 2026 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794848022; x=1795452822; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqpnbYez4VTwdSzKiZ+UbbzzA5hwXKGpfw1yO2qEZlA=;
        b=SE+07uiPRANfOae9uHA6lpUhLnyyI3yoGIF6YSZHHNWoKWqv8mVOWSGe3UcAR/eGp6
         awjVK0/kbixD7ZevMMZ39D92SD9BfYcpbwG4TgAj2z/Fn32fQFS5Jlhx9/FfKMUF/54x
         B+vG7VTRd/8+tH8zJd5pijq//kgYt3LdFOrXzksFjD4xs7OVSWpBYNETB8NXdpUWH7Vz
         s7pzzXi4NFnYLbhTDLdf4QyCF7ASDABJmg5CWTxDU9mFs2fdndFb2x8Wg0SkZSn4xBMt
         3IGoq7IPC/5N+6j+HQxRvS6yGq81sWOePx1VlgIWfOU8tSS+vMkfC21brGUtxkJtHG+g
         LWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848022; x=1795452822;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqpnbYez4VTwdSzKiZ+UbbzzA5hwXKGpfw1yO2qEZlA=;
        b=12knwnBoLl06z2zaEefFyW0uHHXN+6iYuq89y/D7KGeZGvNMNzQhH/K4BoxfPl7Hjb
         NtPrv2soHckGwp0dhsLV/8HWQ3qEFkXE7ccfzg+W4+t8hMDgF87STlfhH9Pf+wT7WfF1
         AZJ2szUa01syqoWxOCYWgjfArEVzgEXjEFUqTrwyU2tXc+VSCD5GYU4R9uFbAor2unPs
         miqYBVkIVhoq4+43pGZmnBrdAU4nQVO8LQtK60I/vwRZcxKfV4HXB9xzFhSfpONnuz+q
         A/MGAw3Vd5gfA9kKbiPeb6SolyXjBb/lhEEUflg+g69ts24PiBTu+FQN7LZ0L2+faoP3
         +stg==
X-Forwarded-Encrypted: i=1; AL+hErHnlUaV9l7Yyom4uZp1GRBVq1qN067Km/QoZTIbrClSch4JZGnVuzFviokW50hbXs0uP2BCS1qVHXMVyS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TLunWLmCZyWhlmK3y2mf8nhxKvw+65IArwONBblhC63X8uLeP
	DB6xt/YFz+AZHyQHbWxl9DTTK3gV4KxUsf5JIbW6li8ZO+tZ2bAxtyyPw4V435h2DSFwf7BIU0w
	VdbzrPL/dDP1YQ5IeldGPQY37LAzh24sSY/KxkTE3dqVr0BVyTloCQNTT0Te4PhIptg==
X-Gm-Gg: AZFdTZeXTGETUMzcZtYJjrySxkMMj1Cs1o8cUEkoh87/bfEX84mkiws2xvIMXWrc2pA
	JPlNzCXpie8aswANBdmUPFWTRLy5+4QWuY9tMCdfjMctD0X6Zwe/nFmn1TKWjqsL+BZPl/wwsSG
	Wouda9+0Agt4qZLotRknk66uvRN5pA9gFJetd8PqlHZMkDPo+66+glwcUbjKR86BABfcsEnnv5D
	Mb/TSAN62rC1zRubKBl/VyrNcR7i7IRL6umfQIyxT5P89ZRB8am/2jLeKTWw8HkkEkmOyMThhGu
	UxtCOd4xhU7tZV/chrXbbCgrHwYdIKt3ezqyAVW4SG7UGN7n3BmtpEtPmsn4QrjkGnClonC3VQz
	BULB7YChBexJC/iOYZzg92euYXgW+ll0V65tu/wO1TKi/DSTE4uBzzF4GeqPbIUz8yMkJg/B9jk
	T1Xb8yq0e61cq6NYQ=
X-Received: by 2002:a05:6000:2dc9:b0:491:8462:20b6 with SMTP id ffacd0b85a97d-49c73ed0fbemr27790081f8f.38.1794848021749;
        Mon, 16 Nov 2026 08:53:41 -0800 (PST)
X-Received: by 2002:a05:6000:2dc9:b0:491:8462:20b6 with SMTP id ffacd0b85a97d-49c73ed0fbemr27790045f8f.38.1794848021334;
        Mon, 16 Nov 2026 08:53:41 -0800 (PST)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm23833104f8f.5.2026.11.16.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:53:40 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Mukesh R
 <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
In-Reply-To: <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
Date: Mon, 16 Nov 2026 17:53:39 +0100
Message-ID: <kup33t0iup8.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

...

>> 
>> -	do {
>
> Dropped the looping behavior here may be much more significant
> than just "streamlining" as described in the commit message. The looping
> behavior was included when rep hypercalls were originally added in
> commit 806c89273bab in kernel 4.14, long before any SNP/TDX/CCA
> functionality was added. So it was present for "normal" VMs doing
> hypercalls on x86/x64 the normal way. The looping ensured that
> rep hypercalls could not return with no errors but with the completed
> rep count less than the requested rep count.
>
> However, in my mind it *is* debatable whether that scenario could
> ever occur. The Hyper-V TLFS describes "Hypercall Continuation" [1]
> as essentially transparent to the caller. If a rep hypercall stops
> processing reps because of hitting the 50 microsecond time limit,
> it should restart and continue with the next set of reps without
> the caller having to loop. Commit 806c89273bab mentions
> hypercall continuation, but does not describe why the explicit
> looping was added or how that aligns with the TLFS statements.
> Vitaly -- it was a long time ago, but do you have any recollection?
>
> Have you gotten an explicit assurance from the Hyper-V team
> that the transparent hypercall continuation really does work,
> and the explicit looping has all along been unnecessary? This
> assurance would be needed back to and including Windows
> Server 2016, which is now the oldest Hyper-V version supported
> by Linux. Also note that the rep hypercall code is architecture
> independent, so the transparent hypercall continuation would
> also need to work on arm64 when the hypercall is invoked via
> the standard path of using the HVC instruction (the TLFS doesn't
> cover arm64, so this is unclear).
>
> If you have such assurance, then I'm good with the removal of
> the looping. But please make the removal a separate patch, with
> sufficient discussion in the commit message to justify why it's OK
> to do the removal (including that evidently the original commit
> misinterpreted how continuation worked). And instead of looping,
> perhaps do a sanity check that the completed rep count matches
> the requested rep count.
>
> Without such assurance, I think the looping needs to stay. Callers
> are not prepared for a rep hypercall to return with no errors, but
> with the completed rep count less than the requested rep count.
>
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface#hypercall-continuation
>

It's been almost a decade since the looping behavior was added, it is
very possible that I was using WS2012 for development back then. The
commit says that the feature was required for HvFlushVirtualAddressList;
I don't have any evidence left but I'm pretty sure 'incomplete' returns
were observed. It is, of course, possible that I only observed them in
synthetic testing when stuffing hypercall input to the maximum by some
random data. 

Overall, I agree with the proposal: keep the looping unless we get an
explicit assurance from the host team that it can be dropped.

-- 
Vitaly

