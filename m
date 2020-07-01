Return-Path: <SRS0=Y3XC=AM=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A7C433DF
	for <linux-hyperv@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60F72082F
	for <linux-hyperv@archiver.kernel.org>; Wed,  1 Jul 2020 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593628139;
	bh=cROMCyjopC2IuK6sUTgsWWkHCbRr/26oLQBaDHIf13w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=F/+zOuXJTdGN7R/43hMkc2r7IGodA+GvPeB0zA6+/Rc63mL7Na+mK8ihWHanMjdoJ
	 9Nu9Re02F2Flv0xelRsye9TDZGo1rrSdM138hoAqR4Crl7YVAOzWajuKp4v9Y2Nl5z
	 CX0NPlabipipCbFBmrkIP9Xsqc1R0VtJbYvlAFos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgGAS27 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:28:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41934 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732868AbgGAS27 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jul 2020 14:28:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so13867111wrl.8;
        Wed, 01 Jul 2020 11:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zfHTaCjW9UsxSmTu/nOJ0l79v/cp+834Mogs/IN1Xxw=;
        b=I2dznqOWLaQFzA6fG4XQeC9UPpbmx6wdKhVI0APo0hJNYlREZnVSKPY8QImH+OqYWH
         KSt8gr9IMJLdStZLb8dBs5UcyyYtegxjDNv1LnLbOKJt1MJMXQiY7qM/xstcLNNgcXAx
         bjmG2VKso1qi1UmB273K/UmjzkFW2nRe5niO9jPAPHdnt3D3ablr9Mh2fD8I7fObmcgL
         7IpIEc10GeLEPzPqKkUWyb5hLOPM3oM1KL74w2xr3m8b43gGh7qQiRlWM1Ju4KJUWYgM
         eB4CLdor+dwSyxU66D4UlOvEr01KoDwybbudsNLU8GWkPAQXqnoIw1S2wBM0uZ9gY0FJ
         9XFQ==
X-Gm-Message-State: AOAM533fLfO3O5ZoM2jJVMizZGncAFsbUUKJh4eICXTC94GLjJ+9Gc2n
        Kclnp7E5Lt46xZTox3v2PCk=
X-Google-Smtp-Source: ABdhPJwtyWIKvVBwzXmpwaiojx8Eh3/eJnk3WYEbki8kdExt+EBOiUeCqnWpA40Mc+3R9PL3MjcMdg==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr26632136wrv.289.1593628137409;
        Wed, 01 Jul 2020 11:28:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a22sm7910904wmj.9.2020.07.01.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:28:56 -0700 (PDT)
Date:   Wed, 1 Jul 2020 18:28:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.8-rc4
Message-ID: <20200701182855.l5xdgglmctv3otvb@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 77b48bea2fee47c15a835f6725dd8df0bc38375a:

  Drivers: hv: Change flag to write log level in panic msg to false (2020-06-29 10:30:35 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.8-rc4

  - One patch from Joseph to make panic reporting contain more
    useful information.
----------------------------------------------------------------
Joseph Salisbury (1):
      Drivers: hv: Change flag to write log level in panic msg to false

 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
