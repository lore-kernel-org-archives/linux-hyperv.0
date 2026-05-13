Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F537DE80;
	Wed, 13 May 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672222; cv=pass; b=o+GHbaSAzZF2OG+DlX84ThXcCyILnW6hHLYMWkbbi0iPlu1sfksgftSJwsF0aajlmZWthGH1Z6FcYKJsTDnKHXze3dZopygXKE0Tw7r56eOBcsqH7DzLtUnCPk5T4GTk2DBMmRudjCupwoMjmvzIaceOpvr927EtGyvoRpT+CgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672222; c=relaxed/simple;
	bh=6aSjmpBrzs/XqmNMTRPyDfYIN5TyX5lGnF+mXSKUtsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyXr6tITLVGczMD47p4lutIPciZT5fc1W72ywpozvnelrv5QTD2GqyaL9rL427WVtVp6qu/2UJaGrsww8y6tko5SN5Wb+ISHQhagVHpXKiK4UacmBijJHCWlPnirN2a7r0n1BA/5G+QtLXdbFd6I1qRVp8ppVBNvxbI3RLcfB7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=RDzkG82P; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="RDzkG82P"
ARC-Seal: i=1; a=rsa-sha256; t=1778672212; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ijNFI8oIIu8DqPwc7JVF5Jq/nqjNO4YP40iuZBUpcjHA5Sqr1ZBOFxv8UrC/hbyrWn2RrtSZz82vcDDum7vP4v0sLwf6UzI3yHhgnWSWZuBTNPEmtKO7NMHl778pGdw287rTKp5QTaaMIlWqksbDkNywQJ4Q+uCGNQ6JgB/ndkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778672212; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QfrWpUgTWs+hN+N9iRkAXAkWR6B1KJaCWc06sC2p/3w=; 
	b=eZLAVaS1E4snOR83hoSCzNy+01ec9V7HiwZNaQ8ApajmL01+4zhIm7hGmOzEGyVpoWE52VY1D6PRG+gsWED0GUhPiuCCHgcoNAu8BESCOtYXw8CXM5v1BVpKyfXS/mP+WvlbfZowS0NxDKwDIqoeZYrdHIjP8b1v3WpeZrR+JCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778672212;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=QfrWpUgTWs+hN+N9iRkAXAkWR6B1KJaCWc06sC2p/3w=;
	b=RDzkG82PHFg6E01oTJ8TqEycxOAZDHBug8P0ZqVmZrYtUc/GEovPcg+wihML5wHr
	Ap97oCkRvB/o5hm9yWsIhw+rW7s91s0X0kdgNIE7g/gJqVEp2XWtbN8OyQtf+FDDNnz
	mJLjQxkbE/ZKowXgcYbhiLcwBtWqkzM7Nz7tOo/Y=
Received: by mx.zohomail.com with SMTPS id 177867220963410.313415523694175;
	Wed, 13 May 2026 04:36:49 -0700 (PDT)
Date: Wed, 13 May 2026 11:36:43 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/18] mshv: Fix duplicate GSI detection for GSI 0
Message-ID: <20260513-chachalaca-of-good-patience-6cedeb@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816862911.21765.306085307721937662.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177816862911.21765.306085307721937662.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:43:49PM +0000, Stanislav Kinsburskii wrote:
> The duplicate routing entry check in mshv_update_routing_table() uses
> guest_irq_num != 0 to detect whether a GSI slot is already occupied.
> This fails for GSI 0 because its guest_irq_num is 0 both when the slot
> is unused (zero-initialized) and when legitimately assigned. As a
> result, duplicate entries for GSI 0 are silently accepted, with the
> second entry overwriting the first — corrupting the routing table
> without any error reported to userspace.
> 
> While GSI 0 (legacy timer) is unlikely to appear in MSI-based routing
> in practice, the check is semantically wrong — it conflates
> "uninitialized" with "GSI number 0." Use girq_entry_valid instead,
> which is explicitly set to true when an entry is populated and remains
> zero for unused slots regardless of the GSI number.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
> index 59584a132ca9f..db05512db5548 100644
> --- a/drivers/hv/mshv_irq.c
> +++ b/drivers/hv/mshv_irq.c
> @@ -88,7 +88,7 @@ int mshv_update_routing_table(struct mshv_partition *partition,
>  		/*
>  		 * Allow only one to one mapping between GSI and MSI routing.
>  		 */
> -		if (girq->guest_irq_num != 0) {
> +		if (girq->girq_entry_valid) {
>  			r = -EINVAL;
>  			goto out;
>  		}
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

