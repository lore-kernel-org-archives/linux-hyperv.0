Return-Path: <SRS0=GrSc=RK=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202AC43381
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113F2081B
	for <linux-hyperv@archiver.kernel.org>; Thu,  7 Mar 2019 16:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCGQgb (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:36:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfCGQgb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Mar 2019 11:36:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3810E2D808;
        Thu,  7 Mar 2019 16:36:31 +0000 (UTC)
Received: from mmorsy.remote.csb (ovpn-200-36.brq.redhat.com [10.40.200.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34CA11001E69;
        Thu,  7 Mar 2019 16:36:21 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        kimbrownkd@gmail.com
Cc:     Alexander.Levin@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, longli@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH] hyper-v: Check for ring buffer in hv_get_bytes_to_read/write
Date:   Thu,  7 Mar 2019 18:36:06 +0200
Message-Id: <20190307163606.25212-1-mgamal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 16:36:31 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch adds a check for the presence of the ring buffer in
hv_get_bytes_to_read/write() to avoid possible NULL pointer dereferences.
If the ring buffer is not yet allocated, return 0 bytes to be read/written.

The root cause is that code that accesses the ring buffer including
hv_get_bytes_to_read/write() could be vulnerable to the race condition
discussed in https://lkml.org/lkml/2018/10/18/779

This race is being addressed by the patch series by Kimberly Brown in
https://lkml.org/lkml/2019/2/21/1236 which is not final yet

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 include/linux/hyperv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 64698ec8f2ac..7b2f566250b2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -148,6 +148,9 @@ static inline u32 hv_get_bytes_to_read(const struct hv_ring_buffer_info *rbi)
 {
 	u32 read_loc, write_loc, dsize, read;
 
+	if (!rbi->ring_buffer)
+		return 0;
+
 	dsize = rbi->ring_datasize;
 	read_loc = rbi->ring_buffer->read_index;
 	write_loc = READ_ONCE(rbi->ring_buffer->write_index);
@@ -162,6 +165,9 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 {
 	u32 read_loc, write_loc, dsize, write;
 
+	if (!rbi->ring_buffer)
+		return 0;
+
 	dsize = rbi->ring_datasize;
 	read_loc = READ_ONCE(rbi->ring_buffer->read_index);
 	write_loc = rbi->ring_buffer->write_index;
-- 
2.18.1

