Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13854158535;
	Wed, 13 May 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667114; cv=pass; b=Q3U7tnknY5FrbghZfamTb/SXXw46KmwzBQcxN8j+k7IVA+4uv/+pZYnkb5IhXnPZSAYWjQxzfQTAErILsbyz1j+Il4GwpCKR9v2bR9Fdvtqkq3Ejx67B8zN5R6gHBaM15cTSJ8xJVrcfm4d4B/JvHGIYT6hKLqEBwLnXD7gyvwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667114; c=relaxed/simple;
	bh=ZVScxYPifBvGLp473qCOXCfV1rZeYvUT98M9AeWbVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh7WtAHoQgpVma8HKUUdBN+xDNaQ/ILvwDvQVcO2h33siHctf4UvyY0Ez3QvxpfWqhBxAIemoUp3MpC+2v3yqfPdOeAv9CDz/tMZF+NzRcrQQuWeObrO0Ej0++4nNHUIEF5aoWmUFoFO4A8qgTvvdH0+uxpznRDbpsutXUOHAVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=pKPXZkBU; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="pKPXZkBU"
ARC-Seal: i=1; a=rsa-sha256; t=1778667101; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hJSPYOWAKQT/cINGqQ5iKBay8tHWZf6wIxsjEsYKKTYC4ICKTpJLqAUBGsWnMgb4FrrTuWKbHhNLsx25t5HmewzZ3mSQZtZrbfw0NOVY9gpwJIdS37OFz4WvxcbsScaRf58yjCI5AE1x8ONPuzi7Eq5PKDIeG8CTEKZpdrYgZtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778667101; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Kvbx7HKdTnDFhuvp4wB+Ht2GcGrYufKnIdbGNHV9+PM=; 
	b=STJsyT2ipIGIbSqft4KF7mV7OV4hdeKIzby0wAS0uCFpmDSdHEHgw9fpS+iRBxIyAqGNK/6flPfTWciWKdnuWVzoEPHXdrREeu4k7Lm9wH0WcEXDDQnKNDfNh8h8XRNP7L3SXAsxiTdlh9PqOse26+NhN7uiFhhTjmOfCaNVSbU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778667101;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Kvbx7HKdTnDFhuvp4wB+Ht2GcGrYufKnIdbGNHV9+PM=;
	b=pKPXZkBUcUUx5cF0bFkVMqrE/LpCVWieR9pWT9IsUjZuLDaPbn73tF/e4Oopg21U
	QgMGloPCMGfRnB+ayxVOluImmFIs7U/js7DhqnrTjeeuWz3dSPgnKh2fi/mTcoTIhtp
	Bst7b4yFJuCrQ/LgDU+UpZV95DPEKTLk4O/Ede7M=
Received: by mx.zohomail.com with SMTPS id 1778667099214109.32452564524624;
	Wed, 13 May 2026 03:11:39 -0700 (PDT)
Date: Wed, 13 May 2026 10:11:33 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/18] mshv: Defer mshv_vp free to an RCU grace period
Message-ID: <20260513-unstoppable-onyx-jackrabbit-1ea05b@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866152.21765.16203922564983237274.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816866152.21765.16203922564983237274.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:44:21PM +0000, Stanislav Kinsburskii wrote:
> destroy_partition() frees mshv_vp with plain kfree() while ISR readers
> walk pt_vp_array[] under rcu_read_lock().  On non-root schedulers,
> where drain_all_vps() does not run, an in-flight intercept ISR can
> observe a non-NULL pt_vp_array slot and dereference freed memory in
> kick_vp().  On the root scheduler the same race exists in a narrower
> form: drain_vp_signals() synchronises on kick_vp()'s kicked_by_hv flag
> but not on its wake_up() tail, so the wait-queue lock embedded in vp
> can still be held when destroy_partition() reaches kfree(vp).
> 
> Add struct rcu_head vp_rcu to struct mshv_vp, clear the pt_vp_array
> slot before the free, and use kfree_rcu() so the actual kfree happens
> after a grace period.  drain_all_vps() is retained because it serves a
> separate purpose (telling the hypervisor to stop signalling and
> reconciling signal counts) that kfree_rcu() does not address.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h      |    1 +
>  drivers/hv/mshv_root_main.c |    5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

