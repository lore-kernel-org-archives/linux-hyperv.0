Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910663;
	b=C2LOb6fM03DyHKBDen4qpcjvtM00aErBuywkRg5UJpqc4ueNkqDtbG2fsskCDbJgSd+P
	 fpUVsQxeSR3hRpEfKxWZkkcWQfOvhDPtM0FXtaJuldUfYClf/3hXuEkzv39Hr0asV+S+C
	 JrObXzO8GlUVkPO/ae4SBIRBHa3sdGi1mWMgM7gPx7fsVDyK1nQga4+3kzUHp5pKDdwXR
	 IugjD1INqs4k7UQGdW1VAHCo8bEcN5DhE/XuvjimoBUjI0A6eRFTnMoeDbNqnoF7WOih1
	 vcFNAOd2gfT4G6zkL+EFD3qc7BS81tI7k2mIbWuAFGW0cR8Ys0gvszgqN8ya3kRlu5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
	b=GtBoNTlEs145OmR3AySYEDeDn6KnNh0lk7rjoQUd9MXBXDg/dy7d3hNGk9vRcRNlK77P
	 cs1yaKKq0GCWG4lYAVxKsEQur9L49YSufnj7QPxuH+OFmRgrOxdsOcbCmCM4TtDa2u/q1
	 +q1YBMdj0hJ73fIyTH53SKb2kZHyT9jXv6zr2TwLVUlDnl4QjbVpb51rHOE9GUjnDXLF8
	 HklXmwwkEU+p5FrO3sL8d/DyA9RSo8cv65yzXFEpZNO6hMqr6EvovONcN4yClwAg63JME
	 ydLUSglJh04YdtO+H080tifZqfHRQcOg0pNEQPSxxKfM5HxiKD+WzQ7vRnyLJq+uDvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GB4Vyiwt;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6E606A32C
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 20:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D6E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GB4Vyiwt
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99071945aa7so1215720241.3
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Nov 2026 12:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793910661; x=1794515461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
        b=GB4Vyiwt5uW0V8lse1c3JVTIcjdYwCfzDi7ms6JirgIiV1XZ5xmCWALwaQI+Z5DkVl
         zqeI8t7tQbjcHdnzqj81OD38fGa0tJr/VDd51xozJWTYgz2a6kpRKU39Z7j5tFWNdr3h
         IlWW6rRHz35ntWDyTUhWHU80NWcqVivyAFXGbTt/s/XKSQp1WCy0b7a/t95WoCEvr32Z
         mBeL4GCHxWyznYCdN1cGfUJXo94un7iR8QgFQYTetODBOB+6GZkK2m9qjnyBHlZnnYQ5
         OCppFK1fTM3uS6RN/r6T0SWssQMIrs7tA5bt9YnfILWKR2UTcTHFIuyOTD1gwFZuhUxt
         Mt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910661; x=1794515461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
        b=2X2J9PEC+UYB6Lry7rlEMLFRnZF6fkgSJeqfpKul+d6/0BDHSlkFCyEa4bgVNa30Yy
         RsEPx/YXQmcjzeBYn+zU9N2WsNj3qxfcSdtXnD2EBEhdcdgEKH8U2EFAvlQ1wf2GfiDk
         tEcZpQvRt2e+IIsIhVm7tpzaGC9STrqIRvJHERB+CEefdqNNrGuDpDWvZsgdt4c1XXon
         qL1YIIFfG84BOeSmS3Pj40Bh0ntKT3krz7PmJtsijNUKQzC+/cDLv14FwBsDUeiZbipS
         KYFsE3Fwq8bAdO4qxXoIjlPwOmFmX7bTksL+0NovkzwfCMhseSZSUxhYXo7MmdR1J2Rr
         WLrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWJ/6nxl4hb3F3OSHen/v26xDbVyL2eGM9+HeRBjWqXMbeOUIpaIzhycBoe/eaiINJgKDuaGhUtCy27dk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UDAoQklVUv/PPuJEvdhN7wr8vClYCht9ayBZ0Eb79qSwjOeHN
	Hf7Dfhs7gwFS4ep8O6xePGH7N8CQJYrwGdf425DUeXwemCHM4VeYu+r11WADjS5WnFOUVxnpedj
	tiXLr
X-Gm-Gg: AYBFou2UblqrMC2ItD3mn2CzbDOOOsQnerFXvQQSZPx153hQYEA00/dMc02VSbgtrbx
	YTx5woN0zgD39kj93BGhVNDzV3rLoRndedt38XqEvOgOFBe31RLtQyDCNJRFiQxh54ellRclhay
	abh7csBhvuj/ePzV39ZWk+H6YiKtLgnxRKNrGsd1lK6KYr5lF8rg6C+XBH+wsRpvMeUoZLYMlnw
	CQh+J5D2+5YBVbIOy4qWKgc/E+DL4LW/0OKDJhhzxMKuDia6ual0ZiZ96a+qJOztSWHqDcUiBYW
	ov8wnJhzIHd9T6MJylZIGB6JogH4/94Psh3FRIQhOElLgbzEvs3COWsbpLWPVk+pYdXloJrqtu9
	VvG57ZM33rsalQ00r1NTs1Fj8PuHWoTXKA1cVi4ikDVDWiLtpHkm/164vln1FF68N4QbEpJFYT6
	cnGILcTI70S1t6j1LUTqkiNxQSlv6ebXDIWuX2eYuKDfN4J3PeW21JtXk2oDW9LiHWa266951b0
	qeRZDOlggharhh8YnbLSsnNDOiN3+51o/pfKaDT+dEA1YTDOvN0jjVfNI1gsjNt8LOwlukXhtA5
	UmV8CTVvVxnpdq+aZ1o3jbN1LUCaXKH97RLTbah4W5K5Oz8pF1/X2lRFOJH60qyenRrlOBb8Kkw
	dBIutDOALpA==
X-Received: by 2002:a05:6102:e0b:b0:7d2:7266:2c8a with SMTP id ada2fe7eead31-7d2a165f989mr692943137.32.1793910661522;
        Thu, 05 Nov 2026 12:31:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm5070410137.3.2026.11.05.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:31:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP46u-00000003hoW-1qsZ;
	Thu, 05 Nov 2026 16:31:00 -0400
Date: Thu, 5 Nov 2026 16:31:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <20261105203100.GG663069@ziepe.ca>
References: <20261105192738.70664-2-oss.patchbox@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105192738.70664-2-oss.patchbox@gmail.com>

On Thu, Nov 05, 2026 at 02:27:08PM -0500, Yuho Choi wrote:
> hv_iommu_paging_domain_free() frees all page-table pages with
> pt_iommu_deinit() and only then asks the hypervisor to delete the
> device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> fails, hv_delete_device_domain() only logs the error, returns the
> domain ID to the IDA, and the domain is freed anyway.

Isn't there a WARN_ON on this path? I recall asking for one ..

So long as that is there this is the right way to continue

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
