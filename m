Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E7446C18;
	Fri, 25 Sep 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363281; cv=none; b=FJdve+dG4jnnGfZ8LdYjGMQZzu36PW3AdUhyBJLI95QgIk4N27IHttvnBrD2h3vJlXdBV3lsBgeZN/XSBj+wqqFI5prFSe7yPiEpFIzW/M0VzKxTWxVMjxz4T4VnPMLA5nhUPeEB4m1sj9LewWc/gM4Orwlff0fiwP6OTFwIuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363281; c=relaxed/simple;
	bh=wu2RauUV2klIodqyYhxceGwJhMVCq7J0NS+fs4JZDY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfN8vNmsM2NnFGNu9pf1neyfzLv7TvlG3s2cN7asLEcU+rjdd1bNV9IL1eBgQKGQOeD+iZbPB/aGyXe/o2D27hjrUz+RolkLckSXeuf6a7WyFJnZqqw75gPPvKTxQf5NIS5G5Ha/VRYH+4E/uHsqJQLNDYhslLHJvnwDCzzPmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gwxFt+WV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gwxFt+WV"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B3A520B7169;
	Fri, 25 Sep 2026 12:06:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B3A520B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790363215;
	bh=venY7MQrc3Gwj56hsbIcioxSPSqsWqGdTpJhwhLC4sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwxFt+WVUHXhid9dJRh3Bq7YkWZu3ycBB+Dln5oFqJSY0dIhjn1Svq2hiH3+AumQa
	 Wn0yr+muwA2QESQ81N0TavLJGCOghO9Y0upUvPEJmunNF7qIF/eaIUx8iY7HEn2Vs8
	 TwqwXwqsGTANNJqw753Dcsr9kYUi+HdBYm3QVMpk=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Date: Fri, 25 Sep 2026 12:07:34 -0700
Message-ID: <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move or
attach devices to another VM address space provisioned by an external
owner, such as a type 1 hypervisor.

This is not a paging domain and is not sysfs-selectable as a default
domain type. It requires external owner context, such as a vIOMMU.

PV IOMMU drivers are expected to use it when moving a device to a guest
VM with an already-created S2 IOPT.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..d0bd3ef00379 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -220,6 +220,8 @@ static const char *iommu_domain_type_str(unsigned int t)
 		return "Translated";
 	case IOMMU_DOMAIN_PLATFORM:
 		return "Platform";
+	case IOMMU_DOMAIN_EXTERNAL:
+		return "External";
 	default:
 		return "Unknown";
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..ede77b90f0fd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -188,6 +188,7 @@ enum iommu_domain_cookie_type {
 
 #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
 					      on a stage-2 translation        */
+#define __IOMMU_DOMAIN_EXTERNAL	(1U << 7)  /* Externally managed translation */
 
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
@@ -207,6 +208,13 @@ enum iommu_domain_cookie_type {
  *				  represented by mm_struct's.
  *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
  *				  dma_api stuff. Do not use in new drivers.
+ *	IOMMU_DOMAIN_EXTERNAL	- Externally managed domain for moving/attaching
+ *				  devices to another VM address space
+ *				  provisioned by the external owner, such as
+ *				  a type 1 hypervisor. This is not a
+ *				  sysfs-selectable default domain type; it
+ *				  requires external owner context such as a
+ *				  vIOMMU.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
@@ -219,6 +227,7 @@ enum iommu_domain_cookie_type {
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
 #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
+#define IOMMU_DOMAIN_EXTERNAL	(__IOMMU_DOMAIN_EXTERNAL)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.43.0

