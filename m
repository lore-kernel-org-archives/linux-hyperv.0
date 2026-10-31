Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405678;
	b=0Pi/6bomPQcreD0364tQJ0xs42Ho+lTmCCS+Q/7svheNYx9hjlOym8Xl3uzajW9aXIuG
	 K/XutxFvnYUmMvn/tMDjIuW2qeuF9fzBkx/GNcLKnWtCpd6oWdLUqrnYRnbkSZ9ta1MYO
	 2NvGqmEMHAKEYokXm5Xwg9x7ExXBkVKpQbVd2eapj8BEQhEayD5eCE3iS3IrUczyxjOFL
	 o96iCje+ZqHbNVEkuNXOMjX2pUBMQdoAnyOR8c3azNMd1f3wJCeVkTLOsJ/BTMQKmg8uP
	 qU6DnRVM2/8t2li+W8DX6owqmtjVrzeGmpvGUUwUM34PUHwSB3XvwgfEfeEe6QUcjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405678;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Hq3qHGQR7nv/3NC9Br2iwzyPeeGRgGD2fYTnbPgW0qA=;
	b=GBmBTHhLmXjecq6qQ+IucSs0tr3J9FBktiEgz7EAVLA7ZZMksOFHp7WET5jceLqP0Pbm
	 8qHunN4Q6SNAMuI6/mFeDwwebr4TDB0RBJ9e1myKUemiuqkVWSQGlVR+I0bKZHdVi6iO1
	 uMP/0En/h3tvJ5J73c2wjZDxgMAzjBXvKcvJjIJTWUg8+X5a0U3n+XX9UdqbkKS9IIhRi
	 +T76jwPheRwvYeGRcIGEKr0d5kzZetwQYJGxYUIhrH1+9YoKjckd4QlXOlkcENyvvrHAI
	 3TNH7rlOS38Qvgr8M3PTzRIlFjmQMRXwB1ifI0DL5lW3UJV6Ppg1uEtUoBDcJbbiMiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=C2NnhdMq;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F6606A31D;
	Sat, 31 Oct 2026 00:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2F6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=C2NnhdMq
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A7DBB20B7166;
	Fri, 30 Oct 2026 17:14:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7DBB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793405664;
	bh=Hq3qHGQR7nv/3NC9Br2iwzyPeeGRgGD2fYTnbPgW0qA=;
	h=From:To:Cc:Subject:Date:From;
	b=C2NnhdMqxNXKrhhx7bh6/zGSQFCn3+/nXNbYbSrYButfurlnwkMWud2lCo4z8xymU
	 qPmhm7y/OIZzFYRjW7k1GW6xKJ8+f2IulBwlX4qXf4n9umohAyHjrjIzMsKVGzkr7e
	 CFz5R50xGAeDo374L0bYFcQIEniU4NIYWYj+6jmo=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	sudeep.holla@kernel.org,
	thuth@redhat.com,
	will@kernel.org
Subject: [PATCH v6 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Fri, 30 Oct 2026 17:14:06 -0700
Message-ID: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

Realms (CoCo VMs on ARM) require host calls to be routed through the RMM
(Realm Management Monitor) via the RSI (Realm Service Interface). This
series implements most of the necessary changes to support Realms on
Hyper-V.

One required change is not included in this series. The two buffers
allocated via vzalloc() in netvsc_init_buf() cannot be decrypted in
vmbus_establish_gpadl(). Currently only linearly mapped memory can be
decrypted.

This patch series was tested by booting a Realm on Cobalt 200 running
Windows. I tested 4KB and 64KB page size. I replaced vzalloc() in
netvsc_init_buf() with alloc_pages_node() -> set_memory_decrypted() ->
vmap() in my testing as a workaround for the issue mentioned above [1].

Changes since v1 [2]:
  Patch 1: Add explicit padding to the RSI host call structure
  Patch 3: Change from a per-cpu pointer lazily allocated to an array
             of host call structs indexed by cpu id
  Patch 4: Align input_page + output_page allocation to PAGE_SIZE since
             that is the smallest unit of memory that can be decrypted
           ~Remove KASAN tags before passing address to
             set_memory_decrypted() since __is_lm_address() does pointer
             arithmetic.~ (reverted in v3)
  Patch 5: Add a helper function to reduce repetition
           Check for NULL before indexing into host call array

Changes since v2 [3]:
  Patch 3: Remove hv_hostcall_free() and inline the logic for simplicity
           Reorder edits to keep #include line at the end of the file
  Patch 4: Remove kasan_reset_tag()

Changes since v3 [4]:
  Rebased onto arm64 for-next/smccc-bus which includes moving RSI header
  files out of arch/arm64 [5]

Changes since v4 [6]:
  Patch 1, 2, 4: Fix commit message to reflect the new header file names
  Patch 5: Remove extra blank line

Changes since v5 [7]:
  Patch 2: Move Realm hypervisor detection out of the generic
           arm_smccc_hypervisor_has_uuid() into hyperv_detect_via_smccc()
           so other SMCCC users are unaffected
  Patch 3: Drop the <linux/arm-rsi-cmds.h> include, now added in patch 2

[1] https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/
[2] https://lore.kernel.org/all/20260609181030.2378391-1-kameroncarr@linux.microsoft.com/
[3] https://lore.kernel.org/all/20260625173500.1995481-1-kameroncarr@linux.microsoft.com/
[4] https://lore.kernel.org/all/20260721201148.1441143-1-kameroncarr@linux.microsoft.com/
[5] https://lore.kernel.org/all/20260923140405.1111554-4-aneesh.kumar@kernel.org/
[6] https://lore.kernel.org/all/20261001220552.1793471-1-kameroncarr@linux.microsoft.com/
[7] https://lore.kernel.org/all/20261002215725.2015959-1-kameroncarr@linux.microsoft.com/

Kameron Carr (6):
  arm64: rsi: Add RSI host call structure and helper function
  arm64: hyperv: Detect Hyper-V via RSI host call in CCA Realms
  arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
  Drivers: hv: Mark shared memory as decrypted for CCA Realms
  arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
  arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms

 arch/arm64/hyperv/hv_core.c       | 155 +++++++++++++++++++++++-------
 arch/arm64/hyperv/mshyperv.c      |  62 +++++++++++-
 arch/arm64/include/asm/mshyperv.h |   4 +
 drivers/hv/hv_common.c            |  17 +++-
 include/asm-generic/mshyperv.h    |   1 +
 include/linux/arm-rsi-cmds.h      |  22 +++++
 include/linux/arm-smccc-rsi.h     |   7 ++
 7 files changed, 228 insertions(+), 40 deletions(-)


base-commit: bce57945f5e7207960b2bd567a6e880f90258ffb
-- 
2.45.4

