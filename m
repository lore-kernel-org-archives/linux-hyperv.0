Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521607;
	b=IB74oLBZ5HCMiw6GHYZd/tx9X9vkqeaTqmnm82YTUXVrxuTioKyL4z/vg0N/nEUlh2S4
	 ylXeAcnQAfDSuUHKmLdNWk7IajGch2hbPSfrlGg6DzRnE63VZWDdG87yV0Bn6UOuoZ1Vz
	 7DIj5DgUkLH6tXOs8u5Q8rLigZ6Ey3a6jNoBA5X2+ZByPWzt08R8L0lQ7KdHljk4jRm82
	 AhVfqqsSljLpIsanVuV0NUFPyJX0wwylBBECQgo2RXr/QRMZlYjzJNzQGam73Zi3+4PJb
	 jxq9nKffRsxT3Q53KBVF1YZhkMymeM18ohh8PvJbSag9eCqXlPzayM8Pv82Fk17EfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521607;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EOZpM7CuUTVEfDbgBRvKlOXtuH3AUTE2in12R3NoLdY=;
	b=UBGVIjPst3Ze1rnnoQgTRw1CC3z2Gou8g2qvpDISjd74xxpOvuAZdrc2qe3dp3RHJ4IF
	 ELM/cO9L2CIQbkQ+A19wu+lTSh4oVsNb0qIXq4t/fH0pm02Y5AZ0KS+jFaDtyNdazpWn2
	 O3GDKRVsTHG9DUnHlTIUgj8Ow548JpRq1mQCAXRmLQzXzfGI2CD6jPiXsnQkk24UCxxTr
	 NM23Yo9rwVTV5cq1kLtQSGGxgHO0zhOFO6C3MgLamZq6t6lBBgRvgD1tMz/qKIy95jRS4
	 W5WyiYuGc590+tXfVuCyTJ29un3BTthtxeW1UlrOfJ7iVrmrN88/sxv4OBTr75kR2nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjqZteqL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39755606A31D;
	Tue, 20 Oct 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjqZteqL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0027F1F000CA;
	Tue, 20 Oct 2026 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521606;
	bh=EOZpM7CuUTVEfDbgBRvKlOXtuH3AUTE2in12R3NoLdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bjqZteqLF/Bq7vcGZ3WV9MU3lv14rWUDFvDQdlIzPJTrt+LW2uTFrBi2jchQ34lO+
	 Kk89zT0clX+NoThMqLvS2e55wsZrrtAo01Ev1X/eMqC+a25/y2nDFdjDj5e+xP6hNi
	 E+IRH+r1IaN58xSsprmwoKjEHg959dem7eg8JKz3dnHHQ1KbKfmZ3hMxK5VlMl4fQz
	 clV4CMGNfsKKHcQxHqcOHXtt6etaO1ElQOXQ5sNBsumfhLDvjeufwp8oPBpydGMt0b
	 I5aORTs3eBFXDOiAPSwU4ook3Y23Dc5VasJafWukMdDsDIwT2SXkzqxb67TxGXSM+D
	 Ul+AxZlDO7RpA==
Date: Tue, 20 Oct 2026 21:40:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Lukas Wunner <lukas@wunner.de>, Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261020184002.GO64621@unreal>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
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
In-Reply-To: <20261020173736.81755-1-pavel.e.popov@intel.com>

On Tue, Oct 20, 2026 at 10:37:34AM -0700, Pavel Popov wrote:
> VMware and Hyper-V expose passthrough devices to guest VMs without an
> explicit host bridge device. Consequently, host_bridge_whitelist()
> cannot automatically identify the underlying host bridge structure,
> causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> P2PDMA on Intel hosts, this series extends cpu_supports_p2pdma(), which
> so far covers AMD Zen and newer, with an explicit list of Intel Xeon
> server generations.
> 
> Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by carried
> over; the Xeon list and the check are unchanged.
> 
> Changes in v4:
> - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
>   (Logan Gunthorpe, Leon Romanovsky)
> - Keep the #ifdef around the asm/ includes, as these headers exist
>   only on x86 (Bjorn Helgaas)

I'm confident that this is wrong usage of asm headers.

Thanks
