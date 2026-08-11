Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA345DF5B;
	Tue, 11 Aug 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464328; cv=none; b=pizOgv9aHmpsBnO00P+E8eQYXvlXxnhESxubyRJQRvwyOAVySqXu45HlFKKO+4jb2MSgNxbxTzE4j2gTgwOFfupcg6PLsJ63UeGhCAW+lTfqneZO3n0CKO1WjVmKrEtSeYKWoXhoa2fOG79LfTJfJQseq16rzN5GOHIxUWVmzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464328; c=relaxed/simple;
	bh=drhGL1j6S3b9Ndo73c7OWgUSL+0yNHq020uWEHohTyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiGLpgT5XrQ//w4e1w9OR1gu9NoHHDvL+K9tFC5IGRqUfgsy/k1UPql0gqnKYxHA2frTR0F5a4neA+DIrEiJsswjJgZx0gW2qLvg/DjCHkdO6ApgQQwZUbgKFuElrT/3jUnVB/OI+X1cjDhlfoprF9SM1RpGflV7JAgf6O+CCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jO19nEff; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jO19nEff"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2072E20B7167;
	Tue, 11 Aug 2026 09:05:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2072E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786464301;
	bh=lkbjGdpj20HRpio5OiBkxn3i7NwuRp9muD+gQpfYvC0=;
	h=From:To:Cc:Subject:Date:From;
	b=jO19nEffS4somCZD4JD5qCsNUYXms8IGAZLsUX1AvLdvOgL5kqLNKlLqyG5IluKDt
	 8dJQQ+y55msnMZpjhh4gMpWbXQu4h0ziy4uO1CLAIsPrGGMkWeO7PuZS2aF8Cdjbqm
	 7yuVDXbAyZn5urOdAcCLI0afd0NQKXB/ORHnoVKY=
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
Subject: [PATCH v4 0/3] Drivers: hv: decrypt netvsc buffers on contiguous direct-map addresses
Date: Tue, 11 Aug 2026 09:04:44 -0700
Message-ID: <20260811160447.2529876-1-kameroncarr@linux.microsoft.com>
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

Changes since v3 [3]:
  - Subject line changes (no code changes)

[1]: https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/
[2]: https://lore.kernel.org/all/20260730233359.3850612-1-kameroncarr@linux.microsoft.com/
[3]: https://lore.kernel.org/all/20260806213326.1425848-1-kameroncarr@linux.microsoft.com/

Kameron Carr (3):
  Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
  Drivers: hv: vmbus: Add vmbus_alloc_buffer()/vmbus_free_buffer() for
    CoCo VMs
  hv_netvsc: Allocate send/receive buffers using vmbus_alloc_buffer()

 drivers/hv/channel.c            | 182 +++++++++++++++++++++++++++++++-
 drivers/net/hyperv/hyperv_net.h |   8 +-
 drivers/net/hyperv/netvsc.c     | 103 ++++++++++++------
 drivers/net/hyperv/netvsc_drv.c |   6 ++
 include/linux/hyperv.h          |  15 ++-
 5 files changed, 277 insertions(+), 37 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4

