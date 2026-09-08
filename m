Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5D5448BD;
	Tue,  8 Sep 2026 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890584; cv=fail; b=nw3yvH3US0O4HZnpvAFbXSnEdJVhLZua/UmivJF3qK9TnztXZLWdebNSC7Un8MM5S4V55nrQ7V2YLe6D/tXf9S/iLaJX1Dx6xUBHlwSBWgldC1ydEeGTS8vy3eHGHzG0f4rRprh2b8LO3buysQGf/jFA66sf8sBaS3HzyghAxbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890584; c=relaxed/simple;
	bh=4zZk6RoeY9FzGJOzKHFvFV78RU4VsZk+g0B6oLBaHN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxM/s2+h9E0LTtiYY4SW+3NkueG0LQCtGF0hN1Im7s1iJalNdCQ/7xyFkvDXOA049NM925h70Rer4CuF+P7OJnwa3e1XdlX0mqs9oy0UYZeeW0SI4w5VCTXXKHfK/BeIP+0SCwQQomU5v7tFNgDvncJWz5siYztFfI7IDPK53Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CZB1yJJv; arc=fail smtp.client-ip=52.103.13.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CZB1yJJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7t0MX9uE8c36vMndzpXwjgsI0m1jQ6Vqos0Ig3rh3/SL33oOiz0JTxxIxL5UMTtl1P/Sh0NmoBH/O+MbOI8RM+u4/JBpZLD71ZlCjNvfjpYZsof6VwcdNqGPhi96n2Ok7CJB1kj8OhUrSeKrPp10kHysTMp5/HAa0lgqBVjYMlyjoiDkoU4HqrPdYRpdjGZDCBFYa/wNbNuwk5C7nOJjktnROWCux484ARcnF1/Y1Cp8rXmtEI3QtL24vaWvQCMzuyu79OBbH1j/I714a//DYInMGw5lbpLdmtHfCLkX29NUG+KBrVgsxfWG3JnQoa2G6GRB/NG1AnuYD/w3BlddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reNk9nxo5M9D8KfMNbtR2GZ81gsgK1PpzBT6Jh2w04A=;
 b=sXCOYHQCzO0Nw9feHq4gjM4HISZB1i7sx/akvavDccKMjdNcg+hLEwHBUfzBFsf7N3f9ceBfmCtaafwsLP7ukNRH6/tWSH3D+cR/e3cEW2bSSLlZXxq7hzqH9P61xEg12C1c4wupq61r6Dm0oYmNpdYXf2Zhja9Xdh2SQg8wbmZkvtR6sVX5T3eCR22b2q7vp0G5mnoNRgj/nyiXibPE0J3kl4IlDrRxRIDiLV/h41yg7SxK83rdsaE9vaDKvO6xDranXsmiU9jIAKm3S1yBWcf2YNlh74zx6TCiXHPWKezJdRO/YhG3cXjLfHQAuMqm+630jgUnPkvIhOChbnYVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reNk9nxo5M9D8KfMNbtR2GZ81gsgK1PpzBT6Jh2w04A=;
 b=CZB1yJJvnJJqkS6RLA12GZ2NWS2EwD884Z46sgIhzAqsXMHDzIC48r7uSTNgr3qe3BpImG7tZu823jci/F3JvRqKsuPAAtK0mDVQtiZojaWAPZqLDTrgfHs1eRy/7ylmB8z5mXsdAFt+I5X7VniRL/TyJMd5iNfRvm8XLwXcZiwhYvqm0EYCyw8xyW4BE7VqaIoec0dcMr8FmG+MpLkuezkCQetrA5vts/eHk72ybI2Irh3DFKhXDtJ33G/geZEGSf+Hi9y5bWrz3lUXcse4Du4MEtQikiRRAwE4byAdx+scFYDF92xCgbzQnogF2KGCSsIi5f74ue1qjf56o/o8Vw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV2PR02MB11153.namprd02.prod.outlook.com (2603:10b6:408:34c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:02:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:02:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH V1 2/3] mshv: Redesign hypervisor memory deposit logic
