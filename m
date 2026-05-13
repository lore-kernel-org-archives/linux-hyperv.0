Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018403FADFE;
	Wed, 13 May 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670745; cv=pass; b=BD3RMsOR8xBo3+YX6zTW39duOuzgSyWfLhwx2zvf2UhswbNrgBKTxCoMmJSWaUxZbR+hTbCQ6QpZfrmtfG4vFRYpZK8dYwjFylk36JxtLOGJUIQy2UkqsSP5RpTVUFLJcoCyQLrn59oruzRwyL/lKQkM4EQGF1NIGlxSzlQiKLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670745; c=relaxed/simple;
	bh=EqRAFPKx4UzOipHDfuRbTUNCpp8gx61tDvvuzgO1DsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDDHTva4OWdAU+7Omol0MsifvKk6BRt7qzmewdhBEfF6vqn3IsDj1oo1oXC4676y0rclaeKIYBp2xg3J7illRXX0dhFIydAjugH/wPJF8E37z9XwM3f4hvpDInQ9yjLlvtM3saXu44YZy4Cl0vH4ABLdyYg5jK9qWRMV8aTqbZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Laeb7Cvj; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Laeb7Cvj"
ARC-Seal: i=1; a=rsa-sha256; t=1778670734; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQWOmfFqLT5vegYqEr7sklQ50kWVSbCwNrPcjnIpbxRIQVRpMT81obS9m3aurnkeC2SjIfjCXrK57wsNdQJUCzASQOZXYIoKMxDbgJqYr2p71HVVpGDj6xRmv1OP4gmq/kTpMVGC6twrE+54xPXkQ+6CIsddb8pUylSznHI+JxE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778670734; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y+g+ygnQU7eh9cKgv7b6e4EHHQr4AlndZRZrbCpblQY=; 
	b=i3wVq182437nS0/WzT9zc9UcQ25hlZK2YiR8FtakU3s5qW0NKiAKboks7tUwH27vouRlOKVJ+c0hzVUe9rjZ/H/sTr4EPbXNUrmtfcwLuEZk4x7blSZ3bDYmGGdgVe7vriZ5E31h3Se0JL9f3bzVGnG/9CTfBx5d6bu4w4+7iQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778670734;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Y+g+ygnQU7eh9cKgv7b6e4EHHQr4AlndZRZrbCpblQY=;
	b=Laeb7CvjFvajk0LcTS2ekBdH4LWrD6Hmwyz0era4wMgwHYcupxBAjVwat5sKY16q
	XhwyHWAsATOCapMbrZyvnSdQr3wlW/pJDnGTG0ord8Fjzi+rZevrk6GRpLpUY1K1e7d
	/3LWWPyHPpI74qpaI+asulnxXS+wZgUcfztloQhc=
Received: by mx.zohomail.com with SMTPS id 1778670732828807.4365024446018;
	Wed, 13 May 2026 04:12:12 -0700 (PDT)
Date: Wed, 13 May 2026 11:12:05 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Message-ID: <20260513-grinning-firefly-of-refinement-ed06cd@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:44:26PM +0000, Stanislav Kinsburskii wrote:
> handle_pair_message() iterates up to msg->vp_count without verifying it
> against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
> from untrusted hypervisor data, a malformed message with a large value
> would cause out-of-bounds reads from the partition_ids and vp_indexes
> arrays.
> 
> handle_bitset_message() iterates over set bits in valid_bank_mask (up to
> 64) and advances bank_contents for each one. However, the payload buffer
> only has space for 16 bank entries. A valid_bank_mask with more than 16
> bits set causes bank_contents to read beyond the message buffer.
> 
> Fix both by adding bounds validation:
> - Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
> - Track banks consumed and stop before exceeding buffer capacity
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 89207aad7cf1f..5d509299f14d7 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -190,7 +190,9 @@ static void kick_vp(struct mshv_vp *vp)
>  static void
>  handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
>  {
> -	int bank_idx, vps_signaled = 0, bank_mask_size;
> +	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
> +	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
> +			      sizeof(u64) - 2; /* subtract format + mask */

Could this be a constant in the header?

Thanks,
Anirudh.

