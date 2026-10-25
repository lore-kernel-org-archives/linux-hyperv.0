Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966358;
	b=KllmTMNl+i4kgGUv5Jfco5NKPFVLN6PWEUpS31O7tE80YR06Ig/QOf/0Zrkm/47RKPVO
	 Y5B3M6ogsK/XZv7xDtab7osIBDmLqMDrcMZahLU0Miz1Czf8BYpS77+Kvuos8kDTU5YSf
	 Gv69n7WQXLsAUqSghJzbEvxu2ZteCGLJY6K12Y8YG8FHHwkAVDYzFFMJ88FZWlD30Ektl
	 Ap9cKsUURlSYUYrhx/GNjmGp9Fy2uHM0Vu85p0I+BCKmjCktHfKN6Hd/gJ1gqm0eQzQpM
	 FLVdIT3ZJ1l2fYX25KiBwtQuw3geN3ohfDED9Nq22Z5e4G+ayNscn6+Pv+4oAQJ/5AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966358;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JL0GWWI0AKKQ8/DgrlnNhQMnfQHvMQfbJnaVOUcgIjQ=;
	b=T0UsdYLGrbOFpbrMv0RN322ENNpqTC3Agp2+49mIx8UMCm5I10j+N42SIwK6lFlaz3Rg
	 bMWBVFR77CHqmhY8nq+w7wvixXNfoGu23uwr3F4VB4FbJZEgfKuVRv2FOLxnjdokzM8TM
	 TlVKybfBuC5UQZ0izvfyUAXSeZy+Zn/3+WCfEVbkl40Sk1iVMnUAsDz9CuRO03FbCy1YE
	 j9VsU9nualjr2HQqagcscWYKhn450JmtpJ6CrTkqe5SLofRqGXz8cP/vopC3UbAj0m239
	 wFA23VSbdPhaE5Vh2s71HTVkL57W43Kh5RABas1RV5YZOO1B2seD6niV0cG0KlbsVYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPXaMPh7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84C606A31A;
	Sun, 25 Oct 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPXaMPh7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A8C1F01825;
	Sun, 25 Oct 2026 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966358;
	bh=JL0GWWI0AKKQ8/DgrlnNhQMnfQHvMQfbJnaVOUcgIjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPXaMPh7bL3idehECX1Sksilw60yVWXQP1tLCxUEsiLS94F4ijshev+T2e5BR++Sj
	 7fcDbMzWvN7BTbvxPLrwh8gVc2HDPy08robIc+apBuDc/ARrRju07I4Hr6xPulYRAg
	 hoU/xv/uKUU0xfIY9g//Jrh8rtwsqr7WXGR9nQeIv7UdOEEEdkAXSOYUY4WpMTJ6sN
	 2opCgZrqDK/xu55tcr2MvpXZOiuHKgUOQiUAzK17YCpSIrSsizt+1k3RWEWGnN9CtQ
	 oYw/uG3j7S4QxmYia3Spr6R7SP9ERD/MUpC80ldNvp+LmnvrrAjYoZzg4ta0LxaKa9
	 NgzMovp9brb3Q==
Date: Sun, 25 Oct 2026 15:12:36 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Remove leftover support for old Hyper-V
 versions
Message-ID: <20261025221236.GB2757597@liuwe-devbox-debian-v2.local>
References: <20261023030527.1611-1-mhklinux@outlook.com>
 <attVUxOyEoUVPYEF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
In-Reply-To: <attVUxOyEoUVPYEF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Oct 23, 2026 at 08:38:43AM -0400, Hamza Mahfooz wrote:
> On Thu, Oct 22, 2026 at 08:05:27PM -0700, Michael Kelley wrote:
> > When removing support for running Linux guests on Windows Server
> > 2008/2008R2 and Windows 7, one area was missed due to the code
> > comment spelling "2012" incorrectly. Remove that functionality now.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied. Thanks.
