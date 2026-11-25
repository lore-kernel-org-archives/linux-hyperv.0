Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642869;
	b=15xZjrcahTElC8z3TA7LpIF1dUbwxf4sdHECdcCo5VBXmt7xT+UvtJYnjBK9LgfvZkGu
	 9WPEC+91/3fq1+qr46/ARhbhm0OOTNZ7XLxHQpXuLxxZg+dHR5qikCP+sQ12zSJ6yZgOz
	 bOFpkt5IzKpc2j9hbyuV/LY7xU4mMFrea+R2Xpp4kTveq71kMBski9K1rbJqor4VV6md4
	 TpMTEtynnsEAMV8R9ssrvtEX189tkEplMR1He4Q9cEWYxUm94m0sTNhps9IYrAGmHCUtv
	 dNEAYxMHn5Ga01JnOXhRo5WoBeZkgvowvFQd1cuKZ2a5RWZ9UsepZd1wLENnFzHkzcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M/jslnl9AzU8jI28P/iUWN1fMqo16piUI+mbg1zL264=;
	b=hOw8hnxs0+Zx9cuzPebzFpJo8ADD4tCYf97c3poCBZionXsCUtszpvO2sYVpEBdfITQd
	 P71yGWYBE8oTCgKlGICsSf5deUkOOIqyySoQPCVQemsx4jmGe7pjGdliFXn8/znxBR3VR
	 tsbb9+zMieUofzFYkxYAHMcpOuDx/Nb+O7xb1L+AgPz1HWdLJJq25K14qESz3BF0r8Jig
	 elT6PLFoeitVbFP/Z+k1wCDNWvfOUbYqbaYeslyYns8uHiH1QoY17V/nJFQ2CpKrRDetR
	 fhPg2zwNX88WcWhdsz+rhdcX5Fxo3nlhN8OEOrVxst+jFK88xyqF7s/zs2L1Pbc0hWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0a5gwZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA2606A31E
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0a5gwZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B81F000C4;
	Wed, 25 Nov 2026 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642868;
	bh=M/jslnl9AzU8jI28P/iUWN1fMqo16piUI+mbg1zL264=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0a5gwZLWSqj/RZWjsPyo9e7Z5PCtnf4KX2Ig1gkYYeA0zR/tA9s1ExRSjxO3yjGe
	 ms2SpRLk7PjVAgRtTlT8qEooZ0LkZ1ezxmJXRDFXyeaBRejdX22bNE8TSFRalFcWKl
	 H8lG2l60Mdc4Vj4XlQb/GoabEgt0ooGLnvu8yRjpoz+LZalbmMTYbSOQYoy6kPM6Od
	 HWdkITAe+wzRmTUanC08Pc4dXV2atYDyJEuNXkAeUIkCS6HkO6t1YKz6S8K0GgKcpe
	 TEn0/nVikv8z2oj24rZXv5mtdHwHsHw/ac35yMJGr2DFoFQ8jSRJ5VA8xt6V8seAJb
	 h5AHbCDL/8C1A==
Message-ID: <sashiko-outbox-234198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] hv: vmbus: allocate ring buffers via
 vmbus_alloc_buffer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261124214030.174246-3-emersonbusson@gmail.com>
References: <20261124214030.174246-1-emersonbusson@gmail.com>
 <20261124214030.174246-3-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:41:08 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] hv: vmbus: bogus struct page from vmalloc_to_page() on
  decrypted vmap in CCA
- [High] uio_hv_generic: UAF race on ringbuffer.pages in
  hv_uio_ring_mmap_prepare()
- [High] hv: vmbus: vmbus_free_buffer() re-encrypts ring pages mapped in
  userspace
- [High] uio_hv_generic: broken VM_MIXEDMAP VMA setup in
  hv_uio_ring_mmap_prepare()
- [High] uio_hv_generic: missing pgprot_decrypted() for UIO_MEM_VIRTUAL
  ring mmap
- [Medium] hv: vmbus: guest ring metadata and vmap leak when
  vmbus_close_internal() fails
--

commit 8be1c950d362b8ac0af37ffe999fefaefbb7f83c
Author: Emerson Busson <emersonbusson@gmail.com>

hv: vmbus: allocate ring buffers via vmbus_alloc_buffer()

This commit allocates VMBus ring buffers via vmbus_alloc_buffer() instead
of high-order alloc_pages_node() calls, updates hv_ringbuffer_init() and
uio_hv_generic to handle non-contiguous pages, and removes struct
vmbus_gpadl.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 9807ff35a1b7e..c0bf154915d76 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
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
> -		channel->ringbuffer_page =3D NULL;
> -	}
> +	vmbus_free_buffer(&channel->ringbuffer);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_ring);

