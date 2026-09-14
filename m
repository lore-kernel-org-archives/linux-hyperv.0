Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769524457A9;
	Mon, 14 Sep 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385218; cv=none; b=B+OhM5Ai4bKeXidjnEopBy0jU9S89P3VUC0CAtLgeD8vkFKLfTVNygVqj/g+MrUl7DNScqCqUsJxtG/KlvTg5ImZ6l5f+IOr/5rL9ILFGEPfMQveUcWLXS7rgwvqc55SW4ARqWLjzSzetlx1ahGHeqtFvj3iBU66OFd4GD2QBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385218; c=relaxed/simple;
	bh=csAbhE4CLlDXp4O4GOyrkq0Rf3qAZlsxhmRn1CU8v30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ebcCqsb7J6fOhNa6T5tMcVh/Y8RZtRXmyto6NOIWNygpvAofja/r2Lwh08yhpp2B4LQWIdoMgHS8SmOgStwNbTtGN72z11laNNFTNnBA3v/zY02dfZ8g4RfoDuG/B+NuPLnBUselIeq7StQTp4E+lmPTFTLGN5JaHxG+6gULFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdBPCPFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdBPCPFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9471F000FF;
	Mon, 14 Sep 2026 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385217;
	bh=csAbhE4CLlDXp4O4GOyrkq0Rf3qAZlsxhmRn1CU8v30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EdBPCPFUOLmU0vOkVyZ5Onm2KAmvWGQ9HXODt7TPq/HVxTpP674AFd1IdwPrxM48M
	 P8t8qvrdU8t97fj3z9Qhj7v/d01umCtFf2YFyeEWYCaGT62jLAnligLMi2JUBcqBA9
	 PfpniUuHPmXINbqHjE4RJ1v1f1EqMSLMojjt90gqpoZWLL2iMCbbnoI8lcnOEU9T9K
	 n4RvPelQ0D79Vbki6jtj2iakyEB6RWZ8+w0C4KYMqKj0pMKg65pLKbeQe2SdXKw6BN
	 ZkF1k8zYqnNWkwLs7pyTbPRJxsjcuKDu0mD+k8uFJJk/9Rrl5yS/E049uAESZ9axsh
	 ttwmiWPN6mVUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260914111836.2119301-5-namjain@linux.microsoft.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-5-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:26:56 +0000
Message-Id: <20260914112657.0D9471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> With fixup_irqs(), msi_set_affinity() and the generic resend path
> (try_retrigger()) now all falling back to irq_chip_retrigger_hierarchy(),
> installing it as the irq_retrigger() callback on the outermost domain chi=
ps
> is no longer required. The hierarchy walk reaches the x86 vector domain's
> apic_retrigger_irq() for all of these stacked domain chips.
>=20
> Remove the now redundant irq_retrigger() initializations from the outermo=
st
> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
>=20
> No functional change intended.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914111836.2119=
301-1-namjain@linux.microsoft.com?part=3D4

