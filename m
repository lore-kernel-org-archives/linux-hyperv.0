Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A582D7DFE
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Sep 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080401; cv=none; b=L0+Zgv7WjOiTcVopDJjiZiiIPwLSCPGncrm6n7Ag8bWyABwwG5a0Erl4EliZR1MTlarHiht9i3n3TDpVnqQuoj2VDkkY6mqZqUU1AbMEMjcyj73I4KbqWcYhgF7PXmCNHm59ESmiRDN0F/IsnHVJStaVPlqe5uDXXB5Qw1kbYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080401; c=relaxed/simple;
	bh=xNKemUhCfIwyBaFE3dn18rH9FQX5gQ/I3YDv1HbBj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAaWwr7JBvpWJDegM55xUl1bhGrGsk3OfDzYn9TNg924MSj+3fcTAFedTrq3zqkogAtT1a6L64F3oss18Z8/eipv/Lhk16rE0aumjJgXswGHQbCT/bCmo3EBNxF4JwnilgY6LOzUT+FNkr0JM8hU7JuS0jevD8+8p1xFBu15pyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzyJucyg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTGLEB6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzyJucyg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTGLEB6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790080398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp/RspYrZJwOpb3gUhpDI38PyXinoO4/BBI7aDbJ9o0=;
	b=fzyJucygqZn4ysJVgYNRGT/X67qefxq+MuWgtjWbaxIyS/dLFllVWzU4VVj5Z4S0+l35bm
	m/3NR/meIv7ZJ60QpL2pQUz0UlKXzsCF78O7l/HZ4uTrhda/L9tHzPvKm2EOcAR3jv5J3C
	WSzRz2/2lAsTf6+aqYrqvYE6C3QRpRw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-XEKeyUGIOtmW5BSxdPtX-A-1; Tue, 22 Sep 2026 08:33:17 -0400
X-MC-Unique: XEKeyUGIOtmW5BSxdPtX-A-1
X-Mimecast-MFC-AGG-ID: XEKeyUGIOtmW5BSxdPtX-A_1790080396
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso36293725e9.3
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Sep 2026 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790080396; x=1790685196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gp/RspYrZJwOpb3gUhpDI38PyXinoO4/BBI7aDbJ9o0=;
        b=DTGLEB6d/+DrFGhsQgrW74/Fx7d9pdj3KXCKaKioczvI73pmlBYMiqv8cuZ0lKUym0
         jFw46evDoQYrf457J7RxAZPYXL5UDZkcTwEs28UQHd/+QXTSBrYjwpRQz+lQ1dxqRk3K
         9wxsTiih9vAh0zKqtsOReAKOV1RtA8lEg1iVJBaH52Loj34Dj8aD4zAOnhMVPImG7JZk
         IMcbyzjpvQUGv7+KWRM8oghM7eC5TdT5Q4ObmPTcHoZkdu3Q4GrHGJ6rod/HuxOI6DCN
         aTswWXjqh7Ndn3+10EYYjrB7vvCmB1OdccFJ0KRxhER2XtNu/9I8uCkPghOc92HHVrkQ
         ZNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080396; x=1790685196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gp/RspYrZJwOpb3gUhpDI38PyXinoO4/BBI7aDbJ9o0=;
        b=n/xprL6vV7lNJVyA2zSae6rJzfKyasyzdzmsC8qpA4UAYXY+jbVSTIkRBAEz3sw3P8
         hH4w5Qqbjsl7iuhZV2kwYuLjWz/bn91UVKrgMBBiAb4J8uXVd8CFmVG9zsHXchSIXPax
         m4C374rfk6cnmOyGYNt/WC1UqZEOD0IvwSceAFB7uOaL3wnsHeU7R0xGQ67QRyFpM5Nv
         Gxy8Av7hKYMwiyzVy8/uUQa3VZs5sUKpX8B21otA7OSJSa5lkghsq48FTYRTUOn54LKA
         bR0z4YzSII8spXHI/CFd7AmkomeMMFQTC9DS8bDXPnmt3lHgH/gbet4gg4+/jeZHmVgi
         +DVA==
