Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C547F784
	for <linux-hyperv@vger.kernel.org>; Sat, 17 Oct 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246541; cv=none; b=Nnu80kx5Cs1E3Kn9aeVwWQ0DRDhH/oSvXR9h2lLFVLmrhD1qa2KeymI6uf0dsiOpmwrHpNPyW5griby+A5+e06BJahg2TJOhsRpE3kmYBIaTA9KxfpfDOC3vZXYmgglIef8rDkM6H7yxu/hQlqlF9OdQ31CwlgNlrKZ7KEl1GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246541; c=relaxed/simple;
	bh=uIwc3JfVPiUNtfTlvP2owlQjEF1XVRi8hcV46UVHY1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M44ET2ZioklyeqDvdNzhtg9xkU7e2Wlp4INmf58mlXssyn6/nqbfSuInaNfrTYXPcA43I+ENxQMeRUPoZpmW4GPFoWLrQ/DruN/EqmuZAvKoAptJcokfibdRMwA3MjmxQY3FfdASA02ZsmTJmOWaM+fLdqOpNh7Z7nGe9xK09VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxYvmNwt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxYvmNwt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso641199a91.1
        for <linux-hyperv@vger.kernel.org>; Sat, 17 Oct 2026 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792246539; x=1792851339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnA3VMBB1IhUUOmUvzPAdGg7gVxpW4JiO55uuDXxAdc=;
        b=pxYvmNwtsQgupEwCnuhVrpsqmUvFQyV/JZyJqLiazGf6l0WL3ssdIBFoZv+FQpZdDT
         kjHUknJJTMzMPR3D1Ox6t8uoc/pNLI/ldsFE+QYJFjQilSYds5PRzpRTmxX/RSfLFi+n
         SX9yKOe7N4m0+MgIsKfbQzUz2kBQJCSnMeYUbp9VF56MM/6PAggKAa55jh69VYSo5q4O
         hDMZLmRXIjzfTuDbVjdqYchK6ZDEAVLfYeBRzqjUiwrcARtP8xVvYhxnIOaONFzDI9WD
         xnSRNozzSo8Xk7XjJbxMaeWS1Ueil9F6g8+o/ZQqPHKNMdxfajq2Fj8PueGNay/lgHT0
         xVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246539; x=1792851339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnA3VMBB1IhUUOmUvzPAdGg7gVxpW4JiO55uuDXxAdc=;
        b=BOK0gdcMuw9HlMBMVX83pW+l6UKJoRuWyovqnqkR0N7+Y+67pk0vFz/erpG3iZKnXh
         LYCeJYkgW/XWWrCZbIsuzkA/9O8XYHNH16y3Oq7YeU3THSo/XUb8nRa7F0kxFPM6C7H0
         EMfPE9DoPqv3yPH6W4obmdUZd8dncFJ90MRXv+WPhh5ZYBfVjIAWGZ3FfoVrmZJoKD5g
         bDndED94G89HyIqWPXpxfZXY0ySP1VrObeeif5NUyvM5Myv9w3mNMN6wE35i1VBQro6J
         MKGG1DR/U/AMV37A/+foLxJdLdlDJb4UqM2rfx0aXvPE+d4xUxe2ZHk+1W+VORHk3hoM
         KtIA==
X-Forwarded-Encrypted: i=1; AKwUvBz5bXsh0n7OrTD3MZYCP98E1KRfrHKESYy+GnqrOqpBsknlSzQKJDj/rRGPeEPgtv99YYN4MAs4UfEwMoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlLgDDjp34lwddxfY0zYqd8Szk+r3spC2LL5JGUBmQNLUaOoAU
	ihGhlLiKoHZJ/GgKfl4/8otfQA+jfT+F0gL37+rqxW8TEuWG+Ouazyve
