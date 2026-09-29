Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB043A901D
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705472; cv=none; b=ZReuT47rKGdrTU/hKwC6UqfT31r38xTPEjI8RpKTxVhy12DyzyhanWvJOebfQNOGrL5abf3kkeBPRVtRzbQh5srvXGPHfTCwNoXEDsLoK5m9WTNHL6UEaQdCYuIi1s/a9ra2VplDf5TmzPGBVdHS7KKTxjGuOdbInHhyTQteQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705472; c=relaxed/simple;
	bh=bFC+TshhTmM0v4253iAy7r1VYxcLXC8treYolVAgLgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTk1bjTV2XKmh2XPPH8c5NqkAEs6Ch1TK1aESIpAKUPnd5rMo4vBBvPxQFeV4IfzLp1vx9x6LEVL3RDStaoFQ3YYN6wNVJGziZtf8BWNkxfVbxGEOGgVQy6Jxyz3q8cnVB+qttaziqBKvTn6sTDfSB9wqP2gfC6ryixxUVxhenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2QO3N/y; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2QO3N/y"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so1935063a12.3
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790705470; x=1791310270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=r2QO3N/yy1gTU4TdtEND5KbMyxGJaaa0GqoLLmfW2PJYZO9FiqOjXHKNeioo/SEya9
         69YO68PyWk0FV2blPUiLJFmO6tDGKTxN9YnVnxtaQ4JvQTRnadn8BhHRJJ9RiUrdQea4
         69TSf9aLC0Xc8o9vt5tJOnK4lmJCFG6ILmO3xarxX172BR43Kuk8Rb188/oXYz8arUDb
         xW/u+E88awQYcahT4aVnyiAWbBWzJ90LZ8ZiOYLJOx8v2dV2niffUHSVmLyPM3Siip7U
         IKX1FCl5iL/nMSfORbJPxzS6APRi+1JCopuQaAZDFSG9S9wYAFTLGxfY9mEVfWluStkJ
         kYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705470; x=1791310270;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=hWR2w7McGn81nQs7PQ3yqcyxrZ2PVUKtd0LKUNZiQai9WVpxeTmeFLml64zyn00ocT
         +8rWtWkp9yKK92qME9A957ZaQRYHUBX6TiLwMGzucL3GOX/6bynRJdaX5z5cnGZkNpV9
         JubJyWh7Jg2OVItH/Cm/nSUUQgNWKWCEMWL6yUXFfNPoH+kvMaHPfXYRMMPAjRx3iMfH
         o2Rigido1Z1mYGzlkR14Zwx/jC5x5c89XYBhq89bOEl3bb4lA6u9pL9A6xR6b/g+3/ch
         J7Rr40AuJrsp6zSzFBaR4MeZ1K7zlPxAbx9Oo3v368HtqTObjatsR7xWBD7IZ/WXffjE
         U1NA==
X-Forwarded-Encrypted: i=1; AKwUvBzL7KLiKkxNMXjWuBxkYrR9yA9yRumYLpFjla+9H3VMPL8uZskJo28lpbEEjKAMgli9kgNKL/LSZRmdgbI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYo67b6JOwmTw3+LOajTzpz88+KXSGOlxweCYvc4dneVam2QN3
	8TRok5SSbuJtgkFNWS30I9bAGFyg8FrRieA2CNHCy1rjZ42HJPRTCziM
X-Gm-Gg: AYBFou2tm20/tfOgygs9hD9vJqMEILlq8L/j9U0f1oO+N8y2uPM20Dour9hi3BNl+8q
	e18fy76/78wMJKICPxB+DaIj5mEEb9UHComjARX/6gXnXQbkUOPqijmp3LdKcFtV12BHfQZMVPP
	kIce84H/aO2ZdUM93bgSrx/kWuR+/KTwUlamVJJJzbcOpxlyHC3HUwbQwQ0M157rIsFCfIr/qPJ
	KeAxvJFA5i2pFViohrVxAomr4NOfIghrvkOaXg7yQp6eFdgTLqW8sJRLM7QCvfmey7d/Ut7QC/A
	Z9BVVQpNLs0OmbETia/TmHfHStJnCkMBa9b8S/N+qZWrPMgyaLf4a3vK4094E9PCHEQ7LBI0Twn
	ufbaW7evQnxs0afz+Ojs+vaBfUzQyW0Wttf4s79lpLlz/ytm81S5wt8LewGBuH2B2mgJ+eDV9Rk
	PKtL3NkrWedJomJkm3nn10Fi4v5/8bRAoOG+dGJyifCg55P9Ai9OVpCbOUWW7DhhVjWE4RZkE0O
	yTDRAKH9BPpFll5R7v0lM6CHCjrKCq/HnjSDZYxou2nWeK6PgIplACxH4rZq/eX
X-Received: by 2002:a17:90b:4b87:b0:3a0:c13d:8b2b with SMTP id 98e67ed59e1d1-3a4bfedd2fcmr109934a91.33.1790705470160;
        Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm6914590a91.14.2026.09.29.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:11:09 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
Date: Tue, 29 Sep 2026 11:10:56 -0700
Message-Id: <20260929181056.4746-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcibios_root_bridge_prepare() currently has code to handle Hyper-V
guest root bridges with the sysdata parent field set to NULL. While
this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
Support root bridge preparation for Hyper-V") was accepted, more
recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
device to PCI device") always sets the sysdata parent field to a
non-NULL value.

No harm is caused by leaving the special case in place, even
though it is no longer needed. But in the interest of overall
code cleanliness, remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch does not just do a revert of 7d40c0f70d92 because
an intervening commit moved the code to a new source code
file.

 drivers/pci/pci-acpi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 42d545edd7fa..452a90317c58 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
+	adev = to_acpi_device(cfg->parent);
 	bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.25.1

