Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32B48BD29
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284650; cv=none; b=K6xQSMY1B7JPQeLfibhWH3g/wdSODmjkMzpwZGCtGKmY1hX1XUqx0epAUK9T4r0ghT2Td1JgvKHH9tpECN0JnUAfjJYq50E8Cs036lTAtADndhV7OkAlDkwVWBhVkc8utfMioJhFLiONJyujwSTnqcmAZ4ZjDH2w7btjg9V2xSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284650; c=relaxed/simple;
	bh=s2ldmKXICXpZgS1yTDJvyBi2suZECNFFQCD7igq5fs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKR+QSa9MIYIOBYzIl+KPpv6DUc8CUtn3oZ+N4bdW0A8EjVTUNW4IEqnGXGHvU/YqA1DVixkqe0lNH2ZWaKJ07dK/7cEheMFrJRozgIj7Rz9r68DJyzoQlUBMLoNDPPbTQf4rB8q+jurkMyhR/zOG5warX6XJ/+zkl+JnFPGdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/qjpFPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/qjpFPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B271F00A3A;
	Tue,  1 Sep 2026 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284649;
	bh=zC/ANxHBD97QQrzvpxt5Ck6csJWqviG0/VwVahNwLzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/qjpFPfBK/9m+klQEAPnrBqcn7+ejVXt9UEEcMQaT+EsUDOzI6eP94ja3Ae+1BZd
	 C+HXFuTvL07Tqii1yDNRhA3omhoMynn04Dk75e6ksRyhJFMnXMcfWJvmyMyrSvmM+q
	 bb4x27MCHpqtZxE7BN7tCVbB39SGs6DiopjsiqpVKpzeRC/gqkYQQBzFDILO9qmxRe
	 Rw9JIa9eAf10IL5GT8t/J7+2SqFhTwyTWH1ceuhAEuU5Jjj3Vm3O5ZX3o+hHLTNYTn
	 h6J8tepFXrjw7vMKzyEH4TGB0IghShYA3ObjKAG3yR2jV3k189TDM6vAUmWrZlOMmo
	 fdtyQ3+1zO80g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/12] drivers: hv: hv_vsm_boot: Boot secondary
 processors in VTL1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-13-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-13-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:44:08 +0000
Message-Id: <20260901174408.E9B271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The boot CPU is incorrectly included in the `cpu_online_mask` pass=
ed to VTL1.
- [High] AP VTL1 boot failures are silently ignored, leaving the system in =
a partially-booted secure state.
- [High] Unsafe usage of `smp_processor_id()` in preemptible context and ta=
sk migration race.
- [Medium] Unprotected snapshot and iteration of `cpu_online_mask`.
--

commit 99445d1f4eda186e7be403a5b296f1c80a9cdae6
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: hv_vsm_boot: Boot secondary processors in VTL1

This commit adds support to boot secondary processors into VTL1 after the
primary CPU has transitioned. It passes an online CPU mask to VTL1 via a
shared page and uses a CPU-bound kthread to sequentially issue a vtlcall
for each AP.

> diff --git a/drivers/hv/hv_vsm_boot.c b/drivers/hv/hv_vsm_boot.c
> index c4f15c42df1f6..ad161b2f56653 100644
> --- a/drivers/hv/hv_vsm_boot.c
> +++ b/drivers/hv/hv_vsm_boot.c
[ ... ]
> +static int __init hv_vsm_boot_sec_vp_thread_fn(void *arg)
> +{
> +	struct hv_vsm_ap_boot_ctx *ctx =3D arg;
> +	struct hv_vtlcall_param args =3D {0};
> +	int cpu =3D smp_processor_id();
> +	u16 vp_enabled_vtl_set =3D 0;
> +	u8 active_mbec_enabled =3D 0;
> +	s64 sk_status;
> +	int ret =3D 0;
> +
> +	pr_info("cpu%d entering vtl1 boot thread\n", cpu);
> +	sk_status =3D hv_vsm_vtlcall(&args);
> +	if (sk_status)
> +		pr_warn("VP%d VTL1 boot returned status %lld\n", cpu, sk_status);
> +
> +	ret =3D hv_vsm_get_vp_status(&vp_enabled_vtl_set, &active_mbec_enabled);
> +	if (ret)
> +		goto out;
> +
> +	if (!active_mbec_enabled) {
> +		pr_err("Failed to enable MBEC for VP%d\n", cpu);
> +		hv_vsm_mbec_enabled =3D false;
> +	}
> +out:
> +	ctx->ret =3D ret;

[Severity: High]
If hv_vsm_vtlcall() fails and returns an error in sk_status, will this
error be silently ignored? The warning is printed, but ret remains 0 before
calling hv_vsm_get_vp_status(). If hv_vsm_get_vp_status() succeeds, ret
is unconditionally set to 0. Does this leave the caller believing the AP
booted successfully instead of surfacing the error?

> +	complete(&ctx->done);
> +	return 0;
> +}
[ ... ]
> +static int __init hv_vsm_boot_ap_vtl(void)
> +{
> +	struct hv_vtlcall_param args =3D {0};
> +	struct page *cpu_online_page;
> +	unsigned int cpu, cur_cpu =3D smp_processor_id();

[Severity: High]
Is it safe to use smp_processor_id() here in a preemptible context?
Fetching it here triggers a kernel BUG warning. Also, because the thread can
migrate between CPU evaluation and the sleepable operations like alloc_page=
()
and wait_for_completion() below, could cur_cpu become stale? This might
cause the AP loop to skip the new CPU and incorrectly attempt to boot the
original primary CPU as an AP.

> +	s64 sk_status;
> +	int ret;
> +
> +	cpu_online_page =3D hv_vsm_alloc_shared_page();
> +	if (IS_ERR(cpu_online_page))
> +		return PTR_ERR(cpu_online_page);
> +
> +	cpumask_copy(page_address(cpu_online_page), cpu_online_mask);

[Severity: Medium]
Should the snapshot of cpu_online_mask and subsequent iteration
be protected by cpus_read_lock()? Accessing this without hotplug
protection could allow concurrent CPU hotplug events to alter the
mask, potentially passing an inconsistent snapshot to VTL1 or binding
an AP boot kthread to a newly offlined CPU.

[Severity: High]
Does this verbatim copy of cpu_online_mask incorrectly include the
already-booted primary CPU in the mask passed to VTL1? If cur_cpu isn't
cleared from the mask first, could VTL1 mistakenly expect the primary CPU to
issue an AP boot vtlcall and hang or corrupt the primary CPU's secure
context?

> +
> +	/*
> +	 * Hand VTL1 the set of APs to expect. VTL1 copies the mask
> +	 * synchronously inside this vtlcall and does not reference the
> +	 * page after it returns, so freeing it here is safe.
> +	 */
> +	args.a0 =3D VSM_VTL_CALL_FUNC_ID_BOOT_APS;
> +	args.a1 =3D page_to_pfn(cpu_online_page);
> +	sk_status =3D hv_vsm_vtlcall(&args);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D12
