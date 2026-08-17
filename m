Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744243EDAC9
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005569; cv=pass; b=BCMjKyXXxyO5xYhyc/LLMKq8Ubw7RYkIqsaYnzudPTInvNiE0RzdeaV7jlZfqKuHg4jf/46eXXkiIhsuy3EUUId5NtNj/wWEjIv3oEGgin3W1aPfjgGPObuoOZ51aa3o+0H1S7r4A00Pv6TDCd5R1/CV2Z1iPChhLcnYLf8G63o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005569; c=relaxed/simple;
	bh=DKrK8uziOsnu81Z21mMms2SVn4MRmNDPf9W6rlN6ndc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY043N52VOgGAoWl2T30cM+evTYOuM9jUt+3lkMWSjLeH/0p1yT69vygogkBO8esvfuPbmajzuKtht2ZTOfdwvD+ib159W2pH/Lt9IxRty6b5ux0+AQl69jiyhiqaYkR+16xWGCKuDYn1unnr0Ik4c9reEz0Cp4zZ9xfEH7xbX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyDaFaej; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyDaFaej"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1828a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 15:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787005562; cv=none;
        d=google.com; s=arc-20260327;
        b=CRYWNlETylIb4EOEplzHIA7efdjfZc9IRbXBRMf2xZtuyh7q/VZzTPwlIVfkabADSY
         ij4ARu1nMmMZuD3nRUHdzXyw+zwrac/ItkMqsLXc1K7A4vp9eBRGo0jDM7T0p8rz4G57
         vSxafpt0Kst8YkWfPvLLSUGYdpefGtQ9+amVR6yhlNwykvLTUvJGILaHWw+QsTKege3G
         jr6tnCeHFWyLzHHQPOvQv8YAppc8QYXrD9t94hRq7unzHMhTI5uBml1rq0lCG2oFrJdL
         YGvp9vB5wLW+y8fKmpDjWnZEQ8TGlUKSCh8HJY/B/jaHdrFo3xPmw8n8EHtrN9ih4QyC
         qtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        fh=rmx0uW+ho9yxeEhoUW1dqUpNp+LeqNTzAxMlvOB4SnE=;
        b=JcMtvaGe9+3+d5SfiR98urzQS/mSJTfAyiXH0c15220CwuBO9ko+HBerFf+YTAPX/2
         jviDp2Gs41enrTEIOEUokJB6yMr5rtDpKjEjVPM2UkYcAwVY2wGkiZxC+il6t3nBc/3Q
         GsdOneSa+1PGweSCE9Cp4uXL1E+Bdx1VaiQ1R00WyAbAL+dzvB3iSv6xYMMDiWipSUAS
         8hu3o600ZQJn4guyyQJC3HeXXsNYgR83Th3Bb9zh1fXSVSLyB38BlZqnDHg9xJ8Yq1fY
         WDRRh3S65ujtuIvhAoJQR+42RQpiwDdRuHtv8uRBLnYnNoQ4NxNGaK9KvUlADoP7C+2b
         pTGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787005562; x=1787610362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=LyDaFaejC43f5Ln2SZZWwjS7JztdgTDE4GuLU1gCD+uxwYua7WAKtuz/XO0/tnzL/e
         KvAfUTUeVDqQaUvHTpXqFh/4vaongrGuKRt12E4qon9DaLp0peDJSwDx+7krtn1WEe47
         dTpgSRiF1Rq6tExmCkybbkjmRWNc9/WEFhlXKe1iV26HIqtrskKODDjZKVQQg5QPW/+d
         Gk9Lf9tnbaiX0ILVXnrh+OXY3GeDSfCXZo++0CkND0ZNdrSkqoEjYXN4eyjC1tB2sMx2
         H/xrMaYlU8TFZ1ae27oI5Vqu3ymqieg3G7zi7o3y8lGuBhz5ScB49I/S96TCdc4zr+OV
         Axsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005562; x=1787610362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=IIW4aApj0JJIE8vTehNKGsbI/T+Mh12sXi2xamv0rQEwu9dH85iudT5Iawu793eJEl
         f0053XjNg6qCzAVvKyE6wWkcuQHIUSgMR22ZXOW5kNGjXrT4vwRXQWoUabWNbITruJR8
         LOFNAJC/uF/Lj8PSdXlAYDDuDyS1d8F7yWpTvmmm6wB1T76L6gZkmsfgBbYPXy73gImf
         a3114fH0icCgmSLkeCuEh2gg6i6LgxHNKy0DOAAKTM9HR83j+6kGbz7sPXxcWI3ToCJ6
         6UHqUh9RlXKbZb04RLZAKM33i5eIgvGWT464GkSq+udIG7lwrD4NSFt+lSHBakBFdFsh
         Lnxw==
