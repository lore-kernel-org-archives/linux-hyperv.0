Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4223DAAC8
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962914; cv=none; b=kOXdzRjQsXYUBiZTQQW9wxLNnmzB5gL+YTFyatIM2erd+jRm3YOsJhIb9STjbEz4Qy2LjaMnkflSdsJ6UokitwHq+ppIrTRnef2y4CDKblkiktYqTJX3qPzrR0wOW2kOA9VzJaeunaYnq8P6PKCLM9f1RGL3+oEJTbwgsVBdHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962914; c=relaxed/simple;
	bh=/wth0lEXcjh/n+pY2EtvxaPN/tZ78bXVTaMJJ/im5+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5CufeJ8b0Ch6Wd76hwfyfJus4vIb7kIzFuFNFhXs7XJO3ZeTGL75uzD7MPkA+yHmSs0v/EZQYJTTMjv22se2dO2+O4QpnVwDjBvdqT/Q2lc5UpxySGIGI7ZICq7hzwZwkyGIy/J/nnyqnJMoQt76uHK/X6UCvC8CUKcOglaQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl02Je1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl02Je1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430C81F000E9;
	Wed,  5 Aug 2026 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962912;
	bh=Fs34yIg409v9DVmjWJ9T0JBYve6xlEu9ath/SF8rrIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zl02Je1m/PZCezFQFrWY3fYoqqu/J91o7X9L3WhRy4nx0nd660gkHp4Nrhjs+F6SS
	 0PcqAXAKz/m9aVgcs3ZXnAFaFCcBV3TEpOkaWM47R7iWiGFXEqrStw+ZdEV9orcMpe
	 C9fHVlrGNsk0L6hYGWF+84JT2M56K2K/AqpLefnaTac20d8rNjqxEK9Dk4uNG42iPx
	 ANfUVyYgtolibvqISGlMdVoCIqj4segyAiqyjlQYtRFB0GRYc9vJ+ZEXimpXFqbAxV
	 xo7r9OlHlDpzW3XAQ8gRXRqpysaN8pDYkZFa4j+rlMw+1Se0d1d8lpgS1J5Z+/VTtO
	 85K6X1iuLurTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] drm_hyperv: Remove support for synth video
 protocol of old Hyper-V hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805203751.2678-5-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260805203751.2678-5-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:48:31 +0000
Message-Id: <20260805204832.430C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `reinit_completion()` and lack of transaction ID or messag=
e type verification causes data races and state machine corruption when VMB=
us requests time out and receive late responses.
--

--- Patch [4]: [PATCH v2 4/6] drm_hyperv: Remove support for synth video pr=
otocol of old Hyper-V hosts ---
commit d7a97b3cab0a3a58ec215d4c2c173f39a5e2648a
Author: Michael Kelley <mhkelley58@gmail.com>

drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts

This commit removes support for synthetic video protocols from Hyper-V
hosts older than Windows 10. It replaces the version negotiation loop
with a single negotiation for the WIN10 version.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index f0ef627b4898a..1d09bba1efdd8 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -581,11 +559,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
> =20
>  	hv->screen_depth =3D SYNTHVID_DEPTH_WIN8;
> =20
> -	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
> -		ret =3D hv_drm_get_supported_resolution(hdev);
> -		if (ret)
> -			drm_err(dev, "Failed to get supported resolution from host, use defau=
lt\n");
> -	}
> +	ret =3D hv_drm_get_supported_resolution(hdev);
> +	if (ret)
> +		drm_err(dev, "Failed to get supported resolution from host, use defaul=
t\n");

[Severity: High]
This is a pre-existing issue, but if hv_drm_get_supported_resolution() times
out here, is it safe to proceed and ignore the error?

hv_drm_get_supported_resolution() issues a request via hv->init_buf and wai=
ts
using wait_for_completion_timeout(&hv->wait, ...). If a timeout occurs, the
error is logged but the driver initialization continues.

Later, if another VMBus request is made using the same shared hv->init_buf
(such as in hv_drm_update_vram_location()), a concurrently arriving late
response to the original resolution query could cause a data race:

hv_drm_receive_sub() would overwrite hv->init_buf via memcpy() while the new
request is being built, corrupting the outgoing message. It also signals
complete(&hv->wait), which could prematurely wake up the new request's wait
loop, falsely accepting the old response since transaction IDs aren't verif=
ied.

Does the driver need to reinitialize completions or discard late responses
after a timeout to prevent this state machine corruption?

> =20
>  	if (!hv->screen_width_max) {
>  		hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805203751.2678=
-1-mhklinux@outlook.com?part=3D4
