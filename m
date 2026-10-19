Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5F485CF7
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393531; cv=none; b=nIvSJLUjBfPi6ESUMOnsCnE3pWXkP4Ph4RF5HW2iwxjnwg9l1XDhfSgyXKLh+7zqI9wBdXRrmDLBmrNLm1OHSfViMrwaTmK2VbaYV4ZtY/2YRt0F2z0syUSeQh2ICfVA3rqLkPlJIKIZZkBovkW12lHZzE00LOmFkA4fTomGHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393531; c=relaxed/simple;
	bh=6ogOn43xB8QEwAvUWQg0xVPQaDZ6JnXonLhaZHN86jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz9NnIwX9ymh2vfnDZVDXo0IgvArF2GUlaxqvdrkhtblvwbSVImmitaqN6w2RsENk3EmrFw0vGIhoE0Bnleesl42iLMIXYYGESWmYYDX6wNVsURUtEbrcGrqdZSAKYriSALAdDflSF8KuKca1iYeaHmxxOWPk471bZIvWu/12+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/dkocMZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/dkocMZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so896209a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 00:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792393528; x=1792998328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pExZzNoAihKMpA7rpnKJk+qrxFW572fEhtbrS1SyvK4=;
        b=E/dkocMZRqnuTtHSEQwne23qnuss54S2SzHDPm/2au2NIf0lZygeOdzCKtAg/Q1pVf
         WtOoUzbOZk3ssqLxlZCB0svpDtTwgWNDJdO0F7gyw4S59/iijqGPWEe51FZLbLXsv1BQ
         bfRJwEAgk4WIuhE6AZIa50YUTwrwuy0/+Dva1uMtSsVUhMqVrwnc9qJ5X+KIozCQjCje
         GfkXz8geEgtzc5XVVTjT8FQO7gryjZ68iEkfQZaUOtAbPZfOcnP9j4qx6u+jxztsDruq
         vUcp9HUQPko6E5EDST6r9uURGHk3sqCYpnBPZ28C20BO8B9Dt9e5mpjWn+lQcVMnj+dU
         Birw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792393528; x=1792998328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pExZzNoAihKMpA7rpnKJk+qrxFW572fEhtbrS1SyvK4=;
        b=fKCm6NGhQaM4I57skv4FWLO5sQNuhumOun4peEkrNcPcTUG7+i+rsDgwKGhd2x1hr7
         puiunzw1w+skCizBObko8giYQ5Gv1q29HcHm5YW+iV70pGQkJb+JEXViRgg7/Mi6SS5P
         i5GhsgDPaLOyaa+9LBc18WnK4/5adqX2/55NJ8Wu2jFvpAqGkym4RBoY++maUAkLc/ni
         fQoN5wQBvFQfk35uUpMRLu9LXnjgXvpfbfFaurAjdWfRK6WNn3OxCxgrG2oll/gVXi1T
         LeHE9wYEfHwTjQhmYug+cMzcP0xls3mjEcfHpX0KcFg+Ww/nVL5GXWraaCXu8edWvjyR
         sxzw==
X-Forwarded-Encrypted: i=1; AKwUvBxaP2inUoolzv0JuUTATxTWP8aBneRqlsatd/lgkzY5gzP/12VFxgjS+E6YTgaW1yKs5cVE09MUjLQ6hdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6YZFy7kcWmbldL1jYOEn5rZcF2yTHCL9go/MOM/HMnGtwO6R0
	5+96q4PAO04G7ftkPWSoS40+x+mHtoRUWQ5v38PyLjJTUzv4bshKtJKF
X-Gm-Gg: AYBFou3RvRxb7mgyEEXJNVxmeJfXFHNLnZ+gyScvhWGOnsWHcA67E5rie4z9TUwB7/x
	d81ZiS9fziRih/8STaqjzCmupuIZNuRBZxgv1r+hu/EV5oUTZ7cdwXFLZ1I2llX8awzCabqFbEI
	R2hVnuHwAqIV80D5yzrygFGsDYXFUKPzNHsJ/4F5ZQCuHpYSBo1Rw+jk/PpnMb0WpjriEO28vN2
	OfWnZoYwPpl/yUYtvkUxOfa5jpoH6qtBuJ1/KX3EL9Zn0qK4kTYjeKVjCqIL6m7Zoy9EdxbcY48
	t8rBz9JXjfjtUCxuryyjPS0aPDQuPytQPHn2C7n2nUjO71ajGatacaZk3NzP+/SKDD5Uv30Arqb
	adh0fw5PN3YWepW7u1rB4J1jL6p5AAKWyLiwqPTWbnDqtDDFxDhNeVelDuvwyrorenX14qJ8FFU
	XmFu1FlFRJZUZin1FaggpiiaFDFLMXIXCerKSI63T1ekTQsvcwbFTIBM10ZGfUU4yRyIUZipLgA
	xX4O38llYg=
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3acef59e230mr4320583a91.39.1792393527520;
        Mon, 19 Oct 2026 00:05:27 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm14384249a91.11.2026.10.19.00.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:05:26 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mshv_vtl: reject poll files with multiple waitqueues
Date: Mon, 19 Oct 2026 16:04:38 +0900
Message-ID: <20261019070438.3732624-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b88b0341-a732-41e1-87df-4f0503df39cc@linux.microsoft.com>
References: <b88b0341-a732-41e1-87df-4f0503df39cc@linux.microsoft.com>
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

An LLM-assisted source audit was used to find the issue and develop and
test this fix.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Replace the no-longer-supported Assisted-by trailer with changelog prose.
- No code changes.
- Link to v1: https://lore.kernel.org/r/20261016061114.1686153-1-4ncienth@gmail.com

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
-- 
2.55.0

