Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251537;
	b=D0i+HqNpcFgnXX8S2BIRZIukP9zAtHeNj/2YkXgl28PIWVKYM2PGwU8MJY/MzXBKLl4U
	 UKmC3nuf5Z/lYwtFosVOiiORkqfP/THn1y+P+Ns4bWjiSQ4uj2+omECt9i5gAxazSjqi4
	 d6s+wltrwBuiFpTn4z0CqeJ+Tr59oQmtu7XYKQqd64SJlaGsyMuPvzNtU7/KQug6bf4TJ
	 1DoeBp9wgXES6dfVaZskQ66x8/8pdjj9eIz5b5c/j+hKbXJTOH/mmgMinYEP6yCZ+MIyt
	 IU2IBpLwa17ctz5Lrcq4UDfc4+FcIGCSuSKF3d97m1iWB7r+bguzjWJmdJIT1bPzShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251537;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lAZ7J5BRahm4+PTHsrALcdJCRxo3BQgKRRr4Wpqy7VY=;
	b=A7WVq9fe1TQtHM/N0cgUDM9JjM4rdVJAWk92CCA+qGPNZrmeXvRkP+NyM/QZXSnDs7CG
	 5N12rllbNGPW2UETUrwvDOjdy1vt2TZf17cZLI4nARg5NVrM5UHqT93yGL4qNr4lJwgUE
	 Xvb0YBj02qbjlv2o+YYTQ/JpLxXi4IQJSMDmjs7wBnLhYxm11ZaPUKIXp++sTyDhDIFJu
	 tk85/pTOL5T68T1IeDu05yjfeDGHuguCtOgzVjyTkGXOr9v99gaGcUu6zn9BZhsWoaOrm
	 qXHoV0vVYNzBwwmjxAPRqfCavxGWEMjGr+tGUPmX32Emq1kuzNvIcw/Lvb5oXdTFeyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=h28iOXPk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1E6606A31A;
	Thu, 29 Oct 2026 05:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=h28iOXPk
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BB9FF20B7167; Wed, 28 Oct 2026 22:25:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB9FF20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793251524;
	bh=lAZ7J5BRahm4+PTHsrALcdJCRxo3BQgKRRr4Wpqy7VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h28iOXPkyW5NgfgY/mpnz7bY/caXqGtLe+098bW1kTZS7/GpvYmbmL4L5elDkojIm
	 W3zMqsM79FkvfDmnLTwNVAe7Xylp6TorcexrJfQ6jAgEiDwWzZi3aMoMI2Jsm2XAiu
	 rnX35//7idu4DzT7W8uoyJPIDz5Ou6bC0pl7aMwM=
Date: Wed, 28 Oct 2026 22:25:24 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
	parri.andrea@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH net] hv_netvsc: Stop PPI parsing on invalid metadata
Message-ID: <auLYxPjFHeYzGETy@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261027164722.3393397-1-ernis@linux.microsoft.com>
 <auIEkCP0B7X0TGqe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
In-Reply-To: <auIEkCP0B7X0TGqe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Oct 28, 2026 at 10:20:00AM -0400, Hamza Mahfooz wrote:
> On Tue, Oct 27, 2026 at 09:47:22AM -0700, Erni Sri Satya Vennela wrote:
> > rndis_get_ppi() uses continue when a per-packet information entry has an
> > invalid size or offset, or cannot hold the requested metadata. However,
> > the remaining length and entry pointer are only updated at the bottom
> > of the loop. Each error path therefore retries the same invalid entry
> > indefinitely, repeatedly logging the error and preventing receive
> > processing from completing.
> > 
> 
> If you have reproduced this, I would strongly suggest that you
> Cc: stable this patch.
> 

Thankyou for the review, Hamza.
I will make this change in the next version.

- Vennela
