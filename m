Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79C3DDB09
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Oct 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921198; cv=none; b=hipXclYcFcn2AuNHaJiFVm938hSWBZsPCZzFbI6pXf4zkfITgsiTitn0hSMvFr1AgyGK14uBxTT5UV3pHV1aTA9Rgkr8qc4qwuLz8e0poDe/xipNhYLr4ypsrDyE+6QWvqX/S7jp+bvtN6eufAUfsw0JGqFfLM8lh80mR1io+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921198; c=relaxed/simple;
	bh=dX5J/1hQESi60FPGPHX6Tf9MRtRmaNTvDSOa1+IwOZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrBVVwr/w++H5uUModYfWWdNQmJBhjvsrZYv0osfS1Fz8IhRnssoC1vcDGq0yXUVOIMCSkg9gC+rCyB/p3cMFs7NgyCSGGaiZHXpn0qDzmtqyAzPK1c8P4RDqAc9C2NRKtGOU0606cs5NX9Lk/1Fu81qE14Ph5wj644c1AbAyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F0lZjANL; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F0lZjANL"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8877c806d12so343641b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 01 Oct 2026 23:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790921196; x=1791525996;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6aqMhi7ZiXK/nXGpxRTQZ2TuR6hVFV8VEZCJZC2/wA=;
        b=DIZEVtfxoWFWXRZAS430xTzRgvYn2lfjS674OYjiQfGYA9BtPWygBGY0hhw8cDoZj3
         FgUiV67ss9/OdSbJS0f27srK0tmuUuogS5ofYGObp4LKgl80JebhX1Qf6KuW9SgbdvXW
         JBCEPgko7iX7UbB1DxlpIevW2M8EhFLPvC9F1+4a3WNvZoa/SZW1P40I9XNA9Tb/wFBe
         LaOELRjeidEjmN94Z+fcNjIx6IxwWnio7Zyg0fqPwipXOHhV36LxaVUumy7rfFCCuJZH
         TkQ1ey3piM6yLi+1DSRINRyLxn6XW2PiJ/XRxdF8+AAEiucHOT2MoxfbUzfAT/KP3UmR
         Zbxg==
X-Forwarded-Encrypted: i=1; AKwUvBxFGJNHJBJNHjPiqLLEB+257F4TjtKzXGcktHKvBCm1Og85dfE8HzeVLpnh3dDIUYwxnjg/PvG5kRYqHbo=@vger.kernel.org
X-Gm-Message-State: AFuF++m/K61hL9m7klIPfcYKxX6y5DLu3QNlAQ+nqB7SdAlWxk0c/QBO
	27IX7JyxY8f/6IUgveu557o7d3RXUKoEo3CiXX1EkvZT1rCKqcL6OCS2SZre+PmezIks1sszAco
	Ge5Uj2cPPfHKRWnrJegBBEIJWyw+RyL84wDOiBttu4ZMvebZbaiJeIqnkwnQc+MCqYqXN342ChA
	IEiBLnIc9luBvPZtUcUsjPqEpGk3KP9zWg3ScbfeTpp4n9/Elm+ktUeXC0fIuPTpcb1WamIMhRs
	hJykWuMOPAMK2if
X-Gm-Gg: AYBFou3EyB9GhesnIITVrbdiU6372FmKY2Ja2oT+KY0Vb53oROFaCik/LNwHPssP63M
	Lk/QaUVCa3DF1336JImeXMIiCmB4D3U+5NemH7n1f4rtOG/NB05TyfkgLxAIQrRg8EAgHshcIQw
	i+yy+ZZzLemHe5qRwqhZdS3cfUAFiJ8GWaUqu6qNRSEtzc1Cjv0x3Y67ZXpU9i6lpG0Kl0vzoQb
	Npj73NsIu+W4Cuh1acfk2Ih7nvYSXqK0ffZFM8mEeR/rX+gHCnCdC98pTbPwHVW7r/3DNs94Qny
	esn57Z8m6lqyYt5LeuP4iytal+S5ce+9sINuerJXdwG20l8qh12/c4UmGKJwhjZqN8HWRm/Fsyq
	Xjws/EauR0xY1Dcz+29GQ23wZ/jTsXxFCNblDKaQ9rhqxQHnUXxpFIflL0orHpiZ6D9EcgW3MTo
	6LAts3QdKKYLkqfrQVBM/bIsCk9nfwD+wwOow=
