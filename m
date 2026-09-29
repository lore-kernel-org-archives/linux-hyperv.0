Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C143E2773
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654595; cv=none; b=tyVYpb1HQLazuNwOwO70DOOxOpcVuX+xwtaOewpryxPe+7IgwgYW8T+xModWQDz5I9hgcgOsM2F8Vo7PjPq8d/75hUWDsAAv+e709kvLsg1cvJn3aQRPv8yZ6vYotp/3snNTQc7qzxc80Q9k+AO4Z7vMk9mETaGrKAveiz0EWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654595; c=relaxed/simple;
	bh=wfxZIiWhDP3+oFPqhctMkZvaOYbsAemH2FvdQjYIm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqsLEwoD65hF7PvnunYSZfwtzXm9sgl7XqIZ+pp2GLj5s1EySL+6Cqe8Mr1cJgxhncA0v0pGKIsZpnbfv3qr22xaWmrPAh1O6V6eSiTJRKrKAu4FaRohDyFwNYs7Ja608eVPV08GjgvuqClpVVUKBme6PY44P8zAzxk5hiXZkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhItftJA; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhItftJA"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-861145fc841so6018867b3.3
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654592; x=1791259392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=DwBY1VVQkzUVubtnDfrwHZRVMLgkDPvhi8eHFB1dCjSBNgUnK83kgoV7abZjEP8SH7
         ZkDG//xTV7gnvQsZjDc3EnUS3yv2hRQK06lyWef+HVUPJgBrtTx05NjbJ4E+XzC4QPRj
         WzKwueMAa7Ug++AdtHO3sYD852ouCjeazr+VL5Gi1FWAa4937jiewkDQSOU5c2tmSgj2
         wrSNOBvvlReUFgk+ErTV/yAe2aTOkmPVKcnznUJejrmSBzwSZAGHznklW8DL2WLeTI7G
         P20bhumhj56ol4DKGGkh9FLV/bCpqt26Z4x8HkpoIIsCQKsnlJnIR56AqGdWSUd2VB/z
         ZwaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/FtSnLH9WS4w/Vr54hThfR+jLsDqQG9zLtpOwx0zwc5p0ZbpitadeGScbfEUqYejAi0S8dO9Lm+7pXMY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr3LHGTi13AWQP7PKXrq4i8upkqlD7JVsVajjTB4qzFQVIXhge
	86VIviJarWWius7BNZoLYNXW7CqzlrnOHLjhAKommAWgOTPOwoqwjr/137QPnJItrqmKwdTsD6+
	8IpiESAK+huKNusctQrBzwZvC4cvKND+fbReVaUQ9pHsikdkVMOweVAZcHWeAlSst79eMMQeX9M
	3JsYGlSBYM2DtCtGMzsyBNCQ3xv+eNFmclPkJkVetB2ce8YV/umFssYeX5K8anW6ecPA1iSR3LO
	leu2lqbfDp68caB
X-Gm-Gg: AYBFou0oBHyJIDZk+CskQOCkUnAZfK9nahKojfyaxv2+vP1vIwosxMjwaDGejHrqAp6
	XYAw4gTePxwfrrv09BciSInuvY2v/4GZNXg/qe2DneeybTp+clI2vSNcWNBr2bI0SdbIXNvJu3S
	8nKQeI99ub3Jc12AL5GNfKUr72HgTDSbVm6YuGFUWl0Ef/4BuE5bMplRZYuOLgtoCIkQXvvGtGK
	fbOMBpFl67BmNuPaFJTWk/nA6b0VKuAdkpwlFTfET5cRoETtMEFWJER5mMR1Fe1fWoabQDSvndx
	GAN9bHHwzmF1Ow27TNHWi6wGM95SJcuw7dQstmDSJAxRx99aZb/fcRAQEayQqL8Yoc2GvNaTYrz
	FJ8jdjDOLUYqKujPERIYrc+BYXYhgfA28WlNyE84e03eXj9I8wUvVDrNYEGwFd1NEqZ1azbIdJX
	7cbPR+MTlH95k1se3RLMDtjVwSJGTCS12yyXA=
X-Received: by 2002:a05:690c:6b12:b0:8a8:9149:e4df with SMTP id 00721157ae682-8a89149f60dmr50393217b3.31.1790654591804;
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8ab44365319sm12627b3.21.2026.09.28.21.03.10
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so14196414eec.1
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654590; x=1791259390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=fhItftJAmbd5w4nLldXjYdujimhcBno2xM358LQIK+THcQYYx0bt6TiEyG7gjmcGLR
         tDCMg3L/hdbu05TXXFgxfWQdgxGwCtTmbKr/CGmO/TOVU0FLsjPHPaN7N110tbrJWY8/
         ADsyxvJ6pEHue+JcxGxeRU2wukWIvSLNR2IHg=
X-Forwarded-Encrypted: i=1; AKwUvBza4kATjTq3TJ1R07J/402rEZTOODTfoboA7cwYmrNIYj7YbWnBDx1ere6wrMInPCvZNex6E9fTVBpJHQ4=@vger.kernel.org
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715265eec.14.1790654589512;
        Mon, 28 Sep 2026 21:03:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715216eec.14.1790654588762;
        Mon, 28 Sep 2026 21:03:08 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
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
Subject: [PATCH v2 1/6] percpu: Page-align decrypted data in UP kernels
Date: Tue, 29 Sep 2026 00:02:50 -0400
Message-ID: <20260929040256.543767-2-zack.rusin@broadcom.com>
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

Without SMP, DEFINE_PER_CPU_DECRYPTED() places variables in
.data..decrypted. Align both ends of that section so that changing a
variable's encryption attribute cannot expose unrelated kernel data.
Keep the section in permanent data, where UP variables are instantiated.

Fixes: 000f8870a47b ("vmlinux.lds.h: Fix placement of '.data..decrypted' section")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..64bc2bfdd2ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,10 +368,19 @@
 /*
  * .data section
  */
+#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#define DATA_DECRYPTED							\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..decrypted)						\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define DATA_DECRYPTED	*(.data..decrypted)
+#endif
+
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
-	*(.data..decrypted)						\
+	DATA_DECRYPTED							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
-- 
2.53.0

