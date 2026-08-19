Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A3476CF5
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153630; cv=none; b=gU9VHg9DMXrbf+/gaEGRNjn4O30c0S7ylwlvw0GIbHkMsyfZFAF9ALPMM8Br40gVzIodsn49lYIO68dHNjhEPdOOEZTnsuQkzRRz7BpiZS+vOxDMrNSlh2eRmNuwRLQl2Z2T+Hh0/R6lYcnLfHRK49zgXyXrcVhFjCAh6u2L1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153630; c=relaxed/simple;
	bh=4Yli6tecyJEHplZwFU9XXAL6o7x1WGOP/NVWujBjOgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3wTxSYzZHrmoB2J1o6uwLim10g/11FuoO1VbqLJtdIGlqpvKWKA5DMJ29NftS9Il/jQy1AsGgYt/xwxnj57cd2nPQlhq0Uq466NTHFR1D8c3iH2+nm1qJlSnixJD05WF+sOVXAj8U8C0wAN05wCjaycXN/FA/8B9dM7BjqExXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU/cVw0+; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XU/cVw0+"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so15780b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787153627; x=1787758427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
        b=XU/cVw0+p9kAqaFFKwNtFk5zq0mOExFboyZMXzRqehxsK9WIfnOCnZxYAx+4Wja0eO
         jALKjzpL9AQ2UaqtpGbejqQfbePzO+q+jc4LYfucU3awBgHzWGILbkmSswwY+VAm1pi2
         UKGgkkcpSRYp8GQotWZUdF8iJeMFfwPYy1uaBpIvbtBkcMlacNxcO+Zo3yoYJ2b+sOZY
         jHtIoadd+n/Fh1q7zG4wZkFxmqMW50IjuVPPaoEZ1nhnUGcL9GnWueT8Ir3SzKuhkSXK
         yfyjsZJxqyA5ar+VOfZRzNPZLBgOKY7GvvTrrJ8jE2iLPZY7R0jBRGj2qpfq3Cpe9UCN
         x93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153627; x=1787758427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
        b=lLeRMdF9dq4DfVwPE6/8ZDXsZUnVasm2sedsc3loNh+OxsMYgi/0ebz227d3LZArHL
         /9YbU1CyxVT8R/SB0j53lgXUzPmgf28jHDoWRvNUyi+7nHPo7MGi06/mXKIp5fvzO/kV
         Sa0z0pMJ68ZmHyI5E95+u9/EM2fptV1yHgCwNeBMKMq4k1nlpRhpBGaWBT98qh4YBSRQ
         Rk+k+xolxO5aGDmxrwa2yTov3PtwRFMv1xJxrZMYCZQ+RvjaFS6devuG3uJHrdZAaNbH
         wLNF426xybcRsEUQFtVaFTIU2eQGtZiq0VU/Cy2Kxk/ddPAzWsmQYGC11J4Agg/AQFjr
         aCOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUuu2TQ3OYQvRzCcqCcT1U2CLcJL8ByG5ku8z7SPTtDY7vB2PdYzqPTg9T0Dq1T0jm6TIGU73klLUXAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3T1P0kFx3HMehuOa6ucI/3ToHQTrY36q3yXR9izQMhrcOXKp
	OCBwuF1YF3xa5WFwPYcw7KQsNZw7LuSRrG7oG5MJ8MCQ1ohXVBKF+MXlDGVAE/jXH7K4t6NIJLn
	XAfuGAg==
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:84f:df8f:5a90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2913:b0:84b:9a69:156d
 with SMTP id d2e1a72fcca58-851df6dc419mr109732b3a.0.1787153626373; Wed, 19
 Aug 2026 08:33:46 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:33:45 -0700
In-Reply-To: <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819102314.1499258-1-jgross@suse.com> <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Message-ID: <aoXM2f1YTwgVj8KL@google.com>
Subject: Re: [PATCH v2 00/13] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>, 
	linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>, 
	Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Artem Bityutskiy <dedekind1@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Dave Hansen wrote:
> Hey Juergen,
> 
> These look great. Thanks for doing it!
> 
> The only wonky thing is how we're going to actually merge it. We
> obviously can't do patches 10-11 until all the "stop using" patches have
> been applied.
> 
> I obviously 100% realize that it's during the merge window, but any acks
> that the maintainers of 5-9 provide in the next few weeks would be super
> helpful. Or, if any of those maintainers want to cherry pick their
> subsystem's stuff out of this series and apply it, that would be great too.
> 
> But, the last time we did some MSR function munging, the tip tree
> carried most of the patches. I would expect we'll have a repeat of that
> here too. I'll pencil in the idea of just merging the lot around -rc1 time.

Note, patch 12 "treewide: convert rdmsrq() from a macro to an inline function"
is going to conflict with the KVM changes for 7.3; kvm_access_xstate_msr() is
getting moved from x86.c to msrs.c.  Somewhat surprisingly, AFAICT that's the
only conflict with KVM's code movement, so it's probably not strictly required
to send a new version after the KVM pull request?
