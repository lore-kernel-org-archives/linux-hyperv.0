Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1771A682C;
	Thu,  1 Oct 2026 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831419; cv=fail; b=kD9m8BWZYa4i56nWmvZJQDSSiJel5iymEn8fg2Mp3r9bEve4NjwpUt1KdWZZvNqgpG7mejt7aKPe2gwP7sCl4sbNyhdNK2m2gKjA25lLqQ55Snp1jBDyn2yBrY5wRJ421RV8FfhAMpgd6/Y36ooWZaF6Xr4QQOO465RtcDn/MSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831419; c=relaxed/simple;
	bh=Wn+dPvTcazi3F9zP7ddyP8f1l1C9YuEi+By8wg4TmDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stomni6jlHmjvjFTwmkLzHGqn0Qv0wgTwCWOZowweTHTZ2SrKWKkVVJrnFdK6ZbnI0yM+IK1xtu9+3BZ0u//Fx/q74RkFIlG6HI6FGdeFL9CWz/473JsszvyI9u2qidH07xmPPnXfJ0Ca6Y4ms0C0MUhU3tEwWkftOLoe3uFKS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rak6ZIJL; arc=fail smtp.client-ip=52.103.14.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rak6ZIJL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkNUbUkMDYcYhpdgJau6Ld+Vr+gHDdHqjm55tYScED/bU5QqlittD6NLF3KPX5rR5CjRrDJT6xNexkecw2ng1jF4dy/0meDZUywtNISpAR6InqbSouWFjLaD4mHN/sV773cwpRsu3gEmAWcdk6Zsk6ghNGttbmn5srHTQWzDkYmRioG8P1FP4E5YQ0Dhq3biXj0KVaD1JNeOZzItkISyswOM4KcuQ40hn6heontL7CSl8XbxRdPrqkpzmzrl5+TeJUZUBSKAScTITBC8EJQ/XstYFHbC1PSDaWm0jPW2ZH31SMGemH/iTepBoTqRdhXCzD6FwygJTy00ZsyJF5ZIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1NccQG0Xsl1bRnCX4hKZszrdpHkX9k9aQPoSpAQABY=;
 b=aa1x0LWRHEQYEwxkT6x1gcoFYotS1u4eGNtkFwp4VBo4QY/EwZBb1bv3NvovqKoxf9ICg2+AFx092xLRRvMOgi/1QZeLsUJ9SbK28ui9aO6dxrxIcKx5r17DAE7ktpUvpjliWFJssntfTFX7Qe7wEnpyAD9W3aG5a8Zg4/RX4jZbMJQ4EsA+kmmWup9HuqaPENIHEZxJDFGix+GqNvtnhKdSiZ0KxsFb2E1BY2/6MXGSUiKeBZO7L4ZkyviRySFPwErYef03VUOzxNZXQ1mKZVSvm4HTJAf2IU3xZ9gCL8YoyyYuK83Cmx54UYnnKVRwU/28ZfCpE9jJGRgquPHx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1NccQG0Xsl1bRnCX4hKZszrdpHkX9k9aQPoSpAQABY=;
 b=rak6ZIJL1ET7MAniKS9zfUWWG60H/w7MimpkragFaLUw4OM3mzv1jn+BOLtUdywQFrnCz/1HJh/sBmjMVinAetfgqUSi74n8Stnbnpnuv+nTY8/q6N3PxrbTXFNIEY+r9FBcHBNLwYj3up9HFlQERrQkvwz70aaJR9RdLPh2m7Tp63geFgp06P38gmYQ8mj2HpC1aUbHXTCarr801hqfibVLgmHkkUVg37gzRSrcpUcJkSYS+9+HygwCfKRTRhCkapZ3TV1wT2r1q35HBnglx0BldRHCXv0PKUqkGGGKduPus2PlzlLCf8qdqDk9EWknYPF8rvw7yAJ+LkzD/WX9fQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH4PPFC5445FEF5.namprd02.prod.outlook.com (2603:10b6:518:1::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 05:10:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.024; Thu, 1 Oct 2026
 05:10:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Souradeep Chakrabarti
	<schakrabarti@microsoft.com>, Wei Liu <liuwe@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Magnus Kulke
	<magnuskulke@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Anirudh
 Rayabharam <Anirudh.Rayabharam@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei Liu
	<wei.liu@kernel.org>
Subject: RE: [PATCH v3] drivers/hv: remove deposited pages from direct map
Thread-Topic: [PATCH v3] drivers/hv: remove deposited pages from direct map
Thread-Index: AQLz71Eyvxq2Lmz/5rMEBoasASibobSyIA5AgAegTgCAASc9wA==
Date: Thu, 1 Oct 2026 05:10:14 +0000
Message-ID:
 <SN6PR02MB41576BE36A94FC74D3C4687ED48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <SN6PR02MB4157B2D3C47289305C6E487CD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
 <arzzghes/vN/1WSf@example.com>
In-Reply-To: <arzzghes/vN/1WSf@example.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH4PPFC5445FEF5:EE_
x-ms-office365-filtering-correlation-id: 374d2903-4a93-4703-b311-08df1f7a46f3
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|31061999003|41001999006|8060799015|24021099003|25010399006|19110799012|12121999013|8062599012|55001999006|37011999003|51005399006|4302099013|3412199025|440099028|102099032|1602099012|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IqwmfZR4MqasPyly+V6D6W86Hm1M5sWDdPwrwJLkQWeX7iTjRcZYwolB87nH?=
 =?us-ascii?Q?65+qvbwMjRov1bEe9p7mH+Vjlmrb/OB0UhISuLVfzYygjFI2hgXkb/Kv5Tds?=
 =?us-ascii?Q?WoPm4Vngbdu9EVERT/EkZDpJdsmk+M23Sk0V4S7n2PSUYzV+gTbl3cSwgAhz?=
 =?us-ascii?Q?KOaQup+VxVdpsgx6VP0F2f9IRdqUYdNs8aeqXyN7Bk5j58mgcNjOq955Zl+v?=
 =?us-ascii?Q?lBTWupQ6BqoCXyX4EVmIXYDS+0gB3o3E3jtmVs+9l53yHIL2zkzFhKdFPdls?=
 =?us-ascii?Q?GCOYigjqL3wNBSGXpGueNM+l6+HvCq0qUdANhGLSwjjzxl/uJOVUvwyItDTh?=
 =?us-ascii?Q?31QGVEExwyHucUYpnrQqwpBRx2K5cZ2jPA+B59WypjzX0f0E4mixyqtGEJpI?=
 =?us-ascii?Q?6WWy1oh+c/fnCV6lnL826ykJmiP5P7mbROesQhwPjwK0Ph8QGq8RDYwzwbzA?=
 =?us-ascii?Q?ncF6rxphkOByvF829W4n86jpSSwHBiX2TnwwXc9YzBG4HSKjbig9uffUInFD?=
 =?us-ascii?Q?EJnSu8fT8Htzy3HDhY0suAEr+fpMruRJRqUhLm/ulwvxRQWvs8cmAbPAk6lJ?=
 =?us-ascii?Q?HrYGM5nBIQc6AY9kaxBTdLVXwAa0ocy9o/62t8IhG5Pz60M8/anV4qgAIFZ7?=
 =?us-ascii?Q?++JaoZVzIcuwCoM98EMwVmgKA9kIepbHlIFyl/OBwoSeE+iKvfGCZaeyz85X?=
 =?us-ascii?Q?6JrtcGkhDp89/c57XoG6cs8TPKixiHEx1cWbA6XwrXkxXTkQjnBFkBvD90bc?=
 =?us-ascii?Q?OVCwl2qnx79rY7yUTFZam5KX3LAyYpuQHDpeJI8WhoTHXSwtxUWEpA2lLW8S?=
 =?us-ascii?Q?iAK3hnOBSkUEQWH/hGeDR0p6yiF51zsNhm4usz5J5q3xGr9M63dtXG8wkP2g?=
 =?us-ascii?Q?UkdF0ZS4O2myHc5gf3AxiRSBlShHf/2arDvimQSd8Y/2lQChaUsCXxFI8bhN?=
 =?us-ascii?Q?7sZbcXCULvbjQl1diUysmR5mqtsTnIARc7lo8RuxOePMl8mqGXc+z3unV8Mh?=
 =?us-ascii?Q?c+pRG+aKMMzIY0H6dgRcZlKdUF4uWJA/OPs3cqVW8ksbb5Jtkl1KPYnCvS0N?=
 =?us-ascii?Q?GiTqP5OfxUfSafEiNmS4bKPL9YpCUp7XNYqY7UYLg/raBYjYjjlxObAu8VaL?=
 =?us-ascii?Q?hQ+RYuVE3UfS5/rVhKisVgQ8CgHzwQq6jle71bVK+hDNTnQcpc1Aoifn4yzI?=
 =?us-ascii?Q?UQvCKGvr5qGZCv3J?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oIYS27iAx6gwogPtMEBjgZ8t/xbfYox+wUElu1F2ae6TSrcqaHBLgDoh21pg?=
 =?us-ascii?Q?vLnr9JDB1FWJq3dMrsvu0cXbuM6cr3jKi3s+kFJKMytJ09KIXHlsyk3/FVnK?=
 =?us-ascii?Q?vtGCamdnlmOpU+rXcgFNj5p3uFpFPceQssFAfGTYiaFDLuFbnL1ENUX2EMS4?=
 =?us-ascii?Q?hiU1aJmOEGpX8Q7xx4rGMhx42u7k+4B+De11Mu2DaH7OibqEH+KtJvzDMRia?=
 =?us-ascii?Q?CWRFZyQVCS7KR3IdmwO6K795/FWH3O6+cqIA/i+lcVL2PMOQ18RhEsDHKxjY?=
 =?us-ascii?Q?+TaxNBIJJ6D2+sW2tS6kBIkHWkUXdfvSeBzKenYZXyKhTRLqOtdUfXqIb4tb?=
 =?us-ascii?Q?wjjXTmajc972goumTk69Hje0Kuuck0SUfevNmk1cvAePkqUPqEPW0omBIEaD?=
 =?us-ascii?Q?ucHu6iX2yflLz4BHH9WyanrUitUnsqt0amkJHbeXNyFzrIC1g7x5PcjHkehp?=
 =?us-ascii?Q?Mb+qy1OMoCRRt2hQkuoZ7oKsOX6BfesTMHX7jwCl69gmhxAxf70WeMfh+E/2?=
 =?us-ascii?Q?Dyk1J1QeS62Iv39kVMj9GCFOsu6u2jeQ8BSjGUmiWtuv7R7Wa4AnF1HcFENH?=
 =?us-ascii?Q?nLxZmQm7iBhS6w5GN3r3stdvxf0CUMLKE1GHD+BWX5UeEf0Yhnh0A2moZ9St?=
 =?us-ascii?Q?xkQGMvfelcyz+h8UwJMneA33RzjwC6R5kLX53Ko6HI98uy/ELUB9QLE6kKCC?=
 =?us-ascii?Q?YvNEFUZNObOE5KHqcznmRymZnPtQhDCo3qD1Tr/14xe7D/YqLTnqfthF7yX4?=
 =?us-ascii?Q?vASG9LXB1Nv1wLL5afWbGDP8n7Gfgr4ZXE2RMLR9LPdLJzJ6WUqW66kyW8ND?=
 =?us-ascii?Q?LuJNeIRTiNqvfSkkhDNsfWLBN8wZVYc0+9zvZCq317MI/Xhr1r4eEUL1QkVi?=
 =?us-ascii?Q?yG9G4kDPsfgivE2crk9KTFsOPl9kNIz5oudOY3wUSN5pYg60usYEXV5z48lH?=
 =?us-ascii?Q?m0ESMZnUf180LfVx+ZpBCclMcn4X6MpzVqW2Zbt+gg8qxPJK2GIX77vBLS9J?=
 =?us-ascii?Q?9qqk8Npu0rdFeDcvT+4LRjO2JYmdX9epHn4jaLHR090mf8+bJ3/uxzMhVC/F?=
 =?us-ascii?Q?otBtAUgTM3h12DlMz6N9aG5f2osKxU9p5ZdWm4GZzLV9pWgBnwKsnUFTkV36?=
 =?us-ascii?Q?+EoqEwB6AYTJHVmZIiMeld1VHdJfdETWVEX1WV+1cNAcbwppGiELQAXKvRkL?=
 =?us-ascii?Q?wsykvqW/7aakXx3pMoA72y8dDxVapp7fV0eRJ84B6H2Ad9rQWK9IjUNntnMB?=
 =?us-ascii?Q?R6kgfSGLV0FtsqlBuv+rJNsOhPiEbJBM9ogR8QWdctTKoNPjQr1aALe09keA?=
 =?us-ascii?Q?6yyVXK0+Whol50ITLLGYVseweEH2kUDsT1VqqTah4koJaTW60RJx5Le5+OX/?=
 =?us-ascii?Q?opH6SV0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d2903-4a93-4703-b311-08df1f7a46f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:10:14.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPFC5445FEF5

From: Magnus Kulke <magnuskulke@linux.microsoft.com> Sent: Wednesday, Septe=
mber 30, 2026 4:33 AM
>=20
> On Fri, Sep 25, 2026 at 04:23:15PM +0000, Michael Kelley wrote:
> > From: Magnus Kulke <magnuskulke@linux.microsoft.com> Sent: Thursday, Se=
ptember 17, 2026 1:11 PM
> > >
> > > hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> > > guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> > > ownership of those pages and per contract revokes root partition
> > > access to them, raising a #GP on access from the L1VH root partition.
> > >
> > > However, the pages remain mapped in the kernel direct map, so kernel
> > > code may still access them even though the hypervisor has revoked
> > > access.
> > >
> > > Helpers such as "load_unaligned_zeropad()" deliberately read past the
> > > end of a buffer and across page boundaries. A read into an unmapped
> > > page is tolerated and triggers a #PF, for which the kernel executed
> >
> > s/executed/executes/
>=20
> ack
>=20
> >
> > > a fixup in the exception table.
> > >
> > > If such a call steps into a page that has been deposited, the access
> > > raises a #GP by the hypervisor from which the above handler cannot
> > > recover and the kernel panics:
> > >
> > >   Oops: general protection fault, maybe for address 0xff1100941a3dfff=
c
> > >   RIP: 0010:csum_partial+0xe5/0x110
> >
> > Is there any possibility of updating the load_unaligned_zeropad() fixup
> > handler to handle the #GP like #PF? I had looked at a variant of this
> > problem a few years back for CoCo VMs. See the code comment above
> > hv_vtom_clear_present(). In that case, a smarter load_unaligned_zeropad=
()
> > fixup handler wasn't an option because these were #VC or #VE exceptions
> > routed to the paravisor instead of the main Linux guest. But in your ca=
se,
> > the Linux gets the #GP, so I wondered if a smarter fixup handler would =
be
> > possible. Of course, both the x86 and arm64 versions would need updates=
.
> >
>=20
> I wouldn't rule it out, but I found it daunting. We don't have a proper
> faulting address ("maybe for address"). AFAIU, for a #PF the CR2 is
> populated with the actual faulting address, so the fixup handler knows
> that it is within the trailing bytes. For a #GP this page is hardcored
> to 0, so we would have to have another sourcefor the actual fault
> address.
>=20

I went back and refreshed my memory on the discussion from July
2023. At least on x86, the faulting address is used only as a sanity
check in ex_handler_zeropad(). The #GP exception handler already
calls fixup_exception(), but it calls with fault_addr set to zero, so
ex_handler_zeropad() always returns false (i.e., it says it can't do the
fixup). From looking at the code, it appears the deposited pages case
would "just work" if the sanity test against fault_addr was removed in
ex_handler_zeropad(). There was a past discussion about removing
the sanity test [1], but at the time there wasn't a strong reason for
or against, so it was left in (having been added relatively recently in
c4e34dd99f2e). An option for the deposited pages problem would
be to make the case now for removing the sanity test.

I haven't looked at the situation on arm64.

It's your call on how to proceed -- I just wanted to make sure the
full context is available to you.

Michael

[1] https://lore.kernel.org/lkml/CAHk-=3Dwipev18s9sErt+iNO_rzgyvGTce38fr1CY=
O0U_hGVGy2Q@mail.gmail.com/
