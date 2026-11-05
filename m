Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908383;
	b=N14PPXqkUTiTvoBJ5oJAXf+0Dcy0Wjl+XFE4aeAScbtYKhCtqZpn+/rouzV+gqO6fXLQ
	 QLlVSb/FrJJJ/l3YPJ164opxKru6MxGHUJ8gFNNdRvUAZYL8ROF+33Giiq94oUmZQQUU2
	 oEFKj2FLr6hDTKTqGX/XRtiScXKZffee7LTXc17vsKsaMKIEYIA7juvi1M4VuywOHRqJx
	 FVCC6Out93geXqRrd6VtxtgwIAcKvaQUoQa4BguESv+FuZy8b0LF2IE9KupatYQHZcWiV
	 BRRveUPf+jE0ukVcGaSIIDPj9uWoPMrknADqBOrja40wSwOvnabEPoLq+NFKQV6YOmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908383;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=U1Jdue00BGFqywykSunZ46/p5KrmDrwoufmlu4fOFFU=;
	b=hxWXnPcaj3jd2FBFmNQfnLw9qxyMdwLuNMIr9TxWSJ/hWbl6Rwtdr5YkI1FAZgHqs00t
	 +LgP60OAJnROtZvCJw9tb6twmp1glfnkXVZ028C9bzh74LV60SyFbSqtDXSInsmuDKVFg
	 qx0zkhhGa6MMz09xJt2wz6ygu1F/rS8ujH5U/AmLoXSrurZwjyNXQKdWNegMOEqr1IHKV
	 uZS7zuuFzJVPN0mI8JYpppx2VtkYNdIIwml78paxG8mRCAByDoDEu7Dq3rOk7Ip/qO1vu
	 krPsljAhNnw9sUeOV1hMUgY4VrSHkXjTVdea4RncXGRpvaXLxqjCrEzfGA1yF4v2KZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="U/9eZprh";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3A606A329;
	Thu,  5 Nov 2026 19:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C3A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=U/9eZprh
Received: from [192.168.166.159] (unknown [67.168.101.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 925BD20B7166;
	Thu,  5 Nov 2026 11:52:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 925BD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793908367;
	bh=U1Jdue00BGFqywykSunZ46/p5KrmDrwoufmlu4fOFFU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=U/9eZprh3TcyRNg4Qz70hF5sZLajLC0+MZyi0iUbPi1OEgI6Ni78c8p9K2x5Qpt70
	 v2E1kImuwPrbu2NlKO8zFkXcDcDInrH2PDLWiita7wac4SZgag23Z4i5AjhE0nx7uW
	 ZWWRNpvFT1m4IpYqqmKA6TG2Kc+HRbe8Wpjedcck=
Message-ID: <b321af97-a39e-4b26-9dfb-e47e5d1dc044@linux.microsoft.com>
Date: Thu, 5 Nov 2026 11:53:01 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, easwar.hariharan@linux.microsoft.com,
 Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
To: Yuho Choi <oss.patchbox@gmail.com>
References: <20261105192738.70664-2-oss.patchbox@gmail.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105192738.70664-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 11:27, Yuho Choi wrote:
> hv_iommu_paging_domain_free() frees all page-table pages with
> pt_iommu_deinit() and only then asks the hypervisor to delete the
> device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> fails, hv_delete_device_domain() only logs the error, returns the
> domain ID to the IDA, and the domain is freed anyway.
> 
> The hypervisor then keeps a device domain whose page tables have been
> freed and can be reused for anything. The ID is also handed out again
> by the next paging domain allocation, while the hypervisor still has a
> domain with that ID.
> 
> Delete the domain before freeing its page tables, and keep the ID, the
> page tables and the domain if the hypervisor fails to delete it.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
> W=1); I have no Hyper-V guest with the para-virtualized IOMMU to test
> it on.
> 
>  drivers/iommu/hyperv/hv-iommu-guest.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
Good catch!

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
