Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804DEED8;
	Tue, 21 Apr 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781122; cv=none; b=WqKTvHMbdl+YmzRPou3y9qXLg8LsfxOTBJbWNfXx6kHDbhCCffUIklh2DQMJjxgISKqD5/cfkLfyl+myzZUAIc4VQhEV5KcGGmo8m1EfehhDssBk2Mk5ZAv3wePgfQol483+ZNp7djJqJ5YcIaTwVrN6bBmmHCmJUeOcC9Y8Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781122; c=relaxed/simple;
	bh=3Ct/SPVIVJ2+EBRzhARfaZ8x6ntKDyeLe8hrRi9Fxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsX5Mz3dB/Jtb8Lz12DLefWKKR2laFoqtwEwq7W3cD2gEz92CCIZavFrvkm+so37coP1XthxNKSp5i5CWw/eZ8t+TCPb7I4TAuyaZ3AVONKFW5oH7tEm/CzxWXl29IbyjYtJ9Gc1szubOjABGYU0dliZjzgSmYApYm7guokD69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyE+2kKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyE+2kKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BDAC2BCB0;
	Tue, 21 Apr 2026 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781121;
	bh=3Ct/SPVIVJ2+EBRzhARfaZ8x6ntKDyeLe8hrRi9Fxd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyE+2kKa3AXBCXD9eLv1BEVn3pPHTE6Bhhn0ZQ8hqgpujDTRUlUF8fDaF8M+bLFu+
	 kbsxmPqMHi2eHDnqFXUJpMV4UE3yJ5Oig9vJcLL4HQAzI8sFzUk4pw3smjkLDLuX1H
	 DLnwOVwny8NmJneBx+LOcTjyklGdHmNHO2se2NWQ0jYtj9f8oO24rjkIbV729U9/m8
	 3LPqdB59mZyhmh0FAS2i16wI/6NDg74tUUEJGd121qxkDnJoAp5hh/TlfUoRglS8yu
	 XN/sYN5ZOuDlCuFyKP9PnHOmiR1oRNR7TQm1Fcvz8rdtAKjUIT92kjHJ2GTRxRQ9QI
	 Ritnpo5/GhytQ==
Date: Tue, 21 Apr 2026 07:18:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dexuan Cui <DECUI@microsoft.com>, "patchwork-bot+netdevbpf@kernel.org"
 <patchwork-bot+netdevbpf@kernel.org>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
 <niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>,
 "levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of
 -EIO for FIN
Message-ID: <20260421071839.30217a60@kernel.org>
In-Reply-To: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
References: <20260416191433.840637-1-decui@microsoft.com>
	<177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
	<SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
	<CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 09:28:19 +0200 Stefano Garzarella wrote:
> > I'm sorry -- I just posted v3
> >     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> > and then I realized that the v2 had been merged into the main branch :-(
> >
> > Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?  
> 
> Ehm, I'm not sure about the process but if it's merged in net tree,
> maybe we need a follow up patch.
> 
> Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Yes, you have to post an incremental fix
