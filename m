Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7237B00E;
	Mon, 27 Jul 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187437; cv=none; b=D1r+SMp3m/1B3uOmvnFj+sh+4p/JqozbJfFM+Sq9hdJ/4BKkscrzoMGlBMumSp9h61UFJbXllrjBMg68/WP2ZvxflUc/uK/7Rn984rGfYQc6X+2QcJTqk+b+Ahc6GzpNDuBmRgLHXiBf1GDfd29WZnjm62TyOFRgZdDqlcu82nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187437; c=relaxed/simple;
	bh=snNrH78bcbfngM/9EsSkHeoIxfxpCcaO99kwCoKU58I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fuw0RQru03twn5bGfiTC74iLURDq9KDC9jMhVm4MXYJ53UxCaMrEllFFBPzyopOEFHlzkrbjaqPYLhK9EDCcQvvViz0DeqVm0W1gcp2PoYHLfECFvAXRDm4cmrex541Y9sgQ2YpLU0O+d1wRH+NXlvZnDovf30y21JU6gRhA1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RcyCme1/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RcyCme1/"
Received: from [10.20.178.127] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDB8720B7166;
	Mon, 27 Jul 2026 14:23:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDB8720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785187420;
	bh=6qgZsjEQFFn45qKNPuN7sOK+CsI2NvYKIjj1UKiebt8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RcyCme1/Z6mGqJRwmzb9dkjsnnaKzr5mvbVlgpLf+FuPxCcBPCbIrqo7+4qcvq74C
	 VlYjYh8xFJy33sengyEUvGhxyClCyoLvbiYruGID+vBZwMx2uQnhO40GJlhG9hW8G4
	 OYEd26T6hFKS42aDILPWIvb6KM28Y8BkVYo+Dd94=
Message-ID: <bc819b23-49c5-43d1-9a69-d34dba8f4762@linux.microsoft.com>
Date: Mon, 27 Jul 2026 14:23:47 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, linux-kernel@vger.kernel.org,
 ssengar@linux.microsoft.com, namjain@linux.microsoft.com
Subject: Re: [PATCH] Drivers: hv: Use meaningful errnos for hypercall status
 codes
To: Hardik Garg <hargar@linux.microsoft.com>
References: <20260727211101.2199630-1-hargar@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260727211101.2199630-1-hargar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hardik,

On 7/27/2026 14:11, Hardik Garg wrote:
> Commit 3817854ba892 ("hyperv: Log hypercall status codes as strings")
> converted hv_result_to_errno() from a switch to a table and added status
> codes used for string logging. Statuses without an existing specific
> mapping were assigned the generic -EIO fallback even when a more specific
> errno was available.
> 
> Map HV_STATUS_ACCESS_DENIED and HV_STATUS_OPERATION_DENIED to -EACCES,
> HV_STATUS_UNKNOWN_PROPERTY and HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE to
> -EINVAL, and HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED to -EOPNOTSUPP.
> This lets callers distinguish permission, argument, and capability
> failures from generic I/O errors.
> 
> The table conversion also added duplicate HV_STATUS_INVALID_LP_INDEX and
> HV_STATUS_INVALID_REGISTER_VALUE entries. Remove the later -EIO entries,
> which are unreachable because find_hv_status_info() returns the first
> match.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
Glad to see that this was something that bothered you as well. If you like, you
can pick up feedback from Nuno on my attempt to solve this [1] and do a de-facto v3.

[1] https://lore.kernel.org/all/479242d4-ae08-442c-b61b-c9408ba2e9b0@linux.microsoft.com/

Thanks,
Easwar (he/him)
