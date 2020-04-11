Return-Path: <SRS0=1uwt=53=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C43C2BA19
	for <linux-hyperv@archiver.kernel.org>; Sat, 11 Apr 2020 23:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBB72173E
	for <linux-hyperv@archiver.kernel.org>; Sat, 11 Apr 2020 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646563;
	bh=OpFbVyvYnIHYbXaql1M7ib78tJ4gNMyNDUmLjzivcGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f+8qm1HUP1J2tbj6LD+h3iwx75MmhOUq3einRNRpAaWSxQKQuokK4wpNHdYXC8hkv
	 lmGrlg8icHfG4lESRcB1Jynx2l4o46sihGXLJZDDiUPE/zEAG6/zHQwXWebp3Q+n5h
	 gOdrc4221+tbY9QCbGGDzaQUJ8eZs5k4KUx0nP50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDKXJV (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgDKXJU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE93217D8;
        Sat, 11 Apr 2020 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646560;
        bh=OpFbVyvYnIHYbXaql1M7ib78tJ4gNMyNDUmLjzivcGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHL7gsDWqmD375hPreg7Oxp8szWklB4m0kU8kkoqnjEnK1bbyyPpMStHfd77SZuUn
         yKbltWhaNJIKMUhx/+S86Ye9BjGvvs1/eaIrN76E+V1+Vrl6uvcOGAPr6wAFrMXAin
         MH2L1ULkZAkS5BZZ3+tE/yOo+w8KI/dd0V4FhUqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 109/121] PCI: hv: Add missing kfree(hbus) in hv_pci_probe()'s error handling path
Date:   Sat, 11 Apr 2020 19:06:54 -0400
Message-Id: <20200411230706.23855-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 42c3d41832ef4fcf60aaa6f748de01ad99572adf ]

Now that we use kzalloc() to allocate the hbus buffer, we must call
kfree() in the error path as well to prevent memory leakage.

Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc5..6b3cee4324047 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3058,7 +3058,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_dom:
 	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
-	free_page((unsigned long)hbus);
+	kfree(hbus);
 	return ret;
 }
 
-- 
2.20.1

