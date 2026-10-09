Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826A36C5A1;
	Fri,  9 Oct 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560879; cv=none; b=cmj3ZcoCHtkJDRqTbo9nRHTfl6JhSPEcY4MHDs84eNA2gx9qaJ8sYJL2VcJvPBuVAKkFuH6YxCkrerLZGfWbR6tdfmvZb5GsUuPWWG0QB9SJ+860FYyGD0rDwHfMWipkndkxBlnmqZvLpoQpq+miLvSdaksk80YVVA0NLUdz7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560879; c=relaxed/simple;
	bh=IFMQ+u51Rk7htIC//8wBPBXvcURe0di0vPUYlALblv0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YTCd5bYDCmPIfyGVlR1oyt3dh28XJov85tElvOkxM7N51jcTu3Y3QcpW/rBM7y5uxWdbq04zFMK5GePrKNdTV72EqD/f73rChf5+mRyj6yJ/TGDKD/u3NVe2BdxrdvS6q6PPzrdN3Ee2yIyguq1M+xfnr3qD0Gg6gIIfNrZSl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8buVSBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8buVSBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41DA1F000FF;
	Fri,  9 Oct 2026 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560878;
	bh=P6Mjv2pFfnBLtfAaN+MLjCgGgaO5xnMpkdjPy0c/dbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8buVSBS60RZr0hfKKAwZw3Cq9Q/RyuunypGcHgVIBdpoITusOs4D1PfNdgr+9cJu
	 9Nx8Eyu79G5+SQXJwU3jMsHKK1n3CwYBjqbuKE8+hHk1Tmm/4bQCZqmy6NR+TrBgpG
	 RTbRwVvSoqPqw/jzw24jEwrjBrc3QiIIYrKOsHQYnP0u315ou8OqFh6Cg1WaaS0wV/
	 l2L0j21U4TXgkgHMdzwMaqaI3FSkoYVsHB5kRi84W7lPJ0L4P18A0qy7qlwx5LiZWm
	 Cyto00n/iWJaK1AA/2xVHE8qtZGEHgsiZFvAyBmW3INu02/sF1sXFyZHalklVjKh7C
	 lSKIfBLPr8jcQ==
Message-ID: <sashiko-outbox-165797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel
 hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261009154034.82321-3-pavel.e.popov@intel.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:47:57 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/p2pdma: numerical x86_vfm comparison matches older unsupported=
 CPUs
--

commit 8df450ad902e18b3a50517392110d5d4750ef685
Author: Pavel Popov <pavel.e.popov@intel.com>

PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts

Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
Hyper-V guests, each passthrough device appears in a PCI domain of its
own without a host bridge device. Consequently, P2PDMA checks evaluate
endpoint Device IDs against the host bridge whitelist, causing P2PDMA
requests to fail regardless of host support.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index d96f44d0738a8..76fadfbc1814a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -544,7 +544,8 @@ static bool hypervisor_supports_p2pdma(void)
>  	/* Hypervisor hides host topology, allow p2pdma on Skylake and newer */
>  	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
>  	    boot_cpu_data.x86_vfm >=3D INTEL_SKYLAKE_X &&

[Severity: High]
Does this numerical comparison correctly filter out older, unsupported CPUs?

Since x86_vfm encodes the model number in the lower bits, older architectur=
es
like Broadwell-D (model 0x56) or Atom Goldmont (model 0x5C) evaluate to bei=
ng
numerically greater than INTEL_SKYLAKE_X (model 0x55).

Because Broadwell-generation CPUs do not support cross-host-bridge P2PDMA,
bypassing the check in the guest will allow transactions the host physical
hardware cannot route, which can result in PCIe Unsupported Requests and
potentially lead to AER panics or device aborts.

Is there a better way to check for supported architectures rather than a
strict numeric comparison of the VFM?

> -	    hypervisor_is_type(X86_HYPER_VMWARE))
> +	    (hypervisor_is_type(X86_HYPER_VMWARE) ||
> +	     hypervisor_is_type(X86_HYPER_MS_HYPERV)))
>  		return true;
>  #endif
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009154034.8232=
1-1-pavel.e.popov@intel.com?part=3D2
