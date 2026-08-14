Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020092.outbound.protection.outlook.com [52.101.201.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70699492522
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732231; cv=fail; b=jDfkkyUpJ9IFCiNKPXCn9l/ibrvROnmc0sw+lbg8cbxCdtUrmwi/2YNFbSZeMI4b0lUoDy/k1JTiORwv1lwBSCqJhc/PkNrCqFzCj0O6QtA9KTNrmYUE7NAxr8XyWie9G+h7YJsLADFgmnQbSRuK03tksgsBedBO6G2a5iL0z04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732231; c=relaxed/simple;
	bh=+jL0WZsX0sXVQn3wfsQQLYOEPBreCp3MSRX7FcyITq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n90JOrsNtz17J1RpeC9xIJjPcdCHbQlXwC6QppOubJGAiTZarK7jeKxp2E3bUZsc8GZmfFGmQRtVpi3eh20SeKxnUu9gF+mSMFiTer+OyZyFM0cgDBWeMSlzJTFNfhUTL3K8J4OfCf4x/U6sp/HkKpllDCt7+nUAV+PYo2tbFog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VrLoQNj0; arc=fail smtp.client-ip=52.101.201.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VrLoQNj0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWpzM54Br271jUePdsV5j+nln8LTcF/xG+cgXclMNxSQT60C21ndaiy2gJOSdnT0keJpFzAf0fKPKMEyDSskjhYvDeLnYYhw0BEy8Ao7SAxws2+VbScdCe3d35HEhos6/cGwCyLOe6Va/qBq3hyOA4N6sqSMls77WMzJAH1MtPb0DJZE6JMeJYnEtC19FvnfW4adu/CsKvRVzVqEb606Ufj3+Y9uELdLDsQeMu1Bn6EI3dzXe7t7mFe+oeo7dgbB+3EZvNRZZJsTO60vYNujIouxZl4mCm+XBn83ep7g40ip4V47wm0Y8smVnii5+Yq9uuIjfySGGYKa4Yq9z1HfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfIfrnHRWWZFK51oFl+UD6Kei277Bhc46vDgBRwdFkI=;
 b=eE4mp/pWupuQI1h9YZTRee68WiaMyDfgez55VZ3LO5NZAzwzcrTd1FAoePmoQmuVONdd9JDvO5kfR8IIDCM4w3aC7+PfshzWkRynHsbqYN8MXTZaIvI/EwRCRJT3l4ln+DH/smdCXMBZcZQi5NAwSm9MMXAx4EK7eNGqjFlht/iTDNSwpcVPJrNXYRI6GcseeTG0Ia+4ZC0btv/pfpVT3+3ZBQnSRWRAmriH+1hsqFu7p2kAqtbF+tJmR09yE6pp1sOrC+jlgx41zEgk7dtWyqYzD+INz/kuGRT7AwxF+2ZvwrvIoBgSsnmb9So+c499tX3TcsvhEFu4GLvMyI3dLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfIfrnHRWWZFK51oFl+UD6Kei277Bhc46vDgBRwdFkI=;
 b=VrLoQNj0AxHghjBSkCugcuvN1xp8D0DnR6pwUPLoVvGmk61/aXmsHMmZjP6N9KAs/0HKtl86bEFs342QxB24u8oA6xKxg4Cza9YY3vgJRyyDWFShESKZmO1m64xiOzlE4cP6I+cqovSJRHmc5TUU74B69HQoMS3pAJ0kOKyeyaU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.6; Fri, 14 Aug
 2026 18:30:26 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 18:30:26 +0000
From: Long Li <longli@microsoft.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 04/13] net: mana: swap queue
 sets in mana_set_priv_flags
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 04/13] net: mana: swap queue
 sets in mana_set_priv_flags
Thread-Index: AQHdKuFKjklj5Rvtk0KJ9LntgizzHrac/zoAgADg2UA=
Date: Fri, 14 Aug 2026 18:30:26 +0000
Message-ID:
 <SA1PR21MB66834F45415F1B35164760BCCEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-5-longli@microsoft.com>
 <20260814050517.220791F000E9@smtp.kernel.org>
