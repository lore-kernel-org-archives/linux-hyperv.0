Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590537;
	b=a403SAgGoHPg3YQvFQ7ki/WBoPUGhhxiRqe6Qnlfc0esvPc7bo95xr0qek334lylKPnb
	 pRuLiTgRKjXTPOtkW+55pGumrP5D0utyhujqoAFM0T4kfnXPUws4tDHEh3pkEBWiC7Ajv
	 vKeZh3Mc71W2lUgErYh0ylrclpdFzmzE+mp0g+eRY2nlvQlKEIhASBL91i3paozz85WZk
	 qDxvHeHygM4bBtszrtiPaCPPQvVsXRB86P/6NSe3N64Fd6cZklTHVpn4NxADOxsiNJwPN
	 wJBNQ5PTsxUfTTlTkgkZxLkywzUIDlGmRMgBkDwKzfXMejfjWodFup3njVb47UGHKcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v3pStVz/719WTAUk1+xHAiMJ4ZTeYF4JuCVC++s0TPk=;
	b=fKNOn/KP2AYSJiSagCVID7OKX+CMKi74LMdFpgTgYkZOpJDbG7j5E2vIonIJbWIMdNmt
	 f/VFGgM+yn3mjix/YGZvH8gVvC3JKC6j7gIXdSuxcxZQ+UiraWVujFMa6SZQWrVbtFj+c
	 dZ2ugKB0EXqjX9oexn9SAph7qAz2gEuMsFqcwKZkiABpxHk6U0NKSNrqMJsiVMlhe70gW
	 D4EWtrrQvAZdWfyZm/Bbi7mzro/icflzR6TOBLJ/xaN7lB/UP4qBnjstO+dMqS3vmKnJR
	 FrH+Ekfd+qHz1GqtEWb/ow3BFuuJzaeft+1Vv48n4ogBF5OLT8o3mTO6yahPFPBvMSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3LUpN21;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665F606A88B;
	Fri, 13 Nov 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3LUpN21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65721F000CA;
	Fri, 13 Nov 2026 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590537;
	bh=v3pStVz/719WTAUk1+xHAiMJ4ZTeYF4JuCVC++s0TPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3LUpN21UaTpwHdm6+mMNb99pzLamRkAv92B3bV+M6DYrZWvwH50dPTN2lF9YJ5n5
	 b9FV6tDUedFcNziI9wYuNgWdfvSlNDfpsXepY6/7XH1ibCPOYadIDm7uQIuUSznyZf
	 coGVdJx8D4zKgC3Cu/PT5IggcyF13+5cPYNAEhcrKeV68ZG3z/c7ZVtRPpB4u9t0L+
	 q5LUvVp98wmkLRvMtUYQu8RXzvVPShTa/dFF5P+SFw7KJARVpoGxQOOpEqolU9TkoT
	 +SDjJndLgCs7PV4jbpZN6lweeC/9rYLilkcwCJ/rvCAH9u7u0cDIHIAf/PxOexYna0
	 uG7kHj9CQOstg==
Message-ID: <sashiko-outbox-213294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: selftests: Add Hyper-V hypercall forwarding
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261113170535.79246-5-dwmw2@infradead.org>
References: <20261113170535.79246-1-dwmw2@infradead.org>
 <20261113170535.79246-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:22:16 +0000
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
- [Low] KVM: selftests: missing volatile and XMM constraints in
  guest_code()
--

commit e7e0d35b7ca4b9fc386b6fe7a75c6cc9bf38431a
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add Hyper-V hypercall forwarding test

This commit adds a KVM selftest covering KVM_CAP_HYPERV_FORWARD_HCALL for
memory-based and fast hypercall exits as well as hypercall completion
cancellation via KVM_SET_VCPU_EVENTS.

> diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/too=
ls/testing/selftests/kvm/x86/hyperv_forward_hcall.c
> new file mode 100644
> index 0000000000000..4c290b6a10122
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
> @@ -0,0 +1,337 @@

[ ... ]

> +static void guest_code(gpa_t pgs_gpa)
> +{
> +	__sse128_u in, out;
> +	u64 status;
> +	u8 vector;

[ ... ]

> +	/*
> +	 * Fast form: the register parameters and XMM0 reach userspace, and
> +	 * the XMM1 value userspace writes reaches the guest.
> +	 */
> +	in.as_u64[0] =3D XMM_IN_MARKER;
> +	in.as_u64[1] =3D XMM_IN_MARKER + 1;
> +	out.as_u64[0] =3D 0;
> +	out.as_u64[1] =3D 0;
> +	write_sse_reg(0, &in.vec);
> +	write_sse_reg(1, &out.vec);
> +	vector =3D __hyperv_hypercall(HVCALL_TEST_CODE | HV_HYPERCALL_FAST_BIT,
> +				    FAST_PARAM0, FAST_PARAM1, &status);
> +	read_sse_reg(1, &out.vec);
> +	GUEST_ASSERT(!vector);
> +	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
> +	GUEST_ASSERT_EQ(out.as_u64[0], XMM_OUT_MARKER);
> +	GUEST_ASSERT_EQ(out.as_u64[1], XMM_OUT_MARKER + 1);
> +	GUEST_SYNC(STAGE_FAST);

[Severity: Low]
Can the compiler reorder read_sse_reg() across __hyperv_hypercall(), or
clobber xmm0 before the hypercall runs?

In tools/testing/selftests/kvm/include/x86/processor.h, read_sse_reg()
uses a non-volatile asm statement with an output operand and no input
operands, and neither write_sse_reg() nor __hyperv_hypercall() declares
xmm register constraints or clobbers:

tools/testing/selftests/kvm/include/x86/processor.h:read_sse_reg() {
	switch (reg) {
	...
	case 1:
		asm("movdqa %%xmm1, %0" : "=3Dm"(*data));
		break;
}

tools/testing/selftests/kvm/include/x86/processor.h:write_sse_reg() {
	switch (reg) {
	case 0:
		asm("movdqa %0, %%xmm0" : : "m"(*data));
		break;
}

Because x86 selftests are compiled with -O2 -march=3Dx86-64-v2 (with SSE
enabled), the compiler can schedule a vectorized zeroing of out via xmm0
after write_sse_reg(0, &in.vec) or move read_sse_reg(1, &out.vec) ahead of
__hyperv_hypercall(), causing spurious assertion failures in
handle_fast_hcall() or guest_code().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113170535.7924=
6-1-dwmw2@infradead.org?part=3D4
