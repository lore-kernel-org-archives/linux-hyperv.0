Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A42D8370
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631609; cv=none; b=gbJ/UGSIqFg36a5u2nWIkvXz5igeNUEfe/NlpnKMxud/IgJrreEr9XBO0lG9Qc+EyQhKV3xHVEof9i4LFtnLMsB7//WYCKrgQRgE5N6IQKJwAIaeqRCwJMwFydKJfSx3WK8HLW5eb2zGVus7Ite4X+yZx6W67gqjTaqhDUeVO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631609; c=relaxed/simple;
	bh=UuJq9TLxLXOIfVx0Sj3VMgdZHhFd2iWnow3LRf8l2CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpfclFd80I4gSEtL0QVHiwC2sQiCb4f0nsomGfqXmdx1/K2OD2ZkQatPDgDwK/4DxjnRSBEKYwSGNhXmGPOv51EhUGghJN7LFmn/Wt271sXWAoJfEZ99D1BoVKZL02xBC10xmcZZG5s7EcbwMVebjdnjjnWeMrHvTtZ1M2Szvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkfs4ajm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkfs4ajm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452821F000E9;
	Tue, 25 Aug 2026 04:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631608;
	bh=IoCoRRXGlmS+qzLIXSZjYnV4VbyRV7jKkrFbS2mf0lw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bkfs4ajm6csIHpTkium8amvDxSNRFFnHzvW73Ug0fJ6aZbslwTTQqHryZcxq8W4Bk
	 rKjIp9TOhehnfLTU+V2xWPKDB1DF8edIdCqCE7VBfDLK/E2NfWQiwcQlK4ZtwG23aB
	 i2NQD040OJ+6Pb1PWjzpkuffnZWb1+PCK0wAMUpoNWTd46tSzs7SUYaTlTOqqTbVZz
	 vkX9XLpnMyvMcmlmTWtILggcFdkboBvLX59LHEJYGfgkpPntNfKwm/0mn0IQc1+5s7
	 Q92O3v3kiT7LIRzDQ3w897f8OjQAjf546UBe6xcl/3e7TxAEk9k/DXKKGW9CvD7Bs/
	 ZB39JYb8rGD0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] mshv: set up own SynIC registers on a nested
 root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260825040505.826600-8-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260825040505.826600-8-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:20:07 +0000
Message-Id: <20260825042008.452821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing MEMREMAP_DEC flag and shared GPA boundary masking when map=
ping hypervisor-shared SynIC pages.
- [High] Missing pointer nullification on the error path of mshv_synic_cpu_=
init leaves a dangling pointer in a per-cpu variable.
--

--- Patch [7]: [PATCH v3 7/7] mshv: set up own SynIC registers on a nested =
root partition ---
commit 04d92759c80f66439e3b646d824c274dc6edc45b
Author: Wei Hu <weh@microsoft.com>

mshv: set up own SynIC registers on a nested root partition

The commit fixes SynIC register setup for nested root partitions by program=
ming
non-nested MSRs instead of relying on VMBus's nested MSR setup, restoring
correct intercept and async-hypercall delivery.

> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 7c168e5a740dd..7d714ee5d2267 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -472,7 +472,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
>  	 * See hv_hyp_synic_enable_regs() for that initialization.
>  	 */
> -	bool vmbus_active =3D hv_vmbus_exists();
> +	/*
> +	 * On a nested root partition VMBus programs the *nested* SynIC MSRs
> +	 * (SIMP/SIEFP/SCONTROL) via hv_set_msr()'s nested remap, whereas the
> +	 * code below reads/writes the non-nested SynIC MSRs. So when nested,
> +	 * do not defer SynIC setup to VMBus -- set up our own registers.
> +	 */
> +	bool vmbus_active =3D hv_vmbus_exists() && !hv_nested;
> =20
>  	/*
>  	 * Map the SYNIC message page. When VMBus is not active the
>  	 * hypervisor pre-provisions the SIMP GPA but may not set
>  	 * simp_enabled =E2=80=94 enable it here.
>  	 */
>  	simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
>  	if (!vmbus_active) {
>  		simp.simp_enabled =3D true;
>  		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
>  	}
>  	*msg_page =3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  			     HV_HYP_PAGE_SIZE,
>  			     MEMREMAP_WB);

[Severity: High]
This isn't a bug introduced by this patch, but does this mapping need to us=
e=20
MEMREMAP_DEC and mask the shared_gpa_boundary bit?

If the root partition is running as a confidential VM (such as AMD SEV-SNP =
or=20
Intel TDX), hypervisor-shared pages need to be mapped as decrypted.

Mapping them as encrypted memory could cause the driver to read garbage=20
intercept messages and miss doorbell events.

[ ... ]

>  cleanup_simp:
>  	if (*msg_page)
>  		memunmap(*msg_page);

[Severity: High]
This is a pre-existing issue, but does this leave a dangling pointer in the=
=20
per-cpu synic_pages structure?

If memremap() fails for the event flags or ring pages during initialization=
,=20
the error path unmaps *msg_page but doesn't set the per-CPU pointer to NULL=
.=20

Since the Hyper-V callback vector can be shared globally, a shared interrup=
t=20
(like from VMBus) could fire on this CPU after a failure.

If the IDT handler unconditionally calls mshv_isr(), could it bypass a NULL=
=20
check and dereference the unmapped pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825040505.8266=
00-1-weh@linux.microsoft.com?part=3D7
