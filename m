Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9142D758
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054691; cv=none; b=L8MqDQTENPWBH2zsU4mrmlcC+muYSrsUEzTIyM2OKwm9kANKiFSaKjIitz7EOmfhpf/4dFip7ouTxrWKkB1QXYV7hfQyUMUQrYLU6ZqBo1u6SQKLrm0xApZJw7O87P/WxuOZJvylS7v5K+HlUu5PqbOzIQ4hywVJSuBJd39CAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054691; c=relaxed/simple;
	bh=on3mRg2u5XTVO1NtPed6Wnq5su/1HFfJAZ0A5V6XV54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NAwWXaQxca7AOvn4FBPBOuPeQWbt5WswZQqVuMf4hUV/Z+2WJ4ARPeev0IlqCGbZF4FoSaN54YpZOPg5wlw6QWlnJI0wNNW6znGU5Uj8Ar1tc4O6szaAAh3UhZQnjsO6k2ogV1nAF+E4IeCyga/ri9IhV85oQ3UM+J7TP3LkP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0zyvnWr; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0zyvnWr"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485d853b08so4546513b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054686; x=1786659486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/BEVvi4/7i6XDSu/QYDIwcuZoEPs9pbAb29S0DeOBes=;
        b=c0zyvnWrdAFI8VFr+T7yfPo4tTie0zkMyU5vE9IpFpQ0bnMIrYNe7D0NVU015/CXq7
         tTbpg+GiP1jxYehCF2k+ss1WmL9zCZkVS/XP0JucnBtnbFrZkun5/zwtPKeVvswIcv0x
         9OXKkSojC+SITbl2r6dWFilo0SBjtSgUXGY7YnzSHnPU836SD7nqqW9ITYT/jJd2JfJs
         YEHVrb3r0enPzU2kmPfGXFNmXi/PHHzpE2fxx1rujcOQQ7gqf5oljFESaE7Lq4tlkZTn
         WgYMlIoEKzbDMturQFbG5GZceqZ9xgZGT0PW3z3gR7B9CbY4okSoPvvfuMih1H9+/ciy
         UOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054686; x=1786659486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/BEVvi4/7i6XDSu/QYDIwcuZoEPs9pbAb29S0DeOBes=;
        b=b6NcWvpfdjyzVvSRVLJyZ6RftHY9ZU4YcI9fOzMgZO+Jq2trdLfk5Esw2oMH9c61pt
         BJUkcBx4AvtROdvLzUZix44xc+kltszG1YU+j/fOQ1C33gdimmECjtB87tx7lCInll00
         yY+KTbf7XAH2F+RQiG2tZaapi05FLsKFH0rAZ+j86dYOk8mpbWKYVsbMJC1eMy7xt9oG
         t8Rk3GKpO2N5YSa1hjqbZ93I62PRO24ntqZB0smkxidu/Ha9JcK4W3NPI1O46fjPUYH/
         gwFt2qWuIXQgtMOuF8+PLx25zcDIdQleU0YGbjIyCEgQAiP6jG/WLs+Q+qbzhyZyPwI9
         7+Bg==
X-Forwarded-Encrypted: i=1; AHgh+RrDPAcfZ7olgeNV6+lwEYhhkQrtG1xulRCu0i3lTDf3Ngsf7lYP0Ev8tn/sHesFx9tChX8mzRCml1VVbN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGPObzYEGYfjOWRhmhlGUcliB0aHx5YlxPx5WJL5VzkhCjr4N
	FArvB95xmo9pD2E18kkIZVaCMQC0xdlAAZkJafsoTocGbapeHyWNuNZB1W7cVJMPJzvO6hp6Ern
	HVPOhfQ==
X-Received: from pfbln15.prod.google.com ([2002:a05:6a00:3ccf:b0:848:5415:1869])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0f:b0:848:3f07:c5a2
 with SMTP id d2e1a72fcca58-84f2dfd0a06mr18297213b3a.4.1786054685697; Thu, 06
 Aug 2026 15:18:05 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:18:05 -0700
In-Reply-To: <SN6PR02MB4157453D405AB80859B12DF9D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-48-seanjc@google.com>
 <SN6PR02MB4157453D405AB80859B12DF9D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <anUIHY-1_q3oVFPf@google.com>
Subject: Re: [PATCH v5 47/51] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 02, 2026, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, July 1, 2026 12:32 PM
> > 
> > Silently ignore attempts to switch to a paravirt sched_clock when running
> > as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
> > hypervisor could attack the guest by manipulating the PV clock to affect
> > guest scheduling in some weird and/or predictable way.  More importantly,
> > reading TSC on such platforms is faster than any PV clock, and sched_clock
> > is all about speed.
> > 
> > Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kernel/tsc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 012321fed5e5..a146fc7b5e74 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
> >  int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
> >  				      void (*save)(void), void (*restore)(void))
> >  {
> > +	/*
> > +	 * Don't replace TSC with a PV clock when running as a CoCo guest and
> > +	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
> > +	 * which isn't in the guest's TCB.
> > +	 */
> > +	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
> > +	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
> > +		return -EPERM;
> 
> Do a pr_warn() in the error case? Your commit message says to do the ignore
> silently, but I wonder if that's a good idea. At least for Hyper-V, the error
> case shouldn't happen.

I agree it's not a great idea, but unfortunately it's pretty much guaranteed to
fire on KVM-based setups.  The KVM world hasn't been anywhere near as aggressive
as Hyper-V in terms of killing off PV features when running SNP/TDX guests (which
is largely how this series came to be in the first place).

So while I'm conceptually not opposed to the idea of printing an error message,
in practice I'm pretty strong against it because odds are very good I'll end up
dealing with "bug" reports due to less-than-awesome setups.
