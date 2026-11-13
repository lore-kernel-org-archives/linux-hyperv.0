Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593457;
	b=MnjeS1TBs+v381Wn82cbDnvpPipqJ0rB3C7SWUavpjEbkL4zZJwvV214aGTiLz9FYR2X
	 mGwpuwPUFePAlIpxOsJmHuQrfn4wMQmpvoR3wXzOvbQ0EiVJUnb29lU3+l9ah9XcZw2tI
	 csLn3zy3n8LTF/wIaKTQAArUwOt/VXOTiPo/BwH3O+iTO3G3CumF4hQWBiiS8dAaEmnYu
	 lnfk+QuCreaNxvyQAwfiY98s1C+ywPLXJpFzHlHuj5kyajhxxdUWcHgyRuK3pD8ZW0lyk
	 trtdfwFhEIdXI05+uPBVzJkI6qGtPRRXuS7QtwmWcQu+7LulbbMYFr/ju7+TfPycm8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593457;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=XhBNFtC1QnqJ4V4bqrNNUKOgvII9Lgc8h6uQXVwmY3w=;
	b=NgVWxbeNJguDX2F3B6jmNtH0o+nYLuYzp31f3xHamVdvMWxkMCVZnx5Y5UCO3EAi8P/W
	 bf0170uNBVBa5UECjhwP8HAAAvwdJYbRae7w4nsZ2Ih7CfhlwR88//A80VJE5TRwP0yrc
	 XYuQQeeHVpcNhE6mEBlGF7Lh4Sd42KP9sC0zp+6Tydqsv6JBMU75PhHJgOvLZ9ZvO7dzn
	 VtUpTYu7VQNBKifTsXYNp0CsFqjynSRTq7vA8C3pXIdmStHP9+bC1k/T44kXrr9uqEjQJ
	 EBeMrDLc8aJ0ENE0Rofef/+RUpjjaWLZQT0M4vk3CAKwHFIbEWi12ExSy5CufKxqvfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i+W7errz;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8275606A323;
	Fri, 13 Nov 2026 18:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8275606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i+W7errz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XhBNFtC1QnqJ4V4bqrNNUKOgvII9Lgc8h6uQXVwmY3w=; b=i+W7errzkrkTbd/Y6S6JKxaE+o
	JPvmm4iyNZVuiMob4lgImQslNCzaFBB3YHVlIyDQpI2JMITxrHzbQrys4nkITqA7Zq0pmPnOnP1Co
	4Qv33ei8oai2kvMoZ9wxGgYYZ16cZAT813Zl0UKzlEcE3Xl9hkKLVdqFm6yXm/OUN9eulL1t1Tc6L
	QIxCWPindXgcGukf+595ZhlRtiqYgEhv6hGj0/Fbs6ykYTbkNBv/5H+BpqI19RORJo1Rigvfjadoh
	pE/xx/pXpasnEXxLMwlb+iGz6haRxVlJzyXevjWroSM3wySm+62Lqcz7w/Dk8/aY6CaZZiD4vTf7y
	SacZ2Jxw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvjh-00000004WY2-21iJ;
	Fri, 13 Nov 2026 18:10:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvjh-00000000LH7-0cTC;
	Fri, 13 Nov 2026 18:10:53 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] KVM: selftests: Make the x86 SSE register helpers volatile
Date: Fri, 13 Nov 2026 18:10:53 +0000
Message-ID: <20261113181053.81779-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <sashiko-outbox-209724@kernel.org>
References: <sashiko-outbox-209724@kernel.org>
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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-209724@kernel.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../selftests/kvm/include/x86/processor.h     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3e4351ccb359..28571ac697c8 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -888,28 +888,28 @@ static inline void read_sse_reg(int reg, sse128_t *data)
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
@@ -920,28 +920,28 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
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

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.50.1