Thread-Topic: [PATCH V1 2/3] mshv: Redesign hypervisor memory deposit logic
Thread-Index: AQHdPze4UOAVldAj6E+TOUlSti9vk7bE+h0g
Date: Tue, 8 Sep 2026 18:02:57 +0000
Message-ID:
 <SN6PR02MB4157AB63EF3BA9E3BC560E19D4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
 <20260908021340.2548924-3-mrathor@linux.microsoft.com>
In-Reply-To: <20260908021340.2548924-3-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV2PR02MB11153:EE_
x-ms-office365-filtering-correlation-id: b7edec0c-e7ae-4d7c-8fda-08df0dd369be
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd/ur0QDa6YmBjuOVf78JKonIb7RV5ngpeVYgWCNN4KNJlRYo3K4eHW8WCWnmr7XE9G9dHcH+Yhuvml8/OXf0Iue8O26aiB9l0e5xf86DywH3KT7chU35ex1e0SxBJp54UJSFn/fYtPfRelddq2lAm1u8CmLKsDpDf3xFaxyoJmevAWavvQETVrao8hLCjkaIzo5x7ZnfTGOZ7trh8w8uoKixWixkV7a/rmu9Ms5+R2v/TaPJPRf03cgwqVxYF0QfYv+8fpUnmtmNv7T539zfcvHxk1U3klkOdll/LBTmFJcHLVEJhfeShqPs99pLlDU0UAy635dsHvYNpkt7Zgf6fiXNk+MsuxFHCyaWUBusuymDhAfWlVKbDWqtQTV9TM+5RmmTsW/bJtSvGMrW25H72R3EJIX6GB+S0j9Kbvt5EbEL4if7FkiVYw2eur67Duaw47d+/z4TkvB1BjGLvexgFf+djvl5v9hsy9AgDoRIhZzqq7zSBx9DQvtNjTp5MStubN+MTjXe0ibf802rhWqLp02UXvAQggTJW9K85ilc70N2bF8ZNtPSbtR3BDbAzkAdslnVWzQiax0VvauxuLR92lSTBoQXYyhWCG+eH0csj/SVpsVvCMnoyyjYPsD3roULFyuSVHzENdjyOEhN4BjCXy16/slRlZDXcR0m8gSzAg1mg2ox8XsjtZzxkLNtYrQX9xEoxLvFrjDL8fCgqEl/9sCb58m0LJ3D5hftCdrL3ObfzTl/AaG9Xy1zfw+jgW25XfwdpcnMBbn2m8w/HBGY/kzt7NzyjfJIiLcCYWg+4zasA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|37011999003|11091999009|25010399006|19110799012|8062599012|8060799015|12121999013|15080799012|24021099003|55001999006|2604032031799003|51005399006|31061999003|13091999003|56899033|4302099013|440099028|3412199025|102099032|1602099012|40105399003|12091999003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M8loLB1yrBMs+L+g3TH/+D+T0cZfQ3RDrUPTWmNty13r+mdDBSmSCTR/miNi?=
 =?us-ascii?Q?dhffu6tkHQ5GYPZVnAQeXeb3aBAMHTNcbv0a2mSL83MA7QWTrawBcptJWeaC?=
 =?us-ascii?Q?7nZ/WSMHB5b4ElKi4FkmDWB0J2Fa9P7EvyNUn639d46ySYHENgJj6mCTj5Eu?=
 =?us-ascii?Q?pHG8GzperCtGerunDni/cjdKaE4ggHS1+9hb60RCUxT0JJchTMC3QXlDgR5W?=
 =?us-ascii?Q?/7KXLzjsL42qUZn/LLh8n9uZQQ/tWWdUl+XtfOP4jdusDLnKwiT84i7hNFUU?=
 =?us-ascii?Q?2f49agihV+0HUYXerHyH1JM5DzpZbecsYI8T7vQdJVJI6LyTK9L6q3L8i7WZ?=
 =?us-ascii?Q?B3Iwk+hDV6m8bGzl3QTJR7b11VHG5HnTGckPlpE8fKOJNkxrka3egKgSC53Z?=
 =?us-ascii?Q?2jrBsSbpIX8tSpY2YchB56H2SgH92BYRH7amZ0phB0uG4L9zeqS5dFvp2Fup?=
 =?us-ascii?Q?zc5AK5eXis5wsk1j0maqLJ9jP7zbQYTekz8G7XVl5ZQT8ijmjSu8EDs9Q5m8?=
 =?us-ascii?Q?162TceYknRxEzAY2oA8KnSyamSBIPYzTtJn4qXyPWBpzvxzeIcYmx6eAgr1Z?=
 =?us-ascii?Q?HQnG5qdf0yHufBmkVmqL8LuVRoHowCGn0IFxD5cgi68V3dDjTrUVR1jcyOT0?=
 =?us-ascii?Q?m4oUAGMjLdBXijm+yv+yORy5XH94ITYnD2kBonaTmm72q677njQWso2cQhsk?=
 =?us-ascii?Q?19jiJVgyyCFZc/YGBS8+dLbJvWSxncKpnpdzBaX2P0HR4JoKBwkQ58LQe8aX?=
 =?us-ascii?Q?77bh7u8bZWQ1999JN79lcaeZ6ailMGqTFyHGC/tlbq4Jy1nZymee/GAVdN2K?=
 =?us-ascii?Q?PsDZAsJgV3QImGdQu9uoH3wGH5reA7LhO2BvBlh/4FwvzpLcEw/0+0NHofaq?=
 =?us-ascii?Q?uJxWl5Nl9n7UU3Tt/k0YyluuzpPZzEzRjSEK+jjX4LyHRLb+f/dZmZRWMbM3?=
 =?us-ascii?Q?juDjJC8G5/yEXuLu6zzr5HTwQtMQ34KPj/7IEfAehAyhyIH8zlRgzkt9LzTP?=
 =?us-ascii?Q?dq5TVI6RI26LIzZbdhuquxno45RfXI7d/J/fUzhnFWwDNwBpLEe5FBsQjiGE?=
 =?us-ascii?Q?uXlqk3I50FsLY3BjMHjuVYABmKbveU4VpolefaVsBU+hmj1pX3+S2so+zqQh?=
 =?us-ascii?Q?vI8dBpl1fEiWowCXcYdsxZcWvgpquf7v/lraqpr5nWV5ny6GncOu/4rYgInN?=
 =?us-ascii?Q?oNc2zdoOntAggUnrM4itGleVs74boQnbbuyB9tqZiX/KWJCJ95/yisewES0a?=
 =?us-ascii?Q?k1gVm1lI9v5ierszGAiHbJRaTueNV5VVSEpiEd4YT7HnKRFcHOrNn+FWpPYa?=
 =?us-ascii?Q?8Cw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ihyZv/UxoecAE/jnnvSYhrBL9z0cw/vq3GW1ptmYKgnzLw4xE731aU4JCV1j?=
 =?us-ascii?Q?4zP9MkvZQNWkl4bOnKVXsoC2jeOg9uSBxkxk7QtHYRt1XuaKoOJ3HkgtdTWD?=
 =?us-ascii?Q?eeSl7iUleLYB+G1p5eLFCY4n5JUi1q11/kw5STdl2yM612/Lv4XIa8nHhzMR?=
 =?us-ascii?Q?XIbBAzmNwPVDswS7aj9XjgrCmz5B4J09N+vvT4z2G3ngWEj97r65zeFljHUD?=
 =?us-ascii?Q?Eutt8AFFGnMV7vHjJytB18lseshIV1BNquQ7unwXPW6fEeCV91EubgoQtkso?=
 =?us-ascii?Q?qg5TSFHPox7aHs3Qni6Od5qLHUMeYf9Errd4/2gv2PbRVL6jwoXTXZ2v+b3y?=
 =?us-ascii?Q?KMJ6tX67s1s0A6WO3IjE4Q4ZptGvC1Z9BG/1XLKRynYMJsUgj8XT/WScrjBE?=
 =?us-ascii?Q?y8wRbQgXXGbNrBMR/WT6t5VSC8eFRUxN5U/9Apa+nNrTWcyQB40A/ROcgNNG?=
 =?us-ascii?Q?2MagX76IZ5C3YK8ttfdoqQQDimgWkIiAjVcerei9bTvC97Kzqdhp4NZ2cibh?=
 =?us-ascii?Q?oRpODKRepy2suxty8gBsglIVuZ/cq9iVOARW73LONVgUTuvnI3b/k5fj/KCf?=
 =?us-ascii?Q?6ia83w78DcujmjO+F/BzupGhYE1jmIAsiBXU1pTx/F60nmgEPZ4KRT91d9Iu?=
 =?us-ascii?Q?FYQTfScZCFBFpmlO39FwDwGX78C0TSrSiAKw+jMp8P8BJKT/XIIjdwe1qNvI?=
 =?us-ascii?Q?Mknox71jZm3SpHg2seQWRxuIVp8W8i2RqwZYOTWvrR7Co0Rx5kqlhBS+kXt+?=
 =?us-ascii?Q?XM6nfI6qKAtPTE9llTtI129+mYCHLOLPjMWJNGXIWbM2xCcejlVLAu4IfGfi?=
 =?us-ascii?Q?PLWv1it0VhEQKrbZmOxU3yFC8v7xCycxDIAgVOpvyL49743dy/zerywjC1H2?=
 =?us-ascii?Q?aFcSDhscIixsvRUBM1xKbfRYhk2zgmg+9BuOraObM0wL5Xwt4bMinC/Z0yv8?=
 =?us-ascii?Q?Aa8TMil4V1FcMmPQo+Qmiv/6KvNeNZxMJKbn6p12ys2cGEdLNad52q2S3AC8?=
 =?us-ascii?Q?QEDs52IsofQ87Ml9uEtixXEtdWv25DHQ0tA2hpGblrHcm406Uc4MHkhs0l8y?=
 =?us-ascii?Q?3i00LzXHtJCnOQKZHu3pLLFjPyjyUfXNwEg1ZLDGwy63Guc8cIIio7TeInDI?=
 =?us-ascii?Q?+cXZ1vAXkq5gwmHfIqhIk2uw9gyqZFg1u7D4Q0AIMc2taCNO5ukVCxirceyR?=
 =?us-ascii?Q?OaST/xZyh54dFlXqm2nP3V5EJnVXg9vG9Zh4WpfMWSUAblcJ8cbbp45qSTNy?=
 =?us-ascii?Q?XmIAd7aOHlNaACOrezWQkNsTvKYpnhe5GRTN8hUG/Mfrn1ka+ii2RhesumsQ?=
 =?us-ascii?Q?VMlC7zL56If7PaLwc0Rt3BttJR2WRbkVJOjLgyTCsm7EI1YhsQ5GD535ObcH?=
 =?us-ascii?Q?7aEIKAk=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7edec0c-e7ae-4d7c-8fda-08df0dd369be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:02:57.2777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11153

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 7, 202=
6 7:14 PM
>=20
> The current memory deposit implementation has a few issues and bugs:
>  o It is very slow
>  o Contiguous range requirement is broken, and is critical bug
>  o An incorrect assumption is made that contiguous memory size would
>    always be power of 2.

