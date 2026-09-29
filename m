Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919582DA76C
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703127; cv=none; b=YmJYgQ4jHMF09j9wRjfrk7AefiG5Qzcjbix9/ZM+H2NPrP46/IqNxm5RH+nN44+f8PXk3Fy8HQsxBoLLahNiHpgzIJiq2vsN3e1nZCj0R/K1NN4fiHVA5HfMpxq6CLPhU/EMOTocORTtAjUppG5YPNipjKOewguNH651hPcv7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703127; c=relaxed/simple;
	bh=gCSeuiqgcoAW0ZlJF4Drrm9uE2RGaXD9qAy3Cz7IsQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxxZTezJrE9L7F4xvqnsqDFzrrw4L9hBxJ1kP+y9BgDP0qTqbKkVwrLvnhhXNZlHlstuEcuLlKCmTjcpiU7eB6CTgue2L1FxR0S5IveF5TcQGzPxeBHbIH5X6Y7VYKAlDeN+LOZZREhI81oFtsYiSRKHK/jHaX9ka71QFslW17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QE3hhA76; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QE3hhA76"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-67489c8202cso167741d50.3
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 10:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703124; x=1791307924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCSeuiqgcoAW0ZlJF4Drrm9uE2RGaXD9qAy3Cz7IsQ8=;
        b=UgmgZg6gh1TNtu6l93hoagThS++wDRU6s4PY6SPqdrh6VRiF5Astc1iIk4MgaYfxEb
         UJNpL+quTfzImIicjYARyWt0/KD5GUiKndzMECuZKMr38tnTe2xBVTDI36S/j/Tx2eKs
         LtKbG3D6G1q4vi3esgP1/dXscRzv813clXb6Z+IrQoiU0eXyW6lC2yQvJU4UKwkqa6Dd
         m3RXIUUbqPwaCUSD7msFmA+iW25aUzwEKx/Geq+LlrOX7C5T6tEvjcUDeoz9TmIF49Nv
         +VtCpPREnVimqHxENXYdO7QCz8evT0pONh96dGTLsJYH6JYpeVh0UXLINRtM16IDQN+t
         I5sA==
X-Forwarded-Encrypted: i=1; AKwUvBwzxIT0sV7hBBmJBCVin0BxZg2eZgWySJkGSRoCjjhonLug2hfX3QkpuCONmkwGXN6GJ79ZV9nLE5UrQMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3MLJ+cNP1jo2DXTP51gIx9gt14Qszysj0pYLvbQYQCqv6zfgH
	uNOM5cqZHVZoPHWpQgEBmWPLUOLGsEGk9zQ5lUaShfEkjzTK5O7D9/cI68u52GhAUB+19Mkc1o8
	sszLV0b+zS13dVKsOpb5mi71WQAOueB4f5Dn7tCuedsu9B4vt4ExyJWsi0nmnapPJONqaNf3x+y
	LEpirmBCgHin0nq0EoBoMlWFoG/jgJkrtJe8dq63zCcx+wlveETu8edUlrMDqYC59ESijQ8aMD3
	vv30FDIbUrBvsYj
X-Gm-Gg: AYBFou2BSqW3wK2NuPgoZmWkXjlWuVKjWTqB3uAVUJSb5vHMyHmVtZlGxN5GyBjafzd
	epnOwexl5xmWqx8bNkrEqwT6QcfREdsWCBXweMN8DdBFhp7yQcChXXtEK3DheqyCIpmbnabFrEu
	MHLFA8UJNgAXLkCVDp1VeVWEza8Tspi+q6nRzCFo4og/JPc3cTF/PrPvuTtqF0MXA/XF8bo5K6F
	pf6pgsnXVTWi8p7yfg4GGQ7dex3Qi6msg4LK1ieoKpCdGZrVapOwpQ+g3xdZQPZG8k4N5u2EsDz
	+5EiYr1sUvZ4+qh1YtJSnr/Hb5s53MqQ+PnEmWzfor94ztRyM/WFKnGacBfrjkdb1sxMIa3ldz/
	aIt7jZymba5XyxQQu7s4W6qW3cnupyrIuOP+I4XTJKHXaIA1PZ8J8uq9RoKqJ8oJFLSQQM8jgXt
	UFx9YdEkaGF2zG0ywtbX8oN7ISHBujG/31dQE=
X-Received: by 2002:a05:690e:d88:b0:675:40e7:8e61 with SMTP id 956f58d0204a3-67540e7c515mr3512013d50.43.1790703124176;
        Tue, 29 Sep 2026 10:32:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-675b76fd476sm87517d50.27.2026.09.29.10.32.03
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:32:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29959eb71fso454503966b.1
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790703122; x=1791307922; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCSeuiqgcoAW0ZlJF4Drrm9uE2RGaXD9qAy3Cz7IsQ8=;
        b=QE3hhA762id5dbysgA14hRrL8GGyCRg+QYR69Tvyu+MpYw75XajOKDW1zEbWOhzLQd
         wqLTV4+mPcOnhX/7azgZYPF6ylxqSyqjKAEPuUVlGT+EbIjNwEwQcRJ1tOPxD6lO+N9v
         DP7mR8OT94LXyV9nlyfdg1R8LUlBmt2ROboqA=
X-Forwarded-Encrypted: i=1; AKwUvBzBIRZC6OLT2jzyEeSfDnOiIN4SQCuLyvoXBfV3KjjYx389dPrISSlKJlRb/FQOouoWPmcXHT089rRWWdk=@vger.kernel.org
X-Received: by 2002:a2e:beab:0:b0:3a1:9562:732 with SMTP id 38308e7fff4ca-3a7716e854emr518731fa.1.1790702723775;
        Tue, 29 Sep 2026 10:25:23 -0700 (PDT)
