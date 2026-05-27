Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F203590A9;
	Wed, 27 May 2026 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919543; cv=none; b=GfIVbZ78yACaC67h4rw7LKLVk3iSsUkyZjYdL+GTQSswczwWLyffhjtG5QenZ0YwVVwYTMqZK6ljQ8YJYpI+SDhbpXyqOMByxxfwFiR9yZyxi8tdb8kZ8BcRYPzZdbVoSrerK8YWlBxKlzZr+Bbo0GXCK4RxD0JF5a+TM6NMGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919543; c=relaxed/simple;
	bh=J9E8UDYrSityZD3SfSkIF5MMGCeA0y2oOdz2uJcFE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgihpFoxKqaBW0+9EfQwSyJFeTnoo+5F9Ik2AmaPQB5Fyh1tzJ0ZYIE8mRj3L80UTQ51mUi232dcbnF3RNeRFsjUNCBuvYqoQRKCy1CBOIClmRItS3Yl8aYgkhlWElmHD6fNXTVWrHaBzszED8xkSaXh/URXVx1UrgrRsASSbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfO+7Q8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfO+7Q8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492761F000E9;
	Wed, 27 May 2026 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919542;
	bh=Wb9exkeDHRidtV186uF3t74XUJIa+JbljNTHeKf8E5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HfO+7Q8lcA4ntGs4VO4RVQ/+FttYMkmy8PVEn/5QzQ7BUBpdlVsZO88Tg42QwXfYr
	 4ppwLL3MxSvJ76h6ZfZYD0z5JVL3rPBUTsO/8HH8BU2QSp0dupXtXdUg/u/YCpL3/i
	 eyms66DIBbXXIVRWOgPeLdLEUl4KBklyf/JFIUJqfCclOsjE8DOSCdH43qjy4vDyHS
	 xxbZ5nLv9cPO9/R8ogg/yrL9Tys9KQcBWLoVlR17CGpfxXaLafpFIRZxmSgJEqoiBJ
	 gvN7okORybgkteqYa0RVdm6XG2PI5O0CI4795ksJYY+X1k5I6kk5jhw0yGDn7r4tvQ
	 34VxWURuArivA==
Date: Wed, 27 May 2026 15:05:41 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Message-ID: <20260527220541.GA3518940@liuwe-devbox-debian-v2.local>
References: <20260527192101.1471995-1-decui@microsoft.com>
 <ahdNVLMHrSgpVKwr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdNVLMHrSgpVKwr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, May 27, 2026 at 04:00:20PM -0400, Hamza Mahfooz wrote:
> On Wed, May 27, 2026 at 12:21:01PM -0700, Dexuan Cui wrote:
> > Change the "64 bit" to "64-bit", and the "Os" to "OS".
> > 
> > Remove the obsolete paragraph since the guideline has been
> > published in the Hypervisor Top Level Functional Specification
> > for many years.
> > 
> > The "OS Type" is 0x1 for Linux, not 0x100.
> > 
> > No functional change.
> > 
> > Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied. Thanks.
