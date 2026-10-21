Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566291;
	b=udKLnmkSyrWGs6UGFftolGIe/R22I/qrTucbAbkmfIlanqlOVfu0cPkfhgXsPivJn7Mr
	 2SUNFNpQOk/q+PQ9Ft6C1H0sXkGYyzkN91lfr1fKrRoqzBqz3MZ7PiT0IQ4iXzhRp+KHu
	 hPGjYI23MyAjgqH2X9hZTR7hG//KgaRrUksjB5uGDb5YsJ0V8WHqAakgtfzioJ9l43YhR
	 nvmWjvONLau6hIJdE21UKtzSz28IoGeYbRp+XnEkhSylXORLvE6wH13LhxoKMFTwXe5kF
	 NWuwJLS6ziMqt+R8Yw+rRj9bJm2LaZ4DAL67ppHlahFo1RQJHqGU01LWZf39h8tIYCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566291;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zDjpm/149iKkzGXPRUz3PfYm6wk52G43lilXI+OIJ0k=;
	b=sBnT+xuHCgxXtDqjwGFnwxPyrvg1C1LvI/S9pvaoSnbGEaahZgJ5N5D6d6BgyGRmMTZj
	 SHNh2V7zEf2Y1wVIsAVP0Q+UAiaVpH/E7JX9/XR5kYtEtkAuRBhi0DX503PraNc78ytKC
	 6y/uU1QJPnHWIww+xGtiPV2b2k8O2nkAWeIUww0tPabsxpnQagoSFZZjc9ZcRqlEgo3XW
	 a1DZBY2npQpHiA8giXjM6KQ6b6cUPOJWW/ORtEen03g6gpR5yLURiML+06nSFpJZaaNGq
	 BGCBW1zPZo2NdZI2uYLjI0yHQJqOzmLS58D66Lsu1XcQ/DJ/KngvRhMnV0SOydkjC2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2UsvbCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B44606A319;
	Wed, 21 Oct 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2UsvbCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9031F000C9;
	Wed, 21 Oct 2026 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566290;
	bh=zDjpm/149iKkzGXPRUz3PfYm6wk52G43lilXI+OIJ0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B2UsvbCtnwmrpkgD4PNMKuakLy4+xvxTrNhmi+xxtjfKv6caIl7bQpqZR07m9Y1V9
	 vI5HcXRSen1yzeu7PnKh9wSIlDF3Vs3y0Gb5/LbDEliYcTTP22d7r96kPCCl1w6kVm
	 bY39LbNdO3U/I3niOch95KB2m6XrdwXDkzm+s+xvoTXu0KOIv7/MIazR+GkGIxau+i
	 4G2AVt8CPrWJPbPhCGeY0TOLstm1VbFNOAl4Utwr7Qh0H8dFV1rESIQ8MsMILQJbdh
	 nZJsTTBPj1K1bxFc/CQlLs+Q/9O6SzjeAfKKgLfKOuCUhLmvbpXA97w/EOhKtabsOm
	 mqN14lIYItK6A==
Date: Wed, 21 Oct 2026 00:04:49 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Check ACPI companion before use
Message-ID: <20261021070449.GA851443@liuwe-devbox-debian-v2.local>
References: <20261017064313.3816553-1-yaojiale02@163.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017064313.3816553-1-yaojiale02@163.com>

On Sat, Oct 17, 2026 at 02:43:13PM +0800, Jiale Yao wrote:
> Platform drivers can be forced to bind to devices outside their match
> tables through driver_override. vmbus_acpi_add() assumes that every bound
> device has an ACPI companion and dereferences it without checking.
> 
> Return -ENODEV when the companion is absent to avoid a NULL pointer
> dereference.
> 
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Applied. Thanks.
