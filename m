Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937977;
	b=lmwVwz1fRkRNAetQdNSK+OeEvQz2jG+anUq0MW0q4hSNiTwcYvxoS1bDsJotWWZxcXT/
	 NRGr0u2o9d34/EMZ6Gwi6jObjVdgkpytHmJm1uU/OU5306A9u20whjTJ+1Lb9XFL7FMVe
	 /y9Hl0KjfiQtPaRHzKW4biNmOwhPHKmZ8yr3aMo6XLWsPltxDX3JMvOeKSv2ca+A8dHIm
	 suNnBAI73MW/oxpFBVc/86DtT0mzufGsu1966sk+ky99F6XFHy3eX0o3W62Ox636mYbb/
	 nLqqXV5Sr1UxImcX9hOorQczOdDgaIwaefzs5TIxT6ufKRrEdDCuvPKliCyLzQZ/Evw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937977;
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
	bh=aKj4Yp6ZMcXIFKcF7ldAXsKrzwvF+LlcgdBu3WLvyI8=;
	b=CJWGuH22NdZbUkKfqCA5QjUhBgVPo9YD+uyM3U+w70pP1K4kiv7PwoSKzMk4gTyrlEiR
	 eeN6hNqENDhlic6RE93jhUiiBGzY/dQZ5R1riURvRIs3b7UihqUFEkvY9NtZ7kC1vY+Gm
	 wC5H1GTQm0akOSZhvdD6OlhGVp75unk6HPZnpKgU/5nJvLjU1bD7Tfh617529W+mLg4iJ
	 h19o8TFM+P1Rw8zX9Z34CxOrqufKdSrH4znCrsPkw6tdsHmmLkdd4FAy2DjNiLM0WwrGF
	 QxwI2xp/qZe9mpTYhZDrBbK4pU8cTGMiK2sAC3rcwBTCs5Qp4wDZOMnNjVxM+zJxtnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aTv3VpRo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.6
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010006.outbound.protection.outlook.com [52.103.2.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F81606A32A;
	Tue, 17 Nov 2026 17:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F81606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aTv3VpRo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFKsGkz2yWVyLLQPR4heSooOJoaCujUiht/nnGY2eEmhhPkaQeBRXw/mK7TSs/KsVcedyA1yDJCEV+V+t2ximdmSohc8cHRoMaLrqQjdCVglmOSMEVODnv6hrNouhppt7stfq55fIcGLPNxUjExiqTcfrci1n1L3P60N/F0y0SDjCwAWsc9C5TjcjaECYXbYtkBvJ+OLuM9rz/lanX3Xp2npf+nW+Lj8d3Dxn81jGA94iVG0n672UzS4EerkB+fUKNwPMirzuv2Lm0F0CQ5klYbLjtMzCwDbR1DKBC+CzvHxJPN18z8lW1J/iGujpS/RBIs3yu9T+8wmauCPNgGmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKj4Yp6ZMcXIFKcF7ldAXsKrzwvF+LlcgdBu3WLvyI8=;
 b=BWCz1Jb9EWSMIee+X6wWQeb8vpWmzK+nDDb8fTsqjImGTD1gnHUuf3Kcxc8Ra7MVeICqU415ji0j9vWNfyPNyndXDEuEmSp4tH4/KNUl+CRwAOO70k4RZcSIwEJJz0VGG68VfMk9qNC0OatWNeM/a+FH7yvc24bSDo/Nul7FTh3I0ig+AofvzZFVpnJOrpDHLewUVZ21eVvuJYYvY3AeoxJ0hv/11iIUQndVtSmbrae8BlqkzQbfEwylSMMC/HY5L3Dr7nZSCtRpPMSt0I86GaeFvXqPGeNrEdTeSxrULNON3ReObo3+byDj//hm91wRFTSAnIq9ncVYhr8Dwg9e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKj4Yp6ZMcXIFKcF7ldAXsKrzwvF+LlcgdBu3WLvyI8=;
 b=aTv3VpRobyv/1xnr2RSo4wEw4uuweu/cXSgVi/9xUJsfDzPlu0jnuSP0RQ3TlT/Dbq5KYr8+XZNSjVltuyXoiTak0lyCyyuF4Pk1vxi9dCYI+y6VJjOHCVusYi8NbpIAdBsSOtXeyRVWwkZ11kEK4qZtoEf2RrlX4B/J/gx5d8jrAxMDpJ1KxEyp54bGEqFCblnjiYEDqALy6Qe7Ywse21Sn71yaBHwFKg4jILbhbaaBywqb9jzabBp8J29/vNYWBKUHFoJRz9wq7OUM3ltcBMx5JmU1xsC/4K5OFtMahbe2vknwW1OdMdgPyGzrI6M5u6Y99cBYTFwcsc8nCFaxvw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DS2PR02MB877199.namprd02.prod.outlook.com (2603:10b6:8:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:52:55 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:52:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Dexuan Cui <decui@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Thread-Topic: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Thread-Index: AQHdc7o9SPo9iNf6wUKOy98JYWtdm7ct1BpwgAL7cICAAcG5EA==
Date: Tue, 17 Nov 2026 17:52:54 +0000
Message-ID:
 <MN2PR02MB68636BC62D2EC02F94B60E80D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
 <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <avsbBTsIoo09yr9L@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <avsbBTsIoo09yr9L@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DS2PR02MB877199:EE_
x-ms-office365-filtering-correlation-id: 3744d67c-e1a4-4a59-6969-08df44d39ba3
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|13091999003|15080799012|55001999006|24021099003|31061999003|25010399006|19110799012|8062599012|41001999006|8060799015|51005399006|440099028|3412199025|102099032|56899033|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JEgLO9Jkwij2ZJpupgXSVguo6UJGvADL4EgNrEMFAtZ7H5KMGOdCCYxupera?=
 =?us-ascii?Q?8ciuK3V9zEXBpix6Ny213U23nV6BY7vocButxjqJIKZxEgbsBGrE7KhDYXVo?=
 =?us-ascii?Q?CdDigR9SsnK/zFHCP1FewejM1Lwvq+QyAiUfxrlCKVtjL5unpEBVlwH2VtCw?=
 =?us-ascii?Q?dxK3AmU/YBZxv2BF1yGAfeC5mpbTNFgdLNwAkSav4gKzXjzfcRK2BhK66aWa?=
 =?us-ascii?Q?QGS6bCbRM3kVZ/q48yx8H0qF5DNtKUmKsuBZ2Q2pw2awf6jxGhUwlCJtggc5?=
 =?us-ascii?Q?CA1YjY1OJ+wN5GbHKHlO1IIhAjND27K+S4hwWSdiCsgEycC8NQFvlm5kO56V?=
 =?us-ascii?Q?bvJvO2hHpRmIkoAkQ/WN73ZmIgommrzcwmO+K7ltf+jaDZE1M908xheVM2NJ?=
 =?us-ascii?Q?7ZViV84et+SqyafbtHzmUuuwV4F411tAwnYXNiZORFJqzWv734XfCCpw8rCq?=
 =?us-ascii?Q?Ob5zrl1DcGVTlINnTdLOcomXI+gAyuhSavJOwWaYMyIfp/J8MVFHDcSVxo4n?=
 =?us-ascii?Q?x8I282E3Xzo+txi7KX8FruVVTtm1dZI6o4LI7QIeBo7ZGZ9TG3g7lAxhPuSI?=
 =?us-ascii?Q?8M3PM6Mb88dBTBnkfsbkLzQky/S5/Z8Y/esAkokiat/4JiygNr1EtIkyiKuA?=
 =?us-ascii?Q?NLpw7Dzn+TTlmNPXCUU9CobO2MpZzTtQmj2RW69NVrKhK59eHUMoHWghLP+7?=
 =?us-ascii?Q?CffGxxq3AaGe+4wVqg6VbqmjDVyE9Q2ufl0IPBRjiWcIvet4ngIKY1fnEBJh?=
 =?us-ascii?Q?4m20YJ2d8wPwjlXQdIi5N7WtkrlnoSBu8zSrzn6u591FXarc2oLniw0QZV0l?=
 =?us-ascii?Q?7VtU3EipXvzYCHWbdgC8FwXdvdG4BmQrXyde/ZTA5CL2ZtEEgRxjlNPyFXUS?=
 =?us-ascii?Q?u1JnRjtVlATBOOKU8ktBQHBc7V8WDdxWfdhENySLZMY8p/K+jnC42k/rlKAl?=
 =?us-ascii?Q?fOqYBzEnDU+OlDL3YT9euijFfUW5kl9TNw25/Zvldp7a0zsTdtyyiVXe2dZv?=
 =?us-ascii?Q?VESGoKW6CV9MyE7TLxWgwjhf28gfRwdS1+GcT40rXUhg7+FRBPBnNzApkAA/?=
 =?us-ascii?Q?DGpu6+Xo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dl780Y3VBuhtINDBBmF1eVySOtr71wGAkctihvL6hBDUDBgjZgS2tYMM00sK?=
 =?us-ascii?Q?4UQtA/+/G8VAqQpBHDpRm3G7q58mfz0/IJBEWREfdQUoR7g0zWN4BsU8oBLL?=
 =?us-ascii?Q?A29bIzkZdHwsadKtDnrz0cXCTxbEmgDWsOU+IL3tu04A81tOdir+ed9eTwel?=
 =?us-ascii?Q?kpe8bjcPKjMDStrMlUuzNa+34RDm968WuSl92N0G4L8cUKHk0oGHHq/phYlD?=
 =?us-ascii?Q?qw6IbJ/MX4Q8aREQwLNEN1bkAfB/mORl1XsvuS1grsFBKeelw2PyweOWsmdw?=
 =?us-ascii?Q?BQheTb3wSMFs2ksJ2xyE8jf2hIDs51jSy9olpp3ITDoOUtOCoTtFvQYqTEop?=
 =?us-ascii?Q?78yHON1+aVWV/XCbXKP0r3l6aRyYFdve7oLHuz3XDBYLPqR2ebw+u7kYIQ5M?=
 =?us-ascii?Q?xkttXpE8b5DyziVGO6MBazkRdLNtDlSMq02w4vo7eiIP5d/Ve2tmiz/xiSuX?=
 =?us-ascii?Q?QNZtsVP7Ysm7PIUtn3+tJN+jEoBaxfgIConsnk/40qK3b0GjT9yH8fCePoC9?=
 =?us-ascii?Q?777qItJbZZKuAL7UzPvmruJzzx9TAC7EmnOZ36CvkrJgAkRN5uvx4nUvu4Pm?=
 =?us-ascii?Q?ctpc0CThZG6S5l8ShMzmdom1VqKrj3TRPRVNdpKgX9mIbovGfvMOyYWOmr8C?=
 =?us-ascii?Q?94r5//HnFumxOenMe6msTb0Gw0A+kmRT0AjVZ6I6w1W8/v96z9AsiH3EIH3m?=
 =?us-ascii?Q?oYy08DiOCqzUtggtkLFreciEfafGc9XuVasfq2uisgU5f2SbHL5/hkjQldEy?=
 =?us-ascii?Q?rgR0bSgiplo8yHEf/WF4ATJ4KclH0/4Af1/ejD5B1EoQQy7MoOZxS6gXdwf5?=
 =?us-ascii?Q?WIXKo2hoeIRk14THVldQxr78YY6gdDBQbSzPPw/NDIJCCqkuMwcrVRHFFnOD?=
 =?us-ascii?Q?u1x5Djb910mZTWhhZB8o1tbGNXndr/FGAfC+h5NmW7lhcJi/dknOplOBUAGz?=
 =?us-ascii?Q?v521iabE1NSMuX4etuzmeP8Y/y+DAvkJA01Fv9mzzfkeaxucz8Lw8Mmskrie?=
 =?us-ascii?Q?Z9dZq5kuzXGIabxNKFt3hnfEqqwufYmJHxSSU4IG1ofRE1A0gyWYtMXEKw6A?=
 =?us-ascii?Q?pm8MIS48ES1KVJ16+UQ4ZEa/qeYx3hji/P58wD7zZadJ2cxj7viJwTbPhlSW?=
 =?us-ascii?Q?raAP6i0aonTtkxdVVqhP5PE9Fv4QkU5LqY15HfMB57ZA1IHHnJ1OcF4L9FXl?=
 =?us-ascii?Q?+rSf8Ov79FNgR6pd1tZnLoGgoQ4Q5fL+8/HtPl9KMthtMT+e3fAy2xb3GeDb?=
 =?us-ascii?Q?HIqT5ZYHiv5FSJHvz8th66LNt09qPANrzJw+Rv7WU8CxbiSBTEwdVqFFwfyY?=
 =?us-ascii?Q?JAumwMa7VJE1YAObpZjTfpgJNXBYjs9sSHUd0Y/4I+e/eJGVLAR1KBUSTmTC?=
 =?us-ascii?Q?YoaxxTE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3744d67c-e1a4-4a59-6969-08df44d39ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 17:52:54.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB877199

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, Novemb=
er 16, 2026 7:02 AM
>=20
> On Sat, Nov 14, 2026 at 05:43:06PM +0000, Michael Kelley wrote:
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday,
> November 13, 2026 1:59 PM
> > >
> > > I was doing a deep dive into the host spec and noticed some gaps. So,
> > > I went ahead and hacked together the patches in this series for items
> > > that seemed worthwhile to address.
> >
> > Are you (or someone on the Microsoft side) testing these changes
> > in a Generation 1 VM, as well as on back revs of the Hyper-V host?
>=20
> Ya, I have smoke tested all of these patches on WS2016 (both gen1 and
> gen2). Also, I have it on good authority that they should be good at
> least as far back as VMBus v3.0, so it should cover everything that
> is currently supported.

Excellent.  Thanks.

Michael

>=20
> > Testing should go back to Windows Server 2016/Windows 10 for
> > both Gen1 and Gen2.
> >
> > Same questions apply to your earlier cursor plane support. I just
> > did basic smoke testing of the cursor plane support on both Gen1
> > and Gen2 VMs using vmconnect.exe on an up-to-date Windows 11
> > host -- no obvious problems. But I don't have access to older hosts
> > like WS2016/Win10 to do the back rev testing.
> >
> > There are multiple frame buffer differences in Gen1 and Gen2 VMs,
> > but most (or all?) are in the lowest layer in how the frame buffer is
> > allocated and mapped. Hopefully these higher-level changes you are
> > making are agnostic of the VM generation, but thoroughness would
> > dictate testing both.
> >
> > I'm less sure about what might have changed in current Hyper-V
> > versions and WS2016 from 10 years ago. My general impression is
> > that very little, if anything, has changed in the Hyper-V frame buffer
> > support, but again it would be better to not get a bad surprise after
> > the code has gone in.
> >
> > Michael
> >
> > >
> > > Hamza Mahfooz (2):
> > >   drm/hyperv: add modes for all resolutions offered by the host
> > >   drm/hyperv: batch dirty rectangles
> > >
> > >  drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
> > >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
> > >  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
> > >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++---=
--
> > >  4 files changed, 110 insertions(+), 20 deletions(-)
> > >
> > > --
> > > 2.56.0
