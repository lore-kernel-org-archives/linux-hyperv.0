Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FA371CE6;
	Fri,  5 Jun 2026 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662818; cv=none; b=I3vNu2lO/qi9Ch8mVC+8gTE8dV0Kx0rQPnjTpj3s70mYFioMQPUip+KA8upOmDoLoUaJBCYxBtsnSPaBYuKQ8ruPs3lJwLM7mG527r3WdAZpIglLK/IO8mPyLCfvQuBIkJAlvtobD6vvxy908pebO6e6QEyTZ6MrbGkdvBKdHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662818; c=relaxed/simple;
	bh=qf5drNVbfjiyqun/6twX6dsS58RoE5Z2+L/qXXwmUeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckmRJYa11mpDYNAfrZ13w5sZXUPP1Rtt2bCWp4g9IYyxAwQ1WC/lIyT3o0h+M5TJvs9b57Eo+ZNgXq29INcO7gw1C42t3AzBeuCGpdaenqs+NcBeCNl+k1XmDAbm7WUBMp6b4TD105YZLvlwH5sNmAhNmSu5JwoMlR+0GeLN3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biVHvO6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biVHvO6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3511F00898;
	Fri,  5 Jun 2026 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662817;
	bh=Bt6OT0/VKhphh3HzvyFQdhPrJoF2vdMvqgs31u2+MPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=biVHvO6L31ky0DbhkuxtmImICmlXKP2o3OOF5xVHa1tc098wBX1/8D0U6NRSAf9rU
	 UlsP63nvrDyBlVYwUJcuAnujyoNQ95whuvY+bxaawMtNzpCnwEgWQG9+8u42DTkSSe
	 9hyPT7fEUrW04s8KALcwsFNNMbFDLxDgZq1Nb08Kj94hN23fq7QZ7Y7h9I6l9dbKdO
	 8bFYyDz3BH1KgWZzgZlBp9yzM5NPcwaf0meH8bgEH3e2pkctUJ/aFFBRVz2loNKWNl
	 BrCqWfY0ReG2TSOUagWxFiBQP66Fg2udQzTY+TxTNPa5tbV+j0qLaLI1k8ShJ/LI0K
	 XOACtKWJ8Suxw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if
 its exact timing is known
In-Reply-To: <20260529144435.704127-2-seanjc@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-2-seanjc@google.com>
Date: Fri, 05 Jun 2026 14:33:34 +0200
Message-ID: <87fr315fq9.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
> Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
> frequency.

That's misleading because fixed frequency means that the frequency does
not change, i.e. X86_FEATURE_CONSTANT_TSC is set. But
X86_FEATURE_CONSTANT_TSC does not imply that the frequency can be read
from CPUID/MSRs.

> In practice, this is likely one big nop, as re-calibration is
> used only for SMP=n kernels, and only for hardware that is 20+ years old,
> i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.

recalibrate_cpu_khz() is only invoked from Intel P4 and AMD K7 CPU
frequency drivers, which means that's absolutely not interesting and
neither X86_FEATURE_CONSTANT_TSC nor X86_FEATURE_TSC_KNOWN_FREQ can be
set on those systems.

IOW, this patch is pointless voodoo ware.

Thanks,

        tglx
