Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436174;
	b=HApfUtFunoWyCnGu8+Iq4WLaFAuVZjUU54vZu7MI7A8Fu5oyxpxvaf/4TnqkxR2FCVu/
	 6PBwjUY6pXMtZZJJVUF2xwvTjkBQPnUf2RZGRX9sVulE3czywoLKmXWL482GFrxQlVmJM
	 xw5O70ogf46xrtoKv+UrDhitzpNfio6FYivJUJMT4teksEyZdPiJUzmXUjIEPNPsku691
	 6MkLNLr5CY7dO1ufoljCBZ4Z/acVMi7w3DSP34hpXUwiO9puHxDNcIENzljoLqAgwf7LB
	 OjRjYY9GkwxLauYoFwsBukS9cpUZKETMJ140bjtcqn5UyKlZcgjVhJPI/h3h3xI2U4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436174;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zyM541AR7ZZE38ApRIgXfw9vU7L1IaJEwloMzTLw3Ig=;
	b=3sp4Z6ekbn2LcGzMrls9H4x37gI7DvYp892X72S15GaqmiIMx0Fsc1DdyKixWPIWWBkJ
	 HhPqlbBAn1if8XKgMKQJxEgrekBvSDw/g3ezYmknxPhzd3D/fJBkL5XxRGDmNEYW9+vUR
	 6INr8kwujrv30u+jCDjrk90fYbOnSRyc9SAEZXi5o4lKBZGsFd5DIV3Z+mi5FY4NaPvuU
	 2C0OQ7SsJQ9rVd7qiXp4SMlqXBXWOt7Jxxt/2xaEhO2mnKOVlEOxzpnDN/b71PoLE568z
	 uYH7Olhc4Lw6wkb/T55O+/lWQjrkoBvD0kGT3OXuqUOHktJvygFmujFOQS4fRsuAwHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fencjVNn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DB606A31A;
	Sat, 31 Oct 2026 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fencjVNn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2171595;
	Sat, 31 Oct 2026 01:42:48 -0700 (PDT)
Received: from [10.57.13.152] (unknown [10.57.13.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B38B3F59E;
	Sat, 31 Oct 2026 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793436171; bh=avExJZ8pIb5Ca/dscv5M6k88MfirFVDBlv6ja+R8bbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fencjVNnt00wM0wda3KJv3WoRmZ8GoSQNWWxyQRTkf7seFOhLkY2VnuWG+597t0Ez
	 +itFgbGaU/suCHgpoFnAbgN+AQ4E3wUGbwU9OaVV8jDvTTym1FhRUmtTgNedvKgBUS
	 uz1DkVoVayYJVDZ+51JRhGrKSIrbf6I74AdaRYLo=
Message-ID: <a1d9608c-8169-49c5-b843-ed9d304136ed@arm.com>
Date: Sat, 31 Oct 2026 08:42:46 +0000
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
Subject: Re: [EXTERNAL] Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor
 via RSI host call in CCA Realms
Content-Language: en-GB
To: Dexuan Cui <DECUI@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>,
 "will@kernel.org" <will@kernel.org>, "Mark.Rutland" <Mark.Rutland@arm.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "sudeep.holla@kernel.org" <sudeep.holla@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>
 <auPOnb_9Jfzh-oQE@arm.com>
 <CH4PPF0966F22FCAF3D8C6535743902930DBF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CH4PPF0966F22FCAF3D8C6535743902930DBF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 31/10/2026 04:47, Dexuan Cui wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>> Sent: Thursday, October 29, 2026 3:54 PM
>>   ...
>> + Suzuki
>>   ...
>>> +static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res
>> *res)
>>> +{
>>> +	guard(spinlock_irqsave)(&uuid_hc_lock);
>>> +
>>> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
>>> +	uuid_hc.gprs[0] = ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
>>> +
>>> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) != RSI_SUCCESS) {
>>> +		res->a0 = SMCCC_RET_NOT_SUPPORTED;
>>> +		return;
>>> +	}
>>> +
>>> +	res->a0 = uuid_hc.gprs[0];
>>> +	res->a1 = uuid_hc.gprs[1];
>>> +	res->a2 = uuid_hc.gprs[2];
>>> +	res->a3 = uuid_hc.gprs[3];
>>> +}
>>> +#endif
>>> +
>>>   bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>>>   {
>>>   	struct arm_smccc_res res = {};
>>>   	uuid_t uuid;
>>>
>>> -
>> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC
>> _ID, &res);
>>> +#ifdef CONFIG_ARM64
>>> +	if (is_realm_world())
>>> +		arm_smccc_realm_get_hypervisor_uuid(&res);
>>> +	else
>>> +#endif
>>> +
>> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC
>> _ID,
>>> +				     &res);
>>
>> Is this meant to be generic? I'm not sure the trick to pass
>> ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID in gprs[0] and forward it to
>> the host is a documented ABI. I think it even confuses other realm guests
>> that don't expect this (e.g. kvm_init_hyp_services()).

