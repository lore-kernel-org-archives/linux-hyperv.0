Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CC2BEFE8;
	Thu, 15 Oct 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083032; cv=none; b=CQV/3035+Ms6BxUQqa3gWXAO4XzqNoDZGn72rVdopJy8oKhgCVYtsIVauUIKqoEpj/n2A1m/BnQ2Is2riX+S3KlKy+D9wiJx1dUySimB/7Lz7mMNCKPv9q5pu6RW/ej0AeEje7W3yTmiz4fawlfYGpS78yrHVmMOF8px27PU7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083032; c=relaxed/simple;
	bh=kwO05T3qqu0Knw24HJuOBFda5ybbqoTOFE7jN5aLmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfRJU0X7RnGP9gb3A4o30blfookzHtWSvdZF4s/kg479NvmHL/YzjJCayUbw7eYQIM9PN82PVoMJD81F6Sre+1P2ca/ls+QYY5GPFo7Jansg1CTLZf2B54Y9B7ftETAGt8Pc2rebfb0EJGUvl1mOYB/ML6woSHdXFId8WxYXJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B77f84sA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B77f84sA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187871F000C4;
	Thu, 15 Oct 2026 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083022;
	bh=Tc9Cu4s2LXMLXjLFSTNNdSNBAebv41XQtzDLNL8AXlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B77f84sAAnckptgK5+lYZdqhM5B6J11Rl7UU1aS9um+5P9Uv67sbVixZ325ZxPHAP
	 Uee+z5dDQ0S9gjzvqUSWVzomNfgScoGec6Uv5yC5FB78GvpWsROKq6JxyqJFQRNYX5
	 uAeY6D34MkLc9F2g1HNriNxjGIp6X8YoT/lhUcMpeEU3c5b9L3GZNHA6uSDuZBHWQB
	 hyp6Sj0XxLdW80s5EtPBYL0HtskFKX0qs4Nqw6j5yKzms8p63PEp7AEgxq8ek8bLiH
	 QQQfF0SgGIf29tohXeJlzI3ZDBH76xOUB1i5ZXXbEcobdZU7agp7BF7bcf6S3OPFMT
	 XwUAi++KMQ5pQ==
Date: Thu, 15 Oct 2026 09:50:20 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Clear CR3[63:32] on SMM entry when running
 on Hyper-V
Message-ID: <20261015165020.GA1019583@liuwe-devbox-debian-v2.local>
References: <20260929-kvm-smm-cr3-upper-bits-v2-1-622429d0cd3c@gmail.com>
 <20260929014927.151141-1-odys.yuan@gmail.com>
 <20261010063853.4109-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010063853.4109-1-odys.yuan@gmail.com>

On Sat, Oct 10, 2026 at 02:38:53PM +0800, Qiliang Yuan wrote:
> Hi Wei, Sean,
> 
> Wei, on the v1 thread
> (https://lore.kernel.org/r/20260930014222.GA4053400@liuwe-devbox-debian-v2.local):
> 
> On Tue, Sep 29, 2026 at 06:42:22PM -0700, Wei Liu wrote:
> > On Tue, Sep 29, 2026 at 08:57:55AM +0800, Qiliang Yuan wrote:
> > > This machine is fully up to date through Windows Update, and the failure
> > > reproduces on this build, so the fix does not seem to have reached the
> > > released builds yet.  Which build or channel (e.g. Insider) carries it?
> > > I am happy to test it.
> >
> > Windows 11 Pro, version 26H1 should have the fix.
> 
> I upgraded and retested.  The failure still reproduces on 26H2:
> 
[...]
> Wei, could you check with your colleague which build actually carries
> the fix?  If it is only in 26H1 and not yet in 26H2, that would explain
> it.  I am happy to test any build.
> 

Sorry for the late reply.

I asked my colleague. There are two options:

1. Go back to 26H1.
2. Stay on 26H2, but wait until December, after the 11.D LCU update is
   delivered (ETA late November).

Wei
