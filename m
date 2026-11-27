Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=I3lcugzZ9HEq97hLnF30PQLLVI4G/R9PVD/fUTMP1IgXApxNIpVMAvjp0OFKllWJCj8G
	 q3igeF07mNA2Gut3n5klCCbqDEN56WSE02sedclulhBE/Y9Bvx8v/EmykBrTw9xEXnmvK
	 ZuN23Y0ybJiZpO2Xc8xlUxDcjf6zkm9X7OolDqhQMA4v/ULOQ2+3SAB8as8FUUGMBsdYj
	 coziYWAMj0rzGFTjV23AagfQ3UsgdDcsuwP4YDv1EkRQKSEK0YN48TMIruloekEHahBMd
	 i/ktDW+qIjX/lRceGSe0hVGZBZCWI9FcjZTBAepVmjsM8zRjIJ67i8pjQaJ+JFMUUgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=z2Y5xsk1oXD8hgCftu0objaSqV0eSFscaGibC1bv4bE=;
	b=oierIRigislkwTAwlFaeoaaFI3VaSBCow4KHbCy1Jlr1+ZMHIAl9mcmwPSjSdrEwh5hK
	 bFdiTt4fQp0wyjZvRcR5e7Q7loDqHA3f0zsb0Z3qqiQFHA6DyOu0h7gjAO9A6Ye2i4GBe
	 g225QubT1aDypEJWValDNvZKOa0KcPsImYxig/ufR1imirn2Hx0SH+1d48drLSp/ZYUKQ
	 SAoQ99nVpVsTaRY51hnJVbzGTq0WtS6uCoAx0gQn09X7GggiudB3aqQa7nLw1hE6ULVCb
	 ls7O9jB+GVP1x3PeUdVlZV0igMOq0KeAo8IuU0YY/24W6sSClRc8oVkzrQ1USzmzBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UqZAuLvF;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF060A2620;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEF060A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UqZAuLvF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z2Y5xsk1oXD8hgCftu0objaSqV0eSFscaGibC1bv4bE=; b=UqZAuLvF5jjZ192pyKrUAbWUVC
	VeYoVuzlQgCPga9YBZevU0v9lhaqrYlKiCGdpdY4kAIgC+ds2WosXpTkwzl9Hb8zYtiOe/N0t+739
	dV/LyogFx3B6G/5cTfN6fR4IGkNXwiJgWGckn1E+yIMV6AvMFs9lgGPKqwwET5P+kYtoqzipRS/vk
	71h3Dcm5tLzzsfrrmmssRhy+5Piped4Yaj4USQixcGwRwPIKwJR6DG6Iu4o3k0XS9wOEyBXG+atag
	ZoN7Dq6nhWwwun7/AHTx5KMxhlV5Sqw14UIPcDV7aCH4f+blVIkUyNo4bwq/yoqXqUGumsuvYGKDU
	0tUfaJKQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkl-2Ez9;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pq7-0xDP;
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
Subject: [PATCH v3 02/15] KVM: Define what completing an exit does with its instruction
Date: Fri, 27 Nov 2026 15:27:17 +0000
Message-ID: <20261127152730.99319-3-dwmw2@infradead.org>
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

The KVM_RUN after an exit which left an instruction to complete retires
that instruction.  Only MSR exits offer anything else: their 'error'
byte asks for #GP instead.

Define one set of values for such exits: complete the instruction,
inject #GP or #UD at it, or do nothing and resume the guest as
userspace left it.  Add the x86 helper which acts on them; a guest with
protected state can only have the instruction completed.  No exit takes
them yet.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 50 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h             | 32 ++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  9 ++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..d15dddd79e5b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6976,6 +6976,56 @@ to the byte array.
       to complete pending operations without allowing any further instructions
       to be executed.
 
