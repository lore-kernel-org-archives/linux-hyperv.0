Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183B336895
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701988; cv=none; b=IV7nvuMVN1ubJDhiIuiMZCwnRVAqFELvLVUSHIIPpluF3WT2fguPGwFy1r4CNnwTMI0s2KAbJFu6if1AQqJ6pTutvw9JYRELhBnNmNSnkM9Tu88UUzb4n+MhRWKRqVmUSs65ckLw0A6g4Bhgein3wUdXZgIJSxS02LlAJr8yZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701988; c=relaxed/simple;
	bh=ZW0IhB8wBKydr8w3cfNHKO96VJkVoBdz9246yq2RyD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh4PG1k31F0ocRfmaaYL/GWRPs6i0yeH9e+CDMKnl01Pp+hy0H6HmnasGfMyni7oizQCtkW+D/51g4NFeRupM4jXfAThz9wHPKX25TNULazTfqUL1Nl5Zu8Jdte2hVu83j2i5z0vr6J97hYosH5olwhY5aB02ROzT+HyCj+oOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b+87O7Ad; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b+87O7Ad"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-89296e56dbaso6717397b3.2
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 10:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701986; x=1791306786;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PS/pJhXrYf+6KZJU6dkGxHVr+RfMM/O9fFmPnRjw9LQ=;
        b=i5eMEUpyxDZmKPfuwJ9V0T6au4AlOa4lydlL1xL8wUvHmf3NJv41S87zPTEMOkmpIk
         x3alflyOl23TIyYzllkiDO6vH6qeUNzznkXhXaPySpL5KoE18tevOVNlSaO9Tr5DjO6b
         gX68QuW9Qoh48iQuqAAEr9GjfH9aPNHZgHrczC4kwcgZZEo08hDOlNmAlOAvqOpG0d+w
         dA4C0kk+zj0xMHiD1JuK08TMDDg/p61Dm+I5wEIlh4WPBjE9WYiTvncw+ZCdNXeEJ8t4
         f0etHyeTIe/TfXr5ZC5z2GvnWg6S+093vtiukjodOEeQgbW8JQrfEReQsSydlpQc9gBC
         PnKg==
X-Forwarded-Encrypted: i=1; AKwUvBw2vOi9lCE3rXftZFtEdYRg5VMMza/00E0sVcYu6EzYQsKcENOYKzAbF7C6+osnvpJSUhlZLldJG0LqNNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrXXX1s9aVrFjRAQs36S5DbqQd/ogluakdEMoowBPxO/f/NSbx
	GEVilcXj79jq9IwmvGfOs9+5xwcn9VcYLMRMOfpDN387US33aiF0Tdfe2pe7U7qHNpBi9NBrqVL
	j7JLemVMQ7slRn3CaNSM5ktg5YzgsFAlDSyRUGnHJ7ZpZ5ip+eiuN3apBsY4QbyYqt+F+AJIPzP
	O6tyCTVeLNlCWPYDOvURu2mBNk2OAPaMbS58Oqru41iyArqPBP/NaUvnQGmRi2bA51V5y3mqDAi
	eFaxfRmaj3EQ/Yj
X-Gm-Gg: AYBFou1CxoMllJUIyEEUR8m5hdxfYngB2kOZBMuN1kXPGYtjVb6Sp7F2VPSKV5wWmSA
	RYM7IGExHMtSnbJBTL4P1XrxjFNx75amQ5yPAfi/D7uUympioElZToGVKvWrGTXGrkX8unzAI2c
	bNANnGVoHyhx/dAOQsn8MctcAuN2WlVJNsb9fYKM+l1oEcwh6oZ8w72wXJq8dtv+jFaq4N753Sb
	Tt8HELcY+7nv5HAn1wimnjZPv/OWkrpc/qVe1ZmnjoPmZ8+9X+uRuYLkf9KVbhAW6U1Mh5h5djw
	GQMwbf1VE6sUdYh7odhumqFQFRTQUfImKpM7PX9MfqFRLSEEiCNZwQCyByC1x+KgCbOK5+fkTn7
	Tz0HVkrvViiTR+eYyxktL4sUdQ5UEIt9xqGV/ZtpMCANQNr6G1KvLYIOKpLtIZ2xpwZDtBMcRbe
	EWM1n5Mc6zIREUtIhmx5+7aR3t2ccK/hyX9q0=
X-Received: by 2002:a05:690e:804:20b0:671:70d2:5294 with SMTP id 956f58d0204a3-672ed3d0e7emr6250061d50.87.1790701985490;
        Tue, 29 Sep 2026 10:13:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-675b26fc7acsm78048d50.3.2026.09.29.10.13.04
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:13:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so8892835eec.1
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790701983; x=1791306783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PS/pJhXrYf+6KZJU6dkGxHVr+RfMM/O9fFmPnRjw9LQ=;
        b=b+87O7AdEXJhr2iE47ZmIC+536/1qQbIA+6qRmcHUbtMLMCHX2CJiY0AnsOiwf18L0
         Ci5t6J8hZZkKLpDcu5GG+eJHhzeTOfVBrr/9N911DWDiA7F4HzP9TagCFKGZGFLezpzd
         ltZrWRyIyS9hyy5yOwnhxM7dL4kzR4nsWew5A=
X-Forwarded-Encrypted: i=1; AKwUvBxcz5NSL/rdx4H/lobsSqsZPYls7Xv+0cx5hIDVkyBFYvaW6gR/1eTm25WEigNNEj1CNIFi2HALb39pQyU=@vger.kernel.org
X-Received: by 2002:a05:7301:4908:b0:348:201a:6c8b with SMTP id 5a478bee46e88-348201a6ef2mr6324523eec.38.1790701982873;
        Tue, 29 Sep 2026 10:13:02 -0700 (PDT)
