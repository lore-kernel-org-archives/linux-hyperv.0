Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674329;
	b=drFDRqwm3HNeos/q/GU//8yufqNBFMH+YCT7ek8pcgDBF23j9FSu3iEoJcGPHgjEx1Dp
	 dJ2F92zjkzUW98Rzin4WH+/sKBU6uWzmgAav85cVxSibX1pJ/ajkcNDyAVXZs6MpTgrFv
	 ZSvLFG5LpoFOOfPiOaIKxorVrA8V2CugChcnYZvG+gfdkdRzhHjQBEmKtyis5ikp4TijH
	 yB7VMz/OkqoZzr/jrYHL1RQCbwPeEpjqoqgR/+gjaU0XKl0r471R/JfZfywxYakQ1/2wq
	 Eou3xbgepbdRtZr21LpYQa3cBCmU4jSZ5lWMHRFC05MZFwHZxbOkHHKGOg1jmcCEHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674329;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=SWWDsMBPFu7NzGa9vSZGenZG5wW09NarRgi13Er8dao=;
	b=am1qcwzxvV7QvzRGKx0Sxz7HxHI7f/DPXtZ+ATZh0zlpA3y8el9P5sUKxiERUI4BTX+U
	 MmARnpo8qkQlCf0tKEywiiejOP0Evj8AMvmi4Z4aL6Ho3vbJ69+f/10xLUWoIpYiPDFOr
	 Vb8GiVCrKdc3RcktdA6OciKcDN8BUcG8KDVbLTaZnimH1N4U1IgIuCq+cY8tPe2Hduivp
	 5l/aFg/KWdPzbApEqaDc2n1vgJMznNfKW/uFHZqf5vdzwQoClfG7QqxOktAnBIJssS8XO
	 kSwd+2h+xBrpZiRaQUk7tqruaBEQ4Vf75HrlzFHMF+6jw0iPtmFqq54qZCqZwbgbdSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SNHAgkas;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F4606D80B;
	Tue,  3 Nov 2026 02:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448F4606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SNHAgkas
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8DA120B716A;
	Mon,  2 Nov 2026 18:51:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8DA120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793674314;
	bh=SWWDsMBPFu7NzGa9vSZGenZG5wW09NarRgi13Er8dao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNHAgkassp5XUXmEuNywiIaGaVf+KP6G4oTN4yQCFeuqjLmAL7TQjcqmercHvsHRH
	 vsldQz/+DjmUTdTz5riT6hN3FZkXgvghYK0AF8oEhefDh79VtDl5GhNTfRezxbi+rp
	 wmN06ID0dI7h6jfSWesQcfAcGomZm8j2vbY47Al4=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V3 4/5] iommu/hyperv: Only call pviommu init on non-root VMs
Date: Mon,  2 Nov 2026 18:51:49 -0800
Message-ID: <20261103025150.3192119-5-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next patch introduces root iommu init. Since both can co-exist, set
x86 iommu_init to pviommu init only on non-root VMs. Also, rename
hv_iommu_init() to hv_pviommu_init(). Lastly, check for null iommu_init
before assignement as suggested by one of the pviommu authors.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c             | 3 ++-
 arch/x86/include/asm/mshyperv.h       | 2 +-
 drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b90e6f487533..18651c38dba3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -580,7 +580,8 @@ void __init hyperv_init(void)
 	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
 
 #ifdef CONFIG_HYPERV_PVIOMMU
-	x86_init.iommu.iommu_init = hv_iommu_init;
+	if (!hv_root_partition() && x86_init.iommu.iommu_init == NULL)
+		x86_init.iommu.iommu_init = hv_pviommu_init;
 #endif
 
 	hv_apic_init();
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 24b19cd28a05..c95d75ae645e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -320,7 +320,7 @@ static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 #endif
 
 #ifdef CONFIG_HYPERV_PVIOMMU
-int __init hv_iommu_init(void);
+int __init hv_pviommu_init(void);
 #endif
 
 #include <asm-generic/mshyperv.h>
diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 876a22f21f1e..a40a8ceb3261 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -601,7 +601,7 @@ hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
 	hv_iommu_device = hv_iommu;
 }
 
-int __init hv_iommu_init(void)
+int __init hv_pviommu_init(void)
 {
 	u64 status;
 	int ret = 0;
-- 
2.51.2.vfs.0.1

