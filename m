Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650805;
	b=mRwNM0BPAUAKnbO+8yLAmns6awU79Ca8twIEjZUQcu9jCabDh2oIgoJmeZz+tWAfwhMT
	 6BC41o6K+YbqAaVmzW4COdDeNz9eNeHSE1qMbnqStl95+gN2CLdujAkQ/YLV7digAbKxt
	 9zxTHQR3tpiRb64sXx+VIK87kzzPboAj9Su7SMZ+LgBY/YtybdezP3tYDjdPIIHkpM1qJ
	 n7Dz0+bFKzwF1IcZsdHfmHAR/Nf0T/JjhvBAWiIeHAh4re1wk820OhLosziZhUkdWiSpU
	 nLgc5HDrPhEFYIY0chk25iNK4FYs4NgB3zAVuKNZAKVONX2G1PMC2lgK1iXuoqQk+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650805;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=x9JMzvFtYJsewmHl+kiCGyQmQFuz/m2DnFsTuD16ctg=;
	b=sKRiEv38m9pvX/5/AEcLDQeoMQtyLfIEnE+EBk/m0HKaDa3r8sVVoClIAidkkhOJH0GN
	 WtX7HEF6nDbPGB1USA1G6zm7wfAg53nir+ziBrn57UPCP/+x70JuLb5hndPhX2uqsecD9
	 7iKDKwWVZIeb2QLeXhE8n8U953w1Scn22xFihFXw633mf4NuPJfQmbMutIwjtoHl+xSnL
	 h7gDzm5VSzN90CgqIB6IxFHbf+sdjXmPw4TdKOspgNB/y3Y1DfHXvvAqpp99LwJg0ACOV
	 ApVzGeN6H7ktYPmisqLhcRcw4GX8p4vJQh/In082E9B3QsciT5f+0iuX4WfsQeMeBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rbJ9pCzm;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A49606A31E;
	Wed, 25 Nov 2026 23:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rbJ9pCzm
Received: from [192.168.4.47] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEAD820B7170;
	Wed, 25 Nov 2026 15:53:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEAD820B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795650797;
	bh=x9JMzvFtYJsewmHl+kiCGyQmQFuz/m2DnFsTuD16ctg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rbJ9pCzm/cOBe6psn42NO8Jx3Y2bxRVT0+P2xPJlSPuT87BZyT9geOv476WmbCICr
	 EOgYQf/T+EF5vKg3h0TvRPfAMV4KhyPVoDDW2Do97HnJZ1sb1TuQkFedsfPDsirRdY
	 2AxQ4ilaIwwSI333Owkyz1G4O2xAuFEUliM6pbpA=
Message-ID: <bef5907a-4b64-4f23-8c3e-0d9a6e89439f@linux.microsoft.com>
Date: Wed, 25 Nov 2026 15:53:14 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hv: vmbus: allocate ring buffers via
 vmbus_alloc_buffer()
To: Emerson Busson <emersonbusson@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261124214030.174246-1-emersonbusson@gmail.com>
 <20261124214030.174246-3-emersonbusson@gmail.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261124214030.174246-3-emersonbusson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/2026 1:40 PM, Emerson Busson wrote:
