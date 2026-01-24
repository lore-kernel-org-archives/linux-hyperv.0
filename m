Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09ACA945;
	Sat, 24 Jan 2026 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213595; cv=none; b=LAIrSG/5M6jlxvaRwpQzBOO3j92rxDmPRrOo4bxQW89P3BiXd9J5Y1ecc2lRKLvGBWtVJwAUIzPPdEcrU6QOv+STgEmGYt4qo838d+r2kngo/w6G+UqH4T2bPbdvdGpaGj+7gzuKU4XQV2jnQrxGmFzJgTzWtTGwlAGwg7/pKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213595; c=relaxed/simple;
	bh=LnRpuAwxio4DbzH8w6cNPr1IH/OQrkdR1UxdXpj6FJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEXczINzZgGz7M1N0UpiaF8+TwhrK35DIp9m7qNSeGO/XsghG+i+RwdYA8NcvIF/KtJYzzqbUi4touhPJF1WmnlW/Xdo7CVSDf5mrceqD8mCSd3OPLFoj0k4dqNDOlLQe+EBfHtMDNr/7zxV8g36je8StkliSA7dENP7hrC0Rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p+28Oyps; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p+28Oyps"
Received: from [100.64.97.48] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB9E620B7167;
	Fri, 23 Jan 2026 16:13:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB9E620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769213594;
	bh=8elzeXjVDp2s4Y/A1TEvO4hZYidyWtV56qUMmeIHKWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p+28Oyps3Ugqt8XuHMYiDcpdL2Y8UkIZRbWMU0rojK8PFC9GmRmJvY1CYkttcetX5
	 QOn7IvZmsWqRcdobKXmR1SpRLsnx2L3haok2ggv7jQDgboFrtmS1C5rB3K2mUp7xrG
	 c1geWP8YvDeCzclQXxFzJdn946jzkhjpXFccjEFE=
Message-ID: <dbe3960d-c765-4394-87ce-e11c051cde44@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:13:13 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] mshv: Add data for printing stats page counters
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2ea6f13f-ac2e-4ed7-9f2c-6c079cb25b85@linux.microsoft.com>
 <aXP2s7V7u6aScDHv@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aXP2s7V7u6aScDHv@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/2026 2:31 PM, Stanislav Kinsburskii wrote:
> On Fri, Jan 23, 2026 at 11:04:52AM -0800, Nuno Das Neves wrote:
>> On 1/23/2026 9:09 AM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, January 21, 2026 1:46 PM
>>>>
>>>> Introduce hv_counters.c, containing static data corresponding to
>>>> HV_*_COUNTER enums in the hypervisor source. Defining the enum
>>>> members as an array instead makes more sense, since it will be
>>>> iterated over to print counter information to debugfs.
>>>
>>> I would have expected the filename to be mshv_counters.c, so that the association
>>> with the MS hypervisor is clear. And the file is inextricably linked to mshv_debugfs.c,
>>> which of course has the "mshv_" prefix. Or is there some thinking I'm not aware of
>>> for using the "hv_" prefix?
>>>
>> Good question - I originally thought of using hv_ because the definitions inside are
>> part of the hypervisor ABI, and hence also have the hv_ prefix.
>>
>> However you have a good point, and I'm not opposed to changing it.
>>
>> Maybe to just be super explicit: "mshv_debugfs_counters.c" ?
>>
> 
> This is reudnant from my POV.
> If these counters are only used by mshv_debugfs.c, then should rather be
> a part of this file.
> What was the reason to move them elsewhere?
> 

Just a matter of taste - so there isn't ~450 lines of definitions at the beginning of
mshv_debugfs.c. But I'm not fussed. If you think it's better to just prepend the
definitions to mshv_debugfs.c, then that's an easy change.

Nuno

> Thanks,
> Stanislav
> 
>>> Also, I see in Patch 7 of this series that hv_counters.c is #included as a .c file
>>> in mshv_debugfs.c. Is there a reason for doing the #include instead of adding
>>> hv_counters.c to the Makefile and building it on its own? You would need to
>>> add a handful of extern statements to mshv_root.h so that the tables are
>>> referenceable from mshv_debugfs.c. But that would seem to be the more
>>> normal way of doing things.  #including a .c file is unusual.
>>>
>>
>> Yes...I thought I could avoid noise in mshv_root.h and the Makefile, since it's
>> only relevant for mshv_debugfs.c. However I could see this file (whether as .c or
>> .h) being misused and included elsewhere inadvertantly, which would duplicate the
>> tables, so maybe doing it the normal way is a better idea, even if mshv_debugfs.c
>> is likely the only user.
>>
>>> See one more comment on the last line of this patch ...
>>>

<snip>
