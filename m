Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFA1E5724
	for <linux-hyperv@vger.kernel.org>; Sat, 12 Sep 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172109; cv=none; b=uUdYrFuKnmzRTSQ17Jq6M7wfo7Ai+2txJtHaglDLj0IpmcQNsOln0AecpGTgKhQJhhv3Sk9IGpASFNOfSprGTNYYNvd2+R2TfZEeFStFoCgV931sa03ukqxzQ9XwuZ/lG/6Y73kKN2VF7FGxoNNtLqyUKIP58yKM8bnEmKqkT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172109; c=relaxed/simple;
	bh=ABm1FEY1jfImcK9ef9McHiUfy2jkpRZb6a6hSVtknMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIDR5x0JPuyzQnN1utI/YBqPx2pwaWEBcP2008aqtGEseGK+lBaqgDLFm59mPnrzszUuz3OEMtbzKfdVIt/wKSn3reAQIsxzAgZYUEECN1wwLn5CAs/PZ5wJQUTdJXkF/R64HRCTee6f1pPOh6VYIVb65ype0NA4JTHaJKPYHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8yIHgas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8yIHgas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C31C1F000FF;
	Sat, 12 Sep 2026 00:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172108;
	bh=ORhLUTZZWLp32NP7TSKzWju15OMcIVMp7sTvN06jyvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8yIHgas8H4rXn18vUqi9viRpR2OxR8Q/kysY1/52rYPON0TSAQ7QbJ7Peyb9Shae
	 G5ZULRPSJi/Ueu/B5dgdyneI4ZBAiGcvdbKCs4f6OAjiTIfC8kcs33yWSydWgLv6NL
	 0LYYb14UW+XmiI1oo/7h6RTpUZRg9XCNDVvNA8D9MHGE8cPskJel4DlYpEpb3aRTr3
	 3qcP0O4/iiulom58f2PkBoeZVQWbc9vOZmhL1XgPK+gUZYtLzsnYtrt0rxs/e9xaoE
	 M5WXGeNRf3/LoKpWTgs0s1VQCird3r6vbP8O53jE1l58L9VwixPzFSIKGa0x0LiLhK
	 D+z3ieW3jS2GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/3] mshv: Redesign hypervisor memory deposit logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260912000318.2959621-3-mrathor@linux.microsoft.com>
References: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
 <20260912000318.2959621-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 00:15:07 +0000
Message-Id: <20260912001508.0C31C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of all un-deposited pages when `hv_do_rep_hypercall`=
 returns `U64_MAX`.
--

commit 68b286f4de61fdc1a888242cfc4b1a1ea3d187dc
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Redesign hypervisor memory deposit logic

This commit redesigns the hypervisor memory deposit logic to optimize
performance and address preexisting issues. It defaults to allocating and
depositing 2M chunks when possible to reduce overhead and avoids unnecessary
interrupt disabling during the process.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57864bb5bcd8c..df39a5c587ca2 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
[ ... ]
> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contig=
uous)
> +{
[ ... ]
> +	/* Not using hyperv_pcpu_input_arg, so no need to disable interrupts */
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages, 0,
> +				     hc_input, NULL);
> +	if (!hv_result_success(status))
> +		goto err_free_dep_pages;
> +
> +	if (lastpfn) {
> +		hc_input->gpa_page_list[0] =3D lastpfn;
> +		status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
> +					     hc_input, NULL);
> +
> +		if (!hv_result_success(status) && hv_repcomp(status) =3D=3D 0)

[Severity: Medium]
Will this leak the page pointed to by lastpfn if hv_do_rep_hypercall() retu=
rns
U64_MAX?

If the hypervisor is unavailable or hypercalls are unsupported,
hv_do_rep_hypercall() can return the sentinel value U64_MAX, which is expli=
citly
handled by hv_result_to_errno() elsewhere.

When status is U64_MAX, the hv_repcomp(status) macro extracts bits 43:32, w=
hich
results in 4095 instead of 0.

Does this cause the condition to evaluate to false and skip freeing the pag=
e?

> +			/* We deposited lot earlier, so give it a go */
> +			__free_page(pfn_to_page(lastpfn));
> +	}
> +
> +	free_page((unsigned long)hc_input);
> +	return 0;
> +
> +err_free_dep_pages:
> +	hv_status_err(status, "\n");
> +	rc =3D hv_result_to_errno(status);
> +
> +	for (i =3D hv_repcomp(status); i < num_pages; i++)

[Severity: Medium]
Will this loop fail to free any pages in the pfna[] array when status is
U64_MAX?

Similar to the check above, if status is U64_MAX, hv_repcomp(status) evalua=
tes
to 4095.

Since num_pages is bounded to a maximum of 511 (HV_DEPOSIT_INP_MAX) in this
path, the loop initialization sets i =3D 4095, making the condition i < num=
_pages
immediately false.

Does this cause the loop to terminate without executing, silently leaking u=
p to
511 allocated pages per failed deposit attempt?

> +		__free_page(pfn_to_page(pfna[i]));
> +	if (lastpfn)
> +		__free_page(pfn_to_page(lastpfn));
> +
> +out_free:
> +	free_page((unsigned long)hc_input);
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912000318.2959=
621-1-mrathor@linux.microsoft.com?part=3D2
