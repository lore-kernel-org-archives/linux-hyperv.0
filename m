Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22533F8251;
	Fri, 11 Sep 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116163; cv=none; b=P36BqfyrmrV6pUwBtul9UUMPi6crQ7Ifr/4s0xWkVNqhRS6zr5GIJOWJNFUNGwCp9Rg4PK9MzBWlvm/dHgV/f4+Mipsy33LxK6tr5vMZhTtqYE8CeaUieoGQ+5GJqoWujJd69KsBrG6s9NSwnZMiy+Fo/gwu2JUptRzzoWJUsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116163; c=relaxed/simple;
	bh=iv6WXsuNLWOqYnR9+0U05E1cTju+vdVPl2MKcQ0AA2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B76QXJQV0TMLUnI3aHjBhSdbDda58ac4k01cPS7W4At8zrWPxLq03/MMZSFDbY8R7njQkmL1J1niJ6I8YvzAlCyhuw+TskpvAdzACs8ffXdk253yVKvPlwP92vUq0gQaFmmNIXrCGUYr7wwJFN4pt8TYtQ7VE07MbyENSNo9Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rdSjRkCz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KY/8X1Ez; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rdSjRkCz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KY/8X1Ez"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95C7421B8B;
	Fri, 11 Sep 2026 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9RPtXPkTH2l0Ce0h0ao/G3WKgQIi0rqtLxtBRCg9co=;
	b=rdSjRkCzOk4/4RzKflhPuzujpGtPl6d1z9BKM0n4C0aHaOt87Zlt0Ugdo34JCc16R1qzWK
	6amzm7zZPLsnQDCNJUW3hShbWLmOruSWh/JeOlNlBVz+n9Z8xgsJa6Ujc2DdAFOjrQsn6+
	sjq/iiMO24gqMmhUEzvMtfF4Ank529g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9RPtXPkTH2l0Ce0h0ao/G3WKgQIi0rqtLxtBRCg9co=;
	b=KY/8X1EzbOsW7wb7+YFo5Q0K65gPFDoNRB04IkuLEe190SKIzPrNbNIQ78T3CntjxOf1ml
	6V+BnJ5VLsCDVXgNDFEk2ExYUrsZd17BB9YZ4y3xbfbyDv+tN6QHZzbKXDB72ua7mHhNop
	QZPO2JRX3/uHmGE5ngZ7gbc18zGk/sw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9BF5132D3;
	Fri, 11 Sep 2026 08:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sSe+N/a+o2rmFAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 08:42:30 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v5 03/17] x86/msr: Minimize usage of native_*() msr access functions
Date: Fri, 11 Sep 2026 10:41:57 +0200
Message-ID: <20260911084211.3149957-4-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911084211.3149957-1-jgross@suse.com>
References: <20260911084211.3149957-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

In order to prepare for some MSR access function reorg work, switch
most users of native_{read|write}_msr[_safe]() to the more generic
rdmsr*()/wrmsr*() variants.

For now this will have some intermediate performance impact with
paravirtualization configured when running on bare metal, but this
is a prereq change for the planned direct inlining of the rdmsr/wrmsr
instructions with this configuration.

The main reason for this switch is the planned move of the MSR trace
function invocation from the native_*() functions to the generic
rdmsr*()/wrmsr*() variants. Without this switch the users of the
native_*() functions would lose the related tracing entries.

Note that the Xen related MSR access functions will not be switched,
as these will be handled after the move of the trace hooks.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/hyperv/ivm.c          |  2 +-
 arch/x86/kernel/cpu/mshyperv.c |  4 ++--
 arch/x86/kernel/kvmclock.c     |  2 +-
 arch/x86/kvm/svm/svm.c         | 16 ++++++++--------
 arch/x86/xen/pmu.c             |  4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..a74f121f2a02 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -328,7 +328,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	savesegment(ds, vmsa->ds.selector);
 	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
 
