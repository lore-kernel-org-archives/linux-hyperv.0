Return-Path: <SRS0=9q/0=BU=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED22C433E0
	for <linux-hyperv@archiver.kernel.org>; Mon, 10 Aug 2020 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0F206B5
	for <linux-hyperv@archiver.kernel.org>; Mon, 10 Aug 2020 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597052883;
	bh=GqkexlyZP7axmeigwWe29MSRGtH2qjhBtbU4q7ty0AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qEg05ikJusZu7NKm1r8ZF6/0h3vuDDJf9+Q9dbAM8L8zCNX/T6TOkSaSihkmPGk3t
	 Yw17q+5N4z4ZQM8BjKCVbPiEVqzgCw6S7xWbI2rgXH7gz2SlYhL+0dRn8ck5t22BSr
	 dEk/KvrnbihPXOHxTAPzPnxjfaKPmOYwLiCPVLf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgHJJsC (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:48:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52290 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgHJJsC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Aug 2020 05:48:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so7080225wmi.2;
        Mon, 10 Aug 2020 02:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYyEJmazRNgH+1g+IGEtqVnKBm2NwZWFCRDnLJoNGo4=;
        b=P3uiua36fJVDHnZnu2pwAsNDFvpXWvKF4I2LLeo6Uu6IG2Nyw49hUMoNRpoLtv1A/Z
         SpAIe9Q298DdxTgMEuUOytrQx8pScFvvCh+YfPDnP3Mwrcge2rUIhtxwZPt4RhJ2WuVh
         L46OjcMlbEHVqh+XTAH8YYBrVOzO6FTZTznM3cUtIz0vAqMAdRU9yFiMRtsqGJlp4cV9
         mm9BNYktswq1Lza2nQgvj+EDrCGYt0YXeagebHflQsebMpb+7tKbOj8zSafPb7D6lQAC
         ux5PyKgnMngFnoMNqE5o3HmsCRRc8FwjlDyAc01T358YKJxgmI4vmT8rv1cItSNBVYrK
         yUXw==
X-Gm-Message-State: AOAM53283rs6M/HPWyU3c0hns4UMBijlXt2DjUtkD7Kr4Z3BLDELh4p3
        sRoIkLQ+JiuJdLv0O8t4acc=
X-Google-Smtp-Source: ABdhPJyIOTbx7rl/qSEt5ccdyCRGigHrEHcl44dPJBVkJveGetk24u6hSWJpMnOwe0ZHZYk1aH6FDQ==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr23394959wme.61.1597052880522;
        Mon, 10 Aug 2020 02:48:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o125sm23132915wma.27.2020.08.10.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 02:47:59 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:47:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
Message-ID: <20200810094758.uosnuns6rlnfqz6z@liuwe-devbox-debian-v2>
References: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Aug 09, 2020 at 06:29:51PM -0700, Michael Kelley wrote:
> Make hv_setup_sched_clock inline so the reference to pv_ops works
> correctly with objtool updates to detect noinstr violations.
> See https://lore.kernel.org/patchwork/patch/1283635/
> 

I read the reference link. This change looks sensible.

I will wait a few days before queueing this up in case other people have
an opinion on this.

Wei.
