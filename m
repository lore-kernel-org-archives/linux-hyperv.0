Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=EaAQ0wcsrd8LjTYv3sRly4YHE47977AZEdgCY6fXPkJWiLypbka2xAS+x1N9D/Zi1XPC
	 4nLIdU9z0cfjt7t9xeyyLVna2WI7mLIRj/1T44AbYGKwshUHn5CJGq4PX70VXSc7VwxOQ
	 T9kZO9KPR60/sPsfcpTnynp42CUpipdd2pHD5Cehu6zIDcvBikRrAs9KdHCd01vtm19bQ
	 nvGVHfH8tFJEG42zSI7Uvw924LwI8/X9W9K1cfJ8ul+SnlCQyk1b9EvXsvEF/B8GydOh6
	 RH7JhstBpqdHajilSImlQaebXFDUQsauoD97MESsm/fCGCj0/Egv/de7eWHISfE2WZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Ukx0O8oxDW21L8q50oPdnx4Z+HK1r/B4WyzP7b5ZREw=;
	b=LWONI/10yZv9Z07ulcRcHZ1Kna3nRt2ePnt4JhEkafUOFaANqBuTGK5gwx53fFLfiPr5
	 XUbNgROxFw+LTD6vc/xM1HQ8t8Oc2dLi8IF+5w4oTJdBv/xXXxkb+xklyiDL+ZHisX6bo
	 BzZE36QgORb6pyJcWdISPcui67kPJKoW9b3NPcOGszRTzMMVlivkV1bKgeAxjYxOVGwwC
	 rdk9YLOvNmT4Y76WeO9fkh95I3QbySH8yT9/iAYEqbf67eVb070EMedQR2/hkbQM7JLvh
	 oq4nt6QmfJfW2COzLIPq5yFg67sSRchX4ypXGl7ZhB5HHfyqAXb9iv3BZ2Z2l8ZTnig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AGIAV6t9;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0A60A2621;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF0A60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AGIAV6t9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ukx0O8oxDW21L8q50oPdnx4Z+HK1r/B4WyzP7b5ZREw=; b=AGIAV6t9bmEm+y2qKa4Rb7ivwP
	vJYRxMDIKHoUfQ2ZkhGgfkpuJv/UNvgO7NTs8Tfnpp7Us/pX6y3NBj0NOhDk6lD3Lx7cMiAgGBI9/
	wgTBf2nk78bdBhzci3rR8VCgb1H4V5IgxrK4uoUD3/9gjw02GC1XszVXpzSvDkFe0YxqV/pOsddVV
	6dBRTBv+CfIspstV5BtgVJDoCvLXKKUfncPIOsTmoWFjw/tuicvrdNCV3rLf2NDOB0oXq/d548eIi
	RC3cc3fX2nQogN0U4aptTQpww32IR9d8pmDv94f3lu/Q2hwhrLJ0x1p9yA08B5a2HfuUBkK408gxT
	SeJnnUGA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkp-2EIE;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqe-2lLX;
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
Subject: [PATCH v3 10/15] KVM: x86: Filter emulated CR0 and CR4 writes
Date: Fri, 27 Nov 2026 15:27:25 +0000
Message-ID: <20261127152730.99319-11-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

MOV to CR, CLTS and LMSW can reach the emulator instead of the vendor
fast paths.  Check the filter in those three handlers, not in
->set_cr(), which RSM and task switches use too.

The emulator retires what it raised, as it does for XSETBV.  Nothing
can arm a CR0 or CR4 filter yet: the vendor patches which follow
advertise them, and SVM leans on the emulator where it lacks decode
assists or NextRIP.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/emulate.c     | 21 +++++++++++++++++++--
 arch/x86/kvm/kvm_emulate.h | 10 ++++++++++
 arch/x86/kvm/x86.c         | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 465b7d402f75..9a4aebcccc95 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3252,6 +3252,10 @@ static int em_cr_write(struct x86_emulate_ctxt *ctxt)
 	int cr_num = ctxt->modrm_reg;
 	int r;
 
+	r = ctxt->ops->filter_cr_write(ctxt, cr_num, ctxt->src.val);
+	if (r != X86EMUL_CONTINUE)
+		return r;
+
 	if (ctxt->ops->set_cr(ctxt, cr_num, ctxt->src.val))
 		return emulate_gp(ctxt, 0);
 
