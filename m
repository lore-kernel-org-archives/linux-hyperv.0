Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EF43F8CB;
	Mon,  5 Oct 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228364; cv=none; b=EDClCqj+vNVz4VHQ3XoVzh2en56kuoHXjM2IuYpVYJWwn6npIbyVLms/rF82u6Wm+oxNGXp8WdtZ5o+gmuCWj93oWHIyIYHPNI6WCLfugBdk6XFMNj+Jmrbce1wwiXTzRsS2Kaw4gThenwwNdjYiD9pbEfBEMh0MDRI+frGAgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228364; c=relaxed/simple;
	bh=cBrQXK4QKOFSUr6CGzzvROOHVgDdiVSnHERQy2hc7Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbP8FioOegHIdqwTCIg6+FmfEfiaemMZowIl3Qh6BEWGRyP61+WobyvvbZYUWTVq80pN3s1nWebePNC7Z1rdrs1Ssw7vZodUN54PRnKEBsHdsqwPnAfz4TVADMwGssrseHSR5gIkcLMTmFEe1ZAlcMqQIRfaL/nl0zibX8KPrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=LOno1FsF; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="LOno1FsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791228362; x=1822764362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMT9hxBTDnR3LlDP5I6HWvIconDCO7HqoR7QsXqlotg=;
  b=LOno1FsFtvPBFv2UcpaqwaBg7YmQNWRehI8OetFBELr7n3WKMt73Trw4
   B7DB7L3Cpsi6jp1hp+TjOPAUsJOYIDv38+k9kWfItIpy2KAvpwDo87aVW
   AsKVIIQbu22J+/Gujd4iW95l6dljuFHaKFvFucoNI552UIGs/OKHx3OyM
   chpxnM9HKr/PqLK4s5/slxbn6FhpQqFeUq2dOaq2/xB+puXUJAhshrMHr
   aaYs2DDoYFAN9HgJyQq/AF4kKhV9sGjsd2aDUWs4kWPUJ95cf0/YnHBQ5
   hbxf1OwsJaqyQ/tMR74u6a+Jp3Bjw0BLWD61zxhE9XIInSBKOshCD+U/H
   w==;
X-CSE-ConnectionGUID: h7Xv/HaSRsq1EW265FPgWQ==
X-CSE-MsgGUID: M7t6NUMYQ++KYYfjdvRDcA==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="30249898"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:26:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:10559]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.83:2525] with esmtp (Farcaster)
 id bd43f895-ff64-4101-a4d3-d1c01b0b4f03; Mon, 5 Oct 2026 19:25:59 +0000 (UTC)
X-Farcaster-Flow-ID: bd43f895-ff64-4101-a4d3-d1c01b0b4f03
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:25:59 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:25:57 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<mushi.shar@gmail.com>
Subject: [PATCH 3/3] KVM: x86: hyper-v: Implement HvCallRestorePartitionTime
Date: Mon, 5 Oct 2026 19:24:31 +0000
Message-ID: <20261005192431.87317-4-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005192431.87317-1-hmushi@amazon.co.uk>
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A nested Hyper-V that sees the frequency MSRs lets its parent own
the partition reference time. After a resume from hibernation it
issues HvCallRestorePartitionTime (0x103) with the TSC and the
reference counter it saved, and expects both clocks to continue
from there. KVM rejected the hypercall. The guest time base stayed
inconsistent and the root partition did not run.

Restore both clocks in one pvclock update, so no vCPU runs with the
new TSC and the old reference time. Each vCPU computes and writes its
own TSC offset from the recorded step, so no other vCPU writes its
TSC state. kvm_synchronize_tsc() writes the offset of the calling
vCPU only. Mark the TSC page as changed by the guest, so it is
recomputed even when TSC emulation control is set.

The TLFS marks the hypercall, its input and CPUID 0x40000004 EAX
bit 20 (RestoreTimeOnResume) as reserved. Microsoft's hvdef crate
defines them (hypercall::RestorePartitionTime), and Microsoft's
OHCL kernel carries the same C definitions in hvgdk_mini.h.

Advertise bit 20 and gate the hypercall on it under
KVM_CAP_HYPERV_ENFORCE_CPUID. Hyper-V offers hibernation to its root
partition only when the parent sets this bit.

