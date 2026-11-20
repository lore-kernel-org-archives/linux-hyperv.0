Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198286;
	b=kjb95ZTZ9vb/QD0Guf1GznRGZCDEAaJCwXI0b3h961ITgDk2z+SNLs1Ulw66I0ysGtFU
	 /l5z14AvZWIhQ3YtMSupX0PV0R+FcVSdLUsE1QU06IVRdoFGvU4DGynl52m2W33O7SIoY
	 RUDvtRGQd0aqVFmzxawQhv/lQTOBtVVH2ZBa9HjHVSX2/Em3pQfO3VUBPSzDnNnNcbkbo
	 kv4VI61ToUT5BiCRSHDDDYmulvc88JRWEKMwXRMmphZu6dKplMZKd5sZlJ0WizzKcQCFm
	 Id+lHflLP3UOgp9++vrnMfIqTWMT+RDB3hIp2pIzbPn/6WrRA1o7WrEmw3WEivh57XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=JDzbhiCoFBsB1LUGSE+FNJ8fs+B+4L9p62TVlpx0yJ4=;
	b=isxln15wFxRK1R3WqWTaoSxPzhwEBMXfsWiTtwioBK23ARxmczTUvJJL11Wsdy+HEGMD
	 ccUGrYeW3RTIiW5LsG0oQTbaeWI2O827C40E7O5K/yYniUOEjm9TYcwFR5Tv/LMnx/592
	 2bV6ytma199MHfPKnoiR7J4MmxyLOMVgprYxhEI/n9H1fQXkXSN8wcc8ISRi9SAJdnDAG
	 kMS5GN9cmjx+vLEvXOjcG0tKji1GLAaH3g/4Ppq7ucFAft5oV95uLv9i+abGONJGlEjt5
	 J8p+ElGh4xvPQyrXo/WuuAoYtPa4XeU5yYgB8mTRIJcRlKqUyen9VtrPap/YKKRh7/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PVGHrCoa;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA3606BDEE
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Nov 2026 18:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7BA3606BDEE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PVGHrCoa
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f04053e460so9957045ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 20 Nov 2026 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795198285; x=1795803085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDzbhiCoFBsB1LUGSE+FNJ8fs+B+4L9p62TVlpx0yJ4=;
        b=PVGHrCoaAP/5w1paicQ+hrt9379ckz/YstH15fDT/2OfPNc3NuS+VgVBK31Y4KWR1c
         6PEILfGm8mXVSYnE+ShXHiGg2+cjwadNYr6CVRAtBkojKCy3wAzMBHiN/hgp9Fr8I0rw
         pVTVrnraiWylu9/TACtXKP/yfxDi0m6zABmX4xVo2kPJHlkl/y54aRsSc9U/9fMEB2PJ
         esMW2rw0ckWd4dJpkMIpx7R4IXIDSCQJYl5yEpK1fzu07+gEa1XoH+hwVcUZ/VsnRp4j
         ChOPqNE4+HHfBFewHGbf5rwxwTNCY+3Zt+DtgYKz0OqIEnlWRHpodKCpTGesETGHl6Vc
         6OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198285; x=1795803085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDzbhiCoFBsB1LUGSE+FNJ8fs+B+4L9p62TVlpx0yJ4=;
        b=t442CYRMr96TE7ZtTAUsH3i7rgzy9zFZ76aylHG/AcPkINJ7vFkN4C9Jb6eqNddSgg
         kBgtboVPzCMUKMtCOQhBJmHU5NTPPiIi+bIu4m0j1NCfqTcWy4YpBGI7yKjxew0MqBOK
         rf2rzDAH1CCj6P4FllRTj1CrL5ozv8GQM52XyEtfx1dPIv/euPMxbdsFe5CEi381A9TT
         PdnM8KGYZVwoSGmeCHKX2RM4wGsxAIXmY6FAESSLAwwHF1RIlH48Vk7FA+SzZc1zwv7l
         KewUA8oJWtHRZVQYpocSY2oHclEnAlRLhaSU7eT7dyRvY7TvQ4CzhP6f9WjP/sqptMfe
         PHcA==
