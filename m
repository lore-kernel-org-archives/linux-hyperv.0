Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C683D9DDB
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654599; cv=none; b=MjtxStNLyS7XXzO0sDtVqUbrHAHavOsay2I0HYEKsCT0xZxZFcYQGjwgmhqVzrovOWutPVNBDxWOB7COWfX1AlOSSTZLQEhqc1vm7CrKCFDjWTH2451RT5vrDFLXyQp25frw4NnPV0sInrz+IyCr0UBIWdprWZNs4Tz0eWaI/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654599; c=relaxed/simple;
	bh=hwzN7aNlJ2wxS9ZWnQFgLPxc8hv3AZhs4ribMUFVqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfMrP/W3lRiKJuquqt1KtLJynLvWVPed0FxhoILWCVBV9OprQQHdhXa9Rf38q1v8DiKcFObhS4uVpEhbGC41yx15Bx9bRT2cv/ORL5SEhEo+ZIZ9/4Dnk5t7mGj/bmp5gBBzEj2haB3KYbuaJT5aQCERSxr4lx/wgoJGXDcUFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J2pFgVBZ; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J2pFgVBZ"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-86a686c0fdaso901157b3a.2
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654597; x=1791259397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=uuhU2l5PajxaQ+I2s4yDQX0m+2PBbwowYAZTKjCNubu7M9bVQcgGwoQ284/9sw96Lj
         6awXhCgryN3Ddyo1DHeBT1TAxvXSkQffvp2uxIu/Cs42liMMvwdscWsGPTWjHNxVCZEP
         +tlB0hoBM4rsKQtU6ZWFIoNkEvCQ4E6sYVJEKVqu7IqR/iz/LFM/h5QgEWbvA13LaxAy
         7+EWRciNEJppJGczmtZK3+XHMf2pLprn9QQl41imNTwaNZHz4y0CcB71d/qZmybVW7A/
         TGWW4laamV5FDyBKaPDpu4H2pBkZYQYLdYmpCbNCnkFL75V81J6u0wi4B4F6/ZR1qfqz
         G3Pw==
X-Forwarded-Encrypted: i=1; AKwUvByflhMAu7UfNZ9nG0uWKe6PStJ+U8JpAlNGemh/lANAgRwWZkBea5We/Jig9BumqDiKs7+YtRXdyhMOeQY=@vger.kernel.org
X-Gm-Message-State: AFuF++mvcHDsdKaV9eg4KfG9Kq8Tl1Yz9U9hPJ+mChnTEiXXEEj9Ro48
	rFrlQ430yZGAiJJKsLXDp0NLrLP4HO+cgVbTXq7kQh5sq6zT0TTUK0TLYZBySSGeQYn37Lc488k
	vfCKrLRmvbJl4cvpBIZcmjFiPm611iw90I6Ex6O1sq+RZXOwDu5Kd+vjbAJYtTxxZSEovSXjHXb
	ZFmLDZGovq0ImVVgZsd57XcANxIRQGyy/pnWKLpAfsfWf2W6ykmtsK5R3YlGD4kEZw1keJlsw9Y
	AdQcQ7PdQm7Z3K/
X-Gm-Gg: AYBFou0S/poRecUSvMC2cZh6YOc67Tv1CRigvVMX3ZoVsIF/3RzqmbnFDcJSnOtuMzG
	27ZR+MRmLaOpIWuXcs+9u8b7kl51l5fergD6yACkhyJsWKQWyQXYFop+rWhP73vJujlQS3d1HdG
	lpd+yM5GJvzs3WhEXV/M56U7JyPnXBvM0eWvvgl5U7tHTNDa6rlivMzOnDiT+hQFdPdjyLlkHZv
	B04wyIGPyxnMIomZ1NeerOMSUqhh4r7N9ICL0NrlCL2dzu5Mq1G+b63G2Eaf8Y0m6XKR8hdWyux
	tzBy80Ng5IBjUAYMr0UEsnOdq08y1CfP/lSM130hKA038TU9VqQ8Jh3JzJFcd9uScI5FebEIiME
	uDrbhdc2pPDqai0JD1Kp1AhngIvj9tN36ZT3ZexfaJQAiFce/Pq3TRrR0sjnVfzvz1TH5hc2LNk
	gWolGxJ/3TYjHZGlQyxwZVPrk/QdTo95Y1rb0=
X-Received: by 2002:a05:6a00:390b:b0:874:705d:f659 with SMTP id d2e1a72fcca58-87e9b3b6543mr11283234b3a.39.1790654597320;
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-885dc1000c6sm100867b3a.0.2026.09.28.21.03.16
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33baaba6371so14196778eec.1
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654595; x=1791259395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=J2pFgVBZHM/fAYXBIqK0/AZxOq/6YSGIL/qKx8D5ACk4THDMXEn+y7CpCzCt8uAWke
         pNQfQ3sU+6Kte5+o+X5ITV615SfqaNQ48T1lR1rglF81HJ+VpKIsc+yJM51g9tVqknPx
         w3kg3JpDvpGwrexpl/4noHhn+sLyrJTgrO3HA=
X-Forwarded-Encrypted: i=1; AKwUvBzdTqu4Sz11CiVxaw1RNKRaKoNwZFN8dVzoWJHEB3s1P79cB6HdJruLeY+xUpkwN2ltfiGXBsojsZ2H7Q4=@vger.kernel.org
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863818eec.8.1790654595191;
        Mon, 28 Sep 2026 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863746eec.8.1790654594365;
        Mon, 28 Sep 2026 21:03:14 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86 encrypted guests
Date: Tue, 29 Sep 2026 00:02:51 -0400
Message-ID: <20260929040256.543767-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
definition and placement, and provide page-aligned boundaries so the
architecture can convert each CPU's whole section before registration.

Define the boundaries in the SMP template or UP data as appropriate.
Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++----
 include/linux/percpu-defs.h       |  7 ++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 64bc2bfdd2ec..145fcdbbe9db 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,11 +368,13 @@
 /*
  * .data section
  */
-#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#if defined(CONFIG_X86_MEM_ENCRYPT) && !defined(CONFIG_SMP)
 #define DATA_DECRYPTED							\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..decrypted)						\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define DATA_DECRYPTED	*(.data..decrypted)
 #endif
@@ -1022,11 +1024,13 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..percpu..decrypted)					\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define PERCPU_DECRYPTED_SECTION
 #endif
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..fdb666a1b4de 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -169,13 +169,10 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
- * Declaration/definition used for per-CPU variables that should be accessed
+ * Definition used for built-in per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-#define DECLARE_PER_CPU_DECRYPTED(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
-
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
 #else
-- 
2.53.0

