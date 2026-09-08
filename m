Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C2534468
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870599; cv=none; b=M8R6L6U3N3YCV+tVqIGWq4aqOv92///rgD167Hi8hgxgvaFUpb9av+Pz7ieKOvsCpSmrn/Ko2VwK55aj3NTEc7rhLCuYLmEsbUafHbivtAAfmW+JJg6/GyDVZrddFbMPi5or3jDEwjKZjNAAdrZ1f3Vf5pFSXTWKfCpZ04esnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870599; c=relaxed/simple;
	bh=EWBiDPyO1GQVlouFtAnuKFyl4H7X5ZRAGaDXEnQkffI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VC0JSTe92MUToYWPdr7IrQSIuEr6aM32lBkBui1oYFqwDlbV6GEKUkyxJgjcBdqH9fRXvhBeRGANiHuiJpKS7QowFrV2b0j0SqLitNVc9/Cn1eULvJoH8p0zg/bJ0+lftwUbghWa0kQ0BfYTxSo3oEHf04P+wg6EMthlPI+Lqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZVHSJF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZVHSJF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034721F00A3A;
	Tue,  8 Sep 2026 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870598;
	bh=VCsT04OrOMMjyC+WaFdXu3Yu+dWOOIHCPU/S2hs5ozI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZVHSJF11Hu5MMcYBgd+XqAuWEluZDRcZT0jnvTnSAcnNROdO8IfGDVOpb0Io8tnb
	 aqXvr22COWP1IcNdX14Z2B5e0+B27FN7JDaqx46Vu/YUMTcAnN0mnMRm4eFKJyf8q8
	 kcVpYzJTmnPoHznXCzmCkkzv5Yme3hmnxu06iz8cpZHLt1rD1jzvbnp3gOyruZOTX4
	 o0Jbl2z7NTl9OdiECdX2Lo2Gkyo57EHr73Y8HLxA3rNUq5vSYJb8JcyC9G4nK6XSnd
	 Bp9nryfwtvDFoJ4YcfTGkW3HkRujL/SWmr24qcUKLCimVntvNsSHcVWrRqe37PJLsn
	 WvsSEUJpanM/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260908121403.1160280-7-weh@linux.microsoft.com>
References: <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260908121403.1160280-1-weh@linux.microsoft.com>
 <20260908121403.1160280-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:29:57 +0000
Message-Id: <20260908122958.034721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing host access restoration on successful PSP guest request pe=
rmanently revokes host permissions.
- [High] Unbounded user-controlled array allocations and non-preemptible lo=
ops cause CPU soft lockups.
--

commit ff3cccc86d268ae551d99e559a8b63d138066868
Author: Wei Liu <wei.liu@kernel.org>
Subject: mshv: wire SEV-SNP partition ioctls

This commit wires the SEV-SNP UAPI into partition creation, memory ownershi=
p,
and isolated-page import. It adds tracking for host access permissions and
handles transitions to release/acquire host access.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -643,6 +643,68 @@ mshv_partition_region_by_gfn_get(struct mshv_partiti=
on *p, u64 gfn)
>  	return region;
>  }
> =20
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +static int
> +mshv_gpfns_to_host_pages(struct mshv_partition *partition, const u64 *gp=
fns,
> +			 u64 page_count,
> +			 struct mshv_host_access_page *host_pages)
> +{
> +	struct mshv_mem_region *region;
> +	u64 i;
> +	int ret =3D 0;
> +
> +	for (i =3D 0; i < page_count; i++) {
> +		u64 offset;
> +
> +		region =3D mshv_partition_region_by_gfn_get(partition, gpfns[i]);

[Severity: High]
Does this code allow an unbounded, user-controlled loop without yielding?

If a user provides an extremely large args.page_count in=20
mshv_partition_ioctl_modify_gpa_host_access(), this loop will repeatedly=20
acquire and release region mutexes for the entire array. Without a=20
cond_resched(), this could cause a CPU soft lockup.

[ ... ]
> +bool mshv_u64_array_has_duplicates(u64 *values, u64 count)
> +{
> +	u64 i;
> +
> +	sort(values, count, sizeof(*values), mshv_u64_cmp, NULL);

[Severity: High]
Can this sort() call cause a CPU soft lockup?

Since count originates from the user-controlled args.page_count without=20
an upper bound, sort() (which is non-preemptible) might block the CPU=20
for an O(N log N) duration on a massive array.

> +	for (i =3D 1; i < count; i++)
> +		if (values[i - 1] =3D=3D values[i])
> +			return true;
> +	return false;
> +}
[ ... ]
> +static long
> +mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
[ ... ]
> +	guest_gpas =3D u64_to_user_ptr(args.guest_gpas);
> +	gpfns =3D vmemdup_array_user(guest_gpas, args.page_count,
> +				   sizeof(*gpfns));
> +	if (IS_ERR(gpfns)) {
> +		ret =3D PTR_ERR(gpfns);
> +		gpfns =3D NULL;
> +		goto out;
> +	}
> +	host_pages =3D kvmalloc_array(args.page_count, sizeof(*host_pages),
> +				    GFP_KERNEL);
> +	duplicates =3D kvmalloc_array(args.page_count, sizeof(*duplicates),
> +				    GFP_KERNEL);

[Severity: High]
Are these allocations sufficiently bounded to prevent kernel memory exhaust=
ion?

Since args.page_count is controlled by userspace, allocating multiple array=
s=20
that scale with this count could lead to severe memory pressure or a denial=
 of=20
service.

[ ... ]
> +static long
> +mshv_partition_ioctl_issue_psp_guest_request(struct mshv_partition *part=
ition,
> +					     void __user *user_args)
> +{
[ ... ]
> +	ret =3D hv_call_issue_psp_guest_request(partition->pt_id, gpfns[0],
> +					      gpfns[1],
> +					      mshv_async_hvcall_handler,
> +					      partition);
> +	if (!ret)
> +		goto out_put_pages;
> +
> +restore_host_access:

[Severity: High]
Does a successful hypercall skip host access restoration?

If hv_call_issue_psp_guest_request() succeeds and ret is 0, the code=20
jumps to out_put_pages, bypassing the restore_host_access block.=20
This leaves the host permissions permanently revoked for the request and=20
response pages, which could break functionality or leak memory.

> +	{
> +		int restore_ret;
> +
> +		restore_ret =3D mshv_restore_psp_pages(partition, host_pages,
> +						     original, transitioned,
> +						     transitioned_count);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908121403.1160=
280-1-weh@linux.microsoft.com?part=3D6
