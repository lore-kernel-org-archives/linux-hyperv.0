Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E73DCD90
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321761; cv=none; b=muM4L4h8WEitK+T8kogv86NiSi22QfH50+smRR/en0cHqNq0Ow/DBaK0PnrDFyrtUx9Yxx/H54rQfGEz0czoPekLsXazLIJGMrczNM9DwRbm8G5Dkrc27epd4EMGtyT6QLgTldOaDKXa7iLcpGfLb9hDTth/gihRstnMb7gYbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321761; c=relaxed/simple;
	bh=bYdiyUxQ1xXquRm8oNOGsZfeYsTcAGZLZoxdSt1Er28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIiAoJIeF/THYRURkHLyuJYSAb2RyeU80BMg5Y46w0lhGUvHeUVKFTFWs3DdIqxfO2wa9UrvcNDME+Nybkwn65Vse3utGK9usK/otYkW1d86FYdlUV8SS9LQalTzG9rC9t938E7DWVtp/S8jwLC/cFt1mHs96Fh1N3zMdOjadNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOx3yF/3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOx3yF/3"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7fe723ca5e5so14477567b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2026 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321759; x=1782926559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbwnK5C4I/+GGTcPtzynJG36TtlPd9rOiV4o4AgC0tU=;
        b=eOx3yF/3ST4Djc2akpkUeXbEwHHH9rKceut98O+4PVBo6U1TgLm8jxmFpsUJHPyNqh
         ElAbjAk3MobJSgoznGbNRXT3YjdL+7z5CSWtc5uVYv46iud23dHffeA+GS79LuN7Q5Br
         wPwrXu5ZWtn1ezAUohAKh6/W+a4mnnlomt6yKTFHJGus5vxifdZGLD1s10+B6/VoB14K
         xQgpTBy990/gugnTOxhFgBRbQCgXwoaVDuYwlKMHDrjdwxaXdCiJeSy1ImapiDLDIxx6
         gLt9Q82/5m4NE+IT3V3xG0/60A+YQcKO54HyxxI0ZfMciwngvP11pRMoaGxVSo+xpxmh
         vPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321759; x=1782926559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbwnK5C4I/+GGTcPtzynJG36TtlPd9rOiV4o4AgC0tU=;
        b=sPA4ClJDdH3AS96wHCZLNFxGl2MOdh9/nPio5y9OtnAmhwr6pKIkw1vbT3iWS+y67B
         9ytTpUrP2uwUkeoekANkeB34nztEC3uYISreTsprr/FLr9ZMz+oFSZxBemvRUZTOD11C
         2pmfVNepKqe2Bty0RKnW9iKw4z7AaU5cW6j6po/2a4e5OSxIkfXop9iq36G0WyRtarx1
         6ZQYd+E1zPJjsyPEmsGs2/SigolByDJICA8YRrQB8r2g6zsaXN3/sZPAGnZFvuGrtevQ
         dp0V2NqjIuNFRFR45BDFHGukSvbfLWngXOy3ZoIhdRVSp/VIUCjLsdfwn8foz95+rvzS
         nCQQ==
X-Gm-Message-State: AOJu0Yz0gKpZQdQMNIgBf4Z6yfmtdl11vH0fB+M+xafVlOyE8eHlTE3K
	K7eZ8nDxkHGFqnadWktNVjK7u0tD42041PCCBXYIo0eW0dySjS+escBk
X-Gm-Gg: AfdE7cmXauCXVxOy2LvRhriLiBaXiC8m1BlxmTlI1vxT1LgZacrvsHAYzevB6RSbkYn
	eUQNwhCPjpEwgbCAW7tWAHcEsTF2GQpbUysSesDDhWAsRaNc+4qxaEz+MQaNfLFL3RTL+059zZ1
	9rpCklillIlquIwI5aKd5NglGb1w/t78Fy+KJjEEItM4ORBEuj1LoxwnfaThlcUK0HJBJ92LEn9
	zUYFyW5Fhu03GhvYKJKNOZHbhcYkpxnbR5r9TmFxj5IL141G38V/os4i5IFu75O8i91n/3hjW90
	GULMMgXo/PGQOEVu8ezEFtqgSrNOa/WMHyqmGgdmK6rJNHdBUAA8lxru/Hma3RQQ/WkVeDVEsdm
	zOCREhgFqnapPWAiqkBxPzxZfWImsrdn0OGYAaCq01fxsJD36T40WD/df5FTehBdgTg7c86KM7O
	Y7msfZzHpsaLr4zvoRS2xuN0xqWw==
X-Received: by 2002:a05:690c:6885:b0:7f8:7e60:acf with SMTP id 00721157ae682-807ef918a25mr41186257b3.52.1782321758845;
        Wed, 24 Jun 2026 10:22:38 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c96fdbesm60985327b3.8.2026.06.24.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:22:38 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] hyperv: mshv: zero VTL hypercall output page
Date: Wed, 24 Jun 2026 19:21:57 +0200
Message-ID: <20260624172157.2790-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshv_vtl_hvcall_call() copies output_size bytes from a freshly allocated
hypercall output page back to userspace. The page is currently allocated
without __GFP_ZERO, so any bytes not written by the hypervisor are copied
from stale page contents.

Allocate the output page zeroed before issuing the hypercall. Also check
both bounce-page allocations before using them so memory pressure cannot
turn the copy paths into NULL pointer dereferences.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hv/mshv_vtl_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 0d3d41619..0365d207c 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -1147,7 +1147,11 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
 	 * TODO: Take care of this when CVM support is added.
 	 */
 	in = (void *)__get_free_page(GFP_KERNEL);
-	out = (void *)__get_free_page(GFP_KERNEL);
+	out = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!in || !out) {
+		ret = -ENOMEM;
+		goto free_pages;
+	}
 
 	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
 		ret = -EFAULT;
@@ -1162,8 +1166,10 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
 	}
 	ret = put_user(hvcall.status, &hvcall_user->status);
 free_pages:
-	free_page((unsigned long)in);
-	free_page((unsigned long)out);
+	if (in)
+		free_page((unsigned long)in);
+	if (out)
+		free_page((unsigned long)out);
 
 	return ret;
 }
-- 
2.54.0

