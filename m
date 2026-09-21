Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D63F86FB;
	Mon, 21 Sep 2026 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031046; cv=none; b=GQpC2eDPNUgaaP9DBdQl5ENK/2AuiL9R3vmF/uvEMFVlNfQFw/h1DULohr2Hbjm4LrJoFkjjxMgmKNjnOeD8MSzQpxQfZ/uAIsKVkNN15bGXhJHvQqVo+lHV2SpFWkWbcvlj0knJc3NfdbHE4PD+UYJDBvgVmNt33SBA1tDxyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031046; c=relaxed/simple;
	bh=5GncTix9rPbaM092RkQHa4NAbSQPXMUaI3IxcIijcOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWct9X/4PBBjy5vK2f0wTZpIIqQ2KRrdZyqAlFuaRnrr37h/CODiVboU5VIgc+lprld5L9OSU/DDk3NEHSWtf5+Per0ARrerdx1hckkBOgrnL2okGpR+UhztX8FfFduJHOUCdf1etiEIwdIlv8pl4b+9Qqo2CSdNjqz9/NeEyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QnoGr9Tv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QnoGr9Tv"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9370320B7167;
	Mon, 21 Sep 2026 15:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9370320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790030997;
	bh=T4UVnmGAf435tUMVGxvn7eV45xDSW+zW2b/xkIrQNmw=;
	h=From:To:Cc:Subject:Date:From;
	b=QnoGr9TvZoQOCoCydH+GCIPL7xj7wICqC4ntSF4eip4XXdEZaKubrKCthHtk4y4pw
	 6kZg41hl+avfaA5ts4DQJoKJZeBF4NGLzUsv+ZnATYp4y6KzySZ8LxYV7B/2StBa2i
	 7mIX3GGE9kH+ZTfU7ZuBpsKiUqs7WsLfz6bYz6pc=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V0 0/3] Hyper-V: root VM iommu kernel only driver
Date: Mon, 21 Sep 2026 15:50:25 -0700
Message-ID: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series introduces hyperv root VM iommu kernel only driver. This
driver acts as liason between the hypervisor and iommu layer. Details are
both in the actual commit and in the comments in the file implementing it.

Thanks,
-Mukesh

V0: based on upstream hyperv-next commit be0cfab740e5

Mukesh R (3):
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  mshv: Import data structs around device domains from hyperv headers
  x86/hyperv: Implement Hyper-V virtual IOMMU on root VMs

 arch/x86/hyperv/irqdomain.c          |   9 +-
 arch/x86/include/asm/mshyperv.h      |   6 +
 arch/x86/kernel/pci-dma.c            |   2 +
 drivers/iommu/Kconfig                |   1 +
 drivers/iommu/hyperv/Kconfig         |  15 +
 drivers/iommu/hyperv/Makefile        |   1 +
 drivers/iommu/hyperv/hv-iommu-root.c | 645 +++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h       |   3 +
 include/hyperv/hvgdk_mini.h          |   9 +
 include/hyperv/hvhdk_mini.h          |  90 ++++
 include/linux/hyperv.h               |   6 +
 11 files changed, 783 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

