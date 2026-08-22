Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBC493625
	for <linux-hyperv@vger.kernel.org>; Sat, 22 Aug 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358996; cv=none; b=ENcl1eFp6i6OOo6oPV8JgLqBqbggm/bh+hSL5W4rUQtDi/7u67kh5FuA6yzs7dJG+MMd3HHHJSLQxigxQCE/GLOSfVFU1NigEUHdfdMW4KkFbiDDMTyl1XyN1hE5iH+xc3gvqI6xPz74nJJBZeLtKiAlwCj1ysK8jbZCcS5sVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358996; c=relaxed/simple;
	bh=HX7hWyLxgcgkGNfONvb1S9oXXuWs/DtA1BF9c8Ugn3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYDYV0JB37YS5czAUNh9oedh7GB0DNXMEgGAQmjQuj8OfqS+M2Q0v+r+gex/StG0Fuf27c2mfkGTNBmbfZZEOoINki9enRqUnklbj6RYKd8mNjb9cjDPHgONX8RgOnTdxek6SxqMzeRqdxOigif90yB8hYaY1PNJ8WPEnpqw7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEAcMsT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEAcMsT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159121F000E9;
	Sat, 22 Aug 2026 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787358995;
	bh=nMJb761mDP4Usmny0YltysofVr7ZAsowTN4AE/9PcBY=;
	h=From:To:Cc:Subject:Date;
	b=KEAcMsT39Tx8k5UMHwfMSbYez3G9gwyV/L1+9TIZ/41hXJgKYQmSHn7Y6bRMkw0gi
	 8ckun31lolJMUfHu5Dau68WcX+WefWAEMBPz2dpH7VJFyG4T/lDYdR4QARsLHkhCxe
	 6r0cZtBC0psfpPIp7cy1kp+5T7+cLZCPo6zAoxNYgg+FPtw3FzgDbNWDhyEwKkrIIh
	 lfj1gpZVg9K5DsolIpNUJgSDO56XJNEMcegwc+4xKElZsojep+m1jRCqyATGndPtqz
	 CM3Oxfbwfl1D+q1NdTiHYdVtlPvccDtVh78a+qViT14ev/6lPKZ2s29NnKPNoRN2US
	 mUG7fBIc/eJ+Q==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	anirudh@anirudhrb.com,
	schakrabarti@linux.microsoft.com,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH 0/3] Fix pci-hyperv interrupt code on a nested root partition
Date: Fri, 21 Aug 2026 17:36:19 -0700
Message-ID: <20260822003623.2925128-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

There are two issues in pci-hyperv when Linux runs as the root partition
on a nested setup.

1. Interrupt state between Linux and the hypervisor is out of sync due
   to pci-hyperv not issuing unmap hypercall.
2. Interrupt migration is broken due to Linux doesn't retarget
   interrupts correctly.

The first patch is trivial. The two issues are fixed by two separate
patches.

Wei

CC: "K. Y. Srinivasan" <kys@microsoft.com>,
CC: Haiyang Zhang <haiyangz@microsoft.com>,
CC: Dexuan Cui <decui@microsoft.com>,
CC: Long Li <longli@microsoft.com>,

Wei Liu (3):
  x86/hyperv: export hv_unmap_msi_interrupt()
  PCI: hv: unmap MSI interrupt on the nested root partition teardown
    path
  PCI: hv: fix interrupt affinity change on the nested root partition

 arch/x86/hyperv/irqdomain.c         |   9 +-
 arch/x86/include/asm/mshyperv.h     |   2 +
 drivers/pci/controller/pci-hyperv.c | 122 ++++++++++++++++++++++++++--
 3 files changed, 122 insertions(+), 11 deletions(-)

-- 
2.53.0

