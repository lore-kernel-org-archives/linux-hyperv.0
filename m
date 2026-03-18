Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B63BA245;
	Wed, 18 Mar 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832879; cv=none; b=sAC6bcAbC/h3Hcmjt51/Bid2EuSvJN1+HSn6zSNzbE13G0zkPnfOUBeeXPpUWxTrujsXss2a4yvUNJHrX9zhrRtKVtV6S/H2cRL3G9e6m9s3r7OBs4KOyM8V9v0jkKV6BP9DHP1KNOLfI7zJj2yEvVhCwgCvJOjMdeyNL+Me6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832879; c=relaxed/simple;
	bh=ZcnzSccRgWemaRvSEJusdnTlf2WSV0kWr2+WxDIvilE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLaJDX4IR5oLJWdDPIR8BwzSTL7Z+tFXDx1pZR2pnf/odu3/3bm5KITfCkA7Wr5Ach1nAcUWtfkdEqHj3aeoOqFTv4g6ryZ74L28vx/0OxZFIGYqBccxvocLN2S8E4o4ijuRSvMfyYyimuW/R2no3L+zou/Ffqlu0VWn/XJG/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUWHba/L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHRPrgMW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUWHba/L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHRPrgMW"
Date: Wed, 18 Mar 2026 12:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773832874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msnaWXopn0JQ1DZRSiTfkpbKYJZASszfyyOMlpaaMuY=;
	b=EUWHba/LR60MXGLCN+jOdETfNhhH9gk8YqyFqbO+vGuPbHiOb3V75M/ytf9cyio0ypnpGy
	Zn6wWmJ64dDtQA93cAiluUS20FqNjoqz0eLZF9BlOGkZ/R3FHu2NkIn7S3WAXi3hGIoXCo
	5UnDJJRJRoLpW+aeafncHtkN1qq/DQU5oUlFgkKXW7vPqEiMW282t5EFEUytIb5jD0jFjj
	xNctLfymbP6adW54qUV1qKiJntJJmA3mQ4Bgfx/yfqCMed+b3swZ70oVBNPFr1JpmnUbdU
	V4sr5cmW1ea9YqIejJPGxdidp1RD0sy0xdNB1PCEa5kGO//eVmkLHu0QiMpAJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773832874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msnaWXopn0JQ1DZRSiTfkpbKYJZASszfyyOMlpaaMuY=;
	b=GHRPrgMWrTgu5MMaBKcCHHTJokGW/yo9sMrbEv2kEDsgt5vOHh6nhleuehaeF5S9JQOrdJ
	4fOsvBnSCjCGN1Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <20260318112113.JDm06Hr-@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318100138.GimjldpV@linutronix.de>
 <7f248f1f-a4ad-442d-bd85-23e57e58eeba@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f248f1f-a4ad-442d-bd85-23e57e58eeba@siemens.com>

On 2026-03-18 12:03:03 [+0100], Jan Kiszka wrote:
> > Either way, that add_interrupt_randomness() should be moved to
> > sysvec_hyperv_callback() like it has been done for
> > sysvec_hyperv_stimer0(). It should be invoked twice now if gets there
> > via vmbus_percpu_isr().
> 
> No, this would degrade arm64.

Okay. So why does this needs to be done for _this_ per-CPU IRQ on ARM64
but not for the others? What does it make so special.

> Jan

Sebastian
