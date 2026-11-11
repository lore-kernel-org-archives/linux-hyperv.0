Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794420666;
	b=qvN9S20D+pZcDi1kOD+8hmdwhRRy7WjvXzGlc/Vd+pGMZa5ZWxHckhSsFLjt0ZtPPVQd
	 IYMCOr0PIEmgxZIVviToTGERJv/Xbxt41ZeGzhQAm+k9tfMBpb3/UGzmv6L9ZK79GMKjE
	 5m/ibLnKJE2UTOczj1mmY6rqQe8iYiDIlgaGjPbo/5iWx6pqjp5l6xbYZDwRdtCdvui3B
	 zvMaCanfXkv/4C4JArUozEpC/j/UmGnrqVVJs5SsSs8UOoA6AUB+HbPt5vsKU4c+DMeh4
	 wDNKDc6UFGCfMSvUlLk8m8kqIAeojKuzp+toMXCxG2ISyGug6cfSMspOBqEVDKVcfww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420666;
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
	bh=cnsidapds3rbDziHl2JuGhJZG4kvqSlTUlYS4EJow9o=;
	b=vlyPFO6OJnFlpBF1eicNZ83WYtBIqu7+kXhPTnyxkpsDKGHXYf8IN1Gy8IvI3/ZKgSyt
	 L8khJ8zmBgW+LuC+0wdl2dsd+44bHDmfq+hHoetHibe8v7v7upkW7PF4T7kyJClyG/UNa
	 ZTjNXBEUIWrU5vv2HM92tHN1H7kDcZ2HmoI9pkAMm+hCbh0MQ1y1YQJiloMqC94cnQqIp
	 sQuc8FkStWzkxW4XF1eTEsAaGrCRZEjrI8mOyYTw398a6jhfRdk3HtblHB3MKNri61G9X
	 S8+fMoI7PIiQlftN7kf8wtyOXWoc7DAK46F/ppewQDDcYk4XojraBe4Y4cJNPktSSLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mdipFx0o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.52
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012052.outbound.protection.outlook.com [52.103.10.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E2606A332;
	Wed, 11 Nov 2026 18:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C1E2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mdipFx0o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBHqExPTdLNU/mqpiyS3/QTwR1CA8Z4nMvt7TjrY+yPeGSmmOBEnIVnyMjk9I7oPnnZEU00TGWuKcsYHS/a7GDqI7Pv0AYYlSl78RF6j4HvvAh+am/ZFloTzeMFFj4CiI63vpf9APlqlKupy9psZwsDrS9skb+nRRR+8jsHbRLpEV0GYwJHpHJ6g+bIrrtTMDSJRGdyGlbFxv13nkwURGW3Re0uak2oL0TQRb+tnBLB2tU9yodf4m3Cgh0H0vCZ/pEj1xCxJ10+5gFyPw3goDklQ1NeUSe7iJjYhJCkGUnrSeSWNLpUiQS3Wk/IoSYrAqoyBJjtGayUaMEa34uFGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnsidapds3rbDziHl2JuGhJZG4kvqSlTUlYS4EJow9o=;
 b=qTSdtdvvuansckgvAAZ5FKO0pW6EaE48fynCj/vWNv8lH9CC70w5T1nlxScMnBwLaD6ZT8VIyMz0jyNqwOSdHfPa618Az11hETl5kuy/uQ6aqqXSAa81XKl0wkYa6yMlUHtRfhFwZp+S32IeHArBsWWmaPkSoejz/ETMc3tFxLjdyghiSMpjDuexhBgQuuVRpuL5b3NhhdVcOJPP8ET+VcSSwec6SxrntEmfZgdx9cwNz6I5nZfaXhDxiZNS11Zncemt+oOKo9yJlk1O7DCydAM3XtSfIyDg9RGD+fr5dOgE70R92xEl2S9Cx+JL2YP+lugRmi+wZF95F5RCcyX5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnsidapds3rbDziHl2JuGhJZG4kvqSlTUlYS4EJow9o=;
 b=mdipFx0oB2LnBI1JdsxX44AKpFO0I2RFpzx8anDdhi8uEd1Ock4SZglUdS4n/ljeyzuEYbXlw5vxP8v9brZbS6CD0eQppoGdVaGNVtSz4uJjfNZhcVIIZZC/np2boBhAsNq1TusV3/fSoUhZxf4jM16d00zfmQirLgGqjpatPJp+egSYuA9wBM4qZyoHwRxN9RiyqS55HukZ6ltghYUyTN176CPLw/ucReHQiLjjPnz83RiSm4VQv5p/1OGF8fHa/bCrPMw5KdDoNl6RJwZ2W/ykxmCMXCAzP/Jejpdlm2BzCc08qhDqQhJy/9b5lzf2qf2oSqeuiB4fc1OwOt6meg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH0PR02MB7947.namprd02.prod.outlook.com (2603:10b6:610:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 18:09:03 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 18:09:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
Subject: RE: [PATCH V0 1/2] Drivers: hv: Add new function
 hv_isolation_hw_cvm()
Thread-Topic: [PATCH V0 1/2] Drivers: hv: Add new function
 hv_isolation_hw_cvm()
Thread-Index: AQHdcYNITCzXCeM9FkG7osdZddDNR7cpLG/w
Date: Wed, 11 Nov 2026 18:09:03 +0000
Message-ID:
 <MN2PR02MB68638A29ED39B5D77EF34616D4712@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261111022036.351231-1-mrathor@linux.microsoft.com>
 <20261111022036.351231-2-mrathor@linux.microsoft.com>
In-Reply-To: <20261111022036.351231-2-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH0PR02MB7947:EE_
x-ms-office365-filtering-correlation-id: 0d8274cd-97e6-4c6a-d85c-08df401ede45
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|24021099003|25010399006|55001999006|31061999003|12121999013|15080799012|19110799012|8060799015|8062599012|37011999003|41001999006|51005399006|12091999003|1602099012|10035399007|40105399003|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+TLugt3884cDLnSgnGJVTRaCZHODllEfXRFRvkzykDfK8kPw7HbkoHUOYiH2?=
 =?us-ascii?Q?/zfLL4Rd6M0XGQs2vpJ8CUZIPfvyl43LTygRU4Od++Q752pwa/AyoioI3pDx?=
 =?us-ascii?Q?q5Ot1Tzmuf0+VAO2POYfOuN1tw0D7S1WLsfpuWvVj/dJxILBmK6Xu70lQOVW?=
 =?us-ascii?Q?AZikHJflhl6RwUZ0w0ChiwMxJ/1F6aFbCai6rwrRUMBqAos3xV+B6jV4PZJF?=
 =?us-ascii?Q?8XCFCmmTguw3vWQjbJzcQ0zgB4dLuUfwsgTZoTWXstQVsfeMMdRG0enRvCGm?=
 =?us-ascii?Q?GRLrRnjMQkjNFlmUo4fqOnSUoh6hbkjFnhzbPEeGk6UD9hdW5W3+hFnoTowl?=
 =?us-ascii?Q?0G/jm2kyPin0yHCnwnNTbfF+GsBigabiAaPNWYBOpmuRzWrB8RtGWi6FiPBz?=
 =?us-ascii?Q?1ux29063kEO8xYEwoYP8HwJOH2n2Yj9l3dTABiUV13r3NQTdQ0FNQxeDgnvl?=
 =?us-ascii?Q?NMkPGXT4/JPT1LWM43Ega31F1nyKlmFjzqj50EJC1XCmnsG1fckBSRqkCAD6?=
 =?us-ascii?Q?OwR7Fwy5NJELIzhGIZoEW1goPESf045lqT/VMXDBO3eu49RaUM0Sp+BagN44?=
 =?us-ascii?Q?/AwR6iCk1aNwsbYUFV79jjF954UJ4rsg1BPNWTMZ2vcBI5bTwRKrJwZiHFJd?=
 =?us-ascii?Q?myPul/1Guw+sHpw3CjCSTmTL8MA74mEZfXWurPYXWP0JHjgMttZCJm56carO?=
 =?us-ascii?Q?KdvfNIfr4byf5W2lVTa+jkYRIDhhjqjQGaWA6CU7v9XkJvR1wivAM9Uaq1Sl?=
 =?us-ascii?Q?V1UtZPRAGWP0WFwgTysUwNqcwtyqnljtP+1ianC4QB2vG8vJIwLTzwpUpFfI?=
 =?us-ascii?Q?DPwboHTUKO5pAxTNKJ/YTASjfq6l/ZIi+Vz0CAlPlhaS5MNLfoYTZm8+1W/2?=
 =?us-ascii?Q?2bcK22E5urq8utegf0hcSgX8rtgDLOryVFqnDP5PHHMgKpo46ckezUOS1q9Z?=
 =?us-ascii?Q?6FTdRNtbWoiscTBqDJbW7LG+Q2ilDrg2K5gVyYAtlwMfSP8NIDjv1kYJpILJ?=
 =?us-ascii?Q?CUrvvuOxUrYdYmHZnBZKxemeHTSgRe2Clj6orzTJjQK4gQ3kFjr4lSj48KyW?=
 =?us-ascii?Q?n9llvHCujTmwGSc0jztNLkTeG2DEcXaKHH9xdko2ywBd+PNNDTeyDQdgYIzf?=
 =?us-ascii?Q?/iqKfqfw8+d1EqrjnXYHoYEw7ELlBB0GeIzcH654CABMQPiKxaN2VfY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jIBNkw9RyvVRr6oXC9KtBlBO1BmwKEtxYNpuMbH9GpIbBFi0XRnTk+/VxHBB?=
 =?us-ascii?Q?dxSy+qG1N6psYq6fP/UIlF8BP4SGBP+7jEvmRHdeOptrdeoxJHIYgMeg7p93?=
 =?us-ascii?Q?rEUYOEDe+g52xsj87evV0sQRNXc2BVY47fICi15ItEU1bV+jKZdXkGaq4sYd?=
 =?us-ascii?Q?qgIHPILSIZpzX3kcQKkz3o+7s7tK+JnhMBMEtiGowMX2J09EGkcme7Ib9EgK?=
 =?us-ascii?Q?i/cEyojW6XxDFGTClPziGRQPZ1ICbUOrE8YYn2itsreIxFRWE6/wQXB630vv?=
 =?us-ascii?Q?D/aRUQJhZNoZMzUwauFaru9HSWoi10TIdGrDeh1zlLHomAha91EVD26CWtFE?=
 =?us-ascii?Q?F/fXz2zZGnrkECfoOEJVk8I51B5CaaHqO+oyBS0iEnb4NCukZd3iVuUhiVoc?=
 =?us-ascii?Q?0Wa3nvPDGkTYNQwdqHTEYhLe/ppibmZ0W7/bAPANo6b3HAL8+ISSncBCMDJz?=
 =?us-ascii?Q?yT1ECgrFHTbU/DKDv/Oxmt1jBsEci8un6bKqgdhXTILm9GIoSMVopkgZn9UZ?=
 =?us-ascii?Q?lwl2EwgdBFLIQsJ7ZB/3lnNlhF0UxWFu4feeG9NFsAqhTtgjg2rZXnq93C5r?=
 =?us-ascii?Q?4oDRw6HB2bxKN5jixjglTnyL3CuWI23yUnu5uNoeeJ+8EaHv33GFUnLMfNlH?=
 =?us-ascii?Q?/9z5XA15NMMLMysAjjnfVEI94TFeSm40gDunQ/GGcTw8dNAPPYVUhnC+y9Dh?=
 =?us-ascii?Q?bZaTEpvkuZEICl4XRrzyGgStFZS4zys1kTWhU6ryPJ+IUizZny8kHCX6nEAa?=
 =?us-ascii?Q?QdGxcM7JAjdsGLIcDzXdwcVFtUp0rMb45kEDdUPBCRZA3wQiRN9cObRBGHe1?=
 =?us-ascii?Q?8JWcj4Qowm9irP+Mlp612VYxe6jK+wCc0cbXREu9/orQ6u6r++6ne7uBq1Oj?=
 =?us-ascii?Q?bdtOS6/We3oYqfB2ng6RjpTI01i+8OcDHtQxuq4QzzqOSajhnp8Jbg/rSUHF?=
 =?us-ascii?Q?IQi4wrpXPAHVEZipCIiadZGqy5laAXWFJOPt/b9Rmeu5O1n9tRFmQYustVqp?=
 =?us-ascii?Q?NcE5/ohwCwRRcKw7aEl0UHH51W62EhPs2RcywuGrA301zZMaLgueof6MaRtg?=
 =?us-ascii?Q?/kxD98c3REnCBwllfucfwB1chzMd3N0TGdVsiyGjCBl/A5nOmyFWxSb5mFzq?=
 =?us-ascii?Q?TmQp7cyu7nxnKZG+RTe+l4EtVLLcXL/oYj9WHHIxG1/bGBnoDCeAYwyWI2QE?=
 =?us-ascii?Q?PAvCTdQuam0wWoqq9wOf0D5B+3tRED6srG8yImHZXAQaRuKgI5o0xHh/YyLU?=
 =?us-ascii?Q?MkU15ARYZtnIuLxyFCeEvaNCpVFmgO3Gs3Z3SzmCMvl3IgVTN3sZS1ytKPM1?=
 =?us-ascii?Q?Vl37WDq8K/sXHMPjnrGrD551b44PNkzLErINpOMIPTozk/98xyok6hlI2elU?=
 =?us-ascii?Q?tGWa3h0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8274cd-97e6-4c6a-d85c-08df401ede45
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 18:09:03.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7947

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, November 10, 20=
26 6:21 PM
>=20
> Add a new function hv_isolation_hw_cvm() for convenient check
> if a VM is running in HW confidential mode, ie, TDX or SNP.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c          | 5 +++++
>  drivers/hv/hv_common.c         | 9 +++++++--
>  include/asm-generic/mshyperv.h | 7 +++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 2ce4dfe53472..b3340be0c43a 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -944,3 +944,8 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +bool hv_isolation_hw_cvm(void)
> +{
> +	return hv_isolation_type_snp() || hv_isolation_type_tdx();
> +}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 27b9b79d4f4c..62b52855ae69 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -528,8 +528,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>  		}
>=20
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> +		if (!ms_hyperv.paravisor_present && hv_isolation_hw_cvm()) {

Any reason not to use hv_is_isolation_supported()? Your
new function seems conceptually equivalent, though at a
detailed level it handles VBS isolation differently from
hv_is_isolation_supported(). But I don't think including
VBS isolation here is a problem since set_memory_decrypted()
is a no-op with VBS isolation.

Also, Kameron Carr has a patch set in flight that collides
on exactly this code.  See [1] for the patch and my comments.

Michael

[1] https://lore.kernel.org/linux-hyperv/MN2PR02MB6863AA6357C8E0D4881F5FEAD=
4712@MN2PR02MB6863.namprd02.prod.outlook.com/


>  			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
> @@ -696,6 +695,12 @@ bool __weak hv_isolation_type_tdx(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>=20
> +bool __weak hv_isolation_hw_cvm(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_hw_cvm);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a3d497d99b0b..440c599784eb 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -87,6 +87,13 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u6=
4
> input2);
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>=20
> +/* This needs to be before hv_do_rep_hypercall() below */
> +#if IS_ENABLED(CONFIG_HYPERV)
> +bool hv_isolation_hw_cvm(void);
> +#else
> +static inline bool hv_isolation_hw_cvm(void) { return false; }
> +#endif
> +
>  /*
>   * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>   * it doesn't provide a recommendation flag and AEOI must be disabled.
> --
> 2.51.2.vfs.0.1
>=20

