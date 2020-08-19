Return-Path: <SRS0=FEYt=B5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD5C433E1
	for <linux-hyperv@archiver.kernel.org>; Wed, 19 Aug 2020 17:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0A82067C
	for <linux-hyperv@archiver.kernel.org>; Wed, 19 Aug 2020 17:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m0t6n++Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHSRsN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:48:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47748 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHSRsL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Aug 2020 13:48:11 -0400
Received: from testvm-timer.0wqf5yk0ngwuzjntifuk1ppqse.cx.internal.cloudapp.net (unknown [40.65.222.102])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A40E20B4908;
        Wed, 19 Aug 2020 10:48:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A40E20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597859290;
        bh=oruyqdKng8+TpXlSXXiikHoCNNdO9Z8FHlgfX8r5vB0=;
        h=From:To:Cc:Subject:Date:From;
        b=m0t6n++ZbcgJ9uS8BGrsR4ZCUeHQkIZgLz1/3jzay5U3fF/tyZWx4neN/mNaOVGG2
         o1pyrsWP1m0UQTHCneJ8RNC2m9chEnlGtD6RiOwKtgRI9wR6ZN1jscBQX4n7e+M2Fq
         6nRPnc215Zt+G1qK5VNscJef/3VUHaL6ErNZsIS4=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv_utils: drain the timesync packets on onchannelcallback
Date:   Wed, 19 Aug 2020 17:47:40 +0000
Message-Id: <20200819174740.47291-1-viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There could be instances where a system stall prevents the timesync
packaets to be consumed. And this might lead to more than one packet
pending in the ring buffer. Current code empties one packet per callback
and it might be a stale one. So drain all the packets from ring buffer
on each callback.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_util.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1357861fd8ae..c0491b727fd5 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -387,10 +387,23 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	/*
+	 * Drain the ring buffer and use the last packet to update
+	 * host_ts
+	 */
+	while (1) {
+		int ret = vmbus_recvpacket(channel, time_txf_buf,
+					   HV_HYP_PAGE_SIZE, &recvlen,
+					   &requestid);
+		if (ret) {
+			pr_warn("TimeSync IC pkt recv failed (Err: %d)\n",
+				ret);
+			break;
+		}
+
+		if (!recvlen)
+			break;
 
-	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
-- 
2.17.1

