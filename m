Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197217;
	b=Oz8vNK5DTK7zPHHFcmsWK4Qab0aiqyXZ4kjBRiUpOL8f4jLNsMnUt6hE+/olGJb8QNSl
	 FjO86LyeJs0UP0w9qCX42U1Yj1QkE5vOf+A5G7fytyduOTJr7xqQXLs5QScSs7L7mvnRS
	 QCFQa+dN5Xwv4drkTBIl8g35ZEAc3o8OS3v9PFS6argROQ/v8vvfDvQZopYdN6tiega+0
	 iESian+DJEpsCjggd4ki3HSqc4Ow+N0HOOoR4QZUeS1abuLtQshiWaArVYtRsXfdrkFet
	 eIFLebbOhq1kE64yWB+jKcjceNjjPaTufFaYlY8yUehpylrsXpwMz0YgNfR2IFS+rAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197217;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vpckeDuo02tS2aORCz9pEfJ8ExYYLYf+aGcqhM3+F4c=;
	b=E78KA1LRDeK6o6edAWN3d/kiZASFiwaKCIx8rh9+jEF6R9VgaR1hF9/S3TA14rS4pYzy
	 AKZvG1KhP+/RzBniOl4ZMPgXYYFxB9KrBKkXCOAyQy0JICCPHmuulh35nQUsdBG+NPAU9
	 9WMZtNj5OsHwfJ1WqoxcYhKITlkQy0dg3YsAVLtiJW3vBrPMGsH9wSO7QwDIIaaTJnknG
	 2Dzz5D0YD9iawCjXISTz3+UYzFIiQ5W4T00R59WNaEOur6Xm9Uway16KuHa1O8CVG1KiC
	 JOE6h7esTLx+/wMPMeKaOiiaXdbmvbmLUCkUMVf92wV5WaLnCOhq+6mA+qpTqtRv5tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=giGxvbkD;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A2E606A31C;
	Wed, 28 Oct 2026 14:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=giGxvbkD
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 546FC20B7167; Wed, 28 Oct 2026 07:20:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 546FC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793197200;
	bh=vpckeDuo02tS2aORCz9pEfJ8ExYYLYf+aGcqhM3+F4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giGxvbkDdKG+hizSabjt1yv8td2qasyDNF1QGUxt0E+/sGoOgdfTevhN6T0qanQTM
	 KiOQcUmxrukoAx+tKzt9z3J8kIazyQ1mhSTQQLMMS3nVJlObBrMV7PCBS9K+VF9AvL
	 npIVZJvmkrFe5GSmugvjZPdiTjspsK48b5FLb7Hw=
Date: Wed, 28 Oct 2026 10:20:00 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
	parri.andrea@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH net] hv_netvsc: Stop PPI parsing on invalid metadata
Message-ID: <auIEkCP0B7X0TGqe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261027164722.3393397-1-ernis@linux.microsoft.com>
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
In-Reply-To: <20261027164722.3393397-1-ernis@linux.microsoft.com>

On Tue, Oct 27, 2026 at 09:47:22AM -0700, Erni Sri Satya Vennela wrote:
> rndis_get_ppi() uses continue when a per-packet information entry has an
> invalid size or offset, or cannot hold the requested metadata. However,
> the remaining length and entry pointer are only updated at the bottom
> of the loop. Each error path therefore retries the same invalid entry
> indefinitely, repeatedly logging the error and preventing receive
> processing from completing.
> 

If you have reproduced this, I would strongly suggest that you
Cc: stable this patch.

> Return NULL on these validation failures instead of continuing. This
> terminates the lookup when malformed metadata is encountered while
> preserving the existing behavior for valid entries.
> 
> Fixes: 44144185951a ("hv_netvsc: Add validation for untrusted Hyper-V values")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wei Liu <liuwe@microsoft.com>
> ---
>  drivers/net/hyperv/rndis_filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 9b6c44979b4e..2c30abf9faf8 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -401,12 +401,12 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
>  		/* Validate ppi_offset and ppi_size */
>  		if (ppi->size > len) {
>  			netdev_err(ndev, "Invalid ppi size: %u\n", ppi->size);
> -			continue;
> +			return NULL;
>  		}
>  
>  		if (ppi->ppi_offset >= ppi->size) {
>  			netdev_err(ndev, "Invalid ppi_offset: %u\n", ppi->ppi_offset);
> -			continue;
> +			return NULL;
>  		}
>  
>  		if (ppi->type == type && ppi->internal == internal) {
> @@ -414,7 +414,7 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
>  			if (ppi->size - ppi->ppi_offset < ppi_size) {
>  				netdev_err(ndev, "Invalid ppi: size %u ppi_offset %u\n",
>  					   ppi->size, ppi->ppi_offset);
> -				continue;
> +				return NULL;
>  			}
>  			return (void *)((ulong)ppi + ppi->ppi_offset);
>  		}
> 
> base-commit: f71ff7d406523748bfb8236830c7eaa6a308aaa1
> -- 
> 2.34.1
> 
