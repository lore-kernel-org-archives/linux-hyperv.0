Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97D37AA90;
	Wed, 29 Apr 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503460; cv=none; b=fv1ruenH1Ahr7pqRRzOBUdVR5mY5xlRFhh/LGe+0kwfAGeVYLfEBMcUOVXd26VulbJls4jO5d2yF5DOGpmf+po3mIRFGcoEEGI0GEl6yRfucL78y6GHU937Xieg4r5tgi5Km+jFhy5heSj1rN/AR9GNC1nTxOggv7Uu1Dggcw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503460; c=relaxed/simple;
	bh=I+//j2q/h0XBW5QRBovEU4yDXrOR+VIyZTkGVCwIPiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH2RS8BowV835MD+aLhPKC0K8iONOlFg5esXXU+CO6Nx89hMwwe/V1Yw4dK62ob2oOYkD7mCVdSZCNTLubi61aLCHDNIrozOdF/UvDSYtMmHvgiKq5m9pjGm8AxmknNNmXwWQUH76DvkYAo8Z8CthB2paXPJHLm/CHIGDSlTctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdGz6Ecu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGz6Ecu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F03C2BCB3;
	Wed, 29 Apr 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777503460;
	bh=I+//j2q/h0XBW5QRBovEU4yDXrOR+VIyZTkGVCwIPiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdGz6Ecu5pkXdxy80SkH+oT00EAoa8E2tUR4kr+lu1t8VDXqWh5vCL2UPsouVvtLx
	 iL7TO8BQRffd7hwhAT0Kiszd+MK8g2cgg1ZesX6xvmmBLy/KZjWkSnvIHoa4U8DDvq
	 73kgHFitwTcKF0Y8SVdwPAL1IYKgUlSXwEewi44bpOpJFbBEYaRXCa57byIwrlO5YH
	 GZdnbkXEY/KSSKk7YKKhym/HrPVkcNGkRLI7RBPjmfp1PYRSnq3w2mKPs40Zr3xTHS
	 euOS9LaXGiYbIoho/3kxfh0hu2h8DeannDvH38j0Vbt4nLZf4uhhVQePkjQmRmM2hq
	 A21UbA1Ehk6Xg==
Date: Wed, 29 Apr 2026 22:57:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Hyper-V: kexec fixes for L1VH (mshv)
Message-ID: <20260429225738.GC2584450@liuwe-devbox-debian-v2.local>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-1-jloeser@linux.microsoft.com>

On Mon, Apr 27, 2026 at 02:38:51PM -0700, Jork Loeser wrote:
> This series fixes kexec support when Linux runs as an L1 Virtual Host
> (L1VH) under Hyper-V, using the MSHV driver to manage child VMs.
> 
> 1-2. SynIC cleanup: the MSHV driver manages its own SynIC resources
>      separately from vmbus. Add proper teardown of MSHV-owned SINTs
>      and SIRBP on kexec, scoped to only the resources MSHV owns.
>      Use hv_vmbus_exists() to decide at runtime whether VMBus owns
>      SIMP/SIEFP/SCONTROL (so MSHV must not touch them) or whether
>      MSHV must manage them itself (bare root partition without VMBus).
>      Also fix SIEFP and SIRBP address calculations to use
>      HV_HYP_PAGE_SHIFT instead of PAGE_SHIFT, which produces wrong
>      addresses on ARM64 with 64K pages.
> 
> 3.   Debugfs stats pages: unmap the VP statistics overlay pages before
>      kexec to avoid machine check exceptions when the new kernel
>      reuses those physical pages.
> 
> Changes since v3:
> - Dropped patches 1-3 (vmbus variable shadowing, stimer cleanup,
>   LP/VP skip), now merged via hyperv-next.
> - Patch 1: fix SIEFP and SIRBP memremap()/virt_to_phys() to use
>   HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of PAGE_SHIFT/PAGE_SIZE.
> 
> Changes since v2:
> - Rebased onto linux-next/master to adapt to the upstream SynIC
>   refactor (commit 5a674ef871fe, "mshv: refactor synic init and
>   cleanup").
> 
> Changes since v1:
> - Patch 1: account for nested root partitions where VMBus is also
>   active (not just L1VH); use a vmbus_active local variable; allocate
>   SIRBP in L1VH allocation path for when the hypervisor doesn't
>   pre-provision the page.
> 
> Jork Loeser (3):
>   mshv: limit SynIC management to MSHV-owned resources
>   mshv: clean up SynIC state on kexec for L1VH
>   mshv: unmap debugfs stats pages on kexec

Applied to hyperv-fixes. Thanks.
