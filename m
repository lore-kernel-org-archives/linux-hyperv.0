Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=CdQUw8I6PKp7vc6g3lhNGISnfd73OC2af3uYmKL9GAiMAy1bwVF2UEl3BmO1fNSka1/4
	 wHsiVaNnex1e/XM2dq6QGLTG+PHPVKCo9ZAzQWRxk/ZUwVuZNLBsnLfEEmTUZp/lR2ZsV
	 MYUCGcHDFO5ujTPUI4xSQEwF3ZkaLerAIqWmWp81HYKkn3pw4hS0IasM+ZFRyh6VLScnU
	 aiYHJxq1bd22btBKCLX1tr1gJDThf92krJqKdMPfoEMR6bcis5j7sS4eeIauD6NP0Lj3y
	 l3vdJbFMmBTOxSCrn4okPB61sVEIzPPT7lGqL4FmmAytddRc82M3kKXcvjQ+Bx3S/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=1BsiWFpQn5takhG8tcqf/7xB4zmGy3GbEtI5gNdaBYA=;
	b=vp101/RkCk9lQCPJZfLMJTNHP9sj9iQ0uQg+ObzmH8/vypJvo/gY7YsIAE3ODp2BuuE9
	 lt1taQC+dn8Z3XX3Fb/p51Cw6CJ+/+tYIOU2E9YJhSI4QOudN27mDB0x7bK8bgrdKD8jn
	 nabdnDwjKAjfzxMirpaYLpW78QnE3tP/94UVt03KwrXsFXnwrsNHkyCQs0rTz4Vynd2C9
	 b9L6c0dD7HwQcZ4xSjWjDziHxbQV20rN1ZOaKRqKCdNgwnNBp3fO4rZlaMwfLBFPTIwW+
	 MKAXinOxyiomdEsQiDjTpzMtRvZAGZdLHlCmVd6Qj2YfiR8tE1ZMv+e8Qx7zky855oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="NSW/inQz";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE960A261A;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCE960A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=NSW/inQz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1BsiWFpQn5takhG8tcqf/7xB4zmGy3GbEtI5gNdaBYA=; b=NSW/inQzjTkQnljtiht0JG+mgl
	Lsu2flLp3tES4Ob4V4DGNMu1yNiG4cbsicyf6O1epMRP9zM3QYl1k+7WxaQrASl47E4xL/uHOH30f
	boSNti7b1NR+jP6rjCZVLdvqer9dJz2Fg7CQskffXaQ7lKnRjFhqK9UvDQY2rLJzf50K8Zla4BEIj
	chLBsy4RQyDe5xis/u6JFknc9q2Ffn3+4zfmFf1Cz3YnMR/EEjcHk7Kr7ZeAAuswb7F/M63DdrK1O
	/vpQP/psh2uOauoY0FY7QXoV3rIjmrHyvIXZqOXllovBnZooK53ylo7TuGzT+y9RjTgYYd+OisHB2
	fwWH3cKg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkk-2EcX;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pq4-0p3Y;
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
Subject: [PATCH v3 01/15] KVM: selftests: Make the x86 SSE register helpers volatile
Date: Fri, 27 Nov 2026 15:27:16 +0000
Message-ID: <20261127152730.99319-2-dwmw2@infradead.org>
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

read_sse_reg() and write_sse_reg() were borrowed from KVM's
_kvm_read_sse_reg() and _kvm_write_sse_reg(). The kernel is built
without SSE, so the compiler never uses the XMM registers itself and a
plain asm() is enough there. Selftest guest code is built with SSE, and
there the asm statements have to tell the compiler what they do.

read_sse_reg() has an output and is not volatile, so the compiler may
treat it as a pure computation and move it, for example ahead of the
hypercall whose XMM output it is meant to read. write_sse_reg() has no
outputs and is therefore implicitly volatile, but it doesn't declare the
register it overwrites, so a value the compiler was keeping there does
not survive.

Mark both volatile, and declare the register each write_sse_reg() case
writes as clobbered. A read_sse_reg() after __hyperv_hypercall() now
stays after it.

That still leaves the compiler free to use an XMM register for its own
code between a write_sse_reg() and the asm which consumes it.
hyperv_write_xmm_input() in the hyperv_ipi and hyperv_tlb_flush tests
relies on that not happening; GCC 11.5 at -O2 emits nothing there.
Closing that window entirely would mean passing the XMM values as
operands of the hypercall asm itself.

Fixes: 676a863ce605 ("KVM: selftests: Better XMM read/write helpers")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-209724@kernel.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../selftests/kvm/include/x86/processor.h     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..571f8a602edd 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -866,28 +866,28 @@ static inline void read_sse_reg(int reg, sse128_t *data)
 {
 	switch (reg) {
 	case 0:
-		asm("movdqa %%xmm0, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm0, %0" : "=m"(*data));
 		break;
 	case 1:
-		asm("movdqa %%xmm1, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm1, %0" : "=m"(*data));
 		break;
 	case 2:
-		asm("movdqa %%xmm2, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm2, %0" : "=m"(*data));
 		break;
 	case 3:
-		asm("movdqa %%xmm3, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm3, %0" : "=m"(*data));
 		break;
 	case 4:
-		asm("movdqa %%xmm4, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm4, %0" : "=m"(*data));
 		break;
 	case 5:
-		asm("movdqa %%xmm5, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm5, %0" : "=m"(*data));
 		break;
 	case 6:
-		asm("movdqa %%xmm6, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm6, %0" : "=m"(*data));
 		break;
 	case 7:
-		asm("movdqa %%xmm7, %0" : "=m"(*data));
+		asm volatile("movdqa %%xmm7, %0" : "=m"(*data));
 		break;
 	default:
 		BUG();
@@ -898,28 +898,28 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
 {
 	switch (reg) {
 	case 0:
-		asm("movdqa %0, %%xmm0" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm0" : : "m"(*data) : "xmm0");
 		break;
 	case 1:
-		asm("movdqa %0, %%xmm1" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm1" : : "m"(*data) : "xmm1");
 		break;
 	case 2:
-		asm("movdqa %0, %%xmm2" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm2" : : "m"(*data) : "xmm2");
 		break;
 	case 3:
-		asm("movdqa %0, %%xmm3" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm3" : : "m"(*data) : "xmm3");
 		break;
 	case 4:
-		asm("movdqa %0, %%xmm4" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm4" : : "m"(*data) : "xmm4");
 		break;
 	case 5:
-		asm("movdqa %0, %%xmm5" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm5" : : "m"(*data) : "xmm5");
 		break;
 	case 6:
-		asm("movdqa %0, %%xmm6" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm6" : : "m"(*data) : "xmm6");
 		break;
 	case 7:
-		asm("movdqa %0, %%xmm7" : : "m"(*data));
+		asm volatile("movdqa %0, %%xmm7" : : "m"(*data) : "xmm7");
 		break;
 	default:
 		BUG();
-- 
2.50.1

