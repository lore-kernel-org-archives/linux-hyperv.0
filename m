Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513441;
	b=Jw2GLaeb7/2pdEe6EH3hjTl+0BALUbHOR3XOi+70jiuqbeT1znl6oZ6YvE/0L7Ogkp5p
	 EfUOz7ybI7WdvXnmoYRyR1gTBNLcrj5T799gpCap/KDplAqOr6B62qqBVnpKMgYGnQ6f+
	 8R8GhiEWDXx+eTeN0gp86erASa2otRyvJMBKs/+oFJyWNR8kRyRvimJyc8xBUN7Htdrhp
	 IQ0JmXDw9t6TqWb03aq69fE9e5hQAmxa+JdZivZuGD9O1YSWfFoCIQMso++awGQT5xzxD
	 RsjKXeim0R/SCkb150PdbDhsELh7Lg0PuN+RLywCrJtG/oUZO/NeW5fxXrrqog892Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
	b=ac4bEvwm56o6PhMM/JmSBl6TrogceQWdEeQzal8UP9h/DfCJZR1MUqaLcHi0y5iwh3Wk
	 CMjfskQjzJmBDJ2gTgoRgli1jfUMPqbYGcTb1XsVEOCzFnOeuhaf9sgBsKH8qO0z9mHjd
	 thgiFJUJ9w83zoQo9kbjk7FZulyqtLmxKY5S9mQ+KdcidX5Al+4eYCa21BRDIdgZNyFKA
	 e8dDVfQ+z4LFmtR3RnG9/31WlhXgAZ5+w+q682lNV1uaT4ehLYy+omEOP+zSlgW3L7TA6
	 SToSAqZohp0H72ugJ5hSsG23XzlGgbILCllLPvbDXnfdx/g5QsSqg+ZW1UXrxmbk1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3cE7ulL;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0E606A888
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC0E606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3cE7ulL
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5364d86f7f0so1743231cf.1
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513440; x=1795118240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
        b=G3cE7ulLNr4Jgu83chYtqgfXpNsyyI81lhQZuA3nuJhrVpBMXInFGTYy1OdtZsWCFG
         21HOlo8+7naSJH4r9C453aCSzXYlWKYZlbktnXB46RS9b7qzkp9iDBmqLC5zNCzMGWP5
         8KiLhy/aRG3CKDa7tFYkQ+Fr5pRyFLmihyjgwqhGX/lT9w+mGf3PtRyVRsGG+xNTtXE8
         LtLkmBMqTC/573fvX2x5kbGa7tIkxTDq32PK44ofJvuhUfrCjjsK1jr+FL7xSYudT9g9
         FwvqF3YcdrzL9OsSgU88Pedr+YbDt3ob+qMMIEQbHo5aKcf4H7ZG+5qEhbJMFxQJCy9X
         pG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513440; x=1795118240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
        b=QhiQj8J7YCfnDEHi98Nhkdv97Z6UjLAqOKNxb/LhVxkjhvJZ6wQATUDZtD3FWboPOk
         MQCh7+fDbhNsRQZO+fF79iPNEf1zoJf8SPQojRnkmzbOxew8eRYE6YOKbtXov1w3fvPq
         tzNUP/7Yes1rNTtlRy4xpTpsvdkXLprJK7KPAkdRmcnJgwMzlYmsmxqyKWts9FNQ5UJe
         DRdRg5tihDfSKT3YmCE9hglFoUn3bXN1MbK0IAhvTS260/bkqo/HcVNKrB1Ogw0CtszB
         e2IJvz/Vy2feqmzwaGjWtIXkpDQQrn4mXYw3OrMl7wf3FILOYLCDdLStwHTmXYITlhVa
         Om8Q==
X-Forwarded-Encrypted: i=1; AL+hErEDghLqMD4dEii2N9SjjrTykXC8fWnvSZISelO0WDDpFWSyhIDJfijy/Xy11L6s+018+ZmHmnwyyFsXCrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/baz1evpK92BOgm6Y78ve8sYt4aQU2gOqGNaULOZ5jJN1sqlCk
	Wur/22zFhhQiqEGMaIxoE6FvLn6tBRmMwJ+knul+Z8BSAsJcrG+2O7ci
X-Gm-Gg: AYBFou35fxt/lfJGOWQagvb8yOMf7gxZF2uXWYu2nAn5VYdrHuBo/s0ihOwS+QShrLi
	HCVyNEPdKzNpHArmysvyeJH9kfCMXIbsM3CQrSuuVc7YV89azdlOluBUcL4EmJGpoh+oM5OKt1u
	FXNebRbzSs1oiLfvRGEvk6Q/DMdPXto+3I5iUeKxn+OJOiX17GYfF2zVDebJdBPVuaLMDj0ejbe
	zkaW6mopZ3mtYhSQHmJ+E3mEnIeN7rajvg5uQJomAM7Kb8Zj3KpbQZyORFiS6VLcF6WnVWaAOq3
	vw7bfvrpzetRco4lC69cU1f3jRBa4lf4aS3hrf1PA7jwQjWmJzJc61UGdgq1ZWSIBNeNR8Zo0GU
	3LonPYS+FeTu3dCBQ3jWBPAX1VOeZF6eitNsN5sQRSdebc+c2j3DaqxCIqnCOKYJF+J4LlvqhRh
	YmhrHWRF//0lrJqWjm0NUiwo5Zuh5y9aKzpWVZ+ET1oGJHuZLLfjnrOQ9jHqEn/1fGn21MY2LuX
	K5XpB3Q52Y/tSQH3xh52GM8aXjmsupKmnpiSA5pPre/h68DCVAKeIG+I/u8hYk4GZtWi4eYd9YP
	Dv/Gj8YIyH1vcXEtWzUVhdqxCTDqSFJLAxxnsC9huWtdZHzRUg9fevm/94xEVi2npkZ9Haa8Pgc
	=
X-Received: by 2002:ac8:5c92:0:b0:535:8607:d2e2 with SMTP id d75a77b69052e-55ac8b905f0mr8030011cf.56.1794513440241;
        Thu, 12 Nov 2026 11:57:20 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:19 -0800 (PST)
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
Subject: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if it cannot be deleted
Date: Thu, 12 Nov 2026 14:57:00 -0500
Message-ID: <20261112195710.1417744-6-oss.patchbox@gmail.com>
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

When hv_iommu_domain_alloc_paging() fails to configure a new device
domain, hv_create_configure_device_domain() deletes the domain again,
and the caller then frees the page tables with pt_iommu_deinit(). If
the delete fails as well, the hypervisor still has the domain, which
may already point at the page tables, and they are freed anyway.

Create and configure the domain in hv_iommu_domain_alloc_paging()
itself, and leak the page tables and the domain when the delete fails,
as hv_iommu_paging_domain_free() does.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index aa1db9db1e97..ef486ffa0be4 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -540,10 +540,18 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 	settings.page_table_root = pt_info.gcr3_pt;
 	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
 
-	ret = hv_create_configure_device_domain(hv_domain, &settings);
+	ret = hv_create_device_domain(hv_domain);
 	if (ret)
 		goto err_pt_deinit;
 
+	ret = hv_configure_device_domain(hv_domain, &settings);
+	if (ret) {
+		/* See hv_iommu_paging_domain_free() */
+		if (hv_delete_device_domain(hv_domain))
+			return ERR_PTR(ret);
+		goto err_pt_deinit;
+	}
+
 	return &hv_domain->domain;
 
 err_pt_deinit:
-- 
2.43.0

