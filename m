Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3A387590;
	Mon,  2 Feb 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052656; cv=none; b=PhzuhF4zuaG19Bo6PgG4dRoEe9egcojaTQ8tY4lhXqCxikqUGVS2h1vTB7fb0MvithWb06B0ieIuCZfvRVX75jdEMjCD80bM9vWCZmeF6KGk9rBKqURcWrtINw7sLZD1I0D9zVkzZFcC6Zv45rp/v5D5dB+19FoL1K+HLphzAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052656; c=relaxed/simple;
	bh=0EXPWx6gK5TMXO/I1b6XKCb6jDIKj9u4skG5GDciBro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U11fevy08vY9NhMNaC7S/ffx+HltcRgVZlOe4Bf1lGaPLW4YvkQUmlqChFOEj22J9fbfoEtnoS/HBrD388PXBDGCQ7gixsdsbImmQshxv5qpy1Sg6Ssy6vfMJR1+T72z2F/fFj/xYwVEnH+ZHEee320Ps7FHgjoW6Cj0FJbST0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h1EbHfML; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h1EbHfML"
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5BBE520B7168;
	Mon,  2 Feb 2026 09:17:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BBE520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770052653;
	bh=0jeEoWDNCvytgrFGnrZvA1H89uYkckkrOnIgWui2AyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1EbHfML2SsQdvEfEBkirxjJuIFEIQAIE2/dvQh5XKu53GD211LtSsi0PIf0zyigI
	 Fo3inhq9Yxw3qQSDDZIhhyGw9wUwAqvTgGicecLk23IFkl1JK/SNB3XJgvhtrAOhBJ
	 TbfmGDRSBREyWVHBBfF/aTPZZCb+jaKGAcc6J0HE=
Date: Mon, 2 Feb 2026 09:17:33 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: mhkelley58@gmail.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Message-ID: <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
References: <20260202165101.1750-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202165101.1750-1-mhklinux@outlook.com>

On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Huge page mappings in the guest physical address space depend on having
> matching alignment of the userspace address in the parent partition and
> of the guest physical address. Add a comment that captures this
> information. See the link to the mailing list thread.
> 
> No code or functional change.
> 
> Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 681b58154d5e..bc738ff4508e 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
>  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
>  		return mshv_unmap_user_memory(partition, mem);
>  
> +	/*
> +	 * If the userspace_addr and the guest physical address (as derived
> +	 * from the guest_pfn) have the same alignment modulo PMD huge page
> +	 * size, the MSHV driver can map any PMD huge pages to the guest
> +	 * physical address space as PMD huge pages. If the alignments do
> +	 * not match, PMD huge pages must be mapped as single pages in the
> +	 * guest physical address space. The MSHV driver does not enforce
> +	 * that the alignments match, and it invokes the hypervisor to set
> +	 * up correct functional mappings either way. See mshv_chunk_stride().
> +	 * The caller of the ioctl is responsible for providing userspace_addr
> +	 * and guest_pfn values with matching alignments if it wants the guest
> +	 * to get the performance benefits of PMD huge page mappings of its
> +	 * physical address space to real system memory.
> +	 */

Thanks. However, I'd suggest to reduce this commet a lot and put the
details into the commit message instead. Also, why this place? Why not a
part of the function description instead, for example?

Thanks,
Stanislav

>  	return mshv_map_user_memory(partition, mem);
>  }
>  
> -- 
> 2.25.1
