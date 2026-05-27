Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BB38AC7B;
	Wed, 27 May 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919902; cv=none; b=gvOAebE9wRXK+eOGfocKffYU/8xcJjC+s/XruUM3nSyE1aogqIxgJUcj3dCjrjEm8OGVWzEjqX//3NwKr7XiImC3TtrILcyv5X2q3XQaiViFQ90pxI7R04LUMxWaBU4LxmVvfAgcy/Yupqycsn6WJ7B5tObNh+JwdvtJ7qtdlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919902; c=relaxed/simple;
	bh=xlJk3uUxV+1iATm0aX5MXplaQUnxroieSVFf9SVpj4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd71R6/ebbgbu97xti49NT588aymc245yFlFE2BebAzJzMSKXhIBfOHX1p58YsSI94EI2e2n7wVpdcWooYYhVEtE3vYURVHaTRwghrSTNTMdcCwGjiu+IeMlAn24kTLeZluS8ByaHByXzoocXqI2FL+bBTKpwC+NrPcIhw1r384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGFw7WKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGFw7WKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF01F000E9;
	Wed, 27 May 2026 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919901;
	bh=sosG4dC3axvMoFiGA4ZWpAgtzupkO+rPJPY6YvFKKBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JGFw7WKf+LGM9mlbcVKs3DmcJoYBlqqpp6d63GbfCvgszdUJu7ZIgcsG5x8UvI01h
	 edgWriUOKj95lTtMj5iakmVcqfaukj0WhG4qSGKN2I3+cA/JqkE/iXH2ubX3+MrBkG
	 wHuOKFNjDQHmI6HgikwpWrybJs2pVPOjiwm4ii+3pMfura1ihmSNCyV6c0ZVwmXncd
	 auJbfx7yoyhlL+xrzo0rAwbFw5U+384Stu8t83D6sGkheKoJ8k2s4y1INOqVbqN1Ix
	 Z8wk5D+yMDG66GEnqnEz4ekm56SJSn2o1GdW8gEcbHA8meAzmA5Zsxldzrx5UUkgNj
	 d0mMMeDDbms4w==
Date: Wed, 27 May 2026 15:11:39 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	jloeser@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de,
	hamzamahfooz@linux.microsoft.com
Subject: Re: [PATCH v2 1/1] mshv: Add conditional VMBus dependency
Message-ID: <20260527221139.GB3518940@liuwe-devbox-debian-v2.local>
References: <20260526141304.3924-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526141304.3924-1-mhklkml@zohomail.com>

On Tue, May 26, 2026 at 07:13:04AM -0700, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When the VMBus driver is not part of the kernel (CONFIG_HYPERV_VMBUS=n),
> the MSHV root driver fails to link:
> 
> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
> 
> Fix this while meeting these requirements:
> * It must be possible to include the MSHV root driver without the
>   VMBus driver. In such case, the MSHV root driver can be built-in
>   to the kernel image, or it can be built as a separate module.
> * If both the MSHV root driver and the VMBus driver are present, the
>   MSHV root driver and VMBus driver can both be built-in, or they can
>   both be separate modules. Or the MSHV root driver can be a module
>   while the VMBus driver can be built-in, but the reverse is
>   disallowed. Regardless of the build choices, the VMBus driver must
>   be loaded before the MSHV driver in order for the SynIC to be
>   managed properly (see comments in the MSHV SynIC code).
> 
> The fix has two parts:
> * Add a Kconfig entry for MSHV_ROOT to depend on HYPERV_VMBUS if
>   HYPERV_VMBUS is present. The entry disallows MSHV_ROOT being
>   built-in when HYPERV_VMBUS is a module, but without requiring that
>   HYPERV_VMBUS be built.
> * Add a stub implementation of hv_vmbus_exists() for when the
>   VMBus driver is not present so that the MSHV root driver has
>   no module dependency on VMBus. When the VMBus driver *is*
>   present, the module dependency ensures that the VMBus driver
>   loads first when both are built as modules.
> 
> Existing code ensures that the VMBus driver loads first if it is
> built-in. The VMBus driver uses subsys_initcall(), which is
> initcall level 4. The MSHV root driver uses module_init(), which
> becomes device_init() when built-in, and device_init() is
> initcall level 6.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel.org/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>

Applied. Thanks everyone.
