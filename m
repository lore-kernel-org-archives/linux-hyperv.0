Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C090359703;
	Fri, 17 Apr 2026 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434908; cv=none; b=mLszakxP48qvQfT3TatkG2kmMrF53TEJ0UZ6E0m1sIuSLGkG4UfBMKZ5ZV+3SvsQISkJIy4QHe5Tpu2daHzv8o5mWV4KefdMwAU6ogGoLL4egNzDFVb7nHgJXd/jAucBlRRX+MulDvk6Neb8pWUeRWQ8u20h59bDvS7zeeK4rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434908; c=relaxed/simple;
	bh=mcYxRom6K1vobfLQ9zuQtg1jewTgsYI9Bcs5FTN3l1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8M6dsXLK74NGb/AanA0H/+ZEA4abJkxl5Qfrgcyfa+ZU5QehZTZ7wqwf+9QsFIr15WSwWKgLktYk0jgpVyzUvkHEjpuwo0pg6gkXXth2xt21EEjkrl28IgScHCk4GnmshJSacSFZDOtKMGHjmyDc2MXM7pl8rR6vZJYN+uDCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkaEhris; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkaEhris"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA44C2BCB0;
	Fri, 17 Apr 2026 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776434908;
	bh=mcYxRom6K1vobfLQ9zuQtg1jewTgsYI9Bcs5FTN3l1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkaEhris7Dk3jVFLDBNo5OFhYBc21nLZZJy92syiup+YEWw9dpKOV1BwfysRsB1YN
	 /703vWyusMqu1DTPq1cHjyoXTt7+qeKnsWU63Vgzlso5pxKpBsSjfchZNmlGIhvJxc
	 /2rW9cu43bgu3jInbCCewIMVU1L6v4kZ6UQ4lUppBNMqlViuPfFZTH3IoV/t9YNk1h
	 fJ5R9NKBmTh54jsf559XXIrKUmzwhbz0qAue0klVGE6iYl8g+9s9L5ETc5MSMlvLVq
	 Kt0y7+tITzHxOHxqTvYWKmT1lgBqKSrmXoJv5GJGS9FUwAb/exOsNwrMCBp+Ojrj2p
	 w3c9uQMOW1oDg==
Date: Fri, 17 Apr 2026 15:08:20 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/5] net: mana: Init link_change_work before
 potential error paths in probe
Message-ID: <20260417140820.GD31784@horms.kernel.org>
References: <20260415080944.732901-1-ernis@linux.microsoft.com>
 <20260415080944.732901-2-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415080944.732901-2-ernis@linux.microsoft.com>

On Wed, Apr 15, 2026 at 01:09:37AM -0700, Erni Sri Satya Vennela wrote:
> Move INIT_WORK(link_change_work) to right after the mana_context
> allocation, before any error path that could reach mana_remove().
> 
> Previously, if mana_create_eq() or mana_query_device_cfg() failed,
> mana_probe() would jump to the error path which calls mana_remove().
> mana_remove() unconditionally calls disable_work_sync(link_change_work),
> but the work struct had not been initialized yet. This can trigger
> CONFIG_DEBUG_OBJECTS_WORK enabled.
> 
> Fixes: 54133f9b4b53 ("net: mana: Support HW link state events")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v3:
> * No change.
> Changes in v2:
> * Apply the patch in net instead of net-next.

Reviewed-by: Simon Horman <horms@kernel.org>

