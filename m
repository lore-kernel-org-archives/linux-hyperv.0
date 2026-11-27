Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793256;
	b=IL1/D0Smwxrj46SUVsQhyoIVl6Gj7rN10cOBT/ZC8h67SCIE7wz8EgrRmAxnikZEkAUE
	 /vvstmFfh+wlmhgQBkKTHjx3Bq3CIN4Q5vPE0Mo87/45GyWyhyip8Y+BJL5ZC8t1a5ecn
	 NMrh/1HWJVUBqvcb91kjc0jVPUHK/hONqPYQYBqiNho7c0VEkBjnViLMiC2ISTftmVSpu
	 Nz3xSd9glPbkxeUW1T419gZjLDNHICrfwGdELXSC5uhelto5tpwtcM9YNsIUx0mxsyoiR
	 p2wWa+wdAAHs6aVX9WhBSmATMMKGTvvtxtHvdcy+JH5HUCgeFj/BU8GFnnAOCyXVUmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793256;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=b21IBx176tNT26CrcV+lAj1FVajl2noTGMquN5oHS2k=;
	b=WrXRsvE3Gt4lOrwayRmhaWr7W/W8FP2UXCOyIVvjbAcTe1YQF+UmYHZT3iQ8v0A4yl5X
	 HtctGAaiuHelpkAmJ6ehvpOQ99AEoM/yYXo/PKz/LC+2ANGjRSwdqb1jOUnDgieQInI1X
	 7ABe8TEiWzNdz6ndpdi2FdgPxUTBeilqp8WhO8UTc2XOEKgQfvVOvAWAehpGQmCabme7H
	 xQ5vgwn53d0Ef+2rfRaVj7k+oWUhJT85f70ZbZKP0z7nuLypreWx6slIWYNDyiHB9jcZ7
	 vyGzClwMqVbn3Uzz1AZAIgtiSkvktLGS7SStu5bMVZUpJfkdo47MRHxO762ZjJ35dpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eS88KzN3;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED97606A31F;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED97606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eS88KzN3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b21IBx176tNT26CrcV+lAj1FVajl2noTGMquN5oHS2k=; b=eS88KzN37mbA/gyleS0bA4FRCT
	tn34jW9YU7AMC3QOnsOvj2l1GuXRrFmzxbX725k2s4GyYzjpHH6p3vDpjKRPpLmipoOE1axEr8q+7
	p8BBqHsCyM4JBpM+PgmhHZe73jwcQwER9gMH7Pflc0xnxq7PxCWwITl5GuTCB5lkJ9bQK4Cdb6oLK
	DeS6uE1ZaE0svLQlXcUdfJil2X3j3tHu6yZ6K+6WzubWyNsGB85d9dVnhKPd36S/mX7pvJUEJMSTr
	jBpmo4ItXiBLz2ck7CaiEQ40X+6gmSCvkV6d1gTlij46/0NdPA6xCuqILuKq9YgMdooUTE+cDL7o7
	pVNMViww==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy1V-2RVf;
	Fri, 27 Nov 2026 15:27:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqA-1Flc;
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
Subject: [PATCH v3 03/15] KVM: x86: Let userspace leave an MSR access alone
Date: Fri, 27 Nov 2026 15:27:18 +0000
Message-ID: <20261127152730.99319-4-dwmw2@infradead.org>
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

A VMM completing KVM_EXIT_X86_RDMSR or KVM_EXIT_X86_WRMSR can only have
KVM retire the instruction or inject #GP.  It cannot raise another
exception, or hand the access to something which retires it later.

