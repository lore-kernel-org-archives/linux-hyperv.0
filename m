Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271982;
	b=zqXrAKjwtGr9A+uNT6Lp3op7w1XmTzduvvqKhgLD18AiIEF9xggImVv/F2UOi23k52ad
	 JWtED3/RbNl+TbtmPeU1SHI5xYgImN/6XtNlNTaM7GnBu+trDEe5OMa9r9SmDk5vYLqQj
	 1yUyt7d6ek/12z67OIRxZB2uffyAXd8QeV9o5NBJ8B2PZqDmMbccq+xGDoiKXbXFBYeA+
	 7irP5x+b/aoPcgE4IarjN5sQiaQWqaPTuH+xbUDY/x4wxpz9H8CWyl9uzhN5f/F4yA/XT
	 Ct3+a/BZMdUyZdm6xlLz2rO4IO603DyGs5FkTZVAhZIgOLqk3wiF+z4n2aAz9hwyv/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
	b=aXkF9dx5lVNK32STrZOSgqZxDfyI0Ol2pwlIa1VUg09r1ozxjTU1QVm8mG2F+wWW80ZX
	 B3QGV1+DfykKyan3cf0+NJu7QvKWxpjVztJFompv/p/9y/XeeGNKPIs8CcbxeYYAbQ7Z6
	 zL9ZmUFW6+5K+B2LrrWD6oYFhaVnw/xEUtA3InQrcQMxlX7oI8N5mOZ5AlEJbP+8Qx+5N
	 kdH9SeTfFuFa6PJnRt2npgcF11Wor/ryVQ2+WQT15bI5CJYBVk0ECPEdNiKPeSznDsa+L
	 /Nao299eTKa3flYoScyzmcA4m2zoY12lh2fEmcmmbliQNMKJeynB/4NPGPXnNwHxkFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UI0lGOzP;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A4606A332
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 00:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9A4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UI0lGOzP
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ea2e29d90so15602066d6.1
        for <linux-hyperv@vger.kernel.org>; Mon, 09 Nov 2026 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794271981; x=1794876781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=UI0lGOzPtjGGCWSl7C0++xvsyw4k27fssP2LH8P51PpkthjkaHj5KRci44EFlllRA2
         22mb0xN7sJ21C61B8NklSQ49XXlif29hkmARn6nYF7ZTHmI2dGgaI2OVUU89vCT4eFP5
         5LRJCqwTtBD6CfuWQsVz9x2+d/i+0bWwCFTQYtukBdoRFozTXPcKkrE92YIokJW3IncK
         GGkMlIDvhWpv5fU5ST0icLmUqNHsc7ncipYaVB16Nj5PkFTFvA5JpSp2xVQ429NppEbO
         5Cth1s0167K9uRdROxWZQJQiE0pbL9Pumg/2EUhQIg3Xg7iKMPVZ3xgsqRirOQTNWFqX
         eFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271981; x=1794876781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=NtxdCaIPg9osvpJq91CZdG1ZDjBA3dE5IqwyydhH9vfsyUOZl5DXzAUYJGHnikFQ+n
         mPvab0nkr5KaUX2+wmtSdaq13oZQhfXroCSl3/mqGAAfC7k3FJk+RANnOGvT8LAHM/1q
         jr0ylrsxERRQLhc+EHXu9O/j589/xFikPp6Z4CDi5bZnOGu925QdIEcYJaY921iDusLx
         iLcy3zHTTHIuNLR7O3JzOf6+nGqZKU3IcDL2WAkTkBRIMShEanqam/zkLO0Avndq3PH8
         D5638AP9SNlPdKA9R/fjdLPArozOfoH/HjcUax4Dc2LNz8cg97QikrJn52jhdulY8s/0
         e1zA==
X-Forwarded-Encrypted: i=1; AL+hErFbZUmVcF+C6YUfpgIJZgJRpRzbI/OmDJbQGu91Ssacj2hm6E9w/4NBeHJN/O6ClVpyIzAqIu9M0oHVsOI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z0wqmnTcCe/lghgCNcbbC/w2aurvmMsNYSqC3rmOT2qhPg4Qn
	xh1EzUV6419hsJdwyxb0bHDw/48WFJZzPtCZS6+zxsOqWkBWLs7TM+4uwk70j7AwmOwoS9WLHZj
	MKsO6
X-Gm-Gg: AYBFou2MTY/bw0OU/3eKW7WB5wYa3SbmQHMmp7W+jsVw2tYXBw8T/VPj/rQtKnhZ2mf
	Lc3Zvq7cspXuX69LWtB7QtnIXLVQG/4tp22f42Y5Ufad7yJ+8kuKEMxsrjbiA536dg85zJWu5zJ
	kloN2T3FHNrmHzEFbkYcX+F+Yn5+H2VcZfjQU5jAfUf+Cf1PUxQrKuXz4PVIKaJKAO6xeVhi64u
	SuUvbsraqL2sbf7/GMF5Fh7/fb607kwtVXssjLurqrZIeNDgbrusu4f47goSUly/u+cCwLr4vDu
	vYLBEnOmeyZXR1RQ/W+Pc2F8kWol3cGQSe5rIWxLVXT3BBbk9uepFxHbCm0RuTi7BCl5tv2rJ5o
	NkLud1XTB+3UVqlPSV+9+dqI08AyPI58mNkNgn4Cv5QVtG//K4YNsxU/0YeArUjnWYkrqp3GXxv
	8+N+I7SAPx7n+0+IrM1+hnxZz2OTqMsZmDjNVUjZd0xQcPl7MgRjXlnD2LS+kIMF2TK+C8Q9+nD
	3YHDoS3Eondwk8Rt09cg93TWZ9Bs5VFNJIaXdtiSyimJxnrXmRIt/q7UPE2dlaz+4DV9IRlZqST
	4tEsAUPrhmBz3UVXu4VytY38K9r5UIMlcIBils9v9mdWWaN/714Rj2vEVy4K+/12ShdzEtorV0b
	MRHOfmMAUMA==
X-Received: by 2002:a05:6214:411e:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-91ef027a678mr17759746d6.25.1794271980522;
        Mon, 09 Nov 2026 16:53:00 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0543c8esm8667106d6.40.2026.11.09.16.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:52:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQa6d-00000003NZr-1IKz;
	Mon, 09 Nov 2026 20:52:59 -0400
Date: Mon, 9 Nov 2026 20:52:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261110005259.GU663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
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
In-Reply-To: <20261106130352.0000638d@linux.microsoft.com>

On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> I am not stating that it will break UAPI because of blocking domain is
> used. What I am trying to say is that with the blocking domain ->
> external transition, we do not need a new UAPI for external attach for
> non-CC. It will just reuse the existing UAPI.
> VMM:
> 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach,
> 			"VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> hv-iommu-root: external_domain.attach_dev() will do the hypercall.

You've basically described a wonky NESTING domain.

I think you should just use nested domains for this. Even though there
is no S2 make it possible to create a nested domain through the
viommu..

If hyperv ever learns to support VIOMMU you will need this anyhow to
pass vSTE/vDTE/etc to hyperv.

For now the nesting domain creation can just accept an empty struct or
something which means identity?

Jason