Assisted-by: Claude:claude-fable-5.1
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  5 ++
 arch/x86/kvm/hyperv.c           | 36 ++++++++++++
 arch/x86/kvm/x86.c              | 99 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.h              |  1 +
 include/hyperv/hvgdk_mini.h     | 12 ++++
 5 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd35..e97ff631196f8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -127,6 +127,7 @@
 	KVM_ARCH_REQ_FLAGS(33, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
+#define KVM_REQ_WRITE_TSC_OFFSET	KVM_ARCH_REQ(35)
 
 #define INVALID_PAGE (~(hpa_t)0)
 #define VALID_PAGE(x) ((x) != INVALID_PAGE)
@@ -1246,6 +1247,10 @@ struct kvm_arch {
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	int nr_vcpus_matched_tsc;
+	/* TSC step requested by the guest; each vCPU applies it. */
+	u64 restore_host_tsc;
+	u64 restore_guest_tsc;
+	u64 restore_tsc_nsec;
 
 	u32 default_tsc_khz;
 	bool user_set_tsc;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c9520..923373dee0e4f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2538,6 +2538,9 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	case HVCALL_SEND_IPI:
 		return hv_vcpu->cpuid_cache.enlightenments_eax &
 			HV_X64_CLUSTER_IPI_RECOMMENDED;
+	case HVCALL_RESTORE_PARTITION_TIME:
+		return hv_vcpu->cpuid_cache.enlightenments_eax &
+			HV_X64_RESTORE_TIME_ON_RESUME;
 	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
 		return hv_vcpu->cpuid_cache.features_ebx &
 			HV_ENABLE_EXTENDED_HYPERCALLS;
@@ -2548,6 +2551,31 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	return true;
 }
 
+static u64 kvm_hv_restore_partition_time(struct kvm_vcpu *vcpu,
+					 struct kvm_hv_hcall *hc)
+{
+	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
+	struct hv_input_restore_partition_time in;
+
+	BUILD_BUG_ON(sizeof(in) != 32);
+
+	if (kvm_vcpu_read_guest(vcpu, hc->ingpa, &in, sizeof(in)))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	if (in.reserved)
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	if (in.partition_id != HV_PARTITION_ID_SELF)
+		return HV_STATUS_INVALID_PARTITION_ID;
+
+	/* The guest asked for the step; recompute the TSC page as for its own write. */
+	mutex_lock(&hv->hv_lock);
+	if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE)
+		hv->hv_tsc_page_status = HV_TSC_PAGE_GUEST_CHANGED;
+	mutex_unlock(&hv->hv_lock);
+
+	kvm_set_clock_and_tsc(vcpu->kvm, in.reference_time_in_100ns * 100, in.tsc);
+	return HV_STATUS_SUCCESS;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -2670,6 +2698,13 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		}
 		ret = kvm_hv_send_ipi(vcpu, &hc);
 		break;
