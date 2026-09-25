Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010017.outbound.protection.outlook.com [52.103.23.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75804AE13A;
	Fri, 25 Sep 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353402; cv=fail; b=W2+ibXTIDmm5fBlXkfuM2wLo3vxxnz6q1vxRbcLnDCMOBVmNau+zQw5tPi0VKeU6xDyREbMmwJ+teSZWYYKTMTsa9YpvxvIOpY9Pwb1l8A3Le+uqHO6A3a/OZpFGMDOBCwMhrU2PVT6AyYPgCVp7iM9TofolA4dSKoqA2emvvsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353402; c=relaxed/simple;
	bh=ql7AQ5BQTF3Xrhd9OBHIjLeQXHZdK111h5589lJz6+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqEFGWsm1PHSsroRx9aNvDw2irpfeOgUZkH+qj6NMVdPIFbl4i+reBK93jmhBUPdMgdjiKKwXOl6+n+uavCTO56lBoXk0e8/Jhv/OUt5Jurs2tE+RbV1xLmQ0vYe2HwLv9NvOCAoS4SYslgAXEG35rnpKEms4yYH1kscSfOdWqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NUpOgzzP; arc=fail smtp.client-ip=52.103.23.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NUpOgzzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ/lFSMg1Fh0PPU2R9qoM/7ATS9Phw0Pl36AcpHDx6cTlmNrFCsDFbaOlWoAkMcdqGacOX6Ik+HNB0tOp7vXh6xDsPHHJUoPyjCqF67VSnKsHlUoQUgyd/f1DxqrQx0z8Kn19vNJVF4FOlSP1m0gbdLcm8q0KuSdq2BsQH5SKAwyMU4TF0hsMjkWYuT2gyUfVUHQTPPP5WQyDP2VsNO+wOGmXPauhjQRlLSQybhCBxxGL296oWF+jOXDINQnR5x4YKlr18RGfXuO+8ffZcOiDk3w+HIbYBE+HIoFtYIB8KgZvbM0B4aa1hZxCrB5asTmHt6qZ4O09jHr+765OcVd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyEoCaUTv3Ld0lvFsT+lY8yiyxX7aFn8neP10IMI5gc=;
 b=yAFGmN64ee8eT/mJqRCXUzWqWrXxt6gRJhDbXsf/4AmFROVYh5eU8pmdxxgVEfzVBip8IH1Sic/fuo7kT05LG0Idbz7YtikRNapgwde+j7X3B9sg21XhZGZdip2rzjkCKfd/Y4WZkB8WRBRdJNZn61XYbxeAPNXWYM1norXySSgK97EMDk9p+MiweZie0cN0vcC01SLsXxYlxZZ7ZOUQehwn7auzvExa4xG+ty4gxSH1lALRP2myeCVRBsFCn1/e1mvvE6weFqNL2lGxIV8DfaowyEVDnAk6tGv09JmX3182HWWAR0O/skHtOy7ZseW5r8ZNrJ85sDQgTY6FgCss1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyEoCaUTv3Ld0lvFsT+lY8yiyxX7aFn8neP10IMI5gc=;
 b=NUpOgzzPmVI0wcYVnjUYsyTzPEAOcCz1vdGM/YJ2Xg4oHpD9YqaOEzQ1y9OAYadBHDF1x2qTgRuj3gTq+8wmaEFiWI8FzX5xlqadmgvh6NeglVEXsA4WvjxvP2VlBFU3U+AfZjouA4hzT0CpIrlEjl80Jen5/g/sOVxHhNJWbCPXYpa+peHkUNwXyI9GXa4qjf+q55V8Z2emo3R6sNzrG1KAUdtyL939o//YYWsfRIIsV4HNhihz1uo9CeBUE29r1iAa6OSCUSCjzAmzAqXlO4e7fkFcStSQqUxMeoD67XPqCcGQe0mwOhbjvZAfuYHt9uN3eoV+FgVd2W0gyC27vg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6705.namprd02.prod.outlook.com (2603:10b6:a03:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 16:23:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:23:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Souradeep Chakrabarti
	<schakrabarti@microsoft.com>, Wei Liu <liuwe@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Magnus Kulke
	<magnuskulke@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v3] drivers/hv: remove deposited pages from direct map
