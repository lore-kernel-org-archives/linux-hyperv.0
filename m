Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822A3AFB0E
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907298; cv=none; b=bgUISgd7bPYZh4Rwd8OApCrAvDv0uKzG3SBMpHakl/KK8jrD0GSIgO3Src3X4faFMtUJCzAtj2tBfHewHksZQ6/w6/103YcMo0PJU8hoAFcjzo2GxnCsPsAcXQzRLQDL92fZbFv2GjvoLHjgVRmQ+huzw0Wc3xHYGlUrPWiJG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907298; c=relaxed/simple;
	bh=3IWkNXs4VOtxIOyhly4DbSR9nbuTpzdMQfxLXBFTrIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhTcOGCUB8ZvI48M4oVnj5ykIb4E9bLvTO0BztQOVHsq7NFFPAbwoaykdyRZFM4sCVPi/EUVaHVSAECxPYuLC2g1zthfZGTs3MG3kTqpNTd55Ky7wNpe+7vBvpRg8dP6dH6LHwa/q9WlPtG+g6+8uJZkNd3rZ9BcD7wWqenQAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bZEckIRP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bZEckIRP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bZEckIRP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bZEckIRP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65D097598F;
	Mon,  8 Jun 2026 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9nnT1byeKutvEwj88/yibfTfL4W6aDMf/O3dkcZbw78=;
	b=bZEckIRPjGBoJDFYIvFnli5JebdXD6WQzuzrWgvgQXtlJBbC832jWYNw9o2a3vj0pjA8sX
	Fe9GQChffXSpJ232XBhMfwgImbEv753I38ONuqerzCmv7xa32G2DX+L3DfTrd/suHRsaKx
	K4J/dZJnsqnIC0scANI3GodcFHExNQA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bZEckIRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9nnT1byeKutvEwj88/yibfTfL4W6aDMf/O3dkcZbw78=;
	b=bZEckIRPjGBoJDFYIvFnli5JebdXD6WQzuzrWgvgQXtlJBbC832jWYNw9o2a3vj0pjA8sX
	Fe9GQChffXSpJ232XBhMfwgImbEv753I38ONuqerzCmv7xa32G2DX+L3DfTrd/suHRsaKx
	K4J/dZJnsqnIC0scANI3GodcFHExNQA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DB49779A7;
	Mon,  8 Jun 2026 08:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7GWBIRt9JmojSAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 08:28:11 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Len Brown <lenb@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 0/4] x86/msr: Get rid of rdmsrl() and wrmsrl()
Date: Mon,  8 Jun 2026 10:28:05 +0200
Message-ID: <20260608082809.3492719-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 65D097598F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[suse.com,infradead.org,redhat.com,kernel.org,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,amd.com,microsoft.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

rdsmrl() and wrmsrl() are deprecated aliases of rdmsrq() and wrmsrq().

Switch all users and remove the deprecated variants.

Juergen Gross (4):
  x86/msr: Switch rdmsrl() users to rdmsrq()
  x86/msr: Remove rdmsrl()
  x86/msr: Switch wrmsrl() users to wrmsrq()
  x86/msr: Remove wrmsrl()

 arch/x86/events/amd/uncore.c          | 4 ++--
 arch/x86/events/intel/core.c          | 4 ++--
 arch/x86/include/asm/msr.h            | 5 -----
 arch/x86/kernel/cpu/resctrl/monitor.c | 4 ++--
 arch/x86/kernel/process_64.c          | 2 +-
 arch/x86/kvm/pmu.c                    | 6 +++---
 arch/x86/kvm/vmx/tdx.c                | 6 +++---
 drivers/hv/mshv_vtl_main.c            | 4 ++--
 drivers/idle/intel_idle.c             | 6 +++---
 9 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.54.0

