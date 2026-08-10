Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E63B47E9
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366710; cv=none; b=KnL6E33SZ1ebRsD8j2DjeHtIwYbcV9KssI9fngaTnCMYXMwh6r0yaCeou/KxIuPsgH90eJcj099T+ZfVPj9qQUCuNX57xYMFemiaIAS8VjROgC1p2101GJrIFwGDmtNlHVMiNHxLT5/tjFcW4FA5DBtGjrEXv5PX3z5AlOmgWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366710; c=relaxed/simple;
	bh=n582HbLmn9P/cXqQoC6jgrG0l2k/rPltd8/AgvVOguQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFaFdzI7PgsR14xza4vrkiireh1sb5+YopFeO2g5/qSyG+MHzzfb3kn/5pwQU5Bwk3XBzmodGRU5/i1BZZWHF/Jb3gcblZb1JPZYtwW27G7tlsNTORtEqXtYeiID53Ps62sOc0bJTaJgq6nOHjdg7BgWM5AAObBxd+mgrtChtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmJJnt5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmJJnt5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFE61F000E9;
	Mon, 10 Aug 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366709;
	bh=9qGy9Llnv6Og4yW3nn3d9rTP4n6R4wqD7/Z7Ij3uicQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmJJnt5vg60A3bbq4tCJqxGxKcntTEVmDmjQBiic4KELNwSMim59eDfYtDh0pXSrt
	 jD7NHPGoU3fOMcUeshYXhzqtxju8NouXl5GuvCf26pMyHx55sxKlY12djEgM99kJoM
	 XfupggUjy9yZ+1L8X+twQuPoc2trStHV68UJFzHE+6dKUFxG5VYNM29t+Jrk7mOJ5k
	 OW/HPfVlcoHI7H3jQzs6Qh49qQVyEbj4UXD3BnkLWa3+SYRXYgXsOgq9PzwYF7kZLN
	 pgcEmYfqm+PT2YHMLPUESe0S2oXJYv7ahlZLb1I57d/NA1HwebJJBw3lmcXstnbp3z
	 //TDcDUAsjBlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] mshv: add SEV-SNP isolated page hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-4-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-4-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:58:29 +0000
Message-Id: <20260810125829.9BFE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The error log in `hv_call_import_isolated_pages` under-reports the =
number of successfully imported pages if an error occurs mid-batch.
--

--- Patch [3]: [PATCH v2 03/13] mshv: add SEV-SNP isolated page hypercalls =
---
commit 6412d57ab824c1079e692800b1ba551aa8b078c8
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP isolated page hypercalls
   =20
This commit adds hypercall helpers for importing isolated pages and
completing isolated imports to transfer state to the hypervisor. These
are used by SEV-SNP guest launch flows.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 48abe338c06f8..4e48c1a9a6308 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
[ ... ]
> @@ -1010,6 +1014,104 @@ int hv_unmap_stats_page(enum hv_stats_object_type=
 type,
>  }
> =20
>  #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
> +				  u64 num_pages,
> +				  enum hv_isolated_page_type page_type,
> +				  enum hv_isolated_page_size page_size,
> +				  void (*completion_handler)(void *data,
> +							     u64 *status),
> +				  void *completion_data)
> +{
[ ... ]
> +		completed =3D hv_repcomp(status);
> +		if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING) {
> +			completion_handler(completion_data, &status);
> +			if (hv_repcomp(status))
> +				completed =3D hv_repcomp(status);
> +		}
> +
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: completed %llu of %llu, %s\n", __func__,
> +			       num_pages - remaining, num_pages,
> +			       hv_result_to_string(status));

[Severity: Low]
Does this error message under-report the number of completed pages?

If a rep hypercall fails after completing some iterations mid-batch, the
iterations completed in the current batch are stored in the completed
variable via hv_repcomp(status).

Because remaining is only decremented at the end of the loop, calculating
num_pages - remaining here appears to omit the pages successfully completed
in the current failing batch.

> +			return hv_result_to_errno(status);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D3
