Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8283431E6D;
	Wed,  1 Jul 2026 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935813; cv=none; b=gaycBV0/O+iy4MZVTnSmVKox5kIqKSo1BujQqivK1FsVCjfsJFdyTCoFsbOYro1uTDU0tjhi3o36mrMzQY1Uh9zFwAM6aFrs1S4SODE4ulbk+XLvMqOgcyuYw0I01PfUP2LoNoBCidOPkNS0owOaIKpJcb2LSuX94t9nYzXlj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935813; c=relaxed/simple;
	bh=a7iaRvOquiQpkJK1Zd7auLUUbSQGKf8f8CZjv8dciwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkswXUJ6IBBGZvIKo+YEr3Twp02eh0Yuna/MwViZF4BKPEqBFB3/QWqw+Yd8J+1bh4g6iFODtP8zvA81Szlc8LqOCP3QS/PV9COr1mSQKC5Jei1GVUihrRRXJRryKa3NXr/myrWYqDuZRX2eH7PIUQKXDqutPO3anyaUfT78s0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au2/3tFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au2/3tFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEF11F000E9;
	Wed,  1 Jul 2026 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935812;
	bh=a7iaRvOquiQpkJK1Zd7auLUUbSQGKf8f8CZjv8dciwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Au2/3tFQW4xQfLPQ+Hl5/tDcApj/Jrkb14+gRwB2C5rCak2znQ1/V963/gg45703h
	 tZ04x/t189CFLSP0EZZmG/lSR9E5GljXilXD8ERZVTZFO80DfY4iVbpoBKi6qfVwZM
	 R3Q9N83fxeh+fTG7HNFwqWc/4U4gj/8etiUAteBdoie1Zi79kM7iIQrIO7UzCuJ2x2
	 EnqB8auo1iflKgrCUtHAsemeqkxNF24jQ/6iHyu8ZIaZqU5l3zkvAzQhAKn6LamQEy
	 XptHBqsgi9TxHPPR1a8Zm07hTI9D/HB6GSSxqu41sdCvJ7Y1VVb9pxsW+jbUJf5nwW
	 nnAN121vz0LDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/51] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-6-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:56:50 +0000
Message-Id: <20260701195652.5DEF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a malicious hype=
rvisor can bypass Secure TSC calibration by injecting a fake UV system tabl=
e, forcing the guest to fall back to untrusted legacy timers.
- [High] This problem wasn't introduced by this patch, but if the calculate=
d Secure TSC frequency is 0, the kernel silently falls back to untrusted ti=
mers instead of terminating the VM.
--

Note: Due to system recitation restrictions, this report is provided as a f=
ree-form summary without direct diff quoting.

commit cdbd80de837f6d512a759452a18164ddd83b9b7b
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Mark TSC as reliable when configuring Secure TSC

This commit moves the setting of the X86_FEATURE_TSC_RELIABLE flag from
sme_early_init() to snp_secure_tsc_init(). It consolidates the handling of
known-frequency and reliable TSC flags when overriding the TSC calibration
routine.

[Severity: High]
This isn't a bug introduced by this patch, but does the early return in
arch/x86/kernel/tsc.c:tsc_early_init() allow an untrusted hypervisor to
bypass Secure TSC initialization?

The tsc_early_init() function checks is_early_uv_system() before initializi=
ng
Secure TSC. The is_early_uv_system() check relies on the presence of
UV_SYSTEM_TABLE_GUID in the EFI configuration tables.

Because the hypervisor can provide tables to the guest firmware which may
expose them as EFI configuration tables, an untrusted hypervisor could inje=
ct
this specific GUID. Would this trick the kernel into returning early,
bypassing both Secure TSC and TDX TSC initialization, and causing the guest
to fall back to untrusted legacy timers?

[Severity: High]
This is also a pre-existing issue, but should the newly updated
arch/x86/coco/sev/core.c:snp_secure_tsc_init() validate that the calculated
frequency is non-zero before returning?

If the calculated frequency evaluates to 0, which could happen if the
hypervisor causes MSR_AMD64_GUEST_TSC_FREQ to read as 0 or if the secrets
factor is invalid, the function simply returns 0 instead of terminating
the VM.

The caller tsc_early_init() treats a return value of 0 as a failure to find
a trusted frequency and gracefully falls back to x86_init.hyper.get_tsc_khz=
()
or legacy timers. In a confidential computing threat model, should this
security-critical initialization fail closed and terminate the VM, rather
than falling back to the hypervisor-controlled time sources that Secure TSC
is designed to protect against?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D5
