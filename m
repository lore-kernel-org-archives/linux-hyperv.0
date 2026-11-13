Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=3wgeRFK4TB03Oe0O3GxU9wpp21ClEgvau3JD8Ao3Q36VY0T5Xad6OATRs1pzLR9bwoIn
	 8yRaHYcwBvGPDXuLW2m1CrtqEiA7vbGofG6PQ37PnMWfHXNcMLTBULM1qclcQKtjD9zZA
	 hkUNA2mPeuImSfzrWCcknsL8B5dyKi5tMHZq+QOHk70jWnLcJdPIeG8FKV04YaNnSnKXb
	 Xkx3jTUg5PkslgK2tl6rVw4xk7fa1oiFO8SckJsAxqivuZpxtEitR01D1KWRxHlmh3ona
	 ViJ2LIkJ01Eej4zPhtVqvcFTMZKSmg9Hx5JxyWaKTSwVuW3IkhbZKu6XPXTAerRDKRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=pBZ+CnC3hUbxw26tE/js7VOagY0qf7uRdqzEN36xmto=;
	b=l1PmbPrifyas6OHrCV2tpF3lt5WkFHE0HUcfDNA+mg2EsdZZhdaAQJJPjOx446af/KaH
	 YzPNJOAPdIDxwHMGoNX9TxUkabwjhe4kwXmkV+zkHs0Wrzz4TEe9fi62OzsxKIQw5L2uT
	 K0hB1vXZ9G8M9asGhgTmZ/26C0AmPFdUHdek4mVvGMYoTwsByouuFC+NSd/ZFIFErmCSp
	 sF8acamLiPsZEBd3rkYFB3Vi3ORI5O5/4jhz5GD6uG3JAN+48RLr2/huy8jVtd6FMmGgW
	 EMCzW8kZwiwEZwJtFNtQIYxPlBmL9FlPZD3ClngSzUb+GdTkWJKWNYwd1Kp3cF9hmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bFbO6Fb+;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F95606A897;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F95606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bFbO6Fb+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pBZ+CnC3hUbxw26tE/js7VOagY0qf7uRdqzEN36xmto=; b=bFbO6Fb+H0AOE5YwunPbU0/elQ
	hncDX2690I4xzl5oLtMzrouUr9OCgDKRrsbvqb7LuIn2REM5uu2cPx61vPYFhPw6WqAsq9EbOO+Dj
	poZyuU6VuAw7xc7ri5u0NXRbScm09VlMclyOzmIywN1xPKaQJkQ4dytQpLivU9lCHfq6TzCerLPEM
	aohhu/iC/7zzkYqS0DM3LdCMsykpBD/bbYy2pK5HCN9LsFTWpL60aQnQ98XpO6q/wfZdOYLBii877
	KLFLjhxYSvtvluybm9gpnYQACUkXczMd3nL/iDzUahB//cNexh+3K0XtstRK+fi8P2yb3Ho2HwY22
	ZuTyu9QQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gRI-3PvL;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Luc-2ZvH;
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
Subject: [RFC PATCH v2 31/31] KVM: x86: hyperv: Do not divert descriptor-table writes in SMM
Date: Fri, 13 Nov 2026 18:34:47 +0000
Message-ID: <20261113183448.84094-32-dwmw2@infradead.org>
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

From: Sriram Nambakam <snambakam@linux.microsoft.com>

Windows VBS boot fails when OVMF executes in SMM. The
hv_divert_dt_write() helper was diverting firmware descriptor-table
writes into the VTL register-intercept path. The failure trace showed a
reflected #GP delivered in an SMM context with IDT base and limit both
zero, followed by a triple fault and guest reset.

Exclude SMM from this helper so those firmware descriptor-table updates
proceed normally, without changing interception for ordinary VTL0
execution.

[dwmw2: applied from the mail; subject ours.]
Link: https://lore.kernel.org/all/20261104065539.15281-1-snambakam@linux.microsoft.com/
Not-signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 27317077f519..4ad8be64166f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5939,7 +5939,7 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	if (!hv_vcpu || vcpu->plane_level || is_guest_mode(vcpu) ||
-	    !(hv_vcpu->reg_intercept_control & ctl_bit))
+	    is_smm(vcpu) || !(hv_vcpu->reg_intercept_control & ctl_bit))
 		return false;
 
 	hv_vcpu->reg_intercept.reg = hv_reg;
-- 
2.50.1

