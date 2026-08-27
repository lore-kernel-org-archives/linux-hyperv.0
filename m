Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010022.outbound.protection.outlook.com [52.103.23.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001A485CE8;
	Thu, 27 Aug 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846830; cv=fail; b=IFPw7gPEx2W6D65yN73Hup4T2U0y+/Ggh2tUlH3hzMDxYIqzWfsq0ASRvFzsemUM64r9q54aA9NnoxlgCPsg29pKQQKC/hGyvzV5g5G5j7VuJ6VQloasT6OfLoL/iqpWuyx3LCai6npfF4EmWVRPLN1hf5T2G/Q5Q1mwkRnt6zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846830; c=relaxed/simple;
	bh=mqTINbod+1inTDwo7ZGUAMHxdPSd61sEWF/BVkFGaVw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HDiQuNFksRwB0EX5wY8Yo6P46Wub7zGLA+F5ZoewTMkLXdRyegYs9BOB2udroSZAyVOkQ/DBkhph5rlx92yv9PYUCndZcPti6N37CMGonRPcMABj+iLp93aD5LYn353yjsg9ZNtGw+ABNK2OTBTMIeLT8gkBJwgaBqZQLhDK3Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IiFK7Hdf; arc=fail smtp.client-ip=52.103.23.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IiFK7Hdf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuCND0jbcFSujttf9EjWy3PvQU3t6XtucUuXL722h1zznIHNP47GQPtkRiMt4U5HZv2OLXLIzOrgBTW5lGZrO1F7tZkU8XPOjg04Vwp4xt4hcpeyKdyy2x+bqFT8mRfSnIJS1lwbb9Wd66h+3PxbnEDJQ7uzSsH3pL6rp2cKCf7aBFKNNkSsWF1MteBHvcLINjHpoPskgg2+c4y3DsDPsaXKaLiRnE4aJTcL5KjKJMe3LC/V+EEYvvae81nc74jPTzBmBzYmV9J7N409JrKHmwe+UjxxzSce9UNc6Ckpy5BphBMROYcJTkuEs1JUvz25iSwzJ+hewCeK7TBFMBYw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVEem69Z+rTUXv2NKI1+uPZF6VQGpOpsFiE5RSl37EQ=;
 b=t4uMJa5EFog7qegtHGDESox4k2NcdI8sqUTsVMTtuhFqyPHZJ7FuuBu58JHL43580g2pWPxMv0twSGPQHyrp/BTzAwaCL0Ddb/HLRwrOHf3XO/mUafJVuNiovrBHAnkMmIY1bSPYlGmc7mZj2/4x9z9E9ehDAhm2XsTx0LmUY+XVbeXuNYs9hL7cWPMwAyVYf/zRGXj8S0j3egemDNminRMqF3mya1D2NZsvfUvjUzvjhbag3ydu3l4gOT1SMWUxAli8glg1fCGVdV/0HCjEpjacuBQyx10k8Y6QWFut5vs9p/gvv8Gn02TCKSf/qfsXuCYh3acHsYBbGkoSfFQSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVEem69Z+rTUXv2NKI1+uPZF6VQGpOpsFiE5RSl37EQ=;
 b=IiFK7HdfQ7l63cvx6y8hodmv1k/lmo124Jbev3K/I2OPSjOihQj5ICqgum3U8MGgQHAZ42/qrKC0Gj36nEk+GMcUWihKvLXmtyA1jogC4Hqf7eFNwtl+ziC/dxR0XbuklXFxCNfJlnE2ddP9lfwtmFdjVSkhQ8Z6Fzu7zHnpbPLrSBc7KQY9ZzzGG763wqwTjasDcJf3hhlERBvDGl5pmP9o0kvfG4LWegODJx23Zc6ioyc4UMYmlfLRm4uLD337amBelkdMvAfQ43f9Fu2J4DqKN6V3i7IrZN5WJFLYjdNUACTpRREsIHv7iQ0bVG2/eN3fPz+dZYmuP4ALSEZZ6g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7452.namprd02.prod.outlook.com (2603:10b6:806:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 16:07:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 16:07:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, Naman Jain <namjain@linux.microsoft.com>,
	Sahil Chandna <sahilchandna@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
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
Thread-Index: AQG4UhXQUA1TB9NlC8hDWzGtIZRKrwHJvkR+ATw7WGe246Oo0A==
Date: Thu, 27 Aug 2026 16:07:06 +0000
Message-ID:
 <SN6PR02MB41578D73327A61FD3D7412C2D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dc4abd39-7366-4940-aec4-2297ecdf07fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-25T17:00:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7452:EE_
x-ms-office365-filtering-correlation-id: 0c0ddc24-5c36-4c30-4d07-08df04553db8
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|24021099003|55001999006|51005399006|13091999003|15080799012|31061999003|41001999006|8062599012|37011999003|8060799015|19110799012|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?713KiWPBZSMB9wz13gPjvonVxYtLRXIueNtQC7kCdgmQQ1OMSVa5pe8CvIy+?=
 =?us-ascii?Q?s1/EyJiSsUpTuNVjnBqdZnp6/m6miPEUeRUUs9h4Y4a0kACC5SkHw/yoUD1W?=
 =?us-ascii?Q?KDb/+mhJFnB/KXXQTWkGOWjbL7yWauxdBck0ofYrYMUDSr6+2IvgNWbn5qd8?=
 =?us-ascii?Q?m7fSuFdl9RA3Mh2Bkf9iRfAI/tdd6yS0/eCqGy84e7Oki6nCqor3T2MVqG7R?=
 =?us-ascii?Q?Z5OuD4eyYu+nnuzbT5I/z7uNxh9Ay5d2Qa1IudOwli7HkPlec6aQXA2I10t4?=
 =?us-ascii?Q?3BoVTpfC+/xd+KbNc+739hxGufjcYPf3i6tCCafY1wo7oqYPITnTa8NpY615?=
 =?us-ascii?Q?5V9lwTWdj9bfvcqq1yJnaUhrbE4/mfNimboh0NPyAxBj+Q9oLBqsZYLwvtK+?=
 =?us-ascii?Q?HRCmMkik6KIEZCURZHlrOIO8MeALq5L22xXDaWFUsjeBeeMWNrLyb19KPO6k?=
 =?us-ascii?Q?vfKt2Q7tI5HMjHKmGGIQVaD+rQTS0WANfSURhdqyoyDeGHL09Vftj2ppv+XV?=
 =?us-ascii?Q?SFKlcNQT0+xPrOMMQzm4GGZ51SD3ToS6USB55wiwJp7wW7RUHF3f9JSyDraD?=
 =?us-ascii?Q?fwN4jSAjCgfreLmbJS5jKXW74w33rKJWm3knxpiRa/c23o3YmIC7I2Ll/zMq?=
 =?us-ascii?Q?66tIFcEb6vWcjxmkyQLu+mezKrWZZYO1oMNCRFdWQ+IVr+PczoigumEKlsHg?=
 =?us-ascii?Q?yUDj9T7tPK8lYpVSEuYGtkb+wiRb/F4EKJEZgVY0O7eADUPPaV49KH3s3l0P?=
 =?us-ascii?Q?TWOGhctdsBFNVy802r3/hYLejRHAxbKIWVWC6MGLUCNq6qHjpaHW+66RWUjd?=
 =?us-ascii?Q?mwuDeK6K5EU8YArBdcEBzUt1zq0lwJTMiRybFx52ItQvjczji+cNQCj2VLPE?=
 =?us-ascii?Q?IsHbehwKHy00iT7I1Bc6Ve78sr4MxZSq80xVwYjOSG8eASjNNB+D6Rj0/byG?=
 =?us-ascii?Q?PaMV1qvNwKJpwUsq1dLpi9oeYXFqMV5j2JZH/jKCBAB0dJMiFCp+zFHp7vMx?=
 =?us-ascii?Q?RJXT5Yz/s9lzJgvbXsxxXgubwklgeFlPIv2ZI2H2KrzrBqXJzoCHUMgzPIZS?=
 =?us-ascii?Q?RRG8SYjb?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WzGZMHEtW5ZTFcm0s6u44s9r6bOXqgEKEnwz8q1MGXQ9HkTBDY5ErpvjOfHG?=
 =?us-ascii?Q?XkbJ8IpCbrCxwl5OVWg5Gy6ULDe/yD3w+ZiNEiUnQIZff81bBhj7ZLLOqAET?=
 =?us-ascii?Q?DKmxg5EvJCnqdgKWw+4FBGlXcI7MsuoDIAl/chsW8iVyOBS2I5SPltQ+fFjp?=
 =?us-ascii?Q?WBEjGY2qvQyqjp5ANDL7rEuQ99khxurD9zqxlL72lnmskKcfjm3yT4G7/Vac?=
 =?us-ascii?Q?dTMkkveqVnNoCqaZRapyb2AtkrDaQ6MWGKSF7yE0/OXLWpYQ1rRPiy1dx9/e?=
 =?us-ascii?Q?RY1Q2WHZq1eaMKaOitcEeIUNQ6TUi9kosP0pHdDjv9ewYuYGjEw2HOig0DkJ?=
 =?us-ascii?Q?BIIi0ZJ07/iphq6oPMsxfVi6JM85sqWEWoPiWJL92nLOY9S3sn9C12rv1W7S?=
 =?us-ascii?Q?GiV+DdZS6+LAMnJwFvYXVLvZz0YJuMgbsuLtxL4hNlSdrMHTxo462fQclUYi?=
 =?us-ascii?Q?Ha8x244VPJtwLmu6duAq37w2A15yeB//TP0zA1PtKj8ff2gtGrn8BVI7U8M7?=
 =?us-ascii?Q?12lrxsXI2juggbzC2BR0Pxj0BrVibhCRLKFb54Ou3B3jttcv5mRsY5lEECJm?=
 =?us-ascii?Q?MOJjzwkmekJ0ZiaZVAbTJom0Aoa8nNBcc8OJwiPWzWSMnH5CygkMrKqHzLe4?=
 =?us-ascii?Q?ZXjQzTVegzONw8jhXxL6YFEoRvxEmsjzMeUzDjC7aSmVQuxoI5VaCkL1E5BY?=
 =?us-ascii?Q?JgEH7wb/Hk091apugIV1Yxi4ySEMpoziXS7o0hiQioOOyvbT1n1QqiAsSS68?=
 =?us-ascii?Q?zyMT1SwSxNbeJhFMj1tb2/DLukaWjYTk0t4JQEjyepboHLvPCsCJN365nPde?=
 =?us-ascii?Q?qRh3enAenDWJ94mYi9KPY5LUI9mCbuuMqI62w/cZT1RSjh2w8iKfT8vpyYOZ?=
 =?us-ascii?Q?n1ngr+54mSJbSp/HTsiUFtp1VJkz2LIbF52m2CBtcoACzeuebbFEPA5HxAhP?=
 =?us-ascii?Q?J5uyCHtJFP1QiXPFuTtrL71Idpnik/zUegADrcRNdakWvy7cF4YaRFYQ3tJH?=
 =?us-ascii?Q?Kniy2qHg1J8tPl0i8XufeqpT53iIfT1UAL/DZYklSRADm5nYj+bkj1L7ReQK?=
 =?us-ascii?Q?eBEOlOoBTXnGJha+Z+vzUmRFyWGPJ7vYlsVHcqYJ9JTk/XzuP8Clb7qXubsp?=
 =?us-ascii?Q?XxQaaNJE7V2uIzhsVXqec6PCJpGccdk0fZ6zXQg92o1sPHbrwGHbT49H7vxs?=
 =?us-ascii?Q?XgPNj4k9KVGs9VCBo0JKmvs8mHCpi6PrctyfcbNhjez6Q3szrIbInmY9iyYU?=
 =?us-ascii?Q?vP+Tcmv4/mmW5iFuBCF0/aYb2UvnHmypE89lXZGD5Vj33AomMyzY2rfAZHsY?=
 =?us-ascii?Q?7equJRntHaLjBaZYDUyGHaGRWfD2vQKsNcE7pPfLsVfP2IXT/h81ZpXaVGHq?=
 =?us-ascii?Q?L7KTZ/4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0ddc24-5c36-4c30-4d07-08df04553db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 16:07:06.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7452

From: Long Li <longli@microsoft.com> Sent: Tuesday, August 25, 2026 10:01 A=
M

[snip]

> >
> > Basically something like this:
> >
> > #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
> >
> > static int wait_for_response(struct hv_device *hdev,
> >                   struct completion *comp) {
> >      unsigned long warn_at =3D
> >          jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
> >      bool warned =3D false;
> >
> >      while (true) {
> >          if (hdev->channel->rescind) {
> >              dev_warn_once(&hdev->device, "The device is gone.\n");
> >              return -ENODEV;
> >          }
> >
> >          if (wait_for_completion_timeout(comp, HZ / 10)) {
> >              if (warned || time_after_eq(jiffies, warn_at))
> >                  dev_warn(&hdev->device,
> >                       "PCI response received after prolonged wait.\n");
> >              return 0;
> >          }
> >
> >          if (!warned && time_after_eq(jiffies, warn_at)) {
> >              dev_warn(&hdev->device,
> >                   "PCI still waiting for response.\n");
> >              warned =3D true;
> >          }
> >      }
> > }
> >
> > Regards,
> > Naman
>=20
> This looks better.
>=20

I like getting the "response received" message if the response
eventually does come in. It's a judgment call, but I would be OK
with outputting the "still waiting" message after each wait interval
rather than doing it only once. And I would make the interval smaller
than 300 seconds. Five minutes is a long time to wait and wonder
what's going on when things are hung. 60 or 120 seconds would
be OK -- a line in dmesg every 1 or 2 minutes doesn't seem like
spamming to me when something is fundamentally broken.
And probably don't expect a VM in this broken state to keep running
for hours -- the sysadmin or automatic monitoring software will
reboot it to get it working again.

Just my $.02. Outputting the "still waiting" message only once is
also OK. Your call.

Michael
