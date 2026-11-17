Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794891305;
	b=GAM9bBobceTInKZZkqyCZW9ztHk0aTSL/1ojjdOCa/U6rsBVGSbrOOJoZgaBdbVbzZxE
	 TJdsspCTELT0cWCox3SmEDCKoMBV1rueRNoeFZFrngD5nJDfyGY+034sNnR3GoIVGSMJd
	 1zErI3lZVnl6+c7VOQTCzT88Q8hnJUFvvfMkWNuU7n+6NP9lSVuVyL30vI08wJf9ye/SC
	 EqLVdX5nJdbyYNQQvYmd23ozHCTWWVv8O9SaTVDweru9CjsIQZwRnGOcjOR4BvKzKPbQP
	 hsppGdHf8jqnomVjAA++U7/BnG3Leiv/Hppp+eoHoKk02RQ47uY6a4hZsWzWc/umogg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891305;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=roi9kW+OgaA/jFBdkdwZzDBFITlwY9IRvZBlw5m5dtg=;
	b=qTpB5fLF+sXpqu8x8NKOzU51qmuWz3ZgGvSyBAt+mHnxFZ8YfP5+lg+lvI+zXQRayjud
	 UPN0tzNJzlYOZMlGDV2ESkGd24MNT+PGiTdj+zARNWztQJkVhUYCVQFFVQ2kI97ZOI1xn
	 NCXx1NB71rIfbxYRXwCbnFUZ4FCA+wGFNvFpeN/mg2rNatMJHW+mu4JjbZeSj69cA6ANt
	 v2EFx9lWicHg4eKf53JOZGEdFSUttgEyOE+v9Al7gr9Xuc+xvT2liP7OjbsNlo0vexPRU
	 Ya6G/o9P3SHPkno4qo8APqmQXvYDtXYZMSu9gU7YbuOWLJt0fq2ymVUP/A5acaoJCug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aIz3Oq4A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.4
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010004.outbound.protection.outlook.com [52.103.13.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701B606A323;
	Tue, 17 Nov 2026 04:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C701B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aIz3Oq4A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6nnEOPTA4LOah3t4NG8VgGvS5I51D+PpCOIJnWxF5/Vqh73DpBqWdt8djDVN6k5D5AwHN5AXDsV/DabKfMjJy0o7vCrsARZi8vPjttXE3N0QkWYcnpB5GbgljNhE9nVm7QcLNOx6DPmnx2t7vidIEBSkFsONrZx4dldeXT8+8cNESFguRJ4PwHa4LwlZnHyww26pBDs95HDwMBNtrQ5OZvzLypLjO79vmloJFWikL75aL/uqWrISwY8hZEJLZ/4g//Ykcj0+UTMxS+M/BeiHoyZfwn+FfA+ZbUeOCmldlaPFhH3AL1yCAKyAZ4ImSSnIC0ULYQCZpCPO3j0imzVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roi9kW+OgaA/jFBdkdwZzDBFITlwY9IRvZBlw5m5dtg=;
 b=D1dP5DnsRfVL/gmpF3z1jg6YpZ2u3In3Enhqj21Yf4cqfS8BB5fStzqfGWk4go143K/fJQHNsfpPynFCPS+8c+MngfRFGGNKMLqbNKiCv25fb4G+3B7Tlw3WAv/eb58W6NlsfYIyZCrGA2Gs2YRHId4vhvWlXJj9Xhkga7ZzBsOWA359t72gl4t82Ca2kiDXZMI58mh2E3DllewgqQaOxhD7cRswZXQJZ+IDgWJJNdEMVGM6YpB+73gbTd9V4V6aGXDZ8ICWfF+QUZKNtz9l9JcKuUQgJt2cWUrkVTrXXXDjxc/poYQKBB7iSMMCkvBKMFxIKzOLMr4uTxDKNebX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roi9kW+OgaA/jFBdkdwZzDBFITlwY9IRvZBlw5m5dtg=;
 b=aIz3Oq4AB/wVh01tLDl8W2luglNBFOw9F5/Cpr1iwdxsYQnV1TPz70K/LRb7BMrtO7ALZtlkXR6z070O3Gu2+Zm45CltN6bVSHA4us7m40waKxY/NHcX1w7w+irYIwch7eHHPDxrRMjgriDNT5+zT58UcX0VHkBlTfzXkd8M9twf+BtPNzrgo72YeiYWTmqs/NyIsw1i8CHj1d/2X1hvC40mdsguWw797M3a8lW/yGQjyXMjQRqTQJTNRRRAQEJC3gzLPTFhpRePUT7ZJUDch9kFFtsRehxi8sspb///X3wwHQ++EYytwPu8EoDyEKQnwbKa7F42z4YHHoLwbbLd3g==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DM6PR02MB147411.namprd02.prod.outlook.com (2603:10b6:5:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 04:52:49 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 04:52:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Juergen Gross <jgross@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v6 03/17] x86/msr: Minimize usage of native_*() msr access
 functions
Thread-Topic: [PATCH v6 03/17] x86/msr: Minimize usage of native_*() msr
 access functions
Thread-Index: AQJWRMBMhEWrzhqQoRQ/70yarwqelgIhAvrzti8HL6A=
Date: Tue, 17 Nov 2026 04:52:49 +0000
Message-ID:
 <MN2PR02MB686321E2F5042F532F9E76C0D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261116183905.1591611-1-jgross@suse.com>
 <20261116183905.1591611-4-jgross@suse.com>
In-Reply-To: <20261116183905.1591611-4-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DM6PR02MB147411:EE_
x-ms-office365-filtering-correlation-id: 00fdd5c9-7527-4f0f-8a90-08df4466a137
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|51005399006|19110799012|15080799012|37011999003|13091999003|55001999006|24021099003|31061999003|25010399006|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Om6fj+F8TX2JGI8fSYl7Kq7VgMEOOZcN1NlCMZyR+BnYN4NNwvV7x1jARkJ9?=
 =?us-ascii?Q?n7MZ10qxo19uhCK+nhufz9xB5IWTBM8XO+sxS4LGVYVWPz2gWwmp22LrjmNE?=
 =?us-ascii?Q?JJXH9MYx8BQ9MNEMXbSkepoZQa+mvFFknHUPEZRNV8C4Edpl9467XMCijOe5?=
 =?us-ascii?Q?tE90Qj3/ChNiQJhWKpR8uWi7temH9l6SiHDC2LkijgwJGtxs4Tk/8z7xSJAl?=
 =?us-ascii?Q?Al1LpKNiTO/NQ+LM1idDyBI+JvoBsztrYLPRRzJMFPpWR9zL15QpPGxoXQpa?=
 =?us-ascii?Q?ndmVrrU5VBBMBwFlMRqTe2ij1QXIdv3iacikJwuCkHvwrZzbelkVqhNSr+Ze?=
 =?us-ascii?Q?Y1Q/hz6To2ieZ/0Qr5GOpWApVd/WP5p+/D6HjIt2fJD9XThY3XJ42P0LgYz9?=
 =?us-ascii?Q?hgtplooLq9VsaV0JDoUTbQQhYcAznovzSd9PkSyUGtCufmyAKfp535FIDXND?=
 =?us-ascii?Q?kMnQw3gS9OSwcrzfbkOyBkVGUeI7NMzs0qlQr3QBI1hEWO4XKRe58pmHCXX/?=
 =?us-ascii?Q?G8CfymPzSoNjmz8eh2PaaFUcKIfjXWmKrhegY5v/+0REzCqcVHP/Sk0PM4wT?=
 =?us-ascii?Q?3L3lToOcOphOmXl9bUWmuMD8Y77akmgWCHWSk4rThEkqzJMcn5DiYFSE82nH?=
 =?us-ascii?Q?k8JLNdgQB4N6FBDSq15PniT0teAazIS180398F8Q//aGpf9BWPMBOdTwFqKo?=
 =?us-ascii?Q?6jxvlLPog7PzOz9SsXNs5fIdcesRmDkRjllvtprbPD4hQU92UuRtYe6ans3B?=
 =?us-ascii?Q?jDkqTGNEV1/XObATWWtRQxq/9B+or92Cad0nPcx8mXMO55q1Em3IQdtQlivs?=
 =?us-ascii?Q?93SL3cHf5hWgG7NVnwwkbFgFX1+CmFT3mbaGO7K95TGPuO5xmEJfpQamKkBY?=
 =?us-ascii?Q?+p89zlCC0wb71jZclqyRTX4aGHkJ1O8nxO3a4Iu5dUtwociMXviKlp2lFyIs?=
 =?us-ascii?Q?OhNpgfuk6EUvvfNa/zwqz7ZNTKC3Syb70u4HwXMRB8tfJyX1QzTMpSKfLb8f?=
 =?us-ascii?Q?OzcRo13x+goFZMMa4p8eQoVJFvUMm3E/04di+eZCKkl9z21u3GDyZfdYXRO0?=
 =?us-ascii?Q?7SnpozZf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dp407flqj6mrej/E317Tj4pxJixLNg6JL2kc47wnAzlmXojd3rxBDvYThNNi?=
 =?us-ascii?Q?CpzQc605iMPTRLn/bPI6Q7CLGLVz+6fSee7VfYRx6psEK+Tgs2VNhpmzSTT2?=
 =?us-ascii?Q?5fSiXVuzzMx9UvGwMtjSh65uZybYz8GXrul6rpayf1bLoc1H1JTMBokt8FNQ?=
 =?us-ascii?Q?+AIfddi54tLlq5GnbFb+BCPvyrop1s/gk5Hwq+vdFa5cmORG0ivn+lcl3nrb?=
 =?us-ascii?Q?i5Qplx4hEu3olkbz5B0hwgO1xuwNNRQ1tl4k0zzAOJ4zF5AUn8zuoB1Lnunt?=
 =?us-ascii?Q?lRwmIlD/V3JVmxNwTJoTZ3qwWcFpOk0a8PWwHCjFQRDh5u/v3HGSj81bU5Es?=
 =?us-ascii?Q?1NOWpeBMqqzQd9ESyPWmsFgla0qayvF+piKNIg47NZyNbpADDP4TlT0Eke3m?=
 =?us-ascii?Q?uIO0Or3DdxRTceUvxUt6bhuguKralucub6m1ryxnTZccRfy/M5TZkbxhrl+k?=
 =?us-ascii?Q?2B+DJ/LWvX+9ytoD/+pAIKRU/zRgzLdkOxjZ/57e63g3yBkdW9vlOoUbqErB?=
 =?us-ascii?Q?Rf6pXkDvzDYjxolL5QBFmNfuQuVJksnW014tgRsQ7tFKnT3aGZpsDepym7ZZ?=
 =?us-ascii?Q?0hWUSOgb3Yl0k7DiPV4lf7SqFL96gSx8UEsSHe8Qd8pZQN/7ZD2ehCq4b4LX?=
 =?us-ascii?Q?RpaXm8qXVgBNLhTqe8AkxRDT0dk4GSQyDUALZqQud5BW21ahSI4C1LypaO7Z?=
 =?us-ascii?Q?QfLgHzHxn3Wo7ywfY2+gUB/EADkx+ujse+zB1WMoxWbX8UzA4jn3VIS+jxgG?=
 =?us-ascii?Q?BGuOtOpxm4jk138G0Oa/nyqr672xBqx8m3ApxhPgvxvyWDfPKAy76M1HfaO2?=
 =?us-ascii?Q?9TruBLTkDxYxRuQsObcnyP2avoI22v/mK9MrjkLYa4eVYHfDIBpRjGjzwEeC?=
 =?us-ascii?Q?CtONPgojimFQVq8EaLjrxQefFo5hhyx3/FaA2cRduCjSVQHmxZpMtRFrz5vy?=
 =?us-ascii?Q?jiDMGJi7isFJ4UlPAkrJHr3xB1j5Q8SdHRU5kF7jFRHSMDhUirqOaRsSPWWw?=
 =?us-ascii?Q?kMwNDz9HTlx4Sgi1TOb6Ra1npmEsGxQ0di5lDy88bXj/O2OV0u+b3jSOmGAm?=
 =?us-ascii?Q?xBvXFrlxETkrWr/Taz8PdKoXVSaaIbjA1lKvSBxoX+rs2wqoXQ7vXrAq3rx4?=
 =?us-ascii?Q?lJ+Zo3IZutXMFyClLj8QF6Hp/+6mFhZMmnlEeQvA+8tcXteFwJ8+GFzReFg3?=
 =?us-ascii?Q?IqM2sbsZRZ3MtqADGkSzI3gBPEDwysMWh/GWlex1iunJIITgy73oxEN9kq4f?=
 =?us-ascii?Q?vxK9lSPOLFeVDoDJtM50DSWRss5to2gnYyEWiNR3jGzLsSn5WxUviOGzHyMm?=
 =?us-ascii?Q?3cuTTsDXs9FW5IS7A2tPgTd7j4a4+Sb77qlFXNz2xYO8w8cufajMTnOmqy6k?=
 =?us-ascii?Q?2szETcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fdd5c9-7527-4f0f-8a90-08df4466a137
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 04:52:49.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB147411

From: Juergen Gross <jgross@suse.com> Sent: Monday, November 16, 2026 10:39=
 AM
>=20
> In order to prepare for some MSR access function reorg work, switch
> most users of native_{read|write}_msr[_safe]() to the more generic
> rdmsr*()/wrmsr*() variants.
>=20
> For now this will have some intermediate performance impact with
> paravirtualization configured when running on bare metal, but this
> is a prereq change for the planned direct inlining of the rdmsr/wrmsr
> instructions with this configuration.
>=20
> The main reason for this switch is the planned move of the MSR trace
> function invocation from the native_*() functions to the generic
> rdmsr*()/wrmsr*() variants. Without this switch the users of the
> native_*() functions would lose the related tracing entries.
>=20
> Note that the Xen related MSR access functions will not be switched,
> as these will be handled after the move of the trace hooks.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/hyperv/ivm.c          |  2 +-
>  arch/x86/kernel/cpu/mshyperv.c |  4 ++--

For these two Hyper-V related files,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>  arch/x86/kernel/kvmclock.c     |  2 +-
>  arch/x86/kvm/svm/svm.c         | 16 ++++++++--------
>  arch/x86/xen/pmu.c             |  4 ++--
>  5 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 2ce4dfe53472..a74f121f2a02 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -328,7 +328,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_i=
p,
> unsigned int cpu)
>  	savesegment(ds, vmsa->ds.selector);
>  	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
>=20
> -	vmsa->efer =3D native_read_msr(MSR_EFER);
> +	vmsa->efer =3D rdmsrq(MSR_EFER);
>=20
>  	vmsa->cr4 =3D native_read_cr4();
>  	vmsa->cr3 =3D __native_read_cr3();
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 91bbffbf5412..eab5516bc243 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -114,7 +114,7 @@ u64 hv_para_get_synic_register(unsigned int reg)
>  {
>  	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
>  		return ~0ULL;
> -	return native_read_msr(reg);
> +	return rdmsrq(reg);
>  }
>=20
>  /*
> @@ -124,7 +124,7 @@ void hv_para_set_synic_register(unsigned int reg, u64=
 val)
>  {
>  	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
>  		return;
> -	native_write_msr(reg, val);
> +	wrmsrq(reg, val);
>  }
>=20
>  u64 hv_get_msr(unsigned int reg)
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index cb3d0ca1fa22..6ddef8b5426a 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -219,7 +219,7 @@ static void kvm_setup_secondary_clock(void)
>  void kvmclock_disable(void)
>  {
>  	if (msr_kvm_system_time)
> -		native_write_msr(msr_kvm_system_time, 0);
> +		wrmsrq(msr_kvm_system_time, 0);
>  }
>=20
>  static void __init kvmclock_init_mem(void)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index a432b878c683..64f609d1ee59 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -415,12 +415,12 @@ static void svm_init_erratum_383(void)
>  		return;
>=20
>  	/* Use _safe variants to not break nested virtualization */
> -	if (native_read_msr_safe(MSR_AMD64_DC_CFG, &val))
> +	if (rdmsrq_safe(MSR_AMD64_DC_CFG, &val))
>  		return;
>=20
>  	val |=3D (1ULL << 47);
>=20
> -	native_write_msr_safe(MSR_AMD64_DC_CFG, val);
> +	wrmsrq_safe(MSR_AMD64_DC_CFG, val);
>=20
>  	erratum_383_found =3D true;
>  }
> @@ -473,8 +473,8 @@ static void svm_init_os_visible_workarounds(void)
>  		return;
>=20
>  	if (!this_cpu_has(X86_FEATURE_OSVW) ||
> -	    native_read_msr_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
> -	    native_read_msr_safe(MSR_AMD64_OSVW_STATUS, &status))
> +	    rdmsrq_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
> +	    rdmsrq_safe(MSR_AMD64_OSVW_STATUS, &status))
>  		len =3D status =3D 0;
>=20
>  	if (status =3D=3D READ_ONCE(osvw_status) && len >=3D READ_ONCE(osvw_len=
))
> @@ -2156,7 +2156,7 @@ static bool is_erratum_383(void)
>  	if (!erratum_383_found)
>  		return false;
>=20
> -	if (native_read_msr_safe(MSR_IA32_MC0_STATUS, &value))
> +	if (rdmsrq_safe(MSR_IA32_MC0_STATUS, &value))
>  		return false;
>=20
>  	/* Bit 62 may or may not be set for this mce */
> @@ -2167,11 +2167,11 @@ static bool is_erratum_383(void)
>=20
>  	/* Clear MCi_STATUS registers */
>  	for (i =3D 0; i < 6; ++i)
> -		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0);
> +		wrmsrq_safe(MSR_IA32_MCx_STATUS(i), 0);
>=20
> -	if (!native_read_msr_safe(MSR_IA32_MCG_STATUS, &value)) {
> +	if (!rdmsrq_safe(MSR_IA32_MCG_STATUS, &value)) {
>  		value &=3D ~(1ULL << 2);
> -		native_write_msr_safe(MSR_IA32_MCG_STATUS, value);
> +		wrmsrq_safe(MSR_IA32_MCG_STATUS, value);
>  	}
>=20
>  	/* Flush tlb to evict multi-match entries */
> diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
> index 3f4dd3f50f56..25f434b6b903 100644
> --- a/arch/x86/xen/pmu.c
> +++ b/arch/x86/xen/pmu.c
> @@ -324,7 +324,7 @@ static u64 xen_amd_read_pmc(int counter)
>  		u64 val;
>=20
>  		msr =3D amd_counters_base + (counter * amd_msr_step);
> -		native_read_msr_safe(msr, &val);
> +		rdmsrq_safe(msr, &val);
>  		return val;
>  	}
>=20
> @@ -350,7 +350,7 @@ static u64 xen_intel_read_pmc(int counter)
>  		else
>  			msr =3D MSR_IA32_PERFCTR0 + counter;
>=20
> -		native_read_msr_safe(msr, &val);
> +		rdmsrq_safe(msr, &val);
>  		return val;
>  	}
>=20
> --
> 2.56.0
>=20

