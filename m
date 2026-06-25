Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC33EE1F8;
	Thu, 25 Jun 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408910; cv=none; b=r/byyIy3W7G/7mzRR75xFJhUSqtDmnLAsl47Kexs9tBcI2/9RMwjTJGN5EOD32gvGm9LWvDfzr6gn7KQgPtM8rQrdz6fM92dq/qBuSB9oWd7cMA1D1Dw4lPClZjR302x9TWyRO2QhjU96thagz7ocBrmT7Fcwj/QDHzyH+kUPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408910; c=relaxed/simple;
	bh=zEk5sFNW6pqe6e2eBsawwoFQuYsd70ozm+V7GXOXLmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOBlNHruzR9Y9d08a5V8bau4j+LmtG7oZoDSvDNfadTddkNS7838zDtdd2ph0MdexLjXaetlocFuBodFTlmFRom+Zm2GaJP48yIyFkVO3KaRTB9+t08xS/m0wmVNJ26BV/BqBUmQKiSYKncpfD7KFpxbuUYF5T8gq+NIDFPrx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XiBBDjmo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XiBBDjmo"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 468DB20B716E;
	Thu, 25 Jun 2026 10:35:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 468DB20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408903;
	bh=5qXijFv0wIQN76+QfzfXNNBj5pz3HvHQr8PE2OKbhL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiBBDjmosB83q+Narr6sdJYR2vnJFfZCtpMKocf8XbUho8BA5YgiU+sUacn68FcQU
	 d4mbt7HaTPWLRE3jVwIX4ZWVKVPv2JJrMZY8DMxODFhCqfAVhMmaWrI8xOQOdUinSl
	 KmDmpDIYPxUX/8CdROgLc5fmhicako9w2gHuo+1g=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [PATCH v2 6/6] arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms
Date: Thu, 25 Jun 2026 10:35:00 -0700
Message-ID: <20260625173500.1995481-7-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an arm64 implementation of hv_is_isolation_supported() that
overrides the __weak default in drivers/hv/hv_common.c.

The implementation deliberately does not depend on
hv_is_hyperv_initialized() because hv_common_init() consults
hv_is_isolation_supported() before hyperv_initialized is set.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 8e8148b723d9c..62995b6133f6f 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -169,3 +169,8 @@ bool hv_isolation_type_cca(void)
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

