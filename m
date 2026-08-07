Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204937266E
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112501; cv=none; b=hYGkzrjG0RLhFXjGUedgG2/d4BVLgpIsrQb7uXpSNBcOeeinwnNfCJR2j4papLb+Cc6fTRODei6fEWmq4+jaIcV7xMrA697qVTTiy6jH3i7Zu6VbsxyYNHERddqHPjZwt2kZKUwDadf5EWbMLZKjctUp841QysynA6H5bpYNL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112501; c=relaxed/simple;
	bh=rdkI4rXdKU7JttJEmaLBoQtGohol2Yl9rmZPeGpxYKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HyeDqfBS4upyci9Ih+PM/0VHmqfTLrukZSQ+CF0zZcjSjG6elxiC0JTTApgsjtUvDFHZ6kc8ADXuaVhd6VKkn4EHhRmSxeaRrhT/4/jImRacYq8bf5vrnYZ7cwNl+I1jxnd3g08d5wylRf3sW9Ila9yYWsU0Vg7GNl9korQOcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKTDGQdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKTDGQdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F531F000E9;
	Fri,  7 Aug 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112499;
	bh=9Lcoln2HEQvkll+o1al5gKpbv1ZPY4ZTqLW8JTlNeKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKTDGQdWSfuKenwjENnzjQOdhabRAmW5rRVwkJmb52iR+jkJ0Lyb0IgzTfw43Dcjc
	 9/LNYKaSkPH/AjUN1+rI0szz9/AeE0BuozyIyYBMHtHtVqkeP7WchwS2AHthcC3acw
	 swFlQtyW2+FMR6ikLuycd0h1FnKy32ieVNibWyDjZC42zm05akxGhZQAFTKGvH6BB3
	 w3VTGKRGubGjlpP/M21B86sEXDXRkCcY1YxJWzG9q2TLiiDF9V9mIYI6bDo/faAkwb
	 ZTt1mZBnIo6eEkB3kgPwfSpj8NTQZo+onPlRlNlNHrxdmjVmtnnN4FKjitz4d/wx8N
	 3r+MgMynV4Dcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/13] mshv: add SEV-SNP isolated page hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-4-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-4-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:21:38 +0000
Message-Id: <20260807142139.69F531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `completed` variable is evaluated from `status` before the asy=
nchronous completion handler updates it, leading to a stale completion coun=
t and an infinite loop.
--

--- Patch [3]: [PATCH v1 03/13] mshv: add SEV-SNP isolated page hypercalls =
---
commit 3c19c21fc983589586a3386b97c714ce13aec72c
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP isolated page hypercalls

Add helpers for importing isolated pages and completing isolated
imports.  These are used by SEV-SNP guest launch flows to transfer
isolated page state to the hypervisor.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 48abe338c06f8..9ddc8dd73da7a 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
[ ... ]
> @@ -1010,6 +1014,99 @@ int hv_unmap_stats_page(enum hv_stats_object_type =
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
> +	while (remaining) {
> +		rep_count =3D min_t(unsigned long, remaining,
> +				  HV_ISOLATED_PAGE_BATCH_SIZE);
> +
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +		input->partition_id =3D partition_id;
> +		input->page_type =3D page_type;
> +		input->page_size =3D page_size;
> +		memcpy(input->page_number, gpa, rep_count * sizeof(*gpa));
> +		status =3D hv_do_rep_hypercall(HVCALL_IMPORT_ISOLATED_PAGES,
> +					     rep_count, 0, input, NULL);
> +		local_irq_restore(flags);
> +
> +		completed =3D hv_repcomp(status);
> +		if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING)
> +			completion_handler(completion_data, &status);

[Severity: High]
If the hypercall returns HV_STATUS_CALL_PENDING, the completion_handler upd=
ates
the status variable, but the completed variable was already evaluated from =
the
initial status.

Could this lead to completed being 0 (or a stale value), which would then
prevent gpa and remaining from advancing correctly?

> +
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: completed %llu of %llu, %s\n", __func__,
> +			       num_pages - remaining, num_pages,
> +			       hv_result_to_string(status));
> +			return hv_result_to_errno(status);
> +		}
> +
> +		gpa +=3D completed;
> +		remaining -=3D completed;

[Severity: High]
If completed is not updated after the completion handler executes, does this
result in an infinite loop since remaining will not decrease?

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D3
