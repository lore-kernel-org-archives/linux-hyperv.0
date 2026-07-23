Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6E3F0ABB;
	Thu, 23 Jul 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841268; cv=none; b=u/Xo5UChBGFfuwNrv0b8A6mRvTFQPjXqgn4gIlvprOJkq2XiwM6/6+5IIUUWUzHcoybv3+ww6hy5+gL4Pxy7IQ+mamucrHN1HQdSuYYKSfU870hv9Zdjf/H4OoEupkgPCEVcyiCAUOMme1pWAx6ooPAnA9TMc9b7Pt51YjabaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841268; c=relaxed/simple;
	bh=eU8jN1QjKxFsINWQ26Sz2lgUmEmvoTd5KJPqDGFraxI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=frkzCkN8gIl0LX8Jeb2OcMKynhX3l01wjSSeY9hZp6iMQWXs28riYZlURrrVVRclqD34Jl+CRGtLDkEB6njmeqS142K2TVDn3DUPSGnP+7SZYcLP7yzMihALmeHNV9q5uOPYUcYpvyHoPPqHSeNn9jlM7Hvmyu+D4XE4uSG4Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A7Fsn879; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A7Fsn879"
Received: from DairyQueen (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A8C120B7167;
	Thu, 23 Jul 2026 14:14:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A8C120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784841246;
	bh=aFeAwYgDEo+YCweQhSGjFe/9SMRHHTgoY4QgPAaf/Kw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=A7Fsn879h59K+hEvP+tyDpYW/cMGpDm81QvSiS9dPwEZ6T6TP+jRYb7FvQHdjEkvX
	 lfX1wunxkCxp4eMUdx/PgH2csedRfWdiEI9uZS5sNPjX+2DOWy1WS5QJ905dyfOcG1
	 hNOeE/wRRnvRK7pfmvtclSVnY0E4OT4haJy7Df/k=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<decui@microsoft.com>,
	<haiyangz@microsoft.com>,
	<kys@microsoft.com>,
	<longli@microsoft.com>,
	<wei.liu@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com> <20260721195633.1438361-2-kameroncarr@linux.microsoft.com> <BN7PR02MB414815ABD36AD06CA3319306D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB414815ABD36AD06CA3319306D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 1/2] Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
Date: Thu, 23 Jul 2026 14:14:10 -0700
Message-ID: <001601dd1ae8$39cf88a0$ad6e99e0$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQNRsRip/0GPmGqK2zS6hqfVzZeToQICPuNBATrcRzizeINSsA==

On Thursday, July 23, 2026 10:53 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, July
21, 2026 12:57 PM
> >
> > Refactor vmbus_establish_gpadl() to separate the encryption lifecycle
> > from the rest of the GPADL establishment logic.
> >
> > Add a new vmbus_establish_gpadl_caller_decrypted() for callers that want
> > to decrypt their own buffers.
> >
> > No functional change for existing callers.
> 
> I have a suggestion for a different way to accomplish this. I haven't
coded
> it, but I think it will result in less code churn and be simpler overall.
> 
> 1) In enum hv_gpadl_type, add value HV_GPADL_BUFFER_DECRYPTED
> 
> 2) Update hv_gpadl_size() and hv_gpadl_hvpfn() to treat the new enum
> value just like HV_GPADL_BUFFER
> 
> 3) In __vmbus_establish_gpadl(), change this code
> 
>         gpadl->decrypted = !((channel->co_external_memory && type ==
HV_GPADL_BUFFER) ||
>                 (channel->co_ring_buffer && type == HV_GPADL_RING));
> 
> to
> 
>         gpadl->decrypted = !((channel->co_external_memory && type ==
HV_GPADL_BUFFER) ||
>                 (channel->co_ring_buffer && type == HV_GPADL_RING) ||
> 	  (type == HV_GPADL_BUFFER_DECRYPTED));
> 
> 4) Add the function vmbus_establish_gpadl_caller_decrypted() like you
> have in this patch. It just calls __vmbus_establish_gpadl(), passing
> HV_GPADL_BUFFER_DECRYPTED.

Ack. Thank you for the feedback. I will use this approach in v2.

Regards,
Kameron

> I think that's all that is needed, though I haven't gone through
> everything rigorously and might be missing something.
> 
> FWIW, the meaning of the "decrypted" field in struct vmbus_gpadl is
> a bit abused, but it was already that way. In current code, it initially
> means "decryption needed". Then after the gpadl is created, it
> means "was decrypted" so that gpadl teardown will re-encrypt.
> But my suggested approach doesn't really make the abuse any worse.
[...]

