Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41546431E69
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702981; cv=none; b=ecMfbx3RHlJP9Xf4lLh5sJTCxWgJ4fyYrBsKoS9YOccO5Rfm2BQvj7bvmTLKz5krV96ZwPbXTGrNXsDEux7r5BRZzaM5X5xe4LFxwtVqgvOAMDpyJnrcHhXko96ueswEmkpyXIRalnfDTWSj7pmxjpvy/NWeNI0xeT5+JMXYhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702981; c=relaxed/simple;
	bh=aBkOaovDmCOVZZHolmZ5nommSM2U/0R+0JcIuWJu4NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXH4IIhfArZUtsZFDiVfYNJMhuGCB1mB0WqhLhaFZJFQJaFKVImKLqa1MlsTA8rqDqVOwkA0IyxkYVOLAhm2rKc2BGbet4MrOX8nrpeWeURAXxrnviCr/zoPZKdudAOTnXcWJaW+EDYLpzwT+VaBl6wQmVBEfkGlUv3gq+Gzhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUF4YcaC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUF4YcaC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso1239143b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783702980; x=1784307780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJt4dduVMLAOIcmpuYMBgvu3eT4RLvOgifRZbg/Z4kQ=;
        b=VUF4YcaCCCyInq90IWtdRjj5gOkVjqBxg2VY1I9myy1ULGQmo/0AQk4vfAcFMi6nD5
         ThuFDH43hsenbYxtB6HjzqwbXG5AYWA3fjxbseKR5eSxUWP0lzGEraIgM8j8UcPNZdwm
         pnbiNqd2UpuWKAiny+ZPCBg4dqmKom3clt4LG3Jo2wUmURS7lwYJkk50dG1hS/UXXtSO
         HRq7T88j7iw+q4FgAeiYCOTS4Gu0dBXaZXV+RhDMRcOy1JU6fLkAP6y7PQtdCKS8k469
         YHNqxLS7B3BN1nWUTLwxkTOIwLUU+Wzhy622XHjyOHvlilT2phaR0UyPuLRuSkHjY7Tj
         0YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702980; x=1784307780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJt4dduVMLAOIcmpuYMBgvu3eT4RLvOgifRZbg/Z4kQ=;
        b=lgrM569PmIoiyo5jZbnVQAPUN5nnA+5Yf94EOTkrWF3Vuc1/RiUqjPz2Jfwt9iI9/D
         pBkPBVwqIqypgqp8pN2JXCxub0lSHGYhhABFF0cgA4s5cUXVUxJn9MAObKE0mYtyNFCD
         ydPj9aab8ooL2CigTAXPq5lWaF8BXc+5Tt2qZTb7ay2EE4LZMQgmOYxCElP81v1UnRsw
         tRHpJplJX7HbV9AdVg1nqHh0MgQFL53/fs2p+Mc1ivdT1MNV19Ev/kvOVDGYQY3w/QRK
         8nuwZ39d5B8ijHBHI0okuRDW0/HSVT0VNh30yGZHnTvRoZ0Z3zszdCI1xVVVwzv0tT17
         wVmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrP+BsGBwNiWkRJorMu+E2+JtFjbZp0+dV77m2zh7eId3XD2MXd51pUZK9OndgnUAMAspa/S7hww4etMPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE93Z3zMru/wyeyUeZSKfIj71KIDZsPUphKxsOetKOswcs0ztn
	NjKOzS+b6yckPc4C5a/HIb69kOwR5rG2nrl28yul2txg73yi58e35LbF
X-Gm-Gg: AfdE7cnry+H4vYMrNhz5mfT4ttliydHXCGLqpOo5liPB15FasBlhHV5Ea+3LKZeT+Hr
	v+Z7+SjCV/SMH8WN7woAuCH2pYSAiF+K9x3H70f5UcmldKV7ixEy7/T/0OlYfO/CErzz+1JX4Qa
	GIVPaHbzmLTl6oXH7zoK6VKtARjITw2OeYN/s+GAvx4UX2KSt1FrDznP7rH35PHPUpEsqx+tZOa
	URUDoGlfQ1jBXcctssapOCGKB42w1I1gtmIIEMWKjHDyy82PuCTSSw3qu3gbTMQ5zyiPftzgQKF
	uUow59KKXYZ09OZZrvAOy5JWXrJBCouhp7nKJO8x0T80/wHOrqI/VgywFeLk0+2vv0KbX6ilWfM
	T8XbftW18U4UCOiX9Z4VIHGvdBU/ZOc6Wm5lBO6Konk4AJ8d71jbht7W9vXBiT8wvHnLu69vKyI
	4ROPED8CE/qTlyf754dlRxEIs4bG4lQnIMhiBHSmkzjdhRP++T805a+p0=
X-Received: by 2002:a05:6a00:1f13:b0:848:6ba2:4139 with SMTP id d2e1a72fcca58-8486ba24522mr4844235b3a.36.1783702979579;
        Fri, 10 Jul 2026 10:02:59 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484519580csm4394040b3a.32.2026.07.10.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:02:58 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:02:55 -0700
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
Message-ID: <alElv0EKjLQXMNK8@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710164743.GX118978@ziepe.ca>

On Fri, Jul 10, 2026 at 01:47:43PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> > 
> > > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > > +				     unsigned long timeout)
> > > +{
> > > +	struct mm_struct *mm = range->notifier->mm;
> > > +	unsigned long deadline = 0;
> > > +	int locked, ret;
> > > +
> > > +	if (timeout)
> > > +		deadline = jiffies + timeout;
> > > +
> > > +	do {
> > > +		if (fatal_signal_pending(current))
> > > +			return -EINTR;
> > > +
> > > +		if (timeout && time_after(jiffies, deadline))
> > > +			return -EBUSY;
> > 
> > I really dislike there is a timeout here, HMM is supposed to be more
> > deterministic. GUP doesn't have a timeout, what is this about?
> 
> It looks like you've moved the timeout processing related to the mmnu
> notifier sequence from the callers into this helper. I'm fine with
> that, but maybe add some comments that this timeout is helping
> implement the mmu notifiers, and we do expect that the HMM part will
> not timeout.
> 
> Though it is a little hard to see how your stated purpose of enabling
> userfaultfd is going to work, aren't you pretty much guarenteed to hit
> a timeout if the userfaultfd process is adversly scheduled? That's
> going to end up broken.
> 

The main customer for this new feature I have in mind is the MSHV driver
which backs VMs memory with HMM, requires userfaultfd support for
post-copy live migration and fast restore and it doesn't timeout.

I agree, that this current timeout value used by the other callers might
not be enough to repopulate the mappings with userfaultfd, but there
drivers would get -EFAULT for uderfaultfd-backed mappings without this
change anyway, so getting -EBUSY with the change instead doesn't look
like a significant change to the behaviour from my POV.

> So, maybe the deadline should be resetting after every handled fault?
> ie the timeout really is only about the mmu notifier and we don't
> count the time spent handling faults or walking?
> 

The timeout was inherited from existing HMM users rather than introduced
as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
budget for the whole range population operation, including HMM retries
and subsequent driver mapping work.

Moving retry handling into the unlocked helper would otherwise hide
repeated -EBUSY returns from those callers and silently turn their
bounded operation into an unbounded one. So the timeout argument is
there to preserve existing caller semantics during conversion.

I'd say it's up to the caller to provide big enough timeout for
userfaultfd to succeed.

Thanks,
Stanislav

> Jason
