Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEF3B6348
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936793; cv=none; b=YNWHRlMumiONmuR0WrXSRpgyk5wo3B98xCuCfdxthxF50dBcaaeruvyz0ZPo53MVpVg4pwMiWsgt/M+bynS0/KgJyfP8Rs9Rs5bNEYc6/adcxIiQplUTwvT+bJ+FDGk3R0d9yMAWUWtxZ3veRFQ95OeHkAI692sZDmE31eknwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936793; c=relaxed/simple;
	bh=cF/jjZEyvGUvgS6uTcZoamdwydDhtZu3BqFwF+APe0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2tSAQgnFSk5QLx1TFTlX2OstAOc7DRDnrj23LD01ZRu16yGJ/CBexHwmzp5jceRtSj9e3o0tJpkSslqcvi59VUTIIqiIiWBTDOql9oA9cjwx2CCpDkxQiBlF9tp02F+xRPUkhTspL66AWq7Y9NcGMsOdVKFyWRrBt+1HxZJEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSrHxd7g; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSrHxd7g"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso800148a12.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936791; x=1783541591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd2T2yrKrdjkGkPBFuv19B1+1Czc0J5Qs+z0vXV9YM8=;
        b=ZSrHxd7gpGFYvcMF8vIkZgw8gbToxaYXQ5Ff9P9lfqWRbySSYlLpJW/PGDWkjCHAJW
         ogthRIVIu6zZj7SuRpWRlITSrgm13ZqOxuonKtFH4z0J9jfw6fSm/eJVNA6R8LrjN8Lb
         uwVQhpwmL65wkRwdgaO/nQD5cAZNllYo7zq0t8AHTEwlrNAnwVYmHc5TICqpDQU4kbSU
         zVaIW9q+whT51m6JOGl+MvG/DHBLMSb2XcPGyMgclC+I3QX2tufMEWwY1tXWubcPnGvq
         h6Z0a8F7QdrsOf58T5cbqDM+Ng2teK3JXU7JBoI+Ur5oPUkRFy5OZ7GuIIqciGmcaMlZ
         oj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936791; x=1783541591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd2T2yrKrdjkGkPBFuv19B1+1Czc0J5Qs+z0vXV9YM8=;
        b=lnXMBDxpj5vEACqojHsFzEg6tOIrKVrjZbxSEprpopj7Gj109huWT/v/cfg8CDyOnv
         os1unCqjbdo17SSIl+2feVovRmrmfZHdvk52PI///WR0u9FTm3Bq2LXQiH4enDZ5Kmzg
         MePPj2umoPzvM3au3gyIuj4IyCUpPYr2g5tEc7Dto6SCQ7wJchQAgzg3Ue8wVhIpoggk
         SgmGUQLyaqgBNLpROtdWv1eiH9+Q9n8btW6tK4li1X024KPWGS/02iDNXI5/SAwd/DD3
         KYUCPTy3iXswv31J78oWrJRdLf/+psjO99yiiP2ICXgzbO7Roctff40A3elL1EPAfJKM
         82zQ==
X-Gm-Message-State: AOJu0YywDs4XK+XCk1h9Lz23Bu398yuQYjDtEBGWqWk70kAUtlUMmTkW
	R1/I7T9RJxu7yCbTRgmuNF1XMRTqduaUbk+n4aqNa6Ewjbcy24rGmrIFgN5G1u2eDNhbe6LEdD9
	IjjccoA==
X-Received: from pfbil2.prod.google.com ([2002:a05:6a00:8d42:b0:847:aa6c:47fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d06:b0:845:44ec:a648
 with SMTP id d2e1a72fcca58-847c506fffdmr2026726b3a.21.1782936791019; Wed, 01
 Jul 2026 13:13:11 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:13:10 -0700
In-Reply-To: <20260701200321.256EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-23-seanjc@google.com>
 <20260701200321.256EF1F000E9@smtp.kernel.org>
Message-ID: <akV01rY3MJkrbene@google.com>
Subject: Re: [PATCH v5 22/51] x86/kvm: Mark TSC as reliable when it's constant
 and nonstop
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 909d3e5e5bcd5..1cef54e1e7d9e 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> [ ... ]
> > @@ -1040,7 +1041,16 @@ static void __init kvm_init_platform(void)
> >  		}
> >  	}
> >  
> > -	kvmclock_init();
> > +        /*
> > +         * If the TSC counts at a constant frequency across P/T states and in
> > +         * deep C-states, treat the TSC reliable, as guaranteed by KVM.
> > +         */
> > +	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC);
> > +	if (tsc_is_reliable)
> > +		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> 
> [Severity: High]
> Does setting X86_FEATURE_TSC_RELIABLE here bypass SMP cross-CPU TSC
> synchronization checks?

No, KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is for kvmclock, not for TSC.  The
CONSTANT+NONSTOP combination is KVM's way of guaranteeing cross-CPU synchronization.

> Forcing X86_FEATURE_TSC_RELIABLE based only on CONSTANT_TSC and NONSTOP_TSC,
> without verifying if the hypervisor actually guarantees cross-CPU
> synchronization (e.g., via KVM_FEATURE_CLOCKSOURCE_STABLE_BIT), sets
> tsc_clocksource_reliable = 1.
> 
> This bypasses the synchronization check in check_tsc_sync_source():
> 
> arch/x86/kernel/tsc_sync.c:check_tsc_sync_source() {
>     ...
>     if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable)
>         return;
>     ...
> }
> 
> Could this cause time to go backwards for guests running on hosts with
> unsynchronized TSCs when threads migrate between vCPUs?
