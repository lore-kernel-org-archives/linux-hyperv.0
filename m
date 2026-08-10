Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5503B2FF8
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367602; cv=none; b=iPzEUs8GYOzvjgISa9g/iRE0G1xaijUH2qanJV27mwOrFH79VOJ4tVwGvNR04WdsoVp+a0BCGY5pn2q54PoMLDfIbUwSTMz73h4mRBC99yHfJek26HxNysBSRKcYd/x4TaP1DzQ7aL6A5LsaCXZDkS48A9bAGdrzZHZQTrupBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367602; c=relaxed/simple;
	bh=JUxXgeqZ/xl8whvW03E90lDySHQFap/MNejOw2vVnmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=US0KASLg7vbXtucnQOS33juTxbHZXcB9kv2PHz94LYeI7P7oRFUE9YfdkFoeB1n9npB+fh0ifttdhC50QLjAeHlRKnJatFbQxO1uRDXydKgQZde+B6V/A+eldwqAMv4QK7cS+mE5zYyYDXsFTnpUgVKv27GsObrYmueWNKFa8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZsIugSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZsIugSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54A81F000E9;
	Mon, 10 Aug 2026 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367601;
	bh=yFwVyasore+L6w9fQXmSmslwAyu7k4zviBH2qO+9bec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZsIugSKBQ9B0ktcRpNKeOEgwZuWER+WQ816skuhk9/q/ZmfyHieFDPIo9xmTfXQh
	 MpgKV2YN7MtE+7T+hGRXNrAakcXm8Re+YnjbHYAMQiYoTYa11PYcnM8gMcOKtnf7Xo
	 szxiHyYwbV8VqNsi0Q8LVv7xcMka26i1HZ8/rCG0ZV7e8pIy9L6sAtJoF8LcB4BJka
	 SlN5/rEa6Ktuj4KhxuKwrZHjNjV95dTjJ7u05s0U76ut+GBRZ0wqngp3JMsV3qRVyI
	 SGqZdQOU7RCeRxsjABRZ+T2UsBSGD6B5CCjnaDdLkZHAkFKgK8zL61clioCBWVxT0a
	 uAnuPWXvhfMDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] mshv: unmap SNP memory before state teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-11-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-11-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:13:19 +0000
Message-Id: <20260810131320.E54A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The `destroy_work` delayed work is never explicitly canceled d=
uring module unload, leading to a potential use-after-free and kernel panic.
- [High] Retrying `destroy_partition` on failure causes partial unmap abort=
s, permanently leaving remaining chunks of a memory region mapped.
- [Low] Intentional early return in `mshv_region_destroy` permanently leaks=
 the `mshv_mem_region` kernel tracking struct.

Pre-existing issues:
- [High] Direct kfree(vp) without waiting for RCU grace period allows Use-A=
fter-Free in concurrent ISRs.
--

--- Patch [10]: [PATCH v2 10/13] mshv: unmap SNP memory before state teardo=
wn ---
commit fe90624ce2dba03d1ad11c9e5fd88e8f71d8c3d0
Author: Wei Liu <wei.liu@kernel.org>

mshv: unmap SNP memory before state teardown

Unmap memory regions before destroying SNP partition state, and only
release regions after SNP state is torn down. Dropping regions first
attempts to regain host access while the partition is still secure and
can leave pages inaccessible.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 6d65e5b421529..62c49b4d2a33e 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
[ ... ]
> @@ -337,7 +337,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_re=
gion *region,
>                                        page_count, flags);
>  }
> =20
> -static int mshv_region_unmap(struct mshv_mem_region *region)
> +int mshv_region_unmap(struct mshv_mem_region *region)
>  {
>         return mshv_region_process_range(region, 0,

[Severity: Low]
Does this error path leak the kernel tracking structure?

When tearing down an SNP encrypted partition and mshv_region_share()
fails, the function returns early to intentionally leave guest memory
pinned and prevent host crashes:

drivers/hv/mshv_regions.c:mshv_region_destroy() {
    ...
        if (ret) {
            pt_err(partition,
                   "Failed to regain access to memory... %d\n", ret);
            return;
        }
    }

    mshv_region_unmap(region);
    mshv_region_invalidate(region);
    vfree(region);
}

Since the mshv_mem_region structure is already removed from the partition
lists and its refcount is zero, could bypassing the vfree(region) call
result in permanently leaking the mreg_pages array and tracking structure?

[ ... ]
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index c32d3375af8c5..0dbf509351bb0 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2208,10 +2208,8 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
>                 if (mshv_partition_encrypted(partition)) {
>                         hlist_for_each_entry_safe(region, n,
>                                                   &partition->pt_mem_regi=
ons,
> -                                                 hnode) {
> -                               hlist_del(&region->hnode);
> -                               mshv_region_put(region);
> -                       }
> +                                                 hnode)
> +                               mshv_region_unmap(region);
> =20
>                         ret =3D destroy_snp_partition_state(partition);
>                         if (ret) {

[Severity: High]
Can this retry logic lead to a partial unmap regression when a memory region
is processed a second time?

If destroy_snp_partition_state() fails, the teardown is retried via
destroy_work:

drivers/hv/mshv_root_main.c:destroy_partition() {
    ...
    ret =3D destroy_snp_partition_state(partition);
    if (ret) {
        ...
        schedule_delayed_work(&partition->destroy_work, HZ);
        return;
    }
}

On the subsequent attempt, mshv_region_unmap() will iterate through the
region chunks again starting from offset 0. Since mreg_pages isn't
cleared during the initial successful unmap, the hypervisor will likely
return an error when attempting to unmap the first chunk again.

mshv_region_process_range() aborts processing immediately on error:

drivers/hv/mshv_regions.c:mshv_region_process_range() {
    ...
    ret =3D mshv_region_process_chunk(region, flags, page_offset, ...);
    if (ret < 0)
        return ret;
}

Will this completely bypass the unmapping of any remaining chunks that
were not reached in the previous pass?

[Severity: High]
Is it safe to schedule a delayed work task that lacks cancelation during mo=
dule
unload?

If destroy_snp_partition_state() fails, the teardown is retried via
delayed work. If the partition file descriptor is closed, the module
reference count drops to 0, which allows the administrator to unload the
mshv module.

Looking at the exit path:

drivers/hv/mshv_root_main.c:mshv_parent_partition_exit() {
    ...
    mshv_irqfd_wq_cleanup();
    root_scheduler_deinit();
    mshv_synic_exit();
}

Since mshv_parent_partition_exit() executes without calling
cancel_delayed_work_sync(&partition->destroy_work), can the timer fire
after the kernel module is unloaded and execute freed memory?

[Severity: High]
This is a pre-existing issue, but would this direct free cause a
use-after-free regression in concurrent interrupt service routines?

In destroy_partition(), vp structures are freed directly:

drivers/hv/mshv_root_main.c:destroy_partition() {
    ...
        kfree(vp);
        partition->pt_vp_array[i] =3D NULL;
    ...
}

Concurrently, the intercept ISR reads these pointers under an RCU lock:

drivers/hv/mshv_synic.c:mshv_intercept_isr() {
    ...
    vp =3D partition->pt_vp_array[vp_index];
    if (unlikely(!vp)) {
        ...
    }
    kick_vp(vp);
    ...
}

Since drain_all_vps() is skipped for non-root schedulers, intercept
messages can still arrive during partition teardown. If destroy_partition()
executes between the time mshv_intercept_isr() reads the vp pointer and
dereferences it in kick_vp(), could this result in accessing freed memory
because synchronize_rcu() or kfree_rcu() isn't used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D10