Is this HV_MAX_CONTIGUOUS_ALLOCATION_PAGES? That value is
defined as a constant in hvhdk_mini.h. So is there a possibility that
the constant will change in the future, or in some new variation of
the overall environment?

>  o Two pages are allocated, only one is really needed. This adds to
>    overhead.
>  o For a 512 page deposit, the allocation is split into two: one for 511
>    and second for 1. Thus, an order 9 allocation never happens. A
>    contiguous 2M range, if possible, significantly improves performance
>    in the hypervisor.
>  o Since a page is already allocated to collect the frames, there is
>    not really a need to use per cpu input page, and hence avoid local
>    irq disable.
>  o In hv_call_deposit_pages(), in case of error, under err_free_allocatio=
ns
>    label, all pages are freed without checking status to see if some page=
s
>    were deposited. This is a critical bug as it would free pages that hyp
>    may be using.
>=20
> All of above is addressed by:
>  o Allocate 2M by default, this is the recommendation from the hypervisor
>    team, and greatly improves performance.

Can you be more specific about "improves performance"? Is the
improvement on the guest side, or on the hypervisor side? And what's
the key leverage point in improving performance, regardless of which
side? It might be helpful to record this for future reference to prevent
a change from being made that unknowingly hurts the key leverage
point.

>  o Always start with a full 2M range allocation, thus getting contiguous =
if
>    available. In cases where possible, the deposits are much faster.

