Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906951;
	b=QYhd05U8pPc6T0E19eLAxkFbU/epuCjeCPwSvfpOdd09WPcW+tzJ2lyonxTFv+huNtIB
	 jn/j2ZU9Ri2oXfY4IGpkreNSiqhSuQ5RoyQ92HBOkG7JYBGAiy6nhJk3cl6QKqRblM3Dg
	 grIeK71PRIVKXhSBkuaJpasnZUgnGeWGGpN3gEGhmz3V1Fx4RloRLoiwlt+v5BGhL4de7
	 pexXeelw4ZjfrzoIk3pFHdAhwCPvL3e7QDeth6Vor8NCX2c1AZzYS43hAO7SPiewhuxk9
	 ppOKRbmq7OJLHkMjSqOuyRLQ2YPw4OLmeRJ3Fkt8w4hNHw715o5GY17YUV0RtI4MqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906951;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=MhlaR7A+LQxt9xjwwwTsFakZKyNa9nGzuu8euZ7poyI=;
	b=ED4+SFBDCQ+jcwbbIV91oZbuqKd2tw/k4bqhG9XxoCBe/uEgOIRowCxA4ZbpdmunGGEq
	 55Cl+cVRBOJyCpWT598VHU4bX75iFxUM5Wru/50NAA8G7h1yf3u8dO/+ZtXOUJXC1TCNU
	 BOuvasz7DpWo4wE8CywQliylpL/XHWuuK34gyTy0LsaO3gVBaQ7h5KU5a57YZyuCyQDWm
	 hHS+wIO1hfbjOG2kvPUHax9Wd6XooiIlOZB7iyioZYHuwAHHpiJR1IDxSSgp5y7zQB/at
	 jchK0yT8uNRooK8KaaUWrbrS7yy/Adqbht6roYamCjggqaZ+/8EO4qC1sbPlfpM2rAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gC9aTTrG;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF3606A32C;
	Tue, 17 Nov 2026 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5DF3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gC9aTTrG
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 963C920B716A;
	Tue, 17 Nov 2026 01:15:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 963C920B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906950;
	bh=MhlaR7A+LQxt9xjwwwTsFakZKyNa9nGzuu8euZ7poyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gC9aTTrG6xY9xTDt+gDihzT+FphMBzNSG1XiO7sGqPoK+rVAutfSMr/2Bu4ZOUFoK
	 /DtwQwa0WMsUBUg3ysqUOkMkGWMkSzl8T75TmMuJcMTICdPJtUpFs1AfFGPpt35a1U
	 17+RDPxIg/zdmKUKZpugUflyyzQdYwd9HEYmewL0=
From: Naman Jain <namjain@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org
Cc: hpa@zytor.com,
	riel@surriel.com,
	mhklinux@outlook.com,
	bigeasy@linutronix.de,
	zhouchuyi@bytedance.com,
	houwenlong.hwl@antgroup.com,
	qq570070308@gmail.com,
	bastien.curutchet@bootlin.com,
	namjain@linux.microsoft.com,
	dianders@chromium.org,
	jgross@suse.com,
	hawk@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] x86/hyperv: Request mask cleanup when no remote target remains
Date: Tue, 17 Nov 2026 09:15:07 +0000
Message-ID: <20261117091507.2088642-6-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117091507.2088642-1-namjain@linux.microsoft.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
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

Filtering avoids unnecessary hypercalls but leaves historical CPU-mask
entries in place. These entries can keep later flushes on the multi-CPU
path even when only local work is needed.

When no remote target remains after filtering, request native trimming
of the original candidate mask instead of waiting for the periodic trim.
Copy the const request so only this call requests cleanup.

The native predicate still skips lazy CPUs, so cleanup may not leave a
local-only mask. The new early return also makes the empty basic
processor-mask check unnecessary.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/mmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 833eaea1d3fa8..545a25fcf6c34 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -102,6 +102,21 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		}
 	}
 
+	/*
+	 * No remote target remains after filtering. Request native cleanup
+	 * of stale, non-lazy memberships so later flushes can take the local
+	 * fast path when possible. Lazy memberships may remain.
+	 */
+	if (cpumask_any_but(flush_cpus, smp_processor_id()) >= nr_cpu_ids) {
+		/* Keep the caller's const request unchanged. */
+		struct flush_tlb_info trim_info = *info;
+
+		trim_info.trim_cpumask = 1;
+		local_irq_restore(flags);
+		native_flush_tlb_multi(cpus, &trim_info);
+		return;
+	}
+
 	if (info->mm) {
 		/*
 		 * AddressSpace argument must match the CR3 with PCID bits
@@ -148,12 +163,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 			__set_bit(vcpu, (unsigned long *)
 				  &flush->processor_mask);
 		}
-
-		/* nothing to flush if 'processor_mask' ends up being empty */
-		if (!flush->processor_mask) {
-			local_irq_restore(flags);
-			return;
-		}
 	}
 
 	/*
-- 
2.43.0

