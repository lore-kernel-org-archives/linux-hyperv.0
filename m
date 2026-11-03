Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736378;
	b=e/08DUnjOOPGwnqZencV4L3YpBionsITL0BsGP2wS5GSEEOb/DmBMaEiInNYtNOxKCfz
	 p1r89cRHdc2+u57R2l/DQxAkVYN2GyhFYeNY7RLwemIuRlcLrEHWkxcBQ+ZIshFmmf5wq
	 uaDotbcllHJaQzQy7bsDGHqnrNYUdmTz25hVNwgUZbvE8px7Xrl6ZSflnoG8njaxWdz9i
	 H03gNp2PpF6pP+AElGbWPEFL0JXJSQwsx+0X/Hj9zP4sYr5oKm5i6s1La7c/Yn24Hvts1
	 V2fXLScIk9BT35HRjkpBA6l/A0C+6gmGzBNe5V1AJm2g2RgvvHP4N5uGoo12YYYuPSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=EbXRj/VoZXjnYYvX5GcP3VoKb0bqBACBxaGvCwlJt6U=;
	b=MhyVVbwxnj7g7rx1ZAZUi+8Q7Y75MkSvddMveKskCzvGOq+gWkipAE5bQW4LgCBvWULM
	 WcyYEfA6F5xmNlPAVNan7QRX0zv2qPcI40WxRy05KETjeQdsTAfyMwgHd77ZDRCo2FAxY
	 Au2rZXIWqOBxcCLvzKXmaqoaGLu2vCr9zSUky8B4H6QlgMi7Hv5b9ilCbzrfl0cWf9Cpm
	 hkd005ZcqokLNnsHgRXtoukx6FcTCvp+rC1BUC33+4/92CoD+VyZ9qIFCvWmAzraIZbpg
	 ZACBRo266WMDgl6ptgKTIm3Aam7wis1CCMQ7Nn6I8rP2/DmI6e0jE2xcLBNWa4b8UdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M5FDkL7f;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA14606D80E;
	Tue,  3 Nov 2026 20:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA14606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M5FDkL7f
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Jla3k3060700;
	Tue, 3 Nov 2026 12:05:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=EbXRj/VoZXj
	nYYvX5GcP3VoKb0bqBACBxaGvCwlJt6U=; b=M5FDkL7fFFQYWeo3kFd/wddB0ac
	oaq1g3qqP/E4WWA+UNf0X2Ovdx0XMs9vDpTvuGORAtva0XYYUvM/hze3crUY7cxt
	oI0U5tbnbwZtcu/iMf7VaA3+IpPYtaAepy8UPoVYReVpLuS1Fo9r5UAO2y9+b802
	PpMJSuLjyPv2oTCW/4ac34J/7puh/eslGwvcC3T8qqQjKU+HlSNsSRDBFFnLn/42
	Vf5ZuIuAtfHgbPEPolNyOieFe2tVlDo+WQfh8PsMpMgzN4upfgmm7pOtjltXy+Vd
	PTFaTN6UcStLb0jSHp+sBtuCeDU5tXmgIxCgJtlVt5dTpMr+5yz5XGgLIIQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqbrfd4tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 12:05:52 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 3 Nov
 2026 20:05:51 +0000
Date: Tue, 3 Nov 2026 12:05:49 -0800
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
Subject: Re: [PATCH RFC 3/8] vsock/virtio: implement the datagram data path
Message-ID: <auo+nf3+0Mdm8vpi@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
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
In-Reply-To: <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX/rRmIK0iah9n
 HWxisJ6YTcnHHNOeq4OsAYonwfqNddeCsaHXKgSaskimHUkkvBJHfU56260zCn65zPp51xKIMNn
 xWpalehduhka8znnZj2v1H/Ov6i1Re3bzsqzLVUcubI0y10iQKEgW4Qgtv+02B6vvShn4ssWwuT
 3Y+qFYuc3j8xhZwILuy7774CaetYTviT0+BgABYCYMM9GXrf1gvUbhAgu0RklH++CcRfW659ny5
 obreNr+NE3MUj0vPwPH/gQvtDQRezuS0DTU/Hm8we9v53hH5eCnjXde9gmHMbxMg3D5I6LOU40U
 ufzaetRRcq0R2mFvdMFeKHC42Jd5G0JbSliCpRsXFK7L4ZsNrXKEogBmLjCSc1SOLG7vSTYzXDX
 KppcLrlICk/QhvLBs4BoApkFEoYTWywQfuX0IRwXmONN/LL7kzi6IoU1FnWcc+hlJEFxFhCszQU
 Hm1mw4/n8wAEQf5gUfg==
