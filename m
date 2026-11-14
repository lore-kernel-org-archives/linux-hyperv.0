Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794678267;
	b=S41bJpuJ4EeikOjqZW9GSrLCC9+11bMJFYZ6wIEofyL47QcFmIbw+rRXbg5uuxYaNsfx
	 RQSwuKc4fJd0h9FRfHYjzDVAFgzUE+Ug8jqYcL/+E4ZMNe65OzHOGkXLa6BsYUbQi1kX2
	 VHAhlaRa5YsOjctlokJIP1ePjVg71AF7upcYR+dAxHtWbVM4zatDax/QAoa6ozXvMscy5
	 hG2ZM7WFuRZvhvGtqdBSyrMd5AJjaQo7t76u4GwMZ1ycdG4pUdcQQKqdjUSQWX/jJj9BV
	 pl9vPVxWYwY3hfWTmfaE62deMZiiKRLdXszM3UPCaGaz135oqX/gHagb6r/jsCNT+/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678267;
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
	bh=zz5olvuFexPdZO1PVksgLnOlKQHTbdVTsIR4z1/+B4M=;
	b=kQAEcghTqgGOLijVswg6lZ6j4HaVLI7ZclxxNfc0REGE5cQnZ4rCa5D9H080+yAZBNXM
	 38SSXJ02LUA865G2b/jim306A3wm4wSv4BUsLMixpDTrtA2uN6FIf4cDfdvMF2fjdKkt0
	 jIxq1hyDOtszuTerB40Qpy/1T/II7kT/eddUUAdjbLrgwUUVvGUZh6zS/VwFNn3+GIrT1
	 fiUuheq/pDM2bT07G6RqteeMIt7YU1/O0h1JLsgX/xvdLpWZSCeKCVwxAkJgvkYcpj47x
	 sLNbvas5n64nEmPPZRZSkjyfXle4jx/LKnhQQsfbpcJDCiH4p/tItBP4Yw5Wz0WE1XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ElsYiA9x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010006.outbound.protection.outlook.com [52.103.20.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69951606A32E;
	Sat, 14 Nov 2026 17:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69951606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ElsYiA9x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrH1lny/xcARJll2wUz7CnAftKr6qjgNKgysf/+A0+FWZ9LqUxlz78z1g9lKhjQKG6baYWncr+dyI8fnA431GkbEUa65EdBJstORb417BjAJu02NBB/LcNG/FoFV72XwuZ3Ny7Lq6UHmmYUN8/Y8xL4paFqXlxYdJ/2rwhsFMkZLwwfiDyc7cLwO5TlvvyPRX1cimH9eWGGzty1nJoQWWsMGVTFP5+LBTsyshyzvM6Sol5r0CZ3/LS+knWw7DQRV/7iEC3vn1UjkCKkXoYbOlOm8VO5hzrXS73z4jRzktT03RrhNEaaVgVuXS9LwS93rcrqPYcTtgMmHPLnDgCbjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz5olvuFexPdZO1PVksgLnOlKQHTbdVTsIR4z1/+B4M=;
 b=eYhFUsqOExvSxVmQLenUBTBjBj4z3v6jFeZW0q3cSuW9D6W+cUeS+ngq8CUo4gLpcIUyihCFnRVdVCT27ONxx4MGLczxG4XbRUd0iRZFx9W91pmFFE3jaq+k09czP0UwpTAxK5E1AipYUwbhSss2B5AeSw1WGQapz36W0yNQ4KyXCIqOlzrExjQoLS/nyA0Gl/q0oOi5BPTDwbXwoHXLaD7SUlcbqMKiA8j1mfvH1wAmIZgXzkNCHXH/lv2SCmTxQiDa8B8ExZ5/o+esOk/mmTL4QYiqHlf23WF079egr6tHoksLCkpjYhO8FcegBuSzN5yMDVEO9Oz8UyPcuMWzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz5olvuFexPdZO1PVksgLnOlKQHTbdVTsIR4z1/+B4M=;
 b=ElsYiA9xbc0fPrnxYGkxW/jAlTzdh99yr90HKg4upoPYs14mPAxtisphObKXJmsGlf2A3Z5ZayEOa1Z5PxdVvGvwqJM4uY3fmVF7wKilx3lEEOB7JJyBuNR00KmLWWhNhWR6chVI8YJhtrJ77EADpZVaip1T0T3ZtDyFSPsEr+teau8COyftJ3bZawrjKqKkz6IjErVWBFp21uxVoyRumY4DHQEHnfLRDJVtzp+lszq8eo02qitIwL3OpZmp3hlE5UsZ0+v4i+jPgoNFUD+tiQh7CdWewViYViGycm/2c9UOU7AtLkWuadpue8ug/eGzUGoWTIWuBC6FaG/OcAowVw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CO6PR02MB7507.namprd02.prod.outlook.com (2603:10b6:303:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sat, 14 Nov
 2026 17:43:07 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 17:43:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Dexuan Cui <decui@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Thread-Topic: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Thread-Index: AQHdc7o9SPo9iNf6wUKOy98JYWtdm7ct1Bpw
Date: Sat, 14 Nov 2026 17:43:06 +0000
Message-ID:
 <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CO6PR02MB7507:EE_
x-ms-office365-filtering-correlation-id: 61acd8d1-4c8a-4e32-e2ba-08df4276bdfa
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|25010399006|19110799012|41001999006|8062599012|8060799015|55001999006|24021099003|15080799012|13091999003|37011999003|31061999003|40105399003|102099032|56899033|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sgfLdWUsz8RiyWc4GePv4cNP6DHSZV4AVrGb9E3l+HhGDAXLQiwDaqqPAR4m?=
 =?us-ascii?Q?QipKud2cvz8AK5OzSHac7Dz5TJDN35idlKNLMNJ6AyRWfoVMn7ugRNP24htg?=
 =?us-ascii?Q?LPFWygyhlhpQtj4zmLgD91+2Y/7pHgMQjSALjdZplTlgraQipjCdBHRgQ+DT?=
 =?us-ascii?Q?c5BLm9ywBbMOBhmDO0Dlkzfwlxs4GZKVXm0H1tuute8QiNetzdbggF9uA7Ak?=
 =?us-ascii?Q?DCUGD10GTGtI3ylKT889Rn8YvnNDqJJwRV7fPrmRBKxO5Jny55yj21emzhqB?=
 =?us-ascii?Q?879ZO5NKJPpKhPrZk1ocAjH2YaiSSqs2YWePA5NN4Th/faflOFDVKJhzUNDl?=
 =?us-ascii?Q?1WGaGU4kwphyjT71ACbTuRmp0tFcUUP3IZxiuzQFcUPeKL+iKBL/k7KkNlX0?=
 =?us-ascii?Q?4f5dtftViS+N3UId+73wr1dUhLDITKL6/OVVRKGVZpCFilMG71fggHFUFJ49?=
 =?us-ascii?Q?plsD0loMJ7RJUne9k+NiBnmKr7g6bK7T4PyBHJu2PGWItqMrFqiBb0BsPUti?=
 =?us-ascii?Q?afY6dnvB3jgnjRuE7C1fBM8oWdc/yEXMVL2bezL8xjohKelQWX2cGbHc2utg?=
 =?us-ascii?Q?/S9UshkoUOVcNSTLm5SyVE1Lq1F2+uTx1z6AbdtkTT3B/qxeDeULJotmxVE3?=
 =?us-ascii?Q?P2rGDbCprvVx1EZbhajm8gfkC1Eb1YX45Mlsx1k+8lF38xi0BWY9Cg82QLzZ?=
 =?us-ascii?Q?yUcC8iSrco4pkdHPoSK7ABgwFN76qDIFPFpdEzVXziWwbiEX8JZsbL3aJd9F?=
 =?us-ascii?Q?GzFhVdtUSLaZeAsgBiOmYYpZ6uHP4DZi5NuBJRkK/mUHRaxTF69OQNsFYega?=
 =?us-ascii?Q?OCbi4PAuj1HraCJxFCQ8a0y7ufY2Y9D6BaApV0tqMlA+7HmSUPeFqUreO6Xx?=
 =?us-ascii?Q?nRvjq4tbjsnItfK7R7tdUJRFppcDdIz7+quXD/7+3f6y3NBxiTpxcUzO8CLu?=
 =?us-ascii?Q?K3lEedU4tdIhSkdzqqKhejIvlc9QkXjayUq9i6m0p3/tSN8+gOq5mXaawoYm?=
 =?us-ascii?Q?CM9AZHhI9ggKUr8kQdf0YGAylKOUUcaAGqsO25ktSrIwjT6aMAZnMnR013T6?=
 =?us-ascii?Q?I3xQ9EFZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BIoNs81b6E3tUxuKl3lFqioN+o9oEwqfF7i/Zn8l3ufcPsNvrfGkzIIYHBtJ?=
 =?us-ascii?Q?Pl7h3vf2hwAG8/74hRbH1sJHvlA9S8VYzFAbdSCws/pryGqbxjQ5u3v7E5mv?=
 =?us-ascii?Q?XHNKAST3qTKgVm6jD96hMFxTQg8Gcxo3FHCleLBB+rZ+rv78clHrlpcrVeMG?=
 =?us-ascii?Q?pT0y/M1ITvB/nblEx2yvGlZk9o6wcO4Os+0xTPvb8hbTbV11LmhfIQ+Lsn0S?=
 =?us-ascii?Q?0lXguOQMYc9x1gYSwsoBcIF3DteiOL2Qm/kYcHheBn2t4NtVnDTxIdYELon1?=
 =?us-ascii?Q?BmXqTuC4qqlClD3TMBawmd5jpzMtvcphGIrg60ycLjd0UX/zSkuI0DX8Mgqc?=
 =?us-ascii?Q?0ItUxexUg+2dU9pYClTUgEqVgTbBrUsYHOBhQtZhiljxTPP/S1Pfy6cZZgKw?=
 =?us-ascii?Q?DL51a9xbE79iauf18czG5GqvvX6Dtfe5nzbYUGAjbcJjcQ9ji3MxXxribYcD?=
 =?us-ascii?Q?D0tjX/EAvNaBpRopvAPxJNcEtF25N/rW0YSOzmE5uHk9QXltiMuyqiKHDqG2?=
 =?us-ascii?Q?vEjl1srYG4TjqkD5E7CkiYLIB4sTr1oQPfHEPnTHtbWZIUM5ie7ZlbHyanaL?=
 =?us-ascii?Q?tyPYqKdfINxzCMIiOgS64ZSZtxVGtyogL4U8DqYgbJKqWywjmCRVVhkoLQsr?=
 =?us-ascii?Q?F1RbAeN5yAa8OHZU2pW/hk7/rF2NyIw7cAbG3wj05SNv0rfpoLvguZHp8N0M?=
 =?us-ascii?Q?4oWSo2nD18+hqvWL/j36G1HzbjQjLyx6YChCzgcWsy3YlBFELkGO7o+Q1IoQ?=
 =?us-ascii?Q?RLWHZdU/7MuzKPxKTzwR4RciMIYlhA3Mr4QXoiexy4F1p+KPQTPmE1joEgfw?=
 =?us-ascii?Q?19IqDgVWZLcRxduCTpfxudfuoU+TWH7xSTMSmT5Lgf57o5v67oCyrpLPUaTe?=
 =?us-ascii?Q?8S3tCfvuJLyWdr4xBWvIpIzFyA62IZ4b/Js+Vu1Yvwvd1bIPPfuIfqFjj4dl?=
 =?us-ascii?Q?6lrnTHDJYbzzCSvxyvP9yJrLxXjLLL9D5FxPnG8WpAc4r8MAwvq+iCeM95N4?=
 =?us-ascii?Q?mPRSCIybyHgQDAQK8xAzSs+oPQ2OZ8G5MYMMA6AADU4sCcfYKtkz3MrEXtEe?=
 =?us-ascii?Q?Rv+FrmH2MAWQ0b65iL6uwMkkiNOXTE/mkVxjNvtn3hZZagZpD29odpwFw2bp?=
 =?us-ascii?Q?IBgzauyXEJ91wgHOSjwlQNDqh1R1tj53vS9qs/EBApBnrjGZg8mah4T3556V?=
 =?us-ascii?Q?x5ANCqu1fAiusR0om+1yXzrp2l1iw8EtgzCDR4dhyWJ5ghZBfPwWMDphuDUm?=
 =?us-ascii?Q?U6a1GNoWP7b0DTdeO3nM8szsKymOf8Q2Epxxg2nbpM/GqOnMXskeburFV7t9?=
 =?us-ascii?Q?4YwQbbELPQUcpJV+9oYZuaMlRRoVqMIBJENnicBsyEkyXkjw+r2CMlQqyAvT?=
 =?us-ascii?Q?AD6EHDk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61acd8d1-4c8a-4e32-e2ba-08df4276bdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2026 17:43:07.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7507

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Novemb=
er 13, 2026 1:59 PM
>=20
> I was doing a deep dive into the host spec and noticed some gaps. So,
> I went ahead and hacked together the patches in this series for items
> that seemed worthwhile to address.

Are you (or someone on the Microsoft side) testing these changes
in a Generation 1 VM, as well as on back revs of the Hyper-V host?
Testing should go back to Windows Server 2016/Windows 10 for
both Gen1 and Gen2.

Same questions apply to your earlier cursor plane support. I just
did basic smoke testing of the cursor plane support on both Gen1
and Gen2 VMs using vmconnect.exe on an up-to-date Windows 11
host -- no obvious problems. But I don't have access to older hosts
like WS2016/Win10 to do the back rev testing.

There are multiple frame buffer differences in Gen1 and Gen2 VMs,
but most (or all?) are in the lowest layer in how the frame buffer is
allocated and mapped. Hopefully these higher-level changes you are
making are agnostic of the VM generation, but thoroughness would
dictate testing both.

I'm less sure about what might have changed in current Hyper-V
versions and WS2016 from 10 years ago. My general impression is
that very little, if anything, has changed in the Hyper-V frame buffer
support, but again it would be better to not get a bad surprise after
the code has gone in.

Michael

>=20
> Hamza Mahfooz (2):
>   drm/hyperv: add modes for all resolutions offered by the host
>   drm/hyperv: batch dirty rectangles
>=20
>  drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++-----
>  4 files changed, 110 insertions(+), 20 deletions(-)
>=20
> --
> 2.56.0

