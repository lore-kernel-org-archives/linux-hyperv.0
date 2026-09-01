Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6C39E18E
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234324; cv=none; b=mUpOEhSVR2kX3K2Ksl+hB+Ncc+xqupOIfWBM+hZUTqtRw7H8ZyqhKL4cLwqO/KKjSPyedVaoA65wqMuGwTHgvf7BQSPj2s7cj8sOHG8XcNx71bhc2G9qUEr4T2/2x3HGlaNplWeTkj8O3KPW8atk6hTnmYCREWZdzpL36m1A6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234324; c=relaxed/simple;
	bh=k0EgHSBZ67xrXqBHCWWygsrB9CHbdTlyhPuetNdyA6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eHzA5najoIoXHIkv9yRNZ9eBkx8MMK34/5qKUHuU4rwBlo0pY0sRahJbKUC09QDZheBeAHeN1xbXay3DhGtZdB5yY0mBMCd3kyF8v27FcZIVLPKaJ5uZ6CJTTM5RWR05wyGoJMQ9qIPF9EUe8E78Ti0AoHedweuXH0IqARfuSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDMmDPZz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDMmDPZz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6e954afbdso2313965ad.2
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788234322; x=1788839122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZaQTPZCBX65twnVoRmMEPBMoXrLHKwaCW1qQEkDk8k=;
        b=NDMmDPZzhy7hPeLf7lycTu/rP0yqY6OJsJNFQdlQDkPFQ0KNvalzQXwZmg5mzPb1SR
         O22Q5GGCMW8OTI8edrSWC+vBfrLMw5zMJzIeZRkD96ntnfYFRE6CdKa2W/3vG9yuetEW
         YZYaVJbTDa8nQh78vIlJwN/fFruLNj0Tv5NBO0z1B4rEhlrGgVXkgBDkJmPKZ4LEaen4
         EtnEZitIvVWsYJe0FN5tiNFyEnz2bHxjxBunhQ6wq0OZsjAsZpMYNIwdqqcw1jLFDOtS
         DOdBkwjGHWCiDtpx7nP7MSVFZ8UCPwrKajeVtxhjbpnOHo+7aE6tqJRwFltDeu+s+19b
         C8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788234322; x=1788839122;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZaQTPZCBX65twnVoRmMEPBMoXrLHKwaCW1qQEkDk8k=;
        b=lEgScck6Yz8p+DP0JcAiI2YqOTpGHkRcerOwjj0tiZQO4/zRYpGP9iyeDoLr7lV+r5
         BcAFWgOH45OJ/fSCpGXxUMNEv6P6F4GKON6SsT3ItzUG1yA0IGhEP/F5Fr/iGRfORqX+
         FW2FqlGsk7ftDqfvjx7VLeoHcZHQ5TONLYN1IL/NBmlXbRq+WbQvYiwIaRxDjWJu2mZf
         +w8iH1304pjIjA8JP0hZUicbkjadvVoFeyqLeoNsMnMoacNBmMW/j7O9OubZ2a1lgapn
         ke2zPsJ6DezTT1d2vMW/6fdvD3jHycpfPWk9w/rgEwYB1OIKXzMW0amtDshNnscKZ0su
         wVnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/9dejlBryWR3JK8+sFmM3f3m4GHaq87b4ZR9VrtxXIeAIvdUFbWVWEBB7nEEP/iSKfINth5Y/oqBXBU8=@vger.kernel.org
X-Gm-Message-State: AFuF++ljyitRhFxovk7RXGjsl5R0CIaF6E3F94xfuggwqaf9C/b7L8ew
	jjsC/KT2P4uFIeJ+Ohet5pcDvhDx7tZYcqSuBiUOmZ9LarkmTjvG+9FC
X-Gm-Gg: AYBFou22sQe7W5obj4Rq0fhQwuo5CKdwsegj+rj1gG3KLhfH1mBgPymadg3kTG6Grww
	mvPUYmK41YwFcGj0X1HO2KUzeT3sYDljmIiYF+PMX9Osp6RLopWeaJms8qRr3LXrlR91UIncGVv
	XsFxy/GJSVFoXPMtbyZ7vMQItOMHt4385SBktqyKt/1SV75/lVggR0Gb4cX26nqDiquoJetWmMB
	Eh+SvHxAar1iMHqWqvBTSo+Fn/Dnj2BGzH8Ni07npX//JQqW3NNyf5jW2nn3nfHMJYA58i/LTw2
	dE9A/6ExDRSoHmwxb+Tuq+7Tvwq4NPNkTwOSzBa/0GY9gap8xotS6ojWRbqFXDQoC2ZNtglJv30
	jGQ9sb0SObNO7znmsWx0vpAfbuRCdo1d8fvKva8/0EEoD3I3UTQdkXCFRfmq7lfZO5+QakTfdqn
	LXucmm2DAD9xmNEROWmW/WLynOdC3xJrtyJ1Ql46gcDxX2BnR1oat7c2hwIYfe+iMt2fV/GSO17
	OMrKTpbF3inJpwxfw0YBnAnuq1Rk1Wdd5nmjySmgOc=
X-Received: by 2002:a17:902:da8d:b0:2d6:8d4a:3ff7 with SMTP id d9443c01a7336-2d74e11c367mr435643785ad.12.1788234321861;
        Mon, 31 Aug 2026 20:45:21 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75963fc5csm43427605ad.33.2026.08.31.20.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:45:21 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Don't reset VMBus connection state on error/exit paths
Date: Mon, 31 Aug 2026 20:45:14 -0700
Message-Id: <20260901034514.457089-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In two places, current code forces vmbus_connection.conn_state to
DISCONNECTED prior to calling vmbus_disconnect(). But vmbus_disconnect()
calls vmbus_initiate_unload(), which unloads the VMBus connection
only if the conn_state is CONNECTED. Consequently, the connection
remains and the Hyper-V host might continue to send messages or post
VMBus interrupts.

The problem was introduced in commit 74347a99e73ae ("x86/Hyper-V:
Unload vmbus channel in hv panic callback"), in that
vmbus_initiate_unload() started checking the current connection
state before doing the unload. This commit removed some occurrences
where conn_state was forced to DISCONNECTED, but these two remained,
apparently due to an oversight at the time.

Fix this by not forcing conn_state to DISCONNECTED during VMBus exit,
or if a failure occurs when establishing the connection in the first
place. Whatever value conn_state has at the time is then read by
vmbus_initiate_unload() to determine if there is a connection to
be unloaded.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260805205806.B5AC31F000E9@smtp.kernel.org/
Fixes: 74347a99e73ae ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/connection.c | 1 -
 drivers/hv/vmbus_drv.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 1ab3581b096a..818667ef9c74 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -346,7 +346,6 @@ int vmbus_connect(void)
 cleanup:
 	pr_err("Unable to connect to host\n");
 
-	vmbus_connection.conn_state = DISCONNECTED;
 	vmbus_disconnect();
 
 	kfree(msginfo);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5ebdbe24b5a1..547bc731114f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -3043,7 +3043,6 @@ static void __exit vmbus_exit(void)
 
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
-	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	if (vmbus_irq == -1)
-- 
2.25.1

