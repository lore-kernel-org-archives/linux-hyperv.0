Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F749DB81
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399451; cv=none; b=sMDNwdTqAphF45+CQsAVK/PMZlOcJ9n/IXMTIKXmFkOPmgyuladIswRigo8O9FwdLkd1RQIBgM9qHcNcAwtovGL90NiwumszXYomYDWZj9hPywbQC6Byf0CafArmyD1khX1W5xUMPmBBJU7sR6GZPMITe5/ho6IJWxtn0CCcH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399451; c=relaxed/simple;
	bh=eUlgZa4mByAmqLLYHZlpmODtiKLs/uZsRAEQoW4P2VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMmAPFLUe9uv9f6LMpJyhy5T2YriZ9TMKR0Ist5Z9Ro3LTHRmvxa9C6iui6p28dQDqXPVwkXcArnNNbX+MRzC2lylrrH2f7s7/qAPYd+2mzWu/l++40QwvsKYfD/UZPQkxlrzvfHQ3/82cwWR50GgypdvtaqqVRXUtyP26YyWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grGRAqts; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grGRAqts"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1174861a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399449; x=1793004249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZAjpnZdcieC/RDo5HIFt+JRBt/XWhH9vOMNbiyGsFc=;
        b=grGRAqts5cd0je1D5xiuGm3XQAiM9jaMZkYb+jUUcldIg685f4For9AOSBJgHPKLEP
         QkA6H8h3NotZ3lgZsWfbbPVLNeQ9qNOxfMdGrLV3wwpnw+P8yVweceTP75X412JjvqSt
         3SsvVIPy9sVe27VxYXUkFSKMN5DIQ5AABD915uoNILNf5UyHgn04Yci1TYdvN6IzSWza
         jyq0ZEfaCbbwq0gKDled2ugFpUI9Z5MasWV1JddiQvYqfkERi3tjbprvGVqvYsVeLuUa
         FbQVqk3bh3av03qg3/5LrqhXvVShW2/O9Xkhsh6gXLrvpxkZgOcQSIxTVeK7j7VsDP9i
         +7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399449; x=1793004249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZAjpnZdcieC/RDo5HIFt+JRBt/XWhH9vOMNbiyGsFc=;
        b=PkOAgDY+ZjOu7SohQqTQCHWrxGIywU6KE6oVwijus85F12+WNRkzElCYUbQBVAOEk/
         2VP+0BwRyLgyG88nKhhwXzF0YFxXyIkF3Fp/aIZMwvyy7g8okJkqCXL0daH+JTv/0gwh
         WsXkT8VLlPhLkcSHkIFsuBF65prlkO1i/3YSm2GqrapvapvPKHRrTiZ8pXOOgO7A6tLN
         M2iOqFKDRYzCkyQ4Do8dW4gzq2T9o2AwS1N+1yK5Hp+EdX3v0ZOqWZlbI/3K8mK6mG+M
         ZqIsuZPuTqem+gVaY3ctt6gwvMsKQ2e5dRoxu9o64yoaQXhjypc68n2gx/3d9mregtSo
         Eb9Q==
X-Forwarded-Encrypted: i=1; AKwUvBw2evgkckYVN2DNJfBOCGf/oE3cl4jQf6HMz7MBFcQ9hdWZRjBp/+A8YCI16rYL6lqfKQULP8l1D4qteY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxFqBkmWKTIxab0xCwdIgtIIpd+WTLRRFArtnzEQcB/1ivqJk3
	BSLSsR4f5jzXoexFz9u1Dw4589hfkGmKrepenZhcWlAvmsrzKO1vz8Zq
X-Gm-Gg: AYBFou0vfAiBS3TSDH45uUrGOIBtjyRwCf8SSD/bHdX3OktLRVpGweUqA7vsW6uqZD7
	XJ75RgON1uSs2oTr11yw72Op9Iq0ZDteY9nzj6KUSw778LS+HZNJAg2AiBlME2MZqu/FW/mGTR+
	DoE9/43Zu6A3P9yoE5gIK5u7Z2xBv/y6bdawgEjP4LpnVaCnrmL1qW8uvQp1aO4ves9Ewz7I0y/
	zqLX9fr4sgP0eVzNyNT8cVuNIavhrE2tDJSUsITxixCChsYtTwT7PPw+vRx4w/p3Xl4/VSHpXyR
	SN0A4NggyESCwGJXUxppskTdraNxvE8labiJKwOqXkTz8OkHfCdm8HQqydmpe9ojr65ejglxjIX
	W5Eoa0ex4vLJV6xXJsQhUUrq7VkjkCVDbrQTshsbCB2UkQklEEqouYLB61e3JnzrXHJabihUBZP
	d8fkvOcscSTLpr+4SfJE7Yrsr/SHoHrpM+cF2h+PC/4sVBn2ZBSvZooCgU+iYoTgR9tLq2TQqS/
	g1BgACALuYdvkNUk4qtog==
X-Received: by 2002:a17:90b:180b:b0:3ac:c90a:10bf with SMTP id 98e67ed59e1d1-3aceefbf728mr5189425a91.17.1792399448796;
        Mon, 19 Oct 2026 01:44:08 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm14644858a91.11.2026.10.19.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:44:07 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mshv_vtl: reject poll files with multiple waitqueues
Date: Mon, 19 Oct 2026 17:43:49 +0900
Message-ID: <49e4b702301d3d413d4adb7d4062e0a9b78a350e.1792398881.git.4ncienth@gmail.com>
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

MSHV_SET_POLL_FILE invokes a file descriptor poll callback with a poll
table backed by a single embedded wait entry. A poll callback may,
however, register the table with more than one waitqueue. pipe_poll()
does this naturally for an O_RDWR FIFO.

The second registration currently warns but then inserts the same list
node into another list. The new insertion overwrites the entry links while
the first waitqueue still points at it, corrupting the first waitqueue and
causing an invalid callback traversal when that queue wakes.

Reject a second distinct waitqueue, remove the first registration through
the common removal helper, and return -EINVAL from the ioctl. Repeated
registration of the same waitqueue is treated as a no-op. A rejected
replacement leaves the CPU slot unregistered, consistent with the existing
remove-before-register ordering. Single-waitqueue users such as the OpenHCL
io_uring poll file keep their existing behavior.

An LLM assisted the source audit, fix development, and validation of this
issue.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/hv/mshv_vtl_main.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index c6f1e2157d258..9133646b5b66c 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -73,6 +73,7 @@ struct mshv_vtl_poll_file {
 	wait_queue_entry_t wait;
 	wait_queue_head_t *wqh;
 	poll_table pt;
+	int error;
 	int cpu;
 };
 
@@ -482,7 +483,18 @@ static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh
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
+		mshv_vtl_poll_file_remove_wait_queue(poll_file);
+		poll_file->error = -EINVAL;
+		return;
+	}
+
 	poll_file->wqh = wqh;
 	add_wait_queue(wqh, &poll_file->wait);
 }
@@ -492,6 +504,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 	struct file *file, *old_file;
 	struct mshv_vtl_poll_file *poll_file;
 	struct mshv_vtl_set_poll_file input;
+	int ret;
 
 	if (copy_from_user(&input, user_input, sizeof(input)))
 		return -EFAULT;
@@ -518,6 +531,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
 
 	old_file = poll_file->file;
 	poll_file->file = file;
+	poll_file->error = 0;
 	poll_file->cpu = input.cpu;
 
 	if (file) {
@@ -525,13 +539,18 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
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
-- 
2.55.0