X-Forwarded-Encrypted: i=1; AHgh+Rpzuz/IEPVf4wCNHtJFNCdt8CSbQ/ahn4UGFn/aAHGFpGFdgkJF71nLEPxS02pHhl6ZRPhcbANKhqWvwik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV5TiNdYdVFiWbQIneIxlKm1swuKbIystiaf1U3A86jGUvmRH
	GqoviI6UbtU50FinhUf44RK0TaQJ6q/Rx+4U/x50/zoTmxD5MFwKRZ1QMUZTm1jPcHZg5/FCINF
	cQbkB8FNIeDFQb2LMC0rTSQnI00Obistv1WhGkDRt
X-Gm-Gg: AR+sD105/TKPg/vfpCpeDvvUw5pEWsek2+pPvS2mMioghLtrytTmK9UMbP0XyxFvLft
	3OEOz52vYe65xUHYrACaYsol6dvu5FvMQurKFvFVeHt8Gu+IiyD9zgr7IrRHaaOaF39ntrJKqHR
	alMuagZtbT4az2xoPCSOV5qcOfVBC2g9riZqffq2ro396BA7nWRjoCqs9aLYJN16SvVTfK3kk4n
	USezU8jHsXd36lW0W51tj9upcEKpFOZSwOspc06uB2ML/JdrirZgZgwRBNqRPTFoyd3Mh5DDVLE
	Qhd839Ilm2y6RrXfhnFC8sI180FeEkabpE7nIcJzcH7I
X-Received: by 2002:aa7:db55:0:b0:698:ac70:31b9 with SMTP id
 4fb4d7f45d1cf-6a3eb34835bmr2896a12.5.1787005561938; Mon, 17 Aug 2026 15:26:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <20260806233609.212337-22-seanjc@google.com>
 <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru> <aoMVy4VB1sq4T-ys@google.com>
 <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
In-Reply-To: <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 17 Aug 2026 15:25:50 -0700
X-Gm-Features: AcwNN1WdnB6ezAOkUjWvrMa9sQkEiE5NQZNmLUZ6exeGRBIrQHFr5mGJRwWtIb4
Message-ID: <CALMp9eQRW22S6zSrhkxc+8PgSuOJJOB-jh_W1iyr7c0j5SBLow@mail.gmail.com>
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:20=E2=80=AFPM Maksim Davydov
<davydov-max@yandex-team.ru> wrote:
>
>
>
> On 8/17/26 17:08, Sean Christopherson wrote:
> > On Mon, Aug 17, 2026, Maksim Davydov wrote:
> >> On 8/7/26 02:35, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> >>> index 29ca37e9a3bc..f55d0305d1f3 100644
> >>> --- a/arch/x86/kernel/kvmclock.c
> >>> +++ b/arch/x86/kernel/kvmclock.c
> >>> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
> >>>     flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
> >>>     kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> >>>
> >>> -   x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> -   x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_tsc_khz)
> >>> +           x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_cpu_khz)
> >>> +           x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>>     x86_platform.get_wallclock =3D kvm_get_wallclock;
> >>>     x86_platform.set_wallclock =3D kvm_set_wallclock;
> >>>  #ifdef CONFIG_X86_LOCAL_APIC
> >>
> >>
> >> I cannot test this right now as I lack two servers with different CPU
> >> base frequencies, but it seems that this patch might break something i=
n
> >> guests:
> >> After migrating a VM (QEMU + KVM) from a host with one base frequency =
to
> >> another host with a different base frequency, the value in CPUID leaf
> >> 0x40000010 EAX changes and becomes the same as the destination host ba=
se
> >> frequency instead of remaining the source base frequency.
> >
> > That's a bug in whatever is orchestrating the migration, and/or QEMU if=
 QEMU is
> > handing the upper layers a loaded footgun.
> >
> >> The main reason for this behaviour is that setting the TSC frequency v=
ia
> >> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x400000=
10
> >> EAX and these two entities are still not connected.
> >
> > And they never will be.  It's userspace's responsibility to fill the co=
rrect
> > values for 0x40000010.
> >
> > But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both t=
he CPUID
> > leaf and for KVM_SET_TSC_KHZ.
> >
> > kvm_arch_init_vcpu():
> >
> >         c =3D &cpuid_data.entries[cpuid_i++];
> >         c->function =3D KVM_CPUID_SIGNATURE | 0x10;
> >         c->eax =3D env->tsc_khz;
> >         c->ebx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
> >         c->ecx =3D c->edx =3D 0;
> >
> > kvm_arch_set_tsc_khz():
> >
> >     r =3D set_ioctl ?
> >         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
> >         -ENOTSUP;
> >
>
> Agreed.
> However, kvm_arch_set_tsc_khz() is also used at the end of migration
> (qemu_loadvm_state -> cpu_synchronize_post_init).
> So, the new value of env->tsc_khz from the source host can be loaded
> during migration via KVM_SET_TSC_KHZ. However, the frequency in CPUID
> leaf 0x40000010 remains the same as on the destination host (the TSC
> frequency can differ from the source host's frequency). Thus, it's
> possible to have unsynchronized CPUID leaf 0x40000010 when using default
> QEMU parameters.

I don't use qemu, but isn't the qemu solution for this general
situation to mark leaf 40000010H as 'unmigratable'?
