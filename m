Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D7257845;
	Wed,  1 Jul 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935307; cv=none; b=dG7ZtizNyY4yu8JVRtWatvV4E/l9i0+oq00TwG/x2k6qUO7qVER1XXwSK4qC2O3Y8nvT+9znmrD7/dljx5LkKnqmAsXYr/gAmvTo83/Ek2FNTOQQzFoBfwXLwn9PAmaMR4RKoeMaVmLEbO2yjd3UhClRaMH4VYvWdWHyurrKVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935307; c=relaxed/simple;
	bh=bZygkXx/enHAM2OO8uay25hEIL6a2T/ymcv3VTBnAyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3iTr4HHg7I09sLFwvE8LaiS7q+bExL+jcjhRZwHi5VtBHonuh/HwSw6CTBqFicYnQ6vEf3UkVjQJEBl78z83wZpkB9jUfsxmbiMiwKqe4qsCYhFxHHdVuNl9UuGcVxZsfAq9FJvtmkJahGpwJbpUvhDMvZYlf502L8FEJrHHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkV4koeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkV4koeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636D1F000E9;
	Wed,  1 Jul 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935305;
	bh=37vRUDKDn2dYl5kXitCbWrzqY9TQMCSdz77GSqvEu6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkV4koeA4dvd0MT2dcZ4exrTRS+MfIWcM2LruC/ULPidairln71bkeUVTFIIBgMQs
	 iAxq9znXYgIqxf+P0bcdayMJbWqeGr6OiCZyHP2uZsGRbH4v2MDIpppv1Dfih6Uzrv
	 LhIwg4MGN1L4/SCPmSZKjdFT9/4aossMcXdTWDByASNJv+ly2ICx3yxi4apenJ+pgJ
	 pZZAC8mCXQFwcqDta1/B19FAytoMma/0XQwr8E15lX+0rwAMSxnYOqSX4XekQFIWMg
	 ZdgTmBGXLUzonv6bnATu/DS8wz62TgdG6ODAe3G+4D8+25Fhwj3I/zEwM4fsQ9ExvZ
	 Qj9LwT7wc5XVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/51] x86/apic: Add CONFIG_X86_LOCAL_APIC=n stubs
 for apic_set_timer_period_{,k}hz()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-3-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:48:24 +0000
Message-Id: <20260701194825.6636D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `source` argument in `apic_set_timer_period_hz()` and `apic_=
set_timer_period_khz()` is completely unused, leading to dead code and lost=
 debug logging.
--

commit a7b2ed4060ee2d44136d35fad056804351b581ca
Author: Sean Christopherson <seanjc@google.com>

x86/apic: Add CONFIG_X86_LOCAL_APIC=3Dn stubs for apic_set_timer_period_{,k=
}hz()
   =20
This commit adds stubs for apic_set_timer_period_hz() and
apic_set_timer_period_khz() when the kernel is built without local APIC
support. It also removes the corresponding #ifdef guards from the calling
code in various x86 subsystems.

> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index cd84a94688a2f..035998555e992 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -189,6 +189,8 @@ static inline void disable_local_APIC(void) { }
>  # define setup_boot_APIC_clock x86_init_noop
>  # define setup_secondary_APIC_clock x86_init_noop
>  static inline void lapic_update_tsc_freq(void) { }
> +static inline void apic_set_timer_period_hz(u64 period_hz, const char *s=
ource) { }
> +static inline void apic_set_timer_period_khz(u64 period_khz, const char =
*source) { }

[Severity: Medium]
Is it intentional that the source argument is completely unused here in the
stubs?

Looking at the main implementation in arch/x86/kernel/apic/apic.c:

void apic_set_timer_period_khz(u64 period_khz, const char *source)
{
        lapic_timer_period =3D mul_u64_u32_div(period_khz, 1000, HZ);
}

The source parameter is discarded without being used for debug logging. Sin=
ce
any code calling apic_set_timer_period_hz() or apic_set_timer_period_khz()
passes a string literal describing the source (such as "VMware hypervisor"
or "CPUID 0x15/0x16"), this results in dropped debug information.

Could the source parameter be removed from the API entirely to clean up the
dead code, or should the boot-time logging be restored?

>  static inline void init_bsp_APIC(void) { }
>  static inline void apic_intr_mode_select(void) { }
>  static inline void apic_intr_mode_init(void) { }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D2
