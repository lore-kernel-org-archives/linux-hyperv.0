Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B04D98FB
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870489; cv=none; b=Gt0jjq5OobE77h5GfPP+9m2m3uRT9r/pHZi1MtwPTAL4I0/ri1AGV/ILU+9/uPFfGwNHPlIiqPQ7tUvJx9te7ZhrYNgyyQpt1LC2WTba+fxVHiYr2kStdB5CfDi7A13XBge+QV6u/Lch6HUIRvQQtSVInS8udA0VJ4IWhVtba6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870489; c=relaxed/simple;
	bh=gLzzLUwqtsl8MX2drfZJAZsiaNpTUmiaHZv3NkdX6n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6eRIfiBhICnbGqln48I8LInH0xYk3Oqai6Psbo7ZML1yHHjpt0hbB1EZSEkz82j3gc0NsX2Mg0eObSZORygFymyYqONBAuFgARBjQPgrSxZcmOJOsZJon/aFouA0iKBrkVuSdeqgj1UesvYjEw2xRyVPA/JRNgQcYcuUGSXiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYe9olcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYe9olcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3F51F00A3D;
	Tue,  8 Sep 2026 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870487;
	bh=OszfE7HhWmXZNlRoZkqyX1tiv7ayUw4QBcEm6SUbvjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYe9olcTfcvT40aw7QtAjEZeQsSHqvBMPMrxobYUviq1ujIel9KServhdNx31oVh1
	 RNIdBlKT2hWu93L3Wi0rQvL/BR7zxxQP1cs6zXGM8RH4MevIMlYZN1sjzGwNb2yBul
	 6LLAQDI+l9/qVBjxjNOhzp8Wa2uah0ZfdtHZCKfWt6Xo3mSzmZ2Si2jcq4hG1MMBf/
	 PizUlnqPH+M8st/GwYR6YfNzgkA45WuRvO7tTjkmvBz/J0uq9FgpecKKsPVttexQ4l
	 QRHXYNDAi3eVKLKuRLlWp8LnpSA7xhj1uYb79P5UOfGkfj9MM1/JsaXlWyCsj+c8OX
	 gVvhnC7WdJYWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] mshv: detect and report SEV-SNP support at init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260908121403.1160280-8-weh@linux.microsoft.com>
References: <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260908121403.1160280-1-weh@linux.microsoft.com>
 <20260908121403.1160280-8-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:28:05 +0000
Message-Id: <20260908122807.5E3F51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses the compiler-defined `__x86_64__` macro instead of t=
he kernel standard `CONFIG_X86_64`.
--

commit 25a294afba0df1fc3823f90fe382591fefe4ae1f
Author: Wei Liu <wei.liu@kernel.org>

mshv: detect and report SEV-SNP support at init

This commit queries MSHV dynamic processor features during parent
initialization to report SEV-SNP availability and the maximum number
of encrypted partitions. It also ensures the misc device rejects opens
until the partition hash table and interrupt handling are fully ready.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 42eb81b257092..bf43f1f1e6da5 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -3232,6 +3235,104 @@ static int mshv_root_scheduler_cleanup(unsigned i=
nt cpu)
>  }
> =20
>  /* Must be called after retrieving the scheduler type */
> +#if defined(__x86_64__)

[Severity: Low]
Should this use the kernel standard CONFIG_X86_64 instead of the
compiler-defined __x86_64__ macro? Using the compiler macro circumvents
kernel configuration management and creates an inconsistency with the rest
of the file which relies on standard Kconfig macros.

> +static const char *hv_snp_status_to_string(enum hv_snp_status status)
> +{
> +	switch (status) {
> +	case HV_SNP_STATUS_NONE:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908121403.1160=
280-1-weh@linux.microsoft.com?part=3D7