Thread-Topic: [PATCH v3] drivers/hv: remove deposited pages from direct map
Thread-Index: AQLz71Eyvxq2Lmz/5rMEBoasASibobSyIA5A
Date: Fri, 25 Sep 2026 16:23:15 +0000
Message-ID:
 <SN6PR02MB4157B2D3C47289305C6E487CD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6705:EE_
x-ms-office365-filtering-correlation-id: d31ec619-392b-4d2c-5dff-08df1b214d7e
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TWTq462A1ci1xfPBdi3ebdlbYEON++TGNON9GdxtzCkRshddHwq6JNkI/Yv7e1fSJx00i2GOFQDTIiV5zr6RCUrzKnUmMOSI/FuqbEHyY1nFsXmLKFbSA4czL0mbuHiKZEFzE1UUnFOTZ8M7g/55YvdZKwQqfX0amHH2FZbcLtptwiaIF+/v4fg8zFzY3lxI8smAm66slm4LNJleGFvN9mte6bpCM23YSj9xTvACxywSW8b8VeQjT82pR9s6exBSanHAXlPGZhymbjWzk3iqdsin7Odi0sv8No1F1RXdALASZu5ibVGc0ZJrk6pePyyYt4NlsVmJChflkGqra1h5tZ6x83fwiFAbkYarzbYMCjsZ6OKa0QYE7iv2IoufYdJSBUT5eRWiX4hCbp9USMsxH4B+9Ne+JRf7M0GYZIibKKO4nlxlOq9FE3HLFmYwl2nDEcpCLkdDzEeAOl68OvSiuEaWcs5+e3tHuJDznWP+LfQBfFBjSbN7YNPBMpPWi4qm3bQ+5x2FFpYR1qYBQQiqXgQPy18kA7dHz6j/nVPXlmAtIEkqPHyZNFwFHylZQNivA9OFfF4bU3/o/5imKD5rF8EU59u+zFSE/gF87aohuqd2QVhl8JE8j1XlDa8C1EqZ4wocCCZv2WhTBMyfl5tJQf+cl9x6o5hBp9C+jlRRU4fY6sHCAhCbrtikAOeQFBUq1ZZrufKy+wy88qTl/l80mPUqEflydv1LCu0JJOH7BrWvrC4o2m24+572Gql3XXHVjq+FniA+Dc9egsR3PNycDKLvh4E7kDxG+Y=
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|24021099003|41001999006|37011999003|15080799012|4140399003|13091999003|8062599012|51005399006|31061999003|8060799015|19110799012|12121999013|25010399006|40105399003|12091999003|1602099012|10035399007|2607281247196008|102099032|3412199025|440099028|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oCkw88suETy5Dig20nHStrsKbSMCRvPEQ6Le+3sIaFXQXy2Y9tIDTYQhyocj?=
 =?us-ascii?Q?tQ5Vpv47h1rmsxae2TXArfadXXV7a/VVPEj0MDOnTVoZ9SR70p9aK2hdGSUy?=
 =?us-ascii?Q?1TboVs4b2N6REg4xWrcH+h94EQKSNVG/XS5dmFs1qDK7Yzt7DIV7clVL0ewx?=
 =?us-ascii?Q?+21cjzlugyEHH/OHxXB+b3JNCOQLz7ACR983mSU188Tbm153CsKaICDVBhMZ?=
 =?us-ascii?Q?0dkG7MNqoQVcGOCkEQqp931cnqnSvYuoLEzz1Ljg6ca7rf5eVsFeTtlbgeaW?=
 =?us-ascii?Q?UQawbS/5U7i906B5cxa2vBql5BOiDnPuu5AFR2uEAsEWOoIRrVXXjjDRm/60?=
 =?us-ascii?Q?XrqCnfzJ3O3h4+FgNJKhci9JU4UX5lfDhV4J4sNhFDd9KC6dQRKOMbV26fu6?=
 =?us-ascii?Q?v4BHPzIAOIhGNUDL/iI/Xf38Few1lEBJgzkbw4aOQweXWuzlX9ZA7jHcEqWK?=
 =?us-ascii?Q?d+CffExvboPLAtMnWCQ1xZf9OtXQz8RECn9jcqQBq/dJzhYswuSj4Uvw1Ekj?=
 =?us-ascii?Q?ybNGY+hD2eakHHt5qj1u6JGrY40JSL2FbvKevJcMTNAapl0HlX6aw5OxEBJz?=
 =?us-ascii?Q?fNTov0kEGWqKek+fD42R8Ein5n2HLblMiVT0UlEJrQaJdymE6fDasnIj0mta?=
 =?us-ascii?Q?B0mdv5K8tFgZh2rIydxqYZY0tPaZhaPHd0MwID9oHtv0An9Hr3kLJwBW2kU9?=
 =?us-ascii?Q?mkp/0MGBeE9jt5fH3jYSsV/En0YwCc9kOwXc1M1npERvi8p3Ko3I+M0g4f/k?=
 =?us-ascii?Q?cHMdUyMlkX7J4AwNvo+nw4zyueYBcQE77l9skjOESXW2uE8X4TYoA5hvqt+n?=
 =?us-ascii?Q?n8N/p77lAir96wVo5HAOH0x7T+VIUXHUtC7+IiP42wSHcIAr6nuynAViH19i?=
 =?us-ascii?Q?8LDJDmi/xA55DneRLR6C4em3F97refZj7J8gQDprB8G/q8Hf/h/yqhfdrCeo?=
 =?us-ascii?Q?3vXfq1cfGJrF03Uik+IRUhaD8WuQ6k+jxltYIaMiHdBetNT4m44V/ny7FOMS?=
 =?us-ascii?Q?1+/eWAoat4R+baTbjjbou9CP+KH69fBBEOWilK7z4+hNcce0LNzJeobYN5R5?=
 =?us-ascii?Q?dM6coKpuSPnuiUaL37f7RZ6TFDLWZerduTU0O2irJRBnwwKyReYishBysQ28?=
 =?us-ascii?Q?jdt7vP0E59WpAnR2nlpvmUYVivCpNuBfsxu3egzLMzpwvuYGVnPB3cM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ust3zsSQ1i1nO8YT+0hq7sszo+9KtmCJrzg85C1oxcreKb2uRB2x9JnU4GWQ?=
 =?us-ascii?Q?eTrQe4qMfcFwwcDRyinbPQQIBFDdVbG9nxaxCd2gARZqNTfqXWCr90Yaxv4o?=
 =?us-ascii?Q?yTSCKsMai2D3vWcDh0jjFbOEQl6mblmII9YM9UQx1IaXewThdSNJ+89/rtC1?=
 =?us-ascii?Q?89cv4k0kJ3haAHTHoB250RiGcZc92iYi0g3mhoOLa/2/VeaFlVy6j53+J2VN?=
 =?us-ascii?Q?AZExjuBg5jgrvhkG/iWIW5A26gXc/RQoA9czqwW9h9rLIfPO8usAFnwlRa1T?=
 =?us-ascii?Q?fGkYY/U9ch6v0eZK0D+Utd0/KfKvUlKp0WZhxyfaXLEgoQCPxALZu32TMgXU?=
 =?us-ascii?Q?jonaOwGxV6ZRg6hnSaLibUAiqevkKlPHWxcYJhGeaBN/LS37/VB8ICUT7joU?=
 =?us-ascii?Q?GugPPd/qcSRuH7lp2VWjpWpk4gGTMrvEmYX9+bNIhAiG1isnFIDqJa93ELNi?=
 =?us-ascii?Q?Ld5K527puOU4IegtCDEefui1L5o5sjiGx4X07uy2iWzFfKbzEa7UcZyGA1bK?=
 =?us-ascii?Q?VerxwFRfWnTf76z1YT4eq3sc31rNjZPgFzxSXzWA9QgkTUcCppoYj8SDWSvt?=
 =?us-ascii?Q?gYQVgobyN+7e8Q33KJMDV679Hnc1p1UIhXnWpBdu0SfapC0EDLUTaFblV5vp?=
 =?us-ascii?Q?bfiLuWUsH0qLUEbazJrO8oYDndL81qwpUybmc/uBs5rQFkDapqumJZ7lD1MI?=
 =?us-ascii?Q?NWUEwlZ4ccEi41+aLMgl0tX6rpTQR0JXiN8C8CdwLkTvaAWnPPR9JDPI7J2t?=
 =?us-ascii?Q?KypuICE3RVRR5+aj8nUSajcSeO49dx1kmkStJ8CMZwXQ+5TJThwH7lY1WpJN?=
 =?us-ascii?Q?Xcjl2Q50dNUqnsWBwez7wGrJCGR17xguvVgswYQuJRqpciR5FI+4ZLW9BLCw?=
 =?us-ascii?Q?o5gb2trMh4XBhs0SxrqjVugaFUg/TCzP0t47taLGbd1jwMLFRQ0p+kmOmVe+?=
 =?us-ascii?Q?G4rHOkWBX2xi+USwJxJoYYEm1Nd6fuE+xyOzpAOGmz0cShGk3SV0srsWDnoh?=
 =?us-ascii?Q?3YgQtU/47QSW95Nd4jU8mG+tbBe7AkOUmzxbFx+b1NDP2aQC5VHfDTC19zqA?=
 =?us-ascii?Q?QOOWFRrS3+OXI2qbaPL4YANyuyZZZjKrzUG5sjn83+Rvut5LsB5FH/6Gly3n?=
 =?us-ascii?Q?1wrq7kYQ/buagOuvYIXPkV4BB+p2ZHUbXNYX/S4kE1/pBBn7zracB0OBZlJM?=
 =?us-ascii?Q?20H5PWew0x0+oZgwiiMbdP81j81Hyd8rixkF4SNE+o319g1EkM0omCsiZh+K?=
 =?us-ascii?Q?Y0iVmtIJtftGpyKzk+SSz4ORt8LIi1rCqCEucbv+9vhnVYPOv/0dfxq70K/b?=
 =?us-ascii?Q?373b8fwR8Nr0LyvwlPz7Iw+ZT1WhdGC3HNmkijX9JHuoAbArOPwM+VoTHoxv?=
 =?us-ascii?Q?Nxo8Ebg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ec619-392b-4d2c-5dff-08df1b214d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 16:23:15.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6705

