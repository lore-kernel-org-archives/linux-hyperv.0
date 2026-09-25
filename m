Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750F1DA0E1;
	Fri, 25 Sep 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295256; cv=none; b=ka/Cxo5B0o2yy5IcHXQBn9sEaeICs2w/gxKqQSjI/00fUBycMVgVTSd7wbQh3dOSxGedw8m+rXapI3nyeKrywg39UIcZcbt2WloeGkc/lcx1x2+L8sW7ZBxaIM9JubFxBSL2xDPKy/ckSXGKqcbC5FAUCz7ocFQ4h0iysWbRHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295256; c=relaxed/simple;
	bh=jp6nqdE7QvGN4xwgnk39K2MvUBZJYTBZhJs+ybChk6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=morFUjzSee92c7hVYy99R07ODlrA8odbcQjQkrqivOoxPCQYP6lejDnU0/h19FUD+AE4RrKWo6pFHcrzi6pJ1os+4YfUBm52DKesa0Ja1OGkkr4KdIZkZVWmDINjZNZTPXRdFP4t8V4OpSPqATB+fOJEsEzJxu6UJlI1pjTLGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MM3tH2eD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MM3tH2eD"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 531DE20B7167;
	Thu, 24 Sep 2026 17:13:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 531DE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790295205;
	bh=/A8ze1IR0XgVzAUkWiSQ9oPFysWsnH8Xbk6S7e2PMHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MM3tH2eD9cqWsXiQWSQMFKupIv8icq0PO4O8qrwA38SHn9cvi95PyLmdbG7ZbAkR1
	 cW3NoaAjA1JgB9GiV2wN+FzqRDvNUiBUIwmCF0ujs7L0qaDvZ8iMlX+n+2T3wImter
	 pgOPA3YArpKLtJi9WIbLLsRXUvdEm+HjTE1IKWKk=
Message-ID: <329027b5-3110-8362-ccee-080c14ed9b3e@linux.microsoft.com>
Date: Thu, 24 Sep 2026 17:14:12 -0700
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
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <arUkaFhYGxaYwL0L@8bytes.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <arUkaFhYGxaYwL0L@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 06:35, J?rg R?del wrote:
> On Wed, Sep 23, 2026 at 07:02:21PM -0700, Mukesh R wrote:
>> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
>> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
>> +			      int prot, gfp_t gfp, size_t *mapped)
>> +{
>> +	u32 map_flags;
>> +	int ret;
>> +	u64 status = 0;
>> +	ulong npages, sav_iova = iova, done = 0;
>> +	struct hv_domain *hvdom = to_hv_domain(immdom);
>> +	phys_addr_t sav_paddr = paddr;
>> +	size_t done_size, size = pgsize * pgcount;
>> +
>> +	map_flags = HV_MAP_GPA_READABLE;	/* required */
>> +	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
>> +
>> +	npages = size >> HV_HYP_PAGE_SHIFT;
>> +	while (done < npages) {
>> +		ulong completed, remain = npages - done;
>> +
>> +		remain = min(remain, HV_MAP_DEVICE_GPA_BATCH_SIZE);
>> +
>> +		status = hv_iommu_map_pgs(hvdom, iova, paddr, remain,
>> +					  map_flags);
>> +
>> +		completed = hv_repcomp(status);
>> +		done = done + completed;
>> +		iova = iova + (completed << HV_HYP_PAGE_SHIFT);
>> +		paddr = paddr + (completed << HV_HYP_PAGE_SHIFT);
>> +
>> +		if (hv_result_needs_memory(status)) {
>> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +						    hv_current_partition_id,
>> +						    256);
> 
> hv_call_deposit_pages() can sleep and must not be called when gfp == GFP_ATOMIC.

yes, indeed, i missed it.  will address it...


>> +			if (ret)
>> +				break;
>> +			continue;
>> +		}
>> +		if (!hv_result_success(status))
>> +			break;
>> +	}
>> +
>> +	done_size = done << HV_HYP_PAGE_SHIFT;
>> +
>> +	if (mapped)
>> +		*mapped = done_size;
>> +
>> +	if (done_size == 0)
>> +		return hv_result_to_errno(status);
>> +
>> +	ret = hv_iommu_add_tree_mapping(hvdom, sav_iova, sav_paddr, done_size,
>> +					map_flags);
>> +	if (ret) {
>> +		size = hv_iommu_hyp_unmap_pages(immdom, sav_iova, done_size);
>> +		if (size != done_size)
>> +			WARN(1, "Failed to unmap exact sizes(%lx/%lx)\n",
>> +			     done_size, size);
>> +		if (mapped)
>> +			*mapped = done_size - size;
>> +
>> +		return ret;
>> +	}
> 
> A general question: Why is the tree mapping added after the hypervisor mappings
> are established. It seems easier and more robust the other way around.  Same on
> the unmap path which should use strictly the reverse order.
> 
> With this order, if adding a tree entry fails and the unmap only partially
> succeeds, it ends up with a partial mapping which can not be unmapped anymore
> because there is no tree entry.

well, it was before in V0, but sashiko/copilot/claude/.. you name it
all bots jumped on me that it would cause tree to go out of sync if map
fails to map everything, since removal from tree then will remove the
entire node in the cleanup path, thus leaving mappings in the hyp that
are not in the tree. In this case above, we only add to the tree whatever
succeeded. Problem at high level is, any of the two can fail, and undoing
could also fail, sorta chicken and egg issue.. We discussed internally
and thought adding WARN() would allow one to catch and maybe panic in
those cases. I also noticed that other drivers also have similar issues
and viommu_map_pages() just ignores if viommu_del_mappings() fails, and
fails the callback.  We fail the callback here also. My V0 did same as
viommu_map_pages(), difference being, in our case, a hypercall can
fail with partially done list.

So, I'm at a bit of loss. I could go back to V0 which did what what you
suggested above, but it can also leave stale mappings when map hypercall
succeeds partially and we delete the entire tree node in cleanup (but
we could add to the tree back whatever succeeded, but that could fail
also, but then we could unmap whatever was mapped, but that could fail
also.. see :)...).

Open to any other suggestions you might have also.


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
> 
> The capabilities returned need more checking. I think at least it needs a check
> for HV_IOMMU_CAP_PRESENT and that PAGE_SIZE is set in the pgsize_bitmap.

In general this caps hypercall is not available to root partitions,
our only agreement is for hyp to provide max_iova_width. But, we check
HV_DEVICE_DOMAIN_AVAILABLE in hv_iommu_detect() which sorta supersedes
HV_IOMMU_CAP_PRESENT. As for page size, hyp owns the iommu and can chose
the page size, meaning it can automatically use larger page size when
possible. But the hypercall HVCALL_MAP_DEVICE_GPA_PAGES will only take
4k pfns as input, hence:

#define HV_IOMMU_PGSIZES SZ_4K        /* for now, to be enhanced */

>> +	hv_iommu_max_iova = ((ulong)1 << caps.max_iova_width) - 1; >
> This is undefined behavior if caps.max_iova_width == 64. Better use
DMA_BIT_MASK().

Ok, I can change it back to DMA_BIT_MASK. (I removed after comment
on V0 that this is not dma address).

Thanks a lot for the review.

-Mukesh


