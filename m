Return-Path: <SRS0=t57i=DJ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D77BC4363D
	for <linux-hyperv@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A06206E3
	for <linux-hyperv@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oB4MvVDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBNl6 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 2 Oct 2020 09:41:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:53864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbgJBNlv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Oct 2020 09:41:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601646110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ex35TTNhtQo4+POapz9XDyIVapheLz/KPghDOJAZTmI=;
        b=oB4MvVDI1JsMmEp5fS6ih0IDJ3PgAF/1fiyI66oaGiIt+W4qf/INGGv0iE18qGvXKec0xO
        qLuuPJacZ9haS8eAxNIVDEfYmij/eqsIT1yxOLKQW7XVaOvlwlgI+fJex9EAJ+KK4SDYFi
        OdM6RJjLLtPQt3GbReg3chiA056/S3g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FBA6AD12;
        Fri,  2 Oct 2020 13:41:50 +0000 (UTC)
Date:   Fri, 2 Oct 2020 15:41:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: update comment regarding zone
 shuffling
Message-ID: <20201002134149.GK4555@dhcp22.suse.cz>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-6-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 28-09-20 20:21:10, David Hildenbrand wrote:
> As we no longer shuffle via generic_online_page() and when undoing
> isolation, we can simplify the comment.
> 
> We now effectively shuffle only once (properly) when onlining new
> memory.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9db80ee29caa..c589bd8801bb 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -859,13 +859,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
>  
>  	/*
> -	 * When exposing larger, physically contiguous memory areas to the
> -	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
> -	 * them either to the head or the tail of the freelist) is only helpful
> -	 * for maintaining the shuffle, but not for creating the initial
> -	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
> -	 * are properly distributed across the whole freelist. Make sure to
> -	 * shuffle once pageblocks are no longer isolated.
> +	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> +	 * the tail of the freelist when undoing isolation). Shuffle the whole
> +	 * zone to make sure the just onlined pages are properly distributed
> +	 * across the whole freelist - to create an initial shuffle.
>  	 */
>  	shuffle_zone(zone);
>  
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