From: Magnus Kulke <magnuskulke@linux.microsoft.com> Sent: Thursday, Septem=
ber 17, 2026 1:11 PM
>=20
> hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> ownership of those pages and per contract revokes root partition
> access to them, raising a #GP on access from the L1VH root partition.
>=20
> However, the pages remain mapped in the kernel direct map, so kernel
> code may still access them even though the hypervisor has revoked
> access.
>=20
> Helpers such as "load_unaligned_zeropad()" deliberately read past the
> end of a buffer and across page boundaries. A read into an unmapped
> page is tolerated and triggers a #PF, for which the kernel executed

s/executed/executes/

> a fixup in the exception table.
>=20
> If such a call steps into a page that has been deposited, the access
> raises a #GP by the hypervisor from which the above handler cannot
> recover and the kernel panics:
>=20
>   Oops: general protection fault, maybe for address 0xff1100941a3dfffc
>   RIP: 0010:csum_partial+0xe5/0x110

Is there any possibility of updating the load_unaligned_zeropad() fixup
handler to handle the #GP like #PF? I had looked at a variant of this
problem a few years back for CoCo VMs. See the code comment above
hv_vtom_clear_present(). In that case, a smarter load_unaligned_zeropad()
fixup handler wasn't an option because these were #VC or #VE exceptions
routed to the paravisor instead of the main Linux guest. But in your case,
the Linux gets the #GP, so I wondered if a smarter fixup handler would be
possible. Of course, both the x86 and arm64 versions would need updates.

