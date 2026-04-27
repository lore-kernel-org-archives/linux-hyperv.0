Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A0359A70;
	Mon, 27 Apr 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307501; cv=none; b=myyt9bq/VqBx4qfb7zO8go75fxyTch+rlVIWAXiBiUYec1eD7gT4maYYKNIz7EPoL6zTN999MzyogRg8FQt07V+o6hV6eTavIhcZEnYYlJMZTYNZaz5mRO4xXKHUq9pINhUW9IIwZX07PHUOjAXtUcQFKppQthY9EuerxzBv21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307501; c=relaxed/simple;
	bh=EmBgN/l8famoiPgynzTW/sALQPUBysGWNc0lBt29TW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pKlHB8Tu07AMP36uu9As85fp2i30u2n/zYfy5gSSZrbm2gnCX0Awy0pf7S/Tb429qp7NwGvFwvZCxmyTIaAMxey/nY7MzCjaA0kP4TZFlIYf1QXOsL0F7BeAhvJfpGem1Q93uGj7jWQ4R8pzXyYmg7J0Ho/lm+LY9jJ+YXVjIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RinZmw0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RinZmw0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19613C19425;
	Mon, 27 Apr 2026 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777307501;
	bh=EmBgN/l8famoiPgynzTW/sALQPUBysGWNc0lBt29TW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RinZmw0FkguzhJm6YLBMK0Rxd0yaMn/wfzwEiaKqPJ72QskJB9Eng4b2HCqoImhxa
	 hlnylvgXjDQyeCkaIZhrCut/b8JregTwmKlf1QmUqCWuLSA10NqYx5TOBVeUpu4NSR
	 K0CnW8D+MgRtdXRsL3+Hk+VulUfGfB6dZQe2iYeAHoqkKnQ3DnmzjKVnhtIRkIBbVl
	 flMFoHVKLkX2RFOPvEIN7jqi4PKDxBIm/FynjwF9aULAR052tEAdpge0xGsIwkD9g0
	 zfLpeYq6WwvZQHhJNeZZmnaXaHf08SFwwE245gvr0ZmIOLM2jFqa4ivOJ+PJwV6jP+
	 KvhpqWUdQIjlQ==
Date: Mon, 27 Apr 2026 11:31:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 08/13] PCI: hv: rename hv_compose_msi_msg to
 hv_vmbus_compose_msi_msg
Message-ID: <20260427163139.GA157548@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-9-mrathor@linux.microsoft.com>

On Tue, Apr 21, 2026 at 07:32:34PM -0700, Mukesh R wrote:
> Main change here is to rename hv_compose_msi_msg to
> hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
> patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
> is not used on baremetal root partition for example. While at it, replace
> spaces with tabs and fix some formatting involving excessive line wraps.

Would be better to do the whitespace changes in their own patch,
although several of them should just be dropped (see below).

Capitalize subject ("PCI: hv: Rename ...").

Add "()" after function names in subject and commit log.

> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -30,7 +30,7 @@
>   * function's configuration space is zero.
>   *
>   * The rest of this driver mostly maps PCI concepts onto underlying Hyper-V
> - * facilities.  For instance, the configuration space of a function exposed
> + * facilities.	For instance, the configuration space of a function exposed

Oops, this hunk made it worse.  Definitely don't want a tab there.

> @@ -1954,7 +1955,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  			return;
>  		}
>  		/*
> -		 * The vector we select here is a dummy value.  The correct
> +		 * The vector we select here is a dummy value.	The correct

Another tab that should be a space.  Actually, you should just drop
this hunk; the rest of the comment has two spaces after periods, so
this should too.

> @@ -2046,7 +2047,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  		/*
>  		 * Make sure that the ring buffer data structure doesn't get
> -		 * freed while we dereference the ring buffer pointer.  Test
> +		 * freed while we dereference the ring buffer pointer.	Test

Same here.  This makes it worse.

> @@ -2226,7 +2227,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  /**
>   * get_bar_size() - Get the address space consumed by a BAR
>   * @bar_val:	Value that a BAR returned after -1 was written
> - *              to it.
> + *		to it.

Just put "to it" on the preceding line.  There's plenty of space
there.

> @@ -2580,7 +2581,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
>   * new_pcichild_device() - Create a new child device
>   * @hbus:	The internal struct tracking this root PCI bus.
>   * @desc:	The information supplied so far from the host
> - *              about the device.
> + *		about the device.

Ditto.  If you want to change this, put "about the device" on the
preceding line.

> @@ -3422,7 +3423,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
>  	 * vmbus_allocate_mmio() gets used for allocating both device endpoint
>  	 * resource claims (those which cannot be overlapped) and the ranges
>  	 * which are valid for the children of this bus, which are intended
> -	 * to be overlapped by those children.  Set the flag on this claim
> +	 * to be overlapped by those children.	Set the flag on this claim

Another hunk that should be dropped.
