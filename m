Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513439;
	b=DTnj6NroPYAOkzI24x006C88bE+jsbn1OMq1zR5DUTsUG/4Iiegwo5BHzola1lyIziRC
	 jJwa4d0a+7+8oEJYUGw+xVouXOigVK9PxlL05Pa/ywV4DhjufsVJLHlWwa+IEUGCh2yid
	 6VKnJWqO6E0USwzfCyXuzIuuctPpkSUs7+F35v72+SifDFzKC//MKlUzd1iL7PWIy5SuQ
	 7bQ/8F7Q5C9vwoUMQTe51txSSqL7S/rcnsxK3VySKilAd+LYuEH3p6BNA8zHOUwDP0EDZ
	 SHpYAHf+rK4WIVvXGvzufBfk+QTYOaS7bFfkaheAMEDlqD5JShKJWiF3tExcGMxBPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
	b=Z6XsnBCZJdDgNxMta7XqdOj+DAyO5V7QVdlregI60sscegIuL5zHsaP3oPnoSiy0z9ND
	 vlrXoPLsi5KiarxuQYWuS2q/4B+BxdvQCrM+C+Zx72N6NNZ1ElSdUyzq473LKWVM2dlJ6
	 TDvYI1ZgJ384G40aetL7D7J28CXz3zfoNiHyKqD1F1QglT77WJjhHEC6xRDSmB4iGywB/
	 8Cv6cFqiQL1UjYx+5WyXu+QodwrXIihotngoemQGw/Qtd0RG9pz2uXLapPBsphW0vHgeB
	 cYREw/jJq0qO6BGYJ/bbpp3Fhi+AHO79rkmKcK0z3fiUUDBfTKxBNY+TZBisi/ylo6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJHbQD98;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DD606A339
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 19:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103DD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJHbQD98
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53cd0c8614eso791101cf.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513438; x=1795118238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
        b=TJHbQD98Scgj5MnwplzoUAe+Pm6QLJPSwjhQxUSqVdcuGVc0fDfrO4++n7mQrY2SIU
         ygD5g27+z77qGwHw4d1B3G/oFawhAqkQxK8cxzPOfXrY5xqlXNmSoOTt8VihqSLiBri9
         JD18Av+FkKv5dQ5rTtG+PPCRHyIGXT78rMUEvSf2mQnlgXRoEXPaJI36L8nerdgzKbwp
         4X8nHx8DbQQmpzm2tU75PD7dGAJdRxUaY3vUY/2y4y8tOqYdw/JxlhjMn7EXNcxnM8EE
         TBCLzSunPVyB6erq1E+TLpTtrUR9z7Rk074P+XveRIZAdEhq1WkGkN9hw72ZpQ37TlA7
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513438; x=1795118238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
        b=nt8+R9Kf2X4DohvuJRzStv2xvPscEFknPtbhzEGzh2/hLivldkhup/D/PUt41jCNo+
         pEXst6v7RjK9u0/zYgrcm7F0v3YpgY268131bEyV2dRTs2gEO8DPztAYpVHPGM2GT7US
         7JwpDpPdSPYbOte0skLlKbCmbqurL/8Cykc2diCLwpAdXgnjMwL+hnvjikE0a7/6KVyH
         yRlAkp6vLh7JSqEiEcC/EYP1Kz/r8/WFS060VUKvGWwAGv548Oy2LoIbe2oYRfzAROw5
         QaOkE+vmD+6LG7cYmO5RH5kUQJVhDSYdYs60/TZYf/c6lmmsUEvmqqsZYIiqISjRHKWA
         NUVA==
X-Forwarded-Encrypted: i=1; AL+hErHaFv0dmQY5tuoFcM8qv658pBB0L/i28Dcwc2wFf2+JkejB2A1hyM6jcsIQl7WpfBG8ixPDc+7N2j1Ismw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BFXTriZXJZzOFMP/thqy/Y5ULGyg/4S7zamT04Xs0RBEiI11k
	jxQKskFqYGXlJ9//IycWTMD5ZRdSwhRC3hjprcKZSF9IgtPeJZWkbs6A
