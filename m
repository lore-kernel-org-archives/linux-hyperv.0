Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473736;
	b=1UcGLFskRt4NOY/eAy7XohO5oZbM6XF1hEzP1DJL9oUH63thEoYzE2GhnbDurBAcNQcb
	 4HWSOiz9DkIXv30PzKZjtSbN+l0ovJtIxHHZmTKzb6vgVy6Nc18X7qWLPEgnqx0+jzoCP
	 YLnGuj7oFKq1ryWbewnuhAZ00ruXepcn7gAG/hBiQ/JUa2jKeIkvjmCan/o+UFm2bc8k2
	 uqQYWA2lVuECF07I9aN2kWD53QDOH1sZwXw3MIkmwW9rS1NFeFJ6UYn4q0u11P68tmnEl
	 OnwIZ08eLgkVsR9Pc9mRU5mGunqzHcxQPU3mkixboMivnvUqBoDWROQmNIzcwuHwekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XqdedUL9j1kYoCsVgoGHr/AMA1g1btCDEN8xHec8Krs=;
	b=ebVJGHea443rBHjrm8ymZkvxYUkWK7J4OqIR7fNeuEYWG0Z3beBTFVAZy9d75/OAd7jg
	 zgy3HPW0oZaXNDxIVt7pmgxmlkIxnFFoU2HW42CxzH0gaqXxr4FrMMwsT/T6oBHIFw1cz
	 Wh7QkEUJwVdFeTXMH+DIg08ZYJTyzUFwBJSaUDlgV+uuc7Cv5uLsHE+Xd5KfmSilqwh98
	 y9Nb+0mmmeaqq/pRm6wjR9gPqK4e9shC6vDc+olP9tSWb4E+6f31JhnedQWD6pW5t8tJs
	 CncegyMPIefm/xyX5ByK6v7UUGR0vVco0SHp05sTHqCaNxjii2r2rFrsIvf/KFIT6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atnR+WAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A8606A319;
	Tue, 20 Oct 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atnR+WAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797861F000C4;
	Tue, 20 Oct 2026 05:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792473736;
	bh=XqdedUL9j1kYoCsVgoGHr/AMA1g1btCDEN8xHec8Krs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=atnR+WAoKxIzMdNNh8969UQH9W/45n1AXtUjCFyka03176J4zi9OzLj5bFc+1AsU2
	 sEfS3EwqWvPNIM7zjbYiM9LsvIITj2a6aGz30Fef1JTUMraetGY9xG/9DhK+P1JgGa
	 H9HoBTWHssuBVriaJ6gmk5pLX/Q0XpV8cSocP2Fss5pDXlenGqKMPtcH1H0xFkN0gx
	 xS5YGBKzZQXkwLct+MlHqJDBh5o2AxGmHv0w8zwj07gKYQ/gGeWKeDr3LFP8egDwWP
	 EKIwYFsLpQ5GGPb69D/mvRXDuh9gGtR9IXRJ/njbVUbe2vIcVxwvVQhFuhm82GLwV8
	 9uIjCDXsf0CRw==
Date: Tue, 20 Oct 2026 08:22:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Popov, Pavel E" <pavel.e.popov@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jim Chow <jim.chow@broadcom.com>,
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
Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
 Intel hosts
Message-ID: <20261020052211.GJ64621@unreal>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
 <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261017074820.GD219304@unreal>
 <LV2PR11MB6070ABD61B46E9590C9B28ACB29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <LV2PR11MB607077BABF5643BD4FAF470FB2982@LV2PR11MB6070.namprd11.prod.outlook.com>
 <fca6d815-519a-449d-a5b7-36bd3ad0c19f@deltatee.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca6d815-519a-449d-a5b7-36bd3ad0c19f@deltatee.com>

On Mon, Oct 19, 2026 at 03:14:38PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-10-19 13:48, Popov, Pavel E wrote:
> > Logan, Leon,
> > 
> > I kept the hypervisor check to avoid changing what the host bridge
> > whitelist refuses on bare metal. Looking at those cases again, on the
> > listed Xeon CPUs this is a limitation of the whitelist itself, not a
> > known hardware limit, and it is why Intel QAT/DSA/IAA had to be added
> > by ID. So I'd drop the hypervisor check.
> > 
> > Would a v3 that moves the Xeon list into cpu_supports_p2pdma(), the
> > same way as the AMD check, be acceptable to you both?
> 
> Yes, that's essentially what I was suggesting before. That would be
> acceptable to me.

Right, I also wrote the same thing in my summary "We agreed ...".

Thanks

> 
> Thanks,
> 
> Logan
> 
