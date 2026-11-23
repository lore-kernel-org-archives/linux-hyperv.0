Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413868;
	b=4ZnVwuXCLEssSTUg/PLY+4oh38jsowOHDnK0ve0YNrXsCD3ov1BKzh42lPj6ClzRJu5z
	 6aTQNDhRUnRA4rSGyefJtBoOwlCNUEdI3fP8Svhs/4dRFZ55TFlG7u4h3YVNG3g61dEI0
	 TCGdLBT9hNC9rSOO+wCofrMctBrxzTu0CCd0BjYlr/9O2qCEUUc67wM4TIfFtavlUs/TH
	 E43tj1+AjMhOpffKIrb5q+1lJGodyZiR/0H8ltzNEpJCzQve+YVoDKNwJRz7OcsxB3TzC
	 0cY/Sl1PCSdsoWA6WSheoe0gN8G5nfUYd5r+4g+IRLwwrBvsSm3si6FKZxVG+e4+t/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
	b=pCK7ZpyenQHNvdiAg0SY95I5IWUl40w7YjEy0sC1TgP2i2fEfG171GZTnA4G0ixXTNXf
	 2LCx/TcXRFwvq4p+Wiyiv/MEjabcVu77murb9eA5DH+UTs7SIal+AW104fZGqvSzx4Rf5
	 43G0jjP4ZKTrPJc9hVIJzLm3fy+VRokB0AwlGGHERL8yg7/VDwXk1KaJiXQZ9HzubFNxL
	 6oLlAOUWSFL/8DE9+RZUiBUgg5cXuhG10V7qWG/FFiHN8b2hPPmrI2d6XWeR1ML05gTP6
	 vvo48MiZY1O3Ro6w8XvKPnK311H/gPMxYa9sKJjiNcPHFfFsIV0Tqm15B49+89yGajA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afE+iKsH;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635F606A31F
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Nov 2026 06:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3635F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afE+iKsH
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-86298f9267fso1662345a34.0
        for <linux-hyperv@vger.kernel.org>; Sun, 22 Nov 2026 22:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413866; x=1796018666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
        b=afE+iKsHfc4xGQWKOR9pz5A41wAXP75O50BOpyebZ4JW8StnnX1LTIhxWRUrAShViR
         qQNMp84nRhljzEPNLAc74NKlS7CsjTTT63KRIuLGIbu2KwtxbCbYPMjK6NmNBZOw8Kb0
         4FjZTMAeO3YVOXM8B8oqOTgSGAL1o9fojxL9ItczwQDPZd/mrNy50SAYyX9AL0gdi8FO
         Glq2bhaxRSdayPKI+wUF621gGIC3T880/5LpBjfepvnaTdgOt7oUIyoshjiJ5+nz70OT
         gXLJwQAUbE1Qo0BFnC1lrrDB3yXo61yWL/pU1DsvUqobuJX5B9cDKbGmEItZKPUR6fZu
         Iq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413866; x=1796018666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
        b=0xySWhezi2O5CZVZ+HoA2XJ3ZH7jYwu7WLKQMj0I1eJNUpnDyPbRLzEqb2CDWzwmMG
         HpUUjdVfKluz/RKsztWiC0ElJEIFVt+0HL/16Z/HKLISgFLAH8ttPGXpoiALc29Lq7If
         PoJ6XA7W2cwgRjKWett/nam6NheLRjPqKKm4FpfJaRNofMBoWBTCjRK3m4CHieq3pLLz
         K7txQ9vM8DRptXv45ruJ72/DptmQhZ+gFURpRHGqWqVNofiEodbscWVrz3kIc+NTnSnm
         Rf6huG2NiYb9ZVPsimqFgd7Z1w3Pb1CfbSWkTGYKCO5j9xJX5+8lL9/MfF+2ejJLNOta
         pt3A==
