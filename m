Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F7C678DB
	for <linux-hyperv@archiver.kernel.org>; Tue,  7 Mar 2023 05:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGFYL (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 7 Mar 2023 00:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGFYK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Mar 2023 00:24:10 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7981F3CE0C;
        Mon,  6 Mar 2023 21:24:09 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id E3BE020BBF92; Mon,  6 Mar 2023 21:24:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3BE020BBF92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678166648;
        bh=eqYZYAifD2hsVeXmbmbT0pdZ4aIRGfqq5HT40bm6dR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2jt2qW4L5Pm9qcfYbe2Jynx1axvirGjecr0Mzkb8oAObF9VtZnmnzJ78gK14GZ+7
         Ljjn8f2AoU1pL6IEG4z/yxuQ4xe/DvkHCUn89LdFHoUXYN+Jo+HxIdPzm+t/ACFZ9m
         ENCiaC4vM738N8dEbI+moC/ax5DgoUuc0vtw/rgs=
Date:   Mon, 6 Mar 2023 21:24:08 -0800
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
Message-ID: <20230307052408.GA11548@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677133334-6958-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZAYJhm9fVAgCtTiC@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAYJhm9fVAgCtTiC@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 06, 2023 at 03:40:54PM +0000, Wei Liu wrote:
> On Wed, Feb 22, 2023 at 10:22:14PM -0800, Shradha Gupta wrote:
> > As communicated in BZ <2122115>, ifcfg config file support in
> 
> What is BZ <2122115>? I guess that's Red Hat's bugzilla?
> 
> I don't think this is useful information for the commit message, since
> the community cannot access that ticket.
Thanks for the pointer, will change this
> 
> > NetworkManger is deprecated. This patch provides support for the
> > new keyfile config format for connection profiles in NetworkManager.
> > The patch modifies the hv_kvp_daemon code to generate the new network
> > configuration in keyfile format(.ini-style format) instead of ifcfg
> > format.
> 
> Okay, so the wire protocol for the KVP daemon is not changed. It is just
> the intermediate file format that's changed.
> 
That is correct.
> > This configuration is stored in a temp file which is further translated
> > using the hv_set_ifconfig.sh script. This script is implemented by
> > individual distros based on the network management commands supported.
> > For example, RHEL's implementation could be found here:
> > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> > Debian's implementation could be found here:
> > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> > 
> > The next part of this support is to inform the Distro vendors to
> > modify these implementations to consume the new configuration format.
> > 
> 
> I guess they will figure out the format has changed when they upgrade to
> a new kernel?
Yeah, so whenever they decide to use the latest kernel, they would have to change
their implementation to consume these changes.
> 
> Thanks,
> Wei.
