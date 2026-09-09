Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDA366075;
	Wed,  9 Sep 2026 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936867; cv=none; b=HiibP/awpF784Dv0isPSkquIRgpC6WDP6GwKX3FMI/ByNALdc+QSVWqKQqtAkxj00ObGUXGrLmDQf4O1ZeDX8U7JxdbqHA0d2yW109hoiEQH9ghh0kh/N3i2/+Nz7UHbNzVNacwSjlkEz2uzXZE5QmJ/SWidM20gwcHW99cY9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936867; c=relaxed/simple;
	bh=jykiTd5xkWh70GQ2ZfS18X1Za2aS3HOKVYWrPP1SfE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2E0VyZraMIuvUkgIeleCZWzwolq8+IttaGkI94NXnFQbf/E2Lfyw8mT49K78rgneBq5SrrIW7dEiYncQL1a8KGaFGgNB6d/oyDXG8g36Z7eQgfXgooc1t+OYNvDx/ae/aVTuLHVHP9ZBKWG/8aTs8C/Ixyt6NHIHHv+K95Nb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adSkU3Fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adSkU3Fd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C6C1F00A3A;
	Wed,  9 Sep 2026 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936865;
	bh=jykiTd5xkWh70GQ2ZfS18X1Za2aS3HOKVYWrPP1SfE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adSkU3Fd5o6NWLvd+dtA+65qSexXAc3ZKGT2I+WCfEUae+RDt0jdrwAmxJdclSQ5w
	 l1HJuQH2olBD0C+4Y0Jc3os1kSWgpHnF3qrojrMGnyQBZReDhoYi+XGjN7u2wj0Y8s
	 cdHaumaDVO0Vw98OQzJ5Eev8O916/M/Jj5FoUUIFyDF9vKSWuvSU2wYcu4e7Yfy+OH
	 5kftt9BPoWX0GzYcTJOFnS9ol9D1G31P2HgrcdwzvoLiJR1UziVfmsFkNY1nzmCxzD
	 6OMMMm5eh4oGta4lbmbJjr+wRbbM1HwPvKo4fBMTNOTPfQTBgW7kFNixBnMupdn/7R
	 W9mbceM4x39Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909064448.1004-3-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260909064448.1004-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:54:25 +0000
Message-Id: <20260909065425.84C6C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> fixup_irqs() re-injects a pending interrupt on its new target CPU by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly. When the outermost chip does not implement
> irq_retrigger(), the pending interrupt is silently dropped, which can
> lead to lost interrupts on CPU hot-unplug.
>=20
> Keep calling the outermost chip's irq_retrigger() when it is present,
> but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
> up the interrupt hierarchy until it finds a chip that implements
> irq_retrigger().
>=20
> While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
> now set only when the retrigger succeeds instead of unconditionally,
> which is harmless today since apic_retrigger_irq() always returns 1.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064448.1004=
-1-namjain@linux.microsoft.com?part=3D2

