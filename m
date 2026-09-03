Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A283B3C0E;
	Thu,  3 Sep 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461220; cv=none; b=X216jm8R2xk37i4n1LJ1YC1lV6pOtPErNu0MOSuW3280zIw5JHv4G6PJMar3bn3DlExwRXGD7LOUDlHeG5hns/xSoWhytTC0D8XnVDQ2WzUta1x1TJGF3O7hH4kYp41Gh7fvzSrEenoGqELEu0x0PwXk89BKY72XFI+Hq/4AUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461220; c=relaxed/simple;
	bh=AAOBbTX//dnshYHVuCrRy4d3uSMcIR6W5SJrVT1ox6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCP91qtO7gNr3aOUtFAs97Ayi9mIdRGWZCkdUsO5EcWqXICwPLPUE6kTllpOBSr1vWUChTR442ZvtRNelfjvLzc3OEJi3DxtUhdkSQpOgi+yUt7z1RZ4Sjj/IcXSF5kFRvAewiE3Ut85mxai7yhCj1gu885SPI8fZf7q6gDdDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GWoHdprR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GWoHdprR"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72A4D20B712B;
	Thu,  3 Sep 2026 11:46:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72A4D20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788461172;
	bh=9417ftu6LLY+NWWmPrsJiSQmjQu6hJFyUo3Wc4rbzQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWoHdprR5u3g4iaUJw+ld4P0JfeaC8Zb35w8iS2kUbDkaZLOIqjnNUGhg/ccvjyZY
	 mmtysBBIBD9xgJhoDgH5h8Z3gWvBzY61WsCRVuofFgYyI0XOB491W7t/B1v6jREMjn
	 iCIC9tR1wosLiHfhUmIryXgNj0z5VXRKmXlv69Es=
Date: Thu, 3 Sep 2026 11:46:47 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Wei Liu <wei.liu@kernel.org>, Mukesh R <mrathor@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>, hpa@zytor.com, robin.murphy@arm.com,
 robh@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
 namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for
 VFIO to build upon
Message-ID: <20260903114647.00005a1f@linux.microsoft.com>
In-Reply-To: <20260903174014.GM4157646@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
	<20260731223427.2554388-4-mrathor@linux.microsoft.com>
	<20260902111905.000079d4@linux.microsoft.com>
	<20260903144236.GK4157646@nvidia.com>
	<20260903161328.GA3102631@liuwe-devbox-debian-v2.local>
	<20260903174014.GM4157646@nvidia.com>
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

Hi Jason,

On Thu, 3 Sep 2026 14:40:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 09:13:28AM -0700, Wei Liu wrote:
> > > Does mshv use KVM at all? Can a kvm fd describe the partition?  
> > 
> > No. MSHV doesn't use KVM. We don't have a kvm fd. We have an mshv
> > fd to describe the partition. They are different virtualization
> > solutions.
> > 
> > In the ideal world, the fd should be hypervisor agnostic, not tied
> > to kvm.  
> 
> There is a patch generalizing vfio to work on FDs instead of KVM
> structures:
> 
>  https://patch.msgid.link/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com 
> 
> That's probably a good step long that line.
Yeah, ideally, it would be removing/rename device/group->kvm to
something like group/device->vm_file?

