Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74A3451A6;
	Wed, 30 Sep 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732545; cv=none; b=ENEx2GQTCaEIZcjHfYC85uF/Q/LPT41472yJqq7s+G5+b4rlDSluOxCAyKRRUM27DU1Z0JCMyPG2jYjNL828QJD1naRACCwh/0kaUKd1Vkcc8V9mPDl6qRKmjEPgUsHQ8Wfw6YixdWvhFYfF71Tg5BGJy8BtjXBd+7467cJ1JwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732545; c=relaxed/simple;
	bh=9/ufpXgRKQmyw20F0nxTinqLXJCyT6Hj4cOvFzY670g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS1pacM+oEW3+U7inbihPlP1ttPSJcto2HpUjviS5JBHBg0CgZClrmfSdjBApI9QFHlxn8VbPtUUfMWXCBuX5NFDcRyZ1EC2Pnmr15pE5MZGQ7r2wMoFlHiNwMxHPuSbA6pypUXf0Og8xEip2ZfX4KtE1bH34HJY/Jz2tvDYQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZajFZfH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZajFZfH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495501F00898;
	Wed, 30 Sep 2026 01:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732543;
	bh=JdG0BSz+fbqhQOpyolncd1TxC0GQe+jRVeUqSMMx7Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZajFZfH/vGJYM8fO6hd9VJN57Bko78bAXcpRJAvvAasjugmE/lkuUSL1WE2w/h/sY
	 X/5Ydl/zbf/jOV9sVlDo25LjEjjrYTZOzntMNUp5lqFXnamPFjInneZnVYtRh9ZbG8
	 fBVDt4xEKEWL9JCP4xZZhXRKrFXJ0tcGHUh6Br2YruPSNPyp/hWK9/0CrzR/ZKpj8A
	 2CDtUh9hltlgtgV/W8v31Nj0c9DYZB2WGPF5wghX8doLXOhc2Lble0rgVvlWcsAQLC
	 mXhqP8ckBGn6XOuF2i4CCFqOP6ML0HjWjQYvFQO2lDAltoFfOwUcKkcbcxFX0+cy+T
	 WhQmJha6o67tA==
Date: Tue, 29 Sep 2026 18:42:22 -0700
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
Subject: Re: [PATCH] KVM: x86: Clear CR3[63:32] on SMM entry from long mode
Message-ID: <20260930014222.GA4053400@liuwe-devbox-debian-v2.local>
References: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
 <20260928072534.1987-1-odys.yuan@gmail.com>
 <20260928174243.GA3705413@liuwe-devbox-debian-v2.local>
 <arqvqW7g72AnVsLK@google.com>
 <20260929005755.64126-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929005755.64126-1-odys.yuan@gmail.com>

On Tue, Sep 29, 2026 at 08:57:55AM +0800, Qiliang Yuan wrote:
> On Mon, Sep 28, 2026 at 10:42:43AM -0700, Wei Liu wrote:
> > Please share the Windows version from `winver`.
> >
> > My colleague said that it had been fixed. Maybe the change needs to be ported.
> 
> Windows 11 Pro, version 25H2, OS build 26200.9457, with WSL 2.9.3.0.
> The host CPU is an AMD Ryzen 9 7940HX.
> 
> This machine is fully up to date through Windows Update, and the failure
> reproduces on this build, so the fix does not seem to have reached the
> released builds yet.  Which build or channel (e.g. Insider) carries it?
> I am happy to test it.

Windows 11 Pro, version 26H1 should have the fix.

Wei

> 
> I have also filed it as a WSL issue, with repro steps and the SMRAM
> analysis: https://github.com/microsoft/WSL/issues/41709
> 
> On Mon, Sep 28, 2026 at 11:19:21AM -0700, Sean Christopherson wrote:
> > Ya, I'd much prefer to get this fixed in Hyper-V.  If we need to carry a KVM hack,
> > then at the very least it should be limited to when KVM detects that it's running
> > on Hyper-V.
> 
> Understood, a Hyper-V fix is the right answer.  Since current released
> builds are affected, I can send a v2 that applies the workaround only
> when KVM is running on Hyper-V, if you'd take that in the meantime.
> Otherwise I'll drop this and wait for the Hyper-V fix to ship.
> 
> Thanks,
> Qiliang
