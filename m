Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433786;
	b=KXlUSXtvswK4tKAUqcJjoMyTm1GlhBXJhkZy3R7WwjI2F4v3DXlZ3n7ZH4v58UGRnNPg
	 rjktJbV0NBXRud63RdN1qmWlB7oY4btPRDVFsjHj8+OFhDVjwNB4ifBhRGDAIF9m2HlYO
	 9wKJlV5UnT25YPbWiBGwmKwiNkdytgau3BQSWNXeDxTIBCWnWAF35I3BkMFagZa0ndB4V
	 Bzgz+oFR95jnHXy1HfJp8E+bYdvkoSVpYgxT4C9MzmrW4J7PnIy8NGYO8Sdp2M0ahfwjY
	 DzD0DMyYX3VHzGhzqX7/Fh/L7frRTORLqPVHLqDRKAtfAhCl4EGpOqpUPAbbfyu4Njw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rk/CBjYjLf7zZ4GcPg89td12CIO5508/QyBpAj9r7oQ=;
	b=D08x2lA6Kmfx2SuPx1+MIjS7egMpzlk/cKk+tVpCEVkFMS6zFev2Te31k9BqgYcHDRXT
	 fMHOBinDfInKbIAch1JA4ga3ufr3oO4Bg/J6Puu0kQ/kQCWr7J+GVHs/hfZoJcvk7c7l5
	 Bq1Z6N3YTxSZnC3qaCYSkYzUAtU78bl9qL93gtxWaroXqbTCvvaAJyWD245XJ9Bu9cAFd
	 zQjczAELu08NWBBhuTkTdHF40DscqoVGPx1+zje2H8TGGpry4VqgWvztRZi2gYtAmiQzl
	 DOsdsHGbOHbMKHrj1+eGWVQRwz8joS3w8G2zuw9pAzH+9f+ENecq5ACGzDf/IAQZu8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsT8YemS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBC606A321;
	Wed, 11 Nov 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsT8YemS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F01F00A05;
	Wed, 11 Nov 2026 21:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433785;
	bh=rk/CBjYjLf7zZ4GcPg89td12CIO5508/QyBpAj9r7oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsT8YemSXRS2jViqx7kOVKJwMe0A6jKMij01GPXzSvzOnkgsfcpFSPuRnQa4m1Yyi
	 IL4KEz0N9NRGghWFECR4is5QPQXSo+gjvdKcsXMbGSQAmy08RQnzPrmlfChIVVWUvI
	 +bOHGc+3rGlqYJnNOCkJV6d47e3rMhOKwkuvWClYSHv1T+jOeqVgKqxuLthkzkUTJR
	 ck4bKIeklb7wWi62ChPKK250i2IyzOrGeQYH4XJN4B+j4RltJV3RfnHRixzjYbhNEh
	 yDNYhYXeNVSqGmbRWalix8WT1DCCPlhZKjeLi+ljrXYX7c4acKCd3kXIG1Uuwf4U+F
	 dT/vl+K5tGUEg==
Message-ID: <sashiko-outbox-209724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Add Hyper-V hypercall forwarding
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261111205836.4186584-5-dwmw2@infradead.org>
References: <20261111205836.4186584-1-dwmw2@infradead.org>
 <20261111205836.4186584-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:49:44 +0000
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

commit 10757ad97814a547a0e0ce57f22b5e41e1c14071
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add Hyper-V hypercall forwarding test

This commit adds a kselftest for KVM_CAP_HYPERV_FORWARD_HCALL covering feat=
ure
mask validation, memory-based and fast hypercall exits to userspace, XMM
register output, 64-bit result handling, and KVM_HYPERV_HCALL_UD fault
injection.

> diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/too=
ls/testing/selftests/kvm/x86/hyperv_forward_hcall.c
> new file mode 100644
> index 0000000000000..5afc99ed533c8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
> @@ -0,0 +1,268 @@
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
Can compiler instruction scheduling or XMM register allocation reorder
read_sse_reg() or clobber xmm0 across __hyperv_hypercall()?

x86 KVM selftests are built with -O2 -march=3Dx86-64-v2 (with SSE enabled),=
 and
read_sse_reg() and write_sse_reg() omit both volatile and XMM register
constraints:

tools/testing/selftests/kvm/include/x86/processor.h:read_sse_reg() {
	switch (reg) {
    ...
	case 1:
		asm("movdqa %%xmm1, %0" : "=3Dm"(*data));
		break;
    ...
}

tools/testing/selftests/kvm/include/x86/processor.h:write_sse_reg() {
	switch (reg) {
	case 0:
		asm("movdqa %0, %%xmm0" : : "m"(*data));
		break;
    ...
}

Because read_sse_reg() has an output operand, no input operands, and no
volatile qualifier, the compiler treats it as a movable computation with no
side effects, and the memory clobber in __hyperv_hypercall() does not preve=
nt
hoisting read_sse_reg(1, &out.vec) ahead of the hypercall since out is a
non-escaping local variable.  In addition, because neither write_sse_reg() =
nor
__hyperv_hypercall() declares XMM register operands or clobbers, the compil=
er
can use xmm0 when zero-initializing out after write_sse_reg(0, &in.vec),
causing spurious test assertion failures in handle_fast_hcall() or
guest_code().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111205836.4186=
584-1-dwmw2@infradead.org?part=3D4
