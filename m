Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F163F9284
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969340; cv=none; b=EwZNlP778otE/EwEr07v7Ao0OFI9wnRr8Ofocfwu6PP44f03jFDHBhic6ZnbqZlFakQKOMXDL6fuWuhriFbO0C4RbyRIc8S4ykinpH3pDTWfSDdk72ua5sxP+hpDHJVcZ305dBLFu7x6/5DFYoDn8iudJu9GZU94QSNv3bfxCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969340; c=relaxed/simple;
	bh=I+UkeZQjqj3g0bJcjZoQjrVdpo8txWH3MfMsXY6UQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGq/vyxX6D5gP2VQczeJcjCZdsa2HCfIJ+l2ouyO/E2JkmBq4FrtKjVW2enwlwfBz1/KyG/nm1gMbHvgKR+lNPjnz9irGd1Ku7KNBFNYiBQCfOIyLALUUfTDfb1tggePkOZdttT1M7WcuoLHYq2/34tBOxl8jIxNPfjETanwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YA4a0nO0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YA4a0nO0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-936d00181abso145277185a.2
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Aug 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969337; x=1787574137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=YA4a0nO0nH4v84iv6elfrsvINBNSoFqqFooCYFt/cRuYftKq9UxSrecdC1bO8LxTmj
         34iaCd1M6wxXfmSzn4njprKUhNyXxgNor+wdcMdW+oQ7bkKBdSqcvOIhfP1QPqH/MXdR
         TBQlF7ijV7sLpk1nwy6HXvYVby0j3i7zTi6nGZJvRbKknPLga1un1MuRPNj/F89+8J8U
         3R+UfBzK5j0qFbBD6gmKibLW/K3dsysN3qBHU3AgSIwz6pI0ebsRHBdAHESNHqtXoa+0
         LkqS1kSLp7+n4aDiVSMigDPOBeLnNvNjrvp0z/Y80YXnNAriMzzHP38XdapZG3uHhgC5
         s7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969337; x=1787574137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=UF5e9JZ7s4rfH06awVhTplEBkIUX/MtcmX2rfQdoEHqnmEN8f//fxmToF9EkqbDDW8
         wjcJkdsCYS+aReDxpM2Vxvp0XiYc1RN5xoVengCyLMkguQHulUMSm+BxbFY24sVOQGhU
         8ovOiJVWAxedqT0PTR6BEY6Nm7cdC7HHkEAtsDcxeWyvHkzvZyOuJqPldpxWLNmcTZRY
         8JaxYVaqeIhFC0gT/a1RxejBHJWEK7kf8bI3BsPJA9p2824hIbG/Dv5j3CAtPZMCKE49
         0yJRjNOjijCYeJ3xLbl6CzR8vGMDt5O3et6KAxg2UzJFu9GE4Rcf4jrC45eDv48b0NJH
         AY/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp3qeYtwDIPa6vichOBFyv2tjB6VrhV/GQNNYkIIsP+o1p+uGzL3BiWkU30io6GeDIRMM0vo76Qu5Xqsz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULX7Bk54IFohe6PlCyb1bsLJOi6oV2WYTOYi3+PqvuDhIwnRj
	PfwMM345GVhvaQ99L4cLbu3OElSdPydq6XEHGyIxvUx/O+FA0KWrUJyeadeknEG6JoI=
X-Gm-Gg: AR+sD10GAL2p3U5apq2u3MtYElW1xM9BKdmnDi76mY6llx82B2YbGU4ge4ZzHQY/OcI
	CchY88z/9/blDCuLpAK3dtkXMCJb8C3QOrXw4B06FQ7YrZ1cxfPqKo2Rp7EH1gw/9MWeO+tEgf+
	wehd0N4bJxKANuqYZRwO1h39/V+BMNTIrqnsu8HQ5OSkdWD/BMa9a8QYFh4Qf/e+kOsoXb+mabd
	agX/xDApRksRsYfB09bf0bHc0KUs4bX6XLc0rLKJlnFtterrP/tjm6lwTDbJcQ4DSdm3zykAVt5
	y//Aqzx0vlsyi0Wi0Bmti2YbzWt309Dxg1NLIlRNPr/JrQFQUg52POSmL2FzJQtA01IloPx0vSk
	H/gHrSUDQFQKYjyiaNP2TqORmypOy4yLHeRQbYBGelcRKCsjhD5sqVttx7m9BxHgCJOnbMe299a
	w2FBqXEKeohGmgTiNGJGR0LY8uyVIfgPViVLpoosj3ydSjJJJZww==
X-Received: by 2002:a05:620a:2552:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-936d202b715mr2670485685a.19.1786969337333;
        Mon, 17 Aug 2026 05:22:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fad12sm31868985a.36.2026.08.17.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:22:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwM4-00000005tO2-0GS8;
	Mon, 17 Aug 2026 09:22:16 -0300
Date: Mon, 17 Aug 2026 09:22:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817122216.GD933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>

On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > Why check it at all? Is there an issue with attaching the same thing
> > twice? Will it blip the DMA or something?
> 
> Actually, I do not think there should be any issue with attaching twice.
> Hyper-V *should* be able to accept such attachment. But I do not want to
> make such assumption just for a redundant hypercall.
> 
> Does this reasoning make sense, or would you prefer that I remove the
> check?

I would probably drop it. Having blocking always set blocking to the
HW regardless of what the SW tracking state says feels more robust to
me.

Jason
