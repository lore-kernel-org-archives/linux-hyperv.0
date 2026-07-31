Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995235C6A4;
	Fri, 31 Jul 2026 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538164; cv=none; b=lLg0HqDucwcT93bZQnvrnyzeDN31H3GsuLt+rTJm5oE1TMzKN5CgW5u8cRWDeFuvzvRs87at1zWjh9oqZWQp8ZLLtqxpvgpHeUni3menLVhRX2hahIQLvYlU4WJF7n7VUu3e3B/sMUEsXwtH4OQNY0b23G6vfTNQqP1WReex3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538164; c=relaxed/simple;
	bh=DA9NUU78wpJeepew4111wieBQzHEhGrN4l1eD+qagK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AWtrZryVKCCA1JVdDRv/0V7CJe1xuYNH2MqIDU2Qi0hJUmMRKHgrhNRgG6U0fTbtdIsm1yU6RoJ6h+du/EcJJnXKSO8ta/25tVXl6VtvlXN9wHK8PbzIdNszwkXzEoAjsiUqlz6dRMDRrPRB74yEJ/LYOmMwUyEw0G/LaTbbwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHdk/rRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHdk/rRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406A1F00ACA;
	Fri, 31 Jul 2026 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538163;
	bh=Vju/u0ZCaiX6xRL7VtZG+hfiP8BQiPbBQumjYfFjLrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NHdk/rRr1G6lKbLMVB9WDNJ7YMelNnq1xiGHNhJ0JiASuDzH/1QNlPN1eg+sp1MLQ
	 3cr/l4VbKICii3+5A8mXF2OGi60lrtexhbEho2Dh38FQg0IWpAKrDyNAm0HBiIvVHT
	 ytiQSTaBolY5Gvm3SPBeb2qaYL4iRBaDGGfd7tVaJ+xioz5tPuI8dYU5pVZWan3w9C
	 K/JEr9suUtw9Lw9rDmimvoL4Vy8A5ABMW3HHnvbV+L4Vl6MHCaEMhk3B1UfwByfx+H
	 ienxxh3DOw4/UEs9FgqUqSVzZq/zqltTfHv6zmruR7EXZ3HG1TF01TyFE4LWwJJIb2
	 7lkXl7cqkhaKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for
 VFIO to build upon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260731223427.2554388-4-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:49:23 +0000
Message-Id: <20260731224923.9406A1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `mshv_vfio` structure is allocated without `__GFP_ACCOUNT`, =
allowing a container to allocate kernel memory without being charged to its=
 memory cgroup limit.
--

--- Patch [3]: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for =
VFIO to build upon ---
commit c0b4902f22a48f131a914dbd4da4237e2be4826b
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Introduce basic mshv bridge device for VFIO to build upon

This commit adds a new file to implement a basic VFIO-MSHV bridge pseudo
device. It provides the foundation for VFIO integration in the MSHV
framework, adapting concepts from the KVM-VFIO bridge.

> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 0000000000000..92cfbaef0328d
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c

[ ... ]

> +static long mshv_vfio_create_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_device *tmp;
> +	struct mshv_vfio *mshv_vfio;
> +
> +	/* Only one VFIO "device" per VM */
> +	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
> +			     device_ptnode)
> +		if (tmp->device_ops =3D=3D &mshv_vfio_device_ops)
> +			return -EBUSY;
> +
> +	mshv_vfio =3D kzalloc_obj(*mshv_vfio);

[Severity: Medium]
Should this allocation include __GFP_ACCOUNT?

When a user space process creates a new MSHV VFIO device, it triggers
mshv_vfio_create_device(). The kzalloc_obj() macro defaults to GFP_KERNEL,
which omits the necessary accounting flags.

This allows a container to allocate kernel memory without being charged to
its memory cgroup limit.

> +	if (mshv_vfio =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&mshv_vfio->file_list);
> +	mutex_init(&mshv_vfio->lock);
> +
> +	mshvdev->device_private =3D mshv_vfio;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D3
