Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97C39BFF0;
	Mon, 30 Mar 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907656; cv=none; b=D4ReFZ5jsIu3RdAz/lNEggzq7POTVOqFXcXTvUcRZuSSe24pjwDKKUyOLm7+leAX1baB+s2qlur/W52PbxMBdnMUnuQctR4mTozMcYiW+z2qrL/ObCdeHTNKiflQpr85I4yw5j2WwdEXdKwpzIBld2FrXBljiJ3b54acXn+aFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907656; c=relaxed/simple;
	bh=JEBw6hwWq1DZE3Fu6dPLv0yd/UdvKbFe2oe5klh8h7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePE13WrDgvjJseFzr+kazhDx+AqYzjiFr320BNpbe7tB0KZKeI/T2bKpE33CM+zTXZDzE5b0azbgxzI5dxJoA5HPuFF+9SqKFvXkD6/bVVXnNxBw7gQx0ma2nU7jJonZxU93yOp5QooPQ2Io9GqC/tLw+LskGew2OuOnYcQVB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IGxCMn01; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IGxCMn01"
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DA4120B6F01;
	Mon, 30 Mar 2026 14:54:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DA4120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774907655;
	bh=Wl0Mv/HTB+nf9JxpV3RJEQ7c5BcPtjN5d5ojZBGMlP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGxCMn015pQ1mDXDeEEAYrVtFAbYsrKno6EwJZZ05tQ2B38I+uS4tr+a5FkbEb+vY
	 A31O0Szr5z6xDPjih8myKxlSsDaHFglre8sMUwHSQHun5srzkTYulj1zQUq5XffRIL
	 PH8wEgRaSEUEYKZB5D27q3HC6houYJCk2CpxDDX0=
Date: Mon, 30 Mar 2026 14:54:12 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/6] mshv: unmap debugfs stats pages on kexec
Message-ID: <acrxBOLaHdku6kdZ@skinsburskii.localdomain>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-7-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-7-jloeser@linux.microsoft.com>

On Fri, Mar 27, 2026 at 01:19:17PM -0700, Jork Loeser wrote:
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
>  drivers/hv/mshv_debugfs.c   | 7 ++++++-
>  drivers/hv/mshv_root_main.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> index ebf2549eb44d..f9a4499cf8f3 100644
> --- a/drivers/hv/mshv_debugfs.c
> +++ b/drivers/hv/mshv_debugfs.c
> @@ -676,8 +676,10 @@ int __init mshv_debugfs_init(void)
>  
>  	mshv_debugfs = debugfs_create_dir("mshv", NULL);
>  	if (IS_ERR(mshv_debugfs)) {
> +		err = PTR_ERR(mshv_debugfs);
> +		mshv_debugfs = NULL;
>  		pr_err("%s: failed to create debugfs directory\n", __func__);
> -		return PTR_ERR(mshv_debugfs);
> +		return err;
>  	}
>  
>  	if (hv_root_partition()) {
> @@ -712,6 +714,9 @@ int __init mshv_debugfs_init(void)
>  
>  void mshv_debugfs_exit(void)
>  {
> +	if (!mshv_debugfs)

nit: this should allow to avoid setting mshv_debugfs to NULL in the
error path of mshv_debugfs_init():

if (!IS_ERR_OR_NULL(mshv_debugfs))

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> +		return;
> +
>  	mshv_debugfs_parent_partition_remove();
>  
>  	if (hv_root_partition()) {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 281f530b68a9..7038fd830646 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2252,6 +2252,7 @@ root_scheduler_deinit(void)
>  static int mshv_reboot_notify(struct notifier_block *nb,
>  			      unsigned long code, void *unused)
>  {
> +	mshv_debugfs_exit();
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  	return 0;
>  }
> -- 
> 2.43.0
> 
