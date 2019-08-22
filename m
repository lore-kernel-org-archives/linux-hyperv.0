Return-Path: <SRS0=O+13=WS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD609C3A5A1
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444B20870
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495502;
	bh=1RdMJqxneLcxedqNQefzh8Rya2X6L0fY5oAISMkgdPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1hhsebb5LrpAIxnud/KPMaCLymnfs1we4FkEYonNLHrPr4GlkqVbGLd1y6eqjIUrS
	 XS/2Eek7gsjn5G2GV0gy3TubhDqgx8eJC4U2WMuP5p4q2+1lDqFXmab4N1CXpbwzaO
	 YvWTvqIXI5yF16SmFCgYUrLAdD/aJV0HXflox9RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392991AbfHVRiR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392985AbfHVRiQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 13:38:16 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA63620856;
        Thu, 22 Aug 2019 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566495495;
        bh=1RdMJqxneLcxedqNQefzh8Rya2X6L0fY5oAISMkgdPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UK+kYTQMVztH4W3mAUZjJ6Kjzmyf8+T37Y+rX1b6xgR3OljbmcU8sKi4O3CD9FBwb
         7w4wDl9KlCf6EiTsNr5cw9Zf1hYzs/UViPb/SyU9kkoyD1laLE1JKekqQem8eam1+T
         kUkpFprQo01LKQHU9Klek5erL00Q980eaPftiDHY=
Date:   Thu, 22 Aug 2019 20:38:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "saeedm@mellanox.com" <saeedm@mellanox.com>,
        "eranbe@mellanox.com" <eranbe@mellanox.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next,v4, 3/6] net/mlx5: Add wrappers for HyperV PCIe
 operations
Message-ID: <20190822173813.GM29433@mtr-leonro.mtl.com>
References: <1566450236-36757-1-git-send-email-haiyangz@microsoft.com>
 <1566450236-36757-4-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566450236-36757-4-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 22, 2019 at 05:05:47AM +0000, Haiyang Zhang wrote:
> From: Eran Ben Elisha <eranbe@mellanox.com>
>
> Add wrapper functions for HyperV PCIe read / write /
> block_invalidate_register operations.  This will be used as an
> infrastructure in the downstream patch for software communication.
>
> This will be enabled by default if CONFIG_PCI_HYPERV_INTERFACE is set.
>
> Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
> Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/Makefile |  1 +
>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c | 64 ++++++++++++++++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv.h | 22 ++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/hv.h
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index bcf3655..fd32a5b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -45,6 +45,7 @@ mlx5_core-$(CONFIG_MLX5_ESWITCH)   += eswitch.o eswitch_offloads.o eswitch_offlo
>  mlx5_core-$(CONFIG_MLX5_MPFS)      += lib/mpfs.o
>  mlx5_core-$(CONFIG_VXLAN)          += lib/vxlan.o
>  mlx5_core-$(CONFIG_PTP_1588_CLOCK) += lib/clock.o
> +mlx5_core-$(CONFIG_PCI_HYPERV_INTERFACE) += lib/hv.o
>
>  #
>  # Ipoib netdev
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c
> new file mode 100644
> index 0000000..cf08d02
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +// Copyright (c) 2018 Mellanox Technologies
> +
> +#include <linux/hyperv.h>
> +#include "mlx5_core.h"
> +#include "lib/hv.h"
> +
> +static int mlx5_hv_config_common(struct mlx5_core_dev *dev, void *buf, int len,
> +				 int offset, bool read)
> +{
> +	int rc = -EOPNOTSUPP;
> +	int bytes_returned;
> +	int block_id;
> +
> +	if (offset % HV_CONFIG_BLOCK_SIZE_MAX || len % HV_CONFIG_BLOCK_SIZE_MAX)
> +		return -EINVAL;
> +
> +	block_id = offset / HV_CONFIG_BLOCK_SIZE_MAX;
> +
> +	rc = read ?
> +	     hyperv_read_cfg_blk(dev->pdev, buf,
> +				 HV_CONFIG_BLOCK_SIZE_MAX, block_id,
> +				 &bytes_returned) :
> +	     hyperv_write_cfg_blk(dev->pdev, buf,
> +				  HV_CONFIG_BLOCK_SIZE_MAX, block_id);
> +
> +	/* Make sure len bytes were read successfully  */
> +	if (read)
> +		rc |= !(len == bytes_returned);

Unclear what do you want to achieve here, for read == true, "rc" will
have result of hyperv_read_cfg_blk(), which can be an error too.
It means that your "rc |= .." will give interesting results.

> +
> +	if (rc) {
> +		mlx5_core_err(dev, "Failed to %s hv config, err = %d, len = %d, offset = %d\n",
> +			      read ? "read" : "write", rc, len,
> +			      offset);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +int mlx5_hv_read_config(struct mlx5_core_dev *dev, void *buf, int len,
> +			int offset)
> +{
> +	return mlx5_hv_config_common(dev, buf, len, offset, true);
> +}
> +
> +int mlx5_hv_write_config(struct mlx5_core_dev *dev, void *buf, int len,
> +			 int offset)
> +{
> +	return mlx5_hv_config_common(dev, buf, len, offset, false);
> +}
> +
> +int mlx5_hv_register_invalidate(struct mlx5_core_dev *dev, void *context,
> +				void (*block_invalidate)(void *context,
> +							 u64 block_mask))
> +{
> +	return hyperv_reg_block_invalidate(dev->pdev, context,
> +					   block_invalidate);
> +}
> +
> +void mlx5_hv_unregister_invalidate(struct mlx5_core_dev *dev)
> +{
> +	hyperv_reg_block_invalidate(dev->pdev, NULL, NULL);
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.h
> new file mode 100644
> index 0000000..f9a4557
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2019 Mellanox Technologies. */
> +
> +#ifndef __LIB_HV_H__
> +#define __LIB_HV_H__
> +
> +#if IS_ENABLED(CONFIG_PCI_HYPERV_INTERFACE)

The common way to write it if(IS_ENABLED(CONFIG_FOO)) inside the code
and #ifdef CONFIG_FOO for header files.

> +
> +#include <linux/hyperv.h>
> +#include <linux/mlx5/driver.h>
> +
> +int mlx5_hv_read_config(struct mlx5_core_dev *dev, void *buf, int len,
> +			int offset);
> +int mlx5_hv_write_config(struct mlx5_core_dev *dev, void *buf, int len,
> +			 int offset);
> +int mlx5_hv_register_invalidate(struct mlx5_core_dev *dev, void *context,
> +				void (*block_invalidate)(void *context,
> +							 u64 block_mask));
> +void mlx5_hv_unregister_invalidate(struct mlx5_core_dev *dev);
> +#endif
> +
> +#endif /* __LIB_HV_H__ */
> --
> 1.8.3.1
>
