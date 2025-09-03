Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C32C18A;
	Wed,  3 Sep 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928431; cv=none; b=Jg5ubISKPyigEuq16HdvpUh0MQoZpmiUkc5nWvW01qeYHpPk6aJbpblv+BbY27OisoePRNi/+iErxpLoExLlP9V2+1hth2EdisD+wnVMsmNnscrZA8CW2/dgGzurSwP1huAnCqGBP1JfR7nWxYxnTjnsZtezOl6aG5dbxJrGdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928431; c=relaxed/simple;
	bh=JI8xjUkMGnccCXbWE68z49u8YEKBr4YpkrEV/CM4qEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ncseaXLPdmyUucvfC3Kf6DSxptRQBJ0+uBzpSDiTd8VWOe3Ts5yM7xRimTjQ8wvPilcfm8LXGXWkqrKaTzCxs8Zf9iXAV1MxAWt+cj+K2K3m0W7tlEjz2wr3s/LnBF4OrpGX0YNgYxjtp2VpxQyZXxc/lAbM+2FBvCyH4yxXCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sWBpejXA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sWBpejXA"
Received: from [100.65.128.180] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 191FF21199D0;
	Wed,  3 Sep 2025 12:40:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 191FF21199D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756928428;
	bh=wTcgDjQ5eMFf/i1ar6oTU5YNVSoLPTIxypfGHzB4Sfw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sWBpejXAdfGKvgRmnUTzAZBTUm1dUVwlWUqJxZrJ1tgRUcnjOTl46TD8kUEhGpdtv
	 Gw+hc1vdpNNdeGJUj9og7ibIOeyFmBDWZQ/fklMrlehyn6NFHt+xgumaL1HlJowAOg
	 SAOztUw4YS0rKLTP+jy3A9ndUywaKpiQqkVmkrcc=
Message-ID: <0105fb29-1d42-49cb-8146-d2dfcb600843@linux.microsoft.com>
Date: Wed, 3 Sep 2025 12:40:27 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
To: Nam Cao <namcao@linutronix.de>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Marc Zyngier <maz@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1752868165.git.namcao@linutronix.de>
 <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/2025 12:57 PM, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
> 
> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
> doing more than it is supposed to (composing message content). The
> interrupt allocation bits should be moved into hv_msi_domain_alloc().
> However, I have no hardware to test this change, therefore I leave a TODO
> note.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>  drivers/hv/Kconfig          |   1 +
>  2 files changed, 77 insertions(+), 35 deletions(-)

Tested on nested root partition.

Looks good, thanks.

Tested-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