X-Proofpoint-GUID: cCDcj29cRLPmF9hW3bwep9_8Uevg30dV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfXza1vwp4gLkIr
 o9x0k59Oylt/fRJSjcW+OaPNXI/BvzyYf3NpXTWN/3yXs6a8ad5tpYP02TtYMZwt4jnoOmb0CTx
 q/LoCz7QhgaX0rgqs9psQ4nE4u+zfGk=
X-Authority-Analysis: v=2.4 cv=VPNIDNPX c=1 sm=1 tr=0 ts=6aea3ea0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=20KFwNOVAAAA:8
 a=4-e4pYDdotXksanAMVAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cCDcj29cRLPmF9hW3bwep9_8Uevg30dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01

On Wed, Oct 28, 2026 at 05:04:32PM +0100, Sergio Lopez wrote:
> Add the datagram feature bit and packet type, and implement the common
> virtio transport operations needed to bind, send, and receive
> datagrams.
> 
> Send each message as an OP_RW packet with a maximum 64 KiB payload,
> including support for empty messages. Bound pending sends by the
> socket send buffer instead of connection-oriented peer credits. Charge
> pending payload bytes before handing the skb to the backend and
> release that charge exactly once on completion, rejection, or queued
> drops.
> 
> Deliver incoming datagrams through the bound table without entering
> the connection state machine. Validate the transport and connected
> peer under the socket lock, including after shutdown, and silently
> discard undeliverable messages. Use the socket datagram queue for
> recvmsg(), including source addresses, peeking, and truncation
> reporting based on the payload length after socket filtering.  Reject
> MSG_OOB and MSG_ERRQUEUE before accessing the receive queue.  Reject
> datagram sockmap admission until its receive callbacks support it.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  include/linux/virtio_vsock.h            |   2 +
>  include/uapi/linux/virtio_vsock.h       |   2 +
>  net/vmw_vsock/virtio_transport_common.c | 150 +++++++++++++++++++++++++++++---
>  net/vmw_vsock/vsock_bpf.c               |   3 +-
>  4 files changed, 142 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057..0bccae661221 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -12,6 +12,8 @@
>  struct virtio_vsock_skb_cb {
>  	bool reply;
>  	bool tap_delivered;
> +	/* Datagram payload is still charged to bytes_unsent. */
> +	bool tx_accounted;
>  	u32 offset;
>  };
>  
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 64738838bee5..27b4b2b8bf13 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -40,6 +40,7 @@
>  
>  /* The feature bitmap for virtio vsock */
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>  
>  struct virtio_vsock_config {
>  	__le64 guest_cid;
> @@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
>  enum virtio_vsock_type {
>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
>  	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> +	VIRTIO_VSOCK_TYPE_DGRAM = 3,
>  };
>  
>  enum virtio_vsock_op {
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 1e762a480df4..ae33630d99e7 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -204,10 +204,18 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  {
>  	if (sk->sk_type == SOCK_STREAM)
>  		return VIRTIO_VSOCK_TYPE_STREAM;
> +	else if (sk->sk_type == SOCK_DGRAM)
> +		return VIRTIO_VSOCK_TYPE_DGRAM;
>  	else
>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>  }
>  
> +static void virtio_transport_dgram_skb_destructor(struct sk_buff *skb)
> +{
> +	virtio_transport_consume_skb_sent(skb, false);
> +	sock_wfree(skb);
> +}
> +
>  /* Returns new sk_buff on success, otherwise returns NULL. */
>  static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>  						  size_t payload_len,
> @@ -303,6 +311,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	u32 src_cid, src_port, dst_cid, dst_port;
>  	const struct virtio_transport *t_ops;
>  	struct iov_iter_state msg_iter_state;
> +	struct sock *sk = sk_vsock(vsk);
>  	struct virtio_vsock_sock *vvs;
>  	struct ubuf_info *uarg = NULL;
>  	u32 pkt_len = info->pkt_len;
> @@ -329,12 +338,24 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  	vvs = vsk->trans;
>  
> -	/* virtio_transport_get_credit might return less than pkt_len credit */
> -	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> +	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
> +		if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +			return -EMSGSIZE;
>  
> -	/* Do not send zero length OP_RW pkt */
> -	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> -		return pkt_len;
> +		/* Datagram sends are serialized by the socket lock. */
> +		if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
> +			sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
> +			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +			return -EAGAIN;
> +		}
> +	} else {
> +		/* virtio_transport_get_credit might return less than pkt_len credit */
> +		pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> +
> +		/* Do not send zero length OP_RW pkt */
> +		if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> +			return pkt_len;
> +	}
>  
>  	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>  		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> @@ -348,7 +369,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>  						    NULL, false);
>  			if (!uarg) {
> -				virtio_transport_put_credit(vvs, pkt_len);
> +				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
> +					virtio_transport_put_credit(vvs, pkt_len);
>  				return -ENOMEM;
>  			}
>  
> @@ -393,7 +415,15 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		virtio_transport_inc_tx_pkt(vvs, skb);
> +		if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
> +			spin_lock_bh(&vvs->tx_lock);
> +			vvs->bytes_unsent += skb_len;
> +			spin_unlock_bh(&vvs->tx_lock);
> +			VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = true;
> +			skb->destructor = virtio_transport_dgram_skb_destructor;
> +		} else {
> +			virtio_transport_inc_tx_pkt(vvs, skb);
> +		}
>  
>  		ret = t_ops->send_pkt(skb, info->net);
>  		if (ret < 0)
> @@ -416,7 +446,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (info->msg && ret < 0)
>  		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
>  
> -	virtio_transport_put_credit(vvs, rest_len);
> +	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
> +		virtio_transport_put_credit(vvs, rest_len);
>  
>  	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
>  	 * skb_zcopy_set() increases it for each skb, so we can drop that
> @@ -620,7 +651,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>  {
>  	struct sock *s = skb->sk;
>  
> -	if (s && skb->len) {
> +	if (s && skb->len &&
> +	    (s->sk_type != SOCK_DGRAM ||
> +	     VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted)) {
>  		struct vsock_sock *vs = vsock_sk(s);
>  		struct virtio_vsock_sock *vvs;
>  
> @@ -631,6 +664,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>  		spin_unlock_bh(&vvs->tx_lock);
>  	}
>  
> +	if (s && s->sk_type == SOCK_DGRAM)
> +		VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = false;
> +
>  	if (consume)
>  		consume_skb(skb);
>  }
> @@ -999,7 +1035,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>  			       struct msghdr *msg,
>  			       size_t len, int flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct sock *sk = sk_vsock(vsk);
> +	struct virtio_vsock_hdr *hdr;
> +	struct sk_buff *skb;
> +	size_t payload_len;
> +	int err;
> +
> +	if (flags & (MSG_OOB | MSG_ERRQUEUE))
> +		return -EOPNOTSUPP;
> +
> +	skb = skb_recv_datagram(sk, flags, &err);
> +	if (!skb)
> +		return err;
> +
> +	hdr = virtio_vsock_hdr(skb);
> +	payload_len = skb->len;
> +
> +	if (payload_len > len) {
> +		payload_len = len;
> +		msg->msg_flags |= MSG_TRUNC;
> +	}
> +
> +	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
> +	if (err)
> +		goto out;
> +
> +	if (msg->msg_name) {
> +		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
> +
> +		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
> +				le32_to_cpu(hdr->src_port));
> +		msg->msg_namelen = sizeof(*vm_addr);
> +	}
> +
> +	if (flags & MSG_TRUNC)
> +		err = skb->len;
> +	else
> +		err = payload_len;
> +
> +out:
> +	skb_free_datagram(sk, skb);
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
>  
> @@ -1202,13 +1278,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
>  int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>  				struct sockaddr_vm *addr)
>  {
> -	return -EOPNOTSUPP;
> +	return vsock_bind_common(vsk, addr);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
>  
>  bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>  {
> -	return false;
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
>  
> @@ -1246,7 +1322,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
>  			       struct msghdr *msg,
>  			       size_t dgram_len)
>  {
> -	return -EOPNOTSUPP;
> +	struct virtio_vsock_pkt_info info = {
> +		.op = VIRTIO_VSOCK_OP_RW,
> +		.msg = msg,
> +		.pkt_len = dgram_len,
> +		.vsk = vsk,
> +		.remote_cid = remote_addr->svm_cid,
> +		.remote_port = remote_addr->svm_port,
> +		.net = sock_net(sk_vsock(vsk)),
> +	};
> +
> +	return virtio_transport_send_pkt_info(vsk, &info);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
>  
> @@ -1771,7 +1857,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  static bool virtio_transport_valid_type(u16 type)
>  {
>  	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
> -	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> +	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
> +	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
>  }
>  
>  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> @@ -1805,6 +1892,41 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		goto free_pkt;
>  	}
>  
> +	/* Dgram packets are delivered directly to bound sockets without
> +	 * going through the connection state machine. Undeliverable
> +	 * datagrams are silently dropped (no RST).
> +	 */
> +	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
> +		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
> +			goto free_pkt;
> +
> +		sk = vsock_find_bound_socket_net(&dst, net);
> +
> +		if (!sk || sk->sk_type != SOCK_DGRAM) {
> +			if (sk)
> +				sock_put(sk);
> +			goto free_pkt;
> +		}
> +
> +		vsk = vsock_sk(sk);
> +		lock_sock(sk);
> +		if (sock_flag(sk, SOCK_DEAD) ||
> +		    vsk->transport != &t->transport ||
> +		    (sk->sk_socket->state != SS_UNCONNECTED &&
> +		     !vsock_check_source(vsk, &t->transport, &src))) {
> +			release_sock(sk);
> +			sock_put(sk);
> +			goto free_pkt;
> +		}
> +
> +		if (sock_queue_rcv_skb(sk, skb))
> +			kfree_skb(skb);

I'd love to see the receive path be free of lock_sock the way that UDP
does.

My understanding from udp is that we can avoid the race with
close/SOCK_DEAD by using SOCK_RCU_FREE and putting this receive in an
rcu read-side section. I think this makes sk->sk_socket->state safe
inside the RCU read side section too.

I think vsock_check_source() in a later patch goes away with
virtio_transport_dgram_source_allow(), so I think maybe that patch
should come before this?

Best,
Bobby

> +
> +		release_sock(sk);
> +		sock_put(sk);
> +		return;
> +	}
> +
>  	/* The socket must be in connected or bound table
>  	 * otherwise send reset back
>  	 */
> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d2648646..296e1fa7970b 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -161,7 +161,8 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
>  	if (!vsk->transport)
>  		return -ENODEV;
>  
> -	if (!vsk->transport->read_skb)
> +	/* Datagram receive is not implemented by the sockmap callbacks. */
> +	if (sk->sk_type == SOCK_DGRAM || !vsk->transport->read_skb)
>  		return -EOPNOTSUPP;
>  
>  	vsock_bpf_check_needs_rebuild(psock->sk_proto);
> 
> -- 
> 2.56.0
> 
