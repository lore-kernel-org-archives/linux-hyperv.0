Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D74848BE;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239912; cv=none; b=Z++AXVfE3olRAPfJqskUCzp5A2uzs/kMLN0Hq5TCQXfXPjv7Otc+8Ez9fCLTXsoDxo3t1DgeCIGauqt6L0zdugHio5Aljspkfr4XXSXc/4y7eKPZjvAQNgrpKL9WRBKb0h5ZDapQP8hAu5Xl/XxuUEYAPFI+EYR8Cu1ps+DY8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239912; c=relaxed/simple;
	bh=oT7s4cv6fMSBKugaS2HctMLpWgAe8nQJ05iA3X7Aipg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAOINUKsmtJ/BNXql0OWMejht4Z5fJwDMQDoVxfhBA6QAJRvZ3kWH7o6B7lyyFmY7IvZkJoRLXUHYwOvywT8cKIYUiB26uxeGu0zu3kRRQ5fGEXL3YdkOparARCea7DVfkv5fUDP6SSQukL9J963Cs/N13mRbVbReY6KKl2Qvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oto9CyMq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oto9CyMq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=p3mw9EkVpU11SerAAl2pkMAc8HzNP4/vJCe8O/2DNKc=; b=Oto9CyMqvOUksemJog0Nf9PrlO
	XUpjz4v8rKCXBOjxx5hNzyZSWoaINBHR4hRDpgGCxOgXRAr0YMiDkyHBeeOkf+RPUB5JHuxzloQx8
	d4CD0VV3tye55ZsY9lXWMsaaq31NrBrs122hSo/5EOEC4x2LkKiNoHogrBphTTdYQmEDosgjzVUsh
	MNlXfWL2L2kQZKY9NvUqytSRywE9ngpXqIxwZobm4SkZhStdZq1wtOsszpiJVhtWt6/XnBkNAnqtf
	mOeu/45/QtiXGHXYBmU0E5RQIxzUDgsCM4JBFxw/KAacJqgu4YSQt1L3VGBTafSZ+FI3SULPMc/EH
	gb4EUVlw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCb-30wu;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ymo-0qEz;
	Sat, 17 Oct 2026 13:25:03 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	David Woodhouse <dwmw@amazon.co.uk>,
	nh-open-source@amazon.com
Subject: [RFC PATCH 29/55] KVM: x86: hyperv: divert LLDT and LTR into register intercepts
Date: Sat, 17 Oct 2026 13:24:35 +0100
Message-ID: <20261017122501.610248-30-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When a higher VTL arms the ldtr_write or tr_write bits of
HvRegisterCrInterceptControl, hv_divert_dt_write() covers GDTR and
IDTR writes, but an LTR in the lower VTL retires natively, and the
LDTR divert sat in emulator_set_segment(), which task-switch emulation
also reaches via __load_segment_descriptor(). A protected-mode task
switch with the intercept armed — reachable by a malicious lower VTL,
even though 64-bit Windows takes no task switches — had its LDTR load
silently dropped, and the higher VTL received a bogus mid-task-switch
intercept carrying the wrong RIP and instruction length. The TLFS
intercepts cover the LLDT and LTR instructions only.

Add a divert_seg_write(ctxt, selector, seg) emulator op and call it
from em_lldt() and em_ltr() before load_segment_descriptor().
Diverting from the instruction handlers, before any architectural
effect, keeps hardware task switches out of the intercept; for LTR it
also matters that __load_segment_descriptor() marks the TSS descriptor
busy in the GDT first, and a busy descriptor would #GP the LTR when it
re-executes after a cooperative VTL return. emulator_set_segment() no
longer diverts anything.

No vmx change is needed: SECONDARY_EXEC_DESC already exits on LTR
(handle_desc covers EXIT_REASON_LDTR_TR) whenever any
reg_intercept_control bit is set.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/emulate.c     | 21 +++++++++++++++++++++
 arch/x86/kvm/kvm_emulate.h | 10 ++++++++++
 arch/x86/kvm/x86.c         | 33 +++++++++++++++++++++------------
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..86d165b8185c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3387,6 +3387,16 @@ static int em_lldt(struct x86_emulate_ctxt *ctxt)
 
 	/* Disable writeback. */
 	ctxt->dst.type = OP_NONE;
+
+	/*
+	 * A higher VTL's LDTR-write intercept suspends the LLDT before any
+	 * architectural effect.  Diverting here rather than in
+	 * emulator_set_segment() keeps task switches, which load LDTR
+	 * through set_segment as well, out of the intercept.
+	 */
+	if (ctxt->ops->divert_seg_write(ctxt, sel, VCPU_SREG_LDTR))
+		return X86EMUL_CONTINUE;
+
 	return load_segment_descriptor(ctxt, sel, VCPU_SREG_LDTR);
 }
 