X-Received: by 2002:a05:6a20:7f8a:b0:3de:6889:22e3 with SMTP id adf61e73a8af0-3e0bcfe9128mr1781939637.51.1790921196195;
        Thu, 01 Oct 2026 23:06:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc9f72dfcc2sm412119a12.2.2026.10.01.23.06.35
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2026 23:06:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so11180206eec.1
        for <linux-hyperv@vger.kernel.org>; Thu, 01 Oct 2026 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790921194; x=1791525994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6aqMhi7ZiXK/nXGpxRTQZ2TuR6hVFV8VEZCJZC2/wA=;
        b=F0lZjANLW9YDIJ0tXdriE/Ikl44pQMHfqDR6KXySwhe3Awr38mbBZ8yLxsz9gI4cPv
         YR/VDMQ3Sy2vMBKAuJPX/1MExpQb8CJSjZ4OfSSrHH9bVkHgdQozW65n4IWkeivdPgWr
         nSlQuhGBllCPJM6SsKyj+Y9NEPo8rxbvJhUm8=
X-Forwarded-Encrypted: i=1; AKwUvBxlg7uEOmXKGMKVLf9QQOfLyB0t4vnKAmdlgn0wOb6am0HmFlT5ZY2nA0URfpV928apqeXXW2gDnwKFaGM=@vger.kernel.org
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id a92af1059eb24-14f5bef5190mr1601618c88.26.1790921193683;
        Thu, 01 Oct 2026 23:06:33 -0700 (PDT)
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id
 a92af1059eb24-14f5bef5190mr1601590c88.26.1790921192899; Thu, 01 Oct 2026
 23:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929053930.GEartPEjbZMpBVSvSk@fat_crate.local> <CABQX2QNmza+=i1FXgDtFS3e3O5oXxPZppRbRrL54P1LmrB2gBw@mail.gmail.com>
 <20261001235950.GHar7z9v3zfk8odoTh@fat_crate.local>
In-Reply-To: <20261001235950.GHar7z9v3zfk8odoTh@fat_crate.local>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 2 Oct 2026 02:06:16 -0400
X-Gm-Features: AclHuK-rd5CcQufUaR0BIRz4PquQ50RR10S1_da_RH0Fm436Xl3eZ4up2QGuXdk
Message-ID: <CABQX2QNE331JieoHixJisyU309A-S_LDuwuZEHQf+AKQs-OyCw@mail.gmail.com>
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
	boundary="000000000000a3586a065cd55538"

--000000000000a3586a065cd55538
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:00=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, Sep 29, 2026 at 01:25:09PM -0400, Zack Rusin wrote:
> > Partly. So steal time tells Linux how much time a virtual CPU spent
> > ready to run but waiting for the hypervisor to schedule it.
> >
> > For example, during a 100 ms interval, the vCPU might execute for 70
> > ms and wait for a physical CPU for 30 ms. Reporting those 30 ms helps
> > kernel:
> > - account for CPU usage accurately: avoid charging applications for
> > time when the hypervisor wasn't running their vCPU.
> > - make fairer scheduling decisions: base task execution accounting on
> > the CPU time tasks actually received.
> > - expose host contention: the st field in top and counters in
> > /proc/stat help explain why a VM is slow even though its applications
> > don't appear to consume all available CPU time.
>
> Aaaha, IOW, that's the "st" column here:
>
> $ vmstat
> procs -----------memory---------- ---swap-- -----io---- -system-- -------=
cpu-------
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st gu
>  1  0      0 1714852   9748  85300    0    0  3793    51 1445    0  0  1 =
99  0  0  0
>
> In any case, you could keep that helpful explanation in yout 0th message.=
 :)

Yeah, that's the one. Sounds good, and thanks for the links to the tip
and submitting-patches docs, I'll follow them for v3.

> > If options are binary then "no" :) It's not for monitoring tools, it's
> > for the kernel's own steal-time accounting above, which currently
> > doesn't work in confidential VMware guests. So the issue is that in a
> > confidential guest (AMD SEV SNP, Intel TDX) memory is private by
> > default, so the hypervisor can't read or write it. Any page the
> > hypervisor has to write must first be converted to shared by the
> > guest. Linux gives us the address of the steal-time buffer without
> > converting it. The hypervisor then tries to write into a private page,
> > which doesn't work. Currently ESXi deliberately powers off the VM when
> > that happens. That only affects VMs with the steal clock enabled,
> > which ESXi leaves off by default except for Photon guests. I'll
> > probably change ESXi to just disable steal time when a guest gives us
> > a private page, but that only avoids the power-off; steal time still
> > won't work in these guests without this series.
> >
> > KVM has the same need for three of its per-CPU buffers (steal time,
> > async page faults and PV EOI). It already converts them, but only on
> > AMD and in its own loop. Kiryl asked on v1 for one common place that
> > converts all such per CPU buffers early, on both AMD and Intel,
>
> Right, why early?

