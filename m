Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E933803F4
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706858; cv=none; b=W2xMZDJrAPiKTERzEZhibzsMdeUE8qn6KvsoXsnpailve+uum/5oxCbjPVfmIlP+k8QAztwPVo74RBS/d+wYk2PIBxGgsc3Tr5f4OTJWxw3L0kh3KM5HSbkISTwO/8yyf26PIGwutLsv89ECatM9D07NWZIIXzfoO/QqH8CaevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706858; c=relaxed/simple;
	bh=O6OimzKD1xlS6Frl91Eg4/jvdk/NA4Un3exe+7jonxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qenJmDAk+LKRCPUKBdf+ssGvI7qfHtWbCvjjVWQNEzLt2gvUshJgqo0joCuQVQEn8eJ5IWnqVCDIEVKwBaS3dxvn9Z0Vm6yx0B/KhQ7FRWAFsLiPfYrs+BfwAfijXPsYjnKI2Dp0BNluEyIvJmu+wMliQbAm0lSYordSfiFOc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mmqZdc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mmqZdc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so10507735ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706847; x=1784311647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
        b=G+mmqZdcs0jO8PwuouqUz0af25DOsf8ysUuT6w/JdUZb+86uc/n1BimKSReR18OYbe
         9PkImlmJYekN/rctDqMv722YFQbGc2miKIz//KKcS18x756BAUG+70UV100zLJdYIdPe
         OS19SaJBHmrsHD0pqZdoubdYrky89nXRiGoTmYNmZCejXcRXuOtliw6+NG/7FtsTixdp
         gwRWecJb33MKp3I4QDqGw/46GM9u1GJnbpZ+Umbassa4Y0V+jH+xvonuYtWP4hCR7pOt
         2gU11ttWG8V0k/7ObjIPilGj4NEepzXluwL+HEfOqrzAKOp+iXkZIEXngdF/VkMaNtFM
         s5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706847; x=1784311647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
        b=IdmwLBhOTvCbyV7e1gbKON8dQOULiWPjzzOjH5xo3oR8o3239OxawwInL80qzQwN6+
         cHdhtKbDVc7NMkvmLa9fd1PdB3VHXxvbD0BBIukFYbCKd38cH+7A7ROVw3LG4ptYgori
         RoiMDSiy4wR3PhhSDvKZ7mZNM5DAiGTZVI2MUpAPb+EQWzWiHfMJusO67gCDWNpucoLc
         8OfmlxW/f2L9EhSAyGQKIrKTrdMMRnq1lUv+/euEwMKVzzostu5aOt1mHZ3EWtL4E8Iw
         U+FodvdMNbnvswad6GS55r1KGT6P1I0S3enx6c7r2onfqUAE0e3Qw5sAzc9dfUHqpy3E
         NDQw==
X-Forwarded-Encrypted: i=1; AHgh+RpcPhb5Fn3RyJPQy0dFqS9a0kkLekYKbtr5575DnpqCxMaXD7g5SOdYJ1Pq43AotzoHLQTrDPC9+kssaro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSaVlsXJTb/jnvVlK8sxiR2l0H5EDIqfU1YgxSY/M44zY8Jvp
	md1fxsMdr+l9upAPBOr/7BuAwi639MMhdY54deBaJqCNc9dhUjamgHXk
X-Gm-Gg: AfdE7cnQ6GIWlMkH05HkOyHjDpfNOC1jnLcpyQfoND6UyPYotrMUOCK0VBQXLQVMtFK
	lm8VtAqoGX3xqz+xbAGd3/xN7KteuLYJi8kDQnURjNW6eo3sCwTeli5wJ2VWCB63zLqe8o/CN0+
	ZxRCr8ZKOLiO+3rzjAndybRfU1jg8w0h6+YuEGQ1N7iYxuHWifIY9y90wDTtP0YUcHiUN+UYS/o
	WXAv8jNNrFhSXQvuRxik9xxj8XSCJx3lwWHbz8iaRynPNJbaLaIPv+9LopnTz5pHJrOl18juh8b
	lXeFtRd+EUT7ok47PRKqQpr+s4ER4tXL0BfyCX8T9LlGVytrgn2a1PoAF2yQ/z6/XJ4TPn5Z8jV
	5ixc/ANRQheseJdQqlenKIECo2spklWlUCMH6Kc5izxAnR0i5g2fHn34SDQ0dciuNb7uc+khTdO
	xAYFqB9/NIwzhmLF3AJs2F0fyQw57BhhmbY22ypXn1q14WZiaqGtdEwVU=
X-Received: by 2002:a17:903:2a88:b0:2c9:d8c6:1db8 with SMTP id d9443c01a7336-2ce9f284e45mr2337085ad.28.1783706847144;
        Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm63356135ad.18.2026.07.10.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:07:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:07:23 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <alE028DsCGeUwNh6@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca>
 <alElv0EKjLQXMNK8@skinsburskii>
 <20260710180312.GD1803712@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710180312.GD1803712@ziepe.ca>

On Fri, Jul 10, 2026 at 03:03:12PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 10, 2026 at 10:02:55AM -0700, Stanislav Kinsburskii wrote:
> > The main customer for this new feature I have in mind is the MSHV driver
> > which backs VMs memory with HMM, requires userfaultfd support for
> > post-copy live migration and fast restore and it doesn't timeout.
> > 
> > I agree, that this current timeout value used by the other callers might
> > not be enough to repopulate the mappings with userfaultfd, but there
> > drivers would get -EFAULT for uderfaultfd-backed mappings without this
> > change anyway, so getting -EBUSY with the change instead doesn't look
> > like a significant change to the behaviour from my POV.
> 
> It sounds like it won't be reliable either then.
> 
> > > So, maybe the deadline should be resetting after every handled fault?
> > > ie the timeout really is only about the mmu notifier and we don't
> > > count the time spent handling faults or walking?
> >
> > The timeout was inherited from existing HMM users rather than introduced
> > as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
> > budget for the whole range population operation, including HMM retries
> > and subsequent driver mapping work.
> 
> Yes, because we always had a timeout around the notifier because that
> scheme can sort of live lock. The timeout was to protect that only, ie
> limit the number of notifier retries.
> 
> Expanding the timeout to be outside what is bounded by the notifier
> retry is not right, and heavy stuff like mapping should be done after
> the hmm side succeeds and the notifiers concluded so they can rely on
> normal locking instead.
> 
> This is why I'm suggesting to reset the deadline as hmm makes forward
> progress, we really only want to bound the notifier retry loop not
> anything else.
> 

Sure, I'll modify accordingly.

Thanks,
Stanislav

> Jason
