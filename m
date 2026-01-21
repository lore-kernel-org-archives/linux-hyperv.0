Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA4421F05;
	Wed, 21 Jan 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034956; cv=none; b=jkZti9mpk+QhIrNiHd2ZMXzpAvwPG+ut0NwLrqij93NugxFfgAhYGrEfYQQEKZtMty4eceOV46La9Xu4Ld/XLS8H+m6t9ITMouScLWLGvMUJr2FYCUjYvl2x5Rk17yo3mcNx/qrJqJW4wycEwxNCkckaaXyFBWkdlm2uBprh9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034956; c=relaxed/simple;
	bh=xzg+wWpeslx7cmSf3+9oCHglph+ucNBV7vA7snnS3vQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB3rcxBhWQ9XA/c0Zi4gJ0/ZtTJYydAcAkB6f1fQHk77HJc67J8Nm2dEXNdjtxiOXqOZqhvZyubY0veZQyNSKVachyAZ0XyAsVwQb4YnEdmctL6Rya2GK4sqp0R9We3vWJ1EIZFks1iRcyMQZRcguZW3L0XOYbKBAwQTYQEvNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jr/fTc+E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jr/fTc+E"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46FBC20B7167;
	Wed, 21 Jan 2026 14:35:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46FBC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769034954;
	bh=qVZNQJTar5ROG4ASJsek+RWuoUtiqtq+N+dHoONkc9c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jr/fTc+EAAoohhzwGvY2TB5uszipsw4MSWwOwI5QJy+0vz+ecqa4+1PHzvojbYVcD
	 W6zgOfm/GRss/k3JpSgpGjPspHptmp/eh1vCsYTMbM7/CbIfxZyx7a2aVpQJkzkBk6
	 AG01AD+hbBnF3myf/w5IapBpEHVKDAPJ99RS40Rw=
Subject: [PATCH 1/2] hyperv: Sync guest VMM capabilities structure with
 Microsoft Hypervisor ABI
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Jan 2026 22:35:54 +0000
Message-ID: 
 <176903495416.166619.16629695002971245203.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andreea Pintilie <anpintil@microsoft.com>

Update the partition VMM capability structure to match the hypervisor
representation to bring it to the up to date state. A precursor patch for
Root-on-Core scheduler feature support.

Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/hyperv/hvhdk_mini.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 41a29bf8ec14..aa03616f965b 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -102,7 +102,7 @@ enum hv_partition_property_code {
 };
 
 #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
-#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
+#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	58
 
 struct hv_partition_property_vmm_capabilities {
 	u16 bank_count;
@@ -119,6 +119,7 @@ struct hv_partition_property_vmm_capabilities {
 			u64 reservedbit3: 1;
 #endif
 			u64 assignable_synthetic_proc_features: 1;
+			u64 tag_hv_message_from_child: 1;
 			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
 		} __packed;
 	};


