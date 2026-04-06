Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06C390983;
	Mon,  6 Apr 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496169; cv=pass; b=TwvClERjnKd6Xz27WzHCZt5RcGQMQ6fjZ8uxHvQpzy09/JUfQ+0U8uO++8TJ63P42kpMTqQnZj2hkvmvlMFOwZx0vsmx3gSP0LKrjBWw9ZaUAt1D46mYnAsPp7rFd27gjbcSzFW4dxUdBgPBnYx1Lle5mVH9xp95yusEyndyNug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496169; c=relaxed/simple;
	bh=mk0CfZ/2vVQJBimFhocybjyV5AWlkVvDuawkiAq6Ty8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGI4Fb0YG/oeq3JUfycw7jfIZswDtoFrKWRGs3Ir34MeQMvwd5858srB7WYoHvswGYmWEOHNs98OkJQuUwWa44UDoWzmH6X2zH3zj/TAgC0vAAyT8o0bAImJMpBpCgZb6Sr/wAw2K3doFoSy5QYQRbzNU+SLQBwO+cKfVYRQpis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=XKX+fYLV; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="XKX+fYLV"
ARC-Seal: i=1; a=rsa-sha256; t=1775496143; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Isksyy2xJ+dtLPb0BlamRyIPi04ts79mB8EeDjqedCK5olnYJTb2ffdJSIjUSzGb6cKGyJ4S1AkucoZJ/RwfdRfqHJtJi6aqcv3LMuLDo8zy3tXGMoA5gbb5eNf5/KFA9zHfhiBwuk3HcfgM9zo3YV59sNR00T1ZhqfgoHHQBWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775496143; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jW3KQa087Y0A5k/DA3y8vVVdmrI6CJt1WGm/JFwltn0=; 
	b=VsuSmiWL+2/GvdPXKmpW+2eD+LjwW8100epQVh0fC7M5Tr8JacHc2Mita9lBF8HWG8wda7/7fSmD3iB7EJvy1jRHqvyPVYiRqjt3FnNaXjdhXeCdPocr7sHi764J384+07rhDXoUy3DABWc3yot9MdDZuUx1E2TAeEldlc+e8Dc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775496143;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jW3KQa087Y0A5k/DA3y8vVVdmrI6CJt1WGm/JFwltn0=;
	b=XKX+fYLViCCWAkvhIWNG4BYA8eqzVT07obry4ebVQIt42zi9ZJJzhkdOYWCBJaFe
	8FQJZ8FioyM/7JDruNnifhDU4cDPE1YDtDmriICwIWkZtUpObtzVIdxxkI5Pr7EkK20
	5P+vnQQFWdVmEmbU+HefxnQtSyoE1DwdVyZAITmQ=
Received: by mx.zohomail.com with SMTPS id 1775496139746327.00162569633585;
	Mon, 6 Apr 2026 10:22:19 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:22:11 +0000
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
Subject: Re: [PATCH v2 5/6] mshv: clean up SynIC state on kexec for L1VH
Message-ID: <20260406-hasty-academic-hippo-a4cfb8@anirudhrb>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-6-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403190613.47026-6-jloeser@linux.microsoft.com>
X-ZohoMailClient: External

On Fri, Apr 03, 2026 at 12:06:11PM -0700, Jork Loeser wrote:
> Register the mshv reboot notifier for all parent partitions, not just
> root. Previously the notifier was gated on hv_root_partition(), so on
> L1VH (where hv_root_partition() is false) SINT0, SINT5, and SIRBP were
> never cleaned up before kexec. The kexec'd kernel then inherited stale
> unmasked SINTs and an enabled SIRBP pointing to freed memory.
> 
> The L1VH SIRBP also needs special handling: unlike the root partition
> where the hypervisor provides the SIRBP page, L1VH must allocate its
> own page and program the GPA into the MSR. Add this allocation to
> mshv_synic_init() and the corresponding free to mshv_synic_cleanup().
> 
> Remove the unnecessary mshv_root_partition_init/exit wrappers and
> register the reboot notifier directly in mshv_parent_partition_init().
> Make mshv_reboot_nb static since it no longer needs external linkage.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e6509c980763..281f530b68a9 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2256,20 +2256,10 @@ static int mshv_reboot_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> -struct notifier_block mshv_reboot_nb = {

I believe this code has moved to mshv_synic.c in hyperv-fixes. So, this
probably won't apply.

Thanks,
Anirudh.