Is this faster because the hypervisor can consume the pages faster
if they are contiguous?

>  o Allocate only one page in the deposit function and collect 511 pfns
>    there. Just use a local variable for last pfn.
>  o Use the page as input to hypercall. Since this page is locally allocat=
ed,
>    irq disable can be avoided helping speed up the deposit.
>  o Fix the physical contiguous memory requirement.
>  o Lastly, remove pre-deposits hv_call_create_vp() and
>    hv_call_initialize_partition() as they were removed internally while
>    ago, most likely because they didn't help much.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c           | 198 +++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_hv_call.c |  10 +-
>  include/asm-generic/mshyperv.h |   5 -
>  3 files changed, 179 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57864bb5bcd8..0ebede0bc8b4 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -9,6 +9,184 @@
>  #include <linux/export.h>
>  #include <asm/mshyperv.h>
>=20
> +#define HV_DEPOSIT_MAX 512
> +#define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
> +	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
> +
> +/*
> + * Allocate free pages for deposit to hypervisor. pfna[] must be large e=
nough
> + * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return l=
ast
> + * pfn in lastpfn. If @single, then it must be a single allocation (not =
split
> + * over multiple contiguous ranges).
> + *
> + * Returns: number of pages allocated or -ENOMEM
> + */
> +static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int nu=
m_pages,
> +			      bool single)
> +{
> +	struct page *page;
> +	int num_allocd, count =3D 0;
> +
> +	/* Published ABI, enforce its immutability. */
> +	BUILD_BUG_ON(HV_DEPOSIT_INP_MAX !=3D 511);
> +
> +	if (num_pages > HV_DEPOSIT_MAX ||
> +	    (num_pages =3D=3D HV_DEPOSIT_MAX && lastpfnp =3D=3D NULL))
> +		return -EINVAL;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		int order =3D 31 - __builtin_clz(num_pages);

Outside of the kernel source file da9062-regulator.c and the definition
of fls(), there are only about 14 direct uses of __builtin_clz() in the
kernel. By contrast fls() is used more than 700 times. Using __builtin_clz(=
)
works, but you might consider using fls() instead just to be on the more
common path.

> +		gfp_t gfp_flags =3D GFP_KERNEL;
> +
> +		if (!single)
> +			gfp_flags |=3D __GFP_NOWARN;
> +
> +		while (1) {
> +			page =3D alloc_pages_node(node, gfp_flags, order);
> +			if (page || order =3D=3D 0 || single)
> +				break;
> +
> +			order--;
> +		}
> +
> +		if (page =3D=3D NULL)

Nit: I've always thought kernel style has a slight preference for "!page"
instead of "page =3D=3D NULL". And indeed, a few lines above you test
just "page". Not a big deal, but when there are inconsistencies I wonder
if there's a reason ....

> +			break;
> +
> +		split_page(page, order);
> +		num_allocd =3D 1 << order;
> +		num_pages -=3D num_allocd;
> +
> +		while (num_allocd && count < HV_DEPOSIT_INP_MAX) {
> +			pfna[count++] =3D page_to_pfn(page++);
> +			num_allocd--;
> +		}
> +
> +		if (num_allocd-- && count =3D=3D HV_DEPOSIT_INP_MAX) {
> +			*lastpfnp =3D page_to_pfn(page);
> +			count++;
> +			break;
> +		}
> +	}
> +
> +	return count ? count : -ENOMEM;
> +}
> +
> +/*
> + * Deposit memory in the hypervisor. Even if @contiguous is false, a con=
tiguous
> + * 2M worth of pfns is utmost desired for performance reasons. But short=
 of
> + * that, we deposit whatever contiguous chunks we can get. If @contiguou=
s is
> + * true, then the entire range has to be physically contiguous. Note, in=
 that
> + * case, upon withdrawl, hypervisor could return any page in between the=
 range,
> + * so we must split that also. Lastly, HV_MAX_CONTIGUOUS_ALLOCATION_PAGE=
S is
> + * not guaranteed to always be power of 2.
> + */
> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contig=
uous)
> +{
> +	struct hv_deposit_memory *hc_input;
> +	int i, rc, num_pages;
> +	u64 status, *pfna, lastpfn =3D 0;
> +	bool trunc_extra =3D false;
> +
> +	BUILD_BUG_ON(HV_MAX_CONTIGUOUS_ALLOCATION_PAGES > HV_DEPOSIT_MAX);
> +
> +	if (contiguous) {
> +		num_pages =3D roundup_pow_of_two(
> +				 HV_MAX_CONTIGUOUS_ALLOCATION_PAGES);
> +		trunc_extra =3D num_pages !=3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +	} else {
> +		num_pages =3D HV_DEPOSIT_MAX;
> +	}
> +
> +	hc_input =3D (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);

Mike Rapoport has a kernel-wide effort underway to replace
__get_free_page() with kmalloc() and get_zeroed_page() with kzalloc().
See [1] for one example of the many patches he has submitted. The
commit message has a short explanation. Going with kzalloc() here
would probably avoid a future change.

[1] https://lore.kernel.org/lkml/20260830-tty-v1-1-0cbe6170649b@kernel.org/

> +	if (hc_input =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	hc_input->partition_id =3D partition_id;
> +	pfna =3D hc_input->gpa_page_list;
> +
> +	rc =3D hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages, contiguous);
> +	if (rc < 0)
> +		goto out_free;
> +
> +	num_pages =3D rc;
> +	if (num_pages > HV_DEPOSIT_INP_MAX)
> +		num_pages =3D HV_DEPOSIT_INP_MAX;
> +
> +	if (contiguous && trunc_extra) {
> +		for (i =3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES; i < num_pages; i++)
> +			__free_page(pfn_to_page(pfna[i]));
> +
> +		if (lastpfn) {
> +			__free_page(pfn_to_page(lastpfn));
> +			lastpfn =3D 0;
> +		}
> +
> +		num_pages =3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +	}
> +
> +	/* We are not using hyperv_pcpu_input_arg, so no need to disable */

"disable interrupts"?

> +
> +	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages,
> +				     0, hc_input, NULL);
> +	if (!hv_result_success(status))
> +		goto err_free_dep_pages;
> +
> +	if (lastpfn) {
> +		hc_input->gpa_page_list[0] =3D lastpfn;
> +		status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
> +					     hc_input, NULL);

