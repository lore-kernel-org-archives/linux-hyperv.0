Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAE3CC9F6;
	Tue, 26 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836865; cv=none; b=aqoGd0Bb1UvNUe0M4VYklUzjPbJJpTfl82XTZqdIVRB0HU4Y0Lhw0kBmZFfsYvL073Mg1fTabQtwoj0wR1XQTRkQwyO89WGnXQa70qOABM6KHix0OqLZYhj5wQ/yrdYhmzmL54q4kgbaESjowMXGWSl43975AhQot4K7iHzGf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836865; c=relaxed/simple;
	bh=1atsktsZ7nDIyB7JhdB0luP485sWATNjHmlMEUSfzzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpsz/aQPgIhG3o6+GPga+3aYA1lxD5vz3pTRfjPa2Haj29GmFFmJCWrMkyJlThvhj030GJEiN4szYpaGIsbRQL/nYDPpTm0eK0rxo43Ot01Y4B0z+ij0nwkyutFZwcp20R7iRt7M9vwx1D8uASn2J90v9V9SmWRQr7iI2nKVZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kKI+osqm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kKI+osqm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v254rOneSjR785k12sson5KrFqb/xvuIEKg85cM7HMQ=; b=kKI+osqmJ2mekcgZMYrFKLMaJ5
	Q5FD965qG36EVXAu0TtnIErDT34rSZOpsJHaJx90Z29CyoAHZHeEycyMz2NozytUDusg+HatXaT1Y
	W463yJwQbuyjWp15APoYB1wP+na8DdPpV6x6K47UrMbPLPC4zWOHKY1yR/04we7s0wEO/y6+F43iu
	lCYnKU885c4tbIt58LqFR4zFw6XWLEFZJOOuV51GfBuSWO/hg2P/DaPpSWpIuF1qrU1valIdWc1jN
	4h7hIqzHlI/+7226BZCjcSimr3cZeCQJ+Fr7oBGu+NiWqYmmzlojLaZ3zJ4E2AjETHQqe8uOG90yL
	TDC2GVhg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-0000000CV9I-0cwK;
	Tue, 26 May 2026 23:06:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r5-00000000Zcl-3TYX;
	Wed, 27 May 2026 00:06:35 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] KVM: x86: Compute kvmclock base without pvclock_gtod_data
Date: Wed, 27 May 2026 00:06:32 +0100
Message-ID: <20260526230635.136914-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526230635.136914-1-dwmw2@infradead.org>
References: <to=b6d2173312b8d0469774846eb18b9799832d9cfc.camel@infradead.org>
 <20260526230635.136914-1-dwmw2@infradead.org>
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

get_kvmclock_base_ns() needs CLOCK_MONOTONIC_RAW + offs_boot. Compute
this directly rather than reading offs_boot from the pvclock_gtod_data
private copy. offs_boot only changes at suspend/resume so does not
need to be atomically paired with the raw clock read.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6f740f95ff9..d057f42603e4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2402,7 +2402,7 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
-	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
+	return ktime_get_raw_ns() + ktime_to_ns(ktime_mono_to_any(0, TK_OFFS_BOOT));
 }
 
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
-- 
2.54.0

