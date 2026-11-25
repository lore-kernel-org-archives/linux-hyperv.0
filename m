Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626717;
	b=L42+1MLnRRNla41tXhO1FSKVTOBk+nfgcZQK6O9tl4CGROcdDd0gXpiy1JIz74lI5D6S
	 9F7ZyZ3gfWEB5OfxmkF0qHoQyxL9FvSrh3k6H0ABoHZHeWg5xt4e35ZzXwY/VskzzpK/o
	 3ib1/19UQ05mf2oAjpEL1oW9TH5IIlRQne8Y5bqinhGJxByoiw+8UanP5Q0d2IKn6qnez
	 mpeN1ob9fmsHdSscCSNupVAWb58U/jq4Ayd7YKJVWOkyNHP+9zfAy1Gaj2Dm6E5eu9urW
	 LQzvjJWExBwUstH8mi8oGFCrvi9ohMGKXWzSDWOVLpA9NYA1SzjVkUxQlqThArGrJJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626717;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=cGJrLmkDnxkJjZ98IfrTzPg/9sGLBx+/ruRXvM5fWw3Vm3JksvU4Kd8no3mmIamRx63J
	 OnMgUsWO0YGZ5AT36lR0LTpabLawIl8n4clz4IzrGw3o1NFBXxPPSj7fv29cYm83ROXlT
	 d+0Of6+V+h53GjaNfJKhrKkBNnGzEsEmTodi9PLJohZkkJHWzUypI/Lr4f0DxApyHNvwr
	 useHgZubWoId2HXSeykfgX9mMRg3wEDE4WUnzktmHJEvBUAk5wGHZru8bert2v6A0sOkI
	 P1RGDMXcsLBu1zO9k3K3ZpU8ba4EYxznsgLjfiYuni4+oaUMMFQ6/YaGLW8BN14ZC7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gwt1iAHU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA64606A32A
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 17:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA64606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gwt1iAHU;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795626715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=Gwt1iAHUVMwCbOAfvitXOiEYwhojYbZJh0SyOxfUb5oytjeSTyvVWeA6ztn1EgRxVbooDN
	Fqv0zboUdkDdYLi050ws9Pq8lmndcCDT/6Z6LDfElXiPTynVViHflp3jAFqYMW0aIN6Ykb
	Zd2S6/0Ih4yzlLnQd81YDjRNwljUiks=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202--Gh-QKgDOAupMegifOCZRA-1; Wed, 25 Nov 2026 17:11:53 +0000
