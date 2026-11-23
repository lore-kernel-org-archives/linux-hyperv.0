Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413875;
	b=uz+7mJw4ThwJsECUN2LCMYKI9epoxeHx60uFoCfWnLySq48ZqUXmXVWhu+lITjjUyvb1
	 3IF3h8+VnmSkNkVuVJVqOtpLzsKq6yZ1CZEGK/GqFK/XEy/wLO+Vo4QBa08IOFy44WUxd
	 EbdIKM7ksI+Zl/pdc4Hbk5vcjeJLOdggmMgiXhRoWH7a1Zq+Dbb7w1TeS+g2VgAlfkunC
	 FA+FMIlFxltcPrixa50c+ZdiW1QenDRqrU6AoKV4tzNQMY45Biz+YrNIvGPcbNRfJZevC
	 1h4hcTONCuJfLJo/rxhigALyZzvrFSdey+b3j96/qxO1rye2T4TGIU2+B16kXPuM53w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
	b=j3PLDryz4LhcG/ilhgfOGXa1TRboy0AesiOBSXNKwiOKme35R3gD5axpn1Ygag/eU4Ov
	 luBQvaA9+ilF46tJuuMrGSLzVbjsIvuoVTMgSrUbw/lWYXsa5ayx7BuptqhqXFaHszE7q
	 OwtMT2BMgJv9k3pDCPBARGe5x7M85ee8Vq5/9j9qqjaPr5Jdq5AShQbGoUcW5D6Ue3fQH
	 aBNzxV4o1BwwXC1k6oSUej/5F06Ki7iuBUo/BshRvy2sJ1EtApXpEDdpBTjVNALd++ez6
	 6ElO1ZgRGG+xs6XoIGXFd+RibTNT9BMhPyul9wM4pDDY4Uf3LeCNoO+p0x+LDWwkgTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKqiIDcX;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B7606A330
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Nov 2026 06:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398B7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKqiIDcX
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-85c1135c286so2439179a34.1
        for <linux-hyperv@vger.kernel.org>; Sun, 22 Nov 2026 22:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413874; x=1796018674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
        b=kKqiIDcXBwQLluyzFnQsxWGULUPyPv9ILfAf9LaNyBqfcY9jYgPiybd+9rAZIA52Qv
         BJbNNJ42TnKmUnBMfItZRZccofjSdzVeXpVYNcqgaAsc82hIf3CJBjiyIApNj6AARID1
         1Av43TbYkdhwHpKvYBEI8vGXPAxfo1H+KP7cdHAehiSlDOWGpi370kGnCRW/9dTQDLQ3
         xxrVhBTqXqb8M51m2V1jIEYyQot4rhbQuI4+6PMUdeMgkWxJZD1oLTRV37egF9gDlcYe
         EkPxLSVwiI0A19WAZaghT/MFReEU3JkL42hh6slUOwcl+hINawmyby3JdpoDb0Nvi1ow
         G21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413874; x=1796018674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
        b=AoQUB3aKVuh54a2+K730zTEEEwXWVd16FrV4lLfOZDMOWIEpo46YNk0TQPs0Kt7nqN
         l68ythqh4yyPtg9tNrW0apwVh4uESn6U/Je5K5b6Sy4FEZMvJsBe6PHn4PwSKWb/2xiN
         4JdUu1fxSrQi2i1LCiKgLvHJrvu/9WIKN7IIi5XXnWxvGx9ChjjalW79y+JxSTv9WAID
         t3OL2X+3l3K6tmOQE4Qv2dhlEIjJpc6i5t+MF3DNcojNa7jnRYt/5rJf/1Whr8DKl6hH
         nZhoL7lCeSnA14DbvooSsTAt753kb2qg7oOQzaoxfdpmLJCWWC52DNaM9oiWp5rph0F0
         Jt6Q==
X-Forwarded-Encrypted: i=1; AL+hErE7KYTG26gBNHFq7GL7zrmZ5qADaWOy5TPv8IVHKfVMRTYy+0PAmuFr7WM9zu00WDaTuzMvciFhprfBZt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E7iJl3n4U3kyr47dL183PRoNkv1XnBavTPvQYKUz7Pm/xcapw
	70/vkCnWAHQJSy2uhWD2A95Wi7F3lMTPmTZMh6VpfGUrkiSba0eQ0KNY
