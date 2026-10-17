Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA44B95A5;
	Sat, 17 Oct 2026 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239937; cv=none; b=czGIaSX7MThaDh39fpkbhX5OEZHavHBxMv28hPEI5cbal5LYWkKQR0goKfKJBeSYhfFQV70vBw/y16W2KvYrhUR8cP8gORE/CsPK4xAWs0zm5xaJiMyBbMe7biczN7tZDSMN+b0Yz6+wtptRCWcT7O0R8kib9lX3iWdrLm7bu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239937; c=relaxed/simple;
	bh=NWU34bJYh/FHMG4s6t6BGGNhLVogYqtzexYpnxzLRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx4U5YVBRZQN9Vc8Eaj3jVX0d7dvNJP1kC1Q1oZDAqIGwOajQCTodyF5GnPnscRru7PY59gYAZkvF6HCzBs84vjVXV0pf4Mv2pF0rL/NL9wyHG+pa6AYMZ/qN07DoNz6ri7OpIdLVB8Gfrlv7fPukVpoG3+UY+7EhJmjHZqh6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJc6J4+n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJc6J4+n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eW0Kaq+3NekPVSNGGgjl7+UyNCWSPnn58rUqywD/288=; b=NJc6J4+nIiVh/uu3kvRv1emIvb
	TgERvcuIj9Eaboe3VdCbgtJh5IwF4ao8D6QNZDvv5cPwGcrjocuXrDTcdXwhG3+CKTZJGMU4mnfIL
	wuTGZ1oJIVEcrwVoeaqpgSULJXtorZVfydrRqU+JJST7u6/tfv0y2D1bmmyIfRwa9wnzmykaftPY0
	zp03ejY1uVqd5XsLOAu5TqBYkOj019YTwpDci8y+ILQD1AiIrx9t3kRxu5H9kaNsh57HnXM1xPTXw
	E+sP6PGux0OI09DWjctteUHfIbYIb6pB0/JsONsvBM+OPCq5NxndtXl8++1IgNP01Y5xCoG2f0bj7
	HGqMVdyg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfL-1aaF;
	Sat, 17 Oct 2026 12:25:16 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YmC-3I2i;
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
Subject: [RFC PATCH 20/55] KVM: x86: allow KVM_TRANSLATE on plane vCPU fds
Date: Sat, 17 Oct 2026 13:24:26 +0100
Message-ID: <20261017122501.610248-21-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The VMM needs to translate guest virtual addresses in the context of a
specific plane to implement HvCallTranslateVirtualAddress, which a
higher VTL uses to resolve a lower VTL's buffer addresses.
KVM_TRANSLATE already works on any vCPU; permit it on plane fds too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eb5d4932641e..1a9a241264ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6310,6 +6310,7 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_GET_XSAVE2:
 	case KVM_SET_XSAVE:
 	case KVM_GET_REG_LIST:
+	case KVM_TRANSLATE:
 		return true;
 	default:
 		return false;
-- 
2.50.1

