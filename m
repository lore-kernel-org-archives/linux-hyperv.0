Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8D3019BA;
	Thu,  2 Apr 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164904; cv=none; b=KzZz4Cy764T69s8Sds0ErBqOFxjz6vMVPSz7FtjFeGcf07Sq3Z2VoBsGHpT110qfMEmTkyW2OpLCuMQ3YBmn83ustFqhXZGMeZkienoWotsP3Tzvg0p7ShRU4RThBtM0iH2ILmvhGvVYqKSEKaFxVr7DCzD0a1Cw5odTvUiMWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164904; c=relaxed/simple;
	bh=/0QlZ1KJ8KtpkaHezOpz0mL7NZKgFv0+qUIs4suo3fc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bn18REzk4RsbZAx8EcQ/bPEn/rxxADBTiR+zd99wpM8wSs0hqbidK8FKFqxQ6RPiftQldu1pDrwjtukMq76N5136s+fq1S3RYB1pJQ9VuoHYvFYSKsLyHcAF0l5hlTV4xhfF3jthUDzQ8etlJ0fcUpch4XjDRdyh0bMYlBJQQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MJm7ZWF2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MJm7ZWF2"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 3AEB220B710C; Thu,  2 Apr 2026 14:21:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AEB220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775164903;
	bh=DCte7zD15GsIRiLEzfiNxmJRz0MxjBwdUaxhRx6/YLE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MJm7ZWF2jVVehi4Jtk2Mf2dGMhWQAxeqBG1hwtztOKzewQSK1gbBvnUJYtBhTLQ5q
	 QRMAbypTAd/85cpmi4TqfbQNdzX+MH0H0bXo4jYUWAIZ4K/h1la2nlUO7zr5DBDmrV
	 Cu47FpGIujhO9S8lsUYZ4ct2jtAoD/4cPvp+2dFU=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 38B0530705A4;
	Thu,  2 Apr 2026 14:21:43 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:21:43 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Roman Kisel <romank@linux.microsoft.com>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <20260402-sturdy-chirpy-cat-78baeb@anirudhrb>
Message-ID: <b9681d7-6166-e7cf-feb-b924c583cdf@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-5-jloeser@linux.microsoft.com> <20260402-sturdy-chirpy-cat-78baeb@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Apr 2026, Anirudh Rayabharam wrote:

> Maybe it's time to extract all the synic management stuff to a separate
> file to act like synic "driver" which facilitates synic access to
> mutiple users i.e. mshv & vmbus.

Yes, such a refactor maybe warranted. This series is about getting 
kexec to work on L1VH, and so such refactor would be ill-placed here.

Best,
Jork
