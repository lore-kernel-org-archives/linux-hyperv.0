Return-Path: <SRS0=LJ8A=Y2=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C9CA9EC7
	for <linux-hyperv@archiver.kernel.org>; Sat,  2 Nov 2019 04:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EA218AC
	for <linux-hyperv@archiver.kernel.org>; Sat,  2 Nov 2019 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572668340;
	bh=L4yi9HZzSLKWoBVRW7HDpNcj9mWtZhcY8Rr5d7zt5oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJgyMk3PQd/Fr7OvqUwrPW1VIa9UtM1qGZzG0Nqh6SPBy5niBEeBa9QZWSYJxutK9
	 VPdSniC7sJwy2XBdLRc6N7gk9K3ij6zr7DhJgtmzKTiaVbVpaSB+K21M+OR5Vmqie7
	 U0yYYfAwgFR7dKvji6WvovzOZ12TMH7z0XuHG8Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfKBETA (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 2 Nov 2019 00:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKBETA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 Nov 2019 00:19:00 -0400
Received: from localhost (unknown [81.18.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C99E2084D;
        Sat,  2 Nov 2019 04:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572668339;
        bh=L4yi9HZzSLKWoBVRW7HDpNcj9mWtZhcY8Rr5d7zt5oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OV6PhQG8AT4wISD+TKNP+5puVX214jsYAkuBxYKn+lbFmwpFQhtLjB7jIYxuYPZsk
         lNYDsRGOTfq6wGhtM4XlUY23WM/uVwj2KX5rb8ZxHcKuLAcb0z/kjpbBIfYk/4g/I7
         u5W+5DKEvI+fVyh7bhBsP3hW5pLRTxbNk2mj9pTQ=
Date:   Sat, 2 Nov 2019 00:18:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191102041856.GY1554@sasha-vm>
References: <20191024144943.26199-1-olaf@aepfle.de>
 <20191028161754.GF1554@sasha-vm>
 <20191028184955.24dbb7d4.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191028184955.24dbb7d4.olaf@aepfle.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 28, 2019 at 06:49:55PM +0100, Olaf Hering wrote:
>Am Mon, 28 Oct 2019 12:17:54 -0400
>schrieb Sasha Levin <sashal@kernel.org>:
>
>> undefined reference to `pthread_create'
>
>Does "make V=1 -C tools/hv" work for you?
>This is what I use.

It works before I apply this patch, but breaks after:

$ make V=1 -C tools/hv
make: Entering directory '/home/sasha/linux/tools/hv'
make -f /home/sasha/linux/tools/build/Makefile.build dir=. obj=hv_kvp_daemon
make[1]: Entering directory '/home/sasha/linux/tools/hv'
  gcc -Wp,-MD,./.hv_kvp_daemon.o.d -Wp,-MT,hv_kvp_daemon.o -O2 -Wall -g -D_GNU_SOURCE -Iinclude -D"BUILD_STR(s)=#s" -c -o hv_kvp_daemon.o hv_kvp_daemon.c
   ld -r -o hv_kvp_daemon-in.o  hv_kvp_daemon.o
make[1]: Leaving directory '/home/sasha/linux/tools/hv'
gcc -O2 -Wall -g -D_GNU_SOURCE -Iinclude  hv_kvp_daemon-in.o -o hv_kvp_daemon
make -f /home/sasha/linux/tools/build/Makefile.build dir=. obj=hv_vss_daemon
make[1]: Entering directory '/home/sasha/linux/tools/hv'
  gcc -Wp,-MD,./.hv_vss_daemon.o.d -Wp,-MT,hv_vss_daemon.o -O2 -Wall -g -D_GNU_SOURCE -Iinclude -D"BUILD_STR(s)=#s" -c -o hv_vss_daemon.o hv_vss_daemon.c
   ld -r -o hv_vss_daemon-in.o  hv_vss_daemon.o
make[1]: Leaving directory '/home/sasha/linux/tools/hv'
gcc -O2 -Wall -g -D_GNU_SOURCE -Iinclude  hv_vss_daemon-in.o -o hv_vss_daemon
make -f /home/sasha/linux/tools/build/Makefile.build dir=. obj=hv_fcopy_daemon
make[1]: Entering directory '/home/sasha/linux/tools/hv'
  gcc -Wp,-MD,./.hv_fcopy_daemon.o.d -Wp,-MT,hv_fcopy_daemon.o -O2 -Wall -g -D_GNU_SOURCE -Iinclude -D"BUILD_STR(s)=#s" -c -o hv_fcopy_daemon.o hv_fcopy_daemon.c
   ld -r -o hv_fcopy_daemon-in.o  hv_fcopy_daemon.o
make[1]: Leaving directory '/home/sasha/linux/tools/hv'
gcc -O2 -Wall -g -D_GNU_SOURCE -Iinclude  hv_fcopy_daemon-in.o -o hv_fcopy_daemon
make: Leaving directory '/home/sasha/linux/tools/hv'
$ git am ~/incoming/_PATCH_v1_tools-hv_async_name_resolution_in_kvp_daemon.patch
Applying: tools/hv: async name resolution in kvp_daemon
$ make V=1 -C tools/hv
make: Entering directory '/home/sasha/linux/tools/hv'
make -f /home/sasha/linux/tools/build/Makefile.build dir=. obj=hv_kvp_daemon
make[1]: Entering directory '/home/sasha/linux/tools/hv'
  gcc -Wp,-MD,./.hv_kvp_daemon.o.d -Wp,-MT,hv_kvp_daemon.o -O2 -Wall -g -D_GNU_SOURCE -Iinclude -D"BUILD_STR(s)=#s" -c -o hv_kvp_daemon.o hv_kvp_daemon.c
   ld -r -o hv_kvp_daemon-in.o  hv_kvp_daemon.o
make[1]: Leaving directory '/home/sasha/linux/tools/hv'
gcc -O2 -Wall -g -D_GNU_SOURCE -Iinclude -lpthread hv_kvp_daemon-in.o -o hv_kvp_daemon
/usr/bin/ld: hv_kvp_daemon-in.o: in function `kvp_obtain_domain_name':
/home/sasha/linux/tools/hv/hv_kvp_daemon.c:1372: undefined reference to `pthread_create'
/usr/bin/ld: /home/sasha/linux/tools/hv/hv_kvp_daemon.c:1377: undefined reference to `pthread_detach'
collect2: error: ld returned 1 exit status
make: *** [Makefile:36: hv_kvp_daemon] Error 1
make: Leaving directory '/home/sasha/linux/tools/hv'

-- 
Thanks,
Sasha
