Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E33B5850;
	Fri, 17 Apr 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449996; cv=none; b=SOK79N4i8zvk84SWF52JAUCavQS/l7Rzg2Vt1JgTk91PZMyywNBNLdRVGazZal9XBWUP+RWZfG1AcQ7acES0owgRY95JQvQ4Ned1viD5LPM6epQ7ExWMu+OWbOOTK2rVh/BzkSw2FOEhR0kBL7ql1JkEY/vaTaQS9YVkDbln2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449996; c=relaxed/simple;
	bh=R12IDCIXkdZNXxjNCe8brPVjwHzFherskLs8R4dflXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr++Ox5QXSwbpB7Zlxjm0rdbpoY35iMnVovlL+jUZ83gO50uYpRDB34m5kcjqWTnzK1thswjIUqAXSG6fFcOM5nvx0YXw8VIeMcpGCtpASXbYf2ekYdrAhgqRz5cJPEr1ME4e0dtEk3mPPYmG+p0DPZ57IT3RC7+sU2wJekIbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XiUW6PfN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XiUW6PfN"
Received: from [100.64.217.73] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B43C520B7128;
	Fri, 17 Apr 2026 11:19:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B43C520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776449989;
	bh=ZoMFv+0gVyZ0RDus1DOUZjij1UXc723wF7Hg48l76WY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiUW6PfNclY3pUdKUMgy2O1e32rHEv47F4idLSAzn771ccErMtdYPnx2xQb7+eyg+
	 ZzwtSV7KiTCMnc5BiIxaGka6u0xdDI8wgq3ADzCmCjuLUzH3JJIhpaDcemCHsw8S5/
	 AGGzVI5JsOe5czDkN7mOepoos+1BBOBeZiGQvP0k=
Message-ID: <075ca01b-cd3e-45bf-b6f3-e6d3d6865021@linux.microsoft.com>
Date: Fri, 17 Apr 2026 11:19:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
To: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhklinux@outlook.com, matthew.ruffell@canonical.com,
 johansen@templeofstupid.com
Cc: stable@vger.kernel.org
References: <20260416183529.838321-1-decui@microsoft.com>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20260416183529.838321-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/2026 11:35 AM, Dexuan Cui wrote:
> If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
> framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
> there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.
> This is especially an issue if pci-hyperv is built-in and hyperv_drm is
> built as a module. Consequently, the kdump kernel fails to detect PCI
> devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk.
> 
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
> back to the low MMIO base, which should be equal to the framebuffer
> MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Windows
> Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
> is not 0; if the user specifies a high resolution, it's not enough to
> only reserve 8MB: in this case, reserve half of the space below 4GB, but
> cap the reservation to 128MB, which is the required framebuffer size of
> the highest resolution 7680*4320 supported by Hyper-V.
> 
> Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
> VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
> device, so there is no need to reserve any MMIO for it.
> 
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF).
> 
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik
