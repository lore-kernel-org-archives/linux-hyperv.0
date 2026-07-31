Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00B48987C;
	Fri, 31 Jul 2026 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538062; cv=none; b=SkMGW8+uaMAHoteLaDyB/EhjGuaxnvH9ATkiInvZ1AnksUm02irqVhEV1fMm5i/DBJ/mSSgkp5rjtESwE/4PdPJTn9dOEWJ7kDf7+xJWhrghCxBCOcbIfP13M3/P7QV9eRB3G7KWl2n7Qv3618LHjVzQar+pDRoYQTiUXwuo1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538062; c=relaxed/simple;
	bh=OqX/F+f1DvUd68lBiRnYuajzcGkQOmr8/9IxNT4DEns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=On/WJ5Dmo3RW0hPzCgWkqli1wSdnXTSAJSxD9TnGAOcRYpA+A5QV3vcZsgzQyS5BxrF9TeAY+tBYSZua1I826fbgqITIwTj1YsJ8Lq9aeuIaUb6pOE77vumo+bXdiqD9ZSdkRSTJZavTkymk2NZu9Xemk7eRT06ROhe8V9AMaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUyeEXKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUyeEXKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5ED1F00AC4;
	Fri, 31 Jul 2026 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538060;
	bh=pliBbd5r1RNo+WUukjv2yWkkfqqNiQ18DdugxKPYbxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUyeEXKoDwd6d0N+BeGxuUB7jwOnLPGTD7hHy9PAEevrToLJoTk8JZL66h8gmHonC
	 CUtD8/UVM0G097lf2JPb26aB5Enhj5FAoOeiC44ZjVE7ANnUx4qYC6VLWe2k5OxSGD
	 FBJ2zpQv/s/cQiva6XpUDIDJviGXDU7bUqC0mvUofIwf8b/xumtuN/k7nPMWVKyzD6
	 k8S5/b7KNAHfvgjX17TnOcK3VnzJ2vry7tPL7g48pNpX7tNjzX37t25oAba3PtJZAf
	 9encnYRF9LRpvZ2ImgIDl8xRl+qDD4EhuaNHVsXMInLOZy3FX6BhMtSabByTQcZOTS
	 wonRLxPdbnQRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] mshv: Provide a way to get partition ID if
 running in a VMM process
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-2-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:47:39 +0000
Message-Id: <20260731224740.5A5ED1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using `current->tgid` for implicit VM partition binding restricts =
multi-process architectures, introduces PID reuse vulnerabilities (Privileg=
e Escalation and DoS), and causes spurious creation failures.

Pre-existing issues:
- [Critical] Unchecked virtual processor (VP) access in `mshv_try_assert_ir=
q_fast` can lead to a kernel panic.
--

--- Patch [1]: [PATCH v5 1/9] mshv: Provide a way to get partition ID if ru=
nning in a VMM process ---
commit c09a2034eaac3e66996c48aebdd226e834f0611e
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Provide a way to get partition ID if running in a VMM process

This commit adds a field to the MSHV partition structure to save the
tgid of the VMM process that created it. It also introduces a helper to
retrieve the partition ID by matching the current tgid and restricts
creation to one partition per VMM instance.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> +u64 mshv_current_partid(void)
> +{
> +	struct mshv_partition *pt;
> +	int i;
> +	u64 ret_ptid =3D HV_PARTITION_ID_INVALID;
> +
> +	rcu_read_lock();
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
> +		if (pt->pt_vmm_tgid =3D=3D current->tgid) {
> +			ret_ptid =3D pt->pt_id;
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +	return ret_ptid;
> +}
> +EXPORT_SYMBOL_GPL(mshv_current_partid);
> +
> +/* At present, we only allow one partition per VMM instance */
>  static int
>  add_partition(struct mshv_partition *partition)
>  {
> +	int rc =3D 0;
> +
>  	spin_lock(&mshv_root.pt_ht_lock);
> =20
> +	if (mshv_current_partid() !=3D HV_PARTITION_ID_INVALID) {
> +		rc =3D -EEXIST;
> +		goto out;
> +	}
> +
> +	partition->pt_vmm_tgid =3D current->tgid;

[Severity: High]
Does using current->tgid for implicit VM partition binding introduce risks
with process lifecycle and PID reuse?

If a VMM process creates a partition, passes the file descriptor to another
process (e.g., via a UNIX socket) and exits, the original tgid could be
recycled for a new, unrelated process.

If that new process performs operations that invoke mshv_current_partid(),
could it incorrectly inherit the partition context of the previous process?

Alternatively, if the new process attempts to create its own partition in
add_partition(), would it incorrectly fail with -EEXIST?

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential unchecked access
during the review of this subsystem.

In drivers/hv/mshv_eventfd.c:mshv_try_assert_irq_fast():

    vp =3D partition->pt_vp_array[irq->lapic_apic_id];

    if (!vp->vp_register_page) {
        ...

If userspace sets up an irqfd routing entry with an APIC ID that has no
corresponding virtual processor created yet, will vp be NULL when fetched
from pt_vp_array?

If so, would the immediate dereference of vp->vp_register_page result in a
host kernel panic when the eventfd is signaled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D1
