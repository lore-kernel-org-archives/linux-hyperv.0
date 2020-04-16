Return-Path: <SRS0=yzbm=6A=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8040C2BA2B
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Apr 2020 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AC9221F4
	for <linux-hyperv@archiver.kernel.org>; Thu, 16 Apr 2020 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587069799;
	bh=7d31cEyKngb3AJGtdDfr1sm/sywbfaeeHt/ZxDspSq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZF2Xtqfmo/CZjnfRxQkQqQqLTMQVWN8r7sFG9JZ/v3sz/uiLG3fYVK3QORvVbQiO2
	 Gm594vmvPT5uiqVWYsCO/ntnUwQqLMPrXlkq8cHdUejIlh9WiiETudmY3+dQuIMwRI
	 705v7xRFsYi9Zgiv7Tt7M9XpRl1qhnyeUSpY7Cpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDPUnT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgDPUnS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Apr 2020 16:43:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4406C061A0C;
        Thu, 16 Apr 2020 13:43:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r20so2200550pfh.9;
        Thu, 16 Apr 2020 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRgyzvRokr7ai+Xbzs2rruJuXsUX0gI+b1jlIGwtZfU=;
        b=Oyt/oE4Ouu2LsqJ33+344yy9kTnzp8/CWBPr7eZxkvWVB8IZf0+J46FH47n3dNy47b
         kice3lT1TD1ImxQCmYZXk7jvpWZg6z2mlPpY+Ys0QsgGXJZASv5HCmVZZlmcrHIT3Ph1
         RKXMfEG5U32cSw2YdADUYO/EfTtD9hhgBLJykOZsHZxahfZ5hvKGj73ZVuWHyjvAGPoR
         RHWgpNuleLC3zAE0hLLzQ7w33YGWM89r44CUTwO3o99AukFCQ236ORK+lQr8hmH9KMgP
         UlVILhg/WfSY98sw4aGVs5qRfCrdXOIUD0WC5/KQPrk9NkEuUE7EvhH2UBMwt4f/4YfC
         w6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uRgyzvRokr7ai+Xbzs2rruJuXsUX0gI+b1jlIGwtZfU=;
        b=CpgoyxNWVumskaX9FyggCDgqzHDYJJfcyw7gdhgSmDDSo9CZemm3PL+Y6AIkHXdqw6
         NjPAnXmGne/JbpEad7dciNHhAJbZNt0DpK722tMRKofw2HuvldTABILCUPpjuEYISJie
         R30++n4S3+ISIuGFJ5hqfJUC4RwpOIDkoURRILx5e2KqPvHmsGVryHjLYAOmwikUNggb
         D04X7xVs+NN4cP1yivjvV2KeTpqi69q2tUr3t2eF49y2VcUvOxtSIb3AAxrkWQfWCAo6
         2+paleuBl9QUpiPIb6uDybEkXaVqDDStlfG8wJxe7e5L34LK7K522+xSvksz6/hm8nTZ
         EFlg==
X-Gm-Message-State: AGi0Pub0PFJrN/XrrgigjVemTSkbDx4ShAH5FwJcLNZokE83e8sDXr3A
        QyHV+55+KmoLIRcJ8u8hS5Q=
X-Google-Smtp-Source: APiQypIXiJO4KCjTGpKvDHmXGV5HxR6F5ChtTIbUrCsBU11gVwLi7psgN6LJANKPucmqiSohUc35Kg==
X-Received: by 2002:a65:611a:: with SMTP id z26mr3767121pgu.341.1587069797727;
        Thu, 16 Apr 2020 13:43:17 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id d8sm12215742pfd.159.2020.04.16.13.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:43:16 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:43:14 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH 11/29] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200416204314.GA59451@google.com>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414131348.444715-12-hch@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 14, 2020 at 03:13:30PM +0200, Christoph Hellwig wrote:
> This allows to unexport map_vm_area and unmap_kernel_range, which are
> rather deep internal and should not be available to modules, as they for
> example allow fine grained control of mapping permissions, and also
> allow splitting the setup of a vmalloc area and the actual mapping and
> thus expose vmalloc internals.
> 
> zsmalloc is typically built-in and continues to work (just like the
> percpu-vm code using a similar patter), while modular zsmalloc also
> continues to work, but must use copies.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
