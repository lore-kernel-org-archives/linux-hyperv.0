Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759132;
	b=nd6vhqkBRqJjNC69aGN9HQqlFQCBEAYsK0mmxI81eyAQfslxZ5OO3UKJqYwfgZxUZc5t
	 eAZdtSJeREjOHH7Gr1sb199goSanuLmtOw92IFhUvajWAKHgCAmTnXsKmUmdxpq9sJtzW
	 VwuaEom65Jr1qkAfTLO5h53n0nngDEht6xU4Wu0ZTUXwFAaJy8ot5M7SWLdLfbHzAMGDC
	 d6nlCACM4xnBMIgCs5WmPsl47VoukZ0UT3rH0yDZzcFlpv4nDhjjy83uPMlB7QZdgRfZG
	 Ae/KMWyBtSttyfui05vg7ygWYkVc2z2HEiMa2R8ChRWegKuBBpmIu9uthIEdnvhzynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759132;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8JP4fqByo87cANLvRb85F+PSRLIXEoS9coFVAgui0Pc=;
	b=DuQeMGCXM4rJU5E98BycUqN3V8E4JfX+9Oe/VqTPL4v+MupKm8aq8NWKFPrZxb+iYvwJ
	 6FNO5FuC2dzs971o83E7DCFwo+pQoHGi1D5oiYkHc+V6a3rhGzTD00tiZjYZ6Y1RZgXeR
	 eF7qPHMGADXoWYKcP5jFn6sEIKQ7QxXYtIIeQSIVbde+JPK5w4JgmjFbpe+zViH9C0JfY
	 MNGyDWSlhUU040nqb1i1HwkvUS8angh0x9qdRfSh2RHBaO+FHSz59MnXYpIfC7uCSbcdx
	 m6d+np+3CNV4e5TG9SskSi9DetIyrO8MS2nak6ALLSzonQtBa+sOkGvpP1bpZQMcw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=pq2hrQ6u;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE3606A31A;
	Fri, 23 Oct 2026 12:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ACE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=pq2hrQ6u
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6A68720B7166; Fri, 23 Oct 2026 05:38:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A68720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792759123;
	bh=8JP4fqByo87cANLvRb85F+PSRLIXEoS9coFVAgui0Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pq2hrQ6uBcLBsWpT7ti5o1M/lM0IUnfldo08t7lEytelDlI//JFZgJrAC9ymbz5mP
	 2jwVQKBrnt86b/4FfGMlW6IWhrBaFElqm+TD1X7XmooXEmtV0IlJ94qAEs945J4eWz
	 hw0Ob4XqcxE5uMGVftPDU8i/n6ebgstGsrUEDV78=
Date: Fri, 23 Oct 2026 08:38:43 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Remove leftover support for old Hyper-V
 versions
Message-ID: <attVUxOyEoUVPYEF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261023030527.1611-1-mhklinux@outlook.com>
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
In-Reply-To: <20261023030527.1611-1-mhklinux@outlook.com>

On Thu, Oct 22, 2026 at 08:05:27PM -0700, Michael Kelley wrote:
> When removing support for running Linux guests on Windows Server
> 2008/2008R2 and Windows 7, one area was missed due to the code
> comment spelling "2012" incorrectly. Remove that functionality now.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  drivers/hv/ring_buffer.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 72f30ab23d1d..d8b085dfdb46 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -561,14 +561,6 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
>  	start_read_index = READ_ONCE(rbi->ring_buffer->read_index);
>  	WRITE_ONCE(rbi->ring_buffer->read_index, rbi->priv_read_index);
>  
> -	/*
> -	 * Older versions of Hyper-V (before WS2102 and Win8) do not
> -	 * implement pending_send_sz and simply poll if the host->guest
> -	 * ring buffer is full.  No signaling is needed or expected.
> -	 */
> -	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
> -		return;
> -
>  	/*
>  	 * Issue a full memory barrier before making the signaling decision.
>  	 * If reading pending_send_sz were to be reordered and happen
> -- 
> 2.25.1
> 
