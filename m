Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CD4A9D77;
	Thu,  1 Oct 2026 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892423; cv=none; b=oB7nRropKAxnJuvvEsdz3LVfeSiPWRiIY7/h0QjwG+SnZjxbbT0PY5uMvNOu1P5PEn1p6lYaGHYtURqRW7K0EoB1w7zAxSXBqvsJaUFLsumpg7G8Y04Lz1B9azp0uavyJ7Q3o+NNd79RJPsmJAhRZMmM/R9PonZOaVjEoE0EdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892423; c=relaxed/simple;
	bh=OiRkYa/QSAS/czBYfSlUOjf+LZVBW6WATEnSmeNWUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT4cR+PqzoOLZVikIp6SgbtBV9asvy0oT3xti5Rok20C1DZsBfzbzkfaod/e+PCPdZx8lEZvJIjpxOswbqx0Km+xfsyP4OihIn/Gu30KJWFQRtQEM3fA+pfK6Clw+vDfb9XMd1tECi24rB+g9+/8E33EvTKQrzth6PUtX9C3TfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j+MR8HoD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j+MR8HoD"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED74020B716C;
	Thu,  1 Oct 2026 15:06:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED74020B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892369;
	bh=uvnZ0OjFgR11f2LC6cFgEePrdPVXvRkOeEjzH8YB4Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+MR8HoDv1hDNZn7dGKEK4FxM0UyLhJcBGuPBlh0oeVq8Nf9XWVN0J0YFkLTDsFi2
	 X3pLj2x3hC1SPaIBKCY2y4sMJpEG6HzsALfZQkswJB/A9D7XvDiWnIzu6Y7HXM/PE1
	 xwejRyfE+sShtFvU8irW4xRqxJfKmpJEhJk5wakU=
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
Subject: [PATCH v4 6/6] arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms
Date: Thu,  1 Oct 2026 15:05:52 -0700
Message-ID: <20261001220552.1793471-7-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
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

