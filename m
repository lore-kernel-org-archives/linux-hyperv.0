Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384306;
	b=RKkQIXHJ1L6noecZFupK3Zjm3CYviALLEwLELaAkTtb9hDryQgz4A38XVEMxq+he/MP7
	 5i5HmKnkGphO+WgV8pafRr/qr3pj4zj5d8r5qvCBOOp9HBdXMibvqTWGKHt0kiB/QGEZb
	 yCChdk1oUwncQ36kIPu9abPl9yqrFcTW9IpN7iO1QuxJlkhyQ1wFwzIjJFrKUjG7v0dbl
	 88Jtq/+rFFOHV2NCCYc1nLLoJrJ5pg7W7mwhWyboDGPmy853GIppDDj+fX9qkOPrfkisw
	 S+oo/95ap4SCo+MX7fqlpgUveKmPs0oqGQoHuEB7Fyz3inWXkJH7uvDQgCnTkgq+JgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384306;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8d1kof1zznXy7nm6rro4noakwVC/Inb4KYV1cw83zlo=;
	b=YsF9JJFD7yUTiTVVN0+iedTRyswKUNzQlZd42F20x/MKObsjH963w0lF18dUaxQSSAGY
	 bC30Yc+RcqFJWW4oNuPHHkcxAQl+Po2kKgqMya4w69KuMtjKtoEZEI4odEUf/No55PEso
	 cIQHY9tUZu+EInR0k1AHZhn1q/iPqDV2eskMJdct4VNsVBmKLetTcZLwTsoHLbAjalIwo
	 llbjWQ582ubC7Mn4bRKMxULc5EM58m2+G+ZxH3CMW/QIHYZv8m3ot19kXpsy+futuQ2Hy
	 aYjAo5Q26tO8DhK2LYASOZYxov3F6BagyI5WMxwhU7sBgnkUGsRDQi163CSEN7RtkDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmGAAVIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEF606A31A;
	Fri, 30 Oct 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmGAAVIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0432A1F0093A;
	Fri, 30 Oct 2026 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384305;
	bh=8d1kof1zznXy7nm6rro4noakwVC/Inb4KYV1cw83zlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmGAAVIMGJXSXx/3b3QNzONz5+wuJo1adqcBUHn5OoVfETlskqSdntIljapoHGe8Z
	 6WOyzjatNMZb/PIIqs0UzOFSmRudqEAgmz3ftczMpjPJNgPwmBzXbbWFxRnR/xAi/a
	 NvaIzVxpTihCf9XCCs7cegxI+Mq8OYgxeWrY3swaq+kJXLy4mSCmHiHxui8WHa85B6
	 xzblXzZFINQd1rBk0RXz+XuMmYVTdnd17e5x0ZtfK9aNQe8GXwp/krWjdDnYAhWhK2
	 7NDujZY0Z4fB27it6WvoXNKVdBQ16gNtN3gyEJaPSqGYQ+bu9Gk0Z/RlXFQw5T6HmL
	 peMzfwRGvVeTg==
Date: Fri, 30 Oct 2026 11:18:23 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <20261030181823.GA581409@liuwe-devbox-debian-v2.local>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
 <49a7b3b0-5314-c028-d0e6-a46e65ed880d@linux.microsoft.com>
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
In-Reply-To: <49a7b3b0-5314-c028-d0e6-a46e65ed880d@linux.microsoft.com>

On Wed, Oct 28, 2026 at 03:54:30PM -0700, Mukesh R wrote:
> On 9/30/26 05:10, Magnus Kulke wrote:
> > hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> > guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> > ownership of those pages and per contract revokes root partition
> > access to them, raising a #GP on access from the L1VH root partition.
> > 
> > However, the pages remain mapped in the kernel direct map, so kernel
> > code may still access them even though the hypervisor has revoked
> > access.
> > 
> > Helpers such as "load_unaligned_zeropad()" deliberately read past the
> > end of a buffer and across page boundaries. A read into an unmapped
> > page is tolerated and triggers a #PF, for which the kernel executes
> > a fixup in the exception table.
> > 
> > If such a call steps into a page that has been deposited, the access
> > raises a #GP by the hypervisor from which the above handler cannot
> > recover and the kernel panics:
> > 
> >    Oops: general protection fault, maybe for address 0xff1100941a3dfffc
> >    RIP: 0010:csum_partial+0xe5/0x110
> > 
> > This condition will appear on L1VH system that have created L2
> > partitions (and hence deposited pages) and exercise networking code
> > paths such as csum_partial() can trigger this condition when a buffer
> > ends close to a page boundary (e.g fffc in the above example).
> > 
> > The fix is to remove the deposited pages from the direct map before
> > they are passed to the hypervisor, and restore them when the hypervisor
> > returns them again.
> > 
> > We want to avoid flushing the TLB in the loop, so we use the _noflush()
> > variant of set_direct_map_valid() when marking a deposited page invalid
> > and flush the affected page ranges in one go ourselves. In the opposite
> > direction this is not required:
> > 
> >    > If a paging-structure entry is modified to change the P flag from
> >    > 0 to 1, no invalidation is necessary. This is because no TLB entry
> >    > or paging-structure cache entry is created with information from a
> >    > paging-structure entry in which the P flag is 0.
> > 
> > (Intel SDM Vol. 3, 4.10.4.3)
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> > Changes since v3:
> > - Batch contiguous pages in the restore path
> > - Adjusted comment about failure modes
> > 
> > Changes since v2:
> > - Checkpatch format fix
> > 
> > Changes since RFC:
> > - Handle direct-map restoration failures without returning unmapped
> >    pages to the allocator.
> > - Move freeing of withdrawn pages into the restoration helper.
> > ---
> >   drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
> >   drivers/hv/mshv_root_hv_call.c |  4 +-
> >   include/asm-generic/mshyperv.h |  4 ++
> >   3 files changed, 87 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 57b2c64197cb..b056051a5ac5 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -7,7 +7,9 @@
> >   #include <linux/cpuhotplug.h>
> >   #include <linux/minmax.h>
> >   #include <linux/export.h>
> > +#include <linux/set_memory.h>
> >   #include <asm/mshyperv.h>
> > +#include <asm/tlbflush.h>
> >   /*
> >    * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> > @@ -15,6 +17,35 @@
> >    */
> >   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> > +/*
> > + * Add or remove a set of physically contiguous page runs from the kernel
> > + * direct map. Once a page has been deposited the hypervisor owns it and
> > + * revokes root partition access to it.
> > + */
> > +static int hv_deposit_update_direct_map(struct page **pages, int *counts,
> > +					int num_allocations, bool valid)
> > +{
> > +	int i, err, ret = 0;
> > +
> > +	for (i = 0; i < num_allocations; ++i) {
> > +		err = set_direct_map_valid_noflush(pages[i], counts[i], valid);
> > +		if (err && !ret)
> > +			ret = err;
> > +	}
> 
> I realize I am late to the review, so if too late, please ignore.
> If the caller is going to not continue on error but will revert,
> what is the reason to keep going on error then?
> 
> And this function should undo it itself if there is error instead
> of forcing the caller to do it imo. It could just undo the part which
> is done.
> 

Magnus, while you work on rebasing the patch, perhaps you can also
address this.

Wei
