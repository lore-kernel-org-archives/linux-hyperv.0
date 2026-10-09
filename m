Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C645D913;
	Fri,  9 Oct 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528558; cv=none; b=aLOGmpnAtO7bMxsEP3h8rlW2DCywdQ0cFdo/sL4z/VbTfqvuD0PsAPwNabWbEUwrp2s6nTEVhEvvGkxLOf7l3BeZbbh2DGyAGt1i6IasVLnDa2gDXk1qR6kDxCIy5U5fTOpnfvJozB4Uj6UyyTkjlofyLZXfnziaO0BdOEdLJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528558; c=relaxed/simple;
	bh=ZwMAWTFJYGtX33ZE5VYxldtOiJLOSRokfSpsQZuLMEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGxbzJNJUv6FT3/uA9PIJYC78Ewi28xghnfnzyL2HcqUBiyxqRhlrZbPhWEQZekB2L8KJpovBtajNN2BeRnboeyi29j18RifyG0M7519QHE8stTGvRW7Dwap26xYOOT1IQlezbwX7CjaAAEtL5FuDB/Oz35IuhY856FvRjIMU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GQ+T8GQ1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GQ+T8GQ1"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E7C6420B7168; Thu,  8 Oct 2026 23:49:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7C6420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791528554;
	bh=IacDB8kE1Y5p15IdTpzM9DnFobde8u0e9G28Ics5ljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ+T8GQ1PK5mh53r6J31cm1RnkoJeZjY06SfczULboNMqK+GOwi/qj8y0OcWO1o10
	 4XlP3ONPQFOQoaRr6kGQDZ9/AhSAAodBD3LbimtUfy/YJMrgaoQFmQrZ5Fp7aacsTi
	 /Q+JFp4SUg5Xmpwipz2YkbJUHxS711qUc665jjfo=
Date: Thu, 8 Oct 2026 23:49:14 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <asiOauj+H+c3zu2S@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <20261001132205.1703683-1-shradhagupta@linux.microsoft.com>
 <asdL4VbXcCeeme8m@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asdL4VbXcCeeme8m@kernel.org>

On Thu, Oct 08, 2026 at 09:53:05AM +0200, Mike Rapoport wrote:
> On Thu, Oct 01, 2026 at 06:22:02AM -0700, Shradha Gupta wrote:
> > ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> > secondary CPUs are stopped. Consequently, the old VMBus connection
> > and SynIC state remain active when the kexec kernel starts.
> > 
> > Run the VMBus kexec handler from the existing VMBus syscore shutdown
> > callback. syscore_shutdown() runs after device shutdown and before
> > machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> > teardown are still available. Guard the callback with
> > kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> > unchanged.
> > 
> > Use the same path on x86 and remove the architecture-specific handler
> > pointer and the weak setup/remove interfaces. VMBus teardown now
> > precedes hv_stimer_global_cleanup() on x86.
> > 
> > The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> > hyper-v: Remove support for stimer interrupts in message mode"), which
> > removed the synthetic timer's dependency on VMBus message delivery.
> > Older kernels that retain message-mode stimer interrupts must preserve
> > the existing x86 ordering and therefore require an ARM64-specific
> > backport.
> > 
> > Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> > Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
> >  drivers/hv/hv_common.c         | 10 ----------
> >  drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
> >  include/asm-generic/mshyperv.h |  2 --
> 
> It seems you missed Documentation/virt/hyperv/overview.rst ;)
>

Thanks Mike, I'll address this in the next version. :)
 
