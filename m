Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512524;
	b=M9s3DBmCkfu4U5pYeyQ/82TTqlURuZ9z+YxnAnwSAdj7J5R5vOQv5M3mfvR5IHew8do9
	 rRAjpVbcq6ij4KxK5ayncLZNu3tUN1oMTb/ML1A/uPWmQ9Ui0qHVUiA8Zbswp2dszTezP
	 DysdiBNhtgehkdvCxyPk/7akz8LbUC92gNkhLliBENyC5OZh4wDks8sHaSs1qEIwUxU3Q
	 hCWgmAlqZpCnGkXaG8ZnDHcrBW5zESNhBGoXeTvoww4totKZ/g/I6SY9yh049ufQuGy3e
	 lxG9f0VqxxovcEVfXAucPu+ZcPXUIHfC4RtrZobgtrFGASvibiqcHu46najoKz9JUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512524;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=vSmY4qK6N+zSMZ80Cf1TxZDK1xNA32Q6d6vGxmq/3Bo=;
	b=3pXZhzs9gJFCR+ZvBRrrfbSAS0LgZ4otvWB8NEXMuQyzHXj9JOJTcRxPiJsdvdzFoif3
	 esHJitocV5/gAJBGz3ZMTEd5rRJyEgBMfdujzmC3Ne5ciyB1lRmVIeN18kBMSRPBZaggN
	 YsVX+wv2OYPAb29DX3rxqPgqWjzrV43iSvQTUnSGpFWKxT+uGNkCW+oSp6h7F1UdLYkcI
	 +gAC1UpupOCkp2J+xyK/B1SoRCjA0aK1KQ6Zjox+TVQBrNGcZhV9h1FhMGLzbM27nzeEv
	 s7FDCn81CTH03jL9Scnw/AqZ34VfDIrJ51PzPX66wXsmO8vZIBSvW9MDLqUYMHHkV8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=tkEQj0Yq;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEC606A31B;
	Tue, 20 Oct 2026 16:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3EEC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=tkEQj0Yq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=vSmY4qK6N+zSMZ80Cf1TxZDK1xNA32Q6d6vGxmq/3Bo=; b=tkEQj0YqLNCzeuJ7e90by1/ejx
	MPy9nsYQzQmcjFTIV+C6f6aBgtHgMgvIMS4GfHLd+Eaduuw7TOQHjvRkWgLKoiM1f/phLJ/NaZY00
	XBKTCN7RcaBJp5ipa2Y7+GllvU5Teeq64N6B2zi+dOUoTJbM85SmKeozviqHjm8b1JDDxPcN16edE
	TWF9A9oOzxjCNcgt7zJ9yXWR60PrhWLRK01ckX3i3OWlXmMqUrGmSkIgh10E7LTfMF+sgSe+c5J1h
	qQ0XwXn6u7BX9Pveu/AQvM/Vhfx5zwZN5dOzDGVf69wMk8qlRcGSRvP0wnLbRU4XC/asPqnMO5Pyb
	h9xs0RkQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xJCOE-00000000yyj-0mXr;
	Tue, 20 Oct 2026 10:08:38 -0600
Message-ID: <e915bdd0-edd4-447d-8b87-6aadad6004bd@deltatee.com>
Date: Tue, 20 Oct 2026 10:08:30 -0600
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
To: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020151305.65218-1-pavel.e.popov@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261020151305.65218-1-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, leon@kernel.org, lukas@wunner.de, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-20 09:13, Pavel Popov wrote:
> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. In Hyper-V guests, each passthrough
> device appears in a PCI domain of its own without a host bridge
> device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> against the host bridge whitelist, causing P2PDMA requests to fail
> regardless of host support.
> 
> This affects discrete devices such as GPUs, NICs and NVMe drives.
> 
> Add an explicit list of the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
> 
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

I can get behind this:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
