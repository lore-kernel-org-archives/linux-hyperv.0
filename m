Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513436;
	b=NkZ0T2ebMuvncUgYNHtQ4Lu8/h5fVX/sHiwP4yLpqVR2TS2kkG+TdGX6otkbuX6PrfNH
	 7lL0nzMh6L/1JppTPXtCXmCswrDqLRz8X/LVxWVgmD7ba63UzbEj+i2v5aK+4YICAe1Ew
	 bIRFhAyr8FKpHjkOYJbpFxToZgIYSxTGYlEUDGxwZHerK4dE4OSSo8X08QJB09sVMhgaw
	 GfmTuqABy+8UEahc88HCH99gQ1W/UoZqo7D/vHvECkBe/UZ0eaGG9zfFPVonCBBm4zCTa
	 fi61FfA1MUQjGKVE8ID2RMwN5gZE/vQG9h8sckSsYnc8UhMfi4rb/ZS2LoQSEADGOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
	b=PgdZnH2UEPEAq1Sx79pflJN6O3q2Ix4xRMPAcUSzBQSomTTUkzfiEh8UEtICme7tkXd0
	 lNww1A2quI4pM+gPhI+bUkQm34d0A0y61PnAwV03W8jSVbm2PKCwRuNcLYN5AWpccecrK
	 u5Ypr93yS4Otq8WF9iKNPN3ctAVJLjNYnUoKryeqzYUD0y9/VfxlK7bmElU85DowLJX4W
	 cJcBMGH4zlaWjgmL/8deBki21EWx7+wp2xhRziZh8pzK5G3G6xYW0X9RAAYyuJ+KEegna
	 zIzyFAGQv3kUp755bH3GJk3PWIwqgDXXAgUvQhg4BcwmMclC6NKkHguUEcDDc7K1bdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuqN8AiL;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0E606A323
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 19:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F0E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuqN8AiL
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-536c8f958d7so790321cf.1
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513435; x=1795118235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
        b=vuqN8AiLpAawFUwEbsflV39EWisNA7pPWcQPclrwWh/dzQgpYKnMgG7+Mh9504+EPp
         91Ld3TSaarfjoNBWrJvJcFIq7fhFbuHkRgG7QWlbrZ+DNsoAg11KnqygrP8xPHO5axIy
         w5BN20XTw0j3LA75J2jEtV2Q7GDCQgaQMp1hQevrWCDcbHpjLlN9umNXv+VbNsnCcnrK
         /l54kA9c145dl8URjgScHlFuVO4450jaL4ZK7q/KBtbTLDLoIUz1fGIhMJP9TBqDMCTC
         kLN+VAimubs6M5FHI4r+RNv+fFFUi750h5rJ4FyBE7CKyIWejDn4iXmM5T1/Ka80olCx
         5N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513435; x=1795118235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
        b=Va0x9+pXydMU2zsAub5/aKMa+sjgIaLCGNdfA5caRmqqbA/7Y7MPi9sgtM5la1R+9U
         cnINelLKTXVzRYKSVr6fHNvTBZ9ege105pPBTmnAAvQSJstYJtGSMHOqLILMW0HjCDo5
         DgX9HyUUE4fv/GpTeisi5BpDkB7Zol2qb01gYp+fx44LF4nMAiFQ2C/AeRK4VT136tj/
         f9z6VHsi7BmRhWIQ1ZyPIV0Yhw3SE0PkYeg2YhmtQY9374PwWtyYjQ9DnvVRnIKJHOWG
         wFfriwCZopDq2Js8SYeCYaJTP/HTyAxhgFYz6jPEwKWlQRIqEw5yhjPUBsFcs3N/PjLm
         We8g==
X-Forwarded-Encrypted: i=1; AL+hErEuKWJVEIjC5egCXG+6Ee835nAozN6Ugwr9BGt/n6pMpLvoShphQshkjb3KDeo88+vQvRfnRuojz9KNe7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RH+lV7afhPL0oeTB1nRcBy8LDTU7K/0fyysn3Vr7PFiuHiU1G
	4tVipYtTXWcRNvXd2m7NKdAL59sD41h88fHSNCw9YQ3euDTgJjG+v151
X-Gm-Gg: AYBFou2fsdqT1Pgl5JM0gWw33dEW1Evb0dHJQhY4VPa98FPRIOFShkkEWvezCF8eZ4j
	0TuihulKnfRwOt79n6uNCNfxfznD7qDj+2OJLdlVHdyjSfOKzQ7D9bupPflvlR8dTQvk21Y/ZlT
	AMKvzmhLHCZcrwdU1BeOumS5Row/wfZqObot6MJrJRsQMEZvWcyjzPvCYhSrjFEksy9wrUxNqC+
	5AQyE2TvH0MuFuRT1HL5n+yEIvq4j5XQcctqEpk+heIXi7i5x2eKYiZVg9VPwbxjGu97xJAeovx
	v4dKv4igSApH52ZrP+YfXPLyFa4DBikbJSBJugBTWJ/FQnGTM8P0MUk6VMtAw8d25IdKv+vBEEs
	uWd4a3ObrAjzOLR9tGzEDqXHMumh7hk7qJtG5DQeK1AW2PyTm03Y3HSGsoH1rBK2t1UuF9L+8Sx
	y7H+he9a8ZY4OQ7iB89tWyd3Vtw0IVMRSXDB26t9rtyB2IMoTsg3q812mo/a7WBDwN89Zr3L3AC
	UO3mWAmmAm3VZX7qgf9VfAIS2K8c/EZ3jzzH+d2IxD2LUtOc3XRBCFsAYmrjEzynZU58uYhekHm
	rdDHLOjOwYtLnP4R7XYc1vS1zbVz1IRW8NRzBiQKcDpJi2SvDQMh
X-Received: by 2002:a05:622a:8586:b0:55a:e65b:d959 with SMTP id d75a77b69052e-55ae65be1eamr2000351cf.8.1794513435248;
        Thu, 12 Nov 2026 11:57:15 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:14 -0800 (PST)
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
Subject: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu, 12 Nov 2026 14:56:58 -0500
Message-ID: <20261112195710.1417744-4-oss.patchbox@gmail.com>
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

The Hyper-V IOMMU driver frees a paging domain's page tables even when
HVCALL_DELETE_DEVICE_DOMAIN fails and the hypervisor still has the
domain. Patch 1 fixes this when a domain is freed, and patch 2 when the
allocation of a new domain fails after the domain has been created.

Changes since v1:
- Patch 1: WARN when HVCALL_DELETE_DEVICE_DOMAIN fails (Jason). Kept
  the Reviewed-by tags from Easwar and Jason. Rebased on current
  mainline (067c5c24cef2).
- Patch 2: new. Handle the same failure in the error path of
  hv_iommu_domain_alloc_paging() (Jacob).

Both are compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1). I have no Hyper-V guest with the para-virtualized IOMMU to test
them on.

v1: https://lore.kernel.org/all/20261105192738.70664-2-oss.patchbox@gmail.com/

Yuho Choi (2):
  iommu/hyperv: Don't free a paging domain the hypervisor did not delete
  iommu/hyperv: Keep a new domain's page tables if it cannot be deleted

 drivers/iommu/hyperv/hv-iommu-guest.c | 29 +++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.43.0

