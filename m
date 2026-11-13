Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593800;
	b=BMAT/2PHn4sR8uax/2yb1wn45T1wn9fddmUSqDOdS4uMYUfpSFP957XmxJePEYGypOoX
	 Tg1DvkGtsc1W8pgFhe1qWVSL92oe2YDp8M28UYXr8eerx/mWRvyxA1vepHvTUpb7KQAZC
	 wo3g22cNrEO+HzHr+u1WWv0ccXABMuXlPfPJREV5mYcgd8jwQMEJuCI/GYIEwhdFYkXQj
	 49gvI3wfn8sFohapPOvH0fUxddjZz3CLhnoNPdE8JhZOFj1gY9oDnahH7Ru1XrhFOCOLu
	 cX/BnvgCZl8mGcGHfFYzP7EWQboDuGXD1uaYcS2C+K5Yt/KK7LwJG+P8ucklWK43OXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i47OKU15qkkacD6rQKrghwg1RWfC+te7lyT0xcVd8m4=;
	b=nfL0Nd20i6zFinENxXL81cwKNZcGpAr7WtrkevVKpYHDg4qHC1JHNY4n3UGHWC/BDJQM
	 lMINGcJM3GSSpR+trnkqxn57SBES3jl7ox+55OMQlLj/yrvgjLejXxti2ouaEUzXA53rw
	 qvmUppTEml2BCXFuUwCt7Y3EhZYMWmntC4/3x0PGW0da7k5SBa3QbPnOcXol0RdxgO/oU
	 4S437fIsQuW2ZAF1L/V2xrxNOPIW2uzxWRdB+ILb8Zekavs/jYctETlY600De8+ubbvsM
	 or8IC127JP7FCsoAmyoHsYP1ukJS3pjeJJD0KuEAms4SJjnVtL8gNBZxbpWiJb6RSuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kgd7E+xV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38786606FE74;
	Fri, 13 Nov 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kgd7E+xV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9471F000C4;
	Fri, 13 Nov 2026 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593799;
	bh=i47OKU15qkkacD6rQKrghwg1RWfC+te7lyT0xcVd8m4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kgd7E+xVL1ORmiGckYeHkwb/cJjFMEb7WPFIZvpuyMfdtXt0S9ZalsULlZvaNLFXT
	 XB0JuGGEPlKgtlsDCGJ9g/RhvnYh1oMF1Zf8DJLVmJoQDUPbhxeothA1NBuZOs2mAd
	 hilliJH3J/qqFQ5gyM33J8tt8jKKXTn+4sgYjhbDGE3E9j9XW1znbmGfvj1nJEMg+/
	 oTDPCVCGziJs7/w/WNyxaINdYfviZ+jMgdtAShrLnyKv17aexQcHExfXvQGUlbc+6Q
	 eU+BxvfD4eIw34CueTd0cCPNzF6U6gh73BdIC6Pgau86wLTvtXrhmtXdH/pu0xCMuX
	 lUC2ooWw403mg==
Message-ID: <sashiko-outbox-213401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Make the x86 SSE register helpers
 volatile
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261113181053.81779-1-dwmw2@infradead.org>
References: <sashiko-outbox-209724@kernel.org>
 <20261113181053.81779-1-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:16:39 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: selftests: missing Fixes trailer for commit 676a863ce605
--

commit ec0caf7c95f47c5b258b6b71433582cb4674f3a4
Author: David Woodhouse <dwmw@amazon.co.uk>

> KVM: selftests: Make the x86 SSE register helpers volatile
>
> read_sse_reg() and write_sse_reg() were borrowed from KVM's
> _kvm_read_sse_reg() and _kvm_write_sse_reg(). The kernel is built
> without SSE, so the compiler never uses the XMM registers itself and a
> plain asm() is enough there. Selftest guest code is built with SSE, and
> there the asm statements have to tell the compiler what they do.
>
> read_sse_reg() has an output and is not volatile, so the compiler may
> treat it as a pure computation and move it, for example ahead of the
> hypercall whose XMM output it is meant to read. write_sse_reg() has no
> outputs and is therefore implicitly volatile, but it doesn't declare the
> register it overwrites, so a value the compiler was keeping there does
> not survive.
>
> Mark both volatile, and declare the register each write_sse_reg() case
> writes as clobbered. A read_sse_reg() after __hyperv_hypercall() now
> stays after it.
>
> That still leaves the compiler free to use an XMM register for its own
> code between a write_sse_reg() and the asm which consumes it.
> hyperv_write_xmm_input() in the hyperv_ipi and hyperv_tlb_flush tests
> relies on that not happening; GCC 11.5 at -O2 emits nothing there.
> Closing that window entirely would mean passing the XMM values as
> operands of the hypercall asm itself.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-209724@kernel.org/
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

[Severity: Low]
Since this fixes read_sse_reg() and write_sse_reg(), should it include:

  Fixes: 676a863ce605 ("KVM: selftests: Better XMM read/write helpers")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113181053.8177=
9-1-dwmw2@infradead.org?part=3D1
