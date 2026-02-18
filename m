Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6830F94E
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402899; cv=none; b=G6gajfRUCZRtrZCYaaNknbKUpy8/fjCEAJ4vfFfwRfliBsJ0Hg/F3iKnlA4abzEx2zB/7SkQlYqB8KCj2S3Qqf41+js9Vpz3dJSBglshNssTknjU+OlRO+ESjDtxgrLrV7zuBrvxH4brtqgElPV85ftSdhUdEi9CfwpCVC8rRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402899; c=relaxed/simple;
	bh=7UHy5f1T56MQ+JimHqC6iTJ7VajkraClBQb0A4F7qpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNi9xYqXBZ1RGwmpBLEyJ73V6vdTKVg/KqMNPAvGlCLMYpTse++V7ecf1jyjXXMXKlXkw0ZsCJLGmEXRxYGpFfzOXZet//ogyWbPmQtty6pubWSkmyYd4k5fP/Xv9t0JAxhHzeSWs+Fven2eg9X5j2F7jqTeab/b5Iyk3WMiLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mumQ2dSr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mumQ2dSr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mumQ2dSr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mumQ2dSr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5925B3E6D0;
	Wed, 18 Feb 2026 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771402896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OYoDmUH9lbkTBURMFRYZYYI6iouhuBtpfCapQgEqDZ8=;
	b=mumQ2dSroxqx6zt+Ap8HTM0DwIHDjYg5G2rkTfGqr0XF50J9oS7P1iax3mkDWYDGIX05mq
	VX/pMUcA0pFYr7ZTj5XfgBOOOEBabHE1Wg4S0+rOQYd/osFxFh8Tnl1dVhywbfaL5k3mSq
	YTambJKAYcAGVGpkGonRfwPP/SogtlM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771402896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OYoDmUH9lbkTBURMFRYZYYI6iouhuBtpfCapQgEqDZ8=;
	b=mumQ2dSroxqx6zt+Ap8HTM0DwIHDjYg5G2rkTfGqr0XF50J9oS7P1iax3mkDWYDGIX05mq
	VX/pMUcA0pFYr7ZTj5XfgBOOOEBabHE1Wg4S0+rOQYd/osFxFh8Tnl1dVhywbfaL5k3mSq
	YTambJKAYcAGVGpkGonRfwPP/SogtlM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893403EA65;
	Wed, 18 Feb 2026 08:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HcFZII92lWkvHQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 18 Feb 2026 08:21:35 +0000
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
Subject: [PATCH v3 00/16] x86/msr: Inline rdmsr/wrmsr instructions
Date: Wed, 18 Feb 2026 09:21:17 +0100
Message-ID: <20260218082133.400602-1-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,google.com,microsoft.com,oracle.com,lists.xenproject.org,broadcom.com,infradead.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
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
the MSR access helpers is done in the patches 1-6.

The next 4 patches are converting the non-paravirt case to use direct
inlining of the MSR access instructions, including the WRMSRNS
instruction and the immediate variants of RDMSR and WRMSR if possible.

Patches 11-13 are some further preparations for making the real switch
to directly patch in the native MSR instructions easier.

Patch 14 is switching the paravirt MSR function interface from normal
call ABI to one more similar to the native MSR instructions.

Patch 15 is a little cleanup patch.

Patch 16 is the final step for patching in the native MSR instructions
when not running as a Xen PV guest.

This series has been tested to work with Xen PV and on bare metal.

Note that there is more room for improvement. This series is sent out
to get a first impression how the code will basically look like.

Right now the same problem is solved differently for the paravirt and
the non-paravirt cases. In case this is not desired, there are two
possibilities to merge the two implementations. Both solutions have
the common idea to have rather similar code for paravirt and
non-paravirt variants, but just use a different main macro for
generating the respective code. For making the code of both possible
scenarios more similar, the following variants are possible:

1. Remove the micro-optimizations of the non-paravirt case, making
   it similar to the paravirt code in my series. This has the
   advantage of being more simple, but might have a very small
   negative performance impact (probably not really detectable).

2. Add the same micro-optimizations to the paravirt case, requiring
   to enhance paravirt patching to support a to be patched indirect
   call in the middle of the initial code snipplet.

In both cases the native MSR function variants would no longer be
usable in the paravirt case, but this would mostly affect Xen, as it
would need to open code the WRMSR/RDMSR instructions to be used
instead the native_*msr*() functions.

Changes since V2:
- switch back to the paravirt approach

Changes since V1:
- Use Xin Li's approach for inlining
- Several new patches

Juergen Gross (16):
  x86/alternative: Support alt_replace_call() with instructions after
    call
  coco/tdx: Rename MSR access helpers
  x86/sev: Replace call of native_wrmsr() with native_wrmsrq()
  KVM: x86: Remove the KVM private read_msr() function
  x86/msr: Minimize usage of native_*() msr access functions
  x86/msr: Move MSR trace calls one function level up
  x86/opcode: Add immediate form MSR instructions
  x86/extable: Add support for immediate form MSR instructions
  x86/msr: Use the alternatives mechanism for WRMSR
  x86/msr: Use the alternatives mechanism for RDMSR
  x86/alternatives: Add ALTERNATIVE_4()
  x86/paravirt: Split off MSR related hooks into new header
  x86/paravirt: Prepare support of MSR instruction interfaces
  x86/paravirt: Switch MSR access pv_ops functions to instruction
    interfaces
  x86/msr: Reduce number of low level MSR access helpers
  x86/paravirt: Use alternatives for MSR access with paravirt

 arch/x86/coco/sev/internal.h              |   7 +-
 arch/x86/coco/tdx/tdx.c                   |   8 +-
 arch/x86/hyperv/ivm.c                     |   2 +-
 arch/x86/include/asm/alternative.h        |   6 +
 arch/x86/include/asm/fred.h               |   2 +-
 arch/x86/include/asm/kvm_host.h           |  10 -
 arch/x86/include/asm/msr.h                | 345 ++++++++++++++++------
 arch/x86/include/asm/paravirt-msr.h       | 148 ++++++++++
 arch/x86/include/asm/paravirt.h           |  67 -----
 arch/x86/include/asm/paravirt_types.h     |  57 ++--
 arch/x86/include/asm/qspinlock_paravirt.h |   4 +-
 arch/x86/kernel/alternative.c             |   5 +-
 arch/x86/kernel/cpu/mshyperv.c            |   7 +-
 arch/x86/kernel/kvmclock.c                |   2 +-
 arch/x86/kernel/paravirt.c                |  42 ++-
 arch/x86/kvm/svm/svm.c                    |  16 +-
 arch/x86/kvm/vmx/tdx.c                    |   2 +-
 arch/x86/kvm/vmx/vmx.c                    |   8 +-
 arch/x86/lib/x86-opcode-map.txt           |   5 +-
 arch/x86/mm/extable.c                     |  35 ++-
 arch/x86/xen/enlighten_pv.c               |  52 +++-
 arch/x86/xen/pmu.c                        |   4 +-
 tools/arch/x86/lib/x86-opcode-map.txt     |   5 +-
 tools/objtool/check.c                     |   1 +
 24 files changed, 576 insertions(+), 264 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-msr.h

-- 
2.53.0

