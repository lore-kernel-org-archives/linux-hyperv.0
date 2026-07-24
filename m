Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE044C51F;
	Fri, 24 Jul 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913634; cv=none; b=RdDEYDiNFx6AGo4FkyLeya4REEMg1pS69eQYDwIcFgj8vf356eTZo11aGQNOmW+ef3PleCSkmIL2u843DH/Nw2EFmwSywpkyrZc8UTFywwfNwCs4g9np7ztKUte7nAupuAj0Dr1+kJKCAi+nCOrHT2/txIexOM/08wTBhsKlX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913634; c=relaxed/simple;
	bh=1XweS3MhAEKL8qL338oxMFBUaD+hC3sekT3IpM0WjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3+rV3EQ5fxPbJrSmXSJB93htcmarO53zaY97YFUGq9KSTip4FU9EZPUvXWZyX7vBrxjYO4Eyj/E0W1YvenIxvHiTJDnq+hTtjHalItFDIC2CjKnyKcmGWUbvnlxgbtS+GZV1V5DMbT8oxbFWuIj0fy+fzGnRiv4ekqMwmm8qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LPVPKdwC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LPVPKdwC"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F41A20B7167;
	Fri, 24 Jul 2026 10:20:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F41A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784913618;
	bh=exmV4vB4M1gvwqWEvEgVq2gXLar6JKNXr5Q6sujGD6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LPVPKdwCejskD/VNR1D1+ofN6PNGB99acB9b+QRYrpvHoxZFPqi8E7cEFUxSGrbnW
	 JY2Qb6p93S/PUf8RSTrF3O84CajD4bN5WSnzFZ1lzC8yJVLvpadIPEev0sczcpkUod
	 48LuZzThKZE0aYtm+owPTc/WflhX7pwOvdmcLIuY=
Date: Fri, 24 Jul 2026 10:20:29 -0700
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
Subject: Re: [PATCH V4 4/9] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Message-ID: <20260724102029.00001c54@linux.microsoft.com>
In-Reply-To: <20260718021949.926306-5-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
	<20260718021949.926306-5-mrathor@linux.microsoft.com>
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

On Fri, 17 Jul 2026 19:19:44 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> +	hlist_add_head(&mshv_dev->device_ptnode,
> &partition->pt_devices); +
> +	mshv_partition_get(partition);
> +	rc = anon_inode_getfd(vfio_ops->device_name,
> &mshv_device_fops,
> +			      mshv_dev, O_RDWR | O_CLOEXEC);
> +	if (rc < 0)
> +		goto undo_out;
> +
> +	devargk.fd = rc;
> +	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
> +		return -EFAULT;    /* cleanup in
> mshv_device_fop_release() */ +
In failure, user never gets the fd, so it never close it. We are leaking
fd until process exit, right?

Maybe we should do anon_inode_getfile(...) and do fd_install() only if
copy_to_user succeeds.

Thanks,

Jacob
