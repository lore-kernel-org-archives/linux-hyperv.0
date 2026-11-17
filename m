Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906925;
	b=B5gIhcmcnjdrQPo2jJZxO6+o0DsA8a73t0Ca/WLZRnZruGkJW396zQT+ewxe7Q2atFyc
	 WX2h94wuSCYo8PocFN/Os7Rt/x8ZnVfhCaEONknzLSRhRcpYe6tazi/ci397Lqks2UaFn
	 TLy/fpOkTHNg8oExeK5H997gYPO6SFN+7cBa1z7VjroOVjDHNww5XzpR4AButjnVqcaNX
	 h7tG2DHB/Q1iBXP+dA3wEfLf65bzNoL618d8AFU9eWvdkdSyc/RZPCcJxGiAcBW5S+3Gq
	 Uv5IGsrqltSgdTJm/zH1tHxsGjLN55Fcmbd6atHXFJfF3OE+L/VqLTzXr177/p6JQ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906925;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=qgmK7OzhFf6ZYYK1k43dELtxtJE2G6fOqCbfSKftF9A=;
	b=HmJf6q4e8AiBANW+Yaa5ulV7aG81IeGSRf+q0CwO3K2OOZskhJEx4FUmeRaRJanTxPYX
	 rBaaLiviRRmYmfNn8wI4eYbXzjYOvgC+MaFd0HTmL252GcSxxWum/t7LUEpsqktxnFSH4
	 8diz5y6hsFm1GgjeCIQH1FgYEGdycm4LIyV8e6g0LWLOOlQ0BWBHTkE3zI8xCc3cF9iR3
	 FBf/FJEbm9idMofZQkh82j9cyus2o1G4wRGedaNgy3FKYzGu+GkxnOjOFS25wkHU3wp6s
	 Gb7LR3FXlOcc328xUPDPBFWtC5TlJtDudcTgZdmV+zgXBO0X6N3xsHiw8I/xV+Rkc9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SDN2kFC6;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E6606A329;
	Tue, 17 Nov 2026 09:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 458E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SDN2kFC6
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33FEC20B716A;
	Tue, 17 Nov 2026 01:15:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33FEC20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906923;
	bh=qgmK7OzhFf6ZYYK1k43dELtxtJE2G6fOqCbfSKftF9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDN2kFC6F10uwCX3SzkBPIV9xwvkfo700Ouee6mideok8RuF18zkHL8kDH2ahz2l3
	 PcMvmgg+yJTWlQfqxTQwWbBgGAKOT2HJUZ01zLwxO0rkqVe10QbY+Pc8LqjLFHn+v0
	 L3LxooNI8W3vHnSF369fHLoK10GYEQNW9BT9VUtg=
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
Subject: [PATCH v2 1/5] x86/hyperv: Reject unrepresentable TLB flush VP sets
Date: Tue, 17 Nov 2026 09:15:03 +0000
Message-ID: <20261117091507.2088642-2-namjain@linux.microsoft.com>
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

The VP-set conversion helper returns zero when it cannot represent the
maximum VP index. Treat zero as an error, just like negative results,
rather than issuing an extended flush with an empty target set.

This lets the caller fall back to native flushing, as the extended IPI
path already does. Filtering a mask that initially includes all present
CPUs can make it use this conversion instead of the all-processors
shortcut.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cfcb60468b01c..1ea57d642faa4 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -199,7 +199,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
 			info->freed_tables ? NULL : cpu_is_lazy);
-	if (nr_bank < 0)
+	if (nr_bank <= 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
 	/*
-- 
2.43.0

