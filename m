Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1E42AFB6;
	Tue,  4 Aug 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827781; cv=none; b=pHic0dWImEerwFFImvggAIFH/NfDvvW6fUwT9hNQ6nZ5ZiH4Kq6cIMf1NdBYRk5tVOd/7esuD1Q6ut392e1GKYSZn1mB6VzUdDOxNdBy1wlB7FOr/yWuc2C8CmJDMy/paSj7dfI0opTZcHIvn44VB5iNBN7NrPC8VGAqwjTqH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827781; c=relaxed/simple;
	bh=JESu/AclIL3+BmuW3VoymqC5DgpEXPwYsbzIHy7VIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1Z0xmP17e4oShp+UkHpthf6QeTrRgbwe4rY5Om2hOZpSVDiGX/nmF7CcSmGeNLI9rZ/g/Z6t1KEdK9igmTJFS/W4N0dgGRV4+f6uYdLRJjMY8CiMBYq+2IczIDcQkpCx6VBj3rrL980QzddPA2VxDPe6+1aVJ5Kivbzt42NFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=YCa2mhDC; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="YCa2mhDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1785827770;
	bh=MJXFdixHataYYt87xEtn0QdfMJOi3nH/EXHHrFBbQBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YCa2mhDCHjFFX0O6d3S1tYEYBR/Jb4ai4lQlH0qCvYfntcHb1/+MEaIyrBX3QT0u1
	 jViT9cjtE41ag6sP28YwsfmBHSjMYS3PwUlLcqd8dqfNVR1ReEl98E/Q9nIoYF3BTz
	 G+fzkT2LOVauhNUbkR9kOT4y87KoehBEuITFVAbI=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 77194E16E0;
	Tue, 04 Aug 2026 07:16:10 +0000 (UTC)
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
Subject: [PATCH 5/5] x86/paravirt: Trace contended_release on unlock
Date: Tue,  4 Aug 2026 07:15:45 +0000
Message-ID: <17fa67f9fa4cf93f1150725e89f5f916e41a9b6f.1785778551.git.d@ilvokhin.com>
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

On PARAVIRT_SPINLOCKS=y kernels queued_spin_unlock() is dispatched
through a static_call(). Those PARAVIRT_SPINLOCKS=y kernels are quite
popular. Gating contended_release behind a static branch would leave a
NOP on the unlock hot path even, when the tracepoint is disabled.

Since the static_call() is already present, swap its target to a traced
unlock, when the tracepoint is enabled instead. When contended_release
tracepoint is disabled the target is the plain unlock (an inline store
on native x86_64), so the unlock path is unchanged and the tracepoint is
truly zero-cost.

Provide two traced variants, native_queued_spin_unlock_traced() and
pv_queued_spin_unlock_traced(), so each tail-calls its own base unlock
directly rather than recursing through the now-traced static_call().

Teach pv_is_native_spin_unlock() that the traced native variant still
counts as native.

Only PARAVIRT_SPINLOCKS=y is affected. PARAVIRT_SPINLOCKS=n keeps the
generic static-branch path.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 arch/x86/include/asm/paravirt-spinlock.h |  2 +
 arch/x86/kernel/paravirt-spinlocks.c     | 53 +++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index ff735830de4a..302bc2ba3a75 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -99,6 +99,8 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 
 void __init native_pv_lock_init(void);
 __visible void __native_queued_spin_unlock(struct qspinlock *lock);
+__visible void native_queued_spin_unlock_traced(struct qspinlock *lock);
+__visible void pv_queued_spin_unlock_traced(struct qspinlock *lock);
 bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
 bool pv_is_native_vcpu_is_preempted(void);
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index ddc19dc28ba1..ca12b3655307 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -7,6 +7,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
+#include <trace/events/lock.h>
 
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
@@ -30,10 +31,58 @@ EXPORT_STATIC_CALL_TRAMP(queued_spin_lock_slowpath);
 DEFINE_STATIC_CALL(queued_spin_unlock, __raw_callee_save___native_queued_spin_unlock);
 EXPORT_STATIC_CALL_TRAMP(queued_spin_unlock);
 
+/*
+ * Traced unlock variants, swapped in via static_call while the
+ * contended_release tracepoint is enabled. Two of them, so each tail calls its
+ * own base directly.
+ */
+__visible void native_queued_spin_unlock_traced(struct qspinlock *lock)
+{
+	if (queued_spin_is_contended(lock))
+		trace_call__contended_release(lock);
+	native_queued_spin_unlock(lock);
+}
+PV_CALLEE_SAVE_REGS_THUNK(native_queued_spin_unlock_traced);
+
+__visible void pv_queued_spin_unlock_traced(struct qspinlock *lock)
+{
+	if (queued_spin_is_contended(lock))
+		trace_call__contended_release(lock);
+	__raw_callee_save___pv_queued_spin_unlock(lock);
+}
+PV_CALLEE_SAVE_REGS_THUNK(pv_queued_spin_unlock_traced);
+
 bool pv_is_native_spin_unlock(void)
 {
-	return static_call_query(queued_spin_unlock) ==
-		__raw_callee_save___native_queued_spin_unlock;
+	void *unlock = static_call_query(queued_spin_unlock);
+
+	return unlock == __raw_callee_save___native_queued_spin_unlock ||
+	       unlock == __raw_callee_save_native_queued_spin_unlock_traced;
+}
+
+int arch_contended_release_trace_reg(void)
+{
+	void *cur = static_call_query(queued_spin_unlock);
+
+	if (cur == __raw_callee_save___native_queued_spin_unlock)
+		static_call_update(queued_spin_unlock,
+				   __raw_callee_save_native_queued_spin_unlock_traced);
+	else if (cur == __raw_callee_save___pv_queued_spin_unlock)
+		static_call_update(queued_spin_unlock,
+				   __raw_callee_save_pv_queued_spin_unlock_traced);
+	return 0;
+}
+
+void arch_contended_release_trace_unreg(void)
+{
+	void *cur = static_call_query(queued_spin_unlock);
+
+	if (cur == __raw_callee_save_native_queued_spin_unlock_traced)
+		static_call_update(queued_spin_unlock,
+				   __raw_callee_save___native_queued_spin_unlock);
+	else if (cur == __raw_callee_save_pv_queued_spin_unlock_traced)
+		static_call_update(queued_spin_unlock,
+				   __raw_callee_save___pv_queued_spin_unlock);
 }
 
 __visible bool __native_vcpu_is_preempted(long cpu)
-- 
2.53.0-Meta

