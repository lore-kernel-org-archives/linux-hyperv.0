Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428002;
	b=o488/dRFbwbrmIO+shQHMOaXqCkfAAUdm+9HS6qpB4mhjUDgB7wSB1NoLUqOpNtW3iZY
	 xm1//2LsE5n4a8zogmSSrB+l4jZSgS/og/GUiKAENJxGPB1lKKiWS0BXmSDIFpAD1J9W8
	 yVlfzKNiqQrVEtC6neqt2ok4A5BMStHjGSmf/m5dGRKrI7Z6ctP99ja0UKnTXgGjc8EH/
	 EgyFbB2Z1pUeSSDB2/RuFk3xSDRsAgSqAojDSpcUPBNqWOYzCMpkBKKeHfQ9YGB2IroHu
	 e8Rqif48UnCgOd0lnDgXqrrKQvCos1M3YGpwIGOtCr+zOAFa9bi+I4JzTwZ11NQyyWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428002;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DUUt4d5FfX5wK9J0Ab/mw7sF993N4uPKgtbtDWygzpw=;
	b=TIOMJnZhbmSv7SUYI2DJeumVaeQl06trbKhRBwmW8+ryQBkSSgYeEo7aJB/+3nkH8p3w
	 rBLqsKniELWduVBBC2BpqH6HzBvKoIPi6NeL/POADEmmXrKZNSMv9itWnL6FnbPQprn+r
	 ihXyyJxKuByuITF5w4FoAellggqC/oD/IBje6t/vM2WXylZcPvYusLQ23o1hw0LDdn1Zo
	 vOgu/JaPhfyBSjoD6v9A6DSia12SYcSMJqW6Zv8PIitrWo4VGiLgmH6WPwPDFyhBgl8SY
	 MONjyTrTv1lczM+SQfSt0AHQsKvTC7huVFSK8PFwKUKUOZ4FVZ1l/hJIOo9fP8J0bWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520F606A31E;
	Mon, 23 Nov 2026 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9520F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 019A62436B3;
	Mon, 23 Nov 2026 10:59:59 +0100 (CET)
Date: Mon, 23 Nov 2026 10:59:58 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <awQOkV6RFl0TM6Hb@8bytes.org>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112195710.1417744-4-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:56:58PM -0500, Yuho Choi wrote:
>  drivers/iommu/hyperv/hv-iommu-guest.c | 29 +++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Applied, thanks.
