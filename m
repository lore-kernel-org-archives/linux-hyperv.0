Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57E395AF8;
	Tue, 26 May 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800718; cv=none; b=lrd3fBBqfvquTLXe+a6Fo2CdpmegTfya2p5fXDKdErGgh0tGO7J2LeX4aQqA2GX2Uicn/pl4z+t5SFaEEQ4SjoDUFhd3VGAgy6RxGzwbDsxAXLphE/3tAn5e7SwzLGFpZ1QOqgPLUbPa7m5TjmLUWrm5c8tRGioCLedU4CYlUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800718; c=relaxed/simple;
	bh=+s3UMrY3+UOtrMJk3Fz0hpAwiLGy6uacxILxMSwgJW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY521F+Ch9iWvobJ02MUlrR2AGgz25ejnB1CP9HvKvc6KZGhczCXlr77cejMNOi0V1nnauA0WdNPblnI6JFyIMAOOp8311t8FLNdu4l3MeUjjGAUkDh6jKsBiWqUlG/zQNdk1YbqMqRVdw+pzUG0MHzayfepWvannHguEv1cYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KX1oYDtZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KX1oYDtZ"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D438720B7167; Tue, 26 May 2026 06:05:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D438720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779800706;
	bh=1MbOAYdYSb18jv3DzYhLQhKAHErzPZ4l2dUsgbVc8JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KX1oYDtZDqwwaRK7PAscj8i/Odj8PIrgdHWEutWwkVYZb/wgR/sGcpMzL6dS62A28
	 8pJL+zUfZJ4BX6B2gaszew0wnZcp6mTg/tioufwnFYJkTyZPfJDZvMM9gzIrqU8Rpz
	 0if8FWKOfuFpkeF2jyb7aybl0pHP/p6ryg32Ua3o=
Date: Tue, 26 May 2026 06:05:06 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Yury Norov <ynorov@nvidia.com>, Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <ahWagnLjClJ2IAVq@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afYxOPL4DNjXM7tL@yury>
 <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afoQHm28qj8JnKww@yury>
 <af15yfdotzVbK8Kb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <af4X_52txN28b9RV@yury>
 <agq5/8rUFp3ttOFz@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agq5/8rUFp3ttOFz@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, May 18, 2026 at 12:04:31AM -0700, Erni Sri Satya Vennela wrote:
> > > But one observation I had was that " irq_set_affinity_and_hint(*irqs++,
> > > NULL);" is essentially a no-op and we end up relying on the initial
> > > placement from pci_alloc_irq_vectors().
> > 
> > Yes you are, assuming you're not binding them before in your call chain.
> > 
> > > Even though in these tests we
> > > were not able to reproduce it, but with this distribution there is a
> > > chance we end up clustering the mana queue IRQs, while other vCPUs are
> > > not running any network load.
> > 
> > That sounds like an IRQ balancer bug which you're unable to reproduce. 
> > 
> > > It's because the placement depends on
> > > system-wide IRQ state at allocation time.
> > 
> > I don't understand this point. The 
> > 
> >         irq_set_affinity_and_hint(*irqs++, NULL);
> > 
> > simply means: I trust system IRQ balancer to pick the best CPU for my
> > IRQ at runtime. It doesn't refer any "IRQ state at allocation time".
> >   
> > > The linear approach however gaurantees each queue IRQ lands on a
> > > distinct vCPU regardless of system state. Even after stressing the cpus
> > > using stress-ng, we did not observe any significant throughput drop.
> > 
> > If you just do nothing, it would lead to the same numbers, right? What
> > does that "non-significant throughput drop" mean? It sounds like the
> > linear approach is slightly worse.
> 
> The numbers are not worse, they almost same in both the cases.
> > 
> > --
> > 
> > So, as you can't demonstrate solid benefit for the 'linear' IRQ placement,
> > I would just stick to the no-affinity logic.
> 
> Thankyou Yury,
> We are investigating on more test scenarios and trying to
> capture numbers with both, your proposed change and the one from this
> patch. We will keep you updated about the results.
> 
> 
> - Vennela

Hi Yury,

Vennela and I ran a bunch of more tests and were able to reproduce the
clustering of mana IRQs issue we discussed earlier with the suggested
approach(setting the affinity and hint to NULL).
In these tests there were additional IRQs allocated(apart from MANA),
that disturbed the MANA IRQ distribution

ENV details
azure SKU(Standard_L4als_v5) 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4
Queue)

"Affinity set to NULL" approach
========================================
MANA IRQ distribution	vCPU
========================================
IRQ0	HWC		0
IRQ1	mana_q1		2
IRQ3	mana_q2		3
IRQ4	mana_q3		2
IRQ5	mana_q4		3


"Affinity set linearly" approach
========================================
MANA IRQ distribution	vCPU
========================================
IRQ0	HWC		0
IRQ1	mana_q1		1
IRQ3	mana_q2		2
IRQ4	mana_q3		3
IRQ5	mana_q4		0


Throughput(Gbps) with high TCP connection
========================================
connection	affinity NULL	Linear
20480		5.25		13.49
10240		5.77		13.48
8192		7.16		13.48
6144		9.33		13.53
4096		13.50		13.50


Considering these results, we would like to proceed with the linear
approach that was proposed by this patch.


Regards,
Shradha
