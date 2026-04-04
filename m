Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D661DDC37;
	Sat,  4 Apr 2026 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775285129; cv=none; b=N1Jr/BWdJ20e86njTlpCFHr0sUfrU0LDxUqH6tmxgEz4nH4F0lb0Ij0Z4idNV58OH65+8duY0O0f7YjSyHSv5caqmJevqKZju0n6d0RMb1tD8YAK6PrsD2NXh9jEPXgfXqTo9cIbq51koyTbbCy+BGvHWmhVdrW/2/UiOj1ZIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775285129; c=relaxed/simple;
	bh=9rmSNRoyX9Hmjm1i6rB9t2bOim9ibqI7oN0AJtIP/tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcPwrF5TT7C4dzz++6SI56LeWefsfir1D7oLhizKpScnJWMxhGhiwD0G979PXkoykay/1HiPWzx5o8aMxdcIIoYvH2n3E/RwpNxmlAkqvmgE/e0Oa6fS2bG/uQgN1mt5w8Vv1j0OP4nYCOHrK5E/SP8IfpinjpD+Bj9OXFLfjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJepS8Xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJepS8Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C35C19423;
	Sat,  4 Apr 2026 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775285128;
	bh=9rmSNRoyX9Hmjm1i6rB9t2bOim9ibqI7oN0AJtIP/tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJepS8XsEiTrPXXnDxQ0Vn4ukRv8Yi9MEG4HCVSo+y/6RxflBgZO7tRG9/KRDEMp5
	 OD7sBQtnCXkbj8Mqk0XYhkaKaCsZ3FvFiJttqtPmtxlJ9oAi6hbJkArXMqub+HJyOM
	 PO8NCPncvEMtvn+uxhjVXnpkXrG1Gymxd7Bb5SnqM0fzt02zzFqvoKUV7CAv3uvBuP
	 jYRuPkLfizftnEmkwpAG6K9MjmZyfhk8WpxlfVWkfOPhGNJDFJObr20lEa6tc5NndV
	 rjWxhnbQaDXQEsXPhGvEMWQbXH9beIHDxwQCGHgdOsFeNt33rPNzc9JIDkumTeZET8
	 I0x8e+HrfyZBw==
Date: Sat, 4 Apr 2026 06:45:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add tracepoint for GPA intercept handling
Message-ID: <20260404064527.GF60588@liuwe-devbox-debian-v2.local>
References: <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>

On Thu, Apr 02, 2026 at 03:45:58PM +0000, Anirudh Rayabharam wrote:
> On Tue, Mar 24, 2026 at 11:59:59PM +0000, Stanislav Kinsburskii wrote:
> > Provide visibility into GPA intercept operations for debugging and
> > performance analysis of Microsoft Hypervisor guest memory management.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |    6 ++++--
> >  drivers/hv/mshv_trace.h     |   29 +++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

This patch has a dependency on another bug fix. That's not listed
anywhere. In the future, please list the dependency, or post this as
part of a series.

The tracing support is in hyeprv-next. This patch needs to wait.

Wei

