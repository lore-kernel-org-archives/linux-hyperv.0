Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278842248B3;
	Thu, 23 Jul 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845301; cv=none; b=nqLrNoGeg+Jgi39Szqsow0krNRm1CogtIfqMTp24xDgaMqbdCoAb9Iv51h01mLiFXxvUNtW4Qwhmd3iztdtCrZUjkWHhDHU/UnaI69j/FeIZBSDCPKwlT/cGF68ic5APtGuaMWSPAkcPiP0gwk/pg0J8bbIzYOrNmdtJ37faRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845301; c=relaxed/simple;
	bh=jRjNU63euG8u6Q0ohvAKCusnzjz1gtBjg+sRRcaZvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ4YbjcnyegFq0tdcuwMsqrlw7Teb+KRLDNr0pxJy8uJOSCAftYHmFwgNcTgovQHoFsJQ5qijyr5i8cojot+qUEWraannsR77eoxrn9G//KurLWT9ETxQm5vqmbwDXVCh+YEhZLD7ZQ3Fp9jPfaCreDKxgcAnJDSc97vU5p6VQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wwzh2zQj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wwzh2zQj"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CEDE20B7167;
	Thu, 23 Jul 2026 15:21:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CEDE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784845280;
	bh=0xpxcb1kD++/7ds8cxGz7zRhCeEmlS8zeWkpqy5r6UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wwzh2zQjr3xmAuvDfe18XRboCe+xANsOpQ6QRgj3mc6pTfti+ngXxEeiG36Kmj5fL
	 A+W+vzxRZI6EorRnX3zMDp8qF43D6dKmF7MXXzsbIzz+9RagiaYXERdVOhZwIpARyx
	 tCezr3yT+4iMq7vVOR7GNIU+KftKHTnC7VcDFICM=
Date: Thu, 23 Jul 2026 15:21:32 -0700
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
Message-ID: <20260723152132.000033d0@linux.microsoft.com>
In-Reply-To: <20260718021949.926306-2-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
	<20260718021949.926306-2-mrathor@linux.microsoft.com>
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

On Fri, 17 Jul 2026 19:19:41 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> Many PCI passthru related hypercalls require partition ID of the
> target guest. Guests are actually managed by MSHV driver and the
> partition ID is only maintained there. Add a field in the partition
> struct in MSHV driver to save the tgid of the VMM process creating
> the partition, and add a function there to retrieve partition ID if
> the current process is a VMM process.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root.h         |  1 +
>  drivers/hv/mshv_root_main.c    | 22 ++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  5 +++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 1f086dcb7aa1..a85c24dcc701 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -138,6 +138,7 @@ struct mshv_partition {
>  
>  	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
>  	u64 isolation_type;
> +	pid_t pt_vmm_tgid;
>  	bool import_completed;
>  	bool pt_initialized;
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd..02c107458be9 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1908,6 +1908,27 @@ mshv_partition_release(struct inode *inode,
> struct file *filp) return 0;
>  }
>  
> +/* Given a process tgid, return partition id if it is a VMM process
> */ +u64 mshv_current_partid(void)
> +{
> +	struct mshv_partition *pt;
> +	int i;
> +	u64 ret_ptid = HV_PARTITION_ID_INVALID;
> +
> +	rcu_read_lock();
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
> +		if (pt->pt_vmm_tgid == current->tgid) {
> +			ret_ptid = pt->pt_id;
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +	return ret_ptid;
> +}
> +EXPORT_SYMBOL_GPL(mshv_current_partid);
> +
>  static int
>  add_partition(struct mshv_partition *partition)
>  {
> @@ -2073,6 +2094,7 @@ mshv_ioctl_create_partition(void __user
> *user_arg, struct device *module_dev) goto cleanup_irq_srcu;
>  
>  	partition->pt_id = pt_id;
> +	partition->pt_vmm_tgid = current->tgid;
I wonder how robust this mechanism is to identify target partition via
tgid.
1) what prevents a VMM process create more than one partition? in that
case each partition would have the same tgid.
2) IIUC, the lifetime of the partition is tied to FD, which is
different than the lifetime of a PID. The partition FD can be
inherited or passed to another process. The VMM tg can exit while
the FDs can be alive. Then the tgid can be reused by another unrelated
process, right?

Would it be more robust to based this on the partition FD instead of
tgid?

>  	ret = add_partition(partition);
>  	if (ret)
> diff --git a/include/asm-generic/mshyperv.h
> b/include/asm-generic/mshyperv.h index bf601d67cecb..e8cbc4e3f7ad
> 100644 --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -350,6 +350,7 @@ int hv_call_add_logical_proc(int node, u32
> lp_index, u32 acpi_id); int
> hv_call_notify_all_processors_started(void); bool hv_lp_exists(u32
> lp_index); int hv_call_create_vp(int node, u64 partition_id, u32
> vp_index, u32 flags); +u64 mshv_current_partid(void);
>  
>  #else /* CONFIG_MSHV_ROOT */
>  static inline bool hv_root_partition(void) { return false; }
> @@ -380,6 +381,10 @@ static inline int hv_call_create_vp(int node,
> u64 partition_id, u32 vp_index, u3 {
>  	return -EOPNOTSUPP;
>  }
> +static inline u64 mshv_current_partid(void)
> +{
> +	return HV_PARTITION_ID_INVALID;
> +}
>  #endif /* CONFIG_MSHV_ROOT */
>  
>  static inline int hv_deposit_memory(u64 partition_id, u64 status)

