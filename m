Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDA39E9DE;
	Tue, 12 May 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602732; cv=none; b=F+do2Bkeac801SDznu8+zKRjzPhLRgfPZYBhSJhBHfFyu/t+5DlkMSSWG4uDvlUa3DQectQ0uSNcgUYkfcEuVL6lw1xsxm03jIe5s2l6RGlZc7CUvx1EwLIGFNE25nujytkKmatdcu6lJboT/BZaNivKdoyqdAjQ+BdjQRHRKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602732; c=relaxed/simple;
	bh=8XFd6GbcBLGGHzmX2zLvpVShwAmL65/U/v73rY5+HBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ptc1pEDFGxC72C+Afi6PjuDG0rl8AwkaIi6E2NHFbGQqkkEwenA07xh4QcVx82n+zXO314EGAQ77OTC2mrNJefj4ecx8O4p1TDum6Do9LgOynKCoeKWfJKU+HfS9Rc4Z+ORnHpDvrbakF3OxIll7yBaZvS42Up98FTCt/O4DwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KWQck597; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KWQck597"
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B64120B7166;
	Tue, 12 May 2026 09:18:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B64120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778602722;
	bh=Uf3CnoeoD1JaJ9/DXoxz1jb7GBmNLqY9irHzO+pPh0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWQck597/eyja/NgCMAmkLC3+bWL5hWVU+Y66nu66N5UekfOjtVOB6GjKYNXVyVjD
	 ufyi56nCuI23ffrZ1mDNNNacGzY8zvU7I+bAkw7ZuMQgMgaNmaUNxKHaeWaIr2+dyr
	 J4TNJtiDGtT4mGb4Wzvblbe2M6QKyghCab8lT9Fk=
Date: Tue, 12 May 2026 09:18:42 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: kys@microsoft.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	decui@microsoft.com, haiyangz@microsoft.com, jgg@ziepe.ca,
	corbet@lwn.net, leon@kernel.org, longli@microsoft.com,
	ljs@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@kernel.org,
	wei.liu@kernel.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/hmm: Add hmm_range_fault_unlockable() for mmap
 lock-drop support
Message-ID: <agNS4llNtAHBkMA2@skinsburskii.localdomain>
References: <177759835313.221039.2807391868456411507.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177759840859.221039.13065406062747296947.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <563bb216-c270-4711-adda-b91484af40dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <563bb216-c270-4711-adda-b91484af40dc@kernel.org>

On Tue, May 12, 2026 at 10:42:14AM +0200, David Hildenbrand (Arm) wrote:
> 
> > +	for (; addr < end; addr += PAGE_SIZE) {
> > +		vm_fault_t ret;
> > +
> > +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> > +
> > +		if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
> > +			/*
> > +			 * The mmap lock has been dropped by the fault handler.
> > +			 * Record the failing address and signal lock-drop to
> > +			 * the caller.
> > +			 */
> > +			*hmm_vma_walk->locked = 0;
> > +			hmm_vma_walk->last = addr;
> > +			return -EAGAIN;
> 
> 
> Okay, so we'll return straight from hmm_vma_fault() to
> hmm_vma_handle_pte()/hmm_vma_walk_pmd() -> walk_page_range() machinery.
> 
> Hopefully we don't refer to the MM/VMA on any path there? It would be nicer if
> the hmm_vma_fault() could be called by the caller of walk_page_range(), but
> that's tricky I guess, as hmm_vma_fault() consumes the walk structure and
> requires the vma in there.
> 

It looks like a caller can provide a post_vma callback in mm_walk_ops. I
missed that case here. This callback cannot be supported by this change.
I will update the patch.

> 
> Note: am I wrong, or is hmm_vma_fault() really always called with
> required_fault=true?
> 

No, hmm_pte_need_fault can return false.

> > +		}
> > +
> > +		if (ret & VM_FAULT_ERROR)
> >  			return -EFAULT;
> > +	}
> >  	return -EBUSY;
> >  }
> >  
> > @@ -566,6 +585,17 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
> >  	if (required_fault) {
> >  		int ret;
> >  
> > +		/*
> > +		 * Faulting hugetlb pages on the unlockable path is not
> > +		 * supported. The walk framework holds hugetlb_vma_lock_read
> > +		 * which must be dropped before handle_mm_fault, but if the
> > +		 * mmap lock is also dropped (VM_FAULT_RETRY), the vma may
> > +		 * be freed and the walk framework's unconditional unlock
> > +		 * becomes a use-after-free.
> > +		 */
> > +		if (hmm_vma_walk->locked)
> > +			return -EFAULT;
> 
> Just because it's unlockable doesn't mean that you must unlock. Can't this be
> kept working as is, just simulating here as if it would not be unlockable?
> 

I’m not sure how to implement this. The walk_page_range code expects the
hugetlb VMA to still be read-locked when we return from
hmm_vma_walk_hugetlb_entry. How can we guarantee that if the VMA might
be gone?

I added a note in the docs. Whoever tackles this will likely need to
either rework `walk_page_range` to handle the case where the VMA is
gone, or use a different approach.

Do you have any other suggestions on how to implement it?

Thanks,
Stanislav

> 
> -- 
> Cheers,
> 
> David
