Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5C48F03C;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=BBsR0useDS7srwq9lfITw8v0JVbjIYzQIqhGwRHli/hmA0VhMHKBfzFwBBhcRnHkkNuQ4GKkzTWnat4DChSay6zHjFK/2SQGnLJdpvp2w/MPel6KQj/G5zHWhZiw0HlMvI9IOOLKsMjpOaCg3umi7vxDCxJL0UGCg5mf1d5tbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=Pbjc+06U7L3YYqyRFy3jBhOJfo9dDht/Chz8rGK0lYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VugNqaqv5At6unFadCVn+bcGQi80MZxBZWVaHAYEWaIOxBZrwyT9lIonM9+d/lXXOEgdMUP6lWW4FMkckqwfe1kkDUsdCpjGTDRSaEr4Ry2tt5+mbHk2CyP1+Xfuux78gs+hXKwtopqpH7xHPeiC/lOYTeM9K2xeloK/sUMYTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYZSKEew; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYZSKEew"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N0HQEkUIGk+rMhwgcnEA8H8yoxyLuPN4PAU1EVSM5Fc=; b=WYZSKEewA8+kvJw6fAQEnmoBpE
	Arb4IyGdQL/Q3lCt5EtzWoXIsM4+wn6l8RUMfIGbnbf4+qNMloC9Cb5YgJZqnPe2aK+Mc8dV2mBzh
	StcOIcukydHu9MJXbzEuQZAreH6EWLQZu9lesFSw+eQbIJkQamsgR4hyezGHTmPJxNu3vdKZC+eGy
	CWTBRwdYrjohmwkZsMjutFd7OcuX517ncqZvEWorJNRkKwC48umAoatWu3xylKEAidYj1VluArF1V
	vUUZ9GXCARj81JBFoqInxn2CzHFL6XfKcWGnRs8Q2Kcal2HSN1aWfUM6oyltNJj1FagJdC0130ITO
	XWM5gi4Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVD5-3g6L;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnN-2eyk;
	Sat, 17 Oct 2026 13:25:03 +0100
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
Subject: [RFC PATCH 37/55] KVM: x86: hyperv: Update the reference TSC page past protections
Date: Sat, 17 Oct 2026 13:24:43 +0100
Message-ID: <20261017122501.610248-38-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Mushahid Hussain <hmushi@amazon.co.uk>

The reference TSC page is a page the hypervisor maintains for the guest.
A higher Virtual Trust Level keeps its own page, and it protects the
memory that holds that page against the lower levels. KVM writes the
page through kvm_write_guest(), which refuses a write to protected
memory. The refusal aborts the update of every page: KVM has written
sequence zero to all of them and leaves them that way for the rest of
the guest's life, so the guest falls back to the time reference count
register for every read of time.

Memory protections restrict the guest. They do not restrict the
hypervisor's update of a page the hypervisor owns. Add
kvm_write_guest_unprotected() for such a page and use it for the
reference TSC page.

Assisted-by: LLM
[dwmw2: the original message called the function kvm_write_guest_hv();
  it is kvm_write_guest_unprotected() in the code, say so. ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c    |  2 +-
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2098daede7d3..eebe48f5be23 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1260,7 +1260,7 @@ static int hv_write_tsc_pages(struct kvm *kvm, size_t len)
 		if (!hv_tsc_page_gfn(hv, i, &gfn))
 			continue;
 
-		if (kvm_write_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, len))
+		if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, len))
 			return -EFAULT;
 	}
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fdcf401ccb46..beae4f2a982a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1551,6 +1551,8 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn, const void *data,
 			 int offset, int len);
 int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
+int kvm_write_guest_unprotected(struct kvm *kvm, gpa_t gpa, const void *data,
+				unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d37961cc5235..72fe64e5d4a1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3832,6 +3832,33 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest);
 
+/* Write a page KVM maintains for the guest; plane protections do not apply. */
+int kvm_write_guest_unprotected(struct kvm *kvm, gpa_t gpa, const void *data,
+				unsigned long len)
+{
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int seg;
+	int offset = offset_in_page(gpa);
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+		unsigned long addr;
+
+		addr = gfn_to_hva_many(slot, gfn, NULL);
+		if (kvm_is_error_hva(addr))
+			return -EFAULT;
+		if (__copy_to_user((void __user *)addr + offset, data, seg))
+			return -EFAULT;
+		mark_page_dirty_in_slot(kvm, slot, gfn);
+		offset = 0;
+		len -= seg;
+		data += seg;
+		++gfn;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest_unprotected);
+
 int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 		         unsigned long len)
 {
-- 
2.50.1

