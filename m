Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0C494277;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=r/mZANWWihbYSu/ftvksPBuAwEPUe1JJd2kKnrT4Pc2bc6WLq9uYa0SlUCYrhYY1wkbjuc1dAZF2bTTA92Wv009vCohXp5o26prZZ/YvSaJlZepAwJFHYsshFlqC+POCL1a2R0ngej9GswGZUmwnv56QnpOSS1AW6xExq8xWkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=Sp9QhG2zvGm/87lgTfKNG36csrD6OLdvypZy3iohC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcrfA0c8V+UeArRlGl1h8RdkoeYdwum852QtdzYbRQX6Wy4WVDtBsZskCI02O7lcMZCXSV7LEbq56serNtJxIJNacJs7My06BlF3feNWO55HpnZXsSIxQvRv/pXAKE/BsJISeWzzyYpgGsPrSQ5dy45pClP3Pz2J7PhhA8OppX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdUcoph1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdUcoph1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=GiYB2tiV9bDGTn9TORkcTuW2eXqoZ0EusCpPtBqMd5c=; b=BdUcoph1voi3uwGHVH/hqDze2t
	n/Bw7jEzE2b1+IlyFrMQwJIdB7SdsVnP7uuoD/pYUXhtygRVfpi8I/zxhTxmGGTP5L2LmiQ2MCRfY
	haJidhs3+Q8foJUDPgtSyZEJiboOQ+QpUsRGQGZh7lNrkq3efVdPX4aoRxPsJco39XjaZje5TIUQr
	NF+Uxsr16GMUrCNA+hAYYNL/s0++4Gti9JlAHtNnLvZ+eacR20KaYQyxCOnmo6Qcfw/4q8sAhGJIO
	Burh8ENcH8qfkWskpJbYMZV+QggX08JC/DyR9ZLsFJ4JX+CKMAeF5bJim5Y0kzBu673C2PewsK3un
	I431DqFw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfI-1c7O;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Ylm-2DOV;
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
Subject: [RFC PATCH 15/55] KVM: x86: hyper-v: bank the reference TSC page per plane
Date: Sat, 17 Oct 2026 13:24:21 +0100
Message-ID: <20261017122501.610248-16-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

HV_X64_MSR_REFERENCE_TSC is a per-VTL instance like GUEST_OS_ID and
HYPERCALL. With a single partition-wide copy, the secure kernel
enabling its own reference TSC page from VTL1 invalidated VTL0's, and
the normal kernel fell back to a TIME_REF_COUNT MSR read — a VM exit —
on every clock read.

Keep the masterclock-maintained page bound to plane 0, and give
non-zero planes a banked MSR whose page gets a one-shot copy of the
current parameters; those stay valid while the masterclock is stable,
which is enough for VTL1's bounded execution windows.

The copy is made only when hv->tsc_ref is host-computed. With
HV_X64_MSR_TSC_EMULATION_CONTROL set (reenlightenment, restored across
migration), kvm_hv_setup_tsc_page() repopulates hv->tsc_ref from the
plane-0 page in guest RAM, which the lowest VTL can write; handing a
copy of that to a higher plane with hypervisor authority would let
VTL0 forge the sequence/scale/offset the secure kernel computes time
from. In that case write the plane's page with a zero sequence, making
it fall back to the TIME_REF_COUNT MSR. The reference VSM host keeps
fully separate per-VTL pages and never crosses VTLs here.

The copy uses the same zero-sequence/body/sequence protocol as the
plane-0 path, so a concurrent reader never sees torn parameters, and
the MSR write fails when the guest write faults, as the
HV_X64_MSR_HYPERCALL case does.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst  |  7 ++++
 arch/x86/include/asm/kvm_host.h |  8 +++++
 arch/x86/kvm/hyperv.c           | 58 ++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f8d9bca1baea..570db83844c7 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6611,6 +6611,13 @@ in the future may use the plane id when planes are supported by hardware (as is
 the case for VMPLs in AMD), or if KVM supports accelerated plane switch
 operations (as might be the case for Hyper-V VTLs).
 
