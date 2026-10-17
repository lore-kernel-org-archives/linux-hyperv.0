Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48047AF6D;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239909; cv=none; b=MBXDunNa8rkxZshId0AkhfF/DSyka0xlxBl6dYTlSP0+0CILg6Gxc2Uu3Xup/p1j1HL4RoUZLysEXJKpKc0SbsmXRKdtpAsmdXZvqihfdaMQJo9/g6azjcMJhngzip4caYNm/HpDnoq/qCoiOBWeouwLKfHYyGTSvo4/p2nPhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239909; c=relaxed/simple;
	bh=Sah8TA7WMOyREYW/vCnq+PIvacRJITZiej9EDRShADg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJwjc5ML4WI3DZpymLNg+saZEwZNR0Ix+WT2rhrqBZQTNiybCCmZ2eReP10O99hvennFartBcoszAXn6lM6eVN2ySYUwltvyE0gpr83uCCijsv6iMPL7dDMdIVA7jYUlR0xUh7gRZROQuQdoXfX5KizjCEjJ052Pq1gtvLIGLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DgHE98A6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgHE98A6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8EdaPKkA0pFZ3HCqdo/wr6WZmT+wZqXu3qoDrjH1eAg=; b=DgHE98A6qpP1JO08v+UzwdacPP
	fUX3ARep3gwYrDXdEZSXj307ndHA3pJXgHmcqMxvLJJoQ9V16YZXY9LZdkc0LlxsSU+QMCp2xK6wo
	vC3HrUmqp9iWoSli8tDIijKMIjhoebmMVACbupna+THSHorzTCJDBkuhnI49RbLAMwTGIG90I+1sd
	x0dRb2CNtBa6+10SwB8aZhhZ6wVRwT/MHVRtYSASr9HCmDG1pwB+sVBOJ9YUteKaKrUE9+S5vU6BN
	4UKCiYNJv3JfMu2cR4DkrlsPc7c2n0Y02Mof7sUx3p18gMMTTW/z4wF//KuWrTo5wmhdlE9iypbGh
	plnWI74Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCT-0euI;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YmK-3h7X;
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
Subject: [RFC PATCH 22/55] KVM: x86: load each plane twin while updating it after KVM_SET_CPUID
Date: Sat, 17 Oct 2026 13:24:28 +0100
Message-ID: <20261017122501.610248-23-dwmw2@infradead.org>
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

kvm_vcpu_ioctl_set_cpuid() runs kvm_vcpu_after_set_cpuid() on every
plane twin, but only the calling vCPU is loaded. The vendor callback
writes VMCS/VMCB controls, and on VMX those writes go to whatever VMCS
is loaded on the current pCPU: the caller's, not the twin's. The
twin's controls shadow is updated anyway, so the stale values in its
real VMCS can never be corrected later; a twin created before
KVM_SET_CPUID2 keeps its empty-CPUID controls (RDSEED/RDRAND exiting
among them), and the guest's higher VTL takes a spurious #UD on its
first RDSEED.

Swap the twin in as the loaded vCPU around its update. Plane ioctls
all share the common vCPU mutex, so the twin cannot be loaded
elsewhere concurrently.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fe8a793b1643..f744e7845843 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -592,7 +592,20 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 #ifdef CONFIG_KVM_XEN
 		v->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
 #endif
+		/*
+		 * The ioctl loaded the calling vCPU; updating a twin's
+		 * VMCS/VMCB controls requires that twin to be the loaded
+		 * one, so swap it in around the update.
+		 */
+		if (v != vcpu) {
+			vcpu_put(vcpu);
+			vcpu_load(v);
+		}
 		kvm_vcpu_after_set_cpuid(v);
+		if (v != vcpu) {
+			vcpu_put(v);
+			vcpu_load(vcpu);
+		}
 	}
 
 success:
-- 
2.50.1

