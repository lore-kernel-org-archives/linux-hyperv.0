Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899F3A759D;
	Sun, 11 Oct 2026 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697627; cv=none; b=mhLsCAHp4tm8Ai0vK+kX2zk55+ABolErsmjMyL8N5qru+M62cRvRDf868qBMrKevYFkAnLxg45J26k0/zFRrROIA62ugUF4fKwG5jfHRVV6vDJ+aogKAtT+eoIA3IdwphdJCCSCw65jEtotls16i9CkwMi4lP5uHIJYCY4HsaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697627; c=relaxed/simple;
	bh=3VNnIGVBv9EL0BAqLp7Vak8V4WA/96/zgoDpeAl9MhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIjQBPjRjsDA6lIuw9kLi15CacmDd0Bd+d4upY7rcvsV0Wv2mm9OclbEv/r9X89y47+a5URg5WYSJfX7jYh9cvWcXHjPDEFxk50ktFaPQfMCHKeKGg+QRTj1J57hHN7MXcd9tpSmKBOMk3PCWyM58VAdsHaJtshueW68ICKKhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktbtfv6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktbtfv6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4141F0089B;
	Sun, 11 Oct 2026 05:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791697625;
	bh=V26Y85Vt2vGB2apj7LD4RMbjX6GtqdMPTO8AtJrxgxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ktbtfv6TUq5tx7CgLuP550bk8DrnLJRr0QNnhGWxbJEUPy3STpWo71Ce1u0DEW6bu
	 asV3ptTx4SWo+afU+TN/wUIRni+1g38rNtNZkLOKWNg/sXjb/4caDeFDMSpe3ggflW
	 Qw2OesF5eRno/VVJ52Yiv0IeR6klp/mBC/5BAnQo5KqMM0R2V9l3Nss7gv/5OzfdnE
	 zqxic6xSIgMQgkzTBhi/ymM0/9/qLr0uwXhjoWhlvF7SpBhVQZ99Jo7T5Kg6aompXw
	 MW7mC2xvb8+H9kcoy8OcKnrhmV+HTHqlzEMmanf9p29/eU1LbpYakmeUrBXLNOI4Yr
	 9M5WpWt94CjlQ==
Date: Sun, 11 Oct 2026 08:47:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Popov, Pavel E" <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jim Chow <jim.chow@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Message-ID: <20261011054700.GF11438@unreal>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas>
 <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>

On Fri, Oct 09, 2026 at 07:13:31PM +0000, Popov, Pavel E wrote:
> Leon,
> 
> Understood on all points, and I agree HMAT is the proper fix. We discussed
> it with Lukas Wunner as well. Exposing HMAT is on the hypervisor side; Jim
> Chow from VMware can speak to their plans. Even once HMAT lands in Linux,
> it only helps guests after the hypervisors add support for it.
> 
> The key point for us is that today there is no path at all for
> passthrough devices on VMware or Hyper-V, and that is what this patch
> addresses. We reviewed it with VMware and aligned on this approach for the
> guest in the meantime.

This does not change the fact that the patch causes unpredictable behavior for
P2P devices in the guest. Sometimes it works; other times, devices that
previously worked may be classified as P2P-capable and will stop.

> 
> Is there anything you would recommend to make the series acceptable as an
> interim?

Help Lukas and Mahesh succeed in their work.

Thanks
