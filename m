Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7A34F46B;
	Wed,  4 Feb 2026 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185786; cv=none; b=ZprnFTGQl4B11ahVudG0/MArEiwfsN9QhEEyZ0IlhssA897b5hQkk57DtoEO53ZaEI+c4/wLp5mmJ0hSTyG8gs44xao1ASW81aE9aZvdwRRUXoqpL6yyTBgiLGbpdlhe7W8kr4At/CD1H2qLL88nfGcjjrUHxVXF1CEDC/IfHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185786; c=relaxed/simple;
	bh=pFkiDUxcEYHTSHVmZDlkfQCaR9e4ugRabMxphGNL1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxQmijT05mQ0Gh39TsvHpAMDqEJjIRF/fzjFpC2Gyk9KCYeXVw2p0e6IPIsjwu4Q9auYS/GFuyW/gbSOOn10m6Dx/MVdHHDZazj4OABSKU3ArSPvkSJDV6uhGYq9nTTG8huVX/qYt9PRqseZgwQn/+EoHDfdbvwZrCyH+nz0Efs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0pa0pPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0pa0pPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74B8C4CEF7;
	Wed,  4 Feb 2026 06:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185786;
	bh=pFkiDUxcEYHTSHVmZDlkfQCaR9e4ugRabMxphGNL1qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0pa0pPuZI68bgdAsZoNNBJTK46Up7irrfI4B0Ic27uGmfqnw5S4juKDLEXTTnB3C
	 9T8qf+IOYOLS9MnX1r0UC5Q6gMikW0/mUAJqjcfZ439VwFpTwKVO2wOvmTt8ObC8OI
	 Ayq4xBpHWUghfhOSpxxCmgFXl4wkxhfo9oAjiLAGp4QbgGgi4Upl/ziVbT91Ta00XY
	 vB+beaLLHP2YeGGQCU1ZhymLUnIUv3UuYFC+kgaJpKsGvAJYsHtfKzu2blldu9eUrj
	 WwmkI/wr32zy+iX0bDVjyyty2TBT1ymdtuYT8HYRUCn9Wd74rytZZrCPRTck08fLMV
	 QAgfLBqVLv9Jw==
Date: Wed, 4 Feb 2026 06:16:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Use EPOLLIN and EPOLLHUP instead of POLLIN and
 POLLHUP
Message-ID: <20260204061624.GE79272@liuwe-devbox-debian-v2.local>
References: <20260129155154.484671-1-mhklinux@outlook.com>
 <aYIX9tvVut-i9QXt@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYIX9tvVut-i9QXt@skinsburskii.localdomain>

On Tue, Feb 03, 2026 at 07:44:54AM -0800, Stanislav Kinsburskii wrote:
> On Thu, Jan 29, 2026 at 07:51:54AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > mshv code currently uses the POLLIN and POLLHUP flags. Starting with
> > commit a9a08845e9acb ("vfs: do bulk POLL* -> EPOLL* replacement") the
> > intent is to use the EPOLL* versions throughout the kernel.
> > 
> > The comment at the top of mshv_eventfd.c describes it as being inspired
> > by the KVM implementation, which was changed by the above mentioned
> > commit in 2018 to use EPOLL*. mshv_eventfd.c is much newer than 2018
> > and there's no statement as to why it must use the POLL* versions.
> > So change it to use the EPOLL* versions. This change also resolves
> > a 'sparse' warning.
> > 
> > No functional change, and the generated code is the same.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202601220948.MUTO60W4-lkp@intel.com/
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Applied. 
