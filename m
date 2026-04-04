Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7EF241665;
	Sat,  4 Apr 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775280368; cv=none; b=qmErxf+2icR2vZedYkfnJFC+a6WkavzmoDAzvZMHfs7hPmkdjCahCAa+1JbesfmYiOrjtgx7Jgo5Qf7G5EeczGgBUTxcteJY5+3ZU+c75gX1nCdzorP0RgK2Wc9mdHfcD7l+IVKPhq/LGQSnpENchDhWEmbXc8K73EVn1L+eGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775280368; c=relaxed/simple;
	bh=x0JFniCNdFcx1m/4JBs+AprbtiEajn0gXd+Whtb2Swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBiFRcgDVyV8tN/RBxCOc6Sd26rLm09Ksy7aGZCuGi7puTFTm5Tyo4QmaVRvcUGO1OMMe/mP+6FRqxYq7mEDzdqa6vjgPJdyZyCG/A/zuV8+nTy8UrMSmg8OZHRBKeKT+AqiRBkOBqxqGxM67ufHMC72a29sQzzLa6JIXBTcWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pntII+CE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pntII+CE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272EBC19423;
	Sat,  4 Apr 2026 05:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775280368;
	bh=x0JFniCNdFcx1m/4JBs+AprbtiEajn0gXd+Whtb2Swk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pntII+CEf+ZR/mTmMtZxkXq9Un4oiBvxbOiwj23NhXT4ZkAakCtYxou39bHmFDdIf
	 MvGOKeQJ4efxcBnJNMeEUuMcsaIPWjetmnj9eT5z6MCpxvaY0wJBTmGqQKsXJkoVFC
	 NFdHarEolEtRibPH/TSueKDXCYs0BUPsY8xz56n6zOc/As6yneJIS7Wr4u6c/Ud1Mn
	 yig9aWGXeIBbPxk0R1GyFz9iysU+WFIGf9WtMwchhKGHdmi4CjY360vK1T1LHDQb9r
	 tCPT2552d9A2rCxQ2Mnx+9oM5ZPrgJO4bj9daZRfAsVIc/2UoH91esP8L+1ZbqOed2
	 pel5lvnSUSoaw==
Date: Sat, 4 Apr 2026 05:26:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix infinite fault loop on permission-denied GPA
 intercepts
Message-ID: <20260404052606.GB60588@liuwe-devbox-debian-v2.local>
References: <177439665824.171668.3582744847973205980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-rare-heretic-tench-adfc68@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-rare-heretic-tench-adfc68@anirudhrb>

On Thu, Apr 02, 2026 at 03:44:58PM +0000, Anirudh Rayabharam wrote:
> On Tue, Mar 24, 2026 at 11:57:40PM +0000, Stanislav Kinsburskii wrote:
> > Prevent infinite fault loops when guests access memory regions without
> > proper permissions. Currently, mshv_handle_gpa_intercept() attempts to
> > remap pages for all faults on movable memory regions, regardless of
> > whether the access type is permitted. When a guest writes to a read-only
> > region, the remap succeeds but the region remains read-only, causing
> > immediate re-fault and spinning the vCPU indefinitely.
> > 
> > Validate intercept access type against region permissions before
> > attempting remaps. Reject writes to non-writable regions and executes to
> > non-executable regions early, returning false to let the VMM handle the
> > intercept appropriately.
> > 
> > This also closes a potential DoS vector where malicious guests could
> > intentionally trigger these fault loops to consume host resources.
> > 
> > Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   15 ++++++++++++---
> >  include/hyperv/hvgdk_mini.h |    6 ++++++
> >  include/hyperv/hvhdk.h      |    4 ++--
> >  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

Applied to hyperv-fixes.
