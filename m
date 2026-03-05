Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A60335BDB;
	Thu,  5 Mar 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702368; cv=none; b=VTPupjg4YCBEMDJSPXRDPXb+oIeGc5BZi8dxzLCOK/PU9X5TIypgf5C9/LecOHXKZGULaKRq3DNLLI4ueVeR0vlk9yR/CQ58l+yrBINJfThiSNs8uh5LQO7RCpWg5qpfrrfoFBwis6BKn+C56H3MtfcrzYX4Mf7vVd0YkyF8DgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702368; c=relaxed/simple;
	bh=8VXwH48mwfU2FboslOUVe6AXxPKiu0MgmHYPxUB7NKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPtOFY4+Zfad73BNSu976PvHk7eseXaDusBKmHXsZiP+S+82SaucOTNtNsJcvUiUUNAOR1rvoXdRl+YJeTcnnyom2/SWjt73Vf7b/n1ppnjpuQaXaqZnr/oAdYSHUplnnmnrU0N05rlTjhJn1Pdd3VcLLqnaU6qEtKC9gl0OBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbd1dnJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbd1dnJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528FC116C6;
	Thu,  5 Mar 2026 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772702368;
	bh=8VXwH48mwfU2FboslOUVe6AXxPKiu0MgmHYPxUB7NKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xbd1dnJIFkuiZD2v5MOARbRTrXkkFuK2TL2adK7v/zhfEXCACCxQ2B/F/NOYrxlNa
	 nU+L3GPnIrO4Hq0M3e9Xtsa8oXXS2wyLdtp3/qCxl/oHUbZnXFwcxEdhm4wW+HtmR0
	 wRkIdaakEp4sx+7K5gYSuKK89x2wrWaMm3Z4f7Wdj64Ad1OLyWFLHDEuiWl48GelZ/
	 PtlG+wyCBD6D0m3efHCMI72eNJm1URWIUyQQso13GJWbMMf0KH7O5wphrGMkO13tDs
	 VMszbyQRLBBC0rM67wvK3gpguKMHwmV17DsCLSB8CjB2TzA3DwYUvTIXxc8vBt5Fn8
	 ToSoHtWvIRbrw==
Date: Thu, 5 Mar 2026 09:19:21 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <20260305091921.GA90938@kernel.org>
References: <20260302174204.234837-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302174204.234837-1-ernis@linux.microsoft.com>

On Mon, Mar 02, 2026 at 09:41:52AM -0800, Erni Sri Satya Vennela wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v5:
> * Remove __func__ and __LINE__ from error logs in hw_channel.c

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
