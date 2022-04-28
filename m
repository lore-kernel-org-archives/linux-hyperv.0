Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B609C433EF
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Apr 2022 14:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348457AbiD1OtN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Apr 2022 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348468AbiD1OtM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:49:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715A3EBB1;
        Thu, 28 Apr 2022 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wn2CCgiEQBYeS5u0DrULazlSPjTmY85xMbHqQ/sfE9k=; b=SPFFyEzI2KXFZuWKlVBFsE45Rd
        tuKS6j1yQzuaKTnrAlz1qA+bdRp0MdXf0O9s3Ql9mZRr8J3YkTrFsILNWA7YNBS/Nv/t39FCxCROR
        tXXuwYUmj54la6tjSJJdhQkY2r7Gyb/KBAGV7ijwKv21aZIwO7PwdGKFY+wmCYNTYddTDO91VNnvu
        uyiL19/jkOa7B0xJIGnk+6PtoDefVlKJhqSsZLwAYcQC+ad/PJQx0tHgkuBlMOz0/Ii/yZ5wOpjSg
        42DqbKhrYwHu7YObyKFJqvKBSjSziz8cT/nRHQwIv7ct+vBMSXzxTJxhloyCAAkkD3LpGxlxYBKK9
        OUWI2eLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk5Ou-007WzS-Oc; Thu, 28 Apr 2022 14:45:48 +0000
Date:   Thu, 28 Apr 2022 07:45:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>, hch@infradead.org,
        m.szyprowski@samsung.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YmqonHKBT8ftYHgY@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
> Rather than introduce this extra level of allocator complexity, how about
> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
> instances?

Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
so the very last thing I want is an interface that allows a driver to
allocate a per-device buffer.
