Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D51472098
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Oct 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932435; cv=none; b=WuQwI9gT0ZxdWrv+WhsK86FUfFg/5/Z0xdA+iqnxUOGzzS3NFxIwwVbPpRB5LQnoY1ZlllwEm08hd3MRx9px9XqJpAT1o7AKZBM97eSVMr/wV9C1sTQXeMt25+mFhOJc4eCUZuDGP2Vva5yrQrBlUFvEjmXGR/hXhK16t2zBcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932435; c=relaxed/simple;
	bh=JwQAQDYUVHe+Rx2lpOEju2szZcxiMsC0yeJLsl/L97g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRQWwqng5j5fQnzhctPaoMwUO8xsrt0pbR5pBBBpwXCtA3oCiZzGB8RtP/XPfzAK67ALwSTVGB1G6RWn9P+bPjXT7gV0gpnKjFfKlywXrFUAizMDGGv2XNLbnFhH8nlxMiWUShQKmKOf6oO0E2BiFwhciVhqJVXC3rQgg91jpO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEcMww7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEcMww7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41471F000FF;
	Fri,  2 Oct 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932434;
	bh=JwQAQDYUVHe+Rx2lpOEju2szZcxiMsC0yeJLsl/L97g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEcMww7/pZLVxFe7mP9aLTA02cRiyK+0L2vhNo53ZamZyNIdymnbmNdJEB3ZrsP60
	 cF8OVamNxo+8cMX/g+kaNALuW537/fi+lvcASO9q7pqsyU4mU0+jvuTbleJDUHhgN2
	 BJDTHWlaLAy21L9zHBmcf3eP4PsM7zOuqtncgq0Zas2/Ye4NPGsaFBu4Ti+jgd5cpJ
	 u5aIvBqDNOwortfmusG0gsXToFCZw6xPy5DLlsBzbtu+OVznPvZgaAK9/pV89he6Kg
	 fHJo6gK4gcZiNYqlbP2ttDPDHcHkheTn/fvXN3jmaWNJcqc4p70mEdJDza1U/6IFbh
	 WoXzduBhnm1Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261001220552.1793471-2-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
 <20261001220552.1793471-2-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:53 +0000
Message-Id: <20261002091353.F41471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] docs: commit message incorrectly names modified headers
--

commit 12e4ec5d9cab90f44760cb6771af64451e5a4884
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: rsi: Add RSI host call structure and helper function

This commit adds the rsi_host_call data structure and an rsi_host_call()
wrapper function for routing hypercalls through the RSI interface.

> Add struct rsi_host_call to rsi_smc.h, which represents the host call
> data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
>=20
> Add rsi_host_call() static inline wrapper in rsi_cmds.h that invokes

[Severity: Low]
This isn't a bug, but the commit message states the structure and wrapper a=
re
added to rsi_smc.h and rsi_cmds.h. The patch actually modifies
include/linux/arm-smccc-rsi.h and include/linux/arm-rsi-cmds.h instead.

Could the commit message be updated to reflect the actual header names being
modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001220552.1793=
471-1-kameroncarr@linux.microsoft.com?part=3D1
