Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012011.outbound.protection.outlook.com [52.103.14.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF8440641;
	Fri, 28 Aug 2026 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929998; cv=fail; b=KsmnVGlCuxCo4QEgxMv4jBWb7N+L2AlBO7feYRR8XKoOvrFd9Oq0SsXgCnl90c8SR5BnmHfsmf8/+zPmaw32xfnSVoUR5o+GX//NdhcOkWZfgPsjvNWxpqUxNWtuiiKNBQIWcYBH+zw1VnG8LCWH/pA8M2rt7IOjPQ+xqa3j2Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929998; c=relaxed/simple;
	bh=J6iK98UF0cygqfaENV1SaqdUs75fZqLyuOYlkCZIJe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUf5nB8SAFEsXQMTKX9AN+v4YwHplqc9astRpaAhzGMYfp5svAQbjgDMMyqlrGq/dMu2bVo7ZPu+LhJoVU/LKOcDLRJRflEN6WyCIV25PsFYezcCPrG/OaKRCCu96TQj2AS8wXwKergCOkMfymc9DMpBophhzgqLD13pWKNl4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GCEQKjUL; arc=fail smtp.client-ip=52.103.14.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GCEQKjUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV4CMa6oMk/ieUTBuodXYc72ISATZxbDqggJcJcjIqlnidrAQ1YgEKEzYqPJT+8hTYucRnRwXcF0pV+ApiER9qy8lFs0Ntrg3Umd5w7c47aw2P6T5FdCNrxAz0ubci8lZ3KxqVIzb3+sh+7+mumv3Pecvc0A8/SzmddYIz6DTIe2fnTk8kv8f4a1B7TcGHo7NcMDSTTEaf3QNTUd1lT+SZyMp+yRvdE252awT6PR11GihF+T6R3PvKVaLs8Z2ou7wefdf+Tt9shioQDqxDmoJPSZdTZMCIpYboBVFeJTo/TzMq1smmQNt8GEjn8blRzgh3gZ0IX0tSaySHv5mNjLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLNBYioyHz//GDVHnxHOF8GlqgXpVrZMC5lpf9ElVDY=;
 b=vf+RlxBC5hkzYkd0+KwcyzlnwApJEzemAj0PdZ362rIJBNuabb4ykOsVeDbq37ZWGf7DM4eEj9e96kOVfcce8OUL4nqXPFnWbHkNxSRVZv8Mq7L16YzeLM4KUNptVZfdSdblfsZBTIAHBO7e9NChussh3kYlvRcjBDbvwkJJdz23Qh3Jj9kptRBLnqp/o+GDvBlyS52r20UFQiIF9A1/TtDcjbhYLUtGG93OcxVDthjBSEVBYxRwxe2aq3Z8WjXx7p1SIgbiZwiNClRxNWyvOJJejcb7qcMWvLYguv+fjGJaKXlun/Zacefaf3HpVGrTncbwdInK4hvSndpFfur/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLNBYioyHz//GDVHnxHOF8GlqgXpVrZMC5lpf9ElVDY=;
 b=GCEQKjULQWnrfZN8AkyYlSdbWbvsfnGAqDQIqAHqR3gGnvt5d/Pl5rrxEoftelAh0YQ9J1bIK/dJMPDVTSv9ZWpOx2fCVDcs769C8ySoQsSukeOq/ef762TiR7+Pp+tfsEtuJBL5L9A2tDBhk2+Sjw5u8s243p9fr5AzdrIPUgti8NxWOibAWmLqlwrGUHMSDIFbBUuYcwsWGzpSiMnI3CSkE9diogTn1dX/hstCuh0+FfD2g2FRLFLL8Qf0O1yW5AqN28wvAEWNPMraPj83uvt6nK2XqriRKeThdRYl1RPeO4RqSi9ISHfswSsE9leLsZtQmJU75Yj+9uzswidWkA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BY5PR02MB6882.namprd02.prod.outlook.com (2603:10b6:a03:23b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:13:13 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:13:13 +0000
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
Thread-Index: AQH7sa8dnqV4RTQVc/XkoqPH319zIbZ2f8EAgAAcWcA=
Date: Fri, 28 Aug 2026 15:13:13 +0000
Message-ID:
 <BN7PR02MB41487D42F307392195E5BCD2D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260828034448.8291-1-mhklinux@outlook.com>
 <apGNvkZMlYccBNcv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <apGNvkZMlYccBNcv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BY5PR02MB6882:EE_
x-ms-office365-filtering-correlation-id: 34e6b629-4807-40f1-c24e-08df0516e158
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|31061999003|25010399006|15080799012|51005399006|19110799012|8060799015|8062599012|13091999003|37011999003|440099028|3412199025|4302099013|102099032|1602099012|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dD8G4aMr//UpW/vcWSj07VKna18MMkeSk03zkQOqx6L8dQibZkEKkdPzR7Rc?=
 =?us-ascii?Q?Gj18UB0NDN5N2mJYpiu1cV2tzQYDufjCmG+PGAFa1NaT7kZQiaT6ZiN1uYcU?=
 =?us-ascii?Q?jUxcVAb8PA3eqxClTwNPk/Ms5klwDzRj6oh455NTiSkR3AKYBqiegRyP9lAa?=
 =?us-ascii?Q?5YwhHxtoWYPN3v8EzqE2RmtbdxMMRVep5NrrxE4gRsmsUjO/bSNWpWh5XCB0?=
 =?us-ascii?Q?UQbtm8MxQishFP17FVt1vyy8+FiLlkJRyRSgboMmn43ZTtYW1K0/Tc9QRUFU?=
 =?us-ascii?Q?KAvhf6ZJm00xaPC3rKPptmRgJTKhWBUmfQWhzmWSqe/qE599cRRt8vcb7rwT?=
 =?us-ascii?Q?QHFqbv8GXaozaBU5EXI/tiOdfjwUzpU8yXoshkwGYzxsITfQBMPBTDhIj2eS?=
 =?us-ascii?Q?wGxFui0e+nn1MxCXWOc+Zi1+4ngtrNGYYxvN8wLbAW6bIf89IY6qjStV0dEI?=
 =?us-ascii?Q?uwjYZ3FC6/Y0376H0A4u34m5KUSf1mF3ZuVKXKKFtTdp6ue0nTdUzddbW7bO?=
 =?us-ascii?Q?dgfpda4WPHE6fmpfA4+rqwgUS1pqfq+VzjgjdSMjS1Oy4+J4k+DnU6nid5Bl?=
 =?us-ascii?Q?4fJF+HJ/kvpFQEyrG1o4V2qDKM7Mnc/SjOYHLMjeAoXMV+D8amBZpf2DSNQL?=
 =?us-ascii?Q?FEV6yQ73sFj4aDl66sp6HE5iWLTMaM4LDcjwhwBjJp8TZ7G1oD/seT6lq/lT?=
 =?us-ascii?Q?0L5r6tDLI5FeaRRVFjaE8xOy6ixPasd9SKMEdGFDz9MK6/QIvLuQXEn6MAsq?=
 =?us-ascii?Q?KKaDkTgIBMgd8BfdLu6YOc7BNlwo6f8qJdkGO6scY5GBDtaAsLorUOOjD7bO?=
 =?us-ascii?Q?hZ2YZMEcsIbgt+QpiUQ/4RRQWxHqElBlJWedan59AUJhb3dM3cxtPenJ3ZBl?=
 =?us-ascii?Q?q6sSteAlWshnVYCpZfGRf328stYZQg82awlzFM/b40aHel4UoxMJ/NZ+I8LD?=
 =?us-ascii?Q?YzEFHu8zANalIi/YrzULSA2KhE2hmHzd5CJ461z9gI8z9TWDRaLaRHXwK/+M?=
 =?us-ascii?Q?uGUxdOBY3SUOitHIOuzlijMl/M33F5TevGim1i16G4DwP/oHDRWvNG13nrH7?=
 =?us-ascii?Q?Cn9qWRwAufP+t36/U1NzT4NTy34SL+G1s2/Q/8b9ZZUepLS5tm1JihJ/RtvL?=
 =?us-ascii?Q?z4fabew7J/vH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xtSURaoMOoGIxfIKYJnMoPVBnS/QAl2/tqzqn2KRzaAh5DzBqH9z+LjkaqW3?=
 =?us-ascii?Q?NQZlS+e2cmzhEJf7xOvoraoJdpILjgyPby/rKSJWnhqyywumyjWN/cmo2WCY?=
 =?us-ascii?Q?yrBbD9UaFNVW+Z3cOvUd0UN7twADfQnPToA1qKxEx4L6ijprgiQYji3Vrnw0?=
 =?us-ascii?Q?ssWsVP8h4Im8km+UZ2XORIMcrR7120pkSbXv2SQzJOdrMvi5o6BCg2HMiCND?=
 =?us-ascii?Q?kCfC2oU91kXIvzfMskIJUhDxxOrZ1u81TzopV8rO09SZhKi1e+9nQAJnM66r?=
 =?us-ascii?Q?sh/dAoof6camwGYXyzsXmqC3wO65XT0+6yHHIbIwM+Rrq96Els8frxDzPP2P?=
 =?us-ascii?Q?3wIr8AJco2YiOlDJZI0+zXHyI8+cftvTtfECpM0a4ti5UfNLLtKBlyL4/J7U?=
 =?us-ascii?Q?+nYSpwr5Yt3agOymPctTAJ2kpIEL/TdxWNmGo+lTtJPRPoiOseVJvi7mknnU?=
 =?us-ascii?Q?bz18ykbNai+zsEDNFXB9ZVCrrNP3/FSRZutRqabDhfP3P5vg0A8J1hEUfMPq?=
 =?us-ascii?Q?0d9RPwV0H2cVRezH4hu9McqzXkxl0zGl6zeXtOtZ4pWhbmWLz5SDovVlH6fw?=
 =?us-ascii?Q?s/G3aF7Xye+9zLRcrgAuJ5q2QFYJD0sV/vjHLPLUPqnXYbQuuGU2QIHkL2gD?=
 =?us-ascii?Q?VVRS6djQJa67ImwkyWeOMALmvOxOLnKcMY+f7jyf+36P5n30h1fHcAWikou5?=
 =?us-ascii?Q?5UC3kvoC1LC1tbZL9sFE1cT0CiqL2o2SWlKzAfWxuGBMF4GN/gEuHj7Kwcxo?=
 =?us-ascii?Q?8sTjq8XIdoUoAS5mHXBg63EODqctD3IapKoLlQY7EAxyFOWnyWMukUAQEOdd?=
 =?us-ascii?Q?B2TQ/GJ9VKSRt6KWej4FCP8sCf02/soLHlgQzqcNtzxGxAwVUjvDJTtkMD7R?=
 =?us-ascii?Q?xbAq4Bh7nbvNvxzavyWCussZVEVX4LdOFEFIkt/r7fotGWHvTlmfZDal7blp?=
 =?us-ascii?Q?onSiAD6mtsqvaC/Gl0p+9G8+hBfiedAg9E71nmBQzL7aLezTuypXC3MHz2Zf?=
 =?us-ascii?Q?6p4tHMioDMV26EO4Jh2RnH6x/NxO8R4nfkuO6zw/UIL4Enm47wRWDd1hicO7?=
 =?us-ascii?Q?//7PjeeM0bIKVdAcCvl8O9nvJykDHB4l4Q1D19CTTscfKQsYUaZBs5w0ceb3?=
 =?us-ascii?Q?uLLoOkoSeV01G9OKAHHH3WiIa8x7+yO7/FzXNRGZjfWjd3XSbE41m8ftcJ09?=
 =?us-ascii?Q?ODqX0Z2pbZ+5dxSsdMPw4J5qFzScgLnTvniDIpw7Dc3+Ww1NUAaXBoZD4Fvs?=
 =?us-ascii?Q?czo/ahRzqSLCcsnXPiWGeRqx1F8lfTN4gzy5t+jrwjPymwGrjZIE3ZnPYvKp?=
 =?us-ascii?Q?0BnkzEtHFHRO7qrshh7QQc0kVXNp+TXGedvJPQA53FXSN9NXOCJGpDCsPWfy?=
 =?us-ascii?Q?qup06VA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e6b629-4807-40f1-c24e-08df0516e158
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 15:13:13.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6882

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, August=
 28, 2026 6:32 AM
>=20
> On Thu, Aug 27, 2026 at 08:44:48PM -0700, Michael Kelley wrote:
> > Support for CPU_BIG_ENDIAN configurations on arm64 was deprecated
> > in commit 1cf89b6bf660 ("arm64: Kconfig: Make CPU_BIG_ENDIAN depend
> > on BROKEN"). The support is now in the process of being completely
> > removed.
> >
> > The Kconfig for Hyper-V guests on arm64 currently has a
> > !CPU_BIG_ENDIAN qualifier since Hyper-V only supports little
> > endian. But with Linux on arm64 restricted to little endian,
> > that qualifier is no longer necessary. Remove it.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index aa11bcefddf2..db8464fcd119 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
> >  config HYPERV
> >  	bool "Microsoft Hyper-V core hypervisor support"
> >  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > -		|| (ARM64 && !CPU_BIG_ENDIAN)
> > +		|| ARM64
>=20
> Personally, I think we should leave it be until aarch64_be support is
> completely stripped out of the kernel.
>=20

The removal is in progress -- see [1].  As noted in that overview,
some kernel areas have already removed the big-endian support,
so the kernel is already irrevocably down the path. But there's
certainly no urgency to do it here as it has no operational effect.
It's just a cleanup item I noted and if the preference is to wait on
picking it up, that's fine.

Michael

[1] https://lore.kernel.org/lkml/20260811140132.22778-1-will@kernel.org/

