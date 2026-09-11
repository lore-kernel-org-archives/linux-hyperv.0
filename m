Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAF3B6377;
	Fri, 11 Sep 2026 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113475; cv=none; b=mJL48ZZcnDxaeMUtxk3yppZ4DxrOnZNSjjI/dU54HGod/P00+D1jg0/LIspyLUMYnEHyA48BIQO4nTpQK2DR9rz0p0r1p5BdxK2a6Z4qnYQyPXFlH65znphbuRaxFaWhKzo0sXURTQG1Q42C1TNT2fZYaJGl1xmlRt6ghuubKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113475; c=relaxed/simple;
	bh=qPmmWY/0euFm27Pfb4vRNo0g+4mEMN3X9gmWw3ZIqG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0rXFustijECnz8iq5PstOXpjAFUITtvSVp4xPnJDxENjwMimP1qkSDMKPHqBHUQewqBNAmP7B0/ysXong0W5rgyyR46bz7PTtgJ3xGNeT+00sVksDq/K8bclBAo50btbklMgbfnL/4Qpilq5BaHdsy3Bx6759LrYlZ0uFNLNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkm9moXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkm9moXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F651F000FF;
	Fri, 11 Sep 2026 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113474;
	bh=QxvmERiv8BnCYnfAtiHd1dcPkzetSVLeJxzlauqjTNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wkm9moXa2jxQrvn4Mr2qVDQh3XoSd9Rj3/9zB3DCrXkFt57hRrGpHBToJkZ8mGipw
	 6zaVNiipCEEb5NXz60lbBhKjSy31mi9XJDP+3VxGzqEo9vSH2kPOgjvZIv/bokZFeB
	 cVleoWBfD43bVQdABSNw6B5j0AlFN02G/iPNquvqvNmmqHBvW4D3yl6HtZYL/8u1pV
	 RZEdIiFUZfM7/xIAJl1C5OB9GVV2aAxnAuj4KP4Dt6BZ42veKOPhjXHhJ6aHlk5uva
	 g70RZZbbU7O+rAWspTZMAiNh+jjUV5IFtk6rZs22Y7u1c1nfT56int+EukTVA6clif
	 FqzVARrnOBNFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-hwmon@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-hyperv@vger.kernel.org, cassel@kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260911074530.3140830-13-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:57:53 +0000
Message-Id: <20260911075753.A3F651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D12

