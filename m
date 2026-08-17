Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D673E6DEC;
	Mon, 17 Aug 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963067; cv=none; b=G9RngRJrZlX9fl4I5Swn6CQ1hjkVwtY0yqHD3vYzWFQqgYvwzPc8HlrTk6PE5+Iio9yY8B2X16SBL/6sDKS3Is/No8QiE8xZZaFgtIFXbMBDIUakYh/Yl13va59V6pRg8F2rcVW7o0GCmO+0Wo7slmYqgnqahk6HNiznHod4+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963067; c=relaxed/simple;
	bh=TQ8gzS3JH3anDnZz8/sQwcvOH7qfiiwZFP+5wIGZxcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxMwNhl0LkxqWn6M2skPC3brUZe9KRprkP0XxraWEX3v39OF+HKNkuhZ5YxNhhzhr76LCEqj2b/V4FRv8JPku51vxPRL01GwLe9BIEljw/u0Erhk7p9Un+Hp+GTrYJktXE1t0QZoqtA79+zmBgLWf+AKquE9pgB5r/uDLmIGk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ToyoGV0j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ToyoGV0j"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DCE320B7168;
	Mon, 17 Aug 2026 03:37:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DCE320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786963036;
	bh=1BKlBXAPRpaf8USNgP+j2y+NhjCV3YNX2Bdm7dpxmp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToyoGV0j5+4/Q9Gx6aibrkmss/5bwwygHLnveQlveG0IF1zG/4e/voe8vGU68NiQd
	 6hLuRi6N6BEjDKWsc5b+ZpVNbAFGZBTaYSxgGLny6MaGf7vXlgAk2zh32NM79rxIAZ
	 lTjYb1v51CiNqlBhTIcE6dNKCzFKQs7aej1axhbE=
Date: Mon, 17 Aug 2026 18:37:41 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, 
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Message-ID: <uvvdhtxzqkwbb7ur4pybseocn3c4erk4gbis7yll4cvgusjzke@n2lbeyn532w2>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
 <BN7PR02MB4148C2319B12C57B1FA3885ED4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148C2319B12C57B1FA3885ED4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>

On Fri, Aug 14, 2026 at 03:31:27PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11, 2026 8:50 AM
> > 
> > Hyper-V identifies each PCI pass-thru device by a logical device ID in
> > its hypercall interface. This ID consists of a per-bus prefix, derived
> > from the VMBus device instance GUID, combined with the PCI function
> > number of the endpoint device.
> > 
> > Add a registry in hv_common.c that maps a PCI domain number to its
> > logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> > prefix when a bus is probed and unregisters it when the bus is removed.
> > Consumers such as the para-virtualized IOMMU driver look up the prefix
> > by PCI domain number and combine it with the function number to form the
> > complete logical device ID for hypercalls.
> > 
> > Use rhashtable for the sparse exact-match mapping. Lookups copy the
> > prefix while holding the RCU read lock, and removal defers freeing the
> > entry until existing readers have completed.
> > 
> > The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> > that pci-hyperv's interrupt retargeting path and the registry use exactly
> > the same byte layout. It is derived on demand from the constant hv_device
> > instance GUID rather than cached in struct hv_pcibus_device, which is
> > private to the pci-hyperv module; this keeps the interface narrow and
> > avoids depending on pci-hyperv internals.
> > 
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c              | 123 ++++++++++++++++++++++++++++
> >  drivers/pci/controller/pci-hyperv.c |  21 +++--
> >  include/asm-generic/mshyperv.h      |  14 ++++
> >  include/linux/hyperv.h              |   8 ++
> >  4 files changed, 161 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 6b67ac616789..b30495b48a37 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/panic_notifier.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/random.h>
> > +#include <linux/rhashtable.h>
> >  #include <linux/efi.h>
> >  #include <linux/kdebug.h>
> >  #include <linux/kmsg_dump.h>
> > @@ -78,6 +79,27 @@ static struct ctl_table_header *hv_ctl_table_hdr;
> >  u8 * __percpu *hv_synic_eventring_tail;
> >  EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> 
> Making this code in hv_common.c conditional on HYPERV_PVIOMMU
> assumes that the only consumer is the pvIOMMU driver. But my
> understanding is that root partition code is also expected to be a
> consumer, and I would guess that code is independent of a guest
> pvIOMMU. So the #ifdef might need to become more complicated
> to also allow the root partition case. I'm thinking it makes sense to
> always build this code as part of hv_common.c. Even when building
> for a guest only with no root partition code, HYPERV_PVIOMMU
> defaults to HYPERV so the pvIOMMU driver will be built anytime
> Hyper-V code is included, unless someone goes out of their way to
> disable it. Getting rid of all the #ifdef'ery would make the code a bit
> cleaner, and I'm looking for an excuse to do so!
> 
> I'd also note that CONFIG_HYPERV_PVIOMMU isn't defined
> until Patch 4 of this series. This patch will still build without the
> remaining patches, so bisect isn't broken, but it would be with
> the equivalent of CONFIG_HYPERV_PVIOMMU=n. It's a little bit
> weird to be using a CONFIG_* value before it is created, but maybe
> the ordering among the patches is complex and not easily sorted.
>  