X-MC-Unique: -Gh-QKgDOAupMegifOCZRA-1
X-Mimecast-MFC-AGG-ID: -Gh-QKgDOAupMegifOCZRA_1795626713
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0bf2140b7so80236227b3.3
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 09:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795626713; cv=none;
        d=google.com; s=arc-20260327;
        b=Wc7wBLb1y42i4WZEFtKRAQIaquh/j3RR15EmNz7esYrt6vULIdPL0lWBMpyub3e2eK
         q0Ca2ub8MDZyt0q2kxWA9Tu75kXYzJab8NwVqn4hi+ptDVa/Da8/0MSY+VwYdWYI1dPT
         4OGHQB170bShwZzwzzYC0UKoG0O8v+F3gxQj2+Y84726XbGEgtS3YihFhCUYwNKSnNDn
         gzPJjTjJKpZWKmC1rn3G1rswkWrN7QKDCE4fEsnMSohSzLyr8A8pkUlG0hactFZ9OOXV
         BkV+V3QgL0wATzfW8ac9es/1xmPqY0eGvYzFR07tPdWQd8yTx2BCBgt8MXC8jBli5+7p
         OZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        fh=fnhlwDhvqix8Qa/UPfYMTBywIy2EOev4cWvvbR426GI=;
        b=B0APwRhnPkyZM0kjm8Z+A1ZnLa3uNRE1fuxM/HNFzNwdwe+vEXp+wOqoZBGfOqtUR9
         NwGjTNoFLAm16gH58uczgyPygUe0pQW8jb33uyFFAHpoZovnVW9cyBRvmWQyDOKQlME7
         L5IN5pkOufX1oRJ6i7hm0D4GBw15GqBcuNApoSC9guW6Sd2Swo0hm9UY07kcCoMAN9Oa
         gcAiS0jCfTlf4t75HzBT1lb/O9pqXUPgC3YX2bO5aAcdB888UUajIsICz0H2gpVE3EV5
         XHqlZ8p/wgsXFa3NWMhRRLt4RTfKCS6Gubt8tCBICC1kxxsNRjn/nbgdW+Xa5vTyf+Ss
         czPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795626713; x=1796231513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=D0wQeWAaebB28+WKLQBSOH4C2jOFLLlSZTlO04f71qF0Aa+Kyyhryv/vMtWXYnbvuT
         k6iAnPClddwWtDpUDuQsaqXT9ZiPmBpetc/POaZJ4XLLpC7W8isgpVShvNq1LTzChtAg
         t0Tq0bZdciT7TRUz1dmRtlu0m94iT7c0k3eQ7hoUgxj+HLNXGhBSpPqGUSo+w38U25V7
         v1iAQAZYAd68wWaGlNRRBkdYB9MYjiJL8VkALML1ApACMyKKVRcChwhC2YrvvKf+Mk7I
         qqCSwS+qUy6ye4DZ1arJuofB1aNTR9ShOI+a0SSfz1P5Vdsg4MabmJ73nWu6B2XzZIaE
         MxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626713; x=1796231513;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=rNbbF30h6/kymAT+LHGl33qmD1Lz1ttJ9krBXsscbHSXkJk3kOVFwEWxCC5vqi53Lq
         lXKJCN5y4Ehjxt2eUOp+zrzXfFB05cJmtqzl9rpomM8ZITc95TVCYB/hSVhX9wPCrhJA
         W0b/1nvyNl3EAF36GDty1Mo7XyvI4nrM0eXpwWzzzsZlYr4uUY6Of0Q2cQKkwmrZBoib
         pHlLJQPzyArcIbYjt7rH68CNGiII7ua8rMjMC/gosm9oUIKkaFZHdiRX/k7jpisn0wFB
         99zgwTP8gWirByfyvz+OM6fpat1H+/YdPH5asepsAo779bZmc8KxxPUdlcJHkQePFVRh
         T/hQ==
X-Forwarded-Encrypted: i=1; AL+hErE9gbFg+4Sp0xzLcyUFANRTduWV4CepBgKk4l51OrwZ7jZx/AYpO8DH9w1yE9wYJ5LeJzM87XBSFWYHRMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8NROTUxH5IAJG4ixZC2m+WsAoAVPlHM2IIruD9Cr6iFYYQiwz
	O5ksPGL11/snuwpgLe15vnCkrf5VcdvQnXBc9EbQ+rm4URYRCacRINOGxhF/M5Efk/Yvq+8uZIF
	TgjHNjOl2OiSP9ULtXdz132iiEgtBuswaPjwCX2ymhtBUvk1zAsVpvRzJKWohFQUa4Iq3meb5Vw
	CNhm2HYEmS0pBw+W/EvsL0sDlDctjtk2lmjQpHnw5r
X-Gm-Gg: AZFdTZddOyagjCEW9d3mEIw7xegfcEeO1w3hNjCdqPeWYEqA3o26SEvJc2MOw7u3nPa
	GRzf226Qa9ty0bIuCBKI53l8HwEsh9J5rqbFFKZthq6Bx97NhK4N7jtjxVrxWBj9++BsNvjYeHp
	BI5eebfaLHCnTvqjKLO5qL8abLcqc8AI4JO4UV38KycSU1jO9/w4KZMxM=
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id 956f58d0204a3-67df44a9f94mr7458645d50.97.1795626712855;
        Wed, 25 Nov 2026 09:11:52 -0800 (PST)
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id
 956f58d0204a3-67df44a9f94mr7458599d50.97.1795626712243; Wed, 25 Nov 2026
 09:11:52 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 09:11:51 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com> <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 09:11:51 -0800
X-Gm-Features: Aa3M54rWhP6JPS6dAHPhCuA1V9j2mDkBDAmNkK_cOM-iU_dy7BMJhibPYf3kF0A
Message-ID: <CAAiTLFWpoZu9ArNVQ_uq6RRQyiiQYvy5=uNVbhpb=6-OBJV8mQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive buffers
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

