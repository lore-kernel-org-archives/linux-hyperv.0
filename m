Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E73F412C
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400086; cv=none; b=JfaczfEv8gY9USgDMeOlmEI6dtY2EY1hkuJfYxNI3Na5BdCrDtmlj9CHsFXIQc8bSvvf8weRZrGNzvQdLl9yR6JdDw5RgHIterWGqb57WCaiw6Vp8GDHwYxGh1OujOWRGdoMpq8P0nMVVYq9eSxXd/vEd3L5QU2aQPAtTRrLzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400086; c=relaxed/simple;
	bh=uh8JA1H9/jfpcvetjt9JHjeo0bOWMTIhWfx+KOoFI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TK4OKH4rSS7UrhL07X2Y1WASzyEYFO2dGQExdWbdq8yzrfYbDZnk7gvTVSyNErw+JtPQzpQ49HT8YeSkhLPEmq3pQN2lHYxR0dvp98VVXDnS2jgunSt4mUPue1q1pywEWzbSD18zLsV6CGyrP0LI082oWygtijwRzKzQs/JckVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcsdSmG+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcsdSmG+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5cca5351b56so616610e0c.1
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400082; x=1792004882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rus/aaQtfqxW/kOzxONv3suVIcIuM8ehKkz4oCrtyBA=;
        b=IcsdSmG+Slp3o0WZHh5j1Ns9MXAqTmZllzrSq9IkaE27QG40E5SO/1Q6O0lIMumvOO
         RvF0qNW2OBmt0PU76Wz4TwlzHxg1yxP4L+/iNAfGaV4xp8k+zaDpemx5rJCkW3YWApKq
         vw9O8UYStW5sGlQ93wZBcyiSuW3jYH1xvcDnI6E5RA+m4eLtxsujuJZGEID87rdiE6p2
         tu6t8rKaZI7crjg3CRBbI7q76QGIZ3S+KQhpbm3gRNTSr1wI/r0yKAtghRl8ky8iAb4r
         vj/D5Y1x8FEYao4kP2knaUzsLnlYIcQShatKtUdQ44S77qP0cT1bqF8YYN6eD76ZXp1j
         Kzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400082; x=1792004882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rus/aaQtfqxW/kOzxONv3suVIcIuM8ehKkz4oCrtyBA=;
        b=oCBLJxJDY/X5pur5fhYkNuczBRPBSk++wwqcsXy1noByZZ6AEuA0XT8nXcB63pKLJW
         8O9ma182Y3mZobEPK9DhGj9Ht5wXAGxAl/58z9uhQovnodJ/0lskk4SvzjaWjCL3z9fn
         OAItV0Dk2ycR2R3P8P6trXfpFH2tKwb1uR3h/l5h41nJr7VGOb7cOVKNjek68tqUedG9
         juqCedcdrlDJopyh3ljq4sOCuX0lJ3eV4kgsLP/Ai9ki868EhCtEOlIyrhcKRr6+1YdT
         i07khkF7RbIKvfbwb4YKg5c93wHpYFKgjEB8TtNJbTs//5USwNiri3SloO0Pumf+ubOH
         XFgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYnfpTvu1FWqNLjXBPhGoM76nEUkCAXawJYbO5an/KZpV34ol3/R3s6A5AN6KqlpkZLUx2RW/w8j+nWxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2KTQ/Npo9fD0vUvbG4guTBTW4csVPUu4Avh5CYlF77x+tTOie
	coASY4VqRgiHlmnRJq8hH/sLs1NMJpctFpBzUtAmDlOpP+g0ePMRQegl
X-Gm-Gg: AYBFou06Qyynsgis5Wu+Etd827wd6YW8Yp7rmTfobNSqLMs6Tg/aU7RozPNekkHqDe4
	Kchgqm261OCXgCkBKBvDAvUL/GwttgYYbgrgXtzhKJoSbF3kS51zDmChwnb/4sJtKdeuDqZX6jd
	vA+XvagieWIjfO4DLoQ/InskVMUiMw8quszZqdN9Ed4/uPMzF07tXOSKwubou1c+O9w/GeKpJtF
	iDm8qeGVfY0YmYnPhsE7xkCkPGxnP51CveD2mg8p4onuHl9jjqaTX4sv7S+HgiMW+n1TuA93IyC
	Jd1a5eFa1X196DxWD6LJIV1doCcqa3w+KvvZSb9uivfM4FjOSHzE6A4kZnEkLC4NYTPeZ5jti9j
	xMbJKwaGz2/nfmuI2+Af5OdiuUDe2O1Si5Nj47/CEVYVdM5TqCMaUXSTz9Z5ySkFeEhXYAC0B32
	iejMRM96vx6j6ThqeW6p38t/KaheXc29Ez561aIs/mTV7uYsBqAjgJxE73t00u6ddAH6gSolXDx
	fvnQEJE5yXkgKTd68U=
X-Received: by 2002:a05:6102:418c:b0:7c3:2401:c4be with SMTP id ada2fe7eead31-7ca38b448cbmr781417137.14.1791400081998;
        Wed, 07 Oct 2026 12:08:01 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:01 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers survive buddy fragmentation
Date: Wed,  7 Oct 2026 16:07:38 -0300
Message-ID: <20261007190752.336426-1-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves VMBus ring backing to the chunk allocator and keeps the
allocation, GPADL ownership, and mapping references together. It preserves
the exported four-argument interfaces while allowing the private allocation
paths to carry ownership and sharing policy.

A review of the original vzalloc fallback noted that CCA and TDX guests
without a paravisor need direct-map page transitions. This revision uses
contiguous chunks for buffers that must be host-shared, transitions each
page through page_address(), and combines the chunks with vmap(). Ordinary
guest-private buffers retain vzalloc-style allocation.

