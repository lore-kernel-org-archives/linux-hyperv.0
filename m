Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374252D2D5;
	Tue,  8 Sep 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866443; cv=none; b=buQhKuWG6HBIV6ZYTUPIXy1zPoLXkaC3Ru/jA/n1FBSw8DOjOXz5QV1i2zIMUFn7R3gQ6ZRCj+0jQLhrYa6lOzWuSuV6DEA+Vb7D8TOD4riUSnEh3YIFW8Ro1vW9tom/XM4EZVAHFSf//YpO+q84bdBdF7a6WztJS5y4EOQkIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866443; c=relaxed/simple;
	bh=FkoG8P8hgCUaeFjzF7cWY9R2Q9TIdToOfyFsgfbthng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnDDSqwCksTOap985seGm6oPhIGHkV/vnNEq57qNM2DzUXO7Bqx+Xs8QV+7vbyhT8fPapoEY95OQoA6cCvlIe0NTKiGpplnuj8Vf+Pg/ZxjsJ6+oynU2hrrsB+NqDlbotZwPcEECr4EKd+fjnm4N3H4YGlYV3S50QXyl464sFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjilL1e3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjilL1e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57D91F00A3A;
	Tue,  8 Sep 2026 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866432;
	bh=UYbQS95NtpTDJ0XIYcQUCeFZJDNj7K/I95/G1Xz9DBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LjilL1e3iICHu+khhy4e+RTewIrtr1TwvZhdc2BfyoWSCUT7GGRDl7kZmxVxA0s/S
	 Qxk8WBLC57pfhnbhQTvzKvVDhudZFntx19wfWghw0Dv35U4o3V3S+AGGVpiwnAmaQH
	 ban6W61/3EEDHVOv1Gsq0FeEpV6KIsWNANF3souAF77Cs3SYgHRvzZGuvlfX53qLUp
	 QR+xVNMBjcTAs0/REfl87kGkUlZraEq7vwgnNRTZTEXSpHYTj+eX2Mhh6Vy5q9T9An
	 fFiY/AQIEUkeTe5X6KxvISqJa7QIERD7SzBf/DgwAccAlQ/QCaE3NbcooXQ34JZA8j
	 N2EFe+6eL5qRw==
Date: Tue, 8 Sep 2026 12:20:29 +0100
From: Simon Horman <horms@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Fan Wu <fanwu01@zju.edu.cn>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: fix reset work race with device removal
Message-ID: <20260908112029.GT40544@horms.kernel.org>
References: <20260905023602.425827-1-fanwu01@zju.edu.cn>
 <20260906023851.AC7981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906023851.AC7981F00A3A@smtp.kernel.org>

On Sun, Sep 06, 2026 at 02:38:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Module text unmap race condition on worker thread exit due to unsafe module_put(THIS_MODULE).
> --
> 
> commit 690e7316a6c3698f99d06b66663e08bbcdb43123
> Author: Fan Wu <fanwu01@zju.edu.cn>
> 
> net: mana: fix reset work race with device removal
> 
> This commit embeds the reset service work in the gdma_context and implements
> admission gates using GC_REMOVING. This correctly synchronizes the service
> work with device removal and probe unwinding to prevent use-after-free races
> on the gdma_context.
> 
> Cc: stable@vger.kernel.org
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -796,48 +841,49 @@ static void mana_recovery_delayed_func(struct work_struct *w)
> [ ... ]
> >  static void mana_serv_func(struct work_struct *w)
> >  {
> [ ... ]
> > +	/* The rescan exits of mana_do_service() remove the device, which
> > +	 * frees gc before returning.  Only touch the pdev and the module
> > +	 * reference from here on; both are held until this point drops them.
> > +	 */
> >  	pci_dev_put(pdev);
> > -	kfree(mns_wk);
> >  	module_put(THIS_MODULE);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to call
> module_put(THIS_MODULE) directly at the end of a work item executing
> inside the module's text segment?
> 
> If a user unloads the module concurrently with mana_serv_func() executing,
> the module unload process (rmmod) will wait until the refcount reaches 0.
> When this worker thread executes module_put(THIS_MODULE), the refcount
> drops to 0.
> 
> If the worker thread is preempted right after this call and before returning
> to the workqueue core, the module unload can complete and free the module
> text memory.
> 
> When the worker thread resumes and attempts to return, it will fetch
> instructions from unmapped memory, resulting in a use-after-free panic.

It seems to me that this pre-existing problem should not block progress of
this patch.
