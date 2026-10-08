Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95F4119ED;
	Thu,  8 Oct 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445046; cv=none; b=KhfvSGRK4Lc02gUrUCGqUdEivIckgTJnibbEOhyJ7qX6w4XOIUODI++J1ZDO981TAFRnRAidlbu5ZitGD9AziCLCQ6qQhXWIeEmOWxOdk7sG+dms0lp8PUCh4TiroP9bjl9vKb58CLy+oSuGgRwp8FFleDRxzOls2EMMXhCDSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445046; c=relaxed/simple;
	bh=3pGQQisnrlTCh82rt6Ix+M6fpGWmCG47wVBncF6BF+Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=alQl2KC+1UlAHAJiISbJKAUioyw+Vp6b2SNXDtxXuiyxB5EHoexYereHx6o/unp1+Yz9klp5WdxV3oTmF7FYReCsNQpP6EP7auuVPUZVQ0F6P8MYoaMODJm6mDXZNkCAwfPsDKxz9OZ0Yf9+yF/aUj6zdOF9Oaj79sp9UolzAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzInXlkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzInXlkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142191F000FF;
	Thu,  8 Oct 2026 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791445035;
	bh=9nh0eDL8VlS8CbRVuCMsRERyCaNvya5PFxbGvhuNeIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzInXlkke8Pjiz8kPnaLTJkwDXkEhcaqaDyLYDZ/5MFzfgpKx3ciR++cirT1JpcLX
	 gwQxYV7fQuD9fNEE4Xx2/loRWEtR0KqFWXrWU1NJuFU/OzX2tkhY/U8pzEnnv3Y4Xg
	 2BdkWR79A3GXVueJPuhpR7OQ6qbm84FZmXkRtAJW9Byei/z8hpUUFO9om9+eFfafk2
	 YdVi+REpSbfaL5ktLQzov1fEbQRN5rb3XIQW83fBKWEc4xxD8Tz+kY/xj63kOJbPI6
	 m641LiKCzGcjz3JAPLZBLddAI3g8sKY8frhRoT/n0aBsZC6kaoi8cf1zy2bVEdmq1X
	 llKKjP4Oozz/g==
Message-ID: <sashiko-outbox-163770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, dlemoal@kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261008071839.2247074-13-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:37:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D12

