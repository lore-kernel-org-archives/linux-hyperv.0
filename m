Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91C46AA7C
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Aug 2026 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766742; cv=none; b=ev02AOYejzFfkSktMAV1TFsG8Dm8SqcrctGV1E2k1gMBBunOasCwcDqyQdVu8uRaRCenZS2792KXx1sw86nRUvpx5Ri4f/Wo1bbRJyak2W4TNYBKCvKG7B+p/qfkEDixx+zkIHxk/X7GBJfzVLWZxjvDnkZ4SfQj2nh1U8Eg8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766742; c=relaxed/simple;
	bh=n3SsaKpmJSbTSrF7G6dJssR9w8zIcmMwzSI+QOFQdAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n4iH8SzUZARan9xNI7MDRia4yOvKA0+WzlyiQmPcxUrVqt36oyIB4h0DhIIVZQ4WbXrI767nSfbq0oFB9K4hMUKAoJFPoB2LBDb4fIRRnLX47uEsxSl4HY19K4KRfyfDjdDcEsm0njIRrRAB1FGEEezz/of35HUtQx6/mhFmW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga8gEnaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga8gEnaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE01F00A3D;
	Wed, 26 Aug 2026 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766726;
	bh=28wEZLzJPp3f2XecNdtftYTURGIMDQaghKBhKJPg+PE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ga8gEnaQgZoBKMmsL2FiYtPkjytvjvjEUhToRYk/JbEv0sPTtnzbU0cDFDo1Rfo6f
	 m3dNYL+LCftPqR8SAG9+2+m3sBT9gAr4YetONPpqO3iEtzcQAhAHPP66ErHgQGPVvx
	 xHpWOEsGchRfGpLVCr8D7qRyIAZBVuvoZErCKc7qq01XlsRDKgf2DCYUvzp7guzBXo
	 ZUL6CKI5zkU5L8jM/+VDKEqnidmsHLIFRyNtYUmvdoGaOHQcTiwziTbPNkyk93nEYx
	 gKsZWJNFqQ1EU/ah92ERzr+6NGOFyZnCsru6VFd9KNVN+fU1YniZ8776V8iHiog7yZ
	 5IHDjnPDg9fRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260826173710.511604-1-longman@redhat.com>
References: <20260826173710.511604-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:52:05 +0000
Message-Id: <20260826175206.42EE01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch inadvertently leaves `check_hkcpu` as `false` for non-pe=
rformance VMbus channels, unintentionally disabling `HK_TYPE_MANAGED_IRQ` i=
solation checks and allowing their interrupts to be assigned to isolated CP=
Us.
- [High] The fix actively violates the user's CPU isolation configuration b=
y forcing interrupts onto isolated CPUs instead of simply skipping incompat=
ible NUMA nodes.
--

commit 36f8ef6b096e353e5114a6a9d0a4e19a5ab2e941
Author: Waiman Long <longman@redhat.com>

Drivers: hv: Avoid infinite retry loop in init_vp_index()

This commit addresses an infinite retry loop in init_vp_index() by allowing
the housekeeping cpumask to be ignored if the allocated cpumask has already
been cleared. It introduces a check_hkcpu flag in struct vmbus_channel to
control whether the housekeeping CPU check should be performed.

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kerne=
l.org [1]

> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index a044fd3b3c4e7..30d369ee4bf4a 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -774,6 +774,7 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  	}
> =20
>  	for (i =3D 1; i <=3D ncpu + 1; i++) {
> +		channel->check_hkcpu =3D true;

[Severity: High]
Since struct vmbus_channel is allocated with kzalloc(), check_hkcpu starts
as false. In init_vp_index(), non-performance channels return early before
this loop:

    if (!perf_chn || ...) {
        channel->target_cpu =3D VMBUS_CONNECT_CPU;
        return;
    }

Does this unintentionally leave check_hkcpu disabled permanently for
non-performance channels?

If CPU hotplug (hv_synic_cleanup() -> hv_pick_new_cpu()) or sysfs
target_cpu_store() later changes the CPU for a non-performance channel, it
appears vmbus_channel_set_cpu() will skip the housekeeping check because
check_hkcpu is false.

Could this allow non-performance VMbus channels to be assigned to isolated
CPUs, bypassing CPU isolation protections?

>  		while (true) {
>  			numa_node =3D next_numa_node_id++;
>  			if (numa_node =3D=3D nr_node_ids) {
> @@ -788,14 +789,21 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
> =20
>  retry:
>  		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node)=
);
> -		cpumask_and(available_mask, available_mask, hk_mask);
> +		if (channel->check_hkcpu)
> +			cpumask_and(available_mask, available_mask, hk_mask);
> =20
>  		if (cpumask_empty(available_mask)) {
>  			/*
>  			 * We have cycled through all the CPUs in the node;
> -			 * reset the allocated map.
> +			 * reset the allocated map. If the allocated map has
> +			 * already been cleared, we will have to ignore the
> +			 * HK_TYPE_MANAGED_IRQ housekeeping cpumask as its use
> +			 * is on a best effort basis, not a must.
>  			 */
> -			cpumask_clear(allocated_mask);
> +			if (!cpumask_empty(allocated_mask))
> +				cpumask_clear(allocated_mask);
> +			else
> +				channel->check_hkcpu =3D false;
>  			goto retry;
>  		}

[Severity: High]
Does this logic actively violate CPU isolation configurations by forcing
interrupts onto isolated CPUs?

When the allocator selects a NUMA node where all CPUs are isolated (none are
in hk_mask), clearing check_hkcpu forces the interrupt onto one of those
isolated CPUs.

Since cpumask_empty(hk_mask) is checked globally before the loop, there is
guaranteed to be at least one housekeeping CPU on some other node in the
system.

Would it be better to simply skip incompatible nodes entirely instead
of permanently overriding the housekeeping mask and forcing high-throughput
performance channels onto isolated CPUs?

[ ... ]

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5ebdbe24b5a1e..4cb9da8467f29 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1745,7 +1745,8 @@ int vmbus_channel_set_cpu(struct vmbus_channel *cha=
nnel, u32 target_cpu)
>  	if (target_cpu >=3D nr_cpumask_bits)
>  		return -EINVAL;
> =20
> -	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_=
IRQ)))
> +	if (channel->check_hkcpu &&
> +	    !cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_=
IRQ)))
>  		return -EINVAL;
> =20
>  	if (!cpu_online(target_cpu))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826173710.5116=
04-1-longman@redhat.com?part=3D1
