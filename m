Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706649;
	b=xzuqv33+GyumyKitanh4rYCDzGkzluryGbc7Uwyv+TFYgKTkcuJtrJbXpRPSj7qI39Cu
	 55ye/eCp89OaGYR+wx+sFccXsTG7tm1cgFYcdKsJO041wfsxrEnkVXt+QO5ehS2A8TEne
	 X+qE1UCJ4YGK5k2I99rA/s/3ajJOmkNxUrsIyyer4Uj54uxM/jpWXA4jncHF2b+SCueTo
	 AXdPTPc42Cyd7zZs6KzwImpbUDknw166gptBGzJaHzYz3QR11+LGMdla89fo1yM3ZF8rV
	 A0Koj1YSBhxn1EvmbqV5o4COHRSO/jx6ySlS3jmaxSioIfpxfdyqr/MFOu7fEpKr9jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706649;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=90Z/2VrWJwwdnNrqjaSepq6lJZp1VP+jwqjBKDqToQE=;
	b=sLg/P7lN9hi47iDNKm7gtinqhe/bSqMufvdlJsjpU+b5QZEy43EAlTpBucvnhrZHuh/E
	 Thxxsf9Ob5eto2WXK/03c/MiLN0DyWphF8IgREgDeRv3sgwV1R1uE+OdMfG1CiMvx+WiV
	 8ml3pt0YdpzENoMRqLf8nhEFKp66PNrlU8cf51t4IyzOGRKCC5qRnIRbg+YNZg3ptvSMd
	 PHS1ia/jYaq5fT1MHDOxA8nHJYxeCI/chnPVOqxDNzHhh+kSeSN0Rm2JPwTBC4J9lExRY
	 Mt2M1xTLMdcpTSpDaElrBuoHNrxE2YBXdAM+7OJErC4QC4TaMOBtYO00knXo9x45wzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NLcHTDk0;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C34606EE99;
	Tue,  3 Nov 2026 11:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C34606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NLcHTDk0
Received: from example.com (unknown [167.220.208.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72A6920B7166;
	Tue,  3 Nov 2026 03:50:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72A6920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793706634;
	bh=90Z/2VrWJwwdnNrqjaSepq6lJZp1VP+jwqjBKDqToQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLcHTDk043xLLWIZDwZi5RG7bz0nectmofp5i/xXmHpxvv1fcM7sUpd1Z89QqCXsa
	 zI9sAmvhmsCMgsGzhMjkLb2wU5HxFgNDrQoYEqgMS2hXtYo84iOpzblytVHdWsgV/i
	 je9Yk7ERJkcy7fiuXlBZCI7qd9irAbZq6K/wvsR0=
Date: Tue, 3 Nov 2026 12:50:44 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Mukesh R <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <aunKlPRx/bhDScrx@example.com>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
 <49a7b3b0-5314-c028-d0e6-a46e65ed880d@linux.microsoft.com>
 <20261030181823.GA581409@liuwe-devbox-debian-v2.local>
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
In-Reply-To: <20261030181823.GA581409@liuwe-devbox-debian-v2.local>

On Fri, Oct 30, 2026 at 11:18:23AM -0700, Wei Liu wrote:
> On Wed, Oct 28, 2026 at 03:54:30PM -0700, Mukesh R wrote:
> > On 9/30/26 05:10, Magnus Kulke wrote:
> > > hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> > > guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> > > ownership of those pages and per contract revokes root partition
> > > access to them, raising a #GP on access from the L1VH root partition.
> > > 
> > > However, the pages remain mapped in the kernel direct map, so kernel
> > > code may still access them even though the hypervisor has revoked
> > > access.
> > > 
> > > Helpers such as "load_unaligned_zeropad()" deliberately read past the
> > > end of a buffer and across page boundaries. A read into an unmapped
> > > page is tolerated and triggers a #PF, for which the kernel executes
> > > a fixup in the exception table.
> > > 
> > > If such a call steps into a page that has been deposited, the access
> > > raises a #GP by the hypervisor from which the above handler cannot
> > > recover and the kernel panics:
> > > 
> > >    Oops: general protection fault, maybe for address 0xff1100941a3dfffc
> > >    RIP: 0010:csum_partial+0xe5/0x110
> > > 
> > > This condition will appear on L1VH system that have created L2
> > > partitions (and hence deposited pages) and exercise networking code
> > > paths such as csum_partial() can trigger this condition when a buffer
> > > ends close to a page boundary (e.g fffc in the above example).
> > > 
> > > The fix is to remove the deposited pages from the direct map before
> > > they are passed to the hypervisor, and restore them when the hypervisor
> > > returns them again.
> > > 
> > > We want to avoid flushing the TLB in the loop, so we use the _noflush()
> > > variant of set_direct_map_valid() when marking a deposited page invalid
> > > and flush the affected page ranges in one go ourselves. In the opposite
> > > direction this is not required:
> > > 
> > >    > If a paging-structure entry is modified to change the P flag from
> > >    > 0 to 1, no invalidation is necessary. This is because no TLB entry
> > >    > or paging-structure cache entry is created with information from a
> > >    > paging-structure entry in which the P flag is 0.
> > > 
> > > (Intel SDM Vol. 3, 4.10.4.3)
> > > 
> > > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > > ---
> > > Changes since v3:
> > > - Batch contiguous pages in the restore path
> > > - Adjusted comment about failure modes
> > > 
> > > Changes since v2:
> > > - Checkpatch format fix
> > > 
> > > Changes since RFC:
> > > - Handle direct-map restoration failures without returning unmapped
> > >    pages to the allocator.
> > > - Move freeing of withdrawn pages into the restoration helper.
> > > ---
> > >   drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
> > >   drivers/hv/mshv_root_hv_call.c |  4 +-
> > >   include/asm-generic/mshyperv.h |  4 ++
> > >   3 files changed, 87 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > > index 57b2c64197cb..b056051a5ac5 100644
> > > --- a/drivers/hv/hv_proc.c
> > > +++ b/drivers/hv/hv_proc.c
> > > @@ -7,7 +7,9 @@
> > >   #include <linux/cpuhotplug.h>
> > >   #include <linux/minmax.h>
> > >   #include <linux/export.h>
> > > +#include <linux/set_memory.h>
> > >   #include <asm/mshyperv.h>
> > > +#include <asm/tlbflush.h>
> > >   /*
> > >    * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> > > @@ -15,6 +17,35 @@
> > >    */
> > >   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> > > +/*
> > > + * Add or remove a set of physically contiguous page runs from the kernel
> > > + * direct map. Once a page has been deposited the hypervisor owns it and
> > > + * revokes root partition access to it.
> > > + */
> > > +static int hv_deposit_update_direct_map(struct page **pages, int *counts,
> > > +					int num_allocations, bool valid)
> > > +{
> > > +	int i, err, ret = 0;
> > > +
> > > +	for (i = 0; i < num_allocations; ++i) {
> > > +		err = set_direct_map_valid_noflush(pages[i], counts[i], valid);
> > > +		if (err && !ret)
> > > +			ret = err;
> > > +	}
> > 
> > I realize I am late to the review, so if too late, please ignore.
> > If the caller is going to not continue on error but will revert,
> > what is the reason to keep going on error then?
> > 
> > And this function should undo it itself if there is error instead
> > of forcing the caller to do it imo. It could just undo the part which
> > is done.
> > 
> 
> Magnus, while you work on rebasing the patch, perhaps you can also
> address this.
> 
> Wei

ack,

magnus
