Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609503;
	b=rPzPzoGwxWMHMOHo17CKLEZusd+c2PG50MDqI4po4/Ix2pvDOFFf355kMxPGL/LfrRT8
	 Qy//BgEPcOmEKAzKi5g4+BSxqNZ7221vgLI3tAb9LZ73V8lbcRC1FBd4FX+zjypybPAVo
	 JPRgMR+V9CmHvr549yA4BaZF+Dacoq9ONLy58TspIbuARtLrW2+0KseQKqV7gUC0byOer
	 fL+5DxiZQ78WWF8AlwSzaBUvFVaeJJNDbSf95caX24BPMgKvL80wF6sbYWIFAHzY/YCC0
	 GV+kqAtzWe1yzec+1dpgjX+KZu8kg40VR8h04m7Fr+XlRETpZhweSgPFfo7LEqUCN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609503;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=4tX/7Z9Vzs8sF/DcogbCQPLNqTP7ZH5DqSeIXezg1HA=;
	b=SiDbJUNJKUeCa6gs3tuzZsmbbiPChEtbkHy12RsPtA9gv7lohRtw1TNy5PC51CBrLgWX
	 j/qxGKRk9AFmyUNA4iLytzhw2KtMfvu6J7S7uB4HA46XYetwtM2vI3r40TnaCHjsGk+VM
	 J1QFQxZ/zysMbW9/lJUDGXQ5ENkwF7jdTQxBaMx9IL9vKDYFg8wybQPhOsqFujsDL5OJk
	 bxq5MhgCaDovwVPEpuSaRqcCvEVKjGhB7L/VqPi46V5cA90CrKgXldYAGWuNpQGJfFk/h
	 tepHIpnt3XF91/7hY8sHOldain303XWTWABYJtqaecWoY/3O8lGOA7uFPIShvO4wpJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WgETjJ9j;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BA606A549;
	Fri, 13 Nov 2026 22:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44BA606A549
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WgETjJ9j
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLf6AD2841807;
	Fri, 13 Nov 2026 14:38:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=4tX/7Z9Vzs8
	sF/DcogbCQPLNqTP7ZH5DqSeIXezg1HA=; b=WgETjJ9jdwMQky1gVOegQ7DFioX
	nvLSkBHB3O+ja2F1Q+M4LSKH5BwBXtodPwineGTgBJ5utL8jZe37Oze9zF21xqyL
	lB7uCW40FSkfHkNb9NS/rVlSezmjGEC2H/IjT9oONFPK/OZ9BWJsedba9p788UBy
	CUjHcfZ4597DuVvDueaSYwHRdXF0igVkwz+N7xEdWZ2wnpIEkPo2mkdtkH9PCxsJ
	xq2ioHW6FYVxY+dt+NQaz51Pyivm0eov8hn6y1mrHyqtyReAg/2st6kEMAD+A32B
	r8IFyqJItICp/v3SXWcStcnLyPV0+DyRAbwQTUAPMrtF2tUN+hmsadpT67g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwj8chtec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 14:38:00 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 22:37:59 +0000
Date: Fri, 13 Nov 2026 14:37:58 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Sergio Lopez <slp@redhat.com>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bryan Tan
	<bryan-bt.tan@broadcom.com>,
        Vishnu Dasa <vishnu.dasa@broadcom.com>,
        Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Stefan
 Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason
 Wang <jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
	<decui@microsoft.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive
 buffers
Message-ID: <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA5MCBTYWx0ZWRfXwuHqpVeHPfUx
 YSYZrtHDQlo2QqxsvVP4nmeRDQTJCG8ZBTQt5FPRfkM/XmhvQxeRa1iR1SWgT6Kqew2692EQu/c
 QCucGYojzLzunPU4whTpjLebKQeYg3Zx1rS6s20eLQDP/FGYxWFMKc41iTKvhkSH0OzoKu++Vrr
 eSsKQ09pl6KCqd8uDVtT4Sz2xQq1guOoY3aw7DUt/+nkROKpVMhmvyqPCV5oAa8Mc//Izgc3e3J
 MF7xJJW1iPmXd1xX//nirHPWeX5/G/FkI8HdGBEzhlO0BbZqnBLuehxcmzeDMuhJc5W1eFzKF1F
 kE8+TRz1b9glm8kd3oDiH9QuTGz/HGy30JVFxTS8wQm60o8Ne1dXjjVQEKEmF4/Eacow4bsz0Pc
 NaPu7EtudXscFZWZ5wYrgL/JXlPlB+qeVfaYjdDAbimyF0HbJ+lAT6isEgPSxcF+mZC4vWXBKs2
 bYOwxeKHnvFMvnmbpPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA5MCBTYWx0ZWRfX+m+6Ukwt/re9
 nJ5t7Rt4bj//OWK7CowD3dryD9bwGr/5ZymEI0fcUGYwJ3X6OaF76bpI9khtaCQ1iNbjCFMvpug
 ZLJP9Ej8+IUU3KQ5qattv2U1iZSACnI=
