Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956979;
	b=VvKaM6t5K6aIlf0u/PZnKIiMViCTGH/m83RWhZNgmBckmioohlu7u/UcEOljbAtIuXfE
	 81NreGLrT5pvWGkYTHkPcjyPqzW+VGh2IK285SLuOa4Q/3jkxotwIWzJx8c4XEhZUZG6W
	 ktWr2t9NLi/QWFY99HqTCyDMPi2h5vTXWTb2IRcNLosvV7KGDogWa2aB1ndd94xmgOxjW
	 FOeBGdJ65czPSwfmZQLRL7kLmnubToq+IEfNMbePbINY67XNR2xo+xVx7e8he8ozsxHhx
	 s7Oy2hTfIBqKZgRxgwXZtTs96EflGxZCRe3ECjjjLyO3tpituQ5r9lX95mpvA3Zi6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956979;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=KmW5WBJWmVnFMziNJgQZ039kaABRRBYmSmOfckGsXpE=;
	b=aZdWZ49TwoFthoNzsVvZBt4rOhGjqQnCLEebpTO+ZYoBvEGhTG5Uld89tVC1iBsfYi8o
	 Dohn7rgSv+Bp+a8yl92DeqqTCahFWx1DvlrtY4I++wbjx6DZwF8R/KdSo01K7aZ79wd1S
	 X0U0lHUVEtWMu3lbiEx7jTHoaebsmZ4zmjoFnKnHxax6Hnc1umvTPKSaPxPsIhqWA59nw
	 3RZYyv3bpDEEtyN68jLhZHeSBHKGRXkiHM7R4kI0MZDAyR/qtyoQA4AraK3L2MUlGDcT3
	 g5UplrXerCTKLxCx/f7mVDTQ5b12UuK/Ql9e38O7bp6ct6ca6yyetP2+Do6YpbscTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cslWmA0f;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDC606A31C;
	Tue, 17 Nov 2026 23:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cslWmA0f
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8DE0420B7169;
	Tue, 17 Nov 2026 15:09:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DE0420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794956976;
	bh=KmW5WBJWmVnFMziNJgQZ039kaABRRBYmSmOfckGsXpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cslWmA0fpIL5uuhTxjjaXdDqtdWFQzTwEFOgzoMolq7A59xMALVF+Ca2JSX5KYmRm
	 o7svpnQwbNjcExg32+g75tQeYBujD0MUhrEQl3bxLngq28EIeQwKaU75MC0mLNGTtS
	 A7oGxRFD/A9UjGBEdFbRT8Uf4JqVeSoXnoOYM/Q4=
Message-ID: <bb569c87-1a60-c498-98e4-db519e4d7d24@linux.microsoft.com>
Date: Tue, 17 Nov 2026 15:09:36 -0800
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
Subject: Re: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <fd130973-25d6-e706-6822-793f12ba2015@linux.microsoft.com>
 <MN2PR02MB68639EE1AC00187FDA3D5A42D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <MN2PR02MB68639EE1AC00187FDA3D5A42D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 09:41, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, November 16, 2026 6:29 PM
>>
>> On 11/15/26 15:48, Michael Kelley wrote:
>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, November 13, 2026 6:53 PM
>>>>
>>>> There are few issues/bugs around repeat hypercall:
>>>>    o If the hypercall fails, it could still have processed some entries.
>>>>      Fix places where it assumes none of the entries were processed and will
>>>>      try to undo entries already processed or print incorrect completions.
>>>>
>>>>    o Hypercall returns back with timeouts only for HW confidential VMs. In
>>>>      that case it should be retried instead of returning back. Returning back
>>>>      results in error conditions and take down of VMs in most cases.
>>>>
>>>>    o For non confidential VMs, the hypercall could be streamlined as it will
>>>>      never return back with timeouts.
>>>>
>>>>    o Rename HV_STATUS_TIME_OUT to HV_STATUS_TIMEOUT to match hypervisor
>>>>      public header file. There is no reason for it to be different.
>>>>
>>>>    o Minor formatting fix for checkpatch. Error printing missing in couple
>>>>      places when rep hypercall fails.
> 
> In my view, the changes to the call sites of hv_do_rep_hypercall() should
> be in a separate patch. These are just bugs in how the undo is handled
> in case of an error, and the fixes presumably want to backported.
> 
> Handling a TIMEOUT return should also be a separate patch. This is
> also a bug and the fix should be backported. The TIMEOUT is
> generated under a specific set of circumstances -- it's not a generic
> error. The patch should describe how and why those circumstances arise
> in the overall context of hypercall continuation. There's not any such
> documentation elsewhere, so the info should be captured in the
> patch commit message or code comments for future reference.
> 
> Finally, if the looping behavior in a normal VM is to be removed,
> that would be a third patch. Given that this changes long-standing
> behavior, some explanation of "why" is needed in the commit
> message. I don't think this change should be backported.

