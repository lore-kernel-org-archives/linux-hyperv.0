Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA7424D47;
	Mon,  3 Aug 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778832; cv=none; b=rWbZg+hsAfPfnsg2ACqvDHHTLhiO04skqHAvHtswWTzrp+/M4f9B4TKfqiTir08YZI/5m2HSeRv8tCci4+sFYH/VLFE5su5mBHwrRUNvqIb9pvlDxaW/M5EoQYz5/At6DrtM+3KwoYtprR8NUplhO2Froc/uuTWOEzeei7bdIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778832; c=relaxed/simple;
	bh=fe59GmNACVKikdBjgmFthWGSMAHunRLdqLS/2aKylYw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHTWJZK3yeDtk9pKgPgh1yTn7aPsCUuR9MNI65ACrW1TvTiHBWaippJLu/TjHS7xRio60MY7+qjK2Xu/NTD+CO00v8dtKeC7Mst3ZMadElL9PB+5YVs7AEtyCeIpcFE7k4J6CZAwu045ZDK3X1t4pWACNChsbompGkgFfXB4cUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G2Iz0Kn6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G2Iz0Kn6"
Received: from DairyQueen (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AC4720B7168;
	Mon,  3 Aug 2026 10:39:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AC4720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785778805;
	bh=AOV9zgbKbOdSHEACWlIc1MgQl9ltnlZ/5pkEXRffwDQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=G2Iz0Kn6dLsSl7xkWDCNsV0gNQQcRlfE/2a9iEkzDai8V+I0bI5pkz84M5q2FFSY/
	 yuOTvmanLgxTXOXY69YieKIj+hHuIU3H7CM8eEi214O7JcZEGxMyQvTx4Ye79kFNiq
	 RV78d5R4/8dozbgdfHoUr9mWSkImYn75C3YZn07s=
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
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com> <20260721195633.1438361-3-kameroncarr@linux.microsoft.com> <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com> <000901dd211f$b119be20$134d3a60$@linux.microsoft.com> <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc + decrypt + vmap
Date: Mon, 3 Aug 2026 10:40:15 -0700
Message-ID: <000a01dd236f$2a24f4f0$7e6eded0$@linux.microsoft.com>
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
Thread-Index: AQNRsRip/0GPmGqK2zS6hqfVzZeToQIbF+Y6AtauNasB7oqiJQJivrRjs1lPuRA=
Content-Language: en-us

On Saturday, August 1, 2026 9:17 PM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, July
31, 2026 12:06 PM
> >
> > On Friday, July 24, 2026 12:37 PM, Michael Kelley wrote:
> > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday,
July 21, 2026 12:57 PM
> > [...]
> > > > +	/*
> > > > +	 * @order monotonically decreases across iterations
> > > > +	 *
> > > > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
but try
> > > > +	 * harder at order 0 since that is the final fallback.
> > > > +	 */
> > > > +	order = min_t(unsigned int, MAX_PAGE_ORDER,
ilog2(nr_pages));
> > >
> > > Prefer using min() instead of min_t(). For normal integer values,
> > > min() should work correctly.
> >
> > Using min() compiled fine on ARM, but x86 is throwing a compile error.
> >
> >     drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
> >     ././include/linux/compiler_types.h:699:45: error: call to
> >     '__compiletime_assert_518' declared with attribute error: min(order,
(
> >     __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
> >     __builtin_clzll(remaining)) : (sizeof(remaining) <= 4) ?
> >     __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness error
> >
> > In my v3 I may go back to using min_t. Please let me know if a cast (or
> > some other method) is preferred.
> 
> Hmmm. I don't get the same compile error on x86/x64. Maybe it is
> related to compiler and version, or the kernel code base against which
> the patch is being built. Probably you didn't see a problem on arm64
> because of some such difference. FWIW, I built with gcc 11.4.0 against
> linux-next20260726.  What is the compiler and base kernel info where
> you saw the error and on arm64 where you didn't?

In both cases, I built against hyperv-next (a4ffc59).
On ARM64 I used gcc 13.2.0; on x86 I used 13.3.0.

To do a fair comparison, I
 * downgraded my x86 environment to gcc 13.2.0
 * started with `make defconfig`
 * enabled Hyper-V and NetVSC in the config (=y)

I saw the same behavior where there was no error on ARM and compile failure
on x86.

Regards,
Kameron

