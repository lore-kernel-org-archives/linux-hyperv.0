Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF02E7369;
	Mon,  8 Jun 2026 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898437; cv=none; b=iaeSUyXFbyoe0j8Wn6knmPyNV5Bhu4S2nxJqVtym8VHZSpRzK3HgsddowPCDWaFa/AOdo7vbp3Mr55xx0NLl9c9EHSqR+ttSS0iO5NoUUV/hmaElKgeFZqLG0zGr88yN0NIjjSAGtpk1gCsCbvj3wmYxkqIeBlD9AFesUsOcgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898437; c=relaxed/simple;
	bh=4XSdySNC6ADz9P8KbUcNklDk+9Rvn9ooMDG3UVATMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8nTPI9IwordVcOvMiAMWxMQJID4ncUEIxieiPAIYb4023DhtqTP/389o0gqTXzUaWzfsLci0z7V4GIkUS8wLR17hS4W350w0zNaBsDFhJwECjZxtMcTJoj+aLJgT6h4hCLI1GXEVQq1NLfzvo1dpMKwFzTzYBg7o+dGFepVUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjMkEf3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjMkEf3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE01F00893;
	Mon,  8 Jun 2026 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780898435;
	bh=TJIqRbcVuZGfZowRQTnAoA4n6W2NjIkeKA4nRugIc+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjMkEf3dqgBnPcx/ttCI1ltijDWBQbChhlRd4huUNbWNBOYDg2rYhXjTszVYTEDis
	 hg/cI3TJiD26RpCQd+WxU1FxzCSXGaDOmfeY/WZLipJZyR0qJDDAKcih2GTw2t457G
	 uSbMu+hOhjFGvVD53JR7yrDIlnmo2mqfGjofUvOxpG/ILpsLVniIt9J/JuASp185Qv
	 rbyVFAXvPRobmRs6S2MYAWp42aGRhuEIdj0wBRkVku2E+QEHcxvZvm3LrAdrMWsYok
	 wxKRz5xADptuwZbJWpBs2YcMjymJ7k5xe9EuVi6mKpHQ3FfkvIwtSBdpagSGkUSEja
	 l/d8rBYXMTaPw==
Date: Sun, 7 Jun 2026 23:00:34 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes in irqdomain.c for
 readability
Message-ID: <20260608060034.GB1555293@liuwe-devbox-debian-v2.local>
References: <20260601225116.956392-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601225116.956392-1-mrathor@linux.microsoft.com>

On Mon, Jun 01, 2026 at 03:51:16PM -0700, Mukesh R wrote:
> Make cosmetic changes:
>  o Rename struct pci_dev *dev to *pdev since there are cases of
>    struct device *dev in the file and all over the kernel
>  o Rename hv_build_pci_dev_id to hv_build_devid_type_pci in anticipation
>    of building different types of device ids
>  o Fix checkpatch.pl issues with return and extraneous printk
>  o Replace spaces with tabs
>  o Rename struct hv_devid *xxx to struct hv_devid *hv_devid given code
>    paths involve many types of device ids
>  o Fix indentation in a large if block by using goto.
> 
> There are no functional changes.
> 
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Applied to hyperv-next.

Wei
