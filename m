Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629C2F691D;
	Sat, 19 Sep 2026 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859031; cv=none; b=lT6oA8SB5EbSSSbcxaKV7w4OV+E9BNIqJfvfOg/qZTlE7TpzDAU49lX8WGaftsXGVZCt1qOFZ5a6uwlyYMYjWrBKJ8FTI0Tx/9J42hzExJRj1kXracJWMj6wYKbBylOTID5lRMi4niGcfVNDnQxKjn5uXC4QFaLJIH5gIVSGybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859031; c=relaxed/simple;
	bh=7DKrcFflSjQGkY+kAERxcUVDrWjX3F09e9H8j4oosw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODclaghWC0G7xg1neMZtxkWW8j+Vtgb0CXdPlF7/xYt/vrUoyYfYqMKqH2dC3+/dtw+H5T2bF/Zjd7ZJ5W16OjrNNKUuVCNEx/LKOeq7ctz09XP5wiUle4RmszmCRN1blzBzyoo0wNMdjqJyM4XP2I5jQnAkPe87Q8B9YjvUMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXIrIXkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXIrIXkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCF21F000FF;
	Sat, 19 Sep 2026 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789859029;
	bh=MvGhrMJk8sYCvFwzsPgKj9IOEWofxy9gNm3301617hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bXIrIXkfIReFA5AgHq7kIMWVLFAgZAHE4EAUNWrkS8j/XrkLnwH5OtWWw8q8ZLluw
	 Gr0/QeE0mpPMcyk0V2YgrrFoW1qazN6QnigAwckuEjWz3XPZXp8YbPK4F3LsMIIG3N
	 AsrbKEItwSL48UrUKaPLH4mruNtr9YOJdIU3HjJs148N4mofOdpkcdM6PK5eIrRwBE
	 jfiJegL+hIYwQ5nkiiupXXxp9QmZJLaNa0fQDZGH1K5bSpmdnn2Xq5jSpUMgpyRr4e
	 dtg7kdd7cHPsctHTKHe+fxy5gEJNc3ZIvUzdSmpbmiWR75PO7tFOrReI9HoAfEqldj
	 /cMXC4JXOjRTA==
Date: Sat, 19 Sep 2026 16:03:48 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, ssengar@linux.microsoft.com,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove myself from the Hyper-V entries
Message-ID: <20260919230348.GC1008213@liuwe-devbox-debian-v2.local>
References: <20260915043150.10521-1-longli@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915043150.10521-1-longli@kernel.org>

On Mon, Sep 14, 2026 at 09:31:50PM -0700, Long Li wrote:
> I am no longer maintaining the Hyper-V/Azure core and drivers, or the
> Hyper-V synthetic video DRM driver.
> 
> Signed-off-by: Long Li <longli@kernel.org>

Applied. Thanks!