With KVM_CAP_X86_MSR_EXIT_INSN, 'error' takes KVM_INSN_*: zero and one
mean what they did, KVM_INSN_UD injects #UD and KVM_INSN_RESUME makes
KVM do nothing.  Other values fail KVM_RUN.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 34 ++++++++++++++-
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/msrs.c             | 75 ++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c              |  8 ++++
 include/uapi/linux/kvm.h        |  3 +-
 5 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d15dddd79e5b..6d4a11ce368c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7441,7 +7441,7 @@ non-zero value, indicating that FEAT_LS64* is enabled.
 
 		/* KVM_EXIT_X86_RDMSR / KVM_EXIT_X86_WRMSR */
 		struct {
-			__u8 error; /* user -> kernel */
+			__u8 error; /* in: KVM_INSN_* */
 			__u8 pad[7];
 			__u32 reason; /* kernel -> user */
 			__u32 index; /* kernel -> user */
@@ -7477,6 +7477,17 @@ wants to write. Once finished processing the event, userspace must continue
 vCPU execution. If the MSR write was unsuccessful, userspace also sets the
 "error" field to "1".
 
+Any non-zero "error" injects the #GP, unless KVM_CAP_X86_MSR_EXIT_INSN
+is enabled.  "error" then takes one of the KVM_INSN_* values (see
+:ref:`the description of completion <kvm_insn_action>`), of which zero
+and one are the success and the #GP described above.  KVM_INSN_UD
+injects #UD instead, and KVM_INSN_RESUME tells KVM to do nothing for the
+access: "data" is ignored, no register is written, nothing is injected
+and RIP is left alone.  For a guest whose register state is protected
+(SEV-ES, SEV-SNP and TDX, a debuggable TD included) KVM can neither
+leave the access unanswered nor inject #UD, and every non-zero value
+fails the access like KVM_INSN_GP, with or without the capability.
+
 See KVM_X86_SET_MSR_FILTER for details on the interaction with MSR filtering.
 
 ::
@@ -9231,6 +9242,27 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_X86_MSR_EXIT_INSN
+------------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] is 1 to enable, 0 to disable
+:Returns: 0 on success, -EINVAL if args[0] is any other value
+
+With this capability enabled, the "error" field of every
+KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR exit takes a KVM_INSN_* value,
+whichever of the KVM_MSR_EXIT_REASON_* reasons caused the exit.
+KVM_INSN_UD, and KVM_INSN_RESUME, which leaves the access for userspace
+to resolve, become available, and other values fail KVM_RUN with -EINVAL
+instead of injecting #GP.  It is disabled by default because existing
+VMMs may pass any non-zero value for a failed access.  The capability
+has no effect on which accesses exit; that is still selected with
+KVM_CAP_X86_USER_SPACE_MSR and KVM_X86_SET_MSR_FILTER.
+
+A guest whose register state is protected is the exception: see the
+description of those exits.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ee4b127004d..0e8150116e20 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1297,6 +1297,8 @@ struct kvm_arch {
 	 * the opportunity to look at it.
 	 */
 	bool exit_on_emulation_error;
+	/* msr.error takes KVM_INSN_*, see KVM_CAP_X86_MSR_EXIT_INSN */
+	bool user_space_msr_insn;
 
 	/* Deflect RDMSR and WRMSR to user space when they trigger a #GP */
 	u32 user_space_msr_mask;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..6b1b93592c2e 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -952,12 +952,40 @@ fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr_imm);
 
+/*
+ * Act on what userspace answered in msr.error.  Returns 1 if nothing is left
+ * to do for the access, or -EINVAL; otherwise 0, with @fail set for the
+ * common completion, which retires the instruction or injects #GP by
+ * whatever means the guest needs.
+ *
+ * Without KVM_CAP_X86_MSR_EXIT_INSN any error is a #GP.  So it is for a
+ * guest with protected state, which kvm_insn_uncompleted() only completes.
+ */
+static int kvm_msr_exit_answer(struct kvm_vcpu *vcpu, bool *fail)
+{
+	u8 error = READ_ONCE(vcpu->run->msr.error);
+
+	*fail = error;
+
+	if (!vcpu->kvm->arch.user_space_msr_insn ||
+	    error == KVM_INSN_COMPLETE || error == KVM_INSN_GP)
+		return 0;
+
+	return kvm_insn_uncompleted(vcpu, error);
+}
+
 static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->run->msr.error) {
-		kvm_eax_write(vcpu, vcpu->run->msr.data);
-		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
-	}
+	u64 data = READ_ONCE(vcpu->run->msr.data);
+
+	kvm_eax_write(vcpu, data);
+	kvm_edx_write(vcpu, data >> 32);
+}
+
+static void complete_userspace_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
+			   READ_ONCE(vcpu->run->msr.data));
 }
 
 static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
