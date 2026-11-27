Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794581;
	b=zQsc8v2lA964dWstWvCqXb7DpSgfQKc9XgIGZ7VyoDqFjT/xRNsHS9HtSCfuSbBIqc/d
	 NNnmAKnwaX/KqxWCClC4iOompmseIrJ4ugcVyil/QY8TKp8DEBqjNlGPcVXA05QvhrJJ+
	 Hc32XMBZf47aPaIU5v30kcHcEkkvyBvq9OLr4o4lTotJ4f1aX5sUyyCK4tPIf4mHqn77o
	 eRSQt77CYXTn0wY8YbzrtikfO/tPoz+Rc8/r0K9ObmAbsthRJwBSi2zM6MVjkV4JKn8BI
	 jspucNMTrHwtHDucu1rnGRqxtWjQLrP14FJAjWm8Yojkq6C7LAkdp55ZFri367jauRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZsgXpNOeXNKeEd3HxUZ2kyfIe2S02QXPmc8lu12KQc=;
	b=k0Yy7DoRDcKtbGjxN2/H5Z31adDmPkESNHaiaxL7+aqqSEkjGsiKuG7khhLUtScKphm+
	 bKcEXbYj4UoTq5AT6bJnrGm4GhGiuADy99NRrPoxwdoFsjbrWtjMXpRAyYy4eeF0VzLtJ
	 dKcP78VjxEXaqKCwXPotCbwO0+bUrOQx4cabfAWbut+Wa8OXPSRyr9tTO6EDekBzNZsdW
	 wCWOfa2Aaauajs9n4E7Ztp0ExM81T/jw9g+o4wzsOItOxvsT0S5nL79pMKiIAZPMhMfvQ
	 Wc23KrqksASC/EHzvRioFHKYFhE6bLd4Azg5SkE2v0nafS62BYIe8e4SN8RzoSpGfOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThZmG0Dk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1215606A31C;
	Fri, 27 Nov 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThZmG0Dk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1C51F00897;
	Fri, 27 Nov 2026 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794581;
	bh=ZZsgXpNOeXNKeEd3HxUZ2kyfIe2S02QXPmc8lu12KQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThZmG0Dk4OwBTAQPrhJ5FeDChOaZeefUsfqvYibnd4P7UiPYB53hsqWzUo8R3d80X
	 QbFlMhjaQ4Fy6P5ObkXgderQfVmR7vtFACMKJe58Ag6mJuACZ6wT4CCLVFgb/4Mu1v
	 gqoeqSI3DjxreLgVS4oWTrDwVH2e5ihw43M5zs5NxnpY3b9UE77t1nKnUek4ZTofbf
	 nRmQrqY4N5t7C3A4uix67XdWg9uwxu+vmq7CEv7JxTLzX8dPx5/OL9gEzZ36fvAzzp
	 p9vTEEHeO61wia/aqohEYmiSx9XVp31wteyU7mYiI4QkVJQ1Jh7ziGf34hsZsFdryj
	 WAxxIa/Bmo9YQ==
Message-ID: <sashiko-outbox-237785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/15] KVM: SVM: Support CR0 and CR4 write filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261127152730.99319-13-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
 <20261127152730.99319-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:49:40 +0000
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
- [Medium] KVM: SVM: unnecessary INTERCEPT_CR0_WRITE for non-TS/MP
  filters and L2 guests
--

commit 94f59c3becb8e9910d861b5136b68fa9775be16d
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: SVM: Support CR0 and CR4 write filters

This commit adds support for CR0 and CR4 register write filters on SVM by
keeping INTERCEPT_CR0_WRITE enabled while a CR0 filter is armed and
checking for filtered writes in cr_interception().

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 4ffb41234dc25..c91467a59e201 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1135,6 +1135,22 @@ static void svm_recalc_intercepts(struct kvm_vcpu =
*vcpu)
>  	svm_recalc_msr_intercepts(vcpu);
>  }
> =20
> +static void svm_update_reg_write_filter(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +	/*
> +	 * CR4 writes are always intercepted.  CR0 writes are not when the
> +	 * guest and host views agree (hcr0 =3D=3D cr0): force the intercept in
> +	 * vmcb01 while a CR0 filter is armed.  Disarming leaves the
> +	 * intercept in place - a forced intercept only costs exits, which
> +	 * cr_interception() handles as usual - and the next svm_set_cr0(),
> +	 * which respects the filter, restores its own state.
> +	 */
> +	if (vcpu->arch.reg_write_filter_armed & BIT(KVM_X86_REG_FILTER_CR0))
> +		svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
> +}
> +
>  static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
> @@ -1867,7 +1883,13 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned l=
ong cr0)
>  	if (hcr0 =3D=3D cr0) {
>  		/* Selective CR0 write remains on.  */
>  		svm_clr_intercept(svm, INTERCEPT_CR0_READ);
> -		svm_clr_intercept(svm, INTERCEPT_CR0_WRITE);
> +		/*
> +		 * The selective intercept misses writes that change only
> +		 * TS or MP, and CLTS: a CR0 write filter needs them all.
> +		 */
> +		if (!(vcpu->arch.reg_write_filter_armed &
> +		      BIT(KVM_X86_REG_FILTER_CR0)))
> +			svm_clr_intercept(svm, INTERCEPT_CR0_WRITE);
>  	} else {
>  		svm_set_intercept(svm, INTERCEPT_CR0_READ);
>  		svm_set_intercept(svm, INTERCEPT_CR0_WRITE);

[Severity: Medium]
Should INTERCEPT_CR0_WRITE only be forced when
vcpu->arch.reg_write_filter[KVM_X86_REG_FILTER_CR0] intersects
SVM_CR0_SELECTIVE_MASK (and when not running in L2 guest mode)?

INTERCEPT_SELECTIVE_CR0 is always enabled and already traps writes to any
CR0 bit outside CR0.TS and CR0.MP.  Forcing INTERCEPT_CR0_WRITE for any
armed CR0 filter causes every guest CLTS and TS/MP-only CR0 write to
VM-exit (with CLTS falling back to the instruction emulator in
cr_interception() because CR_VALID is clear), even when userspace only
filters bits like CR0.WP.

Because nested_vmcb02_recalc_intercepts() copies vmcb01's intercepts into
vmcb02 and svm_set_cr0() also runs during nested entry, this also forces
INTERCEPT_CR0_WRITE on unfiltered L2 guests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127152730.9931=
9-1-dwmw2@infradead.org?part=3D12
