Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C063C1406;
	Fri, 24 Jul 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928439; cv=none; b=Lh2Y2wntWqxFuQ2MLvZN7Oqfjo/BpBz2zFqysSaDcaHfppyFz+ghBHqHbOqcoS57OUHvP2I5Zdz1VrgvJ9NDr0YmkuRfeAbrtaIrShMcy7FjgcCmfITZ6ieMauPIYb6FlL3py3kDr02eLuORuOnhCCwWHsKF6KkoTt+bE4otVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928439; c=relaxed/simple;
	bh=NtVQHDy8W3ARFlBEv09wYjq9IcSPyLv+rX53IelUR64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l46I0yzy87A7tqdZ3pbI+u9CtyGoqnSPK1EVi741Dissy+6OwqaXtap9dg98B+2pnGMwV6pg7wtOoz5AY6TwSwBKgWXvjGzkEiZqiTkU7wj6IQ9ai1PmPKZ1C9aQIofPj7E2RCfMPnZl6aG0kjBtpslXPcylYmSwycMvd6R2xKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TVwyBm3U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TVwyBm3U"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3148220B7167;
	Fri, 24 Jul 2026 14:26:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3148220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784928417;
	bh=+2DfQz0WksYaHZRCX+mn44icL/nRYrBNqbKbbdL5Trg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TVwyBm3U683sTJIIg8iFNWNBUzY4krHBS0lhLAK+KWjHZQ2WgO+IKGoOPJ8ZYVAdv
	 wmvYcnBptvPKbx6j+LdAZhmM5VyltYtJfDU/LcHvNaxda4nH22ghK+3abU14hOeQqb
	 eDkFAgrdfjV+YeO/kO2tJclBoYXNuLd5drq9vyCY=
Message-ID: <699d622d-636c-d75b-aef9-c04f4201b306@linux.microsoft.com>
Date: Fri, 24 Jul 2026 14:27:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V4 4/9] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-5-mrathor@linux.microsoft.com>
 <20260724102029.00001c54@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260724102029.00001c54@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/26 10:20, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Fri, 17 Jul 2026 19:19:44 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> +	hlist_add_head(&mshv_dev->device_ptnode,
>> &partition->pt_devices); +
>> +	mshv_partition_get(partition);
>> +	rc = anon_inode_getfd(vfio_ops->device_name,
>> &mshv_device_fops,
>> +			      mshv_dev, O_RDWR | O_CLOEXEC);
>> +	if (rc < 0)
>> +		goto undo_out;
>> +
>> +	devargk.fd = rc;
>> +	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
>> +		return -EFAULT;    /* cleanup in
>> mshv_device_fop_release() */ +
> In failure, user never gets the fd, so it never close it. We are leaking
> fd until process exit, right?
> 
> Maybe we should do anon_inode_getfile(...) and do fd_install() only if
> copy_to_user succeeds.
> 
> Thanks,
> 
> Jacob

Hey,

right, but efault should result in sigsegv and immediate exit... unless
some rogue vmm is trapping it and doing something malicous in which case
all it can do is fill up only its own file descriptor table.

given that the above is same as kvm_ioctl_create_device(), i think it
is ok to leave as is.  if you think both need changing, lmk.

Thanks,
-Mukesh

