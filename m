Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5A43B3E6
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701829; cv=none; b=hgwYHlfKSvwnmMO3FhKAHBgK53KUH2hFDa7+nFOcQZJNuxr8yu+qE4ZFkmyeHMXg2Ml4V40FN7MN5va2fr9hD63DIzSA3OVGVbwzB9GE/eaB30fM2L1w4FVTx8yTdpaGYn8jhlToAeqvoDhShJtpbCFTAgiclmvdAsSRlL95ntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701829; c=relaxed/simple;
	bh=uIhVIgctXUQcWy00AudXCG6kW+KyBF/3q5iL5v2zEVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkdg3NQuhztfCyfbGG5w5EvB6CoDc8ssTpnFWTrm9w7mbgwejXPyfqWw4mxR+4D41RK3UNIvRsAX7PwSG9OIt58Rj9NlNoG0GV26rMuQdmikFQPbQFIR9JGJZW1vJ6QKHHY9X7+WkwuIhLf9H+7n/nQeG/LTMPMJLfbyAWNGmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AyS1Bxmo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AyS1Bxmo"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-920f33347f5so58828985a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701827; x=1784306627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
        b=AyS1Bxmo0N6YHkVKH9oyazzctAf/4C32alIBv/QFTAAa8UmyfwpnYGzVReGFWv+DP3
         VcpePWyG1bS/CSWG/+IpVMdTuFeZrVes+MBNYw+9jRJF8pK+0K9aHMt4bLIgaQ/7/9hy
         VEfaWMdWITdKdLpPAeSE7Qtwa29EwC4oxt3cBiOlEwjIPNBgoy3jXc7Geh1fAHMdfQfZ
         Kmmja0r7dBY5Rh+6mWUg0+qVA8QOzx1s2Y0bHZcGk6L+fiUylkBBPLREklZMk2T+VfcS
         x9bojoZx144A8gDBS9ilm5M0wynR0XIEzLUj2z+6xCiHnXv+Il1atWK2ekrdouHfCya1
         A7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701827; x=1784306627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
        b=ezvnMK2OKlg7SXCbzWJEe8qq+Soqi1bNnAwYjoLUlA9pjz97hmu9liP7lv9Eq4qFIa
         Ye+q+K8+sa7qidJPHGXx9gKITN1zlY+YzVUbpm4+fV6cVY8UpMa6M4d4r2CjjbbbMjpM
         k8jyh8XO5W91kYU3VIdgDLV8zgNlFLt4svIjHHpj0QA+wcSOYW4GqFvijQAGy/NR0Xws
         5VccSAIoeLZ2HgsQthptcuUfBwHlvo29Z0W8L9EXufvPd3Cep06pTJNVIOPGIPZvCdJu
         RtIN8Hvva2i6xsT1xPrAyOKcVhwVw4MFGTGmNWwFwoAk/YzFZNtSZqK0Xmfkj8cgmkAm
         XnRg==
X-Forwarded-Encrypted: i=1; AHgh+Rrb3tP0OQC0ePkN2He2vfNVH0nltmo4PnhekqB85P1FOq17O7ZBCuf4nAuEvfhRNAUnx8PQrmzXeQ/vk64=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJEbbsuObD4wbjYTUu+yYBRxBAiRjpkZ01Vs5MrbwHUfR+WQD
	qCLRfONatNSf+xqFtAMgr6RCSXqPeIMFOsxr0g2bvK+lK48eEYppL3YtSRX/C0a/OII=
X-Gm-Gg: AfdE7cmXPLvTp4x5yY4myfly2UvuCzXQELiC/dRTnzwzay+Xx3TdZk7prTxi0bk2khj
	af/lG8GAFOX48eXPSUqZ/Geh64N/pUm50RxUNvK7SDlC65dexZxMIHEAIEcUU5+n5SOl173TFGT
	UcfQdSBZn3jzsWIoyjquMMA3NJDzV0vFk0+BzDfmZW38ZPudFecmOATtEjvjzG67hcgCmLnBmG3
	7R+4LS94l1MRoO8DOVAZAxKxYfvdSYt7hd+S6dLM/IRdDHlXVei1PTx8iPrARbJoLW2pbhCNWz0
	95/uKZdXgMH1waY8EzzaalkHx3qskoad1JvHiyFb6rNN6Qbtwk+Y7X+rNzlTnmH04Ea/xQhFtvx
	cgvW7fyRPHPj/Q5t2O9YTM+1fZC9n+IANdnWGedvis4tO1uK+MMy3aEfJhIsQhniaAgTOdEY=
X-Received: by 2002:a05:620a:240f:20b0:92e:e569:dc20 with SMTP id af79cd13be357-92ee569e3c8mr347342685a.78.1783701827057;
        Fri, 10 Jul 2026 09:43:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee59223e7sm237517985a.0.2026.07.10.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:43:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEKH-00000007YpZ-3qzk;
	Fri, 10 Jul 2026 13:43:45 -0300
Date: Fri, 10 Jul 2026 13:43:45 -0300
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
Subject: Re: [PATCH v7 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-ID: <20260710164345.GV118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345365679.660027.16671418103486907555.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345365679.660027.16671418103486907555.stgit@skinsburskii>

On Tue, Jul 07, 2026 at 12:47:36PM -0700, Stanislav Kinsburskii wrote:
> aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
> It keeps a single HMM_RANGE_DEFAULT_TIMEOUT deadline for the populate pass
> and retries -EBUSY until that deadline expires.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes mapp->range.notifier_seq for its internal
> retries. Pass the remaining jiffies from the existing deadline to HMM,
> while preserving the driver's existing outer loop for interval invalidation
> retries and for selecting the next invalid mapping.
> 
> Keep returning -ETIME when the retry budget expires, matching the driver's
> existing timeout error convention.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
