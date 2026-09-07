Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965B10F1;
	Mon,  7 Sep 2026 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742587; cv=none; b=IesZPolRHwip6oZbl9U0sm0GUnCqJeBZFFNj3Agu7D5APbzwBwrrwpddikZC6g/ubK548GM5H/8DzTpgL75ZTR1bezAPfDL74G3QFA0xGq0RD+u/ZB9tzBDPdrO7SR+RabCN8LI5vOQrXyDTZE5lyDLQDeodVu32oY5Ge1UGy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742587; c=relaxed/simple;
	bh=Izd8bNgB9Ti83sycClvg2Fhi1fdjpuIvJKz5gwLn+OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2CwbC67BnihEPCI/xkjdNdUAfyDoMn2Ho343fRvE2ydA/P7dkRIa+epC/dAnRw9Pmm1ih9FvsmlGxFQnDGfxcMeqcid3GOjmbj/zZ8kTwVYkXK8ke0O50HN00Ib6wJG5af0On3MdtgAj8yBLWnDcb70p+tWlFG3ACUkBEvfva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFLYmJs9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFLYmJs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788742585; x=1820278585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Izd8bNgB9Ti83sycClvg2Fhi1fdjpuIvJKz5gwLn+OY=;
  b=hFLYmJs9EpU4gpXXTCL3nz6NAfV5UiacoTUXWMeE6WpsyWxz38NnJw0M
   WoHSMRe2nTDvAkFl18UYxdLAP5KQA7r0Ur1dfS5PXsVcXa7TbL3BzMdG2
   Qlh4UAEK0/mjTFLovVAZSSi8YL5sqSfwRVUaVYVLXpGHJFLIXB/AiyTUy
   Yh1BDAkwVSLCnnAu4liE7UXtkemcty/bAC5neoZZnvPgsdUSq5kzDbFpp
   N4K0RCWtFD4UhVZ7+id36y5jRG16D7xrgJTJ+ypNiB6/J/J8TqnfFfx5U
   ZAoof9myKXnZimMpKfGqiPdPGXKmLCa6CNYYlPvkTMCIQ+Q2jL47H0tM+
   g==;
X-CSE-ConnectionGUID: cWO5qJIARSG8t9Q9SBIiFg==
X-CSE-MsgGUID: UkMUA8JcRgSBOSqUO8QCbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89270036"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89270036"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 17:56:24 -0700
X-CSE-ConnectionGUID: QoXR4ffLS82gTmmwjVUGFg==
X-CSE-MsgGUID: 3j/hgJP0TYuhLtmNhc6ewQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="264373779"
Received: from emr-371.sh.intel.com ([10.112.106.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 17:56:21 -0700
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH] HID: hyperv: fix fortify write overflow in KUnit device info tests
Date: Mon,  7 Sep 2026 08:46:17 +0800
Message-ID: <20260907004619.2479833-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

allyesconfig fails to build:

  In function 'fortify_memset_chk',
      inlined from 'mousevsc_device_info_valid_descriptor':
  ./include/linux/fortify-string.h:430:25: error: call to
  '__write_overflow_field' declared with attribute warning: detected
  write beyond size of field (1st parameter); maybe use struct_group()?

Both tests place a report descriptor in bytes allocated past
struct synthhid_device_info, then memset() it, and derive its address
from the hid_descriptor member:

  report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;

Because that expression is a member reference, the fortify checks bound
the write by sizeof(info->hid_descriptor). bLength is exactly that size
here, so the remaining room in the member is zero and every write is
flagged, even though the memory really came from the caller's
kunit_kzalloc(sizeof(*info) + N).

Compute the address from the start of info instead, mirroring the
desc_offset arithmetic that mousevsc_on_receive_device_info() itself
uses. Deriving from info gives the whole allocation as the object, so
the writes are no longer attributed to a single member. The result is
the same address: (u8 *)&info->hid_descriptor is by definition
(u8 *)info + offsetof(struct synthhid_device_info, hid_descriptor), so
test behaviour is unchanged.

sizeof(*info) deliberately is not used for this: hid_descriptor is
__packed while synthhid_device_info is not, so the struct may carry
trailing padding and the report would land at the wrong offset.

Fixes: 83df7b5fa6735 ("HID: hyperv: add KUnit coverage for device info bounds")
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 drivers/hid/hid-hyperv.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 6579bd19da13a..f1042b36d10b7 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -657,6 +657,25 @@ static struct mousevsc_dev *mousevsc_kunit_alloc_dev(struct kunit *test)
 	return input_dev;
 }
 
+/*
+ * Address of the report descriptor that mousevsc_on_receive_device_info()
+ * expects immediately after the HID descriptor.
+ *
+ * Computed from the start of @info, mirroring the desc_offset arithmetic in
+ * mousevsc_on_receive_device_info(), rather than from &info->hid_descriptor.
+ * The report lives in the extra bytes the caller allocated past the struct, so
+ * deriving it from the member would leave the fortify checks bounding writes
+ * by sizeof(info->hid_descriptor) and reject them. Note sizeof(*info) cannot
+ * be used instead: hid_descriptor is packed while synthhid_device_info is not,
+ * so the struct may carry trailing padding.
+ */
+static u8 *mousevsc_kunit_report_desc(struct synthhid_device_info *info)
+{
+	return (u8 *)info +
+	       offsetof(struct synthhid_device_info, hid_descriptor) +
+	       info->hid_descriptor.bLength;
+}
+
 static void mousevsc_device_info_zero_blength(struct kunit *test)
 {
 	struct synthhid_device_info *info;
@@ -687,7 +706,7 @@ static void mousevsc_device_info_valid_descriptor(struct kunit *test)
 
 	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
 	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(4);
-	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
+	report = mousevsc_kunit_report_desc(info);
 	memset(report, 0x42, 4);
 
 	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 4);
@@ -713,7 +732,7 @@ static void mousevsc_device_info_report_desc_oob(struct kunit *test)
 
 	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
 	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(64);
-	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
+	report = mousevsc_kunit_report_desc(info);
 	memset(report, 0x42, 8);
 
 	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
-- 
2.43.0

