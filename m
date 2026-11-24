Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502602;
	b=lRsIoGeNJx0qMp6673rrYtxn8B7D+C52zRtke9/BX5umxK7TL2Q+PEoK4djx6r3OJKUp
	 UJu2Q3CzvSGMrF2iecEnW/9qlyE0E1bjcPotGR9sFiRMig2gXzZ7+JFkaUbsRYGwutw4C
	 EVJ6+mcTUsi4Ui0k/moKTAPvpMRteRjxt7Z6vOVlx3Zr+VjyBU8gkybBc4hTmYgGeg+QX
	 gVrS2WXWxz7Zd2fGj1lx5k9OzWxgHjX+JMObVCht15J51GfbZgFeq+gOvWwhQtFsugz52
	 /azw4uaiIupLXynNVnpGIh7B6WjU6F2d6xphkEoM2/s+gz2YLM/LrfDiCnWBwHmxLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502602;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=/FIMUk4DjdqAEpPRiRceY+ufT5ushr8GpAhLItS8WTk=;
	b=bVbEMTinwG2ndVsxkbfuZ62cKtjQ3RWocxxSnVqfgl6leabeX/Ir8SsUPr+bbNP29POX
	 AKDVFNTIiUcbipf4AevLI2ROH3voJrt2Jo1cqSXMnZY6pWTZYngkN/GnlZKNgXZjQOoLG
	 OrsmfvV8/qRJ7Ms5NTPWkciTIZpdG7/LmKSsN4O0X8F2tkszi9rDR4Gimb8wwBrdlMIuc
	 mkMPUd5O20VWV+FJjFwoqVAWiDgqpYkRGB8xWRRVukL5ArRBnLMp/vLJwwR7WeEdXMXqp
	 I4n808vUhdvxByAGUAyyPJnaBU5tmsY3IIip7V6ZOyjLgU4Nheha1iIkZc0zFV1yRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NRT8GEqJ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A79606A31E;
	Tue, 24 Nov 2026 06:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A79606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NRT8GEqJ
Received: from [10.95.64.197] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5EC820B7167;
	Mon, 23 Nov 2026 22:43:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5EC820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502597;
	bh=/FIMUk4DjdqAEpPRiRceY+ufT5ushr8GpAhLItS8WTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRT8GEqJguK14ivZip1z9Km23R+8pHydunM5DtF9c/uWnqkl/HG3wLL6zd7eWksUd
	 B8u90YwGruBJPlv5RsszwDtNgESyENaag+EEH+Qn0CfcLw3zQ9R4WuwMBwWyjSAhxO
	 8hgdVKNXg7mBa4Sw8DYinkaPNbxGi04GUpqOflYI=
Message-ID: <4ff748e6-78b0-4ce6-b787-f102e4f8c6b2@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:13:13 +0530
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
Subject: Re: [PATCH v2 0/5] x86/hyperv: Account for lazy mm_cpumask
 maintenance
To: Michael Kelley <mhklinux@outlook.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>,
 "houwenlong.hwl@antgroup.com" <houwenlong.hwl@antgroup.com>,
 "qq570070308@gmail.com" <qq570070308@gmail.com>,
 "bastien.curutchet@bootlin.com" <bastien.curutchet@bootlin.com>,
 "dianders@chromium.org" <dianders@chromium.org>,
 "jgross@suse.com" <jgross@suse.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FA48FAC9BF8447B305A3D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863FA48FAC9BF8447B305A3D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:44 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>
>> Lazy mm_cpumask maintenance leaves CPU bits set after switching to another
>> address space, with stale memberships removed by native flush callbacks.
>> Successful Hyper-V TLB flush hypercalls do not run those callbacks, so
> 
> I'm not sure what the "Successful" qualifier means here.  See comments
> in later patches of the series.
> 
>> historical memberships can persist and cause unnecessary remote flushes.
>> If the mask covers all present CPUs, the backend selects an all-processor
>> flush before reaching its per-CPU lazy-TLB checks.
> 
> As noted in subsequent patches, "backend" is very vague.

Acked.

