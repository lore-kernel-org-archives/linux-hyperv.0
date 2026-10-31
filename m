Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405687;
	b=yTDrc810/Zxro3urYUGvBHt+gnDFnYk9IirWCd8MYnD5h92Dtq93gJK+ubPDabFaewGD
	 kaVZhxOn+YTwDqZZ3RFyIYPGmOa/rCgquCWCR9ABIHcGnl1bhEPCHRILVdY0tYNgcstRy
	 rXFbWCyDIbJahq13Um4VWZEQeHmsZeEORT4dmrZ1eIiNV96YxqPSg0c93Pe4zVrXYGkkJ
	 3MzXqWAN9+mhKJyHeD4NiBhXyYNw0DYnO5I2NwnADAvTRJzA6wPZMM6Ltn9m4vnxixHHv
	 cau3J2YvxHwpixIaGgj7N5kBEgmu7E4RBG0b05rayEaaab8Aoa1fEde815j5dz/dXPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405687;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=UZaxZ3Xj6BQMasztnzAo4Ozc8Pd1UX24Y0xc+tKwRzc=;
	b=5BxkvwB7NJOy9sVnh6NzyIc3iDJnvwUkpS+r2K7rrEyI6ADGlEEuTYR5z+ofPZ4gsU3p
	 /cWrp3Ie4RA9zo4WeaWr1uzxGajggc1AGbl9RyaERTmxFwP23WszkdOdGqibaISpNRJJc
	 yf81D+55BQve6uyEUh2CpdhjeQbSa9WoTfTUjl2Vz5rQErdYtH1adot2n2hXD/IMYPJOc
	 U/6ynDg+3vOXHDTfvVV9yjv9gMWWy2b8BTejOzOGpHA0/ulPeDRtffCU5pNDVfsHx/Qwc
	 +fcknwjJqTYHiDt4VyShpgU11IHr6AxwvWmn+qunuvcdVnv0PVVQqeHnyd8B1NW9yOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y65z0RwT;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9C606A33A;
	Sat, 31 Oct 2026 00:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD9C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y65z0RwT
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E5F720B7166;
	Fri, 30 Oct 2026 17:14:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E5F720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793405668;
	bh=UZaxZ3Xj6BQMasztnzAo4Ozc8Pd1UX24Y0xc+tKwRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y65z0RwTxcPxIGklvi2ejn+smW3Rp1xeaXpQyWkxTFkLcb85HhS+tBgPn5stYbQ/J
	 1ug8CxZ0WZJKd3v+W3BbqdnQpTLCtLbVvo9sdZ9Tgik64XiAaGbHfLyDMxm125r9Zj
	 aimCJDo+Lov4J+yZ8WboIWok1h3IWqG4/xzk0zlY=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	sudeep.holla@kernel.org,
	thuth@redhat.com,
	will@kernel.org
Subject: [PATCH v6 6/6] arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms
Date: Fri, 30 Oct 2026 17:14:12 -0700
Message-ID: <20261031001412.4150488-7-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
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

Provide an arm64 implementation of hv_is_isolation_supported() that
overrides the __weak default in drivers/hv/hv_common.c.

The implementation deliberately does not depend on
hv_is_hyperv_initialized() because hv_common_init() consults
hv_is_isolation_supported() before hyperv_initialized is set.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index da6c3aa0..8a2c446 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -187,3 +187,8 @@ bool hv_isolation_type_cca(void)
 {
 	return is_realm_world();
 }
+
+bool hv_is_isolation_supported(void)
+{
+	return is_realm_world();
+}
-- 
2.45.4

