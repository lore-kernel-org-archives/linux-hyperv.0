Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC413777E;
	Mon, 24 Aug 2026 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787531589; cv=none; b=DKmj1E7pgYGmvpRKbcJL0cZ1ILmRPQtxcpMCxJOi59lfJaKnfrxgWlOG4ZVchAoM4TIcntGT46KcDmiem0EV7JcIFDamX2dFscd/rATKIO3O8eV560qhxfl989n9PLvZlsZC28tIInpKRHVdYKfzRcnobVRIISNWFcJeTRkz6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787531589; c=relaxed/simple;
	bh=xuBTTq1IAu3LtTyToSi0sHCf+K1X8ZtUeY3KuqBqQfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1ctLH0sWk1JqZxA1+06COvkc6zixsXQo8bqaUKJL5HA+xFSnVxQgbJQv0UbTyPY4ATf0rlXGfNWWATn2VqAK4JzCM3R1MKS4lJ4F7Z8jQRbNlkLWr1sQ0fCJSGSTM7JeXuRM01naRZxzjpiZtMzI+1/iTmMaDQXGVj458RM0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJwgMmMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJwgMmMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E551F000E9;
	Mon, 24 Aug 2026 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787531587;
	bh=krg7k3KsK9mqHoK8ctDly2tIPJ7nB7D2CZV0M3mK/5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJwgMmMT+EK/VsVp+JgjsJCS8DZvXnJ417C570VaLd4R0I2qdbaPbo9cQ9wG+dLp7
	 mzZqMBYpwZKF/Pk1Uq9Ki7+TWSqAM/cwsx6pn8Y5ySIlWEOycH7YKiJreGdNUpQk+h
	 muzbz+0bJhU6J8AXcK5n+Hck0NyOuzJDeeVkt4SgrLa5KS/SmUeDmYHC1V576IKI6T
	 RqaRv596gfoVE5tEa1CRWjnZBM+AfJU7yLmJY1piJG8s66/IjbZ7UtCXoLq9uybt8E
	 6ubsMz0+8h9ap4kJV/2RNTXwA3Jp9cpLgqIEwv9EqJiphx2J9WtsCccGhjvuT6lMHk
	 yxVZg15yd5XAA==
Date: Sun, 23 Aug 2026 17:33:06 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for
 non-nested root partition
Message-ID: <20260824003306.GG3566091@liuwe-devbox-debian-v2.local>
References: <20260812145223.85949-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812145223.85949-1-mhklinux@outlook.com>

On Wed, Aug 12, 2026 at 07:52:23AM -0700, Michael Kelley wrote:
> The VMBus module initialization function, hv_acpi_init(), currently
> does nothing when running in the root partition and root is not nested
> in another VM. But the initialization function reports success, so the
> VMBus module is indeed loaded. VMBus functionality is not actually
> needed, but the VMBus module must be loaded so that hv_vmbus_exists()
> can answer correctly. Furthermore, the mshv_root dependency on the
> VMBus module is needed as described in the commit message for
> 840b740a35bf ("mshv: Add conditional VMBus dependency").
> 
> Loading the VMBus module without actually initializing it causes
> failures if the module should later be unloaded. The module unload code
> tries to clean up things that were never initialized, resulting in
> memory faults and a panic.
> 
> Fix this by having VMBus module exit function perform the same
> check for non-nested root partition, and do nothing in such a
> case, just like hv_acpi_init().
> 
> In the long run, the code that manages the Hyper-V provided SynIC
> should be refactored to better coordinate the requirements of
> root partition scenarios and normal VM scenarios, and to hopefully
> remove the hv_vmbus_exists() dependnecy between mshv_root and
> VMBus modules. Preventing the current unload failure scenario is
> an expediency until such a refactoring is done.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
> Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Applied. Thanks.
