Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC672F7F0A;
	Thu,  4 Jun 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567098; cv=none; b=Bmw13Am5v4u90y8tYNKOsbzna5Brh2NICBh69Hu253qS/XKgDt+ebqCZkpBhjE6pFD1KnxhZcImhd/RFLz7q/E1SNvRTSdKm3aG861Eh8FldUhexioVLJEbwMRDdcghEFHgxRVL9gnHO0e5N1w6wP0CiAJ3mcPGQ2Zoq2sk1GYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567098; c=relaxed/simple;
	bh=B8796QuyddTOOJ87NCI4jbabmwrkPHns7USFWAaZl2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY25YZt7b0yIo0ETbXtaKN/bhxBOzjYu55RfF0FY0JAung3G16ucMGIsTuNeVWRkbjh2Zl3ERjeUZvUt4/LjZAXsBWDOYSCvzRV/lCowdZhBNGEqH/CyoUp4PcOwNtruK3EiZfN4mxK8l083cngdTSCP0Ae6DSpKmEBqbLPKJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yx7F8uK4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yx7F8uK4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gSKjiLbNkQCnWmrLULhPaz2f+CKpev4YmPlvbfnECWs=; b=Yx7F8uK4DtIsTGe8z5OuUeH1r0
	EQ/AhIXUsyCEuHEz4QaGhmUAIkfmfQXABfh0p7LnODrTeBFoYMVmuceN4fNAH/Uitri6g/vXxNxTx
	FeOlpY6iGVRnld4QMRoq9RL5dAx/+8zSyVvbhp2mrQuLPe5VCMiauiFAcffzXNJVJshquplsfhEkA
	3nZq1sardow2OAPnLe8qpYVJhEPncBiJG1gjOT2uZ3M322LU+kuvSU3ynHCO3GgrxQObWrK8cdINA
	ZvEfh6NhmfFs7gAnvPNXwWCFojYF4S+hfBMJrLbYh1eDGPFm4T9BT3jh8lDn6jgysCjpOfMraKfb7
	w/S32+PA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4pr-0000000EAMa-0wTu;
	Thu, 04 Jun 2026 09:57:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4pq-00000000H0o-2prI;
	Thu, 04 Jun 2026 10:57:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/3] clocksource/hyperv: Implement read_snapshot() for TSC page clocksource
Date: Thu,  4 Jun 2026 10:35:16 +0100
Message-ID: <20260604095755.64849-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604095755.64849-1-dwmw2@infradead.org>
References: <20260604095755.64849-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Implement the read_snapshot() callback for the Hyper-V TSC page
clocksource. This returns the derived 10MHz reference time (for
timekeeping) while also providing the raw TSC value that was used
to compute it.

When the TSC page is valid, hv_read_tsc_page_tsc() atomically
captures both values from a single RDTSC inside the sequence-counter
protected read. When the TSC page is invalid (sequence == 0), the
hw_csid and hw_cycles are set to zero indicating no value is available.

This enables ktime_get_snapshot_id() to provide the raw TSC to consumers
like KVM's master clock when running nested guests under Hyper-V.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/clocksource/hyperv_timer.c | 37 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index e9f5034a1bc8..df567795d175 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -444,6 +444,22 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
 	return read_hv_clock_tsc();
 }
 
+static u64 notrace read_hv_clock_tsc_cs_snapshot(struct clocksource *arg,
+						  struct clocksource_hw_snapshot *chs)
+{
+	u64 time;
+
+	if (hv_read_tsc_page_tsc(tsc_page, &chs->hw_cycles, &time)) {
+		chs->hw_csid = CSID_X86_TSC;
+	} else {
+		chs->hw_cycles = 0;
+		chs->hw_csid = CSID_GENERIC;
+		time = read_hv_clock_msr();
+	}
+
+	return time;
+}
+
 static u64 noinstr read_hv_sched_clock_tsc(void)
 {
 	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
@@ -492,18 +508,19 @@ static int hv_cs_enable(struct clocksource *cs)
 #endif
 
 static struct clocksource hyperv_cs_tsc = {
-	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 500,
-	.read	= read_hv_clock_tsc_cs,
-	.mask	= CLOCKSOURCE_MASK(64),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-	.suspend= suspend_hv_clock_tsc,
-	.resume	= resume_hv_clock_tsc,
+	.name			= "hyperv_clocksource_tsc_page",
+	.rating			= 500,
+	.read			= read_hv_clock_tsc_cs,
+	.read_snapshot		= read_hv_clock_tsc_cs_snapshot,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend		= suspend_hv_clock_tsc,
+	.resume			= resume_hv_clock_tsc,
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
-	.enable = hv_cs_enable,
-	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
+	.enable			= hv_cs_enable,
+	.vdso_clock_mode	= VDSO_CLOCKMODE_HVCLOCK,
 #else
-	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+	.vdso_clock_mode	= VDSO_CLOCKMODE_NONE,
 #endif
 };
 
-- 
2.54.0

