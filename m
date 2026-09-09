Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D03C457F;
	Wed,  9 Sep 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945636; cv=none; b=pXLVmTJdAn2FSEBgVKBxMdacu67hVsOS6WjG40+8LLlA8DJ9nr1KgjyJ3vMCBb1nEYo2dTapN14CgdpoqbxRSiu3zB0mV40v/JT9uuK4ud0YGwc2oKbM/Yo2g0kyaXMjl00UVBi4Qmq0kLNHNiMzuDOd5xn4eRrxir2zl+C0gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945636; c=relaxed/simple;
	bh=/yTpR67LKXqhtOBeQLGNsUk698G52btJcNEw5A2wmjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6jeFRNovALJwf6C6ARgw7h7z/+Kfy51Pi3V/CSt+GQjo7uYIVMc9ZocOlBVpPZZ4MhRZHR/fVEqwv1BjHzgxUIqoYtPd141D12VpgUKTvtE/0XnewP5cOSXcM/Z7vF466UcyB0izBtlU+zTpVLgWeOmXq8x8ZOLY3px6iaKkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2+TeWn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2+TeWn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921B81F00A3A;
	Wed,  9 Sep 2026 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945631;
	bh=/yTpR67LKXqhtOBeQLGNsUk698G52btJcNEw5A2wmjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2+TeWn6s7NBFSMi0P5y2ikuK48WfV4guvChrGbE02XqPWfRerODcA49aTI5wFV8P
	 IrHSQnL9LlFBW/MtL231u5JNHKdIO+bLldiZ42vSZsacsAiacYWwfylowAg00zIeZN
	 fESTZJTQVoR4y87T26drb4PXdebF6AGzaH9E9J7GLuAhVdYlEBoMrz8wu3D/j0knJj
	 bzLw5nkY/UVaumu/cfxw7q1LXNMtV/Ci07eJDXi9/Q3bE6HR85+mXNGFRmpMVrCDB/
	 5OvQmF9Dsn7FMnypdojlY4GI4BFl2MSN+WcbAkFs2yIUBzdc1rQAVpRycLmoZ1/2HN
	 SJFgNxVR8PZ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] drm/panic: Split draw_panic_plane()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, imx@lists.linux.dev
In-Reply-To: <20260909085826.64529-10-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:20:30 +0000
Message-Id: <20260909092030.921B81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Move locking and parameters from draw_panic_plane() into the new
> helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
> there.
>=20
> The new helper drm_panic_display_panic_screen() is now the DRM core's
> interface for displaying a panic screen. The code remaining in
> draw_panic_plane() still does all the heavy lifting. It will become a
> plane helper for DRM drivers.
>=20
> v2:
> - use panic_type argument in draw_panic_plane() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D9

