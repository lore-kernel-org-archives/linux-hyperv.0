Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854472;
	b=UKsZlRnPhptdvKcea1LJcO4lL1VPRJESfB5RiIDdjvvb0kEhQvBrZY5TwSsxEt/olxmn
	 36qaZllrrLN3vFpHRgEvjfAhyKCFGwvzrGhNptC6KvrCP5/LtuPAllTMK3BIxtKxhVxfe
	 InQ0KkAzv+3NQKbN6Zh3fli0ZLUybyGP+/qqFT+nUMmc6LlxlJ52lSgsY0w8ZeHhFNVL5
	 RR7eJFreTUg5FWBLpLtyAW78YsKPAZ1D0aelyy/i9YnXF7rnuuoBK5OD8I0UVby9HbbzN
	 WANCzQrKToN+CuNrDyQhUam/XF4D3LXG5uXv/EgXyJC/UsncuSZlEp7zdyyyOlliEkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854472;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:
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
	bh=ZxbUC9yhidbP5x4JPV4ulk3mYjpfykXwmrzmOSQrfMA=;
	b=CHUD42mblf3/ohg1NBlu63Q9HD4VlqB0Z4ToFeD4o5rLbYZ7fJGzZAbfR9i9NbrwDzcw
	 3xTRhnqZ8R9APYqBg134NbqhkH7nEqcpmwta2Q6BEQRGlcN/OENNKWpon04+EG+3RnBKJ
	 PelbWzcO2Sn9MGIrahrxU8KL4OBFcDaPua/MGxa3JU6+/zyP/PH0P14Xip7S5iF3Un6aU
	 rFOk372BYcv5ql9YsN0ZWNll4YapQHHOsRRhAYua6IJ/Ogvw2mZLwdncrJBIpzuIRm7qu
	 89gVmQpjJdxYv6h8jrJhHhtw+s66MutYK1kYBqkJsPm/5hPOQpNascXo3jNG+PKs80w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IsC5wwFl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.72
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012072.outbound.protection.outlook.com [52.103.11.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EF606A31B;
	Thu,  5 Nov 2026 04:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 044EF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IsC5wwFl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw5kva+jSvFSo4AXcxt+jMgbYZqw1BTk0JcF4xOFC0+Zlf6AYNxkjODyIEYI65AcpXBsbXE/LLPQiS3lzYasiwlkrbRKfbzRioe8+NAbh9aiVh1/9hMPAJC6EK9cTGXWXIeQV7CaYgWFKeKOYibgFrou3KAeoWdxCfj97+D3Wb6W8sItfij7ukmcZHwobAhtAQundBmo3jyzoO95aQyP11gidhpJF8uxFaWgtcRJLH6Up9jAGuboRA3Pk95r9alIbo5HbsGW0opZXTVWRrru/GPFogrd/3oHqidmD9Fc20hsMu/AEBGQC/sQcmG0TTpe3Pyj2/5gCAxLPqovHaz9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxbUC9yhidbP5x4JPV4ulk3mYjpfykXwmrzmOSQrfMA=;
 b=iAV1p5NxGUzx0ChWjL1/scy1BHHA1052jcmm+5zdQdN7ZV5wafoE9gM8eol99aMEQFxaPKUuaV4vf0Ugq94pDZa9Z3JMRY+F5xVaG219d04fjLfdvt7SMn6LB8NebGHv+tTxau+N2zMpOynK1QdPSLKriRCBZyZ0tlLbJB9+WNR9mXb2QlKrexydVhpu1xB5duk63D4XdqC3ScFDmmpZDkltigCq1oh2mEZvpMY/seKswJrTBk9dvzcun1iHOo+IlcRsgTFcoZW2g8+kvRrHdsjlXAe17pmt9qtUx0QGqVRcrOPdsqrZ35m3jOsaciLcJyNvBkC/pAfdrv4JADNF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxbUC9yhidbP5x4JPV4ulk3mYjpfykXwmrzmOSQrfMA=;
 b=IsC5wwFl6d7Tw0ahvX3IGsrNBCCtm3fvFBlaAJ0KRQOakqXWbXRdFpT1pJrF+UZV6kHt8v8StGrMEcjJwbnkGnsS8Vo7RTY8MHgdkr6eiz0y8AQl4mfq8XHVgGXmT3QGI4S/beOvnVLrGzZ+Fsb4EFenujqB06k4lxFRz3VNAfyrnEiBLZjDW+HrbjOHf5ds3dmODgsquXrH2w41Z3vaBeK/udAO6zrfXqXKWWe0EYiFJSPZv+QQiwrVlFjF4kf5Ye2DoOs9ft07v5yEBT3uDt7x3pRkhl/hYutngMwza/KOpWhVTuNwAI+Bv46A0LcVkqxDMbT+CIAXluL/ejMVCw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH3PR02MB10129.namprd02.prod.outlook.com (2603:10b6:610:1a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:54:29 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:54:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
Thread-Index: AQIXomI6+otxfN4JCoxVV9PiYLu2L7anmeSAgALkzQA=
Date: Thu, 5 Nov 2026 04:54:28 +0000
Message-ID:
 <MN2PR02MB6863696480180D92E5A83B64D4772@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261101022257.52819-1-mhklinux@outlook.com>
 <e7eacfc8-7bf1-4dde-b62a-607a490fdd06@linux.microsoft.com>
In-Reply-To: <e7eacfc8-7bf1-4dde-b62a-607a490fdd06@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH3PR02MB10129:EE_
x-ms-office365-filtering-correlation-id: fff8f255-a25c-4386-0b17-08df3af8dfac
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|21061999006|24021099003|25010399006|55001999006|51005399006|15080799012|12121999013|13091999003|19110799012|8060799015|31061999003|13031999006|8062599012|102099032|19061999003|440099028|3412199025|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aY2ycrL9qPlE+eROkNn9DU/0uWk8YLmqLh6x/3xfslAVFRoXw1Ym67xXbByJ?=
 =?us-ascii?Q?H+QjHDbjcUks2tcIZ3rl1/OBToBsIgunGjN60HbiUidvjrxuSqZXaHzeu4bs?=
 =?us-ascii?Q?QKbbCu4ycgcGouUvmMjqsV6zeFGOMVCtoBRWm/YwrPogjSMFgEuS2EeMQg1/?=
 =?us-ascii?Q?Q6ho+Y4zGHEeBrAG4ORsGXHwcuwWYxuztKXz6j6WI6YnekaLWyLoVHfG9WAa?=
 =?us-ascii?Q?12LWTA3QqoXeSve6OxrJnLHEAKTjNdSQsTxdMlw+rh/sGgOFdiecguFU04Bk?=
 =?us-ascii?Q?PZ/+VacVaFnJjlifVEoVjS7Qm/KlK+cAgcrXakxryrGpqHdOEjF0tseBHn+b?=
 =?us-ascii?Q?i5qP1iKQeLLlSFPpJ3f/gr8ydcbOa1w+tZfSaPwibGpX3oroVrd58e5KHYCR?=
 =?us-ascii?Q?B4fIaM2hwPkkRZVO+clMXPFesgZZh6vAv3zpWvb/a8XsUhlrU3qLZJ7xWoNc?=
 =?us-ascii?Q?M0Toosz2/QcEekyaZgnRtXYI8b2GKDdFa7WgjevllntqShVCMDKGLpkq15dR?=
 =?us-ascii?Q?9WkPmcDLfevrkSlxUnsYxc0MejzTSyyBlzjqbVzFsTqmIfLflNSg1gBPh9mD?=
 =?us-ascii?Q?IboSXuAle307jyeoHGycYv+moZOKBix1VTZ1JlDfB2aHES//kacLrWTvboT/?=
 =?us-ascii?Q?KcnoWi90RqjS1ZSEMNcf/K1VXxE2LmUoKpkuwqf+5DZwou0bZSAPS5wmAuHM?=
 =?us-ascii?Q?ItPFbuf4XceCmPvwtwH333nvrGkkMPnWuB/1Z0vyEWsGUE6FLb1uqfztGcRZ?=
 =?us-ascii?Q?+HtLIW9Nk0LDOJsbznr9LvtPkR9cJ4RgDAF069oRxdchYexkru439VM3Qmz2?=
 =?us-ascii?Q?1aeycmE1wlDq/anuqn4TW9J5Q5g0HAeLURdOnvO6YEXSpcPsWK6xg3wxD/GV?=
 =?us-ascii?Q?+1IvUAVE5KltkoLqFgrzM/vf9QN0luHYrqIzv7WxsUAtSUwZ9UQ0qLPe2i1I?=
 =?us-ascii?Q?XA8Q6DPNCf4zWy2BBBSiGYYMpocXi1pwoUj4P3Xn07LTOTEtY5rO5aOvOP2s?=
 =?us-ascii?Q?KZXVSCpTj+ZaOlWyv2KH5+N1jVzf1UkaLCce9SnhwcmPlePdBCKDy5MjrqYC?=
 =?us-ascii?Q?XKftzK42tEsdNlZ+NHLL72PF17KuchNVWRuvMJtNGe8zRhBY5oXqvZhlSNu1?=
 =?us-ascii?Q?TnlD36av8ssv9i7/9CgKOo98X8cUWtmECVK7lGatQ/h71odVsMlCXmbuYfCF?=
 =?us-ascii?Q?kMDWtj1Xwu3IPF0X?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z92P9pfTsEbfZ+pj8d6iaP/vR1jKpBwlFZjw8Ts72nkwQzNSX/3TS7ogv4TA?=
 =?us-ascii?Q?y7ACw98qBs81w5sMjRKHOgtYfpjFsotittKvr8tP+jmyqjU8Z7EC3UqOPSr7?=
 =?us-ascii?Q?hp6KEqS72wiASY2jPsVa5bt3kDBqxQHgUUdfjOMXgvxVTvS76es46NPlPujf?=
 =?us-ascii?Q?pnBu2iq3w840Fu77ZOz0FS2G5L8hvnx6KKYg4MYzlHJAzTm2Oc5tx6AdYBXO?=
 =?us-ascii?Q?E8iIpHM6//i4/4QfsqCP7bXXwcOuJnbZHmCBK5Zg+NtAYRqDCObUWqWJM7nz?=
 =?us-ascii?Q?YgpRQzFOYse/HJVG3sH04wyvY0aBGmSu0RDjOcQVaGH2Ytj9NXreOtGBtRKe?=
 =?us-ascii?Q?W2unYTEMd8WtCMPu+WdU05yVoeq9Sy1AhhNmVkxjhJ04AHsCDPmR5BE9AvaR?=
 =?us-ascii?Q?hIict5pwAVRLU4vsGsVS6FqJpLiEuzbXkZkq9AzbeqCIzcHghhuyR84GttlZ?=
 =?us-ascii?Q?EmUikQvNScI+7QQoSXITFqvQ7cubtYCAuhrNBA9IAsoggyhYQ2rUlh1FH7Ty?=
 =?us-ascii?Q?RB/4mYc1Yvi+xWmCQmSskJWd/mYaS41ZKRmXlROgPWcK8ufnTHukgoIOZp2b?=
 =?us-ascii?Q?/Sm6GWOdeaytX5jm84qS0rgIMMPddcheSbE7tMTqlhVpH72JtlE7RX4FTsEG?=
 =?us-ascii?Q?n6Af06eXgi7RrF+ufjCkXCshEgx/pUggN4gs9YgG3FJe4LIlPXClSYUZF/4u?=
 =?us-ascii?Q?2J7KDO56TK9FxnoHkaxAx2qBVKxvEN4Toq17JrlWbPnJEOVLT4cAIp/rLb3D?=
 =?us-ascii?Q?YFrqSodfMv+8ga5z06r803Yyq8Cjq2PhCxw0H/w0mlSookMxcHAMpncQVSzv?=
 =?us-ascii?Q?VLla2Ol/OqG74URtd0H7BvhzPUiYstKl7ckwOgLp6UCeUEum8PLi7Dn/HFlP?=
 =?us-ascii?Q?9n93gwFWTwPP3jy5jqdVecY1VdVVZrUJlivp++F2VGg/uoLf8BN7Jej8WoVM?=
 =?us-ascii?Q?Bm4U9H4B3WdevjtQ9y9xcBkASmJzeLGygYVqPg9ho2G6O99YAMU0jbWQIDKD?=
 =?us-ascii?Q?WQlVFGit6g0qJ0JUKxNwKlr926aUIXKzcTl5WMzHM6OGLb74NHPLd8mSGq2A?=
 =?us-ascii?Q?pLtL5TlMp4nb/NLc3dSpOZP5lOCeaPssH1P9JrrZnY6gNGBniq4CoclFaxUA?=
 =?us-ascii?Q?eZcpr6CLIBMU2yJ7Ia5uyi/D5yw/fImqMbbAUzLrHhYhG2xi/17DmSuTj1tm?=
 =?us-ascii?Q?pCkpvH28INn4FHzKxFSE2kmfWJzViSy8tgK4m+Cld5EsaSMMj1ygVx5XIbbZ?=
 =?us-ascii?Q?dJSf82y7AUy58sfA8r0AIZqd1QhFaWELCmF2+6lQWwMFHG4KoZ80OtX3HoNC?=
 =?us-ascii?Q?0p1zsZhv1QNEt1VZsQQYZGIRvUt4ZZuACWn+GF+eh9YahvGTTHApumaWBLhu?=
 =?us-ascii?Q?ywPLEls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fff8f255-a25c-4386-0b17-08df3af8dfac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:54:28.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10129

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 3, 2=
026 12:43 AM
>=20
> On 11/1/2026 7:52 AM, Michael Kelley wrote:
> > Add a section to the documentation describing the IRQ domain and IRQ ch=
ip
> > hierarchy that is created for virtual PCI devices, including the
> > differences on x86 and arm64, and the reasons for those differences.
> >
> > In the context of the IRQ domain and chip hierarchies, describe how the
> > CPU selected for effective affinity is spread across CPUs in the affini=
ty
> > masks. Again, account for the differences in x86 and arm64.
> >
> > Finally, rework existing text on how MSI messages are composed. Provide
> > an expanded section on the overall approach that Hyper-V takes to MSI
> > messages. The section provides more context on the handling of MSI mess=
ages
> > in the Hyper-V vPCI driver, and why it is structured the way it is.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
>=20
> <snip>
>=20
> > +MSI Messages
> > +------------
> > +In a typical guest on KVM, the VMM traps guest writes to a vPCI
> > +device's MSI/MSI-X registers/tables. The guest writes a virutal
> > +message (with a guest APIC address and a guest vector), and VMM
> > +emulation translates the message to program the physical device and
> > +physical device interrupt remapping (IR) tables on the guest's
> > +behalf. The guest never sees or handles the host-level MSI message.
> > +
> > +Hyper-V takes a different approach in which MSI/MSI-X register or
> > +table writes are not trapped. The guest writes the device's MSI/MSI-X
> > +registers/tables directly with a host-valid MSI message. The physical
> > +IOMMU and its remapping table are still owned by the host, so the
> > +guest must ask the host for the proper message.
> > +
>=20
> Could we distinguish MSI-X table writes from MSI configuration-space
> writes here?
>=20
> pci_write_msg_msi() programs the MSI address/data through
> pci_write_config_*(), which goes through the Hyper-V config-space
> access mechanism. As described in the existing "PCI Device Setup"
> and "PCI config space access in a CoCo VM" sections, those accesses
> trap to Hyper-V in normal VMs, or use explicit hypercalls in CoCo VMs.
>=20
> The distinction seems to be that Hyper-V requires the guest to obtain
> a host-valid MSI message explicitly over VMBus, rather than relying
> on interception of guest MSI programming to establish the interrupt
> mapping. That is separate from whether the programming accesses
> themselves are trapped. We should probably make that distinction instead
> of saying that both MSI and MSI-X writes are untrapped?

Yes, you are right. The current text is imprecise and conflates the MSI
and MSI-X cases. Both cases require the guest to request the MSI
message from the Hyper-V host, but only for MSI-X is the address/data
written to an address that is not trapped. My assumption is that Hyper-V
takes this approach for MSI so that the same mechanism is used for
both MSI and MSI-X, even though in the MSI case the address/data is
written to a PCI config space address that is trapped (or uses a hypercall
in the CoCo VM case).

I'll reword this section to make the distinction clear.

FWIW, the code comment for hv_pci_restore_msi_state() conflates
MSI and MSI-X in the same way. I'll see about a patch to tweak that.

>=20
> > +The "asking" is done by the .irq_compose_msi_msg function for the
> > +"Hyper-V PCIe MSI" chip, which is hv_compose_msi_msg(). The
> > +implementation requires sending a VMBus message to the Hyper-V host
> > +and awaiting an interrupt indicating receipt of a reply message.
> > +Since .irq_compose_msi_msg can be called with IRQ spin locks held, it
> > +doesn't work to do the normal sleep until awakened by the interrupt.
> > +Instead hv_compose_msi_msg() must send the VMBus message, and
> > +poll for the completion message. As further complexity, the vPCI
> > +device could be ejected/rescinded while the polling is in progress,
> > +so this scenario must be detected as well. See comments in the code
> > +regarding this very tricky area. A synchronous hypercall to get the
> > +MSI message would be a much nicer interface, but the code makes do
> > +with what's available.
> > +
> > +Once the host-valid MSI message is obtained, the guest must treat it
> > +as a black-box that the guest does not interpret or modify. The only
> > +valid guest action is to write it to the MSI/MSI-X registers/tables
> > +using the .irq_chip_write_msi_msg function on the HV-PCI-MSIX-<PCIaddr=
>
> > +chip. That function is pci_msi_domain_write_msg(), which calls
> > +__pci_write_msi_msg().
> > +
> > +If the affinity of an IRQ changes, the steps must be
> > +repeated. A new host-valid MSI message is requested via the
> > +.irq_compose_msi_msg function and that message is written
> > +to the MSI/MSI-X registers using the .irq_chip_write_msi_msg
> > +function.
>=20
> I don't think ordinary affinity changes require a new MSI message,
> including with the companion arm64 spreading patch applied.
>=20
> hv_pcie_init_dev_msi_info() installs irq_chip_set_affinity_parent
> instead of the generic compose-and-write affinity handler.
>=20
> On arm64, the new hv_pci_arm64_set_affinity() selects a CPU and passes
> a single-CPU mask to the parent. gic_set_affinity() then updates the
> SPI's GICD_IROUTER and effective affinity, without recomposing or
> rewriting the device's MSI message.
>=20
> Similarly, on x86, the new CPU/vector is communicated through the
> Hyper-V unmask/retarget path using the existing MSI descriptor.
>=20
> Could this paragraph describe updating the routing of the existing
> message, rather than obtaining and programming a new one?

Indeed, I agree. The .irq_set_affinity function is originally set
to msi_domain_set_affinity() by msi_lib_init_dev_msi_info().
msi_domain_set_affinity() is the compose-and-write affinity
handler you referred to.

But hv_pcie_init_dev_msi_info() overwrites msi_domain_set_affinity()
with irq_chip_set_affinity_parent(). Evidently the mechanisms you
describe above for changing the target guest CPU are sufficient.
Just to be sure, I ran a test on an arm64 VM in Azure with a Mellanox
VF, and indeed there are no calls to hv_compose_msi_msg() when
manually changing the affinity of one of the Mellanox IRQs. I wish
I knew more about what exactly Hyper-V is doing under-the-hood
so could better interpret the Linux-side code!

I'll update this portion of the text as well.

Thanks for the careful review. Let me know if there are other
aspects of this topic that you've figured out the hard way that
should be documented. Hopefully getting this written down in
one place will help someone new coming along in the future.

Michael
