Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE934B40F;
	Wed, 20 May 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297228; cv=none; b=Uos0L7m+PGUqL8b4fHfcmPichExBGAps3ZxaYYjGn1RKvIlNj6kP/dm+M8MvsWrhCi231+QZZ+8yBtPwKJ5KSUiTwa+AJ34OMThcf8ENZghvb8COhVYWEOOT/U8Efw+BPO5C8Du4QD2QQcR9WowEVImUHy6n8QFG13/+IhpWGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297228; c=relaxed/simple;
	bh=cApMWRjR95laq6iIXYC+B59Y2qt4D9uRHBbbMWnDMZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UdCYdNVEkrKtyQexJUlHyy+HuVIeYYB3Net+HX1dKiOxzBMCtQ86WPWd+fSJbrUS4tjTINLqrkbIlb51qrUuJk658oqN0boCefNLDAo64oVPNYwOQn1p6lRq7xK/obXp2xeYUeAW9FKzFLtjP6ndVrnVlf15IE8LwyFvzJPqIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o/DBlsPq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o/DBlsPq"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 1D70720B7167; Wed, 20 May 2026 10:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D70720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779297220;
	bh=s0h/7HBT9sftL4NedXbi/5HsD8nKkimeOX0VEl/m4d0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=o/DBlsPqFEtPUy7+9VDYh7pY6NCZXPUgvMg1oeicPvvjH7eR+fchTdavdkudEGIOR
	 Q6pOuLmDaSxgtXgBFGZhKCzdj6Iks/0vVVeCOSGa3kCpVDYLyKPcD3ITTlSUrFAODA
	 3nq7jD8F2NjSPK2t+Bu6IK+klefNuUBBe8qYpanI=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 1B4C630705A4;
	Wed, 20 May 2026 10:13:40 -0700 (PDT)
Date: Wed, 20 May 2026 10:13:40 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@kernel.org>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, 
    Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
    "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: add vmbus dependency
In-Reply-To: <56938994-3795-415a-8be3-16e28236082b@app.fastmail.com>
Message-ID: <63d0f4ce-f07c-c426-306d-147fd81d2e8e@linux.microsoft.com>
References: <20260520074044.923728-1-arnd@kernel.org> <SN6PR02MB4157CDF10D33D62DD8709D63D4012@SN6PR02MB4157.namprd02.prod.outlook.com> <56938994-3795-415a-8be3-16e28236082b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 May 2026, Arnd Bergmann wrote:

> On Wed, May 20, 2026, at 15:46, Michael Kelley wrote:
>> From: Arnd Bergmann <arnd@kernel.org> Sent: Wednesday, May 20, 2026 12:40 AM
>>>
>>> When the vmbus driver is not part of the kernel, the mvhv_root
>>> driver now fails to link:
>>>
>>> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
>>>
>>> Avoid this by adding an explicit Kconfig dependency. Note that
>>> stubbing out the hv_vmbus_exists() based on configuration would
>>> also work for some cases, but not with MSHV_ROOT=y and HYPERV_VMBUS=m.
>>
>> Conceptually, the MSHV root code should not have a dependency on
>> VMBus. The "does VMBus exist?" question should handled differently
>> by setting up a boolean in the core Hyper-V code that defaults to "false".
>> If the VMBus driver loads, it would set the boolean to "true". MSHV
>> root code would query the boolean.
>
> That makes sense to me, but it's outside of my area for a drive-by
> build fix. Please treat my patch as a 'Reported-by' then, I expect
> this can easily be addressed by Jork or someone else in the
> hyperv team.

Apologies for letting this linger - we were looking for the best fix 
internally. While Michael is correct that conceptually the dependency is 
not ideal, I think it's the right fix *for now*.

Yes, this would not allow MSHV root without VMBUS, which is relevant for 
MSHV root only, which misses a few other components. For L1VH it is the 
right fix that also enforces module load order.

Ultimately (and this is planned), we need a SYNIC driver, and the 
hv_vmbus_exists() will vanish for this usecase. It is a hack even now.

Best,
Jork

