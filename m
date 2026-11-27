Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=MS/8whN+v/9kij1DJCnimuKZxVdGwHYxUi1ViB+AoUUQotbozAdq8cARMKin0/8VZYxc
	 liRj8Xb7ete0E24lSqq/ESxpdv06W+6nTKanAIxurFeh/qVZ8n2X3niZ/VJrBSTzed1uC
	 a3kttNXDFLPVV4mU5q8ljk10hLfg4tkeKMwaieXJOXSY9HJxVbbf10idku66OCqeHIdoJ
	 btS56c4TsePpKFC0GlcvOr1AQYn8WM2AnM1qPJ8y2+Qu3eS0xFSygzbgz6AOrEdU6oMVi
	 Yu2mjMDqmqLN9mYoX935q0fxp4uuEW1rtE3A23dDEE0Jis55FQyXua4SsLp6rjUlJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Blb7Mg/UOWA71rnTCoPfVbDymfiRcX3jB92crLcpHmM=;
	b=KZchYnWb5Yxu3SeBrbetUfKQ1HPnKzJTHMk00ejieAO5T2Pjf9zYtuV2aLT2FIQKdaO6
	 9uFMBnE7Fl9wYrSMEbZI18HSaTILSPVVwQ9dJOLoWPzcxOrBliuSFShZaoe69Cf627So7
	 Y1DsSD8b9y6S985ZvrOc8T6Z9j8w0NzVhDomr4dI9TSaR5wkb13dshiTKXNSIizkBVE3g
	 F7GqlO5shEC3oLZywr4pvTthdS6jtfymBe/iyCpOreCJoPTkDTuMxqL/bJCdX9RwIxLJy
	 TWXXyUTHenqQOWoSN4xCX9fGUI6cN3JqxX5l5Bm3JDzI920ePXhbPUidtPNjtVSM3HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BE8Zt7ij;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC460A261F;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEC460A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BE8Zt7ij
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Blb7Mg/UOWA71rnTCoPfVbDymfiRcX3jB92crLcpHmM=; b=BE8Zt7ijIQFxXAcVLD3kw9fV5L
	FC+rM3e69g9WhhZzgQJnlvSYGeAxFusbMqdVLG6CCVAJq5Pa3HuOZIDXFUB8peSewuR/JVUAQLslH
	pTTpi9gIo8yYJEWa/hIzH7wmvkepmQsOG1M2Qz61Eyhg/MlPa2L9HWyXfwcjco8Wsx66j34sQrEFH
	vCN/+Jmha3jYtwKybOd2vwrv5JiG5pWk1YfGi6yUJNdcSupc54hF4rCueK09FkWb4NZ+y5ZHWkrHe
	m2teBxZpLUMAZRp8AwlNZvKEMtMb5UbZ07ZyfM4jHp/kapAFy8oBP9OqVYI5oSfD5SJCwu4EFv/rU
	O6qWzTiw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkn-2Ea9;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqS-2Oj9;
	Fri, 27 Nov 2026 15:27:30 +0000
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
	Jim Mattson <jmattson@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 07/15] KVM: x86: hyper-v: Advertise XMM fast hypercall output
Date: Fri, 27 Nov 2026 15:27:22 +0000
Message-ID: <20261127152730.99319-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127152730.99319-1-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A fast hypercall may return its output in XMM registers when the
hypervisor reports HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE, and Windows
only uses those forms when the bit is set.  KVM does not report it,
although a VMM handling a forwarded fast hypercall can write the output
through the vCPU FPU state.

Report the bit.  None of the hypercalls KVM implements itself returns
output, so it only matters for those which the VMM handles.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 67c9d20547d8..bf0e37d026c0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2882,6 +2882,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
+			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
-- 
2.50.1

