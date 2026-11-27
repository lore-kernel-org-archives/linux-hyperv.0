Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794776;
	b=xAwxlQ+ltwLH+Sx8CyBsd83IoYW2Xxy4fu2sBuXkYqF9BsKHbRdBYhnqdiND8QBttxec
	 HZa6oLTOVjSDTEz1TeD9SPWe6qNiF9et/W/ZF14BCT2WIPdCtFFgXKJHzOgHKVkan2OSI
	 K7QIjwfMbr1GMjO+H5MVahZAg7ZczC5xPWHjOcYO+BdB3aKIWJ4bCbAOjnHDUitLZxIOC
	 51qmMRN/ql5jJQQwJ2TemQG1f+HgN8eFJCMLi9ZggGloDWqia1W59fSdkynHjWT+389Un
	 1eJ34+ffYp8wMiWBul5/FW3EJT+xpME5L2eQYBHf8c/TgMZ+GyQLKtOMin0+UgTRRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eESdzYiprt4+VZEiuy+XH/EmeBxpCJza/jDvQ3eWwAM=;
	b=cU/nF9uVTC8LAYlCPf0Sk/SwhzN772RJOf3nI3s6BiW/WkPxKJ2LuK6XTwJvO7oAcAFW
	 sNRbmVvF0qCW8T7crB99YCFY/CSwN9PkaZsvSS6Afj93OKYdEP03juGlsJ+2NmOLOVdBj
	 pPuLifQxM5QRM32QwhD2Y0/nLl7pWWB1uGhdDAWz4EhnW8E+YU7AhJu+g0ZD9gNkU1Amd
	 Awxdos6/IUoHgIvON8JegGCXl7mQdOFk5M/Wwf1Wf24XXfMb1dZg5TH66k+FdeM5/VbRf
	 2uwwKfqcs/cBDsXYo906j4qdFrctiqqdQYoMr5T/vrucWummPBxVwcpTlu64bt5Mjjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs6BJ0Su;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27799606A31C;
	Fri, 27 Nov 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs6BJ0Su
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F52F1F00893;
	Fri, 27 Nov 2026 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794775;
	bh=eESdzYiprt4+VZEiuy+XH/EmeBxpCJza/jDvQ3eWwAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hs6BJ0SuuX5+0tjK+hbFQ6XNpDh1+6qTp6qkXoI36Pc69GRPelSjrqL4r9NzMHBK+
	 I5rimj3z33gMtHcpXjsHH7rRLWzt6as/PwJ5FgDiCkbD3tJLVQYM8r1UybbCt3V4UJ
	 Yp/o+r67o36gsyNqiUk+P28ClogJTOM7yjnqcNsQuDbAHC3iX17IiQELTOcLAubkTp
	 Of5OQi3VdI2sgpQ4IIfeotEAiDkgkOoPj1dr1KDg3uJ7pQnFIzTOpooOTeCSECMHm/
	 qWXDyR69AbaPbkZzrWyqr0PRG55wkM7mxRoudIc/iHSZqNx5ivVpYXl6OjvfKi/HqB
	 u0NkMOEMvIY1w==
Message-ID: <sashiko-outbox-237790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/15] KVM: x86: Add descriptor-table registers to
 the write filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261127152730.99319-14-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
 <20261127152730.99319-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:52:55 +0000
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
- [Medium] KVM: x86: em_lgdt_lidt() validates canonical base before
  filter_dt_write()
--

commit a776c4d770743069de4432de278b52d34d58dbce
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Add descriptor-table registers to the write filter

This commit extends KVM_X86_SET_REG_WRITE_FILTER to support filtering guest
writes to GDTR, IDTR, LDTR, and TR via LGDT, LIDT, LLDT, and LTR across VMX
and SVM.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 9a4aebcccc958..b40e347c498f4 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -3489,6 +3512,11 @@ static int em_lgdt_lidt(struct x86_emulate_ctxt *c=
txt, bool lgdt)
>  	    emul_is_noncanonical_address(desc_ptr.address, ctxt,
>  					 X86EMUL_F_DT_LOAD))
>  		return emulate_gp(ctxt, 0);
> +	rc =3D ctxt->ops->filter_dt_write(ctxt, lgdt ? KVM_X86_REG_FILTER_GDTR :
> +						     KVM_X86_REG_FILTER_IDTR,
> +					desc_ptr.address, desc_ptr.size);
> +	if (rc !=3D X86EMUL_CONTINUE)
> +		return rc;
>  	if (lgdt)
>  		ctxt->ops->set_gdt(ctxt, &desc_ptr);
>  	else

[Severity: Medium]
Should em_lgdt_lidt() call filter_dt_write() before checking whether
desc_ptr.address is canonical?

The KVM_EXIT_X86_REG_WRITE documentation states that the exit is taken
before KVM validates the write, so new_value may be one for which the
instruction would have faulted (matching em_lldt(), em_ltr(), CR writes,
and XSETBV).  Calling emul_is_noncanonical_address() first injects #GP(0)
into a 64-bit guest that loads a non-canonical GDTR or IDTR base instead
of exiting to userspace when a filter is armed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127152730.9931=
9-1-dwmw2@infradead.org?part=3D13
