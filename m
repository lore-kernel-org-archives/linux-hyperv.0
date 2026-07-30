Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23933CA4A9
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442318; cv=none; b=tlUM7rC/tY1C5TQjaF1QT+QI1jJImOtjYxAXVKl57SNDN5Dk4L6jt9O9nbN0UxK+O9AcBUwc4Fhkkr8oo/ADnTVDl6DtNlBu4lrV4NKF1u9k/Um4oan6ioEnfpdDGo6sox2sHeMqy5S8AOURV2KBCiE4FapaF9xeQ2woKakV4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442318; c=relaxed/simple;
	bh=ZdvgeoWh2TerW5rE/vqKIpMlNmv0bCF+vIbf9z8+9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSZb3Tk8SyYom/f2wkHE50Ztin99NxuSOnB37vNXrIzcnY76AfH+pk3AU0ENfCvHd2gBwR31RJACGnPSlE79LfA7X9GvPgfjpQtlaluorckNLPmS9kXarGTFBnVYGMaX/HkKE/FhBxVfZXMRIzBJCplcOlMiL/98y4GqiHB5Hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLvLbPlT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLvLbPlT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84861fc51f5so259948b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442306; x=1786047106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=FLvLbPlTZGHeA6IkbXCPJhDPieVDpLmcH2m7gQubPq6BMmoTK/RqhrPaZB7QzafEnf
         3EPIYSnCXuxvlgtjh813EyHxw8dos2Q/2+nzLBnt5T0oiJ8aMcSaovp2xyl/ZvySGsKX
         BFmGPbCgh/tZf7uFYmBpR8SFFQ2st78hX/T63X2d23JzVAxTyT/DK0Jpgjhuj+riyDTu
         9Pdyv3n9iGsPaxKyis0NVhHMuS6ccShpWeu/EGqlKILAsWycedraVQBPikHc7zno+V9m
         wxiHDRu2rb+feGZI3mSX2icOMVa3yAXfTHgyL3ZjiEwifhOYOCkDuzWLe/Y9h/nJZLaT
         4c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442306; x=1786047106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=OfVEkQayO0uWa3gMwZ1jj53Oxlh8f3RlHSPxfSeN8xBERqYLKQtwYA8NqY6GE+60Zz
         UUOxXpDztl5PCwOvQAGxkUxm7pIsbi2yCmhXjAovwCtJETI+k1i/CO4yKs60hIz9Yyar
         t65ketXYDlUkL/UIqoFgcYq38h6Gvc56i8FneCs8F2OD2D0YyRiaFxP4Y/V8eJwbc6uF
         OBsy1eyZJzKSgsp7v3SM6LDEM2ZhzW4IaSesznvZDfExzq0YA82RkWIPAG3EeTxu0i3Z
         Bq7W0O6hGvIlstOQl158IPYefSJ42zMaRzym1WFS80fvl7Iq5bvin2hddKC9Ns+SRjIm
         4iPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXcIbjn3OFC5F4I0rWZBmgnLHvN62MOPvjAbc+XX9BnqZSwNgKxFtuBM9OQjjrYMe+lCWmt2HEIarThZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEzIXzoQBbMXLg5CBbNuSSRLD9xTV/XIAwNFnVKwvBXQ5ZDH9
	3ixsJq8Vd0DIiuotJ40fhZ1hRCP6XbYOeNhhw95+jaWEyxQj0KE0vv6d
X-Gm-Gg: AR+sD13OWlIs1jaxmM03hzUQQy1/goDWm+ZqN53H/TJhoZZYYIBCzvkTZdlAWaRITPq
	Iarxil52BfXtUia+xJ1HWWXubGt9SGn9BYsYBb3eeCpV1BtHLDYFWXu16LQAUdpwIluz+Ri6naQ
	OsJVNvwhY80xjShrhwxEhtXQ0kfcmy46MLYKfDCMQe8t9WwMcvWunC34RR+rCamklUTLMXoWT1b
	EX9skQQNSXrq2i49y8SwpKwvjJmxqRbhn5ZFehdUVYUSIY6Mmc6TPBZGfQ6/htbiNOSQARKJr+4
	T06pAOC7iDMYdTIBIYytNAcGLIsnH+hNSz/AG79eE5gaecXGk0RCdtoKvydoT7Ddav/5TYF+YAo
	f++znQfD8R0luERJyFaW0wVOBQcqx6mawtMlQ+i33zdL6G0lqt39hafwp8POfnnJDVmiS+vGEPM
	3NcfPIaFgUgGcHtuWlzhhkG5QJfy/mFvlqWW3VO+MIc2Inkmvpdlp8Ha/js3AyY4fyMWbKBlBE7
	moCFu2IxswJSgJJWpoWW1DtdKqJW+bgdQ7fImeGbNg=
X-Received: by 2002:a05:6a00:1741:b0:848:5b1e:aec2 with SMTP id d2e1a72fcca58-84ebc3e39b5mr3714867b3a.54.1785442305476;
        Thu, 30 Jul 2026 13:11:45 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH 5/6] scsi: storvsc: Remove support for storvsc protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:22 -0700
Message-Id: <20260730201123.1767-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
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

