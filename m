Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AA36F8E1;
	Wed, 27 May 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909692; cv=none; b=hK2uHnJxy9a6LAQ3AN+gjO5mkEIwfsuDISmVdXYy+vzCgVELWvUJRZrx4oFEWAEObiy6hJDpV2l9TlkoINoGBFwup2t7WnMF4sISB5pKesg4aezJBAOFVvdhxY4+beAy5ejo+R2O0+FI8eH1H27RpkOKDB22foMOuQnXIHLtubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909692; c=relaxed/simple;
	bh=VJ8UZ24PwSC4r9QS4+AZK3lerpKCqRa9WTsNFVtAbMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EImmo+FIi2u3EqwCnM/1nPzek1UMLEfeBzUC1wYhTRwTwcJpuXTviEB2y1dnHctIOwB+g11KbFiETyrpvAMv844CzJs29Dkai4dC/lpd38nG3BsacuNeEG7SzmsC/FZEgOrJf/kB1rrGju3XhXWzylx8eZ1i/4E5ur4VggjQBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 6D9F420B7167; Wed, 27 May 2026 12:21:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D9F420B7167
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Date: Wed, 27 May 2026 12:21:01 -0700
Message-ID: <20260527192101.1471995-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the "64 bit" to "64-bit", and the "Os" to "OS".

Remove the obsolete paragraph since the guideline has been
published in the Hypervisor Top Level Functional Specification
for many years.

The "OS Type" is 0x1 for Linux, not 0x100.

No functional change.

Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 include/hyperv/hvgdk.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
index 384c3f3ff4a5..f538144280ca 100644
--- a/include/hyperv/hvgdk.h
+++ b/include/hyperv/hvgdk.h
@@ -10,18 +10,12 @@
 
 /*
  * The guest OS needs to register the guest ID with the hypervisor.
- * The guest ID is a 64 bit entity and the structure of this ID is
+ * The guest ID is a 64-bit entity and the structure of this ID is
  * specified in the Hyper-V TLFS specification.
  *
- * While the current guideline does not specify how Linux guest ID(s)
- * need to be generated, our plan is to publish the guidelines for
- * Linux and other guest operating systems that currently are hosted
- * on Hyper-V. The implementation here conforms to this yet
- * unpublished guidelines.
- *
  * Bit(s)
  * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
- * 62:56 - Os Type; Linux is 0x100
+ * 62:56 - OS Type; Linux is 0x1
  * 55:48 - Distro specific identification
  * 47:16 - Linux kernel version number
  * 15:0  - Distro specific identification
-- 
2.34.1

