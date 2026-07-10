Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019942EEC9
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701519; cv=none; b=lSy2RRiNfcVrHxLCPW8qBUhrCUT3fFDwpduCQQAW1GiLnIaIJlDooO47aUqQySV1JBep5PtI6VIXb8+QZZbLkgqU8GgOR+wQClbreJ2tbQ1sMRWB/5yok7dtgbTyxoMZ7OquWNQRl0tZNZeT/1X+b4hIzUPmgyDGbeTNjVLjgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701519; c=relaxed/simple;
	bh=vTdToXVujk74qBKh74vvECPnjgofqJDrLpjoPE4cKsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKJg5tAvR4fqrnRUBTI/vVGab5Z+hUsezgHJMudLBE1JQ5AAIeUdiDP1YtjkBy4KaQXNFmr1+Jy+2K2gjBYldBHd71IibQswWkwwpNY+HEYkgKoc8rNy2DcOHB8dn07jIASrd6Wkr7qNvRxzTRZ7sD7Prrg9CGFglqCdAy+eX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dtj3Fzyg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dtj3Fzyg"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so9410376d6.1
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701517; x=1784306317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fjPC+dGtl7NWTD2gQsmUUpevrDX1aRJ0R6Q1EEoKDOI=;
        b=Dtj3FzygiHO0Ijtq8NJkTj+A8XCmtTgtY/WdFTEByh+1CaGGRHY2XebV/Bve6bTsI1
         roaNiMvL37FyiC57NTbTRYXfUTjDHb9B770JS/DkCRYfUWfPVdtF0ky9otnhyAT8t9EA
         NuYggfNxRWprzMobO1AkQKmDulQYG2MBjRdJlRJXRG4Wbh4JEIwVWGKkuGkHLp8TyvRz
         Vb/GoWYERXPx6dZ8l/7+9VMSi4NKy7I1g3xqsruP7OBC5A/yVs7So9NZcKgcF7mIW8K+
         bghhMlCjlNg8QCSvfevIov4KoCn8zcoxlbD46hxHH9o2a1pSzSeDcIMi80TSLJCDQYKO
         NNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701517; x=1784306317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjPC+dGtl7NWTD2gQsmUUpevrDX1aRJ0R6Q1EEoKDOI=;
        b=C0C1SmD5MLaLp7qlO99I7xhuW1AQRkyFZSCnWYYmz1s1Y0F1CQ/szUEybtrMc/MWXx
         OY6AAWtarupm8++foKRwFRqIlzFND35omJKRVufhsbhqcA3mLHk4iZ6IY8pPht+/Jg9d
         gjXlv37y8E7DY/3aUnhqG/0GIvsOL0iOTB51quwOlFdKuZFLaByE5QY7IaoGKdRqxI50
         1wejoqt4AtAll7Ij2RH2/0B7Pl8pTRTXfm3tLzvb0N3RUQA8W0W75+F84AEIHFf01hWY
         +XY7BkCenEpT4MHdC2TOjBYNmfD9ZBq1bB2QFMdqvzugD451gCbk0HHM7f78tQYxhL60
         vfOw==
X-Forwarded-Encrypted: i=1; AHgh+Rolusn2i6Z/r05irfNru+f33uuAymCLHyHDnaD4tUAbCsGu2BTmaF6AcixybyFBpxweYy+zYJW38mxfRTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzzc9WcfSeYLMB6Lb2EfBMlzco6dddNg9t2DK6bcGnzsAaHUA
	CS3uKIh+1RbQXX19tF29wHr9XL/pC8gtKX3WWokp+Sr+aVvNH2Pv6rRsgA/6wm7e9yatUl3MJym
	fWQY9
X-Gm-Gg: AfdE7ckQ0PJkTMXoX2qhxO9yEaJRtdVg63Vi++LssgheYsJ74VtJAFZB+FBaVxOcsXc
	1ebLuyr4Mqbqf376o1CXYqdX0nZ/nOvoV/kU+DAFjuAvhLz/4TEAvaU+Iw3RdP0oCpJZ+ECRoat
	oKvjT2WDNPBFnP3aMGB62UJ6I+xReaGRIysyNzNcVg3W1g2rQVxYFDUuE93VbFnYu8X1ahZ5EWX
	CingOVC++lM+On3kXhLsBIregXtOKgzdi3V3/mJJjCZNdbeT+ZGKNqGN++9cdxJFmAfQgAyZ2vi
	xcAtpli6s9qskOz0ddSvKqhIRFY0GxwWhZupenxcx5rQYHpmr3CZS3WzSeetuEcKdogw6l2VlcQ
	OQ2p4ciJQ6KbECzCmRpyE3vTL4eLChniQBpwq42F3DXrFuecC7Vj5lus2OlTJ
