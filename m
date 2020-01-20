Return-Path: <SRS0=pcry=3J=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF471C33CAA
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jan 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967ED22522
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Jan 2020 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579529677;
	bh=s+B1Zj2tP63CcGWhhEWSPDbKXf7ZgnCb1d+/R8JiMro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FsHE26mjROPBZrqLLC+ef0+78Vv2Y/rkMD+bzSzPfh4dwS/Y3t+bGzLi6KFTGhtHm
	 d16Hx+np3hEGrfPwnjRGtim76q8dkThUQcOrsjmwa9q4w6KF1o1dDnQ0qwRUfquW+o
	 WnxLdx6ODe9euglXKado7qHT2P3xn4LSaG1KdI40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgATOOh (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:14:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33573 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOOh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 09:14:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so29780839wrq.0;
        Mon, 20 Jan 2020 06:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkDkkMY1TWgj8+gYQdlaFHI7hmmwbXGQtowlL27ZgDI=;
        b=Nrwv0yvJTzzbJuT58voYmYgzfFlF6wgNA1P1HpK4Wa7NYjd99eYag5WD5bIe42UT7k
         5bOvEdiYDUe7VPyjlItS0Vuj/bwNhmuJL1knyX6Y+TuL+2wug5MhpQC03u7mNyjIsgSn
         uc11evw/04AG/X1tXK3b9QR9SIbLt40YGzM9Q6gPsRxSO3GvcGuU/hvWZfZwSTYuFEx/
         xcemiqpoEWtsPWdGRqKulOHzW6cEYZOsdz4e2rCq1ViBYOSenHztVtTNjDhuSG/M/cWJ
         sz25dAGte6G1pTCpp6UVm86i3a2LW/FBuORepe0wxn98hxQRdNAtkp+980kHo25L9RTl
         Rk7g==
X-Gm-Message-State: APjAAAUmjeigQJ9k1+uwiOo0NPzOj6+GSGNzTsJfRbKAOYfkCosTbdDA
        edoeL3HOXRLgY9M3j+uEr2Y=
X-Google-Smtp-Source: APXvYqz5/OtwpB21BRTDCwjNdY9uy8qzHGGRso8Ycl1SAhw43eAeI0AzOpJL6n5gnGShrtZ2EdKgaA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr18440651wrs.169.1579529675281;
        Mon, 20 Jan 2020 06:14:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i11sm49089379wrs.10.2020.01.20.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:14:34 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:14:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Message-ID: <20200120141433.GI18451@dhcp22.suse.cz>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
 <20200107133623.GJ32178@dhcp22.suse.cz>
 <99a6db0c-6d73-d982-58b3-7a0172748ae4@redhat.com>
 <SG2P153MB0349F85FB0C1C02F55391F6D92350@SG2P153MB0349.APCP153.PROD.OUTLOOK.COM>
 <20200114095057.GK19428@dhcp22.suse.cz>
 <PS1P15301MB034764C1FFA3D2711DAED14C92360@PS1P15301MB0347.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1P15301MB034764C1FFA3D2711DAED14C92360@PS1P15301MB0347.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri 17-01-20 16:35:03, Tianyu Lan wrote:
[...]
> > Could you describe your usecase in more details please?
> 
> Hyper-V sends hot-remove request message which just contains requested
> page number but not provide detail range. So Hyper-V driver needs to search
> suitable memory block in system memory to return back to host if there is no
> memory hot-add before. So I used the is_mem_section_removable() do such check.

As David described, you would be much better of by using
alloc_contig_range to find a memory that would be suitable for
hotremoving without any races.
-- 
Michal Hocko
SUSE Labs
