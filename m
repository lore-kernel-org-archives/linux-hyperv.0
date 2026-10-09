Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB173DA5A9;
	Fri,  9 Oct 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542304; cv=none; b=cU9S2Bedf/aTB99zP8s0nwUOVgW5ZaTbjYhGkbw1pwIwnCd/iP4XmPsx2IAzB1DDmebNnWP1C2/C14Z0nCx/FxVmxXcYCYBGXjKJCyilGWXOtshBFc5LMm23F/tJv28dMzGaN5PT7KdPSw0PTW3KoeGo/6pVOTd+uaAkCqAXrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542304; c=relaxed/simple;
	bh=r3bmrxV+t3fPSMRAU/WJh+2ymAD55jqvxklsd7ARlac=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qNXU2Y4BIFhyXEFeqXGu98ZAMMrSngR5bRr2qrgVrY08qlf5uUVvqnMSH3mbQc6Cpn16HBOy1xDP+huQuz2ut7vup3nFIbgscPi0+AiUJhQ6l4MxjXxtgQnqeACGlFTHkrA+J8543XxZkyobbyqBXgm7zZ51DVcj6GTDEheIyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlW+4jUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlW+4jUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944041F000FF;
	Fri,  9 Oct 2026 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542303;
	bh=r3bmrxV+t3fPSMRAU/WJh+2ymAD55jqvxklsd7ARlac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlW+4jUDLiex4nL+P4RAOpxGR6Dod1U7kBIPCeYPqGluAcRfccw7qBl6o8mmCGGXP
	 p8Qgk+dTHggYIbeTCZSEWmLRjtVtvfN5T+Rr26hkf9mmoUnIKKQNV2ENhiz+v2oRdD
	 oVbKyZfOHw/QaUw9jZAAXiOetChEhWh6slfZJ9u/1XPBQ5oqUwgnLfIS8kzSx236VX
	 vIo3QBvO/orMMsVm+WhBEKAEYYpNFmibO2SOpSquyMIaH46xMFxClxTxgEaLK9ewhy
	 0onpnFuNEXmz4E68P89210wvyx/ArbFvi4+W/YopRFMy/xXcxC8s/twtjmv6Uz2x6F
	 vM2Uxql6ODdmg==
Message-ID: <sashiko-outbox-165245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Drivers: hv: Run VMBus kexec cleanup from
 syscore shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: catalin.marinas@arm.com, wei.liu@kernel.org, "Shradha Gupta" <shradhagupta@linux.microsoft.com>, mhklinux@outlook.com, baoquan.he@linux.dev
Cc: will@kernel.org, broonie@kernel.org, rppt@kernel.org, linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, haiyangz@microsoft.com, pasha.tatashin@soleen.com, tglx@kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, kys@microsoft.com, hpa@zytor.com, brads@mainlining.org, akpm@linux-foundation.org, mark.rutland@arm.com, bp@alien8.de, namjain@linux.microsoft.com, longli@microsoft.com, mingo@redhat.com, pratyush@kernel.org, x86@kernel.org, maz@kernel.org, linux-arch@vger.kernel.org, dave.hansen@linux.intel.com, decui@microsoft.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:38:21 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> secondary CPUs are stopped. Consequently, the old VMBus connection
> and SynIC state remain active when the kexec kernel starts.
>=20
> Run the VMBus kexec handler from the existing VMBus syscore shutdown
> callback. syscore_shutdown() runs after device shutdown and before
> machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> teardown are still available. Guard the callback with
> kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> unchanged.
>=20
> Use the same path on x86 and remove the architecture-specific handler
> pointer and the weak setup/remove interfaces. VMBus teardown now
> precedes hv_stimer_global_cleanup() on x86.
>=20
> The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode"), which
> removed the synthetic timer's dependency on VMBus message delivery.
> Older kernels that retain message-mode stimer interrupts must preserve
> the existing x86 ordering and therefore require an ARM64-specific
> backport.
>=20
> Document the VMBus cleanup path and its position in shutdown ordering.
>=20
> Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@l=
inux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009102215.3360=
863-1-shradhagupta@linux.microsoft.com?part=3D2

