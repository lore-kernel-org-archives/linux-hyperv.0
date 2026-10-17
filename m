Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCA4908C3;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239910; cv=none; b=KH1sAjsevRLGSzhRJVRcbjelpJdE8fabQKG33QmP9a42k5MfBO9xzcmBXTXFJExS1KRPwkW6tOSJgQSTE2CjtBWFlw7DpcoIn65VASed3BguI7zvnxtlqveexbkDCeAApY2olMf0DL4FpB7fTaSEBn0n28ugDvqktc6cLjFGQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239910; c=relaxed/simple;
	bh=7xkFfyj7+kgi/24UNcM7vrrckA7SPi0Qx/KJu3xfOpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo+hHkMJLWHgPSAsLDMKwnHFXxsV0BMvwlk4p3dPsoLo0Cy304AX8jl29p4sY+rZmwlbqSBJThVbrFexyq/TI8XU930ndk60dlew3oWilW+/YngbQ5eSBN8/DJc/GXOOtveL0VZOQPZ9HT0iHy+joEvXtc6RTWAEPDb48E5UXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=orvcMM8I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orvcMM8I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n/eiykWu73DO7uamG8LQ8hB+3aaRFyvEzBbCTCSsPgw=; b=orvcMM8INc1FQs68rdXJlOTqIv
	wcCcIkb1yyPvDhpIVeO4GyqNkjSHW0WXbcil4U1Y1X5S+D1uTqhCNGchS35opdP7qfTDJjCRzsI+V
	QfY3+yWgKwnBWf9nZhdbryVDSCvTP58cYQhNcJwYjTwAT/p5euBMnwtPPDkzx9DHMRYL6352FhbyZ
	6n9yr5Ejn4C9c8cAEK7zMdq3MWTz+RF9YIyzvGkrueFRrQUoPXGkBtM7WeGazxaZiQI6ymdVIp9Ll
	2fHrgD+YeTczIFwK5A4hJvZd8e7QnmlIZVxNHIRw2PcoW6btMoICPXIGwMF1FEL/g6vp2eA4Rtm26
	npwo9gNQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVE3-1Nyo;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002Yo4-0UfF;
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
Subject: [RFC PATCH 47/55] KVM: x86: Allow KVM_X86_SETUP_MCE on plane vCPUs
Date: Sat, 17 Oct 2026 13:24:53 +0100
Message-ID: <20261017122501.610248-48-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

mcg_cap is per vCPU. kvm_arch_vcpu_create() gives every vCPU the
KVM_MAX_MCE_BANKS default, plane twins included, but KVM_X86_SETUP_MCE
was only accepted on the plane-0 fd: userspace programs plane 0 and a
higher plane keeps running with the default, so the MCG view diverges
across planes. Hyper-V defines the MCG state as shared across Virtual
Trust Levels, so userspace needs to program the same value on every
plane: accept the ioctl on plane vCPUs.

Assisted-by: LLM

[dwmw2: ours gates plane vCPU fd ioctls in kvm_arch_is_vcpu_plane_ioctl()
 in the same shape; same one-line addition.]
(re-done by hand)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 2 +-
 arch/x86/kvm/x86.c             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 494600236360..24050c79d95c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4594,7 +4594,7 @@ capabilities will have the corresponding bits set.
 
 :Capability: KVM_CAP_MCE
 :Architectures: x86
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: u64 mcg_cap (in)
 :Returns: 0 on success,
          -EFAULT if u64 mcg_cap cannot be read,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dc6196107c23..e2e54f06b092 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6400,6 +6400,7 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_SET_XSAVE:
 	case KVM_GET_REG_LIST:
 	case KVM_TRANSLATE:
+	case KVM_X86_SETUP_MCE:
 		return true;
 	default:
 		return false;
-- 
2.50.1

