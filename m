Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794524;
	b=zBixDnwJXjrShPrKjAo8hEKkshUF5RpBiA2wygN1jXdYLDHBJtv+bmuRHMMWwpKvhanf
	 Wx4QmnbSLDQdZCzy1KNndh3N7ksXj0O0q2bWASqs0nLoVBNm6pKp2NAmNXbY32IyYxQoC
	 GPFaYEkUk0sq7m3KoSkOYlLD+/7oImpwB4Eyj8u2OmHoJZf+BMGPsUndVHA5WDL7k15AW
	 bkNmmLckqXxcpZF4QzK8p87w2EMERPJhku9p7zjbXSD6Yyi85LRiyUXQODJ0y76fLeXha
	 bZdkTp86qt+2ILxE5HcYPDB/C4wnM9fTy24HDjbpjr+Or5cwChGOZn6kKwVSlOIXR/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l96ynvHLdVkKmQ+hThFK5F7Zb52Cz8ekuo9zG2+dkKY=;
	b=lv3B0tKr08T5PYAq9lHsHX3N2vFBxadKNp7iY+OgSbBm75n1Ro/sYmJyVyayZIikJrbJ
	 YiFF6/orzLXR7xBabDa6nAEGOqVVQulIgEkHttCqVouNXhjfp/c1howJbbr/Pr/7kEv+K
	 JS+RPeHBNQqzxB0ec3/6MUmQeNAdUxH0a3HlHLjFgepQBKqZtajSoDS1w1GZO0ABwsXfk
	 n1GJRSN2b4ve5jZmwknLaIZweYjtJCPEYyt3moYzimYgDDDsiMXdY4D44lgBFv/ZUDjLb
	 zTS4Xna0KtdTt9rBYbsxC4+5oTUNUVqbo92ZQdFG87Ehrs0ok45qYAjZdRabit2yiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfEksMna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90A606A31C;
	Fri, 27 Nov 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfEksMna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101721F000C1;
	Fri, 27 Nov 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794524;
	bh=l96ynvHLdVkKmQ+hThFK5F7Zb52Cz8ekuo9zG2+dkKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfEksMnaL2c+EFzw9Hd7G5Dj2EtfjMGgUv055n6GuVaVDnV/R3aO4lVr38bJTlYGc
	 rWzsG5uGV9ZLmmX3kM7/kEk5jfBf83ztGrWEQpyCjcUHhYBEJIxJWPi7lEjYYLocBU
	 V9z1zY7BYsmoMBxGxdOUPQ5hl5U2HqoxkcomM7VfpkuUg3eso7ufBm9Sd0bwLIaSBI
	 U9WYiI0w9eSnnTWrrx3wEciAwGnAhUCfYuaFLQvVPjMbJNpKzvpy3MJAi8K6WPcPOY
	 55mHoNep+Umdv6xw4Z2mKTseVYX+FGXi0GUifpiSr+wy/yxZyG24wbwSutoipfAoqh
	 5OHuOfwG6DylQ==
Message-ID: <sashiko-outbox-237783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/15] KVM: x86: Filter emulated CR0 and CR4 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261127152730.99319-11-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
 <20261127152730.99319-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:48:43 +0000
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
- [Medium] KVM: x86: 32-bit truncation of CR0/CR4 writes in
  emulator_filter_cr_write()
--

commit 08515d18b5f74a7d7b3ddcb78d650f9907df852f
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Filter emulated CR0 and CR4 writes

This commit adds register write filter checks to the x86 emulator's MOV to =
CR,
CLTS, and LMSW instruction handlers so filtered CR0 and CR4 writes exit to
userspace with KVM_EXIT_X86_REG_WRITE.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b559c7880e546..4e6f0cb80288c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5846,6 +5846,42 @@ static int emulator_filter_xcr_write(struct x86_em=
ulate_ctxt *ctxt, u32 index,
>  				       vcpu->arch.xcr0, xcr);
>  }
> =20
> +/*
> + * Divert an emulated CR0/CR4 write into a KVM_EXIT_X86_REG_WRITE exit w=
hen
> + * it hits a write filter.  Called by the instruction handlers (MOV to C=
R,
> + * CLTS, LMSW) before any architectural effect; state loads that reach
> + * ->set_cr() on other instructions' behalf (RSM, task switches) are not
> + * guest register writes and stay unfiltered.
> + */
> +static int emulator_filter_cr_write(struct x86_emulate_ctxt *ctxt, int c=
r,
> +				    ulong val)
> +{
> +	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
> +	u64 old_value, new_value;
> +	u32 reg;
> +
> +	switch (cr) {
> +	case 0:
> +		reg =3D KVM_X86_REG_FILTER_CR0;
> +		old_value =3D kvm_read_cr0(vcpu);
> +		break;
> +	case 4:
> +		reg =3D KVM_X86_REG_FILTER_CR4;
> +		old_value =3D kvm_read_cr4(vcpu);
> +		break;
> +	default:
> +		return X86EMUL_CONTINUE;
> +	}
> +
> +	/* Match the merge emulator_set_cr() will do with the same value. */
> +	new_value =3D mk_cr_64(old_value, val);
> +
> +	if (!kvm_reg_write_filtered(vcpu, reg, old_value, new_value))
> +		return X86EMUL_CONTINUE;
> +
> +	return emulator_reg_write_exit(ctxt, reg, old_value, new_value);
> +}

[Severity: Medium]
Does calling mk_cr_64() here truncate the upper 32 bits of val on 64-bit
MOV to CR0/CR4?

arch/x86/kvm/x86.c:mk_cr_64() {
	static u64 mk_cr_64(u64 curr_cr, u32 new_val)
	{
		return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
	}
}

Because mk_cr_64() takes a u32 new_val, passing the 64-bit operand val
discards bits 63:32 and replaces them with old_value[63:32] (which are zero
for CR0 and CR4).  When a 64-bit guest executes an emulated MOV to CR0 or
CR4 with any upper bits set, kvm_reg_write_filtered() cannot match filters
on bits 63:32, and vcpu->run->reg_write.new_value strips fault-inducing
reserved upper bits that userspace needs to see in order to reject the
write with KVM_INSN_GP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127152730.9931=
9-1-dwmw2@infradead.org?part=3D10