Thank you, Michael!

That makes sense. The trade-off is that a Hyper-V guest without
pvIOMMU support will still allocate and populate the registry for
its PCI buses. If that small overhead is acceptable, building it 
unconditionally does make the design simpler. And we do not need
to worry about the chicken-and-egg problem when ordering this patch
and patch 4. :)


> > +struct hv_pci_busdata {
> > +	int pci_domain_nr;
> > +	u32 logical_dev_id_prefix;
> > +	struct rhash_head node;
> > +	struct rcu_head rcu;
> > +};
> > +
> > +static struct rhashtable hv_pci_bus_ht;
> > +static bool hv_pci_bus_ht_initialized;
> > +
> > +static const struct rhashtable_params hv_pci_bus_ht_params = {
> > +	.key_len		= sizeof_field(struct hv_pci_busdata,
> > +					       pci_domain_nr),
> > +	.key_offset		= offsetof(struct hv_pci_busdata,
> > +					   pci_domain_nr),
> 
> Nit: The above two initializers will fit within 80 characters on a
> single line if you take out an unneeded tab before the "=".
> 

Will fix. Thanks!

> > +	.head_offset		= offsetof(struct hv_pci_busdata, node),
> > +};
> > +
> > +#endif
> > +
> >  /*
> >   * Hyper-V specific initialization and shutdown code that is
> >   * common across all architectures.  Called from architecture
> > @@ -86,6 +108,13 @@ EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
> > 
> >  void __init hv_common_free(void)
> >  {
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +	if (hv_pci_bus_ht_initialized) {
> > +		rhashtable_destroy(&hv_pci_bus_ht);
> > +		hv_pci_bus_ht_initialized = false;
> > +	}
> > +#endif
> > +
> >  	unregister_sysctl_table(hv_ctl_table_hdr);
> >  	hv_ctl_table_hdr = NULL;
> > 
> > @@ -315,6 +344,9 @@ u8 __init get_vtl(void)
> >  int __init hv_common_init(void)
> >  {
> >  	int i;
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +	int ret;
> > +#endif
> >  	union hv_hypervisor_version_info version;
> > 
> >  	/* Get information about the Microsoft Hypervisor version */
> > @@ -394,6 +426,15 @@ int __init hv_common_init(void)
> >  	for (i = 0; i < nr_cpu_ids; i++)
> >  		hv_vp_index[i] = VP_INVAL;
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +	ret = rhashtable_init(&hv_pci_bus_ht, &hv_pci_bus_ht_params);
> > +	if (ret) {
> > +		hv_common_free();
> > +		return ret;
> > +	}
> > +	hv_pci_bus_ht_initialized = true;
> > +#endif
> > +
> >  	return 0;
> >  }
> > 
> > @@ -863,3 +904,85 @@ const char *hv_result_to_string(u64 status)
> >  	return "Unknown";
> >  }
> >  EXPORT_SYMBOL_GPL(hv_result_to_string);
> > +
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +/*
> > + * Logical device ID registry shared between the vPCI bus driver
> > + * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
> > + * registers the per-bus logical device ID prefix at bus probe time, and
> > + * the pvIOMMU driver looks it up to build the full logical device ID used
> > + * in IOMMU hypercalls.
> > + */
> > +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
> 
> The comment above is written as if the pvIOMMU driver is the only
> consumer, which isn't accurate assuming the root partition use case
> materializes as expected.  And that also means having "iommu" in the
> function name is overly specific. Same with the other function names
> with "iommu".  There's really nothing here that is specific to pvIOMMUs.
> 

Agreed. Will update the comment.

