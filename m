Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86A472531;
	Tue, 21 Jul 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664724; cv=none; b=SI1JDsDmcVHOMBm/sKRVcf12kdRN9AkPp0JLxRefH8kvpJF1cGMFlUmibJEVZGC+O94Yzi9vZivyyf0hpPXgFzQgQ5o1tvjPXRhnFu0OKkkAWzBEHYcmykypreMEoq9mNXAvkIPp4qLxGhX7D6SGBTgUSVOQYUtE6TVHM9owS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664724; c=relaxed/simple;
	bh=OgegJIAodpym/AYW4WR7zSTxosj4X8LUj+bOE7mpQgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw8JmHHjssk4qXfDHGEGJLXiszLB5T0Rs/seGAulYovNo8DTnbP11t2w5c50zf62Sp03PKIl5Fx3aF0xVC1zLaxdjjK72sO5O5JkpKVkU0ixMANZTgvb2yRqBA6FXWfIMM6Jx2FRNaHcILBxgHrhUfOV5WcjVfVekw8oms6RWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nbMx/SN+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nbMx/SN+"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B572420B716E;
	Tue, 21 Jul 2026 13:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B572420B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784664710;
	bh=SQu+X8yGMFJ886Y/6SkzpbvtTHqaWWFjdm8ySRmrIgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbMx/SN+1OwJBtSN4jVHReLeoKxQfb25mw1vi2YN+4ZxgqcBN8E7WjYyd9g/i4+lS
	 bHBvGZJOdfTgniOEWqSqeTzCZXyQaAHav6G3Gvgetz4DxwiEZXaGO3RGzP3shrdfks
	 WNvEVPvKgbCHdP5Pf4Jf54mZhUo86iWMQ+qI5U2g=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 6/6] arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms
Date: Tue, 21 Jul 2026 13:11:48 -0700
Message-ID: <20260721201148.1441143-7-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an arm64 implementation of hv_is_isolation_supported() that
overrides the __weak default in drivers/hv/hv_common.c.

The implementation deliberately does not depend on
hv_is_hyperv_initialized() because hv_common_init() consults
hv_is_isolation_supported() before hyperv_initialized is set.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 8519f694f2897..e28612255a970 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -163,3 +163,8 @@ bool hv_isolation_type_cca(void)
 {
 	return is_realm_world();
 }
+
+bool hv_is_isolation_supported(void)
+{
+	return is_realm_world();
+}
-- 
2.45.4

