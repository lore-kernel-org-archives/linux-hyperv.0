Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681768;
	b=LyPHPt+Nmt2OQCn7S8xkxYP93we6305XpyLkQKoSFlKgy+VUlygRFppCf2iFrOGCvTAO
	 CUOf62imHAlNmjYZKN86svIKMnaMqpdRrbqJWyAEV3OhzSieUR6l2ypnRaRvC38u6icq+
	 mpAYuK3fmB3dzI3JoCyHE0/uwaW7Y67hLWwKVK9FMEOo9Hp8qKNTgF7fZ1ExBs3GW9Zql
	 dnmRMM38YbbGo2u4uhiGJRE8ZFIqayrG7HaSABd0zPTevc97TCmJNvcbVVX82Rse/N2PM
	 VPPsr/J2X+w/5z06tF3F3yEc8ZcDkMu3WZIQPrtRaOeHxZUVuUdeJQMGUtHePakkNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681768;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=L0MH+WY7W2IyeERUsNUC9ccH275eDe5FF4UkWWR+tZg=;
	b=JkDz3v90J+S9AOYB2d++VDTyiiep+qLPGhd/eSPJsaez0o0ls9Goxb65g3K3DCVwOSvu
	 6CHvXGMBONPe83tBBmdKKg6kacksy6zLVIjqeeN0KbiC/9tkW4Ucq4F9qAfQwBUYsOam9
	 VgEW6yeZ3w0u4U9S4gb+W9gG2mOrbd7z0KOskcbXBOSTxbfI9c0RCvqXdcXVqJJeH6Apx
	 pEUDBWVpqBEEA0M14MJSMnGZc81emfG6BniB4BM37wgMzxXlXDNktQkUieDfOOsTVM3gn
	 QbmhwBHp15FYedd1ig44dDn42Y1QlJm4uldEF9wP5/8WN5ZbhnOfxTjjRXxNq4JafSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DKzorImD;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C3606A31C
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Nov 2026 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DKzorImD
Received: from [10.26.7.43] (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id 528E720B7166;
	Thu, 26 Nov 2026 00:29:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 528E720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795681761;
	bh=L0MH+WY7W2IyeERUsNUC9ccH275eDe5FF4UkWWR+tZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKzorImDroJ2ksuIjLDNZ83wK91fsW9vH8s/95EgfyIeH8/W71AHHbiv20HNMknqG
	 1A/Bgas0KzNFKCTa7H43GTdlnDFAPrcSPVlPU3aDDk6fnb6IzR64qvT8zRL37O5smM
	 P3gYjxeSd/LOlElTpWLeKZEFxlriTw+Khg7R5pOo=
Message-ID: <ed8b8d34-debf-4f8a-b026-0e049eede19e@linux.microsoft.com>
Date: Thu, 26 Nov 2026 13:59:23 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] hv_balloon: hot-add request larger than 64 GiB is truncated
 (page_cnt:24), host and guest memory accounting diverge by 64 GiB
