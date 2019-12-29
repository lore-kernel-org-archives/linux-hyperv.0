Return-Path: <SRS0=EDzJ=2T=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C0C2D0C8
	for <linux-hyperv@archiver.kernel.org>; Sun, 29 Dec 2019 00:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E000320838
	for <linux-hyperv@archiver.kernel.org>; Sun, 29 Dec 2019 00:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="bIi0LkPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfL2AUL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 28 Dec 2019 19:20:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44508 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2AUL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Dec 2019 19:20:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so15711654pfw.11
        for <linux-hyperv@vger.kernel.org>; Sat, 28 Dec 2019 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DnX5yqKDg1aP0+Hxr5DNL1ZfiiJOI2MJ7VQGf4X/Sc=;
        b=bIi0LkPLfVweNmWGGSgvFoi3qUj6IyYvn0BuETnzJnZJnfdIAb+kUuXzRHji8eWp95
         5TfVgQlrfsd6zC/qVVU8ZmdWobWniVGzcTmMC4y8pjB5hV8Uvw2FSCZ53DSCZDCk8GAE
         Y6cvKDJx98316m7wR10b9paYTbutq/LmsB7rd+qwqJnzJ7WQcpP399VmRrvjwstOYhio
         JKqJR3ch0d04akWP0N2jHIIfF7QwBunu1+5HGSQT19/L6aEdkxV3cs5YtowQymeNU5IQ
         10XXKvi6mmQURxMPy/BQIC7zlNIP3xZwusjU7VOqryfXsShlvvcL9B8R3TYF3zMWWc1y
         9GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DnX5yqKDg1aP0+Hxr5DNL1ZfiiJOI2MJ7VQGf4X/Sc=;
        b=eafd/z8n+JnsvBNxyCP7IjxjLjZPZBav5RB+GmOiE2Tot5sHacKSkvXEH7YiYo537t
         stXlZUzY144EthX3g0/wcwkUM3l2pkE8hfyuOju4lvZ/LH+mFf/8LiKHP3KaDO2QKMay
         xNMfMvWMZ8xAEbBkMuNsBeERNCR+VIh2/d/JO6kYwznQy8RqIuR1nP7tzSXD2bctkBXc
         uqJmX70L0jc/VPgvXScWBad+OfSNXjHJ7Ns8mLjjoBrJVtWHjYa9MVdO2JbONLd0qmQG
         6mmsE2fuicufu0UsofDKe5F4qL8Mw5ePMWJU6P08O2i3yHu0SIJNV6ipLOFd76hRYaA3
         B69A==
X-Gm-Message-State: APjAAAX3jIeMOlZq0RN1n8YRxfvawWrkazuV9QGq9JRQ87iT4nsQg/m+
        i2QCNeT/rvH6AByOquS6z84JEA==
X-Google-Smtp-Source: APXvYqxI4j+g6GpbU5LuafcxrEo7V/30NAtSlEaIQZTlCwrXkJq7mNtmzs7oezeWAxTkjxjO9gpeRg==
X-Received: by 2002:a65:50c6:: with SMTP id s6mr64954989pgp.365.1577578810560;
        Sat, 28 Dec 2019 16:20:10 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id j9sm40064570pfn.152.2019.12.28.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 16:20:10 -0800 (PST)
Date:   Sat, 28 Dec 2019 16:20:02 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next, 1/3] Drivers: hv: vmbus: Add a dev_num
 variable based on channel offer sequence
Message-ID: <20191228162002.3a603c8b@hermes.lan>
In-Reply-To: <1577576793-113222-2-git-send-email-haiyangz@microsoft.com>
References: <1577576793-113222-1-git-send-email-haiyangz@microsoft.com>
        <1577576793-113222-2-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 28 Dec 2019 15:46:31 -0800
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> +
> +next:
> +	found = false;
> +
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (i == channel->dev_num &&
> +		    guid_equal(&channel->offermsg.offer.if_type,
> +			       &newchannel->offermsg.offer.if_type)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (found) {
> +		i++;
> +		goto next;
> +	}
> +

Overall, keeping track of dev_num is a good solution.

I prefer not having a loop coded with goto's. Why not
a nested loop. Also, there already is a search of the channel
list in vmbus_process_offer() so why is another lookup needed?
