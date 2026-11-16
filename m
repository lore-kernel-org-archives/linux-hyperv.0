Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838679;
	b=Jqb3RrxjYdgjhzcUQK6PVPAneLL0b0OfNb6jMGPqZzzbzbCHQ5TNNXdTgLRUDVzvP+GG
	 hw2HPinti6WAWnyZoN+yu1qXNwjFIkzGSWS1kYDd9lKjw4m8nGYaEYUGunYf7KaHqvQGg
	 YQTsOAOTBkZXX6RriMo46C8TvfmulwM9e3RPOMxVUFHDXG4/3bIAcXSDHXGrjvK/RQkrh
	 iTUQO3IZ4Ljhv9IPEEpajGAk9fJ61aEaRqajluUR5lsO1IaUndV1I5/kf7FbgYHkgKkXT
	 q5+TI9HbDeLM8vCwpLLDPyMrWrNpgc8s3QWtiZaoTk1kz/84bve0DbdV2GSBwf9iRew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838679;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LI0DKKsowJb30//UW3p4JvWCa4wNwDYcXX/lPt9xwl8=;
	b=B2QKlhbZ01mk1WC4BDzWlw3WOjc/ML389fSuCQMp32Yhap1rvYAAvdab4m0FSlndToLu
	 GB9tW9hBF/kIb2u1kP277mBQ1yXXk7RISQyGngTrJvARHYmTsS/vRoIErlqn83OgGqIiK
	 i5+HyHqooGNzGJXZgKyl5ZCsnLr2qhrwAOdoCHiQ7YH4yZguL1+uedhqxezHQyboHNut7
	 bgzxg+ZARfY6OdJ21qRRicE08Uar63C7Zc06RARnUD5gLc5s9dfl7ymkLQxyon+jrU8WZ
	 fKntQzWbG26uiOkrw2fBqaF6NCXmy/pGuGiRQJjPKQrDCWY+fyZ+dL8zTvLhaWl0lCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV+NhkqQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A7606A32A;
	Mon, 16 Nov 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV+NhkqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032801F000C4;
	Mon, 16 Nov 2026 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838678;
	bh=LI0DKKsowJb30//UW3p4JvWCa4wNwDYcXX/lPt9xwl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HV+NhkqQguMUUC/5jT/4z/AYyV7y//McU8xYx/wmB7ktWMz7OJytayICJMbEYV6Rh
	 UG81QcdV8jfP6hrkdFIyaHwfEBAZ0z3nVLSnj5LrwmNQPOAUEcBvalvfyNV9ALpGm+
	 09Z0iiuJDimEYNMwRw21XonLmUWX9/nicplef1b2h3YWPRydhz8uHfsfuotdrU0MQe
	 ha8IsNm0+6bis/Cd46JeoPjD4rbDVpguM7i1tgEj3Lbytj8fBIBfWMC6S9bfnANefW
	 IvFPRflp0v7Z19WU6ZgnIpoLclR8qMiB8I7mXEpUQnitF9+so1wnLc9dzaGeNS5Qt8
	 vfyOnKNZM7mOA==
Date: Mon, 16 Nov 2026 16:17:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>, Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Message-ID: <20261116141755.GR11319@unreal>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-2-pavel.e.popov@intel.com>
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
In-Reply-To: <20261111234439.4098-2-pavel.e.popov@intel.com>

On Wed, Nov 11, 2026 at 04:44:37PM -0700, Pavel Popov wrote:
> <asm/cpu_device_id.h> exists only on x86, so generic code that
> matches on x86 CPU models has to wrap the include in #ifdef
> CONFIG_X86.
> 
> Add an empty generic version, so the header can be included
> unconditionally. The CPU match tables themselves still need
> CONFIG_X86 for the model defines.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
>  include/asm-generic/Kbuild          | 1 +
>  include/asm-generic/cpu_device_id.h | 5 +++++
>  2 files changed, 6 insertions(+)
>  create mode 100644 include/asm-generic/cpu_device_id.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
