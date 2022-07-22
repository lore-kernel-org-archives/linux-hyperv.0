Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21FC433EF
	for <linux-hyperv@archiver.kernel.org>; Fri, 22 Jul 2022 15:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiGVPWe (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiGVPWd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Jul 2022 11:22:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F61951EC;
        Fri, 22 Jul 2022 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3cFYRDND0x+BlSv3lXgdOJ3p4nNxLyyMAVH0usIiuPM=; b=BkxlKTZXH+6/3yI8r1C5U02VZh
        sJzdKwwmZFeKFmuAerd1Vdi16093DA2dNHvTfbx0PKxLTIAlIauVDNomY/ckdLZ0hX1eeKSANT2+G
        bPGSuZzNYJrJeNPAwkouPbcJkpnnzWMp2IRMG2wurcnaOMRjxhd7YGgUEPBf7RwETAJTPF/DWziqk
        OC4mjb96GgHWfcD0iLTuGvCiF/uiQ+OOPWfDAhD6lR6XNoyb6uVl2dfXJQbscq8JqWOu3yvx+rpLo
        Tumwi39+RwY3iSoyB7QI9QdACeJfyE67h9mMOtGSYrcJUKvPyZfsd8fMVRqXksOd79vhcshsw4ZRJ
        kgQn3j0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEuTy-007GsN-Rq; Fri, 22 Jul 2022 15:22:26 +0000
Date:   Fri, 22 Jul 2022 08:22:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Clean up some coding style and minor issues
Message-ID: <YtrAsjp0Fs0ThBa7@infradead.org>
References: <20220722033846.950237-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722033846.950237-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I've applied this, but then dropped the debugfs changes.  I can't find
any good reason why we'd use the _unsafe variant here.  Can you resend
that bit and write a commit log clearly documenting the considerations
for it?
