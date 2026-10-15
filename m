Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE44854F8;
	Thu, 15 Oct 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051872; cv=none; b=i0Yej2km67NDCQr9GJjd0a0C9nNAt3igJ/+fNXuvCpT+gRBVMuiFddI8lZIWg9iqzwnMXu7WYJNAwVNeTG0q8PPE/MZb/9XjCkpJr9jaJGf//ldoFOqMwKA7IQhKCUfoHEq+kVbDwW4B69kTNiA8mwB1Y4lyBzaRoIx9swa1U7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051872; c=relaxed/simple;
	bh=V8Y9jYwXwfeBxSoAuTEW2TuAaDfG3L/DV0c1leql/Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JWfN+nT+dW2vkAMmH/pG2J3bKtBHSoSL61o1/6+EJ+ayE0eRx+XZ2cgJiA1LfWkDpgT1UqMsvV4Z2ZCWX2vh0e1UgQjVRlVfnfdG5CiqflwoT1zVMW0joYNWF0Ft7Ma2Osox9faACLx0pDwOft8myWJHK1GumpBT7Y6hxDdxRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcYlvjJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcYlvjJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680FC1F000C6;
	Thu, 15 Oct 2026 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051871;
	bh=u6RjxusLqsOwQy9703o6UZD6vCogKyB637FZ+kG8Iok=;
	h=Date:From:To:Cc:Subject;
	b=CcYlvjJ2iqL5QgRd2R8zMuszd15XuAVXwRMZSYUt4+7Frw65YbpTlhWWEGG+Mc9T7
	 sji+0A7fM7QoakbcQcEIJyCOdLeQI0AVrnp2s19XEK6Rffv91ic/EXj8IZm0IRujq/
	 IrKJnQdFhS/WrV76rUMNbe5ZRkA5dLWqeBQQgFtDhiPXTd5Zk3hSvAqLHf2BiX+Hy+
	 5+GLD/0vJe9nn7bR1fABbVLDoI0QqLOraTvEkCAK/WXKNj4SgaMJm8EllhZ2UJ64mj
	 isw0YRPZgiy1p3biAzWamuqCo9+c1Xwn+WIXeh46NyansEBdaZapkR3eF9znqMllzV
	 3HNsG78+ImTkA==
Date: Thu, 15 Oct 2026 01:11:10 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 7.3-rc8
Message-ID: <20261015081110.GD936897@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20261015

for you to fetch changes up to dbc393f6f009a2bf7e4a22ef2d70b53f533f20f4:

  MAINTAINERS: drop KY from Hyper-V maintainers list (2026-10-15 00:58:57 -0700)

----------------------------------------------------------------
Hyper-V fixes for 7.3-rc8

 - Some typo and comment fixes (Hemanth Selam, Jiangshan Yi)
 - Update maintainers list (Wei Liu, Long Li)
 - Two Hyper-V PCI driver fixes (Naman Jain, Sahil Chandna)
 - Small fixes for core Hyper-V code (Hardik Garg, Michael Kelley,
   Waiman Long)
----------------------------------------------------------------
Hardik Garg (1):
      mshv_vtl: Check per-CPU register page before mmap

Hemanth Selam (2):
      Drivers: hv: vmbus: fix typo "substract" in comment
      tools/hv: fix typo "retrive" in comment

Jiangshan Yi (1):
      x86/hyperv: Fix stale comments after stimer message mode removal

Long Li (1):
      MAINTAINERS: remove myself from the Hyper-V entries

Michael Kelley (2):
      x86/hyperv: Avoid using per-cpu output page in hv_apicid_to_vp_index()
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Naman Jain (1):
      PCI: hv: Probe vPCI buses asynchronously

Sahil Chandna (1):
      PCI: hv: Warn when wait_for_response() waits indefinitely

Waiman Long (1):
      Drivers: hv: Avoid infinite retry loop in init_vp_index()

Wei Liu (1):
      MAINTAINERS: drop KY from Hyper-V maintainers list

 MAINTAINERS                         |  3 ---
 arch/x86/hyperv/hv_init.c           |  7 +++---
 drivers/hv/channel.c                |  2 +-
 drivers/hv/channel_mgmt.c           | 12 ++++++---
 drivers/hv/connection.c             |  1 -
 drivers/hv/mshv_vtl_main.c          |  3 +++
 drivers/hv/vmbus_drv.c              | 19 ++++++--------
 drivers/pci/controller/pci-hyperv.c | 49 +++++++++++++++++++++++++++++--------
 tools/hv/hv_get_dns_info.sh         |  2 +-
 9 files changed, 64 insertions(+), 34 deletions(-)