+	case HVCALL_RESTORE_PARTITION_TIME:
+		if (unlikely(hc.fast || hc.rep || hc.var_cnt)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_restore_partition_time(vcpu, &hc);
+		break;
 	case HVCALL_POST_DEBUG_DATA:
 	case HVCALL_RETRIEVE_DEBUG_DATA:
 		if (unlikely(hc.fast)) {
@@ -2889,6 +2924,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 				ent->eax |= HV_X64_NO_NONARCH_CORESHARING;
 
 			ent->eax |= HV_DEPRECATING_AEOI_RECOMMENDED;
+			ent->eax |= HV_X64_RESTORE_TIME_ON_RESUME;
 			/*
 			 * Default number of spinlock retry attempts, matches
 			 * HyperV 2016.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19666a80240a5..c0865468b02e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4354,13 +4354,85 @@ static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
 	return 0;
 }
 
-static void __kvm_set_clock(struct kvm *kvm, struct kvm_clock_data *data)
+/* Must precede pvclock_update_vm_gtod_copy(), which reads the matched count. */
+static void kvm_open_tsc_generation(struct kvm *kvm, u64 guest_tsc)
 {
 	struct kvm_arch *ka = &kvm->arch;
-	u64 now_raw_ns;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	lockdep_assert_held(&ka->tsc_write_lock);
+
+	ka->cur_tsc_generation++;
+	ka->cur_tsc_write = guest_tsc;
+	ka->last_tsc_write = guest_tsc;
+	ka->nr_vcpus_matched_tsc = atomic_read(&kvm->online_vcpus) - 1;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.guest_tsc_protected)
+			continue;
+		ka->last_tsc_khz = vcpu->arch.virtual_tsc_khz;
+		ka->last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
+		break;
+	}
+}
+
+/* Every vCPU reads @guest_tsc at host TSC @host_tsc. */
+static void kvm_set_tsc_generation(struct kvm *kvm, u64 host_tsc,
+				   u64 guest_tsc, u64 ns)
+{
+	struct kvm_arch *ka = &kvm->arch;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	lockdep_assert_held(&ka->tsc_write_lock);
+
+	ka->cur_tsc_nsec = ns;
+	ka->last_tsc_nsec = ns;
+	ka->restore_host_tsc = host_tsc;
+	ka->restore_guest_tsc = guest_tsc;
+	ka->restore_tsc_nsec = ns;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.guest_tsc_protected)
+			continue;
+
+		ka->cur_tsc_offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc,
+							       guest_tsc);
+		ka->last_tsc_offset = ka->cur_tsc_offset;
+		kvm_make_request(KVM_REQ_WRITE_TSC_OFFSET, vcpu);
+	}
+}
+
+/* Runs on the vCPU; only the owner writes its TSC offset. */
+static void kvm_vcpu_apply_tsc_generation(struct kvm_vcpu *vcpu)
+{
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+	unsigned long flags;
+	u64 offset;
+
+	raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
+	offset = kvm_compute_l1_tsc_offset(vcpu, ka->restore_host_tsc,
+					   ka->restore_guest_tsc);
+	vcpu->arch.last_guest_tsc = ka->restore_guest_tsc;
+	vcpu->arch.this_tsc_generation = ka->cur_tsc_generation;
+	vcpu->arch.this_tsc_nsec = ka->restore_tsc_nsec;
+	vcpu->arch.this_tsc_write = ka->restore_guest_tsc;
+	raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
+
+	kvm_vcpu_write_tsc_offset(vcpu, offset);
+}
+
+static void __kvm_set_clock(struct kvm *kvm, struct kvm_clock_data *data,
+			    const u64 *guest_tsc)
+{
+	struct kvm_arch *ka = &kvm->arch;
+	u64 host_tsc, now_raw_ns;
 
 	kvm_hv_request_tsc_page_update(kvm);
 	kvm_start_pvclock_update(kvm);
+	if (guest_tsc)
+		kvm_open_tsc_generation(kvm, *guest_tsc);
 	pvclock_update_vm_gtod_copy(kvm);
 
 	/*
@@ -4380,14 +4452,29 @@ static void __kvm_set_clock(struct kvm *kvm, struct kvm_clock_data *data)
 			data->clock += now_real_ns - data->realtime;
 	}
 
-	if (ka->use_master_clock)
+	if (ka->use_master_clock) {
 		now_raw_ns = ka->master_kernel_ns;
-	else
+		host_tsc = ka->master_cycle_now;
+	} else {
+		host_tsc = rdtsc();
 		now_raw_ns = get_kvmclock_base_ns();
+	}
 	ka->kvmclock_offset = data->clock - now_raw_ns;
+
+	if (guest_tsc)
+		kvm_set_tsc_generation(kvm, host_tsc, *guest_tsc, now_raw_ns);
+
 	kvm_end_pvclock_update(kvm);
 }
 
+/* Step kvmclock to @ns and the guest TSC on every vCPU to @guest_tsc. */
+void kvm_set_clock_and_tsc(struct kvm *kvm, u64 ns, u64 guest_tsc)
+{
+	struct kvm_clock_data data = { .clock = ns };
+
+	__kvm_set_clock(kvm, &data, &guest_tsc);
+}
+
 static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_clock_data data;
@@ -4402,7 +4489,7 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 	if (data.flags & ~KVM_CLOCK_VALID_FLAGS)
 		return -EINVAL;
 
-	__kvm_set_clock(kvm, &data);
+	__kvm_set_clock(kvm, &data, NULL);
 	return 0;
 }
 
@@ -8168,6 +8255,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_update_masterclock(vcpu->kvm);
 		if (kvm_check_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu))
 			kvm_gen_kvmclock_update(vcpu);
+		if (kvm_check_request(KVM_REQ_WRITE_TSC_OFFSET, vcpu))
+			kvm_vcpu_apply_tsc_generation(vcpu);
 		if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu)) {
 			r = kvm_guest_time_update(vcpu);
 			if (unlikely(r))
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 436e2fb1396c4..e26ca67ac7219 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -326,6 +326,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 u64 get_kvmclock_ns(struct kvm *kvm);
+void kvm_set_clock_and_tsc(struct kvm *kvm, u64 ns, u64 guest_tsc);
 uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 int kvm_guest_time_update(struct kvm_vcpu *v);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570fd..87dfb0aed827e 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -343,6 +343,8 @@ union hv_hypervisor_version_info {
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
 #define HV_X64_HYPERV_NESTED				BIT(12)
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
+/* Reserved in the TLFS; from Microsoft's hvdef. */
+#define HV_X64_RESTORE_TIME_ON_RESUME			BIT(20)
 #define HV_X64_USE_MMIO_HYPERCALLS			BIT(21)
 
 /*
@@ -499,6 +501,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_SET_VP_STATE				0x00e4
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
+#define HVCALL_RESTORE_PARTITION_TIME			0x0103
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
 #define HVCALL_DISABLE_HYP_EX                           0x010f
@@ -1514,6 +1517,15 @@ union hv_intercept_parameters {
 	/* N.B. Other intercept types do not have any parameters. */
 };
 
+/* HVCALL_RESTORE_PARTITION_TIME input. Layout from Microsoft's hvdef. */
+struct hv_input_restore_partition_time {
+	u64 partition_id;
+	u32 tsc_sequence;
+	u32 reserved;
+	u64 reference_time_in_100ns;
+	u64 tsc;
+} __packed;
+
 /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
 #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
 
-- 
2.47.3

