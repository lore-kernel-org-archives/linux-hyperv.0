Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794786495;
	b=y03Hm68Kji7WPWEYGp4AL0PrF66gT/q3u9iGX3lcN9+CCIXTLoGxrBmgCNiMRaVhFyQL
	 pQCAFCA6SqSpLHSzdA5RkMMPdh7tsLKsDJrSlsLlvndXOFhTxYhSrnSta+6CH8il+MJPX
	 /eBQgNu6R7c9lBKJ2EpOJ/K6ObTXCnfzQp4lUyRWyIuZP6MbSSxtD/kydo/0hzQs6N8l6
	 QI4FPks1x2kLUHD3fBuAPOwiIta7ibuIN2P45I2qIn0i9Rv/OMkpEYwfEWMUuYF1yw2xP
	 dJZLZ0GD5iav/bCgi3HyVAdAYiYP5s9mKchfGARMnHRTp7H4LEXiOLoKU667ZVFh1Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786495;
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
	bh=3v4ftb07RcMZhmM1Bb8ufeqs6Ajvk6PcnuTFHaHjTc4=;
	b=RCsvPa6pgrnKMVQ0dEf7FndT2dlQ+LtsptEU3evWjZV8jOIogyXV4obtp4MOHucxGpr2
	 1U6Cn2I6jsOoWdzvrkdff3P6KGY6o1OBG3lph7GZEH5AlPh5KSGAFuXEavrgb9IwncEeG
	 nr8/46KsE84hequXEk6dNHOzMTA4Sy8Lv7Ex1fzNkpfwoTgB5EoAbzKbF9CFUdzO3fjCj
	 Q4NTCpxDAboArYoUIJZnK7iecpDlUqX5uM5bEabQ1k3fgCSZ0A8MLZk81rkodvnNsGGqN
	 QIAO49Gj1LKIcTIkQsTypBAogvf2QUqgI4VBYV4Xt01DtBfUrVmsff2xpITOBlRLfWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bIMaJ4Du;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.35
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD5606A880;
	Sun, 15 Nov 2026 23:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBFD5606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bIMaJ4Du
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbu06W/h5OrfsHaYddprSFqjYF1SssPAcxrBrosR3Zf3fTC6rjdwZY0EPuqqTg+kOS0HC5wGLD8QYRDCvsdGhkhigN6pXbsLcvDJSJ2C+KSLFfmGtzfG7ThtewtstpK236nsIp0CnczrP8Fco2A99YyF4ad/Q95ktnhuz1Hw+HLiH/KZf6geTTBmUJvKrEP/9pzo+LK/f6/z6nqnINfVIf25ITFRRNHPnvZzMg4gDwnDQdgm4jDgaNNOUO0zLpYuvC14QDOkTltV99Hg7p0mt0V3RFSWQW8+aAGYvXQXk+dQk4WvVYWOn69V1FM/t9dubgJnJww5yk1dFZrGhnEXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v4ftb07RcMZhmM1Bb8ufeqs6Ajvk6PcnuTFHaHjTc4=;
 b=Ix9rSyuL6wGwzamE3hwnX3F/KK2GOzQgE0/7N5CN91fs7zMzI4/DN4y8Y3ig7iBQDpCu3n2vCdeVIaTkYXxyB0EjPpSdFM5kuQxoFzaP3/sUNrLFd1D3aCLhSgztn3wjk1NcI2P65xPEgiLpygiD4c9qX+dEB7J93K0aCqmWshfZXzp/tEARvDsnFIS8bWIZ7ahv86vWDIZWYSnUsD+v6ZWAH23F4v5Tb/YEm1aHyeKE6sLXikRTxmn7HoVFF7YH0Yrf5LIth/KMhnLw1GXyAFz+MPKMBi87i8xwQnn4pEyobHdoR8LcZSXw/B+4jH0pUn4CYsDoQ4lwT8UQCkSJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v4ftb07RcMZhmM1Bb8ufeqs6Ajvk6PcnuTFHaHjTc4=;
 b=bIMaJ4DuLsu+rHjXryfC416fNx94JmF9yvoBxbQT2AB1xSJfblm88tADwo87jJP7Np/GizDKMFM2+ELsg0OwC5xIDgejbxnKomr2AZroyFBel+L/3zdvoiXeBuErNSvWar48L0fK0PBmnEHngLrPeKqprf53s0zoVTRVevbMTV4ls3o4CviZ3CXuqZTvDdWvK3CJNE/pLn8/lgzXuQL4x8JYzohsUwHxvp/wzkv5FgALHy7+DvawGxGgBxZgOp4ZRFkJOeDtvZ0BF4JcCrUsE8fomTpKbG29wQNx8EUGtIijNGgQB2gJvD8I8XDTQLkHDkjkNr75gIaVpvJ+BTd2eQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DS4PR02MB687320.namprd02.prod.outlook.com (2603:10b6:8:4f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 23:48:10 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 23:48:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Thread-Topic: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Thread-Index: AQHdc+NRSu3oKf9nNkmCF7w/x48KTbcvz73w
Date: Sun, 15 Nov 2026 23:48:09 +0000
Message-ID:
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
In-Reply-To: <20261114025313.1257042-3-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DS4PR02MB687320:EE_
x-ms-office365-filtering-correlation-id: 365ba09b-ec01-4ae1-4af4-08df4372e799
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|13091999003|24021099003|31061999003|37011999003|55001999006|15080799012|41001999006|51005399006|19110799012|8060799015|8062599012|25010399006|10035399007|40105399003|102099032|56899033|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5xSxQ/htb0AwDosJMNsGxyQ0nzgUOHjE5Ob4QPMVPf3qWgT0cH/OddL0XSiN?=
 =?us-ascii?Q?f/UNz442RafqKNHJpz70zDhckGXOwg4QWgkmVJZxh/8uFOAJZDBqyBVxtBBo?=
 =?us-ascii?Q?eCbiC6un5VoUlZCIaMGhsQ5zvLifn9zcMy5x/9swoC2sDRRCd75dlaG4yE+l?=
 =?us-ascii?Q?f7tvUAVrsRp1WCxWwUzfib+wPNjqGq/C9x/SwgHMOxlqPsRH1vkygBSDtPO4?=
 =?us-ascii?Q?2fM2niV26j2p79nM3nG8r0AsYUnMp4v/Uy2RQ8fvP5TBi/gnlE2quYQ+q2gC?=
 =?us-ascii?Q?pyKODs8cyZJKnHFqilMxvfVgR+z6DTryJER1RU7RjHOCbDYRHZfkCV87NLPO?=
 =?us-ascii?Q?AtMvW+NrFDuGYY1mvA0seniKmhrKa3TLKx4aGkugYWc9sWLAWE4ETyrxtHRf?=
 =?us-ascii?Q?Jc1HnSoy9rDT5ksDpRajBRPb4h/RQU2NfDxfgXWraL0DuZHDRHpiikL+dfAW?=
 =?us-ascii?Q?spDSRkwzzU223Sp0SKgR2f5FisBqhSFCwHxukAXsrdyFmuU46oYWVyXceh1L?=
 =?us-ascii?Q?aCL4+eQifv/rqyACfeefT674HIdqDlR2NaPEqt//qMQaE16a0bIzv2RK8/t2?=
 =?us-ascii?Q?yv9f6n554jX36iYbt2ylV9ZVgaiID38IvA7qFs4nM/brRkSyEbPbBP2rdubX?=
 =?us-ascii?Q?VK9qQgVcp1n9XinwjcpZXiJtQyOT1xifbaAXE3mABp6Uq0Oj7jiLTVKf/NIv?=
 =?us-ascii?Q?yZfrMG4t1z+pRRvva6HZ8SFPFO1Wfq45ndr0APo2unjHHqIvwHTeXWLwsemk?=
 =?us-ascii?Q?Oy5W+uvWk4CcP79jVSjvkeOysKUM8TxYVqxC6yI9XEXWsw+bGV4soijR4j4p?=
 =?us-ascii?Q?G+/hfUODI38alsuNFoqzsd4vywH4BUCk+MTAIKKgZWhe4RzrPby42nTjvTw7?=
 =?us-ascii?Q?AIJ6vMFiZOC56Pc0wVb98ecZZq4bQwKmUUocfXMwiyd7Ay8TP7ORcd9fAhn1?=
 =?us-ascii?Q?/i/xNwYNrsLbvExLhE7impahjZN8h8tzSJ8ShzazA313Th7c/WfszldwL9IB?=
 =?us-ascii?Q?G2GLwNLqHnQnqcWjukJIulbMNH79Ytkz465zuZmYeiJxmy4X3xsYlzOeeoVU?=
 =?us-ascii?Q?49M3GRolTtlLlrQgwvAKIDCGO/wO+g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nQv+92q/hRaEgVcn0oawyMzP7UAUfQWUbpNXTpoji+SvnNGzTxm4rbtr6Oa0?=
 =?us-ascii?Q?iOWmvPbbJJvSsMsM66q22eEP3CmAOw1idRVo0rDsHpquQn9Y/Sl6x3iLCLjX?=
 =?us-ascii?Q?jBKH9fYfWxTKYFmbBpWD/btAuTRZkSOjA8C6O12mX/l6noAFi7tqN+pSWwhT?=
 =?us-ascii?Q?cDl37TVpa5p04Tlgr/6XBMERJcslIDpGzZBZ5iaLv1tbigLrf3V/fEuRGbOo?=
 =?us-ascii?Q?r3P2TTnvZlGehkavMaWQH9qKZKm8mV1o57WAU4I/Ey2rOAUyAHds8DJH27zW?=
 =?us-ascii?Q?O7p0Dy913xpGSLSuGaSXsx0q6eSYn5Mni820T++OYX48zKo8NNq4M/yvmJLV?=
 =?us-ascii?Q?3XY1sbsIEamuKex1BP01yZGOuMZanrzJQ/hArCt0C0h5AzJwfQSsuwQLNmd/?=
 =?us-ascii?Q?YMOXl1b3Pwtru6xpCXQjEXDIK5DW1JxosAe2CIKPHirIJtGbxrytO4mU0tHh?=
 =?us-ascii?Q?xebJNF85FppKW9EfeV1qfrIls9lzhNRZCEPh5x1tP70C+bCDWdvkZef7UMWK?=
 =?us-ascii?Q?U9vSPBloJK0PrmzqgmpJL1ida/J009VQ1vy6R+4/rWDKkNfYGFGES6QVdL2F?=
 =?us-ascii?Q?dQDT49kO/cMTWHIRJcngG7ugHhytw/xQI/AOSVIQHrzG0QDAnrJa80bqZmSS?=
 =?us-ascii?Q?qcK2c26KHUz3ZmDIhenVVM1rJ89muJICfd/bf3SZAZodTsGVMM8EQ8I7tOKM?=
 =?us-ascii?Q?uRt3ly6roHdXLkmr7wwGOB5kId1y8c1tTiwIemM3ReZdZOI3yHLz17RqOW52?=
 =?us-ascii?Q?wqyOBPbhvTVxCNNzaN2P8Y9Jg4+5rOyLi6GKUfOruImP8lxigyfmnBR3Ygl4?=
 =?us-ascii?Q?cSenjmKMysnWUgMWWT7Q32Zla/f49WVh1JeDlPaz0HUsBd1YbibZEF5IywrU?=
 =?us-ascii?Q?9NL0nRS/pUoIAGfc8ZwKO/mOjnyA8RAiRlDUh192NUW8LaooZLwn1J5XVCSv?=
 =?us-ascii?Q?tjpIO28Ofnl00R5Amwq0wZEJCjRlM1hTrQBLv89d6+XGbLCbyhMomLZ8W9nO?=
 =?us-ascii?Q?pxPkvmM29dOfpe9k6M0bNVJd46Ksd7YHsfMZ/RqVjj+rjuOEg+sm6bTgCHTC?=
 =?us-ascii?Q?5sY/kYcV/TY1gTjyALGWUFcxArbeYf54zuZF8iv/NsjRtdofCXE3NHeEl+SR?=
 =?us-ascii?Q?Gmxaf9GEOnpiXXg3paO55zKlkuaaLYoNnGGqbMLj1lSxpirh5eJv3sxRBSP8?=
 =?us-ascii?Q?6LviZe0l3RL+KOxGZLdOGP/DULy3d6C6n8MpyFr7wgwNHgTmvA+VDi/m1KQS?=
 =?us-ascii?Q?nm3iERXfN0sU8I/r3tRMyjYsBty22YpwAZmLxG8a6bqvT5Dc7PJ1T5kz0buX?=
 =?us-ascii?Q?xwyiCOzzW7kdLuCYfY6Vkts1VtXpYUdeuUa/1OjcpfdQiYG+z9//f1axs2U9?=
 =?us-ascii?Q?jrDPSsc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 365ba09b-ec01-4ae1-4af4-08df4372e799
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2026 23:48:10.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB687320

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, November 13, 202=
6 6:53 PM
>=20
> There are few issues/bugs around repeat hypercall:
>  o If the hypercall fails, it could still have processed some entries.
>    Fix places where it assumes none of the entries were processed and wil=
l
>    try to undo entries already processed or print incorrect completions.
>=20
>  o Hypercall returns back with timeouts only for HW confidential VMs. In
>    that case it should be retried instead of returning back. Returning ba=
ck
>    results in error conditions and take down of VMs in most cases.
>=20
>  o For non confidential VMs, the hypercall could be streamlined as it wil=
l
>    never return back with timeouts.
>=20
>  o Rename HV_STATUS_TIME_OUT to HV_STATUS_TIMEOUT to match hypervisor
>    public header file. There is no reason for it to be different.
>=20
>  o Minor formatting fix for checkpatch. Error printing missing in couple
>    places when rep hypercall fails.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

[snip]

> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 396bcb3db0bc..87c784b9daa6 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> +#define HV_REP_COUNT_MAX	\
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)