[Severity: High]
Does vmbus_free_buffer() re-encrypt ring buffer chunks while userspace
still has them mapped via uio_hv_generic?

With hv_uio_ring_mmap_prepare() switching to
mmap_action_map_kernel_pages() and TXRX_RING_MAP switching to
UIO_MEM_VIRTUAL, userspace mappings now take page references and install
pgprot_decrypted() PTEs.  When /dev/uioX is closed (hv_uio_release() ->
vmbus_disconnect_ring() -> vmbus_free_ring() on subchannels) or the device
is unbound while a ring VMA is still mapped, vmbus_free_buffer() runs:

drivers/hv/channel.c:vmbus_free_buffer() {
    ...
	for (i =3D 0; i < buffer->chunk_cnt; i++) {
		unsigned long vaddr =3D
			(unsigned long)page_address(buffer->chunks[i]);
		unsigned int order =3D folio_order(page_folio(buffer->chunks[i]));

		if (set_memory_encrypted(vaddr, 1U << order))
			continue;
		__free_pages(buffer->chunks[i], order);
	}
    ...
}

Because the VMA holds elevated folio references, __free_pages() only drops
the kernel reference, but set_memory_encrypted() has already transitioned
the physical pages back to private/encrypted state.  A subsequent access
through the remaining decrypted userspace PTEs in an isolated guest (SNP,
TDX, or CCA) triggers a fatal hardware exception.

