Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A7C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E5217F5
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj53FbLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfBZOWQ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:22:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33818 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZOWQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 09:22:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so6304384pgd.1;
        Tue, 26 Feb 2019 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WspJFciilXB4U2x8hxTSOZwocNHHGevvjdRWYlg72iQ=;
        b=jj53FbLJxBbU88g7OIAygbunKacdXP/38vhfcvOINYG1PViF6y4sukmrLQdiMfPZKH
         QwA13jtqPbFRWJbeMisOz5+oPUCHke0ndhaAFhXmMrB4laFXzYPWAWNcgZ/LsHgUaWrJ
         +X25aKUz2WWaEKYc/PPRl2T9wxTSGqUdW1Me5ZUo4l0oHnbxrxYzrOjt/zSAekHtpu7v
         qcPSSunQLiy2AXSeIe+wdyBn6nxd8wIeBNu7q7GS7PGD6BPguw0AWr12SkASezRy8IQc
         A04YivSMZhZVqeT2GoF2TCiPnVos904mHsi0ZAxlxy5FGaARM0dgBuP5R5zqF8zlr3TP
         7GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WspJFciilXB4U2x8hxTSOZwocNHHGevvjdRWYlg72iQ=;
        b=NYFT9EzFgs+R3mv5WobYyJTQ75Cj9l6DkzaA4kyvYlDU63LTorpQgJRihPXzukVoEj
         FK91PhSwwb0VPR9gjmO2yup97tIDHlCsYlQQ+/jVz8wVGsbHf8O7wnNpv8kPz+nunizS
         qfh0UM9VhKLz/TVUC6+yfurT61mTgwBcsWtBryEBmuln/k/zf+7CKY7xAHq1q4OEg7sW
         Qfqv5eLmIWSiG9epddBiRlv6mST7HxpJxmGV5HnsaIHGz33uWrLTRa6wk+m1MdG7DGTh
         XbG4dyAHcs5XKwFJaQbSN3kT+YRs+GB7HgAVgaa3+S4uMaGVvUIWxUr5Z+pwjs+PW35x
         syVg==
X-Gm-Message-State: AHQUAuZhkMyIkYcLOEGDpsP7S/7hsDH9BPIrzG2P9TPpt4yLWi76WVeL
        Tc25y5PrIK/B6HbQfPmqAGc=
X-Google-Smtp-Source: AHgI3IZS2Yu3WAOYeMaM5bizKeoTVE4mVq1PrUZ8Fou/ATIYw2IltHPcTdbgd2+Yf3OXCgbq8/XIvA==
X-Received: by 2002:a62:43c5:: with SMTP id l66mr26687873pfi.77.1551190935120;
        Tue, 26 Feb 2019 06:22:15 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.3])
        by smtp.googlemail.com with ESMTPSA id i193sm21597584pgc.63.2019.02.26.06.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 06:22:14 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [Update PATCH V3 2/10] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date:   Tue, 26 Feb 2019 22:21:48 +0800
Message-Id: <20190226142148.23801-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Populate ranges on the flush list into struct hv_guest_mapping_flush_list
when flush list is available in the struct kvm_tlb_range.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Update:
	- Add check of return value "offset" in the kvm_fill_hv_flush_list_func()

Change since v2:
	- Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 21 +++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 875ae7256608..9fc9dd0c92cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -318,6 +318,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 	bool mmio_cached;
@@ -441,6 +447,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 77b5379e3655..197545121355 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -432,9 +432,26 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
+	struct kvm_mmu_page *sp;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
-			range->pages);
+	if (!range->flush_list) {
+		return hyperv_fill_flush_guest_mapping_list(flush,
+			0, range->start_gfn, range->pages);
+	} else {
+		int offset = 0;
+
+		hlist_for_each_entry(sp, range->flush_list, flush_link) {
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
+
+			offset = hyperv_fill_flush_guest_mapping_list(flush,
+					offset, sp->gfn, pages);
+			if (offset < 0)
+				return offset;
+
+		}
+
+		return offset;
+	}
 }
 
 static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
-- 
2.14.4

