Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2AC05051
	for <linux-hyperv@archiver.kernel.org>; Sat, 15 Jul 2023 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGOSys (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 15 Jul 2023 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGOSyC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 Jul 2023 14:54:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705A30FD;
        Sat, 15 Jul 2023 11:53:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D31A621B48;
        Sat, 15 Jul 2023 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689447233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rN7iXgHdNfoVTGsKEMlM6qhA1C0OhaHzC+3XBqWokqM=;
        b=0CLO+Jl4RJxV02TQgGz1lVL0Z9mSQ1j0P+DgJ0nbU3UREBFXn2S5HeoaA8EFIUrK8+tzuG
        kTXqLC5ehTyt80dsVHiDLOBo2qQe1dSoc8WH+TmzBpFIYDvstFzOhzYqpjWqEoNBLAnMl7
        R7fqYYnu/SFLBf1BHOVJWcubFCaLJXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689447233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rN7iXgHdNfoVTGsKEMlM6qhA1C0OhaHzC+3XBqWokqM=;
        b=+mXK0HAm21mj2g3flnXhM/kuVloOtSTQJd3/Y+ZO6agZVwZtFaRZLjGgxErCwRwNTikJWj
        JChxhkeFZob60KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7463E13A23;
        Sat, 15 Jul 2023 18:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIB4G0HrsmQCBwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sat, 15 Jul 2023 18:53:53 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, javierm@redhat.com, geert@linux-m68k.org,
        dan.carpenter@linaro.org
Cc:     linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v4 18/18] fbdev: Document that framebuffer_alloc() returns zero'ed data
Date:   Sat, 15 Jul 2023 20:52:00 +0200
Message-ID: <20230715185343.7193-19-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715185343.7193-1-tzimmermann@suse.de>
References: <20230715185343.7193-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Most fbdev drivers depend on framebuffer_alloc() to initialize the
allocated memory to 0. Document this guarantee.

v3:
	* slightly reword the sentence (Miguel)

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fb_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 8bdbefdd4b70..4847ebe50d7d 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -13,7 +13,8 @@
  *
  * Creates a new frame buffer info structure. Also reserves @size bytes
  * for driver private data (info->par). info->par (if any) will be
- * aligned to sizeof(long).
+ * aligned to sizeof(long). The new instances of struct fb_info and
+ * the driver private data are both cleared to zero.
  *
  * Returns the new structure, or NULL if an error occurred.
  *
-- 
2.41.0

