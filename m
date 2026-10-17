Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F8494291;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239915; cv=none; b=g+kzmddApZ2QbPHMWKcOxi55nHmHthhCbeSx67PEo7B1jWV2/YaAgiCyr+3yj1HqDehwps3OaPMrUZtvQYFSWus4/Kqje953aVrVFo016xDYlDqAv9+U0rvw5Ls8MnSczFSJmx+rGNOhkChiM+k78pEfD/MB56RwS9JBNTj90ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239915; c=relaxed/simple;
	bh=3WkiVn+fXYzkzCq5Ma1IUyy1namICr3IcHzyyf5vZho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1nZkYnp4zapO5CTT/OM0rMwxyJhZ2cj3gp53D7arZTTVkyTi82LzSfrzOKv2EI3aXOLZIfD56aeMmunf2MgAqLNtJrpZuJPRNvzOiNSK/XWqW4fnIwCZCYRcfisQeZb6iVzs0O7w+zySoSM1moeTfBOkmKFIDJGDt27TtYkEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pfZbl/e6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfZbl/e6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GJI8bj1/o7xcDKTOTBlog9lF6RE2KdEibjxq7sa/iGk=; b=pfZbl/e6bvIJrbBET7tLI2JlH2
	U9NHyDlxhuI57VXy+sJ2P5FYI25NbK12iCbDukaEJh9p16VsJexXqIKe6OkHZEh0DzDtmBRY59B/I
	0empbaDMMmjrW2qyOXoizf2YpR75hxCWn7CCjmmQuO6v0nY7FhYKzFm/+MaL0W8PFxf494g1wYQ+5
	9bbyDVTdDMiiSorKd9XL02e7frAeauJaHlBPO1RP7shafVQ+kKF9IyRLlAI+lAKxWJuGTZVZQH3h7
	PcOrNpS/Y/zgU/8xAK9EDrlL9fPrN+n4S8j6C5qxGnkvQdjZCBjO/0XQolEBeLmtDiUcjCm0d5ys5
	+iQVpoeQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfU-1xRZ;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnF-2EjC;
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
Subject: [RFC PATCH 35/55] KVM: x86: Leave TSC matching to the plane 0 vCPUs
Date: Sat, 17 Oct 2026 13:24:41 +0100
Message-ID: <20261017122501.610248-36-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

KVM enables the master clock when every vCPU has a matching TSC, judged
by nr_vcpus_matched_tsc + 1 == online_vcpus.  online_vcpus counts a vCPU
once, but each of its plane vCPUs synchronizes its TSC at creation and
counts as another matching vCPU.  With one higher plane the count can
never equal the number of vCPUs again, the master clock stays off and
kvmclock loses PVCLOCK_TSC_STABLE_BIT.  Among other things the Hyper-V
reference TSC page then breaks: KVM writes sequence 0 to it, finds the
clock unstable and leaves it that way.

The planes of a vCPU share its TSC.  Give a plane vCPU the current
generation and leave the matching count and generation changes to its
plane 0 sibling.

Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f8a149ba0eb..ba468f7c4d4a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2858,6 +2858,31 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	if (vcpu->arch.guest_tsc_protected)
 		return;
 
+	/*
+	 * The planes of a vCPU share its TSC and online_vcpus counts the
+	 * vCPU once, so a plane vCPU neither counts as a matching vCPU nor
+	 * starts a generation; its plane 0 sibling speaks for it.  Nor may
+	 * it perturb the global matching window (last_tsc_ and
+	 * user_set_tsc): KVM_SET_MSRS is accepted on plane fds, and a TSC
+	 * write on a plane fd
+	 * moving the window would corrupt the next plane-0 write's match
+	 * decision.  Latch the generation from the plane-0 sibling, which
+	 * exists by construction for a plane twin, rather than from the
+	 * VM-global cur_tsc_* that may belong to a different vCPU's
+	 * generation entirely.
+	 */
+	if (vcpu->plane_level) {
+		struct kvm_vcpu *sibling = vcpu->common->vcpus[0];
+
+		vcpu->arch.last_guest_tsc = tsc;
+		kvm_vcpu_write_tsc_offset(vcpu, offset);
+
+		vcpu->arch.this_tsc_generation = sibling->arch.this_tsc_generation;
+		vcpu->arch.this_tsc_nsec = sibling->arch.this_tsc_nsec;
+		vcpu->arch.this_tsc_write = sibling->arch.this_tsc_write;
+		return;
+	}
+
 	if (user_set_tsc)
 		vcpu->kvm->arch.user_set_tsc = true;
 
-- 
2.50.1

