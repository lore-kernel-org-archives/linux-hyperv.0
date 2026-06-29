Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8228C86C;
	Mon, 29 Jun 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714294; cv=none; b=g/IQi/Lt3VGEFL2YELW4eRzLDATEUt+MdMOezIbliY3tLckOi+EPHwc48VPGtw7MJFb8yIin38FCZQYV6TaDpM8uJ8HWgtqG4+PD0g2d0AoY4mFjn+8UqyY02uJbTK6QrvGXab3VNIkZtEmjYnv01HWtNWjST4m7riwqD2MTMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714294; c=relaxed/simple;
	bh=gnb858Rm7GrMh702A4NS8Nje13i23mUpj7S8mCYrx6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwQc7ibKb6hlmKd59IyJA6NJCups4xvufN8cakhw1QONND9Sye5UwMpyB9/2vCac7bsVMOpMzu7x665x3WKq34OXcc8vAh1GVFUcAv9SjIe0qsFW4BaaPDiB7j87S2dHHMmxY5RlZZgzatyUqMdSZEXN+2hi3s5ZeRhQHUrMSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLOAGF/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLOAGF/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEA1F000E9;
	Mon, 29 Jun 2026 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782714293;
	bh=aM/fEHBwOE0lymo4oDwfQufex/DqafXe9rPrJOipAI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dLOAGF/zWXVpvbByDN51dBCN04lFjULPGmO1TrJJXfr9mpg5POkpw+J9O6JKN26IL
	 bOhRyDSpSrJCTjQdC1DcGXd134nSy7sZIy+ylcvZ1LLOsFZRYvOP3d/ETRe6//8CWB
	 hZbMjtCUY551GbR+jYfFTBdHRl5bk7uRPyxGon5mffPtfcCQ3G41mBcpWlicljyMIR
	 QzhNPdP+DAabiI6i6dN1hYKD27A1iCv1Wr/uuNjMKlZ/JOUXBnRkjNFmTPvaL+F7fa
	 i4tVWI+nsZA719wCMn3m9W8SK6A7IQTMrHeu4CJcqN9h9MQGvkZEqCnwomB0AyuR41
	 ec1SdnX1yqfCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/32] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-hwmon@vger.kernel.org, cassel@kernel.org, linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260629060526.3638272-32-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-32-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:24:49 +0000
Message-Id: <20260629062452.8DFEA1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D31

