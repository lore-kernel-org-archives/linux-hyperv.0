Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795205311;
	b=esuzKKd3wUttE+ye4kt5VKr+KVv/GDbXDQSNow2q2LaGoZsyx7RdFQ8SSuxcD+LZDAny
	 Sr6WNhWMjQCrYOUJQrSlLA21fgCk2JCEtHq+dcETpDy74/V2J9Gq2UmY4vdiMuMs/MHzP
	 yuTOc5fjNnB8bj9f8dXPL/ph49gWmx4OEavdG34xZuj1Tkz9SfEuMl41hQy69+9c8Gf6l
	 /M5fS19dzQeX9cbEndEJQihFZxvU64ZiU1wcaVlHAsJFjEWepY3Xs+QbYI4dfh3cqSoOQ
	 OLvnnV1Kd77Mgk5q0TnhkUPhMMw4jb+LSxBrF37VfQ+Odoqw4D05ls+qL3TaDCyF6dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205311;
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
	bh=c3L+Jv/9IG4SANB3cN+RAGebcUQA1e5kXkGdadSXBaM=;
	b=LbuOScwO3zagXo0M81khLYNBGad2HAqprBa+tVTvdTU737i3LwIEKK0ma4Kf/VKo9I5d
	 5CfkQhM1DhJFfNWXWezTsyjK0AD7eXKe5vl5Httr+rXvQ7b402wy9PsgfQBYmHIHSYVRx
	 FtsmA62aAR+5Kedeh80aYKIIRxAVT99OTRZm7mlJucelEmdQL31trWzbdnF78lc40JIJt
	 BYWzZ/mzSlx6MogXS8npI4psH8269ktBvurc7otpl6i/HJGNYHggEk1b1hnq3ztamvBW/
	 JM3LqUKXYWq56QUmWuLc2hC66DIt1FGGhoEjKyEbf/vfGJireCHfxO8l+0A5maFzRWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uIprtqrd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.94
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010094.outbound.protection.outlook.com [52.103.10.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B9606A6C4;
	Fri, 20 Nov 2026 20:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028B9606A6C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=uIprtqrd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w72UfFiCX5qSjaTvU5a1Sgbb5p1CSjDj7cmCg6dPSZtTO+FZcaQk4n2HP+dVXQtqig3hBfMrcxyAYY0RiNYeAR+4tU3VTpRxGN6ABrGxzp0hi7SwhKmV1AwEdpTVeAnfmysShedaj6qKPIKhxI2XkDNJU/wCRoYU3yunDiq48s+weW9LM1FVQgWlQXGTVifAXygB9E4xl7XgfW9sqNSdVucqRnLNKOZfXO1o12JHS5X2NtuEcrcne07R6xfXZVK3OD68BKf9TKMqRAM5B5jzyb2gC6sttKmzwgLWu4xMhwrnN/UaFw6Z9z6x9oIiX7WHzOcyORvaePOtQ0aqDctv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3L+Jv/9IG4SANB3cN+RAGebcUQA1e5kXkGdadSXBaM=;
 b=MxuBE0QZke7mgiXrCu6d1xh/AHtvn7Y0k6MtZbb9C3FyHUfqq7BCnvSCLD7k/iaJIiGxOlrXLf/7X2q3snXZBCOD9A4aiVyzo1TzGYct/+JE3rk1D5cVX9HLKhhRlL1qW7w8Ehic4d2/Vw4I6UTPqa1wSQsLDYu0MB0YYkd05r72FGvSLWL3y/EV2E7nASoGTpcklUyRR9wPIBhvjbDQ3YZv+H02TuHP+gKBF3jVhs6kSlO4Dvs4wWYSMYz6CRZFLhUisJrC7gUuUZO1xwQzbwGt37m/618evqodj+qvE9Gs4hn4ENI9KnUY7A65SPssUErUvzCPbE7O8Xp+Ihv+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3L+Jv/9IG4SANB3cN+RAGebcUQA1e5kXkGdadSXBaM=;
 b=uIprtqrd1rcnYujdX4unMi/kGBwx+CJokavIa/G2GxyGyqzbQUmDPkXL/Xa0Q7PyHjJazyjYev4ky92iOw+H3dJvsgzL3ZmmJvaNsgi2x943ExI8i/NYD2G9ACbP6ZDicYgqZF0K/i6hbrTqxyGKW44U+Fyr9PTI2knNG7OBe74qs+s2JT6+r3/EfDuMzX62tP7j6E4h38P8joblSy0woNB8Gnu1PQVasHVY8o3RidgJa3MVm9o6PsySf+l/MU5GWOXgACPi5nYKdF/9Ql5CxFEzRr4/i+GYMHu2oDH7pY44U8Q4ihNRBTNW+pUuEZNu+TidhUjdm0PIm0J5C6HO3A==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CO1PR02MB8635.namprd02.prod.outlook.com (2603:10b6:303:15e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 20:08:29 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 20:08:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH v2 05/10] uio: Allow untainted use of driver_override
Thread-Topic: [PATCH v2 05/10] uio: Allow untainted use of driver_override
Thread-Index: AQMfJRX+ztp9Zvox4aPtllK0egdUugIWEi9PtKM2iFA=
Date: Fri, 20 Nov 2026 20:08:28 +0000
Message-ID:
 <MN2PR02MB6863416350047853E8C13756D4782@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <190f97fdc22c161c4721283a2beb20bb477f9e56.1795171088.git.u.kleine-koenig@baylibre.com>
In-Reply-To:
 <190f97fdc22c161c4721283a2beb20bb477f9e56.1795171088.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CO1PR02MB8635:EE_
x-ms-office365-filtering-correlation-id: d5796a99-1f8c-4823-4ec9-08df47420b2b
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/jjyMcAHWl72QJU+4aM73nXBhiRKihK/yFBUsB4HUkEf8LXUkf9ZkFAUvK82MnoTDTQH4GDAciYAifFaygP+1dS8Omr8GkLf8q5T5CkoklX1PxE7JEc9abcIuEsqrhgqLTgEY8W3bXqFGuSerTDY5ZTkf/svwkL9R8k5nkvtU4uIiWLEejTxppV/J/PmcJtiPE0reAu4buhlhTcXQ0WJTpdUp36guNwuBFLZvRCMDOxeotmCWctC8/pJZXeJypOkfWgNu0VoNdvkK+bl9jhiQ+bvoJYkYW/vcIJM2150+BHbRCmEIy2zLS2A7pEK3Y+mpwOtX//XItjhwWLSIoljoC5K472nNlPKGXP6S71TxKa3I135AAj+8oQTqNmfOIyX5VHFBKUvIOBRDi3GlnxjG/a4M3Z9RVONhGWX0ox7dQu+8KiNQ96eB4WhdFTdQ6N+HxaAFVkkVlk7YcomvLWu8AyNY3wFTrCk93WKFYlvhbCIKC+eWC5FLKKtV85/KSYp7mFetvvoOU8CmG7bfpxE6zHa5XWNarB8i6SjVKqoa7grsTgLRMg4K5hnmpyLTP2y1vHCeK4wtKV7QaekpsWaSBwWAXT6qUAv1hcRUphx4gkYd76rZAUDFLD1Vo64LM+ewRNkcEVwdAy5nTYyfeKCOi9tD4EdRrGyQRLQdWC7sqHmWjZLaD9rR95vZ/7orce3jE6MnOT7Q4LFspJ6VjyBt3IcZVAhnCN9n
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|19110799012|8060799015|8062599012|24021099003|25010399006|51005399006|13091999003|31061999003|15080799012|37011999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?t0bRVgAfE2upcEbQVL/ceJKnhyZXV6RFP+vozWwQkS344LosQxpYX+fh6g?=
 =?iso-8859-1?Q?irIcVSV0gumOFnrFLFksA1cRTxU9jK5eAkP7dfhGp1Z3RLb2KYxAjTO/B6?=
 =?iso-8859-1?Q?9ValOvQci2sKE7XHaa4dGBzVuvUW80ybM83FhhJP224HeuR8ajWbUcd/bh?=
 =?iso-8859-1?Q?gpCB1cRwhI4h0EdA8aOtgfl63YQfBKLtFnWVCIR6CiUbDLB1KsSYZe9J3i?=
 =?iso-8859-1?Q?rM6IzQK7ZrCjlZcLwrtcFdVEI10gzS1ggnFfO69rtxGH6JGLCFoMJ1Ya4d?=
 =?iso-8859-1?Q?Wgt4ar3oOpEClA9HeOCsMus4A0pnAXbpXXdOTiOYQb4rw3PtbYrk4GHd53?=
 =?iso-8859-1?Q?EWBfpajEVpDEsZKUcjOhT4EUyEHByxmaAydMNyTl6RSLixJTt4/NxgkbqU?=
 =?iso-8859-1?Q?0yaDzk9D+pz/yU+2W2boe6g1r36yh/zBkSqXbjSoT15xHUf0xbjWjW3gP0?=
 =?iso-8859-1?Q?CX49A/Vh2cU7yHzkcDD27qFjCvRcRAylg7np9hE9dCfCwyTrFmJvUFFlgf?=
 =?iso-8859-1?Q?Yxr5mBowXoMI91BBdbFLRSL0dc/a0muP+HGqAbRA330ODhWr8cHeql8kGs?=
 =?iso-8859-1?Q?LVrWUOYEDWAkGyFpJR5EqdF3z2x8CIZKdO47fUyT+UsxlOmMkn8IT4oVAb?=
 =?iso-8859-1?Q?RScbB7E/WghZ64AApgFT8x51pX/IgDI7I49z9cOImXkt00pDnQH4rb3RWP?=
 =?iso-8859-1?Q?j4jaVZjmTpWgVZTvqFFCnE08/v7sF3ALeMTNjPf6r5hgIvfkJs088GEb8r?=
 =?iso-8859-1?Q?Kk7KAi5XRc8XDo4nTpecyopXlhys7bkPlsVULOtojHZnZCEIhvdE2hV7x/?=
 =?iso-8859-1?Q?VEIkSPMohJOsQPgDiK1GXNnPoOJ9OXqUyTgHkhbEwry4CF+DnNL2Csxfi4?=
 =?iso-8859-1?Q?9qrkolHooVRci0y5T5+DQPWXDbMs8ch5m+Xx24DOPUg446YRwAmZ12Qgn1?=
 =?iso-8859-1?Q?ZHeLsj0mzs8NKGExajzrTWmadldYuriAJVhkFQRn83nUnCBDX4+GI3Rjb3?=
 =?iso-8859-1?Q?JxqCeFiBUEajmq9XLE5r6L8YVVilSZ2y2DBEIMD5vP7J0t1tjyHr8DPe2/?=
 =?iso-8859-1?Q?7WmBL9SNWQhxIjdlXlj9NWc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5UqVlBsFVrYBQmx96iCDSc0QWIm03z6/J/TwRuSDZUecuuVTchc0D/oeIg?=
 =?iso-8859-1?Q?vzUz9JO3WkojwPIbPk4V26tIogiDZfGYabPzs8dEK1VNZfauF/9eNCS1Jm?=
 =?iso-8859-1?Q?9Hd3+Fzwvaw4dJz2piW7dzg5RbBIgRpO/gMl7tyMHSFZydyWYNZm7uF2lW?=
 =?iso-8859-1?Q?woLdiOd9HxCkTcO7s6tjMOwSh1u2GwBvxFUhnzvKu/8vQLl0txrm50fZVR?=
 =?iso-8859-1?Q?FRh8SWWpAIwpt7B6n3iG5gNtLZEpkCGRHjyIVoRgrroXpjc/8LNVTOCXKY?=
 =?iso-8859-1?Q?IwEK1pBKBsbkd1m2AC9kloIkItUrDJJ7tCXypVFqFB301PjWjvqDcqzsfs?=
 =?iso-8859-1?Q?MdNowKu29pEV/90+Vd8EWRQ8NXV/SmHmKFtfm25J+TEAGtFFtAPvJ7/fk7?=
 =?iso-8859-1?Q?4eEXPXSZnwq+0H45Q+bIGQGQNsSv5S62Gl1vJOLCeXvZrAEmCmHoAHvNNI?=
 =?iso-8859-1?Q?MDWVJSInGD9lspGxxAwg1c5R0A0h1LUfCyiyrKXuPsViOk8jsACjzi7jfF?=
 =?iso-8859-1?Q?3/vrG0B5dz93iA6zgP55eqvjHXZWAO51UmVVDxFaCVIV9QVT/gJ1LtvYPF?=
 =?iso-8859-1?Q?throbVcBl749ON+9pHP/1xBwtRtYc+qPznh53BspWCrbnQAH4moLwm7D60?=
 =?iso-8859-1?Q?xT5jFzYn0w0PiEZtxVpydierqDkLYuOIiQs+yAPUdgoLZSqgIBXnGPo9WJ?=
 =?iso-8859-1?Q?QLsbEKWwTv7E+C71eMILGeGTBfyWER9LHR0PV5ISO5ZmS2MECMC0J2sczt?=
 =?iso-8859-1?Q?C4NF/x6ND6lQddFy8lcs6+sLtLo50QRQ/7r7GIm15P9No9A7KUuhCqyzVl?=
 =?iso-8859-1?Q?2be88EfyarUNKvQjKb469nKIynShoCtG+ZUh3kWH34nFBGoQSk2N7Ddon6?=
 =?iso-8859-1?Q?2TZwRY8P+XDpTiuSc2z5Uljo7tVwGTBJJkroF8dZbaJ47Ey3F+5VGvUPo8?=
 =?iso-8859-1?Q?RdFXUVc3D+zzl/KCfLoLvYrSTQKmay+qf7KhCrbWvDSM5HM1hTMRoyzNaR?=
 =?iso-8859-1?Q?TAeTUA0QjYTGusv926tfbivIEksbYlOVfKAJrYGDFWifEaKZLbpU2ZWmmW?=
 =?iso-8859-1?Q?XJCag5TONHIuoXeyIg7OKDX1pCnS5W0b4b16UFLijxXQalNZ5t36DGfVZR?=
 =?iso-8859-1?Q?Nqp2qAc13etvBEKgY3nASy8K6K+wHMptOM2+LELdKqsTxbNuLVP1mztLBj?=
 =?iso-8859-1?Q?13RNVMMu1RLOkW50yX4TMZSg2zYmmnICDFU1/0IpbcadhqcnqkSTtlmy4K?=
 =?iso-8859-1?Q?qen6ox3k94BGqp/S4pE8YKq8iQ0ZTwV3ld2eVMJkHDt1L5fvzRwSVb4Mrt?=
 =?iso-8859-1?Q?ZGLgsrjgOr8a2/lXBIIL7LZzsuNcK5mIKjrHyzO1ladmKbhPxOvo67w7sL?=
 =?iso-8859-1?Q?TQASuyOt7s+reVKJ33Iv8wWUnBT8d6cqp6RxKMJXSbhYbjzBWFhHg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5796a99-1f8c-4823-4ec9-08df47420b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 20:08:29.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8635

From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> Sent: Friday, Novem=
ber 20, 2026 3:11 AM
>=20
> uio drivers support being matched to devices using the driver_override
> mechanism. Add .support_driver_override =3D true to continue having
> this mechanism work for them without tainting the kernel.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>   # uio_hv_generic.c chang=
e only

> ---
>  drivers/uio/uio_dmem_genirq.c | 1 +
>  drivers/uio/uio_hv_generic.c  | 1 +
>  drivers/uio/uio_pci_generic.c | 1 +
>  drivers/uio/uio_pdrv_genirq.c | 1 +
>  4 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.=
c
> index 263c1ebc2d57..71992431770e 100644
> --- a/drivers/uio/uio_dmem_genirq.c
> +++ b/drivers/uio/uio_dmem_genirq.c
> @@ -309,6 +309,7 @@ static struct platform_driver uio_dmem_genirq =3D {
>  	.driver =3D {
>  		.name =3D DRIVER_NAME,
>  		.of_match_table =3D of_match_ptr(uio_of_genirq_match),
> +		.support_driver_override =3D true,
>  	},
>  };
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index dff92dcbb10d..255c2b5730f6 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -407,6 +407,7 @@ static struct hv_driver hv_uio_drv =3D {
>  	.id_table =3D hv_uio_id_table,
>  	.probe =3D hv_uio_probe,
>  	.remove =3D hv_uio_remove,
> +	.driver.support_driver_override =3D true,
>  };
>=20
>  static int __init
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.=
c
> index c0cab3adb7b0..9785df9fc5de 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -140,6 +140,7 @@ static struct pci_driver uio_pci_driver =3D {
>  	.name =3D "uio_pci_generic",
>  	.id_table =3D NULL, /* only dynamic id's */
>  	.probe =3D probe,
> +	.driver.support_driver_override =3D true,
>  };
>=20
>  module_pci_driver(uio_pci_driver);
> diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.=
c
> index 87e43821ab0c..022178248962 100644
> --- a/drivers/uio/uio_pdrv_genirq.c
> +++ b/drivers/uio/uio_pdrv_genirq.c
> @@ -261,6 +261,7 @@ static struct platform_driver uio_pdrv_genirq =3D {
>  	.driver =3D {
>  		.name =3D DRIVER_NAME,
>  		.of_match_table =3D of_match_ptr(uio_of_genirq_match),
> +		.support_driver_override =3D true,
>  	},
>  };
>=20
> --
> 2.56.0.rc1
>=20

