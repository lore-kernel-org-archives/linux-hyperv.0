Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5022F83AE
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296648; cv=none; b=K8+6GNfOODybi8f1clYGdvs8wkflpN2WT0myeqFelB9s0kn39ARjctTDVXFX9hbFlkmFsYOLV5mNRhWngTzSYkVt7mx4VWSVOVOcIKXIoR+S2zWIi/ntKDHnp3MCjGWCiZ3h/WNQwzb+w8iHn05y7wA4rNb7EEZT/ZcFsetTEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296648; c=relaxed/simple;
	bh=pTmiIW1/CUNAQAC760N/p+JDf8FmonEhErCxgRbvBoY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LZGZ3BskPlVKaKzD22Xx720OdF7vdMC77lLlpJnqVe1BgwJvFZIn4dLuV+qYkCHt29/pH9RF2PqCWqu7VCn0PomNUQyeMFAyHAux3bTQx8aLIrasCqV+WBhnsEYwEJcBdtJSwqjjqkUzLrYu2HEea2AURchbLGLIp08xWkWmzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB32jaYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB32jaYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A00C19424;
	Sat, 28 Feb 2026 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296648;
	bh=pTmiIW1/CUNAQAC760N/p+JDf8FmonEhErCxgRbvBoY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BB32jaYSh5CO6mMATePA3Rtl/whOTwvye+bKZwUoKwKV6iptgOgCXGH1Ye3Ogy3oQ
	 AB4xFNr9uxchMWUcDlaU3Pg5qVj3eApat1jbBO5P4DyqIW+vuRImfo0IfOClADu13I
	 jQ3dYaIKbrsdpYuj23BihvjadG6q7YkW7HfeKMSC1gVPUQQDz5+g5Q5sHY+yoHIcsK
	 3MeAxoNGeVDsyCJkRFGTbTRG/KvWoBkb3X0WDxJHryTSlxCVCHZzrEYpnHlD3dDI6s
	 IEWw2MJ8Zs2EcuhiFkn7VgdmDc8ggSrSWySCLbDetx3C2VslQHKt5rNMczH8choFHm
	 6ZjpiSA8v4lXQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 495B2F40084;
	Sat, 28 Feb 2026 11:37:27 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Sat, 28 Feb 2026 11:37:27 -0500
X-ME-Sender: <xms:xxmjaVzwkU9fsjwrr3yo6xFqNiwrtjD36JjccLZPM6n3lvKjR7fGsA>
    <xme:xxmjaQHTdDf_s6xdzl_an8alxhL2ws2Fx6ot3WKYemppaGwNd8Da60Ix-i3WV7dMQ
    z6ip3KKwc0YaXGNn5NFJX-UmMCVB0gTyI-7QIRZT-7H_8EccWqH0GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrnhgurhgvfidrtghoohhpvghrfeestghithhrihigrdgtohhmpdhrtghpthhtoh
    epuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopeifvghirdhlihhusehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmrhgrthhhohhrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqhhihphgvrhhvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xxmjad0XVHcx2Uu5udwfFSr3ouX_aj0zgUVv_DBgFe_MYv3g_ONfyg>
    <xmx:xxmjaTKyY5Bnd_58IXnnuOdKKpNf_m68N9uJEjP0Cism1m-XzPh12g>
    <xmx:xxmjaUGJMEJ-j2JDLf2kWFeffcayVNy-Mg3uAs4-aBGTaTLMM_DArg>
    <xmx:xxmjaXX0zyT0ByNleExrZ_8ak3VRur-Du23ASMDMmvPCNmUjk3RzAg>
    <xmx:xxmjaUzCRnz-D8l__lJx-egVf-VnXH06d9qtg1rbdDQznm7JstBm1HJk>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2758A700065; Sat, 28 Feb 2026 11:37:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_ejbntDxbYw
Date: Sat, 28 Feb 2026 17:37:06 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Uros Bizjak" <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Andrew Cooper" <andrew.cooper3@citrix.com>,
 linux-hyperv@vger.kernel.org
Message-Id: <a80879c4-10d4-41a7-8043-290b92a0d9fc@app.fastmail.com>
In-Reply-To: 
 <CAFULd4ZYiSWciqo94yaLvB43z_+jqgXa2gy8DOEQQp1W8yFF0w@mail.gmail.com>
References: <20260227224030.299993-2-ardb@kernel.org>
 <CAFULd4ZYiSWciqo94yaLvB43z_+jqgXa2gy8DOEQQp1W8yFF0w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, 28 Feb 2026, at 10:38, Uros Bizjak wrote:
> On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
...
>> -       asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>> -       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>> +       asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
>> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
>
> Maybe this part should be written together as:
>
>       asm volatile("movw %0, %%ss\n\t"
>                     "movq %1, %%rsp"
>                     :: "m"(hv_crash_ctxt.ss), "m"(hv_crash_ctxt,rsp));
>
> This way, the stack register update is guaranteed to execute in the
> stack segment shadow. Otherwise, the compiler is free to insert some
> unrelated instruction in between. It probably won't happen in practice
> in this case, but the compiler can be quite creative with moving asm
> arguments around.
>

It also doesn't matter: setting the SS segment is not needed when runnin=
g in 64-bit mode, so whether or not the RSP update occurs immediately af=
ter is irrelevant.

