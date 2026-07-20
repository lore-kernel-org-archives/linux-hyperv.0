Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06632427A10
	for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555449; cv=none; b=BWxhYOVqg2g8iqsb/VWaJOAN2cLxrJzqSELkPVpGHf7APWAzyAjQyGPjoI2sUzjkAsGHnEvmAuvZ4RBdZR5G22yA4M9jX+apzbWNnLraP3mmdTRO+r0XcxHcBoSBHGdUtcOLia3D52m1bzcp/xUn7Vyzj0pDbOK4PgA8TbnfUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555449; c=relaxed/simple;
	bh=8DVbCeTyRtwdNp19NwSytzMSLYxtjLSi1mLI2nXn1O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dol8z+l9tTjGFYXrImg5HPqEwurodR4BCyeN9IvqtARCqhdx4OWlSO7AUD1+FZE0pDstflzXoJDLZFWALkAg3jqWtnr7zJqKqZI12gfYlkc91tJzwHdLaj0QbWdzrQ0jh5yau/SCJf7kx8VB1hmXP/kb9RZWO4aVLumeeSiFDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dSDz1Kwo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dSDz1Kwo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49546c690ffso25434045e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2026 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784555445; x=1785160245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DVbCeTyRtwdNp19NwSytzMSLYxtjLSi1mLI2nXn1O0=;
        b=dSDz1KwoLLAGEVRmYNFsVJV1vQl18s4nH3Yp7iua2Xmgocqkbf20WuoUPn+97FAWP6
         T5odcgl7m/NEpRcQzravpsltTGnlIBwgSXssAvMI2z8m0dsHDLZWWxSgKSTc1jITM2GM
         QRV8nhFH1ALAcPx0Yz1peULri0yR77+7n1GQMYCZohsBkp2e3qlanW36L4fhpcrJF40+
         RXXdtsATKsAzAbzj3yS2JTAotj1lka76Z6S+MDafVysWSd/T8exU/WgYtwKTqA0hrsyp
         paKB+y2QZx1KBDDMvV/9A8BDL0Xf5F9tt+Xex8lREJsMdZ4O4urzytv5LhDZz0oWTYxH
         phlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555445; x=1785160245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DVbCeTyRtwdNp19NwSytzMSLYxtjLSi1mLI2nXn1O0=;
        b=V3w+wcPOihG7l//qOIxHe7NJPtNWd9tp+ouuYpDnF7gFxbHrhrLv4WUnc+cIU9qfDM
         yrq6lQgOQdE+jZe5Om7igRUKmoez0hvINBtz9dNlTbM8Od5A1uyOYQTbKhLSASx5Uk8T
         Ijtm2gWyQRNVLJOl8VmPqQQNVw9NJVtT37eYKdp2pOZdixzFBJ4ePAGnl5aOTcqGavgS
         dvdF19tU1PF0XBxGHfoETfextyYAL9tCibDNEZvrQX/q53BGFPGOAXv6s6JJPmAIbeaK
         qXPTKhJOL6z3F5Qikm/BJHpAsSddpPvFm1PAOvXQFDKn8GRm22+bHBlO1gSoPUNNl693
         2+VQ==
X-Gm-Message-State: AOJu0YzO4NBWu6conC4YggoC+2gM2XKLMQenfuUelKEOey8sb9fSbYGK
	NDn+EhaURb6eMOEstuV9p2eRo7/0HwsBmvpqnofM/77yWDDGsODiYclOHhUUosXFuRY=
X-Gm-Gg: AfdE7cm+H/MPxy4VMg7IzhKzitpqpo+/EGbTlZDqmlEP5g5b/tC9lWwMuHua+5AkB3u
	mdUURmKKzpbdyyL8D4CkovoZnKMXGtzyz+nPTyO9ETtumrld4hizrvspmHkUWr8aDo5xrZder/M
	ZfQ28BLT0rCTdgL1zZEznSkfkTLLpilVKk0UwFwvQCp45xNp6Y0QPnWUSD56h2KDGH4b7P4QyJw
	pdCDNHRwdKEWoMPsXzoLJg5UcshOoochBffPxID200IEAIFlAYUYQjRXyXcS9o+aeMffHPk6Dh5
	oTYDQ7z2WRTEIKu5equf7sMgjMJQq8GtzuS3xj84CmVBDidN7aeiuTPQuqUt8NffAdXS8S8h+B7
	0SmxhAfbnGr3DfSqz8Ct8AzNU0fd3DGsjRsjX+xkPRTw4ri5HkNwBv9TY1RO5Vn8yqPf02rcdNs
	RZuLDpZNzOdF1DOgQREmziSN9Dpd1bd2f/5L7VKFVZeWxnqB6GvDx5pYwqjgImlRvbEA==
X-Received: by 2002:a05:600c:4714:b0:495:3f84:a792 with SMTP id 5b1f17b1804b1-4954a3ed494mr165288685e9.12.1784555444675;
        Mon, 20 Jul 2026 06:50:44 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49563e60fd9sm12792045e9.0.2026.07.20.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:50:43 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:50:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Message-ID: <al4ncjnbM58fyYoM@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bnxhjx2ywetn23n3"
Content-Disposition: inline
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>


--bnxhjx2ywetn23n3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
MIME-Version: 1.0

Hello,

On Wed, Jul 01, 2026 at 07:05:18PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> while working on a tree-wide cleanup I found a few issues in the
> drm/hyperv driver that are addressed here.
>=20
> While the first patch is a fix, the issue is so old (from 2021, included
> in v5.14-rc1) that applying the series during the next merge window is
> probably the right choice.

I wonder who feels responsible to pick up this series (maybe without
patch 3)?

Best regards
Uwe

--bnxhjx2ywetn23n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeJ68ACgkQj4D7WH0S
/k4IVAf/UbF3ZUuZ0pOeIM1PofAbO0V+GVHAmpdZRUKVVB/dGoZNleA5QRj1tkhh
iQY670n22CpAnQFeLr/V7T6tFirLKkbsq2gG1xBZSlLRHdVSH6VyCbyYq49RGl6w
GemB8U83rR6YbhXeLRPFxYJvBgC0z8IO1K5ayIlHHaLVEhuDMsdUysIYKkRNBynd
0UpQ910loOMxEVD1m52qL7r+59BTNDwHcz1M+AmJpSN2jmpSb+9B5YJmqUeptbLY
hgKbGFkwD7Vio7+cGNY3RbaAfXEsyNj1Osc/bmJDjuV3W7iC2C58MVj6BeQGgs3v
eCnbtwbUaP8y4VJSrBUk6grj6zVKag==
=Ey1H
-----END PGP SIGNATURE-----

--bnxhjx2ywetn23n3--
