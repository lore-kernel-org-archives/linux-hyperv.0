Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253329;
	b=VNe9fXCIzJw9XhEQ9fl6DZjhaPwgvG0CDWSfo8OFf+OniSRpylrzuAbmc3DXK5bQbrKg
	 c7CHh17cYnOgFvK4KqtOunuI5udeEcffV3YvqJabdOJX9pvb6EETw/cRjaXYWhN569F2G
	 PkOYbMW/Lasx6Xd/hCMtlgnqj5gukCJX8qaJ2d3qnidy9BlIgfevlx+t6PqwTucKA6q3d
	 iId6uoQdca3zmQFeh/GFhLJVG/OVilmihrCfWbN4idmg9afKC3CRwOrk34P6hC2iyhsMS
	 VLA5Watfuan2hEnGbIM6yLEs/uIbKuyChqvXWuxrMc1PUH3Pb5xBNOJrNyO9kvxKELA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=3vNZfiAYI6xKq/0IcrERSHIUn9ezzeWckOVCf4JOl9A=;
	b=mbNxgFNKb09mqq9ZOV/3tT427l84JwkpIg74GpAFBl2fXZGCYgYCf2Zj6fMkWYEKhdP8
	 Eu8mrjs0UGcg8K+lLkowNmtimml5h1RvfEbu/ALa1XLGfCTtvv0xC9CwmxSNj0IgWQU3c
	 QGc8j5Nuo3kfGT6Fo5bolJU7tBMWCucXnMBkXY7QiKXQOn28BUqMRHx17c0AFvVnLDU98
	 4kQ9zDgMr1MnGBcpe8d1qHy/fqg8arJz6evzIt4b7vh5zehKwE31J/Hb3Y+/M3qOjiZh1
	 v1ZU46Kc3UNrk0ed5ZsKpdgU2SzQP+olLfR2GYwmvrzRqlQE0hx7RkPEkiQSIhdV34g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5JpeMkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DD606A320;
	Thu, 29 Oct 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5JpeMkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820E01F031E1;
	Thu, 29 Oct 2026 05:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253328;
	bh=3vNZfiAYI6xKq/0IcrERSHIUn9ezzeWckOVCf4JOl9A=;
	h=Date:From:To:Cc:Subject;
	b=I5JpeMkXhCXUzIwzWxVEsKjt2kCNkNpLY9Mwkt1MaHVPidPNeyBb5/UVS9yP3rfA1
	 YamPqGFVNKiLORxVHqtzRVIScAPUDoodHCujv64HKgt0FfA1wn2HhEfi6wh6g+dROo
	 78FLdGXGRFod3X3QXp/0rOuBXMvr1cjwczfjwpfYr1TTVJTq1TKXNcTtBzgDHKI+fM
	 9ZFILr/wamQq+uyEVfAN/KOmk4gB5n3duh5wxPqyd/lzJVveDgdh5mf2xCs0HtF9ad
	 6y88GvECfAXqGhyagleHybIW0H04tzQqBodCdR9fVtq06Bbs/cra8j/seGsxp66qmN
	 KJPEsx7OmF+fQ==
Date: Wed, 28 Oct 2026 22:55:27 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	decui@microsoft.com
Subject: [GIT PULL] Hyper-V next for 7.4
Message-ID: <20261029055527.GC3595008@liuwe-devbox-debian-v2.local>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c03c1a14507dfaf8b856c2608f9ac216021fc222:

  Linux 7.3 (2026-10-18 13:14:58 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20261028

for you to fetch changes up to 33b28f3b313353f11fc939e9a268605e66290d0b:

  Drivers: hv: Remove leftover support for old Hyper-V versions (2026-10-25 15:11:09 -0700)

----------------------------------------------------------------
hyperv-next for v7.4-rc1
 - Update to documents and code comments (Michael Kelley)
 - Harden Vmbus (Kameron Carr)
 - Rework MSHV driver page deposit logic (Mukesh Rathor)
 - Vmbus kexec bug fix (Shradha Gupta)
 - Miscellaneous bug fixes (Daehyeon Ko, Jiale Yao, Sasha Levin)
----------------------------------------------------------------
Daehyeon Ko (2):
      mshv_vtl: detach poll waiter on POLLFREE
      mshv_vtl: reject poll files with multiple waitqueues

Jiale Yao (2):
      Drivers: hv: vmbus: Check ACPI companion before use
      mshv_vtl: initialize poll file mutex before device registration

Kameron Carr (5):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices
      Drivers: hv: vmbus: Use *_ONCE() to access shared ring buffer indices
      Drivers: hv: vmbus: Compute ring byte counts from a caller-held snapshot
      Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index
      Documentation: hyperv: Describe validation of the ring buffer indices

Michael Kelley (4):
      Documentation: hyperv: Update documentation for sending VMBus packets
      Documentation: hyperv: Remove support for guests on Hyper-V 2012/2012R2
      Documentation: hyperv: Update information on guest CPU offlining
      Drivers: hv: Remove leftover support for old Hyper-V versions

Mukesh R (3):
      mshv: Rename memory deposit memory functions to _old
      mshv: Redesign hypervisor memory deposit logic
      mshv: Remove unused *_old memory deposit functions

Sasha Levin (1):
      tools: hv: remove unused rte_smp_mb()

Shradha Gupta (2):
      kexec: Add helper to report an active kexec reboot
      Drivers: hv: Run VMBus kexec cleanup from syscore shutdown

 .../device_drivers/ethernet/microsoft/netvsc.rst   |  14 +-
 Documentation/virt/hyperv/clocks.rst               |   8 +-
 Documentation/virt/hyperv/coco.rst                 |   5 +-
 Documentation/virt/hyperv/overview.rst             |  28 +--
 Documentation/virt/hyperv/vmbus.rst                |  17 +-
 arch/x86/kernel/cpu/mshyperv.c                     |  27 +--
 drivers/hv/hv_common.c                             |  10 -
 drivers/hv/hv_proc.c                               | 260 ++++++++++++---------
 drivers/hv/mshv_root_hv_call.c                     |  10 +-
 drivers/hv/mshv_vtl_main.c                         |  55 ++++-
 drivers/hv/ring_buffer.c                           | 126 ++++------
 drivers/hv/vmbus_drv.c                             |  30 ++-
 include/asm-generic/mshyperv.h                     |   7 -
 include/linux/hyperv.h                             |  58 +++--
 include/linux/kexec.h                              |   2 +
 kernel/kexec_core.c                                |   7 +
 tools/hv/vmbus_bufring.c                           |   6 -
 17 files changed, 363 insertions(+), 307 deletions(-)
