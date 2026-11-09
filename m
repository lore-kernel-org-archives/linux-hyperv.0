Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242359;
	b=oaoSvqDV6A2oXadkCECfisSXCQAlHAwk7KGkqAvAyAoLUPxNGrfzvhVxqGg+ZXe04vGq
	 s6LpsH/W6BtepJGGMrRyfhCx5G5Ig1L+dN9LACjrN62ELd8bTtD/W6icOE1nN2G3zPesn
	 DwxWDGoc763kU0aBIeLgRn5jc80OjuD7UN+0sCYm/4NnpPeow+tZwWrdEoohIQ+/mcMa0
	 goDnzFVe1u/o08xTXNE1ZqzgfcjYuRybpy0jmvmKCvLmybEMEJadljQaL+EWWZtavoKmF
	 JQZRqy6lBVgijfCR0TZemfSc6Pxp3KCciD0TZKvVdndoqLntuO91mhH2U5QM20T9Bng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242359;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=iN3G8mAIeg3/vhBhifQLL1BpRWPbmCDkvMnN8wMYRe4=;
	b=LicEL6Pi9z/JrD0LLCQrqUy8DSAtcv08nCaUOFHnSqWH6rDksXc7aAlS+0XMoavFKnaI
	 9PzRwSTBYkgOs+d0JowWN1rWqZ4/5eVob684QkTeDD7SsZvj5wkdyZmGdlRcyDUwwO5P0
	 J8AUSdm3iRMCGA7qlqjke0ib+0vHMcguwGF9d4QYk5ixtA7DGp96J9NAS+JUJGxngOScJ
	 MCZGUobt4xT0ffn8doNDC17LVvAHnjYz5Ng6haViUL524lAXt7+5b7kUE1rzf1c9x7jgg
	 TR2FnnTp56L0+QBqVw7wNCMYvDHzqd2MoS6QXqQEi1Eoael5S08dv+9esPOQWxNwZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=EkWpgotm;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5F606A7A9;
	Mon,  9 Nov 2026 16:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE5F606A7A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=EkWpgotm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iN3G8mAIeg3/vhBhifQLL1BpRWPbmCDkvMnN8wMYRe4=; b=EkWpgotmTjtlEUN1FnIKaPKRho
	40c3f10iEo+uitWC1+UCdmIN5mWqNT03CEQKOS5brmj/rAT6Ur/F+a7KEOZgf4uYODUJ3TKMfPcPZ
	tSR53U1fv2iv7FlXcTaH7z95Fkp4Fs6IWaGP8xb319B7MCWAFs/b+wLjnnGIv3x8KmwWbj9k8Uss7
	Rptr2kFj4nXiapfSKytCXuB1bpXuzdvJMWRD2eATxa94B3ThLVUMlNvcPQRL+LZddXkGs6oW3kYPT
	T1v3DSvDSc8FIrwzp2aLNwVxqjRstpPcsMvqxWs4sdBOdMjbrOC2YgkfYnw911aGaPwOR9NhoMRXr
	hDiCz8Rg==;
Received: from [205.251.233.232] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQSOn-0000000GQyO-1WWu;
	Mon, 09 Nov 2026 16:39:13 +0000
Message-ID: <9ae548901809fe87b4529e65bda361162583a6a0.camel@infradead.org>
Subject: Re: [RFC PATCH 00/55] KVM: x86: Hyper-V VSM (Virtual Trust Levels)
 on VM planes
From: David Woodhouse <dwmw2@infradead.org>
To: Sriram Nambakam <snambakam@linux.microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, joro@8bytes.org, tgopinath@linux.microsoft.com
Date: Mon, 09 Nov 2026 08:39:08 -0800
In-Reply-To: <20261104065536.15232-1-snambakam@linux.microsoft.com>
References: <20261017122501.610248-1-dwmw2@infradead.org>
	 <20261104065536.15232-1-snambakam@linux.microsoft.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-DAtmD/Ii7Tv2eG0sZH9+"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-DAtmD/Ii7Tv2eG0sZH9+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-11-03 at 22:55 -0800, Sriram Nambakam wrote:
