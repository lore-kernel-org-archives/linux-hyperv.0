Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F1569F20;
	Wed, 23 Sep 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192187; cv=none; b=C9W9eGUSBEgsBxbiiB3hLKC+iT1b7x9MVt9xWHZldXXqd0Butt8BOdzQv+b+QsOsI2ciYAITFGlmjvpl8kye8RWyozPLKlMWcuZSO9u9YHY+wMY+DHK6tqiwggUe68GuxRMfdlW3qlCpojmowO4Gkg0x+QxyB77/02RzmnmiSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192187; c=relaxed/simple;
	bh=qbyegVfPVisMftvM9w19I2vmSLxDxgBL+oYOVHk7UT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKtAf/G4ihvbJcl0Sl+W5FaO+MFw+rL3hUlvL8tAYBPJ6piDtHoNcmxef2NtJ0kszJhg/AvRrFLcjQVZuzZB4bmOcBEuH0Sl1FSgoGXV+JQ4eXpe2nn2Gg6rxHtGPqWQNtuY1PsEcBW0ejG9z5hlZOwusYz393DGb6DJgk/aR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk2L7gGs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk2L7gGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790192186; x=1821728186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qbyegVfPVisMftvM9w19I2vmSLxDxgBL+oYOVHk7UT8=;
  b=Gk2L7gGs3MUpjNaygCBme6le3VQ+UyFdX4koLHlZnivvG4uta9PEShBs
   eiMT4lq3/NKJoztMK1vcV6EnORppWw5Ce667GFjMKxE/06HkLRWRhCyYE
   D4CQnUvYafwfm/NSgQwBayYhG5HS71IlcgjuXxKfA1ay4apa5R6nWs/wr
   wJ9njTxH/vOb1YUvH+xgGw7bAjVYNmZWaMb2eQ3IbMdlt9wDtlxwLyw8S
   8+fQ8FJZ778hNujGazYQX+itOYGuI+50AMQEVUk06PKsIhT4QE7Tp5kCs
   FYp34rZUHRcO2r9JNgZZ+TpAdXn64iTLTOc50d8clqVlQjF2t0YOizRme
   A==;
X-CSE-ConnectionGUID: tgqtSWwXSA+kMHjhVI5GLg==
X-CSE-MsgGUID: YJvV8JRsTg24VYTMMw2F2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94745869"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="94745869"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 12:36:25 -0700
X-CSE-ConnectionGUID: V7WQAby/SG+8UCxdRYJ8CA==
X-CSE-MsgGUID: rL2ba/rySBKoESyRt8MCQQ==
X-ExtLoop1: 1
Received: from smtp.ostc.intel.com ([10.54.69.131])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 12:36:24 -0700
Received: from cwf-2s5.sh.intel.com (cwf-2s5.sh.intel.com [10.239.48.132])
	by smtp.ostc.intel.com (Postfix) with ESMTP id 813186393;
	Wed, 23 Sep 2026 12:36:20 -0700 (PDT)
From: Shreshth Srivastava <shreshth.srivastava@intel.com>
To: Juergen Gross <jgross@suse.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	llvm@lists.linux.dev
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	xin@zytor.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 00/17] x86/msr: Inline rdmsr/wrmsr instructions
Date: Wed, 23 Sep 2026 15:36:17 -0400
Message-ID: <20260923193619.1408940-1-shreshth.srivastava@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911084211.3149957-1-jgross@suse.com>
References: <20260911084211.3149957-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11.09.26 10:41, Juergen Gross wrote:
> When building a kernel with CONFIG_PARAVIRT_XXL the paravirt
> infrastructure will always use functions for reading or writing MSRs,
> even when running on bare metal.

Hi Juergen,

This doesn't build with CONFIG_PARAVIRT_XXL=y. 16/17 and 17/17 are where
it breaks, but the cause is the .byte fallbacks: ASM_WRMSRNS_IMM from
08/17 and ASM_RDMSR_IMM from 10/17 don't end in a separator, unlike the
.insn variants above them.

  #define ASM_RDMSR_IMM				\
	" .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"

That worked while they were only ever the last argument of an
ALTERNATIVE(), which appends its own newline. 16/17 concatenates them
with ASM_CLRERR:

	ASM_RDMSR_IMM ASM_CLRERR, X86_FEATURE_MSR_IMM,	\

so the .long operand runs into the xor. From
make arch/x86/kernel/cpu/common.s:

	.byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long 266xor %rdx,%rdx

  paravirt-msr.h:165: Error: junk at end of line, first unrecognized character is `x'

clang reports "error: unexpected token" in the same place. 71 objects
fail, the same 71 either way, no vmlinux.

msr.h chooses between the .insn form and the .byte fallback with:

	#if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24100

Two kinds of toolchain end up on the .byte side of that test:

  - GNU as older than 2.41. RHEL 9 and CentOS Stream 9 ship 2.35, and
    Documentation/process/changes.rst sets the minimum at 2.30, so this
    is a supported configuration rather than an old outlier.
  - clang, any version. CONFIG_AS_IS_GNU is never set for clang, so the
    && short-circuits and the version comparison is never reached. Your
    08/17 comment already notes that clang has no .insn support.

gcc with binutils 2.41 or newer takes the .insn path, where both macros
do end in a separator, and is unaffected.

Reproduced on v7.3-rc2 with your v3 00/13, v2 0/5 and v5 00/17 applied in
that order, x86_64 defconfig plus HYPERVISOR_GUEST, PARAVIRT, XEN and
XEN_PV. gcc 11.5.0 with GNU as 2.35.2, and clang 21.1.7.

Terminating both fallbacks fixes it, and both toolchains then build
vmlinux with no errors or warnings:

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index eba325ecfe4c..529c13553c63 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -78,9 +78,9 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
  * form MSR access instructions reference %rax as the register operand.
  */
 #define ASM_RDMSR_IMM				\
-	" .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
+	" .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]\n\t"
 #define ASM_WRMSRNS_IMM				\
-	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
+	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]\n\t"
 #endif

 #define RDMSR_AND_SAVE_RESULT			\

ASM_WRMSRNS needs no change, _ASM_BYTES() already emits a semicolon.

The WRMSRNS line belongs in 08/17 and the RDMSR line in 10/17.

Thanks,
Shreshth
