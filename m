Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004337CD2E;
	Wed, 12 Aug 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554434; cv=none; b=YsvzbOAvyqo0yqiV4PRsFx4ZTz6jC3/nn4VCf29YtDQjB+UdFFfu0bjuamOA27e+/mUjAwhwuSlRBhfNlUQJ/dPw+OxpU8/MA371oK8Lff5ryhGPT770gSqwLwZ4ZbSWkERURaL1XPonJTKPB4IIGfzxYnn7OYUS9st7QMwsHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554434; c=relaxed/simple;
	bh=DKpVAJK+G1/UziHV7PPWXNz6P3/XHMIplfhd0RwbOYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLDaaZbpoXgjbfH2xpMUab7WlSlwzK8qCDatTozw/lqzqGL05TjI5VKGdFQr5cbCxq8+v9aWoxNXzkMAd6Osx+ByUNdE/e22OlLeJquwnYj5Ehvy86Y6wQMp7rncKp+kGLFI7qui3aH+f+lujFPiWWzWcQJCq4tKrRFVpwE6C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EuDeZuDm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EuDeZuDm"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4AE0820B7168;
	Wed, 12 Aug 2026 10:06:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AE0820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786554400;
	bh=Y3TMMO63ks6Ih+bBmlya+yjhJYcjvjrnqjec7VPkjYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EuDeZuDmXaGm07nVRbMtEvSehVrq49bu/kHrEbvTkGZ7kvGQlYBM90qej46Dhs0px
	 sKluM7E/06cinG5w3I0c0avZP0Yl2txYLYXOwnGUerjUNYvLY03wjwmYA7+wOBBRpE
	 qZQbwuEIiiihT7dNZjJSBJjuSuRFVbgmh44SxZ4k=
Message-ID: <930ef455-ac7a-c148-6ce5-15cef6a41d87@linux.microsoft.com>
Date: Wed, 12 Aug 2026 10:07:04 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V0 0/2] Redesign memory deposit logic
Content-Language: en-US
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, wei.liu@kernel.org, mhkelley58@gmail.com
References: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 17:05, Mukesh R wrote:
> This small series redesigns the memory design logic when Linux runs on
> Hyper-V hypervisor as a privileged VM. It has many issues currently. It
> is split in two patches, the first patch stubs out the functions which
> makes the 2nd patch review much easier and nicer.
> 
> Thanks,
> -Mukesh
> 
> 
> Mukesh R (2):
>    mshv: Stub out deposit memory functions
>    mshv: Redesign hypervisor memory deposit logic
> 
>   drivers/hv/hv_proc.c           | 240 ++++++++++++++++++++-------------
>   drivers/hv/mshv_root_hv_call.c |  10 +-
>   include/asm-generic/mshyperv.h |   5 -
>   3 files changed, 144 insertions(+), 111 deletions(-)
> 

Please ignore this V0 series in light of some new information from
the hypervisor team. Will send V1.

Thanks,
-Mukesh

