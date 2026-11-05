Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844084;
	b=v5WDMZ7LQVlvq/aC947ZLunwcP2cOdxrW1VdKiP+F/y4EMYFwb62gfjXZwtsWsMqXIp0
	 X9J/lYaOhj1w6DnYUnhUcs6IbCBdtRwwAPsd3boYdwE91ODIilLg/97PWTnl6geB1MHYr
	 bPR/6jE3zX/40OqP5jCxt3/d3gdwLlULO6eE+WshfkFMvwQhEnWuTPhJZivFIlq0ioQFb
	 56RtaKo+yOIzAPAoceZJc4WVQNRifdRNWzjiA+hNvUmKmA3yVoozwGmPLwsd3zk7q1BgB
	 VLLvIm3eDlY47XOcQJ5mUx5G96HdbxQu1R2Z8+YbVhouDciEcrGwC9EM3V+BoHXMGkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844084;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=f7gzFtKMZJGCCgUHzye6RXzDrkC+83Rfcf2joF+exy8=;
	b=4D6aHa0GOw4VptS/XipjPpiHPddtXHvXHvwEnX48vdMGb8vnW0SVH1jzlIfxOcSFTuLM
	 mgQyp2vu/Gmz9yllBBnMappM0Mu7bfbBtxh3bAJVP1b61bhuZdk9x3+QvG8rkSrxSkUFO
	 vVb8SIjf8XvNPTDTwUlbL1l6hRS8E4Ya56EbzbU5quDmfZXqYVH1BiwMFdb6xs7OwF0Cf
	 mMvmOlTtAgvlfAGPDd1gI3/Y4Kru/fsln3z1+0FQ+f0fW7XodDIC75nGEmzDDoLWwgsV0
	 KCTa9gELpqEmM43LiW6QsoXQyj8g/RexoVaQlhd7f97LZevRYBgbbtltVVGVCVjkX4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CJt2N4Yo;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08760A260D;
	Thu,  5 Nov 2026 02:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A08760A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CJt2N4Yo
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A36C420B716A;
	Wed,  4 Nov 2026 18:01:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A36C420B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793844068;
	bh=f7gzFtKMZJGCCgUHzye6RXzDrkC+83Rfcf2joF+exy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJt2N4YoIWRTliVGOS++r10H/i731xsXK4g86sYPNo6e958A5Qm0IqCs2oG3vuL9y
	 5YmurhDuCIz51VNleK/2AtQZO5GpAUNoHGLxwjo4URB955fUHDR8BkuRFS9G3VqgwJ
	 ncgN29kAFX/Qillcv7vSfjkULdTH8tHsSecOJruY=
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
Subject: [PATCH V4 4/5] iommu/hyperv: Only call pviommu init on non-root VMs
Date: Wed,  4 Nov 2026 18:01:05 -0800
Message-ID: <20261105020106.3496339-5-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
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
index b90e6f487533..ea50708c3ae6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -580,7 +580,8 @@ void __init hyperv_init(void)
 	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
 
 #ifdef CONFIG_HYPERV_PVIOMMU
-	x86_init.iommu.iommu_init = hv_iommu_init;
+	if (!hv_root_partition())
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

