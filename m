Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBF25785C;
	Thu, 25 Jun 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409376; cv=none; b=LwW8n8BOpSxebGb6rR/YKq5exhrxi0yj2AxfECRHal7dVjFD7c0eECs9BkAPZH0swGoAkecT+6ofWEBq804Xk/CbA1H2thXOeDg9P0AgNfUwRKVJLjvOZDURX7+sINAZmf/VTbGd/3Jt42oqftA0p8lH73e2U6kvtqf0qr6wilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409376; c=relaxed/simple;
	bh=ex0ixU8nrolSMbX0zWTpjeHiIaN3XTiwbYCu6pteU5k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBGltmiuNkrjXkR336xbjkmUxLIMbZTn5lLXPUGbvRtYicYUlrynakryZrtiqBIzcZS61Ko2yrXNfnkF46BuqNLdEwdcG26ZPWGsDYWNFrB9MryfzQmr1O72u2jCru1rNdx5LhGYK47b+Wtnr0QwwqkCsuivcn59firwTDxuLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M7geG8xy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M7geG8xy"
Received: from DairyQueen (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCE1C20B7167;
	Thu, 25 Jun 2026 10:42:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCE1C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782409368;
	bh=pnOfNp9/ctehv6PmReGlUMeN9R8JuaY0IwGr+iGJTlQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=M7geG8xyuW3jaKBpp3FmBW4kbWpHezIBq47o5MufG7sOysIPZXBqCTpdgclvpB1ZI
	 nk0OqJdgyEKrm4mi2pBsz8xsgWsMUSIAG5uCeKblrU1kMdilPADNuyR+gtBWX/Xj0h
	 t0oswmRWmaHFk8EWTH72SKsvFnajnmtyUCTik4RQ=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>
Cc: <catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mark.rutland@arm.com>,
	<lpieralisi@kernel.org>,
	<sudeep.holla@kernel.org>,
	<arnd@arndb.de>,
	<thuth@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com> <20260609181030.2378391-3-kameroncarr@linux.microsoft.com> <SN6PR02MB4157F6A66DEDE650298E120ED4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157F6A66DEDE650298E120ED4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
Date: Thu, 25 Jun 2026 10:42:41 -0700
Message-ID: <001701dd04ca$0cfd88b0$26f89a10$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIqsf51yBS/Or0EhgWD9giRtIuOSwIF3n0XAZ3FyRa1lxLTUA==

On Thursday, June 18, 2026 10:46 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June
> 9, 2026 11:10 AM
> > diff --git a/drivers/firmware/smccc/smccc.c
> b/drivers/firmware/smccc/smccc.c
> > index bdee057db2fd3..6b465e65472b0 100644
> > --- a/drivers/firmware/smccc/smccc.c
> > +++ b/drivers/firmware/smccc/smccc.c
> > @@ -12,6 +12,12 @@
> >  #include <linux/platform_device.h>
> >  #include <asm/archrandom.h>
> >
> > +#ifdef CONFIG_ARM64
> > +#include <linux/cleanup.h>
> > +#include <linux/spinlock.h>
> > +#include <asm/rsi.h>
> > +#endif
> > +
> >  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
> >  static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
> >
> > @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
> >  }
> >  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> >
> > +#ifdef CONFIG_ARM64
> > +static struct rsi_host_call uuid_hc;
> > +static DEFINE_SPINLOCK(uuid_hc_lock);
> 
> So evidently Sashiko is wrong in saying that struct rsi_host_call must be
> in decrypted memory?

Yes, Sashiko is wrong. The RMM spec clearly states that the rsi_host_call
struct must be encrypted / "protected". The other two requirements are
256 aligned and not RIPAS_EMPTY.