For the function names, I would like to avoid using sth. like
hv_register_pci_bus() since that sounds like to register the
PCI bus itself. Two options I'm having in mind are:

	hv_pci_busdata_register()
	hv_pci_busdata_unregister()
	hv_pci_busdata_lookup()

or some more descriptive yet legthy ones, e.g.,

	hv_pci_bus_register_logical_dev_id_prefix()
	hv_pci_bus_unregister_logical_dev_id_prefix()
	hv_pci_bus_lookup_logical_dev_id_prefix()
                                                                                                                                                        
Do you have a preference, or any suggestion?

> > +{
> > +	struct hv_pci_busdata *bus, *new;
> > +	int ret = 0;
> > +
> > +	new = kzalloc_obj(*new, GFP_KERNEL);
> > +	if (!new)
> > +		return -ENOMEM;
> > +
> > +	new->pci_domain_nr = pci_domain_nr;
> > +	new->logical_dev_id_prefix = logical_dev_id_prefix;
> > +
> > +	bus = rhashtable_lookup_get_insert_fast(&hv_pci_bus_ht, &new->node,
> > +						hv_pci_bus_ht_params);
> > +	if (IS_ERR(bus)) {
> > +		ret = PTR_ERR(bus);
> > +	} else if (bus) {
> > +		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
> > +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
> > +			       pci_domain_nr, bus->logical_dev_id_prefix,
> > +			       logical_dev_id_prefix);
> > +			ret = -EEXIST;
> > +		}
> > +	} else {
> > +		goto out;
> > +	}
> > +
> > +	kfree(new);
> > +out:
> > +	return ret;
> 
> The typical pattern is that non-error path goes straight through to the return,
> and the error paths do the goto's the cleanup and exit. So I'd suggest that the
> two error case do "goto out", and "out" do the kfree and return. The non-error
> case just does "return 0" instead of the "else goto out".
> 

Thanks. That makes the flow clearer.

> Separately, it seems like the existing calls from the Hyper-V vPCI driver should
> never duplicate an existing mapping. Your code disallows mapping a domain_nr
> to a different logical_dev_id_prefix, but silently allows entering a mapping
> that already exists as an exact match. I wonder if that really should be
> allowed, as it seems likely such would be followed later by twice removing
> the duplicate entry, with the second removal failing. Removing a non-existent
> entry is also silently allowed in the unregister function below, with the same
> question as to whether that should be allowed.   
> 

Actually, I don't think an exact duplicate registration is a valid case
either. So how about we use WARN_ONCE() and return -EEXIST when an entry
for the PCI domain is already registered(regardless it is a exact match
or not)?

And for unregister, how about we initialize the result to -ENOENT, do the
removal if lookup finds the entry, and WARN_ONCE if no entry is really
removed? 

> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> 
> This may be overly restrictive if the root partition use case code is in the
> mshv_root module.
> 

Well, I'm not sure. IMHO, the register/unregister side is owned by
pci-hyperv, which creates and removes the Hyper-V PCI bus. The guest
pvIOMMU or the root driver are only cumsumers of the  lookup.                                                                                                                                                        

So maybe the register/unregister exports should remain restricted to
pci-hyperv, and if a future module needs the lookup helper, an export
can be added for the lookup helper by then (we do not need to export
lookup right now for pvIOMMU, which is built-in)?

Am I missing anything?

