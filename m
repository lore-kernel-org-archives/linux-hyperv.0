Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646222C21F1
	for <linux-hyperv@vger.kernel.org>; Sun, 17 May 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030822; cv=none; b=IrFn60Qe9RguM1zeXXi7kKlceFvQ2+4saQEJyR+UTt7NS/Moi8x+tTOTuI7euNsPgt/dMKY7r+ykRUt/HpoMKwIsOAqwLr7i1lraW62LcyG/Nozud0GfQflMnrXvbZzHY/6zi/+QdSpU6FsRDR/Ypad807m6PUMCH2CLlsHuEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030822; c=relaxed/simple;
	bh=3GQUQrorKzXNEOSJEXy2/EJJiyr1VX4PqPYCju9RbfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VN73hfX8F/Wd66mTYtWE7eAgLypDehRdt/iFNcgt4vvEmYNs2gdLRhEHiwAHh21p8Vxa996Wn59pXtmdIhEQ5vnyiohUC43o40bc7WBOAx28uvMtWI7+RuMQa+A6IH3At9BRboeM20wJNq2AN4/bPzU0VD4G9EqcVJW4sa+Jo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIIybxE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIIybxE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18DC2BCB0;
	Sun, 17 May 2026 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779030822;
	bh=3GQUQrorKzXNEOSJEXy2/EJJiyr1VX4PqPYCju9RbfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NIIybxE1rH/Jzz6XF89NJzV6f5ummUeTsR/nY/TPdKNhXdII2Um1zEUZJwN0eIgWZ
	 2nrU8p7IKeg91sm8AC5uZosHWxGq2s3inqku0k1FawIH2beu7SUHvUrwsu5VTo7xdR
	 rfb6Digb1WPgBTLLr0hQnWKsScY1+1rppj0FvMCVoyQn+87jsP2/BrUCZtuf9YcAu6
	 x5jI4cqJBkDcrXiIHi3iVq3zLoNm+dxgNpGSmX0KlUHbgjFtdNl1KnL+C6r7TX7a+J
	 sHhegPrhSEp+kg5LqBrB7QQT0fmZFrUJatVIVnf6msWmcj40Hm2RpxUJTXJ2L9acdF
	 qzoOVmGVwmt0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in
 receive callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260517-drm-hyperv-patch2-v2@berkoc.com>
References: <20260517-drm-hyperv-patch2-v2@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 15:13:41 +0000
Message-Id: <20260517151341.DC18DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete validation of synchronous response payload sizes causes=
 state leakage and deterministic false success.
--

commit 31b0cdbb563323a78bd6df8c18d507462a03a084
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate VMBus packet size in receive callback

This commit updates the hyperv_receive callback to validate the received
packet size before processing it. It ensures that the packet contains at
least the message headers, passes bytes_recvd to the sub-handler, and
uses it to bound the memcpy for synchronous responses.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 3b5065fe06e46..cdab4895dd404 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -423,26 +423,35 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
> =20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
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

Is it possible for a truncated response to incorrectly report success here?

Since hv->init_buf is reused for both sending requests and receiving respon=
ses,
and their structures alias each other in the synthvid_msg union, a short pa=
cket
would leave the payload section of hv->init_buf unmodified.

For example, if a truncated SYNTHVID_VRAM_LOCATION_ACK packet contains only
headers, memcpy() will only copy the headers. The request's vram.user_ctx a=
nd
the response's vram_ack.user_ctx reside at the exact same memory offset in =
the
union. Because the payload in hv->init_buf is unmodified, msg->vram_ack.use=
r_ctx
will perfectly retain the request's vram_pp value.

The waiting thread checks this with:

	if (msg->vram_ack.user_ctx !=3D vram_pp)

Because the memory was unchanged, this check will deterministically evaluate
to false, causing the driver to proceed as if the VRAM location was
successfully acknowledged despite the malformed packet.

Should this code validate that bytes_recvd is large enough to contain the
specific response type's payload before copying and calling complete()?

>  		complete(&hv->wait);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-drm-hyperv=
-cover-v2@berkoc.com?part=3D2
