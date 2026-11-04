Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821072;
	b=ZlX3Nt4mzaaweLKBKoDp1KSLpZkDFufdw2jqkGgkQB6LKOp613YmA3J8oqMtagUE7d0z
	 kKIr9xnplvYGWCoANKrqXbZez4sE68loIzSplYLJfLpHbI9O6fP0sOxnfclqCiwPI9gtp
	 fwlD7vuYx6/91NCwFCnoGy2qp1S61GSZuzL+GMSMMgakxe6p/+7Xm8EBBmNkg7tZVZs6/
	 GuaXq/ZDH+RxxU1FueF6l0kvsplsfV/LagEo8JQWONKLD/xals6+GOiqJ/tT8BXl20cMA
	 e27RhIDgg2qw1e3Nm1Ww8STFFqiKtuKpkF/1O0txx/NE+CEl4ZS1+/nz4bOY8XqYg7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
	b=Pz16BsnbAwdLwNENHoxjn1trPhHJnCnd17/EGSwGlKueqB60YAU0jJ4TPhAn9NyJGBjG
	 tumlxcXFIiy6rAS3lxC90Ed917LRddg6Q7ef7p3hinsAlUAQxRUxpugoc/unSiRVNpVYy
	 ajYFHvkIs0IXBzCN9FABsa3BEIjhtaIVxP2xqXh108Doy2IdO/gnN7T9iB+61DF3Xxy/v
	 mgkM943GPtYsnx9WhrlXdRXjqvmsEmSTuXlQ32PuGKm+V5DR8XG7rW6CY1nvhKQ5Ouzem
	 QlgH/yNUoRqNR/b1W5bEYsLlsJGYwyyBavDZV5vmSklpJ4l5nbkft7vaHB3d5KTCogA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gJSq+Ubr;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01092607F294
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01092607F294
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gJSq+Ubr
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eb2437d752so15698075ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821071; x=1794425871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
        b=gJSq+Ubr/frgSSD/tMBcT+f/kIR/X/CwpTlD2bbtEwjhhi/+7hJcvCLXB4IDL5V/qy
         0+bqsQxIR/t3oEcE59hSTJ+W72qYXOOEgW2ZEriC6BJrsT25yqSEtIMBN47ZOPwQwFWG
         F09buADkQ/trjIAMVNHiW4Q15+CfcFtOoR9LnDt5A+X0L0eFj1vmhP+XBx/Xdw5jIJe3
         bUJna5nkRV02U3UPBg8vELTNy1bogwnSGNgalHMSLWcpVlAKsOwLSREX1jesGpUwlHV9
         0ZQ/YrbnQFOhvhaTw+uAJCPwi+9GbI2gBvYy2qC2s+UpLpC9HaizJLtW6AlznPEGfb7w
         YaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821071; x=1794425871;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
        b=EizZMHIGwyekozmixGpKIWqr04aWPkRR/0WioXYv8115CsHTyKNgiV8EY7eJ20dZ5C
         yhDOof5u4lWvUmqxrBK1NsLRYvhNjEXTW6M0f1Hu3CAKolNUJBuU3w/kFSkT96aeQTBN
         bvLILzZjMQonsBYNogNHO/kbdw5qGGTZdXbpLnFIfmDzkkrddWdXaqH+gS/xoEyF2vkD
         /DFJz9/9LIEBdWIT8ealfRIKkTDgPN66MXKgdCRjck0I+TUVyYsVnVelO6vMG9eS7Y0L
         OVc5BmN9+MbIdXo4nnXTqmVtg83n4WZ8ScbPARJ8UUIDZprtKoCDMtCzOJlCKfmE15Dv
         Gb4w==
X-Forwarded-Encrypted: i=1; AKwUvByRGD52RFnL3gJCGYnpSZ9GrhB/Cj2xDB3DPc4WMOLi1aUak4TZqEpHGrHyezZygSuvENrbbf0JI2cwO98=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q8d+4HjWPIfu9FJPcJMaziYcQ8Uhek8nxkvDRk8kfUK67N+T8
	1i1nVszxibq6y2R7n+aDJMaED21iVCJEVkW4YJSOARKQG5tSqV/cpPVd+6aIAHpy6aWCoj+idOh
	XaIKP9Q==
X-Received: from plww1.prod.google.com ([2002:a17:902:d101:b0:2e9:4a78:9294])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1986:b0:2e9:4d9f:a65b
 with SMTP id d9443c01a7336-2eb3651d564mr160599195ad.53.1793821071087; Wed, 04
 Nov 2026 11:37:51 -0800 (PST)
Date: Wed, 4 Nov 2026 11:37:50 -0800
In-Reply-To: <c9a6455eb88c24d4271b7a7c86f7a4e90799e40a.camel@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <aqLv9GwBNymyHs8q@google.com>
 <c9a6455eb88c24d4271b7a7c86f7a4e90799e40a.camel@infradead.org>
Message-ID: <auuJjiowddGlysWI@google.com>
Subject: Re: [PATCH v6 00/51] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, David Woodhouse wrote:
> On Thu, 2026-09-10 at 10:59 -0700, Sean Christopherson wrote:
> > On Thu, Aug 06, 2026, Sean Christopherson wrote:
> > > The primary goal of this series to fix flaws with SNP and TDX guests =
where a
> > > PV clock provided by the untrusted hypervisor is used instead of the =
secure
> > > TSC that is controlled by trusted firmware.
> > >=20
> > > The secondary goal is modernize running under KVM.=C2=A0 Currently, K=
VM guests will
> > > use TSC for clocksource, but not sched_clock.=C2=A0 And Linux-as-a-KV=
M-guest doesn't
> > > support paravirt enumeration of the TSC/APIC frequencies, even though=
 QEMU
> > > provides that information by default.
> > >=20
> > > The tertiary goal is to clean up the PV clock code to deduplicate log=
ic across
> > > hypervisors, and to hopefully make it all easier to maintain going fo=
rward.
> > >=20
> > > The quaternary goal is to clean up the TSC calibration code, which wa=
s made
> > > stupidly hard to follow by hypervisor code mixing in with the native
> > > calibration routines, instead of being implemented as a pure alternat=
ive.
> > >=20
> > > Note, the VMware and Xen changes still probably should get acks from =
those
> > > maintainers, as my understanding of what they're trying to do may be =
flawed.
> >=20
> > This (thankfully) still applies cleanly.=C2=A0 What can I do to help mo=
ve this forward?
>=20
> Nudge Thomas to spot that this is guest-side and we want him to pick it u=
p, I guess?

Amazingly, still applies cleanly on 7.4-rc1 and tip/master.  I know we're s=
hortly
after the merge window, but this has been sitting idle for months and addre=
sses
issues that are impacting a variety of end users.

Note, this also provides meaningful hardening for SNP and TDX.  /me stares =
intently
in the direction of Dave and Boris.
