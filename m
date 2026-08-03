Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306E3264DD
	for <linux-hyperv@vger.kernel.org>; Mon,  3 Aug 2026 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729197; cv=none; b=sz1xuY1kQonhgjQiRgGZdUBuCrWkT5x1AUK2IBdTHOJmGPRWx2gohPKB6ijKYDCEtJ/PB79PfXgGufdZAv5ev/y42VSYZTRGq9unjTV3oVTFm6NQfvdpcUUWHq2ydh7Uov1gtHcpcOwDl+fUJdZzXWSEoVYCBtv6OTJhsB7dmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729197; c=relaxed/simple;
	bh=uEkh226VBof22x275e/QebTBkfKmNz18/hyYZ+nemfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILXqluCzvglkMlPDqNytmkhBJ2BGKiG/h9mqzjyNhwb45iUDaASBds8xBHhZqF59RH94ATubwGZRhHpQoZ6ub6SihXYtZWKYCT3hcxL8u7kjitxbrYQBo2GW+r7UgMaVU97NutedZlNMBxYX0uuJPTQldcZu5mjlpw2aXFp10Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs93jNp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs93jNp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4641F000E9;
	Mon,  3 Aug 2026 03:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729195;
	bh=G3rfeVsrTeOm08D2FWgIgONxSm5wuBbUFkyyNaGG4Fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fs93jNp5UHcnUaDpzoEYhdhXLYsaW9d9v2V6IEfScFfaB2n3QWHw5yVNGTea7hhDp
	 7A4zGjapi+JCqDg/YBLtifdOIw3VWyxiFwlo+Mu55ZIHHKeB7hytMs8Ql171pMdyoJ
	 EabvpSsRIBT0yhvlNnzvs23oGTluTqHy14AWVIww/oiae/0GT6B3gPRE5KanfThW/b
	 vPaof4w8lOszqMDVBu48giAxFdfA21OS2uzhVX7WeuIUr+b0mgM7fcPEY3gdfHox7t
	 SFK5rS8CX+uJXjKpJv+bZjSw3MAgDhVZO7je5oTC8GkmyjjPT5tGRSMscb05qBtsLt
	 BZEaOGKus0e0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory
 in Coco VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyu Lan" <ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803033520.12930-1-tiala@microsoft.com>
References: <20260803033520.12930-1-tiala@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:53:15 +0000
Message-Id: <20260803035315.5A4641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] The fallback paths in the allocation and deallocation function=
s recursively call the high-level DMA API, causing infinite loops.
- [Critical] The custom DMA allocator ignores the device's coherent DMA mas=
k, allocating memory above the hardware's addressing limits.
- [Critical] Streaming DMA mappings do not apply the mandatory memory encry=
ption bit to physical addresses.
- [Critical] Bypass of architectural DMA cache synchronization in streaming=
 mappings causes data corruption on non-coherent systems.
- [High] Globally overriding the `dma_ops` pointer breaks DMA for all non-V=
MBus devices on the system, and fails to restore the state on initializatio=
n errors.
- [High] The deallocation logic completely mismatches the allocation APIs, =
causing memory leaks, WARN_ONs, and skipped DMA unmapping.
- [Medium] The `dma_supported` map op callback incorrectly modifies device =
state instead of performing a read-only query.
- [Low] Referencing the global `dma_ops` pointer causes an undefined symbol=
 linker error on ARM64.
- [Low] The `else` branch managing unencrypted memory mappings in `hyperv_d=
ma_alloc_coherent` is unreachable.
--

--- Patch [1]: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memor=
y in Coco VM ---
commit 7e352d385400a7e2fcde56e56c2991270a9e565d
Author: Tianyu Lan <ltykernel@gmail.com>
Subject: x86/VMBus: DMA transfer with encrypted memory in Coco VM

This commit introduces Hyper-V DMA ops to support DMA transfers directly wi=
th
private/encrypted memory in CoCo VMs. It bypasses SWIOTLB bounce buffers for
certain PCI and Confidential VMBus devices.

