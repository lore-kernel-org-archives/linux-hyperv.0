Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFD3E7BBF;
	Tue, 18 Aug 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046257; cv=none; b=aB2IbU74UJJMEdw/8Mv2Fp164yULavDahRI+d6Xl2A8bYzAuc0UgWSpe7qXmQRhXEZA0ucgD2y91lPqEUlvRo+7gzQ1qbON1CiI3EGbygrA+dl+8pqeE84ZRn3cIrvHCMLO4br9jOpc9a/cRkYDT7ZyGd8rtFWbZEiPYRLZRAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046257; c=relaxed/simple;
	bh=rP7yIhRki338B9YGCEEb79tX8MTt8unZzk1h1CLQ5CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHTexHDh/rKIpAThybthUjFBLxja6rvttYSuX7FIsWya3fy0VGuKVjH02UlHlfbzVCBEenMm7Eet4KVO9pogP7SEdxRHvGFQWZrbfP+x5/TPAY+ihj6H0DAtUy3KpRkehz2IgtS5R9eZhTwDhAtmnSqLKH6pBsu0sDh65lCo8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=KBJ1mDiE; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KBJ1mDiE"
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:118b:0:640:b49:0])
	by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 6D52F80AD6;
	Tue, 18 Aug 2026 12:42:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:636::1:14] (unknown [2a02:6bf:8080:636::1:14])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id 6gRfrm0eGeA0-HnMFl5RT;
	Tue, 18 Aug 2026 12:42:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787046129;
	bh=o/IysMWmyL9LUdYg5QZLrssRFGKPRJkTzu4baxWXaZg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=KBJ1mDiEsA2ZbXz6LAiDf7sMjQBUnZHmD6q7NN4aApX9W9cwYLnw+/PkEj1rU5g0O
	 wmOVMdLrswWWfOlsuS6Zbc0aNo6B+EP7xCK/0dM6B7zp71WV22pr6Xi2ufD9MxpSZR
	 GhjGRNk9STz4esdKjMLB6QrbrNeJuE1j1slK1PkU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <52aed8f2-02e1-4ef5-a6bb-7010e0dda488@yandex-team.ru>
Date: Tue, 18 Aug 2026 12:42:06 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if
 present
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau
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
 <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
 <CALMp9eQRW22S6zSrhkxc+8PgSuOJJOB-jh_W1iyr7c0j5SBLow@mail.gmail.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <CALMp9eQRW22S6zSrhkxc+8PgSuOJJOB-jh_W1iyr7c0j5SBLow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/18/26 01:25, Jim Mattson wrote:
> On Mon, Aug 17, 2026 at 3:20 PM Maksim Davydov
> <davydov-max@yandex-team.ru> wrote:
>>
>>
>>
>> On 8/17/26 17:08, Sean Christopherson wrote:
>>> On Mon, Aug 17, 2026, Maksim Davydov wrote:
>>>> On 8/7/26 02:35, Sean Christopherson wrote:
>>>>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>>>>> index 29ca37e9a3bc..f55d0305d1f3 100644
>>>>> --- a/arch/x86/kernel/kvmclock.c
>>>>> +++ b/arch/x86/kernel/kvmclock.c
>>>>> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
>>>>>     flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
>>>>>     kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
>>>>>
>>>>> -   x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
>>>>> -   x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
>>>>> +   if (!x86_init.hyper.get_tsc_khz)
>>>>> +           x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
>>>>> +   if (!x86_init.hyper.get_cpu_khz)
>>>>> +           x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
>>>>>     x86_platform.get_wallclock = kvm_get_wallclock;
>>>>>     x86_platform.set_wallclock = kvm_set_wallclock;
>>>>>  #ifdef CONFIG_X86_LOCAL_APIC
>>>>
>>>>
>>>> I cannot test this right now as I lack two servers with different CPU
>>>> base frequencies, but it seems that this patch might break something in
>>>> guests:
>>>> After migrating a VM (QEMU + KVM) from a host with one base frequency to
>>>> another host with a different base frequency, the value in CPUID leaf
>>>> 0x40000010 EAX changes and becomes the same as the destination host base
>>>> frequency instead of remaining the source base frequency.
>>>
>>> That's a bug in whatever is orchestrating the migration, and/or QEMU if QEMU is
>>> handing the upper layers a loaded footgun.
>>>
>>>> The main reason for this behaviour is that setting the TSC frequency via
>>>> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x40000010
>>>> EAX and these two entities are still not connected.
>>>
>>> And they never will be.  It's userspace's responsibility to fill the correct
>>> values for 0x40000010.
>>>
>>> But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both the CPUID
>>> leaf and for KVM_SET_TSC_KHZ.
>>>
>>> kvm_arch_init_vcpu():
>>>
>>>         c = &cpuid_data.entries[cpuid_i++];
>>>         c->function = KVM_CPUID_SIGNATURE | 0x10;
>>>         c->eax = env->tsc_khz;
>>>         c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
>>>         c->ecx = c->edx = 0;
>>>
>>> kvm_arch_set_tsc_khz():
>>>
>>>     r = set_ioctl ?
>>>         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
>>>         -ENOTSUP;
>>>
>>
>> Agreed.
>> However, kvm_arch_set_tsc_khz() is also used at the end of migration
>> (qemu_loadvm_state -> cpu_synchronize_post_init).
>> So, the new value of env->tsc_khz from the source host can be loaded
>> during migration via KVM_SET_TSC_KHZ. However, the frequency in CPUID
>> leaf 0x40000010 remains the same as on the destination host (the TSC
>> frequency can differ from the source host's frequency). Thus, it's
>> possible to have unsynchronized CPUID leaf 0x40000010 when using default
>> QEMU parameters.
> 
> I don't use qemu, but isn't the qemu solution for this general
> situation to mark leaf 40000010H as 'unmigratable'?

I don't think this leaf should be unmigratable by default. I think the
same logic as for `invtsc` can be implemented:
If the TSC frequency is explicitly specified via `-cpu`, CPUID leaf
0x40000010 is migratable because `env->tsc_khz` during
`kvm_arch_init_vcpu()` on the destination host will be the same as on
the source host. But if the TSC frequency isn't specified, CPUID leaf
0x40000010 has to be omitted from `KVM_SET_CPUID2`.

