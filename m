Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642868;
	b=NZ3fQDWHNMOMqiszpSpBm3aRBBn0ZYz/P8sw1j9ebE2SHRE4TR5aHHTLK3wXi/OJOrjb
	 9r4+LpZjC9PudRSm3lDKkZ9zkGUhcsTbKC4eln5Ai7u/f0Z4iJngbC/DZAGgGGJ1Hsv8O
	 czTtlDTIgt39IpdP1bwY8rx73nFLMupp7KpnvNR3fuNN3N/CluvMhqxwau2PpRWP1cgKt
	 1CsPMeLzusYDnTgbHlhR8qnR5olvuMzFvK3ur1bbyCdbnXHLqlHGXBY5QoKCgaMZG+Th3
	 3msXEZusEgYOkiF6CgDQ5P1GRra33mR/LvMK9Ym8fqw44DT0o+bGre3VJlQvi+WOi8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jn04HZkjk1heIjWvtSJ7ns4lYpxNnSn4dtsCvymKJxM=;
	b=2+s+a/bX6oCUhdDGFDbGxRX4l6vsDqitsnadi4CNolpGTuYr4kPVZglrUMyY1IKnbxUn
	 Wf/HZfgfjy4d7pcBlLGopJxiR3X7fpATPNzsQrpmM5vGO092ETk6ScHMY7cqgJ7qt3WrK
	 UXGbN4tY9cojtvrldCvSr3AP4lj2YLwWsdumSOz9ZFsfQMCnxsBldoQVTAKifXEaWQEt7
	 CyV52nNX3Tk6+nNYZBwtF1mZHIerVH494rKT//iyqGEOF3Ld2ZyCOjmH0rMNVr6X1JPIM
	 hU7tD6F89Cdi1H2fa9EhP581u34aOi8dVZ9wW9J3L/5BBQu5e06tiiKyofkuiRU1QGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlXEMqgi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA2606A31E
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlXEMqgi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B5D1F000C0;
	Wed, 25 Nov 2026 21:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642868;
	bh=jn04HZkjk1heIjWvtSJ7ns4lYpxNnSn4dtsCvymKJxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlXEMqgiVveGUAGBQNcb73ljoa6uOtJJAuuVtwnOz5NY2XtEVPDX3RpmyhHqdO8we
	 Z7pGMAtlhl1QV1ZlI+6U3E7oXX45YHz1D21akZwEWr/TTRfu+TPoc3q3LDUfanYzFV
	 KM7EqGTx3l/9pG8x92rU9uD+ITL3f8Z4IQAwIQtBAPpwAiP0TPo3dW5ERD9iuG710R
	 DKdvlI/hoXLwRmb2mahLUIvRkusiWb58LkrMEvmOV0Y0N0ekcUiNGiYiuPmHgOEDNt
	 dQlXjJMxDQvJMgOh00XyzNgmRH/UNdtEnn67wjTvxLCbvvLD1HKyGWz5crjHPByEPM
	 ywgi6TlEmZ1QQ==
Message-ID: <sashiko-outbox-234197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] hv: vmbus: encapsulate buffer and GPADL state in
 struct vmbus_buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261124214030.174246-2-emersonbusson@gmail.com>
References: <20261124214030.174246-1-emersonbusson@gmail.com>
 <20261124214030.174246-2-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:41:07 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] hv: vmbus: memory leak in __vmbus_establish_gpadl() on header
  post failure
--

commit 16a8eda5166da158148ed19c9564e3550cf77b17
Author: Emerson Busson <emersonbusson@gmail.com>

hv: vmbus: encapsulate buffer and GPADL state in struct vmbus_buffer

This commit introduces struct vmbus_buffer to combine VMBus buffer
allocation metadata, GPADL handle, and leak tracking into a single
descriptor, and converts hv_netvsc and uio_hv_generic to use it.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index a0883ddf32e2f..9807ff35a1b7e 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
[ ... ]
> @@ -492,11 +497,9 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>  	gpadlmsg->child_relid =3D channel->offermsg.child_relid;
>  	gpadlmsg->gpadl =3D next_gpadl_handle;
> =20
> -
>  	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
>  	list_add_tail(&msginfo->msglistentry,
>  		      &vmbus_connection.chn_msg_list);
> -
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> =20
>  	if (channel->rescind) {
> @@ -504,6 +507,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  		goto cleanup;
>  	}
> =20
> +	posted =3D true;
>  	ret =3D vmbus_post_msg(gpadlmsg, msginfo->msgsize -
>  			     sizeof(*msginfo), true);
> =20
[ ... ]
> @@ -559,121 +562,100 @@ static int __vmbus_establish_gpadl(struct vmbus_c=
hannel *channel,
> =20
>  	vmbus_free_channel_msginfo(msginfo);
> =20
> -	if (ret) {
> -		/*
> -		 * If set_memory_encrypted() fails, the decrypted flag is
> -		 * left as true so the memory is leaked instead of being
> -		 * put back on the free list.
> -		 */
> -		if (gpadl->decrypted) {
> -			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> -				gpadl->decrypted =3D false;
> -		}
> +	if (ret && posted && leak)
> +		*leak =3D true;
> +
> +	if (ret && !posted && need_decrypt) {
> +		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)) &&
> +		    decrypted)
> +			*decrypted =3D false;
>  	}
> =20
>  	return ret;
>  }

[Severity: Medium]
Does setting posted =3D true before vmbus_post_msg() leak the buffer when
posting the initial CHANNELMSG_GPADL_HEADER message fails?

vmbus_post_msg() only returns an error if the synchronous
HVCALL_POST_MESSAGE hypercall failed on every attempt and the header never
reached the host.  Because posted is already true on that error path,
cleanup sets *leak =3D true (and skips set_memory_encrypted() and clearing
*decrypted for ring buffers), causing vmbus_free_buffer() or
vmbus_free_ring() to leak the backing pages.  Should posted be set only
after the header vmbus_post_msg() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124214030.1742=
46-1-emersonbusson@gmail.com?part=3D1