> Hi David,
>=20
> Thanks for posting this. I've been trying the series and the QEMU VSM
> implementation in my local integration trees. With the fixes below,
> Windows now reports "Virtualization-based security: Running" in msinfo32.

Great, thanks for testing!

> This was on a v7.3-based kernel tree with existing local VM-planes/LVBS
> changes, rather than an otherwise unmodified copy of your v7.1-rc7-based
> tree. I don't want to imply that all of the integration changes were
> defects in the posted series.
>
> The main runtime issue I found was descriptor-table interception while
> OVMF was executing in SMM. hv_divert_dt_write() was diverting firmware
> descriptor-table writes through the VTL register-intercept path. The
> failure trace showed a reflected #GP delivered in SMM with IDT base and
> limit both zero, followed by a triple fault/reset. Adding an is_smm()
> exclusion to the helper fixed that boot failure. I'll reply to patch 23
> with the change.

Thanks. I'll add OVMF with Secure Boot (hence SMM) to the test matrix,
and pull in your fixes. Could I trouble you for a Signed-off-by: for
each of those please?=20

> On the QEMU side, I also changed vsm_glue_reset() to make plane 0 runnabl=
e
> when stopping plane 1. Otherwise a reset following a VTL switch can leave
> the normal-world vCPU userspace-stopped. I'll send that change separately
> in this thread, since the QEMU glue isn't part of the kernel posting.
>=20
> Two build/header items from the newer kernel integration:
>=20
> =C2=A0 - In patch 49, I used cpu_feature_enabled(X86_FEATURE_DECODEASSIST=
S)
> =C2=A0=C2=A0=C2=A0 instead of static_cpu_has(), matching the current SVM =
code.
> =C2=A0 - I synchronized the tools UAPI header with the PLANE_PROT/INSN_VA=
LID
> =C2=A0=C2=A0=C2=A0 flags and their field-validity comments, and the capab=
ility-version
> =C2=A0=C2=A0=C2=A0 requirement for KVM_HV_HCALL_RESULT_RAISE_UD.

I'm playing with the HV_HCALL stuff to make the capability into a
bitmask, like the Xen one, which says which calls are handled in-
kernel. That means the basic support can be submitted first, before
anything else.

> I also encountered an issue in the underlying planes dependency:
> "kvm: Make KVM_SIGNAL_MSI per plane" guards the VM-fd and plane-fd ioctl
> dispatch with CONFIG_HAVE_KVM_MSI. Those guards need to use __KVM_HAVE_MS=
I;
> otherwise KVM_SIGNAL_MSI is compiled out and returns ENOTTY. The existing
> test_plane_msi case exposed this in my tree. This isn't introduced by one
> of the 55 patches here.

Yeah, I have a few more fixes for the underlying Planes series, which
I'll try to split out for J=C3=B6rg too.

> Finally, my older LVBS tree had raised the default plane count to two.
> I reverted that local change to respect the KVM_CAP_PLANES opt-in contrac=
t
> and added early opt-in for my LVBS userspace path. Your QEMU VSM path
> already has its own opt-in, so I am not reporting that as a missing VSM
> change.

There are going to be a lot of intersecting details like that as the
various trees come together and the dust settles. I'm trying to get
things in some semblance of a mergeable order and form a plan for what
could be posted immediately (the basic hv hypercall exit to userspace),
what could follow on as soon as Planes/memattrs land, and then what
needs more thought.

I'd like to get the *minimum* kernel functionality landed, and then
follow on with "optimisations" like the in-kernel VTL switching and
extra features like VINA etc.

--=-DAtmD/Ii7Tv2eG0sZH9+
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
gtEhp7+Bb8rhdn2KFe/MK4wAAAAAAAA=


--=-DAtmD/Ii7Tv2eG0sZH9+--
