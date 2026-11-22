Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795321502;
	b=N4H6BcwNu7e3lCOqnTokK0b3ES++SXb3ukkyGbIkY/qVna6hf9SFp7p+ewCux12nAEf5
	 lhPG+1vZm/x0aDkAeH1D590qMpG+xdGba2FO2YButRiCDIx5Z78Fy0ZbRfrA5F6G1rvl7
	 CJqNKJ1zf1qx4C+qbP32uU6Kxj9LeuQd7h93qrwu1jHL0U5Eoop2gPckk4M71RiFc2n0O
	 oFsK+gTFdpupvOldcriDlP6CFmulLP0CdahF+Z21uJmFMwsqenYzUX4WCzSurPRahjn0Y
	 6u7jEEqza1oPUuyiaCntqgUXcIMVeqPWh3drMsxM6J0GEbi8+ZhNvaBjrnkob1oPxwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321502;
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
	bh=Ot+1ML4xYQqq5sNemM0gQOyxLjw3qcFylCJhhhOt7zg=;
	b=UQp6DD4FDnoXr7x5V87Clh+10QWCJOAK4bUXFkcU14FeH1HNLx39gEXs+Liz17xtGv3u
	 qgywh7PgWCtBpTmVCKwDD0xIvADtHBXfzvy1GsjB1snEbQSY+2x2z9ib0Hp8gw0/z1Vgk
	 in69td1ix917q5ll2Thc1PD9HU9Jx5Je5y/VHhYWt2a8Bs7wiKNxc08At0gXv11v23/qs
	 BV06A9ySQcU8vDR5+feu5oI0RKRpmRftOjSQ5mLLoniY4VyYWmnMPiZ+1yLs1OyjX+NM4
	 Q0XF640tWNVRWwfBn9/eRVhVa8zJ/OAy4YJjKrIjj+pl4+v3JUHSQ5ZomlEQ1H008Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cv3BwsZZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.28
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010028.outbound.protection.outlook.com [52.103.23.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A98606A320;
	Sun, 22 Nov 2026 04:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A98606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cv3BwsZZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqxO+lhPFF4z16db2rF+As+Gz39ZNEHFbAZqqNFXnFrpCvECGJTfQafHpLkJTcCH81BFG4dFrog768S36GlOSnGvTTvRWQLFqOchYQKvbxhh0NlRjg3Qwk/pH9wHTGOcoQOQqroD9/izTQUT0tUclyd4TCCm7MFnen1WvmIidqyewMTGJje0anK3x8MgZOZYbL2fS0Bwpn7ejHXnyMN707RMsZs9YOS70SJ7TpT2pj3/OZjAouxxEUceEKi7FBDdGzp9dFbnARTRFIPP7rEZDQ8hWI/P8QFUPI0tBRO0Sdgm16+1pHqG8yR1qN6YbA3UKMgw1YnYFFWyFlOSHt+h6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot+1ML4xYQqq5sNemM0gQOyxLjw3qcFylCJhhhOt7zg=;
 b=xV4GniuxNXkmQp5QBUTVr1kIoH3gLNI0M03OUyfbur3OKuFOUun+8tRAyzWSyJd7PLd25dr41b9IV4j8slQ7tSvYd5wgnl4+q2vnJI3WMAVhe0qhP/cTUB9vHBd9prR8Aj69A6nq19APdi8FhJ0nqqC0TnJyedKo+yeKKIlnX69b3qLDtp5cvxTaMZPBkmkgHvZz4/2GpwQ43fGlmuk1yH8rwIiH2B9gZVrtTlFKsiMZ3uG2bcl1STcI94Cy6NW04KC0yve3QL6IN8tjEsTOGTWHAIQPySpFf3HMoTurmgbTrMILxT1LLMjYDa29kmnOGS5rBQXkDlam3kfXGBRYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot+1ML4xYQqq5sNemM0gQOyxLjw3qcFylCJhhhOt7zg=;
 b=cv3BwsZZN8IS5FTKGDdo1q/O8znIpXloIJ+k6If3y8XzaZWXsttosfdIaQsMQDxLcCgyz9fvXPxyTT5CUBmurFZ2SH66O/+jTh6MNC1KnUg4qQp4ICRJbgxZEDuwUh/CIESTsVPGqGGzdZNIDr8xrQcMRbxmJdjIkFuY7PV0c/+B+KLOZoe+n8nGr7UIbpgSsC5Lge5/7786OFSr73ChWVwGA5ZEr2/pdhMwQkX+LUqUs3S+LpD46SlcYbWfqp11FrAhk5CQHf+WAvh40Fzd8APvd8ldlEjJsSrJTkroqaJY0Q5DIs+C6qcqlrbzWkw3fPoRpiuRY4sJFbebNnX04w==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SAWPR02MB12044.namprd02.prod.outlook.com (2603:10b6:806:560::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sun, 22 Nov
 2026 04:25:00 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 04:24:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] mshv: Do pre-commit before mapping a guest VM GPA
Thread-Topic: [PATCH] mshv: Do pre-commit before mapping a guest VM GPA
Thread-Index: AQHdbmKE7xxxhaKqskqySaLCsuTBUbc5lhfQ
Date: Sun, 22 Nov 2026 04:24:59 +0000
Message-ID:
 <MN2PR02MB6863E6A55A9C64B4C30CAA2CD4462@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
In-Reply-To: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SAWPR02MB12044:EE_
x-ms-office365-filtering-correlation-id: 34f5095d-d1da-4901-76bd-08df48509222
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|31061999003|25010399006|51005399006|41001999006|8062599012|12121999013|8060799015|19110799012|13091999003|55001999006|24021099003|102099032|3412199025|440099028|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g0KX1KyKBBTUvt8cYFIIENjZtbzSuzAhoXUzdwX+Fg3Kz09YReL1AnTyh4d1?=
 =?us-ascii?Q?gFvEtiP6bxbv4prfMR1H9uMKG+8W6XrqLYQ3ncbuBSNQ0eBKRREVlLzQi8Eh?=
 =?us-ascii?Q?UvxPzv42p+qtZLodV4VBHGzsuTkO/UlSDnK1kmLEkgdpNtJQTiXtsQip8ksS?=
 =?us-ascii?Q?BnPoDgVfIEX3HJPc9s+RD07LfVChBPS4+8zgEbwOaKUjWxtJzWbIDUWg+4TS?=
 =?us-ascii?Q?LBzf3PC62Jdd4M8IEisxf2FZMYNnfxzhfGsDbF9t4PSf4cHkQbZTFWWqp8dU?=
 =?us-ascii?Q?eGd2i1DeUcN3AgfAobRnKaxNSan5B2FHNoanZfy11MrYQyHewsVEYHYPDRvx?=
 =?us-ascii?Q?cjtSGCVozX4Z7AzoNuvVmck8TWPih6cSzQUExf2QeAyXlDMlyqCRlxFb+/+W?=
 =?us-ascii?Q?l2vOkW8KNnII9GMpQnx87h/bhm+wc5UH2tYgBPJ1J77gBckgBA/K1wj3Clzq?=
 =?us-ascii?Q?ExzvcMsZ5AsYlQ5xEmGMrWfW3N2n8dH4809sToIMEyoQprA9WptK5ZDSS7I7?=
 =?us-ascii?Q?q1rdYz0TjeVCRsAu/CBJK4t/dLko2HhMOP4brak0InESrmDbAoORjy0lvzt/?=
 =?us-ascii?Q?IEUkgXAq6SbJxjmIqAv6eLL3dm/fKAh3lKPEP3UIfqKwaZmdjZlfYpCZIq5D?=
 =?us-ascii?Q?utXweeyvDawkBK1USQ0W7CNNM5+J/zE9arAR5nIK0mrQWbh1jn7pQk9q2SSs?=
 =?us-ascii?Q?6tzvF08Qj28ARIPSU6hRZ9mCu3D5KE4ca5MDYdFMLv2ke2v755vv01AAqtMY?=
 =?us-ascii?Q?MLpcRtY7C/3mnaK5sArtuFsF1dRjay8imH1SgsRtyhg5PHSMCT/KMyVH/7jG?=
 =?us-ascii?Q?0BBu6uVnrUA4qzZta2R/H8zDrPciN05qO9JJTYZA7dnaXn7K3EFs8eAtIDs2?=
 =?us-ascii?Q?oqwzHgqXFqMzBQ1o8rLB8N3NhV2rNOKGlknXwzAGAH3epZfiwSVgM7IvTnb7?=
 =?us-ascii?Q?lfOowxZoi2e51Fy9qkuqlYkBG8WPpFUuNKzF0URU0FhiGG4+3egboGglFTOO?=
 =?us-ascii?Q?xBpVEz8KACzrtWi37G0UTGMZ7YE0wNp39+psMB9FY8up6gBxDkrK06cU/yYN?=
 =?us-ascii?Q?+/6db2BysP2xcwg8s3FsIDiX8E6n2UETxGeUA6GNjRZrcNhslZZoHIsABrp+?=
 =?us-ascii?Q?XhsKP7X/V1Sr?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cWRVfHK7xegwxvwTAEKwpIlOwbtaSgEDf7DEJYx4jglVhRYoU+m+PCeWGxf9?=
 =?us-ascii?Q?HeGcZ3SNkDl9BwSdSc6cVheftbsPaPoeRd+nUSbokwcvwj0BOtFisc2oUang?=
 =?us-ascii?Q?g0eZyBT22w3Hv3K4QziHLiTva8gzuUiZjAfc7NiLI839zeC3bADU+WZXFlad?=
 =?us-ascii?Q?EssmA6UzhA5GfaWScvVPzjEW7TVQJC07FkWifBZJlCzmlr8eMb0i0nV9hmlN?=
 =?us-ascii?Q?AjkRZroRmmPvkNitl9L5CzwlzROQeklGxMFE7QuLQ4GmEglUolU6RnAoim+q?=
 =?us-ascii?Q?RRgTKabFJDbYGa9qtDkKA6CQYvZx8Kt9xrLXiEzqTGT/AMGPKSKQSiiZkNwv?=
 =?us-ascii?Q?qA4VdFiOJ3wlpdb61NLoWjp1V3fe9CBcOf3G+M+3SPTKJnQ9TTS0i8Fpo6Zj?=
 =?us-ascii?Q?w55fAr8CXQ64lVAGOo5UR1kzI7SV8pwW0ToNiQBdM1gL55QcxSHSWjp/l8wF?=
 =?us-ascii?Q?sit9/LKmnih5oNTDrBidLZZx+d2pOOQAL6pgvUEkQnABitZrgFQommMxi6dN?=
 =?us-ascii?Q?nv9SL5ySFciKZLn8RWzb3ytfBYQwFX00F6RV4IjtMZnTAh0peu1WNsBKVgp4?=
 =?us-ascii?Q?EPioHIqYOkpmJstl2womqpRdFcMHPxk9RcFnuKd5XavmTFim7iw7eNIIljAM?=
 =?us-ascii?Q?NGAui6MJxiut2Wd30KjfrI+sDnyMZv1YdKWmjl1nlPu3v9vugHRtBXEVgJYD?=
 =?us-ascii?Q?pdEhxm2Kox19HOHjLzj29Gg9tUSOO3HQO762ErY/qrt2/hDloWf9KDT4AtTj?=
 =?us-ascii?Q?i4MZ7EntkqTQdwQDUr8/flWaD55lof5C6xt/9igPW0IH9377pb8hB26L2Vcz?=
 =?us-ascii?Q?jUk3ao7dQU8WbSNb3mGGCp2cuX8SWgcpnfX8v4UhwTy4IElEvBvdUYE17STC?=
 =?us-ascii?Q?72UxL74K1nh4c2POWMydr/bVTnYq95DqAvnUNgusi1TOopOtVT7l+fcpMfiQ?=
 =?us-ascii?Q?6LKR16zGgeWLpwMXsAQZ4PQmlB2hw34m64pM9FSkx1TPL2XaudE17vkl+Zxm?=
 =?us-ascii?Q?oYhFb+Z63z1OmVK4Puc+n4QIR958f12uiXrvfBUnzpINCFPJCMJhuORvEyao?=
 =?us-ascii?Q?bAvu+/zlop7ns/b6iFfLMxK3JlE1msMF3pxqDLdrZiWo31L9GbZ7Jq7xOUiY?=
 =?us-ascii?Q?UyFrjDKS9zMG/7qMblLhpiJM/QGiv/IQy3mTq6kFaCBSQD8Lmmq+Cnska2+o?=
 =?us-ascii?Q?x+tRdOTKw/DMKwSwnoYYkmSGD/pXaHN+/bwMf0LlQbmgkiktfs/a6Vq6n+5i?=
 =?us-ascii?Q?NObdC4jifPnLuHc8XluKpQNTrct5Gw+bpQVbKH0rp/7hotSO4UvkIoVU3NMD?=
 =?us-ascii?Q?wusCBlQA8j0eT0t1uohqw+3q+/QHSnx1Y4BiDOyn7MwvXQpLqbR79HWkWUbE?=
 =?us-ascii?Q?g64Jo2c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f5095d-d1da-4901-76bd-08df48509222
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 04:24:59.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB12044

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, November 6, 2026=
 6:49 PM
>=20
> Pre commit reduces TLB flush overheads in the hypervisor. On systems
> with large number of CPUs, there is signficant advantage to doing
> this. Pre-commit allows the hypervisor to build all data structs needed
> in anticipation of the map gpa hypercall, thus reducing or eliminating
> deposit page returns from the map gpa hypercall, and as a result reducing
> TLB flushes. In some performance benchmarks, it made the maps of large
> ranges almost 30% faster.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 52 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  3 ++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk.h         |  7 +++++
>  4 files changed, 63 insertions(+)
>=20
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index bf0f90515dad..5c44ba8f72b0 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -181,6 +181,54 @@ int hv_call_delete_partition(u64 partition_id)
>  	return hv_result_to_errno(status);
>  }
>=20
> +/*
> + * Pre commit to reduce TLB flush overheads in the hypervisor. On system=
s with
> + * large CPUs, there is signficant advantage to doing this. Pre-commit a=
llows
> + * the hypervisor to build all data structs needed in anticipation of th=
e map
> + * gpa hypercall, thus reducing or eliminating deposit page returns from=
 the
> + * map gpa hypercall, and as a result reducing TLB flushes.
> + */
> +static int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages)
> +{
> +	ulong irq_flags;
> +	struct hv_input_precommit_gpa_pages *input_page;
> +	int rc =3D 0;
> +	u64 status, done =3D 0;
> +
> +	while (done < num_pages) {
> +		u16 rep_count =3D min(num_pages - done, HV_REP_COUNT_MAX);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input_page, 0, sizeof(*input_page));
> +
> +		input_page->partition_id =3D pt_id;
> +		input_page->target_gpa_base =3D gfn;
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_PRECOMMIT_GPA_PAGES,
> +					     rep_count, 0, input_page, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		done +=3D hv_repcomp(status);
> +		gfn +=3D hv_repcomp(status);
> +
> +		if (hv_result_needs_memory(status)) {
> +			rc =3D hv_deposit_memory(pt_id, status);
> +			if (rc)
> +				break;
> +
> +		} else if (!hv_result_success(status)) {
> +			pr_err("%s: failed to pre commit for gfn %#llx done %llu/%llu, status=
=3D%#llx (%s)\n",
> +			       __func__, gfn, done, num_pages, status,
> +			       hv_result_to_string(hv_result(status)));
> +			rc =3D hv_result_to_errno(status);
> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  /* Ask the hypervisor to map guest ram pages or the guest mmio space */
>  static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
>  			       u32 flags, struct page **pages, u64 mmio_spa)
> @@ -205,6 +253,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64=
 gfn, u64 page_struct_count,
>  		page_count >>=3D large_shift;
>  	}
>=20
> +	ret =3D hv_pre_commit_gpa(partition_id, gfn, page_struct_count);
> +	if (ret)
> +		return ret;
> +

