Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D9426D16;
	Tue,  4 Aug 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827779; cv=none; b=iHaPMvfkWSvDlR1G5CoSmaRAdRo7PK3mRao+pnd/nIZW4g3cHD93eyPJ2xEELFbh3mHEn78cAgVIlRUdmSOIXfZpXbILtjtP0wU+Z0Yb/ZtUxBGA9h8XzbMDlcSciXECDe+ee1Mb6b+c/zLqx7Fl7nr4jIJvwiA4Yf4c3NqfQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827779; c=relaxed/simple;
	bh=bfWfrFj1fW9kMK2LtEt9QZqHXwJoM32GS8ORP5hs3tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4kX6/QDUp3gNITVj2F4vSBR+G/chSUxm+JQwABVeR2JGxl+YbzXeLopH5APsyWAtWAQmb7Ek/tA5lmouC7QNTZUJPL38XfI8M6mRT2pj9YeEsqdAcL95/tH2yoWNlfrFwnw+xjaW8fodKzbojPLadVedjzSfEl3Bl4E8qO7HfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=pap3mJ3/; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="pap3mJ3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1785827770;
	bh=Bz2CpdeYvHJ4wdtpHF06PqmuJczwotX2rk+VZpOkhHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pap3mJ3/HxJEJFDk1E9V+MfQ4ojuK31y3RhNzciiECTAVYuygUg+AAUpw8Vg2iPD9
	 bo0bIm+yzmE6QIWLIch8VLiCc2NJUocvXXQ2cbg2o8M207KKA1P5DizNPLx/31xYgC
	 RZ1Z6my1XJzOWuENeYHFx8DmI08HwyPl+3SWt/mM=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 05AB4E16DC;
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
Subject: [PATCH 4/5] tracing/lock: Use TRACE_EVENT_FN() for contended_release
Date: Tue,  4 Aug 2026 07:15:44 +0000
Message-ID: <1c2fcccfb584c075c02890c484f22c76a1948bf1.1785778551.git.d@ilvokhin.com>
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

queued_spin_unlock() gates its contended_release trace call behind a
static branch, so a NOP sits on the unlock path even while the
tracepoint is disabled. Removing that requires replacing the unlock
implementation only while contended_release is enabled, which needs a
callback when the tracepoint is toggled.

Convert contended_release to TRACE_EVENT_FN() and add weak no-op
arch_contended_release_trace_reg()/arch_contended_release_trace_unreg()
hooks.

The default hooks are empty, so this is a no-op until an architecture
overrides them.

No functional change intended.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/trace/events/lock.h | 10 ++++++++--
 kernel/locking/mutex.c      |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 1ded869cd619..b1d5b18c4514 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -137,7 +137,11 @@ TRACE_EVENT(contention_end,
 	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
 );
 
-TRACE_EVENT(contended_release,
+/* kernel/locking/mutex.c */
+int arch_contended_release_trace_reg(void);
+void arch_contended_release_trace_unreg(void);
+
+TRACE_EVENT_FN(contended_release,
 
 	TP_PROTO(void *lock),
 
@@ -151,7 +155,9 @@ TRACE_EVENT(contended_release,
 		__entry->lock_addr = lock;
 	),
 
-	TP_printk("%p", __entry->lock_addr)
+	TP_printk("%p", __entry->lock_addr),
+
+	arch_contended_release_trace_reg, arch_contended_release_trace_unreg
 );
 
 #endif /* _TRACE_LOCK_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8a85912d7ee6..942a939cee95 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1272,6 +1272,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(contention_begin);
 EXPORT_TRACEPOINT_SYMBOL_GPL(contention_end);
 EXPORT_TRACEPOINT_SYMBOL_GPL(contended_release);
 
+__weak int arch_contended_release_trace_reg(void) { return 0; }
+
+__weak void arch_contended_release_trace_unreg(void) { }
+
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
  * @cnt: the atomic which we are to dec
-- 
2.53.0-Meta

