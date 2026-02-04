Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D27361DDF;
	Wed,  4 Feb 2026 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184937; cv=none; b=ujlAAiVyLg/ushCeiuXDPAXq93KObgPZQFdj/7JLQ7In0/ynFiK19MBjduFyhBtGm2XxrhQeRVMOTn0lufFoPi4PaI7iutNwz4iYJQsyzDKdi9J4NaThaTw1GVYdmnzCzX9MMwyVzcI17RvAqtiPcwpTPCRtLKfv6yifuOyyH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184937; c=relaxed/simple;
	bh=xRXMA/dDbdrJX3BOcLGYpGpKjEdBlU3OgbLJdZwIERQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V97OJupcqSNrkc9wmCFK7hT9BY77Tgl4fG1ynQnn5/FtQ3x6tQY5bj1z7B3xXSrE93y0qsodpM0ZUyjz/RG4l22+FoYr9NNVEKEG/I+i+lgj1+KBkumF7YVINNoKAFx/7w3VhsAOQGCb65RnGnZYqDjfZwvszNlNsgjuWXKpkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwV3onC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwV3onC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96398C4CEF7;
	Wed,  4 Feb 2026 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770184936;
	bh=xRXMA/dDbdrJX3BOcLGYpGpKjEdBlU3OgbLJdZwIERQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwV3onC0nhBoKL2RjKnCnjflornaH3TLeEbrbLHWboIQFoS3E+kw99G60f8+3vbLH
	 helaHdfOFdYhY/r+oXmjEpBwihpAJReqITdcU9k0Wfdsz4s+4aQOTuWBcWG1SYrPg7
	 QuQG/6y+1hMRatXqzwYOi1pLDpVurfTBeiXBddvfCeiA8sXqIS0Hb+rKEwQ7LPLL4v
	 PpYOFILtDdRE2YdcjJoh003fBx3BzEHah6EMAH56+Vff4z0JiKe1QaA5Ik2PPaBiQa
	 nbWZj9mbSLjLteiHbKLFW37ZGc3yCCjV6dgZ6yOvHKSxeUa1joUKoI7LOZd8memrlJ
	 EEiK07ms3saCQ==
Date: Wed, 4 Feb 2026 06:02:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Message-ID: <20260204060215.GA79272@liuwe-devbox-debian-v2.local>
References: <20260111170034.67558-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>

On Sun, Jan 11, 2026 at 09:00:34AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

It looks like this trivial patch is not yet picked up. I've queued it
up.

Thanks,
Wei

> ---
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1e237d3538f9..7fcba05cec30 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -501,7 +501,6 @@ struct hv_pcibus_device {
>  	struct resource *low_mmio_res;
>  	struct resource *high_mmio_res;
>  	struct completion *survey_event;
> -	struct pci_bus *pci_bus;
>  	spinlock_t config_lock;	/* Avoid two threads writing index page */
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
> -- 
> 2.25.1
> 
