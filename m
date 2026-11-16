Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854379;
	b=03JiXKHxQjSDS0BhriNDpDYZr2M+/hBd2xnesQCjKEYFYfw5+ZAGDGUC0a4Sr7kp+Sc1
	 SXpfxRIrKBlSs70bRNWuGqnG95iuTvDKs+ii9FVo9w0T629wbnGUxxrtPlcIgaQhGES0R
	 4yznGtYXGDSyjqY6iJoz2XMIVd6kBw4C1JBy7Ju4OUVPtQlQsjuo6BoAf1bkUC5HfJZtf
	 QpM23zAtxzc3+eDSJHAMDRERuIwzCq2qWbjs1yf30b3571mJyZfpkTzd87biZbXVy0HPe
	 LDSw1vAkQUh9hZlCiSrJyX0m3INou+hCJIVQX5y4zE5TxNAza8I/gx9HmxZzp7ezarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854379;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=bI98jE4ZYQJp9Otfps+VYEldIz/18aujxstmdyqsy7U=;
	b=flRun5EP6BM/7SccnswNrZy669/Qs5xtgpPWCUAAWehl41eiCW/1QfF0DMeqJxdIdtui
	 5B1PNAxNz2l1m5PNALWUL8zO4b0tA6cLUimPC0vdewUd3ooY87/Zk9811gxxJBKkvhlaa
	 0kJ9FQt5Ax8+fm+7hKaSP8QYConjHKfHGe7D2fPNmZEbwOlHsv2o//nFwP8N74X5jzABp
	 ORs/MDSzbUzNeyfZBRJDt7IFvkyrKfAZpowjSR5AK0CV17/RhlZtHXUUAmfHt5r6wnzB2
	 nxeEZLgeOrj940/e4ouccQYskduOW29paYAv8VAPRHuUOKKTB0Ff1h972hBB1Nz5ZZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=hGKSXQCO;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=hGKSXQCO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33433606A31C;
	Mon, 16 Nov 2026 18:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33433606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=hGKSXQCO;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=hGKSXQCO
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACAE522321;
	Mon, 16 Nov 2026 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bI98jE4ZYQJp9Otfps+VYEldIz/18aujxstmdyqsy7U=;
	b=hGKSXQCORo2Lb/lhy1tPOxg7MOLBO8uikvbvpuaG/zmbg/Q5pvXdfsjpg4uwA2lsX4Kf+B
	VU8+A7sAbjPekBgiGhrn0t+Kq/g5KKLyeXDzhsGwW89FofanEjDGR8e7SwFGDnvcir7hhp
	4DIUz78cd3yQGuRY1h/IQ+6VB4LA1fg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bI98jE4ZYQJp9Otfps+VYEldIz/18aujxstmdyqsy7U=;
	b=hGKSXQCORo2Lb/lhy1tPOxg7MOLBO8uikvbvpuaG/zmbg/Q5pvXdfsjpg4uwA2lsX4Kf+B
	VU8+A7sAbjPekBgiGhrn0t+Kq/g5KKLyeXDzhsGwW89FofanEjDGR8e7SwFGDnvcir7hhp
	4DIUz78cd3yQGuRY1h/IQ+6VB4LA1fg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 308231334C;
	Mon, 16 Nov 2026 18:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRH9AelN+2qrdwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:39:37 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 05/17] x86/hyperv: Switch from __rdmsr() to native_rdmsrq()
Date: Mon, 16 Nov 2026 19:38:53 +0100
Message-ID: <20261116183905.1591611-6-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116183905.1591611-1-jgross@suse.com>
References: <20261116183905.1591611-1-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:email,intel.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80

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
2.56.0

