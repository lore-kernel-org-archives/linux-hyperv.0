Return-Path: <SRS0=cQrr=3E=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B69C33CB1
	for <linux-hyperv@archiver.kernel.org>; Wed, 15 Jan 2020 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFD720728
	for <linux-hyperv@archiver.kernel.org>; Wed, 15 Jan 2020 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAOMrT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:47:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAOMrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Jan 2020 07:47:19 -0500
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA176159E75BD;
        Wed, 15 Jan 2020 04:47:16 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:51:27 -0800 (PST)
Message-Id: <20200114.115127.2012708883911771822.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     netdev@vger.kernel.org, decui@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net]: hv_sock: Remove the accept port restriction
From:   David Miller <davem@davemloft.net>
In-Reply-To: <SN4PR2101MB08808AAFCEB4E8FC178A4B79C0340@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08808AAFCEB4E8FC178A4B79C0340@SN4PR2101MB0880.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Jan 2020 04:47:18 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>
Date: Tue, 14 Jan 2020 00:52:14 +0000

> Currently, hv_sock restricts the port the guest socket can accept
> connections on. hv_sock divides the socket port namespace into two parts
> for server side (listening socket), 0-0x7FFFFFFF & 0x80000000-0xFFFFFFFF
> (there are no restrictions on client port namespace). The first part
> (0-0x7FFFFFFF) is reserved for sockets where connections can be accepted.
> The second part (0x80000000-0xFFFFFFFF) is reserved for allocating ports
> for the peer (host) socket, once a connection is accepted.
> This reservation of the port namespace is specific to hv_sock and not
> known by the generic vsock library (ex: af_vsock). This is problematic
> because auto-binds/ephemeral ports are handled by the generic vsock
> library and it has no knowledge of this port reservation and could
> allocate a port that is not compatible with hv_sock (and legitimately so).
> The issue hasn't surfaced so far because the auto-bind code of vsock
> (__vsock_bind_stream) prior to the change 'VSOCK: bind to random port for
> VMADDR_PORT_ANY' would start walking up from LAST_RESERVED_PORT (1023) and
> start assigning ports. That will take a large number of iterations to hit
> 0x7FFFFFFF. But, after the above change to randomize port selection, the
> issue has started coming up more frequently.
> There has really been no good reason to have this port reservation logic
> in hv_sock from the get go. Reserving a local port for peer ports is not
> how things are handled generally. Peer ports should reflect the peer port.
> This fixes the issue by lifting the port reservation, and also returns the
> right peer port. Since the code converts the GUID to the peer port (by
> using the first 4 bytes), there is a possibility of conflicts, but that
> seems like a reasonable risk to take, given this is limited to vsock and
> that only applies to all local sockets.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Applied.
