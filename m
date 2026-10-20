Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521927;
	b=w1nVr8CGI0zS6legsHs1drl1kSDbmlZg7dVzn9AmwFpo7Pz8CSVvqMUkeZsebFVxYUH5
	 GV+Lik+xSD3vZwVGKQpLn256SQCSeEbHNCCVYEJCvMSECf0YGIpyF/0nR9AQLx1wcO82e
	 sziTwGiNAoBG0A6BFZFEcq+5iz7zDfFCpfr88h3X9ucDJA8DVgGWfUivuKWdUqFP+TwLq
	 iAB7ZQp15Z5DAK4271e2gbv4le3QeOltSo81Hw/UShu6MJSFTXIZV0krIElhqdPeY4u+w
	 D8+p4LTPUbzXEL/Nem5TmO453AhuiodogLt3H2rBGCArDHO6Y3fgtDEjm09F1ONuQJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ykXZkGntS8u8RrEn/iLcc+w49SUGVewQTVjWJ9WDz/M=;
	b=c2B84bclEFEyKs0IbsHUwVpcaDL4kEdfkW/SKORmM4FQ7FHO7jzO4VSqhoNjAYoinaTZ
	 xCqX5+eAIolfrP+uQkZrFIh4h+OzQ1YVz6jOSEf978wvJX/qhxGktKy15fR8krb52WEnc
	 sxPwm80SHls9y43RKeQ4SCPz1I/CpS9iEnAGf/xSI8n23A9aRgs7qpgt4ezhFLaz4DvG8
	 BkJXv//Qazu4qyHAYooTWgd5Or4pYhBBEQBlADIawBBAfevCx5XiivZIkW1foPOxnMNPr
	 uBPd0ZomtjJOZWJKSEWQ/r92DKLwlCngrSlTJpdtgYGtH+KoImhGnvU1KsmVTmaX21Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6ylAD9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB490606A31B;
	Tue, 20 Oct 2026 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6ylAD9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4D11F000C9;
	Tue, 20 Oct 2026 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521926;
	bh=ykXZkGntS8u8RrEn/iLcc+w49SUGVewQTVjWJ9WDz/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6ylAD9w3YIqD4a4e8/D4V/n3+KlKDu60Pg3esvogSHL0LhHTarzIn3Xssi6S7qZy
	 YWCVgOBY3YEZ7eEZoS7zWkMnsN4imMqE4fuieRlzcAxs80exq4Vf2anyRJirewCUbD
	 LWaJpfMrnZr+hUpdPmYtYoLORaibvLnRqA5E94YyRXYJ5aBcxSct1OwTwXmEpHq7Iw
	 +bkQ1kaGAqwq2YVfb9CKTg9BJVQIcSsqHbP+EPjmXkPX4EzLirp1LiF6D0+m5Px+gj
	 YOS8mk/78+/ye/ZOLBkrqNxxN3/vStWI6Lhp8e+lOtBmsu0skan9I9jyVMBLf0NjEQ
	 ZQ4+4wsG3+vLg==
Message-ID: <sashiko-outbox-179492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261020182433.336637-1-mhklinux@outlook.com>
References: <20261020182433.336637-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:45:25 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PCI: hv: early activation in hv_pci_vec_irq_domain_activate() sk=
ews CPU0 load
- [Medium] PCI: hv: cpu_spi_count corruption in hv_pci_arm64_set_affinity()=
 when inactive
--

commit 9d112d599453572154cd3fbc90e3b6ea7dedf0e3
Author: Michael Kelley <mhkelley58@gmail.com>

PCI: hv: Spread load across CPUs when selecting effective affinity CPU

This patch extends the arm64 Hyper-V vPCI MSI irq chip to track per-CPU
SPI assignments and select the least-loaded CPU from the affinity mask
before forwarding the single-CPU effective affinity to the parent GICv3
chip. It also updates the domain activate and deactivate callbacks to
increment and decrement the per-CPU SPI counters.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 824cf27e85e67..7c293e39c9208 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

[ ... ]

> +/*
> + * Track the count of SPIs assigned to each CPU. Pick a single CPU from =
the
> + * affinity mask based on the SPI loading data, and have the parent IRQ
> + * chip (should be "GICv3") set the effective affinity to that single CP=
U.
> + */
> +static int hv_pci_arm64_set_affinity(struct irq_data *d,
> +				     const struct cpumask *mask_val,
> +				     bool force)
> +{
> +	unsigned int cpu, prev_cpu;
> +	int ret;
> +
> +	prev_cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
> +	if (prev_cpu < nr_cpu_ids)
> +		hv_pci_dec_spi_count(d, prev_cpu);
> +
> +	if (force)
> +		cpu =3D hv_pci_arm64_get_min_load(d, mask_val);
> +	else
> +		cpu =3D hv_pci_arm64_select_cpu(d, mask_val);
> +
> +	if (cpu >=3D nr_cpu_ids)
> +		goto err;
> +
> +	ret =3D irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
> +	if (ret < 0)
> +		goto err;
> +
> +	hv_pci_inc_spi_count(d, cpu);
> +	return ret;
> +
> +err:
> +	if (prev_cpu < nr_cpu_ids)
> +		hv_pci_inc_spi_count(d, prev_cpu);
> +	return -EINVAL;
> +}

[Severity: Medium]
Can hv_pci_arm64_set_affinity() corrupt cpu_spi_count when affinity is
changed on a deactivated interrupt?