X-Received: by 2002:a05:6214:19e7:b0:8f1:36c7:497c with SMTP id 6a1803df08f44-8fec217aa9emr148367176d6.33.1783701516760;
        Fri, 10 Jul 2026 09:38:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d8fcsm45350946d6.25.2026.07.10.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:38:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEFH-00000007YQp-17rB;
	Fri, 10 Jul 2026 13:38:35 -0300
Date: Fri, 10 Jul 2026 13:38:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
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
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710163835.GR118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345362182.660027.12809852179204464964.stgit@skinsburskii>

On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> hmm_range_fault() requires the caller to hold the mmap read lock for the
> duration of the call. This is incompatible with mappings whose fault
> handler may release the mmap lock, notably userfaultfd-managed regions,
> where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
> after dropping the lock. Drivers that need to populate device page tables
> for such mappings have no way to do so today.

sashiko could not apply v7 for some reason but the remarks on v6
seemed meaningful, did you see them were they delt with?

https://sashiko.dev/#/patchset/178336023903.504354.7500950448226027718.stgit%40skinsburskii

> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index 7d61b7a8b65b..70885f153d03 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -208,6 +208,69 @@ invalidate() callback. That lock must be held before calling
>  mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
>  update.
>  
> +Dropping the mmap lock during page faults
> +=========================================
> +
> +Some VMAs have fault handlers that need to release the mmap lock while
> +servicing a fault (for example, regions managed by ``userfaultfd``).
> +``hmm_range_fault()`` cannot be used on such mappings because it must hold the
> +mmap lock for the duration of the call. Drivers that need to support them
> +should call::

Given the majority of callers use this API it should probably be the
focus of the documentation and example, regulate the existing API to a
'BTW if you really need the mmap lock, and you really shouldn't, this
exists too'

> @@ -32,6 +32,7 @@
>  
>  struct hmm_vma_walk {
>  	struct hmm_range	*range;
> +	int			*locked;

Let's use bool if you have to respin this

> @@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
>  		fault_flags |= FAULT_FLAG_WRITE;
>  	}
>  
> -	for (; addr < end; addr += PAGE_SIZE)
> -		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
> -		    VM_FAULT_ERROR)
> -			return -EFAULT;
> +	for (; addr < end; addr += PAGE_SIZE) {
> +		vm_fault_t ret;
> +
> +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> +
> +		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
> +			*hmm_vma_walk->locked = 0;
> +			return HMM_FAULT_UNLOCKED;
> +		}
> +
> +		if (ret & VM_FAULT_ERROR) {
> +			int err = vm_fault_to_errno(ret, 0);
> +
> +			if (err)
> +				return err;
> +			BUG();

Linux will be upset if he sees this.  

if (WARN_ON(!err))
   err = -EINVAL

> +/**
> + * hmm_range_fault - try to fault some address in a virtual address range
> + * @range:	argument structure
> + *
> + * Returns 0 on success or one of the following error codes:
> + *
> + * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
> + *		(e.g., device file vma).
> + * -ENOMEM:	Out of memory.
> + * -EPERM:	Invalid permission (e.g., asking for write and range is read
> + *		only).
> + * -EBUSY:	The range has been invalidated and the caller needs to wait for
> + *		the invalidation to finish.
> + * -EFAULT:     A page was requested to be valid and could not be made valid
> + *              ie it has no backing VMA or it is illegal to access
> + *
> + * This is similar to get_user_pages(), except that it can read the page tables
> + * without mutating them (ie causing faults).
> + *
> + * The mmap lock must be held by the caller and will remain held on return.
> + * For a variant that allows the mmap lock to be dropped during faults (e.g.,
> + * for userfaultfd support), see hmm_range_fault_unlocked_timeout().
> + */

Add a comment discourging anyone from using this function and prefer
hmm_range_fault_unlocked_timeout()

Other than the concern about the timeout and minor nits this looks
fine

Jason
