Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984135F17D;
	Wed, 27 May 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922214; cv=none; b=LFlJ9pLtAA2Pr4QqKPzNZnMwyCA3NVQVQm3Jw9jw8Aov/ZEsaBH9rXTMo9a6tqarJITaMqQv2BviW+2JTk5owtFTFMMIvGJHWMRUJBHTtL/CjTr4XmkW5jXHUI1sa+vy6Z38nLHxSs9HlVUR9P2EZVO0QoFfbAjEYnDYHUBUw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922214; c=relaxed/simple;
	bh=I1mh+WXdn3DJH/1izv88kW35bL0bW0gkAxAUFf0AjIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Z0lPtPPCc+a15Hf44Y7tl4Ll/ER6IkZZBK0+t2+RCPsbdpNI3d+ICC7HqCpZTHH8fy3D9N6y3l6PrwbPFbmjz8dzgy/Pi7dJOhAUsIbLMoT2BgXIS3xrU9C/8l1zesZod7zCfLlQH4I68qPIuZ0ABS1y0ijZJEplXIxwqPNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvHw6RfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvHw6RfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB701F000E9;
	Wed, 27 May 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922212;
	bh=GkJ3bVBiuZQji2Ar/qCbKZ6GVH9IRMh8D8UCLnr9oL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvHw6RfUo8q13AfIMSrfTXDnKC9TNLDz0TfgHCd2nAa7Rw0UjAxRs3PuQXAC70E4j
	 dUV1hwv8WgHSfxZTiVKtOmKoDRBvPNTMpfcCslLv244RjTgo5c6gRI5GHB7zSHISWE
	 +rOtjJEE4nQT8elNuQ+u2LpOrQI3xCZDHWpdl618JKxPF0n3G8f7YVeVwxbx6DPccG
	 gNOhaGkupr2qae3+gXPonWvl/UxwhoB09REhet3n6B/5aJtpf6NgtajOJaN7jmtUW9
	 k8x/PEH/sgeC+TFB3zT6b58ZeWVmK9c5NvlRkPOwb6lxLgv8IM8cbHvhO9q+ci1l3c
	 O7AO2Zur6/Jsw==
Date: Wed, 27 May 2026 15:50:11 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Michael Kelley <mhklinux@outlook.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 08/41] clocksource: hyper-v: Drop wrappers to
 sched_clock save/restore helpers
Message-ID: <20260527225011.GF3518940@liuwe-devbox-debian-v2.local>
References: <20260515191942.1892718-1-seanjc@google.com>
 <20260515191942.1892718-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515191942.1892718-9-seanjc@google.com>

On Fri, May 15, 2026 at 12:19:09PM -0700, Sean Christopherson wrote:
> Now that all of the Hyper-V reference counter sched_clock code is located
> in a single file, drop the superfluous wrappers for the save/restore flows.
> 
> No functional change intended.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
