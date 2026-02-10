Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88092FE579;
	Tue, 10 Feb 2026 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764008; cv=none; b=KsbN7bX3kF1pDK5Joi7h8jw8xBRQumQuTkNcoPGpx1YvQo6jF8+3l9g/LoMAzYqWR25HENA70CsWnEWWvnt7jBwocxbDrRFNJ/d/wn58u+D4bVHiROTU9HbwR5+5tiQRggKhQEZaCxOYijzePZS5zLGN+3rfloanraq8TqH3tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764008; c=relaxed/simple;
	bh=AHbiyaawWzFPubJS9zsKj1xRN7M0Og7yWqxxCClQNfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS1GSEYM344QRIKv24acMf0HsZXiOg8th/nc+JcQyinfZxaOEN6jiyDo2AhsDBPiENxijeyG/4BQPf11+t31bWro3nqGlBL4aa2w4qvIuzANwrbbZhp21tQyaJiWdFNIpOv6tDZgCvXbKXg1M08CrmDiZ5CztVTQefUi77Mpc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hAHwXVxF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hAHwXVxF"
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61AMqfJn3574887
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 10 Feb 2026 14:52:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61AMqfJn3574887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770763970;
	bh=/JVwO5GqZyRu4wslqfDAhOYGhuMqZ/no6z2KyqqMrrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hAHwXVxFx5gqlfTFo0/gyNlXYQGyG16+cRGFk2IqI/h4lJycl1YZ97q4FTjUU+xYT
	 mM31ROJYLaK8oqNutqeK/8rYNWOMrwXdeWEN3YBPWsbpFHa7sE8F01H+LtFzOQlpE/
	 jI5VVFqpsAoAWAaMIJP7/DT38rlWrlTaJB1Bm5l5NhyVQg/7h+nBg6BzWvLr703GCm
	 vGDbTM9zlHstq+R/V50AdmgbNmSJWxhrrCvyFkAfpR3WtV4IRtlS3aZkMhd+v5uJYv
	 7QrhKD3s2RLTLzW5uZVULcw/UDch7w2sqHkafEjjMMPWrD4iJbGFj/e7eKxpQnFX4M
	 5qNmAx2H0G24w==
Message-ID: <90543b26-1e09-4a84-802e-aad737265b7a@zytor.com>
Date: Tue, 10 Feb 2026 14:52:36 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with
 VMMCALL insn
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20251121141437.205481-1-ubizjak@gmail.com>
 <20251121141437.205481-3-ubizjak@gmail.com>
 <8F5147DF-E0E2-4942-99D9-4242F3013635@zytor.com>
 <CAFULd4ZaRGENKVYXZiaPO0heT+1bpGrVBGzA+Wz9VS1NG6trAQ@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAFULd4ZaRGENKVYXZiaPO0heT+1bpGrVBGzA+Wz9VS1NG6trAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-22 01:33, Uros Bizjak wrote:
>>
>> I think it would be good to have a comment at the point where ASM_CALL_CONSTRAINT is defined explaining its proper use.
>>
>> Specifically, instructions like syscall, vmcall, vmfunc, vmmcall, int xx and VM-specific escape instructions are not "calls" because they either don't modify the stack or create an exception frame (kernel) or signal frame (user space) which is completely special.
> 
> The existing comment already mentions CALL instruction only:
> 
> /*
>  * This output constraint should be used for any inline asm which has a "call"
>  * instruction.  Otherwise the asm may be inserted before the frame pointer
>  * gets set up by the containing function.  If you forget to do this, objtool
>  * may print a "call without frame pointer save/setup" warning.
>  */
> 

Yes. Some people seem to have misunderstood it to mean any instruction with
"CALL" in the name.

	-hpa

