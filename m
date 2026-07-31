Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83589455188;
	Fri, 31 Jul 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524789; cv=none; b=Kuy87x9czVBEkY3pW0W8YVZr7oZWVq7sZdQOvbp0l6AG780b9Ylf3erBoItNpgFuW5nHSVTN2eOy4xjNSRwgvR8SsR/QRoLL1NS32lQ7tqJzeA0gO3a95jUdvZ9mI58imY5lSCGaJeYKrl0VlRJ9zLqYTJdxde87sWldgTi2tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524789; c=relaxed/simple;
	bh=A6V6WrLAH+qzv7PfbFNPI7KUxm2YXMn4UjGkCHaXK+g=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cuAmwvDjLo9FTMRcjhbMN2dIv5F1b9T/cIkQqp0z+rwZsrxqAVYyAl//kMtMDzaAjUxeSvOpEG7spF2h2Nx8HDbtl1+gRI8owqHTqM+FkJCgpzQPlx7cp3FBNZG1lG5JH6jrFS8coiwbXb3pvLm5xI/2vkd3dMgp73N0JaGJEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UJCnfacx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UJCnfacx"
Received: from DairyQueen (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE16B20B7166;
	Fri, 31 Jul 2026 12:06:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE16B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785524770;
	bh=Buow5ich3ZiFzKXHDpEEZtNLq0R4+a5F2MMhRGRYcIs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=UJCnfacxHqDa1Px0lD2QQnNja70YGAGXyFHqCm58LY3DDA65tvRh46gJT7jHSJ2uH
	 NMLJzCvapsgFGdml3tA0wgNxpEd+n2C44lpCEl973vpi8EqOsvxA1HdngRi6P+fV1C
	 kYnpYMG6gzznanipRi6ELJKPDLFdIFXu3Cl97ljg=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<decui@microsoft.com>,
	<haiyangz@microsoft.com>,
	<kys@microsoft.com>,
	<longli@microsoft.com>,
	<wei.liu@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com> <20260721195633.1438361-3-kameroncarr@linux.microsoft.com> <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc + decrypt + vmap
Date: Fri, 31 Jul 2026 12:06:18 -0700
Message-ID: <000901dd211f$b119be20$134d3a60$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNRsRip/0GPmGqK2zS6hqfVzZeToQIbF+Y6AtauNauzd0L48A==
Content-Language: en-us

On Friday, July 24, 2026 12:37 PM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, July
21, 2026 12:57 PM
[...]
> > +	/*
> > +	 * @order monotonically decreases across iterations
> > +	 *
> > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
> > +	 * harder at order 0 since that is the final fallback.
> > +	 */
> > +	order = min_t(unsigned int, MAX_PAGE_ORDER, ilog2(nr_pages));
> 
> Prefer using min() instead of min_t(). For normal integer values,
> min() should work correctly.

Using min() compiled fine on ARM, but x86 is throwing a compile error.

    drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
    ././include/linux/compiler_types.h:699:45: error: call to
    '__compiletime_assert_518' declared with attribute error: min(order, (
    __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
    __builtin_clzll(remaining)) : (sizeof(remaining) <= 4) ?
    __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness error

In my v3 I may go back to using min_t. Please let me know if a cast (or
some other method) is preferred.

-Kameron

