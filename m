Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E08383C96
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Oct 2026 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131089; cv=none; b=C5vhW2rFsi8UStUizcxIVNSbyJ3LgfE7BbTiOnVHCoqc7V0XNGyuXzsAi/43H512Xur0nOkzPSpeVvZTDS9jviPtBKwil8uQVliHeU04E1SkCYogsTAkA649gYBwKxfX5uPsRNoNNwl2Lul0TZubOwinZ9PN8lBPQGVUjy07cUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131089; c=relaxed/simple;
	bh=SsI4U9ZL+7Uo8HhhoT2Gu79p5AWbf+Tp7UQOH5gny+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfi0P4hP+RKwieJM8xPvzyBW/dwsg1COH3/KrXWWLO5qWL8zMMEDPcbLYDOmcnHgJeCewewXCEPxoyMBROw1m9K+Nib/vEIH1NREr6D2+CPR0x5ZlQRRso9FkvfKt0euKgsUqe9TSflMhF8NyfoXV/aSLU3Bo8qCJQWCRBXZWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9IeXBEv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9IeXBEv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e987b4a710so1579445ad.1
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Oct 2026 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131086; x=1792735886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=id/dYpmE9pWZImX6Xj6XFEbwxwZmT89xDoMqxLDgKrU=;
        b=E9IeXBEvXZDk+SY08ZjvBwE+6+xVo9BL9PtlX1FGprDLeJJi4cRn3N7EgjQ9eFgNye
         6dwDa3tUaHVks1KyZJZSexIX4GIfmeRxDbHBjl23PuEAoDeIwna4jrqHgl7ckH4W9/SX
         Y8gDDuJP71yE+i/jgSwOUFsGUZSGYdplPtdbH8REQf7bQNf7WPmj6LDsEhKj1wHMkBKz
         f0yahU11QigXzM/bGI+UaNy0SViQtwqaz3aLLVBlbE4N+9cTRqoLqmyzlfGlwDeKsGVh
         cG0XgRFstB0j+2bsnRZB3nVQ+WgTNfHwbxQGPXhIB8k4J1Nz7h+nLQdKgYdSbPRFZsV1
         Rh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131086; x=1792735886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id/dYpmE9pWZImX6Xj6XFEbwxwZmT89xDoMqxLDgKrU=;
        b=u0FmhlD4/LQZdweTcex1nHezUPSliLIUkfHpu0oAHasUFVpOHRn4V8JXg/knxmrljt
         5ts0VC7OIRXzlr5qRWZqgXCgC7iNVlMq9zjO2QsqbC5eqBeSgs0RJrcog1F6wM1foIz8
         yKdl9xeqy03UQYPRvhqEVjAMqwJLFppXO3KKJ0xRZwtfTfnfiH3+Lw1i81q0sgN0yHeD
         jCFUyeN3e8fVFUcXQ8DcCprSLn+tJPOkQp5pL+MBfQs3SOLCYVBflCbGq9Qn606CF6DS
         IzlZTu7VroU8Vcp19FcH/o/PberSbL7xGMkdRnHdWWKrrS6StbUJovGqiF16g8owpfTv
         neqg==
X-Forwarded-Encrypted: i=1; AKwUvBzg96a0APoSehHLJvuzaCyRzALzjwq0rNnFObWRcORU3QVGO2RKseeOMvF+FZ9Rl4lqFg5afMzVHCtZYAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZAg4JtpCiIe/6FSgjcq1HtG+6SDplFSOnu1OJRwVkbqVWI11m
	dtcOuuJc/dppAdZpbgP813N7CJho53UuYerhadYgaABPcKkfvc1EHGJ0