> vmbus_alloc_ring() allocates both ring buffers as a single high-order
> contiguous block via alloc_pages_node() (e.g., order-7 for a 512 KiB
> ring). Under physical memory fragmentation, opening new channels or
> subchannels fails with -ENOMEM even when plenty of order-0 pages remain
> available.
> 
> Allocate ring buffers through vmbus_alloc_buffer() using
> channel->co_ring_buffer and embed struct vmbus_buffer directly in
> struct vmbus_channel. Ordinary and confidential rings use
> vzalloc_node(), while host-visible rings in isolated guests (SNP, TDX,
> and CCA) use the chunked direct-map decryption and vmap() path.
> 
> Update hv_ringbuffer_init() to take the ring's struct page array and
> use kvcalloc()/kvzalloc() for its wraparound page table and packet copy
> buffer. Update uio_hv_generic to map non-contiguous ring pages via
> mmap_action_map_kernel_pages() (with pgprot_decrypted() for shared
> rings) and UIO_MEM_VIRTUAL.
> 
> With all GPADL callers now allocating and decrypting buffers through
> vmbus_alloc_buffer(), drop struct vmbus_gpadl and remove the duplicate
> set_memory_decrypted()/set_memory_encrypted() handling from GPADL
> establishment and teardown.
> 
> Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
> ---
>  drivers/hv/channel.c         | 206 ++++++++++++-----------------------
>  drivers/hv/hyperv_vmbus.h    |   4 +-
>  drivers/hv/ring_buffer.c     |  17 +--
>  drivers/uio/uio_hv_generic.c |  32 +++---
>  include/linux/hyperv.h       |  13 +--
>  5 files changed, 98 insertions(+), 174 deletions(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 9807ff35a1..c0bf154915 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
> @@ -154,15 +155,7 @@ void vmbus_free_ring(struct vmbus_channel *channel)
>  {
>  	hv_ringbuffer_cleanup(&channel->outbound);
>  	hv_ringbuffer_cleanup(&channel->inbound);
> -
> -	if (channel->ringbuffer_page) {
> -		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
> -		if (!channel->ringbuffer_gpadlhandle.decrypted)
> -			__free_pages(channel->ringbuffer_page,
> -			     get_order(channel->ringbuffer_pagecount
> -				       << PAGE_SHIFT));
> -		channel->ringbuffer_page = NULL;
> -	}
> +	vmbus_free_buffer(&channel->ringbuffer);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_ring);
>  
> @@ -170,25 +163,33 @@ EXPORT_SYMBOL_GPL(vmbus_free_ring);
>  int vmbus_alloc_ring(struct vmbus_channel *newchannel,
>  		     u32 send_size, u32 recv_size)
>  {
> -	struct page *page;
> -	int order;
> +	struct vmbus_buffer *buffer = &newchannel->ringbuffer;
> +	u32 size, page_cnt, i;
> +	int ret;
>  
> -	if (send_size % PAGE_SIZE || recv_size % PAGE_SIZE)
> +	if (!send_size || !recv_size ||
> +	    send_size % PAGE_SIZE || recv_size % PAGE_SIZE ||
> +	    check_add_overflow(send_size, recv_size, &size))
>  		return -EINVAL;
>  
> -	/* Allocate the ring buffer */
> -	order = get_order(send_size + recv_size);
> -	page = alloc_pages_node(cpu_to_node(newchannel->target_cpu),
> -				GFP_KERNEL|__GFP_ZERO, order);
> -
> -	if (!page)
> -		page = alloc_pages(GFP_KERNEL|__GFP_ZERO, order);
> +	ret = vmbus_alloc_buffer(newchannel, size, newchannel->co_ring_buffer,
> +				 buffer);
> +	if (ret)
> +		return ret;
>  
> -	if (!page)
> +	page_cnt = size >> PAGE_SHIFT;
> +	buffer->pages = kvcalloc(page_cnt, sizeof(*buffer->pages), GFP_KERNEL);
> +	if (!buffer->pages) {
> +		vmbus_free_buffer(buffer);
>  		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < page_cnt; i++)
> +		buffer->pages[i] =
> +			vmalloc_to_page(buffer->addr +
> +					((unsigned long)i << PAGE_SHIFT));

Sashiko wrote:
  "...vmalloc_to_page() computes a PFN with the unprotected IPA top bit
  set and returns a bogus struct page pointer outside valid RAM.
  hv_ringbuffer_init() then hits
  WARN_ON(!pfn_valid(page_to_pfn(page)))..."


I agree with Sashiko's comment here. I confirmed that this breaks ARM
CCA.

You might be able to mask out the PROT_NS_SHARED bit, but Sashiko's
recommendation also makes sense: instead of page array -> vmap -> back
to page array, why not just use the original page array instead of
throwing it out.

Sashiko also points out some other code locations that use
vmalloc_to_page(). I wonder if this needs a more general solution.

Sashiko was spot on about the call trace that results:
[    0.794657] hv_vmbus: registering driver hv_netvsc
[    0.798391] ------------[ cut here ]------------
[    0.798391] WARNING: mm/vmalloc.c:577 at vmap_small_pages_range_noflush+0x48c/0x50c, CPU#0: kworker/u4:0/12
[    0.844897] Modules linked in:
[    0.846829] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted 7.4.0-rc1-00010-g84ec875ab783 #4 PREEMPT
[    0.852794] Hardware name: microsoft,hyperv (DT)
[    0.855624] Workqueue: async async_run_entry_fn
[    0.858266] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[    0.862687] pc : vmap_small_pages_range_noflush+0x48c/0x50c
[    0.866306] lr : vmap+0x74/0xf0
[    0.868418] sp : ffff8000801ef970
[    0.870612] x29: ffff8000801ef970 x28: fffffc1fc0000000 x27: 0000000000000000
[    0.874933] x26: ffff800080b50000 x25: ffffc6dde5f661a0 x24: ffff0000101105a8
[    0.879615] x23: 0040000000000041 x22: 0010000000000001 x21: ffff800080ba0000
[    0.883982] x20: ffff0000115bc540 x19: ffff000010100020 x18: 0000000000000000
[    0.888229] x17: ffff3922599e0000 x16: ffff800080000000 x15: 32b598eba765892a
[    0.892658] x14: 00004651614f5e04 x13: 0000000000000387 x12: 0000000000000387
[    0.897096] x11: 0000000000000000 x10: ffff800080bb0000 x9 : ffffc6dde5f66000
[    0.901507] x8 : ffffc6dde6fdc000 x7 : ffffc6dde6f44000 x6 : ffff8000a0b50000
[    0.905893] x5 : ffff000010061de0 x4 : ffffffffc0047f00 x3 : ffff00003ffc6a80
[    0.910491] x2 : 00000000000000b5 x1 : 0000000000000000 x0 : 0000000100000000
[    0.914752] Call trace:
[    0.916243]  vmap_small_pages_range_noflush+0x48c/0x50c (P)
[    0.919630]  vmap+0x74/0xf0
[    0.921279]  hv_ringbuffer_init+0xc8/0x1c8
[    0.923847]  __vmbus_open+0x138/0x414
[    0.926192]  vmbus_open+0x6c/0xa8
[    0.928181]  storvsc_connect_to_vsp+0x74/0x474
[    0.930894]  storvsc_probe+0x168/0x45c
[    0.933173]  vmbus_probe+0x44/0xa0
[    0.935205]  really_probe+0xbc/0x29c
[    0.937327]  __driver_probe_device+0x16c/0x19c
[    0.940078]  driver_probe_device+0x3c/0x114
[    0.942640]  __driver_attach_async_helper+0x58/0xcc
[    0.945592]  async_run_entry_fn+0x34/0xe0
[    0.948191]  process_one_work+0x180/0x2dc
[    0.950801]  worker_thread+0x184/0x2fc
[    0.953069]  kthread+0x10c/0x120
[    0.955036]  ret_from_fork+0x10/0x20
[    0.957205] ---[ end trace 0000000000000000 ]---

>  
> -	newchannel->ringbuffer_page = page;
> -	newchannel->ringbuffer_pagecount = (send_size + recv_size) >> PAGE_SHIFT;
> +	newchannel->ringbuffer_pagecount = page_cnt;
>  	newchannel->ringbuffer_send_offset = send_size >> PAGE_SHIFT;
>  
>  	return 0;
> @@ -432,17 +433,14 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
>   *
>   * @channel: a channel
>   * @type: the type of the corresponding GPADL, only meaningful for the guest.
> - * @kbuffer: from kmalloc or vmalloc
> - * @size: page-size multiple
> + * @buffer: buffer allocated with vmbus_alloc_buffer()
>   * @send_offset: the offset (in bytes) where the send ring buffer starts,
> - *              should be 0 for BUFFER type gpadl
> - * @gpadl_handle: some funky thing
> + *               should be 0 for BUFFER type gpadl
>   */
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
> -				   enum hv_gpadl_type type, void *kbuffer,
> -				   u32 size, u32 send_offset,
> -				   bool caller_decrypted, u32 *gpadl_handle,
> -				   bool *decrypted, bool *leak)
> +				   enum hv_gpadl_type type,
> +				   struct vmbus_buffer *buffer,
> +				   u32 send_offset)
>  {
>  	struct vmbus_channel_gpadl_header *gpadlmsg;
>  	struct vmbus_channel_gpadl_body *gpadl_body;
> @@ -452,42 +450,17 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  	u32 next_gpadl_handle;
>  	unsigned long flags;
>  	bool posted = false;
> -	bool need_decrypt;
>  	int ret = 0;
>  
> -	if (leak)
> -		*leak = false;
> +	buffer->leak = false;
>  
>  	next_gpadl_handle =
>  		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
>  
> -	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
> -	if (ret) {
> -		if (decrypted)
> -			*decrypted = false;
> +	ret = create_gpadl_header(type, buffer->addr, buffer->size,
> +				  send_offset, &msginfo);

create_gpadl_header() might need an extra bounds check on size now.
Large ring buffers would have been rejected by the allocator before, but
will now succeed. A large buffer could overflow the 16-bit
gpadl_header->range_buflen.

> +	if (ret)
>  		return ret;
> -	}
> -
> -	need_decrypt = !caller_decrypted &&
> -		!((channel->co_external_memory && type == HV_GPADL_BUFFER) ||
> -		  (channel->co_ring_buffer && type == HV_GPADL_RING));
> -	if (decrypted)
> -		*decrypted = need_decrypt;
> -	if (need_decrypt) {
> -		/*
> -		 * If set_memory_decrypted() fails, the encryption state is
> -		 * unknown; leave *decrypted true so the memory is leaked.
> -		 */
> -		ret = set_memory_decrypted((unsigned long)kbuffer,
> -					   PFN_UP(size));
> -		if (ret) {
> -			dev_warn(&channel->device_obj->device,
> -				 "Failed to set host visibility for new GPADL %d.\n",
> -				 ret);
> -			vmbus_free_channel_msginfo(msginfo);
> -			return ret;
> -		}
> -	}
>  
>  	init_completion(&msginfo->waitevent);
>  	msginfo->waiting_channel = channel;
> @@ -552,7 +525,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  	}
>  
>  	/* At this point, we received the gpadl created msg */
> -	*gpadl_handle = gpadlmsg->gpadl;
> +	buffer->gpadl_handle = gpadlmsg->gpadl;
>  	posted = false;
>  
>  cleanup:
> @@ -562,14 +535,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  
>  	vmbus_free_channel_msginfo(msginfo);
>  
> -	if (ret && posted && leak)
> -		*leak = true;
> -
> -	if (ret && !posted && need_decrypt) {
> -		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)) &&
> -		    decrypted)
> -			*decrypted = false;
> -	}
> +	if (ret && posted)
> +		buffer->leak = true;
>  
>  	return ret;
>  }
> @@ -587,10 +554,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  int vmbus_establish_gpadl(struct vmbus_channel *channel,
>  			  struct vmbus_buffer *buffer)
>  {
> -	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, buffer->addr,
> -				       buffer->size, 0U, true,
> -				       &buffer->gpadl_handle, NULL,
> -				       &buffer->leak);
> +	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, buffer, 0U);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>  
> @@ -824,17 +788,13 @@ static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
>  	bitmap_free(rqstor->req_bitmap);
>  }
>  
> -static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
> -				  u32 *gpadl_handle, void *kbuffer,
> -				  u32 size, bool *decrypted, bool *leak);
> -
>  static int __vmbus_open(struct vmbus_channel *newchannel,
>  		       void *userdata, u32 userdatalen,
>  		       void (*onchannelcallback)(void *context), void *context)
>  {
>  	struct vmbus_channel_open_channel *open_msg;
>  	struct vmbus_channel_msginfo *open_info = NULL;
> -	struct page *page = newchannel->ringbuffer_page;
> +	struct vmbus_buffer *buffer = &newchannel->ringbuffer;
>  	u32 send_pages, recv_pages;
>  	unsigned long flags;
>  	int err;
> @@ -842,6 +802,10 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	if (userdatalen > MAX_USER_DEFINED_BYTES)
>  		return -EINVAL;
>  
> +	if (!buffer->addr || !buffer->pages || buffer->leak ||
> +	    buffer->gpadl_handle)
> +		return -EINVAL;
> +
>  	send_pages = newchannel->ringbuffer_send_offset;
>  	recv_pages = newchannel->ringbuffer_pagecount - send_pages;
>  
> @@ -862,29 +826,21 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  		newchannel->max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE;
>  
>  	/* Establish the gpadl for the ring buffer */
> -	newchannel->ringbuffer_gpadlhandle.gpadl_handle = 0;
> -
> -	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
> -				      page_address(newchannel->ringbuffer_page),
> -				      (send_pages + recv_pages) << PAGE_SHIFT,
> -				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
> -				      false,
> -				      &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
> -				      &newchannel->ringbuffer_gpadlhandle.decrypted,
> -				      NULL);
> +	buffer->gpadl_handle = 0;
> +
> +	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING, buffer,
> +				      newchannel->ringbuffer_send_offset << PAGE_SHIFT);
>  	if (err)
>  		goto error_clean_ring;
> -	newchannel->ringbuffer_gpadlhandle.buffer =
> -		page_address(newchannel->ringbuffer_page);
> -	newchannel->ringbuffer_gpadlhandle.size =
> -		(send_pages + recv_pages) << PAGE_SHIFT;
>  
>  	err = hv_ringbuffer_init(&newchannel->outbound,
> -				 page, send_pages, 0, newchannel->co_ring_buffer);
> +				 buffer->pages, send_pages, 0,
> +				 newchannel->co_ring_buffer);
>  	if (err)
>  		goto error_free_gpadl;
>  
> -	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
> +	err = hv_ringbuffer_init(&newchannel->inbound,
> +				 buffer->pages + send_pages,
>  				 recv_pages, newchannel->max_pkt_size,
>  				 newchannel->co_ring_buffer);
>  	if (err)
> @@ -906,8 +862,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	open_msg->header.msgtype = CHANNELMSG_OPENCHANNEL;
>  	open_msg->openid = newchannel->offermsg.child_relid;
>  	open_msg->child_relid = newchannel->offermsg.child_relid;
> -	open_msg->ringbuffer_gpadlhandle
> -		= newchannel->ringbuffer_gpadlhandle.gpadl_handle;
> +	open_msg->ringbuffer_gpadlhandle = buffer->gpadl_handle;
>  	/*
>  	 * The unit of ->downstream_ringbuffer_pageoffset is HV_HYP_PAGE and
>  	 * the unit of ->ringbuffer_send_offset (i.e. send_pages) is PAGE, so
> @@ -965,12 +920,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  error_free_info:
>  	kfree(open_info);
>  error_free_gpadl:
> -	__vmbus_teardown_gpadl(newchannel,
> -			       &newchannel->ringbuffer_gpadlhandle.gpadl_handle,
> -			       newchannel->ringbuffer_gpadlhandle.buffer,
> -			       newchannel->ringbuffer_gpadlhandle.size,
> -			       &newchannel->ringbuffer_gpadlhandle.decrypted,
> -			       NULL);
> +	vmbus_teardown_gpadl(newchannel, buffer);
>  error_clean_ring:
>  	hv_ringbuffer_cleanup(&newchannel->outbound);
>  	hv_ringbuffer_cleanup(&newchannel->inbound);
> @@ -1013,20 +963,24 @@ int vmbus_open(struct vmbus_channel *newchannel,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_open);
>  
> -static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
> -				  u32 *gpadl_handle, void *kbuffer,
> -				  u32 size, bool *decrypted, bool *leak)
> +/*
> + * vmbus_teardown_gpadl - Teardown the specified GPADL handle
> + */
> +int vmbus_teardown_gpadl(struct vmbus_channel *channel,
> +			 struct vmbus_buffer *buffer)
>  {
>  	struct vmbus_channel_gpadl_teardown *msg;
>  	struct vmbus_channel_msginfo *info;
>  	unsigned long flags;
>  	int ret = 0;
>  
> +	if (!buffer->gpadl_handle)
> +		return 0;
> +
>  	info = kzalloc(sizeof(*info) +
>  		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
>  	if (!info) {
> -		if (leak)
> -			*leak = true;
> +		buffer->leak = true;
>  		return -ENOMEM;
>  	}
>  
> @@ -1037,7 +991,7 @@ static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  
>  	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
>  	msg->child_relid = channel->offermsg.child_relid;
> -	msg->gpadl = *gpadl_handle;
> +	msg->gpadl = buffer->gpadl_handle;
>  
>  	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
>  	list_add_tail(&info->msglistentry,
> @@ -1072,34 +1026,12 @@ static int __vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  	kfree(info);
>  
>  	if (!ret)
> -		*gpadl_handle = 0;
> -	else if (leak)
> -		*leak = true;
> -
> -	if (!ret && decrypted && *decrypted) {
> -		ret = set_memory_encrypted((unsigned long)kbuffer,
> -					   PFN_UP(size));
> -		if (ret)
> -			pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n",
> -				ret);
> -		*decrypted = !!ret;
> -	}
> +		buffer->gpadl_handle = 0;
> +	else
> +		buffer->leak = true;
>  
>  	return ret;
>  }
> -
> -/*
> - * vmbus_teardown_gpadl - Teardown the specified GPADL handle
> - */
> -int vmbus_teardown_gpadl(struct vmbus_channel *channel,
> -			 struct vmbus_buffer *buffer)
> -{
> -	if (!buffer->gpadl_handle)
> -		return 0;
> -
> -	return __vmbus_teardown_gpadl(channel, &buffer->gpadl_handle,
> -				      NULL, 0, NULL, &buffer->leak);
> -}
>  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
>  
>  void vmbus_reset_channel_cb(struct vmbus_channel *channel)
> @@ -1164,6 +1096,7 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
>  	trace_vmbus_close_internal(msg, ret);
>  
>  	if (ret) {
> +		channel->ringbuffer.leak = true;
>  		pr_err("Close failed: close post msg return is %d\n", ret);
>  		/*
>  		 * If we failed to post the close msg,
> @@ -1172,13 +1105,8 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
>  	}
>  
>  	/* Tear down the gpadl for the channel's ring buffer */
> -	else if (channel->ringbuffer_gpadlhandle.gpadl_handle) {
> -		ret = __vmbus_teardown_gpadl(channel,
> -					     &channel->ringbuffer_gpadlhandle.gpadl_handle,
> -					     channel->ringbuffer_gpadlhandle.buffer,
> -					     channel->ringbuffer_gpadlhandle.size,
> -					     &channel->ringbuffer_gpadlhandle.decrypted,
> -					     NULL);
> +	else if (channel->ringbuffer.gpadl_handle) {
> +		ret = vmbus_teardown_gpadl(channel, &channel->ringbuffer);
>  		if (ret) {
>  			pr_err("Close failed: teardown gpadl return %d\n", ret);
>  			/*
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 33923621a5..98eacd737f 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -204,8 +204,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>  
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
> -			   bool confidential);
> +		       struct page **pages, u32 pagecnt, u32 max_pkt_size,
> +		       bool confidential);
>  
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>  
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index d8b085dfdb..15abab9a9a 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -146,8 +146,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
>  
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
> -			   bool confidential)
> +		       struct page **pages, u32 page_cnt, u32 max_pkt_size,
> +		       bool confidential)
>  {
>  	struct page **pages_wraparound;
>  	int i;
> @@ -158,20 +158,21 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  	 * First page holds struct hv_ring_buffer, do wraparound mapping for
>  	 * the rest.
>  	 */
> -	pages_wraparound = kzalloc_objs(struct page *, page_cnt * 2 - 1);
> +	pages_wraparound = kvcalloc(page_cnt * 2 - 1, sizeof(*pages_wraparound),
> +				    GFP_KERNEL);
>  	if (!pages_wraparound)
>  		return -ENOMEM;
>  
> -	pages_wraparound[0] = pages;
> +	pages_wraparound[0] = pages[0];
>  	for (i = 0; i < 2 * (page_cnt - 1); i++)
>  		pages_wraparound[i + 1] =
> -			&pages[i % (page_cnt - 1) + 1];
> +			pages[i % (page_cnt - 1) + 1];
>  
>  	ring_info->ring_buffer = (struct hv_ring_buffer *)
>  		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
>  			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
>  
> -	kfree(pages_wraparound);
> +	kvfree(pages_wraparound);
>  	if (!ring_info->ring_buffer)
>  		return -ENOMEM;
>  
> @@ -196,7 +197,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  
>  	/* Initialize buffer that holds copies of incoming packets */
>  	if (max_pkt_size) {
> -		ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
> +		ring_info->pkt_buffer = kvzalloc(max_pkt_size, GFP_KERNEL);
>  		if (!ring_info->pkt_buffer)
>  			return -ENOMEM;
>  		ring_info->pkt_buffer_size = max_pkt_size;
> @@ -215,7 +216,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
>  	ring_info->ring_buffer = NULL;
>  	mutex_unlock(&ring_info->ring_buffer_mutex);
>  
> -	kfree(ring_info->pkt_buffer);
> +	kvfree(ring_info->pkt_buffer);
>  	ring_info->pkt_buffer = NULL;
>  	ring_info->pkt_buffer_size = 0;
>  }
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 9c6449c92a..09995cfb5b 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -27,6 +27,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/skbuff.h>
>  #include <linux/hyperv.h>
> +#include <linux/mm.h>
>  #include <linux/slab.h>
>  
>  #include "../hv/hyperv_vmbus.h"
> @@ -147,19 +148,24 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
>  	vmbus_device_unregister(channel->device_obj);
>  }
>  
> -/* Function used for mmap of ring buffer sysfs interface.
> - * The ring buffer is allocated as contiguous memory by vmbus_open
> - */
> +/* Function used for mmap of the ring buffer sysfs interface. */
>  static int
>  hv_uio_ring_mmap_prepare(struct vmbus_channel *channel, struct vm_area_desc *desc)
>  {
> -	void *ring_buffer = page_address(channel->ringbuffer_page);
> +	unsigned long pages = vma_desc_pages(desc);
> +	pgoff_t offset = desc->pgoff;
>  
> -	if (channel->state != CHANNEL_OPENED_STATE)
> +	if (channel->state != CHANNEL_OPENED_STATE || !channel->ringbuffer.pages)
>  		return -ENODEV;
> +	if (!pages || offset >= channel->ringbuffer_pagecount ||
> +	    pages > channel->ringbuffer_pagecount - offset)
> +		return -EINVAL;
> +
> +	if (!channel->co_ring_buffer)
> +		desc->page_prot = pgprot_decrypted(desc->page_prot);
>  
> -	mmap_action_simple_ioremap(desc, virt_to_phys(ring_buffer),
> -			channel->ringbuffer_pagecount << PAGE_SHIFT);
> +	mmap_action_map_kernel_pages(desc, desc->start,
> +				     channel->ringbuffer.pages + offset, pages);

Sashiko:
  Can hv_uio_ring_mmap_prepare() race with vmbus_disconnect_ring() and
  read channel->ringbuffer.pages after it is freed?

Can you make teardown wait for any mmap calls before freeing
ringbuffer.pages?

On CVM, could teardown re-encrypt the pages while a shared userspace
reference still exists?



Please double check the rest of the Sashiko comments.

-- 
Regards,
Kameron

>  	return 0;
>  }
>  
> @@ -245,7 +251,6 @@ hv_uio_probe(struct hv_device *dev,
>  {
>  	struct vmbus_channel *channel = dev->channel;
>  	struct hv_uio_private_data *pdata;
> -	void *ring_buffer;
>  	int ret;
>  	size_t ring_size = hv_dev_ring_size(channel);
>  
> @@ -276,12 +281,11 @@ hv_uio_probe(struct hv_device *dev,
>  
>  	/* mem resources */
>  	pdata->info.mem[TXRX_RING_MAP].name = "txrx_rings";
> -	ring_buffer = page_address(channel->ringbuffer_page);
> -	pdata->info.mem[TXRX_RING_MAP].addr
> -		= (uintptr_t)virt_to_phys(ring_buffer);
> -	pdata->info.mem[TXRX_RING_MAP].size
> -		= channel->ringbuffer_pagecount << PAGE_SHIFT;
> -	pdata->info.mem[TXRX_RING_MAP].memtype = UIO_MEM_IOVA;
> +	pdata->info.mem[TXRX_RING_MAP].addr =
> +		(uintptr_t)channel->ringbuffer.addr;
> +	pdata->info.mem[TXRX_RING_MAP].size =
> +		channel->ringbuffer_pagecount << PAGE_SHIFT;
> +	pdata->info.mem[TXRX_RING_MAP].memtype = UIO_MEM_VIRTUAL;
>  
>  	pdata->info.mem[INT_PAGE_MAP].name = "int_page";
>  	pdata->info.mem[INT_PAGE_MAP].addr
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 17ad83d19a..41b9976945 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -808,13 +808,6 @@ struct vmbus_device {
>  
>  #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
>  
> -struct vmbus_gpadl {
> -	u32 gpadl_handle;
> -	u32 size;
> -	void *buffer;
> -	bool decrypted;
> -};
> -
>  struct vmbus_buffer {
>  	void *addr;
>  	struct page **chunks;
> @@ -844,10 +837,8 @@ struct vmbus_channel {
>  	bool rescind_ref; /* got rescind msg, got channel reference */
>  	struct completion rescind_event;
>  
> -	struct vmbus_gpadl ringbuffer_gpadlhandle;
> -
> -	/* Allocated memory for ring buffer */
> -	struct page *ringbuffer_page;
> +	/* Allocated memory and GPADL state for ring buffer */
> +	struct vmbus_buffer ringbuffer;
>  	u32 ringbuffer_pagecount;
>  	u32 ringbuffer_send_offset;
>  	struct hv_ring_buffer_info outbound;	/* send to parent */

