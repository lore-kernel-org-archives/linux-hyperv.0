Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B083328B7B;
	Tue, 10 Feb 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758599; cv=none; b=SRBkwW2ssMAzWfW5imyNHaLbTLQr6Cfgn6AGwZlAAE+o5teFvNvXl+jE6Knwudk7/TJK+CaHf7LX73Q4OzwcYfJTE50iG+WCr+AMTqzhe54tBZhnf9OTT7av93jubwmFFt72di7T1VY3XOxjsZ2ByEG41/Tsd98iRpGCR+OoNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758599; c=relaxed/simple;
	bh=1fCLZcfz88XfXnkau4d74bwFGB3zbfVdmnWEG+jZBK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjdtV46Suqb94Tmgt63Ts/l/6yYuJe68FG/ayRpfeiAlYauqKEKxUQQPjbd5h8VYswtWaxzsCbMY2K8Kcm0xhvWSAvpIfOvitujny+qMbjm7uf5gBDwb4E6Rjq7xYzmxIAiHE4ydTGkzag4PAZapfkUy0/pcsDEj2cmNSFBpU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4D7GrM++; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cne3McgA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4D7GrM++";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cne3McgA"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770758596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMdyGVS2XEUlKtt7abALwZrI2OC6fTcF2Ecw3c3Bkfs=;
	b=4D7GrM++42bskF3UHeoVk5hUY1fjzWwPzwCimat1MSxqRVky/Vs7mMKQPFxA6IAIPyB+qY
	FFtYbq2ICD7gX4w8RBKpHwLN5c5tChL7kdTCyLMfDuG+wpDNguxIz7fVuSgsjwuTOiXMxb
	V0RrUf+qvypF6m5M1Y9Qbwb05fqnsdjMvk8iZ1haKQbuF+/PrEZ2uL5rS1p2fUepNf+yH4
	4cIwSNtOlQAfsacVsDcWPU8XatSVaDFFnV0OV4ZopenNDk04bcrz+9vktlAhCJe7yCQTqT
	+HkYda+0uFfu20uYTdBUTr3bG+nIJdVzm6XvtRTdg8rY1Byie04f7Da4rKnD1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770758596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMdyGVS2XEUlKtt7abALwZrI2OC6fTcF2Ecw3c3Bkfs=;
	b=cne3McgA0MR/KrWiSlVdQ6TtP1iNfkGho4rvDMxZWTHuXb2CB4W+YMo4hoJoDOO2+/irg8
	vDGpAmBULGnfT6Dw==
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
In-Reply-To: <20260102220208.862818-1-mrathor@linux.microsoft.com>
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
Date: Tue, 10 Feb 2026 22:23:14 +0100
Message-ID: <87bjhw9ttp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 02 2026 at 14:02, Mukesh Rathor wrote:
>  
> +#ifndef CONFIG_X86_FRED

This #ifndef is broken. A FRED enabled kernel is no guarantee that the
CPU has FRED. So this has to be unconditional.

> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> + * will crash or hang or break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D

As FRED does not need this bit fiddling you want:

        if (cpu_feature_enabled(X86_FEATURE_FRED))
        	return;

right here.

> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();
> +

Thanks,

        tglx