>=20
> This condition will appear on L1VH system that have created L2
> partitions (and hence deposited pages) and exercise networking code
> paths such as csum_partial() can trigger this condition when a buffer
> ends close to a page boundary (e.g fffc in the above example).
>=20
> The fix is to remove the deposited pages from the direct map before
> they are passed to the hypervisor, and restore them when the hypervisor
> returns them again.
>=20
> We want to avoid flushing the TLB in the loop, so we use the _noflush()
> variant of set_direct_map_valid() when marking a deposited page invalid
> and flush the affected page ranges in one go ourselves. In the opposite
> direction this is not required:
>=20
>   > If a paging-structure entry is modified to change the P flag from
>   > 0 to 1, no invalidation is necessary. This is because no TLB entry
>   > or paging-structure cache entry is created with information from a
>   > paging-structure entry in which the P flag is 0.
>=20
> (Intel SDM Vol. 3, 4.10.4.3)
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
> Changes since v2:
> - Checkpatch format fix
>=20
> Changes since RFC:
> - Handle direct-map restoration failures without returning unmapped
>   pages to the allocator.
> - Move freeing of withdrawn pages into the restoration helper.
> ---
>  drivers/hv/hv_proc.c           | 77 +++++++++++++++++++++++++++++++++-
>  drivers/hv/mshv_root_hv_call.c |  4 +-
>  include/asm-generic/mshyperv.h |  4 ++
>  3 files changed, 81 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..2a392b45205d 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -7,7 +7,9 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/minmax.h>
>  #include <linux/export.h>
> +#include <linux/set_memory.h>
>  #include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
>=20
>  /*
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> @@ -15,6 +17,35 @@
>   */
>  #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>=20
> +/*
> + * Add or remove a set of physically contiguous page runs from the kerne=
l
> + * direct map. Once a page has been deposited the hypervisor owns it and
> + * revokes root partition access to it.
> + */
> +static int hv_deposit_update_direct_map(struct page **pages, int *counts=
,
> +					int num_allocations, bool valid)
> +{
> +	int i, err, ret =3D 0;
> +
> +	for (i =3D 0; i < num_allocations; ++i) {
> +		err =3D set_direct_map_valid_noflush(pages[i], counts[i], valid);

Just a heads up, there's a patch set pending that eliminates the API
set_direct_map_valid_noflush(). [1] As described in that cover letter, the
the behavior is inconsistent across architectures. The intent is that
set_direct_map_invalid_noflush() and set_direct_map_default_noflush()
should be used instead. But the latter two currently operate one page
at-a-time, so they are being updated to take a page count argument.

Michael

[1] https://lore.kernel.org/lkml/20260903-execmem-set-vm-perms-v0-2-v3-0-94=
9b64a9f755@kernel.org/

> +		if (err && !ret)
> +			ret =3D err;
> +	}
> +
> +	if (valid)
> +		return ret;
> +
> +	for (i =3D 0; i < num_allocations; ++i) {
> +		unsigned long addr =3D (unsigned long)page_address(pages[i]);
> +		unsigned long size =3D (unsigned long)counts[i] << PAGE_SHIFT;
> +
> +		flush_tlb_kernel_range(addr, addr + size);
> +	}
> +
> +	return ret;
> +}
> +
>  /* Deposits exact number of pages. Must be called with interrupts enable=
d.  */
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
> @@ -72,6 +103,10 @@ int hv_call_deposit_pages(int node, u64 partition_id,=
 u32 num_pages)
