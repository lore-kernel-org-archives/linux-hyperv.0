Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFE367F3A;
	Sun, 13 Sep 2026 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340341; cv=none; b=TU5OoPqB7uAxrqU2gTLsFmRYUDIqF3qsgUgckJspaZKkF1WMqWPiBM1AxZxpPFIJat8m+meoLMoh3cz9xYrBSLrdlKSS0R2eoBmJldwXnJxhM5OSzhB6CkRLn5XWw4qRDoXH3qJBd42HGQdHNcUGGaVUTmaT6L0fPTOcVMp7hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340341; c=relaxed/simple;
	bh=Oi0kJRqHz97fGcDtqHeiokEjhF4U+9eWn/vQWLkjEXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4WPvzD9NmG3f4KAkSqQS5cOuz5wqE0nA2KWAzBolssIoJwBKg6m+UPeBAJVNXh4Z3I/AdJxyDc1S1zIFPH8tXKB9xjb0LY0yh1BKVNraCvaYjq+P9DYwJQ7lwCtbSnFZeIDyiPJCxoGC79DfEoCAhrGW+JBSJ3yaJKuyYL6Ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT3NnnER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT3NnnER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66961F000FF;
	Sun, 13 Sep 2026 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789340340;
	bh=uEl1/Y+y13fSKP4CZn0HofyZ8xEWWRvmTzNdAamYRo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UT3NnnERRgG5NQF3sT594WOTY04mlH/PO4dtcbLaC7AD+Gd5Qs4kltFMX8V2yFPE0
	 sCWSrAErusAiZhnzDLkcIZjVTpOLeuBsXD47j/bB62Fn31SLjjxnDnTLR1jjNLFSc0
	 rMys5IBXP4WG5qhO/c34WLL2/vdpXlnJV8zbuRMj8DED7MnqY1Jnv+MbluGwVIMDHv
	 Ou2FWWqkN2qdt7XI61LkFvKEHF/4IAzSZ/yBks4NoYupC7QZEQeEjNFqcbB1OvQePc
	 UYyLHPJ1Gisa7QQd7eockzoRxXrFinyv9YNeOx9fsKqnDwJSy2z6j20xWAxX+MBuMN
	 idIrPbL8IEwBA==
Date: Sun, 13 Sep 2026 15:58:58 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Don't reset VMBus connection state on
 error/exit paths
Message-ID: <20260913225858.GI2219269@liuwe-devbox-debian-v2.local>
References: <20260901034514.457089-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901034514.457089-1-mhklinux@outlook.com>

On Mon, Aug 31, 2026 at 08:45:14PM -0700, Michael Kelley wrote:
> In two places, current code forces vmbus_connection.conn_state to
> DISCONNECTED prior to calling vmbus_disconnect(). But vmbus_disconnect()
> calls vmbus_initiate_unload(), which unloads the VMBus connection
> only if the conn_state is CONNECTED. Consequently, the connection
> remains and the Hyper-V host might continue to send messages or post
> VMBus interrupts.
> 
> The problem was introduced in commit 74347a99e73ae ("x86/Hyper-V:
> Unload vmbus channel in hv panic callback"), in that
> vmbus_initiate_unload() started checking the current connection
> state before doing the unload. This commit removed some occurrences
> where conn_state was forced to DISCONNECTED, but these two remained,
> apparently due to an oversight at the time.
> 
> Fix this by not forcing conn_state to DISCONNECTED during VMBus exit,
> or if a failure occurs when establishing the connection in the first
> place. Whatever value conn_state has at the time is then read by
> vmbus_initiate_unload() to determine if there is a connection to
> be unloaded.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-hyperv/20260805205806.B5AC31F000E9@smtp.kernel.org/
> Fixes: 74347a99e73ae ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.
