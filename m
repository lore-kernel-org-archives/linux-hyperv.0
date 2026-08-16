Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FF3E2751;
	Sun, 16 Aug 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916445; cv=none; b=fMC4WyJWjuNO4YRY3o2pRfdxsSxYA8vG7OUy2NuOwYhC34uoXeOd5/yas05SLSmsObzOfpgjbmpWxRN8JOTvQoIw/bhSZAzs1XGdh0wulNpHiSQ0XdUdPEq5eehfnAFtF6YHdGsFNOZ16AsSiloaOWEN/30jOnXsy3vsXLnbA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916445; c=relaxed/simple;
	bh=ZB292vkVVNBTKtO9ry3cUjDaGUckWvj4vjdB2SPakNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUztKytc/nGqMHY1bQmiR3eF3o/K2/wui7DylrB1jpQly+zgvBF3oQ+qSpnHcOnfImS3RfZZJIXz29VnI18hlVBaX7K4cbFr9NkwNSHItQ7WUjJqc6BIDhivcTUk/AcYSiI3Dn7DjkLlshciKfI4+so7qkV4eMrla567G7VgZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=1EmW++Up; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="1EmW++Up"
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 4843FC04B1;
	Mon, 17 Aug 2026 00:38:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d7d::1:36] (unknown [2a02:6bf:8080:d7d::1:36])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id dcbpcP7WMGk0-PuYxShe7;
	Mon, 17 Aug 2026 00:38:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1786916322;
	bh=s7HcjQ73f1ZgIcnWaPQZHhDiaXl1DsseYtimaK/ef9o=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=1EmW++UpFleYRX06kyKiftI59lLPaM4PFEKfv9Jmm9rhNokSq1pNou5tw0+HPmPfO
	 qmQ8e3vRCmSD5lH56597DsCXvtLegbox74YhTR3svKed+E/U4G5GxLG1Ac/Cl3q7RB
	 SK6n7VHiAjNBdT+15kEWI/E3qFJUcj3T2QcUTjRI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru>
Date: Mon, 17 Aug 2026 00:38:39 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if
 present
To: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau
 <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd
 <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Michael Kelley <mhklinux@outlook.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-22-seanjc@google.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20260806233609.212337-22-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/7/26 02:35, Sean Christopherson wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In https://lkml.org/lkml/2008/10/1/246 a proposal was made for generic
