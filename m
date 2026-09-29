Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE63DEAC8
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654589; cv=none; b=lmmmkc1gLPF67C+H7pzRNcCPV8EMl7ZGck6zaTMXk1QzhD1JbfJ+SxjNQlX/4GeWdAoBwCcqY3kjdeXcgICXlqyK6YpKFqwQtCsPpI9Z9H1Uusuw7LEdL7PW6vP+ohLqvAmFJf1TjYuj1Ao93sIWy1Q93s96ldFVtxQvoGM3I0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654589; c=relaxed/simple;
	bh=ofjMK+frBLaew2v4NwVs3dlVJMs1NzYJl7FaeQqAgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAdoOSpVKzuYxC0kPbuw9t2Zs0dZOXihhxhWLk2z6FtyUHM2furWggC3m7KYyp8H/jiU/QBSLpFN207wNhiKiDAtSseUDEQRp3P+hOJVIYO+Zt10xSwCI5kzJctDOhDPqcQI6R8c1FYs+yBEn6Mak85infAB8NMXfsJbEkT/3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TdIlkCp7; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TdIlkCp7"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-885cf67963eso3337517b3.0
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654586; x=1791259386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=r+njCRZDRXVrQbdU59WhlCfjS0OKdp+VeiG+ks4bRlG/3AYj4d0ZTaAfZ5tjZ6np+y
         PhyhjxEQdMjz4cNPr0I9jjLU6VjGw1QVimDBRUDbxFKGszIs3b3dWESI8DsuGxLtsAAz
         6hJZIvF/HdZv8FncB6eyHpmmjFiAdDWSkZESwwKTt2F+0yFOiaHeE2WG35Kbfs281lG7
         Hd5PP2BfFH+soVag14gafN/N9MXhk7ZktRYiZIcFvh4ecgIFidEak4Ju1KNukRGb05Gy
         liv+WZfYAKIEeXjIcCm+dxkwRAJagm8dyQF3h5328Pb1RWNE61Z0rLL+irdC7yt3FApl
         HJEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMf4t8JCdXPD+OaunUCKDFtqVmyoN6RfycjTn+KA4Zu8RMV5XNkbJO4UsJQ6u7OIEvmhAC7V4xC2YBZwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS8vbf5jP67OOixlNBsdEbkfFMRI41RkbPXh8w2Co5U+BoOVFE
	xQDeG+GN89hwOrrcqS1TJJyvSGNwcXtGK6MLoO+6ME0xp7QQM58VwIQH+VT1GZtsG3IBMdIeJt3
	4h4irr8Tb1Oldfm8LTzEyLg9lXZhGwYorqzMZmzsqh9U7ovBrn9BFvuq60R1vzm+3moTCIWtlAL
	UpzS8I6Ni8k13vHUs5uKceEYCWMM97MNr7fgfaR22IhxJ0cc0cAXLlvbIgb6WswTEp/0ZgMjGsr
	Typ7/oPU75IF484
X-Gm-Gg: AYBFou0vbrMk8jlXOsJwiFrpegVDO6x1+3dAVSTHHWHjN0UpE5bbC1t6c8/5m6O8GvZ
	2aTbh20P0ceeJrElPbKOvF+l+7+Ye+1w0df24Q3XT1cRzYdnl5H6N3K3gouypkjZTE4gg0xzHGd
	BTw+HRQooAWSers8G/ck7dqyVzhmHlUMgDJuSs+FmGUh+arxP3RbEJWZFLfuvDNN9QHaRT5+TQg
	P8FZCmWTzwjPTcE5NXdoDGRZ7KbcU/Ke0rmJHizdbdY1FAP74rzIUy02pf8GkAtIgiFMLPpsyDi
	4EHgbLI74Sn2wEGkH8x6q1LUR3awY9g3H+kVuu/AcrNcGf8PuTcyIGsa/JXs2Lzqpw0qo2Rein3
	uaQl1eF7ziT5RSJLw02Lc0b3j+XOqQsI4WHo88qNSzDETJOVfXR05FKIL3ZhEwMiY/icTOnQU0k
	i6AeZW4pewvDbgKEL4jugjQX7bJXddNI2T