X-Gm-Gg: AZFdTZdGrZLI2jWvThNLf+Duul+O88l80Y+e7RHgk/kx528ibBjOid6k8VdpSVyS0yL
	Wyxd7zn0TNUiMgBpeLANR5OuKn0RJP5vJCrqoX4A6WlwVKuLyR0TEhjurrKsltHX0KzaT5pMZGi
	hsfXL7SrGA0PV3paO8h35LELF6POjwfn+iYAfnXmdzYnyQKQzKCaXZxtWKpGgAAVUq/SXMCLFGY
	DhW50CM97EPV0B42URPkKs6OPfGTuqQT9ZluDWds/Ao69ZxScce2myKoW4nWicv3W++WND5kIaB
	FDB431MZSVXOaXp7J1n2m43KAOAs9/tjRSm4iAJ3OnxnghUcywLGsQZVsxpUv9bGU+i5Kv/RSKJ
	GNA5AnMw21f/4cnvd/mAVy85OYiqZLBONUHJlOYqfwS2y5p13CJMnV6zl2wnkLGpCHGSzaFcq9l
	hyl0JMYl5fEXbelN+iZ08ZjO3CUuWxVf0Q8thM37TL5mzFYFQMYCPL75LypuyucoMNG3COJYMnr
	0rxDknYSXLnsbrQOJJs+SD2aEYSdn7tJGnLvrZKLfGIeix7nV9cghSsTOVvxoN1i8NIHRLtL5RR
	w8z6bkXmEdgI87BlEZAd9oSmoGhnQt9zYfAoslNwcchrjSLT/viCyNgU+m3+Bl3zZ+GDnvfgOah
	7C54nZ/58yevJutk+dTsXG8HK3A1DAce0BEh49c7F6kI2ESqhji7cbuSPOlTVFaRVgHY=
X-Received: by 2002:a05:6830:4c18:b0:862:ca2e:918e with SMTP id 46e09a7af769-863152d09cdmr12157738a34.1.1795413874172;
        Sun, 22 Nov 2026 22:04:34 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:33 -0800 (PST)
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
Subject: [PATCH v3 2/2] iommu/hyperv: Keep a new domain's page tables if it cannot be deleted
Date: Mon, 23 Nov 2026 06:01:56 +0000
Message-ID: <20261123060419.119078-6-oss.patchbox@gmail.com>
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

When hv_iommu_domain_alloc_paging() fails to configure a new device
domain, hv_create_configure_device_domain() deletes the domain again,
and the caller then frees the page tables with pt_iommu_deinit(). The
page tables are freed even if the delete fails and the hypervisor
still has the domain.

The current Hyper-V implementation does not adopt the page table root
when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, so the page tables are not
referenced in this case today. This change is defensive: it avoids
relying on that while the hypervisor still has the domain.

Create and configure the domain in hv_iommu_domain_alloc_paging()
itself, and leak the page tables and the domain when the delete fails,
as hv_iommu_paging_domain_free() does.

Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index aa1db9db1e97..0110a1529a23 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -540,10 +540,23 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 	settings.page_table_root = pt_info.gcr3_pt;
 	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
 
-	ret = hv_create_configure_device_domain(hv_domain, &settings);
+	ret = hv_create_device_domain(hv_domain);
 	if (ret)
 		goto err_pt_deinit;
 
+	ret = hv_configure_device_domain(hv_domain, &settings);
+	if (ret) {
+		/*
+		 * The current hypervisor does not adopt the page table root
+		 * when the configure call fails. Still, keep the page tables
+		 * while it has the domain, as hv_iommu_paging_domain_free()
+		 * does.
+		 */
+		if (hv_delete_device_domain(hv_domain))
+			return ERR_PTR(ret);
+		goto err_pt_deinit;
+	}
+
 	return &hv_domain->domain;
 
 err_pt_deinit:
-- 
2.56.1

