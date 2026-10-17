Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D641A547;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239908; cv=none; b=pTuHFyDIr4i+BLXcAX9bdu/4ExL0uDnFYZhORQGpWXc9SrAZEdI0V6rUB1jA9sVka6ux0Ad97XFrWyT1ZO1xs3e17B3v5QGBI6TmZrrtc3+94sEeOBsT/2O5z7uJfI+AI6+m2oAnzB35ztp4KEBU8V4u0b+a0wtPJUvp0kgQsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239908; c=relaxed/simple;
	bh=hHsOZCDLjxtwJ1W+2OpXTKXhCvPpAIaqzK6hEesMOnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON5hhuCnVPD3ah3b9k1sFlfU/x0uWQhhn/MbJXMyzgzQeZUAzOQq7egzHNt6zJHepOQ9WLa20T/bh4q3sNkK7hXKxkCpTOPr8FdQaZYxFVR9jDz9K+R35bGd9qNZhe1ZXfcNhbsE7veBNPnN+iG06T9tKgPjitCRKKuUMgaucYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ILxnMUX+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILxnMUX+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sxf9hLfVKoe9B/juWhGVfchlQD0OaCIIzAXOG/lX39k=; b=ILxnMUX+SKH6o7fO0GvyrtgJ0c
	3T8HcR0e4Clv99xYved7nn5NOnOvSClytApOYaZ0K2A+8GukXUsXfpAFfW/xWs+LNJk0D0CjpUZ/a
	QhZWOnBnSqRKr6/DWnXYwd0Dfp++gZUbFYlUu1uRMK1UZEGq74aAMgWT4e7xHbnWnldHJ5xEyNEk6
	l2R/Mnmv6TGTS11lc4NLbwmwxN1YYP/A3tUvbGa3Z0eJ1tIrncC2+ZpDtx2c6Z2J0/z/H8glnfoN2
	dcDOxivLu3fp/Vo4BrhmBNQl+D+pSrrVNOoDpKb7AzDB86KIg6YRHEtqp4+EYzNp5OgZ4fOCMHiky
	Z3qmyCYg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCP-3Ey3;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Ylq-2PJk;
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
Subject: [RFC PATCH 16/55] KVM: x86: allow KVM_SET_GUEST_DEBUG on plane vCPU fds
Date: Sat, 17 Oct 2026 13:24:22 +0100
Message-ID: <20261017122501.610248-17-dwmw2@infradead.org>
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

Debugging a non-zero plane needs single-step and breakpoint control on
the plane vCPU. The debug exits surface through the plane-0 KVM_RUN
loop like any other plane exit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst | 6 +++---
 arch/x86/kvm/x86.c             | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 570db83844c7..8232356b1bb0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1536,7 +1536,7 @@ for vm-wide capabilities.
 
 :Capability: KVM_CAP_MP_STATE
 :Architectures: x86, s390, arm64, riscv, loongarch
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_mp_state (out)
 :Returns: 0 on success; -1 on error
 
@@ -1617,7 +1617,7 @@ whether the vcpu is runnable.
 
 :Capability: KVM_CAP_MP_STATE
 :Architectures: x86, s390, arm64, riscv, loongarch
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_mp_state (in)
 :Returns: 0 on success; -1 on error
 
@@ -3746,7 +3746,7 @@ handled.
 
 :Capability: KVM_CAP_SET_GUEST_DEBUG
 :Architectures: x86, s390, ppc, arm64
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_guest_debug (in)
 :Returns: 0 on success; -1 on error
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0828889db149..eb5d4932641e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6287,6 +6287,7 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 {
 	switch (ioctl) {
 	case KVM_ENABLE_CAP:
+	case KVM_SET_GUEST_DEBUG:
 	case KVM_GET_DEBUGREGS:
 	case KVM_SET_DEBUGREGS:
 	case KVM_GET_LAPIC:
-- 
2.50.1

