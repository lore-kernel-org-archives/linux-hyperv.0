Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB546EC63;
	Tue, 21 Jul 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659440; cv=none; b=XykNgO//7EGBhqPblvOpwbEPfoZCd5szoKj/4P6mCSEe4ytLPmXEUoQ0cp0eclEAoKXKlwk/zQof8cbhdhjpn7bROKUwjkaSIDRVvnzf0k/2qs9WYkgxJkAWnywoZMDAEl0opauDxV5zAIAoOW/lxGOPXHWtQPC6PMru3m/mGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659440; c=relaxed/simple;
	bh=M2wh6N7iaDHuYoflXitGnoC0cg73rHloT+IjrldxMYM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DN9wxaoFZYb3zkNhEkotTUup8rgG8pKx0QdMgUt8jGC+3dtQxweJSJr7MVmbm9V6Wv1bMkMDmEPfKk7kCS4XyRPXUpmBBr6+Vych9XSvmfoNV08DSR+RJD2p2MSZXWJDU52oBfRm+0NA/8zFuImeMKtUqdTmDmV7p6v5EJ/VoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ze/xJwIQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ze/xJwIQ"
Received: from DairyQueen (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C33020B7167;
	Tue, 21 Jul 2026 11:43:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C33020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784659426;
	bh=Scv/WvO4zMFWVOy+23xBMZDHMzVQCUMVHduhnuFY7AY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=Ze/xJwIQJ3o+lI39zFodcg8HyXEK27JBXvyXCZgvw3xD6hw/l/A2w99p4AepYJgkJ
	 HocEGR7yEJxcstVzLB/ra6Fblf9cR5hLJUqC2hUAQKEYkUKSnUy2rRvGfG1dxO/u9+
	 EX5L+k6bo815ht4nJ7SXew9Ypn0mzQKFzKkxcAuw=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
Cc: <catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mark.rutland@arm.com>,
	<lpieralisi@kernel.org>,
	<sudeep.holla@kernel.org>,
	<arnd@arndb.de>,
	<thuth@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com> <20260625173500.1995481-5-kameroncarr@linux.microsoft.com> <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com> <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com> <SN6PR02MB41571AB004406F331E167203D4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41571AB004406F331E167203D4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Tue, 21 Jul 2026 11:43:45 -0700
Message-ID: <000c01dd1940$e3e267d0$aba73770$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEAlq3oFwuiSVNoPj5kD0Q006gIdwI/GO7nAcdUdB4Bw4q3qAJrBVH4t++pW+A=

On Friday, June 26, 2026 8:04 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, June
> 26, 2026 4:09 AM
> >
> > On Thursday, June 25, 2026 11:59 AM, Michael Kelley wrote:
> > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday,
> > > June 25, 2026 10:35 AM
> > > > We need to round up the memory allocated for the input/output pages
> to
> > > > the nearest PAGE_SIZE, since set_memory_decrypted() requires the
size
> to
> > > > be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that
> are
> > > > using PAGE_SIZE larger than 4K.
> > >
> > > I think this change resulted from a Sashiko comment. My understanding
is
> > > that the ARM CCA architecture only supports CCA guests with 4 KiB page
> > > size. Is that still the case, or has that restriction been lifted in a
later
> version
> > > of the architecture? I'm in favor of handling the larger page sizes,
if only
> for
> > > future proofing. But I wondered whether your intent is to always
support
> > > > 4 KiB page sizes even if CCA doesn't support them now. Another way
to
> > > put it: In reviewing code, should I flag issues related to page sizes
> 4 KiB?
> >
> > I think you might be right. I'm looking at RMM spec 2.0 beta 2, and the
RMI
> > can have granule size 4KB, 16KB, 64KB, but the RSI is restricted to
granule
> size
> > 4KB.
> >
> > I'm open to suggestion on best way to move forward.
> 
> The best approach probably depends on whether the 4 KiB restriction is
> likely to be lifted in a future version of the CCA architecture, and I
don't have
> any insight into that.
> 
> If it is likely to be lifted, then doing the initial implementation to
support
> larger page sizes probably makes sense (which is what you've done here).
> It's less work than going back and adding later. But the commit message
> and/or code comments should indicate that the larger page size support
> is future-proofing work, so that someone doesn't get the wrong idea that
> it should work with larger page sizes now.
> 
> The alternate approach is to not do any larger page size support now,
> and to explicitly state that the code is assuming the current restriction
> of 4 KiB page size only.
> 
> Whichever approach is chosen should be used consistently so there's
> not a mishmash.

I talked with some people from ARM. My current understanding is that the
4KB granule size for the RSI does not mean the guest is restricted to 4KB
page size. The granule size is just the alignment requirement and larger
page sizes will always be 4KB aligned.

I tested 64KB page size on CCA Realm and it booted successfully.

I will be treating large page sizes as a valid scenario. Please flag any
issues you spot related to page size > 4KB.

Regards,
Kameron

