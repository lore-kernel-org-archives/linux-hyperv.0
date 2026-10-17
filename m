Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C14848BF;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239910; cv=none; b=FgaCjX1bEdTro5i/bdaDeOCw26ojWbqvZkWu8lhT2/WDbwVByAmr7Zu0UsG0qJi9bxqpSCwaIJ/X6F9B+oWDv5Xs2AR1pvDVrNsafQEKBpXhoqVWw1ItBCnC4xBlI1DhT4ePIBGNO2i6R88UmtRurwF3z7809UHk1MZMePMJ+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239910; c=relaxed/simple;
	bh=sD+mNkP0EB9XGx/nsHy5n+3PkW1HibJX7qHgCE1y/ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0XQxoHnBTDWrsZEsYED7Hxhf8pmcYOSmGlw+9l8VkW2hgZB8SV6qtMWegN2wG5jLm1GYhztAC+Um/cM5UtexA2OkJHGT3dONZp+mTyA4ChpD5Df+QR5pczLBmN5H21v2AEuH1q3GlsZnzKkFMnXZNtmkijdzZHLvxiwuzuEyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDU6p1WH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDU6p1WH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PwE5ugS2tk/+KDRHoz5g/Y2E89F9eb6TcRkV5vY61cY=; b=HDU6p1WHif1kDxFsv2MpMeRb75
	IMi7n78ehA19y2IWP0Okv4OpLY8FU4SyMu8EZEgyjOiPmz2KT+lzqkR6JeD+fO/NfyivHOvILRV/T
	i0wTxbpbM0d4fTNW2qF8Q3f/iGnX8u+1lFlUT1iyk1YAZUqJ+qPRBsYgTi/zTf+pmgid1blyUB1FL
	7r7Z2QwdX3gvc4fu680XHO1IKeYU8hUwF1sZhX0LjyzFTPd7cswr4yL7s3fksH6SNzq7Foz+ptxhI
	onqRE3yZcd9oWwTDzjaNtul4Bk8zUWxt/03tLOvf3GlhsYXOWxTsNRQq1kDVODMVAqXR32C7ik9+f
	4m76zAPQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCK-3d4I;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Yli-23MT;
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
Subject: [RFC PATCH 14/55] KVM: x86: hyper-v: bank GUEST_OS_ID and HYPERCALL MSRs per plane
Date: Sat, 17 Oct 2026 13:24:20 +0100
Message-ID: <20261017122501.610248-15-dwmw2@infradead.org>
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

The TLFS makes HV_X64_MSR_GUEST_OS_ID and HV_X64_MSR_HYPERCALL
separate instances per VTL; KVM kept a single partition-wide copy, so
the Windows secure kernel enabling its own hypercall page from VTL1
clobbered VTL0's.

Index both MSRs by the vCPU's plane. The hypercall page contents are
still written into guest RAM on enable, now once per plane's page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |  9 +++++++--
 arch/x86/kvm/hyperv.c           | 19 ++++++++++---------
 arch/x86/kvm/hyperv.h           |  3 ++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17dfd232ba58..1c4395f73acb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1202,8 +1202,13 @@ enum hv_tsc_page_status {
 /* Hyper-V emulation context */
 struct kvm_hv {
 	struct mutex hv_lock;
-	u64 hv_guest_os_id;
-	u64 hv_hypercall;
+	/*
+	 * GUEST_OS_ID and the hypercall page are per-VTL instances in the
+	 * TLFS; bank them per plane so a higher VTL enabling its own
+	 * hypercall page does not clobber the lower VTL's.
+	 */
+	u64 hv_guest_os_id[KVM_MAX_PLANES];
+	u64 hv_hypercall[KVM_MAX_PLANES];
 	bool hv_forward_hcalls;
 	u64 hv_tsc_page;
 	enum hv_tsc_page_status hv_tsc_page_status;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e41d101e327a..e703d8999ff0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1342,7 +1342,7 @@ static void __kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu)
 	if (hv->xsaves_xsavec_checked)
 		return;
 
-	if ((hv->hv_guest_os_id & KVM_HV_WIN2016_GUEST_ID_MASK) !=
+	if ((hv->hv_guest_os_id[0] & KVM_HV_WIN2016_GUEST_ID_MASK) !=
 	    KVM_HV_WIN2016_GUEST_ID)
 		return;
 
@@ -1384,10 +1384,11 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 
 	switch (msr) {
 	case HV_X64_MSR_GUEST_OS_ID:
-		hv->hv_guest_os_id = data;
+		hv->hv_guest_os_id[vcpu->plane_level] = data;
 		/* setting guest os id to zero disables hypercall page */
-		if (!hv->hv_guest_os_id)
-			hv->hv_hypercall &= ~HV_X64_MSR_HYPERCALL_ENABLE;
+		if (!hv->hv_guest_os_id[vcpu->plane_level])
+			hv->hv_hypercall[vcpu->plane_level] &=
+				~HV_X64_MSR_HYPERCALL_ENABLE;
 		break;
 	case HV_X64_MSR_HYPERCALL: {
 		u8 instructions[9];
@@ -1395,10 +1396,10 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		u64 addr;
 
 		/* if guest os id is not set hypercall should remain disabled */
-		if (!hv->hv_guest_os_id)
+		if (!hv->hv_guest_os_id[vcpu->plane_level])
 			break;
 		if (!(data & HV_X64_MSR_HYPERCALL_ENABLE)) {
-			hv->hv_hypercall = data;
+			hv->hv_hypercall[vcpu->plane_level] = data;
 			break;
 		}
 
@@ -1427,7 +1428,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		addr = data & HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK;
 		if (kvm_vcpu_write_guest(vcpu, addr, instructions, i))
 			return 1;
-		hv->hv_hypercall = data;
+		hv->hv_hypercall[vcpu->plane_level] = data;
 		break;
 	}
 	case HV_X64_MSR_REFERENCE_TSC:
@@ -1640,10 +1641,10 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 
 	switch (msr) {
 	case HV_X64_MSR_GUEST_OS_ID:
-		data = hv->hv_guest_os_id;
+		data = hv->hv_guest_os_id[vcpu->plane_level];
 		break;
 	case HV_X64_MSR_HYPERCALL:
-		data = hv->hv_hypercall;
+		data = hv->hv_hypercall[vcpu->plane_level];
 		break;
 	case HV_X64_MSR_TIME_REF_COUNT:
 		data = get_time_ref_counter(kvm);
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 6301f79fcbae..0593fe4333d3 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -97,7 +97,8 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 
 static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.hyperv_enabled && to_kvm_hv(vcpu->kvm)->hv_guest_os_id;
+	return vcpu->arch.hyperv_enabled &&
+	       to_kvm_hv(vcpu->kvm)->hv_guest_os_id[vcpu->plane_level];
 }
 
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
-- 
2.50.1

