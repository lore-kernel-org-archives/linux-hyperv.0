Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7749DB91;
	Thu, 15 Oct 2026 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049216; cv=none; b=Fem1LP0s/dLSLRevmNQ/evQm+fZT+P70ZeQ8Kx3U7atwwW+CB9NzJIsqK1ERKTm6Vv4VwWFyLowQhM+aVFPttGNrAYDKrwlN0Q1he7YlVy26ORQgO12HCsJM/WSxf1sNVdClt7IDV0e97fFfly8EjiAU990gFPDoc4pW69PI1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049216; c=relaxed/simple;
	bh=KkAoH9qOejJrCxiTN1zmpYB9UczNYRDdOcAloa58HAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri4niiraNCm9QCSEgvTKNL6Of8VId37yH20CRkybX2vp2A4Y7PU7miQQPXTCXrA3caw7MeFCTgqQjDFdbOnf7x0ruz+aQqzFCv1p5W3p/wFZruohtJF4tC40ltCV8AVs8aPxy34iiENgWFTYn2vZ15MK74xouJoTlPNI6ufc5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kixu3jtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kixu3jtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393CF1F000C4;
	Thu, 15 Oct 2026 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792049207;
	bh=Pf46xFfEGVPZu/Q820g68271K70LkI89BCSOUGYUzss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kixu3jtYFhd+ObD9exXylcLYWSlmFTWFV6xHBK8xrnU3+uk/NDyZcxiIGGExOsuVY
	 ovY8/sLCP32FFRZrrGYxCcE5usFrG48sEjn8NGcNh3epGhPhyZyDY4ioO5hNfNyFK2
	 PSaUL+eJca5cNRe6ebq5QC3zOOe33/by1s469VF0bPMhsC4aZ8fb3wI8hH+oHwaUSU
	 J6L1FSLXR7koOMPxzQLz1GBYmSR90fI3nw4BiGizi3YoqcCwV4WZaSJv9jVLOGGYJZ
	 cO8d5AWjjmVfQM0ip/g23siqeun0DIL5Q7U+NoVeqAiNrtEOUe9yeyxiyS4QFOgdOs
	 sG4HrwUO5brCg==
Date: Thu, 15 Oct 2026 00:26:46 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Emerson Busson <emersonbusson@gmail.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers
 survive buddy fragmentation
Message-ID: <20261015072646.GB936897@liuwe-devbox-debian-v2.local>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>

Hi Emerson

I find the wall of text in the cover letter, commit messages and code
comments extremely difficult to parse.

With AI, generating code is cheap, reviewing is expensive. I don't think
anyone on the list can or should review a patch series like this.

Please make sure you understand the code and deslop the AI-generated
content before posting.

After reading v1, I think I know what you try to solve, but I'm not
going to accept a patch series like this. A lot of the patches don't
seem to be related to the problem you want to solve.

Thanks,
Wei


