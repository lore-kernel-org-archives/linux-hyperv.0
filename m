Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F43B895E
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486578; cv=none; b=M1zOpT4W23WpaufRmCaBZG7xgRWnzL5dCpJhcnR/ovuApz0wCekaslTKjYjmg/RgXxBCQY1bkZUo2bsXB7tPx+PJ5c54nAfpK/p7UICaRpSDPHyEzTlayDvSPRiXzBVKrF1bwNszYZAaBjB8R1EqzYO6rjs8D2X0Q5K5a1I3etE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486578; c=relaxed/simple;
	bh=6qoDgy3jkPW1sohDnPptGZZqlxxaYqbBBvUd0IMre8M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rJtVCscIA2n/wE3a2Z97BNvG+B4/2aDGIhDFVPlg2VPmsetCDgAIdd1Bg+hQ9q7dRme8NLFbtx7j+wbMkZD1XG+ueIdg4zE23u5iHDhEUq90JJAxA5yjp2qKLfuS762wBfYNP7uvG+WhdD5YfUqaW+46NrzQIgGe49p2/RCazVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIhs+lHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIhs+lHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826821F00898;
	Thu,  8 Oct 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486576;
	bh=LTyxEd178ZeTLENmZx3WAlv36LDrQr4yY3Mbvtc5OVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIhs+lHsbZxPu957fs8J90/ODEL1ZyiwktVRm4kBcmd1K7Ae5zo35RsK4soGTqL+H
	 +vKID1tnY6i4yyFDj9HRvB33Ouo4yn/XF3HpB9mvrX9gTkgQA43wshjqGsHqzqCofT
	 C8CvZBKIIDc0htikpQBuIx42PL4ITSh6XiYDb+rSTbiztmBQM/J262C143O5pJVukE
	 +eo5Fc8m58YN3G2t+JvgIhTd+RF0etlDxvd+0vrK099wrnVnh89+cNPjsrbf8fRwGb
	 ERYIZ+zl1NA7lA4nIRNlz/ydxy+HOD11HphZ2F9ThcwSTAbR1NxjOsUo8nFiwNc17v
	 +ze5VotN7tczg==
Message-ID: <sashiko-outbox-164497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] hv: netvsc: allocate RNDIS request descriptors
 with kvzalloc_obj()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-13-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-13-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:36 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] hv_netvsc: Double-free and UAF on duplicate RNDIS response
- [Medium] selftests: rndis_request_size_premise_test fails unconditionally=
 on architectures with >4KB pages
- [Medium] netvsc: netvsc_dma_map() leaks earlier DMA mappings when dma_map=
_single() fails
- [Medium] hyperv: netvsc: DMA mapping leak in RNDIS_MSG_HALT control messa=
ge
- [Low] kconfig: HYPERV_NET_KUNIT_TEST cannot be enabled when driver is bui=
lt as a module
--

commit 91156bed3a78e0ac932d5c6bf8e50ef88aa52fa1
Author: Emerson Busson <emersonbusson@gmail.com>

hv: netvsc: allocate RNDIS request descriptors with kvzalloc_obj()

This commit changes the allocation of RNDIS control requests from
kzalloc_obj() to kvzalloc_obj() to avoid order-2 page allocation failures
under buddy fragmentation. It resolves the vmalloc-backed descriptor into
an array of page buffers for the DMA layout and includes KUnit test cases
to cover the allocation and layout requirements.

> diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
> index 982964c1a9fb9..226728fd77d71 100644
> --- a/drivers/net/hyperv/Kconfig
> +++ b/drivers/net/hyperv/Kconfig
> @@ -6,3 +6,15 @@ config HYPERV_NET
>  	select NLS
>  	help
>  	  Select this option to enable the Hyper-V virtual network driver.
> +
> +config HYPERV_NET_KUNIT_TEST
> +	bool "Build Hyper-V netvsc KUnit tests"
> +	depends on HYPERV_NET && KUNIT

[Severity: Low]
Will this test be unselectable for modular builds?

Because HYPERV_NET_KUNIT_TEST is a bool depending on the tristate
HYPERV_NET, if HYPERV_NET is built as a module (=3Dm), this boolean symbol
will be clamped to n.

Should this use depends on HYPERV_NET !=3D n && KUNIT instead?

> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build the netvsc KUnit test suites into the hv_netvsc object.

[ ... ]

> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis=
_filter.c
> index 9b6c44979b4ea..1ce40baa2d239 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c

[ ... ]

