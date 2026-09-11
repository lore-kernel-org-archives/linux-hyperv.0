Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E753468C30;
	Fri, 11 Sep 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116174; cv=none; b=pZL6ml3RIUNQjNkNzr1RsESda1RVlgMUym4LKtacCIK0TTiZBFs7NibH4OjqLgSGz/AmkDbneiqD73iVAyClS8yfYYMrHEUqCfm2xd9ZgmsKTpS1H3LY/S6nK0QIaKSzLJnvQiwl97GJrG+oYJFuDjQdSSmthcVm3i3+fyKTebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116174; c=relaxed/simple;
	bh=fbK+1/Sj6lwFjOZKI6OYbemFDxoGLktcrCM7IbMQkGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tlvv6zipOp1yu7fUuIz7nbEj14EcLQA04ajjmHSUPWVmVirJ4SBlCoxPc1FEC56lX1mfGra3IQU8qqgGW+qAHD4RGJqxiUVWyFfa8G5lWUbO1oxopihUQUlIePBTRebP7OqkuklP6Dp+/z2FD3sfJ/+rHdw+2LxxpE/xr31KVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYVgKUjT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CGlwsK3o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYVgKUjT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CGlwsK3o"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FB0921B99;
	Fri, 11 Sep 2026 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3DGson/CYT5vFAnm0UUlYHb48tU7S5NLNV/kNsX55c=;
	b=PYVgKUjTKnmpr1/wTNTurf6Gf5jzgciKd2g+gg5vYDupoc+WjVoG7B0ABbjiySzDWuWbPT
	6ZmbbPlNYSU4eLy6hsONnhGtQXfVBJn95Nt66FGH9vzryLf8aOa5jGkN0BNRuBojMD8/yH
	wXVHwyPxoZdOigqXHYL98X37ROXHwuw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3DGson/CYT5vFAnm0UUlYHb48tU7S5NLNV/kNsX55c=;
	b=CGlwsK3oayH+jItiaDKo7GO5KO6mS0ebk37412C3CexDUAyTwerctFvsmYzUfcLDZzS9/8
	rSjXNWKU1NzkTudaPd8nZZX8i8px9TXyNQ3IRfy6REtGrtcdH4n/GXbikcRSEO0CwTofNd
	7yjBfLudFF/PgvzdyA3M9NJ9Egu6vNg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0DA5132D3;
	Fri, 11 Sep 2026 08:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HTfKQK/o2pdFQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 08:42:42 +0000
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
Subject: [PATCH v5 05/17] x86/hyperv: Switch from __rdmsr() to native_rdmsrq()
Date: Fri, 11 Sep 2026 10:41:59 +0200
Message-ID: <20260911084211.3149957-6-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911084211.3149957-1-jgross@suse.com>
References: <20260911084211.3149957-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Spam-Flag: NO

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
2.55.0

