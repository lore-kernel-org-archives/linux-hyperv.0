Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217C392812;
	Wed, 13 May 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671354; cv=pass; b=Lzy1UDs6id8Jlx5RM+lqtJylstGAY0IFTQmgRx+pvCFox3SkTtCedQrduGvQJ5BBloGmlMhsLq52wG3O9/6VyDmdQO8ekLSsUxFoRSBIuezbdQqzLSvCHcx+aFLwxYcz0TtESPmLvw4LcxgPGaOcO416ahbYBxnUpbdFfg4ttpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671354; c=relaxed/simple;
	bh=++6gFsJFCLDXH3CgndjEIkbGMk3Dfyxr9k8BxO9MdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hurVg2ZesFI81zZmh4QMsn40rfcNE4UqDl5NU49HjhEk70tv6fryRsRXRu3i8umcqonukaMcfjm4sDSfnqDPSExbUAOnqKWxsudsE/b0Yu4yDiQiI66FzIA8nCMUEJu5M4cTdqWt83ugLVTlLUp9Jc43MwfOT8PYcIB9e68bCvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=sw1Q4BnL; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="sw1Q4BnL"
ARC-Seal: i=1; a=rsa-sha256; t=1778671345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LSo9XA6tJOTNYFV7bubgeNjTWtElJyJ8YIdll+fErqm85MNUuvkuQE/pzQZLEFx50wi9Gvz6NuaFy7p0QdL+kBTfN/E+pYC3ALnalfAlSJIjyl1tn6k1jst92JD62XVCHo4yxdmWC2DeL61oAhlLa60VAzg9xE46v9TANiz8DTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778671345; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qbyEVmGVMrThfNFUDCyjZsvdvWvIlLLKWkXpSl0D21A=; 
	b=EtvmNET4GgsD3VerlZhyp0J68zjH9633LmYF/wfseWBRK63p1O6BpR+vfZrWDDxzrBFX06qG8lsaNVtWJgqlpgDZJfUVvUBNbKskVYpzr4WYVJJmRxCwYUx9yFPvC3w+U/ifxWqOLIO21YyGjckp5v2QQ6OdpN0/c9/AnUMS8/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778671345;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=qbyEVmGVMrThfNFUDCyjZsvdvWvIlLLKWkXpSl0D21A=;
	b=sw1Q4BnLuCLb8iLsdpy+6mCJLqRlgRD0ov5ty7Hu3BKRw2b+AYHJWWVb0L0aLJhd
	YBWkgidfLK49L4AZZspN6pRXvVHQwq9QzFq7TQthICj6KemNJv2CFfE5ZpzSmN0R32N
	aoFSbDsfxQ3Rt8NJXoaQm/DdXt1HDgNR5O4hbR+w=
Received: by mx.zohomail.com with SMTPS id 1778671343470693.4626802619944;
	Wed, 13 May 2026 04:22:23 -0700 (PDT)
Date: Wed, 13 May 2026 11:22:18 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/18] mshv: Use kfree_rcu in mshv_portid_free
Message-ID: <20260513-aromatic-tricky-turkey-791efc@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816864533.21765.15114003791446487007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816864533.21765.15114003791446487007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:44:05PM +0000, Stanislav Kinsburskii wrote:
> mshv_portid_free() uses synchronize_rcu() followed by kfree() to
> reclaim port table entries. This blocks the caller until a full RCU
> grace period elapses, which is unnecessary since the same module already
> uses the non-blocking kfree_rcu() pattern in mshv_port_table_fini().
> 
> Replace with kfree_rcu() to avoid the blocking wait and keep the
> reclamation strategy consistent across the file.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_portid_table.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
> index d87a82e399e96..42d21b92b88fd 100644
> --- a/drivers/hv/mshv_portid_table.c
> +++ b/drivers/hv/mshv_portid_table.c
> @@ -62,8 +62,7 @@ mshv_portid_free(int port_id)
>  	WARN_ON(!info);
>  	idr_unlock(&port_table_idr);
>  
> -	synchronize_rcu();
> -	kfree(info);
> +	kfree_rcu(info, portbl_rcu);
>  }
>  
>  /*
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

