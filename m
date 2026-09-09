Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50839658D;
	Wed,  9 Sep 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945463; cv=none; b=GkcfumSCdqX38lOIx9k9nAI1q9F7d0ugeLHs/XgX344dV7CNa2pWpYYxA20MYzKFklXjFtORGsnRbshEn5RtnO0Ecsz9m5mH8pORijcYJ4x1Wb0nwKFzpjat05m48pRTys1Kkv0gztcbf/2BCapUkFV0/9W0DO73jexqLpT8z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945463; c=relaxed/simple;
	bh=M2Xg+0GJnnYkjQOT8Sa7lr2VWKOZ2P++qzDCF237qaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0acgJuzbocvCdlxGi+7gQYbC1/GCk4zwd5eIMzvlQ4NskipbJUwOiRFVRSEv+jVsMOwGK33JwM58X3pHtYtaBiipAIJACOHiyD8MGu+IBhI4mLjli7YTr74U7FzH1/Zabtoqx2bANseAm6OTFUz3dBgSFRTNKufnhtacJNud5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAVjyRLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAVjyRLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4081F1F00A3A;
	Wed,  9 Sep 2026 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945462;
	bh=M2Xg+0GJnnYkjQOT8Sa7lr2VWKOZ2P++qzDCF237qaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAVjyRLfwXziH97gNMGoH6iHM0d+jjEJmSnR4WjvFVu8rbOvJ2AwlZqAMhB64L76R
	 FrnAVmxYjt2NKNbS0pFfZBR56R5QYwajY/CFPP9c87oqHCx9f+YxuSIA6ScFCudqcB
	 VMQmjuODJrPxihzHI8ui7zI+/95xrhNph/n12J0hySyELIpJ1a7iLNiLbib/LlNPEA
	 SBjuah8o/qrndnWFg2QL5TLC4qqV1MPswPVBjmSNEsx0xPY5YaY4JuF39891rkDF6g
	 Xh7iLkxwsRtH7lFHdAletVynoRNmX4kiwfWAP4JX9wzzcDgxxusPIj4RCtJcS7nCZG
	 XmUW4E8CN3lqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/14] drm/panic: Retry in dispatch function if panic
 output fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, gary@garyguo.net, virtualization@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260909085826.64529-9-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:17:41 +0000
Message-Id: <20260909091742.4081F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
>=20
> With the implicit fallback removed from QR-code support, the tests
> cases fail for thr smallest output size (300x200). This is because the
> QR code requires a minimal output size. Increase the size to 494x494,
> which is the minimum supported size for QR output.
>=20
> v3:
> - update outdated commit description (Sashiko)
> v2:
> - fix minimum test size (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D8

