Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F10426ECF;
	Wed, 22 Jul 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756520; cv=none; b=CiiSFC8BJrucNd0d89jCKO/RwTuUpKyf4q2MTGATHzkRr4R6YhBlC11Bxe34wWosWmnWz0ah4wBokstgaJQuHCaboN7KiGLaxuqA8Wf8G+rPLqsjOV0H2kOlMgYNr12lPecbxz5EfuZiXtyML5VzTBsgtVeOeb1f9/Ai6BPlV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756520; c=relaxed/simple;
	bh=L+STmZI+O/8Hy6zGjmONJJCtr6XoQGgf9D7qLCNCfyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkP1n3uJUBS/9cBqWoCZ1qAIbOxBfjCETavvKGuNZH4DMz3LDr5wv39p2w/HJ7q2kinv07T3Rfri9m45DGszIkz3rT65ndagbolxE8hZ4QfCvce2dQS/rwqRr6j5WjSnchNZQr+lkf/IK3bdq9/q2zrK+0Awfh1bjNTF987/lqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L58kQ5F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L58kQ5F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2B71F00A3A;
	Wed, 22 Jul 2026 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756519;
	bh=H/eaTnt2I7rZkB+qPiBdgLQe1e95G0GpjeQTI+in0pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L58kQ5F7e72kRh71GHIPD8qMMAL2X+gAjsfEtteGJd5+6ml3rM6MeDIin7Bq0DC1k
	 lu1XR137iaqDq1t6aIBhEqZnfWUC0W7YyIkym+0yXuA81aa7DmBjn/lw3e6GJw8hmo
	 5HL09ur3SsIrZdk4LWVRJREIwJDxjzHfiY7CXBf56nV4V3+yLBLdV9Od1vYnKyvue9
	 7U/M00lYgN827TfDb4pPwZJhA+RKpwlq4aapcoYYe0nUe57x3OoUj1IsaqX+htjEyS
	 XXSUE2monLapllLUUYOLWIX/+tRfXqw/Ygjbg2JLfrbaX2qlrlNygxAiC0bW4fZBU4
	 BGaOiD+M6vfDw==
Date: Wed, 22 Jul 2026 14:41:57 -0700
From: Wei Liu <wei.liu@kernel.org>
To: anirudh@anirudhrb.com, paekkaladevi@microsoft.com,
	avchaurasia@microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Add dedicated ioctl for GVA to GPA translation
Message-ID: <20260722214157.GB2020652@liuwe-devbox-debian-v2.local>
References: <177750046968.208629.5511024136301980968.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177750046968.208629.5511024136301980968.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Apr 29, 2026 at 10:08:06PM +0000, Stanislav Kinsburskii wrote:
> Add an MSHV_TRANSLATE_GVA ioctl on the VP fd that wraps
> HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX with transparent fault-in handling for
> movable memory regions. The passthrough path for this hypercall is retained
> for backward compatibility.
> 
> When guest-backing pages reside in movable memory regions, the mmu_notifier
> invalidation path remaps them to NO_ACCESS in the hypervisor's second-level
> address translation tables. If the VMM issues a GVA translation (e.g.
> during MMIO emulation) while a page-table page is invalidated, the
> hypervisor returns HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS. The VMM cannot
> resolve this on its own.
> 

Pavan, Avinash and Anirudh, I think this needs further attention.

As we optimize the memory management code, this patch's premise will
likely no longer hold.

Wei