-	vmsa->efer = native_read_msr(MSR_EFER);
+	vmsa->efer = rdmsrq(MSR_EFER);
 
 	vmsa->cr4 = native_read_cr4();
 	vmsa->cr3 = __native_read_cr3();
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e1388ed27384..53ac4ef53929 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -114,7 +114,7 @@ u64 hv_para_get_synic_register(unsigned int reg)
 {
 	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
 		return ~0ULL;
-	return native_read_msr(reg);
+	return rdmsrq(reg);
 }
 
 /*
@@ -124,7 +124,7 @@ void hv_para_set_synic_register(unsigned int reg, u64 val)
 {
 	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
 		return;
-	native_write_msr(reg, val);
+	wrmsrq(reg, val);
 }
 
 u64 hv_get_msr(unsigned int reg)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index cb3d0ca1fa22..6ddef8b5426a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -219,7 +219,7 @@ static void kvm_setup_secondary_clock(void)
 void kvmclock_disable(void)
 {
 	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0);
+		wrmsrq(msr_kvm_system_time, 0);
 }
 
 static void __init kvmclock_init_mem(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91f5a5344529..5e5bbecb8020 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -412,12 +412,12 @@ static void svm_init_erratum_383(void)
 		return;
 
 	/* Use _safe variants to not break nested virtualization */
-	if (native_read_msr_safe(MSR_AMD64_DC_CFG, &val))
+	if (rdmsrq_safe(MSR_AMD64_DC_CFG, &val))
 		return;
 
 	val |= (1ULL << 47);
 
-	native_write_msr_safe(MSR_AMD64_DC_CFG, val);
+	wrmsrq_safe(MSR_AMD64_DC_CFG, val);
 
 	erratum_383_found = true;
 }
@@ -470,8 +470,8 @@ static void svm_init_os_visible_workarounds(void)
 		return;
 
 	if (!this_cpu_has(X86_FEATURE_OSVW) ||
-	    native_read_msr_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
-	    native_read_msr_safe(MSR_AMD64_OSVW_STATUS, &status))
+	    rdmsrq_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
+	    rdmsrq_safe(MSR_AMD64_OSVW_STATUS, &status))
 		len = status = 0;
 
 	if (status == READ_ONCE(osvw_status) && len >= READ_ONCE(osvw_len))
@@ -2112,7 +2112,7 @@ static bool is_erratum_383(void)
 	if (!erratum_383_found)
 		return false;
 
-	if (native_read_msr_safe(MSR_IA32_MC0_STATUS, &value))
+	if (rdmsrq_safe(MSR_IA32_MC0_STATUS, &value))
 		return false;
 
 	/* Bit 62 may or may not be set for this mce */
@@ -2123,11 +2123,11 @@ static bool is_erratum_383(void)
 
 	/* Clear MCi_STATUS registers */
 	for (i = 0; i < 6; ++i)
-		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0);
+		wrmsrq_safe(MSR_IA32_MCx_STATUS(i), 0);
 
-	if (!native_read_msr_safe(MSR_IA32_MCG_STATUS, &value)) {
+	if (!rdmsrq_safe(MSR_IA32_MCG_STATUS, &value)) {
 		value &= ~(1ULL << 2);
-		native_write_msr_safe(MSR_IA32_MCG_STATUS, value);
+		wrmsrq_safe(MSR_IA32_MCG_STATUS, value);
 	}
 
 	/* Flush tlb to evict multi-match entries */
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 5f50a3ee08f5..37512df8b8f2 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -324,7 +324,7 @@ static u64 xen_amd_read_pmc(int counter)
 		u64 val;
 
 		msr = amd_counters_base + (counter * amd_msr_step);
-		native_read_msr_safe(msr, &val);
+		rdmsrq_safe(msr, &val);
 		return val;
 	}
 
@@ -350,7 +350,7 @@ static u64 xen_intel_read_pmc(int counter)
 		else
 			msr = MSR_IA32_PERFCTR0 + counter;
 
-		native_read_msr_safe(msr, &val);
+		rdmsrq_safe(msr, &val);
 		return val;
 	}
 
-- 
2.55.0

