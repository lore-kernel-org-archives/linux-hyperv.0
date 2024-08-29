Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693DD4C70;
	Thu, 29 Aug 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899498; cv=none; b=imyamGajWTomHO30r81V5bCOjGqBVaKbGzaKVxa1BFL2v+DpMBHKG1EVfP7d0UYquQrSPVHR42SIWTxnLWJzMkJAd5Fyq/g3PfTcZ5of+xkLNmUBD+spxeF123SfH1qrtE68SFyPuICwIqo9t87HSmAleh3wZ46PFN7dMxr//4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899498; c=relaxed/simple;
	bh=/LX2Aa6CLyktbxFM/+HWrL4NBOZ0cnKwC+kEG81aUjM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nCqetHG8GYJAiUYenz7GqmwFLxb4J+M8EscoBcryIeZTtW4DdnfmMAYqg7L2rUvzKiYe8QYKZp5q3yM86pzBWjhV+DcSQd5AZffL/4U1laOH2KkgXu4KIvwMwuqeuihcTfJoPvJfK5F0oscU0UkGdfBDx6/hdU2VHV+EfwY4NvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966cfe0a0775-b7778;
	Thu, 29 Aug 2024 10:44:50 +0800 (CST)
X-RM-TRANSID:2ee966cfe0a0775-b7778
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566cfe09f470-87f47;
	Thu, 29 Aug 2024 10:44:50 +0800 (CST)
X-RM-TRANSID:2ee566cfe09f470-87f47
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] tools/hv: Add memory allocation check in hv_fcopy_start
Date: Wed, 28 Aug 2024 19:44:46 -0700
Message-Id: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Added error handling for memory allocation failures
of file_name and path_name.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
v1->v2:
	Add cleanup memory

 tools/hv/hv_fcopy_uio_daemon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f97..0af47d88a377 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -296,6 +296,18 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 	file_name = (char *)malloc(file_size * sizeof(char));
 	path_name = (char *)malloc(path_size * sizeof(char));
 
+    if (!file_name) {
+        free(file_name);
+        syslog(LOG_ERR, "Can't allocate file_name memory!");
+        exit(EXIT_FAILURE);
+    }
+
+    if (!path_name) {
+        free(path_name);
+        syslog(LOG_ERR, "Can't allocate path_name memory!");
+        exit(EXIT_FAILURE);
+    }
+
 	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
 	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
 
-- 
2.17.1



