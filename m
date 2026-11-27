Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=F2t77pBGIvTWppgWnjeDLHxGOEj7FDDG8frB8NYEqT7cW9QkS+mBYZMyvD7Qn2BEfGQw
	 GjfWJ54nawhFYL40NSvPOkoiuDTTHBrFaBot5aAhVAFhrYVwbmaSIzFEgxVQz75BQcP5H
	 NTE7SgJnS7ElvvW2+cSAGwUy34Ggax1egh4UGU/dBJ/l3WEwmoCzmlvalp+oUt9MgieEe
	 bQ5ycmd6lHueXPVis2g9X5ZY0p5DS+Sv6G2G4iwRMao45rPuD8/nZ2Z11Ts80ylVSqFdA
	 6CRcyO8fTNTT4n6w0qkZ0btJ2swB1ZjdbQOqcstocvjv7TN7Z3z0y1M9HJkCO/KNHPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=HRdPsM8k7LxHkJKc9/GKJtL7QWO/APvPQxk6NOXwn1I=;
	b=GWQBCMF6tmgG2sjMYlIJ9uByTmIOCGNzRfSRoJ+dt80fANoVpIwXjUV7NXfL9pe7tJVb
	 GeOavTrs9D+KijNlnw58/zjjje3oTZ9H2v9M1CFZN6+YqHF/iX8Y4am1M4qhuN9qjgKID
	 zIgLyDso1I5yqBgcC2qA7V9zGLkowOrrfiyWpxFSYs2VVsygrriLuLLSe8mXgrPnSMh7q
	 +FQVEQlmDBwM8Sn3F+SNC0TLQc7jTlqHShocArcXSM0nmzJO2tejzVoBivdyRJWLifbcP
	 EGI0KYd9KW7Zt0c/kqA2MjmmkfCihMwnwXFr+rHorQUaTeX23ioeLeEsAKSY2/twVQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bN51kz8A;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5D606A31E;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bN51kz8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HRdPsM8k7LxHkJKc9/GKJtL7QWO/APvPQxk6NOXwn1I=; b=bN51kz8AqdcMI7Ca2+YkK0QH6y
	qMq5tVCh++osclO5Qk4B6nUiVdaT/rdxlV3K4kQR65Fcfcfr/d2ITmIiP2+kmZMjQ+fONgRI8kuuk
	Gic4OR68mqen0VPo0Gn8+AlXROKWVxUnh9Zvb2kHsZFOsAVXiwbGiYF8WvNzMoV4DicXEhnubu1NN
	eyTTUMhKbcIGNkH3opTl6QLzhGfuGHe+hQQKr6zX443jX14k4BkhMyaI5gSZEvTMj98YUGu0NwQie
	Tg34NGLdy/lKRIQXj9WEIJsKXx4f1AiFOG6vh+exIbMJV3L/cEvJHyo3EEoqoWUgBNAMjAJFVEJ7b
	hpuOxrpg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy3X-46gt;
	Fri, 27 Nov 2026 15:27:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqm-3Fgj;
	Fri, 27 Nov 2026 15:27:30 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Jim Mattson <jmattson@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 12/15] KVM: SVM: Support CR0 and CR4 write filters
Date: Fri, 27 Nov 2026 15:27:27 +0000
Message-ID: <20261127152730.99319-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127152730.99319-1-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Keep INTERCEPT_CR0_WRITE set in vmcb01 while a CR0 filter is armed,
and check the filter in cr_interception().  Without NextRIP the write
goes to the emulator, which knows the instruction length.  L2 is not
filtered.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/svm.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4ffb41234dc2..c91467a59e20 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1135,6 +1135,22 @@ static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
 	svm_recalc_msr_intercepts(vcpu);
 }
 
