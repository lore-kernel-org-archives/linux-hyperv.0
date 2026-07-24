Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED89233938;
	Fri, 24 Jul 2026 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934970; cv=none; b=IQRvhAR/V2jyPQNbMgu3US1TrJXOvNb+5BA4m2a50i/OgX3PbXJbT4guR3ny4phxT/XxOyrXy0pYpI0aIOWhPHWDPlorHszokEiy73BgqbKPpYwLYHGwcoCKRpaAOm/K4251ZBWSLUMg8eWtw6RKrTleew7oc09V0L2O3NszkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934970; c=relaxed/simple;
	bh=mZlUvBrixQww5im3DZiKZu9byltt2XofZQxmSZSZnPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AJaQ/WWQE3jQAXwj/wJiVPFYIa+jJ0hn2KtAOYn1xMWy2s97GicpUgC+a4EJFMejZAJVCFqXEux4B+izVsQ6bLlc6OCyLKLDXjV7xGu6H3wVHjKtlb5whOfOTfaWZLP7EqfbFHeo56/zk3WqDquwAzImSv0/iQlOuCfuvdmCSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euqT/Aiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euqT/Aiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092C21F000E9;
	Fri, 24 Jul 2026 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934969;
	bh=mZlUvBrixQww5im3DZiKZu9byltt2XofZQxmSZSZnPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euqT/AiuVk3etYMIh4ykQR+30BoH9iRNtQb+G3+QSeh/kehx0JE64v3+9Sh1trCzL
	 BpHLlMNZROIjbtOzHHN86jprxvXyDHGIPq7CMO9UMQb6Di+ETApGhezQ02DS/qVnG4
	 D+K8UMNAG4wGozzcPK7jLsRNJHnmjLUhLxCG6z+Rj9Rhe5G69jX3iUD53Us0Lo61OU
	 dLm3MMolJzywU4eM8w9brZ+dY7j1yyXY8IN5lcNsgPutRvC5nLE11v0Nx0fJJ3fd6R
	 AWnMqa8ulKxKnaqA+5Uy+T4m1h/mXpBv129zgalU/uF8BFa+akKCpT8/L7nt0mcGTQ
	 fL9ojPVqs/KGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] PCI: Add controller reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260724230844.3259741-2-wei.liu@kernel.org>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-2-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 23:16:08 +0000
Message-Id: <20260724231609.092C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> From: Wei Liu <wei.liu@kernel.org>
>=20
> Some PCI controllers provide a function reset mechanism that is not
> advertised in PCI configuration space. Allow them to expose it through an
> optional pci_ops callback.
>=20
> Add the controller reset method to the standard reset_method interface.
> Prefer FLR and AF FLR by default, and use the controller operation before
> PM and bus reset fallbacks.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724230844.3259=
741-1-wei.liu@kernel.org?part=3D1

