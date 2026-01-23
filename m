Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD4279DC9;
	Fri, 23 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192595; cv=none; b=ZmOPsX4KlgmeGlMLpGEcdp8MRwiILYuWDhcJs5mel4/ZplpMN4eAjYUpDF0BLudXY7E48OD3IIbHOvuCwhW0sT4hSCqYDe4Hl+hzZzrm4Fsgap9qDo3HGblZ6gut6fNJtxe6Un4HIYuVL09XKm37+7K+nRbZrj97Tz6CsSwoolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192595; c=relaxed/simple;
	bh=MEyY8GOBWUJDY8rEF5Zd4HVF4yIttXDYJoRqTvoySqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQviflChEVSUR2ryFqjNoTZVfUVT7a4AAiLIs/4YOGCUpiCfa16dQww6BI1jQ0TKwlKMOgN0wa0n/Rn2UoSDxNTx2mA44P1tXXvCQNQXwyfYgRfi9YwCC26YCDTRLCszxflLAInD7z70qIgAtKw80/6F8Js3gAn+zFYT0Yx6pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QjSCNtxz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QjSCNtxz"
Received: from [100.65.200.94] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B6BA20B7167;
	Fri, 23 Jan 2026 10:23:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B6BA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769192585;
	bh=oEGl/tnoimH8y8JY83vb7PwQ86H3tjg5VxpV1bbsBJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QjSCNtxzEhRg6U/ueRjHRaw98P/cSWWNtXZUsYDH4gc80MbbvPU+CmjXRiqGgAABx
	 eS3DvI7hcfflcEy7gCrCztVGp4KlDCM3MgwSjQUThwsnGKn1EN/XeharNXH43mpcrD
	 LKzop3RyFjrOANn6ow1GGzaeYELgTRK66NHfiu8o=
Message-ID: <420bf947-2dc5-4a6b-9766-0eff4d1e1618@linux.microsoft.com>
Date: Fri, 23 Jan 2026 10:23:04 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 04/15] mshv: Provide a way to get partition id if
 running in a VMM process
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-5-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260120064230.3602565-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/2026 10:42 PM, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Many PCI passthru related hypercalls require partition id of the target
> guest. Guests are actually managed by MSHV driver and the partition id
> is only maintained there. Add a field in the partition struct in MSHV
> driver to save the tgid of the VMM process creating the partition,
> and add a function there to retrieve partition id if valid VMM tgid.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  1 +
>  drivers/hv/mshv_root_main.c    | 35 +++++++++++++++++++++++++++-------
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3c1d88b36741..c3753b009fd8 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -134,6 +134,7 @@ struct mshv_partition {
>  
>  	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
>  	u64 isolation_type;
> +	pid_t pt_vmm_tgid;
>  	bool import_completed;
>  	bool pt_initialized;
>  };
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 1134a82c7881..83c7bad269a0 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1823,6 +1823,20 @@ mshv_partition_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +/* Given a process tgid, return partition id if it is a VMM process */
> +u64 mshv_pid_to_partid(pid_t tgid)
> +{
> +	struct mshv_partition *pt;
> +	int i;
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode)
> +		if (pt->pt_vmm_tgid == tgid)
> +			return pt->pt_id;
> +
> +	return HV_PARTITION_ID_INVALID;
> +}
> +EXPORT_SYMBOL_GPL(mshv_pid_to_partid);
> +
>  static int
>  add_partition(struct mshv_partition *partition)
>  {
> @@ -1987,13 +2001,20 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>  		goto delete_partition;
>  
>  	ret = mshv_init_async_handler(partition);
> -	if (!ret) {
> -		ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
> -							   &mshv_partition_fops,
> -							   partition, O_RDWR));
> -		if (ret >= 0)
> -			return ret;
> -	}
> +	if (ret)
> +		goto rem_partition;
> +
> +	ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
> +						   &mshv_partition_fops,
> +						   partition, O_RDWR));
> +	if (ret < 0)
> +		goto rem_partition;
> +
> +	partition->pt_vmm_tgid = current->tgid;
> +
> +	return ret;
> +
> +rem_partition:
>  	remove_partition(partition);
>  delete_partition:
>  	hv_call_delete_partition(partition->pt_id);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index ecedab554c80..e46a38916e76 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -211,6 +211,7 @@ void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
>  void hv_identify_partition_type(void);
> +u64 mshv_pid_to_partid(pid_t tgid);

This should go inside the #if IS_ENABLED(CONFIG_MSHV_ROOT) section.

>  
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.

