Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963C3D5C32;
	Tue, 29 Sep 2026 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655248; cv=none; b=adjzSuXTwXoD6xkbxbV6wWGhCsfA00ljBbnszgL0yXK1tR0NaKhGpAEj6OfnABasppBbbNHQ5v2Cbopn5Kyke8XP/OoQH7UPXViNl2WZRHkhll6OAiyaVQ06pLQk3iujH/uwADnKrhk7Ju1aJwU2PcKp/PHetECvLC8S7BuNGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655248; c=relaxed/simple;
	bh=HX6maylGVerN9oJsIKe0FBC8dSSJOcXJErknd4jaT/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMGi9ge0Qr2nn+li2ugNBrVOxBL6bfpY1yWZoghj/2ksclitsleYUa5WmedPe8e0osYm8cEuv3msy24ql/PQFs0B0th4ljA+VX2KJxBiET7+hDdZHZDJzH8ErsmyQXNZ0R3DkVwVOupgRy82fQPVrznd4HrcrGgZW7JjwSGlMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4G+V5HU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4G+V5HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95E11F000FF;
	Tue, 29 Sep 2026 04:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655247;
	bh=HX6maylGVerN9oJsIKe0FBC8dSSJOcXJErknd4jaT/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4G+V5HUxCFS2TRNRBqXlDlpZDJjzbNnSA397bTjzTOmQSRP1BVQXwnlfXY+wyj/1
	 xr6UHNHnzofcI+zuDJBc/TzwXLXoLVI05minNJzvD8TQF/flirCg0xHy4hQ2PTkfG/
	 0fy6cnlXcNXJZW2SGORcwvYuZ5e3JsQhiQSz3tQflCy2RnRtTaGjA3SqNejkKdn40Z
	 pNuXBcSAwJ5yHl+8v3zj2G5/x/bPyh9++Xi+/lZ411lqwkwEfPyRX0YSNYrx5dktPL
	 UEJUxfOCRmvXIZ2aPK0KHQoRc6+g0WQBKn1sNG3vwuz48VlgsecrSquLkXVj/u+Ih6
	 XmQ0tdHJpqbEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] x86/mm: Provide common early memory decryption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260929040256.543767-5-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-5-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:14:06 +0000
Message-Id: <20260929041406.B95E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Static per-CPU buffers must be shared before the page allocator is ready.
> Provide a page conversion callback with common early page-table splitting,
> including the kernel-image alias used by UP data. Flush large translations
> before changing attributes and retain the AMD content and SNP transitions.
> Drop UP image aliases before SNP kexec makes the backing pages private.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D4

