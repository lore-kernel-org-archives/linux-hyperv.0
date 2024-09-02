Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B091AACA;
	Mon,  2 Sep 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257654; cv=none; b=eMmVXGsS24XMb5DbN/a6jiJ0O9S2Ot6polfY3vwKODTT1AiffC/2cDBq5vobymBYFMQ2caWN9tJLbrc8SQoY8dFu1fR/z+6a+oy60Q8jL+ciZWIVr1Xc16X5Tk2bG7+R7KWUxoYeaKQmNTPH0uGhpzQtkT59SLVVtNpxhpTLCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257654; c=relaxed/simple;
	bh=3DAWqnVCfA9f+ulc7JhR2oVaVpHUUinchMrXeR052DU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rryx2xS0ph/Rxn9iFfvTTtgr9e62yrLEuCixNEHahU2MUwEVJ/qUTrqnWJhBCrixUGI34+NRGQ0pGRSMPz/G8HX88Hpk2v9O8XKpSv2r9OBzTIGAzqEQVg3uin0PVdW55TU8wC8TtQHZ0wMVLDMEWT7USxQVhaWKVeRHKE4On7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d557b0805-a0105;
	Mon, 02 Sep 2024 14:14:08 +0800 (CST)
X-RM-TRANSID:2ee166d557b0805-a0105
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566d557af5da-8abab;
	Mon, 02 Sep 2024 14:14:08 +0800 (CST)
X-RM-TRANSID:2ee566d557af5da-8abab
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: hv: rm .*.cmd when make clean
Date: Mon,  2 Sep 2024 12:21:03 +0800
Message-Id: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

rm .*.cmd when make clean

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/hv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 2e60e2c212cd..34ffcec264ab 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \
-- 
2.33.0



