Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010003.outbound.protection.outlook.com [52.103.2.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C722083;
	Mon,  7 Sep 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800585; cv=fail; b=JNbbbWuH5J6atms0IfTGH4aTIzfEx7TX3hM+6G4cadLzxJMiWrD1ymUDQbLrmy5cR3vZqg4txARxLPi8Ii0nbRF+KoELRu1EDEPcKrXAWQzeTfXcrfAn05O2QLMAWBh2ajKg0De+4CyEFdKD+nRKoGL4N0o+W2uGprqsbpChNNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800585; c=relaxed/simple;
	bh=gkqKCU8gfWh+w8Ixf+tCusR8jeb824erpK7/xSFoLXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uX2T4EkTs9shrzYY+wHdi3haV3PEiXvWHOeiHmKQWqR4i9S16IiOydHkd4AQrv7z9SrvgqwlJ7GzHIXtC1oPX74ylvk00WKL8GJ6hhlOAW9ScYB0hKTgo9vfhhgTLubJPy/mBrRMTxqMLkto93V16HqkXUE9EIw1Wo9/9W9mLGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c3A6DlcZ; arc=fail smtp.client-ip=52.103.2.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c3A6DlcZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDXw7hHvFnveuAgKcU7WltsD1fxg7L9TcRNRC1lBGRTL1wfTrjHhtZ+hQPJO15Z/Yd/F7x1QWL+TtbVIDVin0h6NEtMvyNpsfrHEkJ0W12591DIRZUNgVL96iJ92hecR8HVpD3iIakoKkaHljuKS9HHatiYd+64XZkgoxCME9Qwj4JPJUi8Ux1hkCLliJ+cPf8ey34WOrRIOFD9SDoMwRPctnRaxOvh3MKtNJvPvRcdVhEyl8Zx/gD+grP6pnWjI1mNSlXWAvJFhcmtuOEm0nYpTAmJ+KTNycaGBSIn/q2vDwOvqI+5LjCv0OZSntA0CSLISTeREktsfThDqFre9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9eVhRkkvz71uMqNzvhECg1gqH7+uH0q0Tou4sk6hZ0=;
 b=Av2RUu5HPW5QNmxidahw4fU9muYBxiknL0iiaGGyZgirxaEzb7ncbP7bb3r/j4hsFf+iw95KImhE7ISPE1uk38c5ugl992YoqfQv29A2gfJyHKGcgEXJFp+W22/JCW70moWLaqAEKQEOqQLLo2ZiEazjFyZRzG3GY3k5oyrKhsjBbJ6Ep4dKqvHEE9BTuWIKNdUmlCB+crFlzp2KWs68SF/SiRwWThSGpNxR+8yzRA2lr6pyUAtrLyWs9NLIS2axoeIB8t6osqZE40d6VFw9I1MMF5FcBK5/B70Qm1A/LAXll0rro1jgEJ6MFoATcgmimWqElfp4wJBQ+CAmBaHwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9eVhRkkvz71uMqNzvhECg1gqH7+uH0q0Tou4sk6hZ0=;
 b=c3A6DlcZQZx2CTQNulJBb4dmq+TFmFxSEa5LY0CmOHM9kxfolulA7Gun9r72WxhmcjMbqhZgMjA7riiGPgi6zKPTYfZbGUpmR9iuThpvpL5bsD08uvRnOVWMq0ua+pQSg6Vf16a2gO0lTMzMk8y405exsph1Avb1FZ6NETuba7eoy/tk4IvIX7ZqYfZnDAVzllPuHIeIUenD16oQmFNpQlvAKJaDE6UShy588Ng8P1hb34l1SnlI//A7V5sx2Bq2crpFsHA2x4euTW8S+2Gz3Beby3IdRVMHb/1YMRwCYprvHGOdSrQwyMpn4/WIyRBYox5fAt0FP9Uigjb4C15d8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9933.namprd02.prod.outlook.com (2603:10b6:303:239::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 7 Sep
 2026 17:02:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 17:02:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: Remove !CPU_BIG_ENDIAN qualifier for
 arm64
Thread-Topic: [PATCH 1/1] Drivers: hv: Remove !CPU_BIG_ENDIAN qualifier for
 arm64
Thread-Index: AQH7sa8dnqV4RTQVc/XkoqPH319zIbZ2f8EAgAAcWcCAD9X5oA==
Date: Mon, 7 Sep 2026 17:02:56 +0000
Message-ID:
 <SN6PR02MB415769FD3AA18318F4E755C7D4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260828034448.8291-1-mhklinux@outlook.com>
 <apGNvkZMlYccBNcv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BN7PR02MB41487D42F307392195E5BCD2D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41487D42F307392195E5BCD2D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9933:EE_
x-ms-office365-filtering-correlation-id: 27a620dc-3a11-4a71-b5a5-08df0d01dcfc
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|8060799015|8062599012|19110799012|55001999006|24021099003|15080799012|13091999003|31061999003|51005399006|1602099012|440099028|3412199025|4302099013|102099032|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gqYzsxIs3C68liHETcfMDMgPFg2dfTvOxw8xQD1Q46fpZ/T6Rs4twvZ/cLG+?=
 =?us-ascii?Q?hohoneN3tKkeRzCxiDW38SdK8t7c3gq5kBSSGmeRyXALUy7kpZpJ9yl9bXB+?=
 =?us-ascii?Q?VRsp/aPbdc0U7P+w7HnFN23dnBEz7Hmf8ZjRBsPVGJrhkDJFuSdIBUkY0nM5?=
 =?us-ascii?Q?uxytg/JLIf5ODLbVv0xvBdKKNoj5kEcyNUAS4peLjb8PTVASEeGBFpClQDXy?=
 =?us-ascii?Q?lrz3/HpRNoT6ung4JzbYyxcGpaStmNxpejfDDI/AS0yC2cCbprrj2FQ4Yom+?=
 =?us-ascii?Q?ZhlsEo8FkUSfmpLkW1eIUMUs0s/iGyqsYtSy1f8Yk3wd2zHhgbz57uvFsDrS?=
 =?us-ascii?Q?85o4Foq4q+0cQ/MhD7T+PUrtM4az94fY6GhW4HNNA+m6CtxLjyuA1DPjGPAT?=
 =?us-ascii?Q?4IsETKFYBlVEKjRYPgq7e8YWzMyJFB35ELyOntlRLjkRohZzcW3kdlDIDkW9?=
 =?us-ascii?Q?3qlS5HIcT2O8X7vNq8pHxThO20cXsqcP1S6HDfQYrM6FZVFeVAcPzWjoKhoy?=
 =?us-ascii?Q?oxvBVVL1T/EtPAGSUkK8WSZHfo2dIzKYv2JonuSoEiR8oqEehfD2ZXIq7gKQ?=
 =?us-ascii?Q?QN9ZQVMylhUn/eZqq8sKi+K7QDhgoMBiaK+wfHVT2fBELoe6L+h6H0FfzEbP?=
 =?us-ascii?Q?hxZlENxTG5N5bE3yBR7t8hMPqE1rbWXsc8Hu5pg0ySI0oQpGKdRXmnfXtirG?=
 =?us-ascii?Q?FZU84eAylERjH5ipkzR8Ts4838eI99oC1pZAk9HAmBQrcXnepLE1n477VxFW?=
 =?us-ascii?Q?rjcYAV+FCQi98YAtJgRmghIcGjf3XqjUlxl1vSszSndMEXGAG43p4IyiRe6r?=
 =?us-ascii?Q?aM8BBOq5IjTf7R8xxp7QW62s851kWz+/JdMr5VzioaqRL0dlDvTrB6uchlXw?=
 =?us-ascii?Q?hu1NYtFZyJAtPyajdYCRUKXt0Cx9oSzySL8a+1CbxQffCUR+hRLv570S+DL+?=
 =?us-ascii?Q?VMhkRIvUcs8Bwg8E1s2A/V7PpxJb1u8jrul8dhzG8yOYvpBrPnVekMIIGqor?=
 =?us-ascii?Q?QzMlFHbGBCvotC/uR2ve7T0EUmhydgFLNWnnx1EYaD7XTvn3dFHXYR/tNjqg?=
 =?us-ascii?Q?kWMkwmgiTXTo78piBaO0fnrHSSGobKl2QwDx0TYDgAS9CQcQyIhiQ1h5vAok?=
 =?us-ascii?Q?tSwY9aqaZuyA?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dqsJcJ6nQww5O1mCnlrhkPlhnjVMz5yIz/jVLImpe5OWLASyOvgROB6eLvXR?=
 =?us-ascii?Q?hAM3YX261zLZ4PfNQj0Z/97rt63LhN/6LKRyRlfwIX8pzf/MIBLJTicz8gJt?=
 =?us-ascii?Q?42YeMwYxDvf8toxFuRNZ9XADarh+qC7MrSFIQpBjzuMQco6UEwW72ACSgKss?=
 =?us-ascii?Q?MWKodQd5pCNYkMvY1FXKr4c9zJam9DpGMiu2mZ5dd++IhYaB/M2RvxTDfyXQ?=
 =?us-ascii?Q?TAAFeJ6PAWqc5aX4VT2omlj7CBK90vzpBWI+Yhb8HSfAsnjwDTTwuGsDCMfI?=
 =?us-ascii?Q?Wn5+hvRQ+QUUmLvPZqrPhDN9Gem0qZRuvN+e33bELvWrnif43cwRGVtLuhsL?=
 =?us-ascii?Q?+s6TemDrePrOB+Pb4hqDPQxo+10ol1CUc998t5lv4uTyFbcUFENUEne3ad22?=
 =?us-ascii?Q?RCKcZ4o0s2mhf3RoMEn4Kd2oOly4sTn/ZM8Nr1ew91/RgitY8sjLVN7AMYap?=
 =?us-ascii?Q?IwlTVgEiQL1pjmAu78RbDLH8w+KyBtJ/SL1AH17XKVebtwJtcBxFsXcOPn9d?=
 =?us-ascii?Q?JoMsKhw7Xh0QwCnbMbpbgvEA2YOzMfX143pHQCx3tTFGwqrtrpDSDVeIQm+m?=
 =?us-ascii?Q?SswgfuNtPAZ0e/4IGQMn+pIO0UbSFxTXATpdw8bsopf4Zav7Ixc6vCbOzmpM?=
 =?us-ascii?Q?HP4D+8Sj3G6voL9wkAV1OF5H8wIDfCy5zktj39SJvY1n0FN1i1KeH0bD/TYo?=
 =?us-ascii?Q?ZgcrYTEheDuaHR0LNlkuTCdXDXP+pDVfJHH3Nl82T9i619Mbr896xKsuwEgh?=
 =?us-ascii?Q?n+v2MXMlxV9K4eMH3PGJ0zcWoVFtXjvhl1vKPfOYSYKEY/HFsRXEFpk0fgVQ?=
 =?us-ascii?Q?yggVVlSJ2HYb6nMsBOTbnyRB43jK103LnlGP8rcoGrSw6DvCwf35MT7iS6tw?=
 =?us-ascii?Q?yLn313gZzWDjKxhBWwng1X3jstgYYHQNcrONsZ+q4+vtf21SOQtxdIe1Z/j0?=
 =?us-ascii?Q?LZCj21oPUebgBLNHn46gcjchcUqWWToJVR58sZu0UAYudQowYr7hsdMj2L6P?=
 =?us-ascii?Q?aHkJIClB7gqNXBYVRrvWF/kIA7f+SDXJ7KA0euj5OmphgrmjPg0L/hyawnS+?=
 =?us-ascii?Q?wiVye9ca4b6QxBF6HMJPWceZqiaYzLrhAhjYswVEm6aGLQWtX1HUD/zyuIZP?=
 =?us-ascii?Q?4lnSRz7zsbGkBiKkmwXYieU5ik39kaD43RArjTluieZOcunOZ5Jv4xFslESS?=
 =?us-ascii?Q?a+nkxVPIupZmu4Xef0KVN8NHpPzrVpeJfOEJoULZVxe7059cBjQUfSkfGl8B?=
 =?us-ascii?Q?sraGEIGp8gOC/6eWv0ruTiBFyheiAqHdzVOooaTkKkvAZV4a3sVsCP1DV83q?=
 =?us-ascii?Q?Ox4bzF0eyd/MkDkjjHk/Wdl7g/9pw4GRGiDEiNUG11/m7Xwbt1cxFwY3gHID?=
 =?us-ascii?Q?UaX4Efo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a620dc-3a11-4a71-b5a5-08df0d01dcfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 17:02:56.3043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9933

From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, August 28, 2026 8=
:13 AM
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Augu=
st 28, 2026 6:32 AM
> >
> > On Thu, Aug 27, 2026 at 08:44:48PM -0700, Michael Kelley wrote:
> > > Support for CPU_BIG_ENDIAN configurations on arm64 was deprecated
> > > in commit 1cf89b6bf660 ("arm64: Kconfig: Make CPU_BIG_ENDIAN depend
> > > on BROKEN"). The support is now in the process of being completely
> > > removed.
> > >
> > > The Kconfig for Hyper-V guests on arm64 currently has a
> > > !CPU_BIG_ENDIAN qualifier since Hyper-V only supports little
> > > endian. But with Linux on arm64 restricted to little endian,
> > > that qualifier is no longer necessary. Remove it.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > >  drivers/hv/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index aa11bcefddf2..db8464fcd119 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
> > >  config HYPERV
> > >  	bool "Microsoft Hyper-V core hypervisor support"
> > >  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > -		|| (ARM64 && !CPU_BIG_ENDIAN)
> > > +		|| ARM64
> >
> > Personally, I think we should leave it be until aarch64_be support is
> > completely stripped out of the kernel.
> >
>=20
> The removal is in progress -- see [1].  As noted in that overview,
> some kernel areas have already removed the big-endian support,
> so the kernel is already irrevocably down the path. But there's
> certainly no urgency to do it here as it has no operational effect.
> It's just a cleanup item I noted and if the preference is to wait on
> picking it up, that's fine.
>=20
> Michael
>=20
> [1] https://lore.kernel.org/lkml/20260811140132.22778-1-will@kernel.org/
>

This can be dropped as a separate patch. Will Deacon is making the
change in v2 of his series to remove and cleanup arm64 big-endian
support throughout the kernel [2]. He did not have the Hyper-V
change in v1 of his series.

Michael

[2] https://lore.kernel.org/lkml/20260907163726.17104-15-will@kernel.org/
=20

