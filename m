Return-Path: <SRS0=aIJC=BA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA95C433DF
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jul 2020 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB80320717
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jul 2020 19:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595359290;
	bh=uvcuFv0R6bqByYEk1y2UFO10PzRWHHXQclqrGDwva6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1SPeb1rv/A/YXoYlXRaAxoncjD6SEpGovlcr7odzPPpUd5cBR7p3B9NKueOZa1fJu
	 20y7EjRYg05o3GG89Zk8zxEp2jhaWGXnnN2bvRdzvx0LJOUeWEt//OICJA5pWEhkBu
	 7AGuHIkeuhRJLJP4/wOC60f1ZPAwSW1wtaXFLZ1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgGUTVa (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbgGUTVa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jul 2020 15:21:30 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3B1206F2;
        Tue, 21 Jul 2020 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595359289;
        bh=uvcuFv0R6bqByYEk1y2UFO10PzRWHHXQclqrGDwva6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t7QKyQb8s6wv3ahZjUOMbWYGDUR3vmzeNZrTzR5ncfMPPccXMI0Ij9jPtgbZbnV78
         1T93wL1AeCGIZG8zN3KHjcoJ3HZMiGNyGyZgq+7LGuAVVh64iru1o+VYnASx+jYyIu
         aFHGOelzKORJ61nNURYKYwZHH/Bx0uW2vn6M3OLc=
Date:   Tue, 21 Jul 2020 12:21:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chi Song <Song.Chi@microsoft.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        David Miller <davem@davemloft.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 net-next] net: hyperv: Add attributes to show TX
 indirection table
Message-ID: <20200721122127.3ce422f3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <PS1P15301MB028211A9D09DA5601EBEBEA298780@PS1P15301MB0282.APCP153.PROD.OUTLOOK.COM>
References: <PS1P15301MB028211A9D09DA5601EBEBEA298780@PS1P15301MB0282.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 21 Jul 2020 04:58:59 +0000 Chi Song wrote:
> An imbalanced TX indirection table causes netvsc to have low
> performance. This table is created and managed during runtime. To help
> better diagnose performance issues caused by imbalanced tables, add
> device attributes to show the content of TX indirection tables.
> 
> Signed-off-by: Chi Song <chisong@microsoft.com>

Sorry for waiting until v6 but sysfs feel like a very strange place to
expose this. Especially under the netdev, not the bus device.

This looks like device specific state, perhaps ethtool -d is a more
appropriate place?
