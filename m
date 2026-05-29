Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1273DA5CD;
	Fri, 29 May 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054870; cv=none; b=AXRbpnBLeG2yQMPBgWTrBN/vOkiKNUpFB4uLoydqbho5UCU2g5yBHES21hyF60bbyfmecLNFPWFOqpFDxkdU3uhe4gkB1PYNev9dVBQHnzDMCq8FJRMM++ejnQKrpORKRHnevOyak9iWbgeR/snvmYzqHMs2ChyXcd55Nunw1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054870; c=relaxed/simple;
	bh=6eXyt8sywkKjG6nytPT20FihChYS+IuU9mcpWHLIJkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd3oQNnAsTaJVL66MvxGkhPl7qT5nw1KCoENwAoaZAOLGAH+xZSjntjh3QwiNzu8h3QFOZ+GyUORCUexjjyldR9zH7mAu8Fe7AepAvPSm8ye1qQgdCCb/PSPSifrOX+DB7v6YDp1Spyw2MEHqAYuXRENBn4fv+rt1GPRPN3xfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s4q1OhIa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s4q1OhIa"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4198D20B7167; Fri, 29 May 2026 04:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4198D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780054857;
	bh=qveO8jYL+5Nz6TdMpNHPka2rOiang3qZOK/8ZXcpwdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4q1OhIaU83v+cT3ZlIPWSPU0HW18wkUXj9cb8B1qDgP21qaTr8P/zQimij0fVQJJ
	 wEw4At/08ktSTPk+jJLAxvSDJyoFtNyZP36gmFIDK3028+5OSU/kGjCIy0Qmg/ooNq
	 dfzvVHCRWsSxQDx1O5ROfCkw5zSF1w92oiMwWyoQ=
Date: Fri, 29 May 2026 07:40:57 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	decui@microsoft.com, longli@microsoft.com,
	ssengar@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm/hyperv: Use "hv_drm_" as symbol name prefix
Message-ID: <ahl7SWMUqsqFSMjN@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260529014826.41256-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529014826.41256-1-mhklkml@zohomail.com>

On Thu, May 28, 2026 at 06:48:26PM -0700, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Function and structure names in the Hyper-V DRM driver currently
> use "hyperv_" as the prefix. This conflicts with usage in core Hyper-V
> and VMBus code, and incorrectly implies that functions and structures
> in this driver apply generically to Hyper-V. A specific conflict arises
> for "hyperv_init", which is an initcall for generic Hyper-V
> initialization on arm64. The conflict prevents the use of
> initcall_blacklist on the kernel boot line to skip loading this driver.
> 
> Fix this by substituting "hv_drm_" as the prefix for all functions and
> structures in this driver. In most places, this is replacing "hyperv_"
> with "hv_drm_". In a few places, the substitution results in
> "hv_drm_drm_", which has been collapsed to just "hv_drm_". In two
> cases, the existing prefix is a bare "hv" (including in the to_hv()
> macro), which has been replaced with "hv_drm" for consistency.
> 
> The changes are all mechanical text substitution in symbol names.
> There are no other code or functional changes.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks!
