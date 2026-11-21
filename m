Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795303827;
	b=fnzrN9mi27Hnjd6ksj+u6NgVG/rDOpFT35yMIFwGz9Ho82glhfcKn/AW9T5lhHsAB5TY
	 yQPrluJreqTQnW7Owz9iB05zy3XvdClbbOpVTq6tSEiz3r/YaBvx41f+UuJhNIyifbv7B
	 kjYSrQvcn+c8wmO5qT0ZbwyHn0HzrK5Lx2YncBvXCiYCogd0D3VDOvdSKMehqtmu6JSUp
	 8LPhT6AbMvnbQqHNWnXKQsVWLIW1UCnPYRSo2xIH2LDURmR9il9G7VjWMm2Yy7rNos1/4
	 AithNyEBM6OweY4jc+tt35PwJp0TfObMARnk/DePyYnRLAt9HD/qxvqmBUJY77a+31w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303827;
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
	bh=u/tdSQCt9uPRoFdbm09xraXhCxmPlz/CUDR5i1yBOvE=;
	b=131Z0Wznr3AsL2oqmA/r5AjjzEpXh2LMJ91ovC4zndgjGkXrylpj8ydZ72Harjk/cyBy
	 QPFIHPVGDwKnmeC0QqHmit8YMa3M5rb9CKr+SKqsd3m6XyBuC3yFtKqmb9/oK3HYPOL29
	 pvWKWce5AicJZsJJKNF4VkOltNFxSjg28craLHlshvaGxbJA03uqllbEMV6VlgSKmGi7/
	 FpIBpnhMb7l8obeWTWiAHId+q+B6n5aQjQZiur3h+vPtYBRnDPsYBqW5M9LL2WoMWFA0x
	 uFIvvHsubzC86Brc0wNfaBJ6EYqZD6TLHp9y572hjgg4mkW5bAXdCeoqDY81wO5NqCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UHo7fSKC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.79
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013079.outbound.protection.outlook.com [52.103.7.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B513606A320;
	Sat, 21 Nov 2026 23:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B513606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UHo7fSKC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hms7ooFNZLBJ9OmpcRtXEu7CXllhdeMPSb9meKvlYisH4SowhYkP3FxmQCgDYHRQpIvnzmAy2v6qukjJPUWblosToSBOV+Sz/js+cuu1QKqAKzeEkIMzrRBWJeWtLPUFT/SynCB7i6dpAFKkWxrG/rYtxybze8aGgooFc2Hf24I7FJT6AcjvJ7QULkWHfI8rVEWxpdRyshncrgYSdLtACqu++kYo3yu7P0ZTZLxgPrHoqebja+aoOeoWjnV385k9LzP7W+4e0ARkfVeK0PGF72XqYpbvCCZHw/jRAJn6INaU095EtJd2iSuUhF5E924SVJLTojwwiyKZGLzffcUY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/tdSQCt9uPRoFdbm09xraXhCxmPlz/CUDR5i1yBOvE=;
 b=uX/FoH8IPSnN/6shGv91QaDzJAgelJC/mPMLtrVSBsfvGaX06rkjHZqR6Iyxe9vsLHUP6mLpsXvq6c0cJdy6o6QBSr1OXmcLbEKjiQCgZ9V5DG9VsQQ+hGlJxXm9HxnjaALOETiL+a0JNF9dy5OruDo8c20OPU2NC/Q76zOnDF6gkBs5XKYub0kS5VzV4vqMVpIZ4/ihGKg7Cj0Wtc1xnSLLiQTuv28pX+pjyu5u8BQ0kVqEccBRajn9MFBkbON26HFdk4w7jWahQvXnvrHgfinzSc1TEgS5dLN7Y5lM46i3lNFy9t2MgYoSIxEXSm7qzuqzrGb9hekpnkEHs5GKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/tdSQCt9uPRoFdbm09xraXhCxmPlz/CUDR5i1yBOvE=;
 b=UHo7fSKCMiEjPlsSXkCBVXZXlzpNM5lv8kVOQKXKfkRyM9G3vF/KiUyrPQrm1228083wdyMchsrtOYVjpyy+DXciKi286ScatSbEmVoTiZrrtrGWjS6CORKvV0WcFJotRwJ2s8xXodiVhLOW0LSypuyPu/higPfeecj/7oNs/QH5Ns4FHkOGFkxzxeWyR8VXPvs4ueQViymbHvnZQWPUxnuAZNkGwERBgOObsuFvimhJc2XK8pRx1pLlMr3h15Zs+4QPOfCGhs5q22xq0ggF2A/3Jxzn2f0TPtblB8rogQb2+3dxjelHLfYBhZOS8xf1EIGSb/BOFzFmmxdUM9Ngng==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7839.namprd02.prod.outlook.com (2603:10b6:a03:32d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 23:30:24 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 23:30:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] mshv: Handle completions on repeat hypercall failures
Thread-Topic: [PATCH] mshv: Handle completions on repeat hypercall failures
Thread-Index: AQHdeJQjAUjq0GifCEG3jRSWtn27JLc5L2Kw
Date: Sat, 21 Nov 2026 23:30:23 +0000
Message-ID:
 <MN2PR02MB686354DA3595E40B457C130DD4472@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261120020858.3597446-1-mrathor@linux.microsoft.com>
In-Reply-To: <20261120020858.3597446-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7839:EE_
x-ms-office365-filtering-correlation-id: 277de455-90ee-4c26-cfec-08df48276a56
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|31061999003|41001999006|19110799012|8062599012|8060799015|8022599003|15080799012|12121999013|13091999003|55001999006|24021099003|25010399006|3412199025|440099028|102099032|3071699003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8x6vsQCMmy1mReNNTmQiEc+1dr3CddRVKg0STWz+fHMjWcddrySwMFzzNWVn?=
 =?us-ascii?Q?m8zXLpMWqm4iw9oPB/kUOnPIJIP1+nmCwtOrfcz3dFf+ZTZS0roojP/S+6nQ?=
 =?us-ascii?Q?pTqF75aE7hq/sm3H/CYtzPxF0J6fz0pJTuyWRq1Mwqd3Z698GWnJQ9QpMioz?=
 =?us-ascii?Q?tZQxbkbNzXM3+TPuUJEqz7CxIM1m67/cLSRwkjJarZvnTE+2DcXseE7Z3KJb?=
 =?us-ascii?Q?F3TCAKmMBa+scUkJxGzx6cZ0sf6unL9qBV7JxDxgQGDufDudhjyabpqyQ0ui?=
 =?us-ascii?Q?Bvg13IVzoTk0Rx8TNE18jZBrnEI5pePwDR5vmqgd8LMIB52xuuVzY+M44G9N?=
 =?us-ascii?Q?UCnaFLJSvFca6cmCnIyLnx3Mtto9oeswACGC/pwJkplv5lBgNlTm9OSBsw72?=
 =?us-ascii?Q?VsSwffGy86ZOAFa4G+PNNHV0uq/pWrNC/GVoV54hNE8zh7TCtP6XkwXwUuf8?=
 =?us-ascii?Q?Jt4+VR0ezGPYQ2+/0FANbe8krY76+9gMiACvIJPFiUei8YX6S2Kn363N8NFB?=
 =?us-ascii?Q?lxMWdZspw9GOEMHbCbEhl0fNcT8UhK5O/kjliFRHUBIwCSsbaqxclV0YrkUS?=
 =?us-ascii?Q?hTP2tQbElokwoQRODgH/4v6QxOIfnCDQR3T0WpHGb0eDyYAF6S+CcYoCceZR?=
 =?us-ascii?Q?Z3zjInf4dxFo+BSdGnKqsex//feBnXPMY1d4tfTqUVgZAZG5dARYK3v2CsPX?=
 =?us-ascii?Q?0KQArLwJNU96xPmWZLHF2S7kKiQ0kR67PFRoz1IhKs1XuxSYONnKf1NA/Fjg?=
 =?us-ascii?Q?FTRsGApIfSe60xUT80Jl1Gt4dfK8k1NgYa56BN8oup3IOqWnNctAfKElOi3l?=
 =?us-ascii?Q?f0mwnaI3OcaCfQDh1W66CfRTr0bBj5EM//6Qlns+ItOmu6KfMYQDBK7GFHhO?=
 =?us-ascii?Q?lDsFs+FDbGONSRZgt8kVsL35R3gmUcufRgL30g7V/K+2v1tYDJsYBGf+/PVz?=
 =?us-ascii?Q?yHIT0h2ABYFaE27TzxR0JuskR7fqRUcpCHdwlOs7N+Bx7bWSQgN2bTqbXfiC?=
 =?us-ascii?Q?R4nr1UuPeCDa6pQARlh6+NjTUK2p3vrTA/QgEQsdrAyC7Vsz0t0yVoWFAk+U?=
 =?us-ascii?Q?9IxP0qPLVOq2J8Wfzu1aQ2lKPaBzOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tr05cq5mHwbRmVWkPdG9di9Q0UQSwBK0j1NOOCOSgSPxL5l5CmjTGoV2U2GJ?=
 =?us-ascii?Q?H2GqSlrFEk7bqW6XyhLxI5wK3Nku4NTPuieHOjTA3PUltadkSaTUoaQRNph2?=
 =?us-ascii?Q?f61uH66B9W68sJMwrx/b71o7x1aL89blWcUIDIFPgoqbf8QDUHfFrSeEbEFb?=
 =?us-ascii?Q?jMmtVDT6l36plY6XHW+oOvC3XKaqw2Hbo01j7vUVsXRa1+p3bkHzDhHzzdWU?=
 =?us-ascii?Q?WHOxB/G/FJlgP3Rs/N6qIG+66yiGnlZ1Y6JxYOkQhxQHea+G9agij7szka5U?=
 =?us-ascii?Q?enFgUM7JFzhkWOr0/F9vet9PcpuiQnG/zDzZ4Q8O5Tr4+DnBTwUwff9XaLKn?=
 =?us-ascii?Q?DkwFmhSeUYDs1FAcrpvf2TzBMsK8Z70fh2DFFodbhrn2m7HuGiafP5ZxsKrq?=
 =?us-ascii?Q?oEFiKYOrnRa58BV8yrnuyx1fS8IPXNuTQlFp5lsDl8Afi3HTYyBwYKlWECIo?=
 =?us-ascii?Q?zKIRP4tJSuCCujxxIAngpj61824AgMZ2fu4iipUU7/CWMT13c4xOpsrE/h0U?=
 =?us-ascii?Q?HvJA+zj+9g3YNZWCZRL8rr6iZkg3I9kar1sGNIKY8CMFH5T3oMGpMbfpw5EX?=
 =?us-ascii?Q?RrAas6Wr8JTIjGCv3joqqgqz3kND0ODMS70uBBDKL8Ng75NqB0osWV4Nw8vq?=
 =?us-ascii?Q?hAe/K19WAfw15leL+pbETY+bp6DC0KsOH6yh4Dlo+UN5+9b0iqW4IR0LpWzW?=
 =?us-ascii?Q?u+VxInw2ooQ6GTPNuUSmyI+AE5Jr0v+iM/BLzwoNh43yVAubdCwhEbe9MHmG?=
 =?us-ascii?Q?xeBUw9A56geD0DXM+yarwIbj0i+HTdpQ/UTWxSAaygECZKT+wE0vfOny4vjM?=
 =?us-ascii?Q?OxVRQNhmFkQ+EtfRivPLycB1TtH9e4pXjriMsqL8HldHsSjT5b7+8EyLCcdR?=
 =?us-ascii?Q?md7DNsAguhHPJxuIph1/oMJ5ydDnKZUE23pUWr0oTdNXx84V1N4iBpxbmc3F?=
 =?us-ascii?Q?jCsSmmoM0gUlgd2OU0pALMkt6a6ewmxb+t3yQcrFxuEJBKGa2KgF+hsbKCTk?=
 =?us-ascii?Q?QBei1cM2ROVuCpUSOxiVPcU6ShCOZc574xXYbgqbGnmWIIi0XEhBFh5n0dT6?=
 =?us-ascii?Q?9K4qqScBAtsNJi0BfIvZ+C5R9REAZP46TlS7cR1Tu0CadNf/HW+gpdJEMW/n?=
 =?us-ascii?Q?OFIBfAltKbvZHKE0RJUgqxWBhjoIgugqHrjqDbBjMI2YSACJTTjmyzfI74Q8?=
 =?us-ascii?Q?aLD5Gwfq+p5RMT1JINCOpoh3z1fNkxjDQBf+DNcz/DWNtM3cYCshjXFDfqL7?=
 =?us-ascii?Q?E0SwpGY9w7WOn9sXP/b0LcOrBOjKNRlETaHhsIUXgkhxDElxCb6W2bKQ/JIz?=
 =?us-ascii?Q?nqPAQIe9z5LMHwcuca+f6ldMC3gAILDVLdaGB4vta5cC4EX+yu3srPnGhcyy?=
 =?us-ascii?Q?xRHvBR4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 277de455-90ee-4c26-cfec-08df48276a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 23:30:23.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7839

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, November 19, 2=
026 6:09 PM
>=20
> When a repeat hypercall fails, it could still have completed some of the
> entries requested. Fix places where completions are not checked in case
> of repeat hypercall failures. Also, add error prints in couple places
> with correct partial completion counts when repeat hypercall fails.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Reviewed-by:  Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/mshv_common.c       | 17 +++++++++++++----
>  drivers/hv/mshv_root_hv_call.c | 15 +++++++++------
>  2 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index 63f09bb5136e..580248a490ac 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -56,8 +56,6 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partitio=
n_id, u16 count,
>=20
>  		status =3D hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
>  					     0, input_page, output_page);
> -		if (!hv_result_success(status))
> -			break;
>=20
>  		completed =3D hv_repcomp(status);
>  		for (i =3D 0; i < completed; ++i)
> @@ -65,6 +63,13 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partiti=
on_id, u16 count,
>=20
>  		registers +=3D completed;
>  		remaining -=3D completed;
> +
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: count:%d comp:%d rem:%ld st:0x%llx\n",
> +			       __func__, count, completed, remaining, status);
> +			break;
> +		}
> +
>  	}
>  	local_irq_restore(flags);
>=20
> @@ -99,12 +104,16 @@ int hv_call_set_vp_registers(u32 vp_index, u64 parti=
tion_id, u16 count,
>=20
>  		status =3D hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
>  					     0, input_page, NULL);
> -		if (!hv_result_success(status))
> -			break;
>=20
>  		completed =3D hv_repcomp(status);
>  		registers +=3D completed;
>  		remaining -=3D completed;
> +
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: count:%d comp:%d rem:%ld st:0x%llx\n",
> +			       __func__, count, completed, remaining, status);
> +			break;
> +		}
>  	}
>=20
>  	local_irq_restore(flags);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e761addda50e..6261686c3638 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -239,6 +239,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 =
gfn, u64 page_struct_count,
>  		local_irq_restore(irq_flags);
>=20
>  		completed =3D hv_repcomp(status);
> +		done +=3D completed;
>=20
>  		if (hv_result_needs_memory(status)) {
>  			ret =3D hv_deposit_memory(partition_id, status);
> @@ -246,11 +247,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u6=
4 gfn, u64 page_struct_count,
>  				break;
>=20
>  		} else if (!hv_result_success(status)) {
> +			pr_err("%s: failed to map pages at gfn %#llx: done %u/%llu, flags=3D%=
#x, status=3D%#llx (%s)\n",
> +			       __func__, gfn, done, page_count, flags, status,
> +			       hv_result_to_string(hv_result(status)));
> +
>  			ret =3D hv_result_to_errno(status);
>  			break;
>  		}
> -
> -		done +=3D completed;
>  	}
>=20
>  	if (ret && done) {
> @@ -358,18 +361,18 @@ int hv_call_get_gpa_access_states(u64 partition_id,=
 u32 count, u64 gpa_base_pfn,
>=20
>  		status =3D hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep=
_count,
>  					     0, input_page, output_page);
> -		if (!hv_result_success(status)) {
> -			local_irq_restore(flags);
> -			break;
> -		}
>  		completed =3D hv_repcomp(status);
>  		for (i =3D 0; i < completed; ++i)
>  			states[i].as_uint8 =3D output_page[i].as_uint8;
>=20
>  		local_irq_restore(flags);
> +
>  		states +=3D completed;
>  		*written_total +=3D completed;
>  		remaining -=3D completed;
> +
> +		if (!hv_result_success(status))
> +			break;
>  	}
>=20
>  	return hv_result_to_errno(status);
> --
> 2.51.2.vfs.0.1
>=20

