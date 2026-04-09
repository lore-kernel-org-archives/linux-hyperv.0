Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472302BB13;
	Thu,  9 Apr 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730749; cv=none; b=qGDp/WbFoLwMAnsW4Q9bKVkVW+bC7ZS4vC6345Sl/0gbz/AkaXBbL3q8uOg6fO3viKaJMFO1fZbwLOMjsIMELvaAZUL+T7Pz3SfZcDoIgdJ6E03Qg72+y9fVrlVNwZXyB2ef+3x9kM6dx+Ph+CtKJUUx+2FRbIhCPVGnZG5v2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730749; c=relaxed/simple;
	bh=jzk+gdL+6apqERAGBImjqbpLl5/+TIGKSjoBMfFS9Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzcpKsfRvc7+d1H9LVVpBGAb+wjeNrdR75/Z7+mJR+fXWW6e6tL1PjSKzUk6Ww9/iR4uS9Z+78BF6FdXOxvgL4OeVlrF3eRCzIquujDc1suK5IUX2XxdKtexO5deO/zgRC30WJoYKdrkwqrhKyxjiRXiRb1tYvaMaDZiQPPR/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AR3qNCNp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AR3qNCNp"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 1A90E20B710C; Thu,  9 Apr 2026 03:32:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A90E20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775730748;
	bh=bZXHijE9C2IWPloxfuLcr2kjLiMequTcReTXwpJbWf0=;
	h=From:To:Cc:Subject:Date:From;
	b=AR3qNCNpAcGfCMgITVpKEexgUies9rpvd9MoxyWZ9JBWpHkXILV3Hw8ap+RGMP4PQ
	 23MO3lXc8CmvJ/ZyzxGjCD/aI/vSksVpLDtQ6ZvMXiigbaxn8y3gatY0RP31lTamVo
	 ckkmaqZ/Bq4NQimJJu2xKCQqtFHVeSaebagDniEg=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	gregkh@linuxfoundation.org,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avladu@cloudbasesolutions.com,
	vdso@mailbox.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Cc: Roman Kisel <romank@linux.microsoft.com>
Subject: [PATCH v3] tools: hv: Fix cross-compilation
Date: Thu,  9 Apr 2026 03:32:18 -0700
Message-ID: <20260409103218.367589-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the native ARCH only in case it is not set, this will allow the
cross-compilation where ARCH is explicitly set.

Additionally, simplify the ARCH check to build the fcopy daemon only
for x86 and x86_64.

Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
Closes: https://lore.kernel.org/linux-hyperv/PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com/
Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
Changes since v2:
    - Handle the normalized ARCH=x86 value from the top-level kernel Makefile

Changes since v1:
    - Dropped the info target printing CC, LD and ARCH

v2: https://lore.kernel.org/all/20260407122040.249733-1-gargaditya@linux.microsoft.com/
v1: https://lore.kernel.org/all/1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com/
---
 tools/hv/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 34ffcec264ab..016753f3dd7f 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Hyper-V tools
 include ../scripts/Makefile.include
 
-ARCH := $(shell uname -m 2>/dev/null)
+ARCH ?= $(shell uname -m 2>/dev/null)
 sbindir ?= /usr/sbin
 libexecdir ?= /usr/libexec
 sharedstatedir ?= /var/lib
@@ -20,7 +20,7 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
-ifneq ($(ARCH), aarch64)
+ifneq ($(filter x86_64 x86,$(ARCH)),)
 ALL_TARGETS += hv_fcopy_uio_daemon
 endif
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.43.0

