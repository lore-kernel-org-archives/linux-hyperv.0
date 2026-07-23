Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011033.outbound.protection.outlook.com [52.103.13.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411137F327;
	Thu, 23 Jul 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823839; cv=fail; b=HsiCdi2IVpJ3acxB+4mqy9VHrfNZwWdP25l/Y+qVIo2PZkON9Wv1E3EuF96FLW1zFXm6g6n2VbYtV4429bM6KrfsaZ9X0JB2LaHAs7QMx5TDVtV2Rtg3JROkzQZTUjvNWYMOOi5QXSj1cal0iL5ADB3BSZFgJW4go2unH+sZE9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823839; c=relaxed/simple;
	bh=yvncTsiSCJaQQ05PweFrZSA/vO+m7LTeLm6FlU/GJqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhzQDPU5GnHsXq0T6qS9tq4VwXMiaPolgmTDuUG/1CI9i5n5zOt1pMxElsbUwIWBhdjvuZr0gHE3i0aHuUtQbnBk7z4hKVmwvol+Rp0jX4vEk9iSAofEXJ28IxwFoqxJov8OXDmTvhUvMfPdvYSyvzTHrQ82ebXdtTfrwMWFjkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n/Srp5jc; arc=fail smtp.client-ip=52.103.13.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n/Srp5jc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPBs0xE/Y3SFte2UeCShhswR4mZ8pj24cIKVv3kqcFIbR0y2AMs45oglL1INODLfOie/FCL53X00ImPtaD0QkkFaJOsUOcYJxytJFGDgmW/TCqxOcb6EsZ9y/1WOU3Ds3j/ZhDUuBOvoPv+Tf+sXp+F7RGzFOloZ3/bNIVhFynNH5uqycbOS11nyXKn43ov+bR8ueg7vVQKeP0EyQArq8oPKeOTurfmDFX3N+nPCzDwGUeEop7iOn5jjwPFlc1lxaQq3C+oGLpbO+zaSm1eNbYf26h02MuhT8tars9IyxyVO4aywaQ2tvydTCgyN/im4OL2znZVkcG1M8sJBY4J5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvncTsiSCJaQQ05PweFrZSA/vO+m7LTeLm6FlU/GJqQ=;
 b=GWy5c6KuscaaK/sLIWuYX12B/zefjzDfRoc1RKuH6bfnU3bJr2j7Z8BsPC4p8gF6skvN6jqnUF+PTxfhALQ//Bua9h4/FMNpiipPKUjK2BTCfIhDVE9/UImwJylpyMaP5syT/QKryd6kWYCnw/SrQaoD0/YE69REuWy9VJ2xQ/jl7VcECKtHRbJiCzmJec1v3BTOm2b5Uf4zpMIxni6x9dXnq4MKj3JvDaTF7MzWdks3EksGG/ExDcvHh6jUyTDj1jfiCAVg7yWc+W0KO/IOvmDIfx5+YlRI8xm59GRtOO/WpciaNhlwI37hR7hKwa76e1rb3J8K6QcilGS2Uzdt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvncTsiSCJaQQ05PweFrZSA/vO+m7LTeLm6FlU/GJqQ=;
 b=n/Srp5jc9MzN8ZX+coONX4ya3nO3hFnxZLalipcohaWSmSpuAf2aWUynNIl+TzxsoiAq7wmM10XqLL7IY3nwQIvhS/qAG7cwFb1nPkKi5fGCJmEyrPZpIzZmSbgzUW1FknLWgILi8yjR0fXtEBL3iUbAuiQXvI6021pj9zb0NSp/EK1tUSpDSBdkQPtk9m60DQUt4IDM/i5XFDksEqxqf+gVCHF50dLQCYxL9d54OaRfvUWDStGjnI2gNpZ5L+TVy5A1/GYWfG2JLjWufH2zK3P2nZks+9Y3IkfANJpKOXUVRgxl9uDYdaRcXMer4CFNg90nYKitDCHSeDc/1T2Wuw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BY5PR02MB6610.namprd02.prod.outlook.com (2603:10b6:a03:200::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:23:52 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 16:23:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Topic: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Index: AQHdBMj4p7vUSbVMmE+fvPgM94V6W7ZPn6qAgAEPDwCAAEG8oIAnh7CAgAL9kPA=
Date: Thu, 23 Jul 2026 16:23:51 +0000
Message-ID:
 <BN7PR02MB41489FBBCE1D761420F4E139D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
 <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com>
 <SN6PR02MB41571AB004406F331E167203D4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000c01dd1940$e3e267d0$aba73770$@linux.microsoft.com>
In-Reply-To: <000c01dd1940$e3e267d0$aba73770$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BY5PR02MB6610:EE_
x-ms-office365-filtering-correlation-id: 27308c6f-7e01-48b7-55dc-08dee8d6c8a3
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|24021099003|8062599012|13091999003|8060799015|55001999006|19110799012|51005399006|25010399006|37011999003|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?awAFc4xloHClHL/roCt09mJgQRGYX83eEOSvxmUb0aHTe23ROzQ73S7uW2T+?=
 =?us-ascii?Q?IYXu212naXgIZR1EM63XB9HtK9eXlVKWWskfnMyyommfp1ghgGZioFdxXWHB?=
 =?us-ascii?Q?zELpQUhNpB8BbctLwLZ51iWrS7uU010TFU8WCgUuum1jZFMVPsIm2js40drr?=
 =?us-ascii?Q?vaMakEkh6u5kx/kz35M2Y9mz9eR+fQYUhmc+8tYlesyP7wolKNIhjA6mJZWS?=
 =?us-ascii?Q?fA84vlILM/IPlLBUtldOwW/9Pk20fYYRLTizTqC69iy+L5u16Zzp085QQTAN?=
 =?us-ascii?Q?L8i1gU2HJt6BZshZf2i6Ul3c++547vCOzNGY9jm3o1P8y5WODjPMWVQ+JZU0?=
 =?us-ascii?Q?r9F8vwxf1C1uXnA/UBqvdh1wITBhpt5vwrbAi68+naE2ulJhxrnisgqOW+7c?=
 =?us-ascii?Q?xtPV3t5APNJLPRht40uxIPnTQk0utmJZM75BICVoqe8aAOIylqrggQTqkyhJ?=
 =?us-ascii?Q?blkVIZ+ODcMu6AhJxTxvK6kqk/QyfmMrEHpg+DH4vl+2Ubaz7ikl2FW0u1zs?=
 =?us-ascii?Q?bczE4wTb4GVosxCOQx14yQrkgmAkTA5C8SobaS49LXGDIUXzJqSTCZ1fg1oQ?=
 =?us-ascii?Q?YKGhjsJZlclj69VLMZcZzCRR5lU3cwaCc6HOcNZ1ASrdYuaQ+e2v3aVSITMb?=
 =?us-ascii?Q?OOdheKgTrw2KMA5juAnf3o8PcYaR0dO7uydRwmx2xrM7LrWT2vz4kRPX8+6U?=
 =?us-ascii?Q?FsYq4zj7CJVhHxauLQJk3GbGJ5p7o2RsLkmvjROBgj3AFgribmmJhzJjIW08?=
 =?us-ascii?Q?DfMENSxYbk5SYCutm6L8zT4bzKZXIV+uF5nHX16yExG7koZRJc+osNF7Uz70?=
 =?us-ascii?Q?2f4kQzueaXnKr2YA2eJ49WJ2GRAL+XX+9XkaD/Ux9yKOsntGjX2p2/GMbr7U?=
 =?us-ascii?Q?k9bvWg0W83LlPd3L5UPRUgZf7jfRNtZ7X5YAAdxgQ+JwrF0tQS6PnpzlTEFO?=
 =?us-ascii?Q?yvnAWUzSt0fynyjPeG+zqZXY7NRuSo8OVABPo6k/JYFTzrpIu+J/Bnxt1OZb?=
 =?us-ascii?Q?uzQNxqjthr8du/Bty2KV66DaaG8mAZ0jiA1HY5X16KzD1FI2Vv3FGTkXufKn?=
 =?us-ascii?Q?m8U+Fesy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s833I02w8dIE7Gz7VuVUpV5iB8DRpDAO3dSdjdlY1kJSPUUHOQ9yDuAlB6HM?=
 =?us-ascii?Q?8E8K56oav8/C7OPumkyFb3t29f8vQgndgKLpYBJgLvKsS2HdBMVVOfQ3DcHU?=
 =?us-ascii?Q?047UiL5XreaHnmvUWvzzIVOdbYdK7BTh1uG/ltK0Z0pvocsSJIy+496iNJsy?=
 =?us-ascii?Q?4FIhjG9NTORkn0LyPp1WOygSNfqx5QbyoaE72IeUq4l9LZfb/FcqCVG/aFex?=
 =?us-ascii?Q?N1xiLo1a66py1UjNEkde1aQUV1DlotinVfANqchw6xsBAm7k3hNUOEKq6am2?=
 =?us-ascii?Q?Sm7TFs/4IMyf50yWYo57blQzUdNIyFEMgYoO5C7g2NcLt+FiQ1vZRAPRtW4K?=
 =?us-ascii?Q?DBmIRtGbrXQwDi/4pE5oe+On+CzChyuHo0/h2QXTD1LYaU7oEFTflIZysBiL?=
 =?us-ascii?Q?Z1WBsLsF62N/D2/gEBkPjooGslJgtr67T2IkRYUyB+ISGRUsJwlYzLn+qCjE?=
 =?us-ascii?Q?fkjHcFupBYPY5aUIvDUir5Nl52iH+3Pkz9zsJDxIRF3DGtxtgWOjZfuw+lvn?=
 =?us-ascii?Q?f6XU8kC/6pPRfKbq4nY3wWdhzH7iGg6NgdCbNfpJk2cbSpamdVD3383R+hoN?=
 =?us-ascii?Q?B5AFV1EGOkmVgjvFAGzxEOvldD0J4Q5NOzYcXhXjsQlH3M1AvAwDrYU798zw?=
 =?us-ascii?Q?maof3n5WGyZlR5d9m3kf9mj/A3Ypr6Fc5GYupoaILgwFb+lyA7HHUypTo82n?=
 =?us-ascii?Q?uaxx6oIFkCMmpsgp4FMJcI64S00g5X/fTNLiE7IzyKzGm0RnjzWhnwrQX/cU?=
 =?us-ascii?Q?uilJ5xPR1WXHr+RKmZgn1XYh2urFb5vAq7O+MHa1hUqHwqVQV/5SSzaDOXtz?=
 =?us-ascii?Q?8nqTYA5hO83HcJri2U5vaqWr46hwPJKjb5j3VSbCxhhSjpf0LbsNgdx3jRZG?=
 =?us-ascii?Q?RFQ/qlPzbUeAW/zveLixcfV+saJUlrh8J4GvCJqOkSSbA93hA4YqmihmUf84?=
 =?us-ascii?Q?g55tmC+kJvvRv/jPRdqohyGDM/cBP8YONXXHh15Uqgc787abzxN3ekH8zlkr?=
 =?us-ascii?Q?4b9wmBWiSXT9ICAKX4h8Zxn2lJCT9wdwLE0NKoNin99KCHit6Y+EX28AQreh?=
 =?us-ascii?Q?z6jPp3m/gaZYNmOj3wqQQosQ5Vs3SLPHZSxCuYpdZgQDwoY2lvjm1bJOWNT9?=
 =?us-ascii?Q?TgM1VdA7lMmiwVFXIdAM1qHuwuWKwR01hrDVpusKBIT8+g3Z2lH+HpNlACet?=
 =?us-ascii?Q?tbnLU07T18SzfsCxKwApiN5OHast3I3KRMBJphURRMFB7njMj9igHiExsexR?=
 =?us-ascii?Q?gvjwHftCJZhqzbiy19We5K3mrFiqQa7jxpaEAlkHQxsnbQ9Q8s1XIRK0c/0t?=
 =?us-ascii?Q?ZFrt8OPW/fDYUvI7rQzs3SkgM9IInl3+RFjkWaVO4zMCAuWtJDZxvlEthDro?=
 =?us-ascii?Q?+PC8cZk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27308c6f-7e01-48b7-55dc-08dee8d6c8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 16:23:51.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6610

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, July 21=
, 2026 11:44 AM
>=20
> On Friday, June 26, 2026 8:04 AM, Michael Kelley wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, June=
 26, 2026 4:09 AM
> > >
> > > On Thursday, June 25, 2026 11:59 AM, Michael Kelley wrote:
> > > > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday=
,
> > > > June 25, 2026 10:35 AM
> > > > > We need to round up the memory allocated for the input/output pag=
es to
> > > > > the nearest PAGE_SIZE, since set_memory_decrypted() requires the =
size to
> > > > > be a multiple of PAGE_SIZE. This only has an effect on ARM VMs th=
at are
> > > > > using PAGE_SIZE larger than 4K.
> > > >
> > > > I think this change resulted from a Sashiko comment. My understandi=
ng is
> > > > that the ARM CCA architecture only supports CCA guests with 4 KiB p=
age
> > > > size. Is that still the case, or has that restriction been lifted i=
n a later version
> > > > of the architecture? I'm in favor of handling the larger page sizes=
, if only for
> > > > future proofing. But I wondered whether your intent is to always su=
pport
> > > > > 4 KiB page sizes even if CCA doesn't support them now. Another wa=
y to
> > > > put it: In reviewing code, should I flag issues related to page siz=
es 4 KiB?
> > >
> > > I think you might be right. I'm looking at RMM spec 2.0 beta 2, and t=
he RMI
> > > can have granule size 4KB, 16KB, 64KB, but the RSI is restricted to g=
ranule size
> > > 4KB.
> > >
> > > I'm open to suggestion on best way to move forward.
> >
> > The best approach probably depends on whether the 4 KiB restriction is
> > likely to be lifted in a future version of the CCA architecture, and I =
don't have
> > any insight into that.
> >
> > If it is likely to be lifted, then doing the initial implementation to =
support
> > larger page sizes probably makes sense (which is what you've done here)=
.
> > It's less work than going back and adding later. But the commit message
> > and/or code comments should indicate that the larger page size support
> > is future-proofing work, so that someone doesn't get the wrong idea tha=
t
> > it should work with larger page sizes now.
> >
> > The alternate approach is to not do any larger page size support now,
> > and to explicitly state that the code is assuming the current restricti=
on
> > of 4 KiB page size only.
> >
> > Whichever approach is chosen should be used consistently so there's
> > not a mishmash.
>=20
> I talked with some people from ARM. My current understanding is that the
> 4KB granule size for the RSI does not mean the guest is restricted to 4KB
> page size. The granule size is just the alignment requirement and larger
> page sizes will always be 4KB aligned.
>=20
> I tested 64KB page size on CCA Realm and it booted successfully.
>=20
> I will be treating large page sizes as a valid scenario. Please flag any
> issues you spot related to page size > 4KB.
>=20

OK, this is good information! So evidently the situation is just like
with normal ARM64 VMs on Hyper-V today. The Hyper-V host must
operate with a 4 KiB page size, but the guest can use a larger page
size as long as it communicates with the host in 4 KiB chunks (which
ARM64 guests on Hyper-V already do). As you point out, a guest
page size of >=3D 4 KiB implicitly meets host 4 KiB size/alignment
requirement.

But any changing of the private/shared state of memory assigned
to the guest is necessarily done in units of, and aligned to, the guest
page size. When running with 16 or 64 KiB page size, Hyper-V specific
code in the guest must be careful that it is not unwittingly
decrypting a larger chunk of memory than it intends. Doing so
would probably still work, but would create a security hole by
exposing guest data to the host that should be kept private to
the guest. I've done a quick look through all the places where
Hyper-V code calls set_memory_decrypted(), and the only case
I see where the size might not match the guest page size is in
hv_common_cpu_init(), and you are fixing that case in this
patch. So all appears to be good.

Michael
