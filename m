Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE151A08AF
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834277; cv=none; b=uic/6YxNbEZ2lz77QO/Yx0z4rwpLwunMtEXimo7ULz05Hui/wuSsfMxfS9RXgpxb6zqffbK99O7yfyEj1/pFF9xRUDEVOzTH/92Gim18Z1/ZLIcYcJqZdj77vbCiBzx6VGSWToY1CdOZlu72UfS/KOSpcyIr85taBNzZ2lmGmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834277; c=relaxed/simple;
	bh=3G3AKc2SPl9VsXmE5oqiKNp2R5Xpus7MapyEWPEaNCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IT+6JE7znziXExt1XDsOHDTR+CUCDEG5Q1ew9r79KYeH8l9dRhjzKt1cTq5ny7OR4b/rJowYDdv6eTOH2ZGnhUYfLWgXnw2Zq+TY3nLYZzKvrSOZooX3n9LJniLrwP4L3L7Rkv8XFxuXjY7Oiztl4pdMeoi+nx/BEUh1IN79Ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HigqxdhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HigqxdhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790601F00A3A;
	Tue,  8 Sep 2026 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788834275;
	bh=Nkyuymj7mBved5RNygfBUAO4tOYPsc0BqS1XKDjoXQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HigqxdhJHEFhCz5YPo2qGL3dAVaA0yA2aV/dwjtdp9fa2p/phq9npQZVfAlHQaniQ
	 0xWz+COyfLv+wg+NvkGc3Ap9DnBi5ZeSJ1GqQ6Ovafh7ICAEdSJqSOijxhQcmE2YS6
	 /r5oqLdgPYO27ShgIlGgG5m/B3EXTFMRMqNYkq/nfw46i4y2GYoQh9SPnzDXacqKI5
	 7EQC4iXP9fdP/iaxl1RUzkqjDcHitr5V8lABoMFZkp6Qy8Xt1ERcEUPELdbmWQZ2Av
	 EzajkGbdy+4u13R/ZJAI91X4qBlNru9dUhcmEa/McOTjeCswLjezzH+kgV7db5wyQv
	 cnAFSuixiSv1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/3] mshv: Redesign hypervisor memory deposit logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260908021340.2548924-3-mrathor@linux.microsoft.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 02:24:34 +0000
Message-Id: <20260908022435.790601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The error path for a failed second hypercall erroneously frees=
 pages already deposited to the hypervisor and double-frees `lastpfn`.
- [High] If the deposit hypercall fails with `U64_MAX`, the error handler s=
kips freeing pages, leaking up to 511 pages per call.
--

commit 03b27f8f1637e85a6319eb9bbc84a63e9b9df5c5
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Redesign hypervisor memory deposit logic

This commit redesigns the hypervisor memory deposit logic to improve
performance and fix contiguous range requirements. It changes the logic to
attempt allocating a 2MB contiguous range by default and reduces the
allocations per deposit.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57864bb5bcd8c..0ebede0bc8b4f 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c

[ ... ]

> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contig=
uous)
> +{
> +	struct hv_deposit_memory *hc_input;
> +	int i, rc, num_pages;
> +	u64 status, *pfna, lastpfn =3D 0;
> +	bool trunc_extra =3D false;

[ ... ]

> +	if (lastpfn) {
> +		hc_input->gpa_page_list[0] =3D lastpfn;
> +		status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
> +					     hc_input, NULL);
> +
> +		if (!hv_result_success(status)) {
> +			if (contiguous)
> +				goto err_free_dep_pages;
> +
> +			/* We deposited lot earlier, so give it a go */
> +			__free_page(pfn_to_page(lastpfn));
> +		}
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
> +		__free_page(pfn_to_page(pfna[i]));

[Severity: High]
If hv_do_rep_hypercall() fails and returns U64_MAX, doesn't hv_repcomp(stat=
us)
evaluate to 4095?

Since 4095 is always greater than num_pages (which is capped at 511), this =
loop
condition would evaluate to false immediately, bypassing the cleanup and
causing an unconditional leak of the allocated pages.

[Severity: Critical]
If the first hypercall succeeds but the second hypercall fails while contig=
uous
is true, the code jumps to err_free_dep_pages.

At this point, num_pages is still from the first hypercall, but status is f=
rom
the failed second hypercall, so hv_repcomp(status) is likely 0. Does this m=
ean
the loop will iterate from 0 to 511, mistakenly returning pages to the buddy
allocator that the hypervisor successfully assumed ownership of during the
first hypercall?

Furthermore, because hc_input->gpa_page_list[0] was replaced with lastpfn j=
ust
before the second hypercall, the loop will free lastpfn at index 0.

Could the subsequent block:

> +	if (lastpfn)
> +		__free_page(pfn_to_page(lastpfn));

then free lastpfn a second time, resulting in a double-free?

> +
> +out_free:
> +	free_page((unsigned long)hc_input);
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908021340.2548=
924-1-mrathor@linux.microsoft.com?part=3D2