(I've just noticed I've missed replying to this review, sorry about that).

> On Fri, Nov 13, 2026 at 06:15:47PM +0100, Sergio Lopez wrote:
>> The guest already uses page-sized RX allocations. A datagram can exceed
>> one RX buffer. Growing every posted buffer to hold a full datagram would
>> increase virtqueue memory use and make small queued datagrams retain large
>> backing allocations. With delayed reads, a bounded receive queue could
>> then fill after only a few messages.
>>
>> Define START and EOM flags for datagram packets. Mark outgoing messages
>> with both flags, and let vhost split a message across guest RX buffers,
>> keeping START on the first fragment and EOM on the last. When a data
>> packet meets a descriptor with no payload space, vhost returns that
>> descriptor with zero used bytes. It drops datagrams but requeues stream
>> and seqpacket data for a later buffer.
>>
>> Reassemble consecutive fragments in the guest before tap or socket
>> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
>> incomplete messages on malformed packets, a new START, a peer mismatch,
>> an intervening non-datagram packet, or virtqueue teardown. Require complete
>> framing for host and loopback ingress.
>>
>> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
>> 16 messages of a delayed-read burst. Paired host/guest selftests cover
>> 64 KiB messages and the burst through both a userspace backend and the
>> patched Linux vhost backend, with stream and seqpacket controls. A nested
>> vhost-vsock guest posting header-only RX buffers also passes stream and
>> seqpacket receive tests.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/vhost/vsock.c                   |  15 +++++
>>  include/uapi/linux/virtio_vsock.h       |   8 +++
>>  net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
>>  net/vmw_vsock/virtio_transport_common.c |  11 ++-
>>  4 files changed, 141 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index f4fb2ac732f5..1ff4a9aff907 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 * buffer, we split it using multiple buffers.
>>  		 */
>>  		if (payload_len > iov_len - sizeof(*hdr)) {
>> +			if (iov_len == sizeof(*hdr)) {
>> +				/* Connected sockets must retry with the next buffer. */
>> +				if (le16_to_cpu(hdr->type) ==
>> +				    VIRTIO_VSOCK_TYPE_DGRAM)
>> +					kfree_skb(skb);
>> +				else
>> +					virtio_vsock_skb_queue_head(
>> +						&vsock->send_pkt_queue, skb);
>> +				vhost_add_used(vq, head, 0);
>> +				added = true;
>> +				continue;
>> +			}
>> +
>>  			payload_len = iov_len - sizeof(*hdr);
>>
>>  			/* As we are copying pieces of large packet's buffer to
>> @@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 */
>>  		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
>>  			hdr->flags |= cpu_to_le32(flags_to_restore);
>> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
>> +				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
>>
>>  			/* We are queueing the same skb to handle
>>  			 * the remaining bytes, and we want to deliver it
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 27b4b2b8bf13..e1937f756eeb 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
>>  enum virtio_vsock_rw {
>>  	VIRTIO_VSOCK_SEQ_EOM = 1,
>>  	VIRTIO_VSOCK_SEQ_EOR = 2,
>> +	/*
>> +	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
>> +	 * datagram and EOM marks the last. Both are set for a datagram that
>> +	 * fits in one packet. Fragments must be consecutive on the receive
>> +	 * virtqueue. Each packet's len is its fragment length.
>> +	 */
>> +	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
>> +	VIRTIO_VSOCK_DGRAM_START = 4,
>
> Should this be 4 if VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM = 1?
> Seems like 3 is missing?

Yes, those are bitmasks. But they are also part of an enum, which is
weird and confusing. Perhaps I should prepend a patch removing the enum
and redefining those values in the form of "1U << 0"?

> Is VIRTIO_VSOCK_DGRAM_START strictly necessary? If we just received an
> EOM from a peer, then we know that the next pkt from that peer is also
> the start of a new dgram. We'd have to be careful to never abandon a
> datagram partway through, but for example I think we can just requeue
> the datagram fragment to later retry if we fail to place onto the vq?

Yeah, I thought about this quite a while too. Having START makes the
protocol less dependent on the transport semantics, allowing the guest
to identify an incomplete datagram to resume from a known boundary. I
think it makes the implementation more robust with a relatively small
cost.

Thanks!
Sergio.

