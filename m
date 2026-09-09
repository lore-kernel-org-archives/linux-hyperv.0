Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C21492E38;
	Wed,  9 Sep 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936750; cv=none; b=aCaJiyBSoAGP+C0DWxgvMikL+AuX3HP1cDXrpvCi8r+r+dgA/wswA1VP+ZhB/UidlGnhDEBsbwv4eDNcNYlL7zDtDB29mHUogDlfOq5hY/Da/3psKgQyo+Im/5Ze0/Z2aqC+GgZJTSPi68HTyba1aGMjhMMPa+w3cRV9cdYprmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936750; c=relaxed/simple;
	bh=DVU9+NfmDEnH3WgDOdDICvJJT42Qfjntspa7N+QK/QQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjhzSk8ZRSUvGiqYDQIOpnpSgifkeqkDjtCb5IzMarE+eXvpta/4Nf68VH9QL5/EcWO7D5NzvypAcjTiQrnOenhB4rMLa/2qk9eX+nbQRoH1cE4DOqQbDYq54tnAQuZ3S8Alq1HB9uJCvTCHXq25bQI2nOIIKD5npe+Iu0+cYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpcvfirN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpcvfirN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0B1F00A3A;
	Wed,  9 Sep 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936749;
	bh=DVU9+NfmDEnH3WgDOdDICvJJT42Qfjntspa7N+QK/QQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpcvfirN6PVq4dL4g4aTzDkgnfYPgqP93ZqxifbgdTbiP6+xbDEAqZoPF5sRcmfWI
	 wSQKIqixSZqagc5/Ffl/DAulyGj/d3FRpIvReOPQ6aSknrbZB/BAjIZ+/kAr70QoeJ
	 GgboLJImuq6AITHPw/XxbraOve2Cts/JGSI5Th6FUg7vMat6p0XE7UcPVQBnqoe1zV
	 tJOZ6JqUZmpwA7oTRZUnQSe+N29ZWY1PeR10CasZrtzQ3QZuJMTHaxSwu5bO1ohElv
	 x28HqDlN15a/l4T3eGRuKwRQ0fZyam6ii63i5RVf1JWhz6Nj5Og5o6wIpYhA2dDSD0
	 qRU66BdjiD+Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909064448.1004-5-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260909064448.1004-5-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:52:28 +0000
Message-Id: <20260909065228.E4C0B1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064448.1004=
-1-namjain@linux.microsoft.com?part=3D4