X-Gm-Gg: AYBFou01zCxIxwqs5WTUeYj3S3YRoRTHLBkqAalMcLQ4bKd5sKokQPHtn01OIg6+Sld
	K221mLA0Pz/GKh3zcGq33NGvvOoUDYfdug8yaAc1hpLduOQZ8LEwi/BOEPwurVbgpgaDyLrDq2/
	xCsr55xXj7PNBzE2Z7d9C0jUtXOOaHsn5FrAmmR3viGqa0NbrGAhnDoaBl0DN7L7VFes3gTOleL
	Q7eiz5RAQXtcw84Cfn1UC6gt8cjgWrNkV71zF1s74cqkfGtxbaqb4m2WKHIGioYO0HvLZTOUxC1
	Woe8ZwmWvGeEV5cXxP3GcB3d5EANU2tSpRM/Ev+NHNECo8gi40HCyLGzXZBG3DWVjlTVqkiTZVM
	Cka1xmZUAgtt/mvBr1pqEksmd6EBYQbcXgch8QAeL9z1qWrtGryBFm0PfUDI3nZsAcfpV45spxh
	VJZC2Ht7olCD0+ATuk6xxFJHfu/TGxQaoxYbx8CrlwLEhM37mEEMQTTuMlf2swimlORrAkHvmVk
	5ZEJLBChcA=
X-Received: by 2002:a17:90a:c10e:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3acef10a76emr2602492a91.58.1792246538586;
        Sat, 17 Oct 2026 07:15:38 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947cf9a5sm13320990a91.15.2026.10.17.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:15:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: namjain@linux.microsoft.com,
	mhklinux@outlook.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mshv_vtl: detach poll waiter on POLLFREE
Date: Sat, 17 Oct 2026 23:15:27 +0900
Message-ID: <20261017141527.623376-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSHV_SET_POLL_FILE keeps a poll wait entry after the ioctl returns. A
file reference does not always pin the registered waitqueue:
signalfd_poll() uses current->sighand->signalfd_wqh, whose lifetime is
tied to the task.

signalfd_cleanup() sends POLLFREE before the sighand is freed. The MSHV
callback currently leaves its entry linked, so __wake_up_pollfree()
warns and a later replacement calls remove_wait_queue() through a stale
wqh pointer. A source-equivalent KASAN run reproduced:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave
  remove_wait_queue
  harness_ioctl [mshv_pollfree_harness]

The object belonged to sighand_cache and had been released through
slab_free_after_rcu_debug() after __cleanup_sighand().

On POLLFREE, unlink the entry under the provider waitqueue lock. Preserve
the existing CPU cancellation before publishing a NULL wqh, since a NULL
load lets a racing replacement reuse the persistent poll state. Use a
matching acquire load under RCU when removing a normal registration.

The callback takes no mutex and does not sleep, so the existing
mutex-to-waitqueue-lock order is unchanged.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/hv/mshv_vtl_main.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index d8225242c73f8..c6f1e2157d258 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -17,6 +17,7 @@
 #include <linux/entry-virt.h>
 #include <linux/eventfd.h>
 #include <linux/poll.h>
+#include <linux/rcupdate.h>
 #include <linux/file.h>
 #include <linux/vmalloc.h>
 #include <asm/debugreg.h>
@@ -448,12 +449,35 @@ static void mshv_vtl_cancel(int cpu)
 static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
 {
 	struct mshv_vtl_poll_file *poll_file = container_of(wait, struct mshv_vtl_poll_file, wait);
+	__poll_t pollflags = key_to_poll(key);
+
+	if (pollflags & POLLFREE)
+		list_del_init(&wait->entry);
 
 	mshv_vtl_cancel(poll_file->cpu);
 
+	if (pollflags & POLLFREE) {
+		/* Publish teardown last; pair with acquire in the removal path. */
+		smp_store_release(&poll_file->wqh, NULL);
+	}
+
 	return 0;
 }
 
+static void mshv_vtl_poll_file_remove_wait_queue(struct mshv_vtl_poll_file *poll_file)
+{
+	wait_queue_head_t *wqh;
+
+	/* POLLFREE providers RCU-delay the waitqueue free. */
+	rcu_read_lock();
+	/* Pair with the release store in the POLLFREE callback. */
+	wqh = smp_load_acquire(&poll_file->wqh);
+	if (wqh)
+		remove_wait_queue(wqh, &poll_file->wait);
+	rcu_read_unlock();
+	WRITE_ONCE(poll_file->wqh, NULL);
+}
+
 static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
 {
 	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
@@ -490,9 +514,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 
 	mutex_lock(&mshv_vtl_poll_file_lock);
 
-	if (poll_file->wqh)
-		remove_wait_queue(poll_file->wqh, &poll_file->wait);
-	poll_file->wqh = NULL;
+	mshv_vtl_poll_file_remove_wait_queue(poll_file);
 
 	old_file = poll_file->file;
 	poll_file->file = file;
