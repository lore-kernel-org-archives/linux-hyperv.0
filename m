Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFA1F427C;
	Tue, 25 Aug 2026 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630713; cv=none; b=In8Ql3vT4/l5Af3ShzKCQu8BQYxpcs3QmItdDVI5jnp/rX7iFIKlx/qrgU8N4Ppe4D/unYM0lH3gQIcykB1+tdUZ0WE2rGNS+0YwiFwtKAPxsWmoTmPYVIoeAAnqlmXKUgwjNHwm4K26584MPHGnIC+L89Z9aTMfvY3whOXvw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630713; c=relaxed/simple;
	bh=K5pJtA9m3VT7Dbor0BVe//qicpcj5PRYGqkXUyPmMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYJ5Rf334qNXUN5GYGUR2SaLyHBqWesZLUeAaqkNQiYJFJVdIjqBGW4Enlj5wgLbqXgCEut58KpxCi1wcJS2E7UB5ylD8SRU/Faf9NreHTXl3HciFOXvizBSUtCfbBibob3uAY3EzNgMWhT+KaJovMjZg/BC5kC7IGhAqrTHmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LQlqMa2S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LQlqMa2S"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C830820B7166;
	Mon, 24 Aug 2026 21:04:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C830820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630679;
	bh=Re7/ImR4UTsF3GT2YTwiBGBIxmsfWYv7sG2SmlEvUNE=;
	h=From:To:Cc:Subject:Date:From;
	b=LQlqMa2S8p77WDCEJiRoSVyRH2b5UjgyAxKvPmEXGpZDsc47iPcqYAM988g3pG43Z
	 HyogW1aXSowlCd9HeFHXQD4SLIs9YyK8SwPYR2aejQtneNHRaQFPpIOwHkU8MEe8IJ
	 Xn5IIxG5fAOxn6hBOUNS3M8ZLw+XoxawOO0Grr90=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 0/7] mshv: add SEV-SNP support for MSHV root partitions
Date: Tue, 25 Aug 2026 04:04:32 +0000
Message-ID: <20260825040505.826600-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for creating and managing AMD SEV-SNP
confidential virtual machines through the Microsoft Hypervisor root
partition driver.

The series adds fixed-size MSHV UAPI definitions, the required Microsoft
Hypervisor ABI definitions and hypercall helpers, partition ioctls,
capability discovery, processor-feature handling, ordered encrypted-memory
teardown, and nested-root SynIC handling.

The patches are based on the current hyperv-next branch.

Testing:

  - Built the complete seven-patch series on x86_64.
  - Verified the installed UAPI in 64-bit and 32-bit userspace builds.
  - Generated rust-vmm MSHV bindings from the kernel headers.
  - Booted Linux as an MSHV root partition with SEV-SNP available.
  - Passed Cloud Hypervisor's common_cvm::test_focal_simple_launch.
  - Booted a four-vCPU SEV-SNP guest to login.

The development host needs two additional local patches to boot as a
nested MSHV root partition: the EFI HvLoader enablement and the
non-upstreamable nested-VMBus interrupt-vector workaround. Neither patch
is part of this series.

Changes since v2:

  - Rebase onto current hyperv-next.
  - Drop the system-property structure fix, which is already upstream as
    commit d6f0248f04a9 ("mshv: fix hv_input_get_system_property struct").
  - Drop the EFI HvLoader patch as requested; alternative root-partition
    boot mechanisms will be explored separately.
  - Drop the panic-notifier SNP unlock patch. A panic notifier is not a
    guaranteed pre-crash-kexec hook and cannot safely traverse mutable
    memory-region state in all contexts.
  - Redesign variable-length ioctls to use fixed-size headers and aligned
    userspace pointers. Name GPA and PFN inputs explicitly and add the
    isolated-page size to the UAPI.
  - Replace public bitfields and the large by-value launch payload with a
    naturally aligned pointer-based ABI and field-by-field kernel
    translation.
  - Process userspace page arrays in bounded batches, yield between
    batches, validate large-page alignment and contiguity, and improve
    partial-progress diagnostics.
  - Keep encrypted pages pinned until mappings are removed, the SNP
    partition state is destroyed, and host access is restored. Quarantine
    the partition and retain the module if a safety-critical phase fails.
  - Remove the unbounded delayed-work teardown retry.
  - Treat rejected SNP capability queries (including L1VH) as non-fatal,
    and copy per-CPU results before restoring interrupts.
  - Preserve nested virtualization in the legacy safe feature defaults.
  - Reject device opens until parent-partition initialization completes.
  - Remove redundant SNP operations from the generic passthrough
    hypercall interface.

Link: https://lore.kernel.org/linux-hyperv/20260810124527.1409634-1-weh@linux.microsoft.com/

Wei Hu (1):
  mshv: set up own SynIC registers on a nested root partition

Wei Liu (6):
  mshv: add SEV-SNP UAPI definitions
  mshv: add SEV-SNP PSP request hypercall
  mshv: add SEV-SNP isolated page hypercalls
  mshv: wire SEV-SNP partition ioctls
  mshv: detect and report SEV-SNP support at init
  mshv: use safe partition CPU feature defaults

 drivers/hv/mshv_regions.c      |  10 +-
 drivers/hv/mshv_root.h         |  29 ++
 drivers/hv/mshv_root_hv_call.c | 190 +++++++-
 drivers/hv/mshv_root_main.c    | 854 +++++++++++++++++++++++++++++++--
 drivers/hv/mshv_synic.c        |  16 +-
 include/hyperv/hvgdk_mini.h    |  31 ++
 include/hyperv/hvhdk.h         | 124 ++++-
 include/hyperv/hvhdk_mini.h    |  53 ++
 include/uapi/linux/mshv.h      |  99 +++-
 9 files changed, 1365 insertions(+), 41 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0
