Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB9C433EF
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Jun 2022 12:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiFHM0x (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 8 Jun 2022 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbiFHM0x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 08:26:53 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893CA12DBD9;
        Wed,  8 Jun 2022 05:26:51 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso10994964wmr.5;
        Wed, 08 Jun 2022 05:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YqtF5Tok7lDJRBijBMxdiZCGIwdxt+J3D4YPJdIMw4=;
        b=aJBmEZ83a2ou3smIhdSgaaQrMMFR18s2j4ZTiFccYKmW4CzEbvi1asFx8lNd8LIQcM
         7KI/RXI44n1fna41Ksf6bYfq9qbZJQ9ahecClIGx+DvYZKBYQLJ1rrF/jGeHzFJL5pbc
         Nk42psGlkCdl1GjpHcQAAMMxSy3A9+NU3CSwvW6+KeQQkagDMR/MXBUL4qSYp2yM9KWY
         uPOCYrWw0EJRZJiC3JutV59CrwRrfuVzDiDonoR9NAdUAjA+ij0jcOWEAalSfYadpzzS
         yJzlf+Jnw9Sodeau9+raQ6nMrODFMPJJStTUIkkmyV7wNMp9Brtwqp8UxSEit1cZkAuh
         TULg==
X-Gm-Message-State: AOAM530siqUmhIJ2LUfxPhFVNRt6HpcZ586iG9EcT66Ev6A/27PFht3t
        lm37co4WzTvTv2wH6Krb8a8yra/jSqw=
X-Google-Smtp-Source: ABdhPJxoZ1pe4zphWFDlTvt52RyqsLOK6D1jkKfqHdK1DmwqWM1Oy8wOwQu+AOsdYo3XJE6WjkmFRw==
X-Received: by 2002:a05:600c:3792:b0:39c:6667:202 with SMTP id o18-20020a05600c379200b0039c66670202mr531063wmr.104.1654691210067;
        Wed, 08 Jun 2022 05:26:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d430d000000b002130f1dfe0bsm19027762wrq.74.2022.06.08.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 05:26:49 -0700 (PDT)
Date:   Wed, 8 Jun 2022 12:26:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Xiang wangx <wangxiang@cdjrlc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: Fix syntax errors in comments
Message-ID: <20220608122647.rt6ycnqzomu2w5ev@liuwe-devbox-debian-v2>
References: <20220605085524.11289-1-wangxiang@cdjrlc.com>
 <PH0PR21MB3025110BE6D81EF2F854B5E2D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025110BE6D81EF2F854B5E2D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 07, 2022 at 07:33:51PM +0000, Michael Kelley (LINUX) wrote:
> From: Xiang wangx <wangxiang@cdjrlc.com> Sent: Sunday, June 5, 2022 1:55 AM
> > 
> > Delete the redundant word 'in'.
> > 
> > Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> > ---
> >  drivers/hv/hv_kvp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> > index c698592b83e4..d35b60c06114 100644
> > --- a/drivers/hv/hv_kvp.c
> > +++ b/drivers/hv/hv_kvp.c
> > @@ -394,7 +394,7 @@ kvp_send_key(struct work_struct *dummy)
> >         in_msg = kvp_transaction.kvp_msg;
> > 
> >         /*
> > -        * The key/value strings sent from the host are encoded in
> > +        * The key/value strings sent from the host are encoded
> >          * in utf16; convert it to utf8 strings.
> >          * The host assures us that the utf16 strings will not exceed
> >          * the max lengths specified. We will however, reserve room
> > --
> > 2.36.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
