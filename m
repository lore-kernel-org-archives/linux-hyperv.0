Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871044C653;
	Mon, 17 Aug 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987670; cv=fail; b=SL1Wh0WEn/taSQzeeh/4j6Xb2wRpHXlW1n6Mo933dEUMCt6BbEahSJzhZaOv4SRFUPU4d3pdo44WW2irgLw+OKv9cXRU0OW67jmCUaHbdjGBRpmSMkm1kusuNpwOm7QslsoPTPI+wvOdaQ/E5TSdCn89hs12pLcL67kXnq0d+SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987670; c=relaxed/simple;
	bh=Sg57RovxhIgBrHny/nRczKp09mkr94AmhTjSji4SYOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NyCDXYdBnrMqk9V1C4QkiFtKwQWw89sw1kqeb67hfRerPHzVqbMgW46cBVrP+s42H1aXGXixL4OOKtvT0hFpHdM9dzsz4UYIe81ZRyX8dOZVmCSputwRllbqxCqLBwnbGKFkzquTrgN77uwZVlHIzCDNQhzgMSbkuaja6aRwhos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=amZnZW4W; arc=fail smtp.client-ip=52.103.12.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="amZnZW4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNAkqezekSRSli6oO0oavCz9jXEqdBx38CiDhun19Y4JvLr2FoTAnOaUteSpsgaVT7BEVaih2fVM1B4tCOV4Rf+4fSw1zYsgVx+kRvZXvPznoT7M/PYtv621L8fqBpx+nHoKDJDtEkgZLSzdQA+TXe2hs4B3FmRbw3pbWxrH+lULCYSRVhAOUi4ZSdKidf2kgfYCWiHec/nUn9+gI9r80WpcqLrFeox+OnlNmA3TtuuY4BpW1zjYGI0zXvQwbGWnMCgV+V88PDQJLfTIGqQSIiWyFS7ey0xX8ezkzmDNrPvB7dNnxdVioLbsyYml75EqtDltn9kbuDgQOWxVQ8NHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hODX/1g+2M5L8Qy5dsOIFhLlcOF7kuBiS4eX8kz+11A=;
 b=jgmQU/fADKDuE0enFJ7ziNMaqkWPVWcf9rR8seCsqhD36iVkl69Ek56DibDtaV9zOR6BGkWtrFeF6HFXdZe+3fjIqnFQZmGC3PFrBMLN9nUTw7IDMvtp+IAmWn7kdvkGroHopyLM+OIx4SP58+BlYJRz8trjcT3MwRvX9pQT+JG32cl8sXQP7DXaOrC7SQcEwJzUkcrSNouUhw0p4QYiQmWpcui8QKronkkA9F6Yemx6FgtwvfU039aCzIo9QPdJSiR/h0VCO834d0CVQD1LzhrsHQLwzuN8noNNsGt4cH/p0S0D90/SQQ34l0td5s9AjS7/9FUlm4fDFXIVbHY5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hODX/1g+2M5L8Qy5dsOIFhLlcOF7kuBiS4eX8kz+11A=;
 b=amZnZW4WdYunQyG6pp6aDgZeMYLNSoC6g6dclE+InQyff/GJKmh3bs/VIp9nNgfRxANEC0QF2xGoHMaDf6ISXY3rieTpBaDngn5O03cq6Bj8V6Hc0qeI1FKqnqWy+DKqIaGVXMJ3ZW1eBQEvKTbi7jlmKU4BCoqU+iKbrf/5ZRfe1sz/bQKuhQ+cWB+IKgqzSEtHVc/HwrdhEx1luyNJ6rEjJGaxJohyxlzGyJLSE1msFbGaW4koVpn0itG4Z9XjPOhumNrtWYkeB2dCThHYzN8IkiPD9Al9hiwfvYEIUEdAfALUS+SjLUATu/MOgGg62Q0xoJUmOnKcyqKiHrdmtg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6777.namprd02.prod.outlook.com (2603:10b6:5:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:27:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:27:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Topic: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Index: AQHdKaksqYpZxqDILkSMgywEvhwx/radsJ0QgARk7ICAAHKEAA==
Date: Mon, 17 Aug 2026 17:27:34 +0000
Message-ID:
 <SN6PR02MB4157D48F243A3EA8C94C412ED4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
 <BN7PR02MB4148C2319B12C57B1FA3885ED4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
 <uvvdhtxzqkwbb7ur4pybseocn3c4erk4gbis7yll4cvgusjzke@n2lbeyn532w2>
In-Reply-To: <uvvdhtxzqkwbb7ur4pybseocn3c4erk4gbis7yll4cvgusjzke@n2lbeyn532w2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6777:EE_
x-ms-office365-filtering-correlation-id: a31a3b31-3176-447a-c4e5-08defc84d342
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|51005399006|31061999003|55001999006|24021099003|13091999003|8060799015|8062599012|19110799012|37011999003|41001999006|25010399006|40105399003|2607281247196008|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0ecCefjhPp0uJfXoUoYqioQgztg+OGpcvZodrrAhfQ2oV5kBNHjGIwMMysLn?=
 =?us-ascii?Q?HnnsJKW850o8gTrjMlzgYfEIzTQDVlgQTcOmT6lRilaW0wB7hgl32vVjNfoc?=
 =?us-ascii?Q?GGmf0ldwCLSv8v6W41+X0Ta1XrtO3tDihmACeeA+MR4alcFft881OPOkKqmV?=
 =?us-ascii?Q?2VF/NQV3EhiJUWxAwI/U4VbuHZBTaQ9ykRA3ZO0z+UHMLTCSktQDkxzSXeC2?=
 =?us-ascii?Q?IqZCi3XjsKVgxmtdTvNNdTMTK0W2VC5aeVAn4/7CZUMyT679XWFutntfuLD3?=
 =?us-ascii?Q?q9//zsXGGjLlynihBlGzCwXOyCQUbT12wODbDWiT6jPT0TCp2Ir5ivc5iMzc?=
 =?us-ascii?Q?raHmJP62ryQTxo0VfglfFqM4LgpzOg/oeZVuN3J8Kj8AnBS+AWoZKPqk3tF0?=
 =?us-ascii?Q?cV+Wn8/IsXV/b3RHOIFn+B7ztkvThNU3Mh6irCPLBZDNPoPc+flyyy9scjKc?=
 =?us-ascii?Q?WjVVPUG78P3juYT5zw54cEdGd1Q2U+WCuIFZUECl24E607Zl8VUUDnUHTgz/?=
 =?us-ascii?Q?JtW64YhsZFHUItDCeIkvKi0dpaWUKBwoITxpCfeUU5qKRMnu+gJ5MAjHFOzn?=
 =?us-ascii?Q?Ej9pvOYlXbZyl2rmd0Ph0LTIt1lo25O/MmaxBnzU0oWLMqRyVvDLMplq728T?=
 =?us-ascii?Q?Qc0kVr3zKxUqoOtu/aVZMzGKJc5eqvAQ3i9R8dJNNbWgPTBgYCLuJkPyUbLF?=
 =?us-ascii?Q?svGu+vJhznTVYdp6VqrOdFZ+//8mmLK1dQnE1td+5aJrt4j+15mfFuRNWB3R?=
 =?us-ascii?Q?mOkeVXDy2tEw8dAk/Id6QkJYJzkw4/IO8ugwim7IqCOlClEo6vyZr6kX0O9X?=
 =?us-ascii?Q?eF2I6l6KCyQkuvpPnc1ljIkXuMjLVO4jIeMayXSu5QJk4m5zRAxuJqN9J7kN?=
 =?us-ascii?Q?luaYLBvhybE2SW+E0kQdLIPVM2YB24NDnFYylt5VW/qBtIw3YQWBcmofKSDU?=
 =?us-ascii?Q?0CWnOGvM1xnlN6TFubbwrH0jqOpQQUH0Ad7fo2O8wO+MEHAxJv/ls3H36pqY?=
 =?us-ascii?Q?chs1zbjwIKgRyPx2F5A5QdwMMSBvcAYzbNKY51Xfd5N2EaLPrB/JENluLSmk?=
 =?us-ascii?Q?aC3ZiGZ3Djk1QKsUBR62+bKW2mz2dEyct8cTlgQHDhuhYVzKzSQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PgP4qoyeaU0XFoE3SnBN7U0JhCFz4WXSRQOSTtbBUf+0b25YxozyH0MB9qxX?=
 =?us-ascii?Q?3rfBlrhnrh53UliXQISvpalJFUmWdQu2uDKy+atBlXUkaLMh8cEY2ccnRzXP?=
 =?us-ascii?Q?4R7BbGtc7TzyqGmw5mpdYth4+9QiUvsY1G61gN7RMOPvpX9aMTPKIgVtgEbj?=
 =?us-ascii?Q?XbCXV4S3VoVYCI2/D6HMmt0cnSo/6XkTEO7KvzZaEWAZmO6pEesNwLlpTmh+?=
 =?us-ascii?Q?ow3IOpQjVENdPrYmBOTy2i5pNVGmE54BvXYenqgVK063UZ9QYOXPPQfEhSDm?=
 =?us-ascii?Q?lmjeyBmKSzH6MAIIdN6SJeTSxmHp9XH/jpFtqt+NhLzvlU3nf3yKexXL/L09?=
 =?us-ascii?Q?R2xeYA+PPOEWv071UIg3A6nRVitEfBou8rq3eLM7gWNh/YedMMX86J3FyGlq?=
 =?us-ascii?Q?HUekcAwxuuC5llQ+cVsrx5hr8CE0UtS9ubEcLTLpBv4eaWtNiXBpGijHquaP?=
 =?us-ascii?Q?uRiyIEpI61J0fP9tDv5rAD3PZsSZuVty/vL0IuyPy1nTPeYF8Pzp+HjxJj04?=
 =?us-ascii?Q?Izofkj7ZnGMh4iqNaSTwjFOTn8787BgcjElnHr93QHaszuVw4PHMlA9CPTR0?=
 =?us-ascii?Q?vMsCsjMgQoTmDgdjmIGtrd4C6mQVlGQd6Y6xYtIanjdWBjH9TiS5SqJ8pKNz?=
 =?us-ascii?Q?B6GaEysGlu+vZjGQgIuYu8a6NjBHzt4JxtdmWDz+VAJfKZ/E8vEuCMiGq4IR?=
 =?us-ascii?Q?wXM2JdeYiwTucQgiNG7bVHPQ7JKG0q5y2asPAVqiAYnYfOrb9Rqkdf68Zguq?=
 =?us-ascii?Q?lV1ZvuWsMG2YN5qcF+HT8ok4qpvDchTIKVwtR2AVQtlgoIJbS37sdfa4VVcE?=
 =?us-ascii?Q?8UUaAdsmfLLLs3Rs7PSzS+ddAKbOG1FfHx6gzBVIdJChehIqeV2S0Z3cQ37o?=
 =?us-ascii?Q?gqJoK1ttTlNGoe5etwPXlKm2/W7Zm2QbpR2aU9VTF8tGRJ5ydjHCRRThssdQ?=
 =?us-ascii?Q?TGwq5siv4RWbZ0coD6bH7aO5cCUN9t6bDb/zv5QEwmvoubHa+avaT3/uCCXV?=
 =?us-ascii?Q?4zalhuLqrdeAd2rX7TMMpP3rABVzS8IZoO3geOexBiCZISoE4appFhEyMzX6?=
 =?us-ascii?Q?PNAf0lxjOppOeeSq+7/pdiJGYAfkx4DuBRKDOsIHbnPYoyYttIlpPRX4Suv9?=
 =?us-ascii?Q?7MjAUg4Wj1D8SNm2pPDW9csfs1oDQXO8eFkFvReo7tHTcd1vmGk0DZQiUVAK?=
 =?us-ascii?Q?0e0mrBP9vRZyAY0tAwQP7Pb8Doqnlnpr38klm2+ybDJwB8ECV3s2fVlCtVgx?=
 =?us-ascii?Q?aJQwPBt3BF/BC8mJN3bvx1zC+yw+ZHwgbCSoELM6PTLOTdIRLNh2EIGVptrB?=
 =?us-ascii?Q?rOeBYdnFr/3crW7Ap4lq1PWmkCAElFFpWT/oR2ZPCSnZsGCZHdAGlQ+Tzv1a?=
 =?us-ascii?Q?Qq9A2RE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a3b31-3176-447a-c4e5-08defc84d342
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 17:27:34.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6777

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, August 17, 2026=
 3:38 AM
>=20
> On Fri, Aug 14, 2026 at 03:31:27PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11,=
 2026 8:50 AM
> > >

[snip]

> > > +#ifdef CONFIG_HYPERV_PVIOMMU
> >
> > Making this code in hv_common.c conditional on HYPERV_PVIOMMU
> > assumes that the only consumer is the pvIOMMU driver. But my
> > understanding is that root partition code is also expected to be a
> > consumer, and I would guess that code is independent of a guest
> > pvIOMMU. So the #ifdef might need to become more complicated
> > to also allow the root partition case. I'm thinking it makes sense to
> > always build this code as part of hv_common.c. Even when building
> > for a guest only with no root partition code, HYPERV_PVIOMMU
> > defaults to HYPERV so the pvIOMMU driver will be built anytime
> > Hyper-V code is included, unless someone goes out of their way to
> > disable it. Getting rid of all the #ifdef'ery would make the code a bit
> > cleaner, and I'm looking for an excuse to do so!
> >
> > I'd also note that CONFIG_HYPERV_PVIOMMU isn't defined
> > until Patch 4 of this series. This patch will still build without the
> > remaining patches, so bisect isn't broken, but it would be with
> > the equivalent of CONFIG_HYPERV_PVIOMMU=3Dn. It's a little bit
> > weird to be using a CONFIG_* value before it is created, but maybe
> > the ordering among the patches is complex and not easily sorted.
> >
>=20
> Thank you, Michael!
>=20
> That makes sense. The trade-off is that a Hyper-V guest without
> pvIOMMU support will still allocate and populate the registry for
> its PCI buses. If that small overhead is acceptable, building it
> unconditionally does make the design simpler. And we do not need
> to worry about the chicken-and-egg problem when ordering this patch
> and patch 4. :)

