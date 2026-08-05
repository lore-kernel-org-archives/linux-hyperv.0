Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6741F5DB
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962289; cv=none; b=R4e2zoOMQYPE3rGALl+RK/7ZmV/QHlCwVzsrfuXjNE9vMx6IbZBdkfKu+N0XXzNqMLi9lsTf/A0g+9p7OWqsai5N3f9QOTLgohpoyqzupVgRd61rMmTI7oPIPfgEDX+CHglmlLaIsJ2gA7QOZZB5op5nZ2/oHAH1VRGRFjycJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962289; c=relaxed/simple;
	bh=MNTjFuYLFdVeyceY4LcPMIuVzMCe26DSnzXIN55cVDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULCCpQm5VLHEzd69+zo09jKvQJbb8EsAYZ89EbZaYSyFUDoHJuM+U+ULcHDiLh9eCbpZsXOJc/tCFopDUlvQiGWgia1HKUrXUxJXC6YBPPCiRH/S+pp7e4bpgfaeB0X1zDMFP8Xn47dhFnCOlc4Z6SI2GhgXZw0oszmdxtJ/OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ou1EJsC3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ou1EJsC3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacb8416a1so16211895ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962287; x=1786567087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D2idJVNVVV8Bl12yg0gHJeA25XCgAkeyyrmZbnDeaoA=;
        b=ou1EJsC3OZ7//zRgTwMS9Yr9uGeE953OiBIwoPT6UXyMp/5frd+rzw8YTVbB3W84GW
         IkfKC7cwUmOLl8vIN/Tp5TwVnaVgXcqW5e6Pu0VmCoZdn82ni0kXLluQIliG8V1Kll9r
         uLUINfV7Jkov/FVjzQ71RS4UruWidWGSJ8cHOaV6WlTnmln7boGB30Xo9SH8z/z4XZ9M
         LfVk3f8HzliCd314HdxJdtZqAdU7RX4vxQvZU+Ps6lCv+XnCzDaaT5b7o9nvUb5nzrL7
         XV5zNxCu9x2Vg9cwkzS+E79i0rckfsdclarihCqGORSC6Jf7ZdtJhhDkgxDKp7bAuNMP
         rE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962287; x=1786567087;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2idJVNVVV8Bl12yg0gHJeA25XCgAkeyyrmZbnDeaoA=;
        b=DHjBLkMAJ3fZDTjrpvNFMi7+WqaZIld/mgcKZk+LS3u9IjyM6UJjHVIU3BMiU+zuNt
         QDOPRw5lFNrTQ+CONRjLsEr5QHZtt0lIOyK3HPJZv+r+SJ2cuaL8nikQUnzRnpb0KNF/
         e1LWXg6gXoP8xDccrYm5NjH9Cj8wiimmDZ7mEv1GvaQ5dUzGumKGlHwcl5MX5Pnwn1XC
         iPw6m6UQY6GWrDsVwcCbGGw8JN4Sq/qBEyyMOazD08ChQK4Z+P+Z+Wnl9rGOj5AXGqfp
         IX8AxJh8/SDeWcinUZKK+DIaj7wG5XsM7vp1SfnBg9AmkbeEivZrPJ0YHw5yEdpHrpRq
         PvlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvkXAeqyM94cK7O0AQmCmIlHX/IEy5ZyUgiq742IEkng6SATXWSAiVZ2yM2XBafUn7GR790v3rBw7fHFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+C5eNRaSRDTQSNMuLLKxb4+tNWe5Fw3eRPg1RLMmYwwVBlHvZ
	i1PEOqEf0AdZT+eVA1OZSjw4mJy0x5J/rpurxu636Cd6GEKEQ4Fy9qnC
X-Gm-Gg: AR+sD11qtMUjLctp28fRVbvqF3Lk+LdYCJ15HejCUMkt9sJPwDRPrGaJ9gUI7gBVBz2
	VZkns7wYc2941RfJFqrub9ZdXRXpsS/8Vicj7/bQ5s84D6pJuFO3VuzlPLspQ9obntV+WFKX/DK
	9c/BMtgnxeFzRAx8tVvoXsjGtDtyD9kh30UVPtDB4WL6I947DR3XMaS8mo8ifUAfaXn3/VzmNa7
	3lHyuHyoyt8WV7/oxuyR9o2CJICGUWDrKhGR6U5Ug9oS+2PljVlK0GlVKhMMMpJUZ1IzkIo4RgV
	PZuCocRqLFL4XfeXp0sdygr7xo0AJ11AGPcTgSrTUwcI54rcJjefm5de5Ex4uIqjtMx15hANoJj
	BauqGo4rgros+PdFrPotlmOnqdoZk5YC4vutbfAdnCIHLBb77kqc83ptLRXM7hF6txrw9RIpK5c
	JZfmdpMHRmZ0TFThDprcsoiW2b7lZB1H/FEZKqmZhYfi3yHKk9PNQV1Tsv2JjVf02lHe0wluZbF
	q8Za0LBCbjkJxdZIUxSlA7LADOluXaYJ6z1NF4dLxJC5sTAKyJDlg==
