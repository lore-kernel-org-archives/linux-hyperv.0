Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FA3EB0F1;
	Tue, 29 Sep 2026 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706711; cv=none; b=EihuzCrEJ8h3DnSFNn3WzMDA3Y8biBUaNv4dF/PN7fvyDp0JFO8Bwefvql6zRsWSiA3LJ8pXd1Zx15Z+dKsQuAttZj8rMSo9TU0+83LaVbqpsTMKkMuyxYhJXb5LYEHq7Vm+HxwEZlpnXC3AEo0wKOWGgHHpAT4te12c0GUJ5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706711; c=relaxed/simple;
	bh=vX8BTEDBjE/IyVKL2/RLe1gbcZHe0W3sRQHf/1CEbO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AzuOiw6HkGeBuMlNAWWKCBM11LlibYWwr71u/mhDb5yWHYKwo164Xo89ueud9XvWyxMWoODjQxWUESrQkwkHzBqj5A4YCRrE7mAz3QLy7rW8HKd5mFwq5EeONAE8fre/azDA+/QAxkNShH3lihFE+DyQr/seAZWlzQUUVmC1ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5WR2Y4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5WR2Y4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9721F000FF;
	Tue, 29 Sep 2026 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790706709;
	bh=vX8BTEDBjE/IyVKL2/RLe1gbcZHe0W3sRQHf/1CEbO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5WR2Y4mVqmJ3msC7sqlytRy5sT261fKNuwIq5GyOqbfz+fE4B3hwmN+KBk2M0gbd
	 aRhwnOWpoRX077hwaShUrbUCoCvkIcyFBvQG8yoBeiOh89iYDzeiUl/4L0fXhxLhx8
	 Gt6w8mQFuGBRs7TujY1/tYepg8g70uQB6ffawkciOLAmzpnO0uL0bCtUd0o5hw3rPu
	 eFXhFvq8Y96aOEtPJvG34IXhzc/Q6B8mlYYTJ8G/GsDE08Qt4N96gHSW7yclxXgpQk
	 +g7hizG2wtj4gHeOJa3tjxE9rU9rdbAZnBiG6NTP/RQZ2/Lw0rWEhx33L89fIWGz29
	 MCD8wljwkxIuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in
 pcibios_root_bridge_prepare()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929181056.4746-1-mhklinux@outlook.com>
References: <20260929181056.4746-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 18:31:48 +0000
Message-Id: <20260929183149.3B9721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> guest root bridges with the sysdata parent field set to NULL. While
> this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> Support root bridge preparation for Hyper-V") was accepted, more
> recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> device to PCI device") always sets the sysdata parent field to a
> non-NULL value.
>=20
> No harm is caused by leaving the special case in place, even
> though it is no longer needed. But in the interest of overall
> code cleanliness, remove it.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929181056.4746=
-1-mhklinux@outlook.com?part=3D1

