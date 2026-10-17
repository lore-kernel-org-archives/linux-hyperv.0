Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0C49BB61;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239919; cv=none; b=t90zu/4omqwf2gW3mzTgnvUKs6YUUsw2ZkZ2p6dNYyQitpWF5RYBjSs0ghkUFgQqb4q2ZYB6ncP/G/jD/JN0YrJaOeOJ5JzOM8PCDxGAoSGLqXdJ2Linz+yhCRnqSeV7ty+qUctC0M1IzD7pyfRakUHbk8pvkRdwYQgH7IR5+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239919; c=relaxed/simple;
	bh=Eubby6VT+XARsJ9quJYk41ls+zWKznvr4hi9SsZ0QRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWlHWHKiPvezCuxkiUSFg0Eh7uDCfEvX18hQcqC76Jkk0K8Mu7vy+Hhgyk7TWJhrjPyvpO8zCiRJ0meg3bE1FdI4SxtMT+BM+JTvtYImZHLViwxFah7QxLxwR2gxBH618npVrxShEGUbEfRNK2kUxPswL+7VNvypsPrgzc7DKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pJqbgC/9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJqbgC/9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=QWCP1ZefKnL5Wot6bMiK9KS2y8iKFc8f/R3WKKmTc6I=; b=pJqbgC/9haoqKD3n5M2DCPfxU/
	PJxba4ldFkcSkYP/D5VaJ1yNMDP6KvcHt0qJb2GUeDYGo/n0KwhTz+umkvNXBXZHertUg+cN/at6Y
	6x7E5A/r86FkybIWqzgdNhLimRBi1UsApFtOJFkwdp81F42Q72euDsQtFwRwpBteemIe/aED+NyYy
	7VITOw5oOoTh2cLz/WD4g1Tw3r7+qUX0gPZigC7VJuSd6V3G6FEgzrLUG5vIRZYkxLbBhRYIsZERB
	A4jj4A8mMjsJcXhbX8+9jKFSDKzzDREjtx7TkrogXvg907FDJG2H97/TU4kTXe8MPhfU0r70VCCCP
	cxjOX3XA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfG-1bBy;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlW-1Y7p;
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
Subject: [RFC PATCH 11/55] KVM: x86: Filter KVM_ENABLE_CAP on plane vCPU fds
Date: Sat, 17 Oct 2026 13:24:17 +0100
Message-ID: <20261017122501.610248-12-dwmw2@infradead.org>
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

The plane-fd ioctl allowlist admits KVM_ENABLE_CAP wholesale, so a
plane twin's fd reaches every vCPU cap handler: enlightened VMCS,
direct TLB flush, register intercepts.  The nested paths behind the
first two have never been audited for plane_level > 0, the register
intercept only ever diverts plane 0 (hv_divert_dt_write() skips higher
planes, so arming it on a twin buys native-emulation overhead and no
diversion), and any future vCPU cap would become plane-enabled by
default without anyone deciding that.

Accept only the audited caps on a plane fd: the per-plane SynIC pair
and the two CPUID-enforcement toggles, which mutate state the planes
genuinely bank per twin.  Everything else fails with -EINVAL, matching
how non-allowlisted ioctls already behave on plane fds.

The exposure is widened by our per-plane Hyper-V state: the VTL code
assumes per-vCPU capability state is uniform across a vCPU's twins
unless a cap is explicitly plane-aware.

Found by a local Sashiko review:

  ### M17 — whole KVM_ENABLE_CAP surface admitted on plane fds
  kvm_arch_is_vcpu_plane_ioctl() (x86.c) lists KVM_ENABLE_CAP with no
  per-cap filter in kvm_vcpu_ioctl_enable_cap(), so plane fds reach
  enable_evmcs, enable_l2_tlb_flush, ENFORCE_CPUID, REG_INTERCEPT etc.
  No demonstrated bug (all mutate per-vCPU state), but the vendor
  nested paths are unaudited for plane_level>0 and any future vCPU cap
  becomes plane-enabled implicitly.
  Fix shape: per-cap allowlist for plane vCPUs, or a comment recording
  the audit.

Fixes: 21d7ad7e2ba8 ("KVM: Implement KVM_CREATE_VCPU ioctl for planes")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 970c738558f2..2c41c53e4d4f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6088,6 +6088,26 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	if (cap->flags)
 		return -EINVAL;
 
+	/*
+	 * KVM_ENABLE_CAP is accepted on plane vCPU fds, but only the caps
+	 * below have been audited for plane_level > 0.  The nested paths
+	 * behind eVMCS and direct TLB flush have not, and the register
+	 * intercept only ever diverts plane 0 (hv_divert_dt_write() skips
+	 * higher planes); refuse those rather than implicitly extending
+	 * every current and future vCPU cap to planes.
+	 */
+	if (vcpu->plane_level) {
+		switch (cap->cap) {
+		case KVM_CAP_HYPERV_SYNIC:
+		case KVM_CAP_HYPERV_SYNIC2:
+		case KVM_CAP_HYPERV_ENFORCE_CPUID:
+		case KVM_CAP_ENFORCE_PV_FEATURE_CPUID:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	switch (cap->cap) {
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_SYNIC2:
-- 
2.50.1

