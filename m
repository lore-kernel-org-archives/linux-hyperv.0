Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE573F4DDC
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372208; cv=none; b=eIst/6D1MaxQfunZhuyu9EQaShzkuuE6raQzUwC/0DFk3Q2/DfE3xYAbfessC+plCUI/SG+9mU7XtYKOnekF4zT5pB8u0SWmycvHfDsmXrB0OdKQZMorrYpiA+OpCofV6SJI7VMRzink9+fdaMRy1BLyhu4UG9LuHJnGjbzv0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372208; c=relaxed/simple;
	bh=4hkqL67a+abI0W9PGYZV3w1q/c9dy9KBL2UatITOk78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxfFvQG+bFlpDh8RsCebH+eDHlOANNxreuOStssEcImaCAWTRNsh3TbJdjdPw15sNFECjW3pgwKj/TrYhm1XgP5XvdHrEABngjXUa2xO3eyy9NZgk7VfFVGsJ2S0Kf9RTcQw1n93bZ8sK+wvZjDgL57GslE5iNQAqwHb+6yCuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFhutPxZ; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFhutPxZ"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso1637922a12.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786372206; x=1786977006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pt4y4GsIfgXju50y9aE1V5oqKvyqhzjPLlHBnjvlrwI=;
        b=VFhutPxZzXHMuMqxwBlLbGiTds7tkLIFe2/WqXmjf0TwHMTCRkJXg3iVEe+HILUGpA
         Mi12f2bjjUOj7z4JotlTMHaNISmTHOYZUAewTpsDx/zC2+UYkIMnubcqOFk1RTKRjvlQ
         HBvJwBk8TxKfKCTnTnU0fgLggsLE9kr7UiDwNZ/p8Rv2tQTg2Y+J7s5anG5VaAbkrayJ
         V7kFRrNfn42zG2mQHtGFALWDKEO9ZQoO3b3QIRDACZ1Hb2lEaeF8xtf9U2PGoObWR3MO
         EVIFFHBRA/VMiffkQeD8WQ3fwMgknGHzZDE7Co17MItlPUMu14xK9a6VVye5IIyyFxnR
         Sksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372206; x=1786977006;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt4y4GsIfgXju50y9aE1V5oqKvyqhzjPLlHBnjvlrwI=;
        b=VkN1XnocJYvVyW3uVu0uLrvDr/To+N+X2emks57xyeW33bW+JSulV8jh0CFolZUOuy
         KTF9wJEuFfS8D99RSnJK9P11y4pJk1rJgsV+ZDHHyEPcTXDq7u0eU2R1nCVzT3+JItQU
         Iis/goh1MshNiXxGejprFhoXmhUWt4/4hWVFEoFQiAAL7ctw0EwhW1R9kuLGhZJN3I7K
         WKbQh6YEyV+/7Vd9fk/tdyaFf+6CZV6XHue+WD3j2AVJDkGtUJSiL80cKg6bDFLPsxJE
         K17kSxvIeVb0rBj9Wsu78nHuBDfpNYbLgO4Ba1H1UL0w1F5HKcp8bS9ccFk5qfzO0lfx
         10Sg==
X-Forwarded-Encrypted: i=1; AHgh+RrdDP1u6rdgDzNhVLPxRjky2Di2Nwf7yl3dY6gSu25ytjJ4/AmJqOuc2j/SpEjjd5FwB5IjZZ1N4MbbZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi97EbGmp5RRiNsZ3zIHhO7vV9l179tC9bDZFNonzsI6rL9Tl8
	f7VcOI2mwxGrA6/CUfwtkGJ9FKw/YSYMokKTvO9HlU9lVk/V6ehrt0Da1ggIigDB7LwTWiTslmT
	sGp3G9g==
X-Received: from pgmo14.prod.google.com ([2002:a63:5d4e:0:b0:cbe:7df7:35b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa0:b0:3c3:76a8:c0f
 with SMTP id adf61e73a8af0-3cbce6f17b9mr20503675637.4.1786372205374; Mon, 10
 Aug 2026 07:30:05 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:30:04 -0700
In-Reply-To: <b8c0e3537904e29f233cbb03f4d3ddb5247e2af7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-11-seanjc@google.com> <b8c0e3537904e29f233cbb03f4d3ddb5247e2af7.camel@infradead.org>
Message-ID: <anngbOavdPam2kKy@google.com>
Subject: Re: [PATCH v6 10/51] x86/tdx: Force TSC frequency with CPUID-based
 info provided by the TDX-Module
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, pbonzini@redhat.com, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, jan.kiszka@siemens.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	jgross@suse.com, daniel.lezcano@kernel.org, tglx@kernel.org, 
	jstultz@google.com, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2026, David Woodhouse wrote:
> On Thu, 2026-08-06 at 16:35 -0700, Sean Christopherson wrote:
> > When running as a TDX guest, explicitly set the TSC frequency to a know=
n
> > value, using CPUID-based information, instead of potentially relying on=
 a
> > hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15 is always
> > emulated by the TDX-Module, i.e. the information from CPUID is more
> > trustworthy than the information provided by the hypervisor.
> >
> > To maintain backwards compatibility with TDX guest kernels that use nat=
ive
> > calibration, and because it's the least awful option, retain
> > native_calibrate_tsc()'s stuffing of the local APIC bus period using th=
e
> > core crystal frequency.  While it's entirely possible for the hyperviso=
r
> > to emulate the APIC timer at a different frequency than the core crysta=
l
> > frequency, the commonly accepted interpretation of Intel's SDM is that =
APIC
> > timer runs at the core crystal frequency when that latter is enumerated=
 via
> > CPUID:
> >
> >   The APIC timer frequency will be the processor's bus clock or core
> >   crystal clock frequency (when TSC/core crystal clock ratio is enumera=
ted
> >   in CPUID leaf 0x15).
> >
> > If the hypervisor is malicious and deliberately runs the APIC timer at =
the
> > wrong frequency, nothing would stop the hypervisor from modifying the
> > frequency at any time, i.e. attempting to manually calibrate the freque=
ncy
> > out of paranoia would be futile.
> >
> > Deliberately leave CPU frequency calibration as is, since the TDX-Modul=
e
> > doesn't provide any guarantees with respect to CPUID.0x16.
> >
> > Expose and use cpuid_get_tsc_info() instead of providing a wrapper to
> > get the TSC and core crystal frequency, as TDX is the only anticipated
> > user outside of the TSC code, i.e. adding a helper to dedup the math wo=
n't
> > actually dedup anything.  Having TDX use "struct cpuid_tsc_info" also
> > avoids the temptation of declaring a local "tsc_khz" variable and thus
> > unintentionally creating a shadow of the global "tsc_khz".
> >
> > Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> I don't know if we should set X86_FEATURE_TSC_RELIABLE before bailing
> out in the case where cpuid_get_tsc_info() fails, or just not care
> about that because it Can Never Happen=E2=84=A2? Previously it was set
> unconditionally from tdx_early_init().
>=20
> Whatever...

Heh, yeah, "whatever" is about my thought exactly.  I could go either way. =
 I
would buy an argument that the TSC itself is still reliable even if the fre=
quency
isn't known.  On the other hand, the frequency could be computed via calibr=
ation,
at which point the frequency is no longer reliable and arguably should be s=
anity
checked.
