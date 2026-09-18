Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2344CDDF9;
	Fri, 18 Sep 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728516; cv=none; b=KWyEwL9vJ1pt7W4cCrGg+TOwMnm5yGBdtA9dNcdRrImbc9rfMyQp3NZSy/BKEXwFkFH6tURDVfCo+SkaoXpdMdJo6+O8Omt65rgi0nvKNdvMTdpkC97fF/U3QKF/iWH3hI+FqQiEsRgMdaDIugi7cv9rLs8GqybFaPhX4rzoxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728516; c=relaxed/simple;
	bh=2bc3TgRLj8raO/M9/O/ANshCkiowC3hyRqaWmD+yCwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej54rYcSr4e+shc3B4gT4o4WEkt2199L5+NyCIEbQEa0I+sW1OmFOeFvmRt6CXnHiyC3Sstzmiqc869pl4S7hU/xzanNbnG/0FCtyaZgvx0ej6am/I5K4xmg2Wpc20JOWv3NH9cigmbNQ53bU3jD+kTbCuilg4g+Tsb65i8fTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ifBVYNZW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ifBVYNZW"
Received: from example.com (unknown [167.220.208.36])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1B4B20B7166;
	Fri, 18 Sep 2026 03:47:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1B4B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789728468;
	bh=I4R2G5IfeYbw7m5Y9d+ubIdH4R/mL1LHup49Y12Tbz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifBVYNZWWuD96/TL+c33M6pJ/oZsLa5gFg6sGztsa62TkMgHzmTAun//TBWl+f3u+
	 r4kG+B/gWgXUUkCufrt+XnLHu2asEbSR3y7DClVK6UPJF3hkgtKAnU8kWD0v7pS7Eq
	 m/lReY51OpWs617vApLTe5Fyix6F8kby3kTMuZ3M=
Date: Fri, 18 Sep 2026 12:48:29 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Message-ID: <aq0W/c9SKCympVHE@example.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <a543145c-4503-bdd8-bd73-a2cbcce1e06e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a543145c-4503-bdd8-bd73-a2cbcce1e06e@linux.microsoft.com>

On Thu, Sep 17, 2026 at 05:23:15PM -0700, Mukesh R wrote:
> On 9/17/26 13:10, Magnus Kulke wrote:
> 
> FYI:
> 
> https://lore.kernel.org/linux-hyperv/20260912000318.2959621-1-mrathor@linux.microsoft.com/
> 
> Thanks,
> -Mukesh
> 
> 

Thanks, the change to a larger single page makes sense. I assume we
would still be susceptible to a #GP once the kernel steps into it?

Since this is addressing acute crashes on L1VH, it would be good to
merge a fix first IMO. it can then be easily cherrypicked into
backports or distro-kernels.

Or would you rather see the problem addressed as part of in your
deposit-pages refactoring?

best,

magnus
