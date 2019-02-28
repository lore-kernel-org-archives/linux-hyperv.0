Return-Path: <SRS0=MLR3=RD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C299C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF32F2183F
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Feb 2019 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfB1KJQ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:09:16 -0500
Received: from foss.arm.com ([217.140.101.70]:45186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfB1KJQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Feb 2019 05:09:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0484EBD;
        Thu, 28 Feb 2019 02:09:15 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599603F738;
        Thu, 28 Feb 2019 02:09:13 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:09:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <20190228100910.GB10207@e107981-ln.cambridge.arm.com>
References: <cover.1551319643.git.m.maya.nakamura@gmail.com>
 <6a86e6e6d299dcfa71bf9ba97c60def73c0547e1.1551319643.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a86e6e6d299dcfa71bf9ba97c60def73c0547e1.1551319643.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 28, 2019 at 02:35:06AM +0000, Maya Nakamura wrote:
> Remove a duplicate definition of VP set (hv_vp_set) and use the common
> definition (hv_vpset) that is used in other places.
> 
> Change the order of the members in struct hv_pcibus_device so that the
> declaration of retarget_msi_interrupt_params is the last member. Struct
> hv_vpset, which contains a flexible array, is nested two levels deep in
> struct hv_pcibus_device via retarget_msi_interrupt_params.
> 
> Add a comment that retarget_msi_interrupt_params should be the last
> member of struct hv_pcibus_device.
> 
> Based on Vitaly's finding, add __aligned(8) to struct
> retarget_msi_interrupt because Hyper-V requires that hypercall arguments
> be aligned on an 8 byte boundary.

Hi Maya,

a couple of comments:

1) Please always carry review tags, I can do it for you but you would
   make my life easier.
2) Vitaly's comment should be addressed in a separate patch that should
   come before this patch in chronological order, as he said, it is not
   an issue with this patch per-se.
3) "Based on Vitaly's finding" is meaningless to a commit log reader.
   Please add a "Link:" tag pointing at the relevant mailing list
   discussion.

Comments (1)-(3) apply to patch 2 in this series as well.

Update the patches with my comments above and if Vitaly ACKs them I
will try to merge them for v5.1 but this must be made very promptly.

Lorenzo

> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
> Changes in v4:
> - Add __aligned(8) to struct retarget_msi_interrupt.
> - Update the commit message.
> 
> Change in v3:
> - Correct the v2 change log.
> 
> Change in v2:
> - Update the commit message.
> 
>  drivers/pci/controller/pci-hyperv.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9ba4d12c179c..d71695db1ba0 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -393,12 +393,6 @@ struct hv_interrupt_entry {
>  
>  #define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
>  
> -struct hv_vp_set {
> -	u64	format;			/* 0 (HvGenericSetSparse4k) */
> -	u64	valid_banks;
> -	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
> -};
> -
>  /*
>   * flags for hv_device_interrupt_target.flags
>   */
> @@ -410,7 +404,7 @@ struct hv_device_interrupt_target {
>  	u32	flags;
>  	union {
>  		u64		 vp_mask;
> -		struct hv_vp_set vp_set;
> +		struct hv_vpset vp_set;
>  	};
>  };
>  
> @@ -420,7 +414,7 @@ struct retarget_msi_interrupt {
>  	struct hv_interrupt_entry int_entry;
>  	u64	reserved2;
>  	struct hv_device_interrupt_target int_target;
> -} __packed;
> +} __packed __aligned(8);
>  
>  /*
>   * Driver specific state.
> @@ -460,12 +454,16 @@ struct hv_pcibus_device {
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
>  
> -	/* hypercall arg, must not cross page boundary */
> -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> -
>  	spinlock_t retarget_msi_interrupt_lock;
>  
>  	struct workqueue_struct *wq;
> +
> +	/* hypercall arg, must not cross page boundary */
> +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> +
> +	/*
> +	 * Don't put anything here: retarget_msi_interrupt_params must be last
> +	 */
>  };
>  
>  /*
> @@ -955,12 +953,13 @@ static void hv_irq_unmask(struct irq_data *data)
>  		 */
>  		params->int_target.flags |=
>  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> -		params->int_target.vp_set.valid_banks =
> +		params->int_target.vp_set.valid_bank_mask =
>  			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
>  
>  		/*
>  		 * var-sized hypercall, var-size starts after vp_mask (thus
> -		 * vp_set.format does not count, but vp_set.valid_banks does).
> +		 * vp_set.format does not count, but vp_set.valid_bank_mask
> +		 * does).
>  		 */
>  		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
>  
> @@ -974,7 +973,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  				goto exit_unlock;
>  			}
>  
> -			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
> +			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
>  				(1ULL << (cpu_vmbus & 63));
>  		}
>  	} else {
> -- 
> 2.17.1
> 
