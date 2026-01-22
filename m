Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914862877DA;
	Thu, 22 Jan 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055254; cv=none; b=LfIqIuLowvfm1aziessMn0itMKQab7hKsTEB2KAd3RGn/wqBQzuztkBKjvnSwcBhwANXxTKvWUNxNMyLX6/aqoxm7hQACoIo5/bJQPyBgD4B9ZoBX995JOkP0dnJvcJ5sqkl/1xf2PDwjp96XIbfkGnrZ68uBR8QP1evdsjRyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055254; c=relaxed/simple;
	bh=zhu6dGIyVP2+d4I1Exe97UZ2YxP6FnkSl+SLZz3GaN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNjPC6r1qIop0jMs6rNVtcEgRLSTgAkVXnXGZyJxR0/c/d/nwy3aB2OaK2cxJlJUda5IdAgMu6A9AG4Mqlqt/T6zFHsNvZ6WZRCJ4zrPfrBKYzQOgpEJZgdpcFSaJTn9+Avs/D8aUedKLfFyo5dZpYdzrWHEkF4jl9M2QKJw7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsdJwD4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsdJwD4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B5C116D0;
	Thu, 22 Jan 2026 04:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055254;
	bh=zhu6dGIyVP2+d4I1Exe97UZ2YxP6FnkSl+SLZz3GaN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsdJwD4WZpNEC6Gs24HPVI2+457fEHk0nMywpxvfOPvOk8GmhhhGzrxAiXESdP7Tq
	 HMxsK/oX3L/sArPcvyjQy0NcJwvNAN8un6g8QbkAMEtqp63W421cIYcxwQXibUIclj
	 PQkruEYUCZQBIsrer3fE7XcPZ8Uvl7is8cxuz2ZAXZhHcTyIPPyOGykOLFp8E/gtvY
	 WGGP4CEgzEZ/9fQlUgu+2/CkD5XRvz/lQ0Hb876VDYNsvyoaL3oVrrun8AWh//hC/u
	 4NxJVUDG94D/NyWzLZKsz6gDrFhPPt7zN1BjVgft9gL6B8Kdf3px7OCYYYgneNVT+B
	 Y0+uSJqvIAiMQ==
Date: Wed, 21 Jan 2026 20:14:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 leon@kernel.org, kotaranov@microsoft.com, shradhagupta@linux.microsoft.com,
 yury.norov@gmail.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
 gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <20260121201412.179f9b37@kernel.org>
In-Reply-To: <20260121065655.18249-1-ernis@linux.microsoft.com>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:
> Enhance MANA driver logging to provide better visibility into
> hardware configuration and error states during driver initialization
> and runtime operations.

> +	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
> +		 gc->num_msix_usable, gc->max_num_queues);

> +	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
> +		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);

IIUC in networking we try to follow the mantra that if the system is
functioning correctly there should be no logs. You can expose the debug
info via ethtool, devlink, debugfs etc. Take your pick.
-- 
pw-bot: cr
