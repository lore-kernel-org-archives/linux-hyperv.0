Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=z2Snkjcs97I0tCY3ayq5+wTwuS/9tk043A7uDAdT6vkkT3OW7FCzi0NbDyGQa9FLFdFj
	 mtYFGa0Y0KIkcEyaVivbuoAfL/qURQh276hhWTXTTsS2jHFrHV0i12yg2ARuEGnkdXQYs
	 uOmubQ5be+dRKX1OS/3i7SW/vbBELE8eZycyf6t9ltkRnSRnysWeFR7+2Q+ltd/zfRIet
	 2i84izY4+Hb+fX1Lpn8a6Gb6sp47vftkXPF8DEbT5vZa6wedAxtwkTzLBzvxiAcdUZ52l
	 x9VoI0qEgG5S7AuGbNUj1RcFHxb1VyWO0o/lUcK5M/74toX/eQZ3cIIKju+D4yhO+Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=VBOpqTxN3vlF8ZFojc7vZzpPompRvlLqN47cSb7Z1Mo=;
	b=hZD2CshmpXRJ1unwL8qF1L8SCSZf+/96zCYZuP1hIRRfRU1ZIlSMCQdpaQlW1eL5sxAd
	 owBD/x+xU4+O3a5EWaY9x5DggUXqH07IwsoQnUNY7+Uxsb4TDno2+jjv4Xj0FK3xDSeSC
	 DIL1IjizZWBv/RA2A3lrWFu3mqLjJ84zyryocbJv1NkaUX4pLvZxKk75tTYIH4H9/JGIp
	 DLWwUy1UeodEATjIT/tRBQ1RE70pNOUB6c0JmlQ3R1tItVOIl2wvIFWFDTj+yCXr2nsdq
	 IovV3EGCDVBPfyVC78RmGSW0QjG76mUMfzorKoKD0ydcLw5vW53D7KYt9ym7FL+kvHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EkUh3Ox+;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3F60A5BC2;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C3F60A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EkUh3Ox+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VBOpqTxN3vlF8ZFojc7vZzpPompRvlLqN47cSb7Z1Mo=; b=EkUh3Ox+9gjuy1D2h+lJNM3Y4Y
	AzrVTi5FSKpEj6RiCHLvCy08N83NrN2eLQQ4/g390AITZ056JBklS0REtE35+HXcjjxX25o3YkPqE
	xg9niULaGmlIsg6uApQrOt39bxV26hDDOApOOpsLOw50Zo2MrW2lBC2xUbz+tLbZToscvkr+15Z4e
	vcupmSVSEPD1vx/D6DO8f8yMVVF2CulaUEUNHUiU8jDUK4LBxy+a2qLc5tCu3+T9jzzHAI5P64biI
	2m8fzDD9FedKCda8zQkqaEhZQ/703YZtOl7nRsc+NWtYPn5O8hsUSq5cdlafljIQHBzo2NhkfgFKf
	oqxO8avg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bf03-3AOi;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LtW-41Ro;
	Fri, 13 Nov 2026 18:34:49 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	joerg.roedel@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 15/31] KVM: x86: hyperv: Divert LLDT and LTR into register intercepts
Date: Fri, 13 Nov 2026 18:34:31 +0000
Message-ID: <20261113183448.84094-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113183448.84094-1-dwmw2@infradead.org>
References: <20261113183448.84094-1-dwmw2@infradead.org>
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

HvRegisterCrInterceptControl has LDTR and TR write intercept bits next
to the GDTR and IDTR ones, but only LGDT and LIDT are diverted into
KVM_EXIT_HYPERV_REG_INTERCEPT. An armed LLDT or LTR in the lower VTL
is applied, and the higher VTL never sees the write it asked to
intercept.

