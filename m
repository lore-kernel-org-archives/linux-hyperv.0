Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E004078F0;
	Mon, 19 Oct 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411785; cv=none; b=oICpN8MrKjnm1ZkC4DVYcVnqc5V6WVOvA5MA+z2xsnHTSaPwdeFCbzjxxp1ObQWT0DlmOA+8vGItpZdd6jBGzVC4vYYtWs37ed1lxJn+8eBtgg95NLlN/1FvXBB1sjlEic9K82xoJlBPKj5CZDuMQzKZCbzQ583MX+Fp0Bz60gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411785; c=relaxed/simple;
	bh=66/kSXIZunIvMysX4NXfRh6x8iUihn5RIgQeItorBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtE5KvpaxwFeCrSGhvVMNyJSHJiBaMrSm/a252oeEMBZx3x5D0yeco29yTHN/5OcQizZAeP3geyQeuYvoUz2sXuLoFoeBFWq99/Jaze6aLlH2LmonJwSN7N1ezffweG47bfPUBQIBEXJkmDf9GPoFrmJxTNBZ7dOlZR6tWVBnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZAEyAWYv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZAEyAWYv"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 9B7DC20B7188; Mon, 19 Oct 2026 05:09:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B7DC20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792411777;
	bh=7srkqM2xefj9HVtBCkJOPVB1o5A3cjKerH/znl0Otwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAEyAWYvPJTNGxmIs2Wr/emJ/bVsFjprGvumEr9eZLulMzQk1L/KV9Pd8DmmGQ+y/
	 Dh4IimOUPA8RXzTeNsOyKWSp7KVI0nG7km5W1hMiz5gbrHom+i4eh8B1mzvPBPVD97
	 /cnUqEkpxBbYgagtiQvtNkDpEi7anXEg+fP9PpQY=
Date: Mon, 19 Oct 2026 08:09:37 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update information on guest
 CPU offlining
Message-ID: <atYIgc2jsyh9u1Uy@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261017160848.14730-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017160848.14730-1-mhklinux@outlook.com>

On Sat, Oct 17, 2026 at 09:08:48AM -0700, Michael Kelley wrote:
> In Hyper-V Overview documentation, remove the out-of-date reference
> to explicitly reassigning VMBus channel interrupts before taking a
> guest CPU offline. Instead, reference the VMBus documentation, which
> is already up-to-date on this topic.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  Documentation/virt/hyperv/overview.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
> index 77408a89d1a4..63489f73a299 100644
> --- a/Documentation/virt/hyperv/overview.rst
> +++ b/Documentation/virt/hyperv/overview.rst
> @@ -132,11 +132,11 @@ Starting in Windows Server 2022 Hyper-V, the ACPI tables reflect
>  only the CPUs actually present in the VM, so Linux does not report
>  any hot-add CPUs.
>  
> -A Linux guest CPU may be taken offline using the normal Linux
> -mechanisms, provided no VMBus channel interrupts are assigned to
> -the CPU.  See the section on VMBus Interrupts for more details
> -on how VMBus channel interrupts can be re-assigned to permit
> -taking a CPU offline.
> +A Linux guest CPU may be taken offline, and subsequently brought
> +back online, using the normal Linux mechanisms. See the "VMBus
> +Interrupts" section of Documentation/virt/hyperv/vmbus.rst
> +documentation for how VMBus channel interrupts are automatically
> +re-assigned if necessary when taking a CPU offline.
>  
>  32-bit and 64-bit
>  -----------------
> -- 
> 2.25.1
> 