Yes, this is how a Realm can talk to the Host hypervisor, i.e, 
RSI_HOST_CALL. In simpler terms, HVC is routed to Realm world for
Realms (e.g., a Paravisor running in Realm world Plane-0).
A Realm must always use RSI_HOST_CALL to reach the non-secure
hypervisor. RSI_HOST_CALL expects the arguments to be passed
in a "memory" area to preserve forward compatibility with
the SMCCC standards to allow for using the full argument/result
list.

The RMM does the job of copying the arguments from the Realm memory
to the rec_exit.gprs for consumption by the Host. The host can then
return the results in rec_entr.gprs, which then gets copied over
to the Realm memory area.

> 
> Hi Catalin,
> Regarding the concern about passing ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
> In gprs and forwarding it to the host via an RSI Host Call: if I read the code correctly,
> this pattern actually aligns seamlessly with the current KVM host-side
> implementation for ARM CCA (e.g., in the v16 patchset [1]).
> 
> In arch/arm64/kvm/rmi-exit.c, when a Realm guest triggers an
> RMI_EXIT_HOST_CALL, KVM intercepts it and invokes rec_exit_hvc():
> 
> case RMI_EXIT_HOST_CALL:
> 	rec_exit_hvc(vcpu);
> 	kvm_make_request(KVM_REQ_RMI, vcpu);
> 	return ARM_EXCEPTION_TRAP;
> 
> Inside rec_exit_hvc(), KVM copies the GPRs from the rec run structure
> into the vCPU registers and explicitly emulates a standard HVC
> exception by populating esr_el2:
> 
> static void rec_exit_hvc(struct kvm_vcpu *vcpu)
> {
>          struct realm_rec *rec = &vcpu->arch.rec;
>          int i;
> 
>          for (i = 0; i < REC_RUN_GPRS; i++)
>                  vcpu_set_reg(vcpu, i, rec->run->exit.gprs[i]);
> 
>          vcpu->arch.fault.esr_el2 = (ESR_ELx_EC_HVC64 << ESR_ELx_EC_SHIFT) |
>                                       ESR_ELx_IL;
> }
> 
> After doing so, it returns ARM_EXCEPTION_TRAP, causing KVM's generic
> exception handling loop (kvm_arch_vcpu_ioctl_run() -> handle_exit()) to
> route it straight into the standard handle_hvc() ->
> kvm_smccc_call_handler() path.
> 
> Because KVM deliberately unpacks the RSI Host Call structure and pushes
> it down the traditional non-CVM HVC servicing pipeline, the guest passing
> standard SMCCC Function IDs inside the gprs array of an RSI Host Call is
> exactly how the host expects to handle hypervisor services. It shouldn't
> break or confuse other standard realm implementations since this exact
> emulation block translates the RSI exception back into a generic HVC
> abstraction for the hypervisor layer.
>   
>> I thought realms should stick to the RSI interface and not try to guess
>> the host hypervisor. But if you do need this, a better fit would be in
>> hyperv_detect_via_smccc() (if realms don't boot with ACPI).
>>
>> I'll leave it to Sudeep or Suzuki to comment further.
>>
>> --
>> Catalin
> 
> As I described above, this patch from Kameron should work fine.
> 
> BTW, as Kameron mentioned in another reply, he better organized the
> code by moving the code in this patch into
> arch/arm64/hyperv/mshyperv.c: hyperv_detect_via_smccc().

Any Realm specific stuff must be handled accordingly in the 
"enlightened" path, not in the common code like this patch.

Cheers
Suzuki


> (technically, IMO this change is unnecessary)
> 
> Thanks,
> Dexuan
> 
> [1] https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16
> [2] https://lore.kernel.org/all/20261031001412.4150488-3-kameroncarr@linux.microsoft.com/

