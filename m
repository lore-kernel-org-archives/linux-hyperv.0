Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432200;
	b=oWDdmnhILpbUJjipqm11LkmgXypOx2297VGxUntVOur3NzhB9ooS2476mhTdpDPvgC6U
	 MOg2r6T8YhGLLqtGWZAXVmuaU8tfluf5s9QHWoK0hzr6rWFDsza8L0EccAzpO5QMGHGUR
	 +vJ5Ypgz6EdwCoL/nbbHdJopn1rD/yXwjsRyA0wRn6zDLyCT1br3TPAS8ptqO4gtcKClw
	 B1hyLjGZD5dKDSlhG5eJcc2tMluDiNBdfnuiXpHMUrCMjvH0iZh/db6OquGqbcSixuL/t
	 rG+fdG4u6byIEoodAsppIN8tiOvfjTbE4h9MsIpLkvi9zB8JYCpRu3Ow3m/137WF8xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432200;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lrb0YFMFrFE7HyTUV8Y84CUpLSY3p3XgELY1JaOTjxA=;
	b=s33WOQIhQkZFi3oQ3AqsVBn6pp4PIgWhBtTtY9Vl3BE3RQvXfJJYKcWxTr6CNuV2Sc/K
	 tbyYrE2Jmcq7ChO2fjYfGwGaQEZghCVTrE8/NUObWd+fwPSMGQSHcnJRxXjn6urh2qc+V
	 ZNZ1hB9JHB1KLK0U+bFnOjK4MlDVbnQ1rznrp4FB+7eibaxcGn2LQJbHMZknN3fER0hcS
	 XuTkP9eDPgwI5epJoT+fl68L/fu6tXWXmxMVS4gtBIsUYmqqjpclcpaZPwvBx7i+FHbO/
	 ra29UmCSBt/rz3ShSI/OYiWH5vWEEXQuqBSQTvJvQLKkzQ1YkA0sKJ1ZrebmHiA0VlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0364606A327;
	Mon, 23 Nov 2026 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0364606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 26D0B244C20;
	Mon, 23 Nov 2026 12:09:58 +0100 (CET)
Date: Mon, 23 Nov 2026 12:09:57 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yuho Choi <oss.patchbox@gmail.com>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Yu Zhang <zhangyu1@linux.microsoft.com>, Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <awQe8NR3bnJoujMC@8bytes.org>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <awQOkV6RFl0TM6Hb@8bytes.org>
 <MN2PR02MB68630C9F5A4AD705B3838FABD4452@MN2PR02MB6863.namprd02.prod.outlook.com>
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
In-Reply-To: <MN2PR02MB68630C9F5A4AD705B3838FABD4452@MN2PR02MB6863.namprd02.prod.outlook.com>

On Mon, Nov 23, 2026 at 10:48:09AM +0000, Michael Kelley wrote:
> Hmmm. Did you apply this v2 patch set, or the v3 that Yuho posted a
> few hours ago?

I applied v3.