To me, the small overhead is acceptable. vPCI add/remove
operations are relatively infrequent, and are not a "fast" path. So
the overhead is of no real consequence.

[snip]

> >
> > The comment above is written as if the pvIOMMU driver is the only
> > consumer, which isn't accurate assuming the root partition use case
> > materializes as expected.  And that also means having "iommu" in the
> > function name is overly specific. Same with the other function names
> > with "iommu".  There's really nothing here that is specific to pvIOMMUs=
.
> >
>=20
> Agreed. Will update the comment.
>=20
> For the function names, I would like to avoid using sth. like
> hv_register_pci_bus() since that sounds like to register the
> PCI bus itself. Two options I'm having in mind are:
>=20
> 	hv_pci_busdata_register()
> 	hv_pci_busdata_unregister()
> 	hv_pci_busdata_lookup()
>=20
> or some more descriptive yet legthy ones, e.g.,
>=20
> 	hv_pci_bus_register_logical_dev_id_prefix()
> 	hv_pci_bus_unregister_logical_dev_id_prefix()
> 	hv_pci_bus_lookup_logical_dev_id_prefix()
>=20
> Do you have a preference, or any suggestion?

Or maybe just hv_pci_register_dev_id()? To me, it's
better to put the verb ("register") first followed by the
object. "logical_dev_id_prefix" as the object is a bit
too wordy for my preference.  Just "dev_id" or "busdata"
is better, even if neither is fully precise.

