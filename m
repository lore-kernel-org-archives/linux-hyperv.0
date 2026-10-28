Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207630;
	b=ZtozLyFHgArf751PW3u1Nd7DHdgtsdN23E0UO0pIOTJKo1SkBnYR5EuDZQJMLUhVtdsO
	 njKeFYdbtQll3YFBWBgVTTxQzE+1SNB6LYMA1T9V7pXEHWy4vzPSrz8f/7iHZWJp+irJl
	 fCuGKCSORDx6NG1ay1BR1XneuUqxBNPJcO2QRmqH65JyNDsk2Lo9Xov/+8fz3mY568kbX
	 Lm5VCmkxxuw+swWLFX39s1mmx7xigwc3R+giHYW4YEYQ9ovMOWLI2cAisfQIzG6vz7rt/
	 ERHsEr/kYHros8O47LNZdYIZ5xghwYXA8gCytVuJ1Ioxi4+UwdRYTKWKrtsu1s1b+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RykkFgDTYQiR/nYWDVJXymuvZ54o0JmV+s//fwJkcts=;
	b=mZ2DdJDwzM/R//Y1K2kw+jNvZCVHJmwhuBy8U0EnBo02IKCPLeOPevXScsApxTejdn5n
	 6y7ce5GBGN6zzit79c1ugPyM5iScrEWYB79kRYIV6pQST4GJZRpmn7yWp9buXEzZxnjE7
	 zfZrTX9j1c/n0lulgo/YgyFMV42X422A+F1wb9b8esb9IKqwwkDw48P89A8GveOQ6jSRo
	 4TJ+t326tA5GVMMVkCChn47RKc5rNlTgBAuNvjZ16p0Z7BUx4eU4GTraAg/s+l3awMk8j
	 jitjLYM4DDfZPjCfBjkkC4i6y0QxzjCpZiU2hDhyQFr/50e/fbeyBgdzZQlPTlShA+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYEdlo5f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DF606A31A;
	Wed, 28 Oct 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYEdlo5f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A079E1F01825;
	Wed, 28 Oct 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207629;
	bh=RykkFgDTYQiR/nYWDVJXymuvZ54o0JmV+s//fwJkcts=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HYEdlo5fv0OlJxITzS1isKT0MvJqzWvy5+L3slahnmY1BzOaM7seAzvBMfV6yTvWe
	 ol1K58GhiMd9UANziQMYMwLuwhAvLfGLQgz5gsTbF4N1FSiz38bpU+qc9e1B6BIKiC
	 0wsSwz80RR+KStVIo+xJ7uBi3suwm2Z3VYMF1QBd3FFhCie+PPGxP0UVmxe5Vn68Lz
	 vn2K1JMzBTHacFUWOGgRFWiwJu8Zw4aTJc+6Avo1YCYGHxQCmqQIY8nAcAKqi0dC/t
	 rGeejEZ8eUt4jBc+TrP4G+slTAz94urq4m+AWmQm5gCtZ1X4rn/y8CdF8FDmd7yPOg
	 3cfboZ8f48Ucw==
Date: Wed, 28 Oct 2026 12:13:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Message-ID: <20261028171348.GA560291@bhelgaas>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028155559.138833-1-mhklinux@outlook.com>

On Wed, Oct 28, 2026 at 08:55:59AM -0700, Michael Kelley wrote:
> In a system with multiple devices with the same configuration (such as
> NVMe controllers), the affinity masks are the same for all such devices.
> Linux typicaly must select a single CPU from each mask to be the effective

s/typicaly/typically/

> @@ -881,25 +1016,48 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
>  }
>  
>  /*
> - * Pick the first cpu as the irq affinity that can be temporarily used for
> + * Pick the first CPU as the irq affinity that can be temporarily used for

s/irq/IRQ/ if you want to follow the majority usage in this file, also
below

>   * composing MSI from the hypervisor. GIC will eventually set the right
>   * affinity for the irq and the 'unmask' will retarget the interrupt to that
> - * cpu.
> + * CPU.
