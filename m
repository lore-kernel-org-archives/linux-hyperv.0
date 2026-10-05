Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10943E9FC;
	Mon,  5 Oct 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197935; cv=none; b=aHaFlZkTmKVDa5yLVLF8An64xDPuEZlr8X9gOSHLNmUCu8nWOLqbcfyX9ewUWfyi0OHDEZD97v8N8QvnsnRfxZtiKr+HFluhwtvu9vs2la+/7fv74V/cCvpNgWgRqniX2YLRth+SHlkYn3lm55k+87HrK4t/lQza9B6gP2gh1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197935; c=relaxed/simple;
	bh=XKivEEfqJ1Loxg/zjvRlcQxbdujmDiM0i6o6RGWb0X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy6oM5o478XnI4EZrKO1EHE3hYb6N4aG2PNOH9hI6L6Kdp3KIVP2OimPW2LYls8BDgVZWEbpJ7wvkivNm79fbs0b8Hy3lwLLbREyDdjhwyfgrcL1kBReRMcbedebIR2Xwv98tf67uQbqb8rwnj1hLH5qHs9Jwr+N+4BtzI34OmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Z7J/MNr0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z7J/MNr0"
Received: from example.com (unknown [167.220.208.46])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2BD820B7166;
	Mon,  5 Oct 2026 03:48:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2BD820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791197340;
	bh=bOV1KkbqIPodySJYR8HJdIIEeWJmHDi+JcH9/BuX10U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7J/MNr0Z+/8N6JcXho3uzFWfTC8ak5iHhEr/WXHDfYyB7OKrmrNPjGig6cPjHQed
	 wJf9dq0hEYjlpStr10GQg6Oes0mW9u2acxH7FP4SgWVzooYRdt2SAPWdVfSUalNj6j
	 3J0I7gap/hd01KLpVeLYmG4C76lOBl3LFZ+0kwTs=
Date: Mon, 5 Oct 2026 12:49:49 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Message-ID: <asOAzTuyT3XxeRK4@example.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <SN6PR02MB4157B2D3C47289305C6E487CD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
 <arzzghes/vN/1WSf@example.com>
 <SN6PR02MB41576BE36A94FC74D3C4687ED48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41576BE36A94FC74D3C4687ED48A2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Oct 01, 2026 at 05:10:14AM +0000, Michael Kelley wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com> Sent: Wednesday, September 30, 2026 4:33 AM
> 
> I went back and refreshed my memory on the discussion from July
> 2023. At least on x86, the faulting address is used only as a sanity
> check in ex_handler_zeropad(). The #GP exception handler already
> calls fixup_exception(), but it calls with fault_addr set to zero, so
> ex_handler_zeropad() always returns false (i.e., it says it can't do the
> fixup). From looking at the code, it appears the deposited pages case
> would "just work" if the sanity test against fault_addr was removed in
> ex_handler_zeropad(). There was a past discussion about removing
> the sanity test [1], but at the time there wasn't a strong reason for
> or against, so it was left in (having been added relatively recently in
> c4e34dd99f2e). An option for the deposited pages problem would
> be to make the case now for removing the sanity test.
> 
> I haven't looked at the situation on arm64.
> 
> It's your call on how to proceed -- I just wanted to make sure the
> full context is available to you.
> 
> Michael
> 

Thanks for the context, that's indeed helpful. I'll discuss this with
the mshv team. I'm still leaning towards disabling deposited pages from
the direct map because this seems semantically the right thing, but
Linus' statement gives some confidence that we can make the fixup work
for #GPs.

best,

magnus

> [1] https://lore.kernel.org/lkml/CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com/
