Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F284A92FA;
	Thu, 24 Sep 2026 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272100; cv=none; b=Bl/eDe+4D6k3c+FbntUtaIJtKiDmVuTM62TRigDjiWz3mrDdsVI84npk53Vm+vK9so0EJxIiBgVvQqxGxca5W19Z22hs1XW4Svx/1Ms4bXqD7hQ2pWd5SYDCoUZMzGxV6sgE3/0yPXUdKbvD/kiKpVExldVKdL1/VsjLT63FYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272100; c=relaxed/simple;
	bh=gJTu2GKU6GBN9Ent8nfP/3LDprR16DIyQDpia6hxA0Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B2a1akGPtwe2yEegrODfzo9QPbKUw9hd2OhlgWof0EF7DM0ROkju17Bv3VSh4EcagxvCUUiQV+HCIg1o+v1/VSNXPtldAM5cPD2JvCg/WOF1nWInO0k4VSsvGqPmRbu2M/++wmm19sJRKlGWji8gXKWPLKP2pz3bCq/vfeNv8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i9n0hfl4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i9n0hfl4"
Received: from [100.65.161.51] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26E9120B7168;
	Thu, 24 Sep 2026 10:47:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26E9120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790272049;
	bh=dDnGDmx5A+LgnNNVIQ49CJjfmce0lnemjO1LvEOr3mA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=i9n0hfl4dqFez8rBG7yagyv08/eLYAhZ+PrwGXhSENTLA1m/g85tYweM3QgoQyCKb
	 ZiREM61/dwGIDuFQsoLQIoNHfmKg85wsWixVh32bSYEHh7OfIw0IMDnxanmjCGE8WA
	 6HC7QCrL+nFkxNO/96hPN+9gbxpiZNG/a0rrKIwE=
Message-ID: <4072da50-4c3f-4df9-aef9-789f2431e33c@linux.microsoft.com>
Date: Thu, 24 Sep 2026 10:48:17 -0700
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
Subject: Re: [PATCH V1 2/3] mshv: Import data structs around device domains
 from hyperv headers
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-3-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260924020221.128762-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 19:02, Mukesh R wrote:
> Copy/import from Hyper-V public headers, definitions and declarations that
> are related to creating iommu domains in the hypervisor, attaching devices
> to them, doing the reverse, etc.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  9 ++++
>  include/hyperv/hvhdk_mini.h | 87 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
