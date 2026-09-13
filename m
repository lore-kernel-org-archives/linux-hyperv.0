Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839213D53C;
	Sun, 13 Sep 2026 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339920; cv=none; b=Bn47EBl94ORUrhsC0sBxGqAFbs+U8pzrgzLEDM+bZdI9qvBRnS80CyskUrgwglEfyikNeDdKeOSm4BeNYAOLPveEgLCosVc3FkBTKhbyiKDVU5N+cp6Uwspj/9zNp459CB6aSPlwwMtsqivBhCosZTiDC57nXwaJLI58/DcucdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339920; c=relaxed/simple;
	bh=jTH6+iMMviCQyd4/k7LjG/62LhglXYEmMtvN74VzJSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5BDw47hRYf2yNYKZOmM9OtwtsOkxkchRFlGosKjxAZZCgR20FNlE7/EDVIKSQZH2sy13Yy6KD95D7TCesInurmSQS3TWbpjNA0+7KVmB0LJWkm6Wl1kt/pwr99ZpwB+i8eITRVlxu0OXvysoFKY32ko8xDtaod63+U2HPPQjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtAFhaI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtAFhaI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889801F000FF;
	Sun, 13 Sep 2026 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339918;
	bh=n6dHFvcFo6RJ79bt1/3aqxDTS97jgvVAqZ9spFHnYoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OtAFhaI60Q29Pgh5QtRyj0/QSTsdnM0CnPL+REHetoBAX5Y8FUuwrqwT6y2Q1+3yN
	 ZzEtlFQ6skB1ff+Yr7C1R2CC8EwWPTDbMZWogcYdML4VFSAaq5qvjcBse7eClGDqFs
	 2ubF/C/Iehh+cKY7Ijf80Cscz4KqdunPVpnJio2wZFyHTIEhOzu0ZuNwK+X9Le3dhx
	 Mr5Bebn4h4adiaxTUbwoZvoO0gI2Rt9sxwiPQBq66uPpQ4JwCIYrEmavFflgOxdCXr
	 mqICdGJZ9/lho6g2o9KYbnStt2xzQVskW78ANjXImG41pdIrnI2lIqLjsGGdAD/zrI
	 YkmKY9WKDX8Cw==
Date: Sun, 13 Sep 2026 15:51:57 -0700
From: Wei Liu <wei.liu@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Message-ID: <20260913225157.GG2219269@liuwe-devbox-debian-v2.local>
References: <20260913221039.2218950-1-wei.liu@kernel.org>
 <20260913221940.05A1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260913221940.05A1A1F000FF@smtp.kernel.org>

On Sun, Sep 13, 2026 at 10:19:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The patch fails to hard-wire `PCI_INTERRUPT_LINE` to 0 during 16/32-bit reads, introducing inconsistent emulation behavior.
> - [Medium] Modifying the returned integer via `char *` pointer arithmetic is broken on big-endian architectures.
> - [Low] Extraneous closing brace causes a syntax error and breaks compilation.
> --
> 
> commit 34dba20e549ad1a394e94eeb91577f3b24614432
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
> PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
> 
> This commit hardwires PCI_INTERRUPT_PIN to 0 for Hyper-V Discrete Device
> Assignment, as it does not support legacy (INTx) interrupts. It addresses
> an issue where 16-bit or 32-bit reads miss the previous 8-bit emulation
> and yield non-zero values.
> 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 89816a2bd7cd3..e6db82413addb 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1240,6 +1240,16 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
> >  			mb();
> >  		}
> >  		spin_unlock_irqrestore(&hbus->config_lock, flags);
> > +
> > +		/*
> > +		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0, since it
> > +		 * may be read using a 32bit read, which is skipped by the
> > +		 * above emulation.
> > +		 */
> > +		if (where <= PCI_INTERRUPT_PIN &&
> > +		    PCI_INTERRUPT_PIN < (where + size))
> 
> [Severity: Medium]
> Does this logic miss PCI_INTERRUPT_LINE?
> 
> The previous emulation blocks in _hv_pcifront_read_config() explicitly
> hard-wire the 8-bit read of PCI_INTERRUPT_LINE to 0.
> 
> It seems a 16-bit or 32-bit config read encompassing PCI_INTERRUPT_LINE
> would leak the hardware's non-zero value, violating the design intent to
> hide legacy interrupts.
> 

We have not seen this in practice.

> > +			*((char *)val + PCI_INTERRUPT_PIN - where) = 0;
> 
> [Severity: Medium]
> Will modifying the returned integer via char * pointer arithmetic work on
> big-endian architectures?
> 

We don't support big-endian.

> For a 32-bit read on big-endian systems, casting a u32 * to char * and
> indexing by byte offset modifies the wrong byte in memory.
> 
> This could fail to clear PCI_INTERRUPT_PIN and might accidentally zero
> another byte like PCI_MIN_GNT.
> 
> > +		}
> 

Oops. I had somehow deleted the opening brace when cleaning up the
patch.

A new version will be sent out.

Wei

> [Severity: Low]
> Could this extraneous closing brace cause a compilation failure?
> 
> It doesn't appear to match any opening brace in the added block, which
> would break the block structure and lead to a syntax error.
> 
> >  	} else {
> >  		dev_err(dev, "Attempt to read beyond a function's config space.\n");
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913221039.2218950-1-wei.liu@kernel.org?part=1