> CPUID conventions across hypervisors. It was mostly shot down in flames,
> but the leaf at 0x40000010 containing timing information didn't die.
> 
> It's used by XNU and FreeBSD guests under all hypervisors¹² to determine
> the TSC frequency, and also exposed by the EC2 Nitro hypervisor (as
> well as, presumably, VMware). FreeBSD's Bhyve is probably just about
> to start exposing it too.
> 
> Use it under KVM to obtain the TSC frequency more accurately, instead of
> reverse-calculating the frequency from the mul/shift values in the KVM
> clock.  Use the information to get the CPU frequency as well (kvmclock
> feeds in kvm_get_tsc_khz() for both TSC and CPU calibration), as the info
> from CPUID is superior in every way; whether or not kvmclock should be
> overriding CPU calibration in the first place is an entirely different
> question.
> 
> Use the info from CPUID even if the user explicitly disables kvmclock, or
> if it's unsupported.  The PV CPUID leaf has no dependency on kvmclock, and
> is in fact more useful if kvmclock is disabled since the kernel won't be
> able to use kvmclock to derive a derive the TSC frequency.
> 
> Before:
> [    0.000020] tsc: Detected 2900.014 MHz processor
> 
> After:
> [    0.000020] tsc: Detected 2900.015 MHz processor
> 
> $ cpuid -1 -l 0x40000010
> CPU:
>    hypervisor generic timing information (0x40000010):
>       TSC frequency (Hz) = 2900015
>       bus frequency (Hz) = 1000000
> 
> Note!  *Independently* query for non-null get_{cpu,tsc}_khz() overrides so
> that kvmclock doesn't clobber x86_init.hyper.get_cpu_khz() if/when KVM adds
> support for getting the CPU frequency separately from the TSC frequency.
> 
> ¹ https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c
> ² https://github.com/freebsd/freebsd-src/commit/4a432614f68
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/kvm.c      | 33 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/kvmclock.c |  6 ++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5b554e480c0e..8ed02f4f5775 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -49,6 +49,8 @@
>  #include <asm/svm.h>
>  #include <asm/e820/api.h>
>  
> +static unsigned int kvm_tsc_khz_cpuid __initdata;
> +
>  DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
>  
>  static int kvmapf = 1;
> @@ -913,6 +915,21 @@ bool kvm_para_available(void)
>  }
>  EXPORT_SYMBOL_GPL(kvm_para_available);
>  
> +static u32 __init kvm_cpuid_timing_info_leaf(void)
> +{
> +	u32 base = kvm_cpuid_base();
> +
> +	if (!base || cpuid_eax(base) < (base | KVM_CPUID_TIMING_INFO))
> +		return 0;
> +
> +	return base | KVM_CPUID_TIMING_INFO;
> +}
> +
> +static unsigned int __init kvm_get_tsc_khz(void)
> +{
> +	return kvm_tsc_khz_cpuid;
> +}
> +
>  unsigned int kvm_arch_para_features(void)
>  {
>  	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
> @@ -962,6 +979,7 @@ static void __init kvm_init_platform(void)
>  		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
>  		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
>  	};
> +	u32 timing_info_leaf;
>  
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>  	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
> @@ -1009,6 +1027,21 @@ static void __init kvm_init_platform(void)
>  			wrmsrq(MSR_KVM_MIGRATION_CONTROL,
>  			       KVM_MIGRATION_READY);
>  	}
> +
> +	/*
> +	 * If KVM advertises the frequency directly in CPUID, use that instead
> +	 * of reverse-calculating it from the KVM clock data, or worse, trying
> +	 * to calibratate the TSC using an emulated device.
> +	 */
> +	timing_info_leaf = kvm_cpuid_timing_info_leaf();
> +	if (timing_info_leaf) {
> +		kvm_tsc_khz_cpuid = cpuid_eax(timing_info_leaf);
> +		if (kvm_tsc_khz_cpuid) {
> +			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
> +			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
> +		}
> +	}
> +
>  	kvmclock_init();
>  	x86_platform.apic_post_init = kvm_apic_init;
>  
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 29ca37e9a3bc..f55d0305d1f3 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
>  	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
>  	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
>  
> -	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
> -	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
> +	if (!x86_init.hyper.get_tsc_khz)
> +		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
> +	if (!x86_init.hyper.get_cpu_khz)
> +		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
>  	x86_platform.get_wallclock = kvm_get_wallclock;
>  	x86_platform.set_wallclock = kvm_set_wallclock;
>  #ifdef CONFIG_X86_LOCAL_APIC


I cannot test this right now as I lack two servers with different CPU
base frequencies, but it seems that this patch might break something in
guests:
After migrating a VM (QEMU + KVM) from a host with one base frequency to
another host with a different base frequency, the value in CPUID leaf
0x40000010 EAX changes and becomes the same as the destination host base
frequency instead of remaining the source base frequency.
The main reason for this behaviour is that setting the TSC frequency via
ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x40000010
EAX and these two entities are still not connected.
I saw this behaviour with QEMU 7, but I've checked the code of the
latest version and it seems that the described behaviour still exists.
So, in that case, it's possible that with these changes a VM will use
the wrong TSC frequency from CPUID leaf 0x40000010 EAX if it's migrated
and then rebooted.

Putting it all together, after the previous patch ("KVM: x86: Officially
define CPUID 0x40000010 as PV Timing Info (TSC and Bus)") a new way to
show the guest that CPUID leaf 0x40000010 is valid should be implemented
and only then this leaf can be used to get the TSC frequency.

-- 
Best regards,
Maksim Davydov

