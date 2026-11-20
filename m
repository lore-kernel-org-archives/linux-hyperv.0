Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196835;
	b=qfHYr6jJ23BrN9kUrAqtyI3WfXDavg5PqOEeiUDmEQz21nfMeMEhPUNTHbmtd3WhBIqU
	 ShJnX9KJ7qC5YCtriyZMXOhdOf4mUuzoQsTtEXTvzd1gYpWcqWeDQ8WPC1ZXiVKoNhJPj
	 Xhg7Qxsa2goXWqtWFVjiSsAKm3nulFEKnLvmyp3LMgkG1kvc0wCZ3QaUGzGLah21N0+4I
	 TFv0Z4wFxj2dqp6FQRMnTJ2xow/ONVohgX28sKqas39DXG6nQkUFhWOhy+l3KEDhyjMsa
	 BBIhRX3iG/HS9bCwvPAc3pWn/wZRrjGTPgC80wLdY2s3QzHd0T3Xhj4Fx/EfbW7zTUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196835;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=yolGwi4mDotrhfnUDhpgRldch0r8bXlgRF4yQeMyddc=;
	b=EXFvigyj9axfLanpdoiK5jfrcAKtJh8K7CwqWnS+eakgkF4UJAZuHydJclRok84wRlo7
	 rVhChjLvWBg+Tdeh07HqTsxf7hrhLu1BmzAkz4CSTsq3+mACf61VhJ1o5LdO5RtgciuML
	 FmXj93QeQdeTvHcD3hTWFmy4Mq9hlwzp2zIJrwtyVKWYkhOQs6zDj614flh6fH+/mXWiW
	 hpClfkLzP1IcBn0ZtxjlU0dYYYZ+QbxGaxr3l98mWE7zfB0YS922GrRo84CF95ZtFUSKM
	 l8yehmGCMWHpytwGZMTc4gtbjOj/GsAX9bSb6LKGazWQLaEqaJip5URgJDrJVLaAHnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lCTgURkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.62
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011062.outbound.protection.outlook.com [52.103.14.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E760A261D;
	Fri, 20 Nov 2026 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E71E760A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lCTgURkF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpVcMvwIIs86cE8D85ev5e0I+fqhGLdhewVoWPdR1IHU9Jquk25uT7mf4NdWON1RcESigwFFVBBGq8GrawkrnhtyMI/21gGMG6coHWEVGwQnDGwW2CLPrRqY33/LI4k8OsmfVbpDCdea6ChqYxEB7+s+j+PMpXk7YBJjUYih3pEuLX0idITykEp+rSSSNxGO5rdfN6FQT1xLphoThZUNqSJB12TlqJotaV8jmWSE7kff7QidR22rpZ/1KS6buNRLR2oJbvX+F77dxS63NGEceVetrQXj5MAktsCakIlMyvQz0yR6QG+7iT+hSEK2QHy9i8ZdOiVQIDQ5QywVK9wE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yolGwi4mDotrhfnUDhpgRldch0r8bXlgRF4yQeMyddc=;
 b=qkZdwVMfQTEmqxjrZqALatBIfcIJufsGio76foRCrG5Sls1yON+g1fqANdm4VA9To4ADNO4pcAl2aeRTjKkRrF1cw4Bn2SNrxiZG+gW6RUtZrp+dnpBTcsceP2+Bn5cHrtGdff3sfFQoR6cM0umud0seiFgLUjW5ym8awRErZwM1Uyu1xDcIP1JGbHL/7ICy5zcbdiNpkxq8sPcRD1DMqv3wutBnX7PVc+nqhBuwryxZK0pWyrpMtSwIe4iEvBdPITi7n/ZQPRcM+kCOG2yXRR1vp1U9GLTeqX04z1n5EuRepng8vSpDOcoQewFpdtpl1V5zzvhUo+PzrmUcUreSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yolGwi4mDotrhfnUDhpgRldch0r8bXlgRF4yQeMyddc=;
 b=lCTgURkF1Lq5ABfNOVjswezDfVScL7+ct/zxAyZ2fcIzjP9yuCxvYh9Mxb0Vo+nw1jTaD5FQ9FB1oW1PZP0BVSaxlXkqjsofToaUQnHGJ56v7v1At+LzA9vMmGLXzPBe1rk5aOBVnzFoMNzjpyHYq/Fvjn+QPngG3QkKkjfqxcjZf/C+6L5vAR/dXq+Ah0v8tRRt3a1w3yETFMH6mhhSEMqqJbY3TxlepWBMVSyiLHV0BQNJ3fZrqfKMCshSkBQt/F9EJdyDBmjIGD9Rh++zRMKtleyvK9cGnL/a3TtmCJS8a4X/HNUy5Ggxdx7mq2Sh3w7Xo7RpRy99SGz8p8hYhw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB8816.namprd02.prod.outlook.com (2603:10b6:a03:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 17:47:08 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 17:47:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob
 Herring <robh@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Topic: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Index: AQJkn8ke3hrUAJD/fxNI/dSM12acegIB3L3RthXNLzCAAsEkAIAAUYUQ
Date: Fri, 20 Nov 2026 17:47:08 +0000
Message-ID:
 <MN2PR02MB6863FA2A0210B584D0CC1C52D4782@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
 <MN2PR02MB68637F500EFB95B333A87429D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <a1520d14-ad7d-c9cf-5a7d-628d04ede311@linux.intel.com>
In-Reply-To: <a1520d14-ad7d-c9cf-5a7d-628d04ede311@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB8816:EE_
x-ms-office365-filtering-correlation-id: 46fc35c9-fb1b-41ed-4cea-08df472e4c48
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRQNNq+z5Gcdho9RrbHq2I5TW24/VQNy86yXvz6W8rdOo4lgkxqMY/2W8+6WHJPmipwGakWRSKoajtUL6xNFALljyMCciRx9+VtPStrOy8bbaTOgARMaoA6gTU1BIG2saTdrfsTSYUIXtDDsNeHHwvxf6K2RFyOG6ZFZbmtij037zDZaRA16xXV1+Jf7mxuXfv00OSctCSfblPa4a+ty3XUQ1M7ZdF/x4KwSRsdJMYilRA2wv02TSwxIhV4Fhx7DMqCSBukdpPpgnTL5SCLCR6px45egqGlaS8i4P+mFFPXjeMhVYgi1YhqedH4scIonzcZzlbGJVxFA9AuH0nKg1HOuK9WkkG9QSpt1nWhXfv/F3H7TA9trgCZS7NgJiZIP3n3VGGB+Gdn/2dYAgRay9fnRCiPdzW4s46+SYlWCaRi3rKoUrzyxxDN8ScGwxWneoQq5jr4+dGpzN1Nktt08gXip8LPAxH5+iaRzNaun42LxyKVMxE93Aw5q5kTV8jdhjlm8s5RSQ2KSsk2QMcm1D4NeWYV4m3NCweJYU8BGs4qQ9o87v7lFxL8AD2Q6Wz56DNmeY8qlnkHqsEhkIyPKvU//7ENuqaTvYg50gsQuHWMPyJloJ4wUlbdz8X2wTpvFwlyI0ConCQYhEQA2YhjzDZ0VkGZ4qfDOQkBqOrIGHViyDIJAUFyoANZsztpC9T1dV+z9/1BKTgTiojX4NzRVlduYHx7i5lBJKjluNt3KzJJQo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|31061999003|25010399006|51005399006|13091999003|55001999006|24021099003|37011999003|15080799012|19110799012|40105399003|19061999003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?N9gLnPi9vm4hvF4LICSFHn/Jg389Ch8RADUGhRSpv2x+3HwvrSQFAx+GFH?=
 =?iso-8859-2?Q?rQmgiwdSbmwurJ1YpGeA++See5CMQj09jzK1VTKrUIrLITiRkM4JKm/m28?=
 =?iso-8859-2?Q?/qSC5ENDZCK5bCkdB+SRsavvvn1kJDo6008+isCu8IQgr5Ca0LILMlvz9s?=
 =?iso-8859-2?Q?LvmSv8A5V94QYXFKF7fOPCieZU1I5MTSfaqVvW2gxqT8JJlaxTYNXoCw1m?=
 =?iso-8859-2?Q?KZWCIdwgSYIXU+yZKdcLaE96llHV0qK9hHMuSXyOGL3p5yVDmIu37M8sEG?=
 =?iso-8859-2?Q?nIHgbyWm/PSye3XPyc30Pp3mj9uxCvqbRU5eX22obAmbC9/g9gIHgZZC6S?=
 =?iso-8859-2?Q?Yi4yAQEmH4S+yIEpRTpPrbdQZzxrPsytkNvqempeO18QpJrqpX0HpErxJy?=
 =?iso-8859-2?Q?DZw71+Y0zavONDzTZmEIizglhOFkQd2f6byGSBWy6As/8tUVJmF3ThQyT+?=
 =?iso-8859-2?Q?RdJPVZCMzhgW75WnVRsos12OqIgRMskiwcRxK7SBwHU1+NHVXE88crqceC?=
 =?iso-8859-2?Q?EQnnxH33GOEx06vvt2fDOUrmc9ygj07Ox19uIFsfPzf6sYDLUqry3r0VsI?=
 =?iso-8859-2?Q?tnhFYF9XLZkgcBi17iHsMBJv3Xr7SZ4I2P21mfSxUGe/A6lxaKAnLMjz99?=
 =?iso-8859-2?Q?i/p8evv2tUa49qadpm7qBZaRZFPNrmNwhHZbNVTM1S/Wd5JvVP5YFBUAK7?=
 =?iso-8859-2?Q?W6NUsxC3LdTqMz/2Mg7gKMENZBKl/5ZM8uK6j24AX0wHX1+1Yecf/hbyeo?=
 =?iso-8859-2?Q?i5/MrD7jTYdU1kUTOQfWL6R6m4alZW3JwPx9ny7WevGRn1J6J/SqrT6z8Z?=
 =?iso-8859-2?Q?8aQkW/gigKpUcBB3ajaiJccGN6SYHZp6xDMO8MvzQD3FcSAEGF3AmTiipb?=
 =?iso-8859-2?Q?EHzUIhP2vCZwtlwnZ1eCXow4u5M1JRTfZYkulkfegokLNVhx4MROoIqOm9?=
 =?iso-8859-2?Q?ngYd5JJXW/CDcfqixfBsnEYmiKh7oAxV2XMrLSLdFB/BjODqVilyB45HuR?=
 =?iso-8859-2?Q?C8LLzcwOhlB7G+KhQcYWGSytv0PrM0Mq7PH9lP4BjZAc7IjQDLn+4gQfus?=
 =?iso-8859-2?Q?mDBSrFCHY2Y235jF6RREv9h98KWHM6OtdSNxz2gk44oZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?12imF695WxzsNiuHDmTO/2PuIqGDxsJww+OsGpPU62jlj1GiS2UjuiPyTh?=
 =?iso-8859-2?Q?b9n43EaHmO2J8HYOiNgoVNomTFtvqNcLDydXX8c5qNZH7XXrw+w5CtS4jo?=
 =?iso-8859-2?Q?1EC4IUqF+wxqa6cy0+YW8LLWtW7feBbbTX2gQv0QUnOuFeA8StGHLJCeQN?=
 =?iso-8859-2?Q?C4nYYPj/zvXw4lwD98+Er94HMi9/RElkn4LqHNfPEvk8LXJulwXspmUACg?=
 =?iso-8859-2?Q?lkGcKa4EFrXpeG17UgewFkQ6ZNHdSnpwx4e634C530WC2kt2QGvGEOL2rh?=
 =?iso-8859-2?Q?IT5L6/K7wOGoiEVaSst8ID6ab0KFatyXX+cuEpLmaeOlUQLObYgwJHo7Mv?=
 =?iso-8859-2?Q?w8/PF4hWZsv3yxbj98wXGwuUI1b99NZYnR9vlhjGhWOuKfcij4WpyFQ6jY?=
 =?iso-8859-2?Q?UZck0eTlvzMLjrudW1mBaktKOJIXmkO0ghm1btMqWYnxJQ6PVGwng48ABR?=
 =?iso-8859-2?Q?TY8LUvO4pvI4B8C/KadEorR/b34lMkdKTrAnzKHyz+M7XkA2M2P4ayD1cE?=
 =?iso-8859-2?Q?3jGQAnEARDZLg8cNvMi5EZfX2UxMelO1hSZmnlBQj917812V3TK8NM4qoy?=
 =?iso-8859-2?Q?QNkYzMMO8G6R4VeVieiEfLTSHuLJV2jHhBonmUFSyN2L9a5JVsl0+zPoz0?=
 =?iso-8859-2?Q?2fwrFPRMknQ8CyRajSlNeFSizCJhsiTaPZbJC6sGh/kkbDlrueNRZag6Eq?=
 =?iso-8859-2?Q?1Ki5x4yRjB7lfFdqlEmLRLkdtMtRBYLqIOiwffA3dUXP5YOHiqLivGWjnb?=
 =?iso-8859-2?Q?vqcuAgmSc/XmT1IVv6Vxb2s9t1fey/ZWDdwR5Lnv7E+rrDFZh48ol605Ry?=
 =?iso-8859-2?Q?KfqV381YJwq6z0eQmv4CZSlJpkOuLTxTE6r+ANbPn4AJ5skUCxmsK4e4uq?=
 =?iso-8859-2?Q?pgCH6LC522Z2oU5QQDqquyoi9xAhxvLJrufXspzWtxEp1UzgtFX5Y4Xxoi?=
 =?iso-8859-2?Q?OgxAVdIptCJXOyxpjCO2Q53DDdP6HvoSLZ/yAQiYLOvOpjGYuf2w/nUR8/?=
 =?iso-8859-2?Q?r7N8LUJeosE0/46M5dY7AetNu7uG7fz1UZNIuA3LofeFmeFYPFZMYoDqks?=
 =?iso-8859-2?Q?YzEaZsEUbztw9yjraixTKHqmPoeKcv/QJ0fs6ZTkS+0J2ocRSteYFKGYsb?=
 =?iso-8859-2?Q?9pkI9S4eioqT+o3A37RXCT4J5yvyP3avok8k17xlYIcjvPdTPQJFd7qlGI?=
 =?iso-8859-2?Q?dsZ38ev5siFLHK/IOvDpUcd0MELSaXxaRSVJ6bjT6Uw09z+g9UANP3l/za?=
 =?iso-8859-2?Q?UTilptDpw1U7GxzkmZuRmqUdEubyQcLHuDRL2vuuzwnnkxzh1p0I0vDmiW?=
 =?iso-8859-2?Q?rInCQF/0XP3EKoHJgQm1w3RnfCeq8cCHxtO6oD0RhjMEzeYIe2KZ92bLOZ?=
 =?iso-8859-2?Q?8a9sVVlyB6C1jw0wshmG5Velhy5WuEFXetRktK0GM3Y8ObN8X99OY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc35c9-fb1b-41ed-4cea-08df472e4c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 17:47:08.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8816

From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> Sent: Friday, Novembe=
r 20, 2026 4:55 AM
>=20
> On Wed, 18 Nov 2026, Michael Kelley wrote:
>=20
> > From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> Sent: Monday, Nov=
ember 16, 2026 7:24 AM
> > >
> > > The pci-hyperv driver scans the bus and assigns resources using
> > > pci_bus_assign_resources(). That function makes bridge window sizing
> > > disjoint from the assignment phase and is going to be removed.
> > >
> > > Convert pci_bus_assign_resources() to
> > > pci_assign_unassigned_bus_resources(). If no other bridges are involv=
ed,
> > > the extra sizing should be no-op.
> >
> > I tested this series on an x86 VM in the Azure public cloud that has
> > 5 NVMe devices and a Mellanox VF NIC. All 6 devices are PCI pass-thru
> > devices in the VM that are initially set up using the pci-hyperv.c driv=
er,
> > so each device has its own root bus and bridge. No issues were seen in
> > a basic smoke test.
> >
> > I added some debug code to pci_assign_unassigned_bus_resources(),
> > and indeed the "for_each_pci_bridge()" loop found nothing as each
> > device was setup. So __pci_bus_assign_resources() was called with an
> > empty add_list, and as expected, the new execution path is equivalent
> > to the old pci_bus_assign_resources() call.
> >
> > Question: Your cover letter says drivers that call pci_assign_resources=
()
> > directly are not covered by this series. pci-hyperv.c *does* call
> > pci_assign_resources() directly in hv_pci_allocate_bridge_windows().
> > Is that a problem? I don't understand all the details of the PCI resour=
ce
> > assignment well enough to judge for myself. :-(
>=20
> There's a small name mixup here.

Indeed!  My bad ....

>=20
> pci_assign_resources() is to graft a device's resource (or a window) into
> resource tree, whereas that calls pci_add_resource() adding windows to th=
e
> root bus and that seems to occur before there is anything underneath. At
> this point, there's nothing to do for the resource fitting and assignment
> algorithm (it iterates the devices underneath).
>=20
> ...So I don't see a race here related to pci_assign_resources().
>=20
> Most entrypoints of the fitting and assignment algorith input bus, and I
> don't think anything in kernel would as to assign resources underneath
> that root bus. Only pci_assign_unassigned_resources() looks for all root
> buses, and that is only called from arch init code so I don't think vfio
> setting up it host bridges matters with that call.
>=20
> There seems to be, in general (not just hyperv), some races that are
> unrelated to resource setup in host bridge setup and scanning. I'll see
> what I can do but it'll be in a separate series and those seems to fall
> under can-shoot-oneself's-own-foot category.
>=20
> Thanks for taking a look.

Thank you!

Michael
