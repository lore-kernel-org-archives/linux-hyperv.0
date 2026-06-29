Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44A3955DC
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713324; cv=none; b=VSUI3RkQIi+bM88uV+NJjzWXSJwngjvA6Rrj5XVIS7k+E4AuSIO7U/n6Sr80fvk3Slm493zClo6mAvlVQzN/T35AJZ6fn4LQFg/NxGukdJHoqlneLW33t4DEwuk4AfuJObreIhdFSub3Onyz4YEgKPpq76m+rag1CB/aYMl4ETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713324; c=relaxed/simple;
	bh=rcS/gP8Yquldsg+MuaSvyzRnJ1D10b3djwHCa+6cTpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npcjmRUEgT+snic/1kQrQdoZMhPRXx3kpaR/eiIZkOmrMLnif0tMjplY3p0TM6DtGLRwlG8UNBZ4zLw1LHPrnJ57hdX6FGWEaLutEKk/fnyG/fSo+UNiyefiHeJbfszkZjmEErF/cgOp5N0sTj7ufa0Udcbs4YCt1zMqp6OIdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6516675A9A;
	Mon, 29 Jun 2026 06:08:36 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8BE779A8;
	Mon, 29 Jun 2026 06:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Zb6JOMLQmokFAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:08:35 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
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
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 32/32] x86/msr: Simplify some rdmsrq() use cases
Date: Mon, 29 Jun 2026 08:05:23 +0200
Message-ID: <20260629060526.3638272-33-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 6516675A9A
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

