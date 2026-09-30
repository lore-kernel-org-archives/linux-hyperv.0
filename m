Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBF3B47E1;
	Wed, 30 Sep 2026 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758468; cv=none; b=mnEgI5YW+Klq7I2iK+jJruQM65Z25U8OM8xACXk6vNTR43HPW6jrJtZwAnsclWZzJPDq+aS7ssbp47UZwmgJlZ7tJTZej9CiLb/cqgUiLWn2+DeJak/tGZF0ThAFHn613L/+h7OQSf0A/0IiYPmCvVdWFJBnPTUx9W5jGfGlYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758468; c=relaxed/simple;
	bh=/bg6wWvn3UxxefOMsl8JIomiL9mMcf6RS3vUGzzxCZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsbuHRseMrk9O3C6HL/bKNM5qdpL+C7j9HHIq22WaMu8FEztCP1wZOtyhNdyiVB/Rf703m/DuzCVKj/6MvAXWxTEGwA/jmtDxQAQ4LYdC9BTaStEFCFycOV1ZQK/d+Pv0TB099yHVFbCp7thgXd2O5iS2q8Xu6avBjP+wxbiqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJzc5jIL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJzc5jIL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0UFYYKBUewXLJbGJZ9BEDna7/dDF99emZQefLuG6AWg=; b=aJzc5jIL6ZEo+riFOwoxR1oSNm
	C2hf1HPOb9+KTK8px2ooi5YPLIeRFxTZoinR6pVkeYDaZKn09QeR00yhVqRRjAPKdAPRJkoIrT7S/
	hRxVygx6bLPrPlKZSnQKreIhSWLLbwZnFvcJlIoRpu0zHhaZDBm7i980rS/vK3fK3nujDtN/6z8l8
	fLgOlnTOkOldZJL6u6dcGPuFYD8IOAfYYLYx7hVPjXkwkJJiUSDbMGWUxsizvsvnVwzDCw78nf0AV
	IzzNDXK6Hdr8Iec9g2P2seZ7jfrgAs9zrZtJEFt/4RzEbuMhSVTPiYHQJ3yrkx4qqkpIjr6CULMaD
	pmozWVDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBq4s-0000000B7se-1SQm;
	Wed, 30 Sep 2026 08:54:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9DFA300673; Wed, 30 Sep 2026 10:54:13 +0200 (CEST)
Date: Wed, 30 Sep 2026 10:54:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86
 encrypted guests
Message-ID: <20260930085413.GH88198@noisy.programming.kicks-ass.net>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-3-zack.rusin@broadcom.com>
 <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
 <CABQX2QP0+Jr6gG0nZkDggvyGWCSHMNVKPPavZTYBqH+wg7rdMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABQX2QP0+Jr6gG0nZkDggvyGWCSHMNVKPPavZTYBqH+wg7rdMg@mail.gmail.com>

On Tue, Sep 29, 2026 at 01:12:45PM -0400, Zack Rusin wrote:
> On Tue, Sep 29, 2026 at 3:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> > On Tue, Sep 29, 2026 at 12:02:51AM -0400, Zack Rusin wrote:
> > > @@ -1022,11 +1024,13 @@
> > >   * Note: We use a separate section so that only this section gets
> > >   * decrypted to avoid exposing more than we wish.
> > >   */
> > > -#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > +#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
> > >  #define PERCPU_DECRYPTED_SECTION                                    =
 \
> > >       . =3D ALIGN(PAGE_SIZE);                                        =
   \
> > > +     __start_percpu_decrypted =3D .;                                =
   \
> > >       *(.data..percpu..decrypted)                                    =
 \
> > > -     . =3D ALIGN(PAGE_SIZE);
> > > +     . =3D ALIGN(PAGE_SIZE);                                        =
   \
> > > +     __end_percpu_decrypted =3D .;
> > >  #else
> > >  #define PERCPU_DECRYPTED_SECTION
> > >  #endif
> >
> > So you're page aligning something that will get different protection and
> > will thus shatter large pages?
> >
> > That is somewhat uncool. We like large pages, large pages are good.
>=20
> I'm a huge large pages fan too. I have a poster in my office and
> everything... And I never do things that are uncool. I have a wwcdd
> (what would cool dude do) bracelet and I look at it every time I make
> a decision, which given that I'm old gets on my wife's nerves a lot.
> That is to say I'm handsome and innocent.

:-)

> The alignment isn't new. It has been there since ac26963a1175
> ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED") under AMD_MEM_ENCRYPT,
> which common distro kernels enable. This patch extends it to TDX-only
> builds and adds the boundary symbols. On bare metal and in ordinary
> guests nothing changes protection, so no large pages are split.

Right, I saw it is pre-existing, but you made me notice ;-)

Anyway, the thing that wasn't immediately obvious was that we only
really change the protection for (sekjoer) guests. This means I mostly
don't care.

> In confidential guests, yes, converting each CPU's page splits the
> direct map around it. The alignment doesn't cause that: a large

Nit you could 2M align, so alignment is somewhat related.

> mapping can't be part private and part shared, so a converted page
> can't stay inside one. The alignment only keeps unrelated per-CPU data
> out of the shared page. Because that page sits in every CPU's per-CPU
> unit, each 2M mapping that holds one of them becomes 4K mappings,
> including the ordinary per-CPU data around it. In the layouts we've
> tested that's most of the first per-CPU chunk.

So perhaps a little more invasive would be poking at the per-cpu
allocator and having a whole 'decrypted' pcpu_chunk which is 2M aligned
or something.


Anyway, as long as this is sekjoer guests only, I really could not be
bothered much. Proceed, but perhaps put on a comment in the
vmlinux.lds.h to clarify this, for those of us who do not live in
coconut land?
