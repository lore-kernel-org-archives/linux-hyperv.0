Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594891;
	b=laJdWqNX5LCtfdmpgwuaExuHRmQQR4gJgnqpW5A6qWd4PTeaEF0Rs1cur67/2qJiTFrm
	 T3QbhhErSX5v4se3L3VSwjNYVtVnoLQc9FGheTwu0WYQmzGOygUubXwKaDIBSxkp/hjki
	 Zww9q0zqrNIS5MSTdtKSWGbp/Jx6nVj3qlu1cbOhLQPyBIR0vdq3MGSOx3dlhEXU0Jk0G
	 QSfFNE3fyuWe9kDXeTeVhMZifNC6M6nj7DjyUjOdAGlgs0mIM+VbitFADGGXfdIndJGXe
	 G+5tONfP+UGn2vFwUQoqGqM7KhupTDCvw34NBxacC/S/sldUqubLqR8fooi1y3dTRgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594891;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=qwZRSYpd7BAIdEDFRtmEwc9iMi4v7/Ni01ug+RMS35o=;
	b=vaxPtY4rog36RThcNzP/yDZ9iao6xgY2eW4DflMUPxnB+FqfozrLjwc+Dm5JIc9j/YPy
	 HfIySUWdaHHKgdDQ5DSaXfn19+2dy7sdI5gbBtNU2iEcWloEclOIVHJaubr75XkFoz0FE
	 vDrnVTOK21RszO2+fKi9wcFy2ZlOVn/cesP/xf33A62x5GYjpgZmE/J2Qfk/oY6DkW/BP
	 sb0hvJp0rzDi8WR+tnJK+tU1fExpuix1pKR0qh0fibyHLfLCe/8DAIgzxTsooTpekYl/Y
	 uim4GfgxfHA8GhtOYRE8L5BGuo8I2ILX9zgl23GiUMI3pcp4cZ2Yki+pKroUaFsXjnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="QLZ/3ufy";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B521606A335;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B521606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=QLZ/3ufy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qwZRSYpd7BAIdEDFRtmEwc9iMi4v7/Ni01ug+RMS35o=; b=QLZ/3ufy+z+EcXGbWvWof7GzPg
	LlwiIMz2xaAggQjB+Y5XJqxfW+Y7pFgy8Jman05D3gtFcQbNq5NQ6l80FwyTL20ybQBWBbCComZZV
	OX1ub0veTPrNkKayH/FX7UgXuOToj4rvhzCbnFRKzAHmt0I0vdneaWslhDOR3qQ2TPWW06nrttzlb
	kc/p+s7v4Djya/JuxyxuRE5fySLWBkyqqDTZWjt9kZGXLI9I7aIUOHwBDrP85c6kl950LCB105jzU
	k3cE1pXaQQZGxQx4a61WsTGW19N3QO1CiAb67Vg/axwERVMkdbvu2uYFDpIO8LxIeKU9cewD/gENL
	4jB6gC/A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQL-0Iaq;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LtO-3bE7;
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
Subject: [RFC PATCH v2 13/31] KVM: x86: hyperv: Suppress SynIC exits from higher planes
Date: Fri, 13 Nov 2026 18:34:29 +0000
Message-ID: <20261113183448.84094-14-dwmw2@infradead.org>
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

Userspace's SynIC device models plane 0 only. A KVM_EXIT_HYPERV_SYNIC
exit from a higher plane's vCPU looks like a plane-0 SIMP or SIEFP
move, and the VMM relocates the overlay it keeps for that page to the
new GPA, carrying stale overlay contents along.

Do not report SynIC MSR changes of a non-zero plane to userspace; the
SynIC of a higher plane is handled in the kernel. api.rst says so in
the KVM_EXIT_HYPERV_SYNIC description.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 3 ++-
 arch/x86/kvm/hyperv.c          | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 83daee450284..99e18956f249 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7503,7 +7503,8 @@ Valid values for 'type' are:
 
 Hyper-V SynIC state change. Notification is used to remap SynIC
 event/message pages and to enable/disable SynIC messages/events processing
-in userspace.
+in userspace.  Only plane-0 vCPUs exit this way; the SynIC of a
+higher plane is handled in the kernel.
 
 	- KVM_EXIT_HYPERV_HCALL -- a hypercall for userspace to handle.
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d2ad255ae212..5a42d479e936 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -253,6 +253,15 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
+	/*
+	 * Userspace's SynIC device models plane 0 only; a higher plane's
+	 * exit would be mistaken for a plane-0 page move and relocate the
+	 * overlay the VMM keeps for SIMP/SIEFP.  Higher-plane SynICs are
+	 * handled fully in-kernel.
+	 */
+	if (vcpu->plane_level)
+		return;
+
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
 	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.synic.msr = msr;
-- 
2.50.1

