Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3B3FF1B4
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962286; cv=none; b=EEr7VD5uPQsnzYqV8lsW65QhFHjOAhSNWK95dsY+eyAG285mAJveRTc0VZy/WyDEKTfkrqujWTCegA1pH2o+8z8bIv9Nsna/RWArHgq7PM0TsD8ZPIy3vlnlilPy4Jw8cghVmgAgnice3WAji6bkDiXtMt1Genl3XqPZ1lY56C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962286; c=relaxed/simple;
	bh=2JV7r7V/5Mfq8JH8nQM5E/GaIrbQyMtNDpsDFRzujZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1oYuDkS2dppYIZlTPNmxe4yIeXeY9NIHGnVnDX7rpqeG7lraB0HiP4jFIbCCxIsDY6thxZsCBgSrImoiz3z6cmoZ1SWkRGJAd5d8u/ylEirKi99pzIMQD83oma0lY7OWDaYz9CplzECIK2OrGYD6R3mfE8Mt53/0qiVScwLY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+eeck3O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+eeck3O"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso15775835ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962284; x=1786567084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jA62W3yoTyokb29gnpNc2qYchzwbF/7Ke7VtlhKVyA=;
        b=A+eeck3OGxbUWyYhtNL1rFuLKVIBEvEF9eTiCr6jMU2EvpAgWLfwBrR1m3mDrPWaRz
         J5HAMDRDZ1+v8KT6cUFSnjUGwOBPKHLp//n1T6q+MSpQvK3qlLtioQPCCeBMh6kwne6S
         cK7aCWmmHOVsjVV1DTz6nCsTL2wne5DNhFyqiupBQAcp7feP1c7Xfp0ST7JR/cZxXsaE
         pkWn43MI2H43DHgOw60Qclnm2KDm6SYqgR7jX4CrPidd51By3V4TaWqJ/XPf/bmKruvI
         Cdn/Jph18GNVGh1e+IW9vqYQ+Ze/Oeg+zz/TKcNkKcNzUkWCSBJkyREPPas8B4/QkIhL
         CsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962284; x=1786567084;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jA62W3yoTyokb29gnpNc2qYchzwbF/7Ke7VtlhKVyA=;
        b=jyKYPOi1vwM2ktWMa620txE18hwNgBxRVN2FK5ryYv6woIIjICypmIvcSc4WKlfqe4
         dFfkoikG/myxyMInxI7KtqFsKcAKFrzpZi1vF9FBk6J50JR/e+3GOmAdEWIZVVIIgPB+
         KU9bx8EfgaxgR5IoNtpodTNmFpO35jdx1kIXZdWtusFLIcs4fH7vGQ8G+P63LWbZZfpj
         +b7hyzpChBry5NavIur4qRKekZa9jTSCUIKFtihfkfFrdT4FCiwJrMlOGbW8Ifu/z8lH
         e+ieZ9d22NjH7cWRf+LaioGR2mNgrJtRDcvx7gcaWd0pXY5lC0s5Yc3oX4V7cmxNdwUg
         I5XQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLMCW2H6PzQyzGAQW8zQKqWqR35gvKkVD50YPP5iv/JIUp20qkjOdjRu8cI5P/pf3Cycd7E9NYlpHcn2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2P1wxWszAKwE1IECdMJbSAJ6MXGLzyiqve5qMxlsulhKVvVn
	+ClOtiOyU3s6eX9E70TcM0FeXa6t9utviJhz/OxW8DIo9fR4aub4lJIU
X-Gm-Gg: AR+sD12UbLJWlSnwmhv0MAKSaoDpx2xeTv5vh/rYnEKblsI/Dh+Ef6ChrlJbfEv5rQB
	Ce9rA+eJsKoeRUbO30golzBKd7bgHv9ITqxgBiv9+p/7qqpVK4mz9UdgF2+055siOFf39GzIUSW
	8ssTFK6YCph/XzVeYUEbQhIZhp2eRR3w6ukS7NuveomzNIeOLnodCbawa8hM/ZCFmDMQMZRhwH9
	pMZHOb7pS21H/+MRIkA8kP8BZcsXWlmovMlEmte5X8bkKYEsZd4Um0aKUAjAkNr03OPxfpVClvU
	dBy4TNwLbJYMO7aRq5djsBiu1bruQULmjM8rpnqFI654HWI8hl9xO0ql2xugtc0mi+TQavzCpoP
	xQOG3Bw5Bvbg0x1pibk/UBcW7v7On7mfMKlQ6XhSspUhqiAWL2vpd4Cd9RCSZ3BqEwwmeRcFRs9
	Jp1qkRUtlpS0zYJJGTUKMAyjIG0j9s90fzERAugTml4Uus1DQmonAyaf3+cxUQ0DcSrKJlu7WJy
	1I2J6osPeof0V5PcxWJDrgNdnPlhFO6xgpweOyybtg=
