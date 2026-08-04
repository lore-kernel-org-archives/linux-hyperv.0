Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21657421254;
	Tue,  4 Aug 2026 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827779; cv=none; b=IYHmIs8IiJs8Jt6E62w0kS1l6ScQAJL3GEt8crDQn1Pyql6lG38Mo5I8lcFI1FUTAD1r8+bAfXS0O3WndnR2yP0GXBeAoEmY4RmJeNR815eYnO4UjOICaMllYLvbFhu3Dai6rp4t0PeJ0PVIHGbzRcE7wqRh4nae8nT04vG7ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827779; c=relaxed/simple;
	bh=JLH7QpKgZ10gQbmXPhOq6m2povwsMw0BnTXBtwhbETo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q71Ljcc6cFVTIMmxh6zsc/4IouW6HXvMv9TdLfCJjtNKkMePu0+vBqOjILl0hK3i7PvFpToU8glNB6XKXTXHMJSFG+WNSEK5el3FottzDQEVAoj5cxPB6+hIzx85icu3AlQ8GlA9FXNmYzBllhjVGt6bfqiTR9swwYbHJgepg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=FVNDO3r4; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="FVNDO3r4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1785827769;
	bh=Hgqlc//hwpz+K1crcBkrYPgGS5kJOu9yEyqJUnHTuno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVNDO3r4J4MOXT5qmRaXYUu2pNzl9ZurajzLzmFoGAVSzfbChQnc8xUZc5dM6cHjl
	 dl4A/X2nBgfn5GZv2d97IF3LH92AggOHh7cpwlOahEJLSUKNdgOV9q4kQ+BBqIcgV2
	 hjQ84vsVQbCOHXjwIMxPrXZCCUeUGcpJzNJ/G9uA=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id AF538E16D0;
	Tue, 04 Aug 2026 07:16:08 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 1/5] x86/paravirt: Use static_call() for the paravirt spinlock ops
Date: Tue,  4 Aug 2026 07:15:41 +0000
Message-ID: <9a32ae399eb804a02a31af04dcabe7e7ee4f3fdf.1785778551.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785778551.git.d@ilvokhin.com>
References: <cover.1785778551.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

queued_spin_lock_slowpath() and queued_spin_unlock() are dispatched
through pv_ops_lock via the paravirt-ops ALTERNATIVE machinery, which
picks the target (native inline store / hypervisor call) once at boot
and cannot change at runtime.

Convert both to static_call(). The site becomes a direct call patched in
place (one byte smaller), and on native the unlock still collapses to
the inline "movb $0, (%rdi)" store, so the fast path is unchanged.

Unlike the ALTERNATIVE mechanism, a static_call() target can also be
updated at runtime via static_call_update(). This is a prerequisite for
the contended_release tracepoint, which has to swap in a traced unlock
while the system is running.

[ ilvokhin: commit message; fix PARAVIRT_SPINLOCKS=n build; teach
  __static_call_validate() about the inline unlock insn; make the
  slowpath site module-safe: static_call_mod() +
  EXPORT_STATIC_CALL_TRAMP(); pass @lock to the callee-save unlock,
  fixing a boot hang under CALL_DEPTH_TRACKING. Boot tested native + KVM
  PV guest. ]

