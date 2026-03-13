Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB9282F04;
	Fri, 13 Mar 2026 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436328; cv=none; b=C017N5LEgDq0ha+E42tm7mxG+NcRbaCyW3LM4KIgmCofpRVcoaDyZ6H6IC5PddrclD/iziZw+euqHqN5pY2JsPVIuR/GRg8sDdaLbRLtU5tolqUbsie+h/u84ey5g/r8ID3qzcL0u1YTy0qJ6M11Rvb4Wk5ukmjnRWuRA8kbYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436328; c=relaxed/simple;
	bh=ca1lJHXVkoDwCAR1JjiEvUyVt2ZVf3ZKZ41rGsXX8IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmUk9hPrs6bJETy/39ZECxH4VMp5HDHfGZAlVWCwGpgQK5M/xCj5s1PCIKzAz7wOGMXGn2e0RE4sePWqdLtiQyXXOMJtdgGiEQjCKal7MhSE3wFMU9T5lVOAycobaWv/8VwXlTTLCsDg9/WUe/sEn8JDghqU/JqVsUzwXpLbx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pevssWei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pevssWei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72211C19421;
	Fri, 13 Mar 2026 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773436327;
	bh=ca1lJHXVkoDwCAR1JjiEvUyVt2ZVf3ZKZ41rGsXX8IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pevssWeir7VDOcB9sYseiQOI0WOYZIuwrENNirwCP9UhY34nDH7qrJBkhbR9OYuoL
	 DwJW1l/g6YDtOqEC/IW5a9j5nR/k162raeeovTTfYGsBm5ESVrOOzi2Z3dDax/jkws
	 sefhNcO1WbUpS40w8FyZbHkDXolrR50Rygz+pn/DdGAQ2XZWessxeJnGpl1HhMA3V2
	 EheVjX6lV+RgLrflS7SdBczBEZWqmxtrB57IQMeNyY0VbqecjSqWFp1x16TqgwEEBl
	 NH6e73rPtQDCd7PcvoLoEzjRNvaCgR8ehrmt9JXTxRjokvds0IHbj69lpUakCXog60
	 Qj+Fd9D7iiPnA==
Date: Fri, 13 Mar 2026 21:12:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix use-after-free in mshv_map_user_memory error
 path
Message-ID: <20260313211206.GA412650@liuwe-devbox-debian-v2.local>
References: <177333136886.20575.6266852562711420295.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177333136886.20575.6266852562711420295.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Thu, Mar 12, 2026 at 04:02:53PM +0000, Stanislav Kinsburskii wrote:
> In the error path of mshv_map_user_memory(), calling vfree() directly on
> the region leaves the MMU notifier registered. When userspace later unmaps
> the memory, the notifier fires and accesses the freed region, causing a
> use-after-free and potential kernel panic.
> 
> Replace vfree() with mshv_partition_put() to properly unregister
> the MMU notifier before freeing the region.
> 
> Fixes: b9a66cd5ccbb9 ("mshv: Add support for movable memory regions")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.
