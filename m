Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE6C001B0
	for <linux-hyperv@archiver.kernel.org>; Tue,  4 Jul 2023 16:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGDQ3F (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGDQ2y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Jul 2023 12:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9C1981
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Jul 2023 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688488067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHdgPj1Wm2IgY2fHBO70NHanGv82Rz5Bml4kSaFfUEk=;
        b=jCwEbiV78yYy+2kz0mYUu/xOOcW+HRcoh9pUaVZwoqlbjPJvwYbCxtM6W+gIlxzoWzWLS4
        ps5qQSQ5akNYq/4k0kjIe16br+5UpnRkhVPLhy5CYcq4IwE52oXCwHsMOm82YH0YBy3RRG
        Plv0smLrvJIEcqFXxNmcA/XrMEG9LjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-8QZwvmdkNBKrcNIb4fxAZA-1; Tue, 04 Jul 2023 12:27:46 -0400
X-MC-Unique: 8QZwvmdkNBKrcNIb4fxAZA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbaade0c71so36413825e9.2
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Jul 2023 09:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488065; x=1691080065;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHdgPj1Wm2IgY2fHBO70NHanGv82Rz5Bml4kSaFfUEk=;
        b=aTf2hBbSItsQLhCBK9u4RUiRhkd6VU3aCTZatKAa1LECXsqFTPFrvEQ2e9oirG1J/U
         /o3W/hGvtx2rZZT2pOVHSPbEyJYagX1ZO8qAzESwxS3VVbecuoyZixh3BuqhUuj5vO+4
         F0z0O7mk4wZFkvKa/sm2mamjMWFmLRhtAwYj2ZnXuku8WDAKcsXbT6R8ynxOfm5kZTmR
         QQigD5mafY355layyMXLJtGfgPCnKybeIWrTAcbqJp5XU4fnXDrjnUeCVMJJT+/e/oJM
         +ToHuBGUGPjbzsj9DK6GGpCTEXp3dYQTZ9KJ/d0R3nasq+rMHzUPU1kzc2mQFGU72/gq
         UqGA==
X-Gm-Message-State: AC+VfDwXDafIPeEhuZF2yAkQIaY96QEJpq38RBVhecajvVmOF3XtzSXQ
        BTf26JkI0vUUX+mDGPrSPnl3XipUkMpKpN+fpl8roHaw22sHF4vd5TpzW2NuY5uiZ4IrQNooC90
        T3gTTsKhu2iwlM6kBB17/6K5DhsA2eBfGC2Y=
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr12439029wme.29.1688488065020;
        Tue, 04 Jul 2023 09:27:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76jB5JrX6TXp/j+SpnZTGNMceWk0U9GUm8msLFZPg0J8xzTJ2Ph/XYxtIjAMzvUbO/YmFVwQ==
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr12439000wme.29.1688488064598;
        Tue, 04 Jul 2023 09:27:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm22214385wmj.39.2023.07.04.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:27:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, Rich Felker <dalias@libc.org>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-csky@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        loongarch@lists.linux.dev,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 05/12] arch: Remove trailing whitespaces
In-Reply-To: <20230629121952.10559-6-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-6-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:27:43 +0200
Message-ID: <877crflk00.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