The looping behavior is tied to timeout, so I think it could be two
instead of 3 splits...

>>>>
>>>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>>>
>>> [snip]
>>>
>>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>>> index 396bcb3db0bc..87c784b9daa6 100644
>>>> --- a/include/asm-generic/mshyperv.h
>>>> +++ b/include/asm-generic/mshyperv.h
>>>> @@ -28,6 +28,9 @@
>>>>
>>>>    #define VTPM_BASE_ADDRESS 0xfed40000
>>>>
>>>> +#define HV_REP_COUNT_MAX	\
>>>> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
>>>
>>> Sashiko noted that this new #define is never used anywhere.
>>>
>>>> +
>>>>    enum hv_partition_type {
>>>>    	HV_PARTITION_TYPE_GUEST,
>>>>    	HV_PARTITION_TYPE_ROOT,
>>>> @@ -128,6 +131,11 @@ static inline bool hv_result_success(u64 status)
>>>>    	return hv_result(status) == HV_STATUS_SUCCESS;
>>>>    }
>>>>
>>>> +static inline bool hv_result_timeout(u64 status)
>>>> +{
>>>> +	return hv_result(status) == HV_STATUS_TIMEOUT;
>>>> +}
>>>> +
>>>>    static inline unsigned int hv_repcomp(u64 status)
>>>>    {
>>>>    	/* Bits [43:32] of status have 'Reps completed' data. */
>>>> @@ -135,45 +143,63 @@ static inline unsigned int hv_repcomp(u64 status)
>>>>    			 HV_HYPERCALL_REP_COMP_OFFSET;
>>>>    }
>>>>
>>>> -/*
>>>> - * Rep hypercalls. Callers of this functions are supposed to ensure that
>>>> - * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
>>>> - * definition.
>>>> - */
>>>> -static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
>>>> -					 u16 varhead_size, u16 rep_start,
>>>> -					 void *input, void *output)
>>>> +static inline u64 hv_do_rep_hypercall_reg(u16 code, u16 rep_count,
>>>> +					  u16 varhead_size, u16 rep_start,
>>>> +					  void *input, void *output)
>>>>    {
>>>>    	u64 control = code;
>>>> -	u64 status;
>>>> -	u16 rep_comp;
>>>>
>>>>    	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>>>>    	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>>>>    	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
>>>>
>>>> -	do {
>>>
>>> Dropped the looping behavior here may be much more significant
>>> than just "streamlining" as described in the commit message. The looping
>>> behavior was included when rep hypercalls were originally added in
>>> commit 806c89273bab in kernel 4.14, long before any SNP/TDX/CCA
>>> functionality was added. So it was present for "normal" VMs doing
>>> hypercalls on x86/x64 the normal way. The looping ensured that
>>> rep hypercalls could not return with no errors but with the completed
>>> rep count less than the requested rep count.
>>>
>>> However, in my mind it *is* debatable whether that scenario could
>>> ever occur. The Hyper-V TLFS describes "Hypercall Continuation" [1]
>>> as essentially transparent to the caller. If a rep hypercall stops
>>> processing reps because of hitting the 50 microsecond time limit,
>>> it should restart and continue with the next set of reps without
>>> the caller having to loop. Commit 806c89273bab mentions
>>> hypercall continuation, but does not describe why the explicit
>>> looping was added or how that aligns with the TLFS statements.
>>> Vitaly -- it was a long time ago, but do you have any recollection?
>>>
>>> Have you gotten an explicit assurance from the Hyper-V team
>>> that the transparent hypercall continuation really does work,
>>> and the explicit looping has all along been unnecessary? This
>>
>> Correct, hence the patch. Waiting on confirmation that it is
>> same behavior all the way back to server 2016.

Confirming, that it is same behavior all the way back to 2016.

> Sounds good. FWIW, old TLFS version 2.0A, which is specifically
> titled to cover Windows Server 2008 R2, has the paragraph
> about hypercall continuation. So that functionality was evidently
> present very early on. It is still curious that Vitaly found it
> necessary to include the looping behavior in the Linux guest
> code.
  
Maybe Vitaly was running into a genuine bug, not sure.

>>
>> Basically, the hypervisor will just adjust the RIP back to the
>> vmcall upon internal timeouts, and reschedule the vcpu. But for
>> hw confidential vms, ie, tdx/snp/cca, it cannot adjust the RIP,
>> hence return back to the guest with TIMEOUT, so cvm has to do in
>> a loop.
>>
>> Now, for paravisor support, I was just told by a paravisor team
>> dev, that it will never return with TIMEOUTs. My view on that set
>> aside, I guess for paravisor we'll just call the _reg function
>> then.  Thanks for bringing attention to that...
> 
> Yes, that would be what I expected.
> 
>>
>>> assurance would be needed back to and including Windows
>>> Server 2016, which is now the oldest Hyper-V version supported
>>> by Linux. Also note that the rep hypercall code is architecture
>>> independent, so the transparent hypercall continuation would
>>> also need to work on arm64 when the hypercall is invoked via
>>> the standard path of using the HVC instruction (the TLFS doesn't
>>> cover arm64, so this is unclear).
>>
>> Both x86 and arm are same for this issue.
> 
> OK, good.
> 
>>
>>> If you have such assurance, then I'm good with the removal of
>>> the looping. But please make the removal a separate patch, with
>>> sufficient discussion in the commit message to justify why it's OK
>>> to do the removal (including that evidently the original commit
>>> misinterpreted how continuation worked). And instead of looping,
>>> perhaps do a sanity check that the completed rep count matches
>>> the requested rep count.
>>
>> Not sure if it's worth the overhead of sanity check, looks like
>> callers are checking completed and loop anyways... But I would
>> be OK with BUG(), since it would be a bug for that to happen. FWIW,
>> it's been running internally with couple months, and haven't seen
>> any issues.
>>
>>
>>> Without such assurance, I think the looping needs to stay. Callers
>>> are not prepared for a rep hypercall to return with no errors, but
>>> with the completed rep count less than the requested rep count.
>>>
>>> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-
>> windows/tlfs/hypercall-interface#hypercall-continuation
>>>
>>>> +	return hv_do_hypercall(control, input, output);
>>>> +}
>>>> +
>>>> +static inline u64 hv_do_rep_hypercall_cvm(u16 code, u16 rep_count,
>>>> +					  u16 varhead_size, u16 rep_start,
>>>> +					  void *input, void *output)
>>>> +{
>>>> +	u64 status, control = code;
>>>> +	u16 rep_comp = 0;
>>>> +
>>>> +	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>>>> +	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>>>> +	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
>>>> +
>>>> +	for (;;) {
>>>>    		status = hv_do_hypercall(control, input, output);
>>>> -		if (!hv_result_success(status))
>>>> +
>>>> +		if (!hv_result_timeout(status))
>>>>    			return status;
>>>>
>>>>    		rep_comp = hv_repcomp(status);
>>>> -
>>>>    		control &= ~HV_HYPERCALL_REP_START_MASK;
>>>>    		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
>>>>
>>>>    		touch_nmi_watchdog();
>>>> -	} while (rep_comp < rep_count);
>>>> +	}
>>>>
>>>>    	return status;
>>>
>>> And Sashiko noted that this "return status" is dead code. The only
>>> way to exit this function is via the "return status" up in the loop.
>>>
>>>>    }
>>>>
>>>> -/* For the typical case where rep_start is 0 */
>>>> +/*
>>>> + * Rep hypercalls for HW confidential VMs return back when timeouts occur,
>>>> + * whereas for regular VMs they return only on success or failure. In case
>>>> + * of successful completion, entire rep_count is done. But a hypercall could
>>>> + * fail with partial completions, hence callers must always check that
>>>> + * in case of failure. Lastly, a rep_count value of 0 is allowed for some
>>>> + * hypercalls.
>>>> + */
>>>>    static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>>>>    				      void *input, void *output)
>>>>    {
>>>> -	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
>>>> -				      input, output);
>>>> +	if (hv_isolation_type_hw())
>>>
>>> I don't think this is the right test, so let me explain. You don't describe the
>>> context for when HV_STATUS_TIMEOUT may be returned, and there's no
>>> TLFS documentation of this status, but I'm assuming the context is hypercall
>>> continuation. This isn't the typical "something isn't responding" timeout. I
>>> suspect it means the hypervisor hit the 50 us limit, and returned to the guest
>>> VM with some reps still to be done. In a normal VM when a hypercall is
>>> initiated by the hypercall page on x86/x64 or the HVC instruction on arm64,
>>> the transparent hypercall continuation mechanism makes a TIMEOUT status
>>> unnecessary. But with SNP, TDX, and CCA, hypercall invocation may be
>>> piggybacked on other transports, and transparent continuation isn't available.
>>> So Hyper-V returns HV_STATUS_TIMEOUT with the expectation that the
>>> invoking code will loop to do the remaining reps.
>>>
>>> The key factor is whether the hypercall is piggybacked on other transports.
>>> The tests in hv_isolation_type_hw() don't capture that. For example, if
>>> a paravisor is present, hv_isolation_type_snp() will return "true" even
>>> though hypercalls are invoked via the standard x86/x64 hypercall page.
>>> The hypercalls trap to the paravisor. If the paravisor is functioning properly,
>>> it should do transparent hypercall continuation just like the hypervisor would.
>>> But this is something to be confirmed with the hypervisor and paravisor teams.
>>>
>>> Piggybacking is done only when no paravisor is present, so the
>>> hv_do_rep_hypercall_cvm() path should be taken only in that circumstance.
>>> Your current code works, but it goes down the more expensive
>>> hv_do_rep_hypercall_cvm() path when it doesn't need to. (I'm not completely
>>> clear on how arm64 works with and without a paravisor, so my statement
>>> applies only to SNP and TDX. Need to sort out the CCA case with Kameron.)
>>>
>>> Given the non-trivial complexity in sorting all this out, I wonder if
>>> distinguishing the _cvm and _reg cases is really worth it. The current
>>> code for the _reg case is admittedly inefficient because it does work for
>>> the looping case before likely deciding that no looping is needed. But
>>> that could easily be fixed. When no looping is necessary, which is the
>>> vast majority of cases, the looping code could end up being only a
>>> couple of instructions slower than a separately coded non-looping
>>> version (I did some builds and looked at the generated code). Since
>>> there's overhead in deciding which to use, there may not be any
>>> performance win from having both versions.
>>
>> Well, to me it's correctness issue also. If the ABI says that it will
>> not return with TIMEOUTs for non-cvms, then adding loop just masks it
>> instead of opening a bug report against the hypervisor.
> 
> I see your point, but would not call it a "correctness issue".  A "correctness
> issue" is a case where the result is wrong, and there's no wrong result
> here. I've definitely fixed edge-case issues that might never occur in
> practice just in the interest of overall "correctness", but that's not this case.