So if a full 2 MiB contiguous is allocated, it's OK to deposit the
first 511 pages and then do a 2nd hypercall to deposit the last
page? Does the hypervisor figure out that the 2 MiB is contiguous
and map it with a single 2 MiB PTE to get the mapping perf benefit?
I realize there's not any other choice given the limitation of 1 page
of hypercall input, but I just wondered.

> +
> +		if (!hv_result_success(status)) {
> +			if (contiguous)
> +				goto err_free_dep_pages;
> +
> +			/* We deposited lot earlier, so give it a go */
> +			__free_page(pfn_to_page(lastpfn));
> +		}
> +	}
> +
> +	free_page((unsigned long)hc_input);
> +	return 0;
> +
> +err_free_dep_pages:
> +	hv_status_err(status, "\n");
> +	rc =3D hv_result_to_errno(status);
> +
> +	for (i =3D hv_repcomp(status); i < num_pages; i++)
> +		__free_page(pfn_to_page(pfna[i]));
> +	if (lastpfn)
> +		__free_page(pfn_to_page(lastpfn));
> +
> +out_free:
> +	free_page((unsigned long)hc_input);
> +	return rc;
> +}
> +
> +int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
> +{
> +	int result =3D hv_result(hv_status);
> +	bool contiguous =3D false;
> +
> +	if (result =3D=3D HV_STATUS_INSUFFICIENT_ROOT_MEMORY ||
> +	    result =3D=3D HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY) {
> +		if (!hv_root_partition()) {
> +			hv_status_err(hv_status,
> +				      "Unexpected root memory deposit\n");
> +			return -EINVAL;
> +		}
> +
> +		pt_id =3D HV_PARTITION_ID_SELF;
> +	}
> +
> +	if (result =3D=3D HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY ||
> +	    result =3D=3D HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY)
> +		contiguous =3D true;
> +
> +	return hv_call_deposit_pages(node, pt_id, contiguous);
> +}
> +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> +
>  /*
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>   * are GPAs.
> @@ -109,12 +287,6 @@ static int hv_call_deposit_pages_old(int node, u64 p=
artition_id, u32 num_pages)
>  	return ret;
>  }
>=20
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> -{
> -	return hv_call_deposit_pages_old(node, partition_id, num_pages);
> -}
> -EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> -
>  static int __maybe_unused hv_deposit_memory_node_old(int node, u64 parti=
tion_id, u64 hv_status)
>  {
>  	u32 num_pages =3D 1;
> @@ -144,12 +316,6 @@ static int __maybe_unused hv_deposit_memory_node_old=
(int node, u64 partition_id,
>  	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>  }
>=20
> -int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
> -{
> -	return hv_deposit_memory_node_old(node, partition_id, hv_status);
> -}
> -EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> -
>  bool hv_result_needs_memory(u64 status)
>  {
>  	switch (hv_result(status)) {
> @@ -212,14 +378,6 @@ int hv_call_create_vp(int node, u64 partition_id, u3=
2 vp_index, u32 flags)
>  	unsigned long irq_flags;
>  	int ret =3D 0;
>=20
> -	/* Root VPs don't seem to need pages deposited */
> -	if (partition_id !=3D hv_current_partition_id) {
> -		/* The value 90 is empirically determined. It may change. */
> -		ret =3D hv_call_deposit_pages(node, partition_id, 90);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	do {
>  		local_irq_save(irq_flags);
>=20
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e..b8d199f95299 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -15,8 +15,6 @@
>  #include "mshv_root.h"
>=20
>  /* Determined empirically */
> -#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> -#define HV_MAP_GPA_DEPOSIT_PAGES	256
>  #define HV_UMAP_GPA_PAGES		512
>=20
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> @@ -140,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
>=20
>  	input.partition_id =3D partition_id;
>=20
> -	ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -				    HV_INIT_PARTITION_DEPOSIT_PAGES);
> -	if (ret)
> -		return ret;
> -
>  	do {
>  		status =3D hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>  					       *(u64 *)&input);
> @@ -248,8 +241,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 =
gfn, u64 page_struct_count,
>  		completed =3D hv_repcomp(status);
>=20
>  		if (hv_result_needs_memory(status)) {
> -			ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -						    HV_MAP_GPA_DEPOSIT_PAGES);
> +			ret =3D hv_deposit_memory(partition_id, status);
>  			if (ret)
>  				break;
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb..c16abaecb65e 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -345,7 +345,6 @@ static inline bool hv_parent_partition(void)
>=20
>  bool hv_result_needs_memory(u64 status);
>  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_notify_all_processors_started(void);
>  bool hv_lp_exists(u32 lp_index);
> @@ -360,10 +359,6 @@ static inline int hv_deposit_memory_node(int node, u=
64 partition_id, u64 status)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 =
num_pages)
> -{
> -	return -EOPNOTSUPP;
> -}
>  static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 a=
cpi_id)
>  {
>  	return -EOPNOTSUPP;
> --
> 2.51.2.vfs.0.1
>=20

