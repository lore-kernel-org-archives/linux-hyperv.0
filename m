Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6123D669A;
	Thu,  8 Oct 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445996; cv=none; b=DXa3ZyrOvza/su0dgS7C96UrcAZ3KaICmR4gsUYNl9whkVuJYU4StVEqF4kGwWXDrsg5roVULRRzqSVq3UqhTc0GpVfYcZkjOogL2/RO9nQIOLV+AganwfXkAzu4HfQddhhzgb8GLf09JqdpgMBZOhnDGrDHuZ7xRzPXT4vlXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445996; c=relaxed/simple;
	bh=yYJDiW+wZ3eHb7q05WjAq68yv7uS0uRoh6pMbaDR+k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlMcVCHsHKgadLO+JroJVv4Oz6eJZxpy6IkggjNliC8UCydAHs27ZSds8flTZZuDuW1dGGWtXBYL3LJdKX+/8QvfZ2XEkDgH6/SU2fYRXJaO9NFluOQXNVgmqoJtLJAsKK0LxSkfXZ3IRSgoj111grkb5hXz5JpbKGZjYyKVJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFrdSkhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFrdSkhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2951F000FF;
	Thu,  8 Oct 2026 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791445995;
	bh=GsBfuJjdO4osm7iNMzjiGMPfmASUXV95niPtuVXoMj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFrdSkhcHY7Apx7PBFXuTMq0KRBn3TBds1Yg0yG0Q32rdCz/TOqgCQ51rmUjf5IiD
	 /HXB1fUmg1s17F5nCoW7bquArQ3DWrCmPlVkwVcs7biXSIPFRgft4qDbf5sk9YpBuA
	 PDl67PO58aMjJL0PJ27PQ6c3jTVUDRznMiXpEaBuZaaqXwKNAxpjMkBORF2lzTI2fx
	 Cflg21s1ZEvkgr7nE89gJxa1tXoRkw4t9RfmT5h7p1bju773yddW0QD1x//ePC4npq
	 D7HY15/cZS34p4f6+VcyEAqzImO8Hi5DA0NZHzBz0mqk92WCkW62lEanrcFKjoALPG
	 g5L9Ys57bHzZQ==
Date: Thu, 8 Oct 2026 09:53:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Drivers: hv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <asdL4VbXcCeeme8m@kernel.org>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <20261001132205.1703683-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001132205.1703683-1-shradhagupta@linux.microsoft.com>

On Thu, Oct 01, 2026 at 06:22:02AM -0700, Shradha Gupta wrote:
> ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> secondary CPUs are stopped. Consequently, the old VMBus connection
> and SynIC state remain active when the kexec kernel starts.
> 
> Run the VMBus kexec handler from the existing VMBus syscore shutdown
> callback. syscore_shutdown() runs after device shutdown and before
> machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> teardown are still available. Guard the callback with
> kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> unchanged.
> 
> Use the same path on x86 and remove the architecture-specific handler
> pointer and the weak setup/remove interfaces. VMBus teardown now
> precedes hv_stimer_global_cleanup() on x86.
> 
> The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode"), which
> removed the synthetic timer's dependency on VMBus message delivery.
> Older kernels that retain message-mode stimer interrupts must preserve
> the existing x86 ordering and therefore require an ARM64-specific
> backport.
> 
> Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
>  drivers/hv/hv_common.c         | 10 ----------
>  drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h |  2 --

It seems you missed Documentation/virt/hyperv/overview.rst ;)

