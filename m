Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0687224FA;
	Thu, 14 May 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737798; cv=pass; b=JUSl5EySmr7mKJFvn+3HEppP/Pv8ZBKV5ep4S9LMbjqs1XTkUM5RQjR2lnIkY8pfCjQD966g9D+XIfSEmW/EuA7247CHfh7w7YIulo8RiY9ctVA1n5hG5XYanUO4w2S4hOWQm/SxaLkARAnCi9uQu9aSS9xJRxCpGikN7EiYeQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737798; c=relaxed/simple;
	bh=nmHV4kRjki7EaaGapE0tISD6vHjmK5RO+bdoYC/JZ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA+4sZPFpkjfPQ965UsoyWzJASk46QOKaibast1rdxdZzfO9uXaL9EhbIirfklyzBh+XAkJJocmwr5a1ajMktGApXfukz2UffB02SNrT5sa2jIBQDnHSQxepYW5nBj/nfr1RAphBrDFe65zRwomvwTFtrQApsRgs9+15TWQBbyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Lb5eLRbL; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Lb5eLRbL"
ARC-Seal: i=1; a=rsa-sha256; t=1778737787; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ac0mhiIuR/EnE1vqmfvaetg5tkIVCM4DmHre9uIEU3nDwtLxlN/KeT12b9NsurGUYYC1wvlUZ+43Z1DmUEUFxcVbchXR43wn9Xrfz4KBjerCaVvMknwbXy3S//OvaqHXXD7iN0af0uTR3V3Zu8GU6atUZxce3C0O0pJdtVnm24w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778737787; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OOFlX+sLAHxMSoueXGc3PuQn8942LH9lY3614y5Ql0g=; 
	b=WN85UACdM+qXqpaZ7QMnOIKdO/9aXyfnZwSMKNA7sWbKXd+umiZJBVruhCPihhNgvHgdRizhhjcBpsfC6I5h5yvqgFQn0bc5893QH0ZseP73VDn4UDhmCu6cLwGaLPoaeJl1ogM0SN4C5+SWKC9nnZot/fuFtSkxi18N/qmr3Ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778737787;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=OOFlX+sLAHxMSoueXGc3PuQn8942LH9lY3614y5Ql0g=;
	b=Lb5eLRbLGIKF3EFvkM9yn3VjCapOCrkWxYPMMmiEJXUKPBRw2L0tgwSXLjVftYQd
	X7iL32NyY772dZl/oogcJGmMKyv1L7yAXGUGuP7NimPVvNahZf92UGTOvvpDFi3WCV7
	j6rGMfr+W81xacTnKHoWPl9uCgWeEqBtOdcScoNI=
Received: by mx.zohomail.com with SMTPS id 1778737784476831.6453911774705;
	Wed, 13 May 2026 22:49:44 -0700 (PDT)
Date: Thu, 14 May 2026 05:49:39 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/18] mshv: Fix level-triggered check on
 uninitialized data
Message-ID: <20260514-admirable-hot-mussel-0d9b27@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816862362.21765.11809618639989414561.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260513-omniscient-enchanted-otter-dfd602@anirudhrb>
 <agS3GOct6mPN6sN9@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agS3GOct6mPN6sN9@skinsburskii.localdomain>
X-ZohoMailClient: External

On Wed, May 13, 2026 at 10:38:32AM -0700, Stanislav Kinsburskii wrote:
> On Wed, May 13, 2026 at 12:14:49PM +0000, Anirudh Rayabharam wrote:
> > On Thu, May 07, 2026 at 03:43:43PM +0000, Stanislav Kinsburskii wrote:
> > > In mshv_irqfd_assign(), the level-triggered validation for resample
> > > irqfds checks irqfd_lapic_irq.lapic_control.level_triggered before
> > > mshv_irqfd_update() has populated the field. Since the irqfd struct is
> > > zero-allocated, level_triggered is always 0 at that point, causing the
> > > check to always reject resample irqfds with -EINVAL. This makes
> > > level-triggered interrupt resampling — used to avoid interrupt storms
> > > with assigned devices — completely non-functional.
> > 
> > What bugs would this manifest as? Why haven't we seen any such bugs so
> > far?
> > 
> 
> This patch fixes a logical error.
> Whtout the change this hunk always fails:
> 
>         if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
>             !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
> 
> and the reason we never seen it as that we never used
> register_irqfd_with_resample() function of the mshv crate.

I see.

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

