Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C63AE1B4;
	Wed,  9 Sep 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945530; cv=none; b=ctGmEG9ynzY8vQH8fQoGB7X7JkQTVMEIkwUbhRxxxvjQviM1WFfrliVvAar6oXt/zZOfLi32clTYoDq3V2h20Q1vHgWubFfTAus7RgkXprPZkPxKzjNyIrah+mN6ClBYWXeDqj1n9GES7eNNg9ZiPLjbUqDctW1rlj/juxutx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945530; c=relaxed/simple;
	bh=TxQ1SGVg5bf3+jdluA66EMwI/A8dCOwuitYEA/8Ik30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dGyj3WL3xwdz3QdeYEGfx8DBxDU85WDEhk5KAUQxolguVG2hz12FO2USrI3y841dQABn4MxYEsycpiB2nMn9srxz9J8BCa2nw8wsXrv9TS4SjE7aHumqpB31tG+8s+oYFCdeNNakSxekeB2NBftlrjJtQ+kFGyEzTwL1M3L940I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEdtIu5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEdtIu5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C841F00A3A;
	Wed,  9 Sep 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945529;
	bh=TxQ1SGVg5bf3+jdluA66EMwI/A8dCOwuitYEA/8Ik30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEdtIu5EsimEJjwrs4A1JJMAIrfPyFZtTT4WGJAgu7Qm1RrxfHK9SVCfzLvdjiUhU
	 5Lh32qMVt/PCDMfvbjXQN4JdFt0FW166yKhgyC4AUyz66LJn+liOOgz1jyOsfbmYsy
	 E2zU0RxR4ANnEIfD/A5q6vLhv5/FVhNh7k33QD824d3PvWtqXcORnUlLBY4VpyW0OD
	 Dj9vwi5j4b4h9uopFZtgu6STlFABjJ3u49EpP1oalIocjA5TF48HPEvLgI4gbA1qy2
	 8pDn9KatKk195qrAWPn852P9ilzL4GpOd01NziOmllqOQIBEXOZ39I2btz2Raftdj2
	 5CXraxBTo5LIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] drm/panic: Return from screen_user if display
 is too small
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, imx@lists.linux.dev, virtualization@lists.linux.dev, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, gary@garyguo.net, intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, ojeda@kernel.org, intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-8-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:18:48 +0000
Message-Id: <20260909091848.A0C841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Return an error if the display is too small to display at least a
> single character. If the panic handler cannot display any message
> it does at least not destroy the current output, which might help
> with identifying the problem.
>=20
> v4:
> - also check font height against scanout buffer (Jocelyn)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D7