@@ -971,35 +999,52 @@ static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
 				       EMULTYPE_COMPLETE_USER_EXIT);
 }
 
+/*
+ * The one completion of an MSR exit: @emulated says whether the emulator or
+ * an intercept raised it, and @result writes what a successful read returned.
+ */
+static int complete_msr_access(struct kvm_vcpu *vcpu, bool emulated,
+			       void (*result)(struct kvm_vcpu *vcpu))
+{
+	bool fail;
+	int r;
+
+	r = kvm_msr_exit_answer(vcpu, &fail);
+	if (r)
+		return r;
+
+	if (!fail && result)
+		result(vcpu);
+
+	if (emulated)
+		return complete_emulated_insn_gp(vcpu, fail);
+
+	return kvm_x86_call(complete_emulated_msr)(vcpu, fail);
+}
+
 static int complete_emulated_msr_access(struct kvm_vcpu *vcpu)
 {
-	return complete_emulated_insn_gp(vcpu, vcpu->run->msr.error);
+	return complete_msr_access(vcpu, true, NULL);
 }
 
 static int complete_emulated_rdmsr(struct kvm_vcpu *vcpu)
 {
-	complete_userspace_rdmsr(vcpu);
-	return complete_emulated_msr_access(vcpu);
+	return complete_msr_access(vcpu, true, complete_userspace_rdmsr);
 }
 
 static int complete_fast_msr_access(struct kvm_vcpu *vcpu)
 {
-	return kvm_x86_call(complete_emulated_msr)(vcpu, vcpu->run->msr.error);
+	return complete_msr_access(vcpu, false, NULL);
 }
 
 static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
 {
-	complete_userspace_rdmsr(vcpu);
-	return complete_fast_msr_access(vcpu);
+	return complete_msr_access(vcpu, false, complete_userspace_rdmsr);
 }
 
 static int complete_fast_rdmsr_imm(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->run->msr.error)
-		kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
-				   vcpu->run->msr.data);
-
-	return complete_fast_msr_access(vcpu);
+	return complete_msr_access(vcpu, false, complete_userspace_rdmsr_imm);
 }
 
 static u64 kvm_msr_reason(int r)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..31c6759f38b9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2276,6 +2276,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_LAST_CPU:
 	case KVM_CAP_X86_USER_SPACE_MSR:
+	case KVM_CAP_X86_MSR_EXIT_INSN:
 	case KVM_CAP_X86_MSR_FILTER:
 	case KVM_CAP_ENFORCE_PV_FEATURE_CPUID:
 #ifdef CONFIG_X86_SGX_KVM
@@ -4091,6 +4092,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.user_space_msr_mask = cap->args[0];
 		r = 0;
 		break;
+	case KVM_CAP_X86_MSR_EXIT_INSN:
+		r = -EINVAL;
+		if (cap->args[0] > 1)
+			break;
+		kvm->arch.user_space_msr_insn = cap->args[0];
+		r = 0;
+		break;
 	case KVM_CAP_X86_BUS_LOCK_EXIT:
 		r = -EINVAL;
 		if (cap->args[0] & ~KVM_BUS_LOCK_DETECTION_VALID_MODE)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0a4c548cb329..a146c0487960 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -431,7 +431,7 @@ struct kvm_run {
 		} arm_nisv;
 		/* KVM_EXIT_X86_RDMSR / KVM_EXIT_X86_WRMSR */
 		struct {
-			__u8 error; /* user -> kernel */
+			__u8 error; /* in: KVM_INSN_* */
 			__u8 pad[7];
 #define KVM_MSR_EXIT_REASON_INVAL	(1 << 0)
 #define KVM_MSR_EXIT_REASON_UNKNOWN	(1 << 1)
@@ -1009,6 +1009,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_X86_MSR_EXIT_INSN 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1

