Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022142.outbound.protection.outlook.com [40.93.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530233372A;
	Tue, 25 Aug 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677255; cv=fail; b=XwVQJcXN/Q9QQBED6AWIJaNjNn43zc7LewpujLMzW633TnAyBiJrq3od3uwh/87OR8O7R95ylh8yG9ZJIUf+RjI09uDrMYY6wEHL588mZZAlRX5Uc15QyXCrtcnTczkiuHMdGIumldjE3QIQWg+Nt7Ph36fKfdgU/FXoPL1zqwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677255; c=relaxed/simple;
	bh=cs88nxAaJAB7YSwyYjtYGSqw87nTA8kwgZka/sIt5jw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6Q+XN3jgpaFYXDEa5oE933K7vHQR6T9gqVloMfxAAdUh3vgCyiedddvdqToG2WTU41IH7r0XqyMk4AQhbnIt/P9o4coFDCIZ9FfQ8rMJ6LBs7UNvV1vdDL6kH0l3NdOxTyjNMkKUHkSkDDV228DGHmivkwDT9gdKI8XMm9v66k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aFQXuBvr; arc=fail smtp.client-ip=40.93.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aFQXuBvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpRoOtrgcLUd9wNm0qeewkWUQiyNYYyJ3C2rXnxOk6mLxod2II9zK9Aqzo83e//DZL8MempeCL5l9ebNT79i7a/c7wDIMLYviCkunztBWX009T0A2lA/CxqR3GJW8cQ9stCuyBKdOtZ/NAYVj2C0F/AycbxBKpku6rG8sSnWdvzsiCC0xCftg7WPWn2TbPUXgJCck5mU/lEb819iqvA8eyKbx2Ky3UISPdWN5NZwhaAwnq2a/LXfO+oCvsiibjw2XSPqDS1qjQu+IQGTLHDwyokkvABVZ5IJhTiZXsHUt+esyBWCM9qHtpFZRaM7UqzJ21NkwL1CW0nMNDGK1onslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7rHC87b+xeQ4pjXtJdVn1sgLuASAcc2PjEJU35WasI=;
 b=QCZpcb8SWITlqCmKupP7hGDRNOqMOKDorKzoehJWAN0mEi1JRFN1UwFIG6TN7686hO4TyjmPtzFzCQPASH71z17dop0MNZFcg9wYI11MS3z3vnsX6uZbOOy+C3HM/wpiR+MvPnUXtsBt2C9u98VW96wXQasipWu9Axn3MzLEHbi8qKK42WN0MWH6diJj3CDxecODpDJdYc4GIA6TP3PlwgeQoJOZ5tg66aOC80Jb1c5F7iyLM3POL9A7Lm19YkM1nTNY9f8jg/TUbsUGnrrs2jCQl8lq4q6LMwKPCIHEGd0V9LyJ+l0dzqNYfRnTW83ijqA/o8v05qIKnDe9BgkMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7rHC87b+xeQ4pjXtJdVn1sgLuASAcc2PjEJU35WasI=;
 b=aFQXuBvrCWyvTkSIxAOOKa9B9nVKFk57vkr+T4DJ9qefKmYh3/4V9gbeNNIbBGDWrSpLNrDTdOww0WITRfRr3G6itL0fonsrxiURtwQnYwkNzfVL/8/VvlPYZQj9XvezreWSGL9G4esK0ZZ4VKgMQeHeYzqqvnqVI+dF5pRRk4M=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5519.namprd21.prod.outlook.com (2603:10b6:8:2b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.4; Tue, 25 Aug
 2026 17:00:48 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Tue, 25 Aug 2026
 17:00:47 +0000
From: Long Li <longli@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, Sahil Chandna
	<sahilchandna@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
Thread-Topic: [PATCH] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Thread-Index: AQHdNFFABWOOm2fKm0qHnE869hT7XrauUiwAgACrifA=
Date: Tue, 25 Aug 2026 17:00:47 +0000
Message-ID:
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
In-Reply-To: <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dc4abd39-7366-4940-aec4-2297ecdf07fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-25T17:00:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5519:EE_
x-ms-office365-filtering-correlation-id: 738cf221-0748-48fb-12f1-08df02ca68cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|7146999003|56012099006|11063799006|4143699003|22082099003|18002099003|4133799003|38070700021|921020;
x-microsoft-antispam-message-info:
 AiGpvKNqHoTXNjZ7t6IM8FsksjwqLYUFTViwtKZ9OyS/w9OSzu5XKg41K7Hcxi+wO3hXPGrnx9xyGgFCS7fXdsNc2U4W+S//16oYvEnCFRPsBdYtX8B+pi+7ImKFReDtqAFToD5IefxLSFDNyikCfW40lTC3WIEwL4KttgygnwEzzpZjbN1NSzhimKFBJ5uZNaTAXziBuYT/uVRkDr+o92aetdBohlB0yTp9tC5qVVzCyCnE73bQXpUZVhfkR2JFYmMqCIdbV/dvyoYt0gv2lP8/xuUsFg9pTfvZLYiu+y72lVn5YXVEQRqde4jOL+RceNhSeZKlvkfifKG213uk30e+ELOlBkz74HWu1Fndtt7BxH3LtpjjpO8dqVx3rtEVGJ6yG6Wb7Q8tgNFBDV6IuA0m3Y7fyAab5+S8kiudhbzQ43/rizwgKJE2GagfH30yY7ck4H1sMgM4lodmsu0H1QymMV5pamsbfDn0UO2Te7KnX1anbTYNPKem8mFPAUeQtjxaliGcgN3k1RFgGUaRcZVG9WwsUkFLublEzd+C/YxtAJxKLUXiUQgef/xvp/Qa/QlA2+AwDS4yjKgmCr/PUHczoXDdXnov/y8Q6cVyB9WV3YqTNawPSUWEuyfjw7BC4RdjKEMOG0hLhSdykl0GTzMlkg/YsZCy6ULTNi7wptjifds5K/GJKaq4cGSYRdda20oVgQXw+LpLAMKeq4FXwMlVWu7HcZRzeZrxQC6/zsv9d0UyOamWFEmQhmxgHWMi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(7146999003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(4133799003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lJbRsAEjMq8oF1krOvDYu+ubDNz2aY/p7lvFMvz3E7zEkXPPqLKr6TdayKuD?=
 =?us-ascii?Q?GaYHAHnJAyVBhsh35AQOes8lLAqNCRFjDaAmiDdA2gRFUl0tGIFoJ+s0XhM7?=
 =?us-ascii?Q?NNnOl8OhSnVZhJMO/aObhpB+OwjUPIvQJxu03ZYNJ7itEN+63Lh6rSkeczes?=
 =?us-ascii?Q?On5E3I1LVwCE0pMDs0ls5DGLC+9hqTFrDDnRmYMCq8bLX/btXsy/egXXGFSG?=
 =?us-ascii?Q?Um5dsjUyVrhbFV+TScDOxs0B/sTatvm3ds7XcGxW2qnlWKDycNxzrYiTVBvm?=
 =?us-ascii?Q?39YznSnI3kNDnv9GMBq7SPyYK4XHEjPqjNLeH5pCWCiG1Y10wnKtSGVz9uLM?=
 =?us-ascii?Q?E2MM/2P92z1gmwqAtxqQCim+H21yX81SyDAtLAk2zeugJmSPpJxWb1CuvTat?=
 =?us-ascii?Q?k7RxaNsduDOOsjExa/R702PPsFQmkw5e2NwG8KyK+ILLxVYGCK+vLDbUzKYR?=
 =?us-ascii?Q?V7lKWPjIxL9FQqb7Y64RniS8VfI3DwS2HwoJ+nqBEnutYIAfjemI3gXY0hjR?=
 =?us-ascii?Q?uaUNNvkllcf9wmcopxokrLh8EtkwlQ0DKlQe3XEyl5xODeK8QW+Mi2MjFuCK?=
 =?us-ascii?Q?sNLOko/mzViXp07d8k9DEfePc1ytWBo6+ptmSlvTliuUcSBojJfmobiquRV4?=
 =?us-ascii?Q?3wtiiGPapfZLiekJtcs6lb0YkEoUVYfjg1jkQyvilzbrNMZ4mJ+ieu/1qz63?=
 =?us-ascii?Q?ODF+sl3LugDhXDJBSSqrrKfZc2HwLrvdfNTVO00MuT66zcqFph2UmaI2QNIH?=
 =?us-ascii?Q?2s+AkXBV4SjB4zE6Q7Aa2rRTzVnnZiOjQRwefSxZJ9kcETjYCaP+h1z5iwKK?=
 =?us-ascii?Q?kAdsvbG1ZaM8W2ZBy1DTlL+7o7xOBL2csC6X7wasziaTTLFKJDqIgg9Jix2p?=
 =?us-ascii?Q?+KWxt8b5Emf9Im0F8PTRrgY5iyEHgIq72qSSZnTHeYUfJe9vNzBPC9C5oUsl?=
 =?us-ascii?Q?Aats6ZlovGI0RyRqw8LeRRhDNwJOGZtbTv5d9wpXso+TcyfA9x+mK8Z5iUxq?=
 =?us-ascii?Q?8D1z6ilP9YF15mFx6A/we/AyvVet6qI5haVEB/jRBAm2Pa93iDibRN6Vt6AY?=
 =?us-ascii?Q?ZkxPUO3+ExJex1SXbK++uD1zF7y2Cpz56poUHRABTDlmqPM4PXQKtCSnZQWi?=
 =?us-ascii?Q?7G0XKrOz3qtmZDRnZjvtoN2JnuT9k1yY0jvnZi6q0Hu9biEH7bVI3wB06ADs?=
 =?us-ascii?Q?ckssuf9EmHtKQsljFSZRlTIqXsd2ODNezJJewIcKNmOodCThbBfNiaoV0fJf?=
 =?us-ascii?Q?lDnWyqja/oxcY8/GrbaptIh7urNH8kIQlFln99vJM/FdyZ/E1kWhyhrYXzRd?=
 =?us-ascii?Q?WK1PX/DgBMfxDh+u5wf8aOZ7UTRQDfrp5lLRJywS7uHbcckjIafmqTAQT9U+?=
 =?us-ascii?Q?8DlGt1GvLJjHY9JWRY4JvZNkWRlFG+LwWpY3iRsjgxLEsAVXU6F1lo3TqZUm?=
 =?us-ascii?Q?ix5W8KhN9FXlVvXPnwOW81Ym2aZasG91x+ErMavcLe2lhcIvbsQVPJ1u6AmH?=
 =?us-ascii?Q?r4tMig2CqQ2ggwe3BwdUqCzKx63Au2H+kfPQNN0DeTZJkSdTTZYyEgvlreLv?=
 =?us-ascii?Q?z7/VzQtGL4r2rDhegdMLvbuQRcZztpv5FF6ivyM4qzAJx6T+2m/OFmOO4QqF?=
 =?us-ascii?Q?wBYb4whxtx4DZU9+gFTEX/5FwErIgTDP+ip4qoMZDh7Jb644KW21Z9OaJBqu?=
 =?us-ascii?Q?X9TlX8pR3cOudAgCkg8BDhmb14lLBzN6oC7NsA8nrl1BKHsI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738cf221-0748-48fb-12f1-08df02ca68cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 17:00:47.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+jIRD0sum5B593pn1m1HKrQFEni2DddNpcRd8bnETY2As1YgPp8fBgCpq0iod9eM4Un+TY+XsFE46yLkv7+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5519

>=20
>=20
> On 8/25/2026 10:47 AM, Sahil Chandna wrote:
> > A guest can wait indefinitely in wait_for_response() for the host to
> > send either a rescind message or a packet completion. If the host does
> > not send either, the guest can remain blocked with no diagnostic
> > indicating a reason.
> > This was observed during a guest kernel upgrade in which the host-side
> > application handling the PCI channel faulted, causing the guest to
> > never receive the completion request.
> > Add a periodic warning in wait_for_response() when the wait exceeds a
> > timeout so that such a hang is visible in the guest's kernel log and
> > can be correlated with host-side state.
> >
> > Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> > ---
> > This was sent earlier upstream [1]
> > [1]
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-hyperv%2F20260612174010.2598695-1-
> hamzamahfooz%40l
> >
> inux.microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C22b60
> f06
> >
> 81624fda801f08df02748dce%7C72f988bf86f141af91ab2d7cd011db47%7C1%7
> C0%7C
> >
> 639232371774209409%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
> RydWUsIlY
> >
> iOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7
> C0%
> >
> 7C%7C%7C&sdata=3D1uUKHOonR9CtiJfdofsRbWLbuKYHlWgBXdwByQWdk2A%3
> D&reserved
> > =3D0
> > ---
> >   drivers/pci/controller/pci-hyperv.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index cfc8fa403dad..c4fba0039164 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1040,11 +1040,18 @@ static void put_pcichild(struct hv_pci_dev
> > *hpdev)
> >
> >   /*
> >    * There is no good way to get notified from
> > vmbus_onoffer_rescind(),
> > - * so let's use polling here, since this is not a hot path.
> > + * so let's use polling here, since this is not a hot path. If
> > + * wait_for_response() has been polling for
> > + PCI_RESPONSE_HANG_TIMEOUT_SEC
> > + * without either a rescind or completion, add a periodic warning.
> >    */
> > +#define PCI_RESPONSE_HANG_TIMEOUT_SEC 300
> > +
> >   static int wait_for_response(struct hv_device *hdev,
> >   			     struct completion *comp)
> >   {
> > +	unsigned long delay =3D
> secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
> > +	u64 timeout =3D get_jiffies_64() + delay;
> > +
> >   	while (true) {
> >   		if (hdev->channel->rescind) {
> >   			dev_warn_once(&hdev->device, "The device is
> gone.\n"); @@ -1053,6
> > +1060,11 @@ static int wait_for_response(struct hv_device *hdev,
> >
> >   		if (wait_for_completion_timeout(comp, HZ / 10))
> >   			break;
> > +
> > +		if (time_after64(get_jiffies_64(), timeout)) {
> > +			dev_warn(&hdev->device, "PCI stuck waiting for
> response.\n");
> > +			timeout =3D get_jiffies_64() + delay;
> > +		}
> >   	}
>=20
> There can be some enhancements in above patch to address these problems:
> 1. Logging forever every 5 minutes in case of no completion or rescind.
> 2. If we now print warning once, not knowing if completion ever arrived.
> 3. On solving pt. 1 and 2 by adding a print for completion, one should av=
oid
> adding a print by default for regular timely completions.
>=20
> Basically something like this:
>=20
> #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
>=20
> static int wait_for_response(struct hv_device *hdev,
>                   struct completion *comp) {
>      unsigned long warn_at =3D
>          jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
>      bool warned =3D false;
>=20
>      while (true) {
>          if (hdev->channel->rescind) {
>              dev_warn_once(&hdev->device, "The device is gone.\n");
>              return -ENODEV;
>          }
>=20
>          if (wait_for_completion_timeout(comp, HZ / 10)) {
>              if (warned || time_after_eq(jiffies, warn_at))
>                  dev_warn(&hdev->device,
>                       "PCI response received after prolonged wait.\n");
>              return 0;
>          }
>=20
>          if (!warned && time_after_eq(jiffies, warn_at)) {
>              dev_warn(&hdev->device,
>                   "PCI still waiting for response.\n");
>              warned =3D true;
>          }
>      }
> }
>=20
> Regards,
> Naman

This looks better.

Thanks,
Long