X-Authority-Analysis: v=2.4 cv=DuvDa2/+ c=1 sm=1 tr=0 ts=6af79148 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=20KFwNOVAAAA:8
 a=g20ymAsBIF5uQeyiu3MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ZG9E_BFKVg4jOA7zSdhltnqTQGBMXDXG
X-Proofpoint-ORIG-GUID: ZG9E_BFKVg4jOA7zSdhltnqTQGBMXDXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 13, 2026 at 06:15:47PM +0100, Sergio Lopez wrote:
> The guest already uses page-sized RX allocations. A datagram can exceed
> one RX buffer. Growing every posted buffer to hold a full datagram would
> increase virtqueue memory use and make small queued datagrams retain large
> backing allocations. With delayed reads, a bounded receive queue could
> then fill after only a few messages.
> 
> Define START and EOM flags for datagram packets. Mark outgoing messages
> with both flags, and let vhost split a message across guest RX buffers,
> keeping START on the first fragment and EOM on the last. When a data
> packet meets a descriptor with no payload space, vhost returns that
> descriptor with zero used bytes. It drops datagrams but requeues stream
> and seqpacket data for a later buffer.
> 
> Reassemble consecutive fragments in the guest before tap or socket
> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
> incomplete messages on malformed packets, a new START, a peer mismatch,
> an intervening non-datagram packet, or virtqueue teardown. Require complete
> framing for host and loopback ingress.
> 
> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
> 16 messages of a delayed-read burst. Paired host/guest selftests cover
> 64 KiB messages and the burst through both a userspace backend and the
> patched Linux vhost backend, with stream and seqpacket controls. A nested
> vhost-vsock guest posting header-only RX buffers also passes stream and
> seqpacket receive tests.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/vhost/vsock.c                   |  15 +++++
>  include/uapi/linux/virtio_vsock.h       |   8 +++
>  net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
>  net/vmw_vsock/virtio_transport_common.c |  11 ++-
>  4 files changed, 141 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index f4fb2ac732f5..1ff4a9aff907 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		 * buffer, we split it using multiple buffers.
>  		 */
>  		if (payload_len > iov_len - sizeof(*hdr)) {
> +			if (iov_len == sizeof(*hdr)) {
> +				/* Connected sockets must retry with the next buffer. */
> +				if (le16_to_cpu(hdr->type) ==
> +				    VIRTIO_VSOCK_TYPE_DGRAM)
> +					kfree_skb(skb);
> +				else
> +					virtio_vsock_skb_queue_head(
> +						&vsock->send_pkt_queue, skb);
> +				vhost_add_used(vq, head, 0);
> +				added = true;
> +				continue;
> +			}
> +
>  			payload_len = iov_len - sizeof(*hdr);
>  
>  			/* As we are copying pieces of large packet's buffer to
> @@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		 */
>  		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
>  			hdr->flags |= cpu_to_le32(flags_to_restore);
> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
> +				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
>  
>  			/* We are queueing the same skb to handle
>  			 * the remaining bytes, and we want to deliver it
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 27b4b2b8bf13..e1937f756eeb 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
>  enum virtio_vsock_rw {
>  	VIRTIO_VSOCK_SEQ_EOM = 1,
>  	VIRTIO_VSOCK_SEQ_EOR = 2,
> +	/*
> +	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
> +	 * datagram and EOM marks the last. Both are set for a datagram that
> +	 * fits in one packet. Fragments must be consecutive on the receive
> +	 * virtqueue. Each packet's len is its fragment length.
> +	 */
> +	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
> +	VIRTIO_VSOCK_DGRAM_START = 4,

Should this be 4 if VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM = 1?
Seems like 3 is missing?

>  };

