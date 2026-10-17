Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8F4908CD;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239913; cv=none; b=YdIYz9soQGoMtjCK3CUjpMF+zXNIfcqjZVFWjuzeLpvg2FOqQKk3lFWR/lh565FcMaQnWIP8DYMpiwZ2IhJ0Q+QxahLm8lBE0zSi5PSykTNdxnGKXva3b+XggGIoKmK30zDj80zIEsqSDGI/xjMQ/05P6QKJjiybIZeDiNRb2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239913; c=relaxed/simple;
	bh=RVi6Ypb2sRHdkkT9sxlDqvx5LAZU/U7DtYQuWNHtvHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtvGp0tTXok2o/RW9/r+UxFz4H2/B6F4orrG2Pyn9/q96gKpCXelKQaSc/1WWducArEj8dqBU9Rh4HZW9ukPTsnaafkBzGKjcobopDZX07LG7yZdY7uhBbKpvsY4evEREsHd5ICctVe0eYBxx+FrDKU0heDaZixQPwDOmWT6y9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Adm6Rauo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Adm6Rauo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oqD01cGmatq0R7KGfZBkSFOS1thsicsovcmsGvVc4zw=; b=Adm6Rauo0Ar5AIH+FLJCl2xdXO
	K/Wq3MC+UoV3nH7uU2eYnFD1fDgZ02n9ztpDgO3Vt6DYHuzbP52VilQKlSgOoqO0U2PIBVhLh7Uar
	CgElLx2NxPNwEPVBuu8bmwttOBkxF77FpLVpYVzEIofAhqsvXfchv+CZGvrSkWfGHKCtpcNkKWm4v
	BZKOgZVIxsdbsiFUQPIvxqf8f7UTv3x7mynBVZQSRn88pKdIIiCmE6O+nhlw0R/UeVz7zga9d/k2e
	zf1YsbRORHX+T1EmDfACUcBjBNdq8kML7nGSc8SnsqFkGwBnMoqHUhM+p3XT+8cI8TUOwm+QqurIL
	Vg7FVbpg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVE9-1V8H;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002YoA-0eTW;
	Sat, 17 Oct 2026 13:25:04 +0100
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
Subject: [RFC PATCH 48/55] KVM: x86: hyperv: Advertise XMM fast hypercall output
Date: Sat, 17 Oct 2026 13:24:54 +0100
Message-ID: <20261017122501.610248-49-dwmw2@infradead.org>
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

The Hyper-V VSM register hypercalls return data in XMM registers when
the guest uses their fast forms, and the userspace handler answering
them writes those registers through the vCPU FPU state. Report
HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE in KVM_GET_SUPPORTED_HV_CPUID so
the VMM can expose it; the reference hypervisor advertises it, and the
Windows secure kernel only uses the fast forms when it is present.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 02866b9b7e9b..dbe1b83c1f28 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -3751,6 +3751,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
+			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
-- 
2.50.1