> @@ -115,8 +102,8 @@ static struct rndis_request *get_rndis_request(struct=
 rndis_device *dev,
>  	return request;
>  }
> =20
> -static void put_rndis_request(struct rndis_device *dev,
> -			    struct rndis_request *req)
> +void put_rndis_request(struct rndis_device *dev,
> +		       struct rndis_request *req)
>  {
>  	unsigned long flags;
> =20
> @@ -124,7 +111,8 @@ static void put_rndis_request(struct rndis_device *de=
v,
>  	list_del(&req->list_ent);
>  	spin_unlock_irqrestore(&dev->request_lock, flags);
> =20
> -	kfree(req);
> +	/* Paired with the kvzalloc_obj() in get_rndis_request(). */
> +	kvfree(req);
>  }

[Severity: Medium]
Does freeing the request here permanently leak its DMA mapping when the
device is halted?

When rndis_filter_halt_device() sends an RNDIS_MSG_HALT request, it gets
mapped via netvsc_dma_map(). Because it expects no response,
rndis_filter_receive_response() is never executed to unmap it.=20

Additionally, the TX completion path in netvsc_send_tx_complete() skips
unmapping for control messages since skb is NULL.

When rndis_filter_halt_device() subsequently calls put_rndis_request(),
the request and its req->pkt.dma_range array are freed, but
dma_unmap_single() is never called, leaking the SWIOTLB mappings.

[Severity: Critical]
Can a duplicate response from the host cause a double-free and
use-after-free here?

When rndis_filter_receive_response() processes a response, it looks up the
request in dev->req_list but does not remove it:

rndis_filter_receive_response() {
    spin_lock_irqsave(&dev->request_lock, flags);
    list_for_each_entry(request, &dev->req_list, list_ent) {
        if (request->request_msg.msg.init_req.req_id =3D=3D *req_id) {
            found =3D true;
            break;
        }
    }
    spin_unlock_irqrestore(&dev->request_lock, flags);
    ...
}

If the host sends a duplicate RNDIS response with the same req_id, and the
first response has already woken the waiting thread, the waiting thread
can call put_rndis_request() to remove and free the request.

The duplicate response RX thread will then use the freed request pointer
and call netvsc_dma_unmap(), which calls kfree(packet->dma_range) without
checking for NULL.

For isolated VMs (like AMD SEV-SNP or Intel TDX), could an untrusted
Hyper-V host use this to compromise the guest?

>  static void dump_rndis_message(struct net_device *netdev,

[ ... ]

> @@ -221,27 +209,78 @@ static void dump_rndis_message(struct net_device *n=
etdev,
>  	}
>  }
> =20
> +int rndis_build_page_buffers(const void *data, u32 len,
> +			     struct hv_page_buffer *page_bufs,
> +			     u32 *page_buf_cnt)

[ ... ]

>  static int rndis_filter_send_request(struct rndis_device *dev,
>  				  struct rndis_request *req)
>  {
>  	struct hv_netvsc_packet *packet;
> -	struct hv_page_buffer pb;
> +	struct hv_page_buffer page_bufs[MAX_PAGE_BUFFER_COUNT];
> +	u32 page_buf_cnt;
>  	int ret;
> =20
>  	/* Setup the packet to send it */
>  	packet =3D &req->pkt;
> =20
>  	packet->total_data_buflen =3D req->request_msg.msg_len;
> -	packet->page_buf_cnt =3D 1;
> -
> -	pb.pfn =3D virt_to_phys(&req->request_msg) >> HV_HYP_PAGE_SHIFT;
> -	pb.len =3D req->request_msg.msg_len;
> -	pb.offset =3D offset_in_hvpage(&req->request_msg);
> +	ret =3D rndis_build_page_buffers(&req->request_msg,
> +				       req->request_msg.msg_len,
> +				       page_bufs, &page_buf_cnt);
> +	if (ret)
> +		return ret;
> +	packet->page_buf_cnt =3D page_buf_cnt;
> =20
>  	trace_rndis_send(dev->ndev, 0, &req->request_msg);
> =20
>  	rcu_read_lock_bh();
> -	ret =3D netvsc_send(dev->ndev, packet, NULL, &pb, NULL, false);
> +	ret =3D netvsc_send(dev->ndev, packet, NULL, page_bufs, NULL, false);
>  	rcu_read_unlock_bh();

[Severity: Medium]
Because page_buf_cnt can now be greater than 1, does this introduce a
resource leak if DMA mapping partially fails?

Inside netvsc_dma_map(), it iterates over page_buf_cnt to map the pages:

netvsc_dma_map() {
    ...
    for (i =3D 0; i < page_count; i++) {
        ...
        dma =3D dma_map_single(&hv_dev->device, src, len, DMA_TO_DEVICE);
        if (dma_mapping_error(&hv_dev->device, dma)) {
            kfree(packet->dma_range);
            return -ENOMEM;
        }
    }
    ...
}

If dma_map_single() fails on a later iteration (when i > 0), it returns
-ENOMEM but neglects to call dma_unmap_single() for the pages 0 to i - 1
that were successfully mapped in previous loop iterations.

> diff --git a/drivers/net/hyperv/rndis_request_test.c b/drivers/net/hyperv=
/rndis_request_test.c
> new file mode 100644
> index 0000000000000..6affa916e74e3
> --- /dev/null
> +++ b/drivers/net/hyperv/rndis_request_test.c

[ ... ]

> +static void rndis_request_size_premise_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_GT(test, sizeof(struct rndis_request),
> +			(size_t)KMALLOC_MAX_CACHE_SIZE);

[Severity: Medium]
Will this assertion unconditionally fail on architectures with page sizes
larger than 4KB?

KMALLOC_MAX_CACHE_SIZE scales with PAGE_SIZE (typically PAGE_SIZE * 2).
On architectures like ARM64 or PPC64 configured with 64KB pages,
KMALLOC_MAX_CACHE_SIZE is at least 64 KiB.

Since sizeof(struct rndis_request) is slightly larger than 8 KiB (because
RNDIS_EXT_LEN is fixed at 4096), this check will evaluate to roughly
8272 > 65536 on those platforms, causing the test suite to spuriously
fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D12