> 
>>
>> This was found while investigating a regression between Linux 6.8 and 7.0
>> in SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs.
>> Recreating DataLoader workers each epoch caused host-to-GPU copy stalls
>> and timeouts. The reported bisection identified commit 209954cbc7d0
>> ("x86/mm/tlb: Update mm_cpumask lazily"). This is distinct from lazy TLB
>> mode: a CPU actively running another address space need not be lazy.
>>
>> Patches 1-3 prepare for target filtering in patch 4 while patch 5 adds
>> immediate cleanup.
>>
>> Patch 1 rejects VP-set conversion failures that return zero, allowing
>> native fallback rather than issuing an empty-target extended hypercall.
>>
>> Patch 2 makes the native target predicate reusable, retaining its
>> context-switch ordering and adding a clearly named callback wrapper.
>>
>> Patch 3 uses native callbacks for requested mask trimming and global ASID
>> transitions. The latter need guest callbacks to switch CPUs still using
>> local ASIDs; a Hyper-V invalidation does not do that.
>>
>> Patch 4 filters targets before selecting either hypercall format or the
>> all-processors shortcut. Page-table-freeing flushes remain unfiltered.
>>
>> Patch 5 separately requests best-effort cleanup when no remote target
>> remains after filtering. Lazy memberships may survive this cleanup.
>> The cleanup policy remains open for discussion.
>>
>> The suggested mask-weight > mm_users heuristic was tested as a replacement
>> for patch 5's approach on a 32-vCPU Hyper-V VM. With three remote readers,
>> mm_users was 4 while lazy memberships kept mask weights at 26-32. The
>> heuristic requested trimming for all 10,000 flushes, and each reader
>> received 10,000 remote callbacks. The scoped approach used Hyper-V
>> hypercalls instead. A doubled threshold or rate-limited policy has not
>> been tested.
>>
>> Earlier testing of the monolithic patch reduced the 32-vCPU all-history
>> reproducer from 17.235 us to 1.622 us per iteration (two mprotect() calls
>> and a write). The reporter's application hit the 600-second timeout on the
>> unpatched 96-vCPU VM and completed in 424 and 436 seconds with the patch.
>>
>> Changes since v1:
>> https://lore.kernel.org/all/20261029064234.362385-1-namjain@linux.microsoft.com/
>> * Split the change into five patches with separate explanations (Dave).
>> * Add the workload and regression context (Michael).
>> * Explain the ASID fallback separately from the reported regression (Dave).
>> * Keep related predicate/wrapper names and comment the definition rather
>>    than the header declaration (Dave).
>> * Explain target filtering, page-table freeing, and the no-remote-target
>>    cleanup condition. Document the const copy and lazy-membership limit
>>    (Dave).
>> * Test the mm_users heuristic and retain scoped cleanup as a separate
>>    policy discussion (Dave).
>> * Omit Fixes tags and stable requests (Dave).
>> * Rebase onto next-20261116.
> 
> I've provided comments on the remaining patches in the series, mostly
> around the AI-speak in the commit messages and code comments. I
> still intend to look more closely at how/when to initiate trimming, and
> may follow with additional comments on that topic.

Acked. Thanks for reviewing. I'll wait a couple more days before sending 
the next version with the changes.

Regards,
Naman

> 
> Michael
> 
>>
>> Naman Jain (5):
>>    x86/hyperv: Reject unrepresentable TLB flush VP sets
>>    x86/tlb: Make the conditional flush predicate reusable
>>    x86/hyperv: Use native callbacks for trimming and ASID transitions
>>    x86/hyperv: Filter TLB targets before building hypercalls
>>    x86/hyperv: Request mask cleanup when no remote target remains
>>
>>   arch/x86/hyperv/mmu.c           | 71 +++++++++++++++++++++++----------
>>   arch/x86/include/asm/tlbflush.h |  1 +
>>   arch/x86/mm/tlb.c               | 18 +++++++--
>>   3 files changed, 65 insertions(+), 25 deletions(-)
>>
>>
>> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
>> --
>> 2.43.0

