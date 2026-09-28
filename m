Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA34EDCDB;
	Mon, 28 Sep 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617366; cv=none; b=uHd47VzrVcRVyNodcJkuQsiQ2Xuf3SNetBfuUu6MlE0GMUcTQaX2JhatSr4L2MUqj2ODnN/Qw925GRG7B4UeHtLfD4dTfqgFWJIeETRzv+RjWv5ih7lrnq9fCxnlIjA9EyvmrDO0JJwbqLDKGuUrqQmnamiXTlF6kMLmbXk1CDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617366; c=relaxed/simple;
	bh=6NCfchU+PQQZyERuUU2Ed3mKB3UP4iu3pRSwW0GBrJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIoZDMHkirpFx+g/LfDfr0G22GhsMli50L0wU0iFT2Vn2qzgxlq0bPbPx8XV9XmvsCXPTsfDp38jayqnaoOSb/ZIxLfelpbk/yXPBK3ef6BTzdoR5KGtm227yClomgOMAbQQV0sjVyalfjbVTRYoOPt+0P/u9Kkyj1ALnj9ZCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRKeJG7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRKeJG7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AECA1F000FF;
	Mon, 28 Sep 2026 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617365;
	bh=UDattfyukG7O26TIJoHp52x3bz/aQeuPX0drEE2gCME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QRKeJG7FT4AQ4KAYYnwg1Mgg7UXxChV50eEcr/SFojsjo22EJ/71nY8A1n9aLaFAh
	 +x0/3gJq12IUg+gctN1VCGLqIlG11+F4YRpkeM0yEJobM58QhXe7IwEextZCLR+vIr
	 t8GE0cxP9lg8569mYudNnG3L7UeOOl43PL+WOQZSL4xduMer7Ff23lCBsr5bAmwfx1
	 R4EFqgVLHMoRimgJC9t5LY7EcUubpkstATxMuLdrtOe6rWGS4k6S/AUuTFZ3F+/svg
	 aWRK//5WaugSCngCHXmGszR2oSw7ZwPQ5wt4P/eMQQQp2lnaDWPzxw/aR82myDp+nO
	 TwXsPHUWSqrvQ==
Date: Mon, 28 Sep 2026 10:42:43 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Clear CR3[63:32] on SMM entry from long mode
Message-ID: <20260928174243.GA3705413@liuwe-devbox-debian-v2.local>
References: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
 <20260928072534.1987-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928072534.1987-1-odys.yuan@gmail.com>

Hi Qiliang

On Mon, Sep 28, 2026 at 03:25:34PM +0800, Qiliang Yuan wrote:
> +Cc Hyper-V folks and linux-hyperv, since the failure is triggered by
> Hyper-V's handling of VMRUN for a nested (L1) hypervisor, i.e. KVM
> running on WSL2.
> 
> For the Hyper-V side: the VMRUN is rejected when the guest state has
> CR0.PG=0, EFER.LMA=0 and CR3[63:32] != 0, a combination that bare-metal
> SVM does not reject.  Is that check intentional?  If it is not, a
> Hyper-V fix would help older KVM versions as well; either way the patch
> avoids creating that state in the first place.
> 
> The full patch is here:
> https://lore.kernel.org/r/20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com

Please share the Windows version from `winver`.

My colleague said that it had been fixed. Maybe the change needs to be ported.

Thanks,
Wei

> 
> Thanks,
> Qiliang
