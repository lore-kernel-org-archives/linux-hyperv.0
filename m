Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146C480320;
	Thu,  6 Aug 2026 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046798; cv=none; b=QEnavgCG1Qc2Nd9Cbju+EgxlI7dTpsj83213IVpSip6UF9DQh/DHvvzLG8sb/sDwGxJK7f5a7OoLnIyUTRv0tmAGJ+KYkw52w5RDwsr98fYOEU0Ub4EABKlLlg+vI3pShRLEcuOTuhTnIqkrOUs/ro9VgXzaEmQB272e79c6vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046798; c=relaxed/simple;
	bh=Ap0Qmzmts3oLJZ105+phZogBJij9nWouUMEY0x1uZuk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYTqvXtzMHAytzbRhZM7kLvGYdiVqV6zLna6fU8tZNVWoGUW9oQVSvy7ZxIstt5jfsOzzU5vuQxhza0TRXHEPfqZctQvV+QHw23DrDaXMJu0HKblbFD00QSzoMl3IIZC1eT42J1xnF+Af+mWtIfbE8Nuj0GKteC3uyRd+7hPKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oAid7uyS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oAid7uyS"
Received: from DairyQueen (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACD0F20B7128;
	Thu,  6 Aug 2026 13:05:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACD0F20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786046757;
	bh=opTdFPaBV44HR5yoUGxKTjRAiPFf3Is0t+ryAsEWKGU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=oAid7uySaLszQR1S02jcnghuKw+hOQlQQyA5o2OuFM1PXFqcceb/lqrO4tyPY7/ik
	 bJYZhfiKekrqjS22mATGgM7GSDxbsVfEQzgBskHeO8IBaptje0GXPH2/uHuZ9FVl6A
	 Pn2k9/hl9o6TmHwEB3BmQZ1Iq6R8YdOZYDQqr2Oo=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<decui@microsoft.com>,
	<haiyangz@microsoft.com>,
	<kys@microsoft.com>,
	<longli@microsoft.com>,
	<wei.liu@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com> <20260730233359.3850612-3-kameroncarr@linux.microsoft.com> <SN6PR02MB41576627C0DBA40FA8BB49C7D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41576627C0DBA40FA8BB49C7D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as decrypted contiguous chunks
Date: Thu, 6 Aug 2026 13:06:08 -0700
Message-ID: <002d01dd25df$0b94f8b0$22beea10$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIub+xPS5YiyaZvP24gK8Dc9/eqxgFfExjQAiIv4nu10VI0EA==

On Friday, July 31, 2026 8:47 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, July
30, 2026 4:34 PM
> >
> > On CoCo VMs without confidential VMBus, the netvsc send and receive
buffers
> > must be made host-visible by decrypting them. These buffers are
vmalloc'ed,
> > but set_memory_decrypted()/encrypted() do not work on vmalloc'ed memory.
> > This use case is (so far) unique to netvsc, so solve it locally rather
than
> > changing the set_memory() or allocation APIs.
> >
> > Add vmbus_alloc_buffer()/vmbus_free_buffer() to the VMBus core. When the
> > guest's isolation model requires it, allocate the buffer as a list of
> > physically-contiguous chunks via alloc_pages_node(), starting at
> > MAX_PAGE_ORDER and falling back to smaller orders so the allocation
still
> > succeeds under memory fragmentation. Each chunk is decrypted in place
via
> > set_memory_decrypted() on its direct-map address, and the chunks are
then
> > stitched into a single virtually-contiguous range with vmap(). Buffers
that
> > do not need decryption keep using vzalloc().
> >
> > This approach minimizes scattering of decrypted 4 KiB pages through the
> > kernel direct map and the resulting shattering of large page mappings.
> >
> > Use vmbus_establish_gpadl_caller_decrypted() so there is no attempt
> > to decrypt the virtual address. At teardown, vunmap() the range and
> > re-encrypt and free each chunk individually; any chunk that fails
> > re-encryption is leaked to prevent accidentally freeing decrypted
memory.
> >
> > Because vunmap() and set_memory_encrypted() must run in process context,
> > replace the rcu_head/call_rcu() pair used to defer free_netvsc_device()
> > with rcu_work/queue_rcu_work(). This also fixes a small race condition
> > where the buffers may be accessed while being re-encrypted by moving the
> > re-encryption after the RCU grace period.
> >
> > Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> > ---
> >  drivers/hv/channel.c            | 158 ++++++++++++++++++++++++++++++++
> >  drivers/net/hyperv/hyperv_net.h |   8 +-
> >  drivers/net/hyperv/netvsc.c     | 104 ++++++++++++++-------
> >  drivers/net/hyperv/netvsc_drv.c |   6 ++
> >  include/linux/hyperv.h          |   7 ++
> >  5 files changed, 249 insertions(+), 34 deletions(-)
> 
> Arguably, this patch should be broken into two patches. One
> patch adds the buffer allocation/free functions to the VMBus core.
> The second updates netvsc to use the new allocation/free
> functions and to call the free function in the required context.

Ack.

> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
[...]
> > +void *vmbus_alloc_buffer(struct vmbus_channel *channel,
> > +			 u32 size,
> > +			 struct page ***chunks_out,
> > +			 u32 *chunk_cnt_out)
> > +{
> > +	u32 nr_pages = PFN_UP(size);
> 
> Is there a reason for nr_pages to be u32, and then cast it to unsigned
long
> a couple of places below? The first argument to kvmalloc_array() is of
> type size_t.  Avoiding the casts would be incrementally cleaner.

Ack.

> > +	struct page **chunks = NULL;
> > +	struct page **pages = NULL;
> > +	unsigned int order;
> > +	u32 chunk_cnt = 0;
> > +	u32 page_idx = 0;
> > +	u32 remaining = nr_pages;
> > +	void *addr;
> > +	u32 i;
> > +	int ret;
> > +
> > +	*chunks_out = NULL;
> > +	*chunk_cnt_out = 0;
> > +
> > +	if (!nr_pages)
> > +		return NULL;
> > +
> > +	/* If the buffer does not need to be decrypted, just use vzalloc()
*/
> > +	if (!hv_is_isolation_supported() || channel->co_external_memory)
> > +		return vzalloc((unsigned long)nr_pages << PAGE_SHIFT);
> > +
> > +	/* Worst case: every chunk is a single page. */
> > +	chunks = kvmalloc_array(nr_pages, sizeof(*chunks),
> > +				GFP_KERNEL | __GFP_ZERO);
> > +	if (!chunks)
> > +		goto err;
> > +
> > +	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +	if (!pages)
> > +		goto err;
> > +
> > +	/*
> > +	 * @order monotonically decreases across iterations
> > +	 *
> > +	 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing, but try
> > +	 * harder at order 0 since that is the final fallback.
> > +	 */
> > +	order = min(MAX_PAGE_ORDER, ilog2(nr_pages));
> 
> This works, but is more complex than needed. Just set order to
> MAX_PAGE_ORDER, and the min() at the top of the while loop below
> will do the right thing. And you could do order = MAX_PAGE_ORDER
> where order is declared.

Ack.

> > +	while (remaining) {
> > +		struct page *page;
> > +		gfp_t gfp;
> > +
> > +		order = min(order, ilog2(remaining));

Context: this fails to compile on x86 since order is unsigned and ilog2()
is signed.

Is it acceptable to avoid the min_t() by changing order to be a signed int?

> > +
> > +		for (;;) {
> > +			gfp = GFP_KERNEL | __GFP_ZERO;
> > +			if (order)
> > +				gfp |= __GFP_COMP | __GFP_NORETRY |
__GFP_NOWARN;
> > +			page =
alloc_pages_node(cpu_to_node(channel->target_cpu),
> > +						gfp, order);
> > +			if (page)
> > +				break;
> > +			if (!order)
> > +				goto err;
> > +			order--;
> > +		}
> 
> I think this nested for loop can be avoided. At this point in the outer
while
> loop, set the gfp flags and call alloc_pages_node() as you have here. The
> good and normal path is that alloc_pages_node() succeeds. The exception
> path is alloc_pages_node() failing, so you can do:
> 
> 		if (!page) {
> 			if (!order--)
> 				goto err;
> 			continue;
> 		}
> 
> The "continue" just restarts the outer while loop with the decremented
> value of "order" and everything proceeds normally. To me avoiding the
> nested loop is simpler, though "simpler" can be in the eye of the
beholder,
> so if you prefer to keep this as is, I'm OK with that.

I agree. Thank you for the suggestion.

> > +
> > +		ret = set_memory_decrypted((unsigned
long)page_address(page),
> > +					   1U << order);
> > +		if (ret) {
> > +			/*
> > +			 * set_memory_decrypted() failed; the page state is
> > +			 * unknown so it must be leaked rather than freed.
> > +			 */
> > +			goto err;
> > +		}
> > +
> > +		chunks[chunk_cnt++] = page;
> > +
> > +		for (i = 0; i < (1U << order); i++)
> > +			pages[page_idx++] = page + i;
> > +
> > +		remaining -= 1U << order;
> > +	}
> > +
> > +	addr = vmap(pages, nr_pages, VM_MAP, pgprot_decrypted(PAGE_KERNEL));
> > +	if (!addr)
> > +		goto err;
> > +
> > +	memset(addr, 0, (unsigned long)nr_pages << PAGE_SHIFT);
> > +
> > +	kvfree(pages);
> > +	*chunks_out = chunks;
> > +	*chunk_cnt_out = chunk_cnt;
> > +	return addr;
> > +
> > +err:
> > +	kvfree(pages);
> > +	vmbus_free_buffer(NULL, chunks, chunk_cnt);
> > +	return NULL;
> > +}
[...]
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 59e95341f9b1e..1192929d93a86 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -28,6 +28,8 @@
> >  #include "hyperv_net.h"
> >  #include "netvsc_trace.h"
> >
> > +static struct workqueue_struct *netvsc_wq;
> > +
> 
> Does netvsc needs its own workqueue to do the "free" operation,
> or would the system default workqueue (system_dfl_wq) be just
> as good? At first glance, the system_dfl_wq seems like it would work,
> since netvsc free operations are rare and don't have any strict
> latency requirements. But I'm far from being expect in workqueues,
> and there could be subtleties I'm not aware of.

I have to drain the work queue before module unload.
Currently this is handled by destroying the queue.

Originally, I tried using a system wide queue, but I saw that there are
compile time warnings, __warn_flushing_systemwide_wq(), which state:
"WARNING: Flushing system-wide workqueues will be prohibited in near
future."

I got the impression that having a driver specific work queue is best
practice.

- Kameron


