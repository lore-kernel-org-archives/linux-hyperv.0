Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19AA20E6;
	Thu,  5 Sep 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513626; cv=none; b=MuRzm9mH+jC2WGIgdN3ez9Ibht3l82UrvDYsZ0Oe8sdPIXgeYpMz0/aHNozGFd7Xc0syDFYjwvTtB2aYcZVnP1qN+35esQNlBwJRH8keZT2Eelkt2VrlEtERwIR+Y/GBzG5afqgroP7JP7NlDwmbcWosfvK14hPihQvMcgv18eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513626; c=relaxed/simple;
	bh=6+luWdIv9Wrs1LHHvcLbmKvEvv7SFe3N2xLpL1Z1Zig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7fHqhB1rRrDoqx/cuJTwuJ0ETzbi2t5z5ptlBXbnoDUnp6PBNwOewie650j7g+D+DENAiNHqqKhasaKyL691j/LwkDYxDoSPDFTQjR8gw7FGVQdDcM7TsxOJKMITrxJu7yUd/P8MbGgDrFGUBUtrRodiKrXAVPzLztP57Abk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ocK3UQFy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ocK3UQFy"
Received: from [100.79.0.216] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93BEB20B740C;
	Wed,  4 Sep 2024 22:20:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93BEB20B740C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725513624;
	bh=voA7K9yAJ4nfkKJ4vkC+KujYPi/zFF6JkLSxCCEdCzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocK3UQFyrqdi3VSxoOSRPbVXNvUSpJLYruvNctG2grEGeUyTGx05v4MIoqPIv+MUM
	 7BvZ3UGS1/40drVsArRzknKDehzcvC6+O+ZQF2/Z3Oy9rwQs2X0C+ARVQN0K5v9XD0
	 aE9Ko/ubk6FwgT9rFoRzQt8AXv9PwOwQ+fIXhjJU=
Message-ID: <938405f9-2f71-491c-a07b-6968105823c9@linux.microsoft.com>
Date: Thu, 5 Sep 2024 10:50:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: hv: rm .*.cmd when make clean
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, kys@microsoft.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2024 9:51 AM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> rm .*.cmd when make clean
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/hv/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 2e60e2c212cd..34ffcec264ab 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
>   
>   clean:
>   	rm -f $(ALL_PROGRAMS)
> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
>   
>   install: $(ALL_PROGRAMS)
>   	install -d -m 755 $(DESTDIR)$(sbindir); \

While your patch is supposed to work, below code is another alternative.

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 2e60e2c212cd..be90be9d788f 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)

  clean:
         rm -f $(ALL_PROGRAMS)
-       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+       find $(or $(OUTPUT),.) -name '*.o*' -delete


Regards,
Naman
