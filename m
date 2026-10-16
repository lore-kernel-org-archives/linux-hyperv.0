Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EE390CB7;
	Fri, 16 Oct 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191327; cv=none; b=bhN6nPKT+8J42sR9VsNXdD2CjKjHsJi2B0zV2DdxIOpizhOv9n6UUlQ8+5RXkIs0Cz04xnTBMmzwsuT/KqjeTbEVzLyqJFPFMj/+e7Zj62b4/hHGERNosg1WW2QvlFUVGHajWBdV9hjFqJyVymI+uTGWNTDs1HbMUz2Yjp83STc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191327; c=relaxed/simple;
	bh=eLcXstUGQpu+xrOJ8PeHGrIktdadao5yyHaVL34ACQ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=fe8CAX4XRU2RJRk2BEX6Q+ktYlPWWdh1WwYsUZgbDgL1KCHMWDCh25Rr09FcuYfzVje7sKJFmMs8cLV1ctz4XDRVG2FIAu0spHbfazE0XVu33BNQs++NhigetjSBNdHOUfUOkHITmyHlCAOi61GzyZDLLadyX1OG59lapit0dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=MrxFxZ1e; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="MrxFxZ1e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=pkithiv798uVgMzxb5UwY/p9qnpe6saIvaiV4xnnvbM=; b=MrxFxZ1eCmPPTVkoO/7d402aFx
	54n2ufNyF/N+ngkBlIuLiqbXr4QQbmPebkPoK+pbYNWVLdb6hxK6hgrv5fnv7pYBx/w3a/eslHbfG
	qzp+xinSmAOEQkpFBse7CspNBt+Sp0bU5ssyL6kXNuDvGZLdo4MqbrFIDYnexNykjMm/aueV86NJC
	uYuR178SBkOGSSzNliyes3CyvhEovU/0/xxg2dsiu0cxZPR5LJOOP8469PK4+YBp0LkhIO0N6e48c
	Ciy4dq6hDVYn+/DoR9fs8BZt+U4CTd+bRanjKun1J4UEAv7rJ/5eqdHBJ80v/m5b3mBkVrNYWg5iS
	VWLi5w5A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xHqpf-00000007pyk-0pWS;
	Fri, 16 Oct 2026 16:55:24 -0600
Message-ID: <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
Date: Fri, 16 Oct 2026 16:55:20 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Wunner <lukas@wunner.de>, Leon Romanovsky <leonro@nvidia.com>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261016223402.19991-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, lukas@wunner.de, leonro@nvidia.com, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-16 16:34, Pavel Popov wrote:
> +#ifdef CONFIG_X86
> +/* CPUs whose host bridges support p2pdma, see pci_p2pdma_whitelist[] */
> +static const struct x86_cpu_id hypervisor_p2pdma_cpu_ids[] = {
> +	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> +	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> +	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> +	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
> +	{}
> +};
> +
> +static bool hypervisor_supports_p2pdma(void)
> +{
> +	/* Hypervisor hides host topology, allow p2pdma on whitelisted CPUs */
> +	if (hypervisor_is_type(X86_HYPER_VMWARE))
> +		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
> +
> +	return false;
> +}
One quick thought, after a very quick pass at this:

Why does this now need to be related to the hypervisor? Wouldn't it make
sense to do this check regardless of whether VMWare is involved?

Logan
