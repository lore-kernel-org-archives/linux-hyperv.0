Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF982D73BC;
	Fri, 27 Feb 2026 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222792; cv=none; b=DSM3ziyjrA5r7XXsVAvZRJT28T7RlZn015njHjuJjfsmekK+Zihk+ce9fceEp0qvvl8DIHEY7PhpgXitKNqQUf8trfhS9fnXweMkW6aKZRuycOcoYLAlOk253tFOTSV+BMSTRpEoypZG7o1n4yKnj1QYWSwxCrZopj9eADDLkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222792; c=relaxed/simple;
	bh=rzB214xGCqD3xv4mmMmHeRsaLlWaJqiFq7PjvbJrxVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpXH2X6/WrCjYvXAn2F8tGCXgmaSeDwCOHhSBqlp5j3GzAjeSgN6cpXYGzy7KhCtWTpoLXgU4B3YvTSXS4Sv6W3YF00yF0khWMga1tBsQNTBE9UUAx8mxvIC5vv0mK6YOA78jCUrF4DfZOleUa/tKo0we5kDjSWQL47lh+LOC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PQdNdYk5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PQdNdYk5"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 96F8920B6F02;
	Fri, 27 Feb 2026 12:06:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96F8920B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772222790;
	bh=Lgc0xTJY6n96ZqmNpJBXHUF+t6nBKy6gbV8xtTVGovc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PQdNdYk58FNrxwz9wt1xzJqO13MT8WXHPbe8sPcoMZ8b4HD4EgohHJnndrhftyyFp
	 avTKsPsEOehVmOf5Hn5X+50n5XftixLe77/oP01dSXDLJgdIWcr94dqgVSc7bZwvme
	 rp7ZotNw7oLvV12UU+mcrB0VPNkXIf3BPAegTvF8=
Message-ID: <68f419eb-2f0f-e747-762a-45bd8181e819@linux.microsoft.com>
Date: Fri, 27 Feb 2026 12:06:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: VFIO support on hyperv (vfio_pci_core_ioctl())
Content-Language: en-US
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1f50dae2-ec4a-7914-a14f-2ada803eb0e3@linux.microsoft.com>
 <20260227122957.1e555024@shazbot.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260227122957.1e555024@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/26 11:29, Alex Williamson wrote:
> On Wed, 25 Feb 2026 14:04:49 -0800
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> Hi Alex et al:
>>
>> I've been looking at making pci passthru irq setup/remap work on hyperv
>> for the latest (6.19) version using vfio core. Unfortunately, it's just
>> not fitting well because in case of hyperv the irq remap is done by
>> the hypervisor. Specifically, for a robust and proper solution, we need
>> to override vfio_pci_set_msi_trigger(). As such, for the best way forward
>> I am trying to figure how much flexibility there is to modify
>> vfio_pci_intrs.c with "if (running_on_hyperv())" branches (putting hyperv
>> code in separate file).
>>
>> If none, then the alternative would be to create vfio-hyperv.c with
>> vfio_device_ops.ioctl = hyperv_vfio_pci_core_ioctl(). But, then I'd
>> be replicating code for other sub ioctls like vfio_pci_ioctl_get_info(),
>> vfio_pci_ioctl_get_irq_info(), etc. Would it be acceptable to make them
>> non static in this case?
>>
>> Please let me know your thoughts or if you have other suggestions.
> 
> Hi Mukesh,
> 
> In general, littering the code with running_on_hyperv() tests is not
> acceptable, but the presented alternative isn't really accurate either.
> If you want to substitute in your own ioctl callback, you can still
> call vfio_pci_core_ioctl() for all the unhandled ioctls, without extra

Yes, I realized that after looking at how other callers were using it.

> exports.  We can also look at whether vfio_pci_device_ops could have a
> callback specifically addressing an alternative set_msi_trigger
> handler.  Thanks,

Sounds good. thanks as always,
-Mukesh


> Alex

