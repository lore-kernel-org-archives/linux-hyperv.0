Return-Path: <SRS0=AjjP=5N=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5CC43331
	for <linux-hyperv@archiver.kernel.org>; Sat, 28 Mar 2020 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF442073E
	for <linux-hyperv@archiver.kernel.org>; Sat, 28 Mar 2020 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Eee9yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgC1RIm (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:08:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52902 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RIm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 13:08:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so14957405wmk.2;
        Sat, 28 Mar 2020 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=evb87b2PRODTBIGoW+B/Zw5HYh8w8zLjNwYe5uvzeJU=;
        b=Y8Eee9yHbo1U/yQOxMNbjUlTMoYlmDd7XtCqICdB3jIP1dxyC7QOZTfwtbD19MvYu8
         RROwcPNPxt67II/GNY0SoYDDEMtEr+GOMpx0iPKz6FZnxzwUd/wMPAcunVMZTqfxkSRD
         XjDKkkQrCQX3EVUayrsolwnEdyRMF9JwdA7wYJDfPdvzjZrG0UCSG2WH1LnmYZ3Emknn
         u9dyehFXPVOmxt1OuUWOCfSio6bFCf45dZOl5IhTVg2tD//pDtETjP6c4etM1hl0BLUT
         HjpvwPY8NFrM2bz3VoJntOq9PH7cvNwCWhTmpCElOcnZcAuQY6OqjGZ/jJnO1wK8uZbO
         k1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=evb87b2PRODTBIGoW+B/Zw5HYh8w8zLjNwYe5uvzeJU=;
        b=ghMAyOxDY+WgOz6dajlPjmy4Hj0devAs37OYoTCenLTDOnXggV/3AgKou1LES7Vi/R
         8jibycavAn3zy/C+zNSQZKi67B7Aq0UNgCaTQp5uGc6jNAlIhuG2ZkFPMowC6iL3byt1
         v92vnXDe87tOn6CNsRz4HabXicqGgW7XJLdkwJUTd5HgvnrKp2lca/GYJmfdCn46mwCW
         eZLg//73lnYIwieVFZMuJnDQpKaO9fz6W77kR+rvMIDcy2RBm8d2NUgbBuHefc0LSA/e
         UUnetpJY4Bgy1Y5lDEdKUBHSKlh4/dMmzdUnVPu08jd3R+1axv8bG/2GmNhjnRyi+pHv
         Vg3A==
X-Gm-Message-State: ANhLgQ1C62cz2wNzvLb4+E694Ik/Ysb+FovSJvF6DpkBpDD4HA4e2vLU
        y2fP/+C0upKAgRwbfeVECwU=
X-Google-Smtp-Source: ADFU+vsQpQQL0S3SZ+aSF+Rr7t8Z92M+KlYVkPRDGBYiN1ydw6X+V84Gl3QhGDyA9ncc1p4krJ8bHw==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr4630124wmc.110.1585415319413;
        Sat, 28 Mar 2020 10:08:39 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id 98sm13964670wrk.52.2020.03.28.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 10:08:38 -0700 (PDT)
Date:   Sat, 28 Mar 2020 18:08:33 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the
 offer&rescind works to a specific CPU
Message-ID: <20200328170833.GA10153@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-3-parri.andrea@gmail.com>
 <871rpf5hhm.fsf@vitty.brq.redhat.com>
 <20200326154710.GA13711@andrea>
 <87sghv3u4a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sghv3u4a.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> In case we believe that OFFER -> RESCINF sequence is always ordered
> by the host AND we don't care about other offers in the queue the
> suggested locking is OK: we're guaranteed to process RESCIND after we
> finished processing OFFER for the same channel. However, waiting for
> 'offer_in_progress == 0' looks fishy so I'd suggest we at least add a
> comment explaining that the wait is only needed to serialize us with
> possible OFFER for the same channel - and nothing else. I'd personally
> still slightly prefer the algorythm I suggested as it guarantees we take
> channel_mutex with offer_in_progress == 0 -- even if there are no issues
> we can think of today (not strongly though).

Does it?  offer_in_progress is incremented without channel_mutex...

IAC, I have no objections to apply the changes you suggested.  To avoid
misunderstandings: vmbus_bus_suspend() presents a similar usage...  Are
you suggesting that I apply similar changes there?

Alternatively:  FWIW, the comment in vmbus_onoffer_rescind() does refer
to "The offer msg and the corresponding rescind msg...".  I am all ears
if you have any concrete suggestions to improve these comments.

Thanks,
  Andrea
