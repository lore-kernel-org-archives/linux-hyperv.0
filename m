Return-Path: <SRS0=jM96=5Y=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F9C2BA1A
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6212075E
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgDHPcy (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:32:54 -0400
Received: from verein.lst.de ([213.95.11.211]:42854 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgDHPcy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 11:32:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D40368CEC; Wed,  8 Apr 2020 17:32:45 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:32:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 18/28] mm: enforce that vmap can't map pages executable
Message-ID: <20200408153244.GA27818@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-19-hch@lst.de> <20200408123835.GB36478@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408123835.GB36478@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 08, 2020 at 01:38:36PM +0100, Mark Rutland wrote:
> > +static inline pgprot_t pgprot_nx(pgprot_t prot)
> > +{
> > +	return __pgprot(pgprot_val(prot) | _PAGE_NX);
> > +}
> > +#define pgprot_nx pgprot_nx
> > +
> >  #ifdef CONFIG_X86_PAE
> 
> I reckon for arm64 we can do similar in our <asm/pgtable.h>:
> 
> #define pgprot_nx(pgprot_t prot) \
> 	__pgprot_modify(prot, 0, PTE_PXN)
> 
> ... matching the style of our existing pgprot_*() modifier helpers.

I've added that for the next version with attribution to you.
