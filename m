Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012059.outbound.protection.outlook.com [52.103.10.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6E4A43E3;
	Fri,  4 Sep 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534918; cv=fail; b=PsIFcRRty4d6S97Dr8VDtx5xrf1tlKQ0LOP5g+2QogYvgLhzJtjHbo+Lnivd+YzeDl/4Umv2sORjIjl/h6uFiRbFMbUPfsxryVJ82OBKsTSPagS9LZ2aiNM1VNw1WqNB5aCwDkPywlGwIKrv2N6VY+nMmTFcpr9oW8pj4pt+1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534918; c=relaxed/simple;
	bh=rFIiPS27Yzb/QHoP/wT8nkmdqmHXvguFKG1vTNgfiR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYe0rX09OPCsPhI44sOI9DnZyPeknIkyEVM2gVdsHdg8nEvXz2vSlSy/rxsJGmBqduqUQNTESjon3yY8buVksMK4wpVQyvGgn9DS1Vmu06AaboaHjwEbpuYcuHLavQGPXPEl5XiO58z7cGHo4yBDrSEWzRq0lC5UHjiSPsqB5c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MPw8T3fI; arc=fail smtp.client-ip=52.103.10.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MPw8T3fI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtWEJI2vBLv9Wvo11xEH5D+pwMf50LPg2mCxtoP/5JC8j3AFx9lmcN6C7SJ0fXTQ+2hbsFBNuNi9bmRV3OM9MjsPqSZQIbVvHIrtmV2fJPMAkLTc7gqV+WK1Ldfd5s8i7VwRsepA2fIndd53+WNO9dTsrUXGVFEgPOYqUHaU2L0RyRQ/iq+9gTz5TQ89XXg2nApZr3hEWMUH9wtJrzSKeYAAKSs3KnNA3P7ZFideamUpj9CwM5Z1O91ThL55JYzi/Z0Xzpc2LX3aaTQni+B87ZTHuQ0tyfO46/oHsNfcO5oUZSnPdWOifqrx6+DMOaOIhmARxYFyr+UEKCmnUT586w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUQgBHDhl/3zBgvW6B1z74JdEodgHlGwsFO5bIVy7Ho=;
 b=l69zrRq5CGR19tsQNb9QWstCx/d2NIdeT+AASngfo5ddLwPU/IE8NOHXFE0Z4YruG5e16V+QoPLImexGZZ2eKlSXQkBjsKKbnjVz96ih34R3euYMWwYdc0HwTvhkDg5T6sZfIUctG+hqq7xG1YloHf9xgwnerArQ+1SK6AGEgEF4YRgZSGSTV+4Hy6KqFvB93mpH9BY1AL38zLzoWflAGO0vyUxeUweItexo0E/67P5+PS/UEi/NsIJKxeEfcejCMzgITemyE/0P2uunbkocrJGUWvmAPB38gogBZynyLRCyd12jSvnw4JHIemxKRq0DSiXoU5E67TCtWmAgwUmN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUQgBHDhl/3zBgvW6B1z74JdEodgHlGwsFO5bIVy7Ho=;
 b=MPw8T3fIBOTD6ERxyxO1dyRqkl8bvaPQXuS6PA+rb2HtRna97bMwUBsmQegvTxl07MuLY6Ttl6benm5Z0H6+af/CP4f6sqqcOG3nHMHjEo+spe14t/egzV3LyZjITOseaJIxZyIZx9dJaniifQlMc+e+IzG1oBY1RfBGTkMj4soHs1ZbirmVweR4JqtHcSH9N3iZnalHQWZ3B8Ib4R9DfGoCo0ABozJDt6KRLQ1WGVsI0oM7hnl7YGO99dV5nlml6ewlYK2yINYMe6bWcKivMgPL++byW/VZfxbQ4VWiMevIxg1O02GPFsv32BN/EPf0W2yewUc3O3vMnp/C3cD99g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7574.namprd02.prod.outlook.com (2603:10b6:510:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:15:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:15:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 2/2] tools/hv: fix typo "retrive" in comment
Thread-Topic: [PATCH 2/2] tools/hv: fix typo "retrive" in comment
Thread-Index: AQFJ4/2fTj1rVCOYFMYKHTCfqVGwRwE3wj85t9t57WA=
Date: Fri, 4 Sep 2026 15:15:14 +0000
Message-ID:
 <SN6PR02MB4157134463B92490A697BE92D4B52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260904120857.20431-1-hemanth.selam@gmail.com>
 <20260904120857.20431-3-hemanth.selam@gmail.com>
In-Reply-To: <20260904120857.20431-3-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7574:EE_
x-ms-office365-filtering-correlation-id: 9d93e9fa-1362-4b24-6d9d-08df0a97522f
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/gR/4nYHidVewSWZPY4tHqLbteQmAMN4q/mWwbegfKxKg3ogTzEUCG2mHa8lAgJAWUlfvVvNipEoKcz8LWPAWefi/0gLajds5IRCfWkOZXIP5R9X6+Yjh6VAta7Pa61p0kRet75SPzyadwEeala42hd1AvxsmaEW5lPdBxokTD+c55yIbEpHl993BvsauHcwv/E8xmVcedsNn4mhRjKNSTJhpyk0ukXtuMQUYGzltIfg0tVoPgldUEWYKGPVcAIQVknp6BVxUwTdU+Xa55LvjStMyGSxpL53EnZ673RRbaCgNwOLDLXx0oIuHL1WGQAplzjtmKuaxBV/fFtW2Y7R76ewcI+QEBEy3g6ifDOaVQe06giiBxfYXJm0akY99ThJ+NJgC6B3juahm/cW15WhENRsyOcYZcY3EMSrCGnT3QgZmYGu5qRDlI0vwOTdcc13BP3AHw9YXBPPC822+jh6vj/06L5f+g/Kz1bfpaLDQEJC+D/3NGiKCJSW/jUGOOyWQXMGMxST/mY0VgK1DkwH+eJc1LG0leETtywIj4y2I0/tPMr/+vkiIoqnPwUUL0FGhjbM5XV2Px7R8rdu7IibAIueq2k9AsUt+LAxXL6Meeryacq1bOXhgfPNvXY/uyuyFNjbeNTS+ZZ+YkAT4yjHhm6q237KO/ni8ooObTeqCixVUXJQjWoeOk669bBpV2euE1LBO1pu8vWPQazjv+rSeGx4Sz+AKyYHU
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|25010399006|8062599012|8060799015|19110799012|12121999013|37011999003|15080799012|13091999003|31061999003|51005399006|12091999003|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vLi95chBxnZxnAmVQDCC0vRbRPDb74CwFxuV7CsNStR68n9FEiz7KC87jBYz?=
 =?us-ascii?Q?W8NJH9l0M/ZpVV/fwZV02wPLNX4C2eDWXz0xNgBl4t7vzD7O8oQCNmIryzL5?=
 =?us-ascii?Q?FR4vugsdBMPBbay8B3DBzHlKzas4bISIXzfei+Xky7BQMgut8YuWmntkhRM/?=
 =?us-ascii?Q?SkWt1gdztuXawRm8YL2NuH0Y9XPK6J5LsARwYhH1ThQlqbQiqv12auN30AX8?=
 =?us-ascii?Q?aVxhd3xLrm/a3ySZBObkOTIJMnA06dosexyMMKUpBES+axkXvzOFB7uSy1vF?=
 =?us-ascii?Q?7eAbJdA7mUFYXbKK43EWlIT0d/rogv+bZtG6CDyeSkanuAaUMzPJHGR0RLT/?=
 =?us-ascii?Q?+QxtqzI9Ls1Bf5bUwWPNjp1dNRi2rp0qJjbFOLnmGaHUWLGmQk1W+ewe3ShL?=
 =?us-ascii?Q?oBIE0KQwuCOOffe7fo2MrC4xukhfID0UfyPRDJUaCdMkIxMnaJ+El/DmxscW?=
 =?us-ascii?Q?H6qhA3UIIVX24sK2tP0BPG8lTsHMul8qRQnTj1ID64S+r7CA6Jq+cGx4hvdZ?=
 =?us-ascii?Q?acEDcrmZ4jtVHFW85fgcsymDO6Ah00RVP1mrqjGpZZqsWfKPoUOfGvrPsT5s?=
 =?us-ascii?Q?rGTXUAFXH47kPfMqFBNAsevMYwnmy8ZnB5uJk30osJnZjxj4tx1Yrnqlr7S9?=
 =?us-ascii?Q?T0cp67NTZOuUG5lUW9AaAKT2IGtX1/zo2gXIcYEvmDzvV87CvOSQStufqrdd?=
 =?us-ascii?Q?le5xKz3aqSBUpi75Coqyljk+5uumKz3sAqpv5nz6mH07pzRz0nC0Sj6h+DBy?=
 =?us-ascii?Q?LMKnj2BIBcSBf3qvWnx9WkTv5xm4OemHgoYe5LdinjWWPH2JeohplusijCTW?=
 =?us-ascii?Q?q76SFChe3Jqj6O2jzN6tZGTkQLXIhyn9bJtvV5iwATpGKgVTGVucqHNhZztr?=
 =?us-ascii?Q?IUyRLvYXckJKal9F79RfmFero7+ibCL/KilGoxynp9DG8pY1DCC8SjKFuRFd?=
 =?us-ascii?Q?vr6bBTo1RSYL1MJqvXyCGgyLNGHqsKVtU8kUe8AFfRvYcDLHB6z2SMIgasY2?=
 =?us-ascii?Q?yCLFBEwDE5iYywnpcpfbA7NfdBBMg+bFol0eFgqMVOF0XCbrhGiXB0svJpg3?=
 =?us-ascii?Q?H9U/YDEqg/JCn9yYRS44e9BqSq1+QlpEe0tHx99vLpGNKyCzfv8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qxYIqhz/2van1I/2ilJAIMJs+2aHSHiCGA1vasEMpI0DOpUBHNiOPTohYvqH?=
 =?us-ascii?Q?v5RHZ6bp2iPlBes517pVqeVML1A4OMnYvTvdxKqUTEm5jvXvX8JxrVAoEYBf?=
 =?us-ascii?Q?l3r/tcLwt/J5GOmXEX+AU3BElGw70zlg2CyHoCPXzj6NqI4czQaP2k0mELjc?=
 =?us-ascii?Q?FUFYafOSwppHroy3gpLubCI9kQvUXa5eJS002kogZNA5xFsBCSgf/H7MED3O?=
 =?us-ascii?Q?zpRLCjGY1QRiFlFU2D7nskbDwxOq1oo2u0DB9G0SE2dNuxK7xnooqRD4E/Wx?=
 =?us-ascii?Q?Lx0+J+oDIdDSywyuXVm/BxzSeQ7AgpQ3hF25LkB/us6cRB00PvGI8q7wXChX?=
 =?us-ascii?Q?7qimLFSiudFbQyzMa9WZG4Xv15Rn9vrv+mYoIKyuGcVCI9RSrXrWdGS8Hw4V?=
 =?us-ascii?Q?ZEor7BWl2gcJyOvv65diqNFiBGUyKQXPPg36OjzJclhGULWRuALzP9pJ1fhV?=
 =?us-ascii?Q?Htt/HD0P7olnW0uTaz7uRL82Gw7Ew7PCDE9o9/kQtCs27S7nZgB/zfCiVAqY?=
 =?us-ascii?Q?LFR0viMq33HA6Gk+GIuDBuuVO+s4bzKCR4E8Gh6PEhsMV9PHxxV6k/BWzoFh?=
 =?us-ascii?Q?faK/1sfu9UEcquEE5Bn1PNbo56IXrD+WrrNu+2PdbsQYf1TpsCCECWHbds1O?=
 =?us-ascii?Q?6pzSQhy72XBDIBl6nETdnmb+pcfOcZpWC1HeJaRrfnK42dAOUNY5hKtzPkgD?=
 =?us-ascii?Q?VHmIBQ+D0gxkl5whciEMQEADGWLeLpWMJkPsM9FjOz7xSpZDYw6ADDtUMCya?=
 =?us-ascii?Q?3Dv89xpjBJLJUq9Z1gHeKOc8AsqsTV++LRuTnHeiF8znIPn1SwLAte5euRRr?=
 =?us-ascii?Q?xLImPmMtxFkksonQr0QyiKd0/VL0iO4gOaBRky+MzMyDbyg/x/WdJuVuD/w5?=
 =?us-ascii?Q?w7L7mY55SJABD1JAf64UQNcJGhM7VLMpoKb5lkK7W6oTo6XPRViHNQY9LyLq?=
 =?us-ascii?Q?bjaG8YwkfojV7KlMokW3PDtYUR65FNrrrAOUp4gZX9sx+x5IGdGHUqZL8zbI?=
 =?us-ascii?Q?u+oKZn+PXDPLUCNMeoi+RmxR+dLi8ZOz5M4LoxlW3JhPIb3oCSZvhxNHVgjO?=
 =?us-ascii?Q?YplyxF4xxbOepBXwzzg0SZQXh/jBAmEG9jEBqA9HTFoq6psFokzaE1MkFtEe?=
 =?us-ascii?Q?3nfHyRy3EkqjoLBQCpkCOYWh9iOcXHHZKd0CJu9ls7912fodatHleJj0jcZu?=
 =?us-ascii?Q?sgH+qjJYjkullQVwufST4CE380jYosbUOfvWRl0lOfbsamDqPxG4aJ05htZk?=
 =?us-ascii?Q?dhtgxxkTPpT1AE0AXrL/O45EybQ8pEdH7T1alQc5pJz7/rPpabPS/uvKgYX1?=
 =?us-ascii?Q?bNEJk6URfoddvHTxXM9GSgSzt8BYY7mvsiQadlAp3lvgTeGlutx9+mFM2f8f?=
 =?us-ascii?Q?rLgjlWI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d93e9fa-1362-4b24-6d9d-08df0a97522f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 15:15:14.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7574

From: Hemanth Selam <hemanth.selam@gmail.com> Sent: Friday, September 4, 20=
26 5:09 AM
>=20
> Correct "retrive" to "retrieve", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  tools/hv/hv_get_dns_info.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
> index 268521234d4b..288821565eee 100755
> --- a/tools/hv/hv_get_dns_info.sh
> +++ b/tools/hv/hv_get_dns_info.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>=20
> -# This example script parses /etc/resolv.conf to retrive DNS information=
.
> +# This example script parses /etc/resolv.conf to retrieve DNS informatio=
n.
>  # In the interest of keeping the KVP daemon code free of distro specific
>  # information; the kvp daemon code invokes this external script to gathe=
r
>  # DNS information.
> --
> 2.48.1
>=20

