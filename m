Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EE3EAC68;
	Tue, 14 Apr 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183100; cv=pass; b=SV967tKAEVquGFc75al5Omxvz38jX6B+8ma25SQ9y9G+T+qHv5pkUgljFAgaA8a6voYKq1sa4UjEJjep2rtltRpYPugiQOAFtrhmUldQpadp+z15N86UjVga9BfZwUyoHliuBZym2joUYmZadBash4h+zc8EDTekSVhKA1lTmhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183100; c=relaxed/simple;
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkDggKNVzUojp/36SOmCC3RowTfS1aR/fL/N4exa/BSz9Bdrp+6QgUaxZwYt/lVRcSIKtG4XulKJijt7zrNU3wGETz4DCHhO4ACtVvADP/Gw23MBhAgmgl01pz1nuqeZ0q9d98vks2EE0JMCmc2FhV/8tHBcIXsG3lS7RLz43cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=DqmWXejn; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="DqmWXejn"
ARC-Seal: i=1; a=rsa-sha256; t=1776183090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j1pJfLNuY1Bx4nWYyZgN17uTX7qn5nUOTuVdFJs40IBonAIiUK4mbJQofqqH4CMNgtsMjId+IgPvf+asHAzO/sC9YSJ54Wk3of6wq2VPjFojb0HhleSsp9vc/pL9fwCiRYHu4/Z5xgKxdU5zQo6hxIeFbG1/ZFyIi0IvYqC0BzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776183090; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=; 
	b=Ya3BYi7mICpGIBDvxAPKoap0ykLPRyTC4xXU8t6T4iD/EqrYc8wIg5vLDvuj+JZoVJ4sCsRw1drkXp+CaRweNJIcCBEgVwqJLF+XXCzIxRkN7mgv+yIE2UXfoFrFCXPWGI2R2C/uAfAS2q3yoAU1k6oju847MewQxELxtfosnyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776183090;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=;
	b=DqmWXejnlJ8q7dwH4MnWRJUhkaD5c485+V23toQ0JUVVUr56kVRPWeFHudUX5VkS
	VHYi+5D5tRHEHfMFAUrhwokvjXPVy7TCrDhWVXCFKS23yNaVq3VSh1ec/asIt+Ln82C
	L9R6DriKeQ5OSPhnkAzGnT3noup3rRHKIX7A1tzw=
Received: by mx.zohomail.com with SMTPS id 1776183088084347.1662515709852;
	Tue, 14 Apr 2026 09:11:28 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:11:22 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mshv: Reduce memory consumption for unpinned
 regions
Message-ID: <20260414-broad-abstract-anaconda-1c4ab1@anirudhrb>
References: <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, Apr 09, 2026 at 03:23:59PM +0000, Stanislav Kinsburskii wrote:
> This series reduces memory consumption for unpinned regions by avoiding
> PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
> unused PFN array that HMM-managed regions don't need.

This series has a dependency on "mshv: Refactor memory region management
and map pages at creation" right?

Anirudh.

