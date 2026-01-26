Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228122A4E1;
	Mon, 26 Jan 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457535; cv=none; b=sWHRVpu12sPzgABpmebuR2J5mzhJo7CBdYOvFuQJQ9oIxdfTaZfVVU5Xkl13UyIquNiWKjSxlysxz5sSAjTgyZlXsWUEEHpw3Pm7ejDgdLpghVcqUzt7oR+9Q8kB1tV8/htz8M3yrJiYjfxSzINpnXa/T1g5njEyvvxpLwmyBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457535; c=relaxed/simple;
	bh=gpEGhhknN7TzCJjkZ66nConf3Yk3nMin5RZ3GnJaav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfWrR+Heg7giKOtnFI1TydR0kM7bVCjVtpvDIPulBAdNLDrsm/QPffHT5sMTbKnRr3FWp9dqZYKtA7oyLwGq7rQiHFUJUq5NDjgBEPDZm55UiP/yPf/Eya9anhxXxM0vViOvZQOSEBZsFseHMSaONiPBa8gzolXl4i0ypGKS5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA516Go6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA516Go6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB65C116C6;
	Mon, 26 Jan 2026 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457535;
	bh=gpEGhhknN7TzCJjkZ66nConf3Yk3nMin5RZ3GnJaav4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA516Go6hiQe3HJiBvib21exVP/J/+RZoB6ZOQQrbwm4XLglnt4Qe0y2o3PSC5GcZ
	 k+/51GyDGLn35lbVHLG4mf26jLNunFyZqxQ6GaJCGrHG4JFywDFjZNKH66auOAtzTF
	 L+19jgiFDe/lbC2rmJi1wbg/cUn4bfihd60c+ZGRljmutdxa3ZDDocf8O99ON1utfF
	 F8Gro+4lJ0vKTKS5Uf96+A3UTkT2byjypi5gz96DYa7sPANEjGufxlZmDlhIQoSgWl
	 74Q9ec8ZeIMKiBaKU8Wsxn8KDLnS25xNTF85kamks8WLqHeqbX7Y9qe9OaQsh5/ihV
	 C9kmhyKN6hORg==
Date: Mon, 26 Jan 2026 21:58:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, yury.norov@gmail.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	ssengar@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <20260126195850.GO13967@unreal>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
 <20260121201412.179f9b37@kernel.org>
 <aXJhzi58GqLKtui4@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260122180745.3b5607cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122180745.3b5607cf@kernel.org>

On Thu, Jan 22, 2026 at 06:07:45PM -0800, Jakub Kicinski wrote:
> On Thu, 22 Jan 2026 09:43:42 -0800 Erni Sri Satya Vennela wrote:
> > On Wed, Jan 21, 2026 at 08:14:12PM -0800, Jakub Kicinski wrote:
> > > On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:  
> > > > Enhance MANA driver logging to provide better visibility into
> > > > hardware configuration and error states during driver initialization
> > > > and runtime operations.  
> > >   
> > > > +	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
> > > > +		 gc->num_msix_usable, gc->max_num_queues);  
> > >   
> > > > +	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
> > > > +		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);  
> > > 
> > > IIUC in networking we try to follow the mantra that if the system is
> > > functioning correctly there should be no logs. You can expose the debug
> > > info via ethtool, devlink, debugfs etc. Take your pick.  
> > 
> > We discussed this internally and noted that customers often cannot
> > reliably reproduce the VM issue. In such cases, the only evidence
> > available is the dmesg logs captured during the incident. Asking them to
> > re-enable debug options later is not practical, since the problem may
> > not occur again. Similarly, exposing the information via ethtool,
> > devlink, or debugfs is less effective because the data is transient and
> > lost after a reboot. As these messages are printed only once during
> > initialization, and not repeated during runtime or driver load/unload,
> > we decided to keep them at info level to aid troubleshooting without
> > adding noise.
> 
> You will have to build proper support tooling like every single vendor
> before you. Presumably you can also log from the hypervisor side which
> makes your life so much easier than supporting real HW. Yet, real
> NIC don't spew random trash to the logs all the time. SMH. Respectfully,
> next time y'all "discuss things internally" start with the question of
> what makes your case special :|

+100

Interesting. Completely independent of your comment, I provided the same
feedback on their mana_ib driver. They added debug logs to nearly every
command, even though those commands already had existing debug logging.

https://lore.kernel.org/linux-rdma/20260122131442.GL13201@unreal/T/#m51e8a12f4bca4a6c1377c5531c8a6d94a43af1e5

"In order to simplify things for you: unless you can clearly justify why this
print is required and why you cannot proceed without it, I must ask you to stop
adding any new debug or error messages to the mana_ib driver. There is a wide
range of existing tools and well‑established practices for debugging the kernel,
and none of them require spamming dmesg."

Thanks
