Return-Path: <SRS0=208f=XS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF7C04EBF
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Sep 2019 12:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D88D20835
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Sep 2019 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569241811;
	bh=HU4yCx8g3ABx9yqFacDsRh1eEPwGKuumX+bTsstzbzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w09m3D+2QXQiCZFRenwO/kcS/gN0XbE6BahIoKFLtLR6zmDRQf5QxxmFwtauwYJ8s
	 D++8NOu1xJrnTD2zdsZVtrkbXdTf0q9MV+dnycoHFFNEscg0KEqvRou6716J74fI3V
	 OXIhm9N7C94wv/q3Y6PJwMaO5babVLf80Bc8j2T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbfIWMaL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:30:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388199AbfIWMaL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 08:30:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 316D9AF16;
        Mon, 23 Sep 2019 12:30:09 +0000 (UTC)
Date:   Mon, 23 Sep 2019 14:30:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 0/3] mm/memory_hotplug: Export generic_online_page()
Message-ID: <20190923123008.GP6016@dhcp22.suse.cz>
References: <20190909114830.662-1-david@redhat.com>
 <f73c4d0f-ad81-81a6-1107-852f2b9cad41@redhat.com>
 <20190923085807.GD6016@dhcp22.suse.cz>
 <df15f269-48df-8738-c714-9fae3cb3b44c@redhat.com>
 <20190923111559.GK6016@dhcp22.suse.cz>
 <88ac3511-4ad8-d5c8-8e6a-0cca0a0f0989@redhat.com>
 <20190923120719.GM6016@dhcp22.suse.cz>
 <b60b783e-a251-f155-3cef-e0fa4a18abd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60b783e-a251-f155-3cef-e0fa4a18abd0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 23-09-19 14:20:05, David Hildenbrand wrote:
> On 23.09.19 14:07, Michal Hocko wrote:
> > On Mon 23-09-19 13:34:18, David Hildenbrand wrote:
> >> On 23.09.19 13:15, Michal Hocko wrote:
> > [...]
> >>> I am wondering why those pages get onlined when they are, in fact,
> >>> supposed to be offline.
> >>>
> >>
> >> It's the current way of emulating sub-memory-block hotplug on top of the
> >> memory bock device API we have. Hyper-V and XEN have been using that for
> >> a long time.
> > 
> > Do they really have to use the existing block interface when they in
> > fact do not operate on the block granularity? Zone device memory already
> > acts on sub section/block boundaries.
> > 
> 
> Yes, we need memory blocks, especially for user space to properly online
> them (as we discussed a while back, to decide on a zone) and for udev
> events, to e.g., properly reload kexec when memory blocks get
> added/removed/onlined/offlined.

Just to make sure I really follow. We need a user interface to control
where the memory gets onlined but it is the driver which determines
which part of the block really gets onlined, right?
-- 
Michal Hocko
SUSE Labs
