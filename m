Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794420103;
	b=5JJcBThW9BajFA4eg9miJefHcZY5lsGoI8fe/GOa+4ENaXWpXxlPeRYyWG5qVTBAvXBh
	 MQsU/LTk53f6GL8DEkEWOm2MbvupepLL86FNdTlZAl2mGTf9mb5KKcsC4RbviBXcTgiBS
	 haRvWFDp2cuzpmxIlL0Jza7dt9+A4Nhi/x3OScuUL2/TCMbWWx3VXi0Ji9MnrswKy6riv
	 QlkaK/0tH+Fvr8M4dpI+qGdVeVIi4Oz67KBns6MfrTUAWrHgAnRFZRupmy+Eepckh4VAh
	 IQ5q2XltMtQIub1H6k6ltCX59eDVnn1ue+QbAyK9oPyTYE7uRRGCqE+vcIMSAIVIZMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420103;
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
	bh=2KYZG3Ps/5lwWxmOdJUEP4aawDbqhDyvXHWnA+aGLUo=;
	b=5R9QKSML5QqDvdG0rNdsNxfv9fi984CJdsC5Oh5LvC6UICnR3YGsfM5dnF5BgQ5ObDUL
	 tYfAf4ZMIlqZS06HY6nYRhQ7rJBqszvGLiuxYS7fC0PfHulIrqgXqQGgB7qJolqX5/swt
	 MrRG6IvidF4SgMyGPI7a9rTKBVrGVScc186o0ZLhkMppMdhu4cAXVUO6Nu1og6GCObot1
	 SEkph2YBK5N88sKy6Iw5SLXyHz92uiJ2a5kBeEEomz9+HWiuvAwVHxEgGvZPj0A1lUxaj
	 iav2Yt4sS92+nvRxpAyNtXWbbmbyFhAYvonwSwEnyO2ije+8jfRrhd6Re7vRiCPGusw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rHvr8+zo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.17
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012017.outbound.protection.outlook.com [52.103.10.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C24606A326;
	Wed, 11 Nov 2026 18:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1C24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rHvr8+zo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWQjfoQZ2LUPkCsNw2uBjwHHcB+hxY7i5zqhBB+Wzn3SNhqf0znyMT98qU9inwsqpD5keFB/l8tvc2n3xuIO0cLNj3HZr29Djh31w48q+JzTyAfN1n11EdwAj6uJK9mwNQaqhuLGar3bEfD9qHL0mGQ/VxBo2AkZoLcxVLCpyASWpRG6t3u8m4DNcYVd+32U7UcW6AxlekPK3FltBHQ97wIjAGNUi2jxlzwP7Mvn4wfIVIPydAFPcX9XODoonAz1hQ8gxiDn9/j2D9XrdJK884Y/HeUME1M9nJwaiSccaHqkhP21WUiGFtoU07l/aJGMdU+UXhBDguIfeaApCxiWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KYZG3Ps/5lwWxmOdJUEP4aawDbqhDyvXHWnA+aGLUo=;
 b=mIkYEfUpO1MJPq+4i1eS6DPk4afLy1BtPyTdwHvpQOnv4e0VmYhI1h9sCtyHEHunvhRrzCxyT//p50GGKh2qKQ9gNvUSvv+qywMV/Ba/s2ldJHK5QiJVcqAtOvmZdfijwyYfEI9Fasb7PwK+B61XLIRjo1ORK15m9He/Agi3WjF3EmNdMLmgIEQj7NVsBYHHF2r/rTAOXqKqN/r6RGkZ255tHw9hvO1NL/RA+Dn17O6spD/DnUfUJdxEoJInmRkJOLdfe/PXvSmy7kT78fFO6OsOQIlL1VfaKYZsAtIh6tgTlgC6QIipEmcDTBY/BU1sqcdn7WMX1huS4kB4Kze+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KYZG3Ps/5lwWxmOdJUEP4aawDbqhDyvXHWnA+aGLUo=;
 b=rHvr8+zo1lMC5hWf0JhHQXwzNnzA9LZnmHV9oFjEPNs6pRYKUV/CqCFvi15w/1CZBkxo3V12niSAGLR0hF+VfPYA4ifnCe370/FKr/4n8Vz8m97hBlbSMw4xY90yO3lWN+aZcrfKGcxOpQW22cO2ea93NHZ+TL+1UJh+LT6TzIjYcQNNNP6gKOTwm5o/NN/2oB5SW58058oS/d1GFTG8E7jHVQ2iPA0pEcq00nSH5zV8yDCPDFyI/Fhr61MpZ3f8DzDg5Ps2nUKTRBqxMv92vgY3txaFiHbQFa2yOph2eKdXV+1ngtmU9O7ivPhCJciEMq/4LqJE9IND7b/ZbabfAA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH3PR02MB9714.namprd02.prod.outlook.com (2603:10b6:610:173::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 18:01:05 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 18:01:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Mukesh R
	<mrathor@linux.microsoft.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>, "thuth@redhat.com"
	<thuth@redhat.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Topic: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Index: AQHdaMzUW+ALWywyUk+4CFfjEacMarcpO6KA
Date: Wed, 11 Nov 2026 18:01:05 +0000
Message-ID:
 <MN2PR02MB6863AA6357C8E0D4881F5FEAD4712@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH3PR02MB9714:EE_
x-ms-office365-filtering-correlation-id: b839166f-d0b0-4632-1451-08df401dc176
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|24021099003|31061999003|25010399006|55001999006|41001999006|19110799012|8060799015|12121999013|8062599012|37011999003|51005399006|15080799012|1602099012|12091999003|10035399007|40105399003|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XOWUPO1x44/woZzxHJDtSiwzdIDezNelo6wyduSwKW8cM0H8YcIn1cR2pbPu?=
 =?us-ascii?Q?JVmMEevQTTktsLw+YiEvL6ZfavmFWTtAj6j+1Na0R3joCeAvd+gs75o6TnnN?=
 =?us-ascii?Q?L/UtU64HMuL6jI6AOKFN8PYjNc7S12pEz+rllk/k+TlFwpbU7Fl1xVeEVcMJ?=
 =?us-ascii?Q?RtyZqyKrndNbPOT0VY0k+pDeaIRCfbHoH9ZBe1iv6LEFSqeeGfb7uO/ghOhC?=
 =?us-ascii?Q?/TqxZbUFnginm+rHE9CkO6vFj2a18Yxw5V6HBo5mJFRYcoSWsQ3jRk7d7ERg?=
 =?us-ascii?Q?zsaP3ukSwwCX38T1ESuJfJ4t0bILxTbgcZltsvlgmsBs0NrfMZJ8G0anTpO4?=
 =?us-ascii?Q?WOr+TdnKPC//Yyicy7Fwv0fJe1kXkwc/zp+N7I0x5dQYtJZhpJJoUgq7uzGR?=
 =?us-ascii?Q?7ziQZW2eid39030ceC74UYl4jQKcSzolM6iU+123AD81qSjOgoSTkIEt2FbA?=
 =?us-ascii?Q?Ck8p9aXinOWDjBSKfu5yCG73FhO4RFwyZFoTWIwvh75JeiXVAcrovQDF1sAn?=
 =?us-ascii?Q?ePMjNsowC5cYc9q7tmSUXBJzZMmgc7fdwfXdtNufPiXc/yu8q0VnaDHh+qkU?=
 =?us-ascii?Q?FHnQO34+jPnvcrJJGFOpy7lk9k00zJ063Zfc1R1cNQnGy6JJcYgptONPvjE/?=
 =?us-ascii?Q?viuDcd2hNbSo21rR8U27bd1U2qUR11Nelviw0UZGcslBCbb1PH71YrGr4gTx?=
 =?us-ascii?Q?tRqhh8d12ZxThNbXi9eGhFoaXXpF9Sq9Y7isD7XP67ViV/Pu6TCPX65ID9rf?=
 =?us-ascii?Q?eZ0gnTyJjw1GsZCNhvCj+Bgflv7EVQEv1l9iSWIlOAiYl5KH9xmDGX0Yu+qm?=
 =?us-ascii?Q?X1Sdofu0JNBVcZu22z+hzRUG1gl5W7+e7lhOgTm7QBDXLl4DPylfMlbN24XN?=
 =?us-ascii?Q?XKpmuhOijn04BuOVLS9jmAcMZGmTSBKQOuc71FloUQmZRQDzUKl4tJUUI1LG?=
 =?us-ascii?Q?lRk8gSs+bjxnmgj7n0pWSahPxma+kUw2YhXAloxai58MsOyhEI+XpuW9SXV2?=
 =?us-ascii?Q?Ny8uwoKtF6NCu3vygZSbfUTQfq5umOfGSw1KbMKDq0cX3a7RAv/tAB/PsiR0?=
 =?us-ascii?Q?d3Q1MeJmg9VTWrO4b54//4NLmaVZSuxFIxIqZl+E/FzT2bRHMwfrHIlmBC23?=
 =?us-ascii?Q?TG1zEr+2z123gxsGwE67lxhodxzrTOYcBxX+iCZ+xxVaGT18HpxwWIY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b549PS8XZA5hPwxqhjLDYwPIk8WTnowA8ysLa2HRBctU+m7jLBDeJhQeqHsi?=
 =?us-ascii?Q?gvjeSETL5bpAz/8E71A5O52iOsIYnFYn8FTwFJwlm1/QXIhCl+xeo7l3nY85?=
 =?us-ascii?Q?994TKTKxrj+HDfawAN2mWYDucGwxTIlU/eVe4nJ/i3Pqj+JAgnSiSeCHDRpS?=
 =?us-ascii?Q?IMpnMBE5M3KORhVqUJp+rEoKayM3GBKzrqC9MrBb91JYFBZn8bqES+iRYHG1?=
 =?us-ascii?Q?d7yArlDvt3J5/3TTU6rJ/6RP9Tnqh/FjycAthPa40hN8ts2PAmYPfpMowNI/?=
 =?us-ascii?Q?10JYUHyKfAI5/WcVBbX3uQal5e4vKFk0KLj3z/aNZpdmCo9bQrHgJ7MudyPt?=
 =?us-ascii?Q?DfhsOkjRBuZHEbG24Hq3U/LBjU8tWn276thVqb2zWghNotPP50e0An2yY9EJ?=
 =?us-ascii?Q?papNmpgvlyy90xJUhapNo+8i02W8KuEuzjJ6kj0if9O8Lvq5FBZlGnhk7/0H?=
 =?us-ascii?Q?3WO3EtcQrDgzHaMSTLvCRTMJmqjuaY4pRfdxfU59XFfwlQFykRCr5G11pqH9?=
 =?us-ascii?Q?eSAlWABoFyWZotx+Q1crU+DLT123rzdGwqOHSy9AJw4pd6dP4vWv69mfTS0k?=
 =?us-ascii?Q?4FTS9IBYZHNQZhjwm14T9+Jbrl4mHehnTYRTMmLGIumZd7Ppm32by3RahcC+?=
 =?us-ascii?Q?nVx5v5U8Yb5hgmGIYpwIhj7WpqWjEb0dIRlNRsfSMTd1pfxZFj0CCPogvO2B?=
 =?us-ascii?Q?xPJSkdMlzjYAQRhQnE/qNLB4/Dbds0KeXBHTSyacfgFgHcl6hz/k241aZKgv?=
 =?us-ascii?Q?VPE4cCzkSHmQB28KsdN0l23suWaNYmV27jsnsg5jJHvptuO5ZRnz+BHz5yef?=
 =?us-ascii?Q?69LgNKEwirtLHD9G3XZT25I4aQZXJ8+/hyASEbu7l2WiHdXeOzSorVWDtTKQ?=
 =?us-ascii?Q?H5aZci/CifW8zE6fWmsza9rAisJHx2JZ4A6+OnP+ugxnie+gOfAl2hUq0EVJ?=
 =?us-ascii?Q?DVsdrnUXccyrvQ/RsHZBYhEf/Ax1ckkxj0TRAEPqVOVkPHe1zcyKMu9CNZMo?=
 =?us-ascii?Q?YH3aZGX6SqaIgo2WTXu5RWL1u3kuR6WUo1UgM6ylfRpI+J/QtNhaQaL/yQ9W?=
 =?us-ascii?Q?ZzW8YX9OcDaRiIlgH+BAYD0VsefWsALiNYM0u0ENQao9XBVqYCBD1Z7wnY2f?=
 =?us-ascii?Q?w3as9CX+lIfqx+eP3qaBOAaPrXXzk/xrzN/AKMfXtRAbGqOsT7YJjtJa/dRj?=
 =?us-ascii?Q?oe8rGXOsZY8JIMEiqaikNoByvrQCmEs4ypakbg8FOgXUbtrRpn803Nx0noev?=
 =?us-ascii?Q?0ZxxZ/pLHXQnILQws03BzjCVk/n1+gEjFxm0HUjwajcxRD5WHWDf72zW/18A?=
 =?us-ascii?Q?SGUzeKlwDNEwPqi+8i9tkkQwbUyzvwEelvMOeeINEzyQ0V01uf/QUf5mQaFt?=
 =?us-ascii?Q?ll5nKkI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b839166f-d0b0-4632-1451-08df401dc176
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 18:01:05.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9714

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, October =
30, 2026 5:14 PM
>=20
> In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
> to be marked as decrypted (shared) for confidential VM isolation types.
> This is already done for SNP and TDX isolation; extend the same handling
> to Arm CCA Realm guests so that the host hypervisor can access the
> shared hypercall buffers.
>=20
> is_realm_world() is declared in include/linux/arm-rsi-cmds.h which only
> builds on arm64 (it includes <asm/memory.h>), so using it directly in
> the arch-neutral drivers/hv/hv_common.c would break the x86 build.
> Introduce a Hyper-V-specific helper following the established
> hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.
>=20
> On architectures other than arm64 the weak default keeps the existing
> behaviour.
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c   |  5 +++++
>  drivers/hv/hv_common.c         | 17 +++++++++++++----
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 46ab2da..da6c3aa0 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
>  	return hyperv_initialized;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +bool hv_isolation_type_cca(void)
> +{
> +	return is_realm_world();
> +}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 31256cb..a60c92c 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> +	const size_t alloc_size =3D ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, P=
AGE_SIZE);
>  	void *mem;
>  	int ret =3D 0;
>=20
> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
> +		mem =3D kmalloc(alloc_size, flags);
>  		if (!mem)
>  			return -ENOMEM;
>=20
> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
>=20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {

Could this big "if" statement use "hv_is_isolation_supported()" instead
of explicitly testing for each CoCo VM type? I ask partly because
Mukesh Rathor has just submitted a patch [1] that introduces a new
function that does something almost exactly the same as
hv_is_isolation_supported() and uses it here.

You don't provide the non-stub hv_is_isolation_supported() until
Patch 6 of this series, but the weak stub should allow everything to
build if a bisection splits this patch series.

Michael

[1] https://lore.kernel.org/linux-hyperv/20261111022036.351231-2-mrathor@li=
nux.microsoft.com/

> +			ret =3D set_memory_decrypted((unsigned long)mem,
> +						   alloc_size >> PAGE_SHIFT);
>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
>  				return ret;
>  			}
>=20
> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +			memset(mem, 0x00, alloc_size);
>  		}
>=20
>  		/*
> @@ -666,6 +669,12 @@ bool __weak hv_isolation_type_tdx(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>=20
> +bool __weak hv_isolation_type_cca(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d6..1fa79ab 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64
> input2);
>=20
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
> +bool hv_isolation_type_cca(void);
>=20
>  /*
>   * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> --
> 2.45.4
>=20

