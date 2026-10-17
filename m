Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7A49BB6A;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239917; cv=none; b=H+lRK8LE2oZxc9FARP3QTcl7sSoFI3fgEDHVm6iUhQKmYFA34o/QrSJPsgc3RAr/sBvC/OPfSkWHxntm9K2bPQwU9FmyIxrSDHWvLUBgxWDS2Z38wv8tQ/tKmlZQ/iuwiEKMi8gCwXuVRav0mqwvt6FPq0f/yfpodAbAa3p6FkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239917; c=relaxed/simple;
	bh=9cwo/3fzzWZ5h09vQgPTYuV5TIhJFf1cwmM9zmUwAAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUwZ6thQD9be2pGmIt3PTiu6rh4SsX98IbH0IuNwgd4fwF0M+YSEUOqpxjC4ZSGckR35pyzrTbwBBTkbbGa3BdOkmevIo9oxZAScl8txEqSE85KwRQEw1saoRBCs0zdqTNpfCv/GeHEDvtyx+Oe05rs0HFdEThs3XBZmDdMINW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M9xuQc7w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M9xuQc7w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2AbPDRvQ/GtfxSBHnwz72ekXy3Mtf1+Upt8OjMfxyP8=; b=M9xuQc7w2IzqzXRx/s+cPD7Mal
	6pW169HQE5amHudek4o6498O2L/GZTVHKht3fM8VgR9ptDTbJGjQLV4Ua8Id7eo/8JPBMjA6Y+2Mg
	49jhI7aq97i0EC0XEHewy1g2VSwDqhLDqXwM0wQqnnU+qC1Z0eYz8ESicDBfoPHCfJhG6F1OPc30s
	ZUe2Fj5ycL8u7lBt7WhzqmMIO7FxEQoWChOde2J+m9teIuYrb3Eyalw0AncPKBw+HyzQVi6vuZprS
	L15T4WQFkgy3a7dn+Lfa5+C2/YkBHRt+4ecl46xvYVfiUpXvYxEvXye0S4Ni9ZctTgyfZR7829bJd
	MGkPQVwQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfA-1aAD;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TB-00000002Ykr-3V9D;
	Sat, 17 Oct 2026 13:25:01 +0100
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
Subject: [RFC PATCH 01/55] KVM: x86/mmu: Move ACC_* masks from spte.h to mmu.h
Date: Sat, 17 Oct 2026 13:24:07 +0100
Message-ID: <20261017122501.610248-2-dwmw2@infradead.org>
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

The memory-attributes backport uses the ACC_* masks in mmu_internal.h,
which cannot include spte.h because spte.h includes *it*. Anything
pulling in mmu_internal.h without spte.h (debugfs.c, page_track.c) now
fails to build.

Move the ACC_* definitions to mmu.h, next to the PT_WRITABLE_MASK and
PT_USER_MASK definitions they are built from. Both headers already
include it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/mmu.h      | 14 ++++++++++++++
 arch/x86/kvm/mmu/spte.h | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 830f46145692..ae1068169925 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -32,6 +32,20 @@ extern bool __read_mostly enable_mmio_caching;
 #define PT_DIR_PAT_SHIFT 12
 #define PT_DIR_PAT_MASK (1ULL << PT_DIR_PAT_SHIFT)
 
+#define ACC_EXEC_MASK    1
+#define ACC_WRITE_MASK   PT_WRITABLE_MASK
+#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
+
+/*
+ * Read permission for a gfn's memory protection attributes.  Not part of
+ * ACC_ALL and never set in a PTE's access mask: PTE formats cannot express
+ * no-read, and x86 rejects protection attributes that forbid only read
+ * (kvm_arch_mem_attributes_supported_prot()), so a no-read gfn always
+ * takes a memory fault exit before any SPTE is created.
+ */
+#define ACC_READ_MASK    BIT(3)
+
 #define PT64_ROOT_5LEVEL 5
 #define PT64_ROOT_4LEVEL 4
 #define PT32_ROOT_LEVEL 2
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 217f6b40c50b..511aa0e0e222 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -45,20 +45,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
 			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
 
-#define ACC_EXEC_MASK    1
-#define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
-#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
-
-/*
- * Read permission for a gfn's memory protection attributes.  Not part of
- * ACC_ALL and never set in a PTE's access mask: PTE formats cannot express
- * no-read, and x86 rejects protection attributes that forbid only read
- * (kvm_arch_mem_attributes_supported_prot()), so a no-read gfn always
- * takes a memory fault exit before any SPTE is created.
- */
-#define ACC_READ_MASK    BIT(3)
-
 /* The mask for the R/X bits in EPT PTEs */
 #define SPTE_EPT_READABLE_MASK			0x1ull
 #define SPTE_EPT_EXECUTABLE_MASK		0x4ull
-- 
2.50.1

