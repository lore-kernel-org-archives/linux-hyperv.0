Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440687;
	b=TrFmthm7fz1qj6Khw4D+NHvD72kViI7lgJVl7gvYaS96FkRNmM0KhwPex1h1KpTet9dB
	 Mx5atx7D5lxVZUA6EL1bQS4Ef8OQg1FBUT8dJ7Bf7r3+y+o/ffMs7nfy2aIKkKM1meXDq
	 9mR4ocYUfQERgxtM7Ml1qyfAmBprdSxLypcAt1LU73zxBkoZRPa0Enf9O8gLAm27gjWbn
	 XqDpUge549vBRjrRpCMoYUcqo8ne7qBagG06g9xcmrtLKyij5iv+aUhLevmZ/oHMfA0Wv
	 gtVkjXIGPH4Xuf14EfCEqYfh7rRkXjBUhOycAM96uM0aCwT2eItwm3agKQHg1m+HZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sdSp4JAEBIO1pQeZZS71rX8i5HCrtwFNUZ7pCreT77A=;
	b=Oks4l0ApARf/fxMhhBAJ7lsdrbO/JPa0BxQNAFduOkH3c7RxQdDJjQNfoT+su8KnSYMv
	 ggZFj2TaHb9JtyWTW4ei6OwBJldet8i78x4+COe10R+jZSpoBLu9e9BL1w7m87d2qPwi7
	 /oCLpTNX7C+PjYTgUNJs0gcR2XNYQsp14bjJ2Fxba8cuUFZmYxa5TyQFvIenP1udGDsJI
	 pw/BdzGNIrNK8RIhJEj7DIebi3ZPhLnBTnAmN55jxMUO1K4SqNEtKUKgOHP0KHtcfEv4g
	 0gej9KKI8GybeFR/qlB77fZ+G7Ap0A36v8v/CtvjPy/xM1GHewrJ8KWHGUQxwing8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gA7gYbT9;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D2606A89A;
	Wed, 11 Nov 2026 23:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A9D2606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gA7gYbT9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794440684; x=1825976684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dj125zGEvAXWXtzneUQm2Fo30+JV1EKjt/TJ4mkqfhI=;
  b=gA7gYbT9Pvw4OdGs+xH/J8FAORiqXLchVkKEmLBURxkb5ObfL1reGme5
   pkUQfNJWOMcA9rWi8DJcjJ8DvMAPZ/DZ8Z7Yt7TQKLwHRuy2pnJaOiOh0
   jkxRyKsTES31Lv+cb4NYVQsnwxpRPANrk8KcKjW2Og1dulIV2NK+R73ji
   2sE6pAE7HQoN4ou0UccY3xQ7lYml1ERxIZZmWch6Ab9ucCd5N1jwp5rpK
   3GR9P6H/QOj/p1ZaRxDHF8DaiO0DDlRWtluxTqIqrlx1FA1AQiH1Kzcuq
   o8L2b0i/Qc4QbODafAh773JXcj9F2NoPzbNpt753PoAqA950bi3OCZSU6
   A==;
X-CSE-ConnectionGUID: e5Zx13UsSe68kJnDYOczWg==
X-CSE-MsgGUID: fWLNpoetS4yHcrDjXraNAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099099"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099099"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:44:43 -0800
X-CSE-ConnectionGUID: kH3cqayDS3GUWnZAsbZHfA==
X-CSE-MsgGUID: h2vE+jaoRUKLZ6aRiGD2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10241290"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 15:44:42 -0800
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Date: Wed, 11 Nov 2026 16:44:37 -0700
Message-ID: <20261111234439.4098-2-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111234439.4098-1-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
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

<asm/cpu_device_id.h> exists only on x86, so generic code that
matches on x86 CPU models has to wrap the include in #ifdef
CONFIG_X86.

Add an empty generic version, so the header can be included
unconditionally. The CPU match tables themselves still need
CONFIG_X86 for the model defines.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 include/asm-generic/Kbuild          | 1 +
 include/asm-generic/cpu_device_id.h | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 include/asm-generic/cpu_device_id.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6e..fad71809ffa 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -13,6 +13,7 @@ mandatory-y += cacheflush.h
 mandatory-y += cfi.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
+mandatory-y += cpu_device_id.h
 mandatory-y += current.h
 mandatory-y += delay.h
 mandatory-y += device.h
diff --git a/include/asm-generic/cpu_device_id.h b/include/asm-generic/cpu_device_id.h
new file mode 100644
index 00000000000..05c38c3ca1d
--- /dev/null
+++ b/include/asm-generic/cpu_device_id.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_CPU_DEVICE_ID_H
+#define _ASM_GENERIC_CPU_DEVICE_ID_H
+
+#endif /* _ASM_GENERIC_CPU_DEVICE_ID_H */
-- 
2.54.0

