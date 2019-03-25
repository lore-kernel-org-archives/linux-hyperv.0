Return-Path: <SRS0=tP0O=R4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68742C43381
	for <linux-hyperv@archiver.kernel.org>; Mon, 25 Mar 2019 21:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4932070D
	for <linux-hyperv@archiver.kernel.org>; Mon, 25 Mar 2019 21:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfCYVbY (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:31:24 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:50422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730012AbfCYVbX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Mar 2019 17:31:23 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 17:31:23 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id C345C1804D8BA
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Mar 2019 21:25:20 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0D63B1804E3D4;
        Mon, 25 Mar 2019 21:25:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plant67_111b552e3740e
X-Filterd-Recvd-Size: 3465
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:25:17 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Bad file pattern in MAINTAINERS section 'Hyper-V CORE AND DRIVERS'
Date:   Mon, 25 Mar 2019 14:25:16 -0700
Message-Id: <20190325212516.26489-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	7164	Hyper-V CORE AND DRIVERS
	7165	M:	"K. Y. Srinivasan" <kys@microsoft.com>
	7166	M:	Haiyang Zhang <haiyangz@microsoft.com>
	7167	M:	Stephen Hemminger <sthemmin@microsoft.com>
	7168	M:	Sasha Levin <sashal@kernel.org>
	7169	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
	7170	L:	linux-hyperv@vger.kernel.org
	7171	S:	Supported
	7172	F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
	7173	F:	arch/x86/include/asm/mshyperv.h
	7174	F:	arch/x86/include/asm/trace/hyperv.h
	7175	F:	arch/x86/include/asm/hyperv-tlfs.h
	7176	F:	arch/x86/kernel/cpu/mshyperv.c
	7177	F:	arch/x86/hyperv
	7178	F:	drivers/hid/hid-hyperv.c
	7179	F:	drivers/hv/
	7180	F:	drivers/input/serio/hyperv-keyboard.c
	7181	F:	drivers/pci/controller/pci-hyperv.c
	7182	F:	drivers/net/hyperv/
	7183	F:	drivers/scsi/storvsc_drv.c
	7184	F:	drivers/uio/uio_hv_generic.c
	7185	F:	drivers/video/fbdev/hyperv_fb.c
-->	7186	F:	drivers/iommu/hyperv_iommu.c
	7187	F:	net/vmw_vsock/hyperv_transport.c
	7188	F:	include/linux/hyperv.h
	7189	F:	include/uapi/linux/hyperv.h
	7190	F:	tools/hv/
	7191	F:	Documentation/ABI/stable/sysfs-bus-vmbus

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/iommu/hyperv_iommu.c':

commit 32d5860a9e3c98b5043716fff05a7b20b15918f9
Author: Lan Tianyu <Tianyu.Lan@microsoft.com>
Date:   Wed Feb 27 22:54:05 2019 +0800

    MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
    
    This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
    DRIVERS scope.
    
    Reviewed-by: Michael Kelley <mikelley@microsoft.com>
    Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/iommu/hyperv_iommu.c' was found
