Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791373CEB8D;
	Wed,  9 Sep 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945729; cv=none; b=jLrL+xLiY/vIZjranpisqaI0o726/PxH4j+oFGsCNHLL0RFfccK3eMpOPjbcmkdkK3Dy2kcJ3Q++MM8+ro6pq4POCKlGW32BIKSNcxGrNk9nuO9gT/uSYMBuNc6qCMnwdv/k8oZdKU7kA7Wcfq6rEjF0rAPlMea9Ofe2fPb/CPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945729; c=relaxed/simple;
	bh=v53rzWyS13XTz69Dwg/DhTgxsIt2jqdB9b+1/3rZChc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nd4E6IYV/+7r0tfSfNYyLv5yje5rTVQxA8Ju+GH9Ww9Ypo6eMwZbE1QRxNUJlWmdwz1tOBFbWCGoCUi1sUpN84J8E12HeKzYo9zs3wESpXoi4MolgnpOcIXPXcFKmMHtTg/SmrSAHBpBhD9fEteXarCNibFsRxtgqqAQMj/WknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOq8ErS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOq8ErS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E156A1F00A3A;
	Wed,  9 Sep 2026 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945722;
	bh=v53rzWyS13XTz69Dwg/DhTgxsIt2jqdB9b+1/3rZChc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOq8ErS2hNxgK0ov2PCtLDXn9jYA5B/pm0j81J4vaxkdsOyH7l+Ql+hFiks1Zofg1
	 WlQOwGainPvluwc3ycqmQieNHVffk2rplWRS8ojfNERm7kkhj12YSTj6jW6SQbClN5
	 ktWHVyRh7IM6OI1ELXaQCsr8YsQm0QsbrsQDGPzRqT14bFF4sWnbmUBYKcf03amwUn
	 d33t/EVxXSUG67PJ5UUWqf+NrZcmH3mddV0rYvYGQgmDTBoEPGq94+DrEt7I1XKtqB
	 WzLv5mo2E2Cp/mCTylP6WqXfV1YBVZ0Xn83yesJG9w7b0pfy3IE06tU8G9LvGqU9RK
	 km/QbrN1R/e5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] drm/panic: Restrict to primary planes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, gary@garyguo.net, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, intel-xe@lists.freedesktop.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com, intel-gfx@lists.freedesktop.org, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909085826.64529-11-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:22:01 +0000
Message-Id: <20260909092201.E156A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Restrict panic handling to primary displays. Overlays and cursors
> should not display panic output. If there are exceptions, they can
> be registered by the driver itself.
>=20
> v3:
> - also update drm_panic_is_enabled() (Sashiko)
> - still do some testing when unregistering (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D10

