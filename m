Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63D2D5A01
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975695; cv=none; b=aPXH/YQNrWjQJ07FUzRVyBE9tIsRMkhH8llAAauYF86y4ivg+D2wsn+aR2F03Lc8soQZJG38bBq52vRdwa0vZNkSis+0IoqJ0wNbGCjTCGSEy468j2PK2Fx2uUVwYdwhDsH+8d85TovGrXwxBWp9pdHWhk54z23R/S91dbSS6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975695; c=relaxed/simple;
	bh=Z++qbsFvNFaqswUiDPrL5l0cnunUo2XMhKxY3WDiNMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqOPh70pgQD+NzVHeOcYCe/e7e0CLvoYo+fGE8EmosKMexC+8FW3ufa8x5XGzFinBp/lTfqa5SmMcrkC49KvdVWCYwyflokg9NyHbXb4+NmVIjU3UIkk15Bh0x+DjYS49uimiQyN0v0DdBjG9aSukxQl6DwCaFn6b1QHs5LQYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORdAhtmY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORdAhtmY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so39242975ad.1
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786975693; x=1787580493; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+H/tJA5lC7k+sRi7jSoRnwTUnMixNT0suJnv/pAfq4=;
        b=ORdAhtmYXipveW2Wq7ImBMOKczqKUT8Zf54NTcJ6ItDNklv+kxn7gHyh8QG8bN1wIa
         1dlfSQ/f2vNhhg+irOPKgavI0iUGPCzwphAgVVk66DxRW4d/3ES/+H97x1MgbzVWUhsJ
         lnayxiwgYe8+5okMXvV+J3W1eLvPcLjyjo1LSk0ymHqVNyISGOurWyTNv3CFQ8vxW6lt
         klWCND4OxI9T8um+GKvREcmG5fdBBsuHGxG9DB6Cbkq3aLYuqxn91dX0qbtqZoRuIZCa
         ksSfT5pbO6Me658txqCAprJcjNAmedX07633yRXJ6NH9+L2kCLtdQfzv7EP/L8FTPl9N
         gE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975693; x=1787580493;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+H/tJA5lC7k+sRi7jSoRnwTUnMixNT0suJnv/pAfq4=;
        b=kGpLA3mgcKyyJx2EnZ5tg5DqkqCkR885uvd69GqGFcY/SjHeIbENl8NG5VrZ69pid3
         SEAcMBPXtJA4iQXCM0MTOFlJUUf1SWXzgnZ1B36XazsvUDhEAuj2OutOHDjhhNsvKPge
         WLwxiRd/IR8/MHz67GymVY1A4fPXX+KP3TrOgQF1HCbdAssYoOALObfHyiXFftZHitRJ
         2ptQ39ZRT/v6rFKZzBJSwj/8VRa4/36VZWMQDn7nuuR+M7bQcvO2tyZIPiDArt+Qq1TU
         fMtBow/pc0NvoMRXrCTHK/AJBqornkRHyIa63EuXn9LVACPRNb5/qo0TN30z3pm7oFIQ
         1eQA==
X-Forwarded-Encrypted: i=1; AHgh+RqzxTDb21myPb9TK50LTzyd9WDS1PIeaqkvh0/hp5IQWzhI42Qn68TUMkrloReqVeBNgGKomsDT4o9ipQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKXpJEYu7xZ5S5XxAwVmNPalo78f71RWLxhLp3FTu7pq8L3fA
	Yzc3UJCv/A3zIxpc79sPWn+U4s27Dzxoje+6lVrE/iQs3KTqYC2+gP2ThAZn/VUKdTCVPo/orkE
	kMobxtw==
X-Received: from pgcz4.prod.google.com ([2002:a63:7e04:0:b0:c92:29d5:1f29])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d2:b0:3c3:9746:1fcb
 with SMTP id adf61e73a8af0-3cc71dc524bmr27787783637.35.1786975692489; Mon, 17
 Aug 2026 07:08:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 07:08:11 -0700
In-Reply-To: <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <20260806233609.212337-22-seanjc@google.com>
 <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru>
Message-ID: <aoMVy4VB1sq4T-ys@google.com>
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
From: Sean Christopherson <seanjc@google.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
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
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Maksim Davydov wrote:
> On 8/7/26 02:35, Sean Christopherson wrote:
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index 29ca37e9a3bc..f55d0305d1f3 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
> >  	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
> >  	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> >  
> > -	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
> > -	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
> > +	if (!x86_init.hyper.get_tsc_khz)
> > +		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
> > +	if (!x86_init.hyper.get_cpu_khz)
> > +		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
> >  	x86_platform.get_wallclock = kvm_get_wallclock;
> >  	x86_platform.set_wallclock = kvm_set_wallclock;
> >  #ifdef CONFIG_X86_LOCAL_APIC
> 
> 
> I cannot test this right now as I lack two servers with different CPU
> base frequencies, but it seems that this patch might break something in
> guests:
> After migrating a VM (QEMU + KVM) from a host with one base frequency to
> another host with a different base frequency, the value in CPUID leaf
> 0x40000010 EAX changes and becomes the same as the destination host base
> frequency instead of remaining the source base frequency.

That's a bug in whatever is orchestrating the migration, and/or QEMU if QEMU is
handing the upper layers a loaded footgun.

> The main reason for this behaviour is that setting the TSC frequency via
> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x40000010
> EAX and these two entities are still not connected.

And they never will be.  It's userspace's responsibility to fill the correct
values for 0x40000010.

But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both the CPUID
leaf and for KVM_SET_TSC_KHZ.

kvm_arch_init_vcpu():

        c = &cpuid_data.entries[cpuid_i++];
        c->function = KVM_CPUID_SIGNATURE | 0x10;
        c->eax = env->tsc_khz;
        c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
        c->ecx = c->edx = 0;

kvm_arch_set_tsc_khz():

    r = set_ioctl ?
        kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
        -ENOTSUP;

> I saw this behaviour with QEMU 7, but I've checked the code of the
> latest version and it seems that the described behaviour still exists.
> So, in that case, it's possible that with these changes a VM will use
> the wrong TSC frequency from CPUID leaf 0x40000010 EAX if it's migrated
> and then rebooted.
> 
> Putting it all together, after the previous patch ("KVM: x86: Officially
> define CPUID 0x40000010 as PV Timing Info (TSC and Bus)") a new way to
> show the guest that CPUID leaf 0x40000010 is valid should be implemented
> and only then this leaf can be used to get the TSC frequency.

No, there are already non-Linux kernels that consume 0x40000010, e.g. FreeBSD.
In my very strong opinion, if this problematic for a deployment, then that
deployment needs to urgently fix their broken setup.
