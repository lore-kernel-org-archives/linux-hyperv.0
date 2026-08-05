Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BB385D78
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939880; cv=none; b=MGhgy/ipboa0+YLK2OhJYQpfcs8Xavl04QKA6BRSj3EO/ICtjLi8PJ5GSzQFAT/eKCv23N6GF/E/YmFkJnXawvkNfLOvTtdQctgdBurOrBzWzW46tFzk0cWr94I9YVzSrA3Pwz2M0e8y8ezGuLj2ciEnOY8mxz98g5zkllyt4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939880; c=relaxed/simple;
	bh=CEc8FLPBIATMEsq8wpJPMPDmSCwONIh/JPkgFIFbI8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BFFAwbFLLOH+S4n3FzjGOuPTEtai2OVS8rOCmBhEXmELR0/aIu8gUsvafb7v/DBGAeTC7xtX7KBkaiMDZFEuAPkOckdkl2P7z/ASo7lexI56JySunK+Qf3JJMahSjiPJ1OSKS7be+Hm+PIax0AqJAhq+APFJhUnGU5cAKWf/z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC+s1C11; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC+s1C11"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cca0c5799eso10186855ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939872; x=1786544672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wi22wu2w+8tiE/VeZIOwvf7Sfv8deH0UxzWDUHGi4e8=;
        b=IC+s1C11cVoWceLFXFTYsunqdh1kiMqSwg8pv5VRUdeXi1UZTZ7IAvR+DkjIrVySvA
         FNZmWRZEr5ljYaBYdvYVDu1u1qrcx4lfdo+MI/O1t5hZJ0ADFoRjR7vscKATAi723QTG
         AgikOPEpz9nuxE4dhMhvTsISKg0QcCKvhtppgF2zhfRvV21KVwj5aFIAqiLLwTBfaDnM
         tJSlFP0KIZxxyoNwvoBt8FuHDPkVUM3flB405h9OqFrDsY0f7qP60OOAMD+me8fJBz7V
         e0Ww59ap6e34suMyyZxIbD4jvtFFx37M8P+CGVrUPtaWCO/U+pb+NYfQvogw7Jy/bR+p
         l48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939872; x=1786544672;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wi22wu2w+8tiE/VeZIOwvf7Sfv8deH0UxzWDUHGi4e8=;
        b=gyKYyqL8PgnQgZWlc2ebVMpw7T0dFCqaBvm/WIzu16Dh6u5SneAhRTpvZoBRRR44WD
         59/yUp5uziMD/Vld4p+zA+ofyf+ogrF53OZ5X9DYM/qOBaKiRh4cCD9i28k/1azTwOIq
         8aNDGPj1rzIgPPdiRJLKHKNW3tlf4ki9w2+2Tq222gkTnvgiZ63XFMnNq07PLdJDMQv5
         8RDLkYLe6bIg4dUhiyGv1bMji8UTU/66MDaPD+pnkhL3WqQilEeeREC69AOpo/cwidNy
         d4ifBwsPrg5T6A3uJqxUB5iu3TzMVH6CuCIc4oOTlXzROCOCY2xubNj/ZM6dpc+1pSsH
         EbHA==
X-Forwarded-Encrypted: i=1; AHgh+RqLkdSvwI/kCWRjWZa5zdQjnJRrMwwAsZm98S+2yaQQfe8ZcdYBQGz03HWehbkVxCl5FVvpcp4fbsuo5Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySmu7g6ui0dJlCB6PmfUje5zbHcFTWxT6gqZa9VnLV3NXJmCI
	S6bGCYS/YpPQDnbd3yBcaIIPizPqNOna9YAT/btgX0W+4Dt22Gx8HNem
X-Gm-Gg: AR+sD11xg1iXan9z2XhzYt8qFRlnvkM1pcigdH8kq1RcBN6mtEK2T2RoPp7F1EV7PYK
	LcahwJYL3h2u2Fogpqb9ef3TzHzJVmrv/5xAHQAMltceGsmU/VG49YfKoMLd8TZpNmLvY0PsBeu
	wvZNMq9NZ3sp5udS88LPpf6uwYS0xkPTOSaiWy89qjlMtj2ak04Nw6Vu6kutfQStnTyNk7kOpWY
	fZepSsVOvc44K9fxxXxJ2GQYQjlbmvso6lJ94pwIT+PhF6AfTEjRLah344PNk9BL8e1RAEHI4e+
	g8z9o+C2bFt0SsDvuPAeOXmjqaYRS2vzshNsuqh+Or0pNqxBL91OFHGsmDlx4bFo5O84v1uGvXL
	x44KyeXsUY4wVEbzopTv7vrNlomNcD26+jh6h6+PTEFYE3HaaXWrUCvbwGdU9jBHae1xwNUQkqX
	rJ1gIRrzCYxL1WpMsJMp8g3NQOs7eyuQSsIZoknfK97QNU45nT7l1cjHmMUk7LRNEBTpcwjcvj9
	mh4cEqZE6Tk3jGfCNNRdndYMGshygmfp8KBFPBB2I3qahPxIUDFb+E=
X-Received: by 2002:a17:902:e542:b0:2c9:c991:6ed3 with SMTP id d9443c01a7336-2d0ca7fbb60mr74436655ad.12.1785939871674;
        Wed, 05 Aug 2026 07:24:31 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa00f8a2sm18513465ad.32.2026.08.05.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:31 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition
Date: Wed,  5 Aug 2026 07:24:21 -0700
Message-Id: <20260805142421.104797-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMBus module initialization function, hv_acpi_init(), currently
does nothing when running in the root partition and root is not nested
in another VM. But the initialization function reports success, so the
VMBus module is indeed loaded. VMBus functionality is not actually
needed, but the VMBus module must be loaded so that hv_vmbus_exists()
can answer correctly. Furthermore, the mshv_root dependency on the
VMBus module is needed as described in the commit message for
840b740a35bf ("mshv: Add conditional VMBus dependency").

Loading the VMBus module without actually initializing it causes
failures if the module should later be unloaded. The module unload code
tries to clean up things that were never initialized, resulting in
memory faults and a panic.

Fix this by having VMBus module exit function perform the same
check for non-nested root partition, and do nothing in such a
case, just like hv_acpi_init().

In the long run, the code that manages the Hyper-V provided SynIC
should be refactored to better coordinate the requirements of
root partition scenarios and normal VM scenarios, and to hopefully
remove the hv_vmbus_exists() dependnecy between mshv_root and
VMBus modules. Preventing the current unload failure scenario is
an expediency until such a refactoring is done.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
v1: https://lore.kernel.org/linux-hyperv/20260804190517.101981-1-mhklinux@outlook.com/

Changes in v2:
* Use a different solution: Allow the VMBus module to load but have the
  unload function do nothing for non-nested root
* Change the patch Subject and commit message to reflect the new approach

 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e19ec73b0187..f837153427f4 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -3024,6 +3024,9 @@ static void __exit vmbus_exit(void)
 {
 	int cpu;
 
+	if (hv_root_partition() && !hv_nested)
+		return;
+
 	unregister_syscore(&hv_synic_syscore);
 
 	hv_remove_kexec_handler();
-- 
2.25.1