Allocation and compatibility
----------------------------

Every ring allocation uses the chunk allocator. Ordinary guests and buffers
kept private by channel policy use vzalloc(). For host-shared buffers in an
encrypted or isolated guest, the allocator uses contiguous chunks and
transitions them page by page. Guest-memory encryption is selected
independently of Hyper-V isolation.

Ring consumers select co_ring_buffer. External buffers and the legacy
allocator select co_external_memory. The exported allocator and caller-
decrypted GPADL prototypes retain four arguments throughout all fourteen
patches. UIO migration follows its release support.

The address, page and chunk arrays, and embedded GPADL belong to one buffer.
The allocation extent, host-described GPADL extent, and retained allocation
extent remain distinct. Interior GPADL duplication preserves the existing
exported interfaces. Prepared owned buffers avoid repeat decryption, and
HV_GPADL_BUFFER_DECRYPTED is removed.

Lifetime and host acknowledgement
---------------------------------

A host rescind alone does not prove GPADL revocation. For a known-live GPADL
whose channel identifier is still held, teardown posts a request and waits
for a matching GPADL_TORNDOWN message before clearing ownership. Synthetic
rescind notification cannot replace this acknowledgement. Unknown creates,
local removal, invalid identifiers, failed posting, and timeouts retain
ownership.

Waiter removal shares the response-list lock with matching replies so a late
acknowledgement cannot use a freed waiter. Released owners retain pages
across mapping references and failed page-state restoration. Reclaimer
shutdown cancels pending timers under the owner lock and requeues only work
that was actually canceled; running callbacks drain through workqueue
destruction without re-executing freed embedded work.

Sysfs mappings install no vm_ops and release the bridge pin on every setup
outcome. UIO mappings hold their pin through VMA close. Page, count, and
protection snapshots share the owner-lock boundary. New tests call the real
sysfs wrapper, insert actual PTEs, and check readable bytes and page
references through success and partial -EBUSY. They do not execute a full
kernfs syscall or full device destruction.

The final four fixes use vzalloc() for guest-private requestor arrays and
bitmaps, kvzalloc_obj() for guest-private RNDIS descriptors, handle NULL
control requests on empty NetVSC completions, and use kvzalloc_obj()/kvfree()
for the large guest-private NetVSC device object.

Qualification on the exact fourteen-patch series
------------------------------------------------

The code mails are pinned by series/SHA256SUMS. Applying all fourteen to
93f51579e7df248780214094418f205253383cc5 produces source tree
e6fe523ca92ce30ea7edb265b8a26bf20a867c47.

The VMBus workflow builds x86_64 and arm64 with W=1 and C=2, passes sparse,
and passes all 69 linked x86_64 QEMU KUnit cases. The distinct WSL backport
passes all 26 of its KUnit cases. CoCo source invariants pass on both
architectures; these are necessary static checks, not confidential-hardware
qualification.

Exact-source Hyper-V runtime, including controlled host rescind:
https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/37650468077

On both windows-2025 and windows-latest, the candidate passes 100 bind/unbind
cycles, bounded buddy fragmentation, channel rebind, UIO mapping teardown,
and the controlled host-origin NIC removal. Each report records
HYPERV_DRILL_HOST_RESCIND status=PASS, target_absent=yes,
matching_events=1. Both report zero splats and faults, restore the measured
kernel settings, and return lifecycle map accounting to the settled operational
baseline. Captured owner accounting reports 722 created, zero unobserved
creates, 715 reclaimed, and seven still active; active owners are not
classified as leaks. Trace capture has no overruns or dropped events, and
the disposable VM, VHD, and switch cleanup passes.

The baseline is an intentional negative control. It reproduces the expected
fragmented-allocation failure without guest faults; the workflow accepts
that exact signature as a passing control. It is not a candidate result.

WSL backport runtime matrix:
https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/37645708153

That separate backport passes the actual Windows candidate matrix. Each
runner completes 64 commands with matching teardown acknowledgements,
zero unacknowledged requests, no backing or tail growth, and all six
shutdown checks. The shutdown retry path is covered by 40 local parser and
refusal regressions; the live candidate runs required zero retries. These
results qualify the WSL backport's measured ordinary behavior, not the
mainline mail series.

Qualification limits
--------------------

The Hyper-V runtime uses the ordinary x86_64 vzalloc path. It does not
execute confidential chunk transitions. Full memory saturation, the
chunked CoCo fallback on hardware, SEV-SNP, TDX without a paravisor, Arm
CCA, and complete VMBus module unload and retained-owner destruction remain
unqualified. The exact mainline series has not been installed or booted on
the daily WSL host; the installed kernel and Windows WSL matrix are a separate
backport. The baseline is one intentional fragmentation negative control,
not a matched same-configuration diagnostic-count comparison for every patch.
No confidential-platform result is inferred from ordinary Hyper-V or static
checks.

---
Emerson Busson (14):
  hv: vmbus: convert ring backing through the chunk allocator
  hv: vmbus: validate chunk buffer allocation and cleanup
  uio: hv_generic: describe buffers for owned allocation
  hv: vmbus: add KUnit tests for GPADL post failure injection
  hv: vmbus: add KUnit test for order-zero allocation fallback
  hv: vmbus: cover all shared-page policy combinations
  hv: vmbus: distinguish host rescind from local channel unload
  hv: vmbus: retain backing until ownership and references clear
  hv: use owned VMBus buffers in NetVSC and UIO
  hv: vmbus: pin buffer pages across UIO mmap to close the reclaim race
  hv: vmbus: vmalloc requestor metadata
  hv: netvsc: allocate RNDIS request descriptors with kvzalloc_obj()
  hv: netvsc: handle a NULL request address on empty completions
  hv: netvsc: use kvzalloc for device state