In-Reply-To: <20260814050517.220791F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5db8a1d6-a3d0-40fd-b2ad-f71ee816ce91;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T18:30:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 53c6c3d4-d185-4f67-b265-08defa321c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|7146999003|6133799003|4133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 D7l2JRdDQAPjT0kkSNNzATo0jMb/84YcEAtn/xHQBMtNC9zbhEZ8UpOyb0+DUDolB7v7RSSPDDQTSnf8N2ZH8SCNkqWc2ZXwT3Q3DV1p2vgBDqHecGM3TzUp1VMyBpXQFSRI2vqVxPck2adzsyIhXOCT0toYybRVMLqjSLWceg0AvOvmfrVJ8lMwPlKOFt6d2MXl2xWn1DaMLr88tWc0FHrraoBcAFvZfrZ91Npk5ww7ZLiaKguF0iZX44nfPsE804G4aW+byq4Ux9vStxmcOLIeOXvDuGiLnpw6O52oDjqSHntvVVMaui1bGC5CvCT7oY3oQetIv8IJ5Cm15L0PlpQMYqVO29e/7GkTvUDI/XXmCHXJtb9s+XjcmcmpiV8892l4JuA7qa5trlTug7nDWk0PCrYXbMZ9kYRSxdELeEz6QoEIli7P/lfoUOaVZ0TJNsRXl2UsV6Jqiqks/TUcQYONCkzruWi4RIA1NwcAmCCjxjBexwtDRruvF9/LCqVPj0suSuwi2PlDMSGphnYqBMSpQQkUyCzk6FBP5U4LRm4lEaj9ljgwy/FvKoYZ65qNQkzcm1OHrKln6KuY1EBUE7bU253c1Z+MGT0pOpjEtSt9DnTPZt+CWYaZeynOMULqKcgXoFblwTAwpKo9vUUGKncuNQo9zyMRuDO+K/KTazc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(7146999003)(6133799003)(4133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DTfATaq6C7yaGZbcxLNIeZwUgmEEmUzEWLXMRng75OKRStYkGx65WxzhWZn4?=
 =?us-ascii?Q?zopXN7OLmWgc72QaGen3g8iXajztuxPHTgvSHmG6bRAw6wTVhDjQVTEV5peb?=
 =?us-ascii?Q?f69niTFgBJZjnkr+Jg93XwiYM/qmJaEYFlbtDDVIkjsrol+NxfcPnVsFq7lM?=
 =?us-ascii?Q?JYqfs1dJs5wMOXwafV4FY91/F/CJQB15lJ5UkOuVlRCnWtCAT3ZC2/QyNNmJ?=
 =?us-ascii?Q?PQc2vZyvb2Gtoeg1Ab0oJK2FThJ4XNckA7S6wWviYH6JfJVcitF9FDsyz2rN?=
 =?us-ascii?Q?KOJf5EKvyv+9DcvJxOzRhAAzfZqQZ2z0KH1JUEBhO3M9CYdOJ1umHsDMffOW?=
 =?us-ascii?Q?2XWpzuei+GGf58tstslMTjOcLm4ImgTzgYc9/paUkMCp6bHzpF6CNAI50jUB?=
 =?us-ascii?Q?jfMlVS4kysSkcE5UzSjc8/tzhWcibwX8kBGqKNLnHvnYU98KgoI4ZHbuPhbu?=
 =?us-ascii?Q?YpqYrxNYjYCVZcLO1rSdzTI0tOQRKCofNz0Mbt6h1+/bgmkDf9mHE+TWMSJn?=
 =?us-ascii?Q?7AaoKs9eUvjIj+kPret84sRt9b7pBRKq65zDmAS58XuRvVEdCvZpB5IdhTqY?=
 =?us-ascii?Q?OUlhDCbwFNg1QxAwDHIRydgaiqv9XAuRWm5xsTjs+KFgJ5CwRF2YBCWGsqBD?=
 =?us-ascii?Q?eaFTybXUWcLsNS+v8F21RAgXJ9+9rK69nBN3YV4vZK7yTUogz3hrR7AQMKZ7?=
 =?us-ascii?Q?MWdjJXYrmbtfksX3MB+XIjbhuly2OsGReVnBj1x5qtTpDUobuLPDhTFK6L8x?=
 =?us-ascii?Q?dCfReNhHUQS5EZSJdUmxRz3n+s7V0Ri65xggx9KquwDsewtkUoG1rB0lULg0?=
 =?us-ascii?Q?EC7aVMn6kI1jBIMEKewmbh4UyPJXVs5TeNS1cypxSvQt2CyLjtzFH5HfN+Hk?=
 =?us-ascii?Q?Oz0FyOWU9Y4iskwRjMVeqp+aGzCEtQM2Gz8kbzyconkdElx6n1CXEu54DnV0?=
 =?us-ascii?Q?qNtZMAcfAYGfK94Y5nB9EgCHvqT6JdjeL3ZztQrpipnsd/BYn+3sP2JJ4dvZ?=
 =?us-ascii?Q?oaJhZRhyUD1LlCToJo16V/9m+JBYnaUeTpZPB5SP8fm0qshSSCSzpT0BwS1v?=
 =?us-ascii?Q?fDc56Y29Hlh4cdUOhWm70d2ZO7e/xiyZ5+Ss/CF3+yIwUqaiFgBzJHRVQvi6?=
 =?us-ascii?Q?10efLHFPEkQIsc1u7hAd+idcFACYngnKfBoXzT7mCKT0jxPRVyBgz/uSHKqT?=
 =?us-ascii?Q?Ny5VKHPoP1dlQFOwFuq4uvFcRG4bBQIYr9qQFhoEgK5YurhnRvV9gtwIF65X?=
 =?us-ascii?Q?Iv49RWYCjjf77OIpzLjvP7+2KcnVm9b59j9JReze/REs0Nq+R2S7SF5g4aPs?=
 =?us-ascii?Q?XHSYirb2XsGpX4VEW5dZaZBJnioKnXtGvuk635i6yuTjSyjpoZX3w48HICU/?=
 =?us-ascii?Q?3/OU2Ak67PP0FGoJkDyUVUaArf0xDjz46FtBG8+nzqOKS8k5o1kwls2qKjOj?=
 =?us-ascii?Q?6atXbpvHgN4SmBaPY68H2ESPHXnCLqb8pvwOs0cj5et4Zc/qidQaG14wLi3i?=
 =?us-ascii?Q?Oi4P0ViFrANg5QKjyscWEZUgV2vNNtBojJCOWOcC38AdlbpMwub4+WWgJnDP?=
 =?us-ascii?Q?G8JPeuLgqo3XAOhwEfDCizecAjb4w3MhOCbHNRQzaESX3GZEQw7xsuIqFeHv?=
 =?us-ascii?Q?+FFI747cMkd2TtX1k/SERzPPn5aVkDTIwOkgoO/8rhmd1ih/jca3eMZq85f2?=
 =?us-ascii?Q?uc+Hw8yfNtX2sxKlbbTU6b/DSkZrwnSMoyVz6wrZi+25FK3A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c6c3d4-d185-4f67-b265-08defa321c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:30:26.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Q0e8H49RS00SeGMR3FiZed+vYCsNSaJMXQp9Ys3n/Az6ygmza0DNU/h1gOGngn8peEGaGiNA1PMkDPRd54x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012

>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
>=20
> Pre-existing issues:
> - [High] The boolean flag `apc->channel_changing` is used as an open-code=
d,
> ad-hoc lock to protect vport reconfiguration against concurrent RDMA acce=
ss,
> violating core kernel locking rules.

This patch set doesn't change the locking mechanism used by upstream code.

Long

> --
>=20
> --- Patch [4]: [PATCH net-next v2 04/13] net: mana: swap queue sets in
> mana_set_priv_flags --- commit
> 922132e276d163d3c58e43d88b85f6b85a403949
> Author: Long Li <longli@microsoft.com>
>=20
> net: mana: swap queue sets in mana_set_priv_flags
>=20
> This commit modifies mana_set_priv_flags to pre-allocate and swap queue
> sets instead of rebuilding them in place. This ensures that if the rebuil=
d fails,
> both the queues and the flag word remain untouched.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> [ ... ]
> > @@ -884,54 +888,53 @@ static int mana_set_priv_flags(struct net_device
> > *ndev, u32 priv_flags)
> [ ... ]
> > -		/* Block RDMA from grabbing the vport during detach/attach
> */
> > -		mutex_lock(&apc->vport_mutex);
> > -		apc->channel_changing =3D true;
> > +	/* Block RDMA from acquiring the vport for the duration. */
> > +	mutex_lock(&apc->vport_mutex);
> > +	if (apc->channel_changing) {
> >  		mutex_unlock(&apc->vport_mutex);
> > +		return -EBUSY;
> > +	}
> > +	apc->channel_changing =3D true;
> > +	mutex_unlock(&apc->vport_mutex);
>=20
> [Severity: High]
> This is a pre-existing issue, but in mana_set_priv_flags, is using a bool=
ean
> flag like apc->channel_changing as an open-coded trylock safe?
>=20
> It appears to be set on entry here and cleared on exit to protect vport
> reconfiguration against concurrent RDMA access, rather than using a
> standard synchronization primitive. Does this ad-hoc locking pattern evad=
e
> lockdep and risk races since it bypasses proper kernel locking rules?
>=20
> [ ... ]
> > clear_flag:
> >  	mutex_lock(&apc->vport_mutex);
> >  	apc->channel_changing =3D false;
> >  	mutex_unlock(&apc->vport_mutex);
> > -
> >  	return err;
> >  }
>=20
> --
> Sashiko AI
> review * https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%
> 2Fsashiko.dev%2F%23%2Fpatchset%2F20260813050418.2906468-1-
> longli%40microsoft.com%3Fpart%3D4&data=3D05%7C02%7Clongli%40microsoft.
> com%7C12b5de9dce024bffb15908def9c1a4bb%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C639222807267503180%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DmmPoxVwzW%2F
> 5aQYtA63m5ts8vN8Y3bM45YQmyRwYiTLA%3D&reserved=3D0

