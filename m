Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A26336882;
	Fri,  1 May 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653226; cv=none; b=BoqdoPG/yc3rrJLbvjXclya7mp2sjq5DvYXJM/why7NTeVvOvDYhhazOdeSEWZRyBySxAhw5r/3HeuqBqfb0dC7DG+wGxcdN/67Dvpy2l+I7xmFoxoeiMh2Z2MoRcbMMGFMmJbPQL0t8MVrnvgrSJkor0BH4D93SDR29aNvYtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653226; c=relaxed/simple;
	bh=3O1QVwDiOLSGfUBRkjv89WIn5Hcjyxyt4wh34cUNTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p3Yl68WeBDZyJe/mWQl52tx5oky+ROLZECPG8Ojux2KxtZ82zwqICf6XHR20O5oK87zPRs0AMDbJOlrwJ2nIMar+ThvWV/bPy/MxpHKjT8ypbWsRZWG+Cd512YDbgsfLy7cnfaFSIOsxZfxvNIZ14PZhS66VOM3x8bXYG2BWwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkx5fNIy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkx5fNIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A64C2BCB4;
	Fri,  1 May 2026 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777653225;
	bh=3O1QVwDiOLSGfUBRkjv89WIn5Hcjyxyt4wh34cUNTUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Mkx5fNIyKX7HH5JMuSLg4Ny6gVSImsQGIG9W4ltE752iZQh3M9THdUFcrMxvoBY7F
	 qbx96f/sX8Z1tzlW/G3Em6i7RkvtnZkX3qxNOBMIrtQ3QKvfd0Atd3NE4ebkY4RLGR
	 xBMKHqLWHjEXFBg3bV78Ebz9igbwGFC3CTn22AziXAa/fmJV1yRn5soX2dyIaZxus5
	 ThLrqf3IKEnknzMxTgWUYEeZEcri+dsZV4TxmFT2mciISceWJPdTzP+WuHXLlDABgm
	 tTw+gmxy3rUXScWQ8OJnxEqj7skABPXSlZVwN65ibUEYBWWSU7zlabmgiEbYnvL72q
	 rn7rgSJRHxQHQ==
Date: Fri, 1 May 2026 11:33:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V2 08/11] PCI: hv: Build device id for a VMBus device,
 export PCI devid function
Message-ID: <20260501163343.GA489081@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501004157.3108202-9-mrathor@linux.microsoft.com>

s/id/ID/ in subject.

I don't know if the "export PCI devid function" part is essential in
the subject.  If it is, I don't know whether that refers to
hv_build_devid_type_pci() of hv_pci_vmbus_device_id().  Both are
exported by this patch.  Could just mention the actual name instead of
"PCI devid function" or could make the exports a separate patch.

On Thu, Apr 30, 2026 at 05:41:54PM -0700, Mukesh R wrote:
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device ID as a parameter. This device ID refers
> to that specific device during the lifetime of passthru.

> +++ b/include/asm-generic/mshyperv.h
> @@ -23,6 +23,7 @@
>  #include <acpi/acpi_numa.h>
>  #include <linux/cpumask.h>
>  #include <linux/nmi.h>
> +#include <linux/pci.h>


It doesn't look like mshyperv.h actually needs the definition, so you
probably don't need to include pci.h.  A "struct pci_dev;" declaration
should be sufficient.  

>  #include <asm/ptrace.h>
>  #include <hyperv/hvhdk.h>
>  
> @@ -329,6 +330,13 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>  
> +#if IS_ENABLED(CONFIG_PCI_HYPERV)
> +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
> +#else
> +static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> +{ return 0; }
> +#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */
> +
>  #if IS_ENABLED(CONFIG_MSHV_ROOT)
>  static inline bool hv_root_partition(void)
>  {
> -- 
> 2.51.2.vfs.0.1
> 
