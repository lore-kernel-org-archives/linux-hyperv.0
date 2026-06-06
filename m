Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552330BF67;
	Sat,  6 Jun 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780742094; cv=none; b=nW+NAVuUxTN5tkfbtl2VsBeOOC3S/F0Zol4hRFIwI9akk07x9ToOifVG6G4eybPYTRPiGOvSNaX2zpLI5FxO421WYXY+ZXiMwwyrWflB7A0YAiwpr9gOFROQuiop5+jupy18Tc7YoYZuLPcI+A67mymFOFE/cE/7OxAB6ZMrLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780742094; c=relaxed/simple;
	bh=HjP63eMiZ3E5RbC63Wf6TIubQrzpeHmhV/E4yWzmoPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3YuNyolnDqVE55m6+VWl8Jnfi8wcIWn0uPjD9WxkuNr3W92eAgLAGBOHjqSsYjZIpaaLTOzqlRFpA5OuFJcuKO3ofIWFIFJZMsCrwB50yMhkuFeZpMvZ4CqsPGN2f30055jYJDm0nHE45WSob8xJgjLh6rifO/JzhMa/ileXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXyU/D82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXyU/D82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDCD1F00898;
	Sat,  6 Jun 2026 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780742093;
	bh=NtWrycsv8R2U43lwkz14BzyHb4n6w50k0ikzyF9jV3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IXyU/D8264eSLC2QDbXcAcYtJaBaXZQFhc3eMNaexij+8rWkr00hLcCxbU8sE+dyX
	 mA+0vh4jhmQewxXtcNgNlHzXYQxy3xltXkTXAvckzwoIzIHRe33MgJj8Z/eoKIZg7/
	 OS3AcAdgYKZfgsMlvmrE9ixBzNG2b9ZZdmXOqeb5AoGkbbvWGXnmwwu7r9FDGH7MPJ
	 /ags4E/71IJXIaZDB2vgU6XhD0IfqTYGjQGdAaEMrOXXRxdiQY3pri70AgZucTGyCC
	 26QCAArNsLQlKTvztPntE64Lex8sfSLNWgTTXMw3c1CK7vs7qdGaoXt7ZZuAKprlo6
	 2CEQuUIqJnPEA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
In-Reply-To: <20260529144435.704127-11-seanjc@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-11-seanjc@google.com>
Date: Sat, 06 Jun 2026 12:34:50 +0200
Message-ID: <877boc554l.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:

> Now that all paravirt code that explicitly specifies the TSC frequency
> also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
> and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.
>
> Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
> by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz command
> line parameter"), one of the goals of the param is to allow the refined
> calibration work "to do meaningful error checking".
>
> Note, preferring the user-provided TSC frequency over the frequency from
> the hypervisor or trusted firmware, while simultaneously not treating the
> user-provided frequency as gospel, is obviously incongruous.  Sweep the
> problem under the rug for now to avoid opening a big can of worms that
> likely doesn't have a great answer.

There is a good answer I think.

early_tsc_khz exists to cater for the overclocking crowd. On their
modded systems the firmware supplied TSC frequency (CPUID/MSR) is not
matching reality anymore. So they work around that by supplying a close
enough tsc_early_khz and then they let the refined calibration work
figure it out.

Arguably that's only relevant for bare metal systems and what's worse is
that in virtual environments the refined calibration work can fail,
which renders the TSC unstable.

So I'd rather say we change this logic to:

   if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
      tsc_khz = x86_init.....();
      force(X86_FEATURE_TSC_KNOWN_FREQ);
   } else if (tsc_khz_early) {
      ....
   } else {
      ...
   }

Along with:

   if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
      if (tsc_khz_early)
         pr_warn("Ignoring non-sensical tsc_early_khz command line argument\n");

or something daft like that.

The kernel has for various reasons always tried to cater for the needs
of users who are plagued by bonkers firmware, but we have to stop to
prioritize or treating equal ancient and modded out of spec hardware.

TBH, I consider that whole KVM clock nonsense to fall into the modded
out of spec hardware realm. Do a reality check:

   How many production systems are out there still which run VMs on CPUs
   with a broken TSC and the lack of VM TSC scaling?

I'm not saying that we should not support the few remaining systems
anymore, but our tendency to pretend that we can keep all of this
nonsense working and at the same time making progress is just a fallacy.

I rather want to have a more fine grained differentiation and
prioritization of:

  1) The actual real world relevant use cases which run on contemporary
     hardware.

  2) Still relevant use cases on slightly older hardware with less
     capabilities

  3) Broken firmware

  4) Modded out of spec nonsense

  5) Support for ancient museums pieces

Thanks,

        tglx

