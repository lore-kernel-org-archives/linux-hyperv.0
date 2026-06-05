Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D583DB623;
	Fri,  5 Jun 2026 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653510; cv=none; b=BpOrH9nD0pwQ5Dl4csp2FYYB65Cj7wrG0UAUKT4NlC3VvQ8Ea3zuytwSfjy1frKoES/HbfPnLAngfpO7qNrx9jaoks76g9JsGpRgBmK/ICwXAX3m9I0MX3o8e5+qi7IQ5Sqt05PHj8nHcgk+fCl0vzED/AP9kev/tA9gRriTryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653510; c=relaxed/simple;
	bh=BygzOHjyOSVkTSgh+MomBExcBs0K0x/aVyJqUeMqedQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8Xs96oa6OVGzR/+IJ79SF9ZtU8/P9FJukzVcl3Lc5A5vNNqlQ9LR1VevEe8xDllWjb+VhImWZRYIns5SuceuGD0FddoLxxEmvOV969OuHWTVWdAMw1kHulErCMygD4ii435o7Qmb6UOwL57qc1srRNcIsbw6A4QNKC1LqmmZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUSPhh70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUSPhh70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA721F00899;
	Fri,  5 Jun 2026 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653508;
	bh=CfjJRZvGv/J/Gdx8pRfL5H61jiVMi14GAzOli9zBpRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUSPhh70wDXrzWrGJKDhxnwvII7x1SqYku/ZpS+6ADPXdEeaqZc18uHszWCPJh280
	 che0T1v+O23NoDqdvmnUc7c9sBy2r+3s9W+0NNpGUEIA4MVfxh4hIguSyLR4V47Sbt
	 lxSFiVu9VpITT22iTmsUOqsM0gU1YMWhnW/FLQJgG3TSQ96BK9MOyBiCkRrjn3MBFS
	 aoSg91WzqldRMayNZ8ZOlwP1OgU94chS5PPvZG9CcFzCKcbtxAb5AxiKmFT6KD+GeG
	 DQ+svCKtqUeJwyI9Hk/pkWgBx03W72/tnDiHllf9geLlDAw4rNo2b6aDrcaQ55xvSZ
	 8yGnZqGHN7ZDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ptp: vmclock: Use hw_cycles from snapshot for
 precise TSC pairing
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260604095755.64849-4-dwmw2@infradead.org>
References: <20260604095755.64849-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:58:28 +0000
Message-Id: <20260605095828.7DA721F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory read / Undefined Behavior in `vmclock_g=
et_crosststamp()`
--

commit 9639c73bd7986c7a2cf17a27c0bf79db7385ce83
Author: David Woodhouse <dwmw@amazon.co.uk>

ptp: vmclock: Use hw_cycles from snapshot for precise TSC pairing

When the system clocksource is kvmclock or Hyper-V, vmclock_get_crosststamp=
()
previously fell through to get_cycles(). This patch uses hw_cycles from
ktime_get_snapshot_id() when available, giving a perfect pairing for the
device time calculation.

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> index d6a5a533164aa..eebdcd5ebc080 100644
> --- a/drivers/ptp/ptp_vmclock.c
> +++ b/drivers/ptp/ptp_vmclock.c
[ ... ]
> @@ -140,6 +140,10 @@ static int vmclock_get_crosststamp(struct vmclock_st=
ate *st,
>  			if (sts->pre_sts.cs_id =3D=3D st->cs_id) {
>  				cycle =3D sts->pre_sts.cycles;
>  				sts->post_sts =3D sts->pre_sts;
> +			} else if (sts->pre_sts.hw_csid =3D=3D st->cs_id &&
> +				   sts->pre_sts.hw_cycles) {

[Severity: High]
This is a pre-existing issue, but by adding these checks, does this code
evaluate uninitialized stack memory?

Looking at ptp_sys_offset_extended() in drivers/ptp/ptp_chardev.c, the
struct ptp_system_timestamp sts is allocated on the stack but not
zero-initialized.

When ptp_read_system_prets(&sts) calls ktime_get_snapshot_id(), it sets
systime_snapshot->valid =3D false and returns early in failure cases (e.g.,
if an invalid or unavailable AUX clock ID is passed).

In these cases, the cs_id, hw_csid, and hw_cycles fields remain uninitializ=
ed
stack garbage.

vmclock_get_crosststamp() evaluates these branch conditions without first
checking if sts->pre_sts.valid is true.

Although the sample is eventually discarded by ptp_sys_offset_extended()
because sts.pre_sts.valid is false, branching on uninitialized stack memory
is undefined behavior and can trigger KMSAN warnings.

Could a check for sts->pre_sts.valid be added before evaluating these field=
s?

> +				cycle =3D sts->pre_sts.hw_cycles;
> +				sts->post_sts =3D sts->pre_sts;
>  			} else {
>  				cycle =3D get_cycles();
>  				ptp_read_system_postts(sts);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095755.6484=
9-1-dwmw2@infradead.org?part=3D3
