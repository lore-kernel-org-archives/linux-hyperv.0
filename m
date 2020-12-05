Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F64C4361A
	for <linux-hyperv@archiver.kernel.org>; Sat,  5 Dec 2020 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A9423108
	for <linux-hyperv@archiver.kernel.org>; Sat,  5 Dec 2020 12:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgLEKyc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 5 Dec 2020 05:54:32 -0500
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:44106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728406AbgLEKxv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 05:53:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6C27B18224D86;
        Sat,  5 Dec 2020 10:51:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: edge87_1a0a959273cc
X-Filterd-Recvd-Size: 2215
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Dec 2020 10:51:44 +0000 (UTC)
Message-ID: <7779f4de8d70653fe0d92fd4821c32a71b6df436.camel@perches.com>
Subject: Re: [PATCH 1/7] net: 8021q: remove unneeded MODULE_VERSION() usage
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        sven@narfation.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        roopa@nvidia.com, nikolay@nvidia.com, edumazet@google.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, jmaloy@redhat.com,
        ying.xue@windriver.com, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Date:   Sat, 05 Dec 2020 02:51:43 -0800
In-Reply-To: <20201204160924.2e170514@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201202124959.29209-1-info@metux.net>
         <20201204160924.2e170514@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2020-12-04 at 16:09 -0800, Jakub Kicinski wrote:
> On Wed,  2 Dec 2020 13:49:53 +0100 Enrico Weigelt, metux IT consult
> wrote:
> > Remove MODULE_VERSION(), as it isn't needed at all: the only version
> > making sense is the kernel version.
> > 
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> Thanks for the patches. Please drop the "metux IT consult" from the
> addresses. The from space is supposed to be for your name.

If you _really_ want this superfluous 'metux IT consult' content in your
signature, and I don't think you should, use parentheses around it.

Enrico Weigelt (metux IT consult) <info@metux.net>

Using a comma makes copy/paste into an email client think it's two addresses.



