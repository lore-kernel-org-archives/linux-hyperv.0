Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B535C1B1
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313545; cv=none; b=fu73LvuUIt7lGnR0tzjfY+H7GhcEawzBGfBIhxUApuCk4easi3/y9pxzfe11XqTLr2G5PWfkujysKuQAwMqmpkCnkWVEnD0N06O8aPt2ij/aFbWuHC0aHe7+yQIYD6ukUuENguzkSqtRyjJER5EwXXL4OtioAauVVIh9JWIj4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313545; c=relaxed/simple;
	bh=k6FSQdX52F0nEeZ0Qm9KumH430zabt/0yxuRgS9MQDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=epX68ln6HjaATKdvJlXUMllBMiuPqYWwqOzodEcHQzjCXBhja8wwOi4g0if0nvl9PqqJtlJDzbNlM7KbgB11Wskep5YQf4JXQN2N+GDjO0dBQyc9sUFjAxcIMr3/AwrmNWSImXB9kyCpwPOwPP8I6eeQfgRWcHQTh2TDCSHALuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbWbQgsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbWbQgsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE71F000E9;
	Wed,  2 Sep 2026 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788313536;
	bh=ibXhd65kf2eYF5QLBz0Mmx4JMdQlaNboj0O2Wo6dKWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbWbQgshvQ2eZoCWr0hItDhHejyRs1dHTtW6Ru01TbWhBGMcQc0n+83I0Uw8cN3bZ
	 s7G0x7VIho1GhKjwDICykEDfJQ8VKKrRt27np746a2dS9EOaE1+TRGMWFtFRY8F+E/
	 E0gcmuh5aMpGdYwxb4sEr6nmy5LD5AfkZDGSguhN+hn1ktzqKUCUQaT1iSlUY+fXGF
	 X3FIV015Yi7rz9DUTWOmING2zgzXvAXoNiX7nsgw0TufZ9GhUm9feLTtQ2JOe7WQru
	 2dUFyYAZQ8l0JbRecwOfFUWUpdqWEr2U/lJQsW+AvIiqaMVxDkLEbg+pEBbVZ5ECv7
	 YLRHax6J6D96g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 04/13] net: mana: swap queue sets in
 mana_set_ringparam
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901014442.2945689-5-longli@microsoft.com>
References: <20260901014442.2945689-1-longli@microsoft.com>
 <20260901014442.2945689-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:45:35 +0000
Message-Id: <20260902014536.1CCE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a boolean flag (`channel_changing`) into `mana=
_set_ringparam` to act as an ad-hoc lock against concurrent RDMA operations=
. The subsystem guidelines explicitly prohibit using a boolean flag set on =
entry and cleared on exit of a code region to prevent concurrent access, re=
quiring a proper lock instead. Furthermore, this ad-hoc lock is entirely re=
dundant and constitutes unnecessary code complexity: the RDMA path (`mana_c=
fg_vport`) already returns `-EBUSY` when `apc->vport_use_count > 0`. Becaus=
e `mana_set_ringparam` returns early if the port is down, `vport_use_count`=
 is guaranteed to be `> 0` when the flag is set (as the author notes in the=
 code comment). This means the RDMA path will always short-circuit and fail=
 before it even evaluates `apc->channel_changing`, making the flag updates =
dead code.
--

commit ea4e4054a6be8a40258c13cd5a0aa9f21fa11e29
Author: Long Li <longli@microsoft.com>

net: mana: swap queue sets in mana_set_ringparam

Convert the ring size path to pre-allocate and swap so that allocation fail=
ures
return an error without touching the running configuration. This drops the
fallback on failure and returns early when the requested sizes round to the
values already in use.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> +	/* Block RDMA from acquiring the vport for the duration. The vport
> +	 * itself is never released, so vport_use_count stays > 0.
> +	 */
> +	mutex_lock(&apc->vport_mutex);
> +	if (apc->channel_changing) {
> +		mutex_unlock(&apc->vport_mutex);
> +		return -EBUSY;
> +	}
> +	apc->channel_changing =3D true;
> +	mutex_unlock(&apc->vport_mutex);

[Severity: Low]
Does this introduce a boolean flag as an ad-hoc lock? Subsystem guidelines
prohibit using a boolean flag set on entry and cleared on exit of a code
region to prevent concurrent access, requiring a proper lock instead.

Additionally, could this flag be entirely redundant? Since the RDMA path
returns -EBUSY when apc->vport_use_count > 0, and the port is up here (mean=
ing
vport_use_count > 0, as noted in the comment), the RDMA path will likely
short-circuit and fail before it even evaluates apc->channel_changing.
Does this make the flag updates dead code?

[ ... ]
> +clear_flag:
> +	mutex_lock(&apc->vport_mutex);
> +	apc->channel_changing =3D false;
> +	mutex_unlock(&apc->vport_mutex);
>  	return err;
>  }

[Severity: Low]
This clears the ad-hoc lock mentioned above. Can we remove this flag-based
synchronization entirely if the RDMA path is already blocked by
vport_use_count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901014442.2945=
689-1-longli@microsoft.com?part=3D4
