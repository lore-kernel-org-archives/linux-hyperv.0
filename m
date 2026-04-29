Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A19427A00;
	Wed, 29 Apr 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500915; cv=none; b=JzDfmRw4oXUk3mhb59gtXGgNYWZXwG4N3rYK+7DeP3P0DV1HIKOu81rEqTnvSbjoI3Pq7+r10t9bO7VIGW+FUtEWVmGMQSID2T7u9PsB+tjhHQ2d7lBZXuysomaCCANOlWcKV5zLnfevjQm0UcXmdjHr+jZ7tjV/zHViETnytkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500915; c=relaxed/simple;
	bh=Zv93FCnz67ibqE38O1qzNFDzi+UZGB7hG6LB4C3igVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0lQ1/nOTq46FAJspG+30IWzVa5iiyvp+GINXLE9iGyM8pGvbQJN7txnDwxSvgdBBM4z+5BZD78tqrSjEfVljyHCAcNWMVXsxLEunfG84AUIJEyv1pM0kHHkUZXeFBz/g0ljgX2YOHZASQsjDquxsGk89FHc2Kf3j8euRzP1Dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odLTKtmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odLTKtmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A7C19425;
	Wed, 29 Apr 2026 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500915;
	bh=Zv93FCnz67ibqE38O1qzNFDzi+UZGB7hG6LB4C3igVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odLTKtmhClfTk3Km3hQINQ06PMeFURKHZC3Fzz6opZr8C3gmdw0ZekWQcJERI09im
	 wTdIHglCLpk/NEXhuYOM3hdVi9nsD+tYnwJ71+GXrLy75VL1gE4/eUYSjJ7nmFGdNo
	 9nHZ4+fb8nQbs4mBBQSDgdt9TOElYDA30e+LyA6wH7wSH0e2Ayyq6PIo5QtyyiX88R
	 HcoOEbg/ub5RO2YtH2yCJUudjPT5+bCw2fJf58o9emgH+WXWI1LtUklJOAzzaOncuK
	 AgN8YwKyt2GVG7m8YVyxXWCkZ39p9j/xgCOp0zHhGQf5GXZ31iv7LMqmx6rb3cOrWx
	 HbiyYjn+AMO4Q==
Date: Wed, 29 Apr 2026 22:15:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ky Srinivasan <ksrinivasan@novell.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] hv: utils: handle and propagate errors in
 kvp_register
Message-ID: <20260429221513.GA2584450@liuwe-devbox-debian-v2.local>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
 <SA1PR21MB6683C1A3130951962841B3AECE252@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683C1A3130951962841B3AECE252@SA1PR21MB6683.namprd21.prod.outlook.com>

On Tue, Apr 14, 2026 at 05:48:04PM +0000, Long Li wrote:
> > Make kvp_register() return an error code instead of silently ignoring failures, and
> > propagate the error from kvp_handle_handshake() instead of returning success.
> > 
> > This propagates both kzalloc_obj() and hvutil_transport_send() failures to
> > kvp_handle_handshake() and thus to kvp_on_msg().
> > 
> > Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Reviewed-by:  Long Li <longli@microsoft.com>

Applied to hyperv-fixes, thanks!
