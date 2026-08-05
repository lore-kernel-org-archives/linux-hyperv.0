Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770293CEB90;
	Wed,  5 Aug 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950195; cv=none; b=TnB4uqIh1EwD62+O/J9f8JBhpxK8J7H/V4PCiZ3lC3u6mjU83c9tyvOM65hxNGC+8uEeZdiNoFFabzMLItIj54nV1jLYn6i0JEY5t6i/3AaAYiPW0DmkSJj/0tjqNHlfpyBiXpz21jnaXs9hd4LkeWu9GS+zqwuAQURBFrgxXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950195; c=relaxed/simple;
	bh=5/x+yBltEA6/p9vGJ58LBjPT+vWF9PL/NCY3VCiR0+w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWA2VkeIZ0D/fCv6cevJd4iuDAOTfdrSIAbyLmBildtQmNC/5Ssz6yq+S4Cpiu+ZgcXSpSKErQQaGmAkFbAcEVQNqxBCstIACBPDBpSeZUQaNmbAxqY5R2fnwjAJjEQE1b/og7szUXSRhh02aG4+XJjUDhrml0mgPoyp1rqnfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CU3U5kUe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CU3U5kUe"
Received: from DairyQueen (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id C246B20B716A;
	Wed,  5 Aug 2026 10:16:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C246B20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785950168;
	bh=zUd4Z56F750e/zfpxHZ+hCkFTeSEgJPpK53kX7O/SjY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=CU3U5kUebiu0kMijyW+lERomndJV0oqEH5XEDV2hg3YGXjNXpwXA/lDMoQ2HOJ1dw
	 EVfTTEcmeB6KSa01YlzKBjwQmqCpqefUSYg3cP8QGeANEOmSk2Fi07ayEADFYzN5Fe
	 VHk5MJ5vl+zGkbuzs7A2yYtzuUqasRf9mPTXbcrA=
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
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com> <20260721195633.1438361-3-kameroncarr@linux.microsoft.com> <SN6PR02MB41576F1E9A4F0AC3D6AB8C18D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com> <000901dd211f$b119be20$134d3a60$@linux.microsoft.com> <SN6PR02MB4157514D8AFB06FB6F2ED9BED4D62@SN6PR02MB4157.namprd02.prod.outlook.com> <000a01dd236f$2a24f4f0$7e6eded0$@linux.microsoft.com> <SN6PR02MB415720DFAAC7EF9106D5B684D4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415720DFAAC7EF9106D5B684D4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 2/2] hv_netvsc: back GPADL buffers with kmalloc + decrypt + vmap
Date: Wed, 5 Aug 2026 10:16:19 -0700
Message-ID: <000a01dd24fe$26f311a0$74d934e0$@linux.microsoft.com>
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
Content-Language: en-us
Thread-Index: AQNRsRip/0GPmGqK2zS6hqfVzZeToQIbF+Y6AtauNasB7oqiJQJivrRjAkfGIjMCEyDc4bM5qEaA

On Monday, August 3, 2026 5:23 PM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Monday, August
3, 2026 10:40 AM
> >
> > On Saturday, August 1, 2026 9:17 PM, Michael Kelley wrote:
> > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday,
July 31, 2026 12:06 PM
> > > >
> > > > On Friday, July 24, 2026 12:37 PM, Michael Kelley wrote:
> > > > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent:
Tuesday, July 21, 2026 12:57 PM
> > > > [...]
> > > > > > +	/*
> > > > > > +	 * @order monotonically decreases across iterations
> > > > > > +	 *
> > > > > > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
but try
> > > > > > +	 * harder at order 0 since that is the final fallback.
> > > > > > +	 */
> > > > > > +	order = min_t(unsigned int, MAX_PAGE_ORDER,
ilog2(nr_pages));
> > > > >
> > > > > Prefer using min() instead of min_t(). For normal integer values,
> > > > > min() should work correctly.
> > > >
> > > > Using min() compiled fine on ARM, but x86 is throwing a compile
error.
> > > >
> > > >     drivers/hv/channel.c: In function 'vmbus_alloc_buffer':
> > > >     ././include/linux/compiler_types.h:699:45: error: call to
> > > >     '__compiletime_assert_518' declared with attribute error:
min(order,
> > (
> > > >     __builtin_constant_p(remaining) ? ((remaining) < 2 ? 0 : 63 -
> > > >     __builtin_clzll(remaining)) : (sizeof(remaining) <= 4) ?
> > > >     __ilog2_u32(remaining) : __ilog2_u64(remaining) )) signedness
error
> > > >
> > > > In my v3 I may go back to using min_t. Please let me know if a cast
(or
> > > > some other method) is preferred.
> > >
> > > Hmmm. I don't get the same compile error on x86/x64. Maybe it is
> > > related to compiler and version, or the kernel code base against which
> > > the patch is being built. Probably you didn't see a problem on arm64
> > > because of some such difference. FWIW, I built with gcc 11.4.0 against
> > > linux-next20260726.  What is the compiler and base kernel info where
> > > you saw the error and on arm64 where you didn't?
> >
> > In both cases, I built against hyperv-next (a4ffc59).
> > On ARM64 I used gcc 13.2.0; on x86 I used 13.3.0.
> >
> > To do a fair comparison, I
> >  * downgraded my x86 environment to gcc 13.2.0
> >  * started with `make defconfig`
> >  * enabled Hyper-V and NetVSC in the config (=y)
> >
> > I saw the same behavior where there was no error on ARM and compile
failure
> > on x86.
> >
> 
> Really weird. I compiled on x86/x64 with gcc 13.3.0, and saw no
> problem. This was against the official 7.1.0 release source code.
> Then I grabbed hyperv-next (the tag "hyperv-next-signed-20260621"
> specifically), added your patches, and again using gcc 13.3.0 I
> built with no problem. Are you using the same local copy of the
> source code for arm64 and x86/x64 builds? If not, I wonder if
> your local x86/x64 source code tree is somehow corrupt or not
> what you think it is.
> 
> My .config file is different from yours. I did not try starting fresh
> with make defconfig and then enable Hyper-V and netvsc.

Automated testing is picking up the same compiler error
https://lore.kernel.org/all/6a6dc0b6.1aa927e4.17d4bf.000d.GAE@google.com/

    tree:      net-next
    arch:      amd64
    compiler:  Debian clang version 22.1.8

This points to a real issue, not a corruption issue.

I believe the right course is to explicitly do an unsigned comparison
instead of relying on the compiler to allow a comparison between a
signed and unsigned value.

Regards,
Kameron


