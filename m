Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2325B0AA;
	Mon, 13 Jul 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959209; cv=none; b=ApyZ1Zuz6Aj07gAnHKfXBV1T7eyRbDPRAGjpPO5ya7VeUJ0BJ8+S83dWtzUv0gUoeOQpFrYLZk1x79/2KnLrsnVQ2oVLzqYBku/1fKhgYA0laYuT9NnWSP0dmu5Upla+ogf65Q5L43IBRffyRD2zYx5C8pVCoTqyLzq+9ewJ6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959209; c=relaxed/simple;
	bh=87+DyGXvAKm5IXJiKbRVm11dCASshYHur0HdtyBZK18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoGrscXX/fTdHG+F1G+arMORYtBuvBoBHuNOGXYjJiqQ15ye7RGf4PUnxT9xiT/21nphXYm1FwXm+zujMdz1C2jQ3B1fC5MaAPZmmsLH3hEUR8dbZYVX8jp51MGhairHiFJzb7sUzt7Azq1DkI83zAKXTyp3C3nRotrStAvwkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XZeBtsqO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XZeBtsqO"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEA4520B716F;
	Mon, 13 Jul 2026 09:13:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEA4520B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783959199;
	bh=eeKOrgOt+xXm+V5IRef1lDOmRNhHqtuxeaF/QYex0Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZeBtsqOdJFY4BYYsLd+wm1yi+LZ8NbE8VsdAstHLGM5iSE3p7geCt0pHWkLfZOXI
	 DMBuxTymJLCT1F5m8zAUPQOJ5YsfC1h79HtjvhjMM7+Kf0Lwx9KCdlWDfKJW/W8voN
	 HSbtdm71FNrpf0fRvLi11OcwBg0H17iZziutadVw=
Date: Mon, 13 Jul 2026 09:13:28 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
 <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
 <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
 <mrathor@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260713091328.00004fc9@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
	<20260702160518.311234-4-zhangyu1@linux.microsoft.com>
	<SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
	<SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
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

Hi Michael,

On Sat, 11 Jul 2026 18:31:15 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> One new thought:  Have you considered the hibernate/resume
> cycle? Does anything need to be done with the pvIOMMU to
> make it functional again after resume? I see that the Intel and
> AMD IOMMU drivers have suspend and resume functions. I
> don't know enough about the Hyper-V pvIOMMU to know if it
> might also need suspend and resume functions.

I don't think the Hyper-V pvIOMMU guest driver needs the same kind of
suspend/resume handling as a hardware IOMMU driver. Unlike VT-d or AMD
IOMMU, the guest driver does not own physical IOMMU registers, root
tables, command queues, or translation enable state that must be saved
and reprogrammed on resume.

For nested translation, the guest does own the stage-1 I/O page tables,
but those are normal guest memory. They survive S3 as system RAM. The
guest driver still needs to issue the normal pvIOMMU invalidations when
it changes S1 mappings, but suspend/resume by itself does not modify
the S1 page tables and should not require a special flush.

The important contract is on the Hyper-V side: Hyper-V owns translation
enable/disable and must prevent device DMA while translation state is
not valid.

Thanks,

Jacob
