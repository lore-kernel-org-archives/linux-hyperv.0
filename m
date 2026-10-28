Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163449;
	b=FnfDbyx9hfWtmxE1VcL+DZ0JRr+GJsL8yuZhyHpZFS/u+sdl3I7gQDkOC/ROKVlDQsxn
	 8594Kc7lC3gyABV6Z1FsrKTe0vbpof2YZ9exXqFMegG6EF636dg7K3hTGqGWzJ/bw+udq
	 IuD8ICNDSFvERMouJ42AkAbYLXEYXq1D+VKT8OXv6qRa+ZJ9K9nY38TEks/E4yN8igxE7
	 lBSy1so7x1vSpRa1RqNwGTMxrudYppqoie+DGTTBjJMtWv4+NFKDwryGDq7+VmoNC+C3i
	 /oc4KIuGBWmdwFx8BC6QdgArILUEHQQmGfKU0YwySSUw/JLwJVXQdK4pvErVogE667A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/uaTlwkWh7QBrF1ZrgywNg7sl0YTXSfsaGEGo87T7Vg=;
	b=sz9bs4JbYAA6XEJ0r6w35fu4w36/xhf2bg5p0/3MpeW5nMiH9m4fOR63Fgxs0t0sWvC5
	 HdlZ7gH+JWYHG6Jlr2dLJPlmP1j9eugQSMby49A/qK5rNBs8edRPAKggK7ZvG/52HKEzH
	 qpxA4DaTdZblAZh2r24ADFzXXoybNJH1XeHj7DgVAKVTf90Wy3VzsyxC6ZqoQXMBDgYCU
	 3GsKY6Ls6QvLnCcpApVf42OoB459aCI+9N0Hci+t2jVtUDAnB7mNH0PGe4gpw5WSZQOvV
	 QHQ6t5BbXngmmzj9BObHrPgEbpT4ttsfxMl1FbZvMpqeGODa5d4jvby9Ncg5xaP6PDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6Ly8Fmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79008606A31A
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6Ly8Fmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A71F01825;
	Wed, 28 Oct 2026 04:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163449;
	bh=/uaTlwkWh7QBrF1ZrgywNg7sl0YTXSfsaGEGo87T7Vg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N6Ly8FmxX4aBgc8BatMlavW3F31LrHpH2WXgEc/mcQqxBNH+96Ic+GRtphVKIxz95
	 nZZWx/v4xbfwGsliY7hPvcPQF8K5cih1AP6Uagnsod61Ix92ToTdqHg3a5UVDAvkhi
	 ACJsw9xlRObGAPIqtwpbGJx0AVzVHaUi/a1fdRGHFkeYJUUsCHAR+KbNDOdTz1YNvw
	 guK034NDtI1luCzNSv5pA6PYaxWREPkh4I4XKx6xc2JhYfBi1cEoksHQL+QhduKqOO
	 1bB838n0jda69FyUuRJGQsh4N8rEJAnPfWfZDYrQcbHI/4QIEhhtlPSN3QZ/ibB81n
	 8GAplrPTesaSQ==
Message-ID: <sashiko-outbox-187498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] Drivers: hv: initialize partition table before
 device registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261028044828.96177-4-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-4-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:57:28 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv: mshv: premature misc_register() in mshv_parent_partition_init()
--

commit c189d106f4a7c8456e535fcfffc6e71d86c62b6d
Author: Jiale Yao <yaojiale02@163.com>

Drivers: hv: initialize partition table before device registration

This commit moves the initialization of mshv_root.pt_ht_lock and
mshv_root.pt_htable ahead of misc_register(&mshv_dev) in
mshv_parent_partition_init() so that concurrent partition ioctls do not
access an uninitialized spinlock or hash table.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..ce26320035b6f 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2369,6 +2369,9 @@ static int __init mshv_parent_partition_init(void)
>  	if (hv_get_hypervisor_version(&version_info))
>  		return -ENODEV;
> =20
> +	spin_lock_init(&mshv_root.pt_ht_lock);
> +	hash_init(mshv_root.pt_htable);
> +
>  	ret =3D misc_register(&mshv_dev);
>  	if (ret)
>  		return ret;
> @@ -2407,9 +2410,6 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto exit_debugfs;
> =20
> -	spin_lock_init(&mshv_root.pt_ht_lock);
> -	hash_init(mshv_root.pt_htable);
> -
>  	hv_setup_mshv_handler(mshv_isr);
> =20
>  	return 0;

[Severity: High]
Does moving only pt_ht_lock and pt_htable initialization ahead of
misc_register(&mshv_dev) leave /dev/mshv exposed while the rest of the
subsystem is still uninitialized?

In drivers/hv/mshv_root_main.c:mshv_parent_partition_init(),
misc_register(&mshv_dev) is still called before mshv_synic_init(),
mshv_init_vmm_caps(), mshv_retrieve_scheduler_type(), root_scheduler_init(),
mshv_debugfs_init(), mshv_irqfd_wq_init(), and hv_setup_mshv_handler().

If userspace opens /dev/mshv and issues MSHV_CREATE_PARTITION via
mshv_dev_ioctl() -> mshv_ioctl_create_partition() during this window,
partition creation now succeeds, which can trigger several issues before
mshv_parent_partition_init() finishes:

1. If the partition fd is closed before mshv_irqfd_wq_init() runs,
mshv_partition_release() -> mshv_eventfd_release() -> mshv_irqfd_release() =
in
drivers/hv/mshv_eventfd.c calls:

	flush_workqueue(irqfd_cleanup_wq);

while irqfd_cleanup_wq is still NULL.

2. If MSHV_INITIALIZE_PARTITION or MSHV_CREATE_VP runs before
mshv_debugfs_init() sets mshv_debugfs, mshv_debugfs_partition_create() and
mshv_debugfs_vp_create() return early and leave partition->pt_stats_dentry
and vp->vp_stats_dentry as NULL. When the partition is later destroyed after
mshv_debugfs_init() completes, destroy_partition() calls
mshv_debugfs_partition_remove() in drivers/hv/mshv_debugfs.c:

	if (!mshv_debugfs)
		return;

	partition_debugfs_remove(partition->pt_id,
				 partition->pt_stats_dentry);

which dereferences the NULL dentry pointer.

3. If MSHV_RUN_VP runs after mshv_retrieve_scheduler_type() sets
hv_scheduler_type to HV_SCHEDULER_TYPE_ROOT, but before root_scheduler_init=
()
allocates the per-CPU buffers, mshv_vp_dispatch() in
drivers/hv/mshv_root_main.c dereferences NULL per-CPU pointers:

	preempt_disable();
	input =3D *this_cpu_ptr(root_scheduler_input);
	output =3D *this_cpu_ptr(root_scheduler_output);

	memset(input, 0, sizeof(*input));

4. In mshv_ioctl_create_partition(), the partition file descriptor is creat=
ed
with anon_inode_getfile("mshv_partition", &mshv_partition_fops, partition,
O_RDWR), which does not take a module reference. If a subsequent init step =
in
mshv_parent_partition_init() fails and triggers misc_deregister(&mshv_dev),
module initialization fails while the hypervisor partition remains allocated
and userspace retains an open file descriptor referencing unloaded module
fops.

Could misc_register(&mshv_dev) instead be moved to the end of
mshv_parent_partition_init() (or after all subsystem state is initialized,
passing NULL or a dedicated device pointer to the early init helpers)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028044828.9617=
7-2-yaojiale02@163.com?part=3D3
