Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD03ADB97;
	Wed, 13 May 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698258; cv=none; b=Ty/Rqo8vD29/5ofkCCPyveD/TqiH1XtFFIr+O+PAnXvhVsMWrMOEyIBtbLyRaWgI08CEASxsKcOWX2bHcMxpuAnPM4q33RDcYCa4Zp006m6oSTdb/kxr6HjSsxOAs+WBF/2/BqNDeZa/J8Vr2tRWQiEMh8esrsnTzxaCdXg58/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698258; c=relaxed/simple;
	bh=VRnzgNJPLBHzFXoMYEO8vCwEU9dRS5G2MseorLQ7Tzw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTwIcsXStwtL6U1ADyoyE4NvXayzbSsHijswSUGkcHrf02FuI5TChvbjKflcClGIm/YQKrcVQhXyV2m0O1AgNg152xRn8eJFBjWReF3U/AYfL8MzlDr3wNEKZ1ezy5vwbxcnW049lzbAOnxnN030u/pVLSG1J5M+mshEAthRlkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yuw0b8Op; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yuw0b8Op"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A68A720B7166;
	Wed, 13 May 2026 11:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A68A720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698254;
	bh=y41LTL4py6sdUCnWh7CAByFwkMsG1lIkm199/fUtHew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yuw0b8OpFBbEkPhqoxoL9zV3elRCYyXEn6NUuX81lp5mkzji7emy7vAOlXfdRBcOB
	 nNvvokHcH1Y5SKAwIpK2+3Kiu3oXHIvy9Ab+xbYwZn4iTwksF2GpPTIdL5eM22ECYl
	 S/ok+dS6M/FHi/EVBliAHBMaXTWBb7Vudnh5E6GU=
Subject: [PATCH v3 07/11] mshv: Scale fault granularity for non-4 KiB host
 pages
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:57 +0000
Message-ID: 
 <177869825731.18773.17262977383213856242.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

mshv_region_handle_gfn_fault() faults in PTRS_PER_PMD HV pages
(2 MiB), sized for a single 2 MiB SLAT mapping.  When the host page
is larger than HV_HYP_PAGE_SIZE (e.g. arm64 16 KiB or 64 KiB), the
range covers fewer than PTRS_PER_PMD host pages, so a subsequent
guest fault re-enters HMM for offsets the same host folio already
backs.

Scale MSHV_MAP_FAULT_IN_PAGES by PAGE_SIZE / HV_HYP_PAGE_SIZE
(clamped to at least 1) so the fault range covers one huge page on
whichever side has the larger one.

No functional change for the H == V case; on H > V hosts the fault
grows from 2 MiB to one host huge page.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 807fff43deb43..057fc83895d37 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -17,7 +17,8 @@
 
 #include "mshv_root.h"
 
-#define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
+#define MSHV_MAP_FAULT_IN_PAGES				\
+	(PTRS_PER_PMD * max_t(unsigned long, 1, PAGE_SIZE / HV_HYP_PAGE_SIZE))
 #define MSHV_INVALID_PFN				ULONG_MAX
 
 static inline bool mshv_pfn_valid(unsigned long pfn)


