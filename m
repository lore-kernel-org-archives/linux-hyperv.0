Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62C3F44C0
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652056; cv=none; b=QwJvVE36/jlPWdHZ2b+iPkKMR1Rwyb45/EH2nrk+Ul/dWLyRzRKy5W/GAyduT2l9Fn7P+EMS96M13b1fITB6Jf0IDKywpaTesT0wKd4u4Vm+SMVfYWwUK/MacjJuwHqIi1n/do8EB59JkJ08W+/f6G0XNgPbZKEo/4GwZrHdSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652056; c=relaxed/simple;
	bh=MTeY5Wj2A537PcAl8w2zs34Vdv6IeLJI4cMm7fLYNhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PURgAAM+AoDipkJ672nC09qC1488oV1tFPqiEpPiMQknFU42pz5WsQV6a+NA3gd8OkCSasqv392YsllszEqNt8q8pH87fs58oEhxd+a/u6n/zcNjM9/wtjYw/5BL+enH1BpybU9jF6rnERoxiRWJLFXNlJAQMbeHNtW0GkunQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baN1nOr4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnPAuatw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baN1nOr4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnPAuatw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
	b=baN1nOr4qZ3HusoYOnvtLBvQd1S3H0ksqozBXNRHQArpl9FvPhwU/bhtL8dzDb/5S44U/U
	cti7Vt58HGG9wYlisR+aQXx1To/WcHDB7aIqEWMxdHfXpSnUjevDj6TooFbCbSO2SYqGEQ
	vtdLUNaQdwsTMgzm+SufqENAAOJB7n8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-xkOdzdlcMYWqyTe97Y_8ng-1; Tue, 25 Aug 2026 06:00:50 -0400
X-MC-Unique: xkOdzdlcMYWqyTe97Y_8ng-1
X-Mimecast-MFC-AGG-ID: xkOdzdlcMYWqyTe97Y_8ng_1787652049
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c24ae1a510cso355845266b.3
        for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652049; x=1788256849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=HnPAuatw78phIBulEqiJKX+M2ZfFEiezwN6tmuQYu//Nc7M9ycufOypVAbsKHwHH0s
         jiXUnm3Rpmbh7n0bpFP8G9rtIax1axIxRh+dzxNG/2r4/UlI54Og3NyV/Mdcn304T14H
         bfiBBQuGduY9/ltImzPS6IhhFReufZtxkx6s9W3R2+vwVxwV6S9NFN3LZP1huSufwUbB
         BLgq2PXkwi331j/KHalp+7FCF+2dMkQLgvd9vnsbHd1HNuQMJlnSA0Tq+wfiyvrjbzTB
         rAAURdq3oa12YQJwyuGPLdaNbul4+qAo7Bqda9qpJACc4t9lrrMYcqOAte+5nc6N+4pj
         8zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652049; x=1788256849;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NU7zn4NpIx/9n/bcxiTGmb+4zsi3/IUQL8xFBOWNFE=;
        b=M5O0wDWqtmiLH7TivyrfhQV78meCyoTdS74QHpJMbgqqgTwDYK9CVihOacyCnuYvUY
         n5vd3PMF8k4gLqB5kgV6Tk7D+0/N9cC6rRp6oCAIt+EcFA0LKMz5tEqaX1T9ynZVgJq6
         yatjTm/MfG9rH3gby2KfyUTv0FyJwsqUhQQaoHAzydAmzESD97v0d9pUeeiAB3OOZjC4
         2BWtm92yPAVxxvm0yuM926cZqH+o9Xw67mST8kv4iQ8gVnIqRmXsR5rzQwBTjv16kCJv
         I1U4ESxLUz488NQa4gmSWB1YgWtUAOtVcaGCQNDnwzfIckeWQFCFwLJbWs8ebqZeGdoB
         Kiww==
X-Gm-Message-State: AFuF++kN2DJFqV+hFsqNYrZd4UdTWssLM/TI5dhV3LgazTwU1D6eJ2ox
	Hhl1Ldh1DOfnAiU62mxK7YAi70FWNWYzUasQ/gvVGfK4KhZXK4Mira7Dmps1UbGtZpjfJWMBc2u
	GLrGeQ6j6WFY/HdkFmWnaNP6Wcxooze89fkhB72jKL0Bd5g09Yjqfc5PeHFTIyemF2Q==
X-Gm-Gg: AR+sD11iITovajGIyvANGm5znv+2TH1gpgDmHnaLZ5MlOzdREDbSY8lJL9y/rfQ2U6P
	ayNVjCNazT3z1hIttnmHrfbKQkgeOpj6RiBqNZSBOCm0HIBgQZqf7snmIzoJi+gLpXWwjMW1bl7
	YnWTqhIm42xoeT9EseFojlcP1XIH1DF4NupSzvKwVRQ5WtKL8hAUZXbWP+YNjQ4upLD7sjSzMmJ
	e7NGWv+pC2V4jGC9FKibA2GLAnjf0ZmnM/ui3ia6+5lXJL6vjJruIbCPp0mpyJJxv3g83qyxWBe
	lBbx0xzu4E2rDezmopCwdD05ifVsmC6DXPNYcp1jtZc9ax5quRU4BmyqBZT/DGM6DnwTYND7N/a
	9j06oibqUlaSaneLrawDSx8z1XU89veZFzkCaFHGJqhzqE5NGBvfGlSnW5vyuzcywsnA2GHDe
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862375766b.2.1787652049426;
        Tue, 25 Aug 2026 03:00:49 -0700 (PDT)
X-Received: by 2002:a17:907:72c3:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c249238c382mr2862359166b.2.1787652048499;
        Tue, 25 Aug 2026 03:00:48 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1842658666b.5.2026.08.25.03.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:00:46 -0700 (PDT)
Message-ID: <d595961e-0d7f-4fe8-a483-f2fb7ca7111a@redhat.com>
Date: Tue, 25 Aug 2026 12:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Muhammad Falak R Wani <falakreyaz@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 9:09 AM, Muhammad Falak R Wani wrote:
> mana_bpf() declares an uninitialized 'ret' and falls through to a
> trailing 'return ret;' after a switch statement whose every case
> (XDP_SETUP_PROG and default) already returns unconditionally. This
> statement is therefore unreachable dead code left over from an
> earlier refactor, and it would return an uninitialized value if it
> were ever reached.
> 
> Drop the unused variable and the unreachable return.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed



