Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962819E7F7;
	Mon, 12 Oct 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822257; cv=none; b=Lg7Q7GfLggfqwKaKtH8dtIQ2WLMt+7nSoHcFpDWPcX/4iYcFN1PWIZT5lm3PAOc3+JVoxvm9SUYFJurVE7A5ZRJWNq5Z5sXgn9+mBilG5CYrzKCR2b75DjS2vuhrT1PAiA6MlN8qdqiSN4xz8nclrLyLKn482g7uWqeknCkg8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822257; c=relaxed/simple;
	bh=oGJ9Mp8PbgTz6eQuoApeleJ8XpDy9AWwDY41Aa5LfvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4i1kliXjr1Qh0omkfxGW5GzutJFfD9VsWoy8NrnbsDiMXnjblgtmnmB4QboAH1Nv/gxAcS1CEIj9QD/Uy8NthILNyN1wTdI3ALJj94pgoXvO0aJPWSq2WqOb8xDePB7AZbcTLBZMXfu9TbW2sJBbo0b/U3cxOglILi6tc52jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERwhL2DQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERwhL2DQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E41F0089B;
	Mon, 12 Oct 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822255;
	bh=OZXc+b8QduoClrqZoGh2Zs8gOJq04ekU4fB0vx32kyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERwhL2DQXjfec0wseN3hHz/HMul1ygZKaEe1mgkKoiih/gtJVkr2djgv36sWBUUmb
	 wOacCokvfwYZVcU2SRdAssQiOJaWsS+aqCbPnkwGHJGOyU169OGmUTspNBpJH6gMWO
	 v32RHwGs8p/pFEZu7vddBZHz9TS8VL7V3/1a/6lkU/WuHWkauH35fs1T2On3eRw3w4
	 S8+otQDyppyVsCrY3CVD24E2ZSJxv6G6wLMdK7uM2txpJCjYKooKYyNknZsrdtA8n+
	 lBpYteOl5hPEOWtDwX4txI5vKCcnRWs6EzMEvuFCLMkXrFFK7Dk1xQcIFMJ0XzsSS8
	 8RofCq3BXG3wQ==
Date: Mon, 12 Oct 2026 19:24:10 +0300
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
Message-ID: <20261012162410.GH219304@unreal>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas>
 <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>

On Mon, Oct 12, 2026 at 02:26:43PM +0000, Popov, Pavel E wrote:
> To be clear about what is at stake: this series is what enables P2PDMA
> in VMware and Hyper-V guests on Intel hosts. The assumption that the
> hypervisor can simply be fixed to emit HMAT is Linux-centric. It holds
> for KVM/QEMU, which is open source and where anyone can add HMAT support.
> ESXi and Hyper-V are proprietary, so only VMware and Microsoft can add
> it, and until they do, this series is the only path for guests on those
> hypervisors.

I'm not following your reasoning here. In the cover letter, you say that
VMware reviewed your work. If VMware wants to provide P2P support to its
users, it can add the necessary support itself. As for Microsoft, there's
no need to worry; it can handle the ACPI changes just fine.

> 
> > This does not change the fact that the patch causes unpredictable
> > behavior for P2P devices in the guest. Sometimes it works; other times,
> > devices that previously worked may be classified as P2P-capable and
> > will stop.
> 
> Nothing "previously worked" here. Before this patch, P2PDMA was refused
> for every passthrough device pair in VMware and Hyper-V guests on Intel
> hosts, except Intel QAT/DSA/IAA, whose own Device IDs happen to be in
> the allowlist. Those keep working unchanged, so there is no working
> configuration that could regress. And the check is deterministic: it
> depends on the CPU model and the hypervisor type, nothing else. The same
> guest on the same host gets the same answer every time.

Of course not. P2P operation depends on the hypervisor topology, which the
proposed code does not account for.

> 
> > Help Lukas and Mahesh succeed in their work.
> 
> I'd like to, but the blocker for guests is on the hypervisor side. A
> guest only benefits from HMAT once ESXi or Hyper-V emits it, and that is
> VMware's and Microsoft's code, outside the control of Intel or the kernel
> community. The kernel cannot make them ship it; what it can do is provide
> this fallback. When your HMAT-based detection lands, it should be
> consulted first and this check only when no HMAT is present, so on any
> hypervisor that emits HMAT your code is what runs and this one is never
> reached.

The kernel community has no obligation to accommodate users of proprietary
products who are unwilling to invest in a proper solution.

Please keep these hacks out of tree.

Thanks
