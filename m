Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE519377ED7
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756594; cv=none; b=frHmtyg7sfbnTuoILIFgOWkYlpfUhphPe/qvFw0luQuRA72wlc9fZxdhtwqmibHjlCzuBxcg1Ii16xazzNLs//wpGLNdaPUBlU9+q9DgCiGJZGYlKOetvOwYO5Vdd+1sgwkMN2Vf4IZIBmiISJ5uIGUKFzu6Fb0P7G3LZ2UFU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756594; c=relaxed/simple;
	bh=kUqvJYmPAeHmEQLK0LbbqKY8SPfxqMl8bBWx7arv2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O74r0wwERAWkAYPaudeSUxi1klM0eTGGJMpblKLu/kkHZgP9k0K6BKR+jXhanunDg6qzMNPfqKpmqYEOngO9k+HkXV7VR/KqQI2/R11rSHkdwD8Ws9zYSmqysWJcZKPvq+d2MFw3nRK65+U9bhSVSKczjy5Sq8LWH38wZ7Vj3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVjkQAvE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVjkQAvE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d91ded8174so23633145ad.1
        for <linux-hyperv@vger.kernel.org>; Sun, 06 Sep 2026 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756592; x=1789361392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CfE3tFMihN3EBImlkt3G7IMkI+PLQD4mkC8iY3FVKU=;
        b=SVjkQAvE85LQkmaCZKHf98RWOtsDZmImF5KzIZMIplYXr2dYxenvfB8dlAsFDZvOZa
         CLal6oxcnlEK77XrkhGa6P1/5S9Gi2HpEuK5U1IMRw3hpk36BrPaPV6h6ep147d3QMss
         BCzr0S4DdB8h7uRfubhjYR1pLFVtyLu6WAc8UJZdw8kLla/0dGEWrLw3iGJzQAtCUI/A
         YD7dgC/2AoXwiR5Zzk6lmcovJ1v3uyslSsOuhn3De9ClIj5oICENOisuWF4iI5Gvv7XV
         lRgb/cCixsyJNTlb5OQjmJb7qRHikBNDaRq6I9YdFJouCuFoT1k3VQIAKw2Ps8Ea5JiQ
         T63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756592; x=1789361392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CfE3tFMihN3EBImlkt3G7IMkI+PLQD4mkC8iY3FVKU=;
        b=pV5eEmRrLAmcGdvPn1DdjBGBL4b1mudV/ERgStJtsoq7c6yoXLkCZDw7CYFg6U+1Ut
         mD7awBxp+GFLVl4NOdbZHYlk38ycNxWCYhEAo3AcnIUpmN/pSf7vUMIwfMw/zFxMDu9s
         Fj1vGlSXr2XvY/b5xkVmRh9BUFUlyu64hoTaL8QnzYoRtGAC3tyrzL4oTzyqUZ79ZfCV
         EAWQFZVdcnM2axUp06Dmu9NkSDHPOWRDs0GNGNf7f1si4pGzvg3ola0cTm8STd0Mlff0
         62uHDKaHNAfrBfo40HC6zxjeZ60T0WJgOD2kdkMXZqAT7AkxBJ9KpMghQUBeTSTUyYPA
         TqiA==
X-Gm-Message-State: AFuF++khibrbTMukc3+ZMYuxzCudQ5ctdc45OukijBNWCVP3fZg1Yono
	MpXHRlxTbe7j0zhkKH5b2tYNru9awBF7mx655RXWEfYUr0iPSDKqHBUa
X-Gm-Gg: AYBFou2WydMVKz3I4OaxQCdINM+Q4BYFp1sA28yvN4hXDBuHyKSeY6JXA71isCqcxWF
	jLwRTR855qFwYh+XSsFzXeZbqoHhbhtg002uXBakTPYp3RDtc6/UP/FG63r7wjBHxYc2H8CLeDA
	gQN+BxK7BiOqTsOJAMimQIQgAwEjPVD091bOIQBG5NPh4MswdKBcbPfQzp3wdYip+WX/wIoRVRP
	NrmjsgHfWsO0cpl7H8eNkBhOZKe3GrgcWRgP5YXF0xRMkOVEa0coVYBOfwPvGbhiXeClUgvHjet
	pBLhq+PsXUByZl4M2ehjUFxB319msTjYftZIKSgpyAQL07O3YUxaNvRjxP8BliKJBqn2RipWfv2
	qJr0X2vpRDQHNt8nIblpea3ha7MpYW9T4jymxhjnEWGc4FWzNUfyKF1SBTmR2U7VYbTx3mO+AdY
	tzlPPKZk/EcyyHvVpsKcHHKQZVGV0Rw1MM489Qr7IjtWaihfosWcHNEXon5EGJEBdGx/3/2ws4u
	xVI+x6YDdHQ9VV6LfDS7yUf
X-Received: by 2002:a17:903:1b47:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2db124ca14amr305686505ad.9.1788756592084;
        Sun, 06 Sep 2026 21:49:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm21501484eec.6.2026.09.06.21.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:49:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: hv: fix typos in comments
Date: Mon,  7 Sep 2026 10:19:44 +0530
Message-ID: <20260907044946.10813-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the spelling fixes for this tree.

Changes since v1:
Subject prefix of patch 1 corrected to 'Drivers: hv: vmbus:'.
Michael Kelley's Reviewed-by tags are picked up.

Only comments change; no code is touched.

 drivers/hv/channel.c        | 2 +-
 tools/hv/hv_get_dns_info.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

