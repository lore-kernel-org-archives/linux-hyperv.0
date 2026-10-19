Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0248383C
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399443; cv=none; b=HRn7W2DEngl3EoHGRk+fULRzCPUfPV5qbanb1eBJVPEjFMCeIN8MUUXJETF1mXkryAbiKQxoGMcdN9pc9NEOc2QPC5RWx+LnG1TQwq9iuJkUZGDKLCwO2p06LUOri8LZhK78w/H6m4cwnYGgMJa9TB5PLy4h3uaNqjtEJ7jgfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399443; c=relaxed/simple;
	bh=G/WYqugOJIA7KalApxRhJH5PrgBii+NstNqAfxEfFco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtDbDUSLPKK/sIJVJw/iBnleJWBFAZZrDfTjud7Bv2+QSUCAhn0XdSNl9SJsM2EYWh+gXyjIsTF+vqWtXjNb2SmgQIkMmNVio1R/CkoPpJPC0t6Ni2jYpf8XhC+7oUaVFmrUR3MXeUsKyp6GRMHBG7P+aMa/2Ezx9jHfx12uxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pazPOORL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pazPOORL"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso517635a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399441; x=1793004241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vsJwDFI4fV9Cu6p7SH38mcAbMCAojUaEaNIVM57aM/4=;
        b=pazPOORLxbU5N4fb6IC10slx1oPG8rcTAJNUFLBAy/GiiA/CS5d6ZsAtqBYkvyFN5W
         NuFjmz3Fc3MtkTqbohcKRlYUSpAt0cwxxO2qXbMeHnJwoCBq6JsScfnyE9iBLGIKpLtg
         hlDZ0Bs5ArVQW+xBQ+Skf2cjFyKdmqBUGbrCV9afpbJzlyej3RTUaguQMncUG6Yrk3Pe
         IKDiOyGSPTOL2AI2hFzvQyQFxzb8yGBMh1bVtFLkKHRz+r9albiEbCbC5HzQuU5icj2O
         impkj1vX+tDERDnYJyoa4/R5thCIO0jDqrKpxycY3IRjMTECI93dSfNG0nsbk46U0Q8n
         rdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399441; x=1793004241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsJwDFI4fV9Cu6p7SH38mcAbMCAojUaEaNIVM57aM/4=;
        b=clwzpIr/lX2dZl0SKum6evYCgDPoVhE5xmpfpchwnX7pUQfHeHK8No7CP2G9w/HzFB
         600t+4Q9yzxkZH2tXP9Rs1xpkOoLyqakEHOfCF7Pdo9X+kH660M8bBq/Ll2ycWF2LPdV
         o2vfeogVIIopBn50A5pe4akhGujeVExUXjCJXYyAgnFubmGG/ydDapZ6DAfglB4XRY+K
         5w/abNRieGRpjPOLZ58DkvlDEWI1AtzMCTz51rq/CIMpaRdsuGcWe9Bb/99xNsjWo9Iw
         SuYbeUwjWPwLyxBsb9CeLBt72MfqsdGARbveP0fmneCG7IVqkJPWav0U90qdZTx7Cs+w
         AWCA==
X-Forwarded-Encrypted: i=1; AKwUvBwHh5g2PnF4npO+OjC/3lYzRhKjEqHMpxoko2IJWscXB5HZWYWqU/6FQSO1mSsc/7hEeCjgiFhsznYBBEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkbJue3kBkhAO3jyXgWkw+ZkyXQbTR2qBOImeF0jJXYIDF+WS4
	jQ/sv5ycPpXZiZG32Sle145gFCmBu+/lcj/BqNBblm88nib3oiGeU/S3
X-Gm-Gg: AYBFou3I5x/PfCnlDc7dMlN9Yv35cx/iGrPzGGAw4NptmdHyge8K6gUugRI/KmJaHbm
	y7hj85NluZYq2mvYpSREduZ9vSocWbJ8rWhkWDWK1pFCQ8qd8/zzRo5w7n1GcnU3pUpbyh0w9cO
	ft5tSYbCyohJTa/szVPVVxQDRmjUY3bghxxPt3ktDXkDvEult5tvpE1RiXsgKpqfYdJSeojTgM8
	8DXGZ1vOO1rWwTAXzxYoDuVVnibeuFD72qz6R4pvR28G9EKZ1+l4bvg/340Wt2mKaKQ6DAXympG
	dMED1fxx9Tvy7xAUeLDyLU/9fW5lSjn0cj5wMuXa7SYGR1zNyYkc5A/s2tyEH2oxJ7oNZyZPfSD
	/k8+NqKEZ/17sO6NVQcsukNlKJYIM6rmfExQ0p33MRCJSXGLALP351rdHXKFOxLxxwR9vj4aSjm
	8jra9bkcnHSS9atTDZIt7PcBRpuaEKENiYyze5E8e9edDpaX/yB3aUBB/+1EL8m58d5fk29IyhI
	N1KiyKYw3k=
X-Received: by 2002:a17:90b:5111:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3acee292795mr6730180a91.8.1792399441335;
        Mon, 19 Oct 2026 01:44:01 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm14644858a91.11.2026.10.19.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:44:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mshv_vtl: fix poll waitqueue handling
Date: Mon, 19 Oct 2026 17:43:47 +0900
Message-ID: <cover.1792398881.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSHV_SET_POLL_FILE retains one embedded wait entry per CPU after vfs_poll()
returns. Two independent bugs affect that state.

First, a provider such as signalfd may retire a non-file-owned waitqueue
with POLLFREE. The MSHV callback leaves its entry linked and retains the
queue pointer, allowing a later replacement to access freed provider
memory. Patch 1 detaches on POLLFREE and introduces an RCU-safe removal
helper.

Second, a poll callback may register more than one waitqueue. MSHV inserts
the same embedded list node into each queue, corrupting the first list.
Patch 2 rejects a second distinct queue and uses the common helper to
unwind the first registration.

The roots, triggers, effects, and runtime oracles remain independent.
Source-equivalent KASAN/LOCKDEP tests reproduced both bugs and validated
the fixes. The local system is not a Hyper-V VTL2 environment, so the
series has not been exercised through the real MSHV ioctl. OpenVMM does
not exercise these paths in its current use of the interface.

An LLM assisted the source audits, fix development, and validation. Each
patch notes that assistance in its changelog.

Changes in v2:
- combine the two previously standalone fixes into one series;
- rebase onto current Torvalds master;
- introduce the removal helper in patch 1 and reuse it in patch 2;
- replace the obsolete Assisted-by trailer with changelog prose.

Previous standalone submissions:
- POLLFREE v1: <20261017141527.623376-1-4ncienth@gmail.com>
- multi-waitqueue v2, now withdrawn:
  <20261019070438.3732624-1-4ncienth@gmail.com>

Daehyeon Ko (2):
  mshv_vtl: detach poll waiter on POLLFREE
  mshv_vtl: reject poll files with multiple waitqueues

 drivers/hv/mshv_vtl_main.c | 51 ++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0

