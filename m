Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589547;
	b=O/u7NLpYsrRwI9FcraOud1ll9d2WRQGOor3QuUg0Fmv37uEkzLoCxYzrTqGRatNmrErH
	 iv15OKaj9dFZf7p3tp1/LN8P3gqYB/93EqFvvwloeyNz3GJCIpuIr7lmh1UemZqLdvTNB
	 ss+Hz1zdCpaAidm79IlLXncwVZMKzfBCfjxvpevs2li8ANhKJ5guF88Z6nE1zIFTxqO+k
	 eS2Ij1RUF/HuUv8AowL8wB4gBvPSvAUwQJu7X3H/RUKoVKhId4hKur25LcAiF91VEkl+6
	 zfHImUH4xWnnEWYQT/05QXNdd2X58cmD4GwR+4lKswPJmz8Wu4EnldAS8b6n1h3QOuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=rtFUrJztFGFbta851mkuXzZ/23JIXnRd/M7360eizCU=;
	b=Bk0ksUIRMOesaTmfR67LD1csH0l5J0Hf5oHktboxa1ovWpR5YbG7NJjnZOFhB2CgVLlX
	 rQ3PU4RxH251TYAI92yCQwx9nXx4yhfYoLDeQ5alzp1PcqMXjzkp0lrMFcTZz06zEOyoA
	 OLAIo3DlkNjUen0+EpGfZGCveRQm9C4NohwnlBN4zjkZMSef2DBBLnmnAyyNBEkcRrTkt
	 MjAleUmmysFss7OEMkYJV2CDN2UoM7lHMIekv3svfKXhAEVpt1ZAFT5JgcWxkAb7c3lu6
	 cApZ3Af+HX6TgVuIo6zskEiEwTJOC+NgLCFYKwLSB2qTmPsJgVtHGC2MzmsuZi/cP4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=utaNzrrc;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF864606A338;
	Fri, 13 Nov 2026 17:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF864606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=utaNzrrc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rtFUrJztFGFbta851mkuXzZ/23JIXnRd/M7360eizCU=; b=utaNzrrciPIVMUBAoT3ELtmMrj
	z4+oDOSotU7pndS6hZ1LCkc3Tm5vuVeuWXxR4PHs4eFjBxphRMzakEup8xMQ3QbYzgx5f2kqmRHZF
	tMhqiQUG8bV7JkUtD6WQp7CZBYtKvslnjdkxQ2FP6xWAmujH3Y3kl8t08xU7AxarjirDNeRw2E2N3
	hwSzi4V95T3DVJ05/XydrmJudqlBmvMvOB2MCBAbSRomfGWAKFqt5v8QCHvXW8gYEgu39utetd1UN
	X3IfzWuQ1Re8+kmojFNUwOXsZi3vKRj5LVSvZxjpy/r25lEr1HVRHaDMwvV/jwg+MpzPJUj0DKM+w
	Nt5kv0tQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuiW-00000003oWH-0f7x;
	Fri, 13 Nov 2026 17:05:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRuiV-00000000KcR-3xJ7;
	Fri, 13 Nov 2026 17:05:35 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
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
	Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 3/4] KVM: x86: hyper-v: Advertise XMM fast hypercall output
Date: Fri, 13 Nov 2026 10:05:34 -0700
Message-ID: <20261113170535.79246-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
References: <20261113170535.79246-1-dwmw2@infradead.org>
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
index 858ee0f374e5..e0d9b2b1302d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2870,6 +2870,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
+			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
-- 
2.50.1

