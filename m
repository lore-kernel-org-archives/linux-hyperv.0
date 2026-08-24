Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5D3C1A;
	Mon, 24 Aug 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529722; cv=none; b=dnBr02gUTc5Z1buj05I+myVtPMGJYqNx9P6KTIvCwkO0sTz2pn3w3qlxsk63JKYWS1/iiG5sUFR2M+68vubOvo5YtgsIiPIm8mWtI24WBgyj3CXWP5g/FpERGN6HeS9Jj2DmvGYzzP8yvLn4dV2oOhqfGM+bIXzWt7if5V60pbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529722; c=relaxed/simple;
	bh=kUO61COROewAD+ehc6wTjJNvIJBCMIA7R5BHWMFK8fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xot/cquWcxbahMLffgvxnSvBRK/4y1kNPSx8w1TwdbRmgv6GfXCQM0RckMz/1bmYIZB/bWbasu7u3k9IJzEAghRPCsJZJ7hALyaxvVDD28Mg8kz7uwl8Iw+IGvEQbKzUTSaXrkOoJq5cz5opzJig2InEexFug1crf1nPvzijWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq6PV9Qc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq6PV9Qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAE11F000E9;
	Mon, 24 Aug 2026 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787529720;
	bh=o/14PlblHtJKH9k+jkE5iCXBRNNctaOKdcN85D33fQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gq6PV9Qc0jfwPYcvBdZLrbGoXlKknis+aThKirG9euxM5i350rrGo51lQrZihiwSZ
	 6QplexaBPhPZoawpQNwUMv9PmQOJPzSBhs3QwOT/r3mQEm7YrJI7zU59Ip8CZEksvK
	 rqdGfGx916vr1lY3ibqxzfnuvlyCDZLE2BJ+uUC7i4/GQMu3G0509cENB8l0IOy5Ej
	 8SJFeFr0tLphEUPcJhotqCkCjgsANd1UD/Miel+7TDH81jPIhDzZMQT3Fry7lrJ2qT
	 w2opmA2vXtbBAvv9spRgNSqZsYX8Ilgq786YqIJy3gDx5SsNfr7ATx5CdVZZ+0v74r
	 u7JrimRivx7Hg==
Date: Sun, 23 Aug 2026 17:01:59 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com, namjain@linux.microsoft.com
Subject: Re: [PATCH] Drivers: hv: Use meaningful errnos for hypercall status
 codes
Message-ID: <20260824000159.GB3566091@liuwe-devbox-debian-v2.local>
References: <20260727211101.2199630-1-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727211101.2199630-1-hargar@linux.microsoft.com>

On Mon, Jul 27, 2026 at 09:11:01PM +0000, Hardik Garg wrote:
> Commit 3817854ba892 ("hyperv: Log hypercall status codes as strings")
> converted hv_result_to_errno() from a switch to a table and added status
> codes used for string logging. Statuses without an existing specific
> mapping were assigned the generic -EIO fallback even when a more specific
> errno was available.
> 
> Map HV_STATUS_ACCESS_DENIED and HV_STATUS_OPERATION_DENIED to -EACCES,
> HV_STATUS_UNKNOWN_PROPERTY and HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE to
> -EINVAL, and HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED to -EOPNOTSUPP.
> This lets callers distinguish permission, argument, and capability
> failures from generic I/O errors.
> 
> The table conversion also added duplicate HV_STATUS_INVALID_LP_INDEX and
> HV_STATUS_INVALID_REGISTER_VALUE entries. Remove the later -EIO entries,
> which are unreachable because find_hv_status_info() returns the first
> match.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>

Applied. Thanks.

Wei
