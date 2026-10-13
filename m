Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5B415F39
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Oct 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855843; cv=none; b=Ewi52T9uCKTkoprUYex3ohqWxObjScB8CkE27yLsYphRRFpIkaEHKjK8ECnNTAX/AlUDnTNed4s2a9mqAua/gTXHbNwPuBDfJ0uWNxeqVSEp5j6u+RGt2ytT5BnTYqNDkf3uXurv2Lv3jEwGvXoh95sdN0A6eTrA35WFzYaVLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855843; c=relaxed/simple;
	bh=cwxYtqwV/asJI0sJ0LThEUuGst5eSyMrVjDHOf8D+Tc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PeGEEy47Irwo7UrLflicBQSsFMv601A1zQyzcT7hYrHKLTpKL0o1ItAo0y1hcJfnS8hw5X4L+R089UWiSyUiTvXl18k3Ww4ctCs9diP3zc8US0a+JDN/Cnu7rCoopogwVmOSOoj4MAbppzGbbThtsvKmhAUSM7vGWwi+v/7epjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAyFLk7p; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAyFLk7p"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so628352a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791855841; x=1792460641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKPaX1rZHzqkluIlwZ5oqUSCtuKL8Cpnoh/XmdieGa0=;
        b=pAyFLk7paXKxrkn8c72rJreBTor/XtNoHRo5kTxy4mbg+hjYWndVAHATazbXlYjNP2
         qG91wyhjWVXmFysdR3BBwo+hLlYNsGV/UnvfKF+inz3qLiPp77AulUdRLzg+PtGmaL60
         qJ3K8YtaSoyFQKR2LAogr6szC8rRBzpQXJDE0oP78cZdK4CDShqZYQoGJxurwB6e1geB
         Og4H5XIGaneQ2Ub0SH6OTdS+Cs0dW+Ql/l6b4YHpwttK4M3oBnUE576pJ/5oEAXpbpuE
         8YVsk16mvODCn81KQ5gHoWzQo3eJFPK29SS6qem+NPrhzGXrKOiLcuGzQasWu5tGlbET
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791855841; x=1792460641;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKPaX1rZHzqkluIlwZ5oqUSCtuKL8Cpnoh/XmdieGa0=;
        b=0pPD6cxqUHJ5+KE8FG8jgMKmeK+qGFMQPbT/M21ELB6Qr4sHw4cQHNMuh55bxQncWz
         ROfZW9jSNIu/ZIgVB4UvXZc87GH8m3bLuaL9iqGxTsLUsUZwbW5iI1xlpTnPE4UnpSzz
         AmjnfTJ+oDdQBp9/sCaNVi2jIph+VW2J9WLsiomP5g86+30ytrzSS+uyYO02Ow4U3BwR
         72kDoW4DaSbk8TSs2lS5a74siJEMfo34RHeEue2lkwkepUcfEluRnBKABcEsvjAY/M2+
         p4fQkGRVQn/5J0p67jtv0B7u0DrYrUEzIqAeWy1KDxLSgGcMfrVwd5gsOZVNitR0Qzdw
         yHBw==
X-Forwarded-Encrypted: i=1; AKwUvBynl96Q27qjiRc4/GuDJLttBRYLeoKcILTGJzAVb04p4Oo0GKGUpLRMGJU/XX0LUrYiHgRZERMJ4Eme4ZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxuodsM/5RBVjzwTBPJTdxfYRSPnIj/joQgKUALldNMbXDLfvQ
	1liW2WXDaPvH2RG+VBEDUH2UrMlD8MrcBWItH+4rhjrq8hnMbUP+TV8u
X-Gm-Gg: AYBFou0HkLEYnGvhCTcpGpZoKNPESchn+LIcls7twgtnSZz5RBzxLO1NDmenNWFVn9h
	l0+NaD39/50IIfzUlAvDLGt4jNYYevMR0bM9KIqMsy78D6QwY8AfV1Z+FVRh4ao1T7SdScwt2PP
	xbQpo/gRrKDKKtOXcG1YDF0IQRcOyif7mO5pJnUE7P9qujFZQpHDBHmYM5836Eon74nRtktm4X7
	Xz8o6EocZf02GAn7EyACVnSPuAl8oOhps+j0bX2FNUbQ4FVq9N1CZ+uv4SO5TUtEI6yAjJC0JwF
	eamuZuxM4Sg0OeZjg9FEl4KJsm81gf/mKtVQTMS9nWz7NOSNn4rs2+/nzU8ts5dC/xxQeOjpPy6
	a7wRwRDDRMHGBMSbYYBXWo+XsWDmxDqwrrY1mvjdTxSsdLZSReEZLCE39eXPJcdGUmAFQWmoUnG
	Ygc0vTK4UIlc57+fHfJd3AJQcrEovZoPbcuN8QO9Bk6R+5oXjR6FkR7GrjwGr6lU79sUXkFKkr7
	UmZyv8E5QtJFxOd3UD31iprQtgU9fkpZlE1348+uK+//sbjO80RIDqKlQp7dhhC
X-Received: by 2002:a17:90b:4a8f:b0:3aa:fc22:8ab0 with SMTP id 98e67ed59e1d1-3ab3a8e55damr9182667a91.38.1791855840930;
        Mon, 12 Oct 2026 18:44:00 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac38b36d41sm1060191a91.2.2026.10.12.18.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 18:44:00 -0700 (PDT)
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
Subject: [PATCH v3 1/1] Documentation: hyperv: Update documentation for sending VMBus packets
Date: Mon, 12 Oct 2026 18:43:54 -0700
Message-Id: <20261013014354.18023-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions for sending VMBus packets have changed.
vmbus_sendpacket_mpb_desc() can target multiple ranges, and
vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_getid()
has been added. Update the documentation accordingly.

Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v3:
* Fixed typo in the documentation text [Sashiko]

Changes in v2:
* Add vmbus_sendpacket_getid() to the documentation. [Naman Jain]

 Documentation/virt/hyperv/vmbus.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index 654bb4849972..c546e821ce6b 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -141,14 +141,15 @@ Three functions exist to send VMBus channel messages:
 
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
+2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
+   a transaction ID that is matched against a reply from the Hyper-V
+   host. Useful when the struct completion (or other rendezvous data)
+   must reside on the caller's stack. By invalidating the transaction
+   ID before exiting the function due to a timeout or other error, a
+   late arriving interrupt is assured to not trash the stack.
+3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
+   to target. Each range consists of a single offset and length plus
+   a list of GPAs that describe a logical area of guest memory.
 
 Historically, Linux guests have trusted Hyper-V to send well-formed
 and valid messages, and Linux drivers for synthetic devices did not
-- 
2.25.1

