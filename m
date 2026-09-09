Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BD2F8E85;
	Wed,  9 Sep 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947030; cv=none; b=kzZSn4N84wkT3barFwxz1hibFcjtE4za9c2wuXBZlh2wsh3AFmILxRGQS86t8GcFHgyDZyeOntIuDWQ0Il2YZI5OhgPDPoSjNNM9t/zsUql776SEhcyiWYt81MO/j+6qmkFJYX+xrE9R8m5jzOUYjZHK+ZTiE+yuWknvG14cCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947030; c=relaxed/simple;
	bh=bokbo0Y1lF/sfYbaLycfpEStqn4KwiCoMbrVI7+K238=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mo6rAP3NS83ml8A6rAbP+gU0AunMgB4jlzl7xCJ2MlF1cEkAe8pN8VoI6N5GQ6ci/TLIycRP+cxzPfkr9roQT9IE29ycKdfMQVqmgMpk8PUSSXxG0H5alTRhHVlfyGCbgiOScpB40dCF58ZgeXnjHLqmveq5nMB2wvuhcrmtDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3WCL8lA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3WCL8lA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B341F00A3A;
	Wed,  9 Sep 2026 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788947029;
	bh=TmbfDa3cK/8EeSjpl/bP9c8pl39/dqGomW3DJXMR3pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o3WCL8lAYwhPoDrJvi9XHJ0P5dvM1NlVxm3vFxB746YF/OZWwg5l4hGBcWpn7EJrA
	 GQa9xkGB+Wfu8XIIPrEyZKN3/Vm81EIOVHUISyUetYc1xYDy7EkxOVB29O5wXHuEXI
	 NgqPFE1Ng/ye4UnbQjuUFGmDwR8Oz05WtlmlyKRDWN/DQe3PngFWn2xJ2+vU6Iy1XT
	 XNagyjgIWW9lqOUUD++uv0eEwHZRdlPRrSzR8uZ1V9wbMwBAuAIp40Id1n+Jf4SNX/
	 UmVU5XmF1t47BWI0T+sA03InnQHicQ4Qeg1ru/FZdlS/sg5DlL3kMSg/yRVdz+7Uem
	 zHF0CKErpCAQg==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
In-Reply-To: <fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
 <SN6PR02MB41574989AE7DB1332F06C66DD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com>
Date: Wed, 09 Sep 2026 11:43:46 +0200
Message-ID: <878q5a220d.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20 2026 at 10:17, Naman Jain wrote:
> On 8/19/2026 9:29 PM, Michael Kelley wrote:
> Config dependencies make sure that CONFIG_IRQ_DOMAIN_HIERARCHY is=20
> defined wherever irq_chip_retrigger_hierarchy() is getting called.
>
> x86 SMP or x86-64 guarantees X86_LOCAL_APIC =E2=86=92 IRQ_DOMAIN_HIERARCH=
Y,=20
> PCI_MSI guarantees it via GENERIC_MSI_IRQ. So the #ifdef may not be=20
> required.

Correct. X86 depends hard on hierarchical interrupt domains.

> Can you please comment if you are OK with me adding this fallback=20
> mechanism in next version.

I assume you talk about this:

    if (chip->irq_retrigger)
        ret =3D chip->irq_retrigger(data);
    else
        ret =3D irq_chip_retrigger_hierarchy(data);

It won't hurt, but I can't see a case where the outermost chip which
descends in the hierarchy down to the vector domain would need that at
all.

The point is that any interrupt which is connected to a APIC vector,
i.e. the interrupt descriptor is in the per CPU vector array, will have
the vector domain as root interrupt domain in its hierarchy. Otherwise
it would not end up there.

Therefore retriggering it at the vector domain level is the right thing
to do. The important point is that the retrigger happens on the new
target CPU to ensure that the interrupt which arrived late on the
outgoing CPU is not lost.

When you look at it from a device level (outermost domain), then that
entity sent the message off already and relies on the rest of the system
to take care of it.

That's what the vector level retrigger does. It ensures that the new
target CPU processes the interrupt and keeps the machinery going.

So yes, it looks "safer" with the fallback in theory, but in practice
it's a purely academic exercise.

Thanks,

        tglx