> >  4 files changed, 15 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index b4af7c0a70ac..263f7e7acac0 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -148,7 +148,6 @@ EXPORT_SYMBOL_GPL(hv_set_msr);
> >  static void (*mshv_handler)(void);
> >  static void (*vmbus_handler)(void);
> >  static void (*hv_stimer0_handler)(void);
> > -static void (*hv_kexec_handler)(void);
> >  static void (*hv_crash_handler)(struct pt_regs *regs);
> >  
> >  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> > @@ -215,16 +214,6 @@ void hv_remove_stimer0_handler(void)
> >  	hv_stimer0_handler = NULL;
> >  }
> >  
> > -void hv_setup_kexec_handler(void (*handler)(void))
> > -{
> > -	hv_kexec_handler = handler;
> > -}
> > -
> > -void hv_remove_kexec_handler(void)
> > -{
> > -	hv_kexec_handler = NULL;
> > -}
> > -
> >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> >  {
> >  	hv_crash_handler = handler;
> > @@ -238,13 +227,9 @@ void hv_remove_crash_handler(void)
> >  #ifdef CONFIG_KEXEC_CORE
> >  static void hv_machine_shutdown(void)
> >  {
> > -	if (kexec_in_progress) {
> > +	if (kexec_in_progress)
> >  		hv_stimer_global_cleanup();
> >  
> > -		if (hv_kexec_handler)
> > -			hv_kexec_handler();
> > -	}
> > -
> >  	/*
> >  	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> >  	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 31256cb22b39..bb290a5eaf1d 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -681,16 +681,6 @@ void __weak hv_setup_mshv_handler(void (*handler)(void))
> >  }
> >  EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
> >  
> > -void __weak hv_setup_kexec_handler(void (*handler)(void))
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > -
> > -void __weak hv_remove_kexec_handler(void)
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > -
> >  void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> >  {
> >  }
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 5ebdbe24b5a1..3532ea779d34 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/sysfb.h>
> >  #include <linux/efi.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kexec.h>
> >  #include <linux/syscore_ops.h>
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/pci.h>
> > @@ -2904,6 +2905,12 @@ static void hv_kexec_handler(void)
> >  	cpuhp_remove_state(hyperv_cpuhp_online);
> >  };
> >  
> > +static void hv_vmbus_syscore_shutdown(void *data)
> > +{
> > +	if (kexec_is_in_progress())
> > +		hv_kexec_handler();
> > +}
> > +
> >  static void hv_crash_handler(struct pt_regs *regs)
> >  {
> >  	int cpu;
> > @@ -2958,14 +2965,15 @@ static void hv_synic_resume(void *data)
> >  	 */
> >  }
> >  
> > -/* The callbacks run only on CPU0, with irqs_disabled. */
> > -static const struct syscore_ops hv_synic_syscore_ops = {
> > +/* The suspend and resume callbacks run only on CPU0, with irqs_disabled. */
> > +static const struct syscore_ops hv_vmbus_syscore_ops = {
> >  	.suspend = hv_synic_suspend,
> >  	.resume = hv_synic_resume,
> > +	.shutdown = hv_vmbus_syscore_shutdown,
> >  };
> >  
> > -static struct syscore hv_synic_syscore = {
> > -	.ops = &hv_synic_syscore_ops,
> > +static struct syscore hv_vmbus_syscore = {
> > +	.ops = &hv_vmbus_syscore_ops,
> >  };
> >  
> >  static int __init hv_acpi_init(void)
> > @@ -3014,10 +3022,9 @@ static int __init hv_acpi_init(void)
> >  	if (ret)
> >  		goto cleanup;
> >  
> > -	hv_setup_kexec_handler(hv_kexec_handler);
> >  	hv_setup_crash_handler(hv_crash_handler);
> >  
> > -	register_syscore(&hv_synic_syscore);
> > +	register_syscore(&hv_vmbus_syscore);
> >  
> >  	return 0;
> >  
> > @@ -3039,9 +3046,8 @@ static void __exit vmbus_exit(void)
> >  		 */
> >  		return;
> >  
> > -	unregister_syscore(&hv_synic_syscore);
> > +	unregister_syscore(&hv_vmbus_syscore);
> >  
> > -	hv_remove_kexec_handler();
> >  	hv_remove_crash_handler();
> >  	vmbus_connection.conn_state = DISCONNECTED;
> >  	hv_stimer_global_cleanup();
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index bf601d67cecb..98fe5c0f54ea 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -183,8 +183,6 @@ void hv_remove_vmbus_handler(void);
> >  void hv_setup_stimer0_handler(void (*handler)(void));
> >  void hv_remove_stimer0_handler(void);
> >  
> > -void hv_setup_kexec_handler(void (*handler)(void));
> > -void hv_remove_kexec_handler(void);
> >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> >  void hv_remove_crash_handler(void);
> >  void hv_setup_mshv_handler(void (*handler)(void));
> > -- 
> > 2.43.0
> 
> -- 
> Sincerely yours,
> Mike.
