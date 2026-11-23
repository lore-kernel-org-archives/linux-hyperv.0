Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413872;
	b=FvDzddgq/TbkZ1q/LOqXW9+sutrQDow4YuUuoq44ymhXqsSp4HBKKtwGt2HgwwA5oJNj
	 a7kn5Hr3WwnyPbrHl5qhQjyoCDxx69+dYssdGY5sG/UnJAR8HBnJ0i7sqFnX3tZsmoJJV
	 4EwBAC2YIpuTF2pdaDgs8nBGnh2P1dATcrHsi5duU6ay5blTN1V3QQVTmXdRTCLs/HF2g
	 YglD6gvvBvRdfPlbdHToMFRLffNWIoctW31Qs9dwXNquj3G1SNLGP4pMWN+HG+MUihIJC
	 wExDEeb/1dR8s/nNI2cb+gtIs9LQJdIa4U+04hI6HA8LqaEU9ffgJH76Nt8oNUhQ3+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
	b=lslo6/GbNQLr10AqEYvkXs5+uv0orLS+NIixM1LfxXEELyp7rIt4n4H3P2aVf4GSanb+
	 hd1DNqJ60JUDfXy3i9siie9ujLwqa2e4VrMQ7pDcK8o5ni5WVhTdbKrWED/2dXgXX6Cb6
	 7JEBqTk6TGTg2vooIh9apTytyIHtNwCsNC8kuOsZ1weXR1VUzolLPqxM0xlsbEmKbkj9f
	 3s/4Xlgm9+Nej4OBgqou98pyEoVy0xfRh3kfHbNcz6SnBE+9GWWjL8h2cIc0oa0sfnMFA
	 GM8MdGoYH0ixbNk1awGhO+IrVhCdDvzpsYAe8MpCdPgoZBBygLZiJTPO/qQiQTBNIxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvmFOEGh;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE92606A321
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Nov 2026 06:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE92606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvmFOEGh
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-862bb0a189aso1326750a34.1
        for <linux-hyperv@vger.kernel.org>; Sun, 22 Nov 2026 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413871; x=1796018671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
        b=YvmFOEGhY34VoGni3QxiaW5xDmILPAm1avxaCIA7DhsR8+vGIyiivljap3xcJhoObu
         cIhAXJen4ulRivUQZ8LRBQhLDBpbdsp6uFCXvKd14KxdNMfxec5kUqOnOT4idpHPhbpm
         YHOAEOdXc5jm9PTA9y854tr4zC8pwEVtKnoMfOWE3m9fR8/zAObnTUTuabWFoRk6eCSQ
         LeEr75YYAN0qnjxkMoXMnPLUamJBmSS7QafSwcIG2SyLvCyqhkamIn+cmAZNRpSn4lPZ
         qrPq4lJ628LoQOfDRfyR2pVg3PZkApTVQ/gNb7ui32oscTPtTyDzxIYM7AVEL10+VI0u
         uUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413871; x=1796018671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
        b=B5iMV88hRE2kwloN/iZvrVk+Yrr3ZbAnYDNuLnhA5xwUmWjmGCwdQNHGHgya6dVzet
         tRc4e8VwvyBGhv3ju6V/Sc0WPTGrqh+iDgp8E5VwPh0J0uKpkIGwmK2IjFqx4jWR+V4k
         26zNKeVLWhbR9wZf8codjAJLr6Vj3D/SZIBGS8Erd9ejP0NzBF4377rBy50mJkr7rRKu
         cv0fZd/bTTjssMWgSzYzMfq489FvSPn+Jk64xFoMh46qYIYTJHeNxNHTL5YaKWJ3ffPq
         SbHMBp8t7pTv0MYDixQMjdgjifYJdAa2Sx2Q9c2YfyCFXxnFY3CMmkP6onA668DlJ+cz
         WRMw==
X-Forwarded-Encrypted: i=1; AL+hErEtIxd0/gaPPvgfOcHWqP1X6Q7mMzWmqJ6TShUOJjcOkzL7C8n81qPP/9z1OjSx/zugkJ7aC39XA9pFwhY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FFWQI/WwH+5csu6XAG5Ihik8xofiVPxzB/Qdw5CuwFZ7ZwmVa
	7+Rw3wA6CnX+tHRTMRoXIsGYYXYwZW5FZJ2gS3TRdF2jyS1vLqIzoZjW
X-Gm-Gg: AZFdTZdNzsvkHGbeVWdQVq6rweGiKhxvfn0bhFWw4acynfI1LFgXh0UmBIE6wPW+AoN
	pjCPWhx2ZZpAHBM5zas7OCVMcoNOQLcfpW2Gl1AZv4tTkLHkCBK3KaHtjI0YhTUZMCHzi4XWoYT
	Py0BvAPq4kh6mHJ7A9W8KZpG8R/kI0IQmMqli0G0Ty1md1ZAYVXvrD3N6gvWESMt9qv16+4GUWb
	T3vBy5VJLqIm/gU4LTHZ34xFDTOPLLFA532Cpuu8590PIdXeUS4wOLmkyQExVsPUn6jrk0/3M+s
	J4IMUYe4G+HWAwWQ9yzji6k6zQ9IBxvr65O8HImmAnKHDJ+LI/rroOtT6cXIzSu0B/YBdn1NbC3
	6kjGnDJa+sHQZtZVUe1YVfDDM8HWKHxM/bbcY2nerwEfczjIgld9oVyHRTAgENHGg4edlObjzM8
	g1dd+Gg5s7UUUdRYJ9Vy9Dgbub2iOpSN42G969I4++M+4YF/1Bkg1oIdwYqJbroXu5JsNq1yOGs
	7sjZoy38Zouh2cIauJC2GoS9IX2PsD7Dka27sfG4kUu9rra7sCApBliKZ/oqkFtBVtzRk0JQlV4
	XlBNs1QacwYuKI5KFr6XHDZsGpNiFLktbDoNPMA+7KUzW0CjP7rR3iV+RQxzdCliWvLrUpfqHcz
	XYZexvxMO4FbVESQu00chbSByTpYFbkKKqFKv38hQjrn5Thu0EycDYLiyIY2xUCo3EIA=
X-Received: by 2002:a05:6830:640d:b0:85b:c75:dc65 with SMTP id 46e09a7af769-86315611616mr13072110a34.7.1795413870968;
        Sun, 22 Nov 2026 22:04:30 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:29 -0800 (PST)
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
Subject: [PATCH v3 1/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Mon, 23 Nov 2026 06:01:55 +0000
Message-ID: <20261123060419.119078-5-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123060419.119078-4-oss.patchbox@gmail.com>
References: <20261123060419.119078-4-oss.patchbox@gmail.com>
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
Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
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
2.56.1

