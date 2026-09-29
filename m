Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162254A32;
	Tue, 29 Sep 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660429; cv=none; b=p59FdwU0idZGhRjlAO5fUgwE3gESpQZRaj1hV8Pa8MZ6itZAOM/tXPsIhfAonLxD7xIMyBSUyWnkUIFi+v9xBX3eUXoegWh+5k0TNfSB0/G9yYoz0sitGHsZjkHhV3cBi70f1gK8fAXocCm2AtN7/OYQlrrlK4CuB6YJ3UkLC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660429; c=relaxed/simple;
	bh=UwBNj/WRYvBhs+qLQKgoN88/2kBTeszB+PSYJ+ZygHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWsHb9XHE1SbrrK9db2s3jfFmTube686pCl91NtUq+N3og2NEnzfLdXW4bpiDnzHHDppNg6lDLTkVUXyWV3eqS5pV6CUPz5grvrLz4wy5l/DltXJmDKvtbgIT+NL6lmTJASoWA71f1yVS77aU4Fq7DsuP4wDjXrQwbStoSxuF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PJOuuQ1O reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PJOuuQ1O"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 90C9640E01ED;
	Tue, 29 Sep 2026 05:40:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LW9VMulucr1U; Tue, 29 Sep 2026 05:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790660414; bh=4lbDjmw7JtBgfO2hPYdY0U8ZEXv57xCD4oHdW903C5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJOuuQ1OX8x8eK+0w+F5cbdnUGSPrA8pi/h5SDJBeGEsOnwgCvPAVmrnHiPiObdDP
	 et7KfBmhLy+crcqPIG3X0MyMtYijQWmADye082P0afK3ztffARE+/RWwyVUB+gWwx+
	 meTKNH7NDq1RtEe3/bLWL6hwhWxD46FXH+HtJXG/0jDaGSxJfF6Pe3T1iWK45qot5U
	 2LfqvK13f6GD7tUmMVa1mn1dorgnMf08BKYtnKhMN5Gpu+b+r9+VmSfhxqQaSmo4KP
	 H+44JUWa/alrd+4EhBdHCePdSwe/MRXL8KAc/RdsPVYBd0n3lH3CqY/vAkqPrZrTGq
	 /M+W3xct/KCM/3iPxwfF/was8cNy/hc+25ugpW1cp2z2XqI+PePUOSiC1/zJj1fbpg
	 QQlb2Km0uC3V/R8nnJVzeUYcVNOtT6XvHAEZbLI+uYyVSBoKGGpme7aE5vmW1twx4K
	 J/4gGT7BVgeqZoCYcFQ0uJgtIEpGy1fNNiQG7DH3HLjukLsEm/kewzzgIueScAo7kH
	 yB83BPL6mbiHeGeMfrV4PGbWdqhmVdTw3lO+VJrbfAH86L2T+PeJ+huzdrnq025EzS
	 OxKWC/z/2nvnTSqHoZfDcGagnhp3WcaEniNGYCg78V+tMWGMGsSR7D9BZa7RfDZK8V
	 go6kmqSEINa+cyy3zeqxqcl8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2796940E015D;
	Tue, 29 Sep 2026 05:39:34 +0000 (UTC)
Date: Mon, 28 Sep 2026 22:39:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest
 setup
Message-ID: <20260929053930.GEartPEjbZMpBVSvSk@fat_crate.local>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 12:02:49AM -0400, Zack Rusin wrote:
> VMware publishes its per-CPU steal-time GPA without first sharing the
> storage in encrypted guests.

So this one liner is the only explanation why this patchset exists, AFAIC=
T. So
I asked AI. I'm pasting what it said below, at the end.

Is any of it true?

If so, how much and is that the reason this patchset exists?

I.e., you want for vmware monitoring tools to work with CoCo guests.

Yes, no? Anything else?

And looking at your commit messages, they don't really talk about why the
patches exist.

And I don't think you know your audience - you're sending a bunch of patc=
hes
touching arch/x86/ and you throw all that virt gibberish around like it a=
in't
no tomorrow and you're thinking that tip people can follow. And I think w=
e can
follow only bits and pieces but all of us will be mostly head-scratching =
here
and probably ignore the whole set.

So perhaps you should lay off your virt hat for a minute and try to expla=
in in
an approachable way what you're trying to do so that even non-virt people=
 can
follow.

Right now concepts are flying around left and right in that text and I ha=
ve no
clue what's going on here.

Thx.

P.S., here's the AI gunk:

"In this context, =E2=80=9CVMware per=E2=80=91CPU steal=E2=80=91time GPA=E2=
=80=9D is referring to **Guest
Physical Address (GPA)**=E2=80=93based accounting of **CPU steal time per=
 vCPU**
inside a VMware virtual machine.

Let=E2=80=99s break the components down:

- **Steal time** =20

  In virtualization, =E2=80=9Csteal time=E2=80=9D is the amount of time a=
 guest CPU *wanted*
  to run but **was not scheduled by the hypervisor** because the physical=
 CPU
  was busy running other VMs or host tasks. =20

  Per=E2=80=91CPU steal time means this is measured **for each vCPU** sep=
arately.

- **GPA (Guest Physical Address)** =20
  GPA is the CPU=E2=80=99s view of =E2=80=9Cphysical=E2=80=9D memory insi=
de the guest. It=E2=80=99s:
  - The address space the guest OS uses for RAM, MMIO, etc.
  - Translated by the hypervisor to real host physical memory (or nested =
translations with EPT/NPT).

- **Why GPA for steal time?** =20
  VMware (and other hypervisors) can expose performance statistics (like =
steal time, idle time, run time) via:
  - Per=E2=80=91vCPU counters/timers
  - Memory=E2=80=91mapped (GPA=E2=80=91mapped) structures that the guest =
can read
  - Paravirtual interfaces (e.g., hypercalls, PV drivers) which are often=
 described or backed by GPA regions

So when someone says =E2=80=9CVMware per=E2=80=91CPU steal-time GPA,=E2=80=
=9D they usually mean:

A VMware mechanism where **per=E2=80=91vCPU steal=E2=80=91time metrics** =
are exposed to the
guest via data structures located in **guest physical address space**, so=
 the
guest OS or monitoring tools can read those counters and attribute lost C=
PU
time per vCPU."

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
