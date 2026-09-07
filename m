Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012066.outbound.protection.outlook.com [52.103.14.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127738F250;
	Mon,  7 Sep 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810851; cv=fail; b=RLbPiOiMCcaPfsp+jYMh1oyc3DVWeolDOPiD9fYnzxOjr/hvOR/HBGZAIwyhj2ApxZCwKZJGzGuTXXcOq2LRHNV9T18hQk153j55bfSmQcAq87LnL1+KOGFiK2ybQTQoep0S/IaFjsWXlteNiGpAzQ/fKx0KpbGtHMdZxIsSU/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810851; c=relaxed/simple;
	bh=ib+S1Bh2+6TWUOvRU0N/BxjvlygSKyDgARx1Pr8CIis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DgNDvlIvyQVFCT+Yi88Ilg+BNDLregOrAda5fswYnweR7382b8lHxK9UOSE3SMboGr4yC81GzneUHGYJPoMZdQgKos3EVuq82f072AHiW6V3Y+PKRRkMGHyBZNw1M9uElfCEm5cwrUIaTMurMrD7PyR58CxnXwhg/VT/uOrB4hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FjHGOU3i; arc=fail smtp.client-ip=52.103.14.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FjHGOU3i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXjyQc9qL+R3/VCal39admN/qlkeHcBLGy9dRKPY2gk9LA6dFvYkqBGaUyeseC7Vc5JsrAUSdrFF8JKtAIBoLytOIO580yDK0Fu+HeZG+bbEqAjUYt8qZj5TRxHRiS4ciF9bOfjg9iWbAgN+56fbE/MkDE0H7Jo3gOZPCCKZZKG5Dd42Pj+eF6bIXNcdnnbjG7FOdefNfOGXQBaPD16IoXtrgJXNV4miCrEMOV5VG7n3Bl8FY8W3tWtS5DsbOEYYYOaqhVYZdwyZgSkrZomO3RnfaxS8oBRPg2nNR2n88AL8FcnsiCqZx65ici9eTVDJjp8U7gZZ926xa5SG968S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLq02lpqjsTSH62JetOYC2zOK3QJifT0otk1VzHApg8=;
 b=oSH0zjLhlEl0oxj6u0Mv1OrfSs40aqq8tPTIHUxvoOr7YKWRq3cm08VIdoo4ag30Sr1jnUS4HQIsy/psKEb51DvawXnuv7NYchfPcERCsR44266Q/BfJr1gglQwTzdpxUSaPFtq2uTwQ7H45AUCx54Qw+hEuK3UpVLEzpi2NmBlh1Fco0M3HaaYa85xPfAnL75jIoqw/plQO41kRm2hSmVkRPY9lyqWH+Qf33alvLfJgJaI8YuzFgJSm1Im65vy+ITi0+OmKKqScAiKc5UmRTJzjG3ML4V966uKrUpi2XtAYdLS49N/b1LGnQf+HTr6XXXMTG2yTWEjahYEUfg87JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLq02lpqjsTSH62JetOYC2zOK3QJifT0otk1VzHApg8=;
 b=FjHGOU3ilfKf0pn2mWTmVFvHsDrAPsXQriwEeWtfF5Gxgr9J8xRJ654V6XGcULLdR4EcVTV69ytmjBuWh45tnyVmJt/qDoZqwb8Tz/PFaF9Nt8O5RC80n7vcLebJCaxqysu4i3rKdU6d9kF6PNowxsxOmrMKmzBmW1tJh0aMbJfQsCEnjzbrDKykAMj3B+2Y3BwV07BK9pYjtfMGHcTXVeUT/6KssTqa/2VUZFE8pwkwevrEWXUR8pYVoMumPPtBTRPIzGD9O0qo6uKqf2HYex8vUZNITyfzhaU1i7szWnM1VufqYylDic3Yz6aUf508aOWQ7rAjKZkBAoxL46bnRw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6526.namprd02.prod.outlook.com (2603:10b6:5:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 19:54:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 19:54:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Wei Liu
	<wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Nam
 Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Kees Cook <kees@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Radu Rendec <radu@rendec.net>, Sean Christopherson
	<seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin
	<d@ilvokhin.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding
	<treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>, Daniel J Blueman
	<daniel@quora.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in fixup_irqs()
Thread-Topic: [PATCH v3 2/3] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in fixup_irqs()
Thread-Index: AQHdPpVk/xvaDfpNckmvh2mhQpQJU7bDiB0Q
Date: Mon, 7 Sep 2026 19:54:07 +0000
Message-ID:
 <SN6PR02MB41574A5B8C7ABD5CFFE98810D4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-3-namjain@linux.microsoft.com>
In-Reply-To: <20260907065129.269262-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6526:EE_
x-ms-office365-filtering-correlation-id: acb8e120-7ea7-4a30-b864-08df0d19c746
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|31061999003|15080799012|51005399006|13091999003|37011999003|55001999006|24021099003|25010399006|40105399003|2607281247196008|18061999006|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?fWMahx5oIR/wXkXJ3BDC/XcZlvtCRw2KCVPZQrtwazv8zyTCZGuvKI57XD?=
 =?iso-8859-2?Q?5GH7K+VKFjnxCo5xYoGeOcrE5iD5iJvci9Far30I16rgVzYIowfEKs+T4d?=
 =?iso-8859-2?Q?qYqiSSMrYClOTvwqUS7RGv/yjRSD6EsWRWfM3en0KRts0+Od8TI5YGRPY+?=
 =?iso-8859-2?Q?SAAGLTEUTEckpBS2nv0lcghMNEdlRcwfbxErFdTCLtYPX3Qct92IZHkX4k?=
 =?iso-8859-2?Q?X/ob0q7mBy8TEXQV1C9LPTVG0/zjbAEl6jcPiDfMIZrAQs8bOyFkXX6/U1?=
 =?iso-8859-2?Q?XMJocjs2nPn6GUx5a4CRq2JZn2X00209DHs6UzUow/K7t0gPL7G9oCzseh?=
 =?iso-8859-2?Q?w9Wq2E+Y4Q0eSxcyxD3EvWw3CJcDhTNzwjQ02cjrb5+hvQETcIiBaZqH3+?=
 =?iso-8859-2?Q?M+UVjjIm8rvOLkyFiybG3dbgwRmfIxLAbtR8rL3b6HnOFeS/0g6MiQUNAA?=
 =?iso-8859-2?Q?V7msKloJNE1FIYtKAoA2gY1L7BCfErwDvWaQ6Q5uJ4l9WycbhANdzsYOrI?=
 =?iso-8859-2?Q?M09BfOAQ5kkQknDGwrixAOxhyVwMXLIhHC//xheBs67PK+RfusMIdg+ana?=
 =?iso-8859-2?Q?H1hUbCTTqkbIpDBU2SatzneviaQL3CfMgyEtPIGae8UZbLy6hENcFqG1Hh?=
 =?iso-8859-2?Q?2vOaoSBDSd6RBMw+7kMX4RqNc9IN363ajpEAyqfkCrX+puD00xCPf6ODmn?=
 =?iso-8859-2?Q?sw9G9EZAM6+fpxeJ0ob5kUldf2rOnQBGDB1/4BLnXfCgjXmpkhaskWneCt?=
 =?iso-8859-2?Q?xn6Z/dmEhQb7onzfQRAikF5dI1pV34HVAmqkQNhr0+mhbQb7pRZUQQQt1V?=
 =?iso-8859-2?Q?n9/NiLFw06Z+/qfPLpptubwnCNWqGy/pHmBw4ZBRsqiqhBKYPWuTUWOBGL?=
 =?iso-8859-2?Q?96aXQx0W7jLwcTNosyw7vBin5qpn0Df9NP6eWbeiVjcy7bQ4xsGnFRYHx3?=
 =?iso-8859-2?Q?jPbJffEt+C/LyfVCoSYurkdyQeClg0TeNH/GvF1E9LHPp/E14zvLbd7G3K?=
 =?iso-8859-2?Q?bVg4FULGTZ/oMxQoERJLPSiZlXdNN2jX//erIG86Lg2d+9po8BHmaTXl52?=
 =?iso-8859-2?Q?Uga7SytxfZ0+KcaJUP/ziL32DBNDhWgrbJs/YEI2Lpwzi75VS9YCWJg6Lu?=
 =?iso-8859-2?Q?Tn7qS3Kw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?IOWiTO05bBbprgzzf1PNfbyrFPiYVjSI86OXWXEqioFdn6qOI4suAu24ks?=
 =?iso-8859-2?Q?t7b9PhXvkkK1CpqKjz0URCowXtlI9uqknhvFSECf/qETR5xruwPsZCYqhM?=
 =?iso-8859-2?Q?WlC+OmLtD7/RER0A34nCvHXT+4hm/bDxdrkBheTzahmzGaB7Q0qgjS9U9j?=
 =?iso-8859-2?Q?g5RN2QfbqMrkC9SBFX61jflPIRaWCyPRhqxvMV67Y5W0B5g+rOO3QVXcn+?=
 =?iso-8859-2?Q?veCdrJ947QVBvrooXHrnieUaO5Zgeyy8/UolCvfGF+qrTZwji2i80XBd+5?=
 =?iso-8859-2?Q?+K0BPH4KzYLGO6Pk9DJNhNXnexScnG+hx8wMQ1u0n1AVXgBbslujA6f2rE?=
 =?iso-8859-2?Q?t+aH7yS7D1vggmKwVFt0OfAmsum4WUuS3Etl/SLt01ZdZFQwzHEY0zfaL5?=
 =?iso-8859-2?Q?xmMoF2Qhbc7jRd5OAxePOR0uwG2Vb5CSzlWJjcHqgcHffDNDDKaCRkshLM?=
 =?iso-8859-2?Q?USbYx/z7BIcq+GUau22SbM8NoV/74wGyISIgCKHwBlPvQ/Kp3jYqt7eSFE?=
 =?iso-8859-2?Q?bPLczKWJwPHfTVjuJ4waTlMjOUDtEd1Xh7ZkySOWsUXpGXuMKm//mxskv/?=
 =?iso-8859-2?Q?8+mKZ4b+kJkHJERNdF/rq/i1KGsq+sG0UAu6V7qTj66xz6YuiUqMBYboOb?=
 =?iso-8859-2?Q?eJh39RtPRh5jzZ/LGuwmRnuGBMRVzY81dIdUWtCPUCyEc1J0V6XuWAFpER?=
 =?iso-8859-2?Q?5gooqUiovoFaYGz0xPxov275ZlL+JZ9Xs1KjKpUwOLutHYMu586Z6zRYWv?=
 =?iso-8859-2?Q?iE3vGo8+IenIz9UB1hYFDSSlPifV8uRLClNAzcrGIlOONSU6Lggmb2OZ8u?=
 =?iso-8859-2?Q?yhsruF+6uNeGY85KW58eUcUhoC2z1yPsZu4d2LxhO/4AavtPeAU77+IH/u?=
 =?iso-8859-2?Q?8HugWo96mMUkVG/VYP/kQ44knWY8puFbrKdUCCDwdkHapx1MAd6d8Vhdvo?=
 =?iso-8859-2?Q?5+jyxZXPx4CqVcQEAYEJ3mAVT7vArDou8Uf7/pVDq9zbNSkitpyEgXOAcA?=
 =?iso-8859-2?Q?E0ZJw0YZBxZ6f8U7mhDJfXEc/bKlOUEGzOKjP+P1ABe4jhtqc/T1qAnIjn?=
 =?iso-8859-2?Q?ExHsbJCFyiKdRI5aafQcm+uPqxcXwX5qEQTHSm+r6BXtgiqPI3HDoWheQf?=
 =?iso-8859-2?Q?dN/JP8rWK/KlMnvr6o4HnvtswAdvDfnjVmu0E7YEUTmpWAgvRxNW0d94XO?=
 =?iso-8859-2?Q?/L+cxOCokRKueYWDVe4DxbprKFITCbnbFAsIYB1n3zGTCdPPnpkpJoXKOq?=
 =?iso-8859-2?Q?Zf0IeGoxV+wznejx0qx/rYqwvXePufh+1azwiuFNaonDhGJO1fOzEuET/v?=
 =?iso-8859-2?Q?Ufa8339tvo9TnUs/VnEpW/M1FhxduCBX1ma2r1kfdY8zd3roOGh5ZRvVRT?=
 =?iso-8859-2?Q?GqNGKHp3BqRehkYI9h0K7Q1t+5wLfVOD7RykrFj++csblzuRV6xBQ=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: acb8e120-7ea7-4a30-b864-08df0d19c746
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 19:54:07.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6526

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2=
026 11:51 PM
>=20
> fixup_irqs() re-injects a pending interrupt on its new target CPU by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly. When the outermost chip does not implement
> irq_retrigger(), the pending interrupt is silently dropped, which can
> lead to lost interrupts on CPU hot-unplug.
>=20
> Keep calling the outermost chip's irq_retrigger() when it is present,
> but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
> up the interrupt hierarchy until it finds a chip that implements
> irq_retrigger().
>=20
> While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
> now set only when the retrigger succeeds instead of unconditionally,
> which is harmless today since apic_retrigger_irq() always returns 1.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/x86/kernel/irq.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 30122f0b3af96..e0163f7ac7368 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -470,6 +470,7 @@ void fixup_irqs(void)
>  	struct irq_desc *desc;
>  	struct irq_data *data;
>  	struct irq_chip *chip;
> +	int ret;
>=20
>  	irq_migrate_all_off_this_cpu();
>=20
> @@ -490,21 +491,23 @@ void fixup_irqs(void)
>  	 * nothing else will touch it.
>  	 */
>  	for (vector =3D FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
> +		desc =3D __this_cpu_read(vector_irq[vector]);
> +
> +		if (IS_ERR_OR_NULL(desc))
>  			continue;
>=20
>  		if (is_vector_pending(vector)) {
> -			desc =3D __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> +			guard(raw_spinlock)(&desc->lock);
>  			data =3D irq_desc_get_irq_data(desc);
>  			chip =3D irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			if (chip->irq_retrigger)
> +				ret =3D chip->irq_retrigger(data);
> +			else
> +				ret =3D irq_chip_retrigger_hierarchy(data);
> +			if (ret)
>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}
> +
>  		if (__this_cpu_read(vector_irq[vector]) !=3D VECTOR_RETRIGGERED)
>  			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>  	}
> --
> 2.43.0
>=20

