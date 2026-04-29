Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668C395259;
	Wed, 29 Apr 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457443; cv=pass; b=Nw8sWdZ4ZicOwGkrbfyzjUyFtkykw5YX54J6ebo+L5PDJlKAaB5m2p/t3aa1mjWnJUj2HQmwrjegCHBrUAoqGACWMQmY2QXWgTU921L5t/vsO7MgBS4lT/UdHa5sVa9LaNFU1C6nTSBhYuzjRwymDVNkNy4QDM23Ed6KKods2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457443; c=relaxed/simple;
	bh=lUjcB+iuaalN09wG72rTZUDelYzuJG9bOf/uGfkyGgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOwva1kUz3/X63surFdc1QUW/BtNdgFXHokDUaYOK5m0+GxrjirFf+AL6jnkd6tbo+G2UJ/jrhW7W1iV3m9QAD2QApRNzT0gVYd4gipoWmYD0xmlgwBedH2WbV+UAGow1eqs3LWnNUkXxEJr+CBN134bSeEu8uNA7FJLZPlpxH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=OXBEE9Rf; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="OXBEE9Rf"
ARC-Seal: i=1; a=rsa-sha256; t=1777457412; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mLXLA35hYoo5S8dEqxHmno7mxolKdl64mwISIQ13LC4wkiWXwS/tys3WAbs5+Cw2pVfKrtMqoicahhPlwFjhDqusnEqRjEXCp6GqzopY1Pg1/AN/bvmo0kOfdAzzbMUVNu0U8rVLMYwKnd9JWR//ao/6dq5JQp+iBhS2K2nnSq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777457412; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J50RyZE4/s/NcIzQS4v6UG489kfgGr6Z+tintjb2Nmo=; 
	b=cTdsM54z4aM9KSc2MylFiUdjGfxCldhmBPUl0eXXJyfPj+3iPR1NBfgoxKDind/sl4sW2sSvQWi+Kh2FRj1k/HiPqPMuwHCOgBO/gXr2Ojuxp9Zjuse7sS6zwH/C9MRF7rd29HnVnxLHeWTuLkBVeyrDSUc5Tk0ApoKFL9v+MKg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777457412;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=J50RyZE4/s/NcIzQS4v6UG489kfgGr6Z+tintjb2Nmo=;
	b=OXBEE9RfHegC02ZfBlmdcxQt1XMhtW2f6Snb8z0cF7B31DR5qwAU7YH4kZQSnsQj
	RcwRkeRCfwW85lOZLrHNdPUXhewwZ3IOBIMLzwyPQUL0R/3EgKOWLJ18/3Kl9oZU3FU
	srKP6+pr19UN/tHN8B0cZmEolzsALeX3kRc9hOoc=
Received: by mx.zohomail.com with SMTPS id 1777457407634465.4010038760358;
	Wed, 29 Apr 2026 03:10:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:10:00 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mshv: unmap debugfs stats pages on kexec
Message-ID: <20260429-attentive-gleeful-cow-65e0ca@anirudhrb>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-4-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-4-jloeser@linux.microsoft.com>
X-ZohoMailClient: External

On Mon, Apr 27, 2026 at 02:38:54PM -0700, Jork Loeser wrote:
> On L1VH, debugfs stats pages are overlay pages: the kernel allocates
> them and registers the GPAs with the hypervisor via
> HVCALL_MAP_STATS_PAGE2. These overlay mappings persist in the
> hypervisor across kexec. If the kexec'd kernel reuses those physical
> pages, the hypervisor's overlay semantics cause a machine check
> exception.
> 
> Fix this by calling mshv_debugfs_exit() from the reboot notifier,
> which issues HVCALL_UNMAP_STATS_PAGE for each mapped stats page before
> kexec. This releases the overlay bindings so the physical pages can be
> safely reused. Guard mshv_debugfs_exit() against being called when
> init failed.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_debugfs.c | 7 ++++++-
>  drivers/hv/mshv_synic.c   | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> index 418b6dc8f3c2..3c3e02237ae9 100644
> --- a/drivers/hv/mshv_debugfs.c
> +++ b/drivers/hv/mshv_debugfs.c
> @@ -674,8 +674,10 @@ int __init mshv_debugfs_init(void)
>  
>  	mshv_debugfs = debugfs_create_dir("mshv", NULL);
>  	if (IS_ERR(mshv_debugfs)) {
> +		err = PTR_ERR(mshv_debugfs);
> +		mshv_debugfs = NULL;
>  		pr_err("%s: failed to create debugfs directory\n", __func__);

Might as well print err here.

Nevertheless:

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Thanks,
Anirudh.

