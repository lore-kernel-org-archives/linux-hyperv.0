Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479279;
	b=aCvn+R7N6kqzXxc2ryKmtufUIib8guzikGfYB/K7s5yarSyMEt1iET4d0O9E2y/f2W+6
	 ozJTk49HS9HG7bj0yVYlMGmu7ZobXYxyVjYZ8IQqfezcwEG/kT6uzpf4VPw6HWcfD4zzz
	 msceQf/9nREXKO+myG/kOAfto29YSmePaOf+ClKl3okZWQ4TWbwZzuUFPJiXqOPcVB7RU
	 vn20JhOwd+NM1FmLj+NKuuk3ZrTsfIYGrmfrgnoBCv1n0RVvykFUy0c9ZwpstrnWK1/J2
	 LInwGEp5iA6VLpTvyok0rIAAFPbxqz4+H0UNAdKlKgk7vpH2Qn3l2RieMb2eO46T8PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479279;
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
	bh=zI+JF9nCPWc4+adRDAT1N5uteYbzKJ4MErK6XN/S8/E=;
	b=sV+9+l41yUB75RfBWv9a7mzyb/cM4Nq3LL2/M2RuqhM1AeLEM4dup2Dt/p2mr6IuPdn6
	 M9EndtRhUfLlu3lHlmM7ULdduYJ6fXmHyBB1asGABFsvMtSDqMJPbB8AxXwrkfp7UCsCL
	 DEhYhh33vj6vjj9kbjWDvKkqeQRJt1S+foyE46Dyx3EyIfFCu/aHXw1x0je3y5hkESqs1
	 Q0E8WkR3Aw8sujuneTmaJ6hrPKl5Nq1KvQH/xIueoxOOmaC+D4j1DLGlWu9RERXixUOcu
	 3btFQZw4ACJHucpb4vdjZgG7Oc7bxloZ+EO+vRfewlCJ4x0txkd4YhxpfTJv6M8ESeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=R5FNHfyf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.26
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011026.outbound.protection.outlook.com [52.103.14.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB12606A322;
	Tue, 24 Nov 2026 00:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB12606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=R5FNHfyf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo0TRjOQbIGsHrljGUaeE9n7h2bGuGug8X+AIhJUnE4weAp/8SdSorgwk0rF4/Np+YJ6r++gIYmUbTHjtxGRvyM6nRHKe4YScyYtDa4fCFLrQTMLcUUiYYzS6fhD3eKwZ+gqIxFpz/pGnuV0Setj2mtbbCW2tHxqCpYZBOAX0q20/kosi/QrQ6iJSI5dGNs+5Mt+q0Jz9hpUiBZQNLaxJFJIKQiD3fDm0DDQoPDYMaOKVof95A6sog5GYRVnQa9HqWXL0uRuizcgjrv9us4/y9DAnMZAe7m4vYHO19cI4HW9VYKKA8pAQd7u6HB5eSVauZTOC1M9WbVUQUiEXRH9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI+JF9nCPWc4+adRDAT1N5uteYbzKJ4MErK6XN/S8/E=;
 b=KzMHtcG6bIjum9PGDYJoY52Ur92DVAqTJ60HyRJ+83BkWjHiqX8hXJ1rYhPXiJsIrXN458tq0yltNe+qxCXVc1Dutng1GWIdACRIqXmxQ9yP7m9wuwzjtoaqERq7TDkoqRTcJt+pce8mNBrncKvWBTVOcO1dibOnvI6UG49EmyJTELhwDMTcFqDg59XZipEiSc16LfZHPhZN889AAxr8QyV4jQJ/sfvGkFDTWNQ0vvP9nvSAOfmgOqLisiqh3+WkiVLysVjWdudnrFEdm/6CFA9l1FC08z/JhNK8LzLGljlLe9w3BUMKsBXFquUJibT7M5ZhkrC9/znp9ceY/lIfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI+JF9nCPWc4+adRDAT1N5uteYbzKJ4MErK6XN/S8/E=;
 b=R5FNHfyf+NNzg/h9e383cBkF2fd1Ek2f5BAzPq+LDVVngUM/4sI5wqoAZWOnuHsm5uj7MqNZ3Vx26ru5F2BI41zNfeYiJxJhX7If4pXTPZf3We5+N4miM8PAJbOq6L5WqXIeosQGCHNjQiDsnaFYqZbS1kNTbcGYh95cmRSiTnpgszwbh1Wca++ZrNNCmIGz6QHfPmC92x34xyj6EEd4+FR3pdYHh+5w418mnHypwORbiLmcZw4B6+XqslhlaykKQIIYW6sjezF68CaCFTAf6ssZHIhET86+D4lAeervqu9YNO3a7uyM1wUW+kR1hCFvYue2KI8TxHfpi0E50mTCMA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA4PR02MB349042.namprd02.prod.outlook.com (2603:10b6:207:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:14:36 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:14:36 +0000
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
Subject: RE: [PATCH v2 1/5] x86/hyperv: Reject unrepresentable TLB flush VP
 sets
Thread-Topic: [PATCH v2 1/5] x86/hyperv: Reject unrepresentable TLB flush VP
 sets
Thread-Index: AQHddnQvqgW1kLF71U2YIiH0iW/j6rc8ZKmA
Date: Tue, 24 Nov 2026 00:14:36 +0000
Message-ID:
 <MN2PR02MB6863BDBAFE5B4235BF4AEFABD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-2-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA4PR02MB349042:EE_
x-ms-office365-filtering-correlation-id: 92fd026c-ee56-4aa7-f18b-08df49bfec4e
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOk0uzk9sG8KD5Qqu7GHBJQYWobZMqgZGWS8Z8FGuVHSwCFZLHkxHvHE8dF8twqC7KeO71F03jyZn8L8l/OnDb9FDAWP0k2cTZlCuvTQPKSC54RhKRO/jI1iJVlPNrddiJewzs+c/GLGm05P399wX/9nFoc1CDqCnuQ+jglg/r2YXlBZJBxGkiPbGCJAM6+jwnrwNmEPmD2UPrb74XxnQkXfWZNwfpM4YZyFQvIn1+ZPSp6tMbtwV4x8bGE1EC5ZYFBYEIvaP3CjDsMT/L6KNLHEAR7tXlfX4ksKAK71Gl2B/Ebn6qLZyNGTff39nShLRv274SR54QZS1jzEhjgM7+GBjd0y99kNzrPeJAAmHMFNPsLdpoileEXgK3YQ+DvR1WJTVdIxXK7xGeq7G7ukeagjWx6Unwq1Hoqp6iu+Xc7S8XhFxYIqWNKkYoGkTKWWKMr1fC2g+Dbtw1fQFb0u8/wAcahXRZN9GJVRvMyvG4krL4ICEryMt5W27/U10yqvY43zSjGe6QaryaPhDTOgcAuoalJ+OJGtzbWCRBXWPU0aV4jMBMuJ9EW43DwxJx4NGWGvZPCC5XCXlclyvrX42LBbY3rl+do1+LaFj/8k3a91CoLnjbpHVrf9lOXdNeCBi9nP+vudJoGh3OE9A5X4aH8tmiCDsFH0VBuzfP/fG9BubmBRvlSi2JmW+BWpPCiP+DlcKTJe1goQfZ6CM/0PH+ugJJA6PJQVV7CIUO88mC+kw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|12121999013|13091999003|25010399006|51005399006|15080799012|41001999006|8062599012|8060799015|19110799012|37011999003|31061999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SEyrGk9EdEJghOA25dEPi4bTvIEqpjkugbcb7PoEQslpJHU9FPChV+xSE0Av?=
 =?us-ascii?Q?BDnKAds3tG5ExinK2dIE7hHvVBJPC7Ab1BOMhbe50S7NJx9X4JlOWPQpDU4y?=
 =?us-ascii?Q?uWSen17yK8VKZejYhwUE7jwz1J05yyhbiS/nGvSkJuMmiLemCJtjdrLAg4Cq?=
 =?us-ascii?Q?1jKmhVdZ0YX63MGOpve8ZvCbv5giC4yRdQ6x+cbEGvegmQm6Fcn0o+fwApit?=
 =?us-ascii?Q?rQiUra2zMerV1LSWqTje++hudc/3hjfJPvbJWmXySJse+qqmQt162vtKR+Dm?=
 =?us-ascii?Q?JFaGN7CVage+hNiHI2yRJwMdYnxC2XRw7zh5Di8D2c9LXCD/wf0t28WdGtKV?=
 =?us-ascii?Q?BIkiPewYudRtI7Q8lrqtgiO3k8/gSV/+Uh1PcVlEBROmIvqEmOFvVYhKT4Os?=
 =?us-ascii?Q?SM2dZgPoCHjLnUuwHy5FmZdchcYpEJV4r5S6Z4kJNzTZDnkDykssKnaBRmKa?=
 =?us-ascii?Q?D9IrhwMHN/69CkI8Y1Xg/nfvb08zoYH1spnSLKowTiTLNGMHdrIT7ulapEaN?=
 =?us-ascii?Q?excYvCiJkoXoSbM9zP4Mt2hYUmAbEaK6qW6Oqt5osf+tYx+s6jLS3WDjQetA?=
 =?us-ascii?Q?DnWUivhX3U/VxYx4dEeJ1oL7XmHaqHMfYU1GCJ4yATc9j8Oe2ez36AxtjNl5?=
 =?us-ascii?Q?iYvdFnb8phjKR1x9DudoJZaMYoeSSEPTTUU59GyNjjfIKZZI1e+IYLJYjWxt?=
 =?us-ascii?Q?4R+PX4J5ahIoXWd0EmEMuL5G4DoQk/giUA/+3zi7TXKomF6JZyafJOwgLjOm?=
 =?us-ascii?Q?j2gxvNDE1iwgF83GkFHum4W2hb3vQdCpWuztrQHqFORHdavIFgIIxie3XKUl?=
 =?us-ascii?Q?9N0UxyaPOkrV0m6WorYwqGb5644IhGRVAG1um+g64OYFyPzfw/sgr5YCWqmJ?=
 =?us-ascii?Q?bwNdpb/G6dsr6BtEG98bukhIUBfc7nfgmlclrtSM19J8Dzok2s8wanq2Qe9r?=
 =?us-ascii?Q?sDOcxO3jO06T6VuPUWvo1OvpB/G+s5VBJF/LxzcnFVWv02QP5IdTEg78rr06?=
 =?us-ascii?Q?AR5p2QhwanWviQGBjIo3QLDjU0iwQ5g/PybawIM4jf31lgPaC3OpQSVG/Ef1?=
 =?us-ascii?Q?D8m33CKuM3yPZ/s/aKRNk8RHsWZymgTYsqpKrYVVGeXIWjYtoGo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0VVB2uVaslw0P/XL71g8A8rr8OTsL7HSwENZNd4IZsorQAZ1gOH9edMuR71x?=
 =?us-ascii?Q?Jyy8P7apQvd6akMGLEaEQfnOLOK7Sf6ctq4vKilvOopXAe2w5mpbONBNdQNq?=
 =?us-ascii?Q?AlNU12k3nADo4HGch8nX/AbiBzxeTM8EDgoXgeeTvdrSN2rnmx0oGEGDrYfL?=
 =?us-ascii?Q?cJqhu6LSVm1oTMayf8OW3V2bGlWqd5SThhgL5X5CosIsIujKDSo8kHFY16b6?=
 =?us-ascii?Q?9Un7UWPIg8Ys3X+QAtz+9MXYvqOuKCcwb0G2R1koCkigbmg4HGyA/Fo4L2nn?=
 =?us-ascii?Q?UAepl7jNe9zs2Kx/hITVhTi+KLwVc2W+5Dd9eoZ5TI7ebjBcPo9SOAjZLnd4?=
 =?us-ascii?Q?yGTuXNlB2hE3b315Jyc6R9YQYqJ4rRvAegg2LuKhrvfZTbRDQqh41w2v9yCb?=
 =?us-ascii?Q?GMCFDGZAH/2MOZwDITCiPKS5TBqKsLF7idGWzgyz5VZSxh1qIeK4P4ERiIzJ?=
 =?us-ascii?Q?fj/eeLvjBH7Lnoi6T0vQttyqbImmazV/RzCFuCxOHdHJjaFSraiA4p0pEJ5K?=
 =?us-ascii?Q?8WNU6gUdVI/IsZBFQ0tLyRUiqVJZONoNIfl463fedeh8NyASIS/iUQn5IcVp?=
 =?us-ascii?Q?G6/N304Tcop85viX/g8kYkg0t5ftiGK99f4pnPJaiSWXv++igZfGqbcyK+9j?=
 =?us-ascii?Q?/Bs31AaZB52qtc7FGnQIlSJxTUBXrBSXhDKu4SLxaDu9CXmAiGxo4ljLtg7J?=
 =?us-ascii?Q?8dCIlYlYD/BynPY8yvj3pj2oCi9BX4TqrShPDj3W75wcJk3a+4wOTZHmw3JR?=
 =?us-ascii?Q?6RjxsG1xJo9oY5DOOD/VJ2HATovkKLat7GPZW/cIVEpLYHPvS1K+1xE9vJUn?=
 =?us-ascii?Q?XgaLmnidy2tYq/40M/iJNI0yRBfomb8ATvO8eEJa36TqPAtOzaymPPmyHe2z?=
 =?us-ascii?Q?1khVKf7QQ4/8HAsoCmxmWO7U+SqJXNCxZ7Arkp8aFkAD6SbUgnt5xE/hJCWg?=
 =?us-ascii?Q?EEOmkQOmBzyJrFBigszkf3DgbQvG+FS/5GIr0h3Mcws+UC/gHbDqudY3Jg85?=
 =?us-ascii?Q?dH2+eP/O/LwrxfSGNrpk51EQzsAoPdNkrixFguPzoO9UM7/UYjlyJM7fJTWb?=
 =?us-ascii?Q?thQDbtI7zToqrfcvz/Yw/uhg0DVXfNwL4dJAPnxN7gi0J39W6G0PWmmzqeQO?=
 =?us-ascii?Q?S51koRP/pFYiDL/a3LvSevJFeBRwmX7EgGANYy6QAzqus9rD31kvShsaA2ob?=
 =?us-ascii?Q?bAVHobEW7UMFmKhaVyk/TUVZKR9OTr1Oml0m4ULtIBqgA5G9CBRQKq88eQ6M?=
 =?us-ascii?Q?7I3xumMXRuW8vYanVyyKJvgKQNv4CDNSEPlzOG/Ra6yW9C9ZrD7lj/E92Bbh?=
 =?us-ascii?Q?2r2nCrpbENVZ3NxEbDhlTfu3cUqSRkQpqGXuQbfS/siuSkmd8NJaWgA7elEt?=
 =?us-ascii?Q?snnbLuI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd026c-ee56-4aa7-f18b-08df49bfec4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:14:36.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB349042

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
> The VP-set conversion helper returns zero when it cannot represent the
> maximum VP index. Treat zero as an error, just like negative results,
> rather than issuing an extended flush with an empty target set.

This is more a theoretical issue than a real issue, right?  The max VP
index would need to be >=3D 4096 for this error to occur, and to my
knowledge the max vCPU count in a Hyper-V VM is something smaller
than 4096.

>=20
> This lets the caller fall back to native flushing, as the extended IPI
> path already does. Filtering a mask that initially includes all present
> CPUs can make it use this conversion instead of the all-processors
> shortcut.

I don't understand the last sentence. Is it a leftover or a bad copy/paste?

Michael

>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index cfcb60468b01c..1ea57d642faa4 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -199,7 +199,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask
> *cpus,
>  	flush->hv_vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
>  	nr_bank =3D cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
>  			info->freed_tables ? NULL : cpu_is_lazy);
> -	if (nr_bank < 0)
> +	if (nr_bank <=3D 0)
>  		return HV_STATUS_INVALID_PARAMETER;
>=20
>  	/*
> --
> 2.43.0
>=20

