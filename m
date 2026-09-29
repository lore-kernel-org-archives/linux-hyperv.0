Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96D25B090;
	Tue, 29 Sep 2026 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655127; cv=none; b=R3VnQlAtn90CuVbNhak5xXvYhBkua4krggZbiQ5DziWKIFf71XBbj5bZALe+EFIExOOCICXIMx1mbY0QeypsdtaOnq9c/upV7SiOB1GdK7uzOB/1yFJkjwYZHRPEJC3RlgPyVJZ68xi5P1sogmEF86iDcdZ4t+KXIxeWSrDcW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655127; c=relaxed/simple;
	bh=npHGsqWZTplgDELOGEx0zlONRg86DiDb86H4YQ3VFfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIOZ0cYz6DhiQ38YAUOFW0F5GApul+UwMWVIHNY+wtM5abQ6Dbmzd1AgTkDHi19/UvBU7HjgVgZJ7i9HDlbod2vp4QfwqyvPPcY7n+bT3Bdhy49p4nUzqp0mP+YAmxhO3SpD67SE9mFawEh9g23b+n3MdizUuL6EKWeQDIdp68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxhXU2Ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxhXU2Ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AE81F000FF;
	Tue, 29 Sep 2026 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655126;
	bh=npHGsqWZTplgDELOGEx0zlONRg86DiDb86H4YQ3VFfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxhXU2RoEVCAuO55TPgEBtqxThC1bnbhJE54ZgItDSLupPXM8muWMkTng2Dh+xDEY
	 FIBUpcCKIKm9HntBPGZKVH/0gPX5Q46Qn1lu0gmQNk72LUSSBBykdpqadeurDPA17z
	 5woltLUEUOwI3zONtS6s+TiRsXI/0d02sfukquu3HVW4KDJ7852756/V9DTMXaWSqT
	 vN8jS3L9ad6P1Ks3Xg+3+q9AVUZlIRwXbWDBu6B2zDgNhF1UZyyQQqiOBtHRIQRkLt
	 NyGQOQd6nh+nQbi5nPcdDfiQz3SqamK67XkIvK1DLDqwIFWkA4+tudO/QRId/zRrQ4
	 qZEOxREfiL7xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86
 encrypted guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260929040256.543767-3-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-3-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:12:05 +0000
Message-Id: <20260929041205.B7AE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
> definition and placement, and provide page-aligned boundaries so the
> architecture can convert each CPU's whole section before registration.
>=20
> Define the boundaries in the SMP template or UP data as appropriate.
> Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D2

