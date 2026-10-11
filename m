Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAC466B66;
	Sun, 11 Oct 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758065; cv=none; b=ukbashPB0sd5ZcfPtp9hqyPacsbaIfBDFinfwD76G+EU+aGHqCwCFNMOODFRiV8tONMsUjw0TH4xm0kmJUUqc0RcrWpXNNIfCoEc8TOKrP7de2YrFLekhn24JE5MFf+IulHHSHTuESuwY2v4DLdE007rAdY6NbYVSYP3Ah2DoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758065; c=relaxed/simple;
	bh=vKHfQJH7q8NsLRwBDeVe3ncyqb8RyOUGpEadzNk2PgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uc1vfPXMgYk7eLL3dJitLa4J3QVErUC0VbfiLAFM+WzRldHhlRfb1Luv5n9MtxkSXebT0lAjT3BjnwkJt6xqbVZtbtQbKqPUzwnghnGa3RrrIc3wRctXIYfl6vd61Q43rfKlQr8hgtouPdwXUcaaL5VtKukSiovUEEYncqARxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ3wBnZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ3wBnZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F59A1F0089D;
	Sun, 11 Oct 2026 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758064;
	bh=pBF0WeX0/lVbx/8CGIC1rTeqX0LSx6Yl8hI9Hq/vKlU=;
	h=From:To:Cc:Subject:Date;
	b=UZ3wBnZXoSh4sztMcQe++jJPR4XJw5k5jFVq0fZdiIV8t8Dza4uR/7qexL1URNSHQ
	 Enb2UX1AKFTeubYZd7xXvHRufj+aJV+wq+nsSal5GpvFK6zAFRglJ/VTtkKk6/EFpa
	 c+UwdYrVR2AFzWFjoQxtzIqxria/DJA+9InakCTzwP2m8NNeWgSOTZWnHN2sHZO1ou
	 uYx338dkJZwKtJSOSUWAZ7admkFLD3eH538S3e2Fm2mk1fggSyLKCcKcVRo0v0dw1a
	 Kb23MWai8bqucLRlRiTLY3bFLLP1Uk4eip9ooVj1gjIeAy1OgWwsuur9oyNtI3NoYx
	 OtMBuR7sGISlQ==
From: Sasha Levin <sashal@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mary Hardy <maryhardy@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] tools: hv: remove unused rte_smp_mb()
Date: Sun, 11 Oct 2026 18:33:40 -0400
Message-ID: <20261011223358.2327625-12-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rte_smp_mb() has never been used, and its "static inline __always_inline"
declares inline twice, so clang warns:

  vmbus_bufring.c:61:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
  vmbus_bufring.c:62:1: warning: unused function 'rte_smp_mb' [-Wunused-function]

Remove it.

Fixes: 45bab4d746510 ("tools: hv: Add vmbus_bufring")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/vmbus_bufring.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
index bac32c1109df8..23542e59a2ee9 100644
--- a/tools/hv/vmbus_bufring.c
+++ b/tools/hv/vmbus_bufring.c
@@ -58,12 +58,6 @@ void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
 	br->dsize = blen - sizeof(struct vmbus_bufring);
 }
 
-static inline __always_inline void
-rte_smp_mb(void)
-{
-	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
-}
-
 static inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
-- 
2.53.0

