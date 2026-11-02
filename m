Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658593;
	b=bM/A4DP9tGv/LQKwsCVIKMPlQG91/qKQkfPGGZg+EzziJHaTM/vWt1a2iZFUO+i/KxYN
	 GD648FIF/PFq/AbjS1VlqszofJ8cJmCHXNRTh2Jk7r+yf4epyOsgB6COS82YKyH4pcP6V
	 7fFcekTRPWXGAS8WO9wRCrnCsABf4CCWdJzKOcYCp+gyxzxKcbdkp8sRX5lneamYdOIOV
	 dIgVYbSzXjjVVTjOLg9NOCpS09cKT05vREDkKDSqhgHNjw/eOdU20h8vFBUObhMLCnzjg
	 ub3RNOoea2LCEaAP3Du6g8gA84VmddRZFvzofR7o41HfWfLdzThF9gyw8bBByUnJD1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=sCyX1SlkGo6sHkRrndUyjOrZH78yqj6CSUvT1FPlrwE=;
	b=Slead4CeWWXvCfUfHF2NOjydxh3XSqE/mG1l1r7H3dVEBzzWLq7RCz2GwVGCh9PZSk1K
	 C43K0OQ+BZ3ByMnkr5sIyfcvLHDKJlyH2S1fSv9ihXo8rDdxriyQD7Pe1oYmA1kU0O7iu
	 HzNQBtcAWp+MI1Bw+l+WQtHuML68HY7EhCMK/qFvAT/fA2c6sFT4qZOpzDbq1oO0nvA1q
	 5QeRZo3ROlW8mEH0lNYCnrZKZSimI3ME5f18VRI6o5WMGsMu9ylApU/p0VsVWg9UG89sC
	 I8fjpgc/xP8VUKaOkeNQ5Kf0OTS/2grORNBKn2Mu0xCogPcC68zEsxY6UEGnZ+xj/jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SriatJT+;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B52606A324;
	Mon,  2 Nov 2026 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B52606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SriatJT+
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K5uSZ2957720;
	Mon, 2 Nov 2026 14:29:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=sCyX1SlkGo6
	sHkRrndUyjOrZH78yqj6CSUvT1FPlrwE=; b=SriatJT+QP03fGope/jDFqRN4sG
	dETDESirlWvM/iRq4W/3iY/r5ZoyDqJmpSjZm1RrNxLyZl0zVMi6jWRoGUf+LGVJ
	IrPuMF2B3eqv05Dopps2D+4p0VsJbZktB9yElb9hQeGfXhpKcrV48z/IukCgvAdO
	q/iTfkIp95rW+bPelaTJ4v1jTdfoRDNAadB9O9W6U3mZ0CI4pNzcix2Ycudmt179
	5+CQCMNusANkC0olYo9+zYnG4mDT5U70PGnZejq5S4Ahst4Dd4LroKV3dxr/8KfK
	okeA0vkYTGiWv62N6k0atvqBx2HUaMdwqYrQvAEsWSGnC40akdBNtSNGpsw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hnbn1xqya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Nov 2026 14:29:39 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 2 Nov
 2026 22:29:38 +0000
Date: Mon, 2 Nov 2026 14:29:37 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Sergio Lopez <slp@redhat.com>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Bryan Tan <bryan-bt.tan@broadcom.com>,
        Vishnu Dasa
	<vishnu.dasa@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
	<decui@microsoft.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
Message-ID: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org>
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
In-Reply-To: <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org>
X-Proofpoint-GUID: 4YnaN3ymqMYCxFAr5IM1ktmuNJQqZeGN
X-Proofpoint-ORIG-GUID: 4YnaN3ymqMYCxFAr5IM1ktmuNJQqZeGN
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6ae90ed3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=20KFwNOVAAAA:8
 a=pA-z6RXXlCInsJ1ToaIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4OCBTYWx0ZWRfX1xy47RxZOmCs
 Cn+rXJ//HwvJMkfBoTxMOUJd//jyj3HGoLlZyNDbcOgzuJUexy7zcshjSGoiFiZtdfwtGFBlIJA
 JFpdATM2iwgHuMx4th8pJkaAHCvJ7l8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4OCBTYWx0ZWRfXz2AUGdfp7WQI
 ZltDpz2TzSM/0WbFnKhHsk7ShsIAYRyXLTlJIc6yFlcs+ArbV9rc8M9vhb9aRax9FMvt1ntczFI
 mcRtZ5qd8rNQ+nHfCCjUYKY3edoZk+FPQo/f3tFBi3r8A99/P3dn4mtapS9szrs8Kk5WPfVnxoU
 YIjcs2XC/T+8wQwIkUWL0IW99Q5ctkatRO1s2MfJLqTSdSFzzFRIGu1alsGGGxkOPm9W/Yx/Pqi
 0DCfcZEh8lXGV/hOJa7UG+aU7zkXc3n5Z1bz5zYG5kudrvBo48Ulgs5NFkPQFn84ydIjwf3HEoN
 rNQxqURdkMdVO69DNYR0XDxht1MTNnLe4u3TBQmBRtoV7fNaetNZdMnCihiAfYcXgN6DLAioEbv
 QsK3wGAmzlZYG8ZewjMPiWkYiMuDgYBjFG0duGqzPd5rTskXN5G1khghM5QwOk3gwiqbE7Bv8wD
 TC6cU5niLqCtb/cyQZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01