@@ -3401,6 +3411,17 @@ static int em_ltr(struct x86_emulate_ctxt *ctxt)
 
 	/* Disable writeback. */
 	ctxt->dst.type = OP_NONE;
+
+	/*
+	 * A higher VTL's TR-write intercept suspends the LTR before any
+	 * architectural effect.  The divert must precede
+	 * load_segment_descriptor(): that path marks the TSS descriptor
+	 * busy in the GDT, and a busy descriptor would #GP the re-executed
+	 * LTR after a cooperative VTL return.
+	 */
+	if (ctxt->ops->divert_seg_write(ctxt, sel, VCPU_SREG_TR))
+		return X86EMUL_CONTINUE;
+
 	return load_segment_descriptor(ctxt, sel, VCPU_SREG_TR);
 }
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..8a3b9a40934b 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -202,6 +202,16 @@ struct x86_emulate_ops {
 			    struct desc_struct *desc, u32 *base3, int seg);
 	void (*set_segment)(struct x86_emulate_ctxt *ctxt, u16 selector,
 			    struct desc_struct *desc, u32 base3, int seg);
+	/*
+	 * Divert an LTR or LLDT into a Hyper-V VSM register-intercept exit
+	 * when the higher VTL armed one.  Returns true when the write was
+	 * diverted: the instruction must then have no architectural effect,
+	 * so this is checked before descriptor validation (and, for LTR,
+	 * the busy-bit write).  Only the instructions divert; task-switch
+	 * loads of LDTR/TR are not covered by the TLFS intercepts.
+	 */
+	bool (*divert_seg_write)(struct x86_emulate_ctxt *ctxt, u16 selector,
+				 int seg);
 	unsigned long (*get_cached_segment_base)(struct x86_emulate_ctxt *ctxt,
 						 int seg);
 	void (*get_gdt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 052821799120..c5122e6f42bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8859,9 +8859,11 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 #define HV_CR_INTERCEPT_GDTR_WRITE	BIT_ULL(15)
 #define HV_CR_INTERCEPT_IDTR_WRITE	BIT_ULL(16)
 #define HV_CR_INTERCEPT_LDTR_WRITE	BIT_ULL(17)
+#define HV_CR_INTERCEPT_TR_WRITE	BIT_ULL(18)
 #define HV_X64_REGISTER_IDTR_ID		0x00070000
 #define HV_X64_REGISTER_GDTR_ID		0x00070001
 #define HV_X64_REGISTER_LDTR_ID		0x00060006
+#define HV_X64_REGISTER_TR_ID		0x00060007
 
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
@@ -8949,22 +8951,28 @@ static void emulator_set_segment(struct x86_emulate_ctxt *ctxt, u16 selector,
 	var.unusable = !var.present;
 	var.padding = 0;
 
-	if (seg == VCPU_SREG_LDTR) {
-		struct desc_ptr sel_as_dt = {
-			.address = selector,
-			.size = 0,
-		};
-
-		/* The intercept message carries the written selector. */
-		if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_LDTR_ID,
-				       &sel_as_dt, HV_CR_INTERCEPT_LDTR_WRITE))
-			return;
-	}
-
 	kvm_set_segment(vcpu, &var, seg);
 	return;
 }
 
+static bool emulator_divert_seg_write(struct x86_emulate_ctxt *ctxt,
+				      u16 selector, int seg)
+{
+	struct desc_ptr sel_as_dt = {
+		.address = selector,
+		.size = 0,
+	};
+
+	/* The intercept message carries the written selector. */
+	if (seg == VCPU_SREG_LDTR)
+		return hv_divert_dt_write(ctxt, HV_X64_REGISTER_LDTR_ID,
+					  &sel_as_dt,
+					  HV_CR_INTERCEPT_LDTR_WRITE);
+
+	return hv_divert_dt_write(ctxt, HV_X64_REGISTER_TR_ID, &sel_as_dt,
+				  HV_CR_INTERCEPT_TR_WRITE);
+}
+
 static int emulator_get_msr_with_filter(struct x86_emulate_ctxt *ctxt,
 					u32 msr_index, u64 *pdata)
 {
@@ -9167,6 +9175,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.pio_out_emulated    = emulator_pio_out_emulated,
 	.get_segment         = emulator_get_segment,
 	.set_segment         = emulator_set_segment,
+	.divert_seg_write    = emulator_divert_seg_write,
 	.get_cached_segment_base = emulator_get_cached_segment_base,
 	.get_gdt             = emulator_get_gdt,
 	.get_idt	     = emulator_get_idt,
-- 
2.50.1

