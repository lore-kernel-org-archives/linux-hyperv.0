Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED614459AE6;
	Fri, 11 Sep 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131188; cv=none; b=EQ6rfMd9uwdKrjLsDg5w/sH6rPqy0e7R39fPJM4kghpcSD1ss+0hpPXjz12qO8gOjYKH4qz2sckpimBE+AxX2b+jij4JsBaTZNoSspfeMeMxGaM4MV2gdy/L9WYKrzsv0a41doUJ6AFBc7ToyRe4ENoPYNliutwjhfzxUttD/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131188; c=relaxed/simple;
	bh=umlie9Ka1hcJSUZ7ZKyqCNNpcg//Teh+0cvmbB1lL8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lz5Qj9MlQ4eP765yHrWyyIi5B0/7KuJyn2G/di1tjxTvtcod97o4QLVI4tOpvjA+0Sv5LrkHd1NHCR5gFxFbCUZKICeT72v00wCUK0m5l9JfIdjYjUdMp9Fp8ElFifUqQuzQd4VoGUb1eaFsc/6b9kqp7ruigaXMMXaZqFtEFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibpmoWmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibpmoWmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6C1F00898;
	Fri, 11 Sep 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131186;
	bh=umlie9Ka1hcJSUZ7ZKyqCNNpcg//Teh+0cvmbB1lL8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibpmoWmhg+SiRt337t11Ih5xOAS0iJINn7ItR8apM3HUeu2hgGD4ohSs9nXlsjaX6
	 qthWkwyPHE7FpmpzCru6JjLNkKi/GjGaI6EZHUpwyrUMPBB8hTMqd+cUnnu42oElh8
	 JXwKEjaeUN54ZCiYlWpeeONfWrwhM3h2SG/isng4loZwLY6hpg2rfTsU1hgi6Z5j/Z
	 EIlyYAqLoOQ8o1rbRtnGkTD0+r9OpQc4ZsfwmQvjoIuieLwvCKvNtViLTRnKktGE44
	 W3CDXtHNmE2cq5ImiXKhH3uryXj4GvWi5r+3qg/XQN0Cwsw30m5k8gzTN2xV8slrIu
	 ANxs4RS4mzTJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/14] drm/panic: Return -EINVAL if font is not
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev, ojeda@kernel.org, wsa+renesas@sang-engineering.com, intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, gary@garyguo.net, intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260911124540.279841-4-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:53:05 +0000
Message-Id: <20260911125305.C6D6C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D3

