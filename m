Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D83EA66;
	Sat, 22 Aug 2026 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359547; cv=none; b=Dzc/q885EJ98kkxhJBjfLocBwusUAGNIG210BxpyxKUGvlfdOiFyqKC/cpwW//95NyJUUyuKbQckM1ON7aKBOMU9TSJ5ZzEuR1t3dnCO5+4cWWoV3dDI2xU1v9GborsNAOfwn26l5J3QIGUOZuWFKdwhiCfy1d+phym1bXsaeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359547; c=relaxed/simple;
	bh=I/K27TrvKYqd7KBoUBbO4NGwTUEmp4Vx3utPyzDcJCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNRTdEdMto82rG4BHTCiyNLVfL8FLxCGncKcXBAZ7f1CHme1kydvxYugxww6P5d3QfHM2qqghslqAwP8OO50bHkeOvkzGfGfu0HCLbsYzv84SoSuabUhxFlyd6OQgxdAmpkJ9QUSXOcaj3qxIdio5N13AS3KgfCZBj6fufiwpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMBpjXFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMBpjXFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2BF1F000E9;
	Sat, 22 Aug 2026 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359546;
	bh=Hp9ijSfZ/AxFutmHDg6af1uXPgGWceVOECylATnG2IY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMBpjXFnNeKfqX9huaKyBGaRYRufybLM0/S21Ec7+xtcJn/PIQG/ZNjxXu5SMRdwC
	 0Cw568uFZx0OLjIDnJbZzBaDzbDH36D06kGjHE3oT7EQF+DLhIEEPSaFjq7Z1bTluN
	 k0vgxva0n8+t9Tr4LxUePijLqbVb5m/+LFxuhuCvrwh0YmGcEhom4aNrs2z7nYPa/E
	 FxI7mPvapBLRUPO1MtavloOND86xw/CQuqqpMVSFi3VEdsNUtJ+mbx2cAzjVQ9yTqK
	 YBpK905WNd8AXwzt1zbKflNQoKfYb6WMP3s1xA73p3qt27PGZIRiN11tkqvYZkiFu2
	 470HV+Gjb0aQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: hv: unmap MSI interrupt on the nested root
 partition teardown path
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260822003623.2925128-3-wei.liu@kernel.org>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-3-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 00:45:45 +0000
Message-Id: <20260822004545.DB2BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> From: Wei Liu <wei.liu@kernel.org>
>=20
> On a nested root partition the vPCI MSI/MSI-X interrupts of vmbus
> devices (e.g. the MANA NIC) are mapped in the hypervisor with a
> MAP_DEVICE_INTERRUPT hypercall.  This is done from hv_arch_irq_unmask()
> -> hv_map_msi_interrupt() because the nested hypervisor performs the
> interrupt remapping and a RETARGET_INTERRUPT is not usable there.
>=20
> The mapping was never removed: hv_arch_irq_unmask() called
> hv_map_msi_interrupt(data, NULL), so the returned hv_interrupt_entry was
> discarded, and hv_msi_free() tears the interrupt down with a vmbus
> PCI_DELETE_INTERRUPT message (hv_int_desc_free()) without issuing
> UNMAP_DEVICE_INTERRUPT.
>=20
> This has led to MSHV rejecting already-mapped (vp, vector) pair from
> being used. When this happens during early boot, the system hangs.
>=20
> Keep the hypervisor mapping in sync with the kernel's interrupt
> lifecycle.
>=20
> The mapping is only created on x86 (hv_arch_irq_unmask() is a stub on
> arm64), so the unmap hypercall is guarded accordingly.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822003623.2925=
128-1-wei.liu@kernel.org?part=3D2

