Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54447FB13;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239907; cv=none; b=DJbVS/ABcQVNUi4ij1AibwaNeDk5M8Vk6PQ1/BIX908a4hFT9TJz60gIc0P+n35UdwmAnbQovhOM7vgv24m8zTYbixUoniqihmziWzXGT+Xp2441k6tc/iNDtS0LzgwWgTL1sQJ6oVIo7lAZBp9i4F+RkwGb5bMD7XIJpk1TY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239907; c=relaxed/simple;
	bh=DiMB85kWHBJwzj9kWTX/8hsMthIPOvIwZwLwo/Jp3K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6Vtok6EEOpMJtUtcSMvuynBOq8TdawTu+G/a6VMYte2GgLn0Nj60MG41lcBdjeuuqtFBqhfHNyn3TvoXEXaR16c4Ghv7XxeCvoyqszQti69H3Xz6jU0y176PsTd3BjR0OUA/U38rhflYTvo8/6euW9rItpCfrvnNfxs0ilXoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Am0MamZR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Am0MamZR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=vRfXLwxb6xxx/uxqzwOZVie4vg6Lne5slKcWLAFH2DE=; b=Am0MamZRJZ+Y6mHcFrMOhWCv68
	2TzBPfS8pUo7tUkQWp+dYNE5XWfg4KoKoMl+cG77qbRsgRkt6d7ZEnSzvTJeKqBQfD00JwfaYk269
	OkBr7z3t/frdsTHwR1F+eKTyqp/EQ2Bhs+ZyrstZGbWWbgceLl8aQNN6Dch8YyOne/a7WrRu/4LUU
	tEf+dLuSebifa4eC9YojbmeIyUEZRfzgLnVEHNeRT3Ybrysden6utkGaqU7rChk1wI4yTOnO58ANL
	of7Hyk6CLDEtYe9YUcNVBNNBjF+KcrbMiz8ZPFFL574liQw9DLyMzGSildW+zn/a9/hqRVqXC6XX/
	cUnNpLjg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCA-0V7e;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TB-00000002Yku-3iWu;
	Sat, 17 Oct 2026 13:25:01 +0100
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
Subject: [RFC PATCH 02/55] KVM: x86: Let userspace opt in to multiple planes with KVM_CAP_PLANES
Date: Sat, 17 Oct 2026 13:24:08 +0100
Message-ID: <20261017122501.610248-3-dwmw2@infradead.org>
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

A VMM implementing a software privilege model such as Hyper-V VSM
needs more than one plane, but kvm_arch_max_planes() returns the
vendor ceiling — 1 everywhere except SEV-SNP, where VMPLs are
guest-architectural — so KVM_CREATE_PLANE rejects every id above zero.

Make KVM_CAP_PLANES a VM enable capability taking the number of planes
userspace is going to manage, up to KVM_MAX_PLANES. It must be set
before any vCPU or extra plane exists, so nothing is sized against the
old limit, and cannot be changed once set. Non-default VM types are
rejected: SEV-SNP keeps deriving its count from the supported VMPLs,
and protected-state VM types need their own audit first. A VM that
does not enable the capability keeps reporting a single plane.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst  | 27 +++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 42 ++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b5f0136bb555..bc63054ce7bd 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6598,6 +6598,12 @@ KVM_S390_KEYOP_SSKE
 
 Creates a new *plane*, i.e. a separate privilege level for the virtual machine.
 
+The range of valid plane ids is [0, N) where N is the value returned by
+KVM_CHECK_EXTENSION(KVM_CAP_PLANES) on the VM file descriptor.  Plane 0 is
+the VM itself; for VM types where the plane count is not guest-architectural,
+ids above 0 only become valid after userspace enables KVM_CAP_PLANES with
+the number of planes it is going to manage (see section 7.47).
+
 Each plane has a numeric id that is used when communicating with KVM.  While
 KVM is currently agnostic to whether low ids are more or less privileged, it is
 expected that this will not always be the case in the future.  For example KVM
@@ -8959,6 +8965,27 @@ helpful if user space wants to emulate instructions which are not
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.47 KVM_CAP_PLANES
+-------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] contains the number of planes to make available
+
+Opts the VM in to using multiple planes, raising the limit on plane ids
+that KVM_CREATE_PLANE accepts to args[0] (between 1 and the KVM_MAX_PLANES
+value implied by KVM_CHECK_EXTENSION(KVM_CAP_PLANES) on the system fd).
+
+Planes other than plane 0 only exist when userspace manages them, so by
+default a VM reports and accepts a single plane.  VM types whose plane
+count is guest-architectural (such as SEV-SNP, where it reflects the
+supported VMPLs) report that count without this capability, and enabling
+it on them fails with -EINVAL.
+
+This capability must be enabled before any vCPU or extra plane has been
+created, and the chosen count cannot be changed afterwards; otherwise
+-EEXIST is returned.
+
 7.49 KVM_CAP_HCALL_FAULT_EXIT
 ------------------------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0ce814bbf1ea..e4c8691dc1e1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1442,6 +1442,7 @@ struct kvm_arch {
 	unsigned int indirect_shadow_pages;
 	u8 mmu_valid_gen;
 	u8 vm_type;
+	unsigned int user_max_planes;
 	bool has_private_mem;
 	bool has_protected_state;
 	bool has_protected_eoi;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9a15e06fc91e..a9073436c734 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -490,11 +490,29 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_default_max_planes);
 
 unsigned kvm_arch_max_planes(struct kvm *kvm)
 {
+	unsigned int vendor_planes;
+
 	/* For now, planes are only supported with irqchip=split */
 	if (!irqchip_split(kvm))
 		return 1;
 
-	return kvm_x86_call(max_planes)(kvm);
+	vendor_planes = kvm_x86_call(max_planes)(kvm);
+
+	/*
+	 * When the plane count is guest-architectural (SEV-SNP VMPLs),
+	 * the vendor module owns it.  Otherwise planes are a software
+	 * construct and only exist when userspace has opted in to the
+	 * number of planes it is going to manage, via KVM_CAP_PLANES.
+	 */
+	if (vendor_planes > 1)
+		return vendor_planes;
+
+	/*
+	 * Lockless readers (KVM_CHECK_EXTENSION) race the KVM_ENABLE_CAP
+	 * store; the value is set once, so a torn-free read is all that
+	 * is needed.
+	 */
+	return READ_ONCE(kvm->arch.user_max_planes) ? : 1;
 }
 
 struct kvm_plane *x86_alloc_plane(void)
@@ -6846,6 +6864,28 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_PLANES: {
+		mutex_lock(&kvm->lock);
+		r = -EINVAL;
+		if (cap->args[0] < 1 || cap->args[0] > KVM_MAX_PLANES)
+			goto planes_unlock;
+		/*
+		 * Only ordinary VMs for now.  SEV-SNP VMs get their plane
+		 * count from the architectural VMPL support, and VM types
+		 * with protected state need per-plane audits first.
+		 */
+		if (kvm->arch.vm_type != KVM_X86_DEFAULT_VM)
+			goto planes_unlock;
+		r = -EEXIST;
+		if (kvm->created_vcpus || kvm->has_planes ||
+		    kvm->arch.user_max_planes)
+			goto planes_unlock;
+		WRITE_ONCE(kvm->arch.user_max_planes, cap->args[0]);
+		r = 0;
+planes_unlock:
+		mutex_unlock(&kvm->lock);
+		break;
+	}
 	case KVM_CAP_X2APIC_API:
 		r = -EINVAL;
 		if (cap->args[0] & ~KVM_X2APIC_API_VALID_FLAGS)
-- 
2.50.1

