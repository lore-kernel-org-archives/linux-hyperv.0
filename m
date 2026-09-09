Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6057EDA8;
	Wed,  9 Sep 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970086; cv=none; b=KHWL/Xi86sasfD76q3slLrU/R8/vbth/N2xKSqQB0/UocpqZu8AJJ+4KlFTFBK38EUS9eLd5H1rTxqU0pxsIeCx1Q9DvKDbjpF8aeNN/1QeO0aK7qRtVWATVEEgiJt1TqKP4L1DJaz19Fiww/h6kENioLDpc0gEXdTirmlf0+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970086; c=relaxed/simple;
	bh=JkwN6FfLnr515igDH51Qz5wd7d/8nukuTZUzodOTA8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPP91aWos7wXlSN8OFBnEq376WVe1KTKjfYBtMJDhhqChwg4YX2DvMiqmWbDIHIFU8eEu60pRI3E12iUyz/TRQRlzr2Av50uqZmEBrERdWysaVH/EH4Fd1e2Aiq2C0+EVeW5u96XMIb8mpc6C/OesYuRru+p1DJfFqpAzNyu8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEIZW+VT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEIZW+VT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B671F00A3A;
	Wed,  9 Sep 2026 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970084;
	bh=rF0cscCMKkD34fePqalub+pXM8u7LKVqJfRQzNw+xSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEIZW+VT3PgxiYb+2e5ZnzD+HVV1wbf4R3eIbAjFz2rqPlaf91/lrmKCVPmvQYzlG
	 oy513tX4003zIrkK4Jpab/8+QTzVCEMAr0+nJy/hNiSbm9uYeUwkKmlUsnQu6xyVRq
	 6K61Dyz/yMQjzjj09IHUUONKRMUr8QY/7fQF6t5qRfveJFdOWycbV2zHDDqMWKxfDr
	 kAZ9pU2meBFCXFA58kBulQDoOk11mlEMZm7YgAAHkuoRHuJvfa4X2iJ9V0o0r3cpYs
	 JKFVsZstNYOaCFySp+0Br0q4Mxc8rV7TaOuCeM3vIjsdNXqutKKNu4pgUj2xAnkB0I
	 07IjUPG+qK1mQ==
From: Simon Horman <horms@kernel.org>
To: mhkelley58@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Fix error paths in vmbus_teardown_gpadl()
Date: Wed,  9 Sep 2026 17:07:11 +0100
Message-ID: <20260909160711.697508-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907214902.9046-2-mhklinux@outlook.com>
References: <20260907214902.9046-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260907214902.9046-2-mhklinux@outlook.com?part=1
---
    Drivers: hv: vmbus: Fix error paths in vmbus_teardown_gpadl()
    
    In vmbus_teardown_gpadl(), the return value from vmbus_post_msg() is
    overwritten by the logic that decides if set_memory_encrypted() should
    run. A failure from vmbus_post_msg() is lost and vmbus_teardown_gpadl()
    may incorrectly report success. Furthermore, if vmbus_post_msg() fails,
    the GPADL remains active on the Hyper-V side, yet in a CoCo VM the
    buffer will be re-encrypted anyway.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260904160724.82AB51F00A3D@smtp.kernel.org/
Fixes: d4dccf353db8 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f4370617deacb..cc86e8505ad0b 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1059,14 +1059,14 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
>  
>  	kfree(info);
>  
> -	if (gpadl->decrypted)
> +	if (!ret && gpadl->decrypted) {
>  		ret = set_memory_encrypted((unsigned long)gpadl->buffer,
>  					PFN_UP(gpadl->size));
> -	else
> -		ret = 0;
> -	if (ret)
> -		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
> +		if (ret)
> +			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
> +	}
>  
> +	/* If error in ret, mark buffer decrypted so it is leaked */
>  	gpadl->decrypted = ret;

[Severity: High]
This is a pre-existing issue, but does this early return in
vmbus_teardown_gpadl() bypass the leak mechanism?

drivers/hv/channel.c:vmbus_teardown_gpadl() {
	...
	info = kzalloc(sizeof(*info) +
		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
	if (!info)
		return -ENOMEM;
	...
}

If this kzalloc() fails, gpadl->decrypted is not updated.

In a CoCo VM, __vmbus_open() establishes a GPADL for the ring buffer and
initializes gpadl->decrypted to false. If a subsequent step in
__vmbus_open() fails, it calls vmbus_teardown_gpadl() to roll back:

drivers/hv/channel.c:__vmbus_open() {
	...
error_free_gpadl:
	vmbus_teardown_gpadl(newchannel, &newchannel->ringbuffer_gpadlhandle);
error_clean_ring:
	...
	return err;
}

Since __vmbus_open() ignores the teardown failure, vmbus_open() will then
proceed to call vmbus_free_ring():

drivers/hv/channel.c:vmbus_free_ring() {
	...
		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
		if (!channel->ringbuffer_gpadlhandle.decrypted)
			__free_pages(channel->ringbuffer_page,
			...
}

Because gpadl->decrypted remains false instead of being set to -ENOMEM,
vmbus_free_ring() will erroneously free the memory back to the kernel page
allocator. Could this lead to guest memory corruption if the host hypervisor
retains an active GPADL mapping and overwrites it?

>  
>  	return ret;
