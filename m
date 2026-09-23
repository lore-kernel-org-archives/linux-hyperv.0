Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345D4334AD
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142806; cv=none; b=E3T6OK6kG6fUdFTIqGS+FsyuHF5hf0+18lb6Y+/0HLO4ND6mLUFY0lnEv6si5KFXRrvcW7a/Q3kWz2pg+hLJ1Whblb5uZN+QrVmS2KBoxtRAv6nOjxPJ+Iwrbf8Br9dyYdVGiYPvgfNvO9jec1do+l8u2hZcdIvyfkeWJS0rgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142806; c=relaxed/simple;
	bh=xX83Qv2GNCSFmPnn+MxtgCfH/8/LCmxa144mvyxtVdg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MdWYVsQPYosJlsvjxEXqogLG/dyThAhgl6Fh+yr1ySzCGm9xAGiu/54e4Ifn+077FK+DaQMMHuQHiLuUt0RJh+SKlZ9sU+SWJwfEqkg4jRQse73Oy8fTTxPqbZaMGyrbBaclFS5l8+rajZvzR/T0d06BPnqx3QXWOniG5fNf2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnlBdlTx; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnlBdlTx"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so6443305ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Sep 2026 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790142803; x=1790747603; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GR47YdXkcI+qC2x+J3l7J/ws+MnB/O9JS80C2XvYteI=;
        b=wnlBdlTxED5z4Ybjn1dVsjk+R/0rQQSqhojdfCDwJYGGbJIvinpwjGXOq+RK9orgGd
         f1sTe72f799hW0lz1u4+9Kngafi1qTX6Jn0D6ZG7qxokIVbbs6TAHLK3C7aT3eUyz7/k
         8iIbupyhvi5wBSZJTOUWcnOgs/x6JhXl/u+0Inv3VubbrR5lsM1rtw6TBVedbrxaaoj4
         unl4ngp5s9aZBiWlSHLH7H5guHMdOXU5QmpvO8lEMkasaY41JyFi7KEfDrn8TaRMvhj2
         Mrr41Z6nHwQHDFXLx3SUWWYUkrqCjnORE2OkM3oobJliSpiLIGR1f8vlnDS/LtuG/eDP
         0hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142803; x=1790747603;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GR47YdXkcI+qC2x+J3l7J/ws+MnB/O9JS80C2XvYteI=;
        b=o+weNkUWGn/CuHueF3bfYHeLetq+2NexI/1PEve9xMJ3cZeREv74kVgc+NpVNsyZEM
         bS+UgnzoOHI2YawswHgJbbuIJKlyMpf/SAAiey1kXm8A2I4sXTRe+vw/FeZ6NKoXUqWJ
         zMWeaHCZh83wU7Dty+S56Te9z7fDpPUwnIndjwqit8yDC3uRM/qGnZ5Ekkzn4KUNfhp3
         roRR3KUVH9uazx6khFEz1ZZpRiv66qf6m74wTsp6SlHe6WwewvNI+wOYssqala1g+msQ
         sZIdVG8j3K/VWXajfYFbPrRbv2IDjdXSDLiQyAwn4gv0TKxWL93M2TtPJsax0lAr1fpq
         SHuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAldHl3ETk8ZcjcjCF+1CSfa/vL0uNrbBbDShCzbNhgSNkoQaXI28TzhrR6vdelHzW2m9sbGB56Lw7azw=@vger.kernel.org
X-Gm-Message-State: AFuF++mKsshMX/LkVPI3K+h83kQox1TCLPSzxiRUCgrkrm2ryGSdy7iJ
	MxLMV4SirV8ik5wmf2s7uoURL9fGYzqJe11pZs+ug9aEmZLFnIhCW+/XO3vS2hzfKcE6zNKP7Ap
	P
X-Received: from plmm2.prod.google.com ([2002:a17:902:c442:b0:2df:4477:df93])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:946:b0:2d5:e3ce:3988
 with SMTP id d9443c01a7336-2df69d3255cmr15603695ad.11.1790142802442; Tue, 22
 Sep 2026 22:53:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 05:53:20 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923055320.2602534-1-morbo@google.com>
Subject: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Add the "__counted_by_ptr" attribute to the buffer field of "struct
vmbus_gpadl". This allows compilers (GCC and Clang) to perform
compile-time and runtime bounds-checking when KASAN is enabled, preventing
potential out-of-bounds accesses to the GPADL buffer.

The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
exactly once, during GPADL establishment inside
"__vmbus_establish_gpadl()" in "drivers/hv/channel.c".

To ensure that the count field ("size") is initialized before the
pointer field ("buffer") is assigned, we reorder the assignments in
"__vmbus_establish_gpadl()" so that "gpadl->size" is written before
"gpadl->buffer".

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/hv/channel.c   | 2 +-
 include/linux/hyperv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 7e4cc6f55237..7042de2dd481 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	/* At this point, we received the gpadl created msg */
 	gpadl->gpadl_handle = gpadlmsg->gpadl;
-	gpadl->buffer = kbuffer;
 	gpadl->size = size;
+	gpadl->buffer = kbuffer;
 
 
 cleanup:
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9e109d91aa14..408748a05440 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -780,7 +780,7 @@ struct vmbus_device {
 struct vmbus_gpadl {
 	u32 gpadl_handle;
 	u32 size;
-	void *buffer;
+	void *buffer __counted_by_ptr(size);
 	bool decrypted;
 };
 
-- 
2.55.0.1082.g2b9226bbc0-goog