+static void svm_update_reg_write_filter(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * CR4 writes are always intercepted.  CR0 writes are not when the
+	 * guest and host views agree (hcr0 == cr0): force the intercept in
+	 * vmcb01 while a CR0 filter is armed.  Disarming leaves the
+	 * intercept in place - a forced intercept only costs exits, which
+	 * cr_interception() handles as usual - and the next svm_set_cr0(),
+	 * which respects the filter, restores its own state.
+	 */
+	if (vcpu->arch.reg_write_filter_armed & BIT(KVM_X86_REG_FILTER_CR0))
+		svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
+}
+
 static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1867,7 +1883,13 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	if (hcr0 == cr0) {
 		/* Selective CR0 write remains on.  */
 		svm_clr_intercept(svm, INTERCEPT_CR0_READ);
-		svm_clr_intercept(svm, INTERCEPT_CR0_WRITE);
+		/*
+		 * The selective intercept misses writes that change only
+		 * TS or MP, and CLTS: a CR0 write filter needs them all.
+		 */
+		if (!(vcpu->arch.reg_write_filter_armed &
+		      BIT(KVM_X86_REG_FILTER_CR0)))
+			svm_clr_intercept(svm, INTERCEPT_CR0_WRITE);
 	} else {
 		svm_set_intercept(svm, INTERCEPT_CR0_READ);
 		svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
@@ -2647,6 +2669,21 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 
 #define CR_VALID (1ULL << 63)
 
+/*
+ * Send an intercepted write which a register write filter catches to
+ * userspace instead of performing it.  The caller has checked that the
+ * length of the instruction is known.
+ */
+static bool svm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg,
+				   unsigned long old, unsigned long val)
+{
+	if (!kvm_reg_write_filtered(vcpu, reg, old, val))
+		return false;
+
+	kvm_reg_write_user_space(vcpu, reg, old, val, svm_exit_insn_len(vcpu));
+	return true;
+}
+
 static int cr_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -2660,6 +2697,16 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 	if (unlikely((svm->vmcb->control.exit_info_1 & CR_VALID) == 0))
 		return emulate_on_interception(vcpu);
 
+	/*
+	 * A filtered write reports the length of its instruction, which only
+	 * NextRIP provides here.  Without it, let the emulator raise the exit,
+	 * as it does without Decode Assists.
+	 */
+	if ((vcpu->arch.reg_write_filter_armed &
+	     (BIT(KVM_X86_REG_FILTER_CR0) | BIT(KVM_X86_REG_FILTER_CR4))) &&
+	    !svm_exit_insn_len(vcpu))
+		return emulate_on_interception(vcpu);
+
 	reg = svm->vmcb->control.exit_info_1 & SVM_EXITINFO_REG_MASK;
 	if (svm->vmcb->control.exit_code == SVM_EXIT_CR0_SEL_WRITE)
 		cr = SVM_EXIT_WRITE_CR0 - SVM_EXIT_READ_CR0;
@@ -2673,6 +2720,14 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 		trace_kvm_cr_write(cr, val);
 		switch (cr) {
 		case 0:
+			/*
+			 * The filter never triggers in guest mode and the
+			 * selective-CR0 reflection only applies there, so
+			 * the order of the two checks does not matter.
+			 */
+			if (svm_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR0,
+						   kvm_read_cr0(vcpu), val))
+				return 0;
 			if (!check_selective_cr0_intercepted(vcpu, val))
 				err = kvm_set_cr0(vcpu, val);
 			else
@@ -2683,6 +2738,9 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 			err = kvm_set_cr3(vcpu, val);
 			break;
 		case 4:
+			if (svm_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR4,
+						   kvm_read_cr4(vcpu), val))
+				return 0;
 			err = kvm_set_cr4(vcpu, val);
 			break;
 		case 8:
@@ -5617,6 +5675,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
 
+	.update_reg_write_filter = svm_update_reg_write_filter,
+
 	.recalc_intercepts = svm_recalc_intercepts,
 	.complete_emulated_msr = svm_complete_emulated_msr,
 
@@ -5722,6 +5782,10 @@ static __init void svm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD))
 		kvm_caps.has_bus_lock_exit = true;
 
+	/* CR0/CR4 write interception can always be forced. */
+	kvm_caps.supported_reg_write_filter |= BIT(KVM_X86_REG_FILTER_CR0) |
+					       BIT(KVM_X86_REG_FILTER_CR4);
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-- 
2.50.1

