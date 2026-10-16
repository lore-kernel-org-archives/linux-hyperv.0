Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158C48DB37;
	Fri, 16 Oct 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176875; cv=none; b=LJM4QfxH3+txRJRXTpfPF6i9vvzsMjIb2+ZCvMNyt1MgfEUmEpIl/2p4tBFMSRzZ9iO/gViddL0npZBieO+LijVgDW/lg/Uo/7OwQrblZCELCiYlbqQebbeSgi7ZPDnoyfhw4j04qxYtCK0srOTHZaTb6fgfg17c2qKJLsuX+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176875; c=relaxed/simple;
	bh=ciyEfyhA6spBQY6ZMuVToaA676XbfoSfWUx5vMgli0Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=MGF9SkXjJnr4DwB6ZwAuXiFgmBLpf95ZY7ngtZQyyKQjdn/0GZeQOt0eCyVWQ3jFFmrDS3jLDoiRrtzhGNamwC56SoWE51HQqheJaActlkt/5xRwFwOblygJvzQi90M8Mk7JDWF1X0DSfBV4y/L53Cohtb0MAneWDg9uF9TeTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=o7PeBeyR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="o7PeBeyR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=wBOZAxky3H4/ko7byjZlChAKL7qFnViXPqU4ciUaKoU=; b=o7PeBeyROM7/RNFkgjwNE3lmdU
	A5UAFpk3OKnyyauc2duZWpWlqltbOoDCziJoxUqj62NeoYF07ko7QHzGtqh/QWzBXRg1wj5bopJlW
	u7C7ssTwd2Qf40RAG8lWvmUzxpcL3OypdQTUEd3ZFE6essGFMlyhqrTQiV5XIXNvmGwmFiA+GguHe
	HQMDBfISnX/kWgm7DzMVQQuFiQ1nikXFJiciVsKEmzYpoxsOB3jegcwavvym9ITjLPPaU77bUdmu+
	sPUTFZ7y2XIRTiEIYp5CfiwcZ3En3pny89ZRhuC3K3PYt/3KnVRZaqBdYwRAdM3NbwsXB+ekZsXPr
	5v4wg7WQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xHmVn-00000007n8U-3SSW;
	Fri, 16 Oct 2026 12:18:37 -0600
Message-ID: <006effed-576f-4aed-b3ac-c335d8d51106@deltatee.com>
Date: Fri, 16 Oct 2026 12:18:20 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Popov, Pavel E" <pavel.e.popov@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jim Chow <jim.chow@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
 <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261016153147.GC219304@unreal>
 <LV2PR11MB6070D328D5E6A538DB6370B2B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <LV2PR11MB6070D328D5E6A538DB6370B2B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, helgaas@kernel.org, leon@kernel.org, jim.chow@broadcom.com, bhelgaas@google.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, lukas@wunner.de, rafael@kernel.org, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests
 on Intel hosts
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-16 10:05, Popov, Pavel E wrote:
> Bjorn, Logan,
> 
> Leon's position is clear: "NAK to anything that does not fix the
> hypervisor first". No concrete failure was described, and no change in
> this series can address it. That leaves the decision with you. Two
> facts: AMD guests get P2PDMA today and Intel guests do not, and HMAT
> does not exist in Linux yet.

Yikes, ok, I've followed some of that long discussion.

My first thought was this didn't seem as big an issue as it seemed
because if someone explicitly tries to do a P2PDMA transaction inside a
VM and it fails because the IOMMU blocks it, then they just get a noisy
error and they shouldn't enable P2PDMA. Except...

It looks like the dma-buf paths will enable P2PDMA unconditionally if
the test in question allows it, without anything the user needs to do to
enable it. I think that was probably a huge mistake but I guess we have
to live with that now. It means enabling new hardware with rules like
this is risky. It means even adding a global rule for Intel like AMD is
risky too. (Although, *maybe* eight years after I first added this code,
 we can say that the vast majority of Intel CPUs support it, in which
case the dangers here are overblown -- but can we say that? What about
atoms and the like? Would the rule need to be complicated by a big model
list? These questions are why this has never happened.)

So I'm inclined to agree with Leon now that accepting this patch as is
may introduce some problematic risks. For now, maybe we need a kernel
command line argument that can explicitly enable an endpoint or
something like that so users that want to try it on VMware or wherever
can do so without needing to build a custom patched kernel.

I wish we could revisit the decision for dma-buf to use it without any
users explicitly asking for it. But I don't know what the correct path
forward is. If we can agree on a bulk rule for enabling Intel CPUs that
might be a good compromise, but I'm uncertain if that is even possible.

Logan


