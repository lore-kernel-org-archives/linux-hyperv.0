Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512892;
	b=4x3oy9DUD1wjQMQ7aQQ6kEMm3Kegsitp2C8LazGg0uYeT9GrMYqGyOs2zLr7trXDA9qY
	 YgVA6USBkHJ6k/5LyY8iB2knjC82jerDtl5V+bzrjQKi6n1ntPTomaGkJxEA1L4eaAZjY
	 BwBlKTPjst+9/I9bYdfAMmoCd/5uK22Im3bJqyNCK2A1OaMWMAiJIKF7h8tAMY0MX9JYf
	 SGwN31jBmVIabOdo2A9zZ0BrVA9bRdE1jZsh5FrG4BndMtuoq5ce6r4oIQbnQlcYK0zMw
	 H/y+zibzd88LW0RTiQ2WZqeS2WHMY/tVcQ3F1VDZy7G4j3xvJ0ybYTuBibi3Dj4HNwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512892;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xs2pqe5hXzhzx21X55pZ2haP8v6flwPOkwvfqfrxxrI=;
	b=bLJ/pBK6S2ZVaH92pwlWSHkuG9SVwVY1W1No3kJ0jAIjG37GYodI91vKMsD5dKDLYG60
	 bYEfEkDLiYWGLytaGwBn2GR3gY9D25tQKWwjAJkiHMN8rmEUU1/UJt8bEl9ZccoUUwl+0
	 QEzbXwoj8m/1o3Ofcpm2lbX0ZkRcnKA3nVCfq6Z52oEpjsfq0oCS/Zs5XP6vqyAj1AQMr
	 mFSik+Y+qLZAZ0RKs+kXk3NHaGkBsZAir/3Vym11fByBPDokvn84c/9mV+lij7PlAQekA
	 hnH8avavZAFmWjaCFEyN2sCVNcDqm9C+iKEuj6R3dBTskG2e+YbdzPAV/Nsgbfapqmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4YjE0UG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B5606A31A;
	Tue, 20 Oct 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4YjE0UG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48F1F000C4;
	Tue, 20 Oct 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792512891;
	bh=xs2pqe5hXzhzx21X55pZ2haP8v6flwPOkwvfqfrxxrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4YjE0UGkuwzD9IUz/cqTsH8+DwG89zJ41e4MGgKI+H+rbf1dGZbVH8AQF+nmIh9R
	 M+t/GZA8ZOMrtx9Td0YLoaHUyB1uvq3u8TuLLm7NVB0a9mx3DY8y0NH68FU/DSQPbN
	 Yya3xxZSDEIrI59xhSn7bMUVgq/3SrQSlHwH5AyLxrDcjV/KQVeYWF8J4Q7IEC8x1A
	 IUO41k1i6Di4uB++0+kqHRRElpQjaPxZanJQm9DrB+HMHJGcTvhsCn1AYwFkHJz55q
	 qtLb51bh/zHI/fcc89oZVnJL1QyfmsPYt6cyISyDtoIIlT6bE23mS2LDMuctKqOdJY
	 p84Z3HWOeJpeQ==
Date: Tue, 20 Oct 2026 19:14:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Lukas Wunner <lukas@wunner.de>, Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261020161447.GN64621@unreal>
References: <20261020151305.65218-1-pavel.e.popov@intel.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020151305.65218-1-pavel.e.popov@intel.com>

On Tue, Oct 20, 2026 at 08:13:05AM -0700, Pavel Popov wrote:
> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. In Hyper-V guests, each passthrough
> device appears in a PCI domain of its own without a host bridge
> device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> against the host bridge whitelist, causing P2PDMA requests to fail
> regardless of host support.
> 
> This affects discrete devices such as GPUs, NICs and NVMe drives.
> 
> Add an explicit list of the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
> 
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Changes in v3:
> - Drop the hypervisor check and move the Xeon list into
>   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
>   Gunthorpe and Leon Romanovsky [1]
> - Fold the VMware and Hyper-V patches into one, as the check no longer
>   depends on the hypervisor
> 
> Changes in v2:
> - Replace the Skylake-and-newer threshold with an explicit list of Intel
>   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
>   Gunthorpe)
> - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
>   (Logan Gunthorpe)
> - Rebased on current mainline
> 
> [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> 
> v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
> v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com
> 
>  drivers/pci/p2pdma.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb314663..2650d605d87d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,6 +21,11 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +#endif
> +
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -519,6 +524,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>  }
>  
> +#ifdef CONFIG_X86

Do we really need all these #ifdefs? I'm pretty sure they're not needed for the
includes.

Thanks

> +/* Intel Xeon CPUs whose host bridges support p2pdma */
> +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {
> +	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> +	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> +	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> +	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
> +	{}
> +};
> +#endif
> +
>  static bool cpu_supports_p2pdma(void)
>  {
>  #ifdef CONFIG_X86
> @@ -527,6 +549,10 @@ static bool cpu_supports_p2pdma(void)
>  	/* Any AMD CPU whose family ID is Zen or newer supports p2pdma */
>  	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
>  		return true;
> +
> +	/* Listed Intel Xeon CPUs support p2pdma */
> +	if (x86_match_cpu(p2pdma_intel_cpu_ids))
> +		return true;
>  #endif
>  
>  	return false;
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.53.0
> 
> 
