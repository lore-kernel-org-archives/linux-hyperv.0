Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926047;
	b=eis1iLm1RpxCGx6eJI26Z9Z4NKUVwqyDplk7K1/b8+bn/cwcPXpt6DOb8pPiUjujQk9Q
	 ziLRLEeGKy/t7lKwyj/eYi/BwOYDdgzFsyQMM+khkXfjx7BZUYe7/c8zuIXHKID+A8Jfq
	 0YgzJtv186mo8t+guZ4XbsxoTCEL1tCfeo286poUDaF8o7ZXU3nuYqvjVZ+TGxwwrY+J2
	 /eKUOpeN3j9z9Rlp8oWdeD28r3Yqa3mXgqSkvD/kxrw8YyPyAszTCr4xC5JZP9v9Ok8NM
	 sp7UKPmUBucli4GJ5xE5B8FSDnr3qBp62QSPLSI638CVrceZrIGPiREpGQUsaCHhcow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926047;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=srdI/9MQxYU5FV9gmsT6pcOyiCKw/BiJ7wXU45ZL8Cw=;
	b=2ejeNVGgyWGeuv6Mx9/ex8H+lmd3K83sAmdF+c7nSlqkY32eOb4efxdRESkIE6K1gLsB
	 aBwPt4QFsBXMJQXFqk410SsnKSjzUp7+c1R0+aLxX6aa1xd96CuppyisZ70sckN3QFJC9
	 B9+zjVwwr2yutr7ZctakR707uF0hGhxBoNug/MuMrtSnVLQkDm+qGISk7bxnfgPwZGq9i
	 nwbgRe66ogVXCJCs3zCBg72GydyXCksEBSXzMdz3xnceIpnuUHUCTyipywGqQvmhrM4xl
	 cXaOQVrP913tOMC/vQX1NysTO1bTEN5OOkj0Hyi6sTmVupwmYRtXYU1TVjx7ROqHn+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QcyR3wVD;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69520606A31B;
	Fri,  6 Nov 2026 00:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69520606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QcyR3wVD
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 43E0020B7166;
	Thu,  5 Nov 2026 16:47:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43E0020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793926030;
	bh=srdI/9MQxYU5FV9gmsT6pcOyiCKw/BiJ7wXU45ZL8Cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QcyR3wVDs0HV2Wtw7Sw3qxNUn2fK9dMnMkr5iSVP/z/uedLZOCjgvbfZlTACymGyu
	 7qVdXJFl95pp7exLIya3G8YCCHuAplij8DoL3eZ2zaLMEZ4yGCYZtyviXGfYusPZiI
	 KXzfgy4vtGsx4CokyNK3hBSEOaNjRbXshOmI+CSY=
Message-ID: <efc63cbe-c406-a41e-60f4-df0659517435@linux.microsoft.com>
Date: Thu, 5 Nov 2026 16:47:25 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Add an ioctl to scrub partition state
Content-Language: en-US
To: wei.liu@kernel.org, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 dblanzeanu@linux.microsoft.com, John Starks <jostarks@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Muminul Islam <muislam@microsoft.com>,
 Anatol Belski <anbelski@linux.microsoft.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029062801.28598-2-wei.liu@kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20261029062801.28598-2-wei.liu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 23:27, wei.liu@kernel.org wrote:
> From: John Starks <jostarks@microsoft.com>
> 
> Userspace VMMs need to reset a child partition's hypervisor-managed state
> without destroying its VPs or rebuilding its memory and eventfd
> registrations. Exposing HvCallScrubPartition through generic hypercall
> passthrough would bypass the synchronization and cached-state updates
> needed by the driver.
> 
> Add MSHV_SCRUB_PARTITION as a no-argument partition-fd ioctl. Hold the
> partition mutex and try-lock each populated VP mutex in index order,
> using the partition mutex as the lockdep nesting lock. Return -EBUSY
> without issuing the hypercall if a VP is busy. This excludes VP ioctls
> without waiting indefinitely for a running VP; userspace must stop its
> run threads before requesting scrub.
> 
> After a successful scrub, clear cached intercept suspend so the next run
> clears explicit suspend rather than trying to consume a stale intercept.
> Preserve deferred blocked waits and notification accounting: a VP becoming
> dispatchable does not imply its host notification has already arrived.
> Keep the locks through this update and unwind them on every exit.
> 
> Scrub is nonallocating, so issue one fast hypercall, trace its status and
> return the existing errno translation. Let the hypervisor determine which
> partition configurations support scrub. Device quiescing and restoring
> guest execution state remain userspace responsibilities.
> 
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> ---
> Tested repeated scrub/run, sparse and 64-VP locking, busy unwinding,
> interrupted blocked runs, concurrent memory invalidation and irqfd
> activity on x86-64, and delayed notifications with separate diagnostic
> instrumentation. The affected ARM64 objects compile. ARM64 runtime and
> hypervisor scheduling remain untested. Doorbell delivery across scrub
> works, but exposes an existing eventfd hardirq wait-context warning under
> lockdep, separate from this change.
> 
> GitHub Copilot generated the implementation and test probes, investigated
> locking and notification handling, ran builds and Incubator tests, and
> drafted this description. Human review selected the dedicated ioctl and
> try-lock policy and corrected the nonallocating hypercall contract.
> ---
>   drivers/hv/mshv_root.h         |  1 +
>   drivers/hv/mshv_root_hv_call.c | 11 ++++++++
>   drivers/hv/mshv_root_main.c    | 50 ++++++++++++++++++++++++++++++++++
>   drivers/hv/mshv_trace.h        | 17 ++++++++++++
>   include/hyperv/hvgdk_mini.h    |  1 +
>   include/hyperv/hvhdk.h         |  4 +++
>   include/uapi/linux/mshv.h      | 11 ++++++++
>   7 files changed, 95 insertions(+)
> <snip>


Reviewed-by: Mukesh R <mrathor@linux.microsoft.com>


