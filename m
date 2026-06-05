Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA8390987
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Jun 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682699; cv=none; b=kR/MON4/HFYUa74zXQqnLeCl9FX8UDGO1CvBA2Q8YbKohMJLi/e4uwkHcR4R7jlSTaVF3Zg2vCy9+OTTZDlXVfe4sHxoIiDZuu6s3/z7Vc9zaPK++bKhOBCqPP6iL9BbBqLq0UvYk5tCZv8xK7RyyITbfxMO/BOu01BVwVQ860s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682699; c=relaxed/simple;
	bh=fCJzrdCYp/X/mAcNv+qBAxRieEPHzWXupi+xn0HxO88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rmrzr4Ov4TMnOWRZovXXFXW4cIMhRErcxhtb9Yyhs7kjX8qIK5tVxErMBJTJg6oyErZtvfCG9Nf6CkznUGNnlhl+EDsOII/WEv1yHkwCxwBmcuM7OWGFG27PgyRfyfTBmlD+yh3FyTGHsHw7CND43IVOxwT4BBTbQJN6Pf4tdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhhmGlYp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhhmGlYp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84256bee9a9so1391181b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Jun 2026 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780682696; x=1781287496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOxp1hSLKBpPLL80bFuxK8SsL52R5IjTb2Bqqq35EAY=;
        b=dhhmGlYpvip0/a7ryW+v3le1CZoR0owUaFdjeKTxxdAmZ6EFzJSIQltQYjUpzQSzbW
         YT+6bcnMtwnoOtjT6Nj67UVZj/zSng3g9YmVQOaa/XzhnC3aI+SL4tksqrG9IyNxebnh
         nztPy6A+YKb9ZUkWM+59tEve5m+Q8SNPZHRWEKbkJRG0LvZ/MTBBDc+jHEFwEa1EZ8pa
         1aVC7dD2CIR6KjG+TUil7dNC1vKDi30MGufegGgT4n92YbDMTEA+LDVKtBSinLbWoOoH
         1FLQUzQw1mMaJrVHw7WlpIpMxJupjiIRp0m4lZ7ihHlyVBfm9A4uaQ9sc77w1xJ9TyBt
         H95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682696; x=1781287496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOxp1hSLKBpPLL80bFuxK8SsL52R5IjTb2Bqqq35EAY=;
        b=qIaHakl0wwXsF3TPmUyCbZ1BvysAHgzDg4Zyb1lI5p0EbaRlenMAnY/YM+Ow9WsUDS
         FlUwJ0jHJ7PvSHigA3Qm9qTlaUnQ2/pO0JPRF1M8uEB7DXUiWWavN+Ey8oy6M+eU/uNY
         NPUYHPpmn+pVvYJ6Sh/4NqIzdANfQXfQQ+Cz9GjgsrqKODAT69rpw0lv0uTXggxNbEgw
         DjxZ7rbbMuHT6WYz2l4XBZNHJg5Uhu+rZzvShAGm4whY9hSo1kLOKDqq6bYNOYdulDln
         ZeSa1kBuf7sU6X0Dxymkv9YzDIhIF3o+VPb8WrhI+vUzkQ9OFxbhKOYVv6YP8fpaN5bU
         wHFw==
X-Forwarded-Encrypted: i=1; AFNElJ+zLGDXb+0USv/dByENt4JAjexn2Q3agqU7nDGmqgw0leq3lCROPsrOInJcVMNs2WYdDJH0JKECwU5lpPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7C13NSkJtzsGuc31Hwp60iCxpfw3hkCbcZUI64ZrKQDYHsxi
	K9hpjDDlzp5C1j1q1E2RakJCmj63CyPmKT/hqei+M0c7EmXQ2EQKDuHXFk8M/CIBTACtYTS7VS1
	VO1dO/g==
X-Received: from pfjq2.prod.google.com ([2002:a05:6a00:882:b0:842:1f0e:d24c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:218e:b0:842:4e43:6f6c
 with SMTP id d2e1a72fcca58-842b0fb60bfmr4509683b3a.39.1780682695567; Fri, 05
 Jun 2026 11:04:55 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:04:54 -0700
In-Reply-To: <87fr315fq9.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-2-seanjc@google.com>
 <87fr315fq9.ffs@fw13>
Message-ID: <aiMPxl5vkvJDldi9@google.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if its
 exact timing is known
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Thomas Gleixner wrote:
> On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
> > Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
> > frequency.
> 
> That's misleading because fixed frequency means that the frequency does
> not change, i.e. X86_FEATURE_CONSTANT_TSC is set. But
> X86_FEATURE_CONSTANT_TSC does not imply that the frequency can be read
> from CPUID/MSRs.

Sorry, "if the TSC runs at a known, fixed frequency" would be a better way to
phrase this.

> > In practice, this is likely one big nop, as re-calibration is
> > used only for SMP=n kernels, and only for hardware that is 20+ years old,
> > i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.
> 
> recalibrate_cpu_khz() is only invoked from Intel P4 and AMD K7 CPU
> frequency drivers, which means that's absolutely not interesting and
> neither X86_FEATURE_CONSTANT_TSC nor X86_FEATURE_TSC_KNOWN_FREQ can be
> set on those systems.

It _shouldn't_ be set on those systems, but in the world of virtualization it's
not completely impossible.

> IOW, this patch is pointless voodoo ware.

Would y'all be opposed to adding a WARN?  I don't actually care about P4 or K7
CPUs, but without any reference to X86_FEATURE_TSC_KNOWN_FREQ in
recalibrate_cpu_khz(), the code _looks_ wrong, and so is very confusing for
readers that don't already know that in practice, it's limited to ancient CPUs.

In other words, the point is to document expectations and mutual exclusion, not
to "fix" anything.