Link: https://lore.kernel.org/all/20260603120811.GW3493090@noisy.programming.kicks-ass.net/
Co-developed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 arch/x86/hyperv/hv_spinlock.c            |  4 ++--
 arch/x86/include/asm/cpufeatures.h       |  1 -
 arch/x86/include/asm/paravirt-spinlock.h | 19 +++++++++++------
 arch/x86/kernel/kvm.c                    |  5 ++---
 arch/x86/kernel/paravirt-spinlocks.c     | 12 +++++------
 arch/x86/kernel/static_call.c            | 27 ++++++++++++++++++++++++
 arch/x86/xen/spinlock.c                  |  5 ++---
 tools/arch/x86/include/asm/cpufeatures.h |  1 -
 8 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 210b494e4de0..6b4bdea18218 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -78,8 +78,8 @@ void __init hv_init_spinlocks(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = hv_qlock_wait;
 	pv_ops_lock.kick = hv_qlock_kick;
 	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1b4a48bff18f..e41fe5c24841 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -225,7 +225,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
 
diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index 7beffcb08ed6..ff735830de4a 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_PARAVIRT_SPINLOCK_H
 
 #include <asm/paravirt_types.h>
+#include <linux/static_call_types.h>
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock_types.h>
@@ -11,9 +12,6 @@
 struct qspinlock;
 
 struct pv_lock_ops {
-	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
-	struct paravirt_callee_save queued_spin_unlock;
-
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
 
@@ -26,20 +24,27 @@ extern struct pv_lock_ops pv_ops_lock;
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
 extern bool nopvspin;
 
+DECLARE_STATIC_CALL(queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
+DECLARE_STATIC_CALL(queued_spin_unlock, __raw_callee_save___native_queued_spin_unlock);
+
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 							 u32 val)
 {
-	PVOP_VCALL2(pv_ops_lock, queued_spin_lock_slowpath, lock, val);
+	static_call_mod(queued_spin_lock_slowpath)(lock, val);
 }
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ")",
-			  ALT_NOT(X86_FEATURE_PVUNLOCK));
+	PVOP_CALL_ARGS;
+	__STATIC_CALL_MOD_ADDRESSABLE(queued_spin_unlock);
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(queued_spin_unlock)
+		      : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+		      : PVOP_CALL_ARG1(lock)
+		      : "memory", "cc");
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dcef84da304b..253c159c4abe 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1136,9 +1136,8 @@ void __init kvm_spinlock_init(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock =
-		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = kvm_wait;
 	pv_ops_lock.kick = kvm_kick_cpu;
 
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 95452444868f..ddc19dc28ba1 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -25,9 +25,14 @@ __visible void __native_queued_spin_unlock(struct qspinlock *lock)
 }
 PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
+DEFINE_STATIC_CALL(queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
+EXPORT_STATIC_CALL_TRAMP(queued_spin_lock_slowpath);
+DEFINE_STATIC_CALL(queued_spin_unlock, __raw_callee_save___native_queued_spin_unlock);
+EXPORT_STATIC_CALL_TRAMP(queued_spin_unlock);
+
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_ops_lock.queued_spin_unlock.func ==
+	return static_call_query(queued_spin_unlock) ==
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
@@ -45,16 +50,11 @@ bool pv_is_native_vcpu_is_preempted(void)
 
 void __init paravirt_set_cap(void)
 {
-	if (!pv_is_native_spin_unlock())
-		setup_force_cpu_cap(X86_FEATURE_PVUNLOCK);
-
 	if (!pv_is_native_vcpu_is_preempted())
 		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
 }
 
 struct pv_lock_ops pv_ops_lock = {
-	.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
-	.queued_spin_unlock		= PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait				= paravirt_nop,
 	.kick				= paravirt_nop,
 	.vcpu_is_preempted		= PV_CALLEE_SAVE(__native_vcpu_is_preempted),
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 61592e41a6b1..bab9406e6d6a 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,6 +4,12 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
+/* Declared locally to avoid pulling asm/paravirt-spinlock.h header. */
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+struct qspinlock;
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+#endif
+
 enum insn_type {
 	CALL = 0, /* site call */
 	NOP = 1,  /* site cond-call */
@@ -31,6 +37,17 @@ static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
  */
 static const u8 warninsn[] = { 0x67, 0x48, 0x0f, 0xb9, 0x3a };
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * ds ds movb $0, (_ASM_ARG1)
+ */
+#ifdef CONFIG_64BIT
+static const u8 unlockinsn[] = { 0x3e, 0x3e, 0xc6, 0x07, 0x00 };
+#else
+static const u8 unlockinsn[] = { 0x3e, 0x3e, 0xc6, 0x00, 0x00 };
+#endif
+#endif
+
 static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 {
 	u8 ret = 0;
@@ -78,6 +95,12 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 			emulate = code;
 			code = &warninsn;
 		}
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		if (func == &__raw_callee_save___native_queued_spin_unlock) {
+			emulate = code;
+			code = &unlockinsn;
+		}
+#endif
 		break;
 
 	case NOP:
@@ -139,6 +162,10 @@ static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 		    !memcmp(insn, xor5rax, 5) ||
 		    !memcmp(insn, warninsn, 5))
 			return;
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		if (!memcmp(insn, unlockinsn, 5))
+			return;
+#endif
 	}
 
 	/*
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 83ac24ead289..f718e535ea7c 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -134,9 +134,8 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock =
-		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = xen_qlock_wait;
 	pv_ops_lock.kick = xen_qlock_kick;
 	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 86d17b195e79..61541f042f74 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -225,7 +225,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
 
-- 
2.53.0-Meta

