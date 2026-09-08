Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFD378D8E;
	Tue,  8 Sep 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848745; cv=none; b=M5xsHNDMd/PHvXtze6crYaLEcHhcXWEiCtj8T2ZxBYJCp5qgOD+Oxxune7g88jpbU6cxESjmmftoAyujZFFku8fJZewSjJyXrgmg8EPRP0AnPbdhIrURCChZbaQrknMav5uU+nEI42lhPqRpMU80wcnNgOcSIiAR3nokBTt/50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848745; c=relaxed/simple;
	bh=2sxfpQYYOS6TP3cfrhMZ6nCZCTbUGyW9bNvf6BpMRXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A6BWgadenU9MZJeoxl4Kazc7Uri1sBy+NUFd9rQLqur+yiODzv2CY4HjQ1IJc/mMq3MNBCeTygeclW8zVYWG69+t6PhjI8gHQkxDPK/cPQNIn98X9523vs+GKrd9a8INGDCvqNG5m/1FkWyMpUkrJaCzm4XXDNcSgo3hYkwyAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNbUyBrI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfWfj56D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNbUyBrI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfWfj56D"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIK4BsJWq/dgs8gEc/V728RzzJCD16AWxqBdxMbaD94=;
	b=VNbUyBrIqfAckWEUsY8s1C0hoeg/vS1jMJkmRg3XfCDH9x8ifCV9lV1BhP2BXWWfO4IfwO
	zLoKKyO3Ag5x2oDUZOBQpBje6UI0LVwmyWG0Y8CVlQlfJNOsNDgikJw4VoM5LETRBkdha+
	i4H6sfLMQVeUOV2FxxeS08nM5RdqHAP/JvjFNo8j1SBqA9+0BbcQZlgCqv3gE4dE1EJnqv
	Op4lvUUjWstuNZo0DN9G7zBT4/DzAB8n0xgaZT4Frfvu4BsEoiQlOs9JZM7Zen2vipl+gI
	0NjDJu2vt52wbDVfL44zWpvXQeSMeORRJKZcJfK1fF0ojvvDQ4in94LHaWe3zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIK4BsJWq/dgs8gEc/V728RzzJCD16AWxqBdxMbaD94=;
	b=CfWfj56DuYNhG6ULpszpbz2nxZH0hVNyrQdOp1yP4r7img7WbaXWWt0i9Pk0TjsebYwpy5
	8S38D6lzNJMYuWAQ==
To: Michael Kelley <mhklinux@outlook.com>, Naman Jain
 <namjain@linux.microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Kees Cook <kees@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Radu Rendec <radu@rendec.net>, Sean Christopherson
 <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin
 <d@ilvokhin.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding
 <treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>, Daniel J Blueman
 <daniel@quora.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
In-Reply-To: <SN6PR02MB41570E8F17B6A78AD607F91CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-2-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8F17B6A78AD607F91CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Tue, 08 Sep 2026 08:25:39 +0200
Message-ID: <87bja88djw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 11:51 PM
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index b3ad50a874dca..1e273d7d6c5b3 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -304,6 +304,7 @@ static struct irq_chip hv_pci_msi_controller = {
>>  	.irq_ack		= irq_chip_ack_parent,
>>  	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
>>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>  };
>
> There's a slight discrepancy compared with the guest pci-hyperv.c driver,
> where setting the .irq_retrigger function is done dynamically in
> hv_pcie_init_dev_msi_info() instead of statically.  The parallel here would
> be to set it in hv_init_dev_msi_info(). But given that Patch 3 of series
> removes setting .irq_retrigger in both cases, the discrepancy shouldn't
> really matter.
>
> If there's a reason to prefer one approach vs. the other, I don't know
> what that reason is.

hv_pcie_init_dev_msi_info() is for the MSI device's interrupt domain,
while this patch is setting it for the parent's interrupt domain.

The former is what we need.

Nam
