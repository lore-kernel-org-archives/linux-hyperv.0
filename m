Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430720;
	b=pxZ98RPL0Y7Fq/2Y89HVM/nMQAoGieVD2EJALl88gcZMdo/ZhxVR8tewI2JtIwSYV6Ly
	 +ikW6OzqirOi7VjyOA22+VtriVaAchmnkbVrz/wvfSChxfOy+YYyB/vzgSDj23pW42BF5
	 332UTkk2jOWjI0+f7MUUZ6WhMOv1ciOqRJyxagtF5XgL6IYOTWeU4IjA5xzsWfE2J5kEA
	 IzXLs8cLeiEc21K8EaPlw2vbbGuOy5lpc1ASRgA8/lF7t2ynDjcRX80SK5v32eryybGzp
	 stkW1zDkeAqghjMTtqtBVOeaZJ8LFge7va0c7nj8YStuUeq8+EbT81GGFEW5ddpd43A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430720;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=BcsL0t8ZQN1z8JR0BC0PFQ+tjj2UXrV0eDXs9RKNGc8=;
	b=oIFaCw5Kl+ZLxXvgZ5ZxQMUlpJ2eIGXzJyLI8iyqtoQ2UrMqUejURf6MpE1pbMyXn2Hy
	 0aM24y1wk1Bit/IVKIRQzQxzGI03HJEDiKWMQ5tnXDTX/p1B0wlVrpQOMo8pIapmS237c
	 ldtUDEi7Ex16hi16Lkdt/loattQ97oqOYWwG+qfnX+BRNUlRW3JhniGqLELIGiBd6xT/w
	 rcD9YtyW7DsGapJWtLDhQzkaqA2aULzsKTLfL4DNGCGAXuOq0RSUumC+TFtaWF2Ld0enT
	 4/s8VE3Woc+GkTQhcAINx681/ngb2uroJGp4eDkoApH+guZjd4dHGH+8+4umBEdt/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZcdPyNZp;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7C606A321;
	Wed, 11 Nov 2026 20:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZcdPyNZp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BcsL0t8ZQN1z8JR0BC0PFQ+tjj2UXrV0eDXs9RKNGc8=; b=ZcdPyNZpclwPCzWD9xuqxnzlde
	2nPEX2WYVJtFhbSJ7EXwLHr3xTrZ8Lo7uxug6YH9WCPHj2KvGR6d4bUYOaUQ7nVEqI1eWU8ASYOq3
	meJtcrxr6GXOztm1G6knj94eGQgra+mGh7mvzSZdJTpmW/Q6dpKYXcPciNjYCEsAxWu8td029yfYY
	0b4FGLW2hGrvjkHbnJF5m7iLlZG7Pal79s1/FQAL2pXy43ozoi1n8htd8m5PNClRwJXq83AlR4ClC
	rY3dxb8LUTm2ED+fM8zcVhAJMGenqj2fgeAcGsr9HqSF6g/hbpWDEr1KZaRtbHmqwXeq6iiI2oGe/
	Xsb9AfxQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFOu-0000000Ea67-3kAu;
	Wed, 11 Nov 2026 20:58:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRFOu-0000000HZ7n-2lt6;
	Wed, 11 Nov 2026 20:58:36 +0000
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
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 3/4] KVM: x86: hyper-v: Advertise XMM fast hypercall output
Date: Wed, 11 Nov 2026 12:58:35 -0800
Message-ID: <20261111205836.4186584-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111205836.4186584-1-dwmw2@infradead.org>
References: <20261111205836.4186584-1-dwmw2@infradead.org>
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

A fast hypercall may return its output in XMM registers when the
hypervisor reports HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE, and Windows
only uses those forms when the bit is set. KVM does not report it in
KVM_GET_SUPPORTED_HV_CPUID, although nothing stops a VMM handling a
forwarded fast hypercall from writing its output through the vCPU FPU
state before resuming the vCPU.

Report the bit. None of the hypercalls KVM implements itself returns
output, so it only matters for hypercalls the VMM handles, where the
VMM writes the output registers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2a2bc54775fe..0e1d40cf37a9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2892,6 +2892,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
+			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
-- 
2.50.1

