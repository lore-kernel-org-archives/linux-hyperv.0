Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010047.outbound.protection.outlook.com [52.103.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3483313527;
	Fri,  7 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114604; cv=fail; b=oSatdw7LUj+IrktAZMV5lK0Mi2UE32BPFRvhVCY1UhRkvwPasf8FndCRWhKW+71UE/1EHQeP8IawThFl4fdJZ4CmgGL6eALFZYk++e2oRVdZjt/xC/qSCalBoVTH5sH7ssChnZDxBrMb46KcTOqcaEP8V23HY5pQ1lb1y+MtqWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114604; c=relaxed/simple;
	bh=swo/JvZ8G/FL/zskPorr8NNuAvIyBeNjIoeYfiIGN7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIbpfldgkJ4ujKW/JhZIAeBHi1nxAGt/z8ZfcHL3YYBYum6t//hOcoJVev7i9Ok1RPDftWHFG92VC7d1Dsnzxk+hQ0ABMVlAXFWkDSIub1sFZZW88oDuWH8AjcMwDQS5tS1qWI1eAX8lgmmMuaI6hM8cwN456dUc6/XLrMP+Lhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p1SQSQF/; arc=fail smtp.client-ip=52.103.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p1SQSQF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU5yM0O9KzKEOA/jCSLm26+6mpK+XZWANX8DyktOlpryBXLiQvOB/8NaE7357XMpv6Q87a7QMTaAcdp0vmvWer+W0XSE9X3L15QT3FGEYuDqLGTrsfqQRX7MBZsX1wqDpPhnhejo7RPj+LgRkSJlFkpdEHH1zrMv2RkAxsUajALuVJ4bv7BGaqhbceXtoQJhgP/Bh26I2sjmxj+WqwqjyhDs9MXfwNN+i2O2zqq568uQWe5b67fxosNRGvqzZT0pMBTkbZe6iz4VHjZF2KMwuAd6/iHXkwip+fAdG9NvZlVvB72QPNUis3XQNl+xLvpTMjsHGs6S5TGHefqlplkusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vz8O4HT2lRUnhHfIKy6mXoVYesYKKlYxEUs1uQtuPs=;
 b=EyhaI+n7gZXaAw5Vh+b+hQFGjs+c7AJEKEMTbj1rhKj7Xrf7urZD5A2oNdu4zew0eQYjvz55/KZQ3/oaN58H/yJ+jS39M73D3NBHkJfbZJFPeeAxEQgjD/CoEQuCdNNFyEsgT+V0p9uyMv4Aao8WAXRwxKGzMJF1GewRmkSHD10FJkhvYp77qFqPQTEpppi3jh/8y4gYBn+NKSUpckwqe8Z6VFsGcdWx9UvcfNKnFSIJwA8G2H7FUbbAr0pGipXzw7DzykNMxDVI4+Z30JdZ7qviV/fDDTyJFaTyDajeRBj/SZlOygpDrQvS3tP+NWngfrHjfvtujdSkwpNzjoyXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vz8O4HT2lRUnhHfIKy6mXoVYesYKKlYxEUs1uQtuPs=;
 b=p1SQSQF/kw3wrSYFgVEZLj7IvDM3DtblU4dhva+6w3wJN8FxKNKNhbgizMIuCZqm2GwJ61djtjAzH1MVKMbNeQoVSm9/AK5YMIaUeA767qoVdZhv0p+dO2Prl2TRILeS4LnBYu0r4pIhAKOVKJ+jK5vhuW6cBTheVqImZNAcHjSuBmjJNRKHU5HzuW6XONe5QfJzDzT4GAat6m5V7HMftrIQCWM72InhVRPhxnVTWM4cn6u+4R09m+G6mcm3BCg1d8es7m/4u6x5WHqfdNOhwU1BcHOGxUb9QqoEB1H9s3N9usXpeIFZ1GJ1sni+99xDJGX/W1AkGE+lhGGUHnRPkQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7166.namprd02.prod.outlook.com (2603:10b6:a03:296::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:56:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:56:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as
 decrypted contiguous chunks
Thread-Topic: [PATCH v2 2/2] hv_netvsc: Allocate host-visible GPADL buffers as
 decrypted contiguous chunks
Thread-Index: AQHdIHwAygH/b4GY8UuKRqN3wt0GTbaHxo6AgAm2gwCAATvTAA==
Date: Fri, 7 Aug 2026 14:56:37 +0000
Message-ID:
 <SN6PR02MB4157AF2F371ACD488FB2C6F5D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260730233359.3850612-1-kameroncarr@linux.microsoft.com>
 <20260730233359.3850612-3-kameroncarr@linux.microsoft.com>
 <SN6PR02MB41576627C0DBA40FA8BB49C7D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <002d01dd25df$0b94f8b0$22beea10$@linux.microsoft.com>
In-Reply-To: <002d01dd25df$0b94f8b0$22beea10$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7166:EE_
x-ms-office365-filtering-correlation-id: f38eb585-4923-4fdf-bb0f-08def4941506
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|8062599012|8060799015|19110799012|8022599003|15080799012|24021099003|55001999006|37011999003|25010399006|3071699003|2607281247196008|12091999003|102099032|3412199025|440099028|260806224601699003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CyT1dA4yMSglV1Ra/6afdeTqmjxG71Iz03+XP1WY5wIvULt2u9cu9eS13ZtT?=
 =?us-ascii?Q?pnBsDvYN8Bgah0+OqmsL880RxiviwfNKY4EpI1v6O8yphoKeddeUqLxokEc4?=
 =?us-ascii?Q?4v/waUuOO+txUSuW5a2QaoICahC6cM7I66ZLXr8+rupMgG9lh/k7wA41lUhL?=
 =?us-ascii?Q?+v3+GWpjHUroSpfMxydPv3cbX/eghLdXCuzC6uaMuhQWcPsAgyc+dhxgT6Ib?=
 =?us-ascii?Q?JS8KzM7Jy2Mg0/iRpOLiW//ulv91ykZhh/Z7rgk8dQx0wO9qzU8reILEvuL9?=
 =?us-ascii?Q?xhB3Hv5Op7Jzx/VLlLlKI4iB7XbYMNkzB2DQoMoxz//+Xh8fX0Cj9aKTiodB?=
 =?us-ascii?Q?jRFKas/OsVjpMjiOB+Kslxkhm9mTiIMfgu9yHAipnyz8v2rA6DmPERqJi4cP?=
 =?us-ascii?Q?hfh7+auFdzvom/H1nkUcW0nmISH2Vo4AGli/QgwaXjLdikkZRwqwhQCnlwJX?=
 =?us-ascii?Q?eikVwdXW7BdOh5GzvlIwPdCmNtDEE1qyNTimdAVgjTmowobCnRm7lRv/rRvt?=
 =?us-ascii?Q?ezfzhyNcMmtbiYp8dC0H5rPr+2KzYXo1eh7lTCZ+3RYMwbuOREgZPO4KgNea?=
 =?us-ascii?Q?/oo0EAygV262aB2Hh5aVPs4YhcqT3SG4FA25dxy0iTiZb9QrCnFa9vJM9yHr?=
 =?us-ascii?Q?dG8bUj6WngT+EEGjvVYQCywPzZVMlv7ax5q1oe3NtQse5cfd5/UR612dS4Kc?=
 =?us-ascii?Q?21FU/39osXLRwuC3egKupXH0CI/iR8zZo0swttz83D9MgJXLpiiEOo1XSTi1?=
 =?us-ascii?Q?13bhyvc2UNgd93hSPPq54UwNSqxcZKIE3nQmkfupalrKonC6XrSJgx1m1FZi?=
 =?us-ascii?Q?F5rEzwMfA2nj1hu6UwLwmuHOky6qhCsG1fEOeGq7vmqnSBu8PtNwNnugl21G?=
 =?us-ascii?Q?fImwFkd3aaED/rnRL57TkWgjaIJF2Wnk+Hvl/UtXlQHx+SWXWRwKIa4hzsun?=
 =?us-ascii?Q?eyLpuMnQ6wiOXcxAQY30C365ap50uI0RRvYPt63Oa4PY75yWyraym7LH0T9C?=
 =?us-ascii?Q?3uXOSS4pIpSNu6Ncyrau9MHExQH5dgKZ2mgzLmOX/R+n9zviDE5VFiqtK8SX?=
 =?us-ascii?Q?tKeY9hkwHBqsiS0dveBZGb0kvgw0FHrM+eCpPr8y+ZRT+Uz4s/btNxf+b+7T?=
 =?us-ascii?Q?Yu6N4QUuBYcy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tFJEAEIYTIQ4Vggv0kRZZSi8EKoQxgkgSMHOsKm+ADdxxJBL3f/3AwPWrbRM?=
 =?us-ascii?Q?3kViubq35XJVz1u6qJIxXvQnuw8tjF3UeJlpezGkDagtjz0KDRBvWmtNYA8V?=
 =?us-ascii?Q?dH3ob0GIssXrNRhjqgRnYtl5dn+DaafEprmEQRKULk5x49CsK0f8HhwuRXit?=
 =?us-ascii?Q?uOyOze6G4en6K2w6HMG17NafNgiTdjxEH+8bzFeGno0sdrhu4GZr+B1X0MCq?=
 =?us-ascii?Q?iRZq55CTXBRc6JWL9q0+zIgMXPynnD+g8A8JRIXvcy/MKqzlMQxEOMn/Q+IZ?=
 =?us-ascii?Q?zkOB0qzuzVwr2FwqUe8XxEh99xIJpif/DyslA87ysVPhsGzEjAAhFWX3HXn5?=
 =?us-ascii?Q?+D6Dqphl1xsc0SgBOskrE8jOMqQ7u14EWDJTvYUT83LYzdM4CZFfh9ay+kmy?=
 =?us-ascii?Q?AhNN0d9wVh6BwG+UHRmGgKroHo1IoVnfwE/OYecYMaeMdX9JZ94Ytxtj7I75?=
 =?us-ascii?Q?aaZ3SIPGn6khyLGiH1o2GSwZOFioaAW2uPpZZv/vtJOHVA9p/L3nWeeqzwaL?=
 =?us-ascii?Q?2csAHHcZh0VbRDnJ78ktFpOCHiaO2e0r34zJgg9LLiLPtF5iVJR5ELVhJ593?=
 =?us-ascii?Q?gwlwMCAQ1cV1TUUExUW8mof0C6gwoaBRDTKftFHPWq6IVhErOUkszfmvr0EM?=
 =?us-ascii?Q?V9W4ITjZHzu5GGB+9/Zuvd18eW1y2quUtBfyPGpDSMv2DwHRUUp5eLFBBMxa?=
 =?us-ascii?Q?SXxiC1Cuck/fbkYqiGuNLHHg4ZbVR9HcSX8O8Fg4lWtPyLVIFJVVxc9v0b+i?=
 =?us-ascii?Q?WEAWtonO52ZmbWPJBN4Ya7uJYquLECEjAPmJdvQt2iG5a7h/KpWAKFwf8aZr?=
 =?us-ascii?Q?3ALpx9yk7Kj0RMQQ2zgENg3VtupfzZ5A1yg/Bf3xYhyuFnZFZH4KiuMp2yO8?=
 =?us-ascii?Q?01S497mXFR/ub70eITiNCpVXroOhbxFvdSTxGg6/HewQZUTorlkybrz5zVsO?=
 =?us-ascii?Q?9UA4vQSaJdHe8emRJ9HknQA6hQv5tcfew1lBWBckDFgmxswaMfLPRkVB9Qbo?=
 =?us-ascii?Q?Xmgg3mzE2HGROQ3ZnOgK48M5PxILP82oKCIsh+21GuRtY/CCLDFuS4WC1HL+?=
 =?us-ascii?Q?kEUeZtvkEHQpVtu1cwwqaU/ysvvDvbOZynH6YVxZVjHIsQViCT01gauFXIGE?=
 =?us-ascii?Q?wTAsLYRDAI2AUvQKrJW1sxPy9PJmxjFyySZn/oMy8gz5O2BGgdJX2tqlIYwO?=
 =?us-ascii?Q?Y9UouRi+GFW0yP22dkL1L1plS8ISS6FtMpfw6AyvPkxE7w0YO+DbRpDfv8RJ?=
 =?us-ascii?Q?1xe8nr2nGh2Ki3moYUzu/kbKzBmYcjJu0S9+VTslYKqX0mJVW9lGI0SCZfXH?=
 =?us-ascii?Q?392som9+vENEZGpi5FEzbiyqc/p8mCrqgDT3erMXlOvF4PqXjRO6OOJcEO/D?=
 =?us-ascii?Q?bD2HHHA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f38eb585-4923-4fdf-bb0f-08def4941506
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 14:56:37.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7166

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, August=
 6, 2026 1:06 PM
>=20
> On Friday, July 31, 2026 8:47 AM, Michael Kelley wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Ju=
ly 30, 2026 4:34 PM

[snip]

> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.=
c
> > > index 59e95341f9b1e..1192929d93a86 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -28,6 +28,8 @@
> > >  #include "hyperv_net.h"
> > >  #include "netvsc_trace.h"
> > >
> > > +static struct workqueue_struct *netvsc_wq;
> > > +
> >
> > Does netvsc needs its own workqueue to do the "free" operation,
> > or would the system default workqueue (system_dfl_wq) be just
> > as good? At first glance, the system_dfl_wq seems like it would work,
> > since netvsc free operations are rare and don't have any strict
> > latency requirements. But I'm far from being expect in workqueues,
> > and there could be subtleties I'm not aware of.
>=20
> I have to drain the work queue before module unload.
> Currently this is handled by destroying the queue.
>=20
> Originally, I tried using a system wide queue, but I saw that there are
> compile time warnings, __warn_flushing_systemwide_wq(), which state:
> "WARNING: Flushing system-wide workqueues will be prohibited in near
> future."
>=20

OK, that's make good sense. There is indeed a subtlety. :-)  I had not
ever thought about the problem of unloading a module if a function
in the module is being run by a workqueue.

Thanks,

Michael
