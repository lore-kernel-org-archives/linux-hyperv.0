Return-Path: <SRS0=8c0w=D7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E6C2D0A3
	for <linux-hyperv@archiver.kernel.org>; Sat, 24 Oct 2020 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3F62225E
	for <linux-hyperv@archiver.kernel.org>; Sat, 24 Oct 2020 21:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ppPum58V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764955AbgJXVhf (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 24 Oct 2020 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764398AbgJXVfw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Oct 2020 17:35:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFDC0613DC;
        Sat, 24 Oct 2020 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DgYJXMbGV2JHVlFqtFelrBsB7Fb/P3o4K3g0IpTnelg=; b=ppPum58VCS68LGKaXXBfsrln/Q
        KkM8Q5LSuWoDJBfWvKJE/OMT9IURKS2ziVKKK0uOA4D5sY/QIlvrOyNsjquG+mnf3/bO7GegxhSJ/
        miQf26DVrBpo8dqpyMv50+b31ZvI0sm/I+bagh6Y7BkBKIsYOVT1J7hb10u7+3d6aQ7nivCNQgRLS
        xJlaJ8SiWApO+iKakusrmTX7ZrdfFkrpZyXfMzsQGEekYXVgAMgkI1ixTVDEHYHeSB0nS/BdWtbsZ
        Y/254u+59AfkZOsrPpIVfwWip5uefhi3mYkuXUqpWtsZ7N00Ntf7qzJiWgpiVH9y0IuOXcSOf1p8W
        lWbngivw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWRCT-0008Bc-8F; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kWRCN-001rP0-7I; Sat, 24 Oct 2020 22:35:39 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, maz@misterjones.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 22/35] genirq/irqdomain: Implement get_name() method on irqchip fwnodes
Date:   Sat, 24 Oct 2020 22:35:22 +0100
Message-Id: <20201024213535.443185-23-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Prerequesite to make x86 more irqdomain compliant.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..673fa64c1c44 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -42,7 +42,16 @@ static inline void debugfs_add_domain_dir(struct irq_domain *d) { }
 static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
 #endif
 
-const struct fwnode_operations irqchip_fwnode_ops;
+static const char *irqchip_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+
+	return fwid->name;
+}
+
+const struct fwnode_operations irqchip_fwnode_ops = {
+	.get_name = irqchip_fwnode_get_name,
+};
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
 /**
-- 
2.26.2

