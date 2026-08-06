Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D5346E7A;
	Thu,  6 Aug 2026 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052056; cv=none; b=db5xrURDgz1P2/N0yj5+lVYT86WSpjLiD+D+RX9CkuB9qqDsQ4MaxoOJXEPO+jjJAjiQrncMrhVxUHg0mZUjv7lB/tOveaEFIOXaJH6KVq8akSKwxVpL6753n/BtEJDTGnC7k7Yl/OCr8nneoZBZslDUyapywEMu9N9qwjDoCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052056; c=relaxed/simple;
	bh=q/aVbacnGgRHudHOfvxJxz/qLBUI7C4D1ykLfZe6PII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JRxYMiuYSDdPUNTciyutw6Nt8e9lSOsh32nv3200r3LfhJ0grGGEQJp7D5g2selnrdG/UM+pw/SO/+PGstz/8/EQCWtIlY1rc2CHgCXGMZRJ5nuT5+i7lEjzM/mWWw55ZlNVx4bkmCUNSh4adHZoVXhvJOLMCaiqICcaeROoWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BQg721ey; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BQg721ey"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18E6F20B710C;
	Thu,  6 Aug 2026 14:33:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18E6F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786052031;
	bh=TSD+o9YTVjqxiJfuImsRafP+UbGHCdj/0/T9of7oZBo=;
	h=From:To:Cc:Subject:Date:From;
	b=BQg721eyrvmPtSH2j2iEnUO4aFjU1FjoiH8YdfmZk0zX1bFISWy8bb33SKh9HwUv8
	 kNFKDi42mP65IGIvckfENdMJrwuMlHo9CEvceRQZsSSH0Xjf3YwMM5HefUx38gfyWB
	 9Xqi8gbub6iXsTU1FNbu0XvCvk0qIBzafsbFhnpc=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	longli@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/3] Drivers: hv: decrypt netvsc buffers on contiguous direct-map addresses
Date: Thu,  6 Aug 2026 14:33:23 -0700
Message-ID: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm CCA Realms implement set_memory_decrypted() only for addresses in the
kernel linear map; vmalloc()/vmap() addresses are rejected. netvsc
allocates its large send and receive buffers with vzalloc() and passes
those addresses to vmbus_establish_gpadl(), which calls
set_memory_decrypted(), causing GPADL establishment to fail in a Realm.

This series allocates shared buffers as a list of chunks, each physically
contiguous, decrypts each chunk through its direct-map address, and
combines them into a virtually contiguous mapping with vmap(). Private
buffers continue to use vzalloc().

Changes since v1 [1]:
  Patch 1:
    - Add HV_GPADL_BUFFER_DECRYPTED to enum hv_gpadl_type to indicate a
      buffer that has already been decrypted.
  Patch 2:
    - Rename netvsc_{alloc,free}_buf_pages() -> vmbus_{alloc,free}_buffer()
      and move them to channel.c. 
    - Remove struct netvsc_buf_chunk and replace with page folio in
      compound pages.
    - vmbus_alloc_buffer():
      - use vzalloc() for non-host-visible buffers and remove the
        encryption decision out of netvsc.
      - min_t() -> min().
      - zero the memory after allocation.
      - specify @size "will be rounded up to PAGE_SIZE" in the docstring.

Changes since v2 [2]:
  Patch 2:
    - Split patch into two patches, separating new helper functions in 
      VMBus from the netvsc driver changes.
    - Change `nr_pages`, `remaining`, and `page_idx` to unsigned long to
      avoid casting.
    - Move `order` initialization to the top of vmbus_alloc_buffer(),
      removing one min() call.
    - Change `order` to a signed int to avoid needing min_t().
    - Restructure loop in vmbus_alloc_buffer() to avoid nested loops and
      simplify logic.
    - Small comment changes.

[1]: https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/
[2]: https://lore.kernel.org/all/20260730233359.3850612-1-kameroncarr@linux.microsoft.com/


Kameron Carr (3):
  Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
  hv: vmbus: Add vmbus_alloc_buffer()/vmbus_free_buffer() for CoCo VMs
  hv_netvsc: Allocate host-visible GPADL buffers using
    vmbus_alloc_buffer()

 drivers/hv/channel.c            | 182 +++++++++++++++++++++++++++++++-
 drivers/net/hyperv/hyperv_net.h |   8 +-
 drivers/net/hyperv/netvsc.c     | 104 ++++++++++++------
 drivers/net/hyperv/netvsc_drv.c |   6 ++
 include/linux/hyperv.h          |  15 ++-
 5 files changed, 278 insertions(+), 37 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4

