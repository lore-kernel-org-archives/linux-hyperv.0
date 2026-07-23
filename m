Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F933A9CB;
	Thu, 23 Jul 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786865; cv=none; b=IvzXcmhtOVLiq4ReVRKf5RAVboIgNO1l1i4U7bvHYNVDLpYCgJfIDbjPmjyvCGPbHewc6/hrCkrhLQgJeQhEzCm/doaw10UWgLCNLl5jd1j58Gt1fdhvPHyD6Cma71i4PTRlmYFY3zQjcTEM09GFtowjtdz32Hqz1HRw9SIJi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786865; c=relaxed/simple;
	bh=eBtgSU5dqb0xlXuI63d7nGqrVxcSMF9a6GJF5JFTcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwPlFlzQkpc5Bn9zC5yzVdVw1MQwr0t/vepnYwqIsF2lO+Pr90sQPpB12HSJvEZtdB4TKB12glYhJD9iPeSVhXUCr6f3TLDxJCBl/boE4gQiNL6NTIOFqaKkmcUiOsvdo2+raBwCh5PncQj3O2ld2lNxewe8ADogn/wezotOW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQJDo3/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQJDo3/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7801F000E9;
	Thu, 23 Jul 2026 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784786864;
	bh=mT6AC/CgA/qw0YljyiJfi5cILiHEuRGtFgy9cZoeLZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nQJDo3/GGVYcArLXGhUnDsuEfpq0gI82lnmS+vS/mHZLM3k8v4CcDLl7OOChUtjVC
	 lM/k58TuGnVn7xin4tA1xrOvcWYtmPRMjJ98TH8S6XBYcXrNl7fThJiUHyUrfcYgIG
	 bntUJRlVIRkWWFSJ2wdnKHqYjSCapSJ+E27gIdefmwLT5XhXo7bZD0x77cFBp5hYQn
	 YbsZXsHbaw+a0bZThopXh7Mooe6yGMPeXGEM6YMZQD2PP/EBOxqWD3aX5/CD7Pmudd
	 q1m+MAtz0LUUNmPtO0+wxpEAR3BmmLLUBPwWiO0EyHGeOOUSq1aZ5tTOGnxJaJ7WuZ
	 ZegdoPN1F0ORw==
Date: Wed, 22 Jul 2026 23:07:43 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
Message-ID: <20260723060743.GI2020652@liuwe-devbox-debian-v2.local>
References: <20260717001837.635756-1-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717001837.635756-1-hargar@linux.microsoft.com>

On Fri, Jul 17, 2026 at 12:18:37AM +0000, Hardik Garg wrote:
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
> 
> For a VTL2 kernel using VMBus protocol 5.0 or newer, the host
> may expect INITIATE_CONTACT on either the redirect connection ID or
> VMBUS_MESSAGE_CONNECTION_ID_4. There is no capability indication that
> identifies which ID is active, so the driver must determine it at runtime.
> 
> During VMBus negotiation, the redirect ID is tried first because it is
> used by VTL2 configurations with VMBus redirection enabled. If the
> redirect ID is unavailable, the host rejects it synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to the standard ID.
> 
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. Preserve the existing connection ID
> selection for older protocol versions or when running below VTL2.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>

Applied. Thanks.
