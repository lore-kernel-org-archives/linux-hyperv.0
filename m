Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7247DD4B;
	Fri, 11 Sep 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131406; cv=none; b=LI2mt5Y/za7WmdGI0OhrKCk+J3CTg2b1uWIfHLqN4D91lRKUFi2OWgeJFwfsM9BX34Mi4b6uljnTMnp+uQ+/1WSlImfb4chzIRSl5T6YpiwvmgsGAGPPJqNliZTxAHWLMx/IWfKVq2HF/O1/V/wE1bMHYtXdcTvjV00ZGrPF+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131406; c=relaxed/simple;
	bh=rXhwekFRIFNcSHEsXsELluQd1XAplSrNfZs9RSi5KQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iv6qtbHoE5LcRra8UwSUlGwcaY4powuQAGQGHm4iXfkpofF3/uEH749oQvhDOG4fUnjTgVbRBnOZm5Md7PXn+lpoaKWnY6onQQWbdEdrqtnP8QNIMcHyP2GC8AWhVLxv4wyMJjMuUo66CeDwR7qxSQo2sp9tnIcZe+E4T+xKero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJB3Rulm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJB3Rulm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C21F000FF;
	Fri, 11 Sep 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131389;
	bh=rXhwekFRIFNcSHEsXsELluQd1XAplSrNfZs9RSi5KQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJB3RulmoeFIM3hDilBjEPVJnSV7lfHw7/wf0t2n00Mi7DRMp4XJNUK1rro2v5xdL
	 G74Vga6gfzGh4HRdPQVCEz993XIJgfy39BcksOUmjLupGIhHWqKuny4C4B+THf72Ap
	 7vN+t6D+rnbC9SDifEFfKFOQz1Dq3wWLZr5iTCoT6V0w5neiMz14MzYc0FDhS6EKyX
	 mDvw86keH7ow31N7K5gndEJ62mUdfuP49kroClijWwapcrjfcm4MCEjAXrpyH/NqPK
	 KOV8dszXxMz+T2n8qFSB85Nrdi387XRJuAWMMrGi2PrQZkN2V3E45BQqXPbrBuLMUF
	 9cKZaPKDtz4cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/14] drm/panic: Return errno codes if panic output
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Eugenio Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, Frank.Li@kernel.org, gary@garyguo.net, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-5-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:56:27 +0000
Message-Id: <20260911125628.860C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Return errno codes from the panic output helpers to detect invalid
> panic handling. Avoid flushing the display if an error ocured. The
> unflushed display output might be helpful in debugging.
>=20
> For now, test the result values in the panic test cases. A later patch
> will add support for retrying failed panic output.
>=20
> v2:
> - forward return value of draw_panic_screen_user() (Sashiko)
> - forward errno code from drm_panic_get_qr_code
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D4

