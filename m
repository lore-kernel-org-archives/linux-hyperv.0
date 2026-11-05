Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846535;
	b=DYeEiqrkmXYu5NMKIbzldE33otmqjU0yID0itrCRyMf/zVGwpjYHetpWWaIQY2XwF0gi
	 Fjoo8+V4JSGMC8gJ1cvhBR9zq1EwXkEKn7SF8eNOeobcXnhRAxH3Lv8SOPtvRkpGCx4NS
	 8dUluOKHds3JSo6LcJJL+/o4hg74txyDYuryQQ65f0Cg+taor5AZhezoCXqA5V5SgkMv6
	 NCMDeektPZ5qYww6M89X4hqVRGA18E9//VbN9xiExDcGumg17GK11rjUPXm62yh+J3R8T
	 UJ2rhtDKBdOEWabz+kHsq9i03Calmo/AOuKxtUaq74T9zJofdz4fgPMje8Ub3W1PGNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846535;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=QtOU3iAi4II/7ObZ1Df6+ycmvUKCFA20uiBhRrgPaQ4=;
	b=R0CAPk0iYN9ACyCx/Ge2itGugPWhaZbRPtgHbhG5daVp/E+x7N778roq7D2v+u1Q2yYL
	 OlvnnHaOIxcoZaAk3Gl/Om1kmr4YKEobBuQE/q0sjV9dGeD2CeM/8FcjYFjLa4sU6IWw/
	 Tf8HYc7uFKSz+2DSNeogkULug4EhOU7yXCHEMZ2tb4klW1pLFcW86pNxEhhshnpOZuSEU
	 01L32EVPZRqWUX2eECsaG5hlIKpYrwTQldbfbg0LJFNXhTSxy56DTjM2KujW57WLANEYm
	 Z/YsSR+YCPQ6xRZCwpzHulyDhGkCD1RohIOro2m+HnNuCKhCIvuT1sEvzqWQeqkAWlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D1zhrjbY;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15B606EE8C
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 02:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F15B606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D1zhrjbY
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8128720B7166;
	Wed,  4 Nov 2026 18:41:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8128720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793846518;
	bh=QtOU3iAi4II/7ObZ1Df6+ycmvUKCFA20uiBhRrgPaQ4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D1zhrjbYP7HLgDPoCtmInZIZM/HelUcoLUmNfzWs6HtTh279Iteq2LYUlpinfmVGO
	 IfsOx16fXb/g4ZIwWgin2+/CEyaWBU2+tIg8i10nESsK5Nb0w+vDHoFX/KmRMpWztg
	 JhlQcvJu2W2gi0QGrFv8unPxaaiVt95/ZULjW3OU=
Message-ID: <9504b092-5289-cdf5-cd91-1c589dbc77c0@linux.microsoft.com>
Date: Wed, 4 Nov 2026 18:42:13 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU kernel
 only driver
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, linux-hyperv@vger.kernel.org
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-6-mrathor@linux.microsoft.com>
 <sashiko-outbox-198471@kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <sashiko-outbox-198471@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 18:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] iommu/hyperv: missing !hv_root_partition() check in hv_root_iommu_detect()
