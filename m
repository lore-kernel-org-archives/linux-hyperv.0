Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B0313293;
	Sat, 19 Sep 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858896; cv=none; b=isZT59DqDDjFbENNEdOI4kYx90fD1y2gUuHvRsDQ9veVgJm8BG6WYphV6Y+eqFJsnMxhZImg4ZSZwix6JdSH5vq4IwD7QSc36/jD5D/Tu8ut3mU3KwN/3wS6V+1S9UlL2ON/bOHXNnAzvmdl2H89I47d/O8yGVpruPLQUK9OO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858896; c=relaxed/simple;
	bh=DLvSffMEWO/zgeVYKxCvSK8Qf243kitp0txfQfa8hIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2248ilKnbwyajmiiwp0f7HVmINMpF89oaFE60P4gd+iYYsEV9StA+0HVQ9E0T0LjPZTlS1a80oeIBegpgqHValZ6mj9ooJZ+CEWpYBmV9ReWM7oaw7ZtYVh7pdFfyOGqghgLPHzuklHwnsqPTeok9zcVChibwWERksDsRuxsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKUCitWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKUCitWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B81F000FF;
	Sat, 19 Sep 2026 23:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858895;
	bh=BAjpmyGPSiOS56oilR/js/1YvQt5mNtEuMewwPlDQO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKUCitWObP7Ews+Bvzaz/5IKMfXe5veuVyYl1qeq32nFrqr7F3XXMiva4gB7SRLti
	 OqQWm/fGLq4NWfg479RoWuJ+GACeo8QaXmHSUgfFOy9J6QaElThCmG9gdq9ofD3+Xy
	 /YAQT2U4s4aQZSKuQw8EKM5kqCCuF6QhMhIMGuMFSL5TvnstMB+WBMnGnXiCn92Ffa
	 fw8qUdvhX25h1zFWBWpUlR4h22xQPI3HrmXEDcCn6HV6Db0gx/XIWHMQk5Yn8MzxDT
	 ttuvMbIzMgt9xdMNb+9NCnlAtLAQtu1OYFWY9TinUNuA/APLjQzAUJK0yS3qxS8y3d
	 RVQj5Wm+i9STQ==
Date: Sat, 19 Sep 2026 16:01:33 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Drivers: hv: fix typos in comments
Message-ID: <20260919230133.GA1008213@liuwe-devbox-debian-v2.local>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
 <cover.1789455635.git.hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789455635.git.hemanth.selam@gmail.com>

On Tue, Sep 15, 2026 at 12:31:43PM +0530, Hemanth Selam wrote:
> Two one-line comment typo fixes.  The diffs are unchanged from v2.
> 
> v3:
>  - Trimmed the commit messages down to a single line each (Wei Liu).
>  - Dropped the Assisted-by trailer naming the model.
>  - Moved the note about the v1 -> v2 subject prefix change out of patch
>    1/2's commit message and into this cover letter: the prefix became
>    "Drivers: hv: vmbus:" to match the subsystem's history, as Michael
>    Kelley pointed out.
> 
> Michael Kelley's Reviewed-by is carried over on both patches, as neither
> diff changed.
> 
> v2: https://lore.kernel.org/all/20260907044946.10813-1-hemanth.selam@gmail.com/
> 
> 
> Hemanth Selam (2):
>   Drivers: hv: vmbus: fix typo "substract" in comment
>   tools/hv: fix typo "retrive" in comment
> 

Applied. Thanks.
