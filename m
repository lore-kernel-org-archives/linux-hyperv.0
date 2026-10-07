Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E13FF886
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400119; cv=none; b=EAAVRDp3jKfCKXVLQG1xx7pIdc5aGzIbYd4a8SwwF8xsadPm8vwnRZL3H4aZvCXY89Ff/4J1hy+w5DRCigINVxeAByDv5Rqe92yWecY53DtmJCoUzebte9Y87qA2uKp/jplkUPL/0duQBhueiLO7cKFRP4L9zGNoRpxTzMbdCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400119; c=relaxed/simple;
	bh=T9n2DMbAcbZKwsbfxwnQrsq7TOFHW90UQz8k7zQjIuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsfCylgkmJdvhMOeM8DTquB0+aUb1laLtXA4ono0H59PR60x+iZXSJVZDZRCL+51PZompgd07PrqTJXkWWcCCuUZcuomvD8zoavI1ny0cKyU7ueiGmjJMkhL5J2/hVsLMmk4WIIvzTQdn+ccDW9RwauwGlhUk7awFw2SFRpd0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsHJnq1P; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsHJnq1P"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7ca917f9f52so357001137.1
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400117; x=1792004917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuo128+PEgN2LdloLyCW+rm1ZOlHKjsDDFXJ4dq206w=;
        b=lsHJnq1PuO3zs+AFiT+QxjQIcQavLnshGh1mblVGz8jvc6WeGPnwaROtiROeNNnt+f
         e57C4iEYrSHrmjHV4ul38jrzFFJyM1D/6k/IZLqWuzYpm6zuZ7fr9D7bvT+a8X/Ncn/l
         t2MWp79vZURpapiEXUNaoy8PbouI7HgRLJKamOBk0ncc0ShvAG7y7hpCjjem5xXPX2hL
         fRGxwDqoH5ULsvpYHCwp04v21kQiAjK5OqM+m1dGmRLjoWFomSbge9hsi/9DMS0kaxcu
         ukMB4PpSJKi2uCd2uYLflTv4aDZ4RWSdJusN5D0zacKI7XNa+HA6EcnqgcOBv3qXlhRp
         lbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400117; x=1792004917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuo128+PEgN2LdloLyCW+rm1ZOlHKjsDDFXJ4dq206w=;
        b=iqqKy4xYYVTDOZjVnb6RBsynVP+qrdV46P+jhiOMSS/nB2e5RnNvNaNX+27n8MpgEN
         s0pNk8X5Po8p+4fnUEuH9hLax30/PskX8MaNYP3t9woiENwaBS4l5MF3WNVDtfL84utb
         3tvAd24oXWL2ELu61QilcDMhhHb0s30Tll196n52NWmewlK7trfh6H9nHPu82Eb6thvf
         ah3XBcOYJsa/Ydma1AVyJvr6PlNVGEO1ipBkkwDTBBpdEEpnGQhJJmhEtHahn+rW7FZP
         LoMYO4lJE2II8r6SHYyuqCGGHHcD/N9nKdnAdsSGmkWmcJ+Dv8W7vX0zjWX1jni0b0Iv
         RflA==
X-Forwarded-Encrypted: i=1; AKwUvBynNwjI8L0YwaJ1oL1LjLAE2FKCMAmXmvDpriBm9JBrWI1aHWHQmSba0oLdhQzAbddzzX5WiUHFq/a0t7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPwRGeUCzKCb6n5fHlVx9QjwQr1xDGcKD4hyicdqNlW1pq9EID
	KIiai6U71mCcfZFu7SRntQLutAhsRpETyjxI05FWZY2hTwubLUcfnSKI
X-Gm-Gg: AYBFou1hzX6e2X9umOVH8rL5wUkMrzpLQeynYA+/YoUbiNaYC4AjYAFry4shRYjz3/u
	tyy+R7Ai+/01oKQVjrhxjs1b3RKV2oLe24DqkobgGgFPHKOiSwhM8mz/5rDVQF/NZo2llwyq2/0
	Z9dekdlUdMwp3JNY63tmkzSZqOpoBQnyJ5g9AA1Ct54JrngZjo4a7eQXiDIJwzndFCuM+u27JqM
	LYfR/W4RGATIksaWq6F05HFnldo15P42qfPR/9JLp4Yi3kk6+iUAEeeHH55awhZKSK397cF7bRA
	jwZmOX6n+ZwtPrwi/O162/j112sFqR0EnsN2PfN4l9snSWExB7biWMARAkzsEvDwNrcPKGOBWPv
	jvrLwndrG6WdwNDis1P5zIF7c/D0UPD4UaJrntKRu8V7TjOke+yMAA31wCCAMAQARY0sd/ZUVwf
	np50zmJbGtmp/ToD31Kqk5Q84GAafNj0iB7sueQvnWpv9/1YyV2dCMeVggJbGk+EBpIDDCDmUJp
	hHTNp8XP7sFEPRglqc=
X-Received: by 2002:a05:6102:1492:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7ca355c2b2fmr979882137.0.1791400117578;
        Wed, 07 Oct 2026 12:08:37 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:36 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 06/14] hv: vmbus: cover all shared-page policy combinations
Date: Wed,  7 Oct 2026 16:07:44 -0300
Message-ID: <20261007190752.336426-7-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Name the shared-page selection and enumerate all eight combinations of
Hyper-V isolation, independent guest-memory encryption and channel
confidentiality. Either platform visibility signal selects shared
backing; the confidential-channel override keeps private backing. These
are decision tests, not confidential hardware qualification.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c           | 16 ++++++++++++++--
 drivers/hv/hyperv_vmbus.h      |  2 ++
 drivers/hv/vmbus_buffer_test.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 0c025a12808a..8ed155f2669f 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -45,6 +45,13 @@ int vmbus_buffer_round_size(u32 size, u32 *rounded_size)
 	return 0;
 }
 
+bool
+vmbus_needs_shared_pages(bool hv_isolation, bool guest_mem_encrypted,
+			 bool confidential)
+{
+	return !confidential && (hv_isolation || guest_mem_encrypted);
+}
+
 unsigned int vmbus_buffer_order(unsigned long remaining,
 				unsigned int max_order)
 {
@@ -837,6 +844,8 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	unsigned long nr_pages;
 	unsigned long remaining;
 	unsigned long page_idx = 0;
+	bool hv_isolation;
+	bool guest_mem_encrypted;
 	struct page **chunks = NULL;
 	struct page **pages = NULL;
 	unsigned int order = MAX_PAGE_ORDER;
@@ -853,9 +862,12 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	nr_pages = rounded_size >> PAGE_SHIFT;
 	remaining = nr_pages;
 
+	hv_isolation = hv_is_isolation_supported();
+	guest_mem_encrypted = cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
 	/* If the buffer does not need to be decrypted, just use vzalloc() */
-	if ((!hv_is_isolation_supported() &&
-	     !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) || confidential)
+	if (!vmbus_needs_shared_pages(hv_isolation, guest_mem_encrypted,
+				      confidential))
 		return vzalloc(rounded_size);
 
 	/* Worst case: every chunk is a single page. */
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index e08c472041d5..06094000f2f1 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -557,6 +557,8 @@ int hv_remove_ring_sysfs(struct vmbus_channel *channel);
  * These are shared with vmbus_buffer_test.c, which is built into the
  * hv_vmbus object alongside channel.c. They stay unexported.
  */
+bool vmbus_needs_shared_pages(bool hv_isolation, bool guest_mem_encrypted,
+			      bool confidential);
 int vmbus_buffer_round_size(u32 size, u32 *rounded_size);
 unsigned int vmbus_buffer_order(unsigned long remaining,
 				unsigned int max_order);
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
index 60fc526af1af..9b401ef2ceea 100644
--- a/drivers/hv/vmbus_buffer_test.c
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -38,6 +38,34 @@ static void vmbus_buffer_size_overflow_test(struct kunit *test)
 			(u32)(U32_MAX - PAGE_SIZE + 1));
 }
 
+static void vmbus_buffer_private_shared_selection_test(struct kunit *test)
+{
+	static const struct {
+		bool isolation;
+		bool encrypted;
+		bool confidential;
+		bool shared;
+	} cases[] = {
+		{ false, false, false, false },
+		{ false, false, true, false },
+		{ false, true, false, true },
+		{ false, true, true, false },
+		{ true, false, false, true },
+		{ true, false, true, false },
+		{ true, true, false, true },
+		{ true, true, true, false },
+	};
+	unsigned int i;
+
+	/* Either platform signal requires visibility; confidential stays private. */
+	for (i = 0; i < ARRAY_SIZE(cases); i++)
+		KUNIT_EXPECT_EQ(test,
+				vmbus_needs_shared_pages(cases[i].isolation,
+							 cases[i].encrypted,
+							 cases[i].confidential),
+				cases[i].shared);
+}
+
 static void vmbus_ring_fallback_order_zero_test(struct kunit *test)
 {
 	unsigned int order;
@@ -317,6 +345,7 @@ static void vmbus_buffer_order_zero_allocation_test(struct kunit *test)
 static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_buffer_size_rounding_test),
 	KUNIT_CASE(vmbus_buffer_size_overflow_test),
+	KUNIT_CASE(vmbus_buffer_private_shared_selection_test),
 	KUNIT_CASE(vmbus_ring_fallback_order_zero_test),
 	KUNIT_CASE(vmbus_buffer_failed_teardown_leaks_test),
 	KUNIT_CASE(vmbus_buffer_partial_allocation_cleanup_test),
-- 
2.43.0

