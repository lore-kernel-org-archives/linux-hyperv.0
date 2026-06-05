Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B444A724;
	Fri,  5 Jun 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689102; cv=none; b=qHbyfQWCkWnqYaU3oaDdvJOU6DvTFtOJY4yIZQtR3pq0gGB2arott2i0YEmBcLC+t+aUK3uCiQXhKgkpB+Ck0tLqPETnLSIVMzdPO6h3arv9itjzz1f2L83311965OFRLV5M2al1mDQ4qoeF4MTdmEpMz2ON0jQbsIH7jofZ4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689102; c=relaxed/simple;
	bh=nyCCfHlezDTGlkFVHqBKpPLP7Re1FMEtAy1uM5EiH7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2G+bcaXJ4rkbXeayboviW8k3fmMkgICnTJ80ZJDvmT7DPCnc8moo6tembz0Wo6kNDMj5+zzTMz634vxAAqul/Y6VaFNV/fjPMWGhkbyn/0q8mwTNr9bK4ZynR+p9rcYMiwDW2OEdLTQaKHkvT1Pq0Hm0Qi4ohYJhQxkMkREPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJKk9HX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJKk9HX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE31F00893;
	Fri,  5 Jun 2026 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780689101;
	bh=/4/R21/fqtDVS3dMxk8YUcZsiYIZNFflJGsvUsdqCpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HJKk9HX+g5UPbatALcVIkf0hR4ph+0Wx8iYP9GEhI83XdOxXt7ZFz/GyAcdNSqC3b
	 59tx5s2p8e97ACe09fjCrUGDsFH0mUGYy6hjREF82KGE5tE3NRoM2KruI4GtHlI4zf
	 9JzxtgHFG+ngZyRIRnCNTlILcrBvBhmuDuMhpklDDYDJvC7XRvgVA6xfP46bUmOz7Q
	 DvD8utVSK+xnYsPP5vFZO758kEbbdtewrTCb2MLyAHXLoJqapxPvfVQRwAWSsiuX7l
	 5hn4/v5jowzGbNQzjCTmK+bZEv5FiaP+Dh9Aalw1jf8a8vDBqU3s5PlzLhytckiQry
	 oZh4Oqjmh3P1Q==
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
In-Reply-To: <aiMPxl5vkvJDldi9@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-2-seanjc@google.com> <87fr315fq9.ffs@fw13>
 <aiMPxl5vkvJDldi9@google.com>
Date: Fri, 05 Jun 2026 21:51:38 +0200
Message-ID: <87a4t86a0l.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 05 2026 at 11:04, Sean Christopherson wrote:
> On Fri, Jun 05, 2026, Thomas Gleixner wrote:
>> On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
>> > Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
>> > frequency.
>> 
>> That's misleading because fixed frequency means that the frequency does
>> not change, i.e. X86_FEATURE_CONSTANT_TSC is set. But
>> X86_FEATURE_CONSTANT_TSC does not imply that the frequency can be read
>> from CPUID/MSRs.
>
> Sorry, "if the TSC runs at a known, fixed frequency" would be a better way to
> phrase this.
>
>> > In practice, this is likely one big nop, as re-calibration is
>> > used only for SMP=n kernels, and only for hardware that is 20+ years old,
>> > i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.
>> 
>> recalibrate_cpu_khz() is only invoked from Intel P4 and AMD K7 CPU
>> frequency drivers, which means that's absolutely not interesting and
>> neither X86_FEATURE_CONSTANT_TSC nor X86_FEATURE_TSC_KNOWN_FREQ can be
>> set on those systems.
>
> It _shouldn't_ be set on those systems, but in the world of virtualization it's
> not completely impossible.
>
>> IOW, this patch is pointless voodoo ware.
>
> Would y'all be opposed to adding a WARN?  I don't actually care about P4 or K7
> CPUs, but without any reference to X86_FEATURE_TSC_KNOWN_FREQ in
> recalibrate_cpu_khz(), the code _looks_ wrong, and so is very confusing for
> readers that don't already know that in practice, it's limited to ancient CPUs.
>
> In other words, the point is to document expectations and mutual exclusion, not
> to "fix" anything.

Fair enough.

So yes, having a check there for actually X86_FEATURE_CONSTANT_TSC
(X86_FEATURE_CONSTANT_TSC is not interesting) and emitting a warning and
returning early is the right thing to do there.

But we also should have a check in the TSC init code somewhere which
validates that X86_FEATURE_CONSTANT_TSC is set when
X86_FEATURE_TSC_KNOWN_FREQ is set. X86_FEATURE_TSC_KNOWN_FREQ is useless
w/o X86_FEATURE_CONSTANT_TSC.

Thanks,

        tglx


