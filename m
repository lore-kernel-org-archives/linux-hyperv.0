Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FB37F33B;
	Mon,  3 Aug 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747897; cv=none; b=CjTp2X1Yihs2gR12vNipm1u7elOOIy6AUIB0BsB2+QyiPBQe5/jLZYW+uXuzXwGnoLieha0qsb7TpIdDRdsUwTNEF6I3M7MjqXx1qloKE42Q+YhnIQ2YMQDJddUQfvK7JuDMbMvuVSLuZheqzyuesmfmzHLu4fbwZHV+BN56uAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747897; c=relaxed/simple;
	bh=7I1Zxi0Zeu/M3aHpHsGWkbTmRhqprpfTeIhc/QZtKSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0LsFsz5mTYkXO939smlGcw7UFH061r8Ocl4rtJNrwWEkYYFhXFpMC3y0OPoPXXEsO2eAHTIrBRt/kRYQd+FXkirO95Rk7l1uzvHAE7reEa2Bfz60vhPd6hYNv3idwl5a70mnESBcCk5eR5EFarrlzIJhb2/zfyhtyH64yalKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALEcNoTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALEcNoTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F591F000E9;
	Mon,  3 Aug 2026 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785747892;
	bh=mWN6NBYH7YcJAAB7qf5lkagcg5aDI7/ZZmclJu+ByEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ALEcNoTjNBSTCCD5VGRGI5zkChN3XfCE76PcV7hyCNwgLARoEgGcwghmKpxj7nwJb
	 bas0bhVzuyLKNTqh+6pAGwfxf4qUpUyUJPIb9/XQFweGKXkYX1uacEt+7Hvsw3NP0a
	 lpsULPAjzsWLz6TZ+g89sSC3kh1j3lUKq6uDUKW5i70Qu5F39Y+J5ozDYRcO6VqJiO
	 KAA9mCKY3o0x+q8ac5BnG1C2aiiUJD2uEolcSa1F6El/h9Cja2YZ8ILED0reWUDezq
	 leCHDPKQLv4/Y2ybB7udvsAJ9978VGDAuu/B6zqkbGpvqYwGE1v7x3qcIIpn5bFt8a
	 kIgTSY2Cnah0w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, hch@infradead.org,
	robin.murphy@arm.com, vdso@hexbites.dev, mhklinux@outlook.com
Subject: Re: [RFC PATCH 1/1] x86/VMBus: DMA transfer with encrypted memory
 in Coco VM
In-Reply-To: <20260803033520.12930-1-tiala@microsoft.com>
References: <20260803033520.12930-1-tiala@microsoft.com>
Date: Mon, 03 Aug 2026 14:34:45 +0530
Message-ID: <yq5a8q6n4lsi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyu Lan <ltykernel@gmail.com> writes:

> In CoCo VMs, system memory is encrypted by default.
> Device drivers typically rely on the DMA core's
> SWIOTLB as a bounce buffer for DMA operations, providing
> decrypted memory that can be shared between the guest and
> host.
>
> For PCI devices with T-Disp support and Confidential
> VMBus devices (https://lkml.org/lkml/2026/7/27/1733) can
> perform DMA transfers directly with private/encrypted
> memory in a CoCo VM.
>
> To support DMA transfer with encrypted memory, Hyper-V
> DMA ops are introduced and bypass some API which may
> use swiotlb as bounce buffer.
>
> The DMA ops used is global data structure(see get_arch_
> dma_ops() and get_dma_ops() for details). There is no
> need to set up for each device individually.
>

Can we use __DMA_ATTR_ALLOC_CC_SHARED instead of checking
hyperv_private_memory_dma(dev) directly? Also, would it be possible to
encapsulate this logic in something like force_dma_encrypted(dev)?

Looking at functions such as hyperv_dma_alloc_coherent(), how does this
differ from dma_direct_alloc()? 

-aneesh
