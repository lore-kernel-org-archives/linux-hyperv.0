Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3444236C;
	Thu,  8 Oct 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494623; cv=none; b=pb9jUr7cH1Z/kuvSnxCbJmD612mRzKsljziCEPV5sq2qXcfQGzfXGbrM2i7YljD4iTIiebrCoGeGN2SDaC4x0+ewZCdcIPVOvghPTVNdRffUbk05VMD57oxZlpvhHuJ2ZZyq2GtQcmTfic50jh2t4HAS3ymdWI2e2KBUqlZWzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494623; c=relaxed/simple;
	bh=ptUqKgOgpbLaT8nxgI2JlGP+jUe+nInzMl0MYK4VVwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUoA2OY+y1xZ3tzOpu2i+TcGWfkpIv96dE7Y34b3ix288vb87PFCCzwqwBzx5u89efZ75tAcRmYr9/wPM6oINop6igU84A8yLVRGgrMb8OkLaOquf0sfRONlsc3XJA4Onq2RnH5KJx1f+cQMaQU0WgkzWFImjGQy66OPiFqxRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mkhhYmb3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mkhhYmb3"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 6CA2F20B7166; Thu,  8 Oct 2026 14:22:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CA2F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791494563;
	bh=cI0qlX8zziuWUO0srn3a5Nreq74pAkWgwV5PCjNaBmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkhhYmb3BcX+EJoXp1gMjoFBRbEcd0TavEMBoizpbujeytA7aadjBV9cSeeB0Fxcc
	 PnUqcDew+LILnMJ1BZEar2VYZcAuYDh0hUcYdrix+SdZg1T0KZsPVcJIwTvnKBSqQz
	 JqhKG28E4mmUn/Ob3VKyPNPfiQMP20CLAFiKQhLs=
Date: Thu, 8 Oct 2026 14:22:43 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"andriin@fb.com" <andriin@fb.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
Message-ID: <asgJo+PasN8D+C/p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001014131.310771-1-kuba@kernel.org>
 <LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
 <5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>

On Tue, Oct 06, 2026 at 01:59:05PM -0700, Kameron Carr wrote:
> On 10/2/2026 12:38 PM, Haiyang Zhang wrote:
> > 
> > Thank you for making this patch set, looks good to me.
> > I will find a teammate to test it.
> > 
> > - Haiyang
> 
> I ran LISA functional tests (T4) in Azure, including XDP related tests
> [1], on the patch set based on v7.3-rc6.
> 
> I did not see any regressions in my testing, but my testing did not
> cover:
> 
>   * Hibernation scenarios
>   * Kdump tests (not super relevant but worth a note)
>   * Performance (XDP or otherwise)
>   * Scenarios trying to repro issues found in the patches
> 
Hi Kameron, Jakub,

I tested all five patches applied together on net-next base
8b4e7209c842, with additional targeted lifecycle/error-path
coverage on Azure MANA and mlx5 VFs.

Passing coverage includes:

* VF removal/rejoin: without reattaching the parent program, three
  cycles preserved its program ID. Exact-five synthetic XDP drops
  passed while the VF was absent, and propagation plus exact-five
  live VF XDP drops passed after each rejoin.

* Initial attachment refusal: a program intended for netvsc survived
  five VF-induced attachment failures, then attached and propagated
  successfully after restoring the VF MTU. It was reclaimed after
  detach and pin removal.

* Concurrent replacement/hotplug: while cycling VF availability,
  68 parent-program replacements between PASS and DROP succeeded
  without command errors (38 with the VF present, 30 absent).
  Final PASS/DROP packet checks and program reclamation passed.

* Deferred namespace rejoin: the parent retained the same XDP program;
  the worker moved the VF into its namespace, rejoined it and restored
  propagation, with packet-processing checks.

* Synthetic-device removal: the old program was reclaimed, the
  surviving VF accepted an independent program, and rebinding netvsc
  restored association and connectivity.

* Actual Azure hibernation/resume on mlx5 passed with the VF present
  and with it absent. The parent program and counter-map state survived
  without reattachment; post-resume packet checks passed, including
  propagation to the returning VF in the VF-present case.

* Incompatible arriving VF on mlx5: a VF-only MTU of 9000 caused
  propagation refusal. Netvsc kept the VF unjoined and its existing
  XDP program active on the synthetic path. Restoring the VF MTU and
  re-registering it allowed join, propagation and VF packet processing;
  final reclamation and cleanup passed.

* Join-failure rollback on mlx5: a bridge-induced -EBUSY after
  successful propagation detached XDP from the unjoined VF while
  preserving the parent's program and synthetic-path processing.
  Removing the conflict allowed rejoin, propagation and VF packet
  processing.

I am continuing investigation of synthetic fallback with an
independently programmed MANA VF and rejected-replacement restoration.

Regards,
Vennela

Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
