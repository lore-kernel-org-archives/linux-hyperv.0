Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F258CCC
	for <linux-hyperv@vger.kernel.org>; Sun, 17 May 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025767; cv=none; b=lERrWh8Leri63DzWLoBLVU+NCXY6X3jHB/zPNnyefJKh//vkNWhgNMwFTAT8KhvWat/uk2x1isSFxO+p7qsxiLfVqwSAJQTMdpRbQIyqQb8fB8qAZ/vo/A+rJ6LNnTYlPukDv0UKCDhVaX3HG+NnIsrMLs1GAl+SsORIrQDRizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025767; c=relaxed/simple;
	bh=0dIvTCV3A8DdpMF+1/NMUwsIZ+MRKbEAl7miTi+SkjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=px6GE+ZxcEgfxSUrMPEKY+D5AX39fef2QPLuPciU/NnOgv9saGNxgJCBgPHnna5GSt27ZFON4de9jUw8LgimHVwcy5z+dHBtccyAOnsUgqeyuprHpexFU9FK04MN19tfPgCR+2Q5PFjYLk4K3Ql49DD+xArzCobWRTfN15eErFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWHHxuDY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWHHxuDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4179C2BCB0;
	Sun, 17 May 2026 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779025766;
	bh=0dIvTCV3A8DdpMF+1/NMUwsIZ+MRKbEAl7miTi+SkjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UWHHxuDYyOPwdXSlng0uQZwJK1l+Ke9ULQc4IwX3bpYCS9vavRW4NArqSfNB0p9+r
	 mOSBKa1Ym2fWE4zJvK/Ibu4sMpYG8xE2I4nzvoLuGjpi9N7yJukdqGBRBPCrON1pHH
	 F+wCHdFlQturdgj/KTDgJx2mC7cYKhtPZN021Eh/GqXjJBnaNazucMPLPcbvx9/U3J
	 rnjILt3fCZiKj0iu80Zg/UzmxjdNs6bkAeKNdmZ76MaD3gLsXgeoL+wgLs+jVayXlf
	 eRJhAigLywZ+e6aoz76PuPhysdWJJMg/pSOeUtBeFFU6HUDRGJ/CoSQ6MVCH777xwF
	 QWTD0rn26BC/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/hyperv: validate resolution_count from host
 VMBus message
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260517-drm-hyperv-patch1@berkoc.com>
References: <20260517-drm-hyperv-patch1@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 13:49:25 +0000
Message-Id: <20260517134926.B4179C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized State on Error Path Leaves Display Unusable
- [High] Missing Completion Re-Initialization Breaks Driver Synchronization
--

commit 94c5684ae582179bbf9c456d94f6a0bd0f92785f
Author: Berkant Koc <me@berkoc.com>
Subject: drm/hyperv: validate resolution_count from host VMBus message

This patch adds validation to ensure the host-provided resolution_count does
not exceed SYNTHVID_MAX_RESOLUTION_COUNT. It folds this check into the
existing zero-count check to prevent reading past the end of the supported
resolution array.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 051ecc5268321..003bb118d64c9 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv=
_device *hdev)
>  		return -ETIMEDOUT;
>  	}

This isn't a bug in your patch, but looking at the wait_for_completion_time=
out
call just before this hunk, does the driver reuse the hv->wait completion
structure for multiple sequential VMBus requests without calling
reinit_completion()?

If a previous request times out but the host sends a delayed response, the
receive callback might execute complete(&hv->wait). Could a subsequent
request's wait_for_completion_timeout incorrectly consume this stray
completion, return immediately, and parse stale data from hv->init_buf?

> =20
> -	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> -		drm_err(dev, "No supported resolutions\n");
> +	if (msg->resolution_resp.resolution_count =3D=3D 0 ||
> +	    msg->resolution_resp.resolution_count >
> +	    SYNTHVID_MAX_RESOLUTION_COUNT) {
> +		drm_err(dev, "Invalid resolution count: %d\n",
> +			msg->resolution_resp.resolution_count);
>  		return -ENODEV;

This is also a pre-existing issue, but I noticed that returning an error
here can leave the display unusable.

When hyperv_get_supported_resolution() fails due to this new bounds check,
the caller hyperv_connect_vsp() logs a warning to use defaults, but it
skips setting up the resolution limits. As a result, hv->screen_width_max
and hv->screen_height_max remain 0.

Later, hyperv_mode_config_init() sets dev->mode_config.max_width and
max_height to 0. Since the DRM core's drm_internal_framebuffer_create()
strictly bounds framebuffer dimensions to dev->mode_config.max_width,
would this cause all userspace attempts to create a framebuffer to fail
with -EINVAL?

>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-drm-hyperv=
-cover@berkoc.com?part=3D1
