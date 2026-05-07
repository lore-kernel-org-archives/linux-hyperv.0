Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5F38229C
	for <linux-hyperv@vger.kernel.org>; Thu,  7 May 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156581; cv=none; b=XoiwwYV5tFc9x72S4lLnXbfCLLlcVAAzdmaNw/JudMwYJX/cw92lOZmIIh+k5hAibDs4PgpsE7diWIzZ55+rwYtu3OaHN7pHwknKCZx168YXorwPVKSqyQNrKyOM/+MUd5XeIB15DVZ6H4/OaCjuVWHtD1xDqx7h5BrrcDqJm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156581; c=relaxed/simple;
	bh=yXyy/1avikG//9PNJ0NYNRcQ/+6OhcdCpQSlhFY4bVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdw2OQr27hGtXB3Y9LXZXs+7nKeBqcjNKn5HH6E15g33XHkiAv0rxebKDrFpeVYHxtYzfgJFO7kyBZgjVyAwJCSSNchxoqst1TEzaWce3MB1PmuLmkp06F+LFwj9dKxBbtCHNQAe+rNoy8LDPqqVnOrdM6X9RmmSRheCytogkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eE686EVL; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eE686EVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rf6dlxadgragpeknl2zvhwifqq.protonmail; t=1778156569; x=1778415769;
	bh=yXyy/1avikG//9PNJ0NYNRcQ/+6OhcdCpQSlhFY4bVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eE686EVLPG9E3IvxDNMtZPAUgQnZvjYhBtGeYCeLsfCNrwyUOwDYNTExiom1wb1Vv
	 qxf5nbN2AYwB+PjB6b4dqbRmwRB6HO9ooY5fYpYBLWpa0Jrj4sc5E1DnxJYfqEFebE
	 pjq0qImRlNPXZuB/Kjwt4l0RDL2eqGnBDNaN2Fa6Zw9J60dvsjbk8K/SC9kyx70guD
	 zRaMFJ8yT4aNrsf/KcU9MiDUzcCrQfOd+3neh79Rt+4WHcxEvs/Xro0+zBG7mfowTX
	 HKw6d77yk6g1BGDajPKTBLEZHfo54YyENhNsf1cmjFijEBhEN7yZf+DNbhP37d96Ie
	 XL4adMF90c2LQ==
Date: Thu, 07 May 2026 12:22:42 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Aditya Garg <gargaditya08@proton.me>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net, paul@crapouillou.net, zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-mips@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/10] drm/appletbdrm: Allocate request/response buffers in begin_fb_access
Message-ID: <G66ElwoYASE3O3RpWWuKm9V5LNUTUtjJ_lGUsDxN3EujU3wsp3vpT-KcXMsrFfYEZkBwq9TNaD3Pc2g4oaueu4B-JXN3PTCoNGY999s5WHU=@proton.me>
In-Reply-To: <20260507075725.29738-6-tzimmermann@suse.de>
References: <20260507075725.29738-1-tzimmermann@suse.de> <20260507075725.29738-6-tzimmermann@suse.de>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 809317f98a9202275d5c4ae88ce01ca05792218d
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, May 7th, 2026 at 1:27 PM, Thomas Zimmermann <tzimmermann@suse.=
de> wrote:

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>=20
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Aditya Garg <gargaditya08@proton.me>
