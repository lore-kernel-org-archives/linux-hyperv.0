Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05F3B27E7;
	Tue,  6 Oct 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281315; cv=none; b=eA/4EBfejiZMqo7rMllTiexUuSmkXOH41GvSmWN+Epm2udOOIvL9uNzeh9NiAyl/Vb7/fNnoAAfTppSAL60lNzaUHfmGi+PUH54McCxZ0Oa/B7suR/YWdLKZriPHcWJTzLr3aqPuASjboqxaeHhZRo1II3j4uzoNiAYXXG8uA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281315; c=relaxed/simple;
	bh=gnp8MSjVsj2xCAhK7jar17DLHCZrDPkcKPJcGmYENxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrLc/aAyX9CmU8A1zv5amPcYxFhyCWlibVA6e2tCudZqPDtX/l7r3Aiivo1TXe8AdAz3qiXlG5s9acAXxO8F1II2tGnLxU51Tf3VQ806jMg7CwHD6kVw6vlKW/YsuCwYsUkCJDtu8LzmS7s6bzA8M8bgjO8NrKCWL3sEJ1ySzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qvjOFXrC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qvjOFXrC"
Received: from [10.95.66.108] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A7A720B7166;
	Tue,  6 Oct 2026 03:07:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A7A720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791281257;
	bh=Gt1lp+Gdyr+I3+ep/fgfelXAWkuyT6J0SUoT/mWxGK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvjOFXrCl2Fm7UpQpdxBBERC1/pwNW9LxDDp3yH1tH7KYtGcXxKtDlsJpfibq4Vxk
	 Bfi9nnVAY5937ciu1VKyQMFEYjye25C0BExY/t+G8WcJcHJSN6M88oNg75ZsdQb1qQ
	 r6E4hq1xVBJAJYQEspNRjH1QwGQ0La7JWOgo7buE=
Message-ID: <6c1752b6-d09b-4d64-ac33-ab401df266fd@linux.microsoft.com>
Date: Tue, 6 Oct 2026 15:38:23 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Baoquan He <baoquan.he@linux.dev>
Cc: Will Deacon <will@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/2026 6:51 PM, Shradha Gupta wrote:
> Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
> connection and SynIC CPU hotplug state are not torn down before the
> secondary CPUs are stopped. The kexec kernel consequently starts with
> the previous kernel's VMBus state still active.
> 
> The previous version added an ARM64-specific syscore shutdown
> implementation. This version follows Michael Kelley's review and moves
> the cleanup into the existing architecture-independent VMBus syscore
> operations. This removes the separate x86 handler dispatch and gives
> x86 and ARM64 the same ordering:
> 
>    device_shutdown()
>    syscore_shutdown()
>      VMBus UNLOAD and SynIC CPU hotplug teardown
>    machine_shutdown()
> 
> On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
> This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
> Remove support for stimer interrupts in message mode") removed the
> VMBus dependency from synthetic timer handling.
> 
> Patch 1 adds a read-only helper that reports whether a kexec reboot is
> in progress. The helper is exported because HYPERV_VMBUS is tristate
> and the common syscore callback must also link when VMBus is a module.
> Patch 2 moves the cleanup into the common callback and removes the
> obsolete architecture-specific setup/remove interface.
> 
> For stable kernels that still support message-mode stimers, an
> ARM64-specific backport will be needed to preserve the existing x86
> ordering.
> 
> Changes in v3:
>    - Use the existing common VMBus syscore operations on all
>      architectures, as suggested by Michael.
>    - Remove the x86 handler pointer and the weak setup/remove interface.
>    - Add an exported read-only helper for modular VMBus builds.
>    - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> 
> Changes in v2:
>    - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>      suggested by Catalin.
> 
> Shradha Gupta (2):
>    kexec: Add helper to report an active kexec reboot
>    Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> 
>   arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
>   drivers/hv/hv_common.c         | 10 ----------
>   drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
>   include/asm-generic/mshyperv.h |  2 --
>   include/linux/kexec.h          |  2 ++
>   kernel/kexec_core.c            |  7 +++++++
>   6 files changed, 24 insertions(+), 36 deletions(-)
> 
> 
> base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258

Since the approach changed in this version and previously reviewed-by 
tags were not applicable, sharing them again for the series.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman



