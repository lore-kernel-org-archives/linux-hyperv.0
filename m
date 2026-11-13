Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589843;
	b=zzATbhmql5We/CJ/+eQ95GzzGWXEzcvcvpTVP9Mu+vCv8a1KNwo4nIYe2TbRNBySWjr2
	 ALsh0Grb86LAamCESyBBG1KO3cxvuseXwuB+oRgq1KxXuhi4sxWWBLYB/AB/06+sEiCTl
	 OzSpQJxiVTwJv/iJjHzcvrgfsGkFckwzhcgVGSQta1/Yx5pnOeM3bCEsFDUfd7bfvyZXq
	 z3n5QeNgdMwLwy6AZaYkFF2f3w5cmQ5xzfuQJrTDrn/dtDB/CAZZPsGCHPok+GK2QKGhk
	 3baZda7dUgHspHncKBMglLCW4Zw0CvMVfzdtk4Ml10M6DdAE++3/6ALwXBFx90ES9iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
	b=T1LJ7C/CNu1qImIRAd5zZzWm3FtTSp7+RDu2Ha1cRTGEeP5YDWIjvv0yzCoojOoI94ZZ
	 jkzEEiYAtHI7g7L6gC3fwkwR0XahebhWbDhZnp8G7Ur6wQsDIQjCjmstG/piLYqXNL0qy
	 adW85SPfiQP/FbpLTtZ4renywAj3S5dBklopyEa0abTiZL1Jm/wlBso125inwGa04XV5Z
	 iclYFr5bweIEDQjYTDl6mQiXQ0hELQhT8D0rojRYbnZ1KP1ssKDVNt5VbTheYlnoJ6plP
	 ht52mNPIxXaxYfZBfVlyVf9FmRnxsDwZ9NuyceSoYG18Ec9Rfk42bVkU1eP070ejepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ajpn1FZU;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7904606A330
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 17:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7904606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ajpn1FZU
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so1200085a12.2
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589842; x=1795194642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
        b=Ajpn1FZUD6fdphGL4f5vUwF219i7l5zDYRSDn5qpvopjTucfLpwhBi+V32T8AvbkT8
         RWsRiKmQHMtZ0Y4DXyBIIzisa4aOm9Kpqn6zXnFueVRXAfSBqYFfjwXDeU+cneX/ZUV5
         HefkxbOejcUXxKGiEy7KSwSP4IBU4fi/pKYMHUBYcv1mvmdQpwDaw3KHI/5S1lKhvGqr
         Aqh8AaNox3wkrdcHJzrvSIPrPnnwYPqODX7othykMRmXizjKVDeUsrh370Tsh+29iDXB
         +uM/wdIJpMXmJ6KUDCozEHrN42Uj0kEx3LPWxPBB1gb3KlpwfgJe+HUqqMPUhgl2ikGU
         KuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589842; x=1795194642;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
        b=1StYkA4eLlHS8vdYaBHxOt0Tqk0CJerUxoDORLhH4MZZzl0mmAB8njpQSEkEEkr4fS
         cQz6nWILlkia9naRbU1ctWLSAHh4q0VYB8eTGU/VNDl3AtndcGFdbmRsS3WGYi0HCrlw
         xdzToP5aY5IzAGxhc95CdXtvSV+s7R1mR3ee54K9VL1IbWyab5jaUtqVFI9QYi5choLU
         V3pfChQtUy5N9FRGMwxqL+YRHOELZ0b6J+DCKbfvsO5EjFXGLOk40dlV08G7mS4eEm+e
         jmr4Otqc69ik8X5dbPpToWgRb4vR3cRZD+Y5jgbitUpweDRGxMlooxJ3JQTVTCd2fpLw
         eTEA==
X-Forwarded-Encrypted: i=1; AL+hErEhH+W/ekOkaqaYO8+fxuSgM0jlYWtE8BDNy8aILpwyyUo7hTDdLaZznp30/FMnCkmwJb2xdrsfrpkaQ2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AFE/pP3njL78nX/ZQ8Sy6YNzbPtrlM/w49luG1ndPqwcPO8UE
	W6NZ2YJn/Ek9MBiiyHB9zocOathFUO9vtXS4ywZsHfG7eW+DOOODEd93bqoGXPYyCyQQ4pZgwD/
	xq//OCA==
X-Received: from pgbda3.prod.google.com ([2002:a05:6a02:2383:b0:cc7:dd4c:a852])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:3d3:ae50:97ce
 with SMTP id adf61e73a8af0-3f7a7bc23c1mr3448497637.27.1794589841765; Fri, 13
 Nov 2026 09:10:41 -0800 (PST)
Date: Fri, 13 Nov 2026 09:10:40 -0800
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113170535.79246-1-dwmw2@infradead.org>
Message-ID: <avdEkNbqPWamMErl@google.com>
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
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> KVM implements a fixed set of Hyper-V hypercalls and fails every other
> code with HV_STATUS_INVALID_HYPERCALL_CODE. A VMM that wants to
> implement more of the TLFS, such as the VSM hypercalls Windows uses for
> Virtualization Based Security, never sees them.
> 
> This series adds KVM_CAP_HYPERV_FORWARD_HCALL. As with KVM_CAP_XEN_HVM
> and KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
> features and KVM_ENABLE_CAP takes the subset to enable, rejecting any
> bit the kernel does not report. The first feature,
> KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends the hypercalls KVM does not
> implement, and extended hypercalls in fast form, out through the
> existing KVM_EXIT_HYPERV_HCALL exit, whose format does not change at
> all.

I'm not a fan of fowarding unknown hypercalls.  It seems like it would be quite
easy to end up with a mess where it's difficult for KVM to implement "native"
support without breaking userspace.

How much code (and ongoing churn) would it be to add an allowlist of hypercalls
to forward to userspace?  And then obviously require userspace to configure its
forwarding "intercepts".
