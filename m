Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=YvsIykYSnnigyOaGVZ6KlOMF1WzAVHQsYdEfzl7KZ8WariVVA4mSfeAkESewZMjjuwpo
	 edCKba7uTnCzgbren00FwB8fBgzm54T/LZRfZVVZM8JDUkO+cONIXfl9x117E2sSKwkoV
	 ggdcyp55g2VcnvFu/LcaMmCp8dVY2sQunagDVHeL3ynwECVn8ewionY5XpDZQVDnK7FfL
	 vGhsVrsYZwfl8cQwCryUcFiC8Y0LiiMHBlhlKrBOHe+jQRaH9a69GaPJBvmdkOoqPdoBl
	 cheoc7Fh6TYkOKfbcIFQ/s2xAgO6q3b7v+8uB/hGhVOReulBQARvD0Ed+ZwrL1oauzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=apVsIJSH3/IZZxjWhCK/tx2M7qVtHwabFzFedCcf1jQ=;
	b=vutPY8byN8DEsKxi/rU+OyoCJTDaFzYvDKd8D/WDbWV5EqN66SqqJeqBoBBSkWtUVe4x
	 zFlTzG4aEBC8ibTEY3Y14sgTWmw5fdL4qBSD7tz7hO5vkmzWjQZM7cg4jzpJTEd+zHFNj
	 iIfbItpvW1PaP8hQ/tep+7yfGpAUV3Z8k28IFnhF2Yp7gzZqCgrp8g/PEjM3OkFAgsy2y
	 YenFk64Sdt2Fw6MU/1YI5VoqWUjAK2sUACls/CC2hmcP3o50oQTY+MHriBznm2YjDxg8u
	 PNJWvW2Gr1IJbgU7dCF2GisCi671fy0ozpYYNk0XIzu3+CCmihtFLCfCWuvU8xcwuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=I2i1mOag;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235C606A33D;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0235C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=I2i1mOag
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=apVsIJSH3/IZZxjWhCK/tx2M7qVtHwabFzFedCcf1jQ=; b=I2i1mOagyjT7Y7F6zQfKJgqLBU
	DLbRotcPHALWU9oZCXak9QOrMxZg4vGprhJyYvxE9BcJDkPyH0aPUhNVZaSEq1XB84KxCfmvjZTLv
	JYP0kRtn9Tx/VCI8SB7QoflnkY/b8IDUCLfwz+Hf9aJRTqB0tAL/pV7BQX6EmzFW3UxepnfAKp8BR
	FJ4o6dt+wj9KOPjg/EqowakzW9+389ne51tkiAGm31tgAzUGU/uGXORNi0VrHg+KgujKQrM0275R/
	JL6PpB6WLpzUesbM/E0DCugGrVWon+kymyoQfalaZgl0JpeFKJ/oflBuFPJWPp4mCRa974v/qY8su
	CIp7hPJQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQd-1Eoh;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Ltj-0JLP;
	Fri, 13 Nov 2026 18:34:50 +0000
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
Subject: [RFC PATCH v2 18/31] KVM: x86: hyperv: Truncate higher-VTL vAPIC MSR writes
Date: Fri, 13 Nov 2026 18:34:34 +0000
Message-ID: <20261113183448.84094-19-dwmw2@infradead.org>
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

The Windows secure kernel writes the Hyper-V vAPIC MSRs, HV_X64_MSR_EOI
among them, with stale data in bits 63:32. Those bits are reserved for
every register but the ICR, so KVM injects #GP, and a #GP there is a
VTL1 bugcheck.

Truncate non-ICR writes through kvm_hv_vapic_msr_write() from a
non-zero plane to 32 bits. The exemption covers only this paravirtual
path; a native x2APIC WRMSR still takes the architectural #GP on any
plane.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/lapic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 79e4998da644..81bf72e83e8c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3589,6 +3589,18 @@ int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 reg, u64 data)
 	if (!lapic_in_kernel(vcpu))
 		return 1;
 
+	/*
+	 * Bits 63:32 are reserved in non-ICR registers, but the Windows
+	 * secure kernel leaves stale data in the high bits when writing
+	 * the Hyper-V vAPIC MSRs from a higher VTL, and takes a #GP here
+	 * as a VTL1 bugcheck.  Truncate those writes instead, as the Nitro
+	 * VSM implementation does.  The exemption covers only this PV
+	 * path: a native x2APIC WRMSR takes the architectural #GP whatever
+	 * the plane.
+	 */
+	if (vcpu->plane_level && reg != APIC_ICR)
+		data = (u32)data;
+
 	return kvm_lapic_msr_write(vcpu->arch.apic, reg, data);
 }
 
-- 
2.50.1

