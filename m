Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023104.outbound.protection.outlook.com [52.101.127.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CC3A9612
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264304; cv=fail; b=aD7imhfx49t9tbTs5f5rVqCovXzg4GDzddssgNK5Inzr4+o7ppWB52KbnrTBUE0KvcHT1E8PMB/3CvwLVuuo2aorhySekoBl7eKKp4r1hxnP1rqwc+HNMLiUE8FxdhPFu8X7NIxO0Nl2dnvZLevik8Q//RzSDk/KkzRtOd28haM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264304; c=relaxed/simple;
	bh=o0SYVWV5EGg2YHZdAlAi0v+4pkoocdlVxDsk/AxdBeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G5oOgCzjmA2eqdTfw+m9lOCuCEXJc6+HHOUgmJXKN2t5465lQZmvM1olb2BudP5dhUYNZkyVpmhSrzMjxH/Oa0c91g9qDm/AxteZRAC+wboqUjloVJN/qAABSD09cHWE8t89uesfsTZbBh8IhBUJlxcZiQEJT4d+rvUfcRr2nkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=blL3qrKh; arc=fail smtp.client-ip=52.101.127.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="blL3qrKh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy+/R4VUHc3K9jC+sXk3Plpkf7gFG7GLugPzIyjq2mygNsQMPbdQd03qrR/YD8ThnBb4BKfquD5mmxe3XsZBvBn+ynzMOQRew9jcGFyc7/Hf95IszNioj8jVPjzbzFgkpyxkRjSnxAT7lay6tsHE3NV0AwgAeLrsD1yUrI2ExMoiN3v8KYWQc93E5Ie8sRGYGmx+ZvZSKIl9+Lo9JYE9ncx4vNPYUvyreURPh6w3maEh8uHK7tSdSNztPyIF8R55yK/tnOJvybwLpbOcDphnXJ0ITYvIPLmT37tT9bFgoAWEurzKtHNfk8XvlL1RQxcHAw6XNJSfnCXFhyhFt/U0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9ZzD0nmmje/m2U5XslKmTFHXagfdOi2X2ciMKb4NMlA=;
 b=FTUEfrMO4cxSFWSllSUaIoM9ThEPZZ4fxkwPOQPyCIKAPbe/iDEJs5d5sxIsXoyi3e5gZYm1vdDbT4raxrWg0P+Dd7ee7S/Rdm7BuErrT0z/ucW3MVADyhsrV2BjsbJPy3PYjPOYArgRKWIFvY+kv1BBtwL/DOoAZGvRR9OHxZZjXTbJw0ikJIXr3J72SVGuITd2aiSB1q2ibTdu3NbNIjlRhu11IyjxY49R5USCxoLjmRgSb+nAfYijB2cDniZHgxTU8qCj55j6lCKxgEUOnUm9uzEVDwxfcWDds8wEmzIsI/tIIZFKUcaL92LglHxLsTyOJx6AUm/ghEM/5ZqTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZzD0nmmje/m2U5XslKmTFHXagfdOi2X2ciMKb4NMlA=;
 b=blL3qrKh6FWW9Jc/2nOxpaiBBsqGxNM6TK2pJ5nkI2nXxRfa0YvDuROpTEewZlwuTTXIf8WOOg05zVDJW04tvjoAurEQcFFYeeNZ9ea4ZASG6OyezEH0AtbZFJLHgdPRy8jrGusadRjaRCzKgC300/iga1WWrkuNyHvwRSc+KXg=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by TYNP153MB1866.APCP153.PROD.OUTLOOK.COM (2603:1096:405:3c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Tue, 1 Sep 2026
 12:04:58 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0406.000; Tue, 1 Sep 2026
 12:04:58 +0000
From: Wei Hu <weh@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, Wei
 Hu <weh@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/9] mshv: retain memory regions until
 unmap succeeds
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/9] mshv: retain memory regions until
 unmap succeeds