X-Received: by 2002:a17:903:324b:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d0ca7fa969mr121691295ad.14.1785962287501;
        Wed, 05 Aug 2026 13:38:07 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:07 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] scsi: storvsc: Remove support for storvsc protocol of old Hyper-V hosts
Date: Wed,  5 Aug 2026 13:37:50 -0700
Message-Id: <20260805203751.2678-6-mhklinux@outlook.com>
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

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older storvsc protocols. Remove the support and associated
special case code. However, support for the protocol for Windows
Server 2012R2 and Win8.1 (protocol version 6.0) is *not* removed
because it is activiely used by HvLite in the paravisor for Azure VMs.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
No changes in v2.

 drivers/scsi/storvsc_drv.c | 53 +++++++-------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 571ea549152b..095fce47c5f1 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -47,9 +47,15 @@
  * V1 RC < 2008/1/31: 1.0
  * V1 RC > 2008/1/31:  2.0
  * Win7: 4.2
- * Win8: 5.1
- * Win8.1: 6.0
- * Win10: 6.2
+ * Win8/WS2012: 5.1
+ * Win8.1/WS2012R2: 6.0 (also for HvLite paravisor in Azure)
+ * Win10/WS2016: 6.2
+ *
+ * Protocol versions earlier than Win8.1 are no longer supported since
+ * Win8.1/WS2012R2 and earlier hosts are no longer supported by Linux.
+ * But protocol version 6.0 is retained since it is used by the HvLite
+ * paravisor in Azure. The #define's for the earlier versions remain
+ * for the historical record.
  */
 
 #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
@@ -218,7 +224,6 @@ struct vmscsi_request {
 static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		VMSTOR_PROTO_VERSION_WIN8,
 };
 
 
@@ -1601,13 +1606,12 @@ static int storvsc_sdev_configure(struct scsi_device *sdevice,
 	sdevice->no_write_same = 1;
 
 	/*
-	 * If the host is WIN8 or WIN8 R2, claim conformance to SPC-3
+	 * If the host is WIN8 R2, claim conformance to SPC-3
 	 * if the device is a MSFT virtual device.  If the host is
 	 * WIN10 or newer, allow write_same.
 	 */
 	if (!strncmp(sdevice->vendor, "Msft", 4)) {
 		switch (vmstor_proto_version) {
-		case VMSTOR_PROTO_VERSION_WIN8:
 		case VMSTOR_PROTO_VERSION_WIN8_1:
 			sdevice->scsi_level = SCSI_SPC_3;
 			break;
@@ -1703,28 +1707,6 @@ static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 	return SCSI_EH_RESET_TIMER;
 }
 
-static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
-{
-	bool allowed = true;
-	u8 scsi_op = scmnd->cmnd[0];
-
-	switch (scsi_op) {
-	/* the host does not handle WRITE_SAME, log accident usage */
-	case WRITE_SAME:
-	/*
-	 * smartd sends this command and the host does not handle
-	 * this. So, don't send it.
-	 */
-	case SET_WINDOW:
-		set_host_byte(scmnd, DID_ERROR);
-		allowed = false;
-		break;
-	default:
-		break;
-	}
-	return allowed;
-}
-
 static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 						struct scsi_cmnd *scmnd)
 {
@@ -1738,21 +1720,6 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 	u32 payload_sz;
 	u32 length;
 
-	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
-		/*
-		 * On legacy hosts filter unimplemented commands.
-		 * Future hosts are expected to correctly handle
-		 * unsupported commands. Furthermore, it is
-		 * possible that some of the currently
-		 * unsupported commands maybe supported in
-		 * future versions of the host.
-		 */
-		if (!storvsc_scsi_cmd_ok(scmnd)) {
-			scsi_done(scmnd);
-			return 0;
-		}
-	}
-
 	/* Setup the cmd request */
 	cmd_request->cmd = scmnd;
 
-- 
2.25.1

