Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520183D47D3;
	Wed,  3 Jun 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478956; cv=none; b=cJbr7VWub/D82YUwQMylrTkyRUOl1R60SzzIQbtoXFhcmlR+g0e49FUScQ/if1IwzoXfZ4p3O8Aa0W1H7QwB0sEMg7gcTDteTDTCHtRd2YPIreeLebzZGr5UPeAUMhHJfF1C7ZB94tS6q/hXraiVJXFeNpx93c9TunvsiXyvdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478956; c=relaxed/simple;
	bh=RSKvbcirYIxSnbcLto+sMWhv/k/dNeDONYdaBoCfufo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug8uUloP6ANPAN76zOOXx/N84G0tZyuz1PJTEq5WLM7WoL6e2mfiJdMg+ITwM2aTyrJ2I0jgaxjd20GRkYhtqdXToHGmZY5ZfxCjp9vRXlwdgXvOjqeM3MC+NnV8aEpI6tYyEso8aO6/h4rvFAM56O7Q8WacWI02aEvUIyDZdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aROTsNtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aROTsNtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B8A1F00893;
	Wed,  3 Jun 2026 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478954;
	bh=0YKYxaewRvA3lfBC/tETR3ZEPA7XYWmFAA/XZnPbico=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aROTsNtP0NwcPyhOGg9EN7SaKgxWgmBik4nkTEgxduPxK5HRWw3N84c9Y+ACmVTN1
	 wgGQ5LmSO16hd/kW00Z44oqbucTBUZSCI5qkU4XBMgLuDQlQoPU5Q7drqrxWizzv3f
	 rrWFolACkQfVjWy8P7nyYRfKI3cGxZO78QELntbROjZh2g+LwBwdTl5Zzy83wMh8Ah
	 +jsOcKbtZk9aA7P96fnDV/449Ef6mxs1KgAP+RaMN8fr1epn59jCUIuT3pzqyXrl2/
	 Cty+iU235/fJlfaqEQKiPp5aeuN6LGB+fM5/HMK485/qyjL0EeNknVF9PU08lbGj8F
	 jYzXoc72/R2Ow==
Date: Wed, 3 Jun 2026 12:29:00 +0300
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
Message-ID: <ah_z3GV55RY3ZnT-@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
 <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>

On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
> On Sun, 31 May 2026, Mike Rapoport wrote:
> 
> > > Patch 19:      Export kexec_in_progress for modules
> > 
> > Isn't there another way to differentiate kexec reboot?

There's that "kexec reboot" string passed as the cmd to the reboot
notifier.
Maybe we can make it somehow more well defined API and use it?
 
> I could not find one, unfortunately.
> 
> > Sincerely yours,
> > Mike.
> 
> Best,
> Jork

-- 
Sincerely yours,
Mike.
