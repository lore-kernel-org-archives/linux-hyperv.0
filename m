Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=yEHcYp8LHpfiS/KR/aR5sFDPFf6eNfdgFFwGGumjlxKPVUoHafxMUjWkJ8W1/QmMN9dN
	 CBOGmA1EZT8t/yE3uQx1FFN/CyfYJIAFul7GDlLp6LfCSkSrKZkKAmbNOutc61xlf8vbu
	 OjUJTC7dRqOQyMpdr6u0LcX5gW7MyAAxo0JiniHdGCYjdnKt/ZFI128dacVlEju+afZLd
	 LlV5aXTHZgvMWPYwZcyDu1JWY9aHXVsrt8p0en2MgEXG1T2+ImpcjyAbykRG+IXFcHQ4Z
	 Dmjf1ISJK1zGP+kibjx5pjHhQVy0lTddoFB1X0KpLRkZDxEnRhTdcbmDfVz1Fyf/mbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=H/1yImDOZ+SVFQtMY4YhBA68vbXSp9toi6tf1Yj5qhM=;
	b=Clrm6WQrOboAEUgUfgPF+eoCaw/ppPF/ZQLCgCDz5x7+beiAphtqTH1ojRLGTrJpVt7s
	 wHGkF80oLxdj/FgzVlXVujHoCxtWmemqG4zI7iyQQPCMp4YyE1rwVliv1A7ywYBYhtn9S
	 9BJUtQBgulaCxpT5b9ZOQS8VkYR9vkQv/9Emkl3AiZxNqCrvh9YizOKUUBPlbKfUZF1aJ
	 LBK73px29XFwVnZqowSHpvhHls6oyv9kqzph7dRwh2bNeg/zJ1HIjQgGd4wIkSkvvRRHU
	 /FyRwqvGAqguApiT5zRv0VcFsHlgRrFjyTAmI8hpzJBfhIu/KH1PalpFw582jzP4+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mrCtrXVW;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB760A5BC7;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4BB760A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mrCtrXVW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H/1yImDOZ+SVFQtMY4YhBA68vbXSp9toi6tf1Yj5qhM=; b=mrCtrXVWiY6ncH0VWyExMhF9mU
	u3f3mMUMkLwpyeEsxen5OfDZX5BnrfqOnD5uZdt9FnARfE4XjQVaXxyrpXvDjyW6HYXPTlfQcm3Zj
	d9AdDboZ6YH1kEfVrtTPwFjEsziAygTlb4SO6WH21vBgFxZSBMY/dJHC0K41jBCGcfP2bu56Yst/h
	rCdzC2hc2pQuUiqX5WlZHqBgW0WsLCh0kgXIvGE5GZfck0LAXbHbPL9lFUFKTNTMN+MSY6c5ecycQ
	wAOn0OiACmSYejd6xlvQUgW6kxDhPY7lptGE1LL4VPIpDJIntpNlrwZDlND1fUHbkNMbM7/IEXI1D
	VN1onYeg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6v-0000000Bf09-0UuG;
	Fri, 13 Nov 2026 18:34:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuY-2NyG;
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
Subject: [RFC PATCH v2 30/31] KVM: Document the two scopes of KVM_REQUEST_PER_PLANE
Date: Fri, 13 Nov 2026 18:34:46 +0000
Message-ID: <20261113183448.84094-31-dwmw2@infradead.org>
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

A KVM_REQUEST_PER_PLANE request raised through kvm_make_vcpu_request()
(kicks, mass requests) fans out to every plane twin of the vCPU, while
a direct kvm_make_request() marks only the twin it was given. The
per-plane Hyper-V requests use both, and a future direct caller would
trip over the difference. Say so at the definition.

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/kvm_host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ef95158ddd53..111fa3c4742c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -163,6 +163,12 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQUEST_NO_WAKEUP      BIT(8)
 #define KVM_REQUEST_WAIT           BIT(9)
 #define KVM_REQUEST_NO_ACTION      BIT(10)
+/*
+ * A KVM_REQUEST_PER_PLANE request has two scopes: raised through
+ * kvm_make_vcpu_request() (kicks, mass requests) it fans out to every
+ * plane twin of the vCPU, while a direct kvm_make_request() marks only
+ * the twin it was given.  A direct caller must pick the twin it means.
+ */
 #define KVM_REQUEST_PER_PLANE      BIT(11)
 /*
  * Architecture-independent vcpu->requests bit members
-- 
2.50.1

