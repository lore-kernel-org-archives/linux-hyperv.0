Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3C47F3B2;
	Fri, 11 Sep 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131599; cv=none; b=qvpkSfx2is6geyQ1V9REjYcJLlc9ItSZsy9w9xJzRH26pK5G429AdX1UlNMWcRVYutv2qyy+CiY1hcAMMrEr/w3+GiTHJVU/ZnIf7XUOZm4rl7/W6iSMgHWp7JwvzAZt7865yj9D75XpD0RtjnET4XN5XUE0o22ll9ba17kO5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131599; c=relaxed/simple;
	bh=RSA3hwWiVAI5e8mD1BhxYsRZcuSF+Yldi10e6XniacU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFvggaufgv7O1vwR7ztZFICtFVNogbhGXWAeR/FBjxlBBrr0aLDPZGvq458b/8+5mDWrLG6/EcPE3Ze7CMO6iaq9Q/Se8uZLcm5T4p0w1rkKt/AvPzaqBhNarUtqtR6UkXzWXy9A+pUlFapwzCROI1mcjM+Ib8wUfpp4lisqrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxHdELyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxHdELyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04FC1F000FF;
	Fri, 11 Sep 2026 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131553;
	bh=RSA3hwWiVAI5e8mD1BhxYsRZcuSF+Yldi10e6XniacU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cxHdELyrmgeHyggNnfNgrFbzttzDwx1l2WQF+TteoyRW3ixuHS786L7eXq/xf4xon
	 LeUQIRv5Fq243Uea7+9aARuhTK1GVqGKN/Lw0oWTxihYgRE0kWa2RxHU6xngEM/lxJ
	 66B4zWPeaegkTl5gDgGGosDQe5ebULIjoCh4n0LdxekILyV4UP13nkvQydEMaat3zo
	 FET2TqZI/PJfrqwuQ0GFk4VvsD9Feqooo5aWIIZR+qVfj6y1QemWz0EsNPZbNVaLbF
	 1DhvVfdgkW3/cfBhhkLolN5aD7OGdSduj/orAFrUhA6lPQ+cm1C1h4F8z4qrOKncFn
	 rNWZ+xMqaFYlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/14] drm/panic: Internalize panic locking in DRM
 core and helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, intel-xe@lists.freedesktop.org, gary@garyguo.net, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org, imx@lists.linux.dev, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260911124540.279841-13-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:12 +0000
Message-Id: <20260911125912.D04FC1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D12

