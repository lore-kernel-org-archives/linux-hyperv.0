Return-Path: <SRS0=208f=XS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F9C04EBF
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Sep 2019 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305FC20835
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Sep 2019 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569237363;
	bh=THNDA433EVvnWZ505Ku9XRDy9r98iyeeF0PNX2GYsEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hUQ9iZGAlNhSP+HrbccXNvAQouR9JGU3Bxu/VDxaCg06sSAbnqcUNh3BX1Yj17HP1
	 azbkMbr0Za7Y5q/Rnnm7e5uQTXcAZXIKuHtARZnI+T5maftF4ODe80pWhCWcrezrKB
	 CO+lBQLFDlaQ0QrRqty/HK3sVcESD5ASDXUoF63Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfIWLQD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:16:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730155AbfIWLQC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 07:16:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4084CAE6E;
        Mon, 23 Sep 2019 11:16:00 +0000 (UTC)
Date:   Mon, 23 Sep 2019 13:15:59 +0200
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
Message-ID: <20190923111559.GK6016@dhcp22.suse.cz>
References: <20190909114830.662-1-david@redhat.com>
 <f73c4d0f-ad81-81a6-1107-852f2b9cad41@redhat.com>
 <20190923085807.GD6016@dhcp22.suse.cz>
 <df15f269-48df-8738-c714-9fae3cb3b44c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df15f269-48df-8738-c714-9fae3cb3b44c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 23-09-19 11:31:30, David Hildenbrand wrote:
> On 23.09.19 10:58, Michal Hocko wrote:
> > On Fri 20-09-19 10:17:54, David Hildenbrand wrote:
> >> On 09.09.19 13:48, David Hildenbrand wrote:
> >>> Based on linux/next + "[PATCH 0/3] Remove __online_page_set_limits()"
> >>>
> >>> Let's replace the __online_page...() functions by generic_online_page().
> >>> Hyper-V only wants to delay the actual onlining of un-backed pages, so we
> >>> can simpy re-use the generic function.
> >>>
> >>> Only compile-tested.
> >>>
> >>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> >>>
> >>> David Hildenbrand (3):
> >>>   mm/memory_hotplug: Export generic_online_page()
> >>>   hv_balloon: Use generic_online_page()
> >>>   mm/memory_hotplug: Remove __online_page_free() and
> >>>     __online_page_increment_counters()
> >>>
> >>>  drivers/hv/hv_balloon.c        |  3 +--
> >>>  include/linux/memory_hotplug.h |  4 +---
> >>>  mm/memory_hotplug.c            | 17 ++---------------
> >>>  3 files changed, 4 insertions(+), 20 deletions(-)
> >>>
> >>
> >> Ping, any comments on this one?
> > 
> > Unification makes a lot of sense to me. You can add
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > I will most likely won't surprise if I asked for more here though ;)
> 
> I'm not surprised, but definitely not in a negative sense ;) I was
> asking myself if we could somehow rework this, too.
> 
> > I have to confess I really detest the whole concept of a hidden callback
> > with a very weird API. Is this something we can do about? I do realize
> > that adding a callback would require either cluttering the existing APIs
> > but maybe we can come up with something more clever. Or maybe existing
> > external users of online callback can do that as a separate step after
> > the online is completed - or is this impossible due to locking
> > guarantees?
> > 
> 
> The use case of this (somewhat special) callback really is to avoid
> selected (unbacked in the hypervisor) pages to get put to the buddy just
> now, but instead to defer that (sometimes, defer till infinity ;) ).
> Especially, to hinder these pages from getting touched at all. Pages
> that won't be put to the buddy will usually get PG_offline set (e.g.,
> Hyper-V and XEN) - the only two users I am aware of.
> 
> For Hyper-V (and also eventually virtio-mem), it is important to set
> PG_offline before marking the section to be online (SECTION_IS_ONLINE).
> Only this way, PG_offline is properly set on all pfn_to_online_page()
> pages, meaning "don't touch this page" - e.g., used to skip over such
> pages when suspending or by makedumpfile to skip over such offline pages
> when creating a memory dump.

Thanks for the clarification. I have never really studied what those
callbacks are doing really.

> So if we would e.g., try to piggy-back onto the memory_notify()
> infrastructure, we could
> 1. Online all pages to the buddy (dropping the callback)
> 2. E.g., memory_notify(MEM_ONLINE_PAGES, &arg);
> -> in the notifier, pull pages from the buddy, mark sections online
> 3. Set all involved sections online (online_mem_sections())

This doesn't really sound any better. For one pages are immediately
usable when they hit the buddy allocator so this is racy and thus not
reliable.

> However, I am not sure what actually happens after 1. - we are only
> holding the device hotplug lock and the memory hotplug lock, so the
> pages can just get allocated. Also, it sounds like more work and code
> for the same end result (okay, if the rework is really necessary, though).
> 
> So yeah, while the current callback might not be optimal, I don't see an
> easy and clean way to rework this. With the change in this series we are
> at least able to simply defer doing what would have been done without
> the callback - not perfect but better.
> 
> Do you have anything in mind that could work out and make this nicer?

I am wondering why those pages get onlined when they are, in fact,
supposed to be offline.
-- 
Michal Hocko
SUSE Labs