X-Forwarded-Encrypted: i=1; AL+hErHDwGItZ0U1PjqcA/AfOT/57lPFyJMiGDKqxiuEHastopw4A7xpKizZaONtTbES2+VD2FfPJX+uEOj+l/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jgj4DZg6otnZEdBbU+4aLH2fnAM2xHn2737vKGqk1jBCErmkR
	jNUuNm4qe8LaFRDGnlLHPkneHcFeI1S5jyxfPytYfYQWhKKVwKV/iO/1
X-Gm-Gg: AZFdTZeb9NAwv3t/pSx+CIKNwbpRev6R01eKzsV5oj9FHxahEkovuolT2N+hENYz5tt
	HNV6qXxUeL2HahRjernk8vflioguLA34API23RfFwZC6Bmiv+VuEUn2bK4aQGrKN77/dweXi25u
	fStLx2UuBK9FXOY9l/wS39Uy0HTinPsFbjXQPIk2cfoa8E0Cqh4+bGnNW0TEcOLaxINYa3rIwNX
	JuuoCHe58tr1I1puYVYgyIvAQw3M+t4LFHbq4OvNiUpctDsrf87IPDAJtOx6Owo8YKO82HbekFf
	xydkzNcCIdijFu8bKEMyxP/X1pCer9TXEk4wtKps1ArxBKUSTY4nM8r1lVCAKaSFn/1Wr+UX0dA
	880ISARf4SfYI2zuM/bAgwHOmrhgzVF2AXixwTl4znpd2+C63pZ3960yvoSscH4j4LJthahuLiN
	gH3B79XuqrQXDt7YBjWgTVqEPLSpELM2TeItRNFpV6gaWmn1M8d4F0oaUPOey0WfeSop/caGpwu
	JpJQSeFiy37h7kEQR94W3G2+8R/kzbhgmZN+f5ElhTmNupmzy0VNJGETdF553WksETI7TnmukQ3
	Vkpl+Ljuoy119MjTSRVNgSXY2VrgyC8PJ0cEMvgB8aogfFP0PP3JvaeFk0A80eo1oSO11TROR5m
	CXFr7cXXwL5LzYSSFQVJ7Hvsp9xb7dlOfG2d3ApsaDtRSKBQkNgjjFLxYJz2FqJclitfRK8jxfb
	mBEmU0krf+pKtN
X-Received: by 2002:a05:6830:2696:b0:862:c9e8:5788 with SMTP id 46e09a7af769-86314febd1cmr11692365a34.0.1795413866122;
        Sun, 22 Nov 2026 22:04:26 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:25 -0800 (PST)
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
Subject: [PATCH v3 0/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Mon, 23 Nov 2026 06:01:54 +0000
Message-ID: <20261123060419.119078-4-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The Hyper-V IOMMU driver frees a paging domain's page tables even when
HVCALL_DELETE_DEVICE_DOMAIN fails and the hypervisor still has the
domain. Patch 1 fixes this when a domain is freed. Patch 2 handles the
same failure when the allocation of a new domain fails after the domain
has been created. As Yu pointed out, the current Hyper-V implementation
does not adopt the page table root in that case, so patch 2 is
defensive.

Changes since v2:
- Patch 1: Added Yu's Reviewed-by. No other change.
- Patch 2: Reworded the commit message and the comment to say that the
  current Hyper-V implementation does not adopt the page table root
  when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, and that the change is
  defensive (Yu). Dropped the Fixes tag for the same reason. Added the
  Reviewed-by tags from Jason and Easwar. No code change other than
  the comment.
- Rebased on current mainline (8dac6df92a2e).

Both are compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1). I have no Hyper-V guest with the para-virtualized IOMMU to test
them on.

v2: https://lore.kernel.org/all/20261112195710.1417744-4-oss.patchbox@gmail.com/
v1: https://lore.kernel.org/all/20261105192738.70664-2-oss.patchbox@gmail.com/

Yuho Choi (2):
  iommu/hyperv: Don't free a paging domain the hypervisor did not delete
  iommu/hyperv: Keep a new domain's page tables if it cannot be deleted

 drivers/iommu/hyperv/hv-iommu-guest.c | 34 ++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)


base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
-- 
2.56.1

