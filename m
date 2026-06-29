Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68B3A169F
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716151; cv=none; b=Cmp8xPZp3XzT35bc/VINWmAZMRP6O0UeqGiKEdIYlYlLMZ82VNvpl+JyX7KsRHLP1fQq5dAWipcnOPbzEIiNQI7/51MLva0GsuaQ1Q0Lc8D0Gzkv6TnPc9tfJwl1Ra5i06Cd6i6FS2bUksEiOpJf6yoCGF86Bbl8/K3X1Yainqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716151; c=relaxed/simple;
	bh=qGcvi24MVj6w1CL6DpoKlLc0989nRw/aL4d11/Tw5HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJEtrsOLGHGe22SNv1JgsAWp5INNIFhxgz8ocZmnWjmfyo0tlM1pP5mwVy6FRXqpC4YLBAPpXrpUCPUwwiD/4zVjIgsgS1kXqYqDS6q4bFCaPKlcppqGUBEgxUpiAAOEj/C5koBDsms/VFDPDEMtPSa4Iw93wisKSLd5xmzY8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z+D/qS+Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z+D/qS+Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z+D/qS+Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z+D/qS+Y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05C8275D0F;
	Mon, 29 Jun 2026 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BAupgZB0PJ1OqcpHo6tTgs6hcfKTzlVTTaz41IYB01Q=;
	b=Z+D/qS+Yw2rCgWCjViQmH/IbgyCidWrcLjn6j4Eqnyex37TFnfj3QGPpcG+MRBnSU+4eVT
	5buEr7Harwt4J/6W9JFtSA4Yti0vaAZtta9ceDeQic88uFsvFZedKIT2XDw1bz08qreUrL
	CLvALcSjtYTyU1YoVkY7rXgrRLpOboQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BAupgZB0PJ1OqcpHo6tTgs6hcfKTzlVTTaz41IYB01Q=;
	b=Z+D/qS+Yw2rCgWCjViQmH/IbgyCidWrcLjn6j4Eqnyex37TFnfj3QGPpcG+MRBnSU+4eVT
	5buEr7Harwt4J/6W9JFtSA4Yti0vaAZtta9ceDeQic88uFsvFZedKIT2XDw1bz08qreUrL
	CLvALcSjtYTyU1YoVkY7rXgrRLpOboQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA25779A8;
	Mon, 29 Jun 2026 06:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7iBnAfIWQmqKQQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:55:46 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	llvm@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v4 00/18] x86/msr: Inline rdmsr/wrmsr instructions
Date: Mon, 29 Jun 2026 08:55:26 +0200
Message-ID: <20260629065544.3643253-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,google.com,microsoft.com,oracle.com,lists.xenproject.org,broadcom.com,infradead.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

When building a kernel with CONFIG_PARAVIRT_XXL the paravirt
infrastructure will always use functions for reading or writing MSRs,
even when running on bare metal.

Switch to inline RDMSR/WRMSR instructions in this case, reducing the
paravirt overhead.

The first patch is a prerequisite fix for alternative patching. Its
is needed due to the initial indirect call needs to be padded with
NOPs in some cases with the following patches.

In order to make this less intrusive, some further reorganization of
the MSR access helpers is done in the patches 2-6.

The next 5 patches are converting the non-paravirt case to use direct
inlining of the MSR access instructions, including the WRMSRNS
instruction and the immediate variants of RDMSR and WRMSR if possible.

Patches 12-14 are some further preparations for making the real switch
to directly patch in the native MSR instructions easier.

Patch 15 is switching the paravirt MSR function interface from normal
call ABI to one more similar to the native MSR instructions.

Patch 16 is a little cleanup patch.

Patch 17 is the final step for patching in the native MSR instructions
when not running as a Xen PV guest.

Patch 18 converts the rest of the MSR helpers to __always_inline.

This series has been tested to work with Xen PV and on bare metal.

Based on [1] and [2].

Changes since V3:
- Rebase
- wrmsrns() related changes (patches 9+10)

Changes since V2:
- switch back to the paravirt approach

Changes since V1:
- Use Xin Li's approach for inlining
- Several new patches

[1]: https://lore.kernel.org/lkml/20260629060526.3638272-1-jgross@suse.com/T/#t
[2]: https://lore.kernel.org/lkml/20260629063943.3641266-1-jgross@suse.com/T/#t

Juergen Gross (18):
  x86/alternative: Support alt_replace_call() with instructions after
    call
  coco/tdx: Rename MSR access helpers
  KVM: x86: Remove the KVM private read_msr() function
  x86/msr: Minimize usage of native_*() msr access functions
  x86/msr: Move MSR trace calls one function level up
  x86/hyperv: Switch from __rdmsr() to native_rdmsrq()
  x86/opcode: Add immediate form MSR instructions
  x86/extable: Add support for immediate form MSR instructions
  x86/msr: Make wrmsrns() a first class citizen
  x86/msr: Introduce sync_cpu_after_wrmsrns()
  x86/msr: Use the alternatives mechanism for RDMSR
  x86/alternatives: Add ALTERNATIVE_4()
  x86/paravirt: Split off MSR related hooks into new header
  x86/paravirt: Prepare support of MSR instruction interfaces
  x86/paravirt: Switch MSR access pv_ops functions to instruction
    interfaces
  x86/msr: Reduce number of low level MSR access helpers
  x86/paravirt: Use alternatives for MSR access with paravirt
  x86/msr: Make all MSR access functions __always_inline

 arch/x86/coco/tdx/tdx.c                   |   8 +-
 arch/x86/hyperv/hv_crash.c                |   6 +-
 arch/x86/hyperv/ivm.c                     |   2 +-
 arch/x86/include/asm/alternative.h        |   6 +
 arch/x86/include/asm/fred.h               |   2 +-
 arch/x86/include/asm/kvm_host.h           |   7 -
 arch/x86/include/asm/msr.h                | 340 +++++++++++++++++-----
 arch/x86/include/asm/paravirt-msr.h       | 180 ++++++++++++
 arch/x86/include/asm/paravirt.h           |  45 ---
 arch/x86/include/asm/paravirt_types.h     |  57 ++--
 arch/x86/include/asm/qspinlock_paravirt.h |   4 +-
 arch/x86/kernel/alternative.c             |   5 +-
 arch/x86/kernel/cpu/mshyperv.c            |   4 +-
 arch/x86/kernel/kvmclock.c                |   2 +-
 arch/x86/kernel/paravirt.c                |  42 ++-
 arch/x86/kvm/svm/svm.c                    |  16 +-
 arch/x86/kvm/vmx/tdx.c                    |   2 +-
 arch/x86/kvm/vmx/vmx.c                    |   6 +-
 arch/x86/lib/x86-opcode-map.txt           |   5 +-
 arch/x86/mm/extable.c                     |  46 ++-
 arch/x86/xen/enlighten_pv.c               |  52 +++-
 arch/x86/xen/pmu.c                        |   4 +-
 tools/arch/x86/lib/x86-opcode-map.txt     |   5 +-
 tools/objtool/check.c                     |   1 +
 24 files changed, 641 insertions(+), 206 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-msr.h

-- 
2.54.0