When an allocated MSI or MSI-X interrupt is deactivated (for example, when
free_irq() -> __free_irq() calls irq_domain_deactivate_irq() while MSI
vectors remain allocated across ndo_stop/ndo_open or queue reconfiguration,
or when migrate_one_irq() calls irq_shutdown_and_deactivate()),
hv_pci_vec_irq_domain_deactivate() decrements cpu_spi_count for the CPU in
effective_affinity and IRQD_ACTIVATED is cleared, but the old CPU remains
set in the effective_affinity mask:

drivers/pci/controller/pci-hyperv.c:hv_pci_vec_irq_domain_deactivate() {
	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(irqd));
	if (cpu < nr_cpu_ids)
		hv_pci_dec_spi_count(irqd, cpu);
}

Because hv_pci_vec_irq_domain_alloc() does not set IRQD_AFFINITY_ON_ACTIVATE
(unlike its_irq_domain_alloc() in drivers/irqchip/irq-gic-v3-its.c),
irq_set_affinity_deactivated() does not defer affinity changes on a
deactivated interrupt:

kernel/irq/manage.c:irq_set_affinity_deactivated() {
	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
	    irqd_is_activated(data) || !irqd_affinity_on_activate(data))
		return false;
	...
}

If irq_set_affinity() or irq_force_affinity() is called while the interrupt
is deactivated (for example, via /proc/irq/<irq>/smp_affinity,
irq_set_affinity_hint(), or irq_restore_affinity_of_irq()),
irq_set_affinity_locked() -> irq_do_set_affinity() invokes
hv_pci_arm64_set_affinity(). That reads the stale prev_cpu from
irq_data_get_effective_affinity_mask(d), decrements prev_cpu's
cpu_spi_count a second time, and increments the newly selected cpu's
cpu_spi_count while IRQD_ACTIVATED remains false.

If the vector is later freed via pci_free_irq_vectors() ->
__msi_domain_free_irqs() in kernel/irq/msi.c, irq_domain_deactivate_irq()
is skipped because !irqd_is_activated(irqd), leaking the count on the new
CPU; or if the vector is re-activated via request_irq() -> irq_activate()
-> hv_pci_vec_irq_domain_activate(), effective_affinity is overwritten
with cpumask_first(cpu_online_mask) without decrementing the CPU selected
while deactivated.

Should hv_pci_vec_irq_domain_alloc() set IRQD_AFFINITY_ON_ACTIVATE, or
should hv_pci_vec_irq_domain_deactivate() clear effective_affinity?

[ ... ]

> @@ -885,21 +1007,39 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_=
domain *domain,
>   * composing MSI from the hypervisor. GIC will eventually set the right
>   * affinity for the irq and the 'unmask' will retarget the interrupt to =
that
>   * cpu.
> + *
> + * The first cpu is always used for initial activation because spreading=
 the
> + * initial CPU would have to be done without information about affinity =
groups
> + * that may exist. The resulting assignments would pollute the "least lo=
aded"
> + * data for making the final assignments. Everything would still work, b=
ut
> + * the spreading would be less even than it could be.
>   */
>  static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
>  					  struct irq_data *irqd, bool reserve)
>  {
> -	int cpu =3D cpumask_first(cpu_present_mask);
> +	int cpu =3D cpumask_first(cpu_online_mask);
> =20
> +	hv_pci_inc_spi_count(irqd, cpu);
>  	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
> =20
>  	return 0;
>  }

[Severity: Medium]
Won't incrementing cpu_spi_count in hv_pci_vec_irq_domain_activate() skew
the load calculation away from the first online CPU during multi-vector
MSI/MSI-X setup?

Because pci_msi_template and pci_msix_template in
drivers/pci/msi/irqdomain.c set MSI_FLAG_ACTIVATE_EARLY, allocating N
vectors via pci_alloc_irq_vectors() or pci_alloc_irq_vectors_affinity()
causes __msi_domain_alloc_irqs() to activate all N vectors in a batch via
msi_init_virq() -> irq_domain_activate_irq() ->
hv_pci_vec_irq_domain_activate() before returning and before request_irq()
is called on any vector:

kernel/irq/msi.c:__msi_domain_alloc_irqs() {
	...
	for (i =3D 0; i < desc->nvec_used; i++) {
		irq_set_msi_desc_off(virq, i, desc);
		irq_debugfs_copy_devname(virq + i, dev);
		ret =3D msi_init_virq(domain, virq + i, vflags);
		if (ret)
			return ret;
	}
}

This increments cpu_spi_count on cpumask_first(cpu_online_mask) (typically
CPU 0) for all N vectors up front, inflating CPU 0's count by N.

When the driver then calls request_irq() for each vector i =3D 0..N-1 in
sequence (such as in nvme_setup_io_queues()), irq_startup() ->
irq_do_set_affinity() -> hv_pci_arm64_set_affinity() decrements CPU 0's
cpu_spi_count by only 1 for vector i, leaving CPU 0's count inflated by
N - 1 - i from the remaining unstarted vectors of the same device still
parked on CPU 0. When hv_pci_arm64_select_cpu() selects a CPU for the first
queue (whose affinity mask includes CPU 0), it sees CPU 0's load inflated
by N - 1 and avoids assigning interrupts to CPU 0 for the first N - 1
devices probed.

Furthermore, if a driver allocates M vectors and only calls request_irq()
on K < M of them (or defers request_irq() until queues or network ports are
opened), the M - K unrequested vectors remain activated on CPU 0 and keep
its cpu_spi_count inflated by M - K.

Could hv_pci_vec_irq_domain_activate() leave effective_affinity empty and
avoid incrementing cpu_spi_count until hv_pci_arm64_set_affinity() selects
the actual target CPU?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020182433.3366=
37-1-mhklinux@outlook.com?part=3D1
