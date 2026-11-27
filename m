Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794922;
	b=2tCF5YX0bER+3bJU6vVEXhOwjt6AdiDWoPpPvpZ0xgS3H7C8OZ1zcqZhxFrILGnUMcTC
	 uNOONai8Vo/ggcDUrS/ele5FafCvxlsNbZc/4bdK48TA8pwROHNdmfgIgGEENzXI815lF
	 VsLwh0mVUCPCDhoJgy/4vOB0N2O6r9Erg+GQJQgjknze+qx9rWFNNYrMNLEjjMXSrgFZo
	 /oy7jDsEsXZAus4PbRr/tV3UMJ//cKxKpqceZ14EnNqhenjbSTqwGBGejgkXpANOkN/7V
	 eusyuY8b0epP1bw3Fh2CsKkHG3PQAw14okc7OExyvKCNq/gUaRSvk6cTj0CMJLpFing==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BmuVwbogXnNMmlJ6yuUFGdUyRN1Ru/PD7hJsayd6C2M=;
	b=yz7RjMjqvcLvPBaUlyBXte2sYu7WYYHYn8OYVW0YH4NvZ/D+9GuPcqqFKu2PAzVQ8HB/
	 uUU81Gmjtn7pu2/NGoAHTFZhzaTC+pQA6bqkhFvJiHXwSW2g4DMYl9EFSAhSvSojNGkE4
	 CWgHhmGE7rvyR83uGCD6gf5IO2gJns8kIGysV3+rlpbD0FcMMafNkiNcaKTihwIGQacNL
	 or98W963up102kl8ELGr4QW0/yHJGdD/ajoSW3LXI2Q8otTErfLCX1Pxspl0qDp9yMTDo
	 EgccoW+24Bv1LWACwHJGNV3+uUfpCLxVTl/Ufi4g5ng3JhL0M+pONzd+XjZDw+Y+fIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VG3uZ0/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99440606A32A;
	Fri, 27 Nov 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG3uZ0/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF3D1F00893;
	Fri, 27 Nov 2026 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794921;
	bh=BmuVwbogXnNMmlJ6yuUFGdUyRN1Ru/PD7hJsayd6C2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VG3uZ0/Ji4FfD25Q78fqESDMs4/hFeYkgeM/is0mLh2gjIGdc7i37wSWUxNOfPZum
	 UJVEUauwzLjv84QdvgezB4LoC3H0/MD7c6uBRa0Z1nAPnBnm6HaH5JuSD72kIxkGVq
	 +XUlY2sscRWyeQ/jNRot3AeddxjtTQ1URfYZj1Gxz0FvYTXnCwIyWOd8PrEgqz8TCi
	 gqQv9NKrU1Zjy3aH1x9mkZ3U1QNNEeKstY3+M2M38WJMBiJs4SltYSe892ASxraLXY
	 iS5oj54+Odwv2jI3wsDtAEPdz+3pI8jN5J7HrIjWDCSmEIXyXULYbjRFWfgljnxQ+1
	 VZSMXAnVYS9yQ==
Message-ID: <sashiko-outbox-237797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/15] KVM: Define what completing an exit does with
 its instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261127152730.99319-3-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
 <20261127152730.99319-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:55:21 +0000
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
- [High] KVM: x86: stale emulate_regs_need_sync_to_vcpu in
  kvm_insn_uncompleted()
--

commit a2d5858612fe849c4fd217f459db157f10703c3f
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: Define what completing an exit does with its instruction

This commit defines KVM_INSN_COMPLETE, KVM_INSN_GP, KVM_INSN_UD, and
KVM_INSN_RESUME to let userspace choose how KVM handles an uncompleted
instruction after an exit, along with the x86 kvm_insn_uncompleted()
helper.

> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 436e2fb1396c4..7e5ccbce9114f 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -526,6 +526,38 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vc=
pu, u32 error_code)
>  	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
>  }
> =20
> +/*
> + * Act on the KVM_INSN_* answer which userspace gave to an exit that lef=
t an
> + * instruction to complete.  Returns 0 if the caller is to complete the
> + * instruction, 1 if there is nothing more to do for it, or -EINVAL.
> + *
> + * A guest whose state is protected does not execute the instruction aga=
in,
> + * and KVM cannot inject #UD into it: all that can be done there is to
> + * complete the exit, with an outcome which is the caller's to choose fr=
om
> + * the answer, or to ignore it.
> + */
> +static inline int kvm_insn_uncompleted(struct kvm_vcpu *vcpu, u8 answer)
> +{
> +	if (vcpu->kvm->arch.has_protected_state ||
> +	    vcpu->arch.guest_state_protected)
> +		return 0;
> +
> +	switch (answer) {
> +	case KVM_INSN_COMPLETE:
> +		return 0;
> +	case KVM_INSN_GP:
> +		kvm_inject_gp(vcpu, 0);
> +		return 1;
> +	case KVM_INSN_UD:
> +		kvm_queue_exception(vcpu, UD_VECTOR);
> +		return 1;
> +	case KVM_INSN_RESUME:
> +		return 1;
> +	default:
> +		return -EINVAL;
> +	}
> +}

[Severity: High]
Does kvm_insn_uncompleted() leave vcpu->arch.emulate_regs_need_sync_to_vcpu
set when returning 1 for an emulated instruction exit?

When x86_emulate_instruction() exits to userspace without writing back
registers, it sets vcpu->arch.emulate_regs_need_sync_to_vcpu =3D true, while
x86_decode_insn() has already marked register operands in ctxt->regs_dirty
via decode_register() -> reg_rmw().  If userspace responds with KVM_INSN_GP,
KVM_INSN_UD, or KVM_INSN_RESUME without calling KVM_GET_REGS or
KVM_SET_REGS, completion skips x86_emulate_instruction() and resumes the
guest with emulate_regs_need_sync_to_vcpu still true.  A later __get_regs()
call then flushes the stale ctxt->_regs[] values over vcpu->arch.regs:

arch/x86/kvm/regs.c:__get_regs() {
	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
		emulator_writeback_register_cache(vcpu->arch.emulate_ctxt);
		vcpu->arch.emulate_regs_need_sync_to_vcpu =3D false;
	}
    ...
}

Clearing vcpu->arch.emulate_regs_need_sync_to_vcpu when skipping instruction
completion avoids clobbering guest GPRs after the guest resumes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127152730.9931=
9-1-dwmw2@infradead.org?part=3D2
