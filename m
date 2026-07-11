Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2452DB7BE
	for <linux-hyperv@vger.kernel.org>; Sat, 11 Jul 2026 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739699; cv=none; b=PUrlSQrtI9g8MYPy5+epRsorn4vu3zGLAxSmrJHV+nWTTHbTdsnoOiZdSKJOOU339soKynmbu8cdXw40+Geas47JGO5/4ASXYzD0QMID3PQDNJRrXszIS0faKhbCAqR39EFmf8otb+urshpOlbss4J3hrhYELcEEFp9Jn8TKTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739699; c=relaxed/simple;
	bh=qqBMc1pIZ4OwB1WOwiQC+Ffr8ykArNIN3N1czmLBQLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts0NyNru6PS/9XnzTf0VHr0L4fr7DW7iKAve5UOmz0NDVJjxaKSecdsLGtkdbQ/63pI90U4T4CD5ol14s09FWT1Dws1wsCDoUZYH0ODDvII53ZT8wXqG0ON8glAN0pYwq+yFUVHKJozLvsyBAKFfTje65J8g/3zy8lpcNt8eAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9usNja3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9usNja3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1538996a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739697; x=1784344497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrd/oJTRX2Uc0zxJ+R9Qjxy6xmTV66E4ZoYglWTlGgs=;
        b=j9usNja3Rw5jRvVQMhlvbBICaZdQiWUjddeAsYDi9fiyL8Joamdn0JxMIZ5dk38bIQ
         /dornZxQMlIROVUjVoRhbGHUKuukf6Og8glDQTCDAJbg4K0QgRqqm/1/PM97bWK8yUzb
         cDMHXHbpXI7+NZzaaVzeYzRIphjIJgazuYXMlodgbRGw9iEFgEltoznH76c8Y5kiH7/l
         sCjepKEumOcKyeYvn7JtRE9U0wehywpYEDvMG7zDQKECSL9yoKlNaJvg3/R2NRKxJ/aE
         FTNW2+vTGF6P2K39qMI8aKDaAcI8+pI9elzMZpeldCoY2Ji70VUFBU9h7WkHDCr1dQob
         ZG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739697; x=1784344497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrd/oJTRX2Uc0zxJ+R9Qjxy6xmTV66E4ZoYglWTlGgs=;
        b=nh8wTn4YsFa18fPjc8dm+yRLfvPiuzCCJx6xj/yVVWqltEGlx+QA5DXdToWCV5bLqz
         T23KrY1i3RaLHoOnMF0LDeIGFi+j5M5h764y4F9OgtDHpyqSNSeOci9U7O/lMxpE1Dgd
         o+O7b3lne7NosQWpYkUS40tsd/D/XJ1jyliYHglF2Iv3KO1vcXgId0RyNF+ZP06+Z2gq
         FmdO4aZu4GALSx2m6d9+sENR8q2HPEGpAAFf7Ha8ewBB0ZH15i5pVeoEtBRQeql4KiZ0
         8sQ8Z2ezdZx1QEj3V9g5d2CUgzB2nJOY7usBPY/TPRpKvyyZ98hWFH8VeYrUCGysT5G3
         QkCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7uv7hjoEiAbwkTtbSW6wVG3lHY+wiUVnlOyCvdPlomrDGxdC8zF5YGBpZZhlHM9ZoExhkG2s7Fi8H7yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqC4lZHf+JoLhfSBQ2XAQVrA8AW5hHYgcBc4Jz72PCl7nYizO
	oMWnqjdYlzkGfIVx0MFpS0UqQMaFfAv52Dz5SMj0fRgUWlurx0irrWnR
X-Gm-Gg: AfdE7cnQ+ukibMVZNl4HU50GluS8D2fBCnPkvJAnkBffRANtgKlL/Z8hVwuz7yCPMSo
	7xu1aYKpMO6Ty5eJmE2YH7DP7fBRW/FoD1irR5zMMBoj1sowYWHn75KnN11rfO6NA/GaynIuHwt
	osbPyXRiOHsQ1x/D4D5aqqN0MzHpR9vU4R7rxh4cCjBs+iAkfHP29/nxCYQv7aKdb61mq4yBHwD
	RrKCQTYAJZvdsEpFI1wBAZBzvSbv43SufMa849YF1F7xtgoGkt41FUiULC7hc5h1dkn/mawIyN+
	4cAgSRo1EcM5Vuhj+wIxH0M4kS5YLj68SPa+W7t1uKLbHz5C8dohZUOsvq2U+bioSXvI8wgoQS5
	ZvkmySBd/044DUpF5IW09o3q2AdnpNADebe/G1pVrDl0HqsXum2N1zD1cSagHWZMISVkV6ig6Aq
	7X+G0FKIGj3tD6+fyOqbXJfDlelRLEZ/6gTePRXYJnPZ1W2jS+Z9IjNqU=
X-Received: by 2002:a17:90b:5688:b0:381:29f2:481b with SMTP id 98e67ed59e1d1-38dc74cbe73mr1405854a91.11.1783739697430;
        Fri, 10 Jul 2026 20:14:57 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55a47286sm3463061a91.10.2026.07.10.20.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:14:56 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:14:47 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
	dakr@kernel.org, david@kernel.org, decui@microsoft.com,
	haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <alG1JwgUK44dCiN4@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>

On Fri, Jul 10, 2026 at 03:12:16PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:50 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > MSHV currently faults movable memory regions by taking mmap_read_lock()
> > around hmm_range_fault(). That prevents the fault path from handling VMAs
> > whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
> > mappings.
> > 
> > Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
> > preserves MSHV's existing unbounded retry behavior while letting the HMM
> > helper own mmap_lock acquisition and refresh range->notifier_seq internally
> > before walking the range. After the fault succeeds, MSHV still takes
> > mreg_mutex and checks mmu_interval_read_retry() before installing the pages
> > into the region, so the existing invalidation synchronization is preserved.
> > 
> > Fold the small fault-and-lock helper into mshv_region_range_fault(), since
> > the remaining retry path is just the standard "fault, take the driver lock,
> > check the interval notifier sequence" pattern.
> > 
> > ...
> >
> > @@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> >  	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> >  	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
> >  
> > -	do {
> > -		ret = mshv_region_hmm_fault_and_lock(region, &range);
> > -	} while (ret == -EBUSY);
> > -
> > +again:
> > +	ret = hmm_range_fault_unlocked_timeout(&range, 0);
> >  	if (ret)
> >  		goto out;
> >  
> > +	mutex_lock(&region->mreg_mutex);
> > +
> > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > +		mutex_unlock(&region->mreg_mutex);
> > +		cond_resched();
> > +		goto again;
> > +	}
> > +
> 
> If the calling process has realtime scheduling policy and either a)
> we're uniprocessor or b) this process and the holder of
> interval_sub->invalidate_seq are both pinned to the same CPU then
> cond_resched() won't do anything, and this might be an infinite loop?

Yes, looks like it might.
What can be done to prevent this?

Thanks,
Stanislav