+.. _kvm_insn_action:
+
+Some exits which need completion let userspace choose what the
+completion does with the guest instruction that caused the exit.  Their
+descriptions say which field takes the choice, and when.  The values are
+the same for all of them::
+
+  #define KVM_INSN_COMPLETE	0
+  #define KVM_INSN_GP		1
+  #define KVM_INSN_UD		2
+  #define KVM_INSN_RESUME	3
+
+KVM_INSN_COMPLETE
+  The instruction completes: KVM writes its result, if it has one, and
+  retires it, i.e. moves RIP past it, clears RFLAGS.RF and the interrupt
+  shadow, and honours single-stepping.  KVM sets the field to this.  RIP
+  must still point at the instruction, and RFLAGS be as the exit left
+  it: userspace which changes either retires the instruction itself,
+  with KVM_INSN_RESUME.
+
+KVM_INSN_GP, KVM_INSN_UD
+  The instruction faults: KVM injects #GP with a zero error code, or
+  #UD, and RIP stays at the instruction.  Every exit which takes these
+  values takes both; userspace chooses the one which the CPU would raise
+  for the instruction.
+
+KVM_INSN_RESUME
+  KVM does nothing for the instruction.  It writes no result and injects
+  nothing, and the guest resumes from its state as userspace left it.
+  The instruction has not retired, so the interrupt shadow and RFLAGS.RF
+  stay as they are and no single-step trap is raised, neither a #DB for
+  the guest nor KVM_EXIT_DEBUG.  What the guest sees is up to userspace:
+
+  - with an exception queued by KVM_SET_VCPU_EVENTS, the guest takes the
+    exception at the instruction;
+  - with RIP moved, the guest continues from there: userspace has
+    retired the instruction itself and owns everything that goes with
+    that;
+  - with nothing changed, the guest executes the instruction again and
+    KVM_RUN returns with the same exit.
+
+Any other value is reserved: KVM_RUN fails with -EINVAL, and the guest
+is left as for KVM_INSN_RESUME.
+
+A guest whose register state is protected (SEV-ES, SEV-SNP, TDX) does
+not execute the instruction again, and KVM cannot inject #UD into it.
+KVM can only complete the exit there, with whatever outcome the exit
+itself has, and the description of each exit says what it makes of
+another value.
+
 ::
 
 		/* KVM_EXIT_HYPERCALL */
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 436e2fb1396c..7e5ccbce9114 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -526,6 +526,38 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
 }
 
+/*
+ * Act on the KVM_INSN_* answer which userspace gave to an exit that left an
+ * instruction to complete.  Returns 0 if the caller is to complete the
+ * instruction, 1 if there is nothing more to do for it, or -EINVAL.
+ *
+ * A guest whose state is protected does not execute the instruction again,
+ * and KVM cannot inject #UD into it: all that can be done there is to
+ * complete the exit, with an outcome which is the caller's to choose from
+ * the answer, or to ignore it.
+ */
+static inline int kvm_insn_uncompleted(struct kvm_vcpu *vcpu, u8 answer)
+{
+	if (vcpu->kvm->arch.has_protected_state ||
+	    vcpu->arch.guest_state_protected)
+		return 0;
+
+	switch (answer) {
+	case KVM_INSN_COMPLETE:
+		return 0;
+	case KVM_INSN_GP:
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	case KVM_INSN_UD:
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	case KVM_INSN_RESUME:
+		return 1;
+	default:
+		return -EINVAL;
+	}
+}
+
 void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e..0a4c548cb329 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -220,6 +220,15 @@ struct kvm_exit_snp_req_certs {
 #define HINT_UNSAFE_IN_KVM(_symbol) _symbol
 #endif
 
+/*
+ * What the next KVM_RUN does with the instruction which an exit left to be
+ * completed, for the exits whose description says that they take one.
+ */
+#define KVM_INSN_COMPLETE	0	/* retire it, with its result if any */
+#define KVM_INSN_GP		1	/* inject #GP(0) at it */
+#define KVM_INSN_UD		2	/* inject #UD at it */
+#define KVM_INSN_RESUME		3	/* nothing: resume the guest as it is */
+
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
 	/* in */
-- 
2.50.1

