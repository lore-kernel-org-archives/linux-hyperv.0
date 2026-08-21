Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5813DABE3;
	Fri, 21 Aug 2026 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307311; cv=none; b=LFpGHG/QAPhgir/0Edjf2ZuwXUkkpXS+rl0qy3EvsJIFmhOZ8PM/PRgUSOhpTKqiK+rVq4+ol4JqdrfwABcmCHrZfysV0R77rkw0cfwVHsmWtt/DsiGChePHcagKNuE+7Mz/mUDvTXOLZC2PF1mfYGS1uHtyuiAjvFzXR+t1vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307311; c=relaxed/simple;
	bh=x2PW7k3TwIFcVb0HgB/a2qRx2lQJd10nFtvVhrzqC8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuXxUTqlQx8JV3irVgq6oeX0xWojOoqYVg7QzmuTz05n2a8nVJFxOOP5TvX+eSU4SQM0xVAkGqRcQolWRhIgIm3uhmAKrX6yFORXSCfmMyad/8mofdGk5LZUXVNUfNjfHejJr7ZKbPXdQtC4vCiSQFWcFstIuFmqV8SGO2/ovBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FuYRMiGd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FuYRMiGd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4920A153B;
	Fri, 21 Aug 2026 03:14:50 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E803F66F;
	Fri, 21 Aug 2026 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787307294; bh=x2PW7k3TwIFcVb0HgB/a2qRx2lQJd10nFtvVhrzqC8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuYRMiGderCL7nMqslzfHOA6euy0UBOD1xqRTMH9+k081cdWWc08S4DdYXjkt+Sal
	 boFmmz6ePE8ZDTU+icV/5pr531uWUWcQXyMj2Wc5+zy1PRn5+91yD8wOHdNoP4RuA4
	 x8vzVwd5pN4HQ78h03aRbZpZZ0ZLjboqoXvsE7kc=
Date: Fri, 21 Aug 2026 11:14:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [RFC PATCH 0/2] arm64/hyperv: Enable kexec reboot support
Message-ID: <aoglGZD7ntLJkmcO@arm.com>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>

On Fri, Aug 14, 2026 at 02:31:28AM -0700, Shradha Gupta wrote:
> Kexec reboot consistently fails on ARM64 Hyper-V guests (Azure VMs).
> During the kexec shutdown path, VMBus channels are never cleaned up,
> so in the fresh kexec kernel startup hv_acpi_init() blocks because
> the hypervisor still holds the old kernel's VMBus session open.
> 
> This is because ARM64 lacks the VMBus teardown that x86 performs during
> kexec via hv_machine_shutdown(). On x86, machine_ops.shutdown is
> overridden to send CHANNELMSG_UNLOAD and disable SynIC before CPUs
> go offline. ARM64 has no equivalent mechanism.

I'm really not keen on such hook, a bare pointer you set elsewhere. Not
sure it was discussed before but can you not use the syscore_shutdown()
mechanism? This hook got added in 2023, so the 2022 discussion you
referenced precedes it.

-- 
Catalin