On Wed, Oct 07, 2026 at 04:07:38PM -0300, Emerson Busson wrote:
> This series moves VMBus ring backing to the chunk allocator and keeps the
> allocation, GPADL ownership, and mapping references together. It preserves
> the exported four-argument interfaces while allowing the private allocation
> paths to carry ownership and sharing policy.
> 
> A review of the original vzalloc fallback noted that CCA and TDX guests
> without a paravisor need direct-map page transitions. This revision uses
> contiguous chunks for buffers that must be host-shared, transitions each
> page through page_address(), and combines the chunks with vmap(). Ordinary
> guest-private buffers retain vzalloc-style allocation.
> 
> Allocation and compatibility
> ----------------------------
> 
> Every ring allocation uses the chunk allocator. Ordinary guests and buffers
> kept private by channel policy use vzalloc(). For host-shared buffers in an
> encrypted or isolated guest, the allocator uses contiguous chunks and
> transitions them page by page. Guest-memory encryption is selected
> independently of Hyper-V isolation.
> 
> Ring consumers select co_ring_buffer. External buffers and the legacy
> allocator select co_external_memory. The exported allocator and caller-
> decrypted GPADL prototypes retain four arguments throughout all fourteen
> patches. UIO migration follows its release support.
> 
> The address, page and chunk arrays, and embedded GPADL belong to one buffer.
> The allocation extent, host-described GPADL extent, and retained allocation
> extent remain distinct. Interior GPADL duplication preserves the existing
> exported interfaces. Prepared owned buffers avoid repeat decryption, and
> HV_GPADL_BUFFER_DECRYPTED is removed.
> 
> Lifetime and host acknowledgement
> ---------------------------------
> 
> A host rescind alone does not prove GPADL revocation. For a known-live GPADL
> whose channel identifier is still held, teardown posts a request and waits
> for a matching GPADL_TORNDOWN message before clearing ownership. Synthetic
> rescind notification cannot replace this acknowledgement. Unknown creates,
> local removal, invalid identifiers, failed posting, and timeouts retain
> ownership.
> 
> Waiter removal shares the response-list lock with matching replies so a late
> acknowledgement cannot use a freed waiter. Released owners retain pages
> across mapping references and failed page-state restoration. Reclaimer
> shutdown cancels pending timers under the owner lock and requeues only work
> that was actually canceled; running callbacks drain through workqueue
> destruction without re-executing freed embedded work.
> 
> Sysfs mappings install no vm_ops and release the bridge pin on every setup
> outcome. UIO mappings hold their pin through VMA close. Page, count, and
> protection snapshots share the owner-lock boundary. New tests call the real
> sysfs wrapper, insert actual PTEs, and check readable bytes and page
> references through success and partial -EBUSY. They do not execute a full
> kernfs syscall or full device destruction.
> 
> The final four fixes use vzalloc() for guest-private requestor arrays and
> bitmaps, kvzalloc_obj() for guest-private RNDIS descriptors, handle NULL
> control requests on empty NetVSC completions, and use kvzalloc_obj()/kvfree()
> for the large guest-private NetVSC device object.
> 
> Qualification on the exact fourteen-patch series
> ------------------------------------------------
> 
> The code mails are pinned by series/SHA256SUMS. Applying all fourteen to
> 93f51579e7df248780214094418f205253383cc5 produces source tree
> e6fe523ca92ce30ea7edb265b8a26bf20a867c47.
> 
> The VMBus workflow builds x86_64 and arm64 with W=1 and C=2, passes sparse,
> and passes all 69 linked x86_64 QEMU KUnit cases. The distinct WSL backport
> passes all 26 of its KUnit cases. CoCo source invariants pass on both
> architectures; these are necessary static checks, not confidential-hardware
> qualification.
> 
> Exact-source Hyper-V runtime, including controlled host rescind:
> https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/37650468077
> 
> On both windows-2025 and windows-latest, the candidate passes 100 bind/unbind
> cycles, bounded buddy fragmentation, channel rebind, UIO mapping teardown,
> and the controlled host-origin NIC removal. Each report records
> HYPERV_DRILL_HOST_RESCIND status=PASS, target_absent=yes,
> matching_events=1. Both report zero splats and faults, restore the measured
> kernel settings, and return lifecycle map accounting to the settled operational
> baseline. Captured owner accounting reports 722 created, zero unobserved
> creates, 715 reclaimed, and seven still active; active owners are not
> classified as leaks. Trace capture has no overruns or dropped events, and
> the disposable VM, VHD, and switch cleanup passes.
> 
> The baseline is an intentional negative control. It reproduces the expected
> fragmented-allocation failure without guest faults; the workflow accepts
> that exact signature as a passing control. It is not a candidate result.
> 
> WSL backport runtime matrix:
> https://github.com/emersonbusson/WSL2-Linux-Kernel/actions/runs/37645708153
> 
> That separate backport passes the actual Windows candidate matrix. Each
> runner completes 64 commands with matching teardown acknowledgements,
> zero unacknowledged requests, no backing or tail growth, and all six
> shutdown checks. The shutdown retry path is covered by 40 local parser and
> refusal regressions; the live candidate runs required zero retries. These
> results qualify the WSL backport's measured ordinary behavior, not the
> mainline mail series.
> 
> Qualification limits
> --------------------
> 
> The Hyper-V runtime uses the ordinary x86_64 vzalloc path. It does not
> execute confidential chunk transitions. Full memory saturation, the
> chunked CoCo fallback on hardware, SEV-SNP, TDX without a paravisor, Arm
> CCA, and complete VMBus module unload and retained-owner destruction remain
> unqualified. The exact mainline series has not been installed or booted on
> the daily WSL host; the installed kernel and Windows WSL matrix are a separate
> backport. The baseline is one intentional fragmentation negative control,
> not a matched same-configuration diagnostic-count comparison for every patch.
> No confidential-platform result is inferred from ordinary Hyper-V or static
> checks.
> 
> ---
> Emerson Busson (14):
>   hv: vmbus: convert ring backing through the chunk allocator
>   hv: vmbus: validate chunk buffer allocation and cleanup
>   uio: hv_generic: describe buffers for owned allocation
>   hv: vmbus: add KUnit tests for GPADL post failure injection
>   hv: vmbus: add KUnit test for order-zero allocation fallback
>   hv: vmbus: cover all shared-page policy combinations
>   hv: vmbus: distinguish host rescind from local channel unload
>   hv: vmbus: retain backing until ownership and references clear
>   hv: use owned VMBus buffers in NetVSC and UIO
>   hv: vmbus: pin buffer pages across UIO mmap to close the reclaim race
>   hv: vmbus: vmalloc requestor metadata
>   hv: netvsc: allocate RNDIS request descriptors with kvzalloc_obj()
>   hv: netvsc: handle a NULL request address on empty completions
>   hv: netvsc: use kvzalloc for device state
