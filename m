Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDE3783C6
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756597; cv=none; b=vDbejsf1HBBN/qdl9hr1R2V9TLZHHZg4KLnRzqesh5n7rAA/6T0+e1zali50ZgvpuPSBZR4ga9Bepn6x4q9330XUGtc3tnPR5CDKBNdP8Ul+bQep29hFGPMcZJ1yMPMYAwyGs1TzQDEQQIM+jh50GFCK3ZkYspP0LI5W7T+hOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756597; c=relaxed/simple;
	bh=MufJgkHYL+VNIEsgNZPce4x2p1dXEPQuvTjqk9RTdjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2O+N7dZWbphl8VedhYptAYtnTm4AyHfaUxxL72CSDv7WnMP8IghMRxwWir/r3/SzwlqJn1AHdk0EbOtftUcm2bWQjKerLRpJGGoq6YiJ+dF8SFAXU7f9iRelidStDYOS7k0jWIjsGm1Uuk8hQAHmOFRvv+L/7VJcdzzizyrzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWS5Ki9M; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWS5Ki9M"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1991257a12.3
        for <linux-hyperv@vger.kernel.org>; Sun, 06 Sep 2026 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756595; x=1789361395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdOEATPtEQel+h6L2ijhx9rvUk9Oqw2JLvQ6upawX2c=;
        b=GWS5Ki9MFtSjrnBbsh7IGk5MEeD7CVTgRZ+9wTa541vhCFEn+hAgx4h4gwnrDMx6q/
         7+SdoV8/N+nS6UL90woUnWGPSsb2CQzgiwK3T4WhsPX0L9Z6UXhgPfWYKJTki0+B9vMQ
         Yvtao6xJwHJj6LQNqzbE4ywlBbdcEJ2BLYxf1pg+Jd1lIITzp8kiawIq2M6rANs4DvxB
         5TnBjmsaa13R7M+Ecv8jR4hq0/UIHTrMrOiJmrMzPwbV4pByKlPFc2izCH5PLSNQVsmT
         O5g787UGm9fvnW4YnhmzenjCdCsMyz0drFLuadN3dfRZ8MmRfv837ajFaLpUx3NT8Tin
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756595; x=1789361395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdOEATPtEQel+h6L2ijhx9rvUk9Oqw2JLvQ6upawX2c=;
        b=jfND/1AAOj1gUT4+pUi0tJTREmvunYqHCDuo4Muz9sZAS1tugJM0mUTlOPnlJCSS0i
         3BQCRt3e1k31xgBM/vgfk1AiRwn18/eBjNnZE6Fvlo5fuXvwQkjCDHto6GOOppVRxvVJ
         JNLfORA90zLys98Lt1IoZsY9+kL5ylJ/29t3fNZo/suB0diUkLq8qyOvoEbva39SLjri
         tuUdoGpTY0xT4jTBXvYI1KxJVJyqmX/i6AISESETLApwwhCa00v70/ynwhtn7kMrPKME
         fCmq5Nh5c6i79CeGxFVg8Romy65cGrav7UxmAKKbfU9jszz8LUb4HOEdj38GAiDQuT3q
         afng==
X-Gm-Message-State: AFuF++nhvFP8tXrThJBS7HGJtRGqrBV3AqQZANCd6B9dkmW0GPhjsqli
	oA0N8hVz3VMXiw1jx59mRY+b4e8eoNmleYFTpCq/FgWu/8I4L3/xTQGwAEcPPoH++GA=
X-Gm-Gg: AYBFou3UJxIgTrDnwdKzVQeasvvyQJeYz59P76E9LR4hwyoC6seRm+lBt9O47eT8q3H
	ANddVENj9Zt1Fi5OKH2eRxUmvzbYBVWeVp7Nu7MRCzoSwxz5/ALrEI7RIn7109rPNKwFoBZ25WV
	XXCGu9f/C3cLJdgYLWLXSxaowCgaJuh/HBQtQHOzj75KAGfMr1oKbyP/DVvToa3P8kcBrBhsk6I
	x3V7/qKMDcginaxNR6TXsSd+2SRM2C6lMlFKrdl8nyp1uEvp2855irGLZb2DdhyNk089hWYp1Wf
	+xnwRe9JIQTxkLmx7mZWnzIRAHmDEGlxdnVIl2jz6VqZ5hNiyRQwiqna/0e6EwlMIEse9lJLPxS
	P9anKxY8xKVCgOH5QcUvvxICxcNm8gnWt+ixsTT8W/USj2+AjDellLL1Uqcdfx+pFF1gV3aDjPG
	uyfvbmW7rGVpF1EFtbkhMhbgzaRI1aU8+aspGC+oXMt9cqXzng9G69htzRM2TtSyNftOkCRR8jf
	l9/dz/8xr/e3GY=
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr32748395a91.24.1788756595436;
        Sun, 06 Sep 2026 21:49:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm21501484eec.6.2026.09.06.21.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:49:55 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: fix typo "substract" in comment
Date: Mon,  7 Sep 2026 10:19:45 +0530
Message-ID: <20260907044946.10813-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044946.10813-1-hemanth.selam@gmail.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "substract" to "subtract", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches a comment, no
code changes.

The subject prefix changed since v1, from "hv:" to "Drivers: hv: vmbus:",
for consistency with the rest of the subsystem's history as Michael Kelley
pointed out.

Assisted-by: Cursor:claude-opus-5
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/hv/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f4370617deac..c36ec14529b9 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -79,7 +79,7 @@ static inline u32 hv_ring_gpadl_send_hvpgoffset(u32 offset)
 	 * therefore leaving a (PAGE_SIZE - HV_HYP_PAGE_SIZE) gap.
 	 *
 	 * And to calculate the effective send offset in gpadl, we need to
-	 * substract this gap.
+	 * subtract this gap.
 	 */
 	return (offset - (PAGE_SIZE - HV_HYP_PAGE_SIZE)) >> HV_HYP_PAGE_SHIFT;
 }