X-Gm-Gg: AYBFou3OXELhMsxTrCkYnWUUlcHgJpTv8RwAAwvRv/Kll/nRpGJAhsUKvl5VOD3Xa7F
	Di0StdvrKa3dm9pV/07N9oTe8Gi5j0W5BwNqO3tChhiVWvjjF1TE8PYE9XTekIG2lvD+KSAARPU
	nJQFpkCNIQ8uGXMaUKWszjA49q+X5IcxCNxGkJsP+hBssBypCWh66U6SqTFdXVZzl2xROEwGT/d
	HLBL4PpAKPXUFnp1zreikcGKOqIHLoBlzQ4LIdhx4tKkLZR1JdRt08/+hJSqCrMptUYEtsRtL4l
	YKCV80jSolR/sF5q1fJCB76u93FHQqRgsvBe+Wu5ldS1jxbA0ufr8KgZwm54FOXtNCdXr6NL35T
	XHkh6N12/hzd8pK98/0MvU5/D+8K7XeN4PGkE0IaLY3OIhUoO3EMFwK8kjEvR+USIwkEzQKmWn4
	IEsCoXx8dIPEiEV1ruzXz8rqAInLDYahL4DQGEn0xu0uu58Dirvitn60Kr4I80TPwhH1sy/hPKF
	8fswNHYbRE=
X-Received: by 2002:a17:90b:2ec3:b0:3ac:9d83:8858 with SMTP id 98e67ed59e1d1-3acbb933bbamr1924825a91.41.1792131086541;
        Thu, 15 Oct 2026 23:11:26 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654621dcbsm546633a12.0.2026.10.15.23.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:25 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mshv_vtl: reject poll files with multiple waitqueues
Date: Fri, 16 Oct 2026 15:11:14 +0900
Message-ID: <20261016061114.1686153-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSHV_SET_POLL_FILE invokes a file descriptor poll callback with a poll
table backed by a single embedded wait entry. A poll callback may,
however, register the table with more than one waitqueue. pipe_poll()
does this naturally for an O_RDWR FIFO.

The second registration currently warns but then inserts the same list
node into another list. The new insertion overwrites the entry links while
the first waitqueue still points at it, corrupting the first waitqueue and
causing an invalid callback traversal when that queue wakes.

Reject a second distinct waitqueue, remove the first registration, and
return -EINVAL from the ioctl. Repeated registration of the same waitqueue
is treated as a no-op. A rejected replacement leaves the CPU slot
unregistered, consistent with the existing remove-before-register ordering.
Single-waitqueue users such as the OpenHCL io_uring poll file keep their
existing behavior.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/hv/mshv_vtl_main.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 6e3c11c681717..158409b67a046 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -72,6 +72,7 @@ struct mshv_vtl_poll_file {
 	wait_queue_entry_t wait;
 	wait_queue_head_t *wqh;
 	poll_table pt;
+	int error;
 	int cpu;
 };
 
@@ -458,7 +459,19 @@ static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh
 {
 	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
 
-	WARN_ON(poll_file->wqh);
+	if (poll_file->error)
+		return;
+
+	if (poll_file->wqh) {
+		if (poll_file->wqh == wqh)
+			return;
+
+		remove_wait_queue(poll_file->wqh, &poll_file->wait);
+		poll_file->wqh = NULL;
+		poll_file->error = -EINVAL;
+		return;
+	}
+
 	poll_file->wqh = wqh;
 	add_wait_queue(wqh, &poll_file->wait);
 }
@@ -468,6 +481,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 	struct file *file, *old_file;
 	struct mshv_vtl_poll_file *poll_file;
 	struct mshv_vtl_set_poll_file input;
+	int ret;
 
 	if (copy_from_user(&input, user_input, sizeof(input)))
 		return -EFAULT;
@@ -496,6 +510,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 
 	old_file = poll_file->file;
 	poll_file->file = file;
+	poll_file->error = 0;
 	poll_file->cpu = input.cpu;
 
 	if (file) {
@@ -503,13 +518,18 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
 		vfs_poll(file, &poll_file->pt);
 	}
+	ret = poll_file->error;
+	if (ret)
+		poll_file->file = NULL;
 
 	mutex_unlock(&mshv_vtl_poll_file_lock);
 
 	if (old_file)
 		fput(old_file);
+	if (ret)
+		fput(file);
 
-	return 0;
+	return ret;
 }
 
 /* Static table mapping register names to their corresponding actions */
