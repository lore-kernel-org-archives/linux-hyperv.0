Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA00438022
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954507; cv=none; b=JHRo9BOcrtPmIPzjDz/bq3om6+qY3ygH56QRB0SAjhQfNs2HXQcuqZH/rX7cPhlzufHXi7cMfI+mzkSdxbor8BKYR0q9LZEL/E9fPopi6VNn8JrQ3jkZok7LeWlwvU6xAoGT2c+q7+p8kQEpp+CPlotLAfCBb9hZM8gda34p8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954507; c=relaxed/simple;
	bh=GEh+g1NiW3mR99aSYCyQ33wt1J/GHPQy/vLk28L6OPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnK65rEOL9FGmUMlkCesVi1B1XJxWz7PXoLfBmcWNVHEN6Jv2x61HaOE72sYA9xHo/2zjJSnpXI7WgTA/McUbhtAysdgU4r9MCIyq/XJSQje5Ep9uh/BqVp9I38Htr8BVcanNeRqBqx9eClj7QvtpVOkjeDamMiU/z5QZqdYIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXXu18NO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXXu18NO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a449c57so24821511cf.1
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783954505; x=1784559305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
        b=iXXu18NOzE/K64fJi0fS7XlUycQSsVxXqPVr+DHylcaFLj1ZBGlqbiKaNjYo6pMNIm
         fSiRCUq6RCQAbt++t9n05E9YILRvIwfGpADmIjWHjg4w9C8rhQ2bV4ZbFCsGOJc2Gi9h
         q0ipGuVIBlXhdX5gvz/3Y3NfqBQ95zhUsKtWVIxTviWCAqHMhe+FlLmMacP5a1uSsAxy
         XCa5CdP+NztGm+lo2TBbweNAKDuzXp3OW20FggC18NySuIIp9GsP7Fts37KEB8YucUz/
         RTJmsqpTBastICdMJa+TDHNa8B0sYSLIawq1pS+VlCcHU8CgR0mFrSEaR9qVNe95TjcZ
         BA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954505; x=1784559305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
        b=i1g9DZjP4wqGnQD9yU4UM1CjXeqIS4FmFnXySrtGwbZ/5vG7LWdK2FKQgPfsJne5NC
         gI1mb2R4VKTRnBLOc2UjhPCvCdOXNlS8gKJpKU5DAEeem8TyeVDpml0+LMNma02f7uTR
         KUCy5j0qThxx6tmZpVlusgPOufIuXiKQIHovUp+zskS3Yo6n10JXFo2ZWZXy9dWOit/R
         lxYKMUPGmdyAq/U6rOl7SJHENczTqy2PDL13PGO9cLCpDkie3DODWVFHh2OnhkfACTT+
         AO1WLAMljBis0pIHzqi4G/EN0YefOraD5JXZ21jWnRitJbx+tqfvgdzgz5Y1QyYt6kQI
         c2GA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0+gwmr+eADhJsoafwsfb0kUHgJQfIqJpOVF0wfDVqoQsmal0X3TT9f3iqCfvWEiw1tFqllS4dwOXpSEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCZGEX7keZiDwKTqYyY5DpGWkPEU2OZz+b7aCKgex7TAjANYl
	W/+l00ZgFGQZf2okfPJ9hxq585jKQW84AAi/LEwrGIhS6R24IRe9K6ziWcGgyndJ48c=
X-Gm-Gg: AfdE7cm9usANw/gsW2e2ofPMb6WjRXNlXlQHkQlLXZ0w0ac4dcij9fBzs7NmZ/JZlhj
	iu7Oe71XLe+0QpKoRXzpUUO6ES3HaV/eL3+qG3+dr9wceGrW1zVMDPf+N7YfvuIIk5KNVaBd+Cy
	xyWDnPjlVoRKIeVGYlDt92bt/hMUxpoeW5s1NxZ9zpn3qSbkNRA0dS8qv9Jzm3imDvcQRt8FHYE
	RopvXdnE8JbIzrvkZWztP0CAo/rAoQWBvO0h+DAXOlmCP3F5K0uZmQMi9SmANMJMw1abzV5gRTk
	ortJfSiGX3WsPOca4gGQujW9zuuS6agM/zWGfvbgweAq8e/vp5UW+nZv+Zp9BtDTOoZCAhbrp8q
	9n8yqRHFgql5L754S3/QY1aac8zhMJzFffHhn00rieq6qQJqjKiX9z2L0KkQhKmqXFJ2itIc=
X-Received: by 2002:a05:622a:1911:b0:51c:504:2ef7 with SMTP id d75a77b69052e-51cbf305510mr90471451cf.67.1783954504822;
        Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm84876451cf.3.2026.07.13.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjI3j-0000000DQQj-2xH1;
	Mon, 13 Jul 2026 11:55:03 -0300
Date: Mon, 13 Jul 2026 11:55:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, airlied@gmail.com,
	akhilesh@ee.iitb.ac.in, corbet@lwn.net, dakr@kernel.org,
	david@kernel.org, decui@microsoft.com, haiyangz@microsoft.com,
	kees@kernel.org, kys@microsoft.com, leon@kernel.org,
	liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
	longli@microsoft.com, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
	mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
	ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
	shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
	surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
	wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <20260713145503.GC3133966@ziepe.ca>
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

I think hmm and kvm have had this issue for a long time? I don't see
anything in the mmu notifier locking scheme that would alleviate it at
least

So.. In terms of this series I'd leave it, it is no worse than before?

Jason
