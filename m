Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C22EC0B0;
	Tue, 29 Sep 2026 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654852; cv=none; b=hv7nK6W6XDrIC6sUk1w1PwEBfJyYHJkPckKXu0a0JG+KzDzCfPUE+Gc1l//SxDp0LX7Rd5sAm83L3+3G6B0Bvd4+LYKMzQ1wz3T3yVpprCDZDrAxPgd92flt+wULv8dzaUmHLJOqSiMtywtsRAFSxdaHx71ZXAxo0NGqDkWxwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654852; c=relaxed/simple;
	bh=crCtZ7CecKyaHXuZbE4l1lC6XfpePggSKLsixRqdgXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rDLzuRyrxRnw6Xet0psulxJG4hXOsRYa3Pec7ZD1vtn4vnO/9TzqYNuHV/FigwklxaD2ZggkVNdlsiBXMqExfsLcXKHosUcSSEo8ffrVjewmR7nFoxmLur0Va4oWQWyKLLArzzgVzrXN9KLbBAKpWtWH73jUT4RnCQ2rzbwWURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPaVz+xP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPaVz+xP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF31F000FF;
	Tue, 29 Sep 2026 04:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790654851;
	bh=crCtZ7CecKyaHXuZbE4l1lC6XfpePggSKLsixRqdgXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPaVz+xP/dH9Y2KEuSVxT5LfyCKT8q0o2QbqzRLBZKt61/YalBn0AKsJh4akF/Uzp
	 VgxA0Mrkt5uLPU5ibYNvb416lX2fsn3TdsWNL3LUD9NQI7fKPaDT85KCELcc9XIrVr
	 yzrYgaW64GZTo0gC6wTGvMIgUiCy+rB4gsjbtNjhAxZrD9wDGsS4ICI1LVkdw33pPr
	 n1ltdCqdCOKihYZRWeQamGzVmAC45kIdM+i4Z0BnXpYqhxpzBnxs9J+pyOfeGha6O6
	 +0n6ybCXdWLA87BMTn5G18buyY/KhqjhNKLUkMryCqjFbVfbJ5BIJsuKnHQuCZVU94
	 qhX/eHrdGyg+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] x86/percpu: Require embedded allocation in
 encrypted guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260929040256.543767-4-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-4-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:07:30 +0000
Message-Id: <20260929040730.DFEF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Early sharing needs direct-mapped per-CPU storage. In TDX, a private
> direct-map alias of a shared page can terminate the guest, including
> through load_unaligned_zeropad(). Require embed rather than adding early
> vmalloc conversion and alias synchronization.
>=20
> Warn when overriding percpu_alloc=3Dpage and let embed failures reach the
> existing panic. Restrict this policy to encrypted guests, leaving host
> SME allocation unchanged.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqvxQoIoYhJTZpAC@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D3