X-Received: by 2002:a05:690e:13ca:b0:674:e730:f176 with SMTP id 956f58d0204a3-674e74f7ee0mr3003226d50.82.1790654586258;
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6755b72ec7esm470722d50.8.2026.09.28.21.03.05
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34afa104860so626538eec.1
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654584; x=1791259384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=TdIlkCp7hvOZ7O4to9VD/ktGFpklNkIvzV5hXPGlwMBHYLBF1S8nqsiD3o3M2MC8Ln
         jgothhzf86blwo/6n/U64q6Cx2F+TB/QNUcS9J5/m0IokDf99Vtb+RhGwwpy6VybDFM8
         cTtxrXCmsP8aG8USh0u4j54Q5XvnoQVsK9wxs=
X-Forwarded-Encrypted: i=1; AKwUvBxQq6uvK49h5gT/MbnIqapEWvt6qPaRxOR8jTUQDp/+TFTk7ZH33JKB28RFnoc6SRdx3ERCLtSjRAOkEW4=@vger.kernel.org
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268577eec.31.1790654583924;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268522eec.31.1790654583107;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:02 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
Date: Tue, 29 Sep 2026 00:02:49 -0400
Message-ID: <20260929040256.543767-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware publishes its per-CPU steal-time GPA without first sharing the
storage in encrypted guests. Following Kiryl's review, this series moves
sharing into early per-CPU initialization for both KVM and VMware.
This replaces the VMware fix from Bo Gan and Alexey Makhalov:
https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@broadcom.com

The common helper uses boot-time page-table allocation and preserves
initial contents on AMD and TDX. Conversion precedes buffer registration
on SMP and UP; failures stop boot. Encrypted guests use the embedded
allocator, warn on percpu_alloc=page, and never fall back to page mode.
There is no driver conversion loop or readiness flag. .bss..decrypted
remains outside this series.

I interpreted the allocator requirement as guest-specific, so both it
and per-CPU conversion use CC_ATTR_GUEST_MEM_ENCRYPT and leave bare-metal
SME behavior unchanged.

Two corrections to v1: its isolation claim missed UP, where ordinary data
could share the decrypted objects' page; patch 1 fixes that separately.
TDX's vmalloc constraint concerns private aliases and adjacent accesses
through load_unaligned_zeropad(), not just GPA lookup. This series removes
the unused declaration macro and adds explicit SMP/UP section boundaries.
I have not carried the v1 Ack onto the revised patches; renewed review
would be appreciated.

Tested on VMware ESXi with SEV-SNP and TDX guests, and on KVM with
SEV and SEV-SNP guests, using SMP and UP kernels.

v1: https://lore.kernel.org/r/cover.1789488039.git.zack.rusin@broadcom.com

Zack Rusin (6):
  percpu: Page-align decrypted data in UP kernels
  percpu: Bound decrypted storage for all x86 encrypted guests
  x86/percpu: Require embedded allocation in encrypted guests
  x86/mm: Provide common early memory decryption
  x86/tdx: Support early sharing of kernel data
  x86/percpu: Share decrypted storage before guest CPU setup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/coco/sev/core.c                      |  16 ++
 arch/x86/coco/tdx/tdx.c                       |  32 ++++
 arch/x86/hyperv/ivm.c                         |   4 +
 arch/x86/include/asm/mem_encrypt.h            |   9 +-
 arch/x86/include/asm/x86_init.h               |   4 +
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/kvm.c                         |  35 -----
 arch/x86/kernel/setup.c                       |   2 +
 arch/x86/kernel/setup_percpu.c                |  14 +-
 arch/x86/mm/mem_encrypt.c                     | 139 ++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c                 |  12 +-
 include/asm-generic/vmlinux.lds.h             |  19 ++-
 include/linux/percpu-defs.h                   |   7 +-
 14 files changed, 247 insertions(+), 51 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