@@ -3409,9 +3413,15 @@ static int em_invlpg(struct x86_emulate_ctxt *ctxt)
 static int em_clts(struct x86_emulate_ctxt *ctxt)
 {
 	ulong cr0;
+	int r;
 
 	cr0 = ctxt->ops->get_cr(ctxt, 0);
 	cr0 &= ~X86_CR0_TS;
+
+	r = ctxt->ops->filter_cr_write(ctxt, 0, cr0);
+	if (r != X86EMUL_CONTINUE)
+		return r;
+
 	ctxt->ops->set_cr(ctxt, 0, cr0);
 	return X86EMUL_CONTINUE;
 }
@@ -3512,8 +3522,15 @@ static int em_smsw(struct x86_emulate_ctxt *ctxt)
 
 static int em_lmsw(struct x86_emulate_ctxt *ctxt)
 {
-	ctxt->ops->set_cr(ctxt, 0, (ctxt->ops->get_cr(ctxt, 0) & ~0x0eul)
-			  | (ctxt->src.val & 0x0f));
+	ulong cr0 = (ctxt->ops->get_cr(ctxt, 0) & ~0x0eul) |
+		    (ctxt->src.val & 0x0f);
+	int r;
+
+	r = ctxt->ops->filter_cr_write(ctxt, 0, cr0);
+	if (r != X86EMUL_CONTINUE)
+		return r;
+
+	ctxt->ops->set_cr(ctxt, 0, cr0);
 	ctxt->dst.type = OP_NONE;
 	return X86EMUL_CONTINUE;
 }
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 5e18c0cc7f60..311ff6a01079 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -214,6 +214,16 @@ struct x86_emulate_ops {
 	void (*set_idt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt);
 	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
 	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
+	/*
+	 * Check a guest control register write against the vCPU's write
+	 * filters (KVM_X86_SET_REG_WRITE_FILTER) before performing it.
+	 * Returns X86EMUL_CONTINUE when the write is to be applied, or
+	 * X86EMUL_IO_NEEDED after setting up a KVM_EXIT_X86_REG_WRITE exit;
+	 * the emulation is then abandoned with no architectural effect, and
+	 * the exit's completion retires the instruction.
+	 */
+	int (*filter_cr_write)(struct x86_emulate_ctxt *ctxt, int cr,
+			       ulong val);
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
 	ulong (*get_effective_dr7)(struct x86_emulate_ctxt *ctxt);
 	ulong (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b559c7880e54..4e6f0cb80288 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5846,6 +5846,42 @@ static int emulator_filter_xcr_write(struct x86_emulate_ctxt *ctxt, u32 index,
 				       vcpu->arch.xcr0, xcr);
 }
 
+/*
+ * Divert an emulated CR0/CR4 write into a KVM_EXIT_X86_REG_WRITE exit when
+ * it hits a write filter.  Called by the instruction handlers (MOV to CR,
+ * CLTS, LMSW) before any architectural effect; state loads that reach
+ * ->set_cr() on other instructions' behalf (RSM, task switches) are not
+ * guest register writes and stay unfiltered.
+ */
+static int emulator_filter_cr_write(struct x86_emulate_ctxt *ctxt, int cr,
+				    ulong val)
+{
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	u64 old_value, new_value;
+	u32 reg;
+
+	switch (cr) {
+	case 0:
+		reg = KVM_X86_REG_FILTER_CR0;
+		old_value = kvm_read_cr0(vcpu);
+		break;
+	case 4:
+		reg = KVM_X86_REG_FILTER_CR4;
+		old_value = kvm_read_cr4(vcpu);
+		break;
+	default:
+		return X86EMUL_CONTINUE;
+	}
+
+	/* Match the merge emulator_set_cr() will do with the same value. */
+	new_value = mk_cr_64(old_value, val);
+
+	if (!kvm_reg_write_filtered(vcpu, reg, old_value, new_value))
+		return X86EMUL_CONTINUE;
+
+	return emulator_reg_write_exit(ctxt, reg, old_value, new_value);
+}
+
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
 	return kvm_x86_call(get_cpl)(emul_to_vcpu(ctxt));
@@ -6118,6 +6154,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.set_idt	     = emulator_set_idt,
 	.get_cr              = emulator_get_cr,
 	.set_cr              = emulator_set_cr,
+	.filter_cr_write     = emulator_filter_cr_write,
 	.cpl                 = emulator_get_cpl,
 	.get_effective_dr7   = emulator_get_effective_dr7,
 	.get_dr              = emulator_get_dr,
-- 
2.50.1

