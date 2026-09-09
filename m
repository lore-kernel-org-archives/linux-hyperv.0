Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376838886B;
	Wed,  9 Sep 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946123; cv=none; b=I9LhkEuM21az+j6r+cTJHW/hMwvw0mklv6VS14XV78bfH5GVCAWdmd+f50K8kM2vEx1vjRKGGLveuuBYVq5Hsr1LRV9+hVhw/S3KfTmZxi6H+aG4BgeTmClvksFSOehJczs5tGwTw0aPI+acBRDRySxntXzmJF9FAYNhrNlA7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946123; c=relaxed/simple;
	bh=aLbBfRJEp3WkQmrDf0sL5UEtU0iBuIQVBgcKCZ+7awc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQkPw1W4N3WoGecXBroV2CrvOhWPOYbjKmSOHLbeBdgFpLn3RJ6xf+k4qzHmsCtyvrudjZW9CP2m7Kr8siwv/bt4VagH5RjpkPFTMbjnZpm5RealdQe4+AHtxC0Q5APOKvGpuB25atQgwAOKnArsXuUpFQ2IF+qONh9pzXTnd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAKpJ0Ag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAKpJ0Ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7E1F00ACF;
	Wed,  9 Sep 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946111;
	bh=aLbBfRJEp3WkQmrDf0sL5UEtU0iBuIQVBgcKCZ+7awc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAKpJ0AghOH/HlRGM0QPco4xreKy79RLfvi6V3hNnP+GmIl+rV7B8nfLEJo5VGKj/
	 dDATMbNT8XlvGp06rDYROP+YEeYubN3BEMD1lgUp5cb0HbkJ7KlKsIjIk2HPAUOSke
	 yHHs5/3K3au9fTiUPcGaMvAXpsRN6qZQwBWCEjOwrnI0ii8ifc41zx4WwUuBu4kzet
	 nawIQVO9R3RA320A4lTdT6jWs7Q+8DtsdgR4FpLXP2BIvajFfrSUVCwANZZ4NMVI5r
	 j7btl8CjQTkAg8DUZU3aUuRtDcMb7u4uV+6NeNC9RkSGVrXpP4Vme4Gbie/X50FT0/
	 dx+r2vWBiP3cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] drm/panic: Internalize panic locking in DRM
 core and helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, ojeda@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, gary@garyguo.net, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-13-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:28:30 +0000
Message-Id: <20260909092831.02E7E1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> None of the DRM drivers handles panic locking. Declare the interfaces
> in an internal header file. Move the trylock required during the panic
> into the DRM core's sources.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D12