> > +
> > +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> > +{
> > +	struct hv_pci_busdata *bus;
> > +	bool removed = false;
> > +
> > +	rcu_read_lock();
> > +	bus = rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
> > +				hv_pci_bus_ht_params);
> > +	if (bus)
> > +		removed = !rhashtable_remove_fast(&hv_pci_bus_ht, &bus->node,
> > +						  hv_pci_bus_ht_params);
> > +	rcu_read_unlock();
> > +
> > +	if (removed)
> > +		kfree_rcu(bus, rcu);
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> > +
> > +/*
> > + * Look up the logical device ID prefix registered for @pci_domain_nr.
> > + * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
> > + * registered for that PCI domain.
> > + */
> > +int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
> > +{
> > +	struct hv_pci_busdata *bus;
> > +	int ret = -ENODEV;
> > +
> > +	rcu_read_lock();
> > +	bus = rhashtable_lookup(&hv_pci_bus_ht, &pci_domain_nr,
> > +				hv_pci_bus_ht_params);
> > +	if (bus) {
> > +		*prefix = bus->logical_dev_id_prefix;
> > +		ret = 0;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
> 
> Unfortunately, it looks like changing to use rhashtable didn't reduce
> the lines of code. :-(   But compared to a linked list, it does provide
> better performance when the number of entries grows.
> 

Yes. I only realized that after this code is cooked. But we still have
gains. :-)

> > +#endif /* CONFIG_HYPERV_PVIOMMU */
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfc8fa403dad..0b12b18fe0f1 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -641,10 +641,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
> >  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
> >  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> >  	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
> > -	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> > -			   (hbus->hdev->dev_instance.b[4] << 16) |
> > -			   (hbus->hdev->dev_instance.b[7] << 8) |
> > -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > +	params->device_id = hv_build_logical_dev_id_prefix(hbus->hdev) |
> >  			   PCI_FUNC(pdev->devfn);
> >  	params->int_target.vector = hv_msi_get_int_vector(data);
> > 
> > @@ -3715,6 +3712,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	struct hv_pcibus_device *hbus;
> >  	int ret, dom;
> >  	u16 dom_req;
> > +	u32 prefix;
> >  	char *name;
> > 
> >  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
> > @@ -3857,13 +3855,22 @@ static int hv_pci_probe(struct hv_device *hdev,
> > 
> >  	hbus->state = hv_pcibus_probed;
> > 
> > -	ret = create_root_hv_pci_bus(hbus);
> > +	/* Register the bus before scanning any devices on it. */
> > +	prefix = hv_build_logical_dev_id_prefix(hdev);
> > +
> > +	ret = hv_iommu_register_pci_bus(dom, prefix);
> >  	if (ret)
> >  		goto free_windows;
> > 
> > +	ret = create_root_hv_pci_bus(hbus);
> > +	if (ret)
> > +		goto unregister_pci_bus;
> > +
> >  	mutex_unlock(&hbus->state_lock);
> >  	return 0;
> > 
> > +unregister_pci_bus:
> > +	hv_iommu_unregister_pci_bus(dom);
> >  free_windows:
> >  	hv_pci_free_bridge_windows(hbus);
> >  exit_d0:
> > @@ -3977,6 +3984,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> > 
> >  	hbus = hv_get_drvdata(hdev);
> >  	if (hbus->state == hv_pcibus_installed) {
> > +		int dom = hbus->bridge->domain_nr;
> > +
> >  		tasklet_disable(&hdev->channel->callback_event);
> >  		hbus->state = hv_pcibus_removing;
> >  		tasklet_enable(&hdev->channel->callback_event);
> > @@ -3994,6 +4003,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> >  		hv_pci_remove_slots(hbus);
> >  		pci_remove_root_bus(hbus->bridge->bus);
> >  		pci_unlock_rescan_remove();
> > +
> > +		hv_iommu_unregister_pci_bus(dom);
> >  	}
> > 
> >  	hv_pci_bus_exit(hdev, false);
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index bf601d67cecb..4b3c9ba69cdb 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -73,6 +73,20 @@ extern enum hv_partition_type hv_curr_partition_type;
> >  extern void * __percpu *hyperv_pcpu_input_arg;
> >  extern void * __percpu *hyperv_pcpu_output_arg;
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix);
> > +void hv_iommu_unregister_pci_bus(int pci_domain_nr);
> > +int  hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix);
> > +#else
> > +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> > +					    u32 logical_dev_id_prefix)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> > +#endif
> 
> These stubs won't be needed if the code in hv_common.c is always
> built.
> 

Yes. Thanks!

B.R.
Yu

> > +
> >  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
> >  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> >  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index a2b484679eb4..7bc7b9b60002 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1287,6 +1287,14 @@ struct hv_device {
> >  #define device_to_hv_device(d)	container_of_const(d, struct hv_device, device)
> >  #define drv_to_hv_drv(d)	container_of_const(d, struct hv_driver, driver)
> > 
> > +static inline u32 hv_build_logical_dev_id_prefix(struct hv_device *hdev)
> > +{
> > +	return ((u32)hdev->dev_instance.b[5] << 24) |
> > +	       ((u32)hdev->dev_instance.b[4] << 16) |
> > +	       ((u32)hdev->dev_instance.b[7] << 8) |
> > +	       (hdev->dev_instance.b[6] & 0xf8u);
> > +}
> > +
> >  static inline void hv_set_drvdata(struct hv_device *dev, void *data)
> >  {
> >  	dev_set_drvdata(&dev->device, data);
> > --
> > 2.52.0
> > 
> 
