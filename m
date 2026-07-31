Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDC329C60;
	Fri, 31 Jul 2026 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529071; cv=none; b=VENQyTFgG+qQAod1ON2r6vNuZMC231Y8blu+bc62zweVShxKmvTJKujHRaFEEnV/26nexoh0+orBlNv1vfjXRN4gfDKX9wiTIeCbSo9RLXez74+DS5oQ597gLf1yqr+L5rhxnjO188nj0prtNe4J45znsYhfhgxB1Iz1xlrDdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529071; c=relaxed/simple;
	bh=K+EEnU10TuLOjVkmremCbXgDKBYYgwB9jb1prXRkJ48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lkfXEbiXqKMNdVKCXW2ca+uIloTlVBkYH+rGnce/hadIK+fOYDXoam8sfmhs5AP9kjkFDqInSjwssx9ZK7U5Pb0gbm3VhP95Jizd1rwOfjxHo/+aYVtYn8HGDGZPVgX3clbNTp1hk6Crk67C7uUJigtvK/nxIdOw0312GpqOIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkcJhtJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkcJhtJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE081F00AC4;
	Fri, 31 Jul 2026 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529070;
	bh=UYgGjJlVe+LSZWRYTB52TosNuvHGadTkU8kXi9d44mA=;
	h=Date:From:To:Cc:Subject;
	b=WkcJhtJXdlFaI6ox3xSJp9tlUbvwYTtUjaeExk/DMMG3FIF7uaYbkx5CfEVFblpJu
	 edcLaLTYXMWVIGIYFD5M8MlSo1w9WPf0CRtYsAjzJE0JXqjqZZttHgZd5G1Y3NkKHj
	 f554XMFaJSJ42k3jgea+JFaaXtGcy8LN2frqqT0o3cqPony4ZgeLP47FwIfHGldSqk
	 8UzBiSNYtBLDTz0BD9iiiKNyz7eEGP/Wm5o3TRBI8RfqAHk9tZ/S2cyI1ZVzjMAMQk
	 bRsXgr8dyyYSS3Mt3lb+0WfzrLxA3OrhJmEBk0GEnmP45hExAdkLZoL0GEY19jC59f
	 suIL6oN4yfHqQ==
Date: Fri, 31 Jul 2026 13:17:48 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	kys@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 7.2-rc7
Message-ID: <20260731201748.GA3243806@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260731

for you to fetch changes up to 22dfdc17ceadd2783a609947af621a7f697b7765:

  mshv_vtl: bounds-check cpu index in vtl mmap fault handler (2026-07-31 20:02:04 +0000)

----------------------------------------------------------------
Hyper-V fixes for v7.2
 - Multiple fixes for the MSHV driver (Stanislav Kinsburskii, Wei Liu,
   Yi Xie, Yousef Alhouseen)
 - Multiple fixes for the VMBus driver (Hardik Garg, Michael Kelley,
   Sebastian Andrzej Siewior)
----------------------------------------------------------------
Hardik Garg (1):
      Drivers: hv: vmbus: add VTL2 redirect connection ID

Michael Kelley (1):
      Drivers: hv: vmbus: Set DMA coherent mask for VMBus devices

Sebastian Andrzej Siewior (2):
      Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation
      Drivers: hv: vmbus: Remove vmbus_irq_initialized

Stanislav Kinsburskii (8):
      mshv: Fix duplicate GSI detection for GSI 0
      mshv: Fix sleeping under spinlock in mshv_portid_alloc
      mshv: Use kfree_rcu in mshv_portid_free
      mshv: Fix race in mshv_irqfd_deassign
      mshv: Fix level-triggered check on uninitialized data
      mshv: Fix missing error code on VP allocation failure
      mshv: Order pt_vp_array publish against irqfd assertion path
      mshv: Publish VP to pt_vp_array before installing the file descriptor

Wei Liu (1):
      mshv: fix hv_input_get_system_property struct

Yi Xie (2):
      mshv_vtl: fix fd leak in mshv_ioctl_create_vtl()
      mshv_vtl: bounds-check cpu index in vtl mmap fault handler

Yousef Alhouseen (1):
      mshv_vtl: clear hypercall output before copyout

 drivers/hv/connection.c        | 47 +++++++++++++++++++++++++-----------------
 drivers/hv/hyperv_vmbus.h      |  2 ++
 drivers/hv/mshv_eventfd.c      | 41 ++++++++++++++++++++++--------------
 drivers/hv/mshv_irq.c          |  2 +-
 drivers/hv/mshv_portid_table.c |  9 ++++----
 drivers/hv/mshv_root_main.c    | 41 ++++++++++++++++++++++++++++--------
 drivers/hv/mshv_vtl_main.c     | 13 +++++++++++-
 drivers/hv/vmbus_drv.c         | 28 +++++++++++++++----------
 include/hyperv/hvhdk_mini.h    |  3 ++-
 9 files changed, 125 insertions(+), 61 deletions(-)
