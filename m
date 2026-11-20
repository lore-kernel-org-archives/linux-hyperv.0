Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173105;
	b=GlZQfktRQX5vKiYj3SmYZEtlrhfIrwaCTloOCUn9J/yqmMfBqQHuEAAnjdOLrviBjVoi
	 W1f/9eKvu9jHA4UyNIU2chYlIoWF81l5TDTYthHKONgu1Y+3Z/G4R9c/P7rgJ9wyj/Deo
	 4s5Qt1giwRshkkiA1Z5trPVtJwWZi8ZQNNHzUF+nqlYXFThR+vmC9sm6SmTXL0pfg+Jhe
	 DOpkxWRhmcnUDdWVgDSYbW0TWU1isEuQ1huUYdkwH2mzEqtRCn23xhx+7+IJDtOX0tQSh
	 oG4kfLaRwW+vhwgPtabq1IcMK9QWR9zVj0H89FmkqLpus0X1pyiuos1co72X6yvOuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
	b=FZIluqwtAUSj7+eQNsCy6Ke1JPYcpqXOYgQXKLWSNfHceIKu24fz6jYPQTccExW138G+
	 WIdya4fntqmboj0tXzyhx6cxWepw0ljMf5OS5qXGToRUVpPX91gJd0i0MVYXsd4G3Obks
	 ECeObfz0XwfmxaO+84tMAo0b7zbdhgv2Lii8WsyXqQC5YVsU2r81PsrkWd4X1nXng7KqB
	 FqFtR8yVRDYDEFL+csveE+q3HTOSbRheYW8bHaVCL+tkNqTh5OzrAcicb768hoF/ghBS3
	 FtrcTjJi/nXE4bi0CQ9RpStlt/ZH/HA4pSokY1iZZwbGHnX4vSnYFoHFg9HpvOZYEng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aDWBOkEZ;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EC60A3804
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Nov 2026 11:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698EC60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aDWBOkEZ
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a32576da88so404168f8f.3
        for <linux-hyperv@vger.kernel.org>; Fri, 20 Nov 2026 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173101; x=1795777901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
        b=aDWBOkEZ4qQRUHVhnFnZXjz6gFJEBlNyEyOoHl3cV5UW6Rq7wSX+1fES1TXbs+3IN+
         IAKYtLt20bq7t70W79xhmgxqItOqQijVxo5iyutKZ8jQe1SJ0c8ax6LFcFKQD4/pFVW4
         Scvf+gg55pm8RdsI6l503C/MgY7Jt/K0LEifX++rJZPpsAb41pguop94McXiGc1R57jR
         FWm0KPgHb8+GbMuAMQaM6CEjHnVaWvkGjKpL0Zwmz+m1lkmBwIH1hVaHU8FL9W489041
         MhdVrJqCpXT0gVwTihwed9HE5FTyyCmxQAMbMtU/vnweUAG4HMgIO82NKmvfP5w5TadQ
         9Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173101; x=1795777901;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
        b=oy75QvLpdujIv8KJT0mFUVcWO3+3fNZrn6PK8ExfOFwy8bcKXE1z4POQ2A+eH1l24n
         gnd25psnO3wmP7xwrgfU/grcdkJniFytqio6HWvMynMfYM77wDaufPi6fSPBhlajY+0T
         RQ48XRC0C15ncyVuOv8XE5KmDus+A9qv4vSmKtzKVXOfF9daDSwWvzgsQ2AYK51J8IkD
         F0yYzYKq+wErHtih7MJLpxTA9mUEtefCCYZpscFp5EwX2yUpNccpqKSCTd19dBvfT6pB
         pFK3KeR6ShOdGx9n+n1jHjeop4k6/6gUEPN0qhm4oLSj92+aRv/JR68CDljAhzYZP4EC
         vGow==
X-Forwarded-Encrypted: i=1; AL+hErGCOPB7DxjgWfgxuEtQQA6mavSOjEViurtJ1o0QCYBC9hOBINk8KfUEKLV0T4sRGXRJbM7d3LqT3OHq8pA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XoqYVu77i132YDqMBED/efZkUA1b3qt9Te7P7mv6u9y84NgXj
	qsCHO8FuiNp9LzKdWxXfbgOI+74qtqfFh1YSyR9t1g1+T2w2VnHZiRGd3nExLMv1HB8=
