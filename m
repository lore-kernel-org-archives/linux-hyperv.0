Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D97366546;
	Sun, 15 Mar 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591110; cv=none; b=EbMbyQ/etrpKKrq6Yb45lauWbn+3/UMFOB8NW9qOoaj6QBcEG2cVbVPb5B3LiaAxT+8F/uZPR+Yr7mxX4NeoO/z3pfcfXpEzq2KgdXZKNm9Y86znCwg0ZtahSBpYFUOKmp7hcxqaHJZhfGrIXeIuwUomagzlq/S/ZEuk8f2+Ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591110; c=relaxed/simple;
	bh=ysGCy3hRZ0k9cAzYYMnSd2CSwEnVozMuThlxlhsUDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2qepmCS+eGzCbNvbspHMz6dnH5ZpgAaixFJ99XASzjy6jbZLS88idhdF8G5c6edwlb8P2bAlPRUrm/c2uU20eD/qpaFJ9yZtOHBn9pTq9PSVeCQSn15pVkQsF69MwPH8w76vb8G1AF3jJhKvetaycmKtwuVDBd7xQnRigUovN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3Mm/T6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3Mm/T6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48962C4CEF7;
	Sun, 15 Mar 2026 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773591110;
	bh=ysGCy3hRZ0k9cAzYYMnSd2CSwEnVozMuThlxlhsUDm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3Mm/T6gJRYibqZqBNZ9YIx1+/oFvQxBnOlBL7Ry6RpGLwocK8vPcKRx5St0EZqw6
	 3W5kfYyBqXsPwDpjCD+qPX/zb1D452Lqiroy/9h13YUVQcDyFPagZguYwrVvmYiMSU
	 tuFCtW+2bKNP5So1fj0i/tse5owRoIkW5s5kOSqKuTTKDRd3t4A6fejohvD1QWsEDk
	 tqqDmnsdggfRA7Zur140Z/pRjnWhRbtRiMxrKn4pcbxu+kCl9vOJ1qMCFftp2O4QUC
	 2Swz9g+b1pwQWsFzYooiCVIFzt9IcQxBVGN/mrOMMZbA4vwrMrkW1noH/btEcv6QbK
	 YO+S5TZAcMYkw==
Date: Sun, 15 Mar 2026 16:11:46 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next v5 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS
 and use it in MANA driver
Message-ID: <20260315161146.GA1369074@kernel.org>
References: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193725.994833-1-haiyangz@linux.microsoft.com>

On Thu, Mar 12, 2026 at 12:37:03PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
> 
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.
> 
> Also implement in MANA driver with the new parameter and
> counters.
> 
> 
> Haiyang Zhang (3):
>   net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
>   net: mana: Add support for RX CQE Coalescing
>   net: mana: Add ethtool counters for RX CQEs in coalesced type

Thanks for the update addressing my review of v4.
Overall, this looks good to me.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

