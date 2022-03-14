Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88632C433F5
	for <linux-hyperv@archiver.kernel.org>; Mon, 14 Mar 2022 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiCNROD (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiCNROB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Mar 2022 13:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A0271D;
        Mon, 14 Mar 2022 10:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1983160F3B;
        Mon, 14 Mar 2022 17:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B97C340E9;
        Mon, 14 Mar 2022 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647277967;
        bh=GEY5cKGvA2rl2PigOsyiq7MnGmDB/pky0S3ErxRuSCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nt4X6hyiY9aAs5k99yBOnO+JmQiOfPRMOI1+KMBG13zKzbJ5QXgoxnyRbZzoDennH
         wyucaNOjjNByzNozmYuuJ/AaP9dX/8ImGm+M2xF1hMDpjYko+k7z8Y87juWN+98uuj
         jAxz+wiMinO+1Be+KldpWOTpDsaM1fAck6SAWBnKgddeLXYpNJgyHYN2GUz/2qZlHb
         tN3yuzM/aU8zLKe9Bb8fT+sj30Bhx1mJxjqOVp+2Ur8vFZzurJAJQ1gURawPuFm5R5
         B+AfS0VIMbBH0zOAqgC2hIWUyvp8/6Vdjcsh3HHizc4jpJU5r9XnFS7zJb1Aw+cfG4
         TMSGFJRfqizkw==
Date:   Mon, 14 Mar 2022 10:12:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, stephen@networkplumber.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc: Add check for kvmalloc_array
Message-ID: <20220314101245.1589ec82@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220314083500.2501146-1-jiasheng@iscas.ac.cn>
References: <20220314083500.2501146-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 14 Mar 2022 16:35:00 +0800 Jiasheng Jiang wrote:
> On Mon, Mar 14, 2022 at 04:13:59PM +0800, Greg KH wrote:
> >> The failure of allocation is not included in the tests.
> >> And as far as I know, there is not any tool that has the
> >> ability to fail the allocation.  
> > 
> > There are tools that do this.
> >   
> 
> Thanks, could you please tell me the tools?

Google "linux kernel fail allocation test"
second result is "Fault injection capabilities infrastructure"
which is what you're looking for.

Please try harder next time.
