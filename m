Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519495;
	b=hJUeviNvTtILQmQOa9iN45gZEyFKy4yw1oEusCsNWpFEiy/N6puvqCpBZJ8NtTh1zCAH
	 9AUu4aReEZNYyLfheEtqiolMWcpFXvU/Q4kE3PHG4jGtdJS6MdS0V7LSnzUWTPVnXXPWQ
	 bvyE1amOKUpuEg35PNr7QSByKNoY7wxA/IVTWS+YVm8NbvCfApwNpyXeutoYoCBHduGNB
	 eo00mxSaqxMeLCL0ltgD236G4H/NbqZgANV5M/Ry4sRqUZDK8tYtZLyh32u4WirADvZwC
	 TOCXspkkwOSPcXsNK4peJwuGNbBgOl5p/dLnUP8347VX+ZJS9E56oqHqVTJg6GMmMXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519495;
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
	bh=Up8Y6kKyLiZARfpTNsHw2+u8uh2vAyQXFgzMN9iAZAo=;
	b=lr7oYPIlrk+a4OnAATGv3ztBqH1ncYDgltRm8O2GXhyDUxs0OexbrybwUfNMN0Hxrw2n
	 bBCYeDo6+chILl8w8lYuUs1KIfAo0GWcRxvyIZT6V9+b7snN9sAlwOpJnLeFW+/FfisDd
	 uBdYQ25KQMbgXh0ptHRNm3FNsTJNw8g9Ob2XmRMMdC6aItJbBOxI7yZhGIwMt1vCpZVu1
	 lqkrUj5MHS/zqrEEk53AYH3VhS3GzvbbV9buCpoXIxOeObaPn4+DvkewenO59h7FYXaJH
	 eQjjGEsPwXVl/g8UFey3ACVwrv3D5NGkWW45MJzzi2fLnDbgvEKdZo4sNluImH8qnLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BDCKsH4c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013078.outbound.protection.outlook.com [52.103.7.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D046606A325;
	Tue, 20 Oct 2026 18:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D046606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BDCKsH4c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+8LD59qQjMaszmE1IVUQphCel5fWoBC6D95kSEAnlbCJgPZC9g5dAaBRvLmz2YM3bbq2q5CYkNQlUpCgoFgHDCLg/lW+ZkJ1vC8NRWIiO4TksyowQ1oAJxxMIzs8KTLo418kdpOqKC4OjSebs11i36tEtwvUeo6UPuoQUj3Lk++hiDfYTZk6erQOClrqv9g4IcbnYZP9MeKV06nOWZVC7biBO/dFE6s6XLdutz4O/kGkyXadWOwD0L6X+avSK4ytIcjjg4xckBMmxSEjfXzXMoG1luFlGymoHCGsg1aXN7JGFBaT/5PIrs9PopSRJpk9Ia5B51vPaTGHRGm13zE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up8Y6kKyLiZARfpTNsHw2+u8uh2vAyQXFgzMN9iAZAo=;
 b=CmRCUMi0JWOxR8XQtOAvFpyEScQLYn4mSVdlyg6sFcuZS0MBWzVVjFcFlZvdVwZP3W4WmuKLNlHTNxsO/bCB0j5I2Bdqe46luKih0Ru0RhtbrV4PzLefa1SLAdeTTpIYVXw5zU1iGojJqFz3ci7T7USXQF55Ow9z3k9kVUxoR4vUE8MZa0E88Rbg8ZyoPWcfTVQGY6rvCZnYZszmr8YwRsPjnCLN3piTpuM7CTFPSU3cG5lD6DpsA3ID3Iq0DWJQmBtg8LSkjyBA6ZxG4+CJ8bn8EV84LeoHHbxZ7vOzJrKi6H506e/BP4KtzRX5q1PtumgcFM4Iem4+c2emcF4P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up8Y6kKyLiZARfpTNsHw2+u8uh2vAyQXFgzMN9iAZAo=;
 b=BDCKsH4cjFkScUe+ha6GheL33sqMAde6B1Fd2EW7RQJE5nHPBWM5S6a5MwEqxFJ7tHeWMIPKKaFrWIeKg7EdEXQFyglZByJmlwt5FScCZBoj7nbfJcSgFOG0qAP/qddgmvt1ulaqtcR/6MgaJ7CaZmbNI/Naua7sCp60kRxIfjcwA+xHXu0+HlE9efXCqef3EJq+cLkvQw3HKO2ZkUZLSDLOS3C7qsLXsCD6HY+EjgQCRVj/ezLbGNlIVLaYUjt/NT9kDwG2ztxXXoh1xOdYMfIAOvzmkjzssImKyLypuGw3TWFTQEBcyhlAZa8t8eqZJOuRjPA074La+ksi+Mm+5Q==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN2PR02MB6928.namprd02.prod.outlook.com (2603:10b6:208:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:04:29 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:04:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] Documentation: hyperv: Describe validation of the
 ring buffer indices
Thread-Topic: [PATCH v2 5/5] Documentation: hyperv: Describe validation of the
 ring buffer indices
Thread-Index: AQHdYB77N3oFYeHCFEqqg8wamzyEzbcGuqYw
Date: Tue, 20 Oct 2026 18:04:28 +0000
Message-ID:
 <MN2PR02MB686317D05DF1C791A8A9558FD4672@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
 <20261019230950.1573677-6-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261019230950.1573677-6-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN2PR02MB6928:EE_
x-ms-office365-filtering-correlation-id: e40703b0-cf2a-43ac-4dac-08df2ed495ba
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|51005399006|37011999003|15080799012|13091999003|8062599012|8060799015|19110799012|55001999006|24021099003|31061999003|25010399006|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NuUE/Cdi+02o3cW3ZUmUd9oRJbvYjgdGGi6FSPdg96sS6u2Wi/fTT2UFwzDR?=
 =?us-ascii?Q?lzCdKyApp+T0k6nOhyH0ofotsxH44vcwgY10EtMNuDZ1wQgx9b6H1lY3LBGZ?=
 =?us-ascii?Q?tGWZErpnDDEXvCJ9kuvzki3B8+pTtCUGexmYEoycxTQHJP7Hlm16ILFbJIik?=
 =?us-ascii?Q?Q5r+3qA7YQ0OusmUgW8VQpieXeMyUV2NthxwDV/zbb61E82LbXgJgtewSYaB?=
 =?us-ascii?Q?G/9qbdmOw5jZKK4IBkWweCODxGskWuCoPu9w6vt9JeX/UNkARteszY8QbREG?=
 =?us-ascii?Q?oQyd1RD5lyHsak2eSNIrNDmEyOUYn5NXz49YrAT1XMu+fq54Y1SecaMZ5AOC?=
 =?us-ascii?Q?yvgQf2KdMtjR6Zyp+LlE4FcAvqd3ihH8lzR78BMnXSFkwij+75+HvTkc52+Y?=
 =?us-ascii?Q?xCPz/P1rdAQ1YFbJnNqYRdcfX4B0KC67/hcBsdpDjZMlanbSX/YGglPGWuCs?=
 =?us-ascii?Q?mWNi9GuXFRTFEFq5LnSb24LX59YHPpePJ9bvN1gAppkG3+c/34aKn7+kV4e9?=
 =?us-ascii?Q?f//BOloki1f6/vOCYEN6/M00FY/syjx3vJ6TYjwp2HhEUIl65H18dfh2K1Nk?=
 =?us-ascii?Q?Cn0AdNF7kAEOEaVuAHG7enSjkdwH22Z64l8ZVqjGwD6rFNlNJryHpZuHhut6?=
 =?us-ascii?Q?JN0wKn8hoRdlBnUizS6LZZzYUZKsMrbDNyGscPwPwWgzoCnFqK4lWFu+/PAo?=
 =?us-ascii?Q?27LHjap71GarQbIUivvQNZWxeO+G7IgmBpz5p0/KS6M5NTUdbcSWzgVfdyEC?=
 =?us-ascii?Q?QpCiSLBKj7NZqjPSg37fsSXnq39sEsvVuT8vtHTcueg7sFg6BrAkxBOObVdR?=
 =?us-ascii?Q?kE/MXI/wUsgJVogO3Q72JTcQMGg7JiyQDl9Civ8axk7Tv6ynM9OFvYjNHa5V?=
 =?us-ascii?Q?DoYp2IKq8ywAluPSyFZsBGp/302i9iaMDpOeCFC9rhSNOFUI+izeOTjf9daU?=
 =?us-ascii?Q?ryiAXDWwcyzClmgeqg9w4QsxD5IBsJLWGGI/VbMFLqz3JU7OWUsDLzWAIRa0?=
 =?us-ascii?Q?c7w9gqvJ+LkffkliM0s4ucnZ9wsc1cPNkA/mVt3jQLIVg+/9Xw/+NJcRTPMa?=
 =?us-ascii?Q?HwBT9jxr9aCGCms6gGyMfXbyhzaBCA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5L6LEwi+aH2ckfj8eV9CVbJja3jxf4aUNrjF8WB8E2Us1oSo68uvcHNL9nlp?=
 =?us-ascii?Q?jf37ThmDPOOWZucZfpbnQxI4jUS4qeInjLDK9YfMh3MKR29gJMNe9wvNR0mM?=
 =?us-ascii?Q?+9zZWQ6/010aJViA7HCRc7daKlLEVrf1QxsXcHX1tkjWrRCH+Z7c+F+04DnQ?=
 =?us-ascii?Q?WFr9RV9YAZ3cXFD6OfhVMbaSmRK75BRja4WaEVy17lXcohq4ILpRRriHqoGu?=
 =?us-ascii?Q?fd1dAPmm1jb/0Co1HD2qvRQeOY6WjvSMqYfg9jqBx/Qm5VL7Cq9cF0Z8AaHj?=
 =?us-ascii?Q?zugvOv6prEE/ZrCbsDUo/gXTMO88bmuEC1MBsUsAw4cOshgXhlIviXkQH7BE?=
 =?us-ascii?Q?71B7OmuFAixo8TbahrywOh0gfBiiokXPnix9QlHceMeYfS0Bsh6yygJNLc4U?=
 =?us-ascii?Q?AQkUYdEd9FjB1sc53IIzrWaxC8iVI3w+tzb1bqfKYlGNZSVUfoAKOYZ9kwrU?=
 =?us-ascii?Q?P6i2RAfYmURdlldxhFxvl1vtZPeNZp1KwUdZoqZHcSzD51I1ZdZ/jiljRz67?=
 =?us-ascii?Q?56sWyyh72Iby1EFJAbg+frJCHWAi3IpxRgZiJMkFcSLB3p3KDXKSzDZOtL95?=
 =?us-ascii?Q?S/i1eTvYlMUPjg96k/9buNg5OrRE6SKzluuO0kZoPmbrcWebOTGTZ//kOBgK?=
 =?us-ascii?Q?2HoJDyoKSA29FPPYTcrTOoIjblI+wUeZ0lS20lHFhbDzVJXpUR49eHyLtYFC?=
 =?us-ascii?Q?qMgFi3/dZuwbXH09N3xjShc+y36eZ7ubgq/zbbzAqkk2WFDBZqmcqW0EFkjW?=
 =?us-ascii?Q?D6/kYUo8iG7HB/5Q2xOBf6Fwgkp7lImlDSJRx2cr8bf/lQrYIZbDQXOBIg19?=
 =?us-ascii?Q?UdhecFQxeKQeiEWr6MDN3saEUcTkFrTL2tcDEvJAzShvtu2Amx1PtU7b+j3A?=
 =?us-ascii?Q?dAZ5B733vJ8he5ZteYFN3d9ur3z3+BoqA59lO6i5nOwh4JsVbpa2E6H3vlaA?=
 =?us-ascii?Q?kD6cEkWPYaDXFqo72Cwx0xNiUqqfcNWfYqWPMmiDm0xQvNa/jvxQ7EL4U9YE?=
 =?us-ascii?Q?vT2kQV+IGCuErnHO4G2uyYlYdnf2ogh+UDTkKo+PPbNUlNT0Q0p6xF0P/lPM?=
 =?us-ascii?Q?HUMxqWc6fo3t6eAs295LXZDob+Vv64ljzRctuDrHu26oHvVnOWXSCfY7GMxu?=
 =?us-ascii?Q?wa/o2rwwiYtGxOu0mu5Kinj3WZIC+CN1xbFA1EBAPsra9s1wyWZFbSHXaNHS?=
 =?us-ascii?Q?tbxan6bmyKW7OcopU1gONy5v0aLG2951wL7MfbcxFCR0RC9I39l9U3fGpBz/?=
 =?us-ascii?Q?SNh8ow8pi+1xH42tSsoMns6crTQ50Fex+7KYOMf4g8OWjGz6K39rfJDrHX6j?=
 =?us-ascii?Q?GP3ziz53z2/vETBI/H4gi58+pnyBkDL0ED33u39WimQynHcJPVzWDbLAVBHk?=
 =?us-ascii?Q?jvyidWQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e40703b0-cf2a-43ac-4dac-08df2ed495ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 18:04:28.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6928

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Monday, October =
19, 2026 4:10 PM
>=20
> Document that the guest must snapshot and validate the read and write
> indices before using them to index into the ring buffer or to compute
> the available space.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  Documentation/virt/hyperv/coco.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hype=
rv/coco.rst
> index 3231e51..3e20249 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst
> @@ -200,7 +200,10 @@ validation is performed. For messages passed from th=
e host
> to the guest in a
>  VMBus ring buffer, the length of the message is validated, and the messa=
ge is
>  copied into a temporary (encrypted) buffer for further validation and
>  processing. The copying adds a small amount of overhead, but is the only=
 way
> -to protect against a malicious host. See hv_pkt_iter_first().
> +to protect against a malicious host. See hv_pkt_iter_first(). Similarly,=
 the
> +ring buffer header is shared with the host, so the guest must snapshot a=
nd
> +validate the read and write indices before using them to index into the =
ring
> +buffer or to compute available space.
>=20
>  Many drivers for VMBus devices have been "hardened" by adding code to fu=
lly
>  validate messages received over VMBus, instead of assuming that Hyper-V =
is
>=20
> --
> 2.45.4

