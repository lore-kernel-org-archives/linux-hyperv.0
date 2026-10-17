Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3D48F82C;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239912; cv=none; b=L2o50g38dB/yEX1PXrCnmn6dr3983LpoZ94ILDCyaKJYOemCO4cVdt41EcNv1Z5CU/fIkCC/rpNL+lIfpwLMp1VcOYBpujyi2U/x3cYnx5kMykkhOzC3qveFPUHCNooTzYyS8Uoze0r8g8s3Dl5O/i6N4PWchM9IJjFGsF5jql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239912; c=relaxed/simple;
	bh=n4hcA6lLaoitjflRxS4WNE839VpbRoCICI78N7FE9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZRw7anjCn9x4rLNEwqBUGrhUP3CS8DpNm0x3JnPB8cHsyV/wkJZRLjoXD9UuGUaWbC+xdvgYXIps5pyokqF6UmVqwBOXT9Vtpbgvb6jpOKziDH/TLml9dpQoRmAw5GDhqjxkzstGRAcNOsNI5Zj5YCl3rd3CULJ0EOjjD76CuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jYZw/QE3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYZw/QE3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZSHRhCMRhKiyZmDLW1NcJgrwq3GJtSMGS9fxauRrdiE=; b=jYZw/QE3YGGqMbjL3XQNOXXX2c
	ByZFCMmX+9VGldIzjSLbY/gIxguhqUMUtvAlfyYjCh4zvEAdc50iXcbptlGJGdfe3DQE9ysqw2ALF
	wBYAqO2YKkDNyJCDrD6/qzfdUr/dq3b/nUmX8U69e9e2ngLHu4SKwQ/8SBLIxNF4WZ7V9LPWZtNLf
	j4o6bXq/NPZOZz71gOIt1n+CJpQljfdfjcwWKkgrXlWHfKwuh7jK+fbtr6vL4X8VnUfmllCCGslQ/
	97ILsqaeP3hOnId0zS8nh18Q8w9LZJJzs9EP1PEafhGVfIX2RAc84GKj1+SzIBtgFZKyIoxccLfuM
	xq44raYw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVDV-06hn;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Yne-3SEo;
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
Subject: [RFC PATCH 41/55] KVM: x86: hyperv: Refuse a synthetic IPI to a higher VTL
Date: Sat, 17 Oct 2026 13:24:47 +0100
Message-ID: <20261017122501.610248-42-dwmw2@infradead.org>
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

HvCallSendSyntheticClusterIpi(Ex) honours the target VTL in its input
but does not check it against the caller's VTL. A guest running in a
lower VTL can therefore assert any fixed interrupt in a higher VTL on
any VP, which crosses the boundary that VTLs exist to enforce.

Refuse a target VTL above the caller's with HV_STATUS_ACCESS_DENIED.
A VTL may still interrupt its own level and lower ones.  The old
upper-bound check on the target plane goes away: a target at or below
the caller's level is below KVM_MAX_PLANES by construction.

Matches the equivalent fix in the reference VSM implementation.  The
production Nitro Hypervisor permits the injection; the conformance
suite probes for either behaviour.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0bc9435ea3b9..e3ac840c8e5e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2710,13 +2710,21 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-	/* TLFS: in_vtl bit 4 selects an explicit target VTL. */
-	if (in_vtl & 0x10)
+	/*
+	 * TLFS: in_vtl bit 4 selects an explicit target VTL.  A VTL may
+	 * interrupt its own level and lower ones, never a higher one
+	 * (TLFS 15.9, "VTL Interrupt Management": each VTL sends and
+	 * receives interrupts without interference from a less secure
+	 * VTL).  The reference host omits this check; the suite's
+	 * SendIpi test probes for both behaviours.
+	 */
+	if (in_vtl & 0x10) {
 		target_plane = in_vtl & 0xf;
-	else
+		if (target_plane > vcpu->plane_level)
+			return HV_STATUS_ACCESS_DENIED;
+	} else {
 		target_plane = vcpu->plane_level;
-	if (target_plane >= KVM_MAX_PLANES)
-		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
 
 	if (all_cpus)
 		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0, target_plane);
-- 
2.50.1