After the conversion of rdmsrq() to an inline function some use cases
can be simplified by dropping an intermediate variable.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/amd/core.c      |  6 +-----
 arch/x86/events/amd/lbr.c       | 12 ++----------
 arch/x86/events/intel/core.c    |  6 +-----
 arch/x86/events/intel/cstate.c  |  5 +----
 arch/x86/events/intel/knc.c     |  6 +-----
 arch/x86/events/intel/lbr.c     | 17 +++--------------
 arch/x86/events/intel/uncore.c  |  6 +-----
 arch/x86/events/rapl.c          |  4 +---
 arch/x86/events/zhaoxin/core.c  |  6 +-----
 arch/x86/hyperv/hv_apic.c       |  5 +----
 arch/x86/include/asm/apic.h     |  5 +----
 arch/x86/include/asm/debugreg.h |  6 +-----
 arch/x86/include/asm/kvm_host.h |  5 +----
 13 files changed, 16 insertions(+), 73 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ee08ed4f41ec..04f3c2e99c06 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -660,12 +660,8 @@ static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 
 static inline u64 amd_pmu_get_global_status(void)
 {
-	u64 status;
-
 	/* PerfCntrGlobalStatus is read-only */
-	status = rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS);
-
-	return status;
+	return rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS);
 }
 
 static inline void amd_pmu_ack_global_status(u64 status)
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 0b6aec1e5bf1..ada5278285cd 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -74,20 +74,12 @@ static __always_inline void amd_pmu_lbr_set_to(unsigned int idx, u64 val)
 
 static __always_inline u64 amd_pmu_lbr_get_from(unsigned int idx)
 {
-	u64 val;
-
-	val = rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2);
-
-	return val;
+	return rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2);
 }
 
 static __always_inline u64 amd_pmu_lbr_get_to(unsigned int idx)
 {
-	u64 val;
-
-	val = rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1);
-
-	return val;
+	return rdmsrq(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1);
 }
 
 static __always_inline u64 sign_ext_branch_ip(u64 ip)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c6fc2d9079d9..02cc471cb5bd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2963,11 +2963,7 @@ static void intel_tfa_pmu_enable_all(int added)
 
 static inline u64 intel_pmu_get_status(void)
 {
-	u64 status;
-
-	status = rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS);
-
-	return status;
+	return rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS);
 }
 
 static inline void intel_pmu_ack_status(u64 ack)
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 69eb6cf51d3b..c6d9146d8ec8 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -322,10 +322,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 
 static inline u64 cstate_pmu_read_counter(struct perf_event *event)
 {
-	u64 val;
-
-	val = rdmsrq(event->hw.event_base);
-	return val;
+	return rdmsrq(event->hw.event_base);
 }
 
 static void cstate_pmu_event_update(struct perf_event *event)
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index c4f81215f758..a74caa8280be 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -199,11 +199,7 @@ static void knc_pmu_enable_event(struct perf_event *event)
 
 static inline u64 knc_pmu_get_status(void)
 {
-	u64 status;
-
-	status = rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_STATUS);
-
-	return status;
+	return rdmsrq(MSR_KNC_IA32_PERF_GLOBAL_STATUS);
 }
 
 static inline void knc_pmu_ack_status(u64 ack)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e65a4ed121d7..0364655a8771 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -209,10 +209,7 @@ void intel_pmu_lbr_reset(void)
  */
 static inline u64 intel_pmu_lbr_tos(void)
 {
-	u64 tos;
-
-	tos = rdmsrq(x86_pmu.lbr_tos);
-	return tos;
+	return rdmsrq(x86_pmu.lbr_tos);
 }
 
 enum {
@@ -311,26 +308,18 @@ static __always_inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
 
 static __always_inline u64 rdlbr_to(unsigned int idx, struct lbr_entry *lbr)
 {
-	u64 val;
-
 	if (lbr)
 		return lbr->to;
 
-	val = rdmsrq(x86_pmu.lbr_to + idx);
-
-	return val;
+	return rdmsrq(x86_pmu.lbr_to + idx);
 }
 
 static __always_inline u64 rdlbr_info(unsigned int idx, struct lbr_entry *lbr)
 {
-	u64 val;
-
 	if (lbr)
 		return lbr->info;
 
-	val = rdmsrq(x86_pmu.lbr_info + idx);
-
-	return val;
+	return rdmsrq(x86_pmu.lbr_info + idx);
 }
 
 static inline void
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 0067bd35aa7f..7240849a6633 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -169,11 +169,7 @@ struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu
 
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event)
 {
-	u64 count;
-
-	count = rdmsrq(event->hw.event_base);
-
-	return count;
+	return rdmsrq(event->hw.event_base);
 }
 
 void uncore_mmio_exit_box(struct intel_uncore_box *box)
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 180cc18282ca..2d2376c59816 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -192,9 +192,7 @@ static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
-	u64 raw;
-	raw = rdmsrq(event->hw.event_base);
-	return raw;
+	return rdmsrq(event->hw.event_base);
 }
 
 static inline u64 rapl_scale(u64 v, struct perf_event *event)
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 1980e5995e27..9203321c18b4 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -266,11 +266,7 @@ static void zhaoxin_pmu_enable_all(int added)
 
 static inline u64 zhaoxin_pmu_get_status(void)
 {
-	u64 status;
-
-	status = rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS);
-
-	return status;
+	return rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS);
 }
 
 static inline void zhaoxin_pmu_ack_status(u64 ack)
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 4e30f9a11bc4..52ee8c237c2c 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -36,10 +36,7 @@ static struct apic orig_apic;
 
 static u64 hv_apic_icr_read(void)
 {
-	u64 reg_val;
-
-	reg_val = rdmsrq(HV_X64_MSR_ICR);
-	return reg_val;
+	return rdmsrq(HV_X64_MSR_ICR);
 }
 
 static void hv_apic_icr_write(u32 low, u32 id)
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e028140fac49..993b52b52625 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -231,10 +231,7 @@ static inline void native_x2apic_icr_write(u32 low, u32 id)
 
 static inline u64 native_x2apic_icr_read(void)
 {
-	unsigned long val;
-
-	val = rdmsrq(APIC_BASE_MSR + (APIC_ICR >> 4));
-	return val;
+	return rdmsrq(APIC_BASE_MSR + (APIC_ICR >> 4));
 }
 
 extern int x2apic_mode;
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 426d48beef81..0b2f42c7f8eb 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -174,15 +174,11 @@ static inline unsigned long amd_get_dr_addr_mask(unsigned int dr)
 
 static inline unsigned long get_debugctlmsr(void)
 {
-	unsigned long debugctlmsr = 0;
-
 #ifndef CONFIG_X86_DEBUGCTLMSR
 	if (boot_cpu_data.x86 < 6)
 		return 0;
 #endif
-	debugctlmsr = rdmsrq(MSR_IA32_DEBUGCTLMSR);
-
-	return debugctlmsr;
+	return rdmsrq(MSR_IA32_DEBUGCTLMSR);
 }
 
 static inline void update_debugctlmsr(unsigned long debugctlmsr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e9b4ad535643..c87545070347 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2415,10 +2415,7 @@ static inline void kvm_load_ldt(u16 sel)
 #ifdef CONFIG_X86_64
 static inline unsigned long read_msr(unsigned long msr)
 {
-	u64 value;
-
-	value = rdmsrq(msr);
-	return value;
+	return rdmsrq(msr);
 }
 #endif
 
-- 
2.54.0

