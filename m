Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF33149C7B;
	Tue, 28 Apr 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420117; cv=none; b=sK/9xyTujgjxo820Hmqvajk7f8hlivKBd3IwDO80zLEuSvKHJOVEaPSX1JHmLFAfXkXwKPR7HI8wa0L1NbvPOpVsSA8hWjlwVeaeD2EDvsCw4Wo08kPmEf112k+3sqEY6buB0PylXrS4WoSzzWWCx+YwbupRn2ZRj9qGo4JYjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420117; c=relaxed/simple;
	bh=WKaEbQBSKMy7bS8qKyEcGakJ14grzPmcJjnKqt4AcDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKfnF0MbvhC2VKBgidgzuVwSphkVh9LAZfpg7QuoJG0EkPiGXVWHAMWosaKFych17KDu4hkxnwMPvU9tcK1xe5xR/BB1agQXdDeJzW6epz5R19auN622wye/tCvw17hGWhutMdzkzCuLLlqKZuX2V/glXiQs98DMUtbUoKa441I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5b3+glv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5b3+glv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A6C2BCAF;
	Tue, 28 Apr 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777420117;
	bh=WKaEbQBSKMy7bS8qKyEcGakJ14grzPmcJjnKqt4AcDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5b3+glvCs2C0EKnVY02M56x1Nm6YiYBLwqR5Gk/E8jImkdcHPSJFvVW6oWo0WLMu
	 MS07sxBlYZ1dbRkvHCBQpt1pT4tjtgXq7olzJ2g5QCcicD/3mIDY8LiFBybaYhA4kp
	 RHdMdokImpH1MrruMiRV1Y3Pu6DzU/WqKhn9xR7FM4kP6Yp0zyIm2WwmG2ODl5wF2c
	 +fcCkHWcNWCIu92Lf0LRpzxlleRUidz81Czw6BLeq9nlx7g3J/RlqaLLxTuJyigSBv
	 DxBH1NnZAyvkC9U3g5WckIUU5zCpwafcNHdgBpOO24glIDbPMGRtcw6DMS1wTdAxmI
	 3tYRWfZryKv7Q==
Date: Tue, 28 Apr 2026 16:48:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dexuan Cui <DECUI@microsoft.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Himadri
 Pandya <himadrispandya@gmail.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <20260428164835.4420df64@kernel.org>
In-Reply-To: <SA1PR21MB69211500C7F60FC29F1BAA79BF372@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
	<SA1PR21MB69211500C7F60FC29F1BAA79BF372@SA1PR21MB6921.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 21:24:59 +0000 Dexuan Cui wrote:
> > Sent: Tuesday, April 28, 2026 5:54 AM
> > Subject: [PATCH] hv_sock: fix ARM64 support  
> 
> Typically, for a change to net/, you'd want to add a "net" or "net-next"
> after the "PATCH", i.e.
> 
> [PATCH net] 
> or 
> [PATCH net v2]
> 
> See "Documentation/process/maintainer-netdev.rst"

Speaking of Documentation/process/maintainer-netdev.rst:

  Reviewer guidance
  -----------------
  [...]
  Reviewers are highly encouraged to do more in-depth review of submissions
  and not focus exclusively on process issues, trivial or subjective
  matters like code formatting, tags etc.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#reviewer-guidance
