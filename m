Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961655293A
	for <linux-hyperv@vger.kernel.org>; Thu, 10 Sep 2026 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063159; cv=none; b=c3slCf3YeFipYlsHsru3xo6FTN3LLbHjaKHdaRVOYRycbp1WocMsRUJ8cHCZIGSbRqvrD2QZgtFAT4YSi7Qm8M0TlFyU2j0pzbTxXlN1Wq8KcBg5HWpA+2j/+CkQwmOZZsm8Fun135ZWW7+h2upYPBBZqGijwEpjb1yW5UEfl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063159; c=relaxed/simple;
	bh=iihdVpeTD7xqvFs81N5pzrr3yHNO8lXqn++m5NS1tpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GS9aPbE9EbFZy6leO0dyYlqdcwPCiErS9YGm8nBbgz9oAAnXRQzuIoLWW1x3Asi2WIVsgN6MLXP5ElcniXKVdoDEJKIKov9kP74vjAhu+hCsExFTUyi1exhooWeyJwtY+qu3S4X2Cz/Rd2iGGzyP9OO67x1JPgjfKcJCT0WuDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qp0PeyC1; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qp0PeyC1"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so115518955ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Sep 2026 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789063157; x=1789667957; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdUk7xT6Q2S0XYOIdYUuypvFM5moeaGi7+AJeTxN8N4=;
        b=Qp0PeyC1s/TlCYvWFn3xsZc47//NfWkIAzttYA+mbNnTss7pmMXJpRYv4tU+ObTZN+
         x680/ndDKtd4iof2E5/Npt/XrEqItRPArY0pUeRjKh5RvXjdCqn0ssDE9bCrX9UFjShk
         DpNQ+mSlH+FyvQKJYI9+11ES0TOChqQk3jfmF93W8v5rk77jOoDfdiq8uN91LZgjOE2B
         dOMDDM9j3So7ee/tFy9tEIRtpd/YOEokwpbVSIWJqvedhbsZLD1DkkuKNcPS/vdiVGdj
         c9l/hiXm+Z6gTnufOs+N9ybQmPtk0sCF9wEOpWNaSu/khgVuVxJwMn+MooE2lbgxZG0K
         4yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063157; x=1789667957;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdUk7xT6Q2S0XYOIdYUuypvFM5moeaGi7+AJeTxN8N4=;
        b=dF0/KoutFmNJkY5V9QFN8EdIY3jpfyVk+InUnFNOVeHu1py6gQHpxug1ca8aj70x6k
         aePcZwalVoTdCRRbFzKEUI4Q2S0VOChk/9K62M8rx7qT2cZYXE7xDFUWjZ0y9SO72yS/
         yszaUdVi+kC+8P7E9h1WHDPvXKCEUbikUr0Fx/TQ45pbbpyPdDLtHQ32mvaj5dGbCp8t
         +xraYKGQc3N0gZL9VgTtJD1QpApLNIu91A/XLbfYzuDlIOOI7x07F9U8ncGrtnIxayGe
         PHLVcn96f021DKEVYwxFhqm+AqS9uJfuKY60398X941fV9deHfP4t7TOG/ZemyLNofod
         Ithw==
X-Forwarded-Encrypted: i=1; AKwUvBy8nvaAXSkrIQdhzUxKllMUfrKreUI/2jWwOzQeB55l7xs+AitZJrL86gJmlDF7f4/LPQQDBjQXvN/kiaE=@vger.kernel.org
X-Gm-Message-State: AFuF++l4HEjwMERwSeOFh3E6FrmECkJ943SiBokKH7C6wtCe7tvmQnLL
	D+P41Qg6U9tfCIyBJUO4CHEQ6oJ+2H/gJeEgT2TGMXQfJYDAjiqymYT9ahfswLmoamCALidZtGz
	TwsX7gQ==
X-Received: from pleg13.prod.google.com ([2002:a17:902:e38d:b0:2c9:b703:3bfb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8b:b0:2d7:2edd:d140
 with SMTP id d9443c01a7336-2dd2a1c3e42mr9017035ad.3.1789063156725; Thu, 10
 Sep 2026 10:59:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:59:16 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
Message-ID: <aqLv9GwBNymyHs8q@google.com>
Subject: Re: [PATCH v6 00/51] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

On Thu, Aug 06, 2026, Sean Christopherson wrote:
> The primary goal of this series to fix flaws with SNP and TDX guests where a
> PV clock provided by the untrusted hypervisor is used instead of the secure
> TSC that is controlled by trusted firmware.
> 
> The secondary goal is modernize running under KVM.  Currently, KVM guests will
> use TSC for clocksource, but not sched_clock.  And Linux-as-a-KVM-guest doesn't
> support paravirt enumeration of the TSC/APIC frequencies, even though QEMU
> provides that information by default.
> 
> The tertiary goal is to clean up the PV clock code to deduplicate logic across
> hypervisors, and to hopefully make it all easier to maintain going forward.
> 
> The quaternary goal is to clean up the TSC calibration code, which was made
> stupidly hard to follow by hypervisor code mixing in with the native
> calibration routines, instead of being implemented as a pure alternative.
> 
> Note, the VMware and Xen changes still probably should get acks from those
> maintainers, as my understanding of what they're trying to do may be flawed.

This (thankfully) still applies cleanly.  What can I do to help move this forward?
