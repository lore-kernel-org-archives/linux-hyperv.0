Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019821;
	b=NCgfj2EGsHlkLhfabgACYYfI9IWMHT6IIl0H0atGAOKVubCmfmCAWRbQD3n/Z+nFrkFq
	 qa6C9RFoAzCI7sDC64EzO96czZm4B9i6ZfwlxIcDVYmTdUqR5jzcAzCJNiV8V1goMlZgB
	 IJG4b/O+aqkjBeYm+VaTHTG8/kj0aR+phHow7xULFsaaELTWIvcw4y+wppTNsrTFZvngl
	 CwBlzj6NOfiPKgTHIfSOS87IvhHvs25svR8wvcpRYFu28gGkKXfO1oUAi+9aBJWxj1++p
	 B1e+ZjQdLEdn1zdaU3pcfFiSokANS84uP6N3cdasV6tiGhsw/VT6INMCv7SFwUIpHLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019821;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=3BLIuDEhsTthzC16kupGp2wOIgagbUkGHrl+XCDNR18=;
	b=sSQ6IsFLJxjQj/nYMhFPmb7W+V+M12c+cAj9R2J5iCQ/KqXfYSbYaLk7TLgH0GsL8KE0
	 vftEbX//hPlWXm4NWiJBkxgqQjzGvRD6TrDwv8ixV7OJLsnOalHRwhlz+QnXCU9zWV64K
	 1sRk/TBbO08jSlRbuSl95FNmgmEm8IsHUTTYZP6ZyevW33RVC99lwfEFUQ114vKG3zNkQ
	 p3Ua4r9suHFxuDPMrMI8FxavIx+O/rW9L5mARxqo2m2YMKX7YiIGyErMNb+MVQGiwbvVC
	 qIs+DnvZONuXOSwyAC+8GlUV8JfqCzTJT/Vqu/zDgilGAFFOsuCeuKWJrgpHdJNf3Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bSj2J5fY;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bSj2J5fY;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C11606A327;
	Mon, 26 Oct 2026 13:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C11606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bSj2J5fY;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bSj2J5fY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FABB1F7C8;
	Mon, 26 Oct 2026 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1793019819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BLIuDEhsTthzC16kupGp2wOIgagbUkGHrl+XCDNR18=;
	b=bSj2J5fYNQd9A157z3In6GKUk+AOWsyNTlr3WBkL9j/yGxMea62EAbcJvEvgcC2iNYoSpX
	XkD1S18U9aCKxmA0X1zFsQ3b7EGyZKHG7PvNYvxhoZ1RcHL+bmWbUZ65zYHgaMrD+B1A0/
	yzmRpGHrun6A+ihXpCV8UNL0uhz37AA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1793019819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BLIuDEhsTthzC16kupGp2wOIgagbUkGHrl+XCDNR18=;
	b=bSj2J5fYNQd9A157z3In6GKUk+AOWsyNTlr3WBkL9j/yGxMea62EAbcJvEvgcC2iNYoSpX
	XkD1S18U9aCKxmA0X1zFsQ3b7EGyZKHG7PvNYvxhoZ1RcHL+bmWbUZ65zYHgaMrD+B1A0/
	yzmRpGHrun6A+ihXpCV8UNL0uhz37AA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6339513408;
	Mon, 26 Oct 2026 13:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ws83DqpP32rVWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 26 Oct 2026 13:03:38 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
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
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v5 12/12] x86/msr: Simplify some rdmsrq() use cases
Date: Mon, 26 Oct 2026 14:02:23 +0100
Message-ID: <20261026130223.773129-13-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026130223.773129-1-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
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
X-Spamd-Result: default: False [-15.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,outlook.com:email];
	FREEMAIL_CC(0.00)[suse.com,infradead.org,redhat.com,kernel.org,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,microsoft.com,outlook.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[outlook.com]
X-Spam-Score: -15.80
X-Spam-Level: 
X-Spam-Flag: NO

After the conversion of rdmsrq() to an inline function some use cases
can be simplified by dropping an intermediate variable or by
eliminating the inline function completely.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com> # Hyper-V
Acked-by: Sean Christopherson <seanjc@google.com>
---
V3:
- eliminate KVM's read_msr() (Sean Christopherson)
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
 arch/x86/include/asm/kvm_host.h | 10 ----------
 arch/x86/kvm/vmx/tdx.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  6 +++---
 15 files changed, 19 insertions(+), 83 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 80ed49dba255..3d0e076c1636 100644
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
index 0972690c7d45..5e219a94f28c 100644
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
index 20e96e6c649c..96bcbf823aec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2972,11 +2972,7 @@ static void intel_tfa_pmu_enable_all(int added)
 
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
index 68d184ea5bcf..beac04502b73 100644
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
index ab2c5a962b31..cffbd780a435 100644
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
index 60a3df32a4d3..e00251c7eb12 100644
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
index e1e5d32c6286..183f252a6815 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1875,16 +1875,6 @@ enum kvm_intr_type {
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
-#ifdef CONFIG_X86_64
-static inline unsigned long read_msr(unsigned long msr)
-{
-	u64 value;
-
-	value = rdmsrq(msr);
-	return value;
-}
-#endif
-
 #define HF_GUEST_MASK		(1 << 0) /* VCPU is in guest-mode */
 
 #ifdef CONFIG_KVM_SMM
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 8a593159c9b7..926bbf88b20a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -793,7 +793,7 @@ void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	if (likely(is_64bit_mm(current->mm)))
 		vt->msr_host_kernel_gs_base = current->thread.gsbase;
 	else
-		vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
+		vt->msr_host_kernel_gs_base = rdmsrq(MSR_KERNEL_GS_BASE);
 
 	vt->guest_state_loaded = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa8d23ba1204..7cd64feefc67 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1390,8 +1390,8 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	} else {
 		savesegment(fs, fs_sel);
 		savesegment(gs, gs_sel);
-		fs_base = read_msr(MSR_FS_BASE);
-		vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
+		fs_base = rdmsrq(MSR_FS_BASE);
+		vt->msr_host_kernel_gs_base = rdmsrq(MSR_KERNEL_GS_BASE);
 	}
 
 	wrmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
@@ -1450,7 +1450,7 @@ static u64 vmx_read_guest_host_msr(struct vcpu_vmx *vmx, u32 msr, u64 *cache)
 {
 	preempt_disable();
 	if (vmx->vt.guest_state_loaded)
-		*cache = read_msr(msr);
+		*cache = rdmsrq(msr);
 	preempt_enable();
 	return *cache;
 }
-- 
2.56.0