Thread-Index: AQHdOTu4R+/xS9EwSESkMqwOvvTIura4CtSAgAGWxzA=
Date: Tue, 1 Sep 2026 12:04:58 +0000
Message-ID:
 <SE3P153MB184846843FF17FF2F25D2F29BBA82@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260831112704.2851147-2-weh@linux.microsoft.com>
 <20260831114834.586961F000E9@smtp.kernel.org>
In-Reply-To: <20260831114834.586961F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16d19f51-0761-41a3-af04-906f4bddf1c4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-01T12:04:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|TYNP153MB1866:EE_
x-ms-office365-filtering-correlation-id: 8ea0ee70-b080-4485-971b-08df08213e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|42112799006|1800799024|366016|38070700021|6133799003|56012099006|10067099003|7146999003|11063799006|4143699003|4133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 w4uv5vfaEeNb9TdgVjKveZLztwdeAxQSU4bDriBvR5zIfedwUzksDKYaBagSsgJ+jE1WE3bpoa60zPfsYG7b2TLroHH35sbDphbDy6A2eQ16fbGiDwcLzCxGktDIsOUupzFp2b3/IcQEepXisp8wUKbzYPy0T3p+x317DIO5pkorb5uz+gBWGnwzbleZK/QGAR1Hb76JZTatbvtqAxpCsdoKoKjnAAvMBXdzsBNY+56potLppBzgE/amwyAeAaIywYvOI4/xcRGF7h4V/CWBfFtZYd9vrAqZlYERgSvPwSF/lcrSYydttlR63ExbxJ8ior4b1gT7p/sQ1QfW4KIbLtKBwaeMo16i5YLgroZ8Ek9Iw4NBZQ8aLCsI3WQKU/nm8V04ofaMxFKHViqbc0dESrKyU2AEdzBoBwsMHKL/uPvowiMQtl9H5/AY73pt6RwZUghHz+MdIA2N5+qdeK1i5+i1zEDsfGEiItoTENYC6iruNpLl0710fl+MzH259W9aBCuu4krkX68WhrPN9BUZNTEArH01pvCMcgnyQnTH8nzCNYROOq7knyT4WbdNjRYQYGX6pywHPXWnHkOMUSnn+yuZ2Dw0aEL7lGkDEmeYZGKI8G8CK+GnBgkLFbSxywK0TpcFQNNpvn+zPZzjl0oIVGWr3ZtpEPrGJ8+Jexv/eb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(42112799006)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(7146999003)(11063799006)(4143699003)(4133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gCQx2OAOkDISfQA5+KVXzSgS9y54VqDya5yipLCdnHiO4IhGh6CbkTzvqaX2?=
 =?us-ascii?Q?tpWLcMI6mR8X6amB0nXs/EBi8e67V+NGLPfIjJz40KUmbEBcLt0+V1h43uvJ?=
 =?us-ascii?Q?Qhd07+KZPnwMiRdpHPwAVQ4IlXSrAGOxDGOUf7uwQSi40N7CNiXLT2NXNGmX?=
 =?us-ascii?Q?kT+Yk4tlDQHyHuTViDiRdqZFoJWXq3j3hr1piU/6C8SQ92XEha8Xv8qTrUF+?=
 =?us-ascii?Q?+mbF+bdzT1xzx7i/1+7BTMz8m4UUUUy85z53w8YnYsIYQFQGfesqzsUwRqL9?=
 =?us-ascii?Q?bT1rFjCdZCadZywemBWpntUJ/uCvHv/ulHyFAPo3GNr1fyRkwWM/p2hy8/TB?=
 =?us-ascii?Q?aNNdFEHoSvuuS5nvB5GYexIuUsqnvLoAawgxQIW6ThfpX/JJvPrU+0u0veeV?=
 =?us-ascii?Q?eTdFPpITbIfBPl2Kop5edbsRrkatpo7k1NRE1mA0+ZEV2mWxgGf7of/JjCmJ?=
 =?us-ascii?Q?pOSZhE0WGlyopu67xbN9Mo9M7BaZg35CKuj4veawtghVPfJm37eRIOzyxWxz?=
 =?us-ascii?Q?cteWpKo3LZRllv3Pl6/P/akI+VLBjcMCODdX4EK0wY5VIlJUfyx7WHWMSBtR?=
 =?us-ascii?Q?4GcT/VMV5NZylUCYgCl8tVrsQZ8lwhPseAzmH+Bwbw1JvguaH8j2xIVAnHZe?=
 =?us-ascii?Q?0FHkfpQOaL0i8bW+Ci8wAFi5NBXawNlIiJxB7COu0V9Q/x+MFmYAj9zxwYKm?=
 =?us-ascii?Q?6AwHDjmlD09pr0k6yKsnri00QQc8lLqL2+ETuWu/pa6QPmZVyoYfa+3sSxsP?=
 =?us-ascii?Q?aCwGYefULi3EndNeQdkJkk0LD3ZFmZdy3VGpQEzA1cw96R8WI+NmLziDhjin?=
 =?us-ascii?Q?BO9CMyo78YoAt4ed18xp5LiOkL0gU9891L58YKBjVw/Fb7vYFMux9e0DuEXg?=
 =?us-ascii?Q?BtcoIcYhAzQge6WLGsU0nqo00Q2wG0p3w02uvQG5xlxKPoZHUGtfBXHiWLke?=
 =?us-ascii?Q?CopVD67Zc64ske4HgqhS5w0T4oezgM5pjcC2vkjdqfqbj6EERCxkSCU5UzJv?=
 =?us-ascii?Q?/GYSaRs4lWer9jHx+H/NQcyZXWVYLEBlQa1FyNycCXOm8ET1cfo52v/wkddq?=
 =?us-ascii?Q?sH9iq0ejtHOcjAEmFQCHPNq4ctFoR4TV6prWsnGbhmvUY6ClZ8atd14QHpKP?=
 =?us-ascii?Q?+SvG1BLuAFm4uiFdMYKmziCoDt0UpykOULP073WS/dpuLjqXjVWKfPBRYPPA?=
 =?us-ascii?Q?7VzCJA8+1IuCPdTYoJQKAAU5VF4BCkuLsH+9eWa4uHZ0y0+fBtAv1PqUgrxx?=
 =?us-ascii?Q?fRZ+gHvmW3kh71RznkDYl7eSiHzj+DjIkYA2jBkbyY9symr0oGPGx0zRsce8?=
 =?us-ascii?Q?RJ67ZalVA/JQ1j/aQixgLcJWQRh4R6fZdIkEdCaL57IPnCaOxSqTTukYg60K?=
 =?us-ascii?Q?vd5AZNAyWaOWpa4LAoFlRKF3xc0qigXUA9JR/dNCv5j3dM6FFDUzmDA3tCEf?=
 =?us-ascii?Q?FFolBDO2JIK8zKh2bj6X6Zeca5lOiuXmz6+6rGdKi02eEcvnMLA/PH2lWFW4?=
 =?us-ascii?Q?s0oJFNFDSLFf0q/qHOQli9rGVcRWTJ/jZseF8BdfCZYdYPOVRoH3YVtoVidV?=
 =?us-ascii?Q?QH7sieMSn+D3vm24jqdrPyaHvVzhha+2C6M1IYn8aYpMyTtMGbXA8K8/IoN9?=
 =?us-ascii?Q?WrO4VJhcOnMyq2blW+EeVMmjHndJY+D5/5BRVZTh+RpmnkFKqYRvNuVv26Xj?=
 =?us-ascii?Q?NlSVjADThdjdc2tzV9gzzITjjLo1jl1d0E3o86V+pDaRHIkq?=
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
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0ee70-b080-4485-971b-08df08213e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 12:04:58.1764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRQCyQZyH9qLaddBAejtS3akAYgj7F+4JwYq1tnF2IIPZQ6pBXZBFaQ6OgtCGtUHnar9F9O2IzSH8OLm1h1wIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNP153MB1866



> -----Original Message-----
> From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> Sent: Monday, August 31, 2026 7:49 PM
> To: Wei Hu <weh@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v4 1/9] mshv: retain memory regions until
> unmap succeeds
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [Critical] Early return in MMU interval notifier allows guest-to-host u=
se-after-
> free because it falsely signals that guest access has been revoked before=
 the