X-Forwarded-Encrypted: i=1; AKwUvBz0JDGPL5DO3ONRF9pkwfjM0MeLLciCPbC/ejc+qxAtq+ibXx1+dKD9eB/4aup0CERt/rOhBuOiE4RtCY4=@vger.kernel.org
X-Gm-Message-State: AFuF++lSIcO49YIrqJK647qR3diLULt6Vc760iIkAfSCDqsPmQTPzpVh
	OlzBePG0MS0TJ7jKiRvDjTaT6VkQaGxToCU43F91+ll1f+Y555havOPnWNb5uG77gVQ6cqA4NDP
	vscTTR5EhBW6YhTjT6r8NVXHX7rrVt3bBaqDP9j0EttmwC1K4Ea7GcAc1GhMxKeHQSQ==
X-Gm-Gg: AYBFou00UEASosasFPpYVkaHj+FzZomoiVBrZ8kCuPI/48SD6huQitPMWuPhWxXNUgl
	uH+eM5mGk8TAUep75SxjCJsB93JWngbDsOEyyGchSUYaTJ91DSKGJxB+yeZ89jrtHB/8ZxdzFpw
	swoUwlyvaKAXqZHDmVLZi/flFl8W2PM21iGudUViJnGDCN509D8elfgI3ViJTj6Nxy0PxzKA5S9
	l4I2Co7tb3tiUzsEb41Hq2HKlohc6o9tmYfUfPTPIxSWWwyIOvT1UtxT141obvQ2tcBLr9TzhrJ
	6ZAjNqIKd9YLk7hxdRKQOFCGYWiisFxxJlESiETPb8HHqggMcHMSZyTvv8Ha5i3ZMfVdbGuLyfz
	UIzBqafbP1dGzIfxDIzI8t2ipdc+sDtZMKuCS9uClcZdHs16FXPY=
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fc5671650mr196407475e9.3.1790080395935;
        Tue, 22 Sep 2026 05:33:15 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fc5671650mr196407095e9.3.1790080395480;
        Tue, 22 Sep 2026 05:33:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627314d2sm4904907f8f.2.2026.09.22.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:33:14 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:33:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock/hv_sock: don't finish a connection on a socket
 being released
Message-ID: <arJ0NhXGdCOqRjlj@sgarzare-redhat>
References: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>

On Sat, Sep 19, 2026 at 02:31:27PM +0200, Bartłomiej Dmitruk wrote:
>hvs_open_connection() only checks sk->sk_state (TCP_LISTEN for a
>host-initiated connection, TCP_SYN_SENT for a guest-initiated one) before
>proceeding. __vsock_release() sets sk->sk_shutdown = SHUTDOWN_MASK and, for
>a listener, flushes the accept queue, while leaving sk_state unchanged. A
>VMBUS channel offer that races close() therefore still passes the state
>check and either enqueues a child onto the already-flushed accept queue
>(conn_from_host) or completes a connection on a socket being torn down
>(!conn_from_host); the socket and its VMBUS channel then leak.
>
>The virtio transport guards the listener case in
>virtio_transport_recv_listen(); hv_sock has no equivalent. Add a
>sk_shutdown == SHUTDOWN_MASK check to the common path right after
>lock_sock(), so both the host- and guest-initiated paths bail out.
>hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
>race-free.
>
>This was found by code inspection; I do not have Hyper-V hardware to test on.
>
>Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>v2: move the SHUTDOWN_MASK check to the common checks after lock_sock() so it
>    also covers the guest-initiated (!conn_from_host) path; add Fixes tag
>    (Stefano Garzarella).
>v1: https://lore.kernel.org/netdev/20260917220156.56015-1-bartlomiej.dmitruk@isec.pl/
>

About v1, I see sashiko reporting some pre-existing issues
https://lore.kernel.org/netdev/179003264046.2160803.3176959842906352107@kernel.org/

The critical one seems real, can you check?
Maybe it should be fixed before this change.

Stefano

>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -322,6 +322,15 @@
> 	    (!conn_from_host && sk->sk_state != TCP_SYN_SENT))
> 		goto out;
>
>+	/* __vsock_release() may have already set sk_shutdown = SHUTDOWN_MASK
>+	 * (and, for a listener, flushed the accept queue) while leaving the
>+	 * socket in TCP_LISTEN/TCP_SYN_SENT.  Proceeding would enqueue a child
>+	 * onto a released listener, or complete a connection on a released
>+	 * socket, leaking it and its VMBUS channel.
>+	 */
>+	if (sk->sk_shutdown == SHUTDOWN_MASK)
>+		goto out;
>+
> 	if (conn_from_host) {
> 		if (sk_acceptq_is_full(sk))
> 			goto out;
>

