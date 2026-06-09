Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28E40D563;
	Tue,  9 Jun 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033241; cv=none; b=ZvJesJiFIUXFlLDampdEzu+7GP/D17kTBcL1fsK2IMMTvKLIxJsO3ovVRKOiIrWJwk3kcT8pRVrPWTRl2eaYkoytpjpQ4O3p56bzQcT7VK91i9vcXGI+ORUy2BB7sLpRkR67TBbkIb8R7+GB4UPZlpqweG3o3X0lNgHDFYWkwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033241; c=relaxed/simple;
	bh=t+WvsS2QinBoSI2OXuMQMgk8edo+7KuSw0OLqOxN6Rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IVgU5P6rmoZciOVsOTN3IRAWS55dc6O39hgR80XPKrGSni9c4h4+dRonQasdjLJXZB9rWtC8EjQt8XAc3HphLtbfjAKw5fDioc5TrRgHk/tRD16oBtsuwyrR/CpWmTKyE4CfDElbAbEnA4WUbXyP5WYsXFiYVQSwZzWpxprIbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oStFu7N1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oStFu7N1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2361F0089A;
	Tue,  9 Jun 2026 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033239;
	bh=NlG5HlDElQCbuP6bN10xR/q116+/zHdLSEjJOyQFwVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oStFu7N1msk7hGRxaIGxcPhSkCbArM8aV/psZO+WarZaxilvwF2cpbMRAt4n7Fpb8
	 jdoLMC/Us2am6UlMm/XjVRtHxd9CKSOXzbAPqtoDlCiOpZbpOFQ+SdLvuk0GQ7AACZ
	 3CmrygZjXjo8BSZ2RdYoEHPzauVhH2OoyWisV2Oubk42MoerR11HkIf28Ex0JbwmFs
	 FQo5z4rMOOXRCRjhYFFjZN0UvGaCt0DcbGJcLs9foFY3WZlZjLxuhnEKgDEnd+uRNU
	 itpIBzoF6ZpH4lsa9xtkX9k8gZsXaOt9VgUNb/27eAHzLLvBE62W766RQhGapY7M0m
	 b9tzm1j9ME+sA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if
 its exact timing is known
In-Reply-To: <aihKj-0nP7bUbNHH@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-2-seanjc@google.com> <87fr315fq9.ffs@fw13>
 <aiMPxl5vkvJDldi9@google.com> <87a4t86a0l.ffs@fw13>
 <aihKj-0nP7bUbNHH@google.com>
Date: Tue, 09 Jun 2026 21:27:17 +0200
Message-ID: <87pl1z346i.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 09 2026 at 10:17, Sean Christopherson wrote:

> On Fri, Jun 05, 2026, Thomas Gleixner wrote:
>> On Fri, Jun 05 2026 at 11:04, Sean Christopherson wrote:
>> But we also should have a check in the TSC init code somewhere which
>> validates that X86_FEATURE_CONSTANT_TSC is set when
>> X86_FEATURE_TSC_KNOWN_FREQ is set. X86_FEATURE_TSC_KNOWN_FREQ is useless
>> w/o X86_FEATURE_CONSTANT_TSC.
>
> Ugh, any objection to punting on this for now?  KVM and Xen guests will trigger
> TSC_KNOWN_FREQ without CONSTANT_TSC, thanks to commits:
>
>   e10f78050323 ("kvmclock: fix TSC calibration for nested guests")
>   898ec52d2ba0 ("x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()")
>
> Hyper-V guests might as well?  Hyper-V's handling of TSC is weird, even for a
> hypervisor.

Hypervisors are ranked by weirdness? I ranked them by insanity so far.

> Even when the frequency is provided in CPUID by the hypervisor, QEMU at least
> requires a fairly explicit opt-in to advertise CONSTANT_TSC, presumably to try
> to prevent users from shooting themselves in the foot.

Bah. We really should have enforced the dependency when we introduced
KNOWN_FREQ. But that ship has sailed.

Though for correctness sake this should be fixed at some point in the
foreseeable future.

Thanks,

        tglx
