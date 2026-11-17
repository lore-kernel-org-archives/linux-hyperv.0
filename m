Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906938;
	b=Xa3ru+nVHt2LTmTb9rRMlVkxb/l/XScHWfX8jpN/S9KXsSHMPHCqnJigEly9f98lRQu5
	 tGjgjxkR1R2XWCgnA5FtMImb/c/kiaTTzoV9iETpwjHhOdEj1GURKwurlBl4p0tqzBKaz
	 Wi1KNuaTx+anpQek9fRBnMT83s2Z7eeFY3BjzBiZc2YZWoniplZfxinX3rmafvh/KxBwO
	 i/mjCeLw+hwNKS1EnkMw7xsurMmrWdm1J2IkdliXL9h5+bLouI/8XGYwr16UD8Wpnjpe3
	 nyTrEDBLSAQbkDeYa/iv1NuVtTKd8SlZsv2xkbb0zl1fC//aKnKdApM3G8P0PInsa+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906938;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=haIaCqnkPXAHp1Kini3BdEawsrf6TM0lpTm8+3Y9uDc=;
	b=ZjZFKApB5nsuPt0DySyxAwwUqjwts+CRx7Fz7/r/ihSNL28BY5N+Ukp/A8Xc9KbOQl11
	 iVn1DDWhgOl1ptp4zonIjejcukd4ZTcqBz8tCrlLw2t+sH9A8B/+np0On0J79BnSqx3FO
	 h1eZw5Nnk34HMcK4GlYJmM6h1u7BNUcLZfDBik12j8W/+F+DWmpnRgnqosq3S6L4CGTSG
	 6jKapuPigpyeinmRB+qFsi/J6ypky7pJ/VeVERvbUejnrMVm9lbUvaHpBKYc4hTk8UgF5
	 qhxTkoalrFWuzfmgRxlSGpjEK5NtfnCqK7QpYdcose1IlWnEWb3zYcRSyEBId3Xk0xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qMQOK8SB;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8DC606A323;
	Tue, 17 Nov 2026 09:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8DC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qMQOK8SB
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id AFECC20B716C;
	Tue, 17 Nov 2026 01:15:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFECC20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906937;
	bh=haIaCqnkPXAHp1Kini3BdEawsrf6TM0lpTm8+3Y9uDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMQOK8SBIVPFZ5+p8+S+D2OGzUXm9QO/5HNRfVeLXl5GbPe8/vkeU9iCioXHT+4gN
	 ws2wWoBj+xtOyth/MDSzUk1ks9OJmYWmrrU9vzYa6IkB7XdZ9OJrn53M+AXcms2ClH
	 Jvy5QoNZT808sQbB0ZvrCds6rGgHRtmySN8ZyTJk=
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
Subject: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and ASID transitions
Date: Tue, 17 Nov 2026 09:15:05 +0000
Message-ID: <20261117091507.2088642-4-namjain@linux.microsoft.com>
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

Successful Hyper-V flush hypercalls do not run the guest callbacks that
remove stale CPU-mask entries. Use the native flush path when the common
x86 code requests trimming.

Global ASID transitions also need these callbacks.
finish_asid_transition() requests a flush so that CPUs still using local
ASIDs switch to the global ASID through flush_tlb_func(). Use the native
path for these requests too, without filtering the supplied CPU mask.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 1ea57d642faa4..375f23b157ab3 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -70,6 +70,14 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	if (!hv_hypercall_pg)
 		goto do_native;
 
+	/*
+	 * Trimming needs callbacks on stale members. Global ASID transitions
+	 * need callbacks to switch CPUs still using local ASIDs. A Hyper-V
+	 * flush hypercall does neither.
+	 */
+	if (info->trim_cpumask || mm_in_asid_transition(info->mm))
+		goto do_native;
+
 	local_irq_save(flags);
 
 	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
-- 
2.43.0