>  	}
>  	num_allocations =3D i;
>=20
> +	ret =3D hv_deposit_update_direct_map(pages, counts, num_allocations, fa=
lse);
> +	if (ret)
> +		goto err_restore_direct_map;
> +
>  	local_irq_save(flags);
>=20
>  	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32 num_pages)
>  	if (!hv_result_success(status)) {
>  		hv_status_err(status, "\n");
>  		ret =3D hv_result_to_errno(status);
> -		goto err_free_allocations;
> +		goto err_restore_direct_map;
>  	}
>=20
>  	ret =3D 0;
>  	goto free_buf;
>=20
> +err_restore_direct_map:
> +	/*
> +	 * We don't want to return pages to the allocator if weren't able to
> +	 * mark them valid in the direct map.
> +	 */
> +	if (hv_deposit_update_direct_map(pages, counts, num_allocations, true))=
 {
> +		WARN(1, "leaking %d page block(s) that could not be set to valid\n",
> +		     num_allocations);
> +		goto free_buf;
> +	}
> +
>  err_free_allocations:
>  	for (i =3D 0; i < num_allocations; ++i) {
>  		base_pfn =3D page_to_pfn(pages[i]);
> @@ -110,6 +156,35 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>=20
> +/*
> + * Put withdrawn pages back in the direct map. Counterpart to the direct=
 map
> + * removal done by hv_call_deposit_pages().
> + */
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count)
> +{
> +	int i, ret =3D 0;
> +	struct page *page;
> +
> +	for (i =3D 0; i < count; ++i) {
> +		page =3D pfn_to_page(pfns[i]);
> +		ret =3D set_direct_map_valid_noflush(page, 1, true);
> +		/*
> +		 * HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
> +		 * a 2MiB page, so deposited pages are of 4k granularity and cannot
> +		 * be collapses into a 2MiB page, which would require an allocation
> +		 * and can potentially fail.
> +		 *
> +		 * Should it fail anyway we leak the page, if we would hand it
> +		 * back to the allocator we would introduce faults into random other
> +		 * parts.
> +		 */
> +		if (WARN_ON_ONCE(ret))
> +			continue;
> +		__free_page(page);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
> +
>  int hv_deposit_memory_node(int node, u64 partition_id,
>  			   u64 hv_status)
>  {
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e..150a0c63ebc8 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -46,7 +46,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 pa=
rtition_id)
>  	struct page *page;
>  	u16 completed;
>  	u64 status, withdrawn =3D 0;
> -	int i;
>  	unsigned long flags;
>=20
>  	page =3D alloc_page(GFP_KERNEL);
> @@ -69,8 +68,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 pa=
rtition_id)
>=20
>  		completed =3D hv_repcomp(status);
>=20
> -		for (i =3D 0; i < completed; i++)
> -			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
>=20
>  		if (!hv_result_success(status)) {
>  			if (hv_result(status) =3D=3D HV_STATUS_NO_RESOURCES)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb..397c8ec0ce9a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -346,6 +346,7 @@ static inline bool hv_parent_partition(void)
>  bool hv_result_needs_memory(u64 status);
>  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_notify_all_processors_started(void);
>  bool hv_lp_exists(u32 lp_index);
> @@ -364,6 +365,9 @@ static inline int hv_call_deposit_pages(int node, u64=
 partition_id, u32 num_page
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void hv_restore_withdrawn_pages(const u64 *pfns, int count=
) { }
> +
>  static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 a=
cpi_id)
>  {
>  	return -EOPNOTSUPP;
> --
> 2.34.1
>=20

