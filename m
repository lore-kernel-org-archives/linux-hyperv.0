Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5E2C2360
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716186; cv=none; b=WE9Q3oqaOjV7QFtHz8Z3iW7zBcwAdQUbLBVsk3PLuXBG/N+0gHzxDaodsuyUSlpOKkKjMSnauK7wnS3F97cI/ykDVrtH75Lj+XdIY0SxomaC8zlGIycneu33ii4CuFlmXEWG6y16W6MJkHpM9RPhPt8FO9iSgMVpR8GhO6x8qMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716186; c=relaxed/simple;
	bh=8IIZrd//25j4YR+57PmNv8C3RHMtTZNIgkaMld62H6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+RjBw56QReRIEY/p+G/S/0Kkk4Hq88/R+tTsOGFdE0eGeidfogbxHSJxCNCurm/+RVEyUcqA+xBOfpSPDvaBStnj/pahfyMN6lJBa9U04lPDiMi7ZdSrced6Ku+d7q6qwbfmNPPyDkBoVtVaQ8+WDQRGtG4Iq6AzNw9yUgMlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZ1Ujojy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZ1Ujojy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fZ1Ujojy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fZ1Ujojy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6FCD75D0F;
	Mon, 29 Jun 2026 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZISdsO4tS1HYtt389XqwCLy1XlYy1EGwYtxAQJSbvu0=;
	b=fZ1Ujojy61n2f3PXe8bKe8wngualNNaJL8FY6HYelt8Nxf20iVBEKaEY8b51RVzt1g2zJO
	B5eb/Y1Q8SRU4Ca5vIDbHMNhricx5ynfsPIbOVAOs8hIrjTdia3hA57aAX3kBI5/TrJanz
	MVxAxI2B/Wbo6txcFzwrlDtNLvgOA90=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZISdsO4tS1HYtt389XqwCLy1XlYy1EGwYtxAQJSbvu0=;
	b=fZ1Ujojy61n2f3PXe8bKe8wngualNNaJL8FY6HYelt8Nxf20iVBEKaEY8b51RVzt1g2zJO
	B5eb/Y1Q8SRU4Ca5vIDbHMNhricx5ynfsPIbOVAOs8hIrjTdia3hA57aAX3kBI5/TrJanz
	MVxAxI2B/Wbo6txcFzwrlDtNLvgOA90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CA49779A8;
	Mon, 29 Jun 2026 06:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6Y6ERUXQmq3QQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:56:21 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 06/18] x86/hyperv: Switch from __rdmsr() to native_rdmsrq()
Date: Mon, 29 Jun 2026 08:55:32 +0200
Message-ID: <20260629065544.3643253-7-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629065544.3643253-1-jgross@suse.com>
References: <20260629065544.3643253-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -6.80

The __rdmsr() helper will be changed soon, so don't use it directly
outside of msr.h. Switch to native_rdmsrq() in HyperV related code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602182222.WEBLSQRj-lkp@intel.com/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch (kernel test robot)
---
 arch/x86/hyperv/hv_crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 5ffcc23255de..28ee76e18d9b 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -217,9 +217,9 @@ static void hv_hvcrash_ctxt_save(void)
 	native_store_gdt(&ctxt->gdtr);
 	store_idt(&ctxt->idtr);
 
-	ctxt->gsbase = __rdmsr(MSR_GS_BASE);
-	ctxt->efer = __rdmsr(MSR_EFER);
-	ctxt->pat = __rdmsr(MSR_IA32_CR_PAT);
+	ctxt->gsbase = native_rdmsrq(MSR_GS_BASE);
+	ctxt->efer = native_rdmsrq(MSR_EFER);
+	ctxt->pat = native_rdmsrq(MSR_IA32_CR_PAT);
 }
 
 /* Add trampoline page to the kernel pagetable for transition to kernel PT */
-- 
2.54.0

