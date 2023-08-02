Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A251C001DE
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Aug 2023 05:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjHBFu5 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Aug 2023 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjHBFu5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 01:50:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 605EF10EA;
        Tue,  1 Aug 2023 22:50:56 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id DB1D0238AF68;
        Tue,  1 Aug 2023 22:50:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB1D0238AF68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690955455;
        bh=o47Z7FL0EGxS3sVmC/j/HBMYaOZNkpQdTsm/vyp5wl4=;
        h=From:To:Cc:Subject:Date:From;
        b=iYphvqsD9S7j9YmWuFtcsNLo5T1gH3Ycq8824t/mHMaHdmQxLHCbZpVFiplfKLJUh
         shXSniCj9LPlN1q9pXFDcWHkic/TVkN+/XRGWPg9xjPmc5/QlKkzB9i4Ds2MVTOUrT
         ONxNgROrBy3woN47CcfeUO16Wbz866VgW+js1hp4=
From:   Sonia Sharma <sosha@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, sosha@microsoft.com,
        kys@microsoft.com, mikelley@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: [PATCH] hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
Date:   Tue,  1 Aug 2023 22:50:50 -0700
Message-Id: <1690955450-5994-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sonia.sharma@linux.microsoft.com>

switch statement in netvsc_send_completion() is incorrectly validating
the length of incoming network packets by falling through next case.
Avoid the fallthrough, instead break after a case match and then process
the complete() call.

Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 82e9796c8f5e..347688dd2eb9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG5_TYPE_SUBCHANNEL:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		/* Copy the response back */
-		memcpy(&net_device->channel_init_pkt, nvsp_packet,
-		       sizeof(struct nvsp_message));
-		complete(&net_device->channel_init_wait);
 		break;
 
 	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
@@ -904,13 +900,18 @@ static void netvsc_send_completion(struct net_device *ndev,
 
 		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
 					desc, budget);
-		break;
+		return;
 
 	default:
 		netdev_err(ndev,
 			   "Unknown send completion type %d received!!\n",
 			   nvsp_packet->hdr.msg_type);
 	}
+
+	/* Copy the response back */
+	memcpy(&net_device->channel_init_pkt, nvsp_packet,
+			sizeof(struct nvsp_message));
+	complete(&net_device->channel_init_wait);
 }
 
 static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
-- 
2.25.1

