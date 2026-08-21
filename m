Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB8308F2A;
	Fri, 21 Aug 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319200; cv=none; b=PaO0ryyItq+ooGYpmUn+/A8DDK81fJizKSNMS5lRymeGSGUrblWeA8oVt4nn8aMnb4mocYvjSRqOZWetMz0AbWkrWdrkbUZqQj7NNH5YrvoUY7r2tiQGM413UPFrbcNOyhT53mccmVwB6f7qYC0yjeWRgQrWB5OvO3fBS2uhlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319200; c=relaxed/simple;
	bh=/+O+vX/Sq3RKb6c3hppYL0QFeG+MaPqYaOfQz19FSuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3A6DkEvieyG/UyYCDyLAuF5PfAxkgeXEp4GxCuy1w3aI5d58nmieeNX+rw6DbnbaQFESl8TkB9s2F9EvLc62b+GHBJpT3iy3mdrmYjNcYKykxyeGcAIu3oUqrjFXc40uWRM5ONYJLMn3ZSqQM/NWrLke4O1CbyAlK7KfxDt2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myTa3Ven; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myTa3Ven"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E047A1F00A3F;
	Fri, 21 Aug 2026 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787319199;
	bh=/+O+vX/Sq3RKb6c3hppYL0QFeG+MaPqYaOfQz19FSuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myTa3VenD57/RkzD5NM/HCKPIeFsThLchmzwXijU6RZgwSdb2WzAOZPOZqL/OQZEp
	 Dw4h96T1hofIRxKY3LBVi1rgjOKGVIZ/y8dEdDwbJjoQgpdoltFZodNAlxfZqSC8UM
	 wiHP8JVbdYXrLWZGjgstvirbjYfzi5l4PK5FsM3fOGl02I6WK7PvwGfvkgqCLwFpCU
	 ZHvJPN1czw6OHVwyfk/QbxdzmnRqpNQgTsmFZ6M6rHl0NwesRgkB88/82PmwSweEkb
	 AH1ycZX3ZWsdCa8WmMAeXMIsTvRXPPXT+nmzoiS2s5Q6/6Eds8yBL7MqTU+6LEwOR7
	 /UH1//xpvXZnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260821132654.211730-3-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:33:18 +0000
Message-Id: <20260821133318.E047A1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Hyper-V identifies each PCI pass-thru device by a logical device ID in
> its hypercall interface. This ID consists of a per-bus prefix, derived
> from the VMBus device instance GUID, combined with the PCI function
> number of the endpoint device.
>=20
> Add a registry in hv_common.c that maps a PCI domain number to its
> logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> prefix when a bus is probed and unregisters it when the bus is removed.
> Consumers such as the para-virtualized IOMMU driver look up the prefix
> by PCI domain number and combine it with the function number to form the
> complete logical device ID for hypercalls.
>=20
> Use rhashtable for the sparse exact-match mapping. Lookups copy the
> prefix while holding the RCU read lock, and removal defers freeing the
> entry until existing readers have completed.
>=20
> The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> that pci-hyperv's interrupt retargeting path and the registry use exactly
> the same byte layout. It is derived on demand from the constant hv_device
> instance GUID rather than cached in struct hv_pcibus_device, which is
> private to the pci-hyperv module; this keeps the interface narrow and
> avoids depending on pci-hyperv internals.
>=20
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821132654.2117=
30-1-zhangyu1@linux.microsoft.com?part=3D2