+On x86, the Hyper-V partition-wide MSRs HV_X64_MSR_GUEST_OS_ID,
+HV_X64_MSR_HYPERCALL and HV_X64_MSR_REFERENCE_TSC are banked per plane,
+matching their per-VTL instances in the TLFS: an MSR access reads or
+writes the instance belonging to the plane of the vCPU fd that performs
+it.  A migrating VMM must therefore save and restore these MSRs through
+a vCPU fd of every plane, not just plane 0.
+
 4.146 KVM_GET_PLANE_RUN_STATE / KVM_SET_PLANE_RUN_STATE
 --------------------------------------------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1c4395f73acb..6ee85022cdfc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1211,6 +1211,8 @@ struct kvm_hv {
 	u64 hv_hypercall[KVM_MAX_PLANES];
 	bool hv_forward_hcalls;
 	u64 hv_tsc_page;
+	/* Banked REFERENCE_TSC MSR values for non-zero planes (VTLs). */
+	u64 hv_tsc_page_plane[KVM_MAX_PLANES];
 	enum hv_tsc_page_status hv_tsc_page_status;
 
 	/* Hyper-v based guest crash (NT kernel bugcheck) parameters */
@@ -1218,6 +1220,12 @@ struct kvm_hv {
 	u64 hv_crash_ctl;
 
 	struct ms_hyperv_tsc_page tsc_ref;
+	/*
+	 * tsc_ref was read back from the plane-0 page (guest TSC emulation
+	 * after migration) rather than computed by the host; such values
+	 * are plane-0-writable and must never seed another plane's page.
+	 */
+	bool tsc_ref_from_guest;
 
 	struct idr conn_to_evt;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e703d8999ff0..eefc18c750f1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1191,6 +1191,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 		if (kvm_read_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, sizeof(hv->tsc_ref)))
 			goto out_err;
 
+		hv->tsc_ref_from_guest = true;
 		hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
 		return;
 	}
@@ -1227,6 +1228,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 			    &hv->tsc_ref, sizeof(hv->tsc_ref.tsc_sequence)))
 		goto out_err;
 
+	hv->tsc_ref_from_guest = false;
 	hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
 	return;
 
@@ -1432,6 +1434,58 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		break;
 	}
 	case HV_X64_MSR_REFERENCE_TSC:
+		/*
+		 * The reference TSC page is a per-VTL instance.  Plane 0 keeps
+		 * the live masterclock-maintained page; a non-zero plane gets
+		 * a one-shot copy of the current parameters, which stay valid
+		 * while the masterclock is stable.
+		 */
+		if (vcpu->plane_level) {
+			struct ms_hyperv_tsc_page tsc_ref = {};
+			u32 tsc_seq;
+			u64 gfn;
+
+			hv->hv_tsc_page_plane[vcpu->plane_level] = data;
+			if (!(data & HV_X64_MSR_TSC_REFERENCE_ENABLE))
+				break;
+
+			/*
+			 * Copy only host-computed parameters.  After a
+			 * masterclock change under guest TSC emulation,
+			 * hv->tsc_ref holds values read back from the
+			 * plane-0 page, which the lowest VTL can write;
+			 * presenting those to another plane would let it
+			 * forge that plane's clock.  Without usable
+			 * parameters, publish an invalid (zero) sequence so
+			 * the plane falls back to the TIME_REF_COUNT MSR.
+			 */
+			if (hv->hv_tsc_page_status == HV_TSC_PAGE_SET &&
+			    !hv->tsc_ref_from_guest)
+				tsc_ref = hv->tsc_ref;
+
+			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+			tsc_seq = tsc_ref.tsc_sequence;
+
+			/*
+			 * Write the body under a zero sequence, then the
+			 * real sequence, so a concurrent reader on this
+			 * plane never consumes torn parameters.
+			 */
+			tsc_ref.tsc_sequence = 0;
+			if (kvm_vcpu_write_guest(vcpu, gfn_to_gpa(gfn),
+						 &tsc_ref, sizeof(tsc_ref)))
+				return 1;
+
+			if (!tsc_seq)
+				break;
+
+			tsc_ref.tsc_sequence = tsc_seq;
+			if (kvm_vcpu_write_guest(vcpu, gfn_to_gpa(gfn),
+						 &tsc_ref,
+						 sizeof(tsc_ref.tsc_sequence)))
+				return 1;
+			break;
+		}
 		hv->hv_tsc_page = data;
 		if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE) {
 			if (!host)
@@ -1650,7 +1704,9 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = get_time_ref_counter(kvm);
 		break;
 	case HV_X64_MSR_REFERENCE_TSC:
-		data = hv->hv_tsc_page;
+		data = vcpu->plane_level ?
+		       hv->hv_tsc_page_plane[vcpu->plane_level] :
+		       hv->hv_tsc_page;
 		break;
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 		return kvm_hv_msr_get_crash_data(kvm,
-- 
2.50.1

