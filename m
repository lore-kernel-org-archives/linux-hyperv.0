Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C927477E4D;
	Thu, 30 Jul 2026 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454487; cv=none; b=H9b7UDprFOUJERrldl8XcLQhGV6g6y12pgdQnZUUC9GwYOIRkxY/O77/tIVH3ekiyz5zNmYp2EJhSU/RNnoANW9ZxDrry+ozQj5ywtHoLaUXU3QxA0CWTZT0qKvsNum+XlxM2Du3CfjwpWRpZAyGNn3w17t6KB04ot1L4h0+xdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454487; c=relaxed/simple;
	bh=JzTGQfZc+bq34S4FJ580Z3fOqsbtklwarbQ7qfQGCPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO2IKmglVLBrfAGj5oDykOizvJevEhnU38j1muNk0E0aBuahS090lKs0JTe+A7+t9Z9su8Dx3tlACZVsIdcS3K3ONqXRAKSCNe9ZGTi2B5WMOdWb0eAyR+7b6TafiEeJvGclvCYtJvrKx7EeV3v8s4XXxfDcwNVJVUhz0ILR1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SRjY6enb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SRjY6enb"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E900E20B7167;
	Thu, 30 Jul 2026 16:34:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E900E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785454463;
	bh=RucA4cTdoZD100NHIS/VD42apsvD09hKC3y6JqFhedE=;
	h=From:To:Cc:Subject:Date:From;
	b=SRjY6enbYbYFJmGnnCMQv9ivfVUh3q+nhyFmoUABZDE+U02SYOltdsdf0G3oYB4/c
	 kkUU59yf4upB9Q1H7Oo91tuA1gBBkCGqaEfJE+A9n6k5S7jCjA64IOFLk6R/Z3DTE+
	 jItmISIjL4Lt/tEhpEtcIsc7Xow/2N98a8tli0LI=
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
Subject: [PATCH v2 0/2] Drivers: hv: decrypt netvsc buffers on contiguous direct-map addresses
Date: Thu, 30 Jul 2026 16:33:57 -0700
Message-ID: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
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

[1]: https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/

Kameron Carr (2):
  Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
  hv_netvsc: Allocate host-visible GPADL buffers as decrypted contiguous
    chunks

 drivers/hv/channel.c            | 185 +++++++++++++++++++++++++++++++-
 drivers/net/hyperv/hyperv_net.h |   8 +-
 drivers/net/hyperv/netvsc.c     | 104 ++++++++++++------
 drivers/net/hyperv/netvsc_drv.c |   6 ++
 include/linux/hyperv.h          |  15 ++-
 5 files changed, 281 insertions(+), 37 deletions(-)

-- 
2.45.4

