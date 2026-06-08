Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25113AFD0A
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907317; cv=none; b=e78c+NARVzKDvGg1v347+Pv+PrediDTZp6LEqdE90H0YaIrYV6iE0e4oqhR2Gomi7L37+4EUQQMA86b8475/kC1NGfBoRSgdekz8rco6Mng+hd1rBGkTnmVcngMLCDYmXU9etwuweECFIQQLlS6e4CRe1qloSVtbRaVX3GRsnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907317; c=relaxed/simple;
	bh=bF0CN4dvt4Sppb42MYhcdPxZ1fiT60JCiQNZ4zt/wbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdRGOS1K/7saICtHct0oVFiJXAUQZSzhm/kDwig5mp+W11gJZFMuVCbatYhTfz1Ltm21ZpFmYnlQBiUT5sesFvgJqGUv6ZOWQ1FqUeGQUHn7SpopmmIHl8/GYzRvwusiFX1zBt1LONHeaG7I4tqf9qwts177r+BnhHLfPCd+chY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dnVEbYS1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vv9QmD8t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dnVEbYS1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vv9QmD8t"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1867A7598F;
	Mon,  8 Jun 2026 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jePKORN7IjeteIZRE4yjl1edIOKQNskQBUw6TTuCsCU=;
	b=dnVEbYS1UDkYPsYGNY265WYQjgc3eonU5DDrgHxwCK+kOgET1PSXp8T7davywjT4x4jbyy
	bujpvcjtsuqHpfib6pjI2TIpjmaTe0ymt6S5q3tXjP2sfGVDc5fbQ9ovLQ3+WpVxnu1guC
	MZW0tX+5XeOD1o8uNys/TMRxfsTj2j4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jePKORN7IjeteIZRE4yjl1edIOKQNskQBUw6TTuCsCU=;
	b=Vv9QmD8tS8/iaAy+dU7vrQ+gTbbD/TJdczJsGLmIfExLMmCV0p2vKpwhQs3pnrvSabK9TF
	Vye4trZhEYVPlfth82iicWmyiNLmshccCMlA7dqKTk+ZI9PssHG50nh1soK8Jqs7704DhR
	dWDFgalMYNr8PrHES9FFcpc3stNPpN8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 445A7779A7;
	Mon,  8 Jun 2026 08:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 02CADy19JmpNSAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 08:28:29 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] x86/msr: Switch wrmsrl() users to wrmsrq()
Date: Mon,  8 Jun 2026 10:28:08 +0200
Message-ID: <20260608082809.3492719-4-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608082809.3492719-1-jgross@suse.com>
References: <20260608082809.3492719-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,infradead.org,redhat.com,kernel.org,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,amd.com,microsoft.com,gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -2.80

wrmsrl() is a deprecated synonym for wrmsrq(). Switch its users to
wrmsrq().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/amd/uncore.c          | 2 +-
 arch/x86/events/intel/core.c          | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 arch/x86/kernel/process_64.c          | 2 +-
 arch/x86/kvm/pmu.c                    | 6 +++---
 arch/x86/kvm/vmx/tdx.c                | 6 +++---
 drivers/hv/mshv_vtl_main.c            | 2 +-
 drivers/idle/intel_idle.c             | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 98ef4bf9911a..7dc6af4231cc 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -975,7 +975,7 @@ static void amd_uncore_umc_read(struct perf_event *event)
 	 * that the counter never gets a chance to saturate.
 	 */
 	if (new & BIT_ULL(63 - COUNTER_SHIFT)) {
-		wrmsrl(hwc->event_base, 0);
+		wrmsrq(hwc->event_base, 0);
 		local64_set(&hwc->prev_count, 0);
 	} else {
 		local64_set(&hwc->prev_count, new);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dd1e3aa75ee9..e9baa64dc962 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3166,12 +3166,12 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 	}
 
 	if (cpuc->acr_cfg_b[idx] != mask) {
-		wrmsrl(msr_b + msr_offset, mask);
+		wrmsrq(msr_b + msr_offset, mask);
 		cpuc->acr_cfg_b[idx] = mask;
 	}
 	/* Only need to update the reload value when there is a valid config value. */
 	if (mask && cpuc->acr_cfg_c[idx] != reload) {
-		wrmsrl(msr_c + msr_offset, reload);
+		wrmsrq(msr_c + msr_offset, reload);
 		cpuc->acr_cfg_c[idx] = reload;
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c5ed0bc1f831..e4918c32a822 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -532,7 +532,7 @@ static void resctrl_abmc_config_one_amd(void *info)
 {
 	union l3_qos_abmc_cfg *abmc_cfg = info;
 
-	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg->full);
+	wrmsrq(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg->full);
 }
 
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b85e715ebb30..d44afbe005bb 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -708,7 +708,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	/* Reset hw history on AMD CPUs */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
-		wrmsrl(MSR_AMD_WORKLOAD_HRST, 0x1);
+		wrmsrq(MSR_AMD_WORKLOAD_HRST, 0x1);
 
 	return prev_p;
 }
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e218352e3423..aee70e5dc15d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1313,14 +1313,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 		pmc = &pmu->gp_counters[i];
 
 		if (pmc->counter != rdpmc(i))
-			wrmsrl(gp_counter_msr(i), pmc->counter);
-		wrmsrl(gp_eventsel_msr(i), pmc->eventsel_hw);
+			wrmsrq(gp_counter_msr(i), pmc->counter);
+		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		pmc = &pmu->fixed_counters[i];
 
 		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
-			wrmsrl(fixed_counter_msr(i), pmc->counter);
+			wrmsrq(fixed_counter_msr(i), pmc->counter);
 	}
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..cb50e23c39ca 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -823,7 +823,7 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 		return;
 
 	++vcpu->stat.host_state_reload;
-	wrmsrl(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
+	wrmsrq(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
 
 	vt->guest_state_loaded = false;
 }
@@ -1048,10 +1048,10 @@ static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Likewise, even if a TDX hosts didn't support XSS both arms of
-	 * the comparison would be 0 and the wrmsrl would be skipped.
+	 * the comparison would be 0 and the wrmsrq would be skipped.
 	 */
 	if (kvm_host.xss != (kvm_tdx->xfam & kvm_caps.supported_xss))
-		wrmsrl(MSR_IA32_XSS, kvm_host.xss);
+		wrmsrq(MSR_IA32_XSS, kvm_host.xss);
 }
 
 #define TDX_DEBUGCTL_PRESERVED (DEBUGCTLMSR_BTF | \
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index f5d27f28d6ad..0d3d4161974f 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -596,7 +596,7 @@ static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
 		} else {
 			/* Handle MSRs */
 			if (set)
-				wrmsrl(reg_table[i].msr_addr, *reg64);
+				wrmsrq(reg_table[i].msr_addr, *reg64);
 			else
 				rdmsrq(reg_table[i].msr_addr, *reg64);
 		}
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 15c698291b32..67d5993c7387 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2379,7 +2379,7 @@ static void intel_c1_demotion_toggle(void *enable)
 		msr_val |= NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
 	else
 		msr_val &= ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE);
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	wrmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
 }
 
 static ssize_t intel_c1_demotion_store(struct device *dev,
-- 
2.54.0

