Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C6383984;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239907; cv=none; b=LTAK2ecxZf1betdSiltrlKTBzZJNMZllqp8A5v4Ok7iamH1f5TQwPaTEpzrpLn81Or9WXhWobK7fmnBqjbDksyx3Pp1EiktLgtMinZ6ZY+6NFLYNWIz074VbeMACxMbhtALZMilFMGlOIaCF3br527P6TkwcDWRvAcaT3YFgxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239907; c=relaxed/simple;
	bh=d0lRRxmXLnUsJtatii7z2pOxUgVx3Rg6HZ2/8Trpm9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNKd4dRRXtiZfANz8XS2KdHHYu6ndYE+dk30tsEKFMMlsQyHen4JzZ6HSM/Dl75vG2UlH6eMErKVSAi2FFBGy0usZjHgCzndd0XnwjZvomq0Xd8x4692M9jC5eSO1ptcApuoHi7K7xAUnl54cVm19RtStAtHH2meJidwmjTpy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tr2xttvj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tr2xttvj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QBt9n5EhoF4ytefL+NqOdtVCXxj2E+IaiHKYLwHYwdQ=; b=tr2xttvjtFbuxnSu06mhWznsxe
	eTga23DNzmSDqKHqOACNQeuc3kb6FlBYW6PqlNxmgQjOdd1p/4UBaWDWl0naljuBKNOuaQYr23sa0
	qs3GFKWKpMd3gBLEAe63Zx1RT5CFZ7T2lLicEiLFT9salRDKb4Xvx4+JQ9fK3cG+IGP714sA8q2tS
	twY+WhNxhvG77Ogwv1eHUJq/F7QYHpdUvU7XrkAYB+WdBER9oNRPPmU+Whnqly2kGnvVEKvZKkFan
	npMS8FcWIafqsJP43iITbnGDDMO5lpF7JjEpocKb0kr+eZL+G7/075jgAR4/TcjCN5SDppxoHi2MS
	EuUQGCOQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCI-2BZw;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlS-1Nvm;
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
Subject: [RFC PATCH 10/55] KVM: x86: Allow MP state ioctls on plane vCPU fds
Date: Sat, 17 Oct 2026 13:24:16 +0100
Message-ID: <20261017122501.610248-11-dwmw2@infradead.org>
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

A new plane vCPU for an AP starts, like any non-boot x86 vCPU, in the
uninitialised wait-for-INIT state, and nothing ever sends INIT/SIPI to
the higher plane of an AP. The VMM placing an initial VTL context on
it has to mark it runnable itself.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca5d8e081fdc..970c738558f2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6278,6 +6278,8 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_SET_ONE_REG:
 	case KVM_GET_SREGS2:
 	case KVM_SET_SREGS2:
+	case KVM_GET_MP_STATE:
+	case KVM_SET_MP_STATE:
 	case KVM_GET_VCPU_EVENTS:
 	case KVM_SET_VCPU_EVENTS:
 	case KVM_GET_XCRS:
-- 
2.50.1

