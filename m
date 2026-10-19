Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1F49B5C1
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399447; cv=none; b=KgyU2EBFb+VZBkdiViP5msAmmqtccD8YOoh7bNHOA3hECVRZpzzl+Kp2YeJ5cnOe3jFOryf5zxm2QVpxvZzfB1jy35iG8C+XKs6iuhazLUCoqnkU/Foa9WL00blgdvFm4Ev9fcIaOIRH/nZPpp7kXglQwUoZqeZqTBPNpH0yelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399447; c=relaxed/simple;
	bh=yXUG/OwNyz7lRYm24FzAS/LrpvUUoWignnc+CmJf9kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czmtkxerK7pwRn3y66jKR8+Oyfyn4hPiIsWa+l9IL5+zDTZdYbQXr4mZXK2prScaM/W0CRgvKJR90U+yE/2oNinzc1v7b6pAIVlfqM0wm5jzppPvkWurvcY2Pb25sXVkA5n2dUpGu1tASDSuZeRm0TJ0Wa4hlx4ARiLgwIGPsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRHHTB5v; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRHHTB5v"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso578692a12.2
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399445; x=1793004245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wZd16A4vxo4JDfCL7rTy0nOQhfiuseGLcySUyfI/kI=;
        b=nRHHTB5vKws1pGI2JZB1s53sP8lGuZ0KhEvw3uV0pwo9yV/g5AHx6Jp0oXofxZ8wMH
         p8AIgub7zyF57hd8ijBjtXFuhFOyvF9qS1Hg8D/T30KoH7zvOFv/J4tYDuZkNdsNtqk0
         /ED075GbisJCQMRpvc6bC0LpvO/9Zdowx7iC3xuhGoEgNfY2Ejxsf7xAN+f0er9kt6jG
         1rf7wCGYmgfQUtiKcYE/jMmlYHAMhO5bgvIxpNR/IUsXZ5M1Y5E1F6CsYyYmZBb8Uffu
         UDwA41ynFe1JWHtvEmJ2jx+OC9KSx+ywDVmGVsxfN4XIZqQP49eEoDN/N9+cIqsu5QQL
         3gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399445; x=1793004245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wZd16A4vxo4JDfCL7rTy0nOQhfiuseGLcySUyfI/kI=;
        b=bvxuqPaJLmERVypeoB0Aw+Pd3i908uET0wL6w9ZBZNaoH6gBwe9QKCFUoT41Cr2zyb
         I7OUYWCcMP51DmDweQ4cx4rpFQK5Za8sdCY2l6KKKSzirwu6bkxvICg4bRjUZLyKvzhQ
         6c01JlpvM6L7s4i3S+EUn6CyWc54D9B31AJWkDV7UHHkjjhHoF3gQSPdIArOnTZQztVY
         3o3ZHRuJoy4sFkevNQU6pAE9IhHSQ0agztu6aLsNEWkR5LC2vohTf0OZzHgAzoqJMTu3
         MyAo40LIk0fK8iVMxzRTX8tRqzrfIGuFoe6Q2iNHnUrjBnmFE3tD7AG6GHknt9ptrEKg
         ZdqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwbFeEzUCTID+vqElaoOQzMJBx6SFeCoKoj/ppd11SusQ7kYHTVTd9O8TPPl92RHZS6wzj3T7moJ53fO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9mN1u3SZWwvijC87/rdTvzV55iE2/xT6OGXGOFmqrvcTcWVQ/
	GZHrMsSzrn86b/Ip4weFQGs/oHQ6+Oku2BD9bdr/fXzzpUzd/a77aT/Z
X-Gm-Gg: AYBFou04Vnkhc+5rtnkLWq8l3SRGpkpv71E7a7dQBYa1Jo1iBpiOiSuyL/Ne5nGhtHb
	RR4qUrIh5Z3zy0kLv2br2Q+fBggz4tQzcQPLXNBAgn9kwD6/Nc3TG3+52XP6o/tmw1JqP1DAkWr
	vMSPqw19cnfthBfmaeZ9xXQiu1b5BkyPDi66zfmipzFoj/CF4Ky5PjeXsEPcDrNzB1qw4UKDSHq
	2SWUzoI/PzKz6yF2sRxhGDaptHzv2MKFqAHABOl0h5fr/8TkeAnYNc27/ou1+LvBQlCCbqn4IWP
	ZxGnirGKh6pswmW5/w6DcLQR/AAUM2H3fEe9IRf62CyeGBsGHZFTOfQaUOVhkk3V4hj6I8zbId/
	0lUFu772HhgGpp7Ir8sS4lSmH+Ogzv7JcK/VFpN4CfVNx1ZFtJ+jJbRC8pQEM0Y34+803RD9AdF
	Chj74BlpvUbBMOeUdlgwx5VJmcLOEOXZooadZLvjJoYjawPPx09hCDvRx/770ZsQyVbkS5qYsJE
	4gm81YXcT8f
X-Received: by 2002:a17:90b:5825:b0:3ac:7c52:faf6 with SMTP id 98e67ed59e1d1-3acee2963bdmr5187923a91.1.1792399445078;
        Mon, 19 Oct 2026 01:44:05 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm14644858a91.11.2026.10.19.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:44:04 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mshv_vtl: detach poll waiter on POLLFREE
Date: Mon, 19 Oct 2026 17:43:48 +0900
Message-ID: <a6a7c4c43cac9d42bc2417e9aca16833769c4b84.1792398881.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792398881.git.4ncienth@gmail.com>
References: <cover.1792398881.git.4ncienth@gmail.com>
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

An LLM assisted the source audit, fix development, and validation of this
issue.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
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
-- 
2.55.0

