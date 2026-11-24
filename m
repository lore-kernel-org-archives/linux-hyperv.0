Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479274;
	b=lIs4ZJK8eM1ZsB9rJ10fVxpB5PyQOgtu8ouiAXzcI06K68lvRT5yffKPsHlG3JzZRuDZ
	 QXDKl2iG7QYZyyG8ATZ/dzARhyJ3bOpH7OE9Zewj05Bu4u6etJna1jYC53hmf0p79Lcwt
	 G/hXFzetzqj/X7JMdx4GHOGA7ZJQi73CTQuuoS88Y4N7pZcgpxpTTNWYVii687J4ik1mr
	 9rx1DqUbw7ZmsuiUuG1A6z0DlxEHjvJgxc69mCZDCqcEIsGdTeWnR56SytxahiarZNbGA
	 5mM8raEpFp5JQQ3OYHoYfQVj3QkVdXxNFGU+5cdOlKglNu4+gximrm83JRsgJg60GlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479274;
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
	bh=jEUz3Vd3O5i8esCmg3/+isHFXZhae/LPeoRVOi8jwrA=;
	b=A37+ugE13WhF/AZeghcrh5ocP1X/O4+1QeX4lcuqt7sYtoaR47uQnSDnc3paVxyMqU9Z
	 bQuVR+4oKHeLjwSZVq5C/OABopj+xBVTpem226G7sGbpvfH322gn35Mzj7mDT5x86Ufwz
	 a4IVqVF1jKUj00zuhvvJxMRr/q6JBpDDq2US1jR3RTWQlmopaQNVvWBYebW7YG5asSkod
	 6nqbOmDuasZDt2k6UQOpqxqraVAkWyVNeS7ljfEkZ1B+aLww1P1dNEN+ma1ELY9xJtIIo
	 gRgP+UP4j7SZSRHuAF3Vghau/dgIx2w0AqCRuhwBHnU633hWI50q0KzJinj4pbXtjqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QYpA0K0t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.91
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013091.outbound.protection.outlook.com [52.103.20.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA69606A31E;
	Tue, 24 Nov 2026 00:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QYpA0K0t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/oxUZQvDvIIWrXB46u4fEPv6A6m2Yhgmb79PXZArbJiNATy7SctW7kpo0mBAlSr3u9qL3e7Gh2tfUd/2X8F2KqmToxr1SKZnOmCVujfVcfr8IsWV7F9N3UZ22M6VoYjmU3VCPeZS28jD/20Q8PaiAA0WNWdY7hD9tYlC+v3ZTZFlL6TGKN+1BQ3t8a/K3mjluR1h2bT0pcPjZFALj4i/JQoOW4mNmMhbDlEbmdJ36HPIC3/UHFBU8b7+c2HIVOg5+Mh5pv1xFlxx0KwnBElTZNDeP0rbTQsQFmoCsuN5lU9Xb7KRDzf6VlrY2NPpn4ciL9FhkAMPqXk5h5735BkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEUz3Vd3O5i8esCmg3/+isHFXZhae/LPeoRVOi8jwrA=;
 b=Log0v4KwN5/PcuTr3wSnndmPFDm90Sto9BRo/3JgJJIG1pHfKNROKujK6dLl2W2sgOHtYUCh2KY66PAdnj791oXJ9Lshe5gSeAXlIlTiovI72gZLinE/krDB/6N8nGvlFC1NRSS7M5rdDkjo3LY4duxPanlv7g0PBaw8UbXj85iOKkhzf5Ja/7wqrbFB+8XlJRsXUtXOtPbeQQiXzEEyjD8nOG6sCoEeSJ1+Zhw2hj+tIbilz6/hUQQvfIXc+HK08KmsXAtARtgcIuEN1EPVvXzaREv2L0KXx55OlAxneGY3GYMGPFoIYTcuH5h7++CshA49cyYvpHbzL0PmQkAW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEUz3Vd3O5i8esCmg3/+isHFXZhae/LPeoRVOi8jwrA=;
 b=QYpA0K0tcAWVcBuf/WSUBJOEDLo0MY3m23c/JNUrBvdXqBwuetjYq4yVZQmUIczad+nn4lrgiq2J0VBsMFzYi1/WE2qUFhzmkRgYj5TTPzyQ3kcp6K/vHhdHZqYv/ttQXIsAppFl0J5axBH7ydTvCmcL0r/hH8LsBOf5gNMhuhTKXvfLO5lXPDc68M5ubyu2iR1tIVhkXiKlCs7h8BMWEMDIZr91SYZyqAOJZAlLwUlUPOdIzlyjzptg/UXtUDFeCJE3wh5Rn3TlMMsy2QhHdmKPQrONoDlWGayoNFK+Ur8DELo/1JEQfGMXGFaOv6u6rVeSnwpP9FVlqpuMMBVBOg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA4PR02MB349042.namprd02.prod.outlook.com (2603:10b6:207:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:14:31 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:14:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "zhouchuyi@bytedance.com"
	<zhouchuyi@bytedance.com>, "houwenlong.hwl@antgroup.com"
	<houwenlong.hwl@antgroup.com>, "qq570070308@gmail.com"
	<qq570070308@gmail.com>, "bastien.curutchet@bootlin.com"
	<bastien.curutchet@bootlin.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "jgross@suse.com" <jgross@suse.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/5] x86/hyperv: Account for lazy mm_cpumask
 maintenance
Thread-Topic: [PATCH v2 0/5] x86/hyperv: Account for lazy mm_cpumask
 maintenance
Thread-Index: AQHddnQs7LlC4JlGeU2rFOcYc1/5Yrc8ZJ6g
Date: Tue, 24 Nov 2026 00:14:30 +0000
Message-ID:
 <MN2PR02MB6863FA48FAC9BF8447B305A3D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA4PR02MB349042:EE_
x-ms-office365-filtering-correlation-id: 45ff747b-b71c-4378-6e6c-08df49bfe941
x-ms-exchange-slblob-mailprops:
 iS5pQZgsAQDZd5pLvsexcGXRgbvG27NWPen5qmTOYXFP8jPTX8noZ+7SCsFlb328AJsp/OrV0IfSQtPJDTOyqMWk8//O7fujK+htO2PjGLTrBJmjUy2jB8oH4O4lCWjI92ZhZrf5V5anh8jhETz/5RrKqFQN4kJ3BwME8NaqAtsdQFod57ocKnhcUY7Pjjuj9OHRXyQIBb5fir+uahtQiP0ybzcCOT2i09xyvglw0XZy5gsLpJ4v/zh1eQ7RQ5uh7HppTMRb5WnPRI0iqs4iKKaQFIObcG+1Pv13I+lsEPqjXFbqYU7z8HARmQeH6esCEXo/kRMGbqmeRKg2yAMIrfKn5eMBiby9XB2hDaIjhZgr2YNW01q5sZiQEJY+fyukeIOsXDYclMpNxIF1rPclIQtrVd4Mm71fCFhy6B/0D/43741bfWHMyDIzU6U5CW43Km8ruoxH1Gyfe/+JU6wVH/1uleY0YF30xVD6Z80z97QepxBWU4YA1S/cpCll6CSbWZ+E1o69uNZdUW00DHxwBVzeM5BkFLdIf5KAAR2dMiMLPolLA4clIo8pZif8mxFtk4m05WfsPQ8lWvZDMnkARLrbKlEoQWbdEqhBNKpmI1GveMFwdqQGPhJzE8DqYic3ltx2bMkeYydbDpPLhK/KP1PH/SIAF4Q2vQX83C7zwoI2+rZ0uzQNqYVeYJhIPETWNr5r1Ktc399yP3qhqysMfnuTBrXVbDQzkegcJLgo1l1BDka4ptAB0iEjkq4Lgq3KEUqrUVcWffNk1NZx6nHXGfKPi+W7SrQtyxSXPgV3blNn6FzRW4SzqscRTw5rcYpO
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|13091999003|25010399006|4140399003|51005399006|21061999006|15080799012|41001999006|8062599012|8060799015|19110799012|11091999009|37011999003|31061999003|1602099012|10035399007|40105399003|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0dbF9V975Z7aFCyM8ZQY1VpRkUD0uGPWK6ANgIigjkt12+p1yz3LQatMzgOA?=
 =?us-ascii?Q?IUH3Qxraz7IekI73E1XpsA5xpu6bw/2Gibv3ySyQY0ykamooesUMlrKT6/ST?=
 =?us-ascii?Q?NxWWQgvCakAWUMiw/QE9PCO+vBEVdwNTz+26xqc4VHi7wfm+EVKrbvWDUtMh?=
 =?us-ascii?Q?YNHHKbfFCGhTvShpxnNoTbbja6MVQb/ZOx20RMZA+k2DRFk56eGb/CzeP2xg?=
 =?us-ascii?Q?Dybq3crela0Rqq2UisUAylFm+dWCBzcoShp95akAQUDQXFGi+T9qTHXqwATh?=
 =?us-ascii?Q?mK1bhR/UvkuuRjgwJ5IjNJQbcrhRznfs+/zEM9wIjosB+cM/j4X/yAIH523S?=
 =?us-ascii?Q?BXgCSPMfIbKzCKJvvpDGjGANttrMNJ/QH2uQF3jTh6phWlDgS+tlzkLJHFku?=
 =?us-ascii?Q?QJaRk958kMFUmfL3+4QH47B9uP34TOaOJYSuo4t2MG3WYwLVqz2UO2UySbZY?=
 =?us-ascii?Q?TvFv2lOj1jfvg6VD7aJBcPN4TDhUR+8k4TaUzS15Kf7GcatDRlrvsyYHMoxq?=
 =?us-ascii?Q?R1wnyxOjgBXRSLKQGVyPqouRGZfRs9oCh7IA2o9tlpkanClbmBoXCV+4zgj4?=
 =?us-ascii?Q?VWnHdg9+cIYuXa4MBAbH7hNWxYSOEcJQpK5I6YIplaRlRW8tR5svkEIKTMgO?=
 =?us-ascii?Q?BcXal5bvpfkMocjeTjlbNg9GZghfI2a9xapqA0yp7HgLTzHVLbjSXxS9Druf?=
 =?us-ascii?Q?GuUV/Y3SCnp2Luvb7y3yIYJR0t6eprlimAN1rp1Mx3SoTfBcPc8Jx5oK88HY?=
 =?us-ascii?Q?e5r9o7tcwOt4A5UOpP5B2TGxpiDVaahhRFSXIt+OFmrzxOL43gWNohKSQkOO?=
 =?us-ascii?Q?3sDvY3bwHOFKAeyZa97LCBbFm2TsMx+NacsViC3u1xi6O0S+2AGBHZaI5l92?=
 =?us-ascii?Q?mQ2nVHQwf58XbiqjL0TBRboJgLR3yx5612xZ2qt1m9lu8KmAj3hv6hXS3+pd?=
 =?us-ascii?Q?Plr159odqk1Yq52z2imuHWHU3jS/LYuMc1gE9SPCvrNrpQfpi73qI9veWfLx?=
 =?us-ascii?Q?Rb/PHsLSA6qrqk44+DlqIAybTLl6rBocz+Rwyg6ks8Xi9vggPlCFsN8zrE26?=
 =?us-ascii?Q?Glr758wssbrvjEHmcmS8nsayYN/FGXbiBfuGprPCrUYb7RU9gFn5wqgKC+vp?=
 =?us-ascii?Q?PjSpGA3K2WhJgRBtzd1o/05hqG8FV8ftHSpANixi+nEQub/A0IIdtpA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SotlHJUo7wq0Gk24pBpahYSwvbuDAfYBUHjt1SgC2amYOuu88usK4Jrkoexa?=
 =?us-ascii?Q?R3iFkWgTLzj1TB7Hrdvnl3si9qLcBcbYsMi+//0WPo/VQmRcdODHUNSv0A8U?=
 =?us-ascii?Q?Ees7Gy4UhP+tKO1fUI5gnbwzm0R5PByonYRkZ/tAGJQdxUSrfW3MaRV5quiJ?=
 =?us-ascii?Q?JvVWKC+oUleeaBCfLTeJ1xUQG3plPaR8BQBwbKN6f2vJSlMs3KSfNheE08UK?=
 =?us-ascii?Q?jrknL51RJua+cN4xzvU/DYg0OQFXqDNzn7JZU9H2IXqKZFxKhxNKvGXUcaMR?=
 =?us-ascii?Q?iZ9qqmAYjQCkHT4F1G1VNh00YbRrHWXTJVHPyoUNOoOymPZ84RNBmP+2Iy0o?=
 =?us-ascii?Q?jS9sCfcqwGj8r4zFMXjPynbKFHMeEqFM0UmJn0TDzloPPbWel5r1psfWb2Vp?=
 =?us-ascii?Q?kf+Tl5uyVS6zhZcz7/1DgufQeRN3sfyfThj2uLg8GBarQfOX5ZUNdpHPM2Zb?=
 =?us-ascii?Q?tdKHbykFDVubP3WYZu2W4Odb3gfDldKWroFCNCptwzydbvQ0Yprpg0BCYiE8?=
 =?us-ascii?Q?UgfLISlLoKiFROfH23GPT/CnwFcif3KCJKutJ+BYOlgyrAJV+YXr6YO2px3C?=
 =?us-ascii?Q?5l0hXBeNBRAql5GmZtxQHpWPNrmcLsbx19i9aNkrej/S24cxcz7dmMui6ROH?=
 =?us-ascii?Q?YHe0pW9+tkyVZHzov90HTWwb8bRLvChv2Z2PBek0w6dyzkQpHWv08GWCz4po?=
 =?us-ascii?Q?ptKHRpPdgXLApxk1+tQJ4cm27ve6wTT1j1CBUxBdu8vVYLj+9l4d64G2707o?=
 =?us-ascii?Q?gGwB2Sw9Nqnu1XobzA8Ecems0tntH0wJ13G/RUp+f5PXbEf4vqoaweS3ikNR?=
 =?us-ascii?Q?gjFve1k7N5RaDxUqf+CUGtZ4mAUO2gWcAon+jBtZsrpZ3fDKr+wvfXr/XcvM?=
 =?us-ascii?Q?c3j/A3iPw7xmae2r/C3NLAnl76ewsk4Vdi8Pow63xIiIhenMa7ShoGI1Dxwq?=
 =?us-ascii?Q?Me6iOZAcyhujkSadOipP32YcHel6jRdvYwW7sqTENOzhVq4Vs8n9CD4sjmdB?=
 =?us-ascii?Q?XJsdvVEFGf/nmfmm3hNjLzG/A0H0kNjxeu2v+bIQ2jLg79LX8e/dErl9sWbM?=
 =?us-ascii?Q?N+9LtTDE3n7G+HTJkARzSBtsAcEpzdUMOYYu+ez1uynIQU/D28uRGYBVYlef?=
 =?us-ascii?Q?Eu3gDJpvrTi4zAtpTDUms+93hD7q1qb3Aa/3XMwz0pA6oGcBQ+J6EJxzZDYD?=
 =?us-ascii?Q?4hBbmlm5xUhL2gNyCYaDXyGYvlmyTfeftyASpS3HC60mkFybDKFkgsU5soD+?=
 =?us-ascii?Q?9TkpJCOn5PqKNL5dDgqIdlXCxCTsZi2Fed359peYRlYWz1987zB6bFZDJQG8?=
 =?us-ascii?Q?pIv1ZCEGOFFyUTvz9JFnEAHrpn2fJTJvm0AHVwmBS0TEonPQhm1ennc4GU0Z?=
 =?us-ascii?Q?NuZLIEs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ff747b-b71c-4378-6e6c-08df49bfe941
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:14:31.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB349042

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
>=20
> Lazy mm_cpumask maintenance leaves CPU bits set after switching to anothe=
r
> address space, with stale memberships removed by native flush callbacks.
> Successful Hyper-V TLB flush hypercalls do not run those callbacks, so

I'm not sure what the "Successful" qualifier means here.  See comments
in later patches of the series.

> historical memberships can persist and cause unnecessary remote flushes.
> If the mask covers all present CPUs, the backend selects an all-processor
> flush before reaching its per-CPU lazy-TLB checks.

As noted in subsequent patches, "backend" is very vague.

>=20
> This was found while investigating a regression between Linux 6.8 and 7.0
> in SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs.
> Recreating DataLoader workers each epoch caused host-to-GPU copy stalls
> and timeouts. The reported bisection identified commit 209954cbc7d0
> ("x86/mm/tlb: Update mm_cpumask lazily"). This is distinct from lazy TLB
> mode: a CPU actively running another address space need not be lazy.
>=20
> Patches 1-3 prepare for target filtering in patch 4 while patch 5 adds
> immediate cleanup.
>=20
> Patch 1 rejects VP-set conversion failures that return zero, allowing
> native fallback rather than issuing an empty-target extended hypercall.
>=20
> Patch 2 makes the native target predicate reusable, retaining its
> context-switch ordering and adding a clearly named callback wrapper.
>=20
> Patch 3 uses native callbacks for requested mask trimming and global ASID
> transitions. The latter need guest callbacks to switch CPUs still using
> local ASIDs; a Hyper-V invalidation does not do that.
>=20
> Patch 4 filters targets before selecting either hypercall format or the
> all-processors shortcut. Page-table-freeing flushes remain unfiltered.
>=20
> Patch 5 separately requests best-effort cleanup when no remote target
> remains after filtering. Lazy memberships may survive this cleanup.
> The cleanup policy remains open for discussion.
>=20
> The suggested mask-weight > mm_users heuristic was tested as a replacemen=
t
> for patch 5's approach on a 32-vCPU Hyper-V VM. With three remote readers=
,
> mm_users was 4 while lazy memberships kept mask weights at 26-32. The
> heuristic requested trimming for all 10,000 flushes, and each reader
> received 10,000 remote callbacks. The scoped approach used Hyper-V
> hypercalls instead. A doubled threshold or rate-limited policy has not
> been tested.
>=20
> Earlier testing of the monolithic patch reduced the 32-vCPU all-history
> reproducer from 17.235 us to 1.622 us per iteration (two mprotect() calls
> and a write). The reporter's application hit the 600-second timeout on th=
e
> unpatched 96-vCPU VM and completed in 424 and 436 seconds with the patch.
>=20
> Changes since v1:
> https://lore.kernel.org/all/20261029064234.362385-1-namjain@linux.microso=
ft.com/
> * Split the change into five patches with separate explanations (Dave).
> * Add the workload and regression context (Michael).
> * Explain the ASID fallback separately from the reported regression (Dave=
).
> * Keep related predicate/wrapper names and comment the definition rather
>   than the header declaration (Dave).
> * Explain target filtering, page-table freeing, and the no-remote-target
>   cleanup condition. Document the const copy and lazy-membership limit
>   (Dave).
> * Test the mm_users heuristic and retain scoped cleanup as a separate
>   policy discussion (Dave).
> * Omit Fixes tags and stable requests (Dave).
> * Rebase onto next-20261116.

I've provided comments on the remaining patches in the series, mostly
around the AI-speak in the commit messages and code comments. I
still intend to look more closely at how/when to initiate trimming, and
may follow with additional comments on that topic.

Michael

>=20
> Naman Jain (5):
>   x86/hyperv: Reject unrepresentable TLB flush VP sets
>   x86/tlb: Make the conditional flush predicate reusable
>   x86/hyperv: Use native callbacks for trimming and ASID transitions
>   x86/hyperv: Filter TLB targets before building hypercalls
>   x86/hyperv: Request mask cleanup when no remote target remains
>=20
>  arch/x86/hyperv/mmu.c           | 71 +++++++++++++++++++++++----------
>  arch/x86/include/asm/tlbflush.h |  1 +
>  arch/x86/mm/tlb.c               | 18 +++++++--
>  3 files changed, 65 insertions(+), 25 deletions(-)
>=20
>=20
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> --
> 2.43.0
