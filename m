Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667070;
	b=ija2czfE18FYGJq+wQMG/zmfkoob6aUFNUMATFlH+1QsxREruTkNgoFB5i/uvPC1uP6u
	 YJSlsd3U+lpRJO3DLUfNQipI0VDZ5Ap3do9R/IDMSRXoz5sqv8Myt4Dh4Zk695rxzJnqW
	 kZlmZISOJFqlUlhFSYqGxhqv+EYhAaVli4uqsh5cIbDen7Tp5F01u7gNFeN+sMbAONpjc
	 k3QoqEWjyq1yETm9V+R/li+h8Ha2sN9qSmxhCWU9RYR7yV0ei6TFrSa8eszr6LD/4Cyng
	 VK6HBd0AyXbW73pH/Uan+SEOqTtHNCpPAYTNE6qcgSCl+DGdG3TemhYa59xsPyrc3XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667070;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EO1BnMjokjrVLF0VNQ/IWD9QGwGccXm6vVRtGn7sXpk=;
	b=cAHouzOjd9c99wtBDaGtx1CW6T0s152Ga7U7gbfTtY55nSw9PM4EpQF7zhPVi1pcIRC0
	 CQa197qVXZQtI49Dca9Tkl0sU4PKgnqRHDF7j/ap3WM7vJVGhrOL+KJC26Cm7XMwZ5f4W
	 bTnZqmEDMMolxHfLXCKcXbJyibMyE6nA6R4rO92xSiEkOnFwRY54wJUs9wxOSKTbVZINd
	 7MR/nusCqM7SACOPcxEFtktDwcrqWOF+Xd/2akfSAjtTo90aid3gqJfAkugiq/MDCaMYE
	 S4Yw2IBy515lldztzuRLt5Ahio+DVXRZlbhjs/5vsmkVSxbrBZtch3GQzNxsZRCxQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gboT/HjU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66B606A324;
	Tue,  3 Nov 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gboT/HjU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77371F000C1;
	Tue,  3 Nov 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667069;
	bh=EO1BnMjokjrVLF0VNQ/IWD9QGwGccXm6vVRtGn7sXpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gboT/HjUJac115ml+P2hDry3Ye5G9XLfBh+ioyglojs3EcDKOzMJiP+9ksKymUoyO
	 yiMsIAx9ytbxOjzfC3iiBiv9v048Jt2Pwn6Pb3Iap/t9zfd8QapuFHrbQ6OFPJF1nF
	 +MeuoARLHDcdfoFnxUYlkSZ1Mw0JeEuTBFFzhgKJolU1o6AxG5IZ4freFEr6VSQE/o
	 ggy8TsOSZ6gMOkli713pBkOfAT5kEx8YTmJxrgvGJXbHz5XbKbGrjSatdgxFk0atoK
	 MiIiK+Jk+io3mNfr2KxkLQDILfLwtLyN9qxpJKrkPJX4QW16w2NvtB2DOgzSHrteUX
	 5ax3+jjfvHADQ==
Date: Mon, 2 Nov 2026 16:51:07 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Nam Cao <namcao@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin <d@ilvokhin.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Jiri Wiesner <jwiesner@suse.de>,
	Daniel J Blueman <daniel@quora.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
Message-ID: <20261103005107.GB1862133@liuwe-devbox-debian-v2.local>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
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
In-Reply-To: <20260923043023.3150498-1-namjain@linux.microsoft.com>

On Wed, Sep 23, 2026 at 04:30:19AM +0000, Naman Jain wrote:
[...]
> Changes since v1:
> https://lore.kernel.org/all/20260728135117.2888175-1-namjain@linux.microsoft.com/#t
> * Added Review tags
> * Adding minor clarification in commit msg of patch 2 (Shradha)
> 
> Original RFC: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/
> 
> Naman Jain (4):
>   x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
>   x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
>   x86/irq: Use irq_chip_retrigger_hierarchy() in msi_set_affinity()
>   x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
>     inits
> 

This series has been reviewed but not picked up. I queued it up to the
hyperv tree. Let me know if you have objections.

Wei

>  arch/x86/kernel/apic/io_apic.c      |  2 --
>  arch/x86/kernel/apic/msi.c          |  4 +---
>  arch/x86/kernel/hpet.c              |  1 -
>  arch/x86/kernel/irq.c               | 18 ++++++++----------
>  drivers/iommu/amd/init.c            |  1 -
>  drivers/pci/controller/pci-hyperv.c |  1 -
>  6 files changed, 9 insertions(+), 18 deletions(-)
> 
> -- 
> 2.43.0
> 