Is VIRTIO_VSOCK_DGRAM_START strictly necessary? If we just received an
EOM from a peer, then we know that the next pkt from that peer is also
the start of a new dgram. We'd have to be careful to never abandon a
datagram partway through, but for example I think we can just requeue
the datagram fragment to later retry if we fail to place onto the vq?

>  
>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 87a96e94c3c2..c8c58a7dcec4 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -54,6 +54,8 @@ struct virtio_vsock {
>  	bool rx_run;
>  	int rx_buf_nr;
>  	int rx_buf_max_nr;
> +	struct sk_buff_head dgram_rx_queue;
> +	u32 dgram_rx_len;
>  
>  	u32 guest_cid;
>  	bool seqpacket_allow;
> @@ -312,7 +314,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  {
>  	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> -	struct scatterlist pkt, *p;
> +	struct scatterlist pkt;
>  	struct virtqueue *vq;
>  	struct sk_buff *skb;
>  	int ret;
> @@ -325,9 +327,9 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  			break;
>  
>  		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
> +		virtio_vsock_skb_put(skb, total_len - VIRTIO_VSOCK_SKB_HEADROOM);
>  		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
> -		p = &pkt;
> -		ret = virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
> +		ret = virtqueue_add_inbuf(vq, &pkt, 1, skb, GFP_KERNEL);
>  		if (ret < 0) {
>  			kfree_skb(skb);
>  			break;
> @@ -661,6 +663,93 @@ virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
>  	return dgram_allow;
>  }
>  
> +#define VIRTIO_VSOCK_DGRAM_MAX_FRAGS	64
> +
> +/* The RX worker holds rx_lock while assembling fragments from one virtqueue. */
> +static void virtio_vsock_dgram_reset(struct virtio_vsock *vsock)
> +{
> +	skb_queue_purge(&vsock->dgram_rx_queue);
> +	vsock->dgram_rx_len = 0;
> +}
> +
> +static bool virtio_vsock_dgram_same_peer(struct sk_buff *first,
> +					 struct sk_buff *next)
> +{
> +	const struct virtio_vsock_hdr *a = virtio_vsock_hdr(first);
> +	const struct virtio_vsock_hdr *b = virtio_vsock_hdr(next);
> +
> +	return a->src_cid == b->src_cid && a->dst_cid == b->dst_cid &&
> +	       a->src_port == b->src_port && a->dst_port == b->dst_port;
> +}
> +
> +static struct sk_buff *
> +virtio_vsock_dgram_reassemble(struct virtio_vsock *vsock, struct sk_buff *skb)
> +{
> +	struct sk_buff_head *queue = &vsock->dgram_rx_queue;
> +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +	struct sk_buff *assembled, *fragment;
> +	u32 flags = le32_to_cpu(hdr->flags);
> +	int offset = 0;
> +
> +	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW ||
> +	    flags & ~(VIRTIO_VSOCK_DGRAM_START | VIRTIO_VSOCK_DGRAM_EOM))
> +		goto drop_partial;
> +
> +	/* START also resynchronizes after an abandoned datagram. */
> +	if (flags & VIRTIO_VSOCK_DGRAM_START)
> +		virtio_vsock_dgram_reset(vsock);
> +	else if (skb_queue_empty(queue))
> +		goto drop_skb;
> +
> +	fragment = skb_peek(queue);
> +	if (fragment && !virtio_vsock_dgram_same_peer(fragment, skb))
> +		goto drop_partial;
> +	if (skb->len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE - vsock->dgram_rx_len ||
> +	    skb_queue_len(queue) >= VIRTIO_VSOCK_DGRAM_MAX_FRAGS ||
> +	    (!(flags & VIRTIO_VSOCK_DGRAM_EOM) && !skb->len))
> +		goto drop_partial;
> +
> +	if (flags & VIRTIO_VSOCK_DGRAM_EOM && skb_queue_empty(queue))
> +		return skb;
> +
> +	vsock->dgram_rx_len += skb->len;
> +	skb_queue_tail(queue, skb);
> +	if (!(flags & VIRTIO_VSOCK_DGRAM_EOM))
> +		return NULL;
> +
> +	assembled = virtio_vsock_alloc_skb(VIRTIO_VSOCK_SKB_HEADROOM +
> +					     vsock->dgram_rx_len, GFP_KERNEL);
> +	if (!assembled)
> +		goto reset;
> +	virtio_vsock_skb_put(assembled, vsock->dgram_rx_len);
> +	fragment = skb_peek(queue);
> +	memcpy(virtio_vsock_hdr(assembled), virtio_vsock_hdr(fragment),
> +	       sizeof(*hdr));
> +	hdr = virtio_vsock_hdr(assembled);
> +	hdr->len = cpu_to_le32(vsock->dgram_rx_len);
> +	hdr->flags = cpu_to_le32(VIRTIO_VSOCK_DGRAM_START |
> +				  VIRTIO_VSOCK_DGRAM_EOM);
> +	skb_queue_walk(queue, fragment) {
> +		if (skb_store_bits(assembled, offset, fragment->data,
> +				   fragment->len)) {
> +			kfree_skb(assembled);
> +			goto reset;
> +		}
> +		offset += fragment->len;
> +	}
> +	virtio_vsock_dgram_reset(vsock);
> +	return assembled;
> +
> +drop_partial:
> +	virtio_vsock_dgram_reset(vsock);
> +drop_skb:
> +	kfree_skb(skb);
> +	return NULL;
> +reset:
> +	virtio_vsock_dgram_reset(vsock);
> +	return NULL;
> +}
> +
>  static void virtio_transport_rx_work(struct work_struct *work)
>  {
>  	struct virtio_vsock *vsock =
> @@ -697,7 +786,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			/* Drop short/long packets */
>  			if (unlikely(len < sizeof(*hdr) ||
> -				     len > virtio_vsock_skb_len(skb))) {
> +				     len > sizeof(*hdr) + skb->len)) {
> +				virtio_vsock_dgram_reset(vsock);
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -705,6 +795,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			hdr = virtio_vsock_hdr(skb);
>  			payload_len = le32_to_cpu(hdr->len);
>  			if (unlikely(payload_len > len - sizeof(*hdr))) {
> +				virtio_vsock_dgram_reset(vsock);
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -713,12 +804,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
>  			    (!vsock->dgram_allow ||
>  			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
> +				virtio_vsock_dgram_reset(vsock);
>  				kfree_skb(skb);
>  				continue;
>  			}
>  
> -			if (payload_len)
> -				virtio_vsock_skb_put(skb, payload_len);
> +			pskb_trim_unique(skb, payload_len);
> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
> +				skb = virtio_vsock_dgram_reassemble(vsock, skb);
> +				if (!skb)
> +					continue;
> +			} else if (!skb_queue_empty(&vsock->dgram_rx_queue)) {
> +				virtio_vsock_dgram_reset(vsock);
> +			}
>  
>  			virtio_transport_deliver_tap_pkt(skb);
>  
> @@ -730,7 +828,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	} while (!virtqueue_enable_cb(vq));
>  
>  out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +	if (!vsock->rx_buf_nr ||
> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  out_nofill:
>  	mutex_unlock(&vsock->rx_lock);
> @@ -824,6 +923,7 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>  	mutex_lock(&vsock->rx_lock);
>  	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
>  		kfree_skb(skb);
> +	virtio_vsock_dgram_reset(vsock);
>  	mutex_unlock(&vsock->rx_lock);
>  
>  	mutex_lock(&vsock->tx_lock);
> @@ -865,6 +965,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  
>  	mutex_init(&vsock->tx_lock);
>  	mutex_init(&vsock->rx_lock);
> +	skb_queue_head_init(&vsock->dgram_rx_queue);
>  	mutex_init(&vsock->event_lock);
>  	skb_queue_head_init(&vsock->send_pkt_queue);
>  	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index c540bc40755a..23f141cd786a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -275,6 +275,13 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>  		}
>  	}
> +	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +
> +		/* Vhost may split this message across guest RX buffers. */
> +		hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_DGRAM_START |
> +					  VIRTIO_VSOCK_DGRAM_EOM);
> +	}
>  
>  	if (info->reply)
>  		virtio_vsock_skb_set_reply(skb);
> @@ -1877,7 +1884,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	 * datagrams are silently dropped (no RST).
>  	 */
>  	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
> -		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
> +		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW ||
> +		    le32_to_cpu(hdr->flags) !=
> +		    (VIRTIO_VSOCK_DGRAM_START | VIRTIO_VSOCK_DGRAM_EOM))
>  			goto free_pkt;
>  
>  		sk = vsock_find_bound_dgram_socket_net(&dst, net);
> 
> -- 
> 2.56.0
> 
