Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568623B8D48
	for <linux-hyperv@vger.kernel.org>; Sun, 17 May 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027462; cv=none; b=sG7JUz6TN352Iu73yCe9oy29lr1iOSTsYUVr65RS30eYbOfaIKN7rZ0hUcSOntw72NnRqjiQQKJprWvAeqbs3jF5lXmqJqGHnvNNiWMTr0C8ACBMs9YGEUAjttQHxNQ/oIUtdGsG92IN0qoWZLr3Tkv9JufqbIQtCE6uZ7LIXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027462; c=relaxed/simple;
	bh=lj4mgVq0N89LVQOuDJLmN3hu0aSBHuOK/aEwhXaU/Ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2SkulcAvk/dIeGSSEMHoE+Exu7hMSVMjVcO/iSYD//ARQFsoVgnz/7X26rcEkRVoVWA1HwKDUUlkX+5URBh+2T0eOml/6JutIq5zjc10fOBckg7iI+YHyuaRw8UTgA1Y3qx61CauaqtCF4VlnPYUn+LbvBXR58WcnqqokwTPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeD5phGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeD5phGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A9C2BCB0;
	Sun, 17 May 2026 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027461;
	bh=lj4mgVq0N89LVQOuDJLmN3hu0aSBHuOK/aEwhXaU/Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AeD5phGLFA+043HvtLOWKg7YI0F0G5oyANunYMqU3EJzWT1zdN0t5xmgBUhXNd7u4
	 bv27XlSQOLcdBnblc6zpFpK20KgMqFWRUNgvuRgtQh8UgfD5OwFGEtBoPUMgIiSB0u
	 LYrrNkIAfXNmoxtqLUyC76Nj31akuH/k+KKGBZjZUPn73A+C0tay1MA57r5kKdkApS
	 M9yV1FccDVg0qI3S+4OxuqFBHDACp29s/sj3j/ZQwjC9LxC8vvnMQpA2KQqs1gCsEh
	 7gq32iUHACLRIB8S/4PBgElek3INpfbGi9nDYC+dPWXYXNG77cDkdYsmIvqwmSh74R
	 ORAhy9UjRmh3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260517-drm-hyperv-patch2@berkoc.com>
References: <20260517-drm-hyperv-patch2@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 14:17:40 +0000
Message-Id: <20260517141741.4D4A9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete payload size validation causes wait-completion handlers=
 to read stale request data, allowing response spoofing and invalid state.
--

commit ffe1d9057aa46275f644c2e152d0e7a9e8837c3b
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate VMBus packet size in receive callback

This commit introduces bytes_recvd into hyperv_receive_sub() to validate
packet sizes. It restricts the memcpy length to bytes_recvd and checks
payload size for feature change messages.

Cc: stable@vger.kernel.org # 5.14+

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c

[ ... ]

> @@ -420,26 +420,35 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
>  	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
> +	size_t hdr_size;
> =20
>  	if (!hv)
>  		return;
> =20
> +	hdr_size =3D sizeof(struct pipe_msg_hdr) +
> +		   sizeof(struct synthvid_msg_hdr);
> +	if (bytes_recvd < hdr_size || bytes_recvd > VMBUS_MAX_PACKET_SIZE)
> +		return;
> +
>  	msg =3D (struct synthvid_msg *)hv->recv_buf;
> =20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		memcpy(hv->init_buf, msg, bytes_recvd);

Could this change introduce a regression where a short packet leaves stale
request data in hv->init_buf?

The patch bounds the memcpy to bytes_recvd, but it doesn't appear to valida=
te
that bytes_recvd is large enough to contain the expected response payloads
before calling complete(&hv->wait).

Because hv->init_buf is used for both sending requests and receiving respon=
ses,
a short response might only partially overwrite hv->init_buf. The payload
portion would retain the outgoing request's data or zeroes from the pre-send
initialization.

For example, when sending a VRAM location update, the driver sets
msg->vram.user_ctx =3D vram_pp. If a short response arrives, the payload is=
 not
overwritten. The waiter checks if (msg->vram_ack.user_ctx !=3D vram_pp). Si=
nce
vram and vram_ack share a union in struct synthvid_msg, this check might pa=
ss
against the driver's own request data, allowing a truncated packet to spoof=
 a
successful ACK.

Similarly, in hyperv_get_supported_resolution(), if a truncated response
includes the resolution_count but omits the supported_resolution array, the
uncopied array memory remains zero. The driver could parse zeroed dimension=
s,
setting hv->preferred_width and height to 0, which could propagate to the D=
RM
core.

Would it be safer to have the receive handler validate the specific payload
sizes for these wait-completion response types, similar to how it validates
SYNTHVID_FEATURE_CHANGE below?

>  		complete(&hv->wait);
>  		return;
>  	}
> =20
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_FEATURE_CHANGE) {
> +		if (bytes_recvd < hdr_size +
> +		    sizeof(struct synthvid_feature_change))
> +			return;
>  		hv->dirt_needed =3D msg->feature_chg.is_dirt_needed;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-drm-hyperv=
-cover@berkoc.com?part=3D2
