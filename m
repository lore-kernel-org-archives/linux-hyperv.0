Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA327FD40;
	Thu, 22 Jan 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058351; cv=none; b=G1WJjHYrP4nG2agiYL5wG8/GqjyQWnYrOJwb8SjgxraarasxPh4r1s9cMilcFdVAkB4VGWmuY24YM98y6pLF/FzR5xNy+aYe+J/tjm7/d5urRbEJN7E9Uo0MbmQWZriPegQhiXk5UUeXBN2oE+TKx8ZI4MYTST/ldXPWdxxVKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058351; c=relaxed/simple;
	bh=FbO4XJAhoyHTC1qMFBSuPB8/XkSCTX62CMZCGPOYvcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+RFTuvjs3cZdchSdos1xwaSGNVYTGcYFw5LBWqLCUJuSxL+RK1JcYsbg5dOrL/LLyPK5tfirGAInY9mh0qqZ1iKsw3ziU2/rjTAWA5OcKjwcR3EcS1AtVMmZgHgovwZ675FZ7lHhVSfbpvZYeAn8zpUeRT51fZoamnzrahK5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGsXwm0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGsXwm0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883AEC116C6;
	Thu, 22 Jan 2026 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769058349;
	bh=FbO4XJAhoyHTC1qMFBSuPB8/XkSCTX62CMZCGPOYvcI=;
	h=Date:From:To:Cc:Subject:From;
	b=QGsXwm0K5CteMp6uBoDMbSfQdAeuWcElmKFm2IxPmUnA8PhOokBaU0mGZiBQeZyqt
	 UpEkP3SGbG6CBcWifaC78aqtLALb/bbegHTtCnEokK6B98xijM/ALZOQWT9FYNXVem
	 tuAwmXz8zlJkWRA6YkYLUY982hqpOJDtl50a/4McBb3pFgZbJqvljPvweCydzIR4GN
	 FUSeCEVjZeF12+C1FA5EX0wA2NNczSdBUcvRIi1CLVBXhPcE33aUtNG3tk4qIMkylh
	 JE2E0JyIHK+a7b12d8qKWVKhzvH+Ny9v4NUF873JyFCWp4P9iUQUx0cls/2NKceblI
	 HdAO4rE+uVs+A==
Date: Thu, 22 Jan 2026 05:05:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.19-rc7
Message-ID: <20260122050548.GA909211@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 173d6f64f9558ff022a777a72eb8669b6cdd2649:

  mshv: release mutex on region invalidation failure (2025-12-18 20:00:10 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260121

for you to fetch changes up to 12ffd561d2de28825f39e15e8d22346d26b09688:

  mshv: handle gpa intercepts for arm64 (2026-01-15 07:29:14 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.19-rc7
 - Fix ARM64 port of the MSHV driver (Anirudh Rayabharam)
 - Fix huge page handling in the MSHV driver (Stanislav Kinsburskii)
 - Minor fixes to driver code (Julia Lawall, Michael Kelley)
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (2):
      mshv: add definitions for arm64 gpa intercepts
      mshv: handle gpa intercepts for arm64

Julia Lawall (1):
      Drivers: hv: vmbus: fix typo in function name reference

Michael Kelley (3):
      Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()
      mshv: Store the result of vfs_poll in a variable of type __poll_t
      mshv: Add __user attribute to argument passed to access_ok()

Stanislav Kinsburskii (1):
      mshv: Align huge page stride with guest mapping

 drivers/hv/hv_common.c      | 12 +++---
 drivers/hv/hyperv_vmbus.h   |  2 +-
 drivers/hv/mshv_eventfd.c   |  2 +-
 drivers/hv/mshv_regions.c   | 93 ++++++++++++++++++++++++++++++---------------
 drivers/hv/mshv_root_main.c | 17 +++++----
 include/hyperv/hvhdk.h      | 47 +++++++++++++++++++++++
 6 files changed, 127 insertions(+), 46 deletions(-)
