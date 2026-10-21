Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569318;
	b=MePlSasSWbNBSnB/WygyX90JN7rUd4aDcyj0FDTWTs8/IQ0nJJ0Cw5LTBVZ2ekZYtik4
	 ry9rw/iOfWE4O7duSm+gTJEK7lphgXFURTFuxyW4xHvzooduGXDmLwmdfol9bvg5N7FAW
	 e6id5jF2g5VymYGERRCFGCkFe/hzC/HfyuL1gQSafgQPiyqMnnyHBqQKWlzQQX68Vfet8
	 zQ/W5FAqQ4qBRhyzdmKtokZ/4754qyVtPuEMk3PO/66IZDB42UnMO119vGEVF+gH6WFu3
	 Np4e3cohZKu5CW+ShgmzQ4rUfbG9dGpGpHmKZEbWfABexn81K2ai1ZXz0yrZvJgS5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569318;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m/fqzf4d4DyJh4mvWYiGK6x4TNCfrXy/rEJ5jc6g3LU=;
	b=DzUUaezrmh+SbtlVwrdAAlaA3nB6cEU7GX38wtFkb31EmnEVOJudUGe+PcmmbBB9YNZ0
	 rLx05JkHAMx1jctIno8EgAguiYqj838pv0ronTNdomwVn6a790fJ1VN3hsuq0muq/fCIS
	 dvihN7utS+wYelFg+qYhsXNtaFKmyc6z36RDj99uGwuyatTyn14fXgZXVwbQTxkMzxcrH
	 CG07gd7AH09FhfLysmtONO3M+Wg/dWMt9zW0lRZpwStmFateTvQ5Auh3CEvXEz7+ieirQ
	 s3+Fc46mNFGe+Q4J6OH62pn1A0gKaYIKhHkKc1TbYpasBnu5dVMRdBAWSv4xOe4RBVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG4yNxii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C96606A31D;
	Wed, 21 Oct 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG4yNxii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EB51F000CA;
	Wed, 21 Oct 2026 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792569318;
	bh=m/fqzf4d4DyJh4mvWYiGK6x4TNCfrXy/rEJ5jc6g3LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XG4yNxii5VcUzGLF7YGEaa+gOf8AAPapGOUuo2fPOHBLIq6Y6e04m4V92UFKH3wpE
	 ZTVd7uXIORosC858owYZFalD/bJjvbMVKyLzefwMt+hGfi4q7NMikfHH1alEMvL9zW
	 15Fk2KJBNXi1Is9AdIy+dFxMSx+SNRrSxYwbHc5evoiq1vSQx+jOSkG9p586hTIVdQ
	 NlfKrFlLS97Ku2prDUczyNjaiJCyb1+mKsK1UKNhUJkXzLoAhvkr1W0C77kEJLb5Zk
	 5a2ZbHnbdlH59J863lotAq0arac1i8Eyzi4ydHTEuMvrGxC8RA/kEwjfDFtqyhsA5k
	 /OiFEg7B4VFTA==
Date: Wed, 21 Oct 2026 00:55:17 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Jiale Yao <yaojiale02@163.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv_vtl: initialize poll file mutex before device
 registration
Message-ID: <20261021075517.GL851443@liuwe-devbox-debian-v2.local>
References: <20261018034616.508850-1-yaojiale02@163.com>
 <778a2d3c-19bd-43ec-bc72-26fc02bfea47@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778a2d3c-19bd-43ec-bc72-26fc02bfea47@linux.microsoft.com>

On Mon, Oct 19, 2026 at 10:31:59AM +0530, Naman Jain wrote:
> 
> 
> On 10/18/2026 9:16 AM, Jiale Yao wrote:
> > mshv_vtl_init() registers /dev/mshv before initializing the poll file
> > mutex. A concurrent MSHV_SET_POLL_FILE ioctl can therefore attempt to lock
> > an uninitialized mutex while module initialization is still in progress.
> > 
> > Initialize the file-scope mutex statically so it is ready before the misc
> > device becomes visible.
> > 
> > Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> > Signed-off-by: Jiale Yao <yaojiale02@163.com>
> > ---
> >   drivers/hv/mshv_vtl_main.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> > index d8225242c73f..2b40c9e3bf88 100644
> > --- a/drivers/hv/mshv_vtl_main.c
> > +++ b/drivers/hv/mshv_vtl_main.c
> > @@ -95,7 +95,7 @@ union hv_synic_overlay_page_msr {
> >   	} __packed;
> >   };
> > -static struct mutex mshv_vtl_poll_file_lock;
> > +static DEFINE_MUTEX(mshv_vtl_poll_file_lock);
> >   static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
> >   static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> > @@ -1370,8 +1370,6 @@ static int __init mshv_vtl_init(void)
> >   		goto free_low;
> >   	}
> > -	mutex_init(&mshv_vtl_poll_file_lock);
> > -
> >   	device_initialize(mem_dev);
> >   	dev_set_name(mem_dev, "mshv vtl mem dev");
> >   	ret = device_add(mem_dev);
> 
> While this issue may not happen in practice, as OpenVMM userspace runs much
> later than these init function invocations, but it is good to have the
> potential race condition fixed.
> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied.