Add a divert_seg_write(ctxt, selector, seg) emulator op and call it
from em_lldt() and em_ltr() before load_segment_descriptor(). It goes
through hv_divert_dt_write() with HV_X64_REGISTER_LDTR_ID or
HV_X64_REGISTER_TR_ID; the intercept message carries the written
selector, so the exit reports it in 'base' with a zero 'limit', as
api.rst now says.

Divert from the instruction handlers, before any architectural effect,
rather than from emulator_set_segment(). Task-switch emulation also
loads LDTR through __load_segment_descriptor(), and the TLFS intercepts
cover the LLDT and LTR instructions only; a divert there would drop
the LDTR load of a protected-mode task switch (reachable by a malicious
lower VTL, even though 64-bit Windows takes no task switches) and send
the higher VTL a mid-task-switch intercept with the wrong RIP and
instruction length. For LTR the order also matters because
__load_segment_descriptor() marks the TSS descriptor busy in the GDT,
and a busy descriptor would #GP the LTR when it re-executes after a
cooperative VTL return.

No vmx change is needed: SECONDARY_EXEC_DESC already exits on LTR
(handle_desc covers EXIT_REASON_LDTR_TR) whenever any
reg_intercept_control bit is set.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst |  6 ++++--
 arch/x86/kvm/emulate.c         | 21 +++++++++++++++++++++
 arch/x86/kvm/kvm_emulate.h     | 10 ++++++++++
 arch/x86/kvm/x86.c             | 23 +++++++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f1c64d721570..b742ca327130 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7551,8 +7551,10 @@ higher plane intercepted (KVM_CAP_HYPERV_REG_INTERCEPT) has been
 diverted to userspace instead of being applied.  'reg_intercept'
 carries the HV_X64_REGISTER_* id of the written register, the
 descriptor-table base and limit the guest tried to load, and the RIP
-and length of the writing instruction.  The vCPU's RIP has been
-rewound to that instruction; the higher plane owns its completion.
+and length of the writing instruction.  For HV_X64_REGISTER_LDTR_ID
+and HV_X64_REGISTER_TR_ID (LLDT and LTR) 'base' carries the written
+selector and 'limit' is 0.  The vCPU's RIP has been rewound to that
+instruction; the higher plane owns its completion.
 
 ::
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 93596cf6aa3d..187047bf1005 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3394,6 +3394,16 @@ static int em_lldt(struct x86_emulate_ctxt *ctxt)
 
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
 
@@ -3408,6 +3418,17 @@ static int em_ltr(struct x86_emulate_ctxt *ctxt)
 
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
index 488738794bb6..a810d099782b 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -208,6 +208,16 @@ struct x86_emulate_ops {
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
index 99a18f9da769..165eb105e112 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5933,8 +5933,12 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 
 #define HV_CR_INTERCEPT_GDTR_WRITE	BIT_ULL(15)
 #define HV_CR_INTERCEPT_IDTR_WRITE	BIT_ULL(16)
+#define HV_CR_INTERCEPT_LDTR_WRITE	BIT_ULL(17)
+#define HV_CR_INTERCEPT_TR_WRITE	BIT_ULL(18)
 #define HV_X64_REGISTER_IDTR_ID		0x00070000
 #define HV_X64_REGISTER_GDTR_ID		0x00070001
+#define HV_X64_REGISTER_LDTR_ID		0x00060006
+#define HV_X64_REGISTER_TR_ID		0x00060007
 
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
@@ -6026,6 +6030,24 @@ static void emulator_set_segment(struct x86_emulate_ctxt *ctxt, u16 selector,
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
@@ -6194,6 +6216,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.pio_out_emulated    = emulator_pio_out_emulated,
 	.get_segment         = emulator_get_segment,
 	.set_segment         = emulator_set_segment,
+	.divert_seg_write    = emulator_divert_seg_write,
 	.get_cached_segment_base = emulator_get_cached_segment_base,
 	.get_gdt             = emulator_get_gdt,
 	.get_idt	     = emulator_get_idt,
-- 
2.50.1

