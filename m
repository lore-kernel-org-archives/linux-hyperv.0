Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B849A3AB;
	Mon, 19 Oct 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400866; cv=none; b=hK7GnPALigLiBDiJ34r61u7KlmRRi0tw5w56GtBJ/u6L3CtvuVDrB2eMTu+jRoqpCDeHgEyx/nqv46abIXsQYgAgzZVu5tdBpTRxmBL2QTQXcXs4FhSLVKFL8Fz/MNOyL5lcquOs4ZtsmviCWPcvOSO07RsChDRki/mXpM7CXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400866; c=relaxed/simple;
	bh=+10VJtpyBQ72wzq5Nb9BBeqVR7geSvFh24503lC8YFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpNQitEfBx9VON8mYvFTVoNOq0tCGpALGbMmB5k2FjHXOJoImrq+IUE+KlHRUqz4VlUQwr6SNrxbKl97Gddo4LlJjfg84dgHLYgWMtPzJIgKAOr/WfruIrkUni8TTxth0D8LMLEEgwZ/YUhLfEbfmhPg6G6OCTI6vLmQcH+wP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fSjMWvQH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fSjMWvQH"
Received: from [10.95.64.89] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9BEF420B7168;
	Mon, 19 Oct 2026 02:07:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BEF420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792400857;
	bh=OH4vWuOgczp+V/xBT0eeZsAh2EAied0ct7EXt9CRiVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fSjMWvQHItQ++eTpDTHVzd1dczhW4kF/wpVfWg6Ud5Ih3gYKoX7YWP/6z6yG9z7fW
	 4m/DgBlUSXJPSDG8xj8GVhJ0KOcZIREM0RSeo+tU09k0ec5vOu7v4R8l5McZxjGeer
	 D9ekdniR6EPWyiXPaqNB7xAjmOpJCVRJJnunj394=
Message-ID: <61e6d816-7cd4-4124-960c-805f7689b568@linux.microsoft.com>
Date: Mon, 19 Oct 2026 14:37:39 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mshv_vtl: fix poll waitqueue handling
To: Daehyeon Ko <4ncienth@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1792398881.git.4ncienth@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <cover.1792398881.git.4ncienth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/2026 2:13 PM, Daehyeon Ko wrote:
> MSHV_SET_POLL_FILE retains one embedded wait entry per CPU after vfs_poll()
> returns. Two independent bugs affect that state.
> 
> First, a provider such as signalfd may retire a non-file-owned waitqueue
> with POLLFREE. The MSHV callback leaves its entry linked and retains the
> queue pointer, allowing a later replacement to access freed provider
> memory. Patch 1 detaches on POLLFREE and introduces an RCU-safe removal
> helper.
> 
> Second, a poll callback may register more than one waitqueue. MSHV inserts
> the same embedded list node into each queue, corrupting the first list.
> Patch 2 rejects a second distinct queue and uses the common helper to
> unwind the first registration.
> 
> The roots, triggers, effects, and runtime oracles remain independent.
> Source-equivalent KASAN/LOCKDEP tests reproduced both bugs and validated
> the fixes. The local system is not a Hyper-V VTL2 environment, so the
> series has not been exercised through the real MSHV ioctl. OpenVMM does
> not exercise these paths in its current use of the interface.
> 
> An LLM assisted the source audits, fix development, and validation. Each
> patch notes that assistance in its changelog.
> 
> Changes in v2:
> - combine the two previously standalone fixes into one series;
> - rebase onto current Torvalds master;
> - introduce the removal helper in patch 1 and reuse it in patch 2;
> - replace the obsolete Assisted-by trailer with changelog prose.
> 
> Previous standalone submissions:
> - POLLFREE v1: <20261017141527.623376-1-4ncienth@gmail.com>
> - multi-waitqueue v2, now withdrawn:
>    <20261019070438.3732624-1-4ncienth@gmail.com>
> 
> Daehyeon Ko (2):
>    mshv_vtl: detach poll waiter on POLLFREE
>    mshv_vtl: reject poll files with multiple waitqueues
> 
>   drivers/hv/mshv_vtl_main.c | 51 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 46 insertions(+), 5 deletions(-)
> 
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222

I would suggest you to generally wait for a couple more days to collect 
other reviewers feedback as well, in case someone is reviewing your 
changes. You can then address them together in the next version.

For the series,
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman


guidance: 
https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient



