Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA6337B81
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515206; cv=none; b=Fc2FzeU5UR2wvE0xxvJfBHwROLf6ooQP28MCmzBd3Jum4O0efb8A8Eyda/4XTsfHY0urloxFr1fRFmzdCtQ7OhfImk+jgAGId6eKIetDbLfcKU4tF1U5KgWL+MeHdl7m8prNsew0hfM67M2ATFa1xKwsllkMSSiq2Inl29zvHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515206; c=relaxed/simple;
	bh=5Uz2zi/HaHZ9scqnUVj7yk+2fytGfDAxOLNXAwt2vw4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gG9y63IEzg0U4RDTVlHowCWq+eDwmKM1d4OnWRY+iiblvdsQ0rVcygFJbrKDrGGtS49G43Sva2sdqh9uIRyiG5Vs/Vp7okQyDTtEchckd/ZQacy7Nuwkz2YQ6BMovEevPUxlFECoYxHp6A3JU4/KTBDM0xYjfYRxGJYNybV+Zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmiwYATY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmiwYATY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8714288dd3bso1992199b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Oct 2026 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791515204; x=1792120004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KrdVnUhtPNK/Av17PhvpBtm9fsARY9axkUcpxdE9xCo=;
        b=gmiwYATYJDVsrjbDD631PuI+E1Bodn447DUDkztIwobHVVaY6Tl9cwqDDtalGnjCCh
         d2IFLrQEBmM9JlR96GifgEEyp8Fj2tgUSMeQr/u4XPyIO/+RcgYdOg1OnWYwTft1ktzh
         gA0eNgrOcmxsdQNazDWxwCTV1kT9aP/8m0sHi+JYY40vp5K8dwI9KN4eZ1JxvnwOTOIX
         IBI5fwfLpMruw3GT1CwWfkZHTyVyRqDFr9JIU4cxYOy0fe6hbQrN36k8cPMUSsL54+PL
         /nR1sFvJJuYj4Hd3WDjucQtPhlWFbMXHy7j3bd1Dwg7y2BoX2TIBqkMwqohbL5kNju3R
         jKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791515204; x=1792120004;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrdVnUhtPNK/Av17PhvpBtm9fsARY9axkUcpxdE9xCo=;
        b=a56vT4OEWw/j0N6CWh/kpLe7k0fwJTXlauSCjYFda6i1cx9xXMbdXzThR7LyX3Cfg6
         CG4WTMPgqjIFYrE3/qOQoQXjvlDws82DPvcN1haJqUJoJ7z0I9G5V4Gx831G0YFfNcW4
         Bt2TIhM19JXs3MSyfsMgovcCMxhcy5OBC7t89fB5mjravFNsWtP8xfZcbuwIU8o/0UPQ
         VcUplV4kT0Z1yGHIWsk9bJN6WYkDT+fU447TbraZB4ArWHYJXqSTkFzk0VBbcQic94jN
         zqf2YeeeX0CNnhUJn5C9VX2D2MFPqqsZVWooAxaKz+5cjOZ9ZGq27p9D/q9ZxDKZ4MZf
         xZzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmr/hG9maXKB/2MvVgxFEPLnm90BtOwqvwbcI9+HUBFzgUf+9b77yCZ3HWHnvJIFMFGc9k9Z8CuwKD0Oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnZDEpVqa1Dqi6jKHmts0qKcTdtiJiSZP4s2pn/KAsLEH+wKsp
	k1byLqTjOnZclYBbf+6iYzyE+2EnBpIuWyUOdPTzggH39tAugBPXlXK4
X-Gm-Gg: AYBFou36Sx7ln81xIegmfJ9vvj+b/g3LBZ69DvsPgkTiLUi5ZRz122Pk+Z3xAPiu0o+
	nIqccMAvaGVnxbLLmxQHKcwIGjxdMLROGVCxDsP9UHPiOrxjr59od4qnGn5VcuTB1VJIOBEzLC9
	LZwWokEcdq9opzTWo01wOT4mkmfRMHnRUVMZm3lnR3SGlcMunDJoDKROa0mwwfhZfErvez5cuR5
	DuM0uIyRai/OuqK8hFRXVxjo90Mcb15tGeXx4g4pnIDkIQsKFAdujvGtV7yRhelnKHiLFEI9etu
	SdFcBGlnmJwz6qKIOVwBGr6E9HO16N9nKlwB84z319TEPiw0OUnXvLrd5LRHu1D+uo1RqtHNcxb
	Yf6+uzO+XZOEHHyRLgEUtELv2rS+mS4BKfwL9KSKn6Cs6FRVTz03qGtb0UWOiYwUBsjMnObh2tr
	FEq/vtYLLL9QaW/Atmv5nVaUwjUYrtC+91CeMn8scxtLNSXp6eA67svc+FIo5McIdXNfLuV7XkE
	/objEeQ3qCSzoLEI7LOsMONyuxbfCYqVh/bbTUtUGvtg5hYwCF8fjbCRtz1gXesTVA=
X-Received: by 2002:a05:6a00:1254:b0:882:bba:8791 with SMTP id d2e1a72fcca58-897c73f9603mr484203b3a.34.1791515204273;
        Thu, 08 Oct 2026 20:06:44 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3ecb01dsm320656b3a.36.2026.10.08.20.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:06:43 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation: hyperv: Update documentation for sending VMBus packets
Date: Thu,  8 Oct 2026 20:06:37 -0700
Message-Id: <20261009030637.3869-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions for sending VMBus packets have been simplified.
vmbus_sendpacket_mpb_desc() can target multiple ranges, and
vmbus_sendpacket_pagebuffer() has been removed. Update the
documentation accordingly.

Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
The Fixes: tag reflects the code change that was made. The
documentation update should have been included with the
original code change.

 Documentation/virt/hyperv/vmbus.rst | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index 654bb4849972..77a437969b49 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -137,18 +137,13 @@ control message contains a list of GPAs that describe the data
 buffer.  For example, the storvsc driver uses this approach to
 specify the data buffers to/from which disk I/O is done.
 
-Three functions exist to send VMBus channel messages:
+Two functions exist to send VMBus channel messages:
 
 1. vmbus_sendpacket():  Control-only messages and messages with
    embedded data -- no GPAs
-2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
-   identifying data to transfer.  An offset and length is
-   associated with each GPA so that multiple discontinuous areas
-   of guest memory can be targeted.
-3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
-   identifying data to transfer.  A single offset and length is
-   associated with a list of GPAs.  The GPAs must describe a
-   single logical area of guest memory to be targeted.
+2. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
+   to target. Each range consists of a single offset and length plus
+   a list of GPAs that describe a logical area of guest memory.
 
 Historically, Linux guests have trusted Hyper-V to send well-formed
 and valid messages, and Linux drivers for synthetic devices did not
-- 
2.25.1