> diff --git a/drivers/hv/hv_dma_ops.c b/drivers/hv/hv_dma_ops.c
> new file mode 100644
> index 0000000000000..ef53a42c0450b
> --- /dev/null
> +++ b/drivers/hv/hv_dma_ops.c
> @@ -0,0 +1,140 @@
[ ... ]
> +#include <asm/mshyperv.h>
> +#include "hyperv_vmbus.h"
> +#include "../../kernel/dma/direct.h"
> +
> +extern const struct dma_map_ops *dma_ops;

[Severity: Low]
Is this extern declaration safe on ARM64?

The CONFIG_HYPERV option supports ARM64, but the global dma_ops variable is
only exported on certain architectures like x86. On ARM64, this does not ex=
ist,
which could result in an undefined symbol linker error.

[ ... ]
> +static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *sgl,
> +		int nelems, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	dma_addr_t dma_addr;
> +	int i;
> +
> +	if (hyperv_private_memory_dma(dev)) {
> +		for_each_sg(sgl, sg, nelems, i) {
> +			dma_addr =3D __phys_to_dma(dev, sg_phys(sg));
> +			sg_dma_address(sg) =3D dma_addr;

[Severity: Critical]
Does this mapping miss the mandatory memory encryption bit?

For private memory transfers in CoCo VMs, physical addresses must be mapped
with a specific encryption bit. Returning the unencrypted physical address
here could cause the hardware to access the memory as shared or decrypted.

[Severity: Critical]
Is it safe to skip cache synchronization here?

By returning early after translation without calling generic wrappers, and
lacking .sync_single_for_cpu and .sync_single_for_device callbacks in the
hyperv_dma_ops structure, this bypasses architectural DMA cache flushing. On
architectures that are not hardware cache-coherent, this could lead to data
corruption.

> +			sg_dma_len(sg) =3D sg->length;
> +		}
> +
> +		return nelems;
> +	} else {
> +		return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
> +	}
> +}
[ ... ]
> +static int hyperv_dma_supported(struct device *dev, u64 mask)
> +{
> +	dev->coherent_dma_mask =3D mask;

[Severity: Medium]
Should a dma_supported callback modify the device state?

The ops->dma_supported callback is strictly a read-only query evaluated by
functions like dma_supported(). Assigning dev->coherent_dma_mask here silen=
tly
alters the device state when the driver only intends to query supported
capabilities.

> +	return 1;
> +}
[ ... ]
> +/* allocate and map a coherent mapping */
> +static void *
> +hyperv_dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *d=
ma_handle,
> +		    gfp_t flag, unsigned long attrs)
> +{
> +	phys_addr_t phys;
> +	void *ret;
> +
> +	if (!hyperv_private_memory_dma(dev))
> +		return dma_alloc_coherent(dev, size, dma_handle, flag);

[Severity: Critical]
Can this fallback path cause an infinite recursion?

If hyperv_private_memory_dma() is false, this calls dma_alloc_coherent().
The core API looks up the device's DMA ops via get_dma_ops(), which now ret=
urns
hyperv_dma_ops due to the global override. This would recursively call back=
 into
hyperv_dma_alloc_coherent(), leading to a stack overflow.

> +
> +	size =3D ALIGN(size, PAGE_SIZE);
> +	ret =3D (void *)__get_free_pages(flag, get_order(size));

[Severity: Critical]
Could this allocation bypass the device's DMA boundary constraints?

The core DMA API strips memory placement zone flags (like __GFP_DMA32) befo=
re
calling ops->alloc, expecting the implementation to allocate from the corre=
ct
zone based on dev->coherent_dma_mask. Blindly allocating via __get_free_pag=
es()
here could result in allocating memory above the hardware's addressing limi=
ts
for devices with constrained DMA masks.

> +	if (!ret)
> +		return ret;
> +	phys =3D virt_to_phys(ret);
> +
> +	if (hyperv_private_memory_dma(dev))
> +		*dma_handle =3D dma_addr_encrypted(__phys_to_dma(dev, phys));
> +	else
> +		*dma_handle =3D phys_to_dma_unencrypted(dev, phys);

[Severity: Low]
Is this else branch reachable?

The function returns early at the top if hyperv_private_memory_dma(dev) is
false. By the time execution reaches this block, the condition is guaranteed
to be true, making this else branch dead code.

> +
> +	memset(ret, 0, size);
> +	return ret;
> +}
> +
> +/* free a coherent mapping */
> +static void
> +hyperv_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
> +		   dma_addr_t dma_addr, unsigned long attrs)
> +{
> +	if (hyperv_private_memory_dma(dev))
> +		dmam_free_coherent(dev, size, vaddr, dma_addr);

[Severity: Critical]
Can the dmam_free_coherent() call result in infinite recursion?

Since the memory was not allocated via devres, dmam_free_coherent() will fa=
ll
back to dma_free_coherent(). This looks up ops->free and infinitely recurses
back into hyperv_dma_free_coherent().

> +	else
> +		free_pages((unsigned long)vaddr, get_order(size));

[Severity: High]
Are the allocation and deallocation APIs correctly paired here?

The branches appear to use inverted APIs. For private memory, it is allocat=
ed
via __get_free_pages() but freed using the devres-managed dmam_free_coheren=
t(),
which could fail to find a devres entry.

For non-private memory, it is allocated via dma_alloc_coherent() but
incorrectly freed using free_pages(). Bypassing the DMA API on free skips
SWIOTLB bounce buffer cleanup and IOMMU unmapping, potentially causing reso=
urce
leaks.

> +}
> +
> +static dma_addr_t hyperv_dma_map_phys(struct device *dev, phys_addr_t ph=
ys,
> +		size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	if (hyperv_private_memory_dma(dev))
> +		return __phys_to_dma(dev, phys);

[Severity: Critical]
Does this mapping miss the memory encryption bit?

Similar to hyperv_dma_map_sg, returning the unencrypted physical address for
private memory transfers could cause the hardware to access the memory as s=
hared
or decrypted.

[Severity: Critical]
Is it safe to bypass generic cache synchronization wrappers here?

As with hyperv_dma_map_sg, missing the cache flushing could cause data
corruption on non-coherent architectures.

> +	else
> +		return dma_direct_map_phys(dev, phys, size, dir, attrs, true);
> +}
[ ... ]
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6824bd7cb3c4f..3479528d3b963 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -40,6 +40,10 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> +#include "../../kernel/dma/direct.h"
> +
> +extern const struct dma_map_ops *dma_ops;

[Severity: Low]
Would this extern declaration cause build issues on ARM64?

The global dma_ops pointer does not exist on ARM64, which may result in a l=
inker
error on architectures that do not export it.

[ ... ]
> @@ -1518,8 +1527,11 @@ static int vmbus_bus_init(void)
>  	 * doing that on each VP while initializing SynIC's wastes time.
>  	 */
>  	is_confidential =3D ms_hyperv.confidential_vmbus_available;
> -	if (is_confidential)
> +	if (is_confidential) {
> +		dma_ops =3D &hyperv_dma_ops;

[Severity: High]
Could overriding the global dma_ops pointer affect other devices?

Setting the system-wide dma_ops pointer forces all standard non-VMBus devic=
es
to use these Hyper-V DMA ops. Additionally, if vmbus_alloc_synic_and_connec=
t()
fails later, this global pointer is left hijacked on the error path, which =
could
lead to system failures for non-VMBus devices.

>  		pr_info("Establishing connection to the confidential VMBus\n");
> +	}
> +
>  	hv_para_set_sint_proxy(!is_confidential);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803033520.1293=
0-1-tiala@microsoft.com?part=3D1
