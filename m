Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7549429A;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=XaovYe/5FiEwU29RnLZPCc3soGbKE6VYk96koLEfryjfaF5Du5Y9irvSUZYE8sNHACJ78RLiYDS6yQfYgb9wGiRIf+WeRHNGWEglCV3KyjSW3pdXN8OKF2JoQl/xGmv/6Cm/0jTgu742ljGT/MErbON30sZHKVQulxInRRQtMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=6vMPagEOuYyEfY1B6yKNA6m4gTwHzU0TJu6mcsV1/fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1IjmnEmZtro6TBWYse47eh/8NLNa+qt/d93H9jYxTthspxv7O2CLI6wFjfJvqjSo2J1MueuhdWbPTXkxSlq310dbhopyQOoYxoJSRX/PZJirEoUYVXFBQfvaWqQSAuBEPGXpOWJVipYNa+RgDDXLX86bp45KHOdnqfWTqNSqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YeICn6Ej; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YeICn6Ej"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VqCBB6kXO7UCyXg4rfNCIEycADAsoFBnscSImV0SEXM=; b=YeICn6EjfCuVPzx7JOrYYJjVkx
	2FrgAmceVGevMST/gohFc+vlygTp8pI/tmm/StO9V6Dg83b7xQ4nllnpxRwmJYoMY4Pl+TtFY/5b6
	BonMcnKLWOXRhPDmGjGVI46+dxNVPPmlNXg+su+ElmHBovv/YO/P8ixEazEB7GZsrasvoJfOTa1zq
	QTW025A0p9ehJB6e4Z5a9LouVVss62GAr7jrDD4eMevX3+o6DYye/X4JHwoMBBhdj8ESJW2klHIXL
	S+sOlLG9kpc3AsOLA8o4ynxvIhgKqNB763gRmfK8xdELsCzB1xKiIptb3wi4hRwH7T0pS3CKdpVd8
	17m5jvjg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfS-1we9;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Yn6-1eZg;
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
Subject: [RFC PATCH 33/55] KVM: x86: Report a real write-access walk from KVM_TRANSLATE
Date: Sat, 17 Oct 2026 13:24:39 +0100
Message-ID: <20261017122501.610248-34-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

KVM_TRANSLATE hardcodes writeable = 1, so userspace answering
HvCallTranslateVirtualAddress from this ioctl cannot honour the
hypercall's write-validation flag: validating write access against a
read-only PTE succeeds instead of reporting the address unmapped, and
the Windows secure kernel's page verification trusts a mapping it
cannot write.

Walk the address a second time with PFERR_WRITE_MASK at supervisor
level and report the outcome, matching the reference hypervisor's
validation walk.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afd668c6db3f..491a0360c403 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13305,10 +13305,19 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
+	/*
+	 * Report write access from a supervisor-level walk instead of the
+	 * hardcoded 1: Hyper-V's TranslateVirtualAddress write validation
+	 * is answered from this ioctl, and the reference hypervisor walks
+	 * with PFERR_WRITE_MASK and no user bit.
+	 */
+	tr->writeable = vcpu->arch.walk_mmu->gva_to_gpa(vcpu,
+							vcpu->arch.walk_mmu,
+							vaddr, PFERR_WRITE_MASK,
+							NULL) != INVALID_GPA;
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	tr->physical_address = gpa;
 	tr->valid = gpa != INVALID_GPA;
-	tr->writeable = 1;
 	tr->usermode = 0;
 
 	vcpu_put(vcpu);
-- 
2.50.1

