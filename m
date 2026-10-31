Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406464;
	b=XqMqyev5R3V4yKoPaUi01C8KXBJtZO4JBJ+EaFHy4JDHARgsDxuS56U+LL2oqls1jXd0
	 YTh/9e55HJYhp2NGAm2SCQeRCmFXkm0/Yx3MoOGcm6NKJtQLQCqGm5wQgxkK9mApAUGFL
	 Wyu3QaXAOrSYIAb9Yk3dhLOIQL22ZVQSl6VE/Lwq75HawoPfXqK/KVWJb2J6k1axOSJps
	 jTBESVWACqJz/Cc+YYPauo2ySM+iSZLD8miozebVSaNjpiiciRjpje3Z8K3WNDQxtDJ/g
	 5Ei7y+OZlk5bStng3CmqdZZQVdyzuW5Nb7RdRWbcIkb08PhITQ0As57NoNq+lCDZ6XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406464;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cv+JWitwttEO03ALofpCJiDyXTLOG25yqR/oF++s0HE=;
	b=h5/zAylYja09bjbKiGYSLpbk6LIdoAcr9wIYDk2zTkWQyPL5TgGwckGdRe6b5mm7HmyN
	 0PBhH4DvpCw4h1j8P6jyuvMzn8jWVag/eE7TRTD6k5wYlzLS7dPHMGT9TgJugHXtoMyxO
	 hz7McVa5zT8P2RDo17Qh9+/m5ZID0CifbvzPosvk0llsf5PmTY4/Tvwu+cm/rDEVS0hbi
	 dFhtTM2n7xIBkVBEKxmh3eM/RIjwrWjK77JEvLoeB9A5JU3BRUUjyQpxYTwjXcRQ7pe+Y
	 PvHAq4c3pJMKMLl1NYgwp9wFcxqcUh2B/Q7Jiushdgef9jEVtCXqxNPV+oNdtrDG0JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INmROvAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C6606A31A
	for <linux-hyperv@vger.kernel.org>; Sat, 31 Oct 2026 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INmROvAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD51F000C1;
	Sat, 31 Oct 2026 00:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793406463;
	bh=cv+JWitwttEO03ALofpCJiDyXTLOG25yqR/oF++s0HE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INmROvAI18rqjBvAZvfk9iz9sdygyIVYWuIjXv8hEQo/XVU8MmGfBkNeFTxU+3les
	 j5GgZiaztN3VsTSfmoAZYq0DJqYMdKWiQA7b+dGrbYT4OY9j3zeGRpnauCoFwQuIx+
	 mmdI6yX8+2YXIsJmxqzhiGEPXGm+CNO3hvaVAsdM09m48R5mxMSWuZqm5JpOzYMGI2
	 k4DWdSogEyeJOZNQo2yNzbYCHghOx9a257NfXPzqBJg6RR11CehT3sw7350JYWaWpf
	 qhzyZC/r3fPvSgGI/QrCiEWYXcaJ0k8tPnuzq/xDCrOTzaztswBhpT5hJOAFTeRIZ+
	 l6fdjGobGpI8A==
Message-ID: <sashiko-outbox-191675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:27:43 +0000
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
- [High] hv: arm64: set_memory_decrypted() in hv_common_cpu_init() hits BBM=
L3 -EBUSY
--

commit 8d15e623ca43bf983a70fccbb187c60423dd18ef
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

Drivers: hv: Mark shared memory as decrypted for CCA Realms

This commit introduces hv_isolation_type_cca() and extends
hv_common_cpu_init() to mark the per-CPU hypercall input and output pages as
decrypted on Arm CCA Realm guests. It also aligns the hypercall buffer
allocation size to PAGE_SIZE when calling set_memory_decrypted().

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 31256cb22b39e..a60c92cd83eac 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> +	const size_t alloc_size =3D ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, P=
AGE_SIZE);
>  	void *mem;
>  	int ret =3D 0;
> =20
> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
> +		mem =3D kmalloc(alloc_size, flags);
>  		if (!mem)
>  			return -ENOMEM;
> =20
> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
> =20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {
> +			ret =3D set_memory_decrypted((unsigned long)mem,
> +						   alloc_size >> PAGE_SHIFT);
>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */\
>  				return ret;
>  			}

[Severity: High]
Can calling set_memory_decrypted() from hv_common_cpu_init() fail with -EBU=
SY
and prevent secondary CPUs from coming online on BBML3-capable arm64 system=
s?

On arm64, when the boot CPU supports BBML3 and debug_pagealloc is disabled,
paging_init() -> map_mem() sets linear_map_requires_bbml3 =3D true and maps=
 the
linear region with block/contiguous descriptors because is_realm_world()
makes can_set_direct_map() return true.

In arch/arm64/hyperv/mshyperv.c, hyperv_init() runs as an early_initcall()
during do_pre_smp_initcalls() and registers hv_common_cpu_init() for
CPUHP_AP_HYPERV_ONLINE:

	ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:onlin=
e",
				hv_common_cpu_init, hv_common_cpu_die);

Next, smp_init() calls bringup_nonboot_cpus() before smp_cpus_done() ->
setup_system_features() -> setup_system_capabilities() finalizes the
ARM64_HAS_BBML3 capability. During bringup_nonboot_cpus(), each secondary C=
PU
is marked online in secondary_start_kernel() (making num_online_cpus() > 1)
and then executes CPUHP_AP_HYPERV_ONLINE -> hv_common_cpu_init() while
system_supports_bbml3() and system_capabilities_finalized() are still false.

That leads to the following call chain on the secondary CPU:

  hv_common_cpu_init()
    set_memory_decrypted()
      realm_set_memory_decrypted()
        __set_memory_enc_dec()
          __change_memory_common()
            update_range_prot()
              split_kernel_leaf_mapping()

In arch/arm64/mm/mmu.c:split_kernel_leaf_mapping(), splitting the linear map
in this window triggers a warning and returns -EBUSY:

	if (!linear_map_requires_bbml3 || is_kfence_address((void *)start))
		return 0;

	if (!system_supports_bbml3()) {
		if (system_capabilities_finalized())
			return 0;

		if (WARN_ON(!page_alloc_available))
			return -EBUSY;

		/*
		 * Boot-time: Started secondary cpus but don't know if they
		 * support BBML3 yet. Can't allow splitting in this window
		 * in case they don't.
		 */
		if (WARN_ON(num_online_cpus() > 1))
			return -EBUSY;
	}

When split_kernel_leaf_mapping() returns -EBUSY, hv_common_cpu_init() leaks
the mem buffer and returns -EBUSY from the CPUHP_AP_HYPERV_ONLINE callback,
aborting secondary CPU bringup.

Should the per-CPU hypercall buffers for possible CPUs be allocated and
decrypted earlier on the boot CPU (for example in hv_common_init() while
num_online_cpus() =3D=3D 1), or after system capabilities have been finaliz=
ed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031001412.4150=
488-1-kameroncarr@linux.microsoft.com?part=3D4
