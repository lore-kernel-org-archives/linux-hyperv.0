Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3426ED4F;
	Mon, 17 Aug 2026 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004989; cv=none; b=gvhM1R8C8JBIqNCawutMlBXdwxzUxQTIW7uCO1l7DRwL1VD65lFgoCKypTQIsSjsAKBtWoHGuZnpdqaM8TzzvM6mzt3Blqrjfo59hhLrl05R2xt+AfPkFMo1XCO0xU7+95ozhAnz1oLNzzuC/f9NCTOtc6gWf8BLOqSmke1B5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004989; c=relaxed/simple;
	bh=0pp1Vxu+goQlHbq1pQ07TMz1QvRgRhvkA4HKqSMY60U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgbL9B/6PAwIkGTE5tEC0qswymAtnB70rVmDOBVe28jTrad0mifWAG9N3cOf1k+I70ttakuQ/oSfZCWzSTlfQ20NQxEHvcnQoDWXK99kdA9sBqbwVsijhAdu7OvI2bq+2Z3abc4JIihxw14VNdKtsg7Tt9wax+KU1v1cwvuBog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Bqo7B2+O; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Bqo7B2+O"
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
	by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id DB311C0A13;
	Tue, 18 Aug 2026 01:16:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:636::1:14] (unknown [2a02:6bf:8080:636::1:14])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id AGdauh9aNOs0-b6cs1GW7;
	Tue, 18 Aug 2026 01:16:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787004974;
	bh=b0Z0/tXuCNUd1fMwZ+IpDj+Wo0HtUhiZ0PxFs9YzGJE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Bqo7B2+OcvbL6jkoeu5ZtQ58ESgMa5yx1X9ZY/km3cBov6qCeQ5SDsgsZ0U86Rt5d
	 uYvDSlYKTy4SV0n31y+JkkPZM+aJbk85EmEmmi+5ZG2KRLadsxdZofEw9k/LGvaPc2
	 rA3R7E8/1y06BWknqf88/HkaFxTe9jLnAMqszcpg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
Date: Tue, 18 Aug 2026 01:16:10 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if
 present
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
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
 <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru>
 <aoMVy4VB1sq4T-ys@google.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <aoMVy4VB1sq4T-ys@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/26 17:08, Sean Christopherson wrote:
> On Mon, Aug 17, 2026, Maksim Davydov wrote:
>> On 8/7/26 02:35, Sean Christopherson wrote:
>>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>>> index 29ca37e9a3bc..f55d0305d1f3 100644
>>> --- a/arch/x86/kernel/kvmclock.c
>>> +++ b/arch/x86/kernel/kvmclock.c
>>> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
>>>  	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
>>>  	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
>>>  
>>> -	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
>>> -	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
>>> +	if (!x86_init.hyper.get_tsc_khz)
>>> +		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
>>> +	if (!x86_init.hyper.get_cpu_khz)
>>> +		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
>>>  	x86_platform.get_wallclock = kvm_get_wallclock;
>>>  	x86_platform.set_wallclock = kvm_set_wallclock;
>>>  #ifdef CONFIG_X86_LOCAL_APIC
>>
>>
>> I cannot test this right now as I lack two servers with different CPU
>> base frequencies, but it seems that this patch might break something in
>> guests:
>> After migrating a VM (QEMU + KVM) from a host with one base frequency to
>> another host with a different base frequency, the value in CPUID leaf
>> 0x40000010 EAX changes and becomes the same as the destination host base
>> frequency instead of remaining the source base frequency.
> 
> That's a bug in whatever is orchestrating the migration, and/or QEMU if QEMU is
> handing the upper layers a loaded footgun.
> 
>> The main reason for this behaviour is that setting the TSC frequency via
>> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x40000010
>> EAX and these two entities are still not connected.
> 
> And they never will be.  It's userspace's responsibility to fill the correct
> values for 0x40000010.
> 
> But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both the CPUID
> leaf and for KVM_SET_TSC_KHZ.
> 
> kvm_arch_init_vcpu():
> 
>         c = &cpuid_data.entries[cpuid_i++];
>         c->function = KVM_CPUID_SIGNATURE | 0x10;
>         c->eax = env->tsc_khz;
>         c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
>         c->ecx = c->edx = 0;
> 
> kvm_arch_set_tsc_khz():
> 
>     r = set_ioctl ?
>         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
>         -ENOTSUP;
> 

Agreed.
However, kvm_arch_set_tsc_khz() is also used at the end of migration
(qemu_loadvm_state -> cpu_synchronize_post_init).
So, the new value of env->tsc_khz from the source host can be loaded
during migration via KVM_SET_TSC_KHZ. However, the frequency in CPUID
leaf 0x40000010 remains the same as on the destination host (the TSC
frequency can differ from the source host's frequency). Thus, it's
possible to have unsynchronized CPUID leaf 0x40000010 when using default
QEMU parameters.

>> I saw this behaviour with QEMU 7, but I've checked the code of the
>> latest version and it seems that the described behaviour still exists.
>> So, in that case, it's possible that with these changes a VM will use
>> the wrong TSC frequency from CPUID leaf 0x40000010 EAX if it's migrated
>> and then rebooted.
>>
>> Putting it all together, after the previous patch ("KVM: x86: Officially
>> define CPUID 0x40000010 as PV Timing Info (TSC and Bus)") a new way to
>> show the guest that CPUID leaf 0x40000010 is valid should be implemented
>> and only then this leaf can be used to get the TSC frequency.
> 
> No, there are already non-Linux kernels that consume 0x40000010, e.g. FreeBSD.
> In my very strong opinion, if this problematic for a deployment, then that
> deployment needs to urgently fix their broken setup.

-- 
Best regards,
Maksim Davydov

