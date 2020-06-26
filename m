Return-Path: <SRS0=czHO=AH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E188C433E0
	for <linux-hyperv@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8748207E8
	for <linux-hyperv@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593178515;
	bh=/B/faJGs8yTTv8m+w0HaYz4BjLyimXCekgSZ2XIm4Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7onJMV26zzVaM0jjZ7YqMeuRJwhsDHdoI5mHFuqXUrOTE/w8Yi19pgWZowi7llnt
	 0fzxfU+nHtEvnuaE6GGYE3qZtsz0XZqfKiqXWDUJ6/iTepgyRuQKruEzE5XEfiWl3t
	 TajhK9Z7JC+wjAW28k4IQPmQhqNtTEiijDGNkMkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgFZNfP (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:35:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39281 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNfP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 09:35:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id t194so9400507wmt.4;
        Fri, 26 Jun 2020 06:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rp6YQJvOct5YMdcILlfA4VbzbkAlegh4uyhw+0iU3XE=;
        b=a6OcOXWqZZ/2EzHlaX0jBt9K4pdNl6qRnpCGQNhhJeHT/8Du6fAc4hl75ROWYMCQM+
         fXWNos573s6pIJMrb0AmnFfKF+aPlQzDskpSI/cJ/FB1uwVI+BiO421RD8Xm6EhlV2yN
         4NQwQsGNPgyqGArKb3IOoyBDUIONcby+UfLEjq6XE7v5twPDLKthJLmLzLUXw4a7cJyj
         7IpZmG4UkLaYbqLtv8Y+eM7V+OsL5WhRrsObOBHGiuHxdij2yBdEkUbDeqLbxVpDQcK1
         RoPfwyg/XQDK4W+wBAC2gjLr4qTq/vY53HNqqgX4WJs0TkReoS91xQzLemdOorIm0+Fi
         3ELA==
X-Gm-Message-State: AOAM530YTw6eNE/TyKPuIGAC7WxPdNYlw/To0qBXIoGzSTaDiPGSv54f
        ei6lltLn2Z8N4E7Q/i2TCW4=
X-Google-Smtp-Source: ABdhPJxHnTY151Rip/N6CxrRu6WrNQ89wyE7a1bxwHbwP2ycd8jMKwULsmAaXasUS2CP9GmyfSd1yA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr3428647wmf.140.1593178512694;
        Fri, 26 Jun 2020 06:35:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm37886021wrb.51.2020.06.26.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:35:12 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:35:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andres Beltran <lkmlabelt@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Message-ID: <20200626133510.5ognamqpz3klnfhk@liuwe-devbox-debian-v2>
References: <20200625153723.8428-1-lkmlabelt@gmail.com>
 <20200625153723.8428-3-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625153723.8428-3-lkmlabelt@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 25, 2020 at 11:37:22AM -0400, Andres Beltran wrote:
>  	 * If the number of CPUs is artificially restricted, such as
> @@ -760,14 +768,22 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
>  	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
>  	vstor_packet->sub_channel_count = num_sc;
>  
> +	rqst_id = vmbus_next_request_id(&device->channel->requestor, (u64)request);

You can cast request to unsigned long to fix the warnings on 32bit.

Wei.