X-Forwarded-Encrypted: i=1; AL+hErFOtkrxgBoFdNZz1sxhsAcKebmLjt2iiId7pbK6kv0fzwsSkmKiehIOzogiKuPRhlK/zyCki3eQRq5TYKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ybHml6boMquY1VCaPIcXGAWxHXyU/cTB7hQEbgyktGurH8Les
	OlS1fe/2edalUsKzhKK+NsHCEBPYZxxOyrL+ArmuB6AP5LDqAhCE1GUEKCUw0hMA+OzqJ6i11Rv
	G1rRlow==
X-Received: from plup11.prod.google.com ([2002:a17:903:4b2b:b0:2ed:e056:7a80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:2f0:59dd:4d07
 with SMTP id d9443c01a7336-2f059dd50f7mr8708795ad.38.1795198285056; Fri, 20
 Nov 2026 10:11:25 -0800 (PST)
Date: Fri, 20 Nov 2026 10:11:24 -0800
In-Reply-To: <5F8F490B-BC93-41EA-B77E-9EC108C09DBE@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113170535.79246-1-dwmw2@infradead.org> <avdEkNbqPWamMErl@google.com>
 <5F8F490B-BC93-41EA-B77E-9EC108C09DBE@infradead.org>
Message-ID: <awCNTITOOiS1JEod@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 0/4] KVM: x86: hyper-v: Forward unimplemented
 hypercalls to userspace
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Thara Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, 
	Nikolas Wipper <nik.wipper@gmx.de>, Mushahid Hussain <hmushi@amazon.co.uk>, 
	Sriram Nambakam <snambakam@linux.microsoft.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, 
	"Radim =?utf-8?B?S3LEjW3DocWZ?=" <rkrcmar@ventanamicro.com>, Liran Alon <liran.alon@oracle.com>, 
	Arbel Moshe <arbel.moshe@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, David Woodhouse wrote:
> On 13 November 2026 10:10:40 GMT-07:00, Sean Christopherson <seanjc@google.com> wrote:
> >On Fri, Nov 13, 2026, David Woodhouse wrote:
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >> 
> >> KVM implements a fixed set of Hyper-V hypercalls and fails every other
> >> code with HV_STATUS_INVALID_HYPERCALL_CODE. A VMM that wants to
> >> implement more of the TLFS, such as the VSM hypercalls Windows uses for
> >> Virtualization Based Security, never sees them.
> >> 
> >> This series adds KVM_CAP_HYPERV_FORWARD_HCALL. As with KVM_CAP_XEN_HVM
> >> and KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
> >> features and KVM_ENABLE_CAP takes the subset to enable, rejecting any
> >> bit the kernel does not report. The first feature,
> >> KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends the hypercalls KVM does not
> >> implement, and extended hypercalls in fast form, out through the
> >> existing KVM_EXIT_HYPERV_HCALL exit, whose format does not change at
> >> all.
> >
> >I'm not a fan of fowarding unknown hypercalls.  It seems like it would be quite
> >easy to end up with a mess where it's difficult for KVM to implement "native"
> >support without breaking userspace.
> >
> >How much code (and ongoing churn) would it be to add an allowlist of hypercalls
> >to forward to userspace?  And then obviously require userspace to configure its
> >forwarding "intercepts".
> 
> I'm following the model we used for Xen support, where the default assumption
> is that we do everything in userspace, then accelerate only what's absolutely
> necessary in the kernel.

Oh, right.  I was worried about people getting clever and abusing the Hyper-V
handling to implement bespoke, out-of-tree hypercalls, but that ship has sailed.

> Userspace can opt *in* to having the kernel support certain hypercalls, and
> later patches waiting in the wings already add the in-kernel VTL switching
> enabled via a bitmask when enabling the capability. 

Oh yeah, duh.  We need a capability either way.