Sashiko noted that this new #define is never used anywhere.

> +
>  enum hv_partition_type {
>  	HV_PARTITION_TYPE_GUEST,
>  	HV_PARTITION_TYPE_ROOT,
> @@ -128,6 +131,11 @@ static inline bool hv_result_success(u64 status)
>  	return hv_result(status) =3D=3D HV_STATUS_SUCCESS;
>  }
>=20
> +static inline bool hv_result_timeout(u64 status)
> +{
> +	return hv_result(status) =3D=3D HV_STATUS_TIMEOUT;
> +}
> +
>  static inline unsigned int hv_repcomp(u64 status)
>  {
>  	/* Bits [43:32] of status have 'Reps completed' data. */
> @@ -135,45 +143,63 @@ static inline unsigned int hv_repcomp(u64 status)
>  			 HV_HYPERCALL_REP_COMP_OFFSET;
>  }
>=20
> -/*
> - * Rep hypercalls. Callers of this functions are supposed to ensure that
> - * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
> - * definition.
> - */
> -static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
> -					 u16 varhead_size, u16 rep_start,
> -					 void *input, void *output)
> +static inline u64 hv_do_rep_hypercall_reg(u16 code, u16 rep_count,
> +					  u16 varhead_size, u16 rep_start,
> +					  void *input, void *output)
>  {
>  	u64 control =3D code;
> -	u64 status;
> -	u16 rep_comp;
>=20
>  	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>  	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>  	control |=3D (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
>=20
> -	do {

Dropped the looping behavior here may be much more significant
than just "streamlining" as described in the commit message. The looping
behavior was included when rep hypercalls were originally added in
commit 806c89273bab in kernel 4.14, long before any SNP/TDX/CCA
functionality was added. So it was present for "normal" VMs doing
hypercalls on x86/x64 the normal way. The looping ensured that
rep hypercalls could not return with no errors but with the completed
rep count less than the requested rep count.

However, in my mind it *is* debatable whether that scenario could
ever occur. The Hyper-V TLFS describes "Hypercall Continuation" [1]
as essentially transparent to the caller. If a rep hypercall stops
processing reps because of hitting the 50 microsecond time limit,
it should restart and continue with the next set of reps without
the caller having to loop. Commit 806c89273bab mentions
hypercall continuation, but does not describe why the explicit
looping was added or how that aligns with the TLFS statements.
Vitaly -- it was a long time ago, but do you have any recollection?

Have you gotten an explicit assurance from the Hyper-V team
that the transparent hypercall continuation really does work,
and the explicit looping has all along been unnecessary? This
assurance would be needed back to and including Windows
Server 2016, which is now the oldest Hyper-V version supported
by Linux. Also note that the rep hypercall code is architecture
independent, so the transparent hypercall continuation would
also need to work on arm64 when the hypercall is invoked via
the standard path of using the HVC instruction (the TLFS doesn't
cover arm64, so this is unclear).

If you have such assurance, then I'm good with the removal of
the looping. But please make the removal a separate patch, with
sufficient discussion in the commit message to justify why it's OK
to do the removal (including that evidently the original commit
misinterpreted how continuation worked). And instead of looping,
perhaps do a sanity check that the completed rep count matches
the requested rep count.

Without such assurance, I think the looping needs to stay. Callers
are not prepared for a rep hypercall to return with no errors, but
with the completed rep count less than the requested rep count.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlf=
s/hypercall-interface#hypercall-continuation

> +	return hv_do_hypercall(control, input, output);
> +}
> +
> +static inline u64 hv_do_rep_hypercall_cvm(u16 code, u16 rep_count,
> +					  u16 varhead_size, u16 rep_start,
> +					  void *input, void *output)
> +{
> +	u64 status, control =3D code;
> +	u16 rep_comp =3D 0;
> +
> +	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> +	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> +	control |=3D (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
> +
> +	for (;;) {
>  		status =3D hv_do_hypercall(control, input, output);
> -		if (!hv_result_success(status))
> +
> +		if (!hv_result_timeout(status))
>  			return status;
>=20
>  		rep_comp =3D hv_repcomp(status);
> -
>  		control &=3D ~HV_HYPERCALL_REP_START_MASK;
>  		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
>=20
>  		touch_nmi_watchdog();
> -	} while (rep_comp < rep_count);
> +	}
>=20
>  	return status;

And Sashiko noted that this "return status" is dead code. The only
way to exit this function is via the "return status" up in the loop.

>  }
>=20
> -/* For the typical case where rep_start is 0 */
> +/*
> + * Rep hypercalls for HW confidential VMs return back when timeouts occu=
r,
> + * whereas for regular VMs they return only on success or failure. In ca=
se
> + * of successful completion, entire rep_count is done. But a hypercall c=
ould
> + * fail with partial completions, hence callers must always check that
> + * in case of failure. Lastly, a rep_count value of 0 is allowed for som=
e
> + * hypercalls.
> + */
>  static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhe=
ad_size,
>  				      void *input, void *output)
>  {
> -	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
> -				      input, output);
> +	if (hv_isolation_type_hw())

I don't think this is the right test, so let me explain. You don't describe=
 the
context for when HV_STATUS_TIMEOUT may be returned, and there's no
TLFS documentation of this status, but I'm assuming the context is hypercal=
l
continuation. This isn't the typical "something isn't responding" timeout. =
I
suspect it means the hypervisor hit the 50 us limit, and returned to the gu=
est
VM with some reps still to be done. In a normal VM when a hypercall is
initiated by the hypercall page on x86/x64 or the HVC instruction on arm64,
the transparent hypercall continuation mechanism makes a TIMEOUT status
unnecessary. But with SNP, TDX, and CCA, hypercall invocation may be
piggybacked on other transports, and transparent continuation isn't availab=
le.
So Hyper-V returns HV_STATUS_TIMEOUT with the expectation that the
invoking code will loop to do the remaining reps.

The key factor is whether the hypercall is piggybacked on other transports.
The tests in hv_isolation_type_hw() don't capture that. For example, if
a paravisor is present, hv_isolation_type_snp() will return "true" even
though hypercalls are invoked via the standard x86/x64 hypercall page.
The hypercalls trap to the paravisor. If the paravisor is functioning prope=
rly,
it should do transparent hypercall continuation just like the hypervisor wo=
uld.
But this is something to be confirmed with the hypervisor and paravisor tea=
ms.

Piggybacking is done only when no paravisor is present, so the
hv_do_rep_hypercall_cvm() path should be taken only in that circumstance.
Your current code works, but it goes down the more expensive
hv_do_rep_hypercall_cvm() path when it doesn't need to. (I'm not completely
clear on how arm64 works with and without a paravisor, so my statement
applies only to SNP and TDX. Need to sort out the CCA case with Kameron.)

Given the non-trivial complexity in sorting all this out, I wonder if
distinguishing the _cvm and _reg cases is really worth it. The current
code for the _reg case is admittedly inefficient because it does work for
the looping case before likely deciding that no looping is needed. But
that could easily be fixed. When no looping is necessary, which is the
vast majority of cases, the looping code could end up being only a
couple of instructions slower than a separately coded non-looping
version (I did some builds and looked at the generated code). Since
there's overhead in deciding which to use, there may not be any
performance win from having both versions.

Michael
=20
> +		return hv_do_rep_hypercall_cvm(code, rep_count, varhead_size, 0,
> +					       input, output);
> +	else
> +		return hv_do_rep_hypercall_reg(code, rep_count, varhead_size, 0,
> +					       input, output);
>  }
>=20
