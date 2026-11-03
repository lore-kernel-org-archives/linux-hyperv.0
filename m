Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736934;
	b=znNnJgmvzDQHS6kVf1RjWnYylJz3+ishKFLr0o8AQn2RKtaGRHpCD98qhv1RMGzkv/FI
	 7jikmWn7glTtXPNGI55GwB9xxYskpAc99uWu95T1yzcyTasUc1gmOAejycpEFbaGBfAtk
	 mpF4bJ+HMdCEmFogVeOioJTWs8bTPFbUrdWnoR/FOim8L0rpDVMobrKi76g6Pbue46hEh
	 J2V/ajxpiE6oyu+VsLMRKXHAnNvb56WQd5hNvNulFvhjnUCEr0DNGUs6nINV1v50E2r4Q
	 ujX1olbORE2txjHl2mkZyzqTK1SHt1PKtPJkC9f1WRo8Qr2S6wrsQzOZuhDYFIB37/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=eghRhgi4bPuKMGkoryBJ+KE/HiW3Dfnjrc6aD6yazkE=;
	b=VbPb5n57+2uYk1rNDCi1HdPcS8lfrPwQTt95cSEJIp3Zac4Woc10EbtjNpBn8Oy2uyHN
	 7LtBVD/o6B38pII+S+LX6X64FYmjqPEVJgH7ZputXJ8O4GFjmEeVIS8Jz4XgDOH+2Fx5O
	 P6fy/WlOR0uDTnlCV6bXgp9BdOUC4qdPqjCQXSc01Ys2P8NRQCF2bSLBC4AXI3JOAFGxA
	 TsgFZ/0ixawrdsURecBVj0zYgWfxHMxk7Q+i1ZQLVBCA86yr5OYba8TZqRU54ehkP578f
	 EdpBsCLwUpuK4JMQN3uWKKxIyVgbJeKbYeXprH16JxhyJZ/sN1V0i8K7+U5QubszzQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ZyENK9RA;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAD606A329;
	Tue,  3 Nov 2026 20:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DAD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ZyENK9RA
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3JlSKg3135601;
	Tue, 3 Nov 2026 12:15:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=eghRhgi4bPu
	KMGkoryBJ+KE/HiW3Dfnjrc6aD6yazkE=; b=ZyENK9RAiwRGQ4p5HoO4M5u3Btq
	qzQDZbUmFIZwIMmA17kT20JWAVIu4/DWA8McHN8us3aWAHqPZzeDd+zTWPwCOD7W
	IR4Xq9usNzrmY7I3wEHLRlHsENtiZG0b/o2tXkfHC8LyuCgv9zJzvKoEISDcHZ01
	0cK6rEgtAr2MBTWQZ6WxwWATT5ZOE9gtdCQC4eLXqA9vYwGkXAjXDkCW6H77CwSI
	/RP67hxP17l8leDAH09KqZfvMntPN3MPPW+D5U6C9C+wIYy4n0tzQOZLOgufOnNx
	wV1vilxODbk4Wul101SB14ofguhAAkYSagrlVJt+9idhAOChHzjXSwrHhxQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqbb1na9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 12:15:19 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 3 Nov
 2026 20:15:09 +0000
Date: Tue, 3 Nov 2026 12:15:08 -0800
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
Message-ID: <aupAzEcsi35RCasR@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
 <auo+nf3+0Mdm8vpi@devvm29614.prn0.facebook.com>
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
In-Reply-To: <auo+nf3+0Mdm8vpi@devvm29614.prn0.facebook.com>
X-Proofpoint-GUID: W6AiV-pcr9Xrgipzqm2Wy4CacCTy2FZz
X-Authority-Analysis: v=2.4 cv=LsIHWXdc c=1 sm=1 tr=0 ts=6aea40d7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=20KFwNOVAAAA:8
 a=nZWooqS4hBZVCPw9Ht8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXxbaKkvPr0ZVw
 OQ3+MkSEgI8Uio828XRon02AztNCkFgnMjufpoEnG2mB/0BMqzYhmJxlYJD+9vf9g+cptugXuT0
 McDkEvEa9Rh8xq83bvXKDuvvGY1ToT23bIdfz2DsAjPhDd7ZEwQUmE08DnzliY7orOYEa3Nw0V+
 Ka2gvgK8HfCZe3i3pMB+zNjpK0rVUEpMwtUmhvZf1fiKRcTrcDrJB7lWpFzxuKoBPnHr8xILN4e
 LCD1FPxRjSP3biXoM7Vb6dZuCyH1E1kLD83BjYLP5asqxVEI3XyfBKms0FUKKmdVnlT0t66gYrX
 Nz7AAPnllE3g8d1mVY2bCGfqWkP9xCAOjr9IwNkIhFCCFqltBoUtIIngD1Eb1vbQ26v+JY0M4az
 wMFq7JeeT9493X5XR4RTecFG1BEiOvYiQmrmmzMP73lOpbpjQCs/XCKvu2dTqFw+6l/A9bAJYdJ
 igiWI0xvm3SlGqbpmAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXwul97ZCEahbK
 23uk3sjG6YPIXIzTlEf5eLQihyXmyBsbG+dXHqCeNi1NDZWmE8RSBumAFFHniGRKXXgKG5PKQ8t
 AVR65Y5TBe66jJbJuCSD0D5Bhf7sOyE=