Because on SMP kernels both KVM and VMware hand the boot CPU's buffer
address to the hypervisor in smp_prepare_boot_cpu(), right after
setup_per_cpu_areas() and well before mm_core_init(). Sharing a page
usually means splitting the direct map around it, and
set_memory_decrypted() needs the page allocator for the new page
table. To keep that existing registration point, the common code
needed its own early sharing path, which is most of what patches 4 and
5 are.

> I mean, I am still trying to see the justification for this diffstat
>
>  14 files changed, 247 insertions(+), 51 deletions(-)
>
> and whether it is really worth it.

For VMware alone it isn't. But you guys have to decide based on what
your long-term plan here is.

I'd be happiest if we stayed within the confines of the VMware code.
That's what v1 of this did (besides the small guard fix outside) and
I'll only stray from this if I'm explicitly told that a patch/series
won't be accepted without some cleanups/re-architecture somewhere
else.

I'm here because internally we've had multiple teams needing various
bugs/features in the kernel and looking at some parts of our Linux
kernel code was making me sad so I decided to collect the changes and
use this opportunity to also cleanup some of our code. (I have three
other series in my tree, they all touch arch/x86/kernel/cpu/vmware.c
so I'm trying to push them out in a semi-coherent order.) But this is
very much a spare time thing. I can guarantee I'll find enough time to
always review the VMware bits, maintain them and answer questions
about them, but I can't do the same for other parts of the kernel. So
the more focused we can keep those patches the easier this is for me.

> > instead of each hypervisor driver doing it. That's patches 2-6.
> >
> > Patch 1 fixes an old layout bug in uniprocessor kernels, where these
> > buffers can share a page with unrelated data. The series also fixes
> > SEV and SEV-SNP guests on KVM running kernels built with CONFIG_SMP=3Dn=
,
> > which currently hang at boot (we reproduced the hang).
>
> That should tell you how much we care about UP. We would even love to mak=
e SMP
> the default.

hah :) The UP handling was a good chunk of the complexity (patch 1,
the kernel-image aliases and their kexec teardown), and the simpler
approach below doesn't need any of it.

> In talking to Peter about it, we were wondering whether this can be made
> simpler. Like do not touch perCPU but do a normal page for each CPU's ste=
al
> time gunk and thus do not split the large page and then that early
> enc/decrypting of memory I don't like either.
>
> Perhaps we should start with the simplest approach first.

Sounds good to me, that's pretty much the smaller fix I'd offered on
v1. v3 would then be VMware only: if the steal clock is available,
allocate the steal-time structs for all possible CPUs once the page
allocator is up, share them with set_memory_decrypted(), and register
the boot CPU from an early initcall. The existing hotplug callback
registers the other CPUs as they come up. The memory comes from the
page allocator, so it's in the direct map and TDX's vmalloc problem
doesn't come up. No percpu, linker-script or early-conversion changes,
and KVM stays as it is. This would also move registration for
unencrypted guests to the initcall.

One small tweak: I'd pack all CPUs into one allocation (64 bytes each)
rather than use a page per CPU. Sharing a page can still split the
large direct map mapping around it, so a page per CPU could split one
large mapping per CPU, while a single allocation concentrates those
splits in that one allocation. And that only happens in confidential
guests with the steal clock enabled.

Kiryl, I know this is the opposite of what you asked for on v1, but it
sounds like Boris and Peter would rather start with the VMware-only
fix. Shout if you object.

z

--000000000000a3586a065cd55538
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHMv
yTLPcyN7lWUhT/on8/ToZwnK+q0RgvXIiep/lGIUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwMjA2MDYzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFsJiP1etuKra7IRbsDCox9oIoW46luETWyadZPG
/9+VUWkP8aXivckqk369OBsHFJABXJWQE1vT4hDVOncSwlpxmcIKn1TNKt/RtfKpupSzlUej0t2v
fHZAGLORk2hFfoMgWH1ctmx5o/ssr+f+FbWsinIW1Fyp0ionq1ztT3iw8QRXNimkKo/kgnEMuvwa
mcTtsq8zD2qb4C2hCH/hvkImuzk4nYQbqNrgxE/R/ro+utG3OmZ0K3FKlqiy60hI/kd4HSSIEyLQ
Y93bjEpNzrsuP4RIsIpnA1tjPirKL7ixhTVnmZEknnbWJrgiJK7G1Nw3qTngvuoILi6Yodyvlo0=
--000000000000a3586a065cd55538--
