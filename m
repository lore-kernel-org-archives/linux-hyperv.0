Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854351;
	b=rnkNuSdBpxyae68OCycMis/r4dVl/fet+EpKhqd1epMxlj9i9eu4mfAqgeXjDriTdkZk
	 IfDu6Xm3RUE4t5f9xtqGQXD4vHLP5PpV+nkSiRQR4TNACVkhyT21GE1ZnCk+Zd8VKjgNw
	 Oak16ibifEhZC4JMciOAUAtn9KkcoA76Z68oprd3ws3wk+J5ALZ9mwh8usnxvjaWRk5Y9
	 Rp8TI7O6uac12x0hRnoMgp4hALlGHORVYTPRV96V+uOTSFY1mi9cKTER/rKURfaxmIzv6
	 Yg/cJkbr5u0bRNXDMleX+spdMkqqr6mdZeXKDdwumfAE6N0PFFwl1KExSjKsQLHQgXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854351;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=lh0jUNpR8nhRgfOHY5r+bwbPQ9w++53XNhmx7tZ4xXY=;
	b=3ORuv7hJ2En0n/bRwsoasY7NPmuB/296u8+yZoFC99O+rS2F8ziXjFOupWvbolQcVJqT
	 GHsa3WVVDOtIDmAKrhUxpcZ38GhT13VWP3SKTTAOXnE+SKqUUvO3Mku9nzzlzIZYSJDgB
	 kzn3uRGynwlUy16R8CvypIxEsSjA35D1EKjaR2BLhixTJz2PmtnmgittnYNNZkk3zA6u4
	 A/q9POEE5CNYz3lt6Q9enSML+uwJrz3AdHNLX6CWYUlCByInQuUO2RSQJ8t6FUGbkh261
	 iXODJ9F5dLdcHzHZ6M3kxchZTGlsc0dNAc5DJ67oPMfP2i54GDRrtfsbfLe8sDRYBtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Agyb3zNw;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Agyb3zNw;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E596606A31C;
	Mon, 16 Nov 2026 18:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E596606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Agyb3zNw;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Agyb3zNw
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8133B1F899;
	Mon, 16 Nov 2026 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lh0jUNpR8nhRgfOHY5r+bwbPQ9w++53XNhmx7tZ4xXY=;
	b=Agyb3zNwVYHXMZ2/i/w8Np3lM2YYjCbXbWDz+Zd7mHdiq7J+Oq3m8JQHnFiDJmVFFGeNwe
	5vW17bI7VQ5/kUK/IzDKgK1f+UkQt+qB4p6M5Fflpn5GpBfbFq+XloQEtCvLc6ggwzopxn
	py/9RjfekEZssXeK7VSUR1FXbxPAXI0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Agyb3zNw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lh0jUNpR8nhRgfOHY5r+bwbPQ9w++53XNhmx7tZ4xXY=;
	b=Agyb3zNwVYHXMZ2/i/w8Np3lM2YYjCbXbWDz+Zd7mHdiq7J+Oq3m8JQHnFiDJmVFFGeNwe
	5vW17bI7VQ5/kUK/IzDKgK1f+UkQt+qB4p6M5Fflpn5GpBfbFq+XloQEtCvLc6ggwzopxn
	py/9RjfekEZssXeK7VSUR1FXbxPAXI0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F7921334C;
	Mon, 16 Nov 2026 18:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MmR0FctN+2okdwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:39:07 +0000
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
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v6 00/17] x86/msr: Inline rdmsr/wrmsr instructions
Date: Mon, 16 Nov 2026 19:38:48 +0100
Message-ID: <20261116183905.1591611-1-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 8133B1F899
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	URIBL_BLOCKED(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

When building a kernel with CONFIG_PARAVIRT_XXL the paravirt
infrastructure will always use functions for reading or writing MSRs,
even when running on bare metal.

Switch to inline RDMSR/WRMSR instructions in this case, reducing the
paravirt overhead.

The first patch is a prerequisite fix for alternative patching. Its
is needed due to the initial indirect call needs to be padded with
NOPs in some cases with the following patches.

In order to make this less intrusive, some further reorganization of
the MSR access helpers is done in the patches 2-5.

The next 5 patches are converting the non-paravirt case to use direct
inlining of the MSR access instructions, including the WRMSRNS
instruction and the immediate variants of RDMSR and WRMSR if possible.

Patches 11-13 are some further preparations for making the real switch
to directly patch in the native MSR instructions easier.

Patch 14 is switching the paravirt MSR function interface from normal
call ABI to one more similar to the native MSR instructions.

Patch 15 is a little cleanup patch.

Patch 16 is the final step for patching in the native MSR instructions
when not running as a Xen PV guest.

Patch 17 converts the rest of the MSR helpers to __always_inline.

This series has been tested to work with Xen PV and on bare metal.

Based on [1] and [2].

Changes since V5:
- Rebase

Changes since V4:
- Rebase
- dropped patch 3 of V4, as already covered by [1]

Changes since V3:
- Rebase
- wrmsrns() related changes (patches 9+10)

Changes since V2:
- switch back to the paravirt approach

Changes since V1:
- Use Xin Li's approach for inlining
- Several new patches

[1]: https://lore.kernel.org/lkml/20261116150208.1572254-1-jgross@suse.com/T/#md59eab1d0c8b23a3184cbab408629c86f95e8419
[2]: https://lore.kernel.org/lkml/20261116160259.1579333-1-jgross@suse.com/T/#mf22bd746d396918f2d8163541405b2222770600a

Juergen Gross (17):
  x86/alternative: Support alt_replace_call() with instructions after
    call
  coco/tdx: Rename MSR access helpers
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
 arch/x86/include/asm/msr.h                | 356 +++++++++++++++++-----
 arch/x86/include/asm/paravirt-msr.h       | 180 +++++++++++
 arch/x86/include/asm/paravirt.h           |  45 ---
 arch/x86/include/asm/paravirt_types.h     |  57 ++--
 arch/x86/include/asm/qspinlock_paravirt.h |   4 +-
 arch/x86/kernel/alternative.c             |   5 +-
 arch/x86/kernel/cpu/mshyperv.c            |   4 +-
 arch/x86/kernel/kvmclock.c                |   2 +-
 arch/x86/kernel/paravirt.c                |  42 ++-
 arch/x86/kvm/svm/svm.c                    |  16 +-
 arch/x86/lib/x86-opcode-map.txt           |   5 +-
 arch/x86/mm/extable.c                     |  41 ++-
 arch/x86/xen/enlighten_pv.c               |  52 +++-
 arch/x86/xen/pmu.c                        |   4 +-
 tools/arch/x86/lib/x86-opcode-map.txt     |   5 +-
 tools/objtool/check.c                     |   1 +
 21 files changed, 645 insertions(+), 198 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-msr.h

-- 
2.56.0

