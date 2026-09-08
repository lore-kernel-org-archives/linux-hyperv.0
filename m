Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EF53CA61
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904171; cv=none; b=EtKX5Je50duERS6mZ7wHRkDjK+S+LpRt7f5LcaxFpTHrOJMdt2qTPB0xDYKCCub6Z+/G5HQforESyrD7LxvEDd6qipWBvKXrHUrOuA+5coYA2GCWXbD136gFNCMbdnl7UHvux7PJRGMwFSYO5CzJjpy03erS84pbp8rewiUudqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904171; c=relaxed/simple;
	bh=Qf+HHgW6N1rc8pmh0i0ZOaW28blx/IGYkT4fwrh0Wus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JXYK5kCvX22Gjr7I35lktf0qcCHrnhwc05t26aeAYpYqETYrvseKy3bSLTAV0JaqMpbQGtkDvxXfigzoM7YJXy2qCpcS1k0vUJNPUuee52LMMSrui42qjrdHsBmdYcjH0IeyRP0e3qDZIR73Bl5jKZvT70GDqtdP4EUuRqV7rbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2mzIFus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2mzIFus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135441F00A3D;
	Tue,  8 Sep 2026 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904170;
	bh=Mz81pL0fjQMpoyroveCohGWZzQX2T1aLOiuBFpckM2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2mzIFusRFzS3bJspMdq0tlf4aSnJLCBIDK8DTFb4V182VK4xImUG6IGruv5Cpd22
	 le8ki4vy4+F/yPT1wLj9Iz8hruJo2qkSM7rIdl9tkaKnXxKpqW40ga+EVRliw0M33Y
	 qh/mX3bjCyHPAj7FLXzqXRbfWoib8dnGiiQiQcHgh1t6zWCOOUPWVVvsnRX+AspLMN
	 T3vvBzf9CZgzRzxYyvShpqDr8dFoEzaAmFX861RqDGMbZKsQ5cy69kwAsiTBAZXeu1
	 FkJ0hhMAyZPBsl9uinB0y8/7xESMDbAMnej0H38XoOM2Zvch683uTc/QFag+m2FlkS
	 sytBDU1eXFKtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Fix error paths in
 vmbus_teardown_gpadl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260907214902.9046-2-mhklinux@outlook.com>
References: <20260907214902.9046-1-mhklinux@outlook.com>
 <20260907214902.9046-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:49:29 +0000
Message-Id: <20260908214930.135441F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing update to `gpadl->decrypted` on the `kzalloc` error path i=
n `vmbus_teardown_gpadl()` bypasses the memory leak mechanism, leading to g=
uest memory corruption.
--

commit 06cfb23325c5ac07c00c74d8250a4bd0f20ac4f0
Author: Michael Kelley <mhkelley58@gmail.com>

    Drivers: hv: vmbus: Fix error paths in vmbus_teardown_gpadl()
   =20
    In vmbus_teardown_gpadl(), the return value from vmbus_post_msg() is
    overwritten by the logic that decides if set_memory_encrypted() should
    run. A failure from vmbus_post_msg() is lost and vmbus_teardown_gpadl()
    may incorrectly report success. Furthermore, if vmbus_post_msg() fails,
    the GPADL remains active on the Hyper-V side, yet in a CoCo VM the
    buffer will be re-encrypted anyway.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260904160724.82AB51F00A3D@sm=
tp.kernel.org/
Fixes: d4dccf353db8 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to=
 host in Isolation VM")

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f4370617deacb..cc86e8505ad0b 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1059,14 +1059,14 @@ int vmbus_teardown_gpadl(struct vmbus_channel *ch=
annel, struct vmbus_gpadl *gpad
> =20
>  	kfree(info);
> =20
> -	if (gpadl->decrypted)
> +	if (!ret && gpadl->decrypted) {
>  		ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
>  					PFN_UP(gpadl->size));
> -	else
> -		ret =3D 0;
> -	if (ret)
> -		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret=
);
> +		if (ret)
> +			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", re=
t);
> +	}
> =20
> +	/* If error in ret, mark buffer decrypted so it is leaked */
>  	gpadl->decrypted =3D ret;

[Severity: High]
This is a pre-existing issue, but does this early return in
vmbus_teardown_gpadl() bypass the leak mechanism?

drivers/hv/channel.c:vmbus_teardown_gpadl() {
	...
	info =3D kzalloc(sizeof(*info) +
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

> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907214902.9046=
-1-mhklinux@outlook.com?part=3D1
