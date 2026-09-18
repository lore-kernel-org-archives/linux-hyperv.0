Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C33403FA
	for <linux-hyperv@vger.kernel.org>; Fri, 18 Sep 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737465; cv=none; b=L4ihgFfrWuT2pla+IIY/6kcqlywamTAmhf3c3BzL0k8GCCWAUflTXU34K0gj8mS32jRF8slbkDbDEMoblsvQM510JTbqApWMsAQPXPEV2oXCTv/NudEUvEuyRlAjDgxSuPwqV78fiDOqu09E3iWKITXKA6L1GfMZX+Jh/Y9O34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737465; c=relaxed/simple;
	bh=kN5BYIsmhqVkXYrS9tG2zrKZRLqVYGZ8zSUbwhKf4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkA1sCvdgctwJDWRjn6KHqyvPJOot/pGdKmQwuHqmHtxCjHzEOHMkX8S4cfFui4M8HVbihyearV+PfGGlrER+z5C0nwOo+KN9kHr5BmRAE+FObuy2S6B9yuO2uIgZq3W0CPij01FTWUqZJC4fXUg1PpRAUUmV9TqglI0Xq1gqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdBLbbkO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3mkCakR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdBLbbkO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3mkCakR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789737461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
	b=FdBLbbkOdGmsje1dko1wRM2HOaUFz/ViIcU3aEwmyyPZGdN4KLKPIEsmcaOzY94LdlJEt0
	7hF/Ypqi4jVQUfUZuL+JNHAClO/KOl+hyhiV6d2gU8HfTw/hhabdNuoYzAVOpaHydn/UT0
	yNpEnDfEIY/slCtLzBFFuT9hcGi4d4M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-bQIUh8w6N9GB_5CRGteMhA-1; Fri, 18 Sep 2026 09:17:40 -0400
X-MC-Unique: bQIUh8w6N9GB_5CRGteMhA-1
X-Mimecast-MFC-AGG-ID: bQIUh8w6N9GB_5CRGteMhA_1789737459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so6264385e9.2
        for <linux-hyperv@vger.kernel.org>; Fri, 18 Sep 2026 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789737459; x=1790342259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
        b=V3mkCakROQjZhk5iskwk3U86uF0A9Jhc3p3EF9nbcE0r9TEQ7hIGbgiqhSbJTy2XKj
         1VHe36U7uEjvQrE0IqXjB5jmCXsZuZ9ZTcDqFapYzboUOZnQmw/RrQeFZbz1DKLJg/Wi
         ICR7z8ljoF2aqG2YZeecKHX0/d01j+JtaFlitadSWv37Ir7grHMLZ0Dz4fqE0Ax64jWY
         aksHCuUan/y18PIbUMS12fQS8O17DLfbUpjTnhEHfShbxqCyqGs8/8x6kAgWc7jsXQNH
         c+cvehETLDvSuH8ObJj5xMAZ3JpcfADZR+iv1fTtmNp05VtZbO80K6iRjRbEZt2juSw5
         veiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737459; x=1790342259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
        b=kcmZOz6/UN4dH965BGMSjp0IX+zVoL2UOkOZt0ajWHbHwppHevurThhbMZqS4lSZ8z
         Ec1TuuPNh4PXcBY62ZBX2mM/doFDPZJEFHhmXlvmN3jYUhfeLUw/XAPTB7Nfiz00YHZZ
         sjARlZ1pnNEHDwxB92Aojmjd5Z3ALN4rpP1Qw+dTQluuCkjcUIVpA/QtbLHRXmQd3X6T
         aXfMQhXZpPgq01Ek4S5TvfHp2rE8CMsn9a3Ti20GSfdWqsodqj1qWA1CCrI42D+kUFTr
         npw5CHmzv66puRQ3mVNSDfLOSwqS/kmDHo6LWD1E/+0oYxnfsLi6NsnjoB01ezrUZgNF
         NtFA==
