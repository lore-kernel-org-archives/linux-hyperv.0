Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769513D539;
	Fri,  5 Jun 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653508; cv=none; b=dMBpqysqFQcIyAWgKMfQjlYq1OWM3iQrOj5iz8LCkXku+4zvaUs5ClAwBJ2f2mVRPZo+TAHmVH63L18KwHdX6VM6azdrx3QtmXA6skNQ93XeCpcvMyQ9D4rEFK48mbCbez9k8b/WV2GsHH20rx3nKdH0qZQJf5E8h02zpckPkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653508; c=relaxed/simple;
	bh=uOddUzG+zzL5JxbTdKUA1jUfanz88s0LGygMbkq8Ucs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pf7mUF4Q3ZnfCtKyfAtBAVOryirbpzY9CLF+nt39fxVzfGVeR+x3mgn17WEIvYJScP0TUm4/sPhaPD3ULKm9sl7QF39a0msLplTiDq9iVu1H7PPV6IOQ7SiG4dE8dCBiiF0P+jLBU3kOkMn5rxOy0sUZ9d4gxLBBfTPId+665mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQWJP5US; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQWJP5US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F81F00893;
	Fri,  5 Jun 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653506;
	bh=5jOmDvGTk2h3oNo23blW199InMGaTib2Q7ENMqnQi+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQWJP5US7Hc3taYi7zj3OYrSSw5DJAOWfP6QW/gBmT4qstmWsRf67W3gg6PpBhS/3
	 WJZTgd/JG8LKqm5+vEbvyYTkLLtLROHmZPN+os5LbCnu5vtj+U3j04VF1DMC7WspcQ
	 eiJ6xoHauNp/QteYeFqBpmFHHHIFzk9/sPAAFBOSd9glGZO6TRmXnW2X++RU//veU1
	 cIXi/uN/JB4NHCpRqVxOUbDr6oycPyroCGCvi2HeFR0X6/XFWm7ilLhXS/WRyHvOVd
	 VnAKbUej6SGSTt4w0NiXDYYkahESrpjSclnaJ+kO2BhXAs4tT6AzDoUoJyS3v9Sh+p
	 wijFJxpj/lF7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] clocksource/hyperv: Implement read_snapshot()
 for TSC page clocksource
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260604095755.64849-2-dwmw2@infradead.org>
References: <20260604095755.64849-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:58:26 +0000
Message-Id: <20260605095826.B77F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if `memremap` fa=
ils during Hyper-V root partition initialization, the active clocksource is=
 not unregistered and `tsc_page` becomes NULL, leading to a guaranteed kern=
el panic upon the next clock read.
--

commit fd7e137ffdb89db4afcdcc509ba544a534823492
Author: David Woodhouse <dwmw@amazon.co.uk>

clocksource/hyperv: Implement read_snapshot() for TSC page clocksource

This commit implements the read_snapshot() callback for the Hyper-V TSC
page clocksource. It allows the raw TSC value and the derived time to be
atomically captured, enabling ktime_get_snapshot_id() to provide the raw
TSC to consumers like KVM's master clock.

> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index e9f5034a1bc89..df567795d1751 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c

[ ... ]

> @@ -444,6 +444,22 @@ static u64 notrace read_hv_clock_tsc_cs(struct clock=
source *arg)
>  	return read_hv_clock_tsc();
>  }
> =20
> +static u64 notrace read_hv_clock_tsc_cs_snapshot(struct clocksource *arg,
> +						  struct clocksource_hw_snapshot *chs)
> +{
> +	u64 time;
> +
> +	if (hv_read_tsc_page_tsc(tsc_page, &chs->hw_cycles, &time)) {

[Severity: High]
This isn't a bug introduced by this patch, but if memremap() fails during
Hyper-V root partition initialization, tsc_page becomes NULL:

drivers/clocksource/hyperv_timer.c:hv_remap_tsc_clocksource() {
	...
	tsc_page =3D memremap(tsc_pfn << HV_HYP_PAGE_SHIFT, sizeof(tsc_pg),
			    MEMREMAP_WB);
	if (!tsc_page)
		pr_err("Failed to remap Hyper-V TSC page.\n");
	...
}

Since the clocksource is not unregistered and a valid fallback pointer isn't
restored on failure, will passing this NULL tsc_page to hv_read_tsc_page_ts=
c()
cause a kernel panic upon the next snapshot read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095755.6484=
9-1-dwmw2@infradead.org?part=3D1
