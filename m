Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962FC14A;
	Tue, 28 Apr 2026 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334800; cv=none; b=uEDHFNvV9ofnyWhkiHH0ifeW5ai4N3KeNF8oNzbXDiTXO0RDGaIB5q/xJHosBhfZptHLKY7r/8qnF9bEHLe+iTwfWCchZ/t0xUrAhNBXEEf1LLxmneRrKxIvnUubunxeHRsOSRM+s/zVSEbY5knpo1jGJWGgZAzALGG1jNBMLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334800; c=relaxed/simple;
	bh=v5xF8URNYI+qlU0ksb3uicajfE3SlBSLk0529expY4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIzeMRA0gZetKYY4XP60QSW5HNt4WFl+sUghr0a5upn+laaao/rpS6KlClVBukDdk5g8joqggQ2vWVG+yii4CMWdhGLgSuyUHtR68OxtAsclUKL1n4ayTKV5WE3mfH3WCQ+GfEFaVY08QM7ohjbqjjphOGfqOYVbJhGQx03pIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHZ0eoeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHZ0eoeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B4C19425;
	Tue, 28 Apr 2026 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334799;
	bh=v5xF8URNYI+qlU0ksb3uicajfE3SlBSLk0529expY4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHZ0eoeQFQH4znXi7HqJMe9zkwZIwxKJpTjBhUhdD0yM4bc3lj0VQSFpMr6ndEdwd
	 VG+jCzNLRTJThF89EhxHWG43FULj42Wugi1Ny6K7WTmEJ9C8KR8pfqHQUZjZzpdJE8
	 Hwc2Tb51pbA1GmycPtDdUYjyIUDoSpGooR/sChVHYhx533Ag+rlAL2Mk5iw79L99PE
	 xk4Vt7IdqF4Laa0JZzmG4pE9bBcZt9hmwNHuDaAwVGBJh82SiHHAcXMmgwNraPlTUS
	 KhF4BM7qGOcQGexFDfwrBbxmJjX4xMvDVpM0/xCX5mD5BJkJT/jL6K5+rhwptkCnPR
	 1qrby/ooxv2gg==
Date: Mon, 27 Apr 2026 17:06:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Himadri Pandya <himadrispandya@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
 dri-devel@lists.freedesktop.org, stable@kernel.vger.org
Subject: Re: [PATCH 1/2] hv_sock: fix ARM64 support
Message-ID: <20260427170636.7a02bf9c@kernel.org>
In-Reply-To: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 11:17:18 -0700 Hamza Mahfooz wrote:
> VMBUS ring buffers must be page aligned. Therefore, the current value of
> 24K presents a challenge on ARM64 kernels (with 64K pages). So, use
> VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
> hold all of the relevant data.

Please split the fixes into two independent postings.
They have to go via different trees AFAICT