The pre-commit call uses the original GFN and page struct count, so
evidently the pre-commit functionality in the hypervisor does not need
to know if the follow-on MAP_GPA_PAGES hypercall will be specifying
large pages. I don't know anything about the pre-commit functionality,
but my guess would have been that it is allocating page table pages, and
that the large page flag would let it know that only PMD level is needed.
Do you know those details?  Just curious ....

>  	while (done < page_count) {
>  		ulong i, completed, remain =3D page_count - done;
>  		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 4c9f3353074a..a3d497d99b0b 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> +#define HV_REP_COUNT_MAX        \
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
> +
>  enum hv_partition_type {
>  	HV_PARTITION_TYPE_GUEST,
>  	HV_PARTITION_TYPE_ROOT,
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 966945f0504f..16c41ee5079a 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -489,6 +489,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
>  #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
> +#define HVCALL_PRECOMMIT_GPA_PAGES			0x00be
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 0c89c62c9706..3944e51d0a2d 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -953,4 +953,11 @@ struct hv_input_modify_sparse_spa_page_host_access {
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
>=20
> +struct hv_input_precommit_gpa_pages {	/*
> HV_INPUT_PRECOMMIT_GPA_PAGES */
> +	u64 partition_id;
> +	u32 flags;
> +	u32 reserved;
> +	u64 target_gpa_base;
> +} __packed;

Does Windows put this struct in hvhdk.h? Its close relative from
a functional standpoint, struct hv_input_map_gpa_pages, is in
hvhdk_mini.h, so that would seem to be a more natural place for
this. But I never have understood the criteria for being in one vs.
the other.

Michael
