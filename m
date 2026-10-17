Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DC49BB59;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239922; cv=none; b=BTBJWgrihnnr9ClF0gq1vFkAhKPwV3CTLk4jsyMjzLmeH2Qx1bjhWd0YTCqgiKSKBjA+/FK06ZBTycT5UwoxcER3PCDFp38CeJKTFOxvGt5swFcj/LK9C2bjeGT7AzOjUrhpONIpXklsIePK9OjqCTWj3Uzh01JBL0I3uPdhJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239922; c=relaxed/simple;
	bh=f+s0TcF2rgcdhfqMxtlIt/rrYCzhR9bIrpDtS6bz1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLGaMsKLF7hiuUalq02Gszyoibg4cGdMx4bFvOcpQmr36g6fo6Rdx8h/94QBxM88YTMihRNf3vp1rTixyj4v+gYhRuUN7cdAtDU4TSKHQZIJHpVJ6L8DuBCOhychXJIYB1ket0LjRLVx39uigDJVKcsFA7CtQDs9tQ0j4YtiyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BB7ZQpyg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BB7ZQpyg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b84l7c+3APHc+R8gW+0cyDQpS7umyE+pPCwVc1HKzPw=; b=BB7ZQpyg00Ps5gcId6kR9qE/OI
	CAIRlQcvQHfL+wro46vRqxDngRs16Ee/TAKUSH/vQrCjdEwZ8wz9VjbO7WTRG2u9DpkF0e4Lvk5Sa
	MOA5xnsS9oyrZdjDKfPipY838OjHBwSLRvv5C3k5PExOGoT9mLrUb7L/J7Aq1+1L4Ptu9O9PtaNdt
	nSUEK4w7wuqWbsoxcZBBSzGcbf6g39MeqF3QBWWhLJd4HcuPZUNGwgMmVmnkbi6sLvLk41FBUxyFY
	EfgnYZ3JsA2xR9jBWTxDxxoGghyQeEmpAEN6G0M/rFXNbMARoTL/KYnp4PkSGIYlRbTz87bU3aOQE
	r7+zzBXA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfQ-1xV5;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Yms-13LI;
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
Subject: [RFC PATCH 30/55] KVM: planes: Unwind published state on KVM_CREATE_PLANE failure
Date: Sat, 17 Oct 2026 13:24:36 +0100
Message-ID: <20261017122501.610248-31-dwmw2@infradead.org>
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

kvm_create_plane() publishes the new plane in kvm->planes[] and takes
the APICV_INHIBIT_REASON_PLANES inhibit before
kvm_vm_ioctl_create_plane() can still fail at anon_inode_getfile(),
and the error path freed the plane without unpublishing it: a VMM
retrying plane setup after such a failure wrote overlays through the
freed plane via KVM_SET_PLANE_MEMORY_OVERLAY, and VM teardown
destroyed the plane a second time. The VM also kept APICv inhibited
with no nonzero plane left to justify it.

Clear the kvm->planes[] slot before freeing, and drop the APICv
inhibit in kvm_arch_plane_destroy() when the last nonzero plane of a
live VM goes away (at VM teardown plane 0 is already gone, which skips
the update). Make the overlay ioctl read kvm->planes[] under
kvm->lock, which the create path holds across publish and unpublish,
so a plane pointer it observes stays valid until VM teardown; publish
with smp_store_release() for the remaining lock-free readers.

Found by Sashiko review.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c  | 32 ++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c | 25 ++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5122e6f42bd..afd668c6db3f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14003,7 +14003,39 @@ int kvm_arch_plane_init(struct kvm *kvm, struct kvm_plane *plane,
 
 void kvm_arch_plane_destroy(struct kvm_plane *plane)
 {
+	struct kvm *kvm = plane->kvm;
+	int i;
+
 	kvfree(rcu_dereference_check(plane->arch.apic_map, 1));
+
+	if (plane->level == 0)
+		return;
+
+	/*
+	 * Drop the APICv inhibit taken in kvm_arch_plane_init() when the
+	 * last nonzero plane goes away.  Only the KVM_CREATE_PLANE error
+	 * path destroys a nonzero plane while the VM is live; at VM
+	 * teardown plane 0 is destroyed first and kvm->planes[0] is
+	 * already NULL, which skips the update (the inhibit machinery
+	 * needs plane 0 and SRCU, both gone by then).
+	 */
+	if (!kvm->planes[0])
+		return;
+
+	/*
+	 * Reaching here means a nonzero plane died while the VM is live,
+	 * which only the KVM_CREATE_PLANE error path does - under
+	 * kvm->lock.  A future kvm_destroy_planes() reordered to tear
+	 * nonzero planes down before plane 0 would get here locklessly;
+	 * catch that instead of silently poking freed APICv state.
+	 */
+	lockdep_assert_held(&kvm->lock);
+
+	for (i = 1; i < KVM_MAX_PLANES; i++)
+		if (kvm->planes[i] && kvm->planes[i] != plane)
+			return;
+
+	kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_PLANES);
 }
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e021683c8a8..ae998cef3c36 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1259,7 +1259,12 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	if (kvm_arch_plane_init(kvm, plane, plane_level))
 		goto out_free_plane;
 
-	kvm->planes[plane_level] = plane;
+	/*
+	 * Pairs with the lock-free readers of kvm->planes[] (MSI delivery,
+	 * SEV VMPL targeting): the plane's fields must be visible before
+	 * the pointer is.
+	 */
+	smp_store_release(&kvm->planes[plane_level], plane);
 
 	return plane;
 
@@ -5915,8 +5920,15 @@ static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
 	return fd;
 
 put_kvm:
-	kvm_put_kvm(kvm);
+	/*
+	 * kvm_create_plane() published the plane; unpublish it before
+	 * freeing (kvm->lock is held throughout, so readers who take it
+	 * never observe the dead pointer) and so that VM teardown does
+	 * not destroy it a second time.
+	 */
+	kvm->planes[id] = NULL;
 	kvm_destroy_one_plane(plane);
+	kvm_put_kvm(kvm);
 put_fd:
 	put_unused_fd(fd);
 	return r;
@@ -6037,7 +6049,14 @@ static int kvm_vm_ioctl_set_plane_overlay(struct kvm *kvm,
 		return -EINVAL;
 	if (ov->uaddr & ~PAGE_MASK)
 		return -EINVAL;
-	plane = kvm->planes[ov->plane];
+	/*
+	 * Read under kvm->lock: KVM_CREATE_PLANE publishes and, on its
+	 * error path, unpublishes-and-frees the plane under that lock, so
+	 * a pointer observed here is either NULL or a plane that lives
+	 * until VM teardown.
+	 */
+	scoped_guard(mutex, &kvm->lock)
+		plane = kvm->planes[ov->plane];
 	if (!plane)
 		return -EINVAL;
 
-- 
2.50.1