X-Received: by 2002:a17:903:18c:b0:2cf:7fab:3cf with SMTP id d9443c01a7336-2d0ca981a9fmr99371515ad.23.1785962283985;
        Wed, 05 Aug 2026 13:38:03 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:03 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of Hyper-V
Date: Wed,  5 Aug 2026 13:37:46 -0700
Message-Id: <20260805203751.2678-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260805203751.2678-1-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux code for running as a Hyper-V guest includes special cases for
running on Hyper-V in WS2012/2012R2 and Windows 8/8.1. These versions
were initially released 14 years ago, and official support ended in 2023
(unless a customer has contracted for extended security updates). Given
the release of subsequent versions with improved functionality, there's
no need to continue to support the latest Linux kernels on these versions
of Hyper-V. If someone is running Linux on one of these older Hyper-V
versions and doesn't want to upgrade, they can continue to do so as
presumably they don't want upgrade the Linux version either.

Simplify Linux code by removing special cases for running on these
old versions of Hyper-V. Remove the negotiation of the VMBus protocol
versions for WS2012/Win8, and remove special case code based on those
VMBus protocol versions. Also update the balloon and snapshot drivers
to no longer negotiate driver-specific protocol versions for these
older Hyper-V versions, and remove any related special cases.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Added error message in vmbus_connect() to indicate that running on
  an older version of Hyper-V is a possible cause of being unable to
  negotiate a compatible VMBus version [Hamza Mahfooz]
