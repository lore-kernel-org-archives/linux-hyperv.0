Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=BkLkGnNjfeey2AEhAbNPepd1Ma7hCNL9GA2LLQkDfMWgwkTszkqLE4ONndXP5KKQrn7q
	 FUas5D/D1tjvukFKvm7iWggGDZkX65GmiRkZAc2V2yYYiFt4R6scT2K2XBhhspy1byoBK
	 JK4S8RzEn4LY+o9uKzIApiVJbDV7Y/LFfffSP97/4KlE1wstz+punzGizMTaW1uEzFfyO
	 dscxEoe3fClnkFqQWYUng1xcnkNDuV75jPBaKEuLvLLWeWI6lsuA0rfOdHpf4IKcX+Hkk
	 syYdHGgRj4zKjKlk1TZMA6HbDMViZGObunPyhVGEB3ImjsDl8UfE8AzoyLZgryp9+UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=yuXeiTRewtwnJ0Siqg/g/BH/O6H4cY0PF5l9a+qFn9I=;
	b=Rkl87XOT01o2QkrUgR34fqRbEqx9tBPUbPbt/VM9Su9e88OqXyBfjySiuCzRtx/+txPQ
	 7adTgp878M40iuJepAd+NMSU1TKxJdBJZTndUK0qOyZfUm34mLK/l0Rk589/xmR+XecWR
	 xKhcIzgZ8KtgUkuLpWWMvmB5GB/g916ez5Fcc6Vj98poyRItvHrS+ZxqGOJwThN0AISf9
	 GRXp1g6iMm0vaYehPplI3qRS2CaHzSQWUcQITI9O1jndBN6SfhDUGug6W4/RjJ5Lopjag
	 /isJiAWpo8bDizRu62Dzqn0zTR+DqFGheNYHhywJ/1RNlKSak1COymkohYEwzvXkqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eQD4btuR;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CD606A333;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0CD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eQD4btuR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yuXeiTRewtwnJ0Siqg/g/BH/O6H4cY0PF5l9a+qFn9I=; b=eQD4btuRM+oIH7dqstUSmrqwnH
	hssNv1XKN3J2AW7JY2giyMKa+kwp052M1PQoazes95KgIApcdu4M+Jn2i+/gtRN0DSn/fJF1SyuHi
	Ed49leZcbgHvKoz3dYlMpCvQF2UY7bhgfXGMwz6e0CK7K1baqohq93Cgbc2uw5RIAuplCdynaIGK/
	RkTmtdOy+0lZ6J9scHri9AaunD5qFlzChCRkLPVjJykL2Q5pJwm78BingbsRWULfqpLgeDep6hnjs
	afbBdR71D3/bMYYcvcS84HDXZx2bPBKPhYFohuVbPUA3SUaVEnk5t7Pl35LE+NjUGWmdD6bkpp4vc
	4A+zJ0sw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPT-1d0Q;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsb-0fFb;
	Fri, 13 Nov 2026 18:34:49 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	joerg.roedel@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 02/31] KVM: x86: hyper-v: Bank GUEST_OS_ID and HYPERCALL MSRs per plane
Date: Fri, 13 Nov 2026 18:34:18 +0000
Message-ID: <20261113183448.84094-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113183448.84094-1-dwmw2@infradead.org>
References: <20261113183448.84094-1-dwmw2@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
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
---
 arch/x86/include/asm/kvm_host.h |  9 +++++++--
 arch/x86/kvm/hyperv.c           | 19 ++++++++++---------
 arch/x86/kvm/hyperv.h           |  3 ++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 69c32ce22b56..c642a20f3b5f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1089,10 +1089,15 @@ enum hv_tsc_page_status {
 /* Hyper-V emulation context */
 struct kvm_hv {
 	struct mutex hv_lock;
-	u64 hv_guest_os_id;
-	u64 hv_hypercall;
 	/* KVM_HYPERV_HCALL_* features enabled by KVM_CAP_HYPERV_FORWARD_HCALL */
 	u64 hcall_features;
+	/*
+	 * GUEST_OS_ID and the hypercall page are per-VTL instances in the
+	 * TLFS; bank them per plane so a higher VTL enabling its own
+	 * hypercall page does not clobber the lower VTL's.
+	 */
+	u64 hv_guest_os_id[KVM_MAX_PLANES];
+	u64 hv_hypercall[KVM_MAX_PLANES];
 	u64 hv_tsc_page;
 	enum hv_tsc_page_status hv_tsc_page_status;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9ebcad807c69..387fff64597d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1371,7 +1371,7 @@ static void __kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu)
 	if (hv->xsaves_xsavec_checked)
 		return;
 
-	if ((hv->hv_guest_os_id & KVM_HV_WIN2016_GUEST_ID_MASK) !=
+	if ((hv->hv_guest_os_id[0] & KVM_HV_WIN2016_GUEST_ID_MASK) !=
 	    KVM_HV_WIN2016_GUEST_ID)
 		return;
 
@@ -1413,10 +1413,11 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 
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
@@ -1424,10 +1425,10 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
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
 
@@ -1456,7 +1457,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		addr = data & HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK;
 		if (kvm_vcpu_write_guest(vcpu, addr, instructions, i))
 			return 1;
-		hv->hv_hypercall = data;
+		hv->hv_hypercall[vcpu->plane_level] = data;
 		break;
 	}
 	case HV_X64_MSR_REFERENCE_TSC:
@@ -1669,10 +1670,10 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 
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
index 7c6a21f02d71..2617ee1e57b2 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -202,7 +202,8 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 
 static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.hyperv_enabled && to_kvm_hv(vcpu->kvm)->hv_guest_os_id;
+	return vcpu->arch.hyperv_enabled &&
+	       to_kvm_hv(vcpu->kvm)->hv_guest_os_id[vcpu->plane_level];
 }
 
 /* Features reported and accepted by KVM_CAP_HYPERV_FORWARD_HCALL. */
-- 
2.50.1

