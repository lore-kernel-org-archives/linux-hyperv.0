Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87848F001;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239910; cv=none; b=OWVOiOypLClD3eAUaxaxiWYNXf9KFziHNpXUMFhrKtGpLLdHcO2H+WZEa9RhFFyM4sRvCh1VkcGTQhykf6P9J8pwZoA5GZ4VauGJ6mYg4MXaqdqdtS/Wb84paFUw2qtmV9lYhWwJl9Xioh6kPMkQ7vcj5GE8fpIngBiZ61ZDPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239910; c=relaxed/simple;
	bh=1J3qC5Oq7Srd0keW0OO2QWLWcl2+mCDDb0bY9RxZj6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7Or6OjF0dBrILppMnuja6d5slxIzC3utV665PQ9kgYgwVR3BHWgNg+9b9BdUfWABG4h1DfJMB/dqehvtE7S8QBz0qHMZuctLR2LUfV8Ed0NJARpygnyFI+LimF/qo5ZEnQ6Qrtaz1U8pxyPFW+chXtE9dSNGxxxes5NoVgbWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jK0niyEC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jK0niyEC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wLsGF6uGFGLAH+kB1tI7Qt6oZ6M1uGzRVnG4O8inLuI=; b=jK0niyECKcTg7/ahYrKEWrKzrV
	BKcXesX9cP5VdixbEBIw1qN3qQI69Y+geUaGhAozc8zhehlar+JiFQ210WEx7P3hI7FEnoRmXITFH
	kkyMHuTKJOpnEX5QziaEzdLijVRcIcZAPJZi0mxul2dFrG6MLtu29lNu7lwlSfAtHXxMxQnCAI/u5
	hrsztXBIkoqgyHBirIH7gX32GGsRQbWDaG1CmZTbjEjJPA1edCYw9ZsNCtFAM1GgCVjrrVw7k3f14
	IJMJPc/rmaFXbRAwIlFy20GTHP9hsAeAxdHgS6ahih6xkP5+M6cobYjRDL8eKJZdCQjzatjhOc2iN
	7Dm3Udmg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVD2-3XXB;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnB-1tvM;
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
Subject: [RFC PATCH 34/55] KVM: planes: Share XCR0 across plane twins
Date: Sat, 17 Oct 2026 13:24:40 +0100
Message-ID: <20261017122501.610248-35-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

XCR0/XFEM is shared between VTLs: the TLFS banks no vector state and
the reference host keeps a single XCR0 (its store_vtl/load_vtl carry
no XSAVE state). The planes series shares the FPU payload between
twins but keeps arch.xcr0 per-vCPU, so an XSETBV in one VTL was
invisible in the other: VTL1 read a stale XFEM, and state enabled by
VTL0 (AVX, for the Windows secure kernel) silently vanished across a
VTL switch.

Propagate the validated value to every plane twin in __kvm_set_xcr(),
covering both guest XSETBV and the KVM_SET_XCRS ioctl path. The CPUID
dynamic-bits dirty marker lives in the shared common state, so the
existing single set covers the twins.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 491a0360c403..0f8a149ba0eb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1361,6 +1361,28 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 
 	vcpu->arch.xcr0 = xcr0;
 
+	/*
+	 * XCR0/XFEM is shared across VTLs (TLFS 15.4; the reference host
+	 * banks no vector state): propagate the new value to every plane
+	 * twin so the other VTLs observe it.  This covers both guest
+	 * XSETBV and the KVM_SET_XCRS ioctl path.  The CPUID dirty marker
+	 * below lives in the shared common state, so one set covers the
+	 * twins too.
+	 *
+	 * Skip the fan-out until this vCPU is published in
+	 * common->vcpus[]: the architectural reset of a twin still being
+	 * created must not clobber a live sibling's XCR0 (the new twin
+	 * inherits the shared value instead, in kvm_arch_vcpu_create()).
+	 */
+	if (vcpu->common &&
+	    vcpu->common->vcpus[vcpu->plane_level] == vcpu) {
+		struct kvm_vcpu *twin;
+		int i;
+
+		vcpu_for_each_plane(vcpu->common, i, twin)
+			twin->arch.xcr0 = xcr0;
+	}
+
 	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
 		cpuid_set_dirty(vcpu);
 	return 0;
@@ -13549,6 +13571,14 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_vcpu_after_set_cpuid(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
 	kvm_vcpu_reset(vcpu, false);
+	/*
+	 * XCR0 is shared across planes.  A twin created after its plane-0
+	 * sibling has run (Hyper-V VSM enables VTL1 at runtime) inherits
+	 * the current shared value; the architectural reset value only
+	 * stands when no sibling exists yet.
+	 */
+	if (vcpu->plane_level && vcpu->common->vcpus[0])
+		vcpu->arch.xcr0 = vcpu->common->vcpus[0]->arch.xcr0;
 	kvm_init_mmu(vcpu);
 	vcpu_put(vcpu);
 	return 0;
-- 
2.50.1

