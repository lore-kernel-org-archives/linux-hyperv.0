Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A359C5519F
	for <linux-hyperv@archiver.kernel.org>; Sat, 14 Nov 2020 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCB920A8B
	for <linux-hyperv@archiver.kernel.org>; Sat, 14 Nov 2020 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKNFux (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 14 Nov 2020 00:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgKNFux (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 14 Nov 2020 00:50:53 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBEC0613D1;
        Fri, 13 Nov 2020 21:50:53 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdoSW-005cUH-Ok; Sat, 14 Nov 2020 05:50:49 +0000
Date:   Sat, 14 Nov 2020 05:50:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114055048.GN3576660@ZenIV.linux.org.uk>
References: <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114041420.GA231@Ryzen-9-3900X.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 13, 2020 at 09:14:20PM -0700, Nathan Chancellor wrote:

> Unfortunately that patch does not solve my issue. Is there any other
> debugging I should add?

Hmm...  I wonder which file it is; how about
		if (WARN_ON(!iovec.iov_len))
			printk(KERN_ERR "odd readv on %pd4\n", file);
in the loop in fs/read_write.c:do_loop_readv_writev()?
