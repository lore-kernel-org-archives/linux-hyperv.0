Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C771345ED7;
	Wed, 19 Aug 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136265; cv=none; b=NW8TQpYb1zdQdsJXHtlS+bw0+f/bhBgSGpwRku6dyKNLioBjl1xy1k5SrXYhrg5M4D1syDuHb4xGmCSPla4nczj4VCSrHaEqeXw/frzQ9mG8CmBTUx/IwbXChPv44TsqUZlYETe+S8wyTvo+FhTSqchuWWoz2g3RBF8mgTI1kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136265; c=relaxed/simple;
	bh=eb42mF16IY8465HCprGPDbeio9qRyf6gNsO74tjklnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=is6ECpUhgpFU1cApnhG/QZYPip0H/OWA3hR8Tv9amB2NxYJL2VfngKPrH5vguCsQvYSCqK/ky6gY2dlTxZwSZtuNa1mZxD3blNPF7QsAZPxfc9IAhiVqA+Tnv2Qv0yWSk+iojLKetJLaDr6pDYRrdRAZ+/JOYEnilKWMlWUqsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMqXAres; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMqXAres"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296E1F000E9;
	Wed, 19 Aug 2026 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136263;
	bh=ey57vTEolivXAyrb04IJdMPT5EBqIxWjHkgX1fQRjcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMqXAres/GFMOupsum4EnVhV94y30XPluIBDR9KgA0WwzL0lRAc+aZVXlW0gBU5ax
	 ScIzejDTtrWrR3FBAA8k5tfPdyyhA8pC3WpL0drA+GXjNFblLhRgweusdiN+6m82ea
	 pZBpanhVlyRLZn+WAksa8tthy7wkR5V9PRG7F/NbvfYwsoSl+M0JYxR6UelB05s7rv
	 aSfqWjebFDQA3ZwNiDDnlBCJ19NXGJu5irgEA8QDEnUPkxGDctiINs/9tX40qOG+uQ
	 Ye8fnbYHlfgZZhXnGN9iW1cLXJCy+p7olKfDYj8pVh2FZo/lpuZLnUtUHUTHmCovUM
	 gYDgYssVpdwQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, cassel@kernel.org, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Michael
 Walle" <mwalle@kernel.org>, dri-devel@lists.freedesktop.org, dlemoal@kernel.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Richard Weinberger" <richard@nod.at>, linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-ide@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260819102314.1499258-13-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:44:21 +0000
Message-Id: <20260819104422.4296E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819102314.1499=
258-1-jgross@suse.com?part=3D12