On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
> Vhost splits large datagrams across guest RX buffers, delivering each
> fragment as a separate message. Allocate full-size RX buffers with
> page fragments when datagrams are negotiated, and drop whole datagrams
> if a guest buffer is too small. Refill empty RX queues even when only
> one full-size buffer fits in the ring.

I wonder if it might be better to do what seqpacket does, and just split
the datagram across the buffers (for seqpacket, until the EOM flag is
seen)? I'd expect that we will get better utilization of our vq buffers
this way?

Best,
Bobby

> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/vhost/vsock.c            |  8 ++++++++
>  net/vmw_vsock/virtio_transport.c | 28 +++++++++++++++++++---------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 79ffdb28f4d9..2294ed8d30a8 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -185,6 +185,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		 * buffer, we split it using multiple buffers.
>  		 */
>  		if (payload_len > iov_len - sizeof(*hdr)) {
> +			/* Datagrams must fit in a single descriptor chain. */
> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
> +				kfree_skb(skb);
> +				vhost_add_used(vq, head, 0);
> +				added = true;
> +				continue;
> +			}
> +
>  			payload_len = iov_len - sizeof(*hdr);
>  
>  			/* As we are copying pieces of large packet's buffer to
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 14ce0836bc39..d256274088b3 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -54,6 +54,7 @@ struct virtio_vsock {
>  	bool rx_run;
>  	int rx_buf_nr;
>  	int rx_buf_max_nr;
> +	struct scatterlist in_bufs[MAX_SKB_FRAGS + 1];
>  
>  	u32 guest_cid;
>  	bool seqpacket_allow;
> @@ -312,22 +313,31 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  {
>  	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> -	struct scatterlist pkt, *p;
>  	struct virtqueue *vq;
>  	struct sk_buff *skb;
>  	int ret;
>  
>  	vq = vsock->vqs[VSOCK_VQ_RX];
> +	/* A datagram must fit in one RX buffer, including its header. */
> +	if (vsock->dgram_allow)
> +		total_len = VIRTIO_VSOCK_SKB_HEADROOM +
> +			    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>  
>  	do {
> -		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> +		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>  		if (!skb)
>  			break;
>  
>  		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
> -		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
> -		p = &pkt;
> -		ret = virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
> +		/* Post the header and the entire payload as one RX buffer. */
> +		virtio_vsock_skb_put(skb, total_len - VIRTIO_VSOCK_SKB_HEADROOM);
> +		skb_push(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> +		sg_init_table(vsock->in_bufs, ARRAY_SIZE(vsock->in_bufs));
> +		ret = skb_to_sgvec(skb, vsock->in_bufs, 0, total_len);
> +		skb_pull(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> +		if (ret >= 0)
> +			ret = virtqueue_add_inbuf(vq, vsock->in_bufs, ret, skb,
> +						  GFP_KERNEL);
>  		if (ret < 0) {
>  			kfree_skb(skb);
>  			break;
> @@ -698,7 +708,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			/* Drop short/long packets */
>  			if (unlikely(len < sizeof(*hdr) ||
> -				     len > virtio_vsock_skb_len(skb))) {
> +				     len > sizeof(*hdr) + skb->len)) {
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -710,8 +720,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  				continue;
>  			}
>  
> -			if (payload_len)
> -				virtio_vsock_skb_put(skb, payload_len);
> +			pskb_trim_unique(skb, payload_len);
>  
>  			virtio_transport_deliver_tap_pkt(skb);
>  
> @@ -723,7 +732,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	} while (!virtqueue_enable_cb(vq));
>  
>  out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +	if (!vsock->rx_buf_nr ||
> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  out_nofill:
>  	mutex_unlock(&vsock->rx_lock);
> 
> -- 
> 2.56.0
> 
