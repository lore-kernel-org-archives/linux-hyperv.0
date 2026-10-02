Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D04718D0;
	Fri,  2 Oct 2026 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978338; cv=none; b=iexon3IWPYuy9dqOU31euzEn3Ri/JR2TdZPe/LPRNpwtrAtFUEinrI9i8kYO+e4Y0T8gOtBcEMED0Tay0d8osFMjz68OkZDpDRaEnltllaxlpATEvU6DdCC7XbTQyrRdBPmyazJFr2azllhEILxm9SQtOm4wl9Md/zOPIaD+r4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978338; c=relaxed/simple;
	bh=OiRkYa/QSAS/czBYfSlUOjf+LZVBW6WATEnSmeNWUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW2Q1yJQ6ZkmY+Le8zeQwzi4T1Y+7z29ox8XdUvvaBShUTpzq21uBCVhj6bB2pJY07le50FAnvmhTnRlzoEFDM1HeMqoipidr8eTWGrBZks2IMcfHDRJeMYAjCOk+NEGhgEhDDsnm5EUq+tLOHEA4LU030bjKZuJ3DIJ9+22pxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O6tk1yoD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O6tk1yoD"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 61C5E20B7172;
	Fri,  2 Oct 2026 14:58:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61C5E20B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790978283;
	bh=uvnZ0OjFgR11f2LC6cFgEePrdPVXvRkOeEjzH8YB4Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6tk1yoDS2rDXMbJRvGoDgZSWxmFEDHM1IZdGFJIddfHQcTo+1u7egNYiCoiHK3y0
	 NSrUr7FDcV1FwMs/xp3J5qY2OO1n7tfjYixYmRMCxArRXQnsWq4Cjo0sqCvg5ycmJd
	 lP1Utc9CglGGY/qYLMXdqOz6piGbH18vs9MTPtVw=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
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
Subject: [PATCH v5 6/6] arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms
Date: Fri,  2 Oct 2026 14:57:25 -0700
Message-ID: <20261002215725.2015959-7-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 45ca8e2..c41188a 100644
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