X-Gm-Gg: AYBFou0IsH5lM2dHNmlsCcyvj+iizsoh6xcMpqdyhBG8HzkJ0kBM1ACwQn8tvLQrX1M
	mQUQe0VDgX3Q3VA+qdr1ZFQjHodAxDkNGgtT2O2Aai+lRTqJlucH7ec1AxKzZW99Ypl+ozzcHX+
	Vhuo01KjZlMc8yNwsP0OuILHew+HBx0IU660U9mnKzKX2RxUKnneNnaBjAiWLSHB/+q9DUGr8QS
	sZwsqtPmTMRXVI6vFfAq7J6tpurVj+p7jfMZvyBxfaHb9z4mhm35xvlqrc38E+ZDOGCuheIzhyu
	tGuiQs09ohKFgpH+uy5VEj4XE23ChJhd0/52jhrB7kA1BIoTbVjY4LCohhzhVzu0GCS+btYTH4q
	cB1qXShidyoC69502SAvF6qIQf6NBownQMkCKS9LowYHSm2PDstN/xY3AQYdgyJlIKMlmcdQ/Ly
	96pRSVMdKDkjTB5GckN6FYzcAhUMzPz5GoD6ul/R0Fa0BA6vLlkzs9YPzgWhCHS/MqEceEhe7qk
	66u5DMrhqtypiTMMQjJeEzKSQlDH0ilKmvJNsZf48kAlmXepSDmBu+h+0uONy6rcxFJHC2gOOAu
	O+3XL04JeijhYUWZuyrS6anPWDCxyexpoCKb9nver81nKXoEFc7E
X-Received: by 2002:ac8:610a:0:b0:537:6f12:69 with SMTP id d75a77b69052e-55ac888b9a3mr8854161cf.45.1794513437993;
        Thu, 12 Nov 2026 11:57:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:16 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu, 12 Nov 2026 14:56:59 -0500
Message-ID: <20261112195710.1417744-5-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112195710.1417744-4-oss.patchbox@gmail.com>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
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

hv_iommu_paging_domain_free() frees all page-table pages with
pt_iommu_deinit() and only then asks the hypervisor to delete the
device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
fails, hv_delete_device_domain() only logs the error, returns the
domain ID to the IDA, and the domain is freed anyway.

The hypervisor then keeps a device domain whose page tables have been
freed and can be reused for anything. The ID is also handed out again
by the next paging domain allocation, while the hypervisor still has a
domain with that ID.

Delete the domain before freeing its page tables, and keep the ID, the
page tables and the domain if the hypervisor fails to delete it. WARN
when the delete fails, as the domain is then leaked.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 9f4fa4315091..aa1db9db1e97 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -107,7 +107,7 @@ static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
 	return hv_result_to_errno(status);
 }
 
-static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
+static int hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 {
 	u64 status;
 	unsigned long flags;
@@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 
 	local_irq_restore(flags);
 
-	if (!hv_result_success(status))
-		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
+	/* If the domain still exists, its ID cannot be reused */
+	if (WARN(!hv_result_success(status),
+		 "HVCALL_DELETE_DEVICE_DOMAIN failed: %#llx (%s)\n",
+		 status, hv_result_to_string(status)))
+		return hv_result_to_errno(status);
 
 	ida_free(&hv_domain->hv_iommu->domain_ids,
 		 hv_domain->device_domain.domain_id.id);
+	return 0;
 }
 
 static int
@@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
 {
 	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
 
+	/*
+	 * If the hypervisor still has the domain, it may still use its page
+	 * tables, so leak them.
+	 */
+	if (hv_delete_device_domain(hv_domain))
+		return;
+
 	/* Free all remaining mappings */
 	pt_iommu_deinit(&hv_domain->pt_iommu);
 
-	hv_delete_device_domain(hv_domain);
-
 	kfree(hv_domain);
 }
 
-- 
2.43.0