> hypervisor unmap completes.
> - [High] ABBA deadlock between `mreg_remap_lock` rwsem fair-queueing and
> HMM sequence counter invalidation due to holding locks across a retry loo=
p.
>=20
> Pre-existing issues:
> - [Critical] mshv_region_interval_invalidate() returns false for blockabl=
e ranges
> if remapping fails, leading to silent UAF.
> - [Critical] Incorrect MMIO physical address mapped for user memory regio=
n,
> allowing arbitrary physical memory access.

Hello Sashiko,
The pre-existing issues will be addressed in a separate patch set. They wil=
l not be resolved in the future revisions of this patch set.=20

Thanks,
Wei

> --
>=20
> commit bdfaa07680341c254374f6fa979c3fcd550c4840
> Author: Wei Hu <weh@microsoft.com>
>=20
> mshv: retain memory regions until unmap succeeds
>=20
> Do not remove a region from the partition list or unpin its pages until a
> checked UnmapGpaPages hypercall has completed. Validate repetition
> progress so malformed zero or oversized completion counts cannot spin or
> conceal partial state.
>=20
> [ ... ]
>=20
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index 6d65e5b421529..9feb49d9d9d49 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
>=20
> [ ... ]
>=20
> > @@ -452,12 +458,35 @@ static int mshv_region_range_fault(struct
> mshv_mem_region *region,
> >  	range.start =3D region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> >  	range.end =3D range.start + page_count * HV_HYP_PAGE_SIZE;
> >
> > +	/*
> > +	 * Pin the mm while the remap gate still guarantees that the interval
> > +	 * notifier is registered. Do not acquire mmap_lock while holding the
> > +	 * gate: invalidation enters with mmap_lock held for write.
> > +	 */
> > +	down_read(&region->mreg_remap_lock);
> > +	if (READ_ONCE(region->remap_blocked) ||
> > +	    !mmget_not_zero(region->mreg_mni.mm)) {
> > +		up_read(&region->mreg_remap_lock);
> > +		ret =3D -ECANCELED;
> > +		goto out;
> > +	}
> > +	mm =3D region->mreg_mni.mm;
> > +	up_read(&region->mreg_remap_lock);
> > +
> > +	/* Lock order: mmap_lock -> mreg_remap_lock -> mreg_mutex. */
> > +	mmap_read_lock(mm);
> > +	down_read(&region->mreg_remap_lock);
> > +	if (READ_ONCE(region->remap_blocked)) {
> > +		ret =3D -ECANCELED;
> > +		goto out_unlock_remap;
> > +	}
> > +
> >  	do {
> >  		ret =3D mshv_region_hmm_fault_and_lock(region, &range);
> >  	} while (ret =3D=3D -EBUSY);
>=20
> [Severity: High]
> Does holding mreg_remap_lock across this retry loop create an ABBA
> deadlock?
>=20
> If a concurrent page fault and region unmap occur:
> 1. The fault handler acquires mreg_remap_lock for read and blocks here
> waiting
>    for mmu_interval_read_retry() to clear.
> 2. The unmap thread queues for the mreg_remap_lock write lock in
>    mshv_unmap_user_memory(), blocking new readers due to fair-queueing.
> 3. The MMU interval invalidation callback mshv_region_interval_invalidate=
()
>    (which would clear the retry loop) attempts to acquire mreg_remap_lock=
 for
>    read, but gets stuck behind the queued writer.
>=20
> Can the fault handler loop forever holding the read lock, freezing the ho=
st
> kernel?
>=20
> [ ... ]
>=20
> > @@ -524,6 +558,17 @@ static bool mshv_region_interval_invalidate(struct
> mmu_interval_notifier *mni,
> >  	unsigned long mstart, mend;
> >  	int ret =3D -EPERM;
> >
> > +	if (mmu_notifier_range_blockable(range))
> > +		down_read(&region->mreg_remap_lock);
> > +	else if (!down_read_trylock(&region->mreg_remap_lock))
> > +		return false;
> > +
> > +	/* A completed checked unmap makes notifier remapping
> unnecessary. */
> > +	if (READ_ONCE(region->remap_blocked)) {
> > +		up_read(&region->mreg_remap_lock);
> > +		return true;
> > +	}
>=20
> [Severity: Critical]
> Does this early return falsely signal that guest access has been revoked =
before
> the hypervisor unmap completes?
>=20
> If mshv_unmap_user_memory() sets remap_blocked =3D true but has not yet
> acquired the mreg_remap_lock write lock to issue the hypervisor unmap, a
> racing MMU invalidation could acquire the read lock first, see remap_bloc=
ked
> =3D=3D true, and immediately return true.
>=20
> Could the MM subsystem then free the page while the hypervisor unmap has
> not yet executed, leading to a guest-to-host use-after-free?
>=20
> [ ... ]
>=20
> >  out_unlock:
> >  	mutex_unlock(&region->mreg_mutex);
> >  out_fail:
> > +	up_read(&region->mreg_remap_lock);
> >  	WARN_ONCE(ret,
> >  		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx,
> event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
> >  		  region->start_uaddr,
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does mshv_region_interval_invalidate() =
return
> false on a blockable range if mshv_region_remap_pages() fails?
>=20
> The core MM __mmu_notifier_invalidate_range_start() explicitly ignores th=
e
> return value of blockable notifiers. By returning false instead of ensuri=
ng the
> mapping is torn down, the driver silently fails the invalidation contract=
.
>=20
> Does this allow the core MM subsystem to free or reuse a host page while =
the
> guest VM retains mapped access to it, resulting in a guest-to-host use-af=
ter-
> free?
>=20
> [ ... ]
>=20
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index cc2cfce2aefdb..1ca14660f9985 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
>=20
> [ ... ]
>=20
> > @@ -1397,13 +1398,15 @@ mshv_map_user_memory(struct
> mshv_partition *partition,
> >  		ret =3D hv_call_map_gpa_pages(partition->pt_id,
> >  					    region->start_gfn,
> >  					    region->nr_pages,
> > -					    HV_MAP_GPA_NO_ACCESS, NULL);
> > +					    HV_MAP_GPA_NO_ACCESS, NULL,
> > +					    &region->mapping_may_exist);
> >  		break;
> >  	case MSHV_REGION_TYPE_MMIO:
> >  		ret =3D hv_call_map_mmio_pages(partition->pt_id,
> >  					     region->start_gfn,
> >  					     mmio_pfn,
> > -					     region->nr_pages);
> > +					     region->nr_pages,
> > +					     &region->mapping_may_exist);
> >  		break;
> >  	}
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does mshv_map_user_memory() allow
> mapping of arbitrary physical memory by passing an unadjusted MMIO PFN
> and unvalidated size directly to the hypervisor?
>=20
> By using vma->vm_pgoff directly without adding the intra-VMA offset
> corresponding to the userspace_addr, and by failing to validate that the
> requested size fits inside vma->vm_end:
>=20
> drivers/hv/mshv_root_main.c:mshv_map_user_memory() {
> 	vma =3D vma_lookup(current->mm, mem->userspace_addr);
> 	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> 	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
>     ...
> }
>=20
> Could a malicious userspace process set userspace_addr to an offset withi=
n a
> legitimate MMIO VMA (or beyond it) and map arbitrary contiguous physical
> memory into the guest VM?
>=20
> --
> Sashiko AI
> review * https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F
> %2Fsashiko.dev%2F%23%2Fpatchset%2F20260831112704.2851147-1-
> weh%40linux.microsoft.com%3Fpart%3D1&data=3D05%7C02%7Cweh%40micr
> osoft.com%7Cf41ea7e6afe44d8b0d6208df0755cacd%7C72f988bf86f141af
> 91ab2d7cd011db47%7C1%7C0%7C639237737234695849%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3DnKKIfw5wbEV33vK8LJGwQNDyA3zm%2F5DYBZgHWDH0x2U%3D&reserve
> d=3D0
