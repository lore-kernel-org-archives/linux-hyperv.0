Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5D231A3B
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143196; cv=none; b=nmthtkMDpYLARoEV+8wIwKLp29xZLAckqVaOHyQM0YH7JPFO5ziZgD9MRyHPcBTfHmhWdE5DGxx3FlnkJssH9Y5DgIbcy+AjwLRGXd69A94EjIpughQuFpnmfOXMUOF/S2m3dqZ6MqOlHxdwcgV1Z9fz5DF/7k2oQBr1/oGs7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143196; c=relaxed/simple;
	bh=Ab+fzl+EmUYRMX8Dq4+8YGse2iIOiyHdeb7Pcp6GLGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UT2vfEH+5kMmixy2tJ2gcgojX/iVSbMZ1yYMqDzg+hhKvUtNGuM8ypLtdy4zWrFB3HZ2luUvR7YvvDnMwfik40+ukgWF/z8vp+BMYPqIH22m6lYF3Sm8RHlftVNp5RMQUFo20ePpw3F4Wwa+2LQiMs1xEKBGKXSIfdyDeYJbyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9F2bGKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9F2bGKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A061F000E9;
	Wed, 19 Aug 2026 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143194;
	bh=c98ssoOwKv6nXMTBU4eU+fickvjniB+NjivW3ioL1A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9F2bGKGldvp10hQZcHtnQqIpAxZZg0RFghfgxDfEmjQppWY+x1YasC40zvSN0xK6
	 PBuD/3pgMKx8ummWftPBnNyEe3E67/QCJndHj2wBipaWnbjzgkFHbX0edrLyOcIxqV
	 ho4kayjDom41OMyqDjvWLSpt6Yj0NUrUgQqmmx7yXC5TJJgdF1G97cMcHWQZonAOKN
	 AbgG3TL1b4amr7AN7YMOPImnCOYqMYEuRLyKgjRNB5kPAFtl8YOFOe4wgisEvLc9Pw
	 xKbgUTsNt0H/wvYEvRqYkzRCDf5P7GKVKkhomdCul/6uIoo7WfnheMkPFeta7mibrH
	 tj/DUbsOS8MpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm: drop stale MAX_ORDER references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Xi" <xiqi2@huawei.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260818122408.4182417-1-xiqi2@huawei.com>
References: <20260818122408.4182417-1-xiqi2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:39:54 +0000
Message-Id: <20260819123954.C2A061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Blind text replacement in a comment causes the documented mathemati=
cal formula for maximum page allocation size to be halved.
--

--- Patch [1]: [PATCH] mm: drop stale MAX_ORDER references ---
commit dbb29499acbd8adcdd7b1a04573e7581c99841f4
Author: Qi Xi <xiqi2@huawei.com>

mm: drop stale MAX_ORDER references

This commit renames leftover instances of MAX_ORDER to MAX_PAGE_ORDER across
the tree, including comments and gdb helper scripts, to maintain consistency
after the treewide rename.

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 04acb6791dbd9..1d5bed71d6a7e 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -40,8 +40,8 @@ enum TRI_STATE {
>  #define COMP_ENTRY_SIZE 64
> =20
>  /* This Max value for RX buffers is derived from __alloc_page()'s max pa=
ge
> - * allocation calculation. It allows maximum 2^(MAX_ORDER -1) pages. RX =
buffer
> - * size beyond this value gets rejected by __alloc_page() call.
> + * allocation calculation. It allows maximum 2^(MAX_PAGE_ORDER -1) pages=
. RX
> + * buffer size beyond this value gets rejected by __alloc_page() call.

[Severity: Low]
Does this direct text replacement inadvertently halve the documented
maximum page allocation size?

The old formula used 2^(MAX_ORDER - 1). Because MAX_PAGE_ORDER is an
inclusive limit that is one less than the old exclusive MAX_ORDER, evaluati=
ng
2^(MAX_PAGE_ORDER - 1) results in half the actual maximum pages.

Should this formula be updated to just 2^MAX_PAGE_ORDER instead?

>   */
>  #define MAX_RX_BUFFERS_PER_QUEUE 8192
>  #define DEF_RX_BUFFERS_PER_QUEUE 1024

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818122408.4182=
417-1-xiqi2@huawei.com?part=3D1