X-Received: by 2002:a05:7301:4908:b0:348:201a:6c8b with SMTP id
 5a478bee46e88-348201a6ef2mr6324466eec.38.1790701981900; Tue, 29 Sep 2026
 10:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-3-zack.rusin@broadcom.com> <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
In-Reply-To: <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 29 Sep 2026 13:12:45 -0400
X-Gm-Features: AclHuK9CQF2HwjTfB3IkA5Iz-7VKmkeLlHNlajXqAX5pb_ttJ9z-UY2UurMeehQ
Message-ID: <CABQX2QP0+Jr6gG0nZkDggvyGWCSHMNVKPPavZTYBqH+wg7rdMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86
 encrypted guests
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>, 
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a5a38b065ca24b1d"

--000000000000a5a38b065ca24b1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Tue, Sep 29, 2026 at 12:02:51AM -0400, Zack Rusin wrote:
> > @@ -1022,11 +1024,13 @@
> >   * Note: We use a separate section so that only this section gets
> >   * decrypted to avoid exposing more than we wish.
> >   */
> > -#ifdef CONFIG_AMD_MEM_ENCRYPT
> > +#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
> >  #define PERCPU_DECRYPTED_SECTION                                     \
> >       . =3D ALIGN(PAGE_SIZE);                                          =
 \
> > +     __start_percpu_decrypted =3D .;                                  =
 \
> >       *(.data..percpu..decrypted)                                     \
> > -     . =3D ALIGN(PAGE_SIZE);
> > +     . =3D ALIGN(PAGE_SIZE);                                          =
 \
> > +     __end_percpu_decrypted =3D .;
> >  #else
> >  #define PERCPU_DECRYPTED_SECTION
> >  #endif
>
> So you're page aligning something that will get different protection and
> will thus shatter large pages?
>
> That is somewhat uncool. We like large pages, large pages are good.

I'm a huge large pages fan too. I have a poster in my office and
everything... And I never do things that are uncool. I have a wwcdd
(what would cool dude do) bracelet and I look at it every time I make
a decision, which given that I'm old gets on my wife's nerves a lot.
That is to say I'm handsome and innocent.

The alignment isn't new. It has been there since ac26963a1175
("percpu: Introduce DEFINE_PER_CPU_DECRYPTED") under AMD_MEM_ENCRYPT,
which common distro kernels enable. This patch extends it to TDX-only
builds and adds the boundary symbols. On bare metal and in ordinary
guests nothing changes protection, so no large pages are split.

In confidential guests, yes, converting each CPU's page splits the
direct map around it. The alignment doesn't cause that: a large
mapping can't be part private and part shared, so a converted page
can't stay inside one. The alignment only keeps unrelated per-CPU data
out of the shared page. Because that page sits in every CPU's per-CPU
unit, each 2M mapping that holds one of them becomes 4K mappings,
including the ordinary per-CPU data around it. In the layouts we've
tested that's most of the first per-CPU chunk.

SMP KVM SEV guests already pay this today. sev_map_percpu_data()
converts the same pages for every possible CPU, at the same
granularity. What v2 adds is TDX guests and guests on other
hypervisors.

Where you're right is that v2 converts in every encrypted guest apart
from Hyper-V vTOM, even when nothing uses the pages. VMware only needs
them when the steal clock is enabled.

If this is a deal breaker for you for v3 I could convert only when the
hypervisor's platform setup says it will use them: VMware when the
steal clock is available, KVM when async page faults, steal time or PV
EOI are enabled. That decision would be made before the conversion
(for KVM that means making it in kvm_init_platform() instead of
kvm_guest_init()), so there's still no readiness state, and other
confidential guests don't lose large pages to this.

If you'd also like to keep large pages while the steal clock is in
use, the alternative is to move these buffers out of the per-CPU area
into one tightly packed allocation. That concentrates the splits in
that one allocation, so the rest of the per-CPU area keeps its large
pages. Kiryl preferred the per-CPU section when we discussed v1, so
I'd like to hear from both of you before going that way. fwiw, I'd
vastly prefer to first fix the steal-time bug for VMware before trying
to do this though (whether it's with this series or a smaller
VMware-only fix). x86 kernel team is notoriously opinionated, which
isn't a bad thing, but it means that a rewrite of core x86 bits like
that will take a long time and it's starting to feel a little like I
stepped into something and you're all behind blast doors yelling "cut
all the wires you coward!!!" and I'm just confused going "I just came
here to get some blueberries".

z

--000000000000a5a38b065ca24b1d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIM95
Y+wYvsgw8fhQBqM5K0hnr0Cphy3qyWfbqheI4Lz8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkyOTE3MTMwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFvC9yUf4NxqdbxrJRcyAp/5mQzhsOLZROjyygFB
yBZ8VcJ9B6XVEIMx3ZhJzgeW/nkTMkE2njNsu0m3mo82ePcyXk1iXQ/Gi9jtgJQkGDPoDvnTYACV
/exkyT1vYEnTQ9UwNxR0tih5JE8C8VS8OZrjIaL2gqiGuewJGFZZNha6AcjbJyVMvn0a9EGg5aUw
VESPqWMG8KRf2gkLgDsHKgdUY0FrlFjzp/HhZ0BEkJdTGXaIu2Yfcf9ti2cBvfhvF820CEUE64xG
kDNvoHKMDbCrGc+XZxH2F4e11DN9nq1ssLS7C+QzPQC0qSjaMKYb7leVCvjULe138pNDm0J+Auo=
--000000000000a5a38b065ca24b1d--
