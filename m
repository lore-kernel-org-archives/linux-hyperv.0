Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA79463
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403540; cv=none; b=q+YDCA7+F5z1gWril86oBfgtUmSQFNAKAsQjHGNBXO7P1p4BP9ZgPV3Zk8Lx5dOdrgDZEoRGQ8SNtXxOmJQ3eqfzOzupYOhWUsLMf3YDY0SeCpNkc+L2lLzKkIZMKAmqnRfewscnggw/ducf7ZKM0o1fiv7/CMxbP7SB2zGD66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403540; c=relaxed/simple;
	bh=KgPJePNXcynL5wVdvESOxTecPqRWFfNIHcFNR4q+q9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5VI5oyItsBunZvqY9l0T8RHAyQvj9pIHUWtTlr/A+76XsNa6ew4zi6Mkstzj4RfBlXFSOTodc9RUwUqLVEPSXqRPZlyIi9VYyneo2173Jl0shj4fI14WTFLW75OTpu4ygyT21bRENNx8twJl9Lij3FAZW17wU5xN4vPLMuGNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pht8evVM; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pht8evVM"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c7ed771dbfso697095ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403537; x=1783008337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2MJP6G+0qiz8VruHee0NS0DtXdE/aa4R8BvTRRv9rU=;
        b=Pht8evVMH8uAy8YyOIR+NHbB/QuSgB/d3L5cl3CxOuf3Xt9cji6s5xP7gqOAc8LZaz
         76h3PpodPpZH5ojY3Esbhu57ixM9kx/Esrqj4r0fc6sm7v1At8Y6umX0JIPpN5IamOkQ
         nmtw8T/LCJb8kPY96S5k9GCfZb4k7/j91Si0U5Ww+iELWYUWzaXIAv36qcYB8F5QL6G7
         TghBU65QihvIk0tQG/mKqCH+5DP2omBMZiI9aLntVeyX3TCKIE6/o51HX1xNbzpxtzgF
         OLSvEAOX4w5+eZ6gdJHyMYwU5RR9QcxHc8kPTc1s+rX1e+PJgEA1DxXgmZVMhkP+07mL
         KKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403537; x=1783008337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2MJP6G+0qiz8VruHee0NS0DtXdE/aa4R8BvTRRv9rU=;
        b=apWuXNM+9lpERnhN8Xe6lYxkAfpC3xJuIL0ro5b+etk6/1FvQaYWNoZ5sB28Dz3Zst
         nj6CFcdB6uvCcQWdYTh00sBr2SsMJpViSxlklp6UPlLVMYt7mCl55csBWZZI4SuxjqYL
         vTXk4bR869qKF/2QJH2imfFRfn0rRBe0eBOnjYZJPC02ZpBdYTdmyRnvzktt6fFi7JoM
         lMxJFBm5MmAjJ0o877l0lTgBhgyFCK3nSJth6SU9lz86Oge5o6Rulti1L1IFiYrWGZ0B
         QsK9tJqX3Q2Kw9FtM0qxNQluWP7+29kQJQ97b423PFe6y0H2EjWj7kKdlkpK6ca/ZOM8
         kq1w==
X-Forwarded-Encrypted: i=1; AHgh+RqF8Tq+1jMRPuJvbC+OlQsdTxgpjxEta5zvhw+5bao77hbEtSV+VQ1s43L8zs/8D+8ZYwAEfmM4bVoyaps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5TWiJUzi/ClOxPASlLN6LR4JtcNlncpONxl26TLd9ak9yCOa
	WW6ZPLsTnyeAmJy3xVAJDFA0kufUuXg+q4oQNGrkjJ60YsnD5fdA9iYC
X-Gm-Gg: AfdE7ckc1Ou1ddXTlK7X95ajMe029FdSmG9udh7QTPzylmDylDX+HFLptxGmK5mRSgE
	8jQjqFVSZWEElTaTkAEYUyMaFaic3e1axyfHWPuj5eY0SzByyL1ofiffG2WF7cvD7stvXVWv9pA
	VleBGmYElhVDrddx6Rfhk7N4qHWJ7BOAD4lkT/Fj2KO90vW+cRG0h045vj+hJEGJGkkouT+2TcD
	aIRdQq02KSmwMGu8anAgS7d+S95rGkfVrkM7vHtEa/BneASFMGOvqPVTraAYYO9WMJoexuYl7QF
	Uk5Sd3XsWQW4oX4MzsSOHSg/P93ZGgjgBgtnqRX6YFfq3rSN5G7a03/DXLJDvk1AJd/O75Zrw0b
	kehin3Bp5h9QFU3fnnJdtTYs5B1W7kde7D2wv2s66ESxDtu0c8s4iBL/uDDVE4n4LYL2BlRkBp9
	kMPRTl
X-Received: by 2002:a17:902:ef03:b0:2c0:d9b7:b7a3 with SMTP id d9443c01a7336-2c7fc740665mr30975935ad.21.1782403537535;
        Thu, 25 Jun 2026 09:05:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27dasm22916635ad.45.2026.06.25.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:36 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:48:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Breno Leitao <leitao@debian.org>, joshwash@google.com, hramamurthy@google.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com, 
	kernel-team@meta.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, jordanrhee@google.com, 
	jacob.e.keller@intel.com, nktgrg@google.com, debarghyak@google.com, mohsin.bashr@gmail.com, 
	ernis@linux.microsoft.com, sdf@fomichev.me, gal@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: keep rtnl_lock for ops using
 ethtool_op_get_link()
Message-ID: <aj1Nqe3RoITzxSEb@devvm7509.cco0.facebook.com>
References: <20260624190439.2521219-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624190439.2521219-1-kuba@kernel.org>

On 06/24, Jakub Kicinski wrote:
> Breno reports following splats on mlx5:
> 
>   RTNL: assertion failed at net/core/dev.c (2241)
>   WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: ethtool/1335
>   RIP: 0010:netif_state_change+0xf9/0x130
>   Call Trace:
>     <TASK>
>      __linkwatch_sync_dev+0xea/0x120
>      ethtool_op_get_link+0xe/0x20
>      __ethtool_get_link+0x26/0x40
>      linkstate_prepare_data+0x51/0x200
>      ethnl_default_doit+0x213/0x470
>      genl_family_rcv_msg_doit+0xdd/0x110
> 
> Looks like I missed ethtool_op_get_link() trying to sync linkwatch,
> which needs rtnl_lock. Not all drivers do this - bnxt doesn't,
> it just returns the link state, so add an opt-in bit.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
