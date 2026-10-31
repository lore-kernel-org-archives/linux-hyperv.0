Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406958;
	b=iBw9UzLXTyngnmG9qhvbE3B3oNQrkjMPiTFbOUkJt2cFQXBvvCuJ08Vg8l8hgPESNC5Y
	 rhBM/5nrQx2wm4R6d4KWjiqQnYvRirJYYF3JHwjvNypgeDG8HiTM3IX51pfBoL5Fct9nj
	 F54hfrypRAhve10Ut8wdZuZmjV7lr31d22Ys/fu9lMWToMJfzcVLmEO+lTNqUIIXoX1W2
	 2IpfodwCh5tHlRDDdIU16I63c/AfknDz6tUMCF+/Ylj41b0YP9rOXVRQLWAFSVzxEzKm1
	 VmFw+F8AaoP7PyRovORh2V2Pj/aYy5FGDdHj6RTEIg2mSxtLXLKniJSeUzz6U2xC+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406958;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=EQ7fNiO0P3mhoLAhbj+6WfCFh3aUC3uBzQXi0YuoPKA=;
	b=o7nlXFhz72O644fHUeiUEHgzkNqZBU2DoYNiSfTH+xON6Kwwscqz14amM/KPJiHhR+iv
	 XJNB1u9tZUGIl/74u39rwRc3P4k3t6kQCkUy2py68kCrYe9jSogsq6Vp/41etq/tO0LSt
	 soRhSLSuz0ZWtE3pFeYryyh9vHJddLoJe7EcyvvNMPZGf10jrGkmb/bRLpRd1XBcf3sJW
	 zn2v4MuR3eDT5KMPOiHSUkpDG/q9tJl21i2fCHgbPQzroLqXXWwhCCq4R2eBRzOIZtT5M
	 lvQbv5bLi77z3VV0YVqY3pZmu1EPx4xCy6+JBpQiaDDk/F4GSza1yBiGyb1FK8GtahA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cFReCf0d;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6C606A31A;
	Sat, 31 Oct 2026 00:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cFReCf0d
Received: from [100.64.217.159] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA10520B7166;
	Fri, 30 Oct 2026 17:35:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA10520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793406945;
	bh=EQ7fNiO0P3mhoLAhbj+6WfCFh3aUC3uBzQXi0YuoPKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cFReCf0dabEhVznpQ0oD55qIBHIWSpDa9udX1pxRG3zX1SNL32mSHA7gtkVWZ3o5R
	 a5Ybru57SRz08HUAxBWKguLzKeKVQ8iP0UxbJlrd/cesfBW1GSHpRKtSd5qKYZ/4rS
	 7CgsawYhdc/qNWDJX2md8+pz2f2nsiQImu+7nhJs=
Message-ID: <8d175247-24a9-42ee-8ce8-4bdfce6db548@linux.microsoft.com>
Date: Fri, 30 Oct 2026 17:35:58 -0700
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
Subject: Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 mhklinux@outlook.com, will@kernel.org, mark.rutland@arm.com,
 lpieralisi@kernel.org, sudeep.holla@kernel.org, arnd@arndb.de,
 thuth@redhat.com, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Suzuki K Poulose <Suzuki.Poulose@arm.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>
 <auPOnb_9Jfzh-oQE@arm.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <auPOnb_9Jfzh-oQE@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/2026 3:54 PM, Catalin Marinas wrote:
> On Fri, Oct 02, 2026 at 02:57:21PM -0700, Kameron Carr wrote:
>> +#ifdef CONFIG_ARM64
>> +static struct rsi_host_call uuid_hc;
>> +static DEFINE_SPINLOCK(uuid_hc_lock);
>> +
>> +/*
>> + * Helper function to get the hypervisor UUID via an RsiHostCall.
>> + */
>> +static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *res)
>> +{
>> +	guard(spinlock_irqsave)(&uuid_hc_lock);
>> +
>> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
>> +	uuid_hc.gprs[0] = ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
>> +
>> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) != RSI_SUCCESS) {
>> +		res->a0 = SMCCC_RET_NOT_SUPPORTED;
>> +		return;
>> +	}
>> +
>> +	res->a0 = uuid_hc.gprs[0];
>> +	res->a1 = uuid_hc.gprs[1];
>> +	res->a2 = uuid_hc.gprs[2];
>> +	res->a3 = uuid_hc.gprs[3];
>> +}
>> +#endif
>> +
>>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>>  {
>>  	struct arm_smccc_res res = {};
>>  	uuid_t uuid;
>>  
>> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
>> +#ifdef CONFIG_ARM64
>> +	if (is_realm_world())
>> +		arm_smccc_realm_get_hypervisor_uuid(&res);
>> +	else
>> +#endif
>> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
>> +				     &res);
> 
> Is this meant to be generic? I'm not sure the trick to pass
> ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID in gprs[0] and forward it to the
> host is a documented ABI. I think it even confuses other realm guests
> that don't expect this (e.g. kvm_init_hyp_services()).
> 
> I thought realms should stick to the RSI interface and not try to guess
> the host hypervisor. But if you do need this, a better fit would be in
> hyperv_detect_via_smccc() (if realms don't boot with ACPI).
> 
> I'll leave it to Sudeep or Suzuki to comment further.

I moved this code to a Hyper-V specific location as you suggested.

Let me know if you have any other concerns.

[v6] https://lore.kernel.org/all/20261031001412.4150488-1-kameroncarr@linux.microsoft.com/

-- 
Regards,
Kameron
