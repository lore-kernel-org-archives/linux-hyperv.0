Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906865;
	b=qK5DU2v+Rvw3ng0NdBGCJzrsA1c6ZwukrB0erOhWMM8vlTks4jiWuwVIVky/ZLt3Ndmy
	 LuXH+zwN5z1FFRuF2Q2iO0sJQA7WCHJk9YKvtYflQtSKTJFLclbUXtYPNbaxVF01oJamf
	 y4o8Kr9en1Oj8uZhtm733pYjrLT4p4X2XiFUr9mdsz9n9SbpFVpp5FFcM31XXfnfW9Ugs
	 KnF9sNCfpLv6sPHWyzeTfIsTDnmCy0Sn0xwAjdupU+thKGeFXKRraf5Se188UZBEllB12
	 9ADuGZqpGvEOI8Iue+8x018y2fJwG6dqUpvE2u2yRBZG68G0uiDLZoCXbhLBpFSaJqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
	b=bUdjxrxBwhrG2nIOKSEQQS98RsoHGQrEbzvoKIvc6Yc6fwbvUUtebJ99ud34jESSYZk1
	 HP5Mic4ZrCtKW951/S+852IFDgcpeo73n90uEAmM1H41azxkeZbnmq7H4XpB8wahUM76k
	 cSVfQtnlxaCMX4dnuQw540uvVpQC94SlCtlIMkM9KESPlnYsua2UL30gOoPsm9nhdRKxt
	 BlnJ7UG9rC19jZmragvofYhCrCuNKQFV6k/yWHqK5eWTdmkyV7yVRWjrKywnKG8LCx+08
	 1sco+WRONan07akZecyY556Yzgv+5zeQJ47Oht17JtDrFvgz5L9DcPbDY+q5+nmVW8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+j3H3DU;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93E606A32C
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 19:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D93E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+j3H3DU
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-536c8f958d7so17107701cf.1
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Nov 2026 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906864; x=1794511664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
        b=F+j3H3DUF7XihgOWTB8+UzKP+a41nWACjrgGh2kwbIrgOV4ps8NJpxwhBZIcj7NL9x
         iMpt6xOiQbnGOpe/J7wfRK7XsCFr4+mofGpue9Ipkb/ChvYpZyubXjXen4/hGsLlA2BJ
         HStoq1AmjzcUKKFo6GG3HpH4BE/QkACE20F0CINekOOg1dW/dyyzblHmXzlnclOOwS+1
         09/PO+5wBGHq3h9V3ADyxWKAeIi8GeW1trh8wzV82WQqGwE31m0jEBeC0Fn6ti/Y3jcn
         Uvye39h8CSc0E3WmzpyBjlpUfJMMiGKHqLK/veLE+FntjNSnqVt1HzxaWW40cevQskLD
         xAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906864; x=1794511664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
        b=w6Ss06o2MgeA4Oiudp+Us2o2exuol5zE7QIAavuQ+1R/lro81PF+wTpuk2z1CJ+GZH
         Jhz7l76UeuCL54bbQq6w361aZxaykFZgYKp77KRwvorqzd2Lu2p7oz4A5+ZRoUQITnGN
         XvZ0MvvyItDB9IYN+KGYrgJDaNm4RVEVcpUJ9gl0hImqFg7i2yIjFLudo+VSHK5qIbIe
         OwvzEEnvwolSnXF30rGLw4FkQZmAYo0T1IREpYFnaG6ZUntRB/+MoFcxawmJY1SfYSI+
         6Ermcm+YiRyB42JD21MLBcoJAiy7KXx6Y8kpkLRUxO3vWDzUqHBCjLTr8WCun59qIuex
         jnBA==
X-Forwarded-Encrypted: i=1; AKwUvByrzuknSzokRHc9rt3iTORgTQb1Zsw0Al/Us0XpKwoTxCU9hvtrtoT/3TdKvka6aNw7ZbSuEl+lVKLxk64=@vger.kernel.org
X-Gm-Message-State: APuU4Z82gNsQ8eNd0RxZUvydOHsxDWG6pb6/OdgSi7djPXrrjIoliURv
	hjHuesxG8xT9uAIcvIcnwuQHE6bJGQ2lcuefU/VEbw4uulmaNBOjebW2
X-Gm-Gg: AYBFou1JbRiNPRXips2n+S6AJ4dm8Gvm6qVWb224gbNQEeRmM49nPo/6G6kZtwShtDY
	CegTYEjN4b4RN2T88SD0CpfxNxQJq42/1o4402u20Eix3NWItk3LpgpnhrokrxRMk+Qh5mYdaA5
	jKbNlm9NydMupFra4KP9JloohMX/FwnoP/QOP2jZSe9sG9Pw9ORcX8E9nog5ks4BIQq5BaBc0Ae
	2I91+X5nmC40P5gzHSH2bzsKnvKRVLpafPf9xn+A6KgGCgBkEOZwvjIAdZA4ABphPFWI/wgoCGL
	QDf9WFyCm7hr2FRgPkL0DEAUbe/95PpRq4NUFEPYRk+t+LbJJ/8IrOVxA10JT6bBlFbPIekbAiZ
	Ek2rC6DOr73kIk/FSrOXHIclDKOWAgCNQkUqXGebp0/xuPjUHDPn+Lc2OAVEFX+vYVBbPFqpx7m
	l6U7ALyJL/f42QbIWebMw4t3FCoc079ol191nIEGFPKtuYKh9Ps6EW3VpvCQFH0cNrFLTYxqUWK
	GKJamQKE9VlJgq0xbAxqL5sFtN+laRir6SZ/ZpVac7lxDJSU5C6WAW5sMxj9cUBQwVkdTvHZhBH
	R0IDpTg35VKJSef/udfxPODXSgQod9mVdiuIS8tyl/WHPwap6GnGMg==
X-Received: by 2002:ac8:5ad4:0:b0:536:6383:577f with SMTP id d75a77b69052e-54e15b66b1cmr4847061cf.64.1793906864051;
        Thu, 05 Nov 2026 11:27:44 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785890sm925801cf.7.2026.11.05.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:27:43 -0800 (PST)
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
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu,  5 Nov 2026 14:27:08 -0500
Message-ID: <20261105192738.70664-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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
page tables and the domain if the hypervisor fails to delete it.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1); I have no Hyper-V guest with the para-virtualized IOMMU to test
it on.

 drivers/iommu/hyperv/hv-iommu-guest.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 876a22f21f1e..205c642c8d40 100644
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
+	if (!hv_result_success(status)) {
+		/* The domain still exists, so its ID cannot be reused */
 		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
+		return hv_result_to_errno(status);
+	}
 
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
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

