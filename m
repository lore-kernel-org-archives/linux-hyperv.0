Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A124D9901;
	Thu,  3 Sep 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452011; cv=none; b=thV+InD0nkgrRKOsEK4+0hWjk4E2+a5z9NHeB8fpU9TMCnCTz1yx2PZMwyMJd85V55FEU+C5CAsmzGmND+huHfXFG/yNvaXpX5gRs40AIIJmOYMlxQqXGYb3WaOUY3lP6ETiXEErpXOI8o1h0MwSwciEGtPveMd/h3BOxMhhDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452011; c=relaxed/simple;
	bh=PB7Iq2ssFKLaMqNGOCeNlDG2sDFWCM0kB5FjcfQ5eAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qngccmUXkCYxv24VjZ7QDdzQeNc54bWloJiaxIroPq3LmADRCfR0ICjGBag8gvaxLVgqy0Oozir9P2lT0VNXrXziYt+Zn9kLKYGp9Y4tekO9LB11CKTSm+4Xu1fm584IiHkpigS+ZOGxOW6nHQuw0C+IU1bIw6ebAib+CzEVvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKBqdlKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKBqdlKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D41F000E9;
	Thu,  3 Sep 2026 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452010;
	bh=0AqKXgC/ir//xnyE9Qd0oIkiDK0g4G75mrBEzb+49oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cKBqdlKQNG+MgIqyCdTWZkCc552pzvkklw9sYz13LkySjin8cHqvOu/azYYZfjaOq
	 zqjcnetKLSBKYNJ+HRDJpwmSdW9xjtp264kd0LYTg86Vz0vnNz+OZ+l/cfcGL9GyN8
	 jQPPQdDpf/rCXDgXbNPJEggRtFDCGM0BkDwAGR249XYPoYNLy/v2TISkXfoyUDxtq5
	 DDDioPXlFCI1c2VcAyZ4vSm4bxCI6CIebJyDc6v0weNe6252CQkk/1IvtUg4sFYiFs
	 ouUuMKCkY90wvG+1oBcTiRdGWZS/JACKtXYCN1WWLciYf9cO2pD11zYYR6Y9Oa7K74
	 2CginSW6x86UA==
Date: Thu, 3 Sep 2026 09:13:28 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Mukesh R <mrathor@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for VFIO
 to build upon
Message-ID: <20260903161328.GA3102631@liuwe-devbox-debian-v2.local>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-4-mrathor@linux.microsoft.com>
 <20260902111905.000079d4@linux.microsoft.com>
 <20260903144236.GK4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903144236.GK4157646@nvidia.com>

On Thu, Sep 03, 2026 at 11:42:36AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 11:19:05AM -0700, Jacob Pan wrote:
> 
> > If we do want to support this kvm-vfio bridge semantics beyond kvm,
> > maybe this should be abstracted as a generic VFIO "hypervisor
> > partition" association, with hypervisor-specific get/put callbacks,
> > rather than adding an MSHV-only copy of the KVM hook.
> > +Alex
> 
> I don't like this patch at all.
> 
> I think we should try to harmonize all these sort of "external" cases
> as best we can. mshv, confidential compute, xen, etc all have a very
> similar shape.
> 
> I am discussing here with Aneesh an approach to use the viommu almost
> exclusively for this.
> 
> https://lore.kernel.org/all/20260902235609.GG2890729@ziepe.ca/
> 
> Can you imagine a way to do that for your stuff?
> 
> In that case I imagine the iommufd vdevice create is what attaches the
> vfio device to the partition, not a seperate ioctl over in some other
> driver. When the viommu is created it knows what partition it is
> affiliated with because it took in a FD that describes that partition.
> 
> Does mshv use KVM at all? Can a kvm fd describe the partition?

No. MSHV doesn't use KVM. We don't have a kvm fd. We have an mshv fd to
describe the partition. They are different virtualization solutions.

In the ideal world, the fd should be hypervisor agnostic, not tied to
kvm.

Wei

> 
> Jason
