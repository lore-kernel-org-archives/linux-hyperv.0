Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A642B307;
	Mon,  6 Jul 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356917; cv=none; b=TrGKFLji3HBM+QCvO2CenBTurRLXtrCOXP0214ywtPCjzGceoae/inyiPw9Rd9C5u0X7MNfs+unJaD0TXU/4LfIzGccGnNUq08eKDvEsXOHOpR+iA38NALtvcSngKanGxvs5I3RrjmNhDJwOdntNIGz+GRL9yLnYjodExF3q7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356917; c=relaxed/simple;
	bh=V27uU26z+OREAxOjfC3mYvFlmRfHErKF0t40vNkBFcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts0nudDRhtKpdxZ0IkswkpFS+j+XqiEsgUsd5TXHMdzEjvhIXITOTMFxJ/Us4l+hLVYhZPEkr8ksFlDxlktNQlB9BUATZrY19jVM4wdIk267ApLkkNub7IfMmXSghPhBpkF3521gu/OwyTE1fMQ3mrfe6j82DlQXGdpsCyss5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e6MVuqKk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e6MVuqKk"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E0BF20B716A;
	Mon,  6 Jul 2026 09:55:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E0BF20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783356912;
	bh=HoZoevdHv2yQT0DlpD5qpPEyASfbpumwXGMTTLcX+qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6MVuqKkQaSr4NlvXcDV/ZTz4kzbCtf9HiZ4CcO444sIzlXx9W6tm9/IqySvh72+U
	 8gaf3+8hXJUUgIBBNsB+k/sjKVpgqoXacPtkkq5DqYTj1WwU/IUu+3RKyL3FradD3Z
	 lo/CunsxQln6iyAgEt++juRrk+vNQQV/XVE57oCg=
Date: Mon, 6 Jul 2026 09:55:10 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
 mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca,
 mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260706095510.00007ce1@linux.microsoft.com>
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
	<20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yu,

On Fri,  3 Jul 2026 00:05:17 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct
> device *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =
> to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	if (vdev->hv_domain == hv_domain)
> +		return 0;
> +
Is this needed? seems the core code already skips same domain attach?
i.e.

static int __iommu_group_set_domain_internal(struct iommu_group *group,
					     struct iommu_domain
*new_domain, unsigned int flags)
{
...
	if (group->domain == new_domain)
		return 0;
