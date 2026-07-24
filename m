Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C434392C32;
	Fri, 24 Jul 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930909; cv=none; b=Leq1ojCe5BgKRay0Lj3pXzIkwVAkx3/FrMopMQRIpT9cyJ3pRJSDIRF7TumKzHGrdt0MyrG0x4GbVHS7bpSJDIjpxmG3tYIJVXrOAl5DqOSqpK/xkJKrqd+eIzdqb04YcbHsngTGce26qWUPJkfya20PZIVy96lIl9PAFzbs0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930909; c=relaxed/simple;
	bh=l0U3dZ28LyDdd2d58YSyrNZlaRmSuLvYsNCrSGDqRY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWA52CDMavydFAWEIyYg2EWc9FpM9AUKWhWjrc7u8xc75SQEEyL21jCtO8XrsM5MwDfQnHIrkScQb1dRHSYwWDjsjE9UZRXb7GQJFc2a+nQYTB0S3g5AqH65UprAuujXLGp8n/zB6N16nvrxL+sxBM38tRTqPHCdL5Ua7JC4g9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g9HnKJXw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g9HnKJXw"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 41AB220B7167;
	Fri, 24 Jul 2026 15:08:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41AB220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784930892;
	bh=PneHZPZl/NkHqkk5l4fHfLS0UqzueCtDxEOMC/7Vibs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9HnKJXwSrSFtOmYBvW27/+B+EVq1VupYBhB239eDqO48ckvjYjgKKMnuXOHmeOQ7
	 nxuezF8GF4k+Svha8uP8GFtUa64ikLRIYIzvEneuQvObtP4OouSsKKLFEcCwFvCJsg
	 uLxl/8bNNZmq+oq55HzeaLhVAmtReB6YpyTUl/hw=
Date: Fri, 24 Jul 2026 15:08:24 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
 wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
 namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 1/9] mshv: Provide a way to get partition ID if
 running in a VMM process
Message-ID: <20260724150824.000075a7@linux.microsoft.com>
In-Reply-To: <95a1bed4-dd5a-654b-9e7a-7d5a453e3966@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
	<20260718021949.926306-2-mrathor@linux.microsoft.com>
	<20260723152132.000033d0@linux.microsoft.com>
	<95a1bed4-dd5a-654b-9e7a-7d5a453e3966@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mukesh,

On Fri, 24 Jul 2026 12:14:08 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> On 7/23/26 15:21, Jacob Pan wrote:
> > Hi Mukesh,  
> 
> Hey Jacob, pl see inline..
> 
> > On Fri, 17 Jul 2026 19:19:41 -0700
> > Mukesh R <mrathor@linux.microsoft.com> wrote:  
> 
>    ... snip...
> 
> >>   static int
> >>   add_partition(struct mshv_partition *partition)
> >>   {
> >> @@ -2073,6 +2094,7 @@ mshv_ioctl_create_partition(void __user
> >> *user_arg, struct device *module_dev) goto cleanup_irq_srcu;
> >>   
> >>   	partition->pt_id = pt_id;
> >> +	partition->pt_vmm_tgid = current->tgid;  
> > I wonder how robust this mechanism is to identify target partition
> > via tgid.
> > 1) what prevents a VMM process create more than one partition? in
> > that case each partition would have the same tgid.  
> 
> Currently, none of the VMMs we support do that, and doesn't look like
> there is much of a demand for it.
> 
My point is that from kernel UAPI pov, we cannot count on user behavior
nor current VMM's implementation.

> > 2) IIUC, the lifetime of the partition is tied to FD, which is
> > different than the lifetime of a PID. The partition FD can be
> > inherited or passed to another process. The VMM tg can exit while
> > the FDs can be alive. Then the tgid can be reused by another
> > unrelated process, right?  
> 
> yeah, AI keeps telling me that, but not super accurate imo.
> 
> we are using tgid and not pid. tgid is process group id, and that will
> stay around as long as there is at least one process in it. if we used
> pid, then that would be the case.
> 
I understand it is tgid but don't think tgid makes difference in terms
of FD lifetime.
e.g. process A creates a partition, then passes the partition fd to
process B over a Unix socket. Process A can then exit while process B
still holds a reference to the partition file. At that point the tgid
that was stored in pt_vmm_tgid can be reused by an unrelated process C,
while the partition's file object remains alive.

> > Would it be more robust to based this on the partition FD instead of
> > tgid?  
>   
> it might be, but problem with that is we need pt-id in other cases
> where that is not available: for example in
> hv_iommu_domain_alloc_paging and in irq remapping paths for direct
> attached devices. if we can sort that out somehow, then we can do
> that. but i suspect, it would take some time to figure that out, so i
> hope we can make that a future enhancement.
> 
> For now, i've been thinking of just putting a check and returning
> ENOTSUPP if a vmm tries to create another partition.
> 
IMHO, that only solves the uniqueness issue of partition ID but not the
lifetime issue.
maybe EEXIST instead of ENOTSUPP?

> Thanks,
> -Mukesh
> 
> >>   	ret = add_partition(partition);
> >>   	if (ret)
> >> diff --git a/include/asm-generic/mshyperv.h
> >> b/include/asm-generic/mshyperv.h index bf601d67cecb..e8cbc4e3f7ad
> >> 100644 --- a/include/asm-generic/mshyperv.h
> >> +++ b/include/asm-generic/mshyperv.h
> >> @@ -350,6 +350,7 @@ int hv_call_add_logical_proc(int node, u32
> >> lp_index, u32 acpi_id); int
> >> hv_call_notify_all_processors_started(void); bool hv_lp_exists(u32
> >> lp_index); int hv_call_create_vp(int node, u64 partition_id, u32
> >> vp_index, u32 flags); +u64 mshv_current_partid(void);
> >>   
> >>   #else /* CONFIG_MSHV_ROOT */
> >>   static inline bool hv_root_partition(void) { return false; }
> >> @@ -380,6 +381,10 @@ static inline int hv_call_create_vp(int node,
> >> u64 partition_id, u32 vp_index, u3 {
> >>   	return -EOPNOTSUPP;
> >>   }
> >> +static inline u64 mshv_current_partid(void)
> >> +{
> >> +	return HV_PARTITION_ID_INVALID;
> >> +}
> >>   #endif /* CONFIG_MSHV_ROOT */
> >>   
> >>   static inline int hv_deposit_memory(u64 partition_id, u64
> >> status)  

