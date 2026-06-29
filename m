Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821B3932E9
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713289; cv=none; b=KYckvSuPJBeJqoYDCP+pEFEMA4rJy852uIAB+VgXeFaCf+IoHJ2ADD6E8p4GwZYeoSCmZFpXsewGZlgMIp2Gc/gtm7g/ZvhHq9fTqgIWgvfhbzNscnUTLUWOklK8mt+I0u9qgGyFZ2WUe1IRn6TAhW0C5sZ9pPvIBouiu6o5PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713289; c=relaxed/simple;
	bh=zcDGs6CpQoLyiosUb0Uax13IVV3IZF3htq7pYx8d1BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coII7lu7UQfkBu028Hyp5W8wJWpHYw+ZYmDZzlbj33VQh1ry3a8nj21Lqid1eAmXfd4R3Qdfh0WfdtqhLyEN3WTzrxqybqzGqB5Ca/fS2q1LjUyg+9JtE74O7eXEYwW8N/3fy/KZajux4ZJaFq9yKKFteM1gPM79DGm5J/rGCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxHZOMLJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxHZOMLJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxHZOMLJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxHZOMLJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FAEF72F0A;
	Mon, 29 Jun 2026 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXPK35OTcxbrAHElJ+R7ax1ys2YK+EbeeL4YKvGLUyA=;
	b=QxHZOMLJWLU35HhoMaFNdFM8jjMhlRi5IROqWkUMC4D16i9JhxueMIG8s/bVolijeBfJ5g
	LYtUqnlGgWHTyvcLHiV7rC8BWy/jy+XgV6L6Q7YycxLnnbvAeVHIKHrLExLnHQ71yNq7sG
	E70E1AwBo7QpmDUpjS0ErboAYMMumck=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXPK35OTcxbrAHElJ+R7ax1ys2YK+EbeeL4YKvGLUyA=;
	b=QxHZOMLJWLU35HhoMaFNdFM8jjMhlRi5IROqWkUMC4D16i9JhxueMIG8s/bVolijeBfJ5g
	LYtUqnlGgWHTyvcLHiV7rC8BWy/jy+XgV6L6Q7YycxLnnbvAeVHIKHrLExLnHQ71yNq7sG
	E70E1AwBo7QpmDUpjS0ErboAYMMumck=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E728B779A8;
	Mon, 29 Jun 2026 06:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PTsEN8QLQmrwEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:08:04 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 27/32] x86/hyperv: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:18 +0200
Message-ID: <20260629060526.3638272-28-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
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
	RCPT_COUNT_TWELVE(0.00)[14];
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

The 32-bit MSR interface rdmsr() is planned to be removed. Use the
related 64-bit variant instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/hyperv/hv_apic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index a8de503def37..95f1782d1e17 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -60,17 +60,15 @@ void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
 
 static u32 hv_apic_read(u32 reg)
 {
-	u32 reg_val, hi;
+	struct msr reg_val;
 
 	switch (reg) {
 	case APIC_EOI:
-		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
-		(void)hi;
-		return reg_val;
+		rdmsrq(HV_X64_MSR_EOI, reg_val.q);
+		return reg_val.l;
 	case APIC_TASKPRI:
-		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
-		(void)hi;
-		return reg_val;
+		rdmsrq(HV_X64_MSR_TPR, reg_val.q);
+		return reg_val.l;
 
 	default:
 		return native_apic_mem_read(reg);
-- 
2.54.0

