Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBF1DE8BB;
	Wed,  2 Sep 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310359; cv=none; b=ZMgptOoDYcRRzVxWNQK7dUy2GE+DApTUwxYeUfJfKOVh5y4rbKQvDgkKInxCp2i2ZCeLcpKsA2iN99TOG9Nv+qpaDaierlyBRuTyHl2lggoHgQ32V0iCbtb9hgEIN4QN8lQOx8alM7kaQ7SOndB+kKiJRdgW4Unf9o9TUdXh4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310359; c=relaxed/simple;
	bh=K+6q92TVo8X3beKwWwU1xxkAYpiY04tmCLHlqBGFVcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFV459xrDwXMtQCxMoEs/Gnhxqkdfu9GV23+jWoNn+8ppQLatWkMHyibXjmnxZHbm+8LmVW6k+QkBKa4f9g8Y25AdpvuahQHqYKkERpX/40lAY9XyNtxK70t+PsKlV6lkXEd95mbD4gdPT0OLaelbIfoMu8s0BE9vuf25aCDWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk5mfaqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk5mfaqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FD11F000E9;
	Wed,  2 Sep 2026 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310357;
	bh=mG10mSZuh7vAyFu8BCj0hVL+OIs93IAYJ9UZtxsWvVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hk5mfaqO0AZHJ0rPuVCD6T05osLD4aUYCfhWoHUdZ0lX7seCsIa9g6TwrXfZ3wd+U
	 UFb9kYWsP8KWWiH5uFw5q96iIC68gJdXe705uZILz1hYSFgPerPL8+WiYc6/LEcDZx
	 4FzcFAjiigSjdvBEyGp7uYQYJzVle96/wqH6Dufjx2XTNxV+9CmxEastyFfrslzNI5
	 EDeqoJ11ryEEXAlSBQHde1CsvTtS3ZN0yUbJt18NlfJlh4LXoZ3sj3uEIpF3L+9V+H
	 hhF9oX0R+hQEGUT5hbWyHq6IN6FoL+m4TCQesiL6UgtDHwGy31WAdAawjcg36BCCUL
	 tkHc/SOntS0hQ==
Date: Tue, 1 Sep 2026 17:52:36 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Avoid using per-cpu output page in
 hv_apicid_to_vp_index()
Message-ID: <20260902005236.GB2583463@liuwe-devbox-debian-v2.local>
References: <20260901193236.540188-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901193236.540188-1-mhklinux@outlook.com>

On Tue, Sep 01, 2026 at 12:32:36PM -0700, Michael Kelley wrote:
> hv_apicid_to_vp_index() currently uses the per-cpu hypercall input
> and output pages. This function is called when running in VTL2 and
> when running in an SEV-SNP CoCo VM with no paravisor. In the former
> case, the output page is allocated, but in the latter case it is
> not, so the hypervisor stores the output VP index in memory that has
> not been allocated by the guest.
> 
> Fix this by using the input page for both input and output. The
> hypercall has very small input and output, so sharing the same
> page for both is straightforward. An alternative fix is to
> allocate the per-cpu output page when running in an SEV-SNP CoCo
> guest, but this uses significantly more memory, particularly
> with larger vCPU counts.
> 
> Fixes: 86c48271e0d6 ("x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> 
> I'm not aware that this bug is causing any real problems because
> SEV-SNP CoCo VMs on Hyper-V are rarely, if ever, used without a
> paravisor. But it was on my list of little clean-ups to do, and
> a recent Sashiko analysis [1] flagged the issue. So the best thing
> to do is just fix it.
> 
> [1] https://lore.kernel.org/linux-hyperv/20260901171238.834601F00A3A@smtp.kernel.org/

Thanks Michael. You beat me to it.

Wei

> 
>  arch/x86/hyperv/hv_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index d5edc8530964..d0302bf2641e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -731,7 +731,8 @@ int hv_apicid_to_vp_index(u32 apic_id)
>  	input->partition_id = HV_PARTITION_ID_SELF;
>  	input->apic_ids[0] = apic_id;
>  
> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	/* Treat input as having 2 APIC IDs so output is 64-bit aligned */
> +	output = (u32 *)((void *)input + struct_size(input, apic_ids, 2));
>  
>  	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
>  	status = hv_do_hypercall(control, input, output);
> -- 
> 2.25.1
> 
