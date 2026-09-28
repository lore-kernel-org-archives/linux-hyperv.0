Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECA47DF86;
	Mon, 28 Sep 2026 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638418; cv=none; b=A12Lk/7RUoNUYyJwlRteKlxGGPiURKOrNgYbp0xM5/Mn2Erftjso9A+Vas/CkZ6e3CLQ4/pTqoCDru/jnXQQK/xsJ3JY81vzxjqS6EL7cwKII88o48yNbccbb1uwVJWLJ9mU7zrN1fB4I3wiQLN+vbtgat3EMp6NBM6L6QHPJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638418; c=relaxed/simple;
	bh=yLZ5jE+aOYjf/2iecgD8Qy20xu8jO95uvRKQarsAfC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJSZBTKu+m97lgePlH5hxz8Xbm99vAZfvzC7UFWgYRW9c7csL5W25pkgmgVnwBsdu11tNYyu/uknjbvZy+xjaWzRet/nHTvNs0GELlW3FsF7hFc/WjEZcvqafSiZCYQcozAUe9GlatdTj+kMRIbWK2jOhyhGXlHnm150viWS63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hzoSdV1b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hzoSdV1b"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D5DF20B7166;
	Mon, 28 Sep 2026 16:32:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D5DF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790638365;
	bh=sMT8EN3O9tuZdfIltXdYrhZ4ASeGIOHvmQ803a27Hig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hzoSdV1bTQdVLgm3l4rjKxwYbxUvS6O4VpN5wLn6eLdTGCgrlnIZL9E/q7HnO27sd
	 jeUi4wsWQ+nO9S3EOKqfOPf0jyO79FcsGV6I5wXswo2aXZCmjoCVcn1ES8S89vqghQ
	 i6EEK485kEqZHSwXiP8DstRWwl0Tt8u1nUU7J+qo=
Message-ID: <28ef0634-24ed-2cc7-89c8-48c8615a9691@linux.microsoft.com>
Date: Mon, 28 Sep 2026 16:33:35 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <179060271395.122959.9162511491972155683.b4-review@b4>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <179060271395.122959.9162511491972155683.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 06:38, Jason Gunthorpe wrote:
>> [ ... 103 lines skipped ... ]
>> +/*
>> + * We will not claim these PCI devices. Eg hypervisor debugger is using it
>> + * for a dynamic debug session. They cannot be enumerated under static ACPI
>> + * device scope.
>> + */
>> +static char *hv_skip_pci_devs;
>> +static int __init hv_iommu_setup_skip(char *str)
>> +{
>> +	hv_skip_pci_devs = str;
>> +	return 1;
>> +}
>> +/* Eg: hv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
>> +__setup("hv_iommu_skip=", hv_iommu_setup_skip);
> 
> I don't like this in a driver. This isn't really skipping anything, it
> is just leaving some devices in an identity mode.

Ok. I talked to the original author of that and i can just remove
it. It's mostly for running hyp debugger and we can just carry
the patch internally, at least for now.


> If you have a use case for this as a general command line policy then
> come with a core code enhacmenet so everyone can choose per-device
> their boot time mode.
> 
>> [ ... 7 lines skipped ... ]
>> +struct hv_domain {
>> +	struct iommu_domain iommu_dom;
>> +	u32 domid_num;			      /* as opposed to domain_id.type */
>> +	spinlock_t mappings_lock;	      /* protects mappings_tree */
>> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
> 
> This seems basically identical to what virtio-iommu is doing, can you
> consider sharing its code?

yeah, the tree part is somewhat identical, but virtio-iommu has extra
fields that we don't need. overall, i don't think there is enough here
to refactor, just few lines of code around add/remove calling kernel
interval tree apis. moreover, if hyp can provide the lookup in future,
i'd like to just remove it from here.

>> [ ... 26 lines skipped ... ]
>> +static bool hv_special_domain(struct hv_domain *hvdom)
>> +{
>> +	return hvdom == &hv_def_identity_dom || hvdom == &hv_def_blocked_dom;
>> +}
> 
> This is only called by hv_iommu_domain_free() which is only linked to
> hv_paging_domain_ops(), so it should be dead code
> 
>> [ ... 204 lines skipped ... ]
>> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
>> +			       struct iommu_domain *old)
>> +{
>> +	struct pci_dev *pdev;
>> +	int rc;
>> +	struct hv_domain *hvdom_new = to_hv_domain(immdom);
> 
> 'new' is an odd variable name here

'current' is passed as 'old', so we are moving from old to new i
thought. please tell me what would you like it called, thx.

>> [ ... 246 lines skipped ... ]
>> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
>> +{
>> +	return pci_device_group(dev);
>> +}
> 
> No need for a wrapper, use the function directly in the ops

it helps with quick debug... just set breakpoint in hv_iommu_device_group
or add a printk here at the cost of one jmp instruction. but whatever..
i can remove it if it helps move this forward.

>> +
>> +static void hv_iommu_get_resv_regions(struct device *dev,
>> +				      struct list_head *head)
>> +{
>> +	struct iommu_resv_region *reg;
>> +
>> +	/* reserve the entire LAPIC region */
>> +	reg = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0, IOMMU_RESV_MSI,
>> +				      GFP_KERNEL);
> 
> There was some discussion to make a helper for this, I don't see it
> merged yet..

we are both waiting on each other, whoever goes first will leave
the follower to address it i guess. i cannot test without this and
i am not sure if that series will merge first or this.

>> [ ... 65 lines skipped ... ]
>> +static int __init hv_iommu_init(void)
>> +{
>> +	int rc;
>> +	struct iommu_device *iommup = &hv_virt_iommu;
>> +	struct hv_output_get_iommu_capabilities caps;
>> +
>> +	if (!hv_is_hyperv_initialized())
>> +		return -ENODEV;
>> +
>> +	rc = hv_iommu_get_caps(&caps);
>> +	if (rc)
>> +		return rc;
>> +
>> +	hv_iommu_max_iova = ((ulong)1 << caps.max_iova_width) - 1;
>> +
>> +	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
>> +	if (rc) {
>> +		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	/* This must come before iommu_device_register() because the latter
>> +	 * calls into the hooks.
>> +	 */
>> +	hv_initialize_special_domains();
> 
> This probably should be before doing anything with sysfs.

ok.

Thanks,
-Mukesh