> The new ioctl detects this transient GPA access failure, faults the page
> back in via mshv_region_handle_gfn_fault(), and retries the translation
> until it succeeds or an unrecoverable error occurs.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    3 ++
>  drivers/hv/mshv_root_hv_call.c |   37 +++++++++++++++++++++
>  drivers/hv/mshv_root_main.c    |   69 ++++++++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |    1 +
>  include/hyperv/hvhdk.h         |   41 ++++++++++++++++++++++++
>  include/uapi/linux/mshv.h      |   10 ++++++
>  6 files changed, 161 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 1f086dcb7aa1a..2e6c4414740cc 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -290,6 +290,9 @@ int hv_call_delete_vp(u64 partition_id, u32 vp_index);
>  int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
>  				     u64 dest_addr,
>  				     union hv_interrupt_control control);
> +int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
> +					 u64 flags, u64 gva, u64 *gfn,
> +					 struct hv_translate_gva_result_ex *result);
>  int hv_call_clear_virtual_interrupt(u64 partition_id);
>  int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
>  				  union hv_gpa_page_access_state_flags state_flags,
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 1f19a4ca824f0..f8c2341193da5 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -677,6 +677,43 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
>  	return 0;
>  }
>  
> +int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
> +					 u64 flags, u64 gva, u64 *gfn,
> +					 struct hv_translate_gva_result_ex *result)
> +{
> +	struct hv_input_translate_virtual_address *input;
> +	struct hv_output_translate_virtual_address_ex *output;
> +	unsigned long irq_flags;
> +	u64 status;
> +
> +	local_irq_save(irq_flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = partition_id;
> +	input->vp_index = vp_index;
> +	input->control_flags = flags;
> +	input->gva_page = gva >> HV_HYP_PAGE_SHIFT;
> +
> +	status = hv_do_hypercall(HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX,
> +				 input, output);
> +
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(irq_flags);
> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
> +		return hv_result_to_errno(status);
> +	}
> +
> +	*result = output->translation_result;
> +	*gfn = output->gpa_page;
> +
> +	local_irq_restore(irq_flags);
> +
> +	return 0;
> +}
> +
>  int
>  hv_call_clear_virtual_interrupt(u64 partition_id)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd4..665d565899c15 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -898,6 +898,72 @@ mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
>  	return 0;
>  }
>  
> +static bool mshv_gpa_fault_retryable(u32 result_code)
> +{
> +	/*
> +	 * Note: HV_TRANSLATE_GVA_GPA_UNMAPPED is intentionally not handled
> +	 * here. The guest page table cannot be unmapped under normal
> +	 * operation. It may be mapped with no access during page moves,
> +	 * but a truly unmapped state indicates a kernel driver bug.
> +	 * Retrying in this case would only mask the underlying problem of
> +	 * an unmapped guest page table.
> +	 */
> +	return result_code == HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS;
> +}
> +
> +static long
> +mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
> +{
> +	struct mshv_partition *partition = vp->vp_partition;
> +	struct mshv_translate_gva args;
> +	struct hv_translate_gva_result_ex result;
> +	u64 gfn, gpa;
> +	int ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	do {
> +		ret = hv_call_translate_virtual_address_ex(vp->vp_index,
> +							   partition->pt_id,
> +							   args.flags, args.gva,
> +							   &gfn, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (mshv_gpa_fault_retryable(result.result_code)) {
> +			struct mshv_mem_region *region;
> +			bool faulted;
> +
> +			region = mshv_partition_region_by_gfn_get(partition,
> +								  gfn);
> +			if (!region)
> +				return -EFAULT;
> +
> +			faulted = false;
> +			if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
> +				faulted = mshv_region_handle_gfn_fault(region,
> +								       gfn);
> +			mshv_region_put(region);
> +
> +			if (!faulted)
> +				return -EFAULT;
> +
> +			cond_resched();
> +		}
> +	} while (mshv_gpa_fault_retryable(result.result_code));
> +
> +	gpa = (gfn << PAGE_SHIFT) | (args.gva & ~PAGE_MASK);
> +
> +	if (copy_to_user(args.result, &result, sizeof(*args.result)))
> +		return -EFAULT;
> +
> +	if (copy_to_user(args.gpa, &gpa, sizeof(*args.gpa)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static long
>  mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  {
> @@ -917,6 +983,9 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  	case MSHV_SET_VP_STATE:
>  		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
>  		break;
> +	case MSHV_TRANSLATE_GVA:
> +		r = mshv_vp_ioctl_translate_gva(vp, (void __user *)arg);
> +		break;
>  	case MSHV_ROOT_HVCALL:
>  		r = mshv_ioctl_passthru_hvcall(vp->vp_partition, false,
>  					       (void __user *)arg);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 6a4e8b9d570fd..ac901801fd397 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -484,6 +484,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
> +#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX		0x00ac
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 5e83d37149662..08eede666762e 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -952,4 +952,45 @@ struct hv_input_modify_sparse_spa_page_host_access {
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
>  
> +enum hv_translate_gva_result_code {
> +	HV_TRANSLATE_GVA_SUCCESS			= 0,
> +
> +	/* Translation failures */
> +	HV_TRANSLATE_GVA_PAGE_NOT_PRESENT		= 1,
> +	HV_TRANSLATE_GVA_PRIVILEGE_VIOLATION		= 2,
> +	HV_TRANSLATE_GVA_INVALID_PAGE_TABLE_FLAGS	= 3,
> +
> +	/* GPA access failures */
> +	HV_TRANSLATE_GVA_GPA_UNMAPPED			= 4,
> +	HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS		= 5,
> +	HV_TRANSLATE_GVA_GPA_NO_WRITE_ACCESS		= 6,
> +	HV_TRANSLATE_GVA_GPA_ILLEGAL_OVERLAY_ACCESS	= 7,
> +
> +	HV_TRANSLATE_GVA_INTERCEPT			= 8,
> +	HV_TRANSLATE_GVA_GPA_UNACCEPTED			= 9,
> +};
> +
> +struct hv_input_translate_virtual_address {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 padding;
> +	u64 control_flags;
> +	u64 gva_page;
> +} __packed;
> +
> +struct hv_translate_gva_result_ex {
> +	u32 result_code; /* enum hv_translate_gva_result_code */
> +	u32 cache_type : 8;
> +	u32 overlay_page : 1;
> +	u32 reserved : 23;
> +#if IS_ENABLED(CONFIG_X86)
> +	char event_info[40]; /* HV_X64_PENDING_EVENT */
> +#endif
> +} __packed;
> +
> +struct hv_output_translate_virtual_address_ex {
> +	struct hv_translate_gva_result_ex translation_result;
> +	u64 gpa_page;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_H */
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b2..5aae848ded4ea 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -318,6 +318,16 @@ struct mshv_get_set_vp_state {
>  #define MSHV_RUN_VP			_IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
>  #define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_vp_state)
>  #define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_vp_state)
> +
> +struct mshv_translate_gva {
> +	__u64 gva;
> +	__u64 flags;
> +	__u64 *result; /* enum hv_translate_gva_result_code */
> +	__u64 *gpa;
> +};
> +
> +#define MSHV_TRANSLATE_GVA		_IOWR(MSHV_IOCTL, 0xF2, struct mshv_translate_gva)
> +
>  /*
>   * Generic hypercall
>   * Defined above in partition IOCTLs, avoid redefining it here
> 
> 
