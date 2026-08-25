Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AC250BEC
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631589; cv=none; b=WCczCwRUd59mByVF443nfSzP57szNKJLeZX+ktnBd0gDZa/xVzVu6k1+AaJAdn6U190tue5E6sXe8tlEMZdA36v+UAvSCicMElSikkfnA7NsYKz5EjramYpLfy4ctI1/pkiqO+awF7DUizFr5cOptFNYFgYUPn+L4KNbs6NTHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631589; c=relaxed/simple;
	bh=llNeTy5OkVlxXqovFXVz7khr9tL1HG0elnqE/XLjfLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B//QPZqmqthjgnC6mB9RHgwudFa0J6Y9sj08sM1cCW8slWFAEVou/d4Cnd5SrrYM7kZV8pMfTx3GTcrZww/6QSt0eHtTtoC9wwwcpIiO8uzMtanhOeC4MkNPESSO2Dhc5/ZDSq46Ekbhox/MZfD8IlnIRdJkIHyle5Nzd6gwJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9xOVahU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9xOVahU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFED1F000E9;
	Tue, 25 Aug 2026 04:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631587;
	bh=iA584joFzzR51GSUiaZ6rKbeJGwcWrqMJMSDh9j68Js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9xOVahUzeKkaXpOVslzx4KjeG4qBV+xsyUZ20n/UsIBBUPfs5Zfweg0ww0xfDgut
	 G60xS55zCNcZtVQV4rt84SoAsK25micwMHkH+wtPtDOfssV//Iz/wZyArBacJohJ/G
	 RagKt3GRfCJUmzyvonR9oq/tQLiOfOghzljkEvtxlkyiMHQ2vS8TT/jHF3ZTKY//dQ
	 9cp0IDOWDhLaQPKnkwgGRxOapmaFDS2Jw5NYkL2bALr33jlydhwXbEcDwntOL9gzYw
	 ZM/Lbjw/j4Pxmpwy+uMEnf0E0zhu7MQkSRdDAB0TPd+KlnEWaaJHhB/VBq2q3e0tmt
	 Ic0r37yPck79w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] mshv: detect and report SEV-SNP support at init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260825040505.826600-6-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260825040505.826600-6-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:19:46 +0000
Message-Id: <20260825041947.8EFED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memory barriers when updating and reading `mshv_ready` all=
ows concurrent userspace opens to access uninitialized driver state on weak=
ly-ordered architectures.
--

--- Patch [5]: [PATCH v3 5/7] mshv: detect and report SEV-SNP support at in=
it ---
commit fb8f9421bc97a7ed49258a973cb3c9b05f5b3049
Author: Wei Liu <wei.liu@kernel.org>

mshv: detect and report SEV-SNP support at init

This commit queries MSHV dynamic processor features during parent
initialization to report SEV-SNP availability and the maximum number
of encrypted partitions. It also introduces a readiness flag to reject
userspace opens until initialization is complete.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -2757,7 +2759,7 @@ static long mshv_dev_ioctl(struct file *filp, unsig=
ned int ioctl,
>  static int
>  mshv_dev_open(struct inode *inode, struct file *filp)
>  {
> -	return 0;
> +	return READ_ONCE(mshv_ready) ? 0 : -EAGAIN;

[Severity: High]
Since READ_ONCE() does not provide a load-acquire barrier, could subsequent
loads in the ioctl path be reordered on weakly-ordered architectures like
ARM64?

If a userspace process concurrently opens the device and calls an ioctl
while the module is initializing, it might observe mshv_ready as true but
still access uninitialized driver structures. Would using smp_load_acquire()
here prevent this reordering?

[ ... ]
> @@ -3022,6 +3124,7 @@ static int __init mshv_parent_partition_init(void)
>  	hash_init(mshv_root.pt_htable);
> =20
>  	hv_setup_mshv_handler(mshv_isr);
> +	WRITE_ONCE(mshv_ready, true);

[Severity: High]
Because WRITE_ONCE() lacks a store-release barrier, is it possible for the
CPU to commit this store before the preceding stores that initialize the
driver state, such as the workqueue allocation or mshv_root.pt_htable?

Using smp_store_release() instead would ensure all preceding initialization
is globally visible before userspace can successfully open the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825040505.8266=
00-1-weh@linux.microsoft.com?part=3D5