To: Artem Matviychuk <asm@sysadmins.club>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>
References: <5c4f93c2d38443348ef29b57547c10c0@sysadmins.club>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <5c4f93c2d38443348ef29b57547c10c0@sysadmins.club>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21-11-2026 14:56, Artem Matviychuk wrote:
> Hello,
> 
> On a Linux guest with Dynamic Memory, a single hot-add request larger
> than 64 GiB seems to be truncated to its low 24 bits of page count.
> The host then accounts for memory the guest never added, and later
> balloons the guest far below its configured minimum.
> 
> Setup
>   Host:  Windows Server 2022, build 10.0.20348.5756
>   Guest: Debian 13, kernel 6.12.113+deb13-amd64, Generation 2 VM, 32 vCPUs
>   VM memory: startup 32768 MB, minimum 32768 MB, maximum 131072 MB,
>              buffer 20%, Dynamic Memory enabled
>   hv_balloon: protocol version 2.0, hot_add=Y, auto_online_blocks=online,
>               memory block size 128 MB
> 
> What happens
>   The guest commits about 105 GiB (Committed_AS) shortly after boot.
>   About 50 seconds after boot the host grows the VM to its maximum.
> 
>   Guest log:
>     Memory: 32514644K/33553344K available
>     hv_vmbus: hv_mmio=[mem 0xf8000000-0xfed3ffff],[mem 0xfe0000000-0xfffffffff]
>     [   52.772118] hv_balloon: Max. dynamic memory size: 131072 MB
>   No "hot_add memory failed" or "Memory hot add failed" messages.
> 
>   Host, same second (Hyper-V-Compute-Admin, event 10020):
>     The dynamic memory balancer could not add memory to the virtual
>     machine because its configured maximum has been reached
> 
>   Host view afterwards:
>     Get-VM: MemoryAssigned 128 GiB
>     Hyper-V Dynamic Memory VM counters:
>       Memory Add Operations          2
>       Added Memory                   98526 MB
>       Guest Visible Physical Memory  131072 MB
> 
>   Guest view afterwards:
>     MemTotal 63.3 GiB, lsmem: 64G online, 0 offline
>       0x0000000000000000-0x00000000f7ffffff   3.9G
>       0x0000000100000000-0x0000000fdfffffff  59.5G
>       0x0000001000000000-0x0000001027ffffff   640M
>     /sys/kernel/debug/hv-balloon:
>       pages_added            : 8388608    (32768 MB)
>       pages_onlined          : 8388608
>       max_dynamic_page_count : 33554432
> 
> Arithmetic
>   Boot memory ends at 0x808000000. The high MMIO window starts at
>   0xfe0000000. If the host sends two hot-add requests,
>     1) 0x808000000-0xfdfffffff     = 32128 MB
>     2) from 0x1000000000 upwards   = 131072 - 32768 - 32128 = 66176 MB
>   then request 2 is 16941056 pages, which does not fit into
>     union dm_mem_page_range { struct { __u64 start_page:40;
>                                        __u64 page_cnt:24; } finfo; ... }
>   16941056 mod 2^24 = 163840 pages = 640 MB, which is exactly the size
>   of the range the guest added above the MMIO window, and
>   32128 + 640 = 32768 MB matches pages_added exactly.
>   I did not capture the requests on the wire; the two sizes above are
>   derived, not observed. The host counter shows 98526 MB added, which is
>   222 MB more than 131072 - 32768; I cannot explain that difference.
> 
> Consequence
>   The host believes the guest has 64 GiB more than it has. When the
>   guest's committed memory dropped from about 107 GiB to 43 GiB, the host
>   removed about 58 GiB by ballooning. The guest went from MemTotal
>   63.3 GiB to about 4-5 GiB within 10 minutes (minimum is 32768 MB) and
>   stayed there, logging
>     hv_balloon: Balloon request will be partially fulfilled. Balloon floor reached.
>   every 5 minutes. The host reported pressure 73 and returned nothing:
>   assigned 68.4 GiB, demand 50.6 GiB by its accounting. At that point:
>     pages_ballooned 15634328 (59.6 GiB), MemTotal 3.9 GiB.
>   This happened twice, each time after a sharp drop of Committed_AS.
> 
> Control
>   Another VM on the same host with the same kernel, startup 32768 MB and
>   maximum 49152 MB shows no discrepancy: assigned 48 GiB, 48G online.
> 
> Questions
>   1. Is page_cnt:24 the actual wire format, so that the host must not
>      send a range above 2^24 - 1 pages, or does the host encode larger
>      ranges differently?
>   2. The guest reports resp.page_count for what it added. The host seems
>      to account the full request anyway. Is that expected?
> 
> The page_cnt:24 field is the same in v6.12 and in current mainline.
> As a workaround I plan to lower the VM maximum so that no single
> hot-add range can exceed 64 GiB.
> 
> I can provide full dmesg, the debugfs output and host counters, and I
> can test patches on this configuration.
> 
> Thanks,
> Artem Matviichuk

Thanks Artem for reporting this issue, the numbers reported above look
correct and there is an overflow happening with page count for hot_add >
64GB as mentioned in your analysis.
I am checking on this internally and will update.

Thanks,
Sahil
