Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132A2FD1AA;
	Wed,  1 Apr 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065637; cv=none; b=j1N52cJRcjTUen+NYKSIonC88OQMwJnh9PEjHtGYaFtssSI2Grz8JZDfnAJXhwFKJAxUS9N6S4RxikXfpFDNXIt1HN/LTVw+iMArpLThwpZgR2q5zzWvTBaJkaxQASqH7zFtFLK5ntnhfzcYHCxsxxIaF+GlAYDlhdXGVEoQxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065637; c=relaxed/simple;
	bh=2HWNGN087gz7GE251OyfR94/6I847zuQQ59q4IfndXY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TOFHfR3w1wYcmThkjjMtRggIUhy6RIVt4OVeGgodO3mWfhYPhKcvgBVpEo/HJifAzBtUVtPb5Z+MFUwa2H3GpFccBMpNwo3FLaIJaFr8Xs3iaVdl/Dbau1t4j2YUFrPI+8e+ukGgT/eQbCjs5qGcaJ5p3+1ARGQWvub70t4D2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WRjtVjXu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WRjtVjXu"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 044CD20B710C; Wed,  1 Apr 2026 10:47:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 044CD20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775065637;
	bh=GVZ6AfYHfFQdP8AbVauKGzQ4QHfyPw/mi+D6kmLBC1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WRjtVjXuq5Y5pDEIrJcVF3AAunv0f72pPS/qmrhKlkMTyARW1vrpPV2eqUNKIkmWQ
	 iL8kXJgcvL2GnycIfPtvJZea6Gd5FdZst+70y/OEGUdCC+V5acoLP++MJXR7Di8HmC
	 TLk/j2PYIWutxk6fZNj7hmn+vO+ryq3u0QubKlDs=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 029E4307050E;
	Wed,  1 Apr 2026 10:47:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:47:16 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Roman Kisel <romank@linux.microsoft.com>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/6] mshv: unmap debugfs stats pages on kexec
In-Reply-To: <acrxBOLaHdku6kdZ@skinsburskii.localdomain>
Message-ID: <47e5a81-a2d6-b59d-f087-26b148fdb43@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-7-jloeser@linux.microsoft.com> <acrxBOLaHdku6kdZ@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 30 Mar 2026, Stanislav Kinsburskii wrote:

>> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
[...]
>> +++ b/drivers/hv/mshv_debugfs.c
>> @@ -676,8 +676,10 @@ int __init mshv_debugfs_init(void)
> nit: this should allow to avoid setting mshv_debugfs to NULL in the
> error path of mshv_debugfs_init():
>
> if (!IS_ERR_OR_NULL(mshv_debugfs))

Yes, of course one could. Though a permanent ERR_PTR in a global variable 
to indicate init-problems feels off to me. NULL for "not there" seems more 
canonical, no?

Best,
Jork
