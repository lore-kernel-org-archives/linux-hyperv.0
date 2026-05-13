Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F730FC27;
	Wed, 13 May 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650351; cv=pass; b=RzqEe6i0nJ/8USTU/MlFHe6sDV1MpaB2qpC5IK6beWpz507PPkEY4/Wxmm1L9dye8tm+nokfcCNUcjV/gLbpnPk8+g8G0rSDEDqg/V7Yd9Zp5//gyfoz2ktmO1PZ/63xOagMqY5Gb5+TvtXgFhIDZFWxmtvGtHrUqNaN0xZmd6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650351; c=relaxed/simple;
	bh=bido1uBskWMdXbiI/f5Y9yHbO7sRr9ZlWQHN0CvcdmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhxE8FxDW9gx0wMyOv9ZNbADKjn59SFdX06i0E0BOJgg/81cKnFEDgeIgfVbU8ASY7bsLuj31lcXzUrS44nxVYDsDOzMTeTg2sc/VwqoeJ39nUPkihk+2bpYbyEvSZBJjYb8Wg6uHo+BdbALJxDbhh4gEQVVqWcN+etl9aa/47s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=jFSUsUSg; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="jFSUsUSg"
ARC-Seal: i=1; a=rsa-sha256; t=1778650340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X8bWh7MfvZcKmMYX/4tTeGiHXqM/YbA63Uvnf+5vnaXbREkdvi7o0qyJaaycQ9xDmvrAdStgjWztBzxkIV0IYq+FdY1oqRQDVuQdkIsEboGXDED7B8v3O8AFU6R/0suKf+d4XiczlLQs+Jq56sqoLhwHheZ3xUONWo275vQPnlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778650340; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SdXRvmJihsoWwykWNl3djZ30Af7RtaFdeCAvIreg08U=; 
	b=nJo+tV2k/Xs9GqkwBHztY1dca+l9bqLV4sp7ZXLOOg8pB0TmRhpUh7zNZzM8CAqWScor+gJmdAHOab/hF3qT2PwxpxChHL7iM7WKpkpr4NSw+nCAsAmENg0VJxMIFjALp5sDlUDOvPGydJcd+nC16/EYBu89lrl70o56YC/rJw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778650340;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=SdXRvmJihsoWwykWNl3djZ30Af7RtaFdeCAvIreg08U=;
	b=jFSUsUSgw29dp/tz6bhYq6kG40fidlyWXghOcyT1qnEyraoskuMbYB3Vx0pOoV6P
	3ZUnPk/mpQwSvr7JmlG6plVhimT1q/4hD0AqUofSmMJOegIeq225jboIT095wnT/wML
	JAcEZCt6/Ueecj1FWxVVHdNRERvtYO1PJgC4pXQ4=
Received: by mx.zohomail.com with SMTPS id 1778650336566972.0119436504021;
	Tue, 12 May 2026 22:32:16 -0700 (PDT)
Date: Wed, 13 May 2026 05:32:06 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] mshv: Add missing vp_index bounds check in
 intercept ISR
Message-ID: <20260513-gregarious-denim-cockatoo-c522cb@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816865065.21765.5112039734725197893.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816865065.21765.5112039734725197893.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:44:10PM +0000, Stanislav Kinsburskii wrote:
> mshv_intercept_isr() reads vp_index from the SynIC intercept message
> payload and uses it directly to index into partition->pt_vp_array without
> validating that vp_index < MSHV_MAX_VPS.
> 
> Mshv treats the Microsoft Hypervisor as trusted, so a malformed vp_index is
> not a security concern; the threat model does not include a malicious
> hypervisor. A hypervisor bug that placed an out-of-range value here would,
> however, cause an out-of-bounds read of pt_vp_array in hardirq context,
> manifesting as random memory corruption or a host crash with no clear
> signal pointing back to the hypervisor as the source.
> 
> handle_bitset_message() and handle_pair_message() already perform this
> defensive check on hypervisor-supplied vp_index values, with an explicit
> "This shouldn't happen, but just in case" comment  Add the same check to
> mshv_intercept_isr() for consistency, turning a potential silent corruption
> into a debuggable pr_debug message.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_synic.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index bac890cd2b468..89207aad7cf1f 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -387,6 +387,11 @@ mshv_intercept_isr(struct hv_message *msg)
>  	 */
>  	vp_index =
>  	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
> +	/* This shouldn't happen, but just in case. */
> +	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
> +		pr_debug("VP index %u out of bounds\n", vp_index);
> +		goto unlock_out;
> +	}
>  	vp = partition->pt_vp_array[vp_index];
>  	if (unlikely(!vp)) {
>  		pr_debug("failed to find VP %u\n", vp_index);
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

