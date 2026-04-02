Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972E3F0A90;
	Thu,  2 Apr 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147623; cv=pass; b=kWWjo2IF6L+xAJet/QqzUIG0nc/mrAhZMh9GHrVBAktVxzpiewBlHT9yTMWlHZ6hIOwJLGrtGqZ+douiXQcu3jgH7tsFFWwW1A2cji/a0yFIMHE2D7wk2PYbLkgjNYD+Kro1Na2vHrgrzcph0xnPk32dq17PMeSC5fhnGn70Lcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147623; c=relaxed/simple;
	bh=z4q+ukMpzuhGj/yeLsoMrBN9jZgOS8In/U8XH3L9MNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpTM53PFvflBrG7+HrsZvBL006KZwj5NTwgT5W9q8TJYZkCN+OpejTZoQKaTe/kmsRavPvrRCFTR74CLLt/gtjcydBEwyoax0tUzkLIrxa2ElBiI2DLz/ZTMAjIbQZpTgP4SYqLQX/6zyQm8ccpk0xJC5gRNCaI1sW+PUAr2Sjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=FLApsrmM; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="FLApsrmM"
ARC-Seal: i=1; a=rsa-sha256; t=1775147612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gwwh1y6DyAdupLdNTwizwLgpFJ3iStleho6WPnMO7jR9ifE1chamgCCkCUO+hQ6zrPO4uGFqM11iroJVTAgODQXWZT1IDsLJ6rry1/F8QKAhCFGW0tI0zM6BzVUKeKCTO7jlBSUXqZh0Slma4c0eF7T+sBfT0EZPcYaugh+k4iQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775147612; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uRcMfgPB23Hj9odwBHEr14HMfIVkSmgxhTmEigSjfRI=; 
	b=H/04fJLmveDEMKyTilVgIbqxEyzykT3Z6hZvwMRRvLy9ad1bXjQjjqQqnAQJ2KKZwB7eaEuOqhn+zyLxMFqzPk6drv0lSeqJlYbK4gwt9+zTGGKfh/M0hG8deX5ld6JL4U5slsJpTcwVvs2xmJrdvOpdBIYe4crOMPCDe2kMkow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775147612;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=uRcMfgPB23Hj9odwBHEr14HMfIVkSmgxhTmEigSjfRI=;
	b=FLApsrmMSVohlFassS9SKaAVSDpol+thijHyj90BW9FA6SkNIMoX3fwcvTZkok+r
	oCaMOFHExzFTP03o/V+Ecxn13NqDM7iactEu3I5kfwDr3Ib8XUnMiwdwlMevBQFzOkv
	2oOty/kWwTNLFG2iLig5kUxbidzOVyEt8syRS77g=
Received: by mx.zohomail.com with SMTPS id 1775147610949123.7557164587439;
	Thu, 2 Apr 2026 09:33:30 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:33:24 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mshv: Rename mshv_mem_region to mshv_region
Message-ID: <20260402-fervent-thick-boobook-45dba9@anirudhrb>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Apr 01, 2026 at 10:12:40PM +0000, Stanislav Kinsburskii wrote:
> The mshv_mem_region structure represents guest address space regions,
> which can be either RAM-backed memory or memory-mapped IO regions
> without physical backing. The "mem_" prefix incorrectly suggests the
> structure only handles memory regions, creating confusion about its
> actual purpose.
> 
> Remove the "mem_" prefix to align with existing function naming
> (mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
> this structure manages arbitrary guest address space mappings
> regardless of their backing type.

I don't think the "mem_" prefix automatically suggested the backing
type.

Isn't mshv_region too vague now? Region of what?

Thanks,
Anirudh.