X-Proofpoint-ORIG-GUID: W6AiV-pcr9Xrgipzqm2Wy4CacCTy2FZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01

On Tue, Nov 03, 2026 at 12:05:49PM -0800, Bobby Eshleman wrote:
> On Wed, Oct 28, 2026 at 05:04:32PM +0100, Sergio Lopez wrote:
> > Add the datagram feature bit and packet type, and implement the common
> > virtio transport operations needed to bind, send, and receive
> > datagrams.
> > 
> > Send each message as an OP_RW packet with a maximum 64 KiB payload,
> > including support for empty messages. Bound pending sends by the
> > socket send buffer instead of connection-oriented peer credits. Charge
> > pending payload bytes before handing the skb to the backend and
> > release that charge exactly once on completion, rejection, or queued
> > drops.
> > 
> > Deliver incoming datagrams through the bound table without entering
> > the connection state machine. Validate the transport and connected
> > peer under the socket lock, including after shutdown, and silently
> > discard undeliverable messages. Use the socket datagram queue for
> > recvmsg(), including source addresses, peeking, and truncation
> > reporting based on the payload length after socket filtering.  Reject
> > MSG_OOB and MSG_ERRQUEUE before accessing the receive queue.  Reject
> > datagram sockmap admission until its receive callbacks support it.
> > 
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  include/linux/virtio_vsock.h            |   2 +
> >  include/uapi/linux/virtio_vsock.h       |   2 +
> >  net/vmw_vsock/virtio_transport_common.c | 150 +++++++++++++++++++++++++++++---
> >  net/vmw_vsock/vsock_bpf.c               |   3 +-
> >  4 files changed, 142 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..0bccae661221 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -12,6 +12,8 @@
> >  struct virtio_vsock_skb_cb {
> >  	bool reply;
> >  	bool tap_delivered;
> > +	/* Datagram payload is still charged to bytes_unsent. */
> > +	bool tx_accounted;
> >  	u32 offset;
> >  };
> >  
> > diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> > index 64738838bee5..27b4b2b8bf13 100644
> > --- a/include/uapi/linux/virtio_vsock.h
> > +++ b/include/uapi/linux/virtio_vsock.h
> > @@ -40,6 +40,7 @@
> >  
> >  /* The feature bitmap for virtio vsock */
> >  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> > +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
> >  
> >  struct virtio_vsock_config {
> >  	__le64 guest_cid;
> > @@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
> >  enum virtio_vsock_type {
> >  	VIRTIO_VSOCK_TYPE_STREAM = 1,
> >  	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> > +	VIRTIO_VSOCK_TYPE_DGRAM = 3,
> >  };
> >  
> >  enum virtio_vsock_op {
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 1e762a480df4..ae33630d99e7 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -204,10 +204,18 @@ static u16 virtio_transport_get_type(struct sock *sk)
> >  {
> >  	if (sk->sk_type == SOCK_STREAM)
> >  		return VIRTIO_VSOCK_TYPE_STREAM;
> > +	else if (sk->sk_type == SOCK_DGRAM)
> > +		return VIRTIO_VSOCK_TYPE_DGRAM;
> >  	else
> >  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> >  }
> >  
> > +static void virtio_transport_dgram_skb_destructor(struct sk_buff *skb)
> > +{
> > +	virtio_transport_consume_skb_sent(skb, false);
> > +	sock_wfree(skb);
> > +}
> > +
> >  /* Returns new sk_buff on success, otherwise returns NULL. */
> >  static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> >  						  size_t payload_len,
> > @@ -303,6 +311,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  	u32 src_cid, src_port, dst_cid, dst_port;
> >  	const struct virtio_transport *t_ops;
> >  	struct iov_iter_state msg_iter_state;
> > +	struct sock *sk = sk_vsock(vsk);
> >  	struct virtio_vsock_sock *vvs;
> >  	struct ubuf_info *uarg = NULL;
> >  	u32 pkt_len = info->pkt_len;
> > @@ -329,12 +338,24 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  
> >  	vvs = vsk->trans;
> >  
> > -	/* virtio_transport_get_credit might return less than pkt_len credit */
> > -	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> > +	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
> > +		if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > +			return -EMSGSIZE;
> >  
> > -	/* Do not send zero length OP_RW pkt */
> > -	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> > -		return pkt_len;
> > +		/* Datagram sends are serialized by the socket lock. */
> > +		if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
> > +			sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
> > +			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > +			return -EAGAIN;
> > +		}
> > +	} else {
> > +		/* virtio_transport_get_credit might return less than pkt_len credit */
> > +		pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> > +
> > +		/* Do not send zero length OP_RW pkt */
> > +		if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> > +			return pkt_len;
> > +	}
> >  
> >  	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> >  		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> > @@ -348,7 +369,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> >  						    NULL, false);
> >  			if (!uarg) {
> > -				virtio_transport_put_credit(vvs, pkt_len);
> > +				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
> > +					virtio_transport_put_credit(vvs, pkt_len);
> >  				return -ENOMEM;
> >  			}
> >  
> > @@ -393,7 +415,15 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  			break;
> >  		}
> >  
> > -		virtio_transport_inc_tx_pkt(vvs, skb);
> > +		if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
> > +			spin_lock_bh(&vvs->tx_lock);
> > +			vvs->bytes_unsent += skb_len;
> > +			spin_unlock_bh(&vvs->tx_lock);
> > +			VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = true;
> > +			skb->destructor = virtio_transport_dgram_skb_destructor;
> > +		} else {
> > +			virtio_transport_inc_tx_pkt(vvs, skb);
> > +		}
> >  
> >  		ret = t_ops->send_pkt(skb, info->net);
> >  		if (ret < 0)
> > @@ -416,7 +446,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  	if (info->msg && ret < 0)
> >  		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
> >  
> > -	virtio_transport_put_credit(vvs, rest_len);
> > +	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
> > +		virtio_transport_put_credit(vvs, rest_len);
> >  
> >  	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> >  	 * skb_zcopy_set() increases it for each skb, so we can drop that
> > @@ -620,7 +651,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> >  {
> >  	struct sock *s = skb->sk;
> >  
> > -	if (s && skb->len) {
> > +	if (s && skb->len &&
> > +	    (s->sk_type != SOCK_DGRAM ||
> > +	     VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted)) {
> >  		struct vsock_sock *vs = vsock_sk(s);
> >  		struct virtio_vsock_sock *vvs;
> >  
> > @@ -631,6 +664,9 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> >  		spin_unlock_bh(&vvs->tx_lock);
> >  	}
> >  
> > +	if (s && s->sk_type == SOCK_DGRAM)
> > +		VIRTIO_VSOCK_SKB_CB(skb)->tx_accounted = false;
> > +
> >  	if (consume)
> >  		consume_skb(skb);
> >  }
> > @@ -999,7 +1035,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> >  			       struct msghdr *msg,
> >  			       size_t len, int flags)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct sock *sk = sk_vsock(vsk);
> > +	struct virtio_vsock_hdr *hdr;
> > +	struct sk_buff *skb;
> > +	size_t payload_len;
> > +	int err;
> > +
> > +	if (flags & (MSG_OOB | MSG_ERRQUEUE))
> > +		return -EOPNOTSUPP;
> > +
> > +	skb = skb_recv_datagram(sk, flags, &err);
> > +	if (!skb)
> > +		return err;
> > +
> > +	hdr = virtio_vsock_hdr(skb);
> > +	payload_len = skb->len;
> > +
> > +	if (payload_len > len) {
> > +		payload_len = len;
> > +		msg->msg_flags |= MSG_TRUNC;
> > +	}
> > +
> > +	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
> > +	if (err)
> > +		goto out;
> > +
> > +	if (msg->msg_name) {
> > +		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
> > +
> > +		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
> > +				le32_to_cpu(hdr->src_port));
> > +		msg->msg_namelen = sizeof(*vm_addr);
> > +	}
> > +
> > +	if (flags & MSG_TRUNC)
> > +		err = skb->len;
> > +	else
> > +		err = payload_len;
> > +
> > +out:
> > +	skb_free_datagram(sk, skb);
> > +	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
> >  
> > @@ -1202,13 +1278,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
> >  int virtio_transport_dgram_bind(struct vsock_sock *vsk,
> >  				struct sockaddr_vm *addr)
> >  {
> > -	return -EOPNOTSUPP;
> > +	return vsock_bind_common(vsk, addr);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
> >  
> >  bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> >  {
> > -	return false;
> > +	return true;
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
> >  
> > @@ -1246,7 +1322,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> >  			       struct msghdr *msg,
> >  			       size_t dgram_len)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct virtio_vsock_pkt_info info = {
> > +		.op = VIRTIO_VSOCK_OP_RW,
> > +		.msg = msg,
> > +		.pkt_len = dgram_len,
> > +		.vsk = vsk,
> > +		.remote_cid = remote_addr->svm_cid,
> > +		.remote_port = remote_addr->svm_port,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +	};
> > +
> > +	return virtio_transport_send_pkt_info(vsk, &info);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
> >  
> > @@ -1771,7 +1857,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> >  static bool virtio_transport_valid_type(u16 type)
> >  {
> >  	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
> > -	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > +	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
> > +	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
> >  }
> >  
> >  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > @@ -1805,6 +1892,41 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >  		goto free_pkt;
> >  	}
> >  
> > +	/* Dgram packets are delivered directly to bound sockets without
> > +	 * going through the connection state machine. Undeliverable
> > +	 * datagrams are silently dropped (no RST).
> > +	 */
> > +	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
> > +		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
> > +			goto free_pkt;
> > +
> > +		sk = vsock_find_bound_socket_net(&dst, net);
> > +
> > +		if (!sk || sk->sk_type != SOCK_DGRAM) {
> > +			if (sk)
> > +				sock_put(sk);
> > +			goto free_pkt;
> > +		}
> > +
> > +		vsk = vsock_sk(sk);
> > +		lock_sock(sk);
> > +		if (sock_flag(sk, SOCK_DEAD) ||
> > +		    vsk->transport != &t->transport ||
> > +		    (sk->sk_socket->state != SS_UNCONNECTED &&
> > +		     !vsock_check_source(vsk, &t->transport, &src))) {
> > +			release_sock(sk);
> > +			sock_put(sk);
> > +			goto free_pkt;
> > +		}
> > +
> > +		if (sock_queue_rcv_skb(sk, skb))
> > +			kfree_skb(skb);
> 
> I'd love to see the receive path be free of lock_sock the way that UDP
> does.
> 
> My understanding from udp is that we can avoid the race with
> close/SOCK_DEAD by using SOCK_RCU_FREE and putting this receive in an
> rcu read-side section. I think this makes sk->sk_socket->state safe
> inside the RCU read side section too.
> 
> I think vsock_check_source() in a later patch goes away with
> virtio_transport_dgram_source_allow(), so I think maybe that patch
> should come before this?
> 
> Best,
> Bobby

On second thought, the lock sock does not matter here since this isn't
the recvmsg path and there are not multiple rx workers vying for this
lock (if there were multiple, they'd already be vying for the
vsock->rx_lock anyway).

Feel free to ignore my noise about that.

> 
> > +
> > +		release_sock(sk);
> > +		sock_put(sk);
> > +		return;
> > +	}
> > +
> >  	/* The socket must be in connected or bound table
> >  	 * otherwise send reset back
> >  	 */
> > diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> > index 9049d2648646..296e1fa7970b 100644
> > --- a/net/vmw_vsock/vsock_bpf.c
> > +++ b/net/vmw_vsock/vsock_bpf.c
> > @@ -161,7 +161,8 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
> >  	if (!vsk->transport)
> >  		return -ENODEV;
> >  
> > -	if (!vsk->transport->read_skb)
> > +	/* Datagram receive is not implemented by the sockmap callbacks. */
> > +	if (sk->sk_type == SOCK_DGRAM || !vsk->transport->read_skb)
> >  		return -EOPNOTSUPP;
> >  
> >  	vsock_bpf_check_needs_rebuild(psock->sk_proto);
> > 
> > -- 
> > 2.56.0
> > 