> --
> 
> commit c89a0e9d0fe34e767bd4527e0d99839504bcbea1
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
> x86/hyperv: Implement root partition IOMMU kernel only driver
> 
> This commit implements a kernel-only virtual IOMMU driver for baremetal
> Microsoft Hyper-V root partitions, handling paging domain management, device
> attachment, and IOVA page mapping via hypercalls.
> 
>> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
>> new file mode 100644
>> index 0000000000000..e0e3e9d4385e2
>> --- /dev/null
>> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> 
> [ ... ]
> 
>> +static int hv_iommu_get_caps(struct hv_output_get_iommu_capabilities *caps)
>> +{
>> +	u64 status;
>> +	unsigned long flags;
>> +	struct hv_input_get_iommu_capabilities *input;
>> +	struct hv_output_get_iommu_capabilities *output;
>> +
>> +	local_irq_save(flags);
>> +
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +	memset(input, 0, sizeof(*input));
>> +	input->partition_id = HV_PARTITION_ID_SELF;
>> +	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output);
>> +	*caps = *output;
>> +
>> +	local_irq_restore(flags);
>> +
>> +	if (!hv_result_success(status))
>> +		hv_status_err(status, "\n");
>> +
>> +	return hv_result_to_errno(status);
>> +}
>> +
>> +static int __init hv_root_iommu_init(void)
>> +{
>> +	int rc;
>> +	struct iommu_device *iommup = &hv_virt_iommu;
>> +	struct hv_output_get_iommu_capabilities caps;
>> +
>> +	if (!hv_is_hyperv_initialized())
>> +		return -ENODEV;
>> +
>> +	rc = hv_iommu_get_caps(&caps);
> 
> [ ... ]
> 
>> +void __init hv_root_iommu_detect(void)
>> +{
>> +	if (no_iommu || iommu_detected || hv_l1vh_partition())
>> +		return;
>> +
>> +	/* This is set for root partitions only, it is never set for non-root */
>> +	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
>> +		return;
>> +
>> +	iommu_detected = 1;
>> +	x86_init.iommu.iommu_init = hv_root_iommu_init;
>> +
>> +	pci_request_acs();
>> +}
> 
> [Severity: High]
> As reported by Sashiko on v3 [1], should hv_root_iommu_detect() check
> !hv_root_partition() instead of hv_l1vh_partition()?
> 
> During x86 boot, ms_hyperv_init_platform() calls hv_identify_partition_type()
> in drivers/hv/hv_common.c, which forces hv_curr_partition_type to
> HV_PARTITION_TYPE_GUEST whenever HV_ISOLATION is set so that Confidential VMs
> do not execute root partition paths:
> 
> drivers/hv/hv_common.c:hv_identify_partition_type() {
> 	hv_curr_partition_type = HV_PARTITION_TYPE_GUEST;
> 	...
> 	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> 	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> 		...
> 	}
> }
> 
> Later in boot, pci_iommu_alloc() calls hv_root_iommu_detect(). Because
> hv_root_iommu_detect() only checks hv_l1vh_partition(), a guest partition
> where HV_DEVICE_DOMAIN_AVAILABLE is set in ms_hyperv.misc_features will set
> iommu_detected = 1 and x86_init.iommu.iommu_init = hv_root_iommu_init.
> 
> When hyperv_init() then calls hv_common_init() in drivers/hv/hv_common.c,
> hyperv_pcpu_output_arg is only allocated if hv_output_page_exists() is true:
> 
> drivers/hv/hv_common.c:hv_common_init() {
> 	...
> 	if (hv_output_page_exists()) {
> 		hyperv_pcpu_output_arg = alloc_percpu(void *);
> 		BUG_ON(!hyperv_pcpu_output_arg);
> 	}
> }
> 
> For HV_PARTITION_TYPE_GUEST (with CONFIG_MSHV_ROOT depending on
> !HYPERV_VTL_MODE), hv_output_page_exists() is false and hyperv_pcpu_output_arg
> remains NULL.
> 
> If CONFIG_HYPERV_PVIOMMU is disabled, pci_iommu_init() invokes
> hv_root_iommu_init() -> hv_iommu_get_caps(), which dereferences
> *this_cpu_ptr(hyperv_pcpu_output_arg) while hyperv_pcpu_output_arg is NULL. If
> CONFIG_HYPERV_PVIOMMU is enabled, hyperv_init() overwrites
> x86_init.iommu.iommu_init with hv_pviommu_init, which then fails with -ENODEV
> because hv_root_iommu_detect() already set iommu_detected = 1.
> 
> Would checking !hv_root_partition() in hv_root_iommu_detect() avoid this by
> excluding both L1VH and guest partitions?
> 
> [1] https://lore.kernel.org/r/20261103025150.3192119-6-mrathor@linux.microsoft.com
> 

No. HV_DEVICE_DOMAIN_AVAILABLE is never set for non-root, ie, guest
partitions. So, a guest partition will never set iommu_detected here.

