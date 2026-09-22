Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84629439F90;
	Tue, 22 Sep 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099322; cv=none; b=cJbBR4jjgUs4csONTlLiWFGtMsT6GoM22tkIzYBwWxeQzkLzLoebAkdqSVN8iDZupL6S2DOfzG0faQ8SfuiPMQeE2xl2kVue0++hL7Zh73TNNOm3WPCp3P+denCY9Y27JDtqxA+4z4XcWwgC/yPLRGC7mO9eaSNazz8/S50gdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099322; c=relaxed/simple;
	bh=hROc+a0Vg2NgIOCzGL4hJedwPNiwG4QC1dmVhkMm/BQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewse7nowBvhY/M8plRePVGDKaxAX4Px+i1Sx42V2OnGXtA6QMbQDwCJZMLp259F+KgUIUosrApLLCas3t8qEU3HLwBGKpAqOVT+mMyc9BU1rMpNN2/S5pOP/bC71mSqOZTPtRNDW5+M1bhSfkBk4fhTPWkbNSB3/fZC3+nTL/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MRGlkqCz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MRGlkqCz"
Received: from [100.64.33.11] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1055D20B7167;
	Tue, 22 Sep 2026 10:47:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1055D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790099273;
	bh=eaOnYQxE8z2ZJvsby/FJ6ww5rwVyjRrp/amSfAq2Pa0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MRGlkqCzcgIO7WmhjMdMJPX9S273nVQbqtNV+dTeqafhXD9sUabDkd3Cz+2RDHgfB
	 eRFlRx1/vfwU9zR/tMzoXGawKnS2sojdomUC59f1RPKFl4j5wEU/TUDv4e2M0viSJY
	 u1CYi0tSztY1bj9JJKmum+GolcR6hph/cYcXMaFs=
Message-ID: <5aaddb48-3061-4a4c-a081-67befa955143@linux.microsoft.com>
Date: Tue, 22 Sep 2026 10:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V0 1/3] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-2-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260921225028.4007330-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/2026 15:50, Mukesh R wrote:
> On Hyper-V, most hypercalls related to device domain management like
> attach device to a device domain, or to map/unmap regions, interrupts,
> etc need a device ID as a parameter. So, make hv_build_devid_type_pci()
> public and change return type to u64 to enforce it's size.

Nit: it's -> its

> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 9 +++++----
>  arch/x86/include/asm/mshyperv.h | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
No other feedback than the Sashiko review, so assuming that's fixed:

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
