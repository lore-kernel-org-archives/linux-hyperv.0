Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40713C9C4
	for <linux-hyperv@vger.kernel.org>; Sat, 11 Jul 2026 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739805; cv=none; b=WGy638D1IY1pm/tZ6sEmct6hysNcQCXsMIZTzw5mM/XZCVSeV/ylsybIMJTZ0P3lksDAIdKwAbKO2B0gijKIrwSPP8iuqxlH3Rh3wRKws2AvL+hMTUDrG6zPc3L69LjWpdale4CAFFWG+ocLWGtmsQnFWj6dyw0To2Hd5xQbT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739805; c=relaxed/simple;
	bh=B3DNccZp5dt31xSN8qydp5e80M3HHyRBCHgLNJEVo70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEssx+CEuAAKZ2jhR6QOxJSWLW9VGxKvbdmXdp2CUdGM37arB0t51PBEVFQoW5ZD6hPdfDvV8fSsSYJ8rBz6uZKL3bJlKkyMNV0jOzbHOgCPqCLlXy5730mSPOuQgTjiJSiF2xN+KP9zW6MzZeS9zcx1gFR0R+UeX/E0qDYLRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcLxFmF6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcLxFmF6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2030818b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739804; x=1784344604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FBlRq40n+WQNoah/jqkKv0Mdb6DSXF7flMHY66vmfak=;
        b=KcLxFmF6Yn9X45t/A6xxKDCYHrBSJ41t8fEBK9PkCHLXW/K0gjuF+pSG12tQVenpXI
         N3z4OgZMhVUgrhCG5U+TVI5t8KErmisE08WqJko8sdkfeloCaffPgjPDyfXaA/gjWl9J
         5pBqSNIcy87Uwm9vJ2mbkTghXmS2k6qvfxKk4qLohwOSo/GfAlVNaFa6Q5QUidhTz3uc
         eEDzYFDkJOPdqIx1mwH7enFnVOOSv2zLCNTm8Wmy2hNVfcJmwf/PSC534His1I5bGm4E
         pOOtvYLdgpI+kh5bLvFNDsocLdlhBtfcCKx3sMe4z7CEgfUfFnqEeBEaWYZOTvMjJkP/
         3WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739804; x=1784344604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBlRq40n+WQNoah/jqkKv0Mdb6DSXF7flMHY66vmfak=;
        b=FV2jEBPKq6LgNgUL65eLiviPzkr5MgcT6XaaMX4RPFPKoihVpnwpGp1A3E1GgGyLwU
         Vaq+4mu2GYZeF1Frs4boYAK3vQe3K1M8tYgF8UM4lD4aurG9C3p0IyxT2nNkFtJqWfuw
         JdvEVKVPgemzMJ6fhDzwXnF5Ah1lLQpbVpkzucCzk3yRRI5t2HRxWwZdS0fgqnlu0d6I
         gjhq/6RTSG3FXVwxlx3Gy9X1NSskUkLdw8EKGvjV7P6vRSXX1j45+OW74Jl58uQiyT9W
         oeyVT2o9HFYHsQz9v6wMh+Ez2IH5dgbWFO75tO3WOOss9DIbk2hkhDm7XYWg5QtSaB+Q
         h1Ng==
X-Forwarded-Encrypted: i=1; AHgh+Ro0LsEY41UgEZo2/LxXTTvz/E9BGTOsmcRWHWgWGmKJXH0Z7ABj+1ziVh0SR5BlbOnTK2YcXW2P8YmH+2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyey8sVFN5W2XvUofVJLYoJpHMJ+VaxuDcQbfYQAcskv0Xr6q15
	9/LuLI8dlAANJZt3+THKBVY4U3N820suqW4Ez0UT9CjyMrWZtqBRzUKz
X-Gm-Gg: AfdE7ckgrkGLImpn6sLsFs56mxCyBXt/X513SbV34/Y5HKHbxRQ9mZhKd0LtzzTK0E3
	M8iqqcu83ljshzmZhpk4RdeVbqavaZrGHsWpRZF2htSXCMChBk8YBLHSfT2E18FLeXey7Oo2XVW
	yWGlv+WoO/X8IkaghQ0mRH3HIgSK+CmUcflsbGuczXlaOaajE4yiIaYLiJ011JKRq6xr3YclKwR
	2NWVsSiGl04QALZVtlzyv3kZvECKZQsJUkv/RHhqYDY9lufkxgGRKYfSRU1iisqY/ZzwO/8BYjs
	xrXVmk7yzshlOdWu/sj9/Gj0sxR8vE1L+Zbtt1lGXk/cSFY2sPReRz1z68y/Y3H0cxTkEbbbTST
	5PRlUGi6e5t1B2w367mYXVkVFVsKOrfg0Kt+n+Dc08hnC8qC8i/9VVjVd/ot6PBF32FXGiwgE3D
	omYZrxBbdsHpmp5YtOQYjYABtl4h2nDqwJ/N/4o8uqq/2bRXEu5q7r8P4=
X-Received: by 2002:a05:6a00:b4f:b0:848:2f77:e2da with SMTP id d2e1a72fcca58-8488979d33dmr1391764b3a.67.1783739803838;
        Fri, 10 Jul 2026 20:16:43 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84870d76ce7sm2041406b3a.55.2026.07.10.20.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:16:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:16:35 -0700
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
Subject: Re: [PATCH v8 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <alG1k3JsoywE2CBM@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881847.900500.8789369230260725500.stgit@skinsburskii>
 <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>

On Fri, Jul 10, 2026 at 03:12:22PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:58 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > @@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
> >  			goto out;
> >  		}
> >  
> > -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> > -		mmap_read_lock(mm);
> > -		ret = hmm_range_fault(&range);
> > -		mmap_read_unlock(mm);
> > -		if (ret) {
> > -			if (ret == -EBUSY)
> > -				continue;
> > +		ret = hmm_range_fault_unlocked_timeout(&range,
> > +						       max(timeout - jiffies,
> > +							   1L));
> 
> "1UL" here?  I'd have expected min() to warn, as it likes to do.

I'm not sure... The "timeout - jiffies" can become negative.
Won't 1UL convert both of them to "UL" and thus make the comparison
overflow?

Thanks,
Stanislav
