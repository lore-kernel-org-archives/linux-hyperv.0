Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=ACjxr4QKBIJzkdnH4KS9NgXG564IGD5rcklbpIuEyU3uF+Snu2gSRwmQWMS8G2V4m8GB
	 mmVF6ppU8dqJPCAXXaPruIrVSnDmGq5GY/SvG+Xl/GJeSgYNBRjZzG9ffrWxb2quGW5Qi
	 vbBfRaObV6jC4lqxRSs0gjOwSPnpAqOOBrXOtv98MJawOm31TgTCwrYdKWF6S68PQnC97
	 zZv7gRzaX2A10TtyAoLU2f9ljNWeFwhSVyKx3XClZL7YjsA2UTeVKex4qSvfSPX47Jye5
	 JfjsZDy8AuNPiiYAKxjhNW9Dr6chRi1E4DV23xW55wlZ0AdDYMvQlZjPJEQdNmlzt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=hjXwP543D0QoCmKTck4gYVnjCEUlDyF9Fx/1kCdoIn4=;
	b=l9H5cYDB1GP9+zp+6SoumyL+o997/Uc5H9Rn0Q9Wtv198vCzMJxliMnRfuN1pMoTqYdb
	 bTEvqoGz6VqNhXG36wRBb8nTiovjhNvH33WM4ZpALfiRA+UF7oGn4D04VtIDIUuuWbCal
	 hgf3HdpejH73ecERpMUhbJpWlKlIUgNL5B8K695MRbrK5FA2oGwYoyGoHJxVD88fV1PDA
	 VZDknqs/KUWVKW3u9ZJM6TNGz/jcsrbzOmw91IPkhiI/CRZc5LOezfstiHzeoINr7V49g
	 rgwYXAuAJCQLEL/y+xGIiokQ9G4DbBdDahQ9M9ecXyK2iPR7VbUhlcRTi6hr6VJIMyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ETCoRcQk;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268360A5BC4;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B268360A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ETCoRcQk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hjXwP543D0QoCmKTck4gYVnjCEUlDyF9Fx/1kCdoIn4=; b=ETCoRcQkhii3nUvt5U0cRy0Pxp
	pxMp4LjejPip5j26YCCbulPw9HlruDwkx92yictZl+tPTIBJGGRHQsoACI5pJ9oC0pCk/FiRaNkae
	dQ/XGL4ImmuanBNS2/EP1ImukIXEpQBXwzrviMROCDs0dHJ5hh1v+rvCcX6TlNkWQt+DWgbaPPdMW
	N8YPW8feKUT/AGvq7NgAwaA0PLmOLmU45+Nmz1sVrefweJsO18b2LfBpTc1QlrmkZqGoPeV5ae3oI
	1oRwgurRfWONNiunKNUcTLVBAZyidriVqYQ4K5T3IhIJ6YMAEbWSl/c1onF8ElkadAlCHYt3gYrYT
	W0bqQpFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bf01-3AC6;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LtD-3GEt;
	Fri, 13 Nov 2026 18:34:49 +0000
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
Subject: [RFC PATCH v2 11/31] KVM: x86: hyperv: Make KVM_REQ_HV_STIMER a per-plane request
Date: Fri, 13 Nov 2026 18:34:27 +0000
Message-ID: <20261113183448.84094-12-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A synthetic timer that expires on a suspended higher plane raises
KVM_REQ_HV_STIMER on that plane's vCPU. The request is shared between
the plane twins, so the plane that is running consumes it and processes
its own synthetic timers, not the twin's. The twin's expired timer is
never delivered.

Define KVM_REQ_HV_STIMER with KVM_ARCH_PLANE_REQ(), so each plane keeps
its own request and processes it when it next runs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fe8fddab6039..0fa3196fba36 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -113,7 +113,7 @@
 #define KVM_REQ_IOAPIC_EOI_EXIT		KVM_ARCH_PLANE_REQ(19)
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
-#define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
+#define KVM_REQ_HV_STIMER		KVM_ARCH_PLANE_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
 #define KVM_REQ_GET_NESTED_STATE_PAGES	KVM_ARCH_REQ(24)
 #define KVM_REQ_APICV_UPDATE \
-- 
2.50.1

