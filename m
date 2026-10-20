Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515285;
	b=ZL+/acKb3+zLGK8eHsha9W14ygWITxnOLJyU97wAiVTa+HNTYv9ojEFz/fpIk+q7upVt
	 BCH3nmpgvNeO0Ud0D+yuUUKRwha+hmZWXF8TaAmWJbpB6BBSKS4U0uMkqfZAPPYE3bog0
	 gKjtPtktL9DD6wUJAmrhxf5vC7k3L68sWAmO59LoZpVTdc/IyuADsbLDsw2yHO3ABY/Aq
	 I2A7DaVDe15+hVIdif6TJilN6gb/mbvgfTci9FRXKZYcqyc/PGphtt8zkddkBGxcqRBsV
	 MIeeXTvJsIpByEpNhqzfZZUmWc8EuAJlU6LeGRGhWL0x5nOOf5J/Vc70cGb43xVsVzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515285;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=cXfGenyjXLSMXgfQE5Chfdo/t+3Ko9b5078skif6VV0=;
	b=hr3RXJmSQaDX4eh3uMlFYrXHYXCgkClnkcHKV3e4iNYF0HmOSjR7ZUtY260H5HYsc5qD
	 1qV5ybY0XnNKaLYUbZRcj+2U8iPigRjh3lK14C+IUD1z1I1j5MplWo33QNShiZKLjPLyn
	 rfnGgA7LWl3KNYY+L6JLwwu/sBjcjMBbLwQKcMObKStsOjq1prpq2z83gtWdWobggkmV6
	 kMa00JVUtl7v6cMzsROB4xT5vBivr26u/RjPDVHB+EPsEQAEiUiBNIW524sVkzBlvmgWJ
	 T1FE8PuLHFJkt/2UVG+u279MgSCgoRmvr2F8Zsp7NAJ5X6Bznq/yXzjrvbwxt+vpj7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=f1wlx+ou;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71C606A31A;
	Tue, 20 Oct 2026 16:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E71C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=f1wlx+ou
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=cXfGenyjXLSMXgfQE5Chfdo/t+3Ko9b5078skif6VV0=; b=f1wlx+ouq0YwBBYWkhPhkh/9Td
	WE1CHe1X4il+154zbyZu/0quHKs1fHHKcI3z4mU7xZ+9uN9o6PkFG5rdhT87KIkEXAzAsh4uqadSU
	1f2btNohJiNAF6SprVJ4/U4v9eVPt6qstV23beBb29j9tzW0D1INRHymYI6Omjp6KkHJMmjMrAlrb
	NHffIHzenhfjGfV1D0+xRS7WPnX6LLsiU8gg8o/sMXdjRgJGShCuguqAHSwLE5XINP48NQicmTFux
	Ud0NBJETtxuT2YXzhZ3sGNnBPUYyNSROupLA/d/aL0vbshTUzPQcpzmcRGIeYNb58Z+DolisbmNok
	QP7Ycusg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xJD6n-00000000zOY-1cjl;
	Tue, 20 Oct 2026 10:54:42 -0600
Message-ID: <db26b21b-8416-4b11-aed8-3829ed5a6cfa@deltatee.com>
Date: Tue, 20 Oct 2026 10:54:39 -0600
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Popov, Pavel E" <pavel.e.popov@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261020161447.GN64621@unreal>
 <20261020163758.GA2342476@bhelgaas>
 <LV2PR11MB6070444E927B9AA891B8180FB2672@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <LV2PR11MB6070444E927B9AA891B8180FB2672@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, helgaas@kernel.org, leon@kernel.org, bhelgaas@google.com, lukas@wunner.de, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-20 10:47, Popov, Pavel E wrote:
> If preferred, we could use for cpu_supports_p2pdma() the pattern Logan
> suggested for hypervisor_supports_p2pdma() in v1: the whole function
> under #ifdef CONFIG_X86 with a stub returning false for !CONFIG_X86.
> The Intel CPU list then moves into the same #ifdef block, which saves
> one #ifdef, at the cost of also touching the existing AMD part.

I personally would prefer cleaning up the #ifdef style but that's an
issue that's already in the code. I don't feel the need to make it
conditional on my Reviewed-by. If you are able to clean that up, I would
appreciate it.

Thanks,

Logan
