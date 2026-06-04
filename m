Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233D3EFD24;
	Thu,  4 Jun 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575456; cv=none; b=mppqJ+/bO8yXytMXPrrNo0nucPxCLHFr/+gfw22YpNasC6IF6JXQggGdf2OVEiy7ZydbRWAnvIGaYdxJmfywUQcvtRd+IxX9hgBD5AfaunU9QAz1INhAtpI/L0ppEEOI+ghMEm+XnLkpU1/ewObjKOvM2TVa90dSQW4YMqief4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575456; c=relaxed/simple;
	bh=jy9wNXrlbzwxZ9O6GecZWqZOM9Gp0gZ/hrygFvd2E+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiGLvtqXo9Nk6ToTat433fT1Lyw/cBjb9az3DNZqgEaLn5yUv0TJ2fmExypwEBvly14XHpRwriN9YjbKve+3UmxelJbfkH1K5fCxRvHUctxw3vSVls5E6uWnicaSMLmRz8Ei3U/Ik+0U71kQaeXgL4DBHdJkb3dxoBQI2ke8WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJT1W+a7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJT1W+a7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7A51F00893;
	Thu,  4 Jun 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780575455;
	bh=6tcDaEhePlIudWCcnW0SAhasLmYK5dwxdEw+RSf4P8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJT1W+a7yBFj5f0F08Rf3p+a5QNdyb2ZOlFDLriNmO2DidwrP1SwEKpexjiYGbXtI
	 mrg493otE2WPbKmxOLVcQEDVxAX81TPqkPR+YF4hP2pW2devqPit639cMGJgjtMQU2
	 AG5qUsLs7SRJ21lXhntgVzwUiRdBV+CiXRLXYlK6qyIFJt6HP6BjhjpLKcTCpN1C2j
	 MdccibZC2LGohJqgT2WVSxIER2+5wQcA79GHLyl16IhYbrBbCKfylMKEou3aoGT+1W
	 lAJpv/fbjL+hlGx0tzVtdTaV/qtZTay37HLuxRbIdBk7BuKOR6T5UqLLfSh4toAoP4
	 y4lbtqS/nGtOA==
Date: Thu, 4 Jun 2026 15:17:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <aiFs0OLJQWtIbJEF@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
 <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
 <ah_z3GV55RY3ZnT-@kernel.org>
 <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>

On Wed, Jun 03, 2026 at 10:25:58AM -0700, Jork Loeser wrote:
> 
> 
> On Wed, 3 Jun 2026, Mike Rapoport wrote:
> 
> > On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
> > > On Sun, 31 May 2026, Mike Rapoport wrote:
> > > 
> > > > > Patch 19:      Export kexec_in_progress for modules
> > > > 
> > > > Isn't there another way to differentiate kexec reboot?
> > 
> > There's that "kexec reboot" string passed as the cmd to the reboot
> > notifier.
> > Maybe we can make it somehow more well defined API and use it?
> 
> A string? Dear my - the compiler won't flag it on an API change then, not
> ideal clearly. What's wrong with exporting kexec_in_progress()?

The policy in general is avoid exports unless strictly necessary.
A string can be declared as const char *KEXEC_REBOOT = "kexec reboot" and
used in both kexec and mshv. Not ideal, but still better.

No strong feelings from my side, just EXPORT_SYMBOL there felt a bit off.
 
> Best,
> Jork

-- 
Sincerely yours,
Mike.
