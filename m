Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2B427FBD
	for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555323; cv=none; b=iy2rDFAkboq/Of+9CRPYtna9UoXJPna81hbCoEqqnIOSKDf8zFY9aMpAwVtWlJPKfw8DAq7jSiV6uMkkQLl5zSathbJFpJ7ew5qr7aj+eKC7Q9pe5FO67M4BBwLVR8USet/uW0OVxhRbtd5kwUwr0XtPldYbzb1dNADOAchLCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555323; c=relaxed/simple;
	bh=vzLkNqYd7qsY+I3O8gZsQMr0QfwtIMdFQiB7BvegON8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhSr1AZEDwvqAT8AjQYH1gcyp7quyzHJfVefFntIyxai0Xq8J6sUtq7vwb09prDlPUashDftkCgxBxyjpiLFeCSIu516YnVS+hL/JC283P2KNqtCJgtVRiN/Ws2MbladaCtzKK32vEKE+1zby8vdH8qm3f/hfqaRlgruU4O1/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GUCGLBrv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GUCGLBrv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso540661f8f.2
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2026 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784555317; x=1785160117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QmCBjNjotMnuERLBel5nv9vg0rDycBvRi24F+jtO75Y=;
        b=GUCGLBrvAETt8bgA4D2YkMP4TeJTtl2Ca43oOhZ4dWq2ENjPhO1L4zCD/Z4UVzYbR9
         sDwgR06kWljQYofId2rztchQP0SHdS1jaL2Z4CzdH4cqi6yUDjafTlHjn/t3k7sc59GL
         HtiPKjIlB3W1yHtJq+bt0ZcWXrVYMMUILgdcRWLW9ohjF+McGZJ6Z2QuaOO6gYbNntR/
         xmBJYjbKGrU0BQrkx/1Y+mOfV+3+wIscp9MJWKGQbbQdzOBja6zgAYDWpyEepVa+WPqL
         GUeNrjEXTnnAACbfEjl2Xt0XOgiLHhPv0v7EtA9pkb3HfUBckdXU9jjhfsYOFK6ygdcI
         kPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555317; x=1785160117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmCBjNjotMnuERLBel5nv9vg0rDycBvRi24F+jtO75Y=;
        b=HV5rxgBQgBNh76v4W++wUfQumd0uCiqeu5ES4aBqvdmo0Ln0hwWk6V8+wQNUg0wzDg
         mbW8qWS2rJSiwoUaPS13iOQkhkpg18BZeu88A0M26e0k+IfuQ8irzhAoRTJYuOlEZe9L
         dYzaLcuDzKB5LTPgf7p1OqIVi86z0E+9KE/CdwqkerjwH8HHNwA23aAwoty3XjG8PCgx
         FmhlglxCrjhvsobhxHz5tyy5nTKzcHaDgvr5RPbEPAm3rz4liMRRX6XYme8wxiiiXlWI
         ZpSVEJcrf7/KVKYhpumNWWRZ58zA/2ueykgT6AdWzr+IvBJEo2m1ZkzU4m2E8+F99Cl/
         soMg==
X-Forwarded-Encrypted: i=1; AHgh+RoCWV7dYliEu1m8bY2YLKVMVAJ3QhK5rFR5ZkGvnGCsoyZi6BPXwbSFBELb0F+a4CRgzHjYkbrrSpAVCpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHImpeVcBlpwgscWaJQG3eCyU7cQn9H+IxDmnYQKZmQfVjo22
	b+hXMpA8Hb1wqVp+7HGCdIMKKHNqX/BaL6+RTWUGkGP1ZQd7xJltqypNAtzAUeEKR38=
X-Gm-Gg: AR+sD11rmNbbK/anzEvmu7A4fSOzcgiUHRn4rs4X9NzNMiOIicJ2xNwCVgmJda93ZDS
	g0b5fnR/yfa5L6WjIDyOuHfR8TeOP6sTdWwAz+66aAKA1SXBfC0vrnfXRfWOZW6VeEk42vUAmyP
	rECXPcQYSGSEshlDncd8vMdatmxeAsJy5jcU/ibSEeDGbhSkEFZUU9kLaBe05d3c7zxHv077mvX
	/NwEgf10o6oI1nXVLBzzPSYqXFEhsG/Tt4pmwfseSjLJURFys8sOeSrLg4EsipVAXHu8aeFI4b1
	V5WST/dqd0exmuA1pcKU3zq8pPO3/TuLP+IQPMrVVDB+RKQlhl/r4eREE2g0yXdO1p5brFmvvGO
	uib/lxx6N9uAH1kjt5rgDjICTGI0sxMUenJu/oXfG0QU5urCsWtuwl7FiNGvXxNpMfY/24q34dd
	vcqL9E0Y4SbLMJ8M48YXzPD9E4ZnxiVILEj+sVT83qllV0CZ8zHh8jeJQeJAmMf55f2g==
X-Received: by 2002:a05:6000:71a:b0:47f:2de3:b34d with SMTP id ffacd0b85a97d-47f6233498bmr16462661f8f.46.1784555316783;
        Mon, 20 Jul 2026 06:48:36 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63edcd13sm29610037f8f.26.2026.07.20.06.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:48:35 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:48:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
Message-ID: <al4m34a1ZG5UTroc@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
 <56983c6a-6459-4145-bf6a-909d2f3ee9a4@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ere6fq2b6xkmdent"
Content-Disposition: inline
In-Reply-To: <56983c6a-6459-4145-bf6a-909d2f3ee9a4@suse.de>


--ere6fq2b6xkmdent
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
MIME-Version: 1.0

Hello,

On Thu, Jul 02, 2026 at 08:45:14AM +0200, Thomas Zimmermann wrote:
> Am 01.07.26 um 19:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > Having an empty remove callback is equivalent to no remove callback.
> > (The only minor difference is that with an empty remove callback
> > pm_runtime_get_sync() and pm_runtime_put_noidle() are called.)
> >=20
> > Drop this useless function.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_drv.c
> > index e766d87b7a9d..e3f41336a831 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -45,10 +45,6 @@ static int hv_drm_pci_probe(struct pci_dev *pdev,
> >   	return 0;
> >   }
> > -static void hv_drm_pci_remove(struct pci_dev *pdev)
> > -{
>=20
> It would be better to call drm_dev_unplug() from here.=A0 With a bit more
> work, the driver can have hot-unplug functionality.

I don't have the "hardware" and thus cannot test. So I won't tackle that
suggested quest.

Best regards
Uwe

--ere6fq2b6xkmdent
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeJzAACgkQj4D7WH0S
/k4kJQf+Oa7xsTZm7Dflio0AOE9QUQev3vXET7Qbxr5n4Pon9N8JnccwC2OYjrfn
maAAVo55m4s6vSSkJJ9JcsDwDl6ZeHu64t2C470QWl934h0XwjusVqUKMpvEAuzX
pJBHoNKWC89wSHuarv1TdzyRfvn/C3DOJrwuWKHwvGzycrTIBfrwZVB6Lx0KNET4
sWawarbS6BVYKjI2o5OcZJXpgb6rIU5hL3Hiseqv1No4vuNH5daig+RrFcw5QyaH
WQg6KKu0PZ8ESc6dsXc2Gg8mrg1exCAfVyprdWTq5bSPd8Py/g1lnWoYl5bD4i4a
TJiHLqHgaDVcKBkgSh5htoErLY3YVg==
=vy29
-----END PGP SIGNATURE-----

--ere6fq2b6xkmdent--
