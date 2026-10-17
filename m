Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67D49BB5E;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239917; cv=none; b=eZhyZC4I62MMSZHOZU2mz3Y2A3B0WnIqG1MpbdiKGRHuPqivMDPY2sCpI9m7S8itAkp5I0fpxsQuOtkv75/iQJk4YNjhiZ0DPKNPtiv87aCqJcLl+wQ0ICIypYcnbFHbFuYfQ1rzgP/3OnUj2b+Szxegk13DE1SnU9CneAJWY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239917; c=relaxed/simple;
	bh=8dHDkYl4pvzcEHqywdJwvq3wSDzm1EVyT7972O+DpEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J42UaguoZ1US4E0b/o0jH13xZ/qRnxtzqX/C8ASXSqzEWRu0Vm/Semjy/V60aiIH0G+PjvOniksg5dPP77arOyrlUcMnsNSDkqXB0ekRtEEbtpsbo9zbYdPHuPKfTTzoCKWz7+9NxyfwTkyTDittpmR/frL/jhSELeET8h50AYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X07MoKV9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X07MoKV9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vTY+MmDWBfuu+ZZ765xgJwxV4ddQ/XQCQUMyD6Z95L0=; b=X07MoKV9IunB+zQC/nq32vx8iC
	2/R4EyXRIenptqGgDxilTf7pFIfrLyxgs28A0iDg/BKi4SgXX8zNFSw1YnI1YHtOtPz4e4qOd6k89
	pl3A/dBt3bLQjtesItWIlZzgwJDP99nGq0W2/aio9zp9AjMLEWlgaev2P0FC6SW9UzbwOA76Xbn+g
	EsAQCXnuSeQtBMuV9rvDgmQK//ldipKGeVmBTBhGr3uMLwgYcoB++kK2NR6oDGUGrLA12YjwuPMHk
	HwV6SFRWP4tFrTMb/UmmCX+9P+FUFYHWY9pG15hcX7r4zmDalYIYdIoNXMi9FYQZ8/zzPS35kCTmn
	ExA4zAvQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfR-1xxz;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Yn2-1PIG;
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
Subject: [RFC PATCH 32/55] KVM: planes: Keep current_vcpu in sync in vcpu_load()
Date: Sat, 17 Oct 2026 13:24:38 +0100
Message-ID: <20261017122501.610248-33-dwmw2@infradead.org>
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

The preempt notifiers save and restore common->current_vcpu
(kvm_sched_out()/kvm_sched_in()), but vcpu_load() does not update it.
kvm_vcpu_ioctl_set_cpuid() swaps the loaded vCPU to each twin around
kvm_vcpu_after_set_cpuid(), a window that is preemptible and sleeps
(kvm_pmu_refresh, mmu_lock): a reschedule there arch-put the
already-put caller a second time, never saved the twin, and reloaded
the caller's VMCS, so the vendor callback wrote the twin's controls
into the caller's VMCS and the trailing vcpu_put() unloaded a
non-resident vCPU, corrupting the per-pCPU loaded_vmcs tracking. Any
KVM_SET_CPUID2 on a multi-plane VM reaches this; ioctls taken on a
plane-N fd while current_vcpu pointed at another plane had the same
exposure, as do the kick paths that now read current_vcpu->cpu.

Set common->current_vcpu in vcpu_load(), making every load path (run
loop, vcpu ioctls, the cpuid twin swap) agree with what the preempt
notifiers will operate on. kvm_vcpu_select_plane() keeps its own
assignment; both stores use WRITE_ONCE to pair with the lock-free
readers in the kick paths.

Found by Sashiko review.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 virt/kvm/kvm_main.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fa639a659138..d37961cc5235 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -165,6 +165,16 @@ void vcpu_load(struct kvm_vcpu *vcpu)
 {
 	int cpu = get_cpu();
 
+	/*
+	 * The preempt notifiers operate on common->current_vcpu, so it
+	 * must name the plane vCPU being loaded here: an ioctl taken on
+	 * another plane's fd than the one that ran last would otherwise
+	 * have a preemption arch-put the stale twin (whose state is not
+	 * resident) and arch-load it back over the state this load makes
+	 * resident.  The kick paths also read it to find the running
+	 * twin's pCPU.
+	 */
+	WRITE_ONCE(vcpu->common->current_vcpu, vcpu);
 	__this_cpu_write(kvm_running_vcpu, vcpu->common);
 	preempt_notifier_register(&vcpu->common->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -4719,7 +4729,26 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id
 
 	kvm_vcpu_init(vcpu, kvm, id);
 
+	/*
+	 * A non-zero plane shares 'common' with a plane-0 twin which may
+	 * already be running.  kvm_arch_vcpu_create() calls vcpu_load(),
+	 * which publishes the half-created vCPU through
+	 * common->current_vcpu and registers the shared preempt notifier,
+	 * so it must not run concurrently with a twin's KVM_RUN: hold the
+	 * shared vCPU mutex across it.  Drop it before kvm->lock is taken
+	 * below, to respect the kvm->lock -> vcpu mutex ordering.
+	 */
+	if (plane->level > 0) {
+		r = mutex_lock_killable(kvm_vcpu_mutex(vcpu));
+		if (r)
+			goto vcpu_free_common;
+	}
+
 	r = kvm_arch_vcpu_create(vcpu);
+
+	if (plane->level > 0)
+		kvm_vcpu_unlock(vcpu);
+
 	if (r)
 		goto vcpu_free_common;
 
@@ -5427,7 +5456,7 @@ struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
 		ret->plane_state = RUNNABLE;
 	}
 
-	common->current_vcpu = ret;
+	WRITE_ONCE(common->current_vcpu, ret);
 
 	common->plane_switch = false;
 
-- 
2.50.1