X-Received: by 2002:a2e:beab:0:b0:3a1:9562:732 with SMTP id
 38308e7fff4ca-3a7716e854emr518621fa.1.1790702723256; Tue, 29 Sep 2026
 10:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929040256.543767-1-zack.rusin@broadcom.com> <20260929053930.GEartPEjbZMpBVSvSk@fat_crate.local>
In-Reply-To: <20260929053930.GEartPEjbZMpBVSvSk@fat_crate.local>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 29 Sep 2026 13:25:09 -0400
X-Gm-Features: AclHuK9MtIFPSxXHWZMv2V63rPUuOwDojaWOanbSwfqwCxHPzt-TuhSiHt6biCo
Message-ID: <CABQX2QNmza+=i1FXgDtFS3e3O5oXxPZppRbRrL54P1LmrB2gBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, x86@kernel.org, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000088e29e065ca28f14"

--00000000000088e29e065ca28f14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Boris.

On Tue, Sep 29, 2026 at 1:40=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
> On Tue, Sep 29, 2026 at 12:02:49AM -0400, Zack Rusin wrote:
> > VMware publishes its per-CPU steal-time GPA without first sharing the
> > storage in encrypted guests.
>
> So this one liner is the only explanation why this patchset exists, AFAIC=
T. So
> I asked AI. I'm pasting what it said below, at the end.
>
> Is any of it true?

Partly. So steal time tells Linux how much time a virtual CPU spent
ready to run but waiting for the hypervisor to schedule it.

For example, during a 100 ms interval, the vCPU might execute for 70
ms and wait for a physical CPU for 30 ms. Reporting those 30 ms helps
kernel:
- account for CPU usage accurately: avoid charging applications for
time when the hypervisor wasn't running their vCPU.
- make fairer scheduling decisions: base task execution accounting on
the CPU time tasks actually received.
- expose host contention: the st field in top and counters in
/proc/stat help explain why a VM is slow even though its applications
don't appear to consume all available CPU time.

The benefit is greatest on busy or overcommitted hosts. On a host
where vCPUs rarely wait, steal time stays near zero.

To make this work the hypervisor writes a running total into a small
per-CPU buffer in guest memory, and the guest kernel reads it. More
below...

> If so, how much and is that the reason this patchset exists?
>
> I.e., you want for vmware monitoring tools to work with CoCo guests.
>
> Yes, no? Anything else?

If options are binary then "no" :) It's not for monitoring tools, it's
for the kernel's own steal-time accounting above, which currently
doesn't work in confidential VMware guests. So the issue is that in a
confidential guest (AMD SEV SNP, Intel TDX) memory is private by
default, so the hypervisor can't read or write it. Any page the
hypervisor has to write must first be converted to shared by the
guest. Linux gives us the address of the steal-time buffer without
converting it. The hypervisor then tries to write into a private page,
which doesn't work. Currently ESXi deliberately powers off the VM when
that happens. That only affects VMs with the steal clock enabled,
which ESXi leaves off by default except for Photon guests. I'll
probably change ESXi to just disable steal time when a guest gives us
a private page, but that only avoids the power-off; steal time still
won't work in these guests without this series.

KVM has the same need for three of its per-CPU buffers (steal time,
async page faults and PV EOI). It already converts them, but only on
AMD and in its own loop. Kiryl asked on v1 for one common place that
converts all such per CPU buffers early, on both AMD and Intel,
instead of each hypervisor driver doing it. That's patches 2-6.

Patch 1 fixes an old layout bug in uniprocessor kernels, where these
buffers can share a page with unrelated data. The series also fixes
SEV and SEV-SNP guests on KVM running kernels built with CONFIG_SMP=3Dn,
which currently hang at boot (we reproduced the hang).

> And looking at your commit messages, they don't really talk about why the
> patches exist.
>
> And I don't think you know your audience - you're sending a bunch of patc=
hes
> touching arch/x86/ and you throw all that virt gibberish around like it a=
in't
> no tomorrow and you're thinking that tip people can follow. And I think w=
e can
> follow only bits and pieces but all of us will be mostly head-scratching =
here
> and probably ignore the whole set.
>
> So perhaps you should lay off your virt hat for a minute and try to expla=
in in
> an approachable way what you're trying to do so that even non-virt people=
 can
> follow.

Fair enough. I'll rework the cover letter and the commit messages so
each one starts with the problem. The series originally wasn't really
touching x86 core parts and I haven't updated it for a larger crowd.
Would you like an explanation of steal time, like the above, in the
cover as well?

z

--00000000000088e29e065ca28f14
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJNP
S6jDImrUmlay9QeGHdRpWRIu9sjbDlG7nS4YLZLtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkyOTE3MzIwMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJOsdWS4AhQKao1Q1WcJtgfxoZUeEu1NE3Jit1jP
Ei+ABtUVWwB3a8HZQcXx9wbBnT5DTe7lZ6oHDQghWw5ZEV8hTyfx/glUzU/U1MyYWHHqzK5blKnf
rHg2d40rRAWQBModAaRw5Q3bT4MYSxY9obmwKZmjrajO4Mcffc65ft+cY0UyupBm7cO34HSifbed
dw5pTaUa7o9bLlzHKyerUpaKJXUdfa5I2U/JsWXG/CcbhY1nXaCuY4UjNMK6C7FRLZV4yxrfdY23
k8MZs8MiW7QUFCdtb97SkE/fcJW6yde2YXCZJyIVWZ6JwqJRyDUwVRBVSGWJc0UDAXjX0X8buBs=
--00000000000088e29e065ca28f14--
