Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4E486436;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239908; cv=none; b=h49B89sOBu9M0LVTkHms2d2N6FGhRVLl6YJZ0iX0u7/eOVSVXdHv1LLlGdoiLkM2C6OttcwhSirL9qqWeoyFA+ny0IXyc0bfFziGzyKQcU4X/iMXMBmd1q6Tgw5/XBUbYn/KJ0VPloeUup2QFvE1XMKl7ghGHh7lPSqbOOx3cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239908; c=relaxed/simple;
	bh=2uoQbAv+DaXiGxQeRUkZhozEiJhK+pbBFfAOP/l7NZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOOaRryrJcoi611HSRw1HoiBqb/iJwfa1xwOkTTOm8uGp9dOdRcYpH6tcvJQJbIRWNzEujK7xY4pDaQfPpnwFNe6qvMtb7/Tlzsnc68nxnr2Ioruzauu93/ZpqRVqD5vmhYCqp+Mmt5D86HhpkkKL/nfoNMm51lDqe7TN2Mavd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LLbgP3g/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLbgP3g/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=xWwOOO3NhypbaWB+e7snQOOTSSNKnh3+oRDenoBzvnU=; b=LLbgP3g/YuNKOobbtH6PdM8rO7
	3cDaG3LpOfs+xhxa7OIWMhY5waKJI6Rgfh5VWuGaez4pKV/atdHSqK8QEmVmoua9pO5JOd1V91T2M
	DTJdf2NTy50couFwVcV/A/k0vx8IUIGx+V8bFxOo9ZA7oP6dfcxEOQp2rfaZ46ZtrcGwnRzvi9h1d
	Y10ZKW1S6sm2k9fpOSictqvh24HyAZ+9RSMy48GHnEZrY+b1vxSxyyO8xDvDWLBswYfAMRap+hAWq
	zyB+LeOmXQ+aKnYZBgN1Vvt2CT3F49XNEo5s0pI0+JfiI6M1o6N7rU3gEEcI0C/+ZzAPAj+OA88pV
	NhPNONsg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCD-1SBO;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlG-0eNO;
	Sat, 17 Oct 2026 13:25:02 +0100
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
Subject: [RFC PATCH 07/55] KVM: Add KVM_GET/SET_PLANE_RUN_STATE vCPU ioctls
Date: Sat, 17 Oct 2026 13:24:13 +0100
Message-ID: <20261017122501.610248-8-dwmw2@infradead.org>
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

A VMM doing VSM in userspace has to switch the executing plane when
the guest asks for a privilege transition, but a vCPU's plane run
state is kernel-internal — set only by the SEV-SNP VMPL switch,
plane-0 event delivery, and vCPU creation. A VTL call forwarded to
userspace is a dead end.

Add ioctls to read and write the run state as stopped/runnable.
KVM_RUN already executes the lowest-numbered runnable plane, so a
userspace plane switch is just: mark the target plane's vCPU runnable,
mark the current one stopped, re-enter KVM_RUN.

A plane 0 stopped this way *stays* stopped. Forcing it runnable on a
pending event fits the SEV-SNP model, but under a userspace privilege
model plane 0 would preempt the higher VTL on any interrupt and resume
mid-hypercall with whatever completion value the shared kvm_run last
held; the events stay pending until the VMM switches back. In-kernel
transitions never set the stopped-by-userspace flag, so SNP behaviour
is unchanged.

The ioctls return -EINVAL unless kvm_arch_max_planes() reports plane
support, the same condition KVM_CREATE_PLANE enforces: only x86
consumes KVM_REQ_PLANE_RESCHED, and on the other architectures a stray
request bit would abort every subsequent entry attempt, leaving KVM_RUN
spinning at 100% with no way for the VMM to recover the vCPU.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst | 26 ++++++++++++++++++++
 arch/x86/kvm/x86.c             |  3 ++-
 include/linux/kvm_host.h       |  6 +++++
 include/uapi/linux/kvm.h       |  4 ++++
 virt/kvm/kvm_main.c            | 44 ++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ade8c91ef24b..f8d9bca1baea 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6611,6 +6611,32 @@ in the future may use the plane id when planes are supported by hardware (as is
 the case for VMPLs in AMD), or if KVM supports accelerated plane switch
 operations (as might be the case for Hyper-V VTLs).
 
