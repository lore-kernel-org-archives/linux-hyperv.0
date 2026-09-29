Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E7390985;
	Tue, 29 Sep 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655274; cv=none; b=pI3+ZfUJ4toDL/OP9XIjpv0IsrN9x82BzX3sqnGfkwVDYmOXvFsWFBQw9HwjT5dzUgqHBcKdJXXfTDcLV83+5WBn0Bz3G9sLk5kSy0lmEK6fxgVSu6gY1/UWhofHNYCqD3hB8HEe6kl3WXPH214rKEIs7q1VVaOSbA39XhL1Qhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655274; c=relaxed/simple;
	bh=R9A3N+G7NkPWOa1bq+bzwUzYvsGB7Rc6nye+IUPycL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQVvmQCQoK7zcnI7Ax0oYo72Xg5s8ueO3C6JJibmGI+Kv1DyvnScIE0Dd/D6VoeS/mok7OPl6GFUEVnJDa0LCvuCEmqWuBNDrE6m87FvcGOPD2Ti692e5azRW7kuRz72ntsEFSnY3kw716g4DzBHA6KapVSmBN7Y9KlAJ4Adops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqdjNY/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqdjNY/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A1C1F000FF;
	Tue, 29 Sep 2026 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655273;
	bh=R9A3N+G7NkPWOa1bq+bzwUzYvsGB7Rc6nye+IUPycL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZqdjNY/wPfrFkvF3sKtMCNJZwkHurfD818YImFiZmaGRxvbspQulN6cn/0nyOR7TW
	 7OxJQND/C97kFRZVhm+neDp5IbZ63gORNy27pNaUdeVJu2VLDncBxQme5M0VyZv7uK
	 zcOIMOdq7FW1Lu1jXfoDc9VYQfABh4lvOHN6II8z/K1Lc6VgYnZ4y+qzcKLVBKJerU
	 rT5qmCHmjfBICfYYQcr+RwnuytwDrRuKzY0umE7fgtGZi4rmEBb9hUkJMO5BbrxonB
	 5S57DNIs0HD9BV7ofa0HFTNO0GXKW+F1FiKF2NX2yr8Iob538GLOkMLSD1x9u77kIv
	 IbpP+PVNanwug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] x86/tdx: Support early sharing of kernel data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260929040256.543767-6-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-6-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:14:32 +0000
Message-Id: <20260929041433.25A1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Share pages before the page allocator is available, after both their
> direct-map and kernel-image mappings have been made shared. Preserve
> initial contents in a private scratch page, matching the AMD early helper,
> and use the existing MapGPA path and shared-page accounting.
>=20
> UP per-CPU data has an image alias. Drop shared image mappings before
> kexec converts their backing pages to private through the direct map.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D5