[snip]

>=20
> > Separately, it seems like the existing calls from the Hyper-V vPCI driv=
er should
> > never duplicate an existing mapping. Your code disallows mapping a doma=
in_nr
> > to a different logical_dev_id_prefix, but silently allows entering a ma=
pping
> > that already exists as an exact match. I wonder if that really should b=
e
> > allowed, as it seems likely such would be followed later by twice remov=
ing
> > the duplicate entry, with the second removal failing. Removing a non-ex=
istent
> > entry is also silently allowed in the unregister function below, with t=
he same
> > question as to whether that should be allowed.
> >
>=20
> Actually, I don't think an exact duplicate registration is a valid case
> either. So how about we use WARN_ONCE() and return -EEXIST when an entry
> for the PCI domain is already registered(regardless it is a exact match
> or not)?
>=20
> And for unregister, how about we initialize the result to -ENOENT, do the
> removal if lookup finds the entry, and WARN_ONCE if no entry is really
> removed?

Works for me.

>=20
> > > +}
> > > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> >
> > This may be overly restrictive if the root partition use case code is i=
n the
> > mshv_root module.
> >
>=20
> Well, I'm not sure. IMHO, the register/unregister side is owned by
> pci-hyperv, which creates and removes the Hyper-V PCI bus. The guest
> pvIOMMU or the root driver are only cumsumers of the  lookup.
>=20
> So maybe the register/unregister exports should remain restricted to
> pci-hyperv, and if a future module needs the lookup helper, an export
> can be added for the lookup helper by then (we do not need to export
> lookup right now for pvIOMMU, which is built-in)?
>=20
> Am I missing anything?

You are correct and didn't miss anything. I didn't fully think it through,
so my comment is bogus. What you propose is fine.

Michael
