Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF722576E
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885165; cv=none; b=FyYevFr2zygwWjslcdlLSyK4rc9NFJITsVKBoUVevFdGqPJAJ27ALALcF/i3WPe6w2Y6S0fNIBYLzzFyh9SSsKP1Nc4z+izwohtFyjKhIAkGg7nFMDirUt3376cqHg2KH6okFyjgkHquLh+Wgf9O1QX04VOSgbUkvkivCCUcgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885165; c=relaxed/simple;
	bh=iAWlj3tAEJSjTOchAHXvSDLPftb3HhaeZhYy1hIR2f8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNHk9v2a1/4EDN7GItDgtbwvBrA/t6Uv9i7kv3QniQWBBGpPigSbTkiFP+tNoTl72Ju8tI26v3uKyOFpBl6BAM4V8ir8mbvr2wbl4rxaQ4fGciOHdBtt9VLA/FQAiQhtnoZfmO2oa+RqNXRxsdes5DIcQ0OJVVlsXBapGnLgf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2BAW63g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2BAW63g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6131F00893;
	Mon,  8 Jun 2026 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780885163;
	bh=sYBqh5xh9SSvJlztkgNldoUX6wWXeA7U0Te7ZBpf/Pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2BAW63gYP2pTeLBHU4XmqZZBdF2LaDtCOM2Vcyd5wRDtpWogpeGNKWRhYx0DVuSw
	 oIlHfCosoUjwqSfwKHTHJSE6XHk42TgZLvl3MbD4oEtg8jjbSGZ12+Eb1yVvzna1Ng
	 2osJnmRlWSOrZq77pr+HaK/bwMMd+NCVkRhg4guy5Pl6pglHXczIX+vAMqmYNfRRY+
	 svi6rF2ccJuLDBcdU/+S/wbZH1GBc3/Pn0Pnsflq5nsFYjQag7kg1Z4GRt+yUHs/AE
	 4KSSsKiqb6Zmb8J7T/GyLSy0uDp+g+9KdeRVZMH0kWL0LRQ6Wlsh2W2KRL59cIY7uI
	 uHW6HKILGLovg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhklkml@zohomail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260608020616.52852-1-mhklkml@zohomail.com>
References: <20260608020616.52852-1-mhklkml@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 02:19:23 +0000
Message-Id: <20260608021923.9D6131F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If device_register() fails in vmbus_device_register(), the error h=
andling path panics the kernel due to a BUG_ON, and would result in a doubl=
e free if the panic were bypassed.
--

commit 575a138c8a50043a8fa9993f9a0f7b0f34865b8a
Author: Michael Kelley <mhklinux@outlook.com>
Drivers: hv: vmbus: Set DMA coherent mask for VMBus devices

This commit fixes DMA allocation failures for VMBus devices in CoCo VMs.
It ensures the coherent_dma_mask is set to 64 bits at the same time the
dma_mask is configured during vmbus_device_register().

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 23206640c6139..a6b9a33db6578 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2169,6 +2169,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
>  	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	dma_set_coherent_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> =20
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device

[Severity: High]
This is a pre-existing issue, but does the error handling path for
device_register() further down in this function cause a kernel panic?

If device_register() fails, the code calls put_device():

vmbus_device_register() {
    ...
    ret =3D device_register(&child_device_obj->device);
    if (ret) {
        pr_err("Unable to register child device\n");
        put_device(&child_device_obj->device);
        return ret;
    }
    ...
}

This triggers the release callback vmbus_device_release(), which
unconditionally invokes hv_process_channel_removal(). However,
hv_process_channel_removal() begins with:

    BUG_ON(!channel->rescind);

Since channel->rescind is false during initial channel offer processing,
would this BUG_ON fire and crash the kernel?

Additionally, if the BUG_ON were bypassed, hv_process_channel_removal()
calls free_channel(channel). The error then propagates up to
vmbus_add_channel_work(), which takes the err_deq_chan label and calls
free_channel(newchannel) again. Does this sequence result in a double free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608020616.5285=
2-1-mhklkml@zohomail.com?part=3D1
