Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2032E62B5;
	Wed,  1 Apr 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065436; cv=none; b=EMzKSaI9eu7nw6Ak2bFWk4fR3zFiRXVByQZtRjKbAjVtflMEJeD3V1vScNHuURcJ8xdJ4tp6bfcFSbXaLSKucdcASn22G1mWXq07n0ggfYVH10gieWwMASjEsH1lgks3fw4+vhFI8nEQ4qp4rteFPnnn0JSYNcCCPrzHEMb5drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065436; c=relaxed/simple;
	bh=Y4xn5LPC4zpOOT2zZXS8dOaqCrmqo7qJ0HHfOom4P2U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D2kIS2xvZMIkXVp+hI/bZN5jAuadaMApOiXLCek+/J8HOWOUat+cP2tD8tH4hsKSwbt19SryhOD6wJSBQOdN+92NtGKEXD30hsqfeIspmb88z19QnRWwbpUDV5bjcyB/qxfWIueWMCVQJF4kxKdWnujot+NOXF6L3U2hFOY5Cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cJKYkQTJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cJKYkQTJ"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id F268B20B712B; Wed,  1 Apr 2026 10:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F268B20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775065434;
	bh=yAbqd11rZZyfR0ixJzDS1kD5ucvKMwrItKENgc4fHZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cJKYkQTJRCn1FlBlkuzj40okkU7KenmxJBnWCt8+k/+JqG6qe8/22Spc/pISO6GDK
	 nkrFglnYFcTD7g3sQQJO55GPsCd5g9TPVvgAGkg/3pvwK8pb4slx4Y6TB/p2YuRyL7
	 JqLwIqx7Y6EKxcDyvcN3vLHyfenTb+xuo8neH2tY=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id F07D0307050E;
	Wed,  1 Apr 2026 10:43:54 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:43:54 -0700 (PDT)
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
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <acrwYf50SJnDwN3e@skinsburskii.localdomain>
Message-ID: <1ad289c1-c0d7-5afb-9f29-89c6e169ec45@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-5-jloeser@linux.microsoft.com> <acrwYf50SJnDwN3e@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 30 Mar 2026, Stanislav Kinsburskii wrote:

>> ---
>>  drivers/hv/mshv_synic.c | 109 ++++++++++++++++++++++++----------------
>>  1 file changed, 67 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
[...]
>> @@ -454,7 +454,6 @@ int mshv_synic_init(unsigned int cpu)
[...]
> Is it possible to split out the root partition logic to a separate
> function(s) instead of weawing it into this function?
>
> Ideally, there should be a generic function called by VMBUS and a
> root partition-specific function called by MSHV if needed.

There are three cases/components: VMBus (L1VH/client), MSHV(root), 
MSHV(L1VH). VMBus can exist with and without MSHV, and should be
self-standing. MSHV can have root or L1VH beahvior. One could split
the MSHV behavior across two functions, though keeping them in sync in the 
future seems more fragile. Let alone awkward semantic comparisons 
in reviews and bug-searches. So I think a single funtion for both MSHV 
cases is just way easier to maintain.

Best, Jork
