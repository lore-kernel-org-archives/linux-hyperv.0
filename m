Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE342E54B6;
	Wed, 18 Feb 2026 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397008; cv=none; b=Ht2FMBGKiPLXABfU2C9X57hCj7XbuwRLwAOqHxSH3BmBB2Sz9wy5CoKV2OalGyGiPU82+3LUS57eSQfrnBVh49cTaC/U3BJX4OcRGKwrCB50chZ9Jk2DCtjGUZ5YfekSLpTm7IsM8DwMWv4gL4RnxbOcba6yzBf0SmfSvp46KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397008; c=relaxed/simple;
	bh=fJhCfa7IL3s7pa9TZNDAXyTbDf2+EJrmmKn//htWPLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN897srg18/YCjCV7aIvoDhli7O+RuWHixH87lGSlDOnTa0SMgNemFJ5A74v6Cab+2wQ7ukZ1Kfty/J85r2ctDe+J/PbrZFPREj2rWX66fv7nGQBzeno0q3Ou2BwpwaO/p/5QIRQGAaXGmlr5+NxBqp3LhEliJEENLhaUpZA8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKiv+DRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKiv+DRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550DC19421;
	Wed, 18 Feb 2026 06:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771397008;
	bh=fJhCfa7IL3s7pa9TZNDAXyTbDf2+EJrmmKn//htWPLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKiv+DRN3Pb9PZYB6hh5SHYWldf2AeuqhUPA2Fn0FRh+upOh1iNTMgnItdNErpARA
	 Mwhr0hopyxyDFKeg2aey0BxzPndEyKm0ESP26fgo6XUk+grfJ5vVNbowS6GKqGzvoY
	 QQ/jslHC5LqOd4rsWk8ltc+pbGWFaC6UdbsVwRuOatRwSNg2nkYL25QBUS7m4RZj2F
	 nV6bbTWdOc/hP25Igj850a9kL1pFqQpqTG2KljSyt76bHkLD8A+i7C636D0+ooH8mo
	 qSH8xKPOeYvOaljh4+Xp+Ad/d/s8FIk4TSfj9W+AqsGRYttFq3JS+Rli/OATdiwE+b
	 wHEETkpcuECfw==
Date: Wed, 18 Feb 2026 06:43:26 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/3] x86/hyperv: Use savesegment() instead of inline
 asm() to save segment registers
Message-ID: <20260218064326.GD2236050@liuwe-devbox-debian-v2.local>
References: <20251121141437.205481-1-ubizjak@gmail.com>
 <20251121141437.205481-2-ubizjak@gmail.com>
 <SN6PR02MB4157A2BE3BF643B9E8CB2B0BD462A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157A2BE3BF643B9E8CB2B0BD462A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Feb 10, 2026 at 10:40:35PM +0000, Michael Kelley wrote:
> From: Uros Bizjak <ubizjak@gmail.com> Sent: Friday, November 21, 2025 6:14 AM
> > 
> > Use standard savesegment() utility macro to save segment registers.
> 
> Patch 1 of this series was included in the tip tree. But this patch (Patch 2) and
> Patch 3 have not been picked up anywhere.
> 
> Wei Liu -- could you pick these two up in the hyperv tree?

Applied patch 2 and 3. Thank you for the reminder. 

Wei
