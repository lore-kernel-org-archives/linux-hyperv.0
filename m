Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D333563FA
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455720; cv=none; b=pgePN3I/kQZhKu2oi+3w57F4BrNVKJ+pTwXN247UbLGmRO7zEye79jlCbsdOiqP3bS3Ph4fj3Su6gmpIGW4GQCn6T/mOCm0bXKDTGtWbb9UU0NKjCUaEf1MCGhFNKzssngBLKPueOeGXLt7IJCcM6NqM5FVUT4aWy5oot+pHORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455720; c=relaxed/simple;
	bh=SmVFfhSX65tUNLF4crAjZPrJT+oXElV9Xhfp3R7sQr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzwH4GlXbpp4cxttL7iXkYoojZn02aWmnZ0Usa4TZjOoT1CZsWFm+iANi/rxyT8oBPPmUxiKwT3A/Mzkm78riKGBTye+AFkvWqoxqCHvYXqgr4TVQCeDXr0ZEo1J35dbOTeXkAhgoQAd+lKUhIZyfJ88F5Pep083u8dywykRuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnV/bUZX; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnV/bUZX"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso2903124a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455719; x=1790060519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hXwNzmZuh9VGj26rZAssJYXJ3fSJyHCnF9FFfAHDC4=;
        b=AnV/bUZXN3SEQVnsE7bKDVhdW1CSEubeM7H5Sjyan8+CinWRj2BYIfq8V0MSVBfSUi
         AN5hNoCPvPK4B3s84pStsAU/JnrOSMzZkuUWi+aCfs3GngcLmQKIFy/S3tFDxx+t5uWn
         S+idbYFAVWyE100qyyPdOMaZgmTh6vOF/UIBdoYuk7gF32v1kQKY5B3e0na/5hALz5Fu
         oz+G+T47mD+Siy9rcBGeVev+UGinLUlbRbzDEqBL9jryLS1KifMI+e83pzCTQVqDNYjI
         jA40FFaWazxaJWZhT94boUD3zSnqjheiLqrqQRqE+0AEvV48WCTVrNfql9w9mSL0ENB3
         VcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455719; x=1790060519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hXwNzmZuh9VGj26rZAssJYXJ3fSJyHCnF9FFfAHDC4=;
        b=VaiLKVUHX9VyyVNLZ54Sgtu2aEvQBlldZzNTx7Eiv+SUt1jVFOO3BNNWJT5Nu9ub1d
         H/EQ5YfPKiqboz7+CZ/8fgcOYe+cfSNoaYWZ/quSAcOKWEV+Qah5ztRYOrcriMizLs08
         i+qfubIYKfepWKUHhWDqPzwx+DBI+omP27C6OAHOokWWqFNQRBWf6iIiEPmqQ/UddfQZ
         yRmezJIkr2iWeuN/rSMdFbaxrq/LLUAqpBfBm7JGOnlR4W6Nq1SDMmAbQZp1UjO11UiQ
         SyYIhGBzneGFE9NLIO3tSjDxIc5z4E/eYjrwp7X/ajcL2EkfrYsNm9Svu/MqQVPuBpAX
         8ytA==
X-Forwarded-Encrypted: i=1; AKwUvBx6JPx7ZSnioJvPFyjt0O577imB16I06jI/X1gYiyYILgTXNSimX4KgvzDjAH1AY5oCsEurBiMqut8lS+k=@vger.kernel.org
X-Gm-Message-State: AFuF++npNgGnahZkc3H/yngXY0n/LbXjKm3egc6NROzXw01XcgZJ6VGQ
	g7ugZ16wibzA0XrY0V8Ce9la83sc9axhxs2bx41CSPN1dqXA5ZUgIcxC
X-Gm-Gg: AYBFou3rZnb8fYzkTNN7devx5V7ViR2XbvKnYAKj539/JJScOKpBoZPb1tQYMSnSfSX
	1P05XbJQ/HzAtTQNDbvuhr/hqsZg3k0pdFRe8mU7XypYQzNBOhxs3m7bstwgDDkRk/l90r0aIW2
	7MmBJ56iJVHZKXpw178rKIBvRww2Rmc6sB1SETv8i9vYjCXDeJYbu+dd/IAkvBAZm1nJn+mUax9
	qTY2EMTQmo/cAKfYETzrtUCwkjMh+ZGIEW06avaq8VKYc31QQHNsuBuYJ1Oi66D6+7UMoe6A+6p
	j7nNo+B8Vk61LLWdbpl4AaVHJ0mggpkDdmjcZkIleBcEw0NjxN07+1wY1eAFiz0mIb8sGVcwnFO
	6HPy9hBTeyum3uimeSqVvlGk++54Efs9n2WmAxIsSO4Vb4qjC0oDi0CNiz4JIigztHBwDiT3Fmx
	0vImp03b+ePha0ZoUpPC4a0akouiHFfFRHPfXpLcxZs+Oj8B6muAQ9Na/ZFDi120eC410AEfBKf
	mVzSEaYxTrEylBENVJYhOgChlw=
X-Received: by 2002:a17:90b:264c:b0:39d:f18c:1ad1 with SMTP id 98e67ed59e1d1-39df18c1bb5mr10762706a91.3.1789455718837;
        Tue, 15 Sep 2026 00:01:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm56553791c88.12.2026.09.15.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:01:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tools/hv: fix typo "retrive" in comment
Date: Tue, 15 Sep 2026 12:31:45 +0530
Message-ID: <33db65bfcef30cb347a3e00b152dc4bfdd0bf288.1789455635.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1789455635.git.hemanth.selam@gmail.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com> <cover.1789455635.git.hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "retrive" to "retrieve".

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/hv/hv_get_dns_info.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
index 268521234d4b..288821565eee 100755
--- a/tools/hv/hv_get_dns_info.sh
+++ b/tools/hv/hv_get_dns_info.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-# This example script parses /etc/resolv.conf to retrive DNS information.
+# This example script parses /etc/resolv.conf to retrieve DNS information.
 # In the interest of keeping the KVP daemon code free of distro specific
 # information; the kvp daemon code invokes this external script to gather
 # DNS information.
-- 
2.48.1