* Added a check in vmbus_initiate_unload() to catch the CONNECTING
  state. This case was previously implicitly caught by the VMBus protocol
  version check that has been removed. [Sashiko]

 drivers/hv/channel_mgmt.c |  8 +++-----
 drivers/hv/connection.c   | 11 +++++++----
 drivers/hv/hv_balloon.c   | 36 +++++++++++++++---------------------
 drivers/hv/hv_snapshot.c  |  5 -----
 include/linux/hyperv.h    |  5 ++---
 5 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 89d214dda360..a044fd3b3c4e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -929,12 +929,10 @@ static void vmbus_unload_response(struct vmbus_channel_message_header *hdr)
 void vmbus_initiate_unload(bool crash)
 {
 	struct vmbus_channel_message_header hdr;
+	enum vmbus_connect_state old_state;
 
-	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
-		return;
-
-	/* Pre-Win2012R2 hosts don't support reconnect */
-	if (vmbus_proto_version < VERSION_WIN8_1)
+	old_state = xchg(&vmbus_connection.conn_state, DISCONNECTED);
+	if (old_state == DISCONNECTED || old_state == CONNECTING)
 		return;
 
 	reinit_completion(&vmbus_connection.unload_event);
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 0fd50d4cb573..1ab3581b096a 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -47,7 +47,9 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
 
 /*
  * Table of VMBus versions listed from newest to oldest.
- * VERSION_WIN7 and VERSION_WS2008 are no longer supported in
+ * VERSION_WIN7,VERSION_WS2008, VERSION_WIN8 (which is
+ * Windows Server 2012) and VERSION_WIN8_1 (which is
+ * Windows Server 2012 R2) are no longer supported in
  * Linux guests and are not listed.
  */
 static __u32 vmbus_versions[] = {
@@ -57,9 +59,7 @@ static __u32 vmbus_versions[] = {
 	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
 	VERSION_WIN10_V4_1,
-	VERSION_WIN10,
-	VERSION_WIN8_1,
-	VERSION_WIN8
+	VERSION_WIN10
 };
 
 /*
@@ -304,6 +304,9 @@ int vmbus_connect(void)
 	for (i = 0; ; i++) {
 		if (i == ARRAY_SIZE(vmbus_versions)) {
 			ret = -EDOM;
+			pr_err("Hyper-V host does not support VMBus version %d.%d or higher;\n\
+		 the host may be an older version no longer supported by Linux\n",
+				vmbus_versions[i-1] >> 16, vmbus_versions[i-1] & 0xFFFF);
 			goto cleanup;
 		}
 
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 42ce27be344d..9cba97e81111 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -58,6 +58,10 @@
 #define DYNMEM_MAJOR_VERSION(Version) ((__u32)(Version) >> 16)
 #define DYNMEM_MINOR_VERSION(Version) ((__u32)(Version) & 0xff)
 
+/*
+ * VERSION_1 and VERSION_2 are retained for the historical record,
+ * but are no longer supported in Linux guests.
+ */
 enum {
 	DYNMEM_PROTOCOL_VERSION_1 = DYNMEM_MAKE_VERSION(0, 3),
 	DYNMEM_PROTOCOL_VERSION_2 = DYNMEM_MAKE_VERSION(1, 0),
@@ -65,9 +69,7 @@ enum {
 
 	DYNMEM_PROTOCOL_VERSION_WIN7 = DYNMEM_PROTOCOL_VERSION_1,
 	DYNMEM_PROTOCOL_VERSION_WIN8 = DYNMEM_PROTOCOL_VERSION_2,
-	DYNMEM_PROTOCOL_VERSION_WIN10 = DYNMEM_PROTOCOL_VERSION_3,
-
-	DYNMEM_PROTOCOL_VERSION_CURRENT = DYNMEM_PROTOCOL_VERSION_WIN10
+	DYNMEM_PROTOCOL_VERSION_WIN10 = DYNMEM_PROTOCOL_VERSION_3
 };
 
 /*
@@ -1434,19 +1436,9 @@ static void version_resp(struct hv_dynmem_device *dm,
 	version_req.version.version = dm->next_version;
 	dm->version = version_req.version.version;
 
-	/*
-	 * Set the next version to try in case current version fails.
-	 * Win7 protocol ought to be the last one to try.
-	 */
-	switch (version_req.version.version) {
-	case DYNMEM_PROTOCOL_VERSION_WIN8:
-		dm->next_version = DYNMEM_PROTOCOL_VERSION_WIN7;
-		version_req.is_last_attempt = 0;
-		break;
-	default:
-		dm->next_version = 0;
-		version_req.is_last_attempt = 1;
-	}
+	/* Set the next version to try in case current version fails. */
+	dm->next_version = 0;
+	version_req.is_last_attempt = 1;
 
 	ret = vmbus_sendpacket(dm->dev->channel, &version_req,
 				sizeof(struct dm_version_request),
@@ -1735,16 +1727,18 @@ static int balloon_connect_vsp(struct hv_device *dev)
 
 	/*
 	 * Initiate the hand shake with the host and negotiate
-	 * a version that the host can support. We start with the
-	 * highest version number and go down if the host cannot
-	 * support it.
+	 * a version that the host can support. The mechanism is in place
+	 * to start with the highest version number and go down if the host
+	 * cannot support it. But currently we only try the WIN10 version
+	 * since support for older Hyper-V versions has been removed from
+	 * Linux.
 	 */
 	memset(&version_req, 0, sizeof(struct dm_version_request));
 	version_req.hdr.type = DM_VERSION_REQUEST;
 	version_req.hdr.size = sizeof(struct dm_version_request);
 	version_req.hdr.trans_id = atomic_inc_return(&trans_id);
 	version_req.version.version = DYNMEM_PROTOCOL_VERSION_WIN10;
-	version_req.is_last_attempt = 0;
+	version_req.is_last_attempt = 1;
 	dm_device.version = version_req.version.version;
 
 	ret = vmbus_sendpacket(dev->channel, &version_req,
@@ -1964,7 +1958,7 @@ static int balloon_probe(struct hv_device *dev,
 #endif
 	dm_device.dev = dev;
 	dm_device.state = DM_INITIALIZING;
-	dm_device.next_version = DYNMEM_PROTOCOL_VERSION_WIN8;
+	dm_device.next_version = 0;
 	init_completion(&dm_device.host_event);
 	init_completion(&dm_device.config_event);
 	INIT_LIST_HEAD(&dm_device.ha_region_list);
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 506871aeacf0..847dc69e8250 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -372,11 +372,6 @@ static void vss_on_reset(void)
 int
 hv_vss_init(struct hv_util_service *srv)
 {
-	if (vmbus_proto_version < VERSION_WIN8_1) {
-		pr_warn("Integration service 'Backup (volume snapshot)'"
-			" not supported on this host version.\n");
-		return -ENOTSUPP;
-	}
 	recv_buffer = srv->recv_buffer;
 	vss_transaction.recv_channel = srv->channel;
 	vss_transaction.recv_channel->max_pkt_size = VSS_MAX_PKT_SIZE;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a2b484679eb4..9652083b6798 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -260,9 +260,8 @@ static inline u32 hv_get_avail_to_write_percent(
  * 5 . 2  (Windows Server 2019, RS5)
  * 5 . 3  (Windows Server 2022)
  *
- * The WS2008 and WIN7 versions are listed here for
- * completeness but are no longer supported in the
- * Linux kernel.
+ * The WS2008, WIN7, WIN8, and WIN8_1 versions are listed here for
+ * completeness but are no longer supported in the Linux kernel.
  */
 
 #define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
-- 
2.25.1

