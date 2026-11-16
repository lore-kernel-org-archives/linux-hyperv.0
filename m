Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810154;
	b=NGwKtO9Fug+dSqXSO65Zcl1WtRH7W3c7DmY/LiH4H502ZiucfgxiTJzFZ2gjwL+zk4tw
	 T9B/2dUalFM96ckFBcHDhNW1ItLJcsIZhlWnDsSOFwgo84ekGIHaPgDGSshQ3otuWWwZD
	 6JD718haKEmI9rpZy8nIu3HSc+dh7XPZhLpVTBt0/DQWHZIU0+whNB1SnKcrHwit2xSaj
	 eoEhhNToQDqBHp5wTUBIMCDgN3RRJArZWo5P2NlmHqtazkBPQBq7hDNQM6pddJRUDUfG1
	 oPCNGehf3BkHN31w1cGKHIFjjFTbOYwXU1rtVIEsbNzhZUqYm31TyCyW6mGA7pWZpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810154;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=6JeNuagrKkhlsUC62EGh2fwcvgdbpoK+v8GV5W+tLck=;
	b=vBNVL/w7xrxn2ZvHKt+LEodyfPgrBvOySu4f/YmEqSMVmPBwJ2yk3U3A1DJHfp6i5gZA
	 yQ5wC3JeWsV7UIyHh7YbN/oySwqsP9TccxCYOeL/90uj5zNriUjjHxdflpE9oKG99h1bc
	 wePEMU5RN4rPrA6s2qLi96J7xuoUukntSnFEg41+R1A740nnHFcg6GIaWFFDxAKHBWhWa
	 AdvBzFIrhp3i5rOFCNdnj+qVsezKTCHTFygUDoNlAhgjzFpreNPlE/CgCaQNA6Q4dA0v8
	 cCi9iJz3vnNeWipg+mXZrbSHkHoa+XsPSFgqamuQSZvSNLrEqOxbIsJqpxjyQuVG6ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Qo6fj0m;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C709606A31C;
	Mon, 16 Nov 2026 06:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C709606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Qo6fj0m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6JeNuagrKkhlsUC62EGh2fwcvgdbpoK+v8GV5W+tLck=; b=0Qo6fj0mt3LEB3mIBoB9/wQaVm
	kFs/i16knfl079NMYU4uyZebhhDFxOKi305wXed0a4HWXH3Kc8BhqNNXx75w2RS40bx3PUoXLHXmG
	Avh5hSX26Gr6EDiraEumbwRARrg6A+0k5kaLuKdlhnNNRAAzOO52UJneaiuWTKXc2PJDKkod8R3uK
	YpYrjsHJQpOVaKjucTUDF2HctDi9U78EKe5I8ouQ2GK9BW7idg/28OotLx5P5XaVwukChbpUV7V8s
	zXKCzOnHiftCD1KhrY0aMCB8qXw3P8GlIgOR1bmFcIAw5MDy+e+BM5hIiH36IMXh3ejMZD3mMWNpX
	G/9EyciA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSq6j-00000001E8g-2jmY;
	Mon, 16 Nov 2026 06:22:25 +0000
Date: Sun, 15 Nov 2026 22:22:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <avqhIQ2krd1qgp6K@infradead.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-4-pavel.e.popov@intel.com>
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
In-Reply-To: <20261111234439.4098-4-pavel.e.popov@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
>  #ifdef CONFIG_X86
> +/* Intel Xeon CPUs whose host bridges support p2pdma */
> +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {

Why is this in drivers/pci/ instead of behind a clean abstraction in
arch code?

(and the fact that the CPU vendors still haven't managed to provide
a firmware interface to expose the P2P capabilities is just insane)