> @@ -170,25 +163,33 @@ EXPORT_SYMBOL_GPL(vmbus_free_ring);
>  int vmbus_alloc_ring(struct vmbus_channel *newchannel,
>  		     u32 send_size, u32 recv_size)
>  {
> -	struct page *page;
> -	int order;
> +	struct vmbus_buffer *buffer =3D &newchannel->ringbuffer;
> +	u32 size, page_cnt, i;
> +	int ret;
> =20
> -	if (send_size % PAGE_SIZE || recv_size % PAGE_SIZE)
> +	if (!send_size || !recv_size ||
> +	    send_size % PAGE_SIZE || recv_size % PAGE_SIZE ||
> +	    check_add_overflow(send_size, recv_size, &size))
>  		return -EINVAL;
> =20
> -	/* Allocate the ring buffer */
> -	order =3D get_order(send_size + recv_size);
> -	page =3D alloc_pages_node(cpu_to_node(newchannel->target_cpu),
> -				GFP_KERNEL|__GFP_ZERO, order);
> -
> -	if (!page)
> -		page =3D alloc_pages(GFP_KERNEL|__GFP_ZERO, order);
> +	ret =3D vmbus_alloc_buffer(newchannel, size, newchannel->co_ring_buffer,
> +				 buffer);
> +	if (ret)
> +		return ret;
> =20
> -	if (!page)
> +	page_cnt =3D size >> PAGE_SHIFT;
> +	buffer->pages =3D kvcalloc(page_cnt, sizeof(*buffer->pages), GFP_KERNEL=
);
> +	if (!buffer->pages) {
> +		vmbus_free_buffer(buffer);
>  		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < page_cnt; i++)
> +		buffer->pages[i] =3D
> +			vmalloc_to_page(buffer->addr +
> +					((unsigned long)i << PAGE_SHIFT));

[Severity: High]
Does vmalloc_to_page(buffer->addr + ...) return out-of-bounds struct page
pointers for non-confidential rings on ARM64 CCA?

In an isolated guest with !newchannel->co_ring_buffer,
vmbus_alloc_buffer() maps buffer->addr via vmap(...,
pgprot_decrypted(PAGE_KERNEL)) and frees its temporary pages array.  On
ARM64 CCA, pgprot_decrypted() sets PROT_NS_SHARED (BIT(config.ipa_bits -
1)) in the vmap PTEs, and arm64's __pte_to_phys() / pte_pfn() do not mask
that bit out.

As a result, vmalloc_to_page() computes a PFN with the unprotected IPA top
bit set and returns a bogus struct page pointer outside valid RAM.
hv_ringbuffer_init() then hits WARN_ON(!pfn_valid(page_to_pfn(page))) in
vmap_pages_pte_range() and fails with -ENOMEM, create_gpadl_header() ->
virt_to_hvpfn() sends corrupt GPADL PFNs, and uio_hv_generic dereferences
the invalid struct page pointers on mmap or fault.  Retaining the pages
array built before vmap() in vmbus_alloc_buffer() would avoid walking the
decrypted vmap PTEs.

[ ... ]

> @@ -1164,6 +1096,7 @@ static int vmbus_close_internal(struct vmbus_channe=
l *channel)
>  	trace_vmbus_close_internal(msg, ret);
> =20
>  	if (ret) {
> +		channel->ringbuffer.leak =3D true;
>  		pr_err("Close failed: close post msg return is %d\n", ret);
>  		/*
>  		 * If we failed to post the close msg,
> @@ -1172,13 +1105,8 @@ static int vmbus_close_internal(struct vmbus_chann=
el *channel)
>  	}
> =20
>  	/* Tear down the gpadl for the channel's ring buffer */
> -	else if (channel->ringbuffer_gpadlhandle.gpadl_handle) {
> -		ret =3D __vmbus_teardown_gpadl(channel,
> -					     &channel->ringbuffer_gpadlhandle.gpadl_handle,
> -					     channel->ringbuffer_gpadlhandle.buffer,
> -					     channel->ringbuffer_gpadlhandle.size,
> -					     &channel->ringbuffer_gpadlhandle.decrypted,
> -					     NULL);
> +	else if (channel->ringbuffer.gpadl_handle) {
> +		ret =3D vmbus_teardown_gpadl(channel, &channel->ringbuffer);
>  		if (ret) {
>  			pr_err("Close failed: teardown gpadl return %d\n", ret);
>  			/*

[Severity: Medium]
When vmbus_close_internal() fails, does skipping vmbus_free_ring() leak the
guest-private ring metadata and wraparound vmaps?

Setting channel->ringbuffer.leak =3D true (here and in
vmbus_teardown_gpadl()) tells vmbus_free_buffer() to leak the host-visible
backing pages while still freeing buffer->pages and buffer->chunks.
However, vmbus_disconnect_ring() and vmbus_close() only call
vmbus_free_ring() when vmbus_close_internal() returns 0:

drivers/hv/channel.c:vmbus_disconnect_ring() {
    ...
		if (vmbus_close_internal(cur_channel) =3D=3D 0) {
			vmbus_free_ring(cur_channel);
    ...
}

When vmbus_close_internal() returns an error, vmbus_free_ring() is never
called, leaking outbound.ring_buffer, inbound.ring_buffer,
inbound.pkt_buffer, ringbuffer.pages, and ringbuffer.chunks (and losing
the pointers permanently if vmbus_open() later zeroes channel->ringbuffer).

> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 9c6449c92abee..09995cfb5bed5 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -147,19 +148,24 @@ static void hv_uio_rescind(struct vmbus_channel *ch=
annel)
>  	vmbus_device_unregister(channel->device_obj);
>  }
> =20
> -/* Function used for mmap of ring buffer sysfs interface.
> - * The ring buffer is allocated as contiguous memory by vmbus_open
> - */
> +/* Function used for mmap of the ring buffer sysfs interface. */
>  static int
>  hv_uio_ring_mmap_prepare(struct vmbus_channel *channel, struct vm_area_d=
esc *desc)
>  {
> -	void *ring_buffer =3D page_address(channel->ringbuffer_page);
> +	unsigned long pages =3D vma_desc_pages(desc);
> +	pgoff_t offset =3D desc->pgoff;
> =20
> -	if (channel->state !=3D CHANNEL_OPENED_STATE)
> +	if (channel->state !=3D CHANNEL_OPENED_STATE || !channel->ringbuffer.pa=
ges)
>  		return -ENODEV;
> +	if (!pages || offset >=3D channel->ringbuffer_pagecount ||
> +	    pages > channel->ringbuffer_pagecount - offset)
> +		return -EINVAL;
> +
> +	if (!channel->co_ring_buffer)
> +		desc->page_prot =3D pgprot_decrypted(desc->page_prot);
> =20
> -	mmap_action_simple_ioremap(desc, virt_to_phys(ring_buffer),
> -			channel->ringbuffer_pagecount << PAGE_SHIFT);
> +	mmap_action_map_kernel_pages(desc, desc->start,
> +				     channel->ringbuffer.pages + offset, pages);
>  	return 0;
>  }

[Severity: High]
Can hv_uio_ring_mmap_prepare() race with vmbus_disconnect_ring() and read
channel->ringbuffer.pages after it is freed?

In hv_uio_new_channel(), subchannels expose their own ring sysfs
attribute, and closing /dev/uioX runs hv_uio_release() ->
vmbus_disconnect_ring() without removing the subchannel ring sysfs file or
serializing against hv_mmap_ring_buffer_wrapper():

CPU0                                  CPU1
hv_mmap_ring_buffer_wrapper()
  hv_uio_ring_mmap_prepare()
    if (channel->state !=3D ... ||
        !channel->ringbuffer.pages)
    mmap_action_map_kernel_pages(...,
      channel->ringbuffer.pages + offset, ...)
                                      hv_uio_release()
                                        vmbus_disconnect_ring()
                                          vmbus_close_internal(cur_channel)
                                          vmbus_free_ring(cur_channel)
                                            vmbus_free_buffer()
                                              kvfree(buffer->pages)
                                              vfree() / __free_pages()
  __compat_vma_mmap()
    map_kernel_pages_complete()
      insert_pages()
        pages[curr_page_idx]  <-- use-after-free

insert_pages() then dereferences the freed ringbuffer.pages array and calls
folio_get() on already-freed ring pages.

[Severity: High]
Does switching hv_uio_ring_mmap_prepare() from
mmap_action_simple_ioremap() to mmap_action_map_kernel_pages() break write
faults and VMA flags on the sysfs ring mapping?

mmap_action_map_kernel_pages() inserts normal (non-special) PTEs with
mkwrite =3D false in a VM_MIXEDMAP VMA under kernfs_vm_ops.  When a write
fault on a shared mapping reaches do_wp_page() (such as on the first write
on ARM64 without hardware DBM, or after mprotect() / soft-dirty clearing),
vm_normal_page() now returns the struct page and routes the fault to
wp_page_shared() -> do_page_mkwrite() -> kernfs_vma_page_mkwrite().
Because kernfs_vma_page_mkwrite() returns 0 without VM_FAULT_LOCKED and
ring pages have folio->mapping =3D=3D NULL, do_page_mkwrite() returns 0
(retry) without marking the PTE dirty/writable, causing an infinite
page-fault retry loop.

In addition, map_kernel_pages_prepare() does not set VMA_DONTEXPAND_BIT or
VMA_DONTDUMP_BIT (allowing mremap() to expand the VMA past
channel->ringbuffer_pagecount), __mmap_complete() -> vma_set_page_prot() ->
pgprot_modify() strips PROT_NS_SHARED (pgprot_decrypted()) from
vma->vm_page_prot on ARM64 CCA, and MAP_PRIVATE mappings are not rejected
(so COW faults in isolated guests map encrypted anonymous folios with
decrypted protections).

> @@ -245,7 +251,6 @@ hv_uio_probe(struct hv_device *dev,
>  {
>  	struct vmbus_channel *channel =3D dev->channel;
>  	struct hv_uio_private_data *pdata;
> -	void *ring_buffer;
>  	int ret;
>  	size_t ring_size =3D hv_dev_ring_size(channel);
> =20
> @@ -276,12 +281,11 @@ hv_uio_probe(struct hv_device *dev,
> =20
>  	/* mem resources */
>  	pdata->info.mem[TXRX_RING_MAP].name =3D "txrx_rings";
> -	ring_buffer =3D page_address(channel->ringbuffer_page);
> -	pdata->info.mem[TXRX_RING_MAP].addr
> -		=3D (uintptr_t)virt_to_phys(ring_buffer);
> -	pdata->info.mem[TXRX_RING_MAP].size
> -		=3D channel->ringbuffer_pagecount << PAGE_SHIFT;
> -	pdata->info.mem[TXRX_RING_MAP].memtype =3D UIO_MEM_IOVA;
> +	pdata->info.mem[TXRX_RING_MAP].addr =3D
> +		(uintptr_t)channel->ringbuffer.addr;
> +	pdata->info.mem[TXRX_RING_MAP].size =3D
> +		channel->ringbuffer_pagecount << PAGE_SHIFT;
> +	pdata->info.mem[TXRX_RING_MAP].memtype =3D UIO_MEM_VIRTUAL;

[Severity: High]
When userspace maps TXRX_RING_MAP via /dev/uioX in an isolated guest with
!channel->co_ring_buffer, does UIO_MEM_VIRTUAL map the decrypted ring
pages with encrypted userspace PTEs?

Unlike hv_uio_ring_mmap_prepare(), which applies pgprot_decrypted() for
the sysfs ring file, uio_mmap() handles UIO_MEM_VIRTUAL via
uio_mmap_logical() and uio_vma_fault(), which resolves each page with
vmalloc_to_page() and faults it in using the default encrypted
vma->vm_page_prot.  Accessing the /dev/uioX ring mapping from userspace in
an SNP, TDX, or CCA guest will then trigger a hardware memory-encryption
fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124214030.1742=
46-1-emersonbusson@gmail.com?part=3D2
