Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D948F828;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=K6kXBb4HpY/uVaRS2T+KIg8vLSR3Kn3n7Sdl4YGmlzrRziY1qjbtQmZiDIWcs2oCFpUpy+5T2z3/gjF7LBx0UiX6tqYCwWe6S2HYPGgrypyskcnML13dztS5kVIMJS6MsSE6/Fpxya1TDuwROc1l7v5EP4L62nIiAsoiuUhOUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=UlnAh4X/W1iV8phD2/NlYNYiqbhE+WtRQiUM6BtDIl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOKf+dkakCy8dfrHmwYmncZoWO7UEjWvL/2yy6op84aD8On8+KmLL1jagwDGU0oZhMkSlUhDM9TUEmeUzcZrb5lEFcaKYg3GZ+Z43DqN65z0x7wyGWzxVV0KXdx1qU6SHxM0jlE5aLkDWsIGYYNdGvz0FiS1fRaa5uEhHSGXrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQfu6qVs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQfu6qVs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p4JOl5VU+3U9bTyz+MT4JEVbN8bplcD1G1bGlp0DP8w=; b=nQfu6qVsnXqRYRbrqt71J/NMYE
	o84fIn4RP05eF36cBYWE0XdY4vtIlOv5W0Rxp4IU8QBbNfXP9GvgtR3YbbzJto78Qz6DnJRRjND3C
	wnLQK0XFlrewjPzJu/rPCEscBYm61iN2ssDjO/52afQnsy9YPnCZIz8mV3k7hAOeYwI1wNa1slKoG
	b1zSCyAlevFPDelBTyNTQYfoYqY5aBT1sbC7FxL6ZoF+arlO1ETy2zgM2lcRSSPN1kFUFu0pOW8PT
	w8xGirv34qgZfhdYMi+et6IivbKcnc3VTaw7mHD/Te+e8tlX+LWo/pvaUnv+s8IiPsr04dwFVbEjX
	9/JiuZEg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVDU-47l3;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnZ-3CyQ;
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
Subject: [RFC PATCH 40/55] KVM: x86: Implement Hyper-V's vCPU suspended state
Date: Sat, 17 Oct 2026 13:24:46 +0100
Message-ID: <20261017122501.610248-41-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Nikolas Wipper <nikwip@amazon.de>

Introduce a suspension state for Hyper-V enlightened vCPUs. Microsoft's
"Hypervisor Top Level Functional Specification" (TLFS) introduces this
state as a "vCPU that is stopped on a instruction guest boundary, either
explicitly or implicitly due to an intercept". The only documented
explicit suspension is caused in response to a TLB Flush hypercall, which
will use the state switching API in subsequent patches.

Each Hyper-V vCPU now has a 'suspended' boolean field, which is checked
before entering the guest. When set, it forces the vCPU to block. Once in
that state, the vCPU ignores any events. The vCPU is unsuspended by
clearing 'suspend' and issuing a request to force the vCPU out of sleep.

Suspensions are issued as a mechanism to halt execution until state change
is observed on a remote vCPU. Hyper-V vCPUs track this with 'waiting_on',
which holds the 'vcpu_id' of the remote vCPU that forced the vCPU to enter
the suspended state. It's the remote vCPU's responsibility to wake up the
suspended vCPUs when ready. 'waiting_on' ensures the remote vCPU can
selectively unsuspend vCPUs that blocked on its behalf while leaving other
suspended vCPUs undisturbed. One vCPU can only be suspended due to a
single remote vCPU, but different vCPUs can be suspended on behalf of
different or the same remote vCPU(s). The guest is responsible for
avoiding circular dependencies between suspended vCPUs.

Callers of the suspend API are responsible for ensuring that suspend and
unsuspend aren't called in parallel while targeting the same pair of
vCPUs. Otherwise kvm_hv_vcpu_{un}suspend_tlb_flush() ensure 'waiting_on'
and 'suspended' are updated and accessed in the correct order. This, for
example, avoids races where the unsuspended vCPU re-suspends before
kvm_hv_vcpu_unsuspend_tlb_flush() is done updating 'waiting_on'.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>

(cherry picked from the posted series, re-done by hand)
[hmushi: struct kvm_vcpu_hv now lives in arch/x86/kvm/hyperv.h;
 bitmap_zero(vcpu_mask) added (the original used an uninitialised stack
 bitmap)]
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
(re-done by hand from the reference VSM implementation)
[dwmw2: struct kvm_vcpu_hv is in arch/x86/include/asm/kvm_host.h on
 this branch.  Unsuspend walks the suspended waiters' own plane and
 kicks each one directly: kvm_make_vcpus_request_mask() resolves
 indices against plane 0, which is the wrong twin for a waiter in a
 higher plane.]
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/hyperv.c           | 28 ++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h           | 15 +++++++++++++++
 arch/x86/kvm/x86.c              |  2 +-
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 153c076e91bc..6d864aa71b5b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -761,6 +761,9 @@ struct kvm_vcpu_hv {
 	u64 vtl_entry_rax;
 	u64 vtl_entry_rcx;
 	bool vtl_entry_regs_valid;
+
+	bool suspended;
+	int waiting_on;
 };
 
 struct kvm_hypervisor_cpuid {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e6ef0f93096e..0bc9435ea3b9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1040,6 +1040,7 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.hyperv = hv_vcpu;
 	hv_vcpu->vcpu = vcpu;
+	hv_vcpu->waiting_on = -1;
 
 	synic_init(&hv_vcpu->synic);
 
@@ -3764,3 +3765,30 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 	return 0;
 }
+
+void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
+{
+	/* waiting_on's store should happen before suspended's */
+	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
+	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
+}
+
+void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *vcpu_hv;
+	struct kvm_vcpu *v;
+	unsigned long i;
+
+	plane_for_each_vcpu(i, v, vcpu->plane) {
+		vcpu_hv = to_hv_vcpu(v);
+
+		if (vcpu_hv && kvm_hv_vcpu_suspended(v) &&
+		    READ_ONCE(vcpu_hv->waiting_on) == vcpu->vcpu_id) {
+			/* waiting_on's store should happen before suspended's */
+			WRITE_ONCE(vcpu_hv->waiting_on, -1);
+			WRITE_ONCE(vcpu_hv->suspended, false);
+			kvm_make_request(KVM_REQ_EVENT, v);
+			kvm_vcpu_kick(v);
+		}
+	}
+}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 0b81ba482201..5ba2bb2e649b 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -228,6 +228,15 @@ static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
 		(hv_vcpu->cpuid_cache.nested_eax & HV_X64_NESTED_DIRECT_FLUSH);
 }
 
+void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id);
+void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu);
+
+static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.hyperv_enabled &&
+	       READ_ONCE(vcpu->arch.hyperv->suspended);
+}
+
 static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -309,6 +318,12 @@ static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
+static inline void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id) {}
+static inline void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu) {}
+static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 static inline int kvm_hv_verify_vp_assist(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ba468f7c4d4a..d82b457e6714 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12182,7 +12182,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 static bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
-		!vcpu->arch.apf.halted);
+		!vcpu->arch.apf.halted && !kvm_hv_vcpu_suspended(vcpu));
 }
 
 bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
-- 
2.50.1

