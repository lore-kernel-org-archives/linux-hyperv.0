Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794435;
	b=tHIsCR2c4nKguzBwx8psgQbY1m44nHdOROijmJwE+JJ/TVBCnCWVZ2G5eQfnDeE0VsZ7
	 Z80cL48v+N5DAkvjgId5cuqWTfHq68r+z97gi/z9nMRrLzPDJ+iCaSdrW3kFC2jLRZTZU
	 fZzYqBhV12HCnf2WjTnfQGVgBvfqHoINEKVd4xWIcOWLBf6lFHubGsk943yCbmMiMAqdU
	 nJdhAzcx+8Jx3uja49GiAPZqVpN5Im320zLMr1cpSXJbdxgGcB5JrSqWeimta3BBURTSa
	 PU+mJz9+BZu1R342AmlXj4+33/WnuLe2avuORsdvdO5xQcqH8w4NKgHZ/PjJDejU/KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mFSsmB9kiNOQ0rDVYSaTBmIMBmJV5MVfeABrB+C99M0=;
	b=BCOHEUWlgzSbZ/fPO0H+/JopbvbsQQfMzjvdK2jKgAO246VfOb1WWhtlD+36QkH6y8w5
	 KZslTPc7h6fisQKc/FBoPSy6bOgRacbhu+crXkPIIl0k5e4AjEmtJzrmW0mlbmbawc16G
	 oQZv6OGyAI1u5x3lN0TLjzPd2h660JNpdgiOEMEkBPPIAyX+FgSAkar2gQPzM0Io5f65n
	 GYcVDQ+VInuRYHHcy8RwOfx6i8YmD3NHai1pJ+Lc1oeUrC44wIh8mZNaH598Y+WUkVnTn
	 Ba3sB2CjsdZ2Z3f6FoMgysHQEHHIURgMUaKT4Gvkwgj/D9q2sl8/Bb5u77l28adGkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG+prKvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F06606A31C;
	Fri, 27 Nov 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG+prKvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82451F0089B;
	Fri, 27 Nov 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794435;
	bh=mFSsmB9kiNOQ0rDVYSaTBmIMBmJV5MVfeABrB+C99M0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TG+prKvxV2OqMR1pwyFRJ5NZ5uC/j/WGo8VDndL/CvSX/+WK+GLSwamS9Srq8QP0X
	 +Ct8xB93WTz8nTWh29uVyFJNiIv4cgQRknrrdKtX+xHPwQ9EmReF0PHHNb/6dAxZ0q
	 O8Zu1gXivGQXjFuqI/Pp1six0OXpVyRhzzuRvZzxe6KY1HlPOBtZIeujF4NpoABpn1
	 JcdoxIZjdFjn627VJfAkl1spV7PK/I4P1mv9mD/2O9bLrgA6GCIDO3LQZq0yTgmgOk
	 XEgyzy2d5SWxFeieLk015S6K2ZnSGUG58ynh8tEU7MR44LXZyb2tNqpMOjSqPMhD8y
	 Bhwf8ArlenQLQ==
Message-ID: <sashiko-outbox-237780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/15] KVM: selftests: Test the register write filter
 with a nested guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261127152730.99319-16-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
 <20261127152730.99319-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:47:14 +0000
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
- [Medium] KVM: selftests: intercepted CR4 write in l2_vmx_code() masks
  clean-vmcs12 bug
--

commit 6862822e0c88af446e20e6806bc0fab3b0651065
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Test the register write filter with a nested guest

This commit adds an x86 KVM selftest to verify XCR0, CR0, and CR4 register
write filter behavior across L1 and L2 on SVM and VMX.

> diff --git a/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test=
.c b/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c
> new file mode 100644
> index 0000000000000..4977b3d5f64bd
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c

[ ... ]

> +static void l2_vmx_code(void)
> +{
> +	xsetbv(0, LEGACY);
> +	vmcall();
> +
> +	/* Out to L1 once more, which resumes L2 with vmcs12 as it is. */
> +	vmcall();
> +
> +	/* So L2 still owns this bit, and sets it without an exit. */
> +	set_cr4(get_cr4() | FILTERED_CR4_BIT);
> +
> +	/* These two exit to KVM, which must not filter them. */
> +	set_cr4(get_cr4() | INTERCEPTED_CR4_BIT);
> +	set_cr0(get_cr0() ^ INTERCEPTED_CR0_BIT);
> +	vmcall();
> +}

[Severity: Medium]
Does writing INTERCEPTED_CR4_BIT after FILTERED_CR4_BIT cause the
STAGE_L2_CR4 check in test_vmx() to pass even if KVM fails to update
vcpu->arch.cr4_guest_owned_bits on the second VMRESUME in resume_twice()?

The first VMRESUME in resume_twice() has a dirty vmcs12, so
prepare_vmcs02_rare() clears FILTERED_CR4_BIT in vmcs02's hardware
CR4_GUEST_HOST_MASK.  The nested VM-exit to L1 then clears FILTERED_CR4_BIT
from vcpu->arch.cr4_guest_owned_bits via vmx_refresh_reg_write_filter(),
while vmcs02's hardware CR4_GUEST_HOST_MASK keeps FILTERED_CR4_BIT clear.

Even if the second (clean-vmcs12) VMRESUME skips updating
vcpu->arch.cr4_guest_owned_bits, setting FILTERED_CR4_BIT in L2 updates
hardware GUEST_CR4 without an exit.  The subsequent get_cr4() |
INTERCEPTED_CR4_BIT then reads FILTERED_CR4_BIT =3D 1 from hardware GUEST_C=
R4
and triggers a CR4 VM-exit to KVM, where handle_set_cr4() writes the full
register value (including FILTERED_CR4_BIT) into vmcs02's CR4_READ_SHADOW.
When L2 later exits on vmcall(), vmcs12_guest_cr4() pulls FILTERED_CR4_BIT
from CR4_READ_SHADOW into vmcs12->guest_cr4 regardless of
vcpu->arch.cr4_guest_owned_bits.

Setting INTERCEPTED_CR4_BIT before FILTERED_CR4_BIT avoids populating
CR4_READ_SHADOW with FILTERED_CR4_BIT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127152730.9931=
9-1-dwmw2@infradead.org?part=3D15