Well, imo, abi says it will not timeout. if it does, it is an
"incorrect behavior". But anyways, not worth nit picking about :).


> Your point opens a different can-of-worms. The threat model for Linux
> guests on Hyper-V has historically been that the guest trusts the Hyper-V
> host to do the right thing. A buggy or malicious host can arbitrarily read
> or write guest memory, so there's really not much choice but for the
> guest to trust the host (of course, in a CoCo VM the threat model is
> different). As such, Linux code has never tried to fully validate what it
> gets back from Hyper-V. Various ad hoc validations have been added
> when it seemed helpful to do so, but it's not a priority or a directive.
> Doing such a validation here is not objectionable, but I wouldn't add
> a significant complexity to do so.

Ok, I'm ok with adding a WARN() to catch incorrect behaviors...

> FWIW, here's pseudo-code for an alternate approach that doesn't
> require splitting into separate _reg and _cvm versions:
> 
> static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
>                                            u16 varhead_size, u16 rep_start,
>                                            void *input, void *output)
> {
>          u64 status, control = code;
>          u16 rep_comp = 0;
> 
>          control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>          control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>          control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
> 
>          for (;;) {
>                  status = hv_do_hypercall(control, input, output);
> 
>                  if (!hv_result_timeout(status))
>                          /* If result is success, could validate
>                             completed reps == rep_count - rep_start */
>                          return status;
> 
>                  if (! <hypercall is over alt transport> ) {
>                          /* Should not get TIMEOUT with normal calling seq */
>                          WARN();
>                          return HV_STATUS_INVALID_PARAMETER; /* or some such */
>                  }
> 
>                  rep_comp = hv_repcomp(status);
>                  control &= ~HV_HYPERCALL_REP_START_MASK;
>                  control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
>          }
> }
> 
> In almost all cases, the result is not TIMEOUT, so the code returns
> immediately with no extra overhead except to check for TIMEOUT.
> If it *is* TIMEOUT, then go to the trouble to figure out whether
> TIMEOUT is valid. If the VM is using the normal hypercall invocation
> mechanism, flag that as a hypervisor bug and don't loop.

Well, the end result is almost the same, but I like different
function (will not be _cvm anymore) because it tells the reader
upfront of different behaviors of the repeat hypercalls. I'll
experiment with both, and send the one that I like...

Thanks,
-Mukesh


>>
>> Hope that makes sense.
>>
>> On a side note, to solicit your thoughts, i am not sure i like the
>> touch_nmi_watchdog()... it appears the the WD is triggered in seconds,
>> and if a hypercall is that long, schedule() really should be done in
>> between. IOW, remove the touch, instead any very long running hypercalls
>> should call schedule(). Of course, that would be a different patch.
> 
> I agree. I would be fine with removing the touch_nmi_watchdog().
> 
> Michael

