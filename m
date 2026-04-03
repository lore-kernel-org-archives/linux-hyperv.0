Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774F2D322F;
	Fri,  3 Apr 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188796; cv=pass; b=FR/oL/pBfyByZW+Ys4SOmVEVHwrnLEWnwMV4UVeqDywyJqpZWTeQdz0ZyPigkF71BH825MAoAJr5gUkGkIaWzH2VT6YzA4LW3PkjDffhThU8AgDbE3TNJo7THbF9ak2dChgk9/Ar2TxFCSEIER6JGt/My0ezsQkdurIaTr7g7mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188796; c=relaxed/simple;
	bh=JJ+E9RBcexzvFKrkbySwpGTNaAIhW1yHXVRgKhlcLNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H25d8RhOS86rTScvP2VCEN3khagpiRbuqhHeX4VECawSCrs29DeOkwegAYlOfQwQOAsmW+ydnTViweJmHYUWTfS4EU0veslf1W0wrEGhpIFHlqWvkZvI1lnXzxLmJxt+9yK2/7QgPBRWn+wJ66CwZluA0Fx4xRGBntf/m+364dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=zRc5yDnM; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="zRc5yDnM"
ARC-Seal: i=1; a=rsa-sha256; t=1775188766; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cnoU0sVU152h7Azs+Yt71cqz28ovvA55/L3b913DcO7wU7bs4v6hkEGckniStIBRw3zdjK8hAHZGUt/VlfSwAVm0a4zgGKqiMkfhXqlizLkWNHE97hmPyNEwBo0O+vn0boeXkyOrkIYVPuRG9ex3l4muUmJDyAwtAx/pk+b54ko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775188766; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=de3YuJ+lxwVdkMrhXpj2VwoVAaJPrAVJoSI7db/terU=; 
	b=VnxS8L0wRsbqc9y0S7p6z3VA/CVuKyAKuhXKeGpjqKmFV0GhE92lRLczT+0erE/LiTEq6V/OC34f/4utJtKmyKakm9AVr8Ok3CCPTiXu725rwbosJqlx7nbzOdd1/QPqMBFETV9cfsIwIpwkE1in0tZRaAR0H6YKddScQJaD/G4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775188766;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=de3YuJ+lxwVdkMrhXpj2VwoVAaJPrAVJoSI7db/terU=;
	b=zRc5yDnMapjEKm48SNgUUK/LZ0b12KSV7iGUGGtTnaChQbR8w9SY/VMNXKq4EW3G
	F3BXWaKH+inILwURiCDiCtVnGv3ysnPfV7ILPi+2APW/NrL4yoC85NmviB581b1fqhg
	ep/w0DR2clvMs+rrMKdavCv6ZR/TjKxuMmr+HU4M=
Received: by mx.zohomail.com with SMTPS id 1775188764057860.7861426283346;
	Thu, 2 Apr 2026 20:59:24 -0700 (PDT)
Date: Fri, 3 Apr 2026 03:59:16 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned resources
Message-ID: <20260403-stimulating-coot-of-freedom-f87138@anirudhrb>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-5-jloeser@linux.microsoft.com>
 <20260402-sturdy-chirpy-cat-78baeb@anirudhrb>
 <b9681d7-6166-e7cf-feb-b924c583cdf@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9681d7-6166-e7cf-feb-b924c583cdf@linux.microsoft.com>
X-ZohoMailClient: External

On Thu, Apr 02, 2026 at 02:21:43PM -0700, Jork Loeser wrote:
> On Thu, 2 Apr 2026, Anirudh Rayabharam wrote:
> 
> > Maybe it's time to extract all the synic management stuff to a separate
> > file to act like synic "driver" which facilitates synic access to
> > mutiple users i.e. mshv & vmbus.
> 
> Yes, such a refactor maybe warranted. This series is about getting kexec to
> work on L1VH, and so such refactor would be ill-placed here.

Well, the limitations of the current code have been exposed while trying
to fix kexec. So I would say this is the best place to fix those
limitations.

If you're intending these patches to the backported into stable release
then you could first fix the issues and later patches *in the same
series* can do the refactor. That way, the patches that have the actual
fix can be backported and we can avoid backporting the refactor.

Thanks,
Anirudh.

