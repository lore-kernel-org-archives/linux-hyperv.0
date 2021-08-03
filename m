Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB478C432BE
	for <linux-hyperv@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A8760F93
	for <linux-hyperv@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhHCM7o (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:59:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhHCM7n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 08:59:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F088021C1B;
        Tue,  3 Aug 2021 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627995571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMGr2bMFEOJkptOUJEslT5Rfc8inM6HmVr0HkLxTO48=;
        b=g4d7OwKX0BNDWNw4lbkxL/t63EICoH93gazLB2MgxeGzRKVyDmDcj8Ke5aLgpRyAOC/ST7
        58yDCQLUAkCKhLrW9DuzUL2UZqJhM4x2EoaWbSXVAizKx3PEYKLNJvTX5GdHcXlfW1X0a8
        tiqMRH2Q4L8eTJ4z9fYzInLIMjyFzBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627995571;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMGr2bMFEOJkptOUJEslT5Rfc8inM6HmVr0HkLxTO48=;
        b=DFbalQutwyV/J1ZNbO2xxS2e+kFXNq2zoOAqXP6uf/b/lUQnU4yNdhY4XgKI0KHYMTs7eC
        czOClUWKEMeMkWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC4713CD6;
        Tue,  3 Aug 2021 12:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKGrHLM9CWExZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:31 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, drawat.floss@gmail.com, kraxel@redhat.com,
        hdegoede@redhat.com, sean@poorly.run,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/11] drm/ast: Use offset-adjusted shadow-plane mappings
Date:   Tue,  3 Aug 2021 14:59:19 +0200
Message-Id: <20210803125928.27780-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For framebuffers with non-zero offset fields, shadow-plane helpers
provide a pointer to the first byte of the contained data. Use it in
ast.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 15319967164e..6bfaefa01818 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -808,7 +808,7 @@ ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
 		ast_cursor_plane->hwc[ast_cursor_plane->next_hwc_index].map;
 	u64 dst_off =
 		ast_cursor_plane->hwc[ast_cursor_plane->next_hwc_index].off;
-	struct dma_buf_map src_map = shadow_plane_state->map[0];
+	struct dma_buf_map src_map = shadow_plane_state->data[0];
 	unsigned int offset_x, offset_y;
 	u16 x, y;
 	u8 x_offset, y_offset;
-- 
2.32.0