>  4 files changed, 15 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index b4af7c0a70ac..263f7e7acac0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -148,7 +148,6 @@ EXPORT_SYMBOL_GPL(hv_set_msr);
>  static void (*mshv_handler)(void);
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
> -static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
>  
>  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> @@ -215,16 +214,6 @@ void hv_remove_stimer0_handler(void)
>  	hv_stimer0_handler = NULL;
>  }
>  
> -void hv_setup_kexec_handler(void (*handler)(void))
> -{
> -	hv_kexec_handler = handler;
> -}
> -
> -void hv_remove_kexec_handler(void)
> -{
> -	hv_kexec_handler = NULL;
> -}
> -
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
>  {
>  	hv_crash_handler = handler;
> @@ -238,13 +227,9 @@ void hv_remove_crash_handler(void)
>  #ifdef CONFIG_KEXEC_CORE
>  static void hv_machine_shutdown(void)
>  {
> -	if (kexec_in_progress) {
> +	if (kexec_in_progress)
>  		hv_stimer_global_cleanup();
>  
> -		if (hv_kexec_handler)
> -			hv_kexec_handler();
> -	}
> -
>  	/*
>  	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
>  	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 31256cb22b39..bb290a5eaf1d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -681,16 +681,6 @@ void __weak hv_setup_mshv_handler(void (*handler)(void))
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
>  
> -void __weak hv_setup_kexec_handler(void (*handler)(void))
> -{
> -}
> -EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> -
> -void __weak hv_remove_kexec_handler(void)
> -{
> -}
> -EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> -
>  void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
>  {
>  }
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5ebdbe24b5a1..3532ea779d34 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -33,6 +33,7 @@
>  #include <linux/sysfb.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/kexec.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> @@ -2904,6 +2905,12 @@ static void hv_kexec_handler(void)
>  	cpuhp_remove_state(hyperv_cpuhp_online);
>  };
>  
> +static void hv_vmbus_syscore_shutdown(void *data)
> +{
> +	if (kexec_is_in_progress())
> +		hv_kexec_handler();
> +}
> +
>  static void hv_crash_handler(struct pt_regs *regs)
>  {
>  	int cpu;
> @@ -2958,14 +2965,15 @@ static void hv_synic_resume(void *data)
>  	 */
>  }
>  
> -/* The callbacks run only on CPU0, with irqs_disabled. */
> -static const struct syscore_ops hv_synic_syscore_ops = {
> +/* The suspend and resume callbacks run only on CPU0, with irqs_disabled. */
> +static const struct syscore_ops hv_vmbus_syscore_ops = {
>  	.suspend = hv_synic_suspend,
>  	.resume = hv_synic_resume,
> +	.shutdown = hv_vmbus_syscore_shutdown,
>  };
>  
> -static struct syscore hv_synic_syscore = {
> -	.ops = &hv_synic_syscore_ops,
> +static struct syscore hv_vmbus_syscore = {
> +	.ops = &hv_vmbus_syscore_ops,
>  };
>  
>  static int __init hv_acpi_init(void)
> @@ -3014,10 +3022,9 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		goto cleanup;
>  
> -	hv_setup_kexec_handler(hv_kexec_handler);
>  	hv_setup_crash_handler(hv_crash_handler);
>  
> -	register_syscore(&hv_synic_syscore);
> +	register_syscore(&hv_vmbus_syscore);
>  
>  	return 0;
>  
> @@ -3039,9 +3046,8 @@ static void __exit vmbus_exit(void)
>  		 */
>  		return;
>  
> -	unregister_syscore(&hv_synic_syscore);
> +	unregister_syscore(&hv_vmbus_syscore);
>  
> -	hv_remove_kexec_handler();
>  	hv_remove_crash_handler();
>  	vmbus_connection.conn_state = DISCONNECTED;
>  	hv_stimer_global_cleanup();
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..98fe5c0f54ea 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -183,8 +183,6 @@ void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
>  void hv_remove_stimer0_handler(void);
>  
> -void hv_setup_kexec_handler(void (*handler)(void));
> -void hv_remove_kexec_handler(void);
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>  void hv_remove_crash_handler(void);
>  void hv_setup_mshv_handler(void (*handler)(void));
> -- 
> 2.43.0

-- 
Sincerely yours,
Mike.