X-Gm-Gg: AYBFou02ULqngVjkPGOgfuLnUw7N7jL8dkmasO7vyJOhpnblZVARxIXsmOPwKl6pzfM
	17t+CCeXpgEf476dRv1WXIkz5K/2nEHZAtPXUGVJ+fR1J8yOBwunVrlOjYot2YJitd7Fppy3qu7
	biEeE4OEU7S7qtnAv8XKbZaHUDrRj8J+PuE4r6AHr5bXDIsvVQRG1LMTZWdGItQq+GPusUUmmC1
	1q6Y06UnfVUWy1bNDoUfk1B3aK1783SvB+/oDTyq396Y19X221xNeFl+lqEmiAgdFpv+016cK6R
	Fc5AgsVok+3wv5jBcO3NKMzyuXKkfzleorl0ShV/rp9XEwbyA9zKCVtEokR0OVh6NSFeH7ZOtuS
	YEg0h1Y2SFoLzwxUThlOgcP9JDqMRykVw/LPBXKPG30s96N8uAD3lRGYR1Uomjo9sKwtMk45mFA
	gjIUYDVhEM+T57i6sQfi37cf0LHGPrwzwt+/3v0tcB/ItM7rgJIXRlwVenkfaVywYXDbnm8kPpk
	ZfVouy6gUih20urLjHEe6wi9Ohrq/p9F6uIPmQJ9bEHgWRI9eTxHqVnJWEjc3j36+l51GJ5pSp5
	fRv291orKTEzFyGc3/Yh5srG2/m9IYPjQZJmprVCYBG4d8K9+Mdt5K5rYAhnPo9BeYO+158M5LR
	aE2k0rwwcH+Y/+dQ6
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb88826810mr53126695e9.11.1795173100811;
        Fri, 20 Nov 2026 03:11:40 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88f148aasm25552865e9.0.2026.11.20.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 05/10] uio: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:06 +0100
Message-ID:  <190f97fdc22c161c4721283a2beb20bb477f9e56.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iCUi/7tI/zgEkK4zQSmtLg1qQ9fsMtrvvDC7LGhhuns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrTI/ZTGZ5YUYLg+hewc2YLCRqh9DJjAObYH uU0wg5v0smJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAq0wAKCRCPgPtYfRL+ TikhB/91CrSUe0WLbAkxv/SKrwgCyHDlQP/ZyGjOoKNTEMIEV/ql4vVu9pMRDw6sHcxLfLYl9/H rIhWYQ2bf49lE1MoG/fCG8BD04CU82cvNj1qID0PlF/Y4W+6ls38K4tyflWGBfZZCxxirnW1QIx zDiWB3NW2veRL+r6Zka116LLr88v2PKOy+HsvWogO22SrxIOs5BSmfVn8KULg/MKVGAhYDycSw8 AS06RrlsL86KNGd9D7fKdhyZUZZO0KGGt0MVBMMh2ER7V0705/JMbK1cCtVwsDJy2s45E3HrNS2 69fihF7+EhGPXckf0p8NlRnPsHwNsOhRYJu6IMPJTGIT5tYw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

uio drivers support being matched to devices using the driver_override
mechanism. Add .support_driver_override = true to continue having
this mechanism work for them without tainting the kernel.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/uio/uio_dmem_genirq.c | 1 +
 drivers/uio/uio_hv_generic.c  | 1 +
 drivers/uio/uio_pci_generic.c | 1 +
 drivers/uio/uio_pdrv_genirq.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 263c1ebc2d57..71992431770e 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -309,6 +309,7 @@ static struct platform_driver uio_dmem_genirq = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(uio_of_genirq_match),
+		.support_driver_override = true,
 	},
 };
 
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index dff92dcbb10d..255c2b5730f6 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -407,6 +407,7 @@ static struct hv_driver hv_uio_drv = {
 	.id_table = hv_uio_id_table,
 	.probe = hv_uio_probe,
 	.remove = hv_uio_remove,
+	.driver.support_driver_override = true,
 };
 
 static int __init
diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index c0cab3adb7b0..9785df9fc5de 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -140,6 +140,7 @@ static struct pci_driver uio_pci_driver = {
 	.name = "uio_pci_generic",
 	.id_table = NULL, /* only dynamic id's */
 	.probe = probe,
+	.driver.support_driver_override = true,
 };
 
 module_pci_driver(uio_pci_driver);
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 87e43821ab0c..022178248962 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -261,6 +261,7 @@ static struct platform_driver uio_pdrv_genirq = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(uio_of_genirq_match),
+		.support_driver_override = true,
 	},
 };
 
-- 
2.56.0.rc1