+4.146 KVM_GET_PLANE_RUN_STATE / KVM_SET_PLANE_RUN_STATE
+--------------------------------------------------------
+
+:Capability: KVM_CAP_PLANES
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: pointer to a __u32 run state
+:Returns: 0 on success, <0 on error
+
+Reads or sets the per-plane run state of a vCPU:
+KVM_PLANE_RUN_STATE_STOPPED (0) or KVM_PLANE_RUN_STATE_RUNNABLE (1).
+
+When a vCPU thread calls KVM_RUN, KVM executes the lowest-numbered plane
+whose vCPU is runnable, falling back to plane 0.  A VMM implementing a
+software privilege model (such as Hyper-V VSM) switches planes by
+marking the target plane's vCPU runnable and the current one stopped
+before re-entering KVM_RUN.  Pending events for plane 0 make it runnable
+again on their own only as long as userspace has not explicitly stopped
+it with this ioctl; a VMM-stopped plane 0 keeps its events pending until
+the VMM makes it runnable, so a software privilege model can keep a
+higher plane running undisturbed.  The ioctl is accepted on any plane's
+vCPU fd.
+
+The run state is distinct from KVM_GET/SET_MP_STATE, which describes
+the architectural state of a vCPU within its plane.
+
 5. The kvm_run structure
 ========================
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8de596e00441..ca5d8e081fdc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11508,7 +11508,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (kvm_check_plane0_events(vcpu)) {
+	if (kvm_check_plane0_events(vcpu) &&
+	    !vcpu->common->vcpus[0]->plane_user_stopped) {
 		kvm_vcpu_set_plane_runnable(vcpu->common->vcpus[0]);
 
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7ed79479b4a1..5bdae2127578 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -413,6 +413,12 @@ struct kvm_vcpu {
 
 	u64 plane_requests;
 	enum kvm_vcpu_state plane_state;
+	/*
+	 * Set when userspace stopped this plane with
+	 * KVM_SET_PLANE_RUN_STATE: pending plane-0 events then no longer
+	 * make plane 0 runnable on their own, the VMM owns the switch.
+	 */
+	bool plane_user_stopped;
 
 	/* S390 only */
 	bool valid_wakeup;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5567cf352907..2aeb8c5172cb 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1371,6 +1371,10 @@ struct kvm_s390_keyop {
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
 #define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
+#define KVM_GET_PLANE_RUN_STATE	  _IOR(KVMIO, 0xe5, __u32)
+#define KVM_SET_PLANE_RUN_STATE	  _IOW(KVMIO, 0xe6, __u32)
+#define   KVM_PLANE_RUN_STATE_STOPPED	0
+#define   KVM_PLANE_RUN_STATE_RUNNABLE	1
 
 /*
  * ioctls for vcpu fds
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c8b0722ac35c..2d2dc7828e1f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4788,6 +4788,8 @@ static inline bool kvm_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_GET_SREGS:
 	case KVM_SET_SREGS:
 	case KVM_TRANSLATE:
+	case KVM_GET_PLANE_RUN_STATE:
+	case KVM_SET_PLANE_RUN_STATE:
 		return true;
 	default:
 		return kvm_arch_is_vcpu_plane_ioctl(ioctl);
@@ -4928,6 +4930,48 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
 		break;
 	}
+	case KVM_GET_PLANE_RUN_STATE: {
+		u32 state = vcpu->plane_state == RUNNABLE ?
+			    KVM_PLANE_RUN_STATE_RUNNABLE :
+			    KVM_PLANE_RUN_STATE_STOPPED;
+
+		r = -EINVAL;
+		if (kvm_arch_max_planes(vcpu->kvm) <= 1)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user(argp, &state, sizeof(state)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_SET_PLANE_RUN_STATE: {
+		u32 state;
+
+		/*
+		 * KVM_SET_PLANE_RUN_STATE raises KVM_REQ_PLANE_RESCHED,
+		 * which only plane-aware architecture code consumes; on a
+		 * planes-less VM the stuck request would abort every guest
+		 * entry and spin KVM_RUN at 100%.
+		 */
+		r = -EINVAL;
+		if (kvm_arch_max_planes(vcpu->kvm) <= 1)
+			goto out;
+		r = -EFAULT;
+		if (copy_from_user(&state, argp, sizeof(state)))
+			goto out;
+		r = -EINVAL;
+		if (state > KVM_PLANE_RUN_STATE_RUNNABLE)
+			goto out;
+		if (state == KVM_PLANE_RUN_STATE_RUNNABLE) {
+			vcpu->plane_user_stopped = false;
+			kvm_vcpu_set_plane_runnable(vcpu);
+		} else {
+			vcpu->plane_user_stopped = true;
+			kvm_vcpu_set_plane_stopped(vcpu);
+		}
+		r = 0;
+		break;
+	}
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
-- 
2.50.1

