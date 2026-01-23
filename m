Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9426163;
	Fri, 23 Jan 2026 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132156; cv=none; b=MPZefNwMT2wBvYrDaK9pJ2tkZJ+OYB66NBwN83dhKPbYQ4RksLD3wKIYv3yVVWPNx3PPzRrdmThEW/OF/FsfBhX1irFLIWSm4Cnez+P4aNUnSdXhxB1L5mH1POWN8x8gjG5wS7TKjjV+hZrGX+j+TKDj7vP8sCN3wTrc5/+ppkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132156; c=relaxed/simple;
	bh=nNcTBApfRjCfBuW+Cz8XEj3WoIA/I6Xd2tXSHbDP19E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBlc/WpCm+UMyjDn8o6ysuth3vV1NamofX8wgRzyWguViJwFUoGgG/sVG9+7c0L/umYhkfRw//diIAQRjPRfiH5hlKM06DxccReBbTSBRpZhjnQif2DTCWGl/9+XjmyRyQfrPRRc/twXfd7XABoiEU7QV2Ae0QkL25DkdGUNxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iBFDGT54; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iBFDGT54"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45E8D20B7196;
	Thu, 22 Jan 2026 17:35:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45E8D20B7196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769132134;
	bh=hOltQxHdeY9K7U1HdsyL5wctDElwKdfqcvWb9XBjfJ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iBFDGT54dN5Msyj0teUw1OK0q7kTkNB6OgavSRcRMTd9G1+RoCQ8hG+hwjQzwslr5
	 ze2bFZ3f3qpuYvVl80HIYZQj/POoYLifpp+Y5VhaVIvxUo9aTRN1GmLjFP/5AYpgCo
	 zgcpVJsDXYsNuCX9tvV80U96S8juNo2Judefwo7c=
Subject: [PATCH 4/4] mshv: Handle insufficient root memory hypervisor statuses
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 01:35:34 +0000
Message-ID: 
 <176913213416.89165.12097472046071061525.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When creating guest partition objects, the hypervisor may fail to
allocate root partition pages and return an insufficient memory status.
In this case, deposit memory using the root partition ID instead.

Note: This error should never occur in a guest of L1VH partition context.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c      |    2 +
 drivers/hv/hv_proc.c        |   14 ++++++++++
 include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c7f63c9de503..cab0d1733607 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -792,6 +792,8 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index ac21e16f9348..89870c1b0087 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -122,6 +122,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
 		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
 		break;
+
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
+		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
+		fallthrough;
+	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
+		if (!hv_root_partition()) {
+			hv_status_err(hv_status, "Unexpected root memory deposit\n");
+			return -ENOMEM;
+		}
+		partition_id = HV_PARTITION_ID_SELF;
+		break;
+
 	default:
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
@@ -135,6 +147,8 @@ bool hv_result_oom(u64 status)
 	switch (hv_result(status)) {
 	case HV_STATUS_INSUFFICIENT_MEMORY:
 	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
+	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
 		return true;
 	}
 	return false;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 70f22ef44948..5b74a857ef43 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -14,34 +14,36 @@ struct hv_u128 {
 } __packed;
 
 /* NOTE: when adding below, update hv_result_to_string() */
-#define HV_STATUS_SUCCESS			    0x0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
-#define HV_STATUS_INVALID_ALIGNMENT		    0x4
-#define HV_STATUS_INVALID_PARAMETER		    0x5
-#define HV_STATUS_ACCESS_DENIED			    0x6
-#define HV_STATUS_INVALID_PARTITION_STATE	    0x7
-#define HV_STATUS_OPERATION_DENIED		    0x8
-#define HV_STATUS_UNKNOWN_PROPERTY		    0x9
-#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	    0xA
-#define HV_STATUS_INSUFFICIENT_MEMORY		    0xB
-#define HV_STATUS_INVALID_PARTITION_ID		    0xD
-#define HV_STATUS_INVALID_VP_INDEX		    0xE
-#define HV_STATUS_NOT_FOUND			    0x10
-#define HV_STATUS_INVALID_PORT_ID		    0x11
-#define HV_STATUS_INVALID_CONNECTION_ID		    0x12
-#define HV_STATUS_INSUFFICIENT_BUFFERS		    0x13
-#define HV_STATUS_NOT_ACKNOWLEDGED		    0x14
-#define HV_STATUS_INVALID_VP_STATE		    0x15
-#define HV_STATUS_NO_RESOURCES			    0x1D
-#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED   0x20
-#define HV_STATUS_INVALID_LP_INDEX		    0x41
-#define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
-#define HV_STATUS_OPERATION_FAILED		    0x71
-#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
-#define HV_STATUS_TIME_OUT			    0x78
-#define HV_STATUS_CALL_PENDING			    0x79
-#define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
+#define HV_STATUS_SUCCESS				0x0
+#define HV_STATUS_INVALID_HYPERCALL_CODE		0x2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT		0x3
+#define HV_STATUS_INVALID_ALIGNMENT			0x4
+#define HV_STATUS_INVALID_PARAMETER			0x5
+#define HV_STATUS_ACCESS_DENIED				0x6
+#define HV_STATUS_INVALID_PARTITION_STATE		0x7
+#define HV_STATUS_OPERATION_DENIED			0x8
+#define HV_STATUS_UNKNOWN_PROPERTY			0x9
+#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE		0xA
+#define HV_STATUS_INSUFFICIENT_MEMORY			0xB
+#define HV_STATUS_INVALID_PARTITION_ID			0xD
+#define HV_STATUS_INVALID_VP_INDEX			0xE
+#define HV_STATUS_NOT_FOUND				0x10
+#define HV_STATUS_INVALID_PORT_ID			0x11
+#define HV_STATUS_INVALID_CONNECTION_ID			0x12
+#define HV_STATUS_INSUFFICIENT_BUFFERS			0x13
+#define HV_STATUS_NOT_ACKNOWLEDGED			0x14
+#define HV_STATUS_INVALID_VP_STATE			0x15
+#define HV_STATUS_NO_RESOURCES				0x1D
+#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED	0x20
+#define HV_STATUS_INVALID_LP_INDEX			0x41
+#define HV_STATUS_INVALID_REGISTER_VALUE		0x50
+#define HV_STATUS_OPERATION_FAILED			0x71
+#define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
+#define HV_STATUS_TIME_OUT				0x78
+#define HV_STATUS_CALL_PENDING				0x79
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY	0x83
+#define HV_STATUS_VTL_ALREADY_ENABLED			0x86
 
 /*
  * The Hyper-V TimeRefCount register and the TSC


