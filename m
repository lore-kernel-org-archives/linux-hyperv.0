Return-Path: <SRS0=q/xO=A7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DAEC433E1
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jul 2020 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B562080D
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jul 2020 23:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGTX12 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTX12 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jul 2020 19:27:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7DC061794;
        Mon, 20 Jul 2020 16:27:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C82311E8EC0A;
        Mon, 20 Jul 2020 16:27:27 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:27:26 -0700 (PDT)
Message-Id: <20200720.162726.1756372964350832473.davem@davemloft.net>
To:     srirakr2@cisco.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, mbumgard@cisco.com, ugm@cisco.com,
        nimm@cisco.com, xe-linux-external@cisco.com, kuba@kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: hyperv: add support for vlans in netvsc driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200720164551.14153-1-srirakr2@cisco.com>
References: <20200720164551.14153-1-srirakr2@cisco.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jul 2020 16:27:27 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sriram Krishnan <srirakr2@cisco.com>
Date: Mon, 20 Jul 2020 22:15:51 +0530

> +	if (skb->protocol == htons(ETH_P_8021Q)) {
> +		u16 vlan_tci = 0;
> +		skb_reset_mac_header(skb);

Please place an empty line between basic block local variable declarations
and actual code.

> +				netdev_err(net,"Pop vlan err %x\n",pop_err);

A space is necessary before "pop_err".
