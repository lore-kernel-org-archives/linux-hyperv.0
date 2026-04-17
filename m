Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED03A7F47;
	Fri, 17 Apr 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435014; cv=none; b=QaeSfas9jHA2sUlo0silbgkMZZ8VszvhZQDEFW2xv5pgCWTAETikVwI5A2E/xYzf/phHqh4fsfyaw2GMvVsUTd6BSZqD/sBBudCK2uC7VnHQbhkuSrL/7zczy+E2iAwVtTjn/mLLdvc51MOk4mV+VaMHeEGHeq0AWDfsFThONwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435014; c=relaxed/simple;
	bh=LXyGjZr0glZIvidv/14NOUVA/CrZwTtxA1pXnsPk1hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdE3wy8JEjmQ1IDdrtVzaT7T6sg6n1GNX+r3SQfb1hPSvjHdOELt6xdCsrQ2HMyDtlhZ4OOctRoOiNGHynhvHF1tqZhVh5SAt0RwJcQlOXLHdqXj5WXG6eRsF1/H7a23v/fE7O+9n7UceimSh1ByQdCOu9zCJ5q5NZwmbVJP48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOzqyRdG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOzqyRdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA4BC2BCB0;
	Fri, 17 Apr 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776435013;
	bh=LXyGjZr0glZIvidv/14NOUVA/CrZwTtxA1pXnsPk1hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOzqyRdGk+KNVIHeIWxQZQ2fVKGxMKguTl4twWZWHJm12/rC/e2yHYf3xbzzX/zek
	 dkYUoKw+KeI1iFWNh/ho9u2jhRLvV3CQQ6SLQMq5vfX9Ayo/nWD1oqr7cNzbOB/jfb
	 4fLZqmuczB0mrcoXm5Y3SWpzOT+JS9hHuu+fyHxXA4I/fVkNNhOqXZYBC6Du7ZYr/m
	 GkWmbWx+iuQ6uNW26bJfPhNJTXEyqq4PQ07VB9GzF2EDYY1BhNPtWQJIALcupOPA66
	 qYZR7T/EOrQzpo95cRMgtOPkyHbtTm7F6KzBDVULkF1/HGNz/9jurT0P+lIgswxtnS
	 YWA9zZyUa/Wpw==
From: Simon Horman <horms@kernel.org>
To: ernis@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	haiyangz@microsoft.com,
	davem@davemloft.net,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	kotaranov@microsoft.com,
	stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	kys@microsoft.com,
	wei.liu@kernel.org,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	edumazet@google.com,
	decui@microsoft.com,
	leon@kernel.org,
	gargaditya@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	netdev@vger.kernel.org,
	shacharr@microsoft.com
Subject: Re: [PATCH net v3 3/5] net: mana: Guard mana_remove against double invocation
Date: Fri, 17 Apr 2026 15:09:53 +0100
Message-ID: <20260417140953.218832-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415080944.732901-4-ernis@linux.microsoft.com>
References: <20260415080944.732901-4-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Guard mana_remove against double invocation

If PM resume fails (e.g., mana_attach() returns an error), mana_probe()
calls mana_remove(), which tears down the device and sets
gd->gdma_context = NULL and gd->driver_data = NULL. However, a failed
resume callback does not automatically unbind the driver. When the device
is eventually unbound, mana_remove() is invoked a second time. Without a
NULL check, it dereferences gc->dev with gc == NULL, causing a kernel
panic. Add an early return if gdma_context or driver_data is NULL so the
second invocation is harmless.

> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

The Fixes: tag points to ca9c54d2d6a5, which introduced mana_remove()
without NULL checks. However, the exploitable double invocation scenario
was actually introduced by commit 635096a86edb ("net: mana: Support
hibernation and kexec"), which added suspend/resume support and made
mana_probe() call mana_remove() on error.

Should the Fixes: tag be:

Fixes: 635096a86edb ("net: mana: Support hibernation and kexec")

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9d095a6fb56c..2ab7c89e2fed 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3685,11 +3685,16 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct mana_context *ac = gd->driver_data;
>  	struct mana_port_context *apc;
> -	struct device *dev = gc->dev;
> +	struct device *dev;
>  	struct net_device *ndev;
>  	int err;
>  	int i;
>
> +	if (!gc || !ac)
> +		return;
> +
> +	dev = gc->dev;
> +
>  	disable_work_sync(&ac->link_change_work);
>  	cancel_delayed_work_sync(&ac->gf_stats_work);
