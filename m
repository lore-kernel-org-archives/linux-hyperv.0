Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314468;
	b=ewtJOlQLDgU5+WkMqBPcITixeEB2vu0dwSANTKsxMS0Optjx7Vm0fDMu+QYDr/FEuGQo
	 J4ETftNLpdYh3r1sMxII/WP/ZvLmklpFxHUcfcLBmoP17fSvUAeRY7IECdRWcvdqKv1fQ
	 3l5ZftPsBIzn0ch43/So8+bVjvbnz/kn3Ld9tdoto8SQggDdwQEhzMZldaZXVc/sQ9Gei
	 PYGmgVIGWzBbwoB0lV1flMS5e+s3Ism8aHrRQwjR/BgV7TZC8UM/uX3FsjSRRr9Um0VXE
	 NfuJCB4EAmgtyQHU0VrIj0uRMnUGHuWcY6/VhDNWiqKFMesKEyeDKZ/JyteDdHNi9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314468;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=POwY9K3wYZjvJPalx+6QkgsqJfGo8QCv3p3v7iSCx8U=;
	b=JdMSqXO38UzMSQQTR14okUwdbH0qmidLz/5q3ykk6eLilNOLQAmExMwK+EA7zXPn2kjX
	 NSx/cVAwZXLsVrximWzmoh3yXcSx87tSyje2DjxrlHDFqrGDgd+qXCwZgRhHXVDtzMs8T
	 otkRhSnfWPUX1Zs1hr6sHBZ9n6gB0JiQtAFce9hmv9hfIJaY2O/sd6paNhg0OXQiujmZX
	 mx3pzM8dkRHfYv73J6ti3CA8x4M2NjC2jcGM9VseLwLhoepl0DWIqyIwEgGv4BzX3DAB4
	 W+OOjnTSEnQ/2bOplSqE0KiTH/5JRpUEFQMLeu2dmlJcZRWCAVqU8waenB2bH8rfVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDH0irSJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86144606A31A;
	Thu, 29 Oct 2026 22:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86144606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDH0irSJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352FB169E;
	Thu, 29 Oct 2026 15:54:23 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2043F673;
	Thu, 29 Oct 2026 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793314466; bh=+W+VoreRqIYQsjm9ZjQdyC40IddCPxH6b0QBB2g7Y3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDH0irSJKsIvF3lVyzTr15otTHYjyscFtzzcK2NHYxOvYzxveHXWqaGMjHHgVZHsG
	 vINIrvUOSDsQkpU5VyXbVZL4KrLZwF7+8VuyhowwNaKNjHX4P5VdHXfIxAUioo+gm9
	 Ho9ljIJqirq4qnv/E8nsInssKH/ncXUu8miviacQ=
Date: Thu, 29 Oct 2026 22:54:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	mhklinux@outlook.com, will@kernel.org, mark.rutland@arm.com,
	lpieralisi@kernel.org, sudeep.holla@kernel.org, arnd@arndb.de,
	thuth@redhat.com, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Message-ID: <auPOnb_9Jfzh-oQE@arm.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>
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
In-Reply-To: <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>

+ Suzuki

On Fri, Oct 02, 2026 at 02:57:21PM -0700, Kameron Carr wrote:
> Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and
> use rsi_host_call() to query the hypervisor vendor UUID when inside a
> Realm. The realm path is factored into a helper,
> arm_smccc_realm_get_hypervisor_uuid(), that owns a file-static
> rsi_host_call buffer (uuid_hc) serialized by a spinlock.
> 
> The RSI-specific includes, file-static state and helper are guarded with
> CONFIG_ARM64 because <linux/arm-rsi-cmds.h> does not build on 32-bit
> ARM.
> 
> For non-Realm environments, the existing arm_smccc_1_1_invoke() path
> is unchanged.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  drivers/firmware/smccc/smccc.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index afc2e4d..7e77170 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -14,6 +14,12 @@
>  
>  #include <asm/archrandom.h>
>  
> +#ifdef CONFIG_ARM64
> +#include <linux/arm-rsi-cmds.h>
> +#include <linux/cleanup.h>
> +#include <linux/spinlock.h>
> +#endif
> +
>  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
>  static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
>  
> @@ -69,12 +75,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>  
> +#ifdef CONFIG_ARM64
> +static struct rsi_host_call uuid_hc;
> +static DEFINE_SPINLOCK(uuid_hc_lock);
> +
> +/*
> + * Helper function to get the hypervisor UUID via an RsiHostCall.
> + */
> +static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *res)
> +{
> +	guard(spinlock_irqsave)(&uuid_hc_lock);
> +
> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> +	uuid_hc.gprs[0] = ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> +
> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) != RSI_SUCCESS) {
> +		res->a0 = SMCCC_RET_NOT_SUPPORTED;
> +		return;
> +	}
> +
> +	res->a0 = uuid_hc.gprs[0];
> +	res->a1 = uuid_hc.gprs[1];
> +	res->a2 = uuid_hc.gprs[2];
> +	res->a3 = uuid_hc.gprs[3];
> +}
> +#endif
> +
>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  {
>  	struct arm_smccc_res res = {};
>  	uuid_t uuid;
>  
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +#ifdef CONFIG_ARM64
> +	if (is_realm_world())
> +		arm_smccc_realm_get_hypervisor_uuid(&res);
> +	else
> +#endif
> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> +				     &res);

Is this meant to be generic? I'm not sure the trick to pass
ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID in gprs[0] and forward it to the
host is a documented ABI. I think it even confuses other realm guests
that don't expect this (e.g. kvm_init_hyp_services()).

I thought realms should stick to the RSI interface and not try to guess
the host hypervisor. But if you do need this, a better fit would be in
hyperv_detect_via_smccc() (if realms don't boot with ACPI).

I'll leave it to Sudeep or Suzuki to comment further.

-- 
Catalin
