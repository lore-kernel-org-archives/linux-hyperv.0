Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16423B2D00;
	Fri,  4 Sep 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508897; cv=none; b=M2KlGHFTbFGN249UpN1UhaZGGCE8I7mvkv+H0b4ArEmRqckwLbG4enLEMFLHjGjDT9TtHM06r3RqIlA21eMBcu8gWxjAjuEl8NxvTg6b6D5VtJhoihfMmzR5uADH/oi+0n5KQ/wB+ZSTSb9y3AkEt8eDQdsxCBuYjfsfqrbpYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508897; c=relaxed/simple;
	bh=cGXu7sW6mF7++qc/CkOSt6RbDUdDz4GEg+wqdJM3K+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AB2/noGEfr92d+0qj9kad3h7aG8ZKzIZsVonuQ4Eh8NIfcdQa2F5Lekc/kXPOkONCPRxNN7cdxB0SW57TEmuQNyxrOo9C1u115v2eOjZQrB9kdjkSOUYjrvTdRhfbmoqd/zhoZ2/I8BmmyPcrFCRNDVkPlKY2r9YvKNSCuidtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXC1sUZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXC1sUZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554CC1F00A3D;
	Fri,  4 Sep 2026 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508895;
	bh=cGXu7sW6mF7++qc/CkOSt6RbDUdDz4GEg+wqdJM3K+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXC1sUZZG6VI27A44fIlNQRlJTEqvcp+SXDkCcaraI1LFb7IWt4LV6E5lC7ORcZxo
	 W5Jkt6Wswdb+ZoMzYNh7uvkbqc3siab0jpkMi7CotgL1xJpmGRV8yUoGagd+N5fz1h
	 BG7hRI+1kTU/J7atKZZSIS4YZXAor5ZIt8BXVtFG21L/Khq6/gWLHMPOY4+xukzKTT
	 aQrHJKMQIao3j//om7jLeAjyFA88PEHIUDVnYnhbrqqVWbZ3d8556htb04OeQaB9Iq
	 zMLGlZZIH9ayHywJSjg7zPNJrV/sikL3mQ1/nlMissMVQ9FrppkRoWZdEsbcjkSpHP
	 dhuEdeRbPzoeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904075512.174154-3-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:01:34 +0000
Message-Id: <20260904080135.554CC1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904075512.1741=
54-1-zhangyu1@linux.microsoft.com?part=3D2

