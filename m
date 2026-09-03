Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012052.outbound.protection.outlook.com [52.103.10.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E93ED3BA;
	Thu,  3 Sep 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454109; cv=fail; b=a9Tx9tWJqOmVoleRsWfJctnp1qWP2uOYwqHuaxWE+/Sis3qd9D1ttevxP8SoUco2nTzCxDvR7nNghNwBHbXELZw8k2V3clUGswWm1MwxnFClLTRF48J29Ht78fvsAfT6XWpa+zflsmKYy9sKJ3/c7F61KyNLAD3eUA6Qifl3g0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454109; c=relaxed/simple;
	bh=2VO+gkcfQTYlMzK0ERQBhDErEbphQgX4oAIICSxgEsQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbbsaOGR6LT9K9CbnidzQxCE341UTUqROjQBO6ZmbDvLz8bz2WX/v+tXwx7hDRcnjNNOMNPYcvF0GSHMx8Jb6LbfCq1ywAUPQCE6MiENPiiDwz3Mr/SVhxK6jR2jakxdQygiAwvQwdcG8qrHaz3EWZL2VdMH2nT/o7dFCsQQA5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WAbZ3SAE; arc=fail smtp.client-ip=52.103.10.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WAbZ3SAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHxPnF7zY/0jhQFDDx3gsNbOtLVJWQg60wo8iyTOb7Uq+wHdDRJqKQlt/2muYBWYXfsBRI6brNzdD9K75ZOhQ94C8/MAExENfUJwZXKH+lp9c6VagpLMttv/TYTVkqD9TAzZ0F5dpjoKoiHzR8ND+sm++O/qP070n/avr7ZmuNKiYGHU9de68fOM3izXsGcmN7MhJ3rv2H2sRFqyQoqtcos8YoEmelVu5bCWnPGdZoxkyCfxK4LYlj91ced/4yZti3lovMX25IJ/AJTWDCLBrdWZl4M9NvA0yxInC7V02PMLGwhgfzD6JkrDLHt8s8FQcp/naQIUOuV3o4bVK4P6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn1QbmQ4xedxUZCL18cBUMrxP9UFiTzf9USb8W83sbo=;
 b=l3ncYCcEaltqcjduCij+xNU+YNbKAC68db7nP0Vkgytjcf3itgRFEGGDHBCeX2fMSUKLbBSyX/jKN9eBpkpAnOmzD8n2hiVj0gFKymlaUm/DobRXqUqe/j2SmMQFsG9Zq8APeF3EwSl3M6hdjqj1KeyLcuRojOkVb1IqObC/BE9OMjtS7+5sv4dOH0QeBNWUiNQGb5OXs9WmbgnD3j03cdX9acXkP7aD+iWZdgbyXl/rkMgAALf//j9c0UZxL1811UcAX3UqhE7tA/EJK4uji34FchHbyh4jW/r9TVOa+qquBOQ+50PCbAIRkXVXAV4H0KhdD9flWLo4+fD3xX7CBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn1QbmQ4xedxUZCL18cBUMrxP9UFiTzf9USb8W83sbo=;
 b=WAbZ3SAEa7TLLN3LNqCEeI8J9JINxTFA4EuXqISY8MtajbwLJcG7IiDBq4zuAxFHgebmAFZk6bjWLz+VTLCmxIo+iiCswn7oSABhy/dnOWLiEZX46xlENAmp8/VPO1k/sVvRWtltzDRth4/HPDKk6r3Qmz+7wI0OvnBqaW+oCpXMLkKHvxQDjH9p/zRc53zo5Fl0X3u6FPe5gGkMa5ha65c1L24adXapRelC9/+EJ0Zt2iFIYMuq/YT/uPKf3UoLw8gAyRSTP+5AOFF+hbQwnnFqX+Lwq2cwGzFweWIO+q1zHsIJ458LiViJE1Q5SS1FcSkYu9sxd5Q0AgpLvTPRFw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7984.namprd02.prod.outlook.com (2603:10b6:408:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 16:48:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 16:48:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "hamzamahfooz@linux.microsoft.com"
	<hamzamahfooz@linux.microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: warn when wait_for_response() waits
 indefinitely
Thread-Topic: [PATCH v2] PCI: hv: warn when wait_for_response() waits
 indefinitely
Thread-Index: AQHdOtJ1qrivGgblSkyYsyi8/YZsj7a9EmhQ
Date: Thu, 3 Sep 2026 16:48:24 +0000
Message-ID:
 <SN6PR02MB41576349B2BDB3D44815E894D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
In-Reply-To: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7984:EE_
x-ms-office365-filtering-correlation-id: d76f291b-51ac-41a4-a438-08df09db2bd0
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j2981iOqa3TIFE7v3cGH1r/4MA0gFqk5TlXxteZvxOD96VCxFz2AInVvh5rNH2mwbdmC6C6YZzUseDsylpANxG705YQjJTypMHJ1FCOewZ5LMvq6FpCHl8KCVUy8isQM2i0hPZRzLqYkqTGqWHkNV/P/65aexvBMuPJm2ptqzdvL8HxRiW11CX80aXbSJ97Hg4xIrtVfj41E/6zRIquXz/oOUYX9D2CeDLzN7ezBKzklv68mCYbCIm7OyMnFguvf/z2cQgv9Ow4Tzsm7zX9SKiwtRG+/3CxoLbzAoGoV1FTP0QWsasgoO/lE6UMKdjshZJx7yNzXPaO8YqXmCxFgQb2fLEnoxAH7vVkYlv5bkWLeF5bQDVoqy1elFu9+WRDbrXcXxr328GvhyrvVMVId8uykHJfdt4sA55RfTYv/ThLbj70geVIwPP6s3pNa473fd6UgnZMrU0iyIJJ0+aBvJuwqs7WvvSZe+PS+E/21VMwoAqLDP5obgF4Mzj66stMn9XYr/HlME9vUT6A1gNFbu7JyCSHrdGabH7SeIocylSk0ZVKKBlNYQcZVMsTbKxK5iFFj0Bd7Tv2qYbuRXDeEWdOOvbVkr3WnkWzsJrxyedlg+RZGCcFLhOfznzLjnwLQrirGrJjGl1S0wurWl2xCpx7VJAJ2GEfiOkIlE0Ju1Lbo1Tjx9yy4cGv8LiPF66KLaSqb6OpTUqbZTWa4qEvdDAiIn2coIHoQnYUXUuhTQ0RCk/e3lOMoTBPDoz7wmp3WJgDQZ+oJMhpgIuNeZwVCeyizYEDQXlBK5QsiHnEPTiRZhojer8iMcyHD
x-microsoft-antispam:
 BCL:0;ARA:14566002|13031999006|13091999003|51005399006|31061999003|15080799012|19110799012|55001999006|24021099003|41001999006|8062599012|37011999003|8060799015|25010399006|40105399003|10035399007|1602099012|2607281247196008|56899033|18061999006|102099032|4302099013|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IegrFaZhymapAuzypeqzWxvONY8LX9eAiJ6xvVLspFRo1nucVa/2FLscF57U?=
 =?us-ascii?Q?niUSNrSydgexmRokfMeU4pWypCLCpwdNtHWUaq096hmaWz87GEiRJPnwSvf5?=
 =?us-ascii?Q?HrduWcq69d/7X0L+ltIhxKxUsrNkyCDHZD8bsB+71mVigSnndvuHNwDp3mky?=
 =?us-ascii?Q?ILX1m/SCwQetRiaQdtXooJQchlKcKpUp6Ndw65P7Jf+MvqEbyH+XhtvH1RJZ?=
 =?us-ascii?Q?+IcV9sLAQS/r36rciB8kmS5z0400XUuKWWo3oCRnflB23yDLwVYy7Uqt73cB?=
 =?us-ascii?Q?vAlP15md3wczQGEakQzXMhvRO6+YajvJcR+qoatlpKaOkLjQuAX5qzUs1i55?=
 =?us-ascii?Q?OjT+xw4gqrs0YmEy9oXETeJcQikg1fo3HrcMJuHHX5skGyktJ/oirYMJPEKF?=
 =?us-ascii?Q?HjOf7CUj8iXTJFQGxMEnwQldfTTHbA5j2OAeHO1klVk+EZPVYFsnWkE5RMNT?=
 =?us-ascii?Q?zeCIQUvMruQimd1Xz5wnjU/KbPYZJ68f+JlOjsZKJWzk5R0a+FUwDuY6ueKN?=
 =?us-ascii?Q?HA3VRFbUyYaTx4O5o9lXs54uA/qxbngqe5NjCO8zTFzBHkN0Ur6PLlu2dlpl?=
 =?us-ascii?Q?QIFa9bWZ8udmlziYAIP1bbrdrcEMsvp4MRtkfKSURMFSXknPILpAwxW77gwa?=
 =?us-ascii?Q?nq0+e+26LKTdG4JMxDBuvKvj3gKo12pBWQb0DfZQ4hLPJs58cIJMhIHzS8uo?=
 =?us-ascii?Q?25kyzwLa2Svs3zEdN6kPD6JbNUelnLyTneYyQNKP2pituKvzEXIJI7XFPx3D?=
 =?us-ascii?Q?f+P0l81vP7ydB7rUHiCqzS00Irk64M313LKJG8olwOkUdZ9749Tm0RVqhBJi?=
 =?us-ascii?Q?xfEmb0rAHoGKsHW7njSHrRgVBQr/9R0By9Ey/X0SWBy8oflLheJn2G23Vdq3?=
 =?us-ascii?Q?mvrQlFmhtJfvLgek8rXINGaMiBXoO1CtxduXg2UPi0njU56Ja5XAWaIYhAiz?=
 =?us-ascii?Q?8h+bXf33P+Nu4W616uaoFamf1di6Acr7dm88ZvxDwcZBgGv35A8+7Pdmkcju?=
 =?us-ascii?Q?2JfjnRIsdaGDz8SkLxV5H+GADATypmowNJ+GT9PYAVN1K1yZ8sheTgSdyAK9?=
 =?us-ascii?Q?ghS1TIl6vO9NjNQspK8tXXhG6HBviSlqPB775jgLPtWCn18nTC01wJY3i/jG?=
 =?us-ascii?Q?lBwRVNh813dqncZGFeLY+mE21agnPR3dgmIcqITWddAPtQYdVNNpjx7kZVrM?=
 =?us-ascii?Q?+s77XBUKmkK+nuMpnDFxWUFtHdRGavWplwIUDBLTtaPMm3rg7onxG6pyvBmF?=
 =?us-ascii?Q?31+YIqawuLs/VkbcSmTR?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?92LFFF8tci6mVHn11YMihIBFGZmj4XvoCkADf5vQr0MgvIbsRBHPfKIjlE3h?=
 =?us-ascii?Q?1dnT/n5NcVpAPZ0gksCECGSnR21dKBZBZos7ufUNY40SeawS1lD32Is9uY//?=
 =?us-ascii?Q?vqmeFPEGFgGSQw2pr6ivDzRQapj2rvAYh+9DvC7v81A7ydiHPLZ6y3ekREsl?=
 =?us-ascii?Q?8LfHbYF0isJgvBsxZxrpZHRmxiyd13z7i6Egfhjob3wG9I1iBn153TmqPGQK?=
 =?us-ascii?Q?ix7HLtSofx8Gd7jtABWc/AIm/zbByXo4D9Fz+FGncjd4sRarEXGLFhvPPd9Z?=
 =?us-ascii?Q?k0xdDfSaav2r8ZyUvThS9WTKbqwRT0QDDLJrrr2wRZCMkZXiJhLrTj0BhJ9n?=
 =?us-ascii?Q?PoCHCgM5XtRjTkvUpc2HVj6kwnn1vWVTIhps/7fq4IPxva8zSPpeGn4v1ZTC?=
 =?us-ascii?Q?rCOu8PlR2vF622GLnEvVlbouZkZLlsS5ox4chQffgc5fsbAkymCom+Rgz/Xp?=
 =?us-ascii?Q?wOP5fVw+o+0SG/0IniqyxzWD2jVP2THF7VZOs85FhelZgdfL8o8hS0Wq8lwb?=
 =?us-ascii?Q?iEIzm6Y5kHn16x74/GsKu1ku9eKHQGBBtYRs78+UoBtUiSA/RrryiHgAAD7F?=
 =?us-ascii?Q?E9ASe3uKBqwA/NPyUouqG270rCxbrTQdmD1TNnT5KG7lZrT/f6ghO6njqGvU?=
 =?us-ascii?Q?zFwFPOhSNqI5VdoBfG2RrCdagbxIqJF0HQ+h0EW+3hzM/qHizOHB2KVXDqyh?=
 =?us-ascii?Q?w6w06r6CvjF9GcK61/i8iwyFVYK19I/bnocOy/m5Pbggp/HP+pO85/FoOQbU?=
 =?us-ascii?Q?T10TxpDBxL7yBMxY295GdCxoYI7FkuHfqZ85PTI8QhzOh6aj/unftwt2nO/V?=
 =?us-ascii?Q?1fGIiKFgfVi5qsCo7yNXDJdDzi3F9+OZh/H2Hp3xvD5MBU7BKsVNH7hScdb0?=
 =?us-ascii?Q?OM+TVOQQllEi/Ec4+ghzYoNJy+/ROigXT/ItPaNXKTkG8Npr4QFxSpdjwuSf?=
 =?us-ascii?Q?YyzEH+2td/6nJ4DFahwVuWCN8zFNZR8hMwzuh2MLZnbn6Qr8TYo7iaRxN2fq?=
 =?us-ascii?Q?LB57zJbIbwR8lTUtA7DFz6jZDuAlqX2w6FFaOlBp/9hEFeMnrsEtBzsFILeI?=
 =?us-ascii?Q?M93y3befdC3/sc7cU2///YtTEQDr4zdxS4IgiIoTHrpceYRNCs9LWsvdSbyA?=
 =?us-ascii?Q?ykIuD+y2FsmUv+JNEp0+hJ+nTt2ipeqPLX+t8rjkW6WeGyPdmu02c7fAZpR7?=
 =?us-ascii?Q?N5xxxi64iZFHd7ycLRRfGlNmlBfLg01eZ2W4/2efITJH5SGOZoaHW/uvvIxF?=
 =?us-ascii?Q?QiUulpbwu2TM0hS4nlEyFMiZ5aRgEJWvKtk7wX2EntilbSwMu6Jmm+lmPgAK?=
 =?us-ascii?Q?4jQg2D+ST2AKoM9gDmkSL7ZeAKeZU0l5FkFoszWVxbEKjtFkd8v8rtCDMlaR?=
 =?us-ascii?Q?VTpfvRQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d76f291b-51ac-41a4-a438-08df09db2bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 16:48:24.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7984

From: Sahil Chandna <sahilchandna@linux.microsoft.com> Sent: Wednesday, Sep=
tember 2, 2026 4:59 AM
>=20
> A guest can wait indefinitely in wait_for_response() for the host to
> send either a rescind message or a packet completion. If the
> host does not send either, the guest can remain blocked with no
> diagnostic indicating a reason.
> This was observed during a guest kernel upgrade in which the
> host-side application handling the PCI channel faulted, causing the
> guest to never receive the completion request.
> Add a warning in wait_for_response() when the wait exceeds
> a timeout so that such a hang is visible in the guest's kernel log
> and can be correlated with host-side state.
>=20
> Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Suggested-by: Naman Jain <namjain@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> ---
> Changes since v1:
> - Removed periodic warning to one time warning in 2 minutes
> - Include vmbus relid and stuck PCI msg.
> Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilcha=
ndna@linux.microsoft.com/
> ---
>  drivers/pci/controller/pci-hyperv.c | 48 +++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd..ca9d8efd748c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1040,19 +1040,40 @@ static void put_pcichild(struct hv_pci_dev *hpdev=
)
>=20
>  /*
>   * There is no good way to get notified from vmbus_onoffer_rescind(),
> - * so let's use polling here, since this is not a hot path.
> + * so let's use polling here, since this is not a hot path. If
> + * wait_for_response() has been polling for PCI_RESPONSE_HANG_TIMEOUT_SE=
C
> + * without either a rescind or completion, add a warning.
>   */
> +#define PCI_RESPONSE_HANG_TIMEOUT_SEC 120

This all looks good to me and it should work as written. But the code
seems more complex than it needs to be. There are two timers running in
parallel -- the 100 millisecond timer in wait_for_completion_timeout(),
and the larger 120 second timeout for printing the "stuck waiting" message.
A simpler approach would be to count iterations through the "while(true)"
loop. Print the "stuck warning" message when the count is exactly
1200. Print the "late completion" message if the completion occurs and
count is > 1200. Then there's no need to manipulate jiffies and the "warned=
"
flag isn't needed. Make the loop counter 64-bit so overflow isn't an issue.

Arguably this suggested approach is a little too clever, but it seems clear
enough to be easily understood.

Michael

> +
>  static int wait_for_response(struct hv_device *hdev,
> -			     struct completion *comp)
> +			     struct completion *comp,
> +			     const char *msg_type)
>  {
> +	unsigned long delay =3D secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
> +	u64 timeout =3D get_jiffies_64() + delay;
> +	bool warned =3D false;
> +
>  	while (true) {
>  		if (hdev->channel->rescind) {
>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>  			return -ENODEV;
>  		}
>=20
> -		if (wait_for_completion_timeout(comp, HZ / 10))
> +		if (wait_for_completion_timeout(comp, HZ / 10)) {
> +			if (warned)
> +				dev_warn(&hdev->device,
> +					 "Late %s completion arrived.\n", msg_type);
>  			break;
> +		}
> +
> +		if (!warned && time_after64(get_jiffies_64(), timeout)) {
> +			dev_err(&hdev->device,
> +				"%s stuck waiting for response, relid =3D %u\n",
> +				msg_type, hdev->channel->offermsg.child_relid);
> +
> +			warned =3D true;
> +		}
>  	}
>=20
>  	return 0;
> @@ -1518,7 +1539,8 @@ static int hv_read_config_block(struct pci_dev *pde=
v, void *buf,
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
> +	ret =3D wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event,
> +				"PCI_READ_BLOCK");
>  	if (ret)
>  		return ret;
>=20
> @@ -1607,7 +1629,8 @@ static int hv_write_config_block(struct pci_dev *pd=
ev, void *buf,
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event);
> +	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event,
> +				"PCI_WRITE_BLOCK");
>  	if (ret)
>  		return ret;
>=20
> @@ -2624,7 +2647,8 @@ static struct hv_pci_dev *new_pcichild_device(struc=
t
> hv_pcibus_device *hbus,
>  	if (ret)
>  		goto error;
>=20
> -	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> +	if (wait_for_response(hbus->hdev, &comp_pkt.host_event,
> +			      "PCI_QUERY_RESOURCE_REQUIREMENTS"))
>  		goto error;
>=20
>  	hpdev->desc =3D *desc;
> @@ -3256,7 +3280,8 @@ static int hv_pci_protocol_negotiation(struct hv_de=
vice *hdev,
>  				(unsigned long)pkt, VM_PKT_DATA_INBAND,
>=20
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
> -			ret =3D wait_for_response(hdev, &comp_pkt.host_event);
> +			ret =3D wait_for_response(hdev, &comp_pkt.host_event,
> +						"PCI_QUERY_PROTOCOL_VERSION");
>=20
>  		if (ret) {
>  			dev_err(&hdev->device,
> @@ -3476,7 +3501,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (!ret)
> -		ret =3D wait_for_response(hdev, &comp_pkt.host_event);
> +		ret =3D wait_for_response(hdev, &comp_pkt.host_event,
> +					"PCI_BUS_D0ENTRY");
>=20
>  	if (ret)
>  		goto exit;
> @@ -3553,7 +3579,8 @@ static int hv_pci_query_relations(struct hv_device =
*hdev)
>  	ret =3D vmbus_sendpacket(hdev->channel, &message, sizeof(message),
>  			       0, VM_PKT_DATA_INBAND, 0);
>  	if (!ret)
> -		ret =3D wait_for_response(hdev, &comp);
> +		ret =3D wait_for_response(hdev, &comp,
> +					"PCI_QUERY_BUS_RELATIONS");
>=20
>  	/*
>  	 * In the case of fast device addition/removal, it's possible that
> @@ -3644,7 +3671,8 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
>  				VM_PKT_DATA_INBAND,
>=20
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
> -			ret =3D wait_for_response(hdev, &comp_pkt.host_event);
> +			ret =3D wait_for_response(hdev, &comp_pkt.host_event,
> +						"PCI_RESOURCE_ASSIGNED");
>  		if (ret)
>  			break;
>=20
> --
> 2.53.0

