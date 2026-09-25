Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF236495F;
	Fri, 25 Sep 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337683; cv=none; b=rAkjDny8XWfkHOMI5kkLTMdJxtk+f3q8Eot6Xe9UyeFqdRF9mUDq1DPGaDkRBnWyWfkq4BmBbu/9WrPxvkOz1MzXm6lt6ytAOXRMu+D4zTMuBfFNDCDepBVW7NofqBou+x6RMSW6YK+rhkv7+eag7Ku+RJM+VVXgExvPOuRcbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337683; c=relaxed/simple;
	bh=KoNA8IEmw6rVgjEzh4iM8tmfecTPznSgVl3B3cV9W/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxxDLzaLqUcOzAzIniLY0sFAmsE593RxUQ7vPxsI0l8q2HCZFWbxCuYOevAcdQ4VFQofcMxnB5JYgk59vybxRlT27X97zW50K0MEujCnsX8SbAFmNc1jz5r7j2SAThhiiaMkg0t8xihPv16dqK5SmZheC6xrARW9ougMurtL+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gubDwn+5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gubDwn+5"
Received: from example.com (p3e9c0608.dip0.t-ipconnect.de [62.156.6.8])
	by linux.microsoft.com (Postfix) with ESMTPSA id 737A320B7167;
	Fri, 25 Sep 2026 05:00:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 737A320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790337628;
	bh=TocEik8U291QYRdj8rPVWjwxtpenn4POATH1+GDEMZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gubDwn+5BoxNQdqp4PH59FRHBW7Hvv5uJ43xDImUI587BMSCVdAAI0sYEtV6AhMi6
	 5gTldkV6fUwzFPd2AGyl6azaKgfL2IOv+QIEm9f9TmGGEXkUBPuR7+RCW9+b4O+UCH
	 UoQqRws18Vjx9yIycL6xiRhb7kYk5eRWmmMxuMxo=
Date: Fri, 25 Sep 2026 14:01:11 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Message-ID: <arZih4nPb80EUt9n@example.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <a543145c-4503-bdd8-bd73-a2cbcce1e06e@linux.microsoft.com>
 <aq0W/c9SKCympVHE@example.com>
 <7363cfd4-31f0-451f-0cf5-879e878b30ef@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7363cfd4-31f0-451f-0cf5-879e878b30ef@linux.microsoft.com>

On Thu, Sep 24, 2026 at 05:30:02PM -0700, Mukesh R wrote:
> On 9/18/26 03:48, Magnus Kulke wrote:
> > On Thu, Sep 17, 2026 at 05:23:15PM -0700, Mukesh R wrote:
> no, we need to backport deposit-pages also (it is already in the
> internal 6.18) as not only it enhances the deposit, but also fixes
> couple bugs, so best to keep this separate. the deposit patch does
> address your comment:
> 
>  +     HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
>  +    * a 2MiB page, so deposited pages are of 4k granularity and cannot
>  +    * be collapses into a 2MiB page, which would require an allocation
>  +    * and can potentially fail.
> 
> IOW, as soon as it's merged, above will not be true always.

understood, so we'll drop that comment. but we can keep the logic?
(leaking the page should the  make-valid call fail)

best,

magnus
