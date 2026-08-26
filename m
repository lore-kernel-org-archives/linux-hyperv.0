Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F13B635B;
	Wed, 26 Aug 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779269; cv=none; b=MsouFBI8uph+yK0RUL61Xr7O0Xx6cEgWq053zs4UkV4iK02NZKl9TptrgYZVDJF/ldMRaFrB8FGVVTSAYwd6JRl57u1pT4qvCJynFgcA33ahP6UibGjmwPT5+Xfp7OBSsavrKUw/dorRKFfALkaYSARqrMquI/l/sL12vuNjzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779269; c=relaxed/simple;
	bh=rk4nNQNngRg9zsPWkJ/A0kxKyRXt2KgJJQ8gyfnsRnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPVWkBev3TmgNtTGLZaMvITLjxw49wW14/CzMcoiWUISPf0mv1PdGsI0kMrb6FvTBoWVGvfSmH7LR8u4PmWj6FgkxLLOtHTCPRKISTVklfT6ZcOaex99iXrqdd1wgcvhT1hgJghmi1Jxi9lON+or8Ywg2FNyLps3YwsyWK2/cxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrqe2ed8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrqe2ed8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0861F000E9;
	Wed, 26 Aug 2026 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787779267;
	bh=+n/uGXf2baQNUm9FbO3aJnaCFXxvka7jc7HMY6dMGBM=;
	h=Date:From:To:Cc:Subject;
	b=Wrqe2ed8IzncQ8KwBzMwcgKRVwpnhiz2npRYEPV+Ou9hBmR+afeoC48iZT5/eiY+N
	 /6YaZTx4aRGJXoLIb/t7nC7dirRToWJA8k3mus0JpTePF71WV9EMjAf1Bhn9ZtbA3q
	 fji7IR4TSLtKIVaqjQmB1ffsNAEoKFjNx4z2BdqUa2BeOQFaYiYQ3/eJfZPNQ3s/3X
	 lpY+6gENKkPoQ34iR2npGyFKalp8/9bj1pMcd6h5JCvAm3j3DHfbOUiZ/ma0lobz3z
	 iRarwx/600qxuAnTzBrhEj8fWrhrDBonhhK5GTjsDu98tLAq8Uih58emdJyR8GrLSU
	 +uoXhkor01CPQ==
Date: Wed, 26 Aug 2026 14:21:06 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	kys@microsoft.com
Subject: [GIT PULL] Hyper-V next for v7.3
Message-ID: <20260826212106.GA693916@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260826

for you to fetch changes up to be0cfab740e58b70047ef6e7e3d578f00ed5d258:

  clocksource: hyper-v: Remove support for stimer interrupts in message mode (2026-08-24 00:36:14 +0000)

----------------------------------------------------------------
hyperv-next for v7.3-rc1
 - Decrypt netvsc buffer on contiguous direct-map addresses (Kameron
   Carr)
 - Drop WS2012/2012R2 & Win8/8.1 Hyper-V support (Michael Kelley)
 - Use more meaningful errnos for hypercall status code (Hardik Garg)
 - Fix lost interrupts on CPU hot-unplug for Hyper-V PCI/MSI (Naman
   Jain)
 - Reserve more MSHV vectors for Linux root partition (Wei Liu)
----------------------------------------------------------------
Hardik Garg (1):
      Drivers: hv: Use meaningful errnos for hypercall status codes

Kameron Carr (3):
      Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
      Drivers: hv: vmbus: Add vmbus_alloc_buffer()/vmbus_free_buffer() for CoCo VMs
      hv_netvsc: Allocate send/receive buffers using vmbus_alloc_buffer()

Michael Kelley (6):
      Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition
      Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of Hyper-V
      hv_sock: Remove check for old Hyper-V hosts
      hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
      scsi: storvsc: Remove support for storvsc protocol of old Hyper-V hosts
      clocksource: hyper-v: Remove support for stimer interrupts in message mode

Naman Jain (1):
      PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

Wei Liu (1):
      x86/hyperv: reserve more vectors

 arch/x86/hyperv/hv_init.c           |  23 ++---
 arch/x86/kernel/cpu/mshyperv.c      |  25 +++--
 drivers/clocksource/hyperv_timer.c  | 150 ++++-------------------------
 drivers/hv/channel.c                | 182 +++++++++++++++++++++++++++++++++++-
 drivers/hv/channel_mgmt.c           |   8 +-
 drivers/hv/connection.c             |  11 ++-
 drivers/hv/hv.c                     |   4 -
 drivers/hv/hv_balloon.c             |  36 +++----
 drivers/hv/hv_common.c              |  12 +--
 drivers/hv/hv_snapshot.c            |   5 -
 drivers/hv/vmbus_drv.c              |  25 +++--
 drivers/net/hyperv/hyperv_net.h     |   8 +-
 drivers/net/hyperv/netvsc.c         | 123 ++++++++++++++----------
 drivers/net/hyperv/netvsc_drv.c     |   6 ++
 drivers/pci/controller/pci-hyperv.c |   1 +
 drivers/scsi/storvsc_drv.c          |  53 ++---------
 include/clocksource/hyperv_timer.h  |   6 --
 include/linux/hyperv.h              |  20 +++-
 net/vmw_vsock/hyperv_transport.c    |   3 -
 19 files changed, 391 insertions(+), 310 deletions(-)