X-Forwarded-Encrypted: i=1; AKwUvBzFa29Q/i/KFciT/tpWWQ4aGGHuDaBt6NquRGC/iWvnV+F3qbengPj2qK+FXnbPNd9vuTtTQq48rr7A43s=@vger.kernel.org
X-Gm-Message-State: AFuF++lo/HJXaByPCMmcQBfNoxjpwmArI53kVciAj+0Yi26abXou/kAc
	Q7zHxp6lCyqdONKlfzplWOE+/8y9lDFvU1S2gTRpStkjhKDxN3ecqht1uPDq7RKZ3ztBAhRCTJT
	iPO8by/f/+8fRMaKf/dIh4OOmnjLMBHPtpRo0XVQz5JNIQuEeTxkC+Y5Dw7P8/0KrWw==
X-Gm-Gg: AYBFou17CuIpIrJhKUBgsp6L+FLKHYjSi5eM7Bcdd7mFajQzGt2OA9eHM29dDe/fi2l
	9C5f9BjYsZ+q9K4EM/cFCvGsUntktY78e40LFDr+0OHNUS7Zk8CzgR5Bp0R2QjqApQBdCEGDU4b
	qXt09HcTjsIplg2SsSEtF9TGBrUxBS4McNfWawk7uiI3vhoNwLh5yDN4aG0L6MXoIJ10zdffm1F
	+V9QS5MFK9yxh9ZaMpNrXL/AHtzXnvxGrBJJGg05B5xbUQzspDDSwpyLpimbK4ILj8pNUnoAyxB
	wOMULYyUOyaIoxwv7HcFomitzjWWy4Dhm+BZ+xGZ/zvVl9TccBr8L7Hy6SkTD/5w36KWJK5ou3m
	hQKMrkd8SpJRWOwLHqlY6YGQX7IZzGih9sZ3ON4XSkTDdOA==
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id 5b1f17b1804b1-49fc58500e5mr31289975e9.28.1789737459136;
        Fri, 18 Sep 2026 06:17:39 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id 5b1f17b1804b1-49fc58500e5mr31289535e9.28.1789737458692;
        Fri, 18 Sep 2026 06:17:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm155058355e9.2.2026.09.18.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:17:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:17:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vsock/hv_sock: reject incoming connections when the
 listener is being released
Message-ID: <aq05eT6CP9ns6Cae@sgarzare-redhat>
References: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>

On Fri, Sep 18, 2026 at 12:01:54AM +0200, Bartłomiej Dmitruk wrote:
>hvs_open_connection() only checks sk_state == TCP_LISTEN and
>sk_acceptq_is_full() before creating a child and calling
>vsock_enqueue_accept().  __vsock_release() sets sk->sk_shutdown =
>SHUTDOWN_MASK and flushes the accept queue while leaving sk_state ==
>TCP_LISTEN, so a host channel offer that races close() of the listener
>passes both checks and enqueues a child onto the already-flushed queue.
>That child socket (and the VMBUS channel opened for it) is never accepted
>or cleaned up and leaks.
>
>The virtio transport guards exactly this case in
>virtio_transport_recv_listen(); hv_sock lacks the equivalent guard.
>hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
>race-free.
>

Fixes tag missing.

>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -324,6 +324,14 @@
>
> 	if (conn_from_host) {
> 		if (sk_acceptq_is_full(sk))
>+			goto out;
>+
>+		/* __vsock_release() may have already flushed the accept queue
>+		 * and set sk_shutdown = SHUTDOWN_MASK while leaving sk_state ==
>+		 * TCP_LISTEN.  Enqueuing a child now would leak the child socket
>+		 * and its VMBUS channel.  Mirror virtio_transport_recv_listen().
>+		 */
>+		if (sk->sk_shutdown == SHUTDOWN_MASK)
> 			goto out;

Should we do this check also if conn_from_host is false?

If it's the case, I guess we can add that check in the checks we do 
after lock_sock().

Thanks,
Stefano

>
> 		new = vsock_create_connected(sk);
>

