Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010037.outbound.protection.outlook.com [52.103.10.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D123B058F;
	Thu,  8 Oct 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480131; cv=fail; b=gdRnTHp9JpTywINAyC1C2Q9EiA3A7ah3Es+VyI4xB9Ia6f3Y574TMs83er1MOh9sM3fGQWTH2cQP8Wk38gJFhTQlpvFD4qlveLhbHKe00Qx12/iMPMwnZUxkmOe2UoMAtw86V203U8H8kuagxONnaAkUSVzVqgmlhuazRIAsdxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480131; c=relaxed/simple;
	bh=pu7Kbx0/2VvCNlIEuq9STiAa4+SD5ezJFTTse8ot4sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGLHNejor6WewMKzeAT8tCvPPewIcSIDptx0yATsP7T/MpXc0ehNXlLQXDzHJ5QpIVGgStw/Loslst/zRLVWkCzdnY6s5GwveERxYbMbttux/sERnFLitCOQhIuYtWmTbpuFuT3a4d0d5TtY8jYKOM5+Z/0W69Wzu2m5cGRiRZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WKjKsH+Q; arc=fail smtp.client-ip=52.103.10.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WKjKsH+Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1XduXWm7Xps3Ke5B8K6e97iXTgyh0hUo0LpLitt9SMlqg1/18MzK1gqGfVEhJck/e/dnyk7Uimi/MVet1RNj5l0FLb51j5Gs7cKsMDV0vx0YKU2IB0PPGZKmEB0U2Sv5rdy0Bg5jyVfITFf3QKZOSTQI5NnHTjJcCukNB3Wydt4t8q/2fp0mg6zPHRES8yOcJWu4k/LWX0EsU1PVC9m8RLN9cWHldBcJ69bRTSbatNVibyCzj8dZOeXMsR74FEj2eN9wTe/R/T547oSeo+8Wljm0fBbgUsaV0OKkiQjPictcxxj1/enFgd1aX7AFz1o7vGS4FT0J5aXfVHJ2pcNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efqNAX2d4iA+wrtgxrBSL7+lTJWXKcjshtdMAtwm+Ks=;
 b=nqzhlpXxr+N3joV3GO1dHK8aXX7B6nW3+auH/3JWp4z8xj564Ctf9Ovhn8sFudLnyw9Nvx/BKfbCJ7MXqOBOKk/zA7zBL2cWxQLWzwP6b9qrsmbD9L8PyiUy6/cwLS/fGfi4ZG2e2u0REgMXFATC/I9AtIXPcT98gQxzyhqXMPwtKzxZ9im7+nszwHZIDzfYW3jTP4kqdI15oruiLIYgTwP0Yb9rQbHaTCCE0q1r3eOu26rkoohxZtrMngmGHBNHZeYzSW+L+OuVYftmF82lmJlWjVlkhkcyG++D2y6jKzLqmS5IKbOIvFRHbbfayKVSeBhRrtmnhXGd5lrEAemWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efqNAX2d4iA+wrtgxrBSL7+lTJWXKcjshtdMAtwm+Ks=;
 b=WKjKsH+QvMJ+fvOMyLvrvMwHjtwQhV6/XbDiNIeqG2JTnpGkgMOtpRbLiMgb/4zp3ERrNZWYUpg8AnK2WeJvBwg7RHCO6nECtcknBWLZ+ROuoK7XFxOo1Wkh5sTHbidbCLCaVQKdgykhTbccmKc0kffiGLpJGQ6QdS/47pIUJARsniR9rpn+iVEMiT3tUOzG12GZNKU1ZEMs2HhqbXc6DX/86WUQGWFGXpWlk5FTRoAoULUhS9mx1MQ8tcXGpCmZlR/mM009JW8kITwTTrc1IYv7eAX9gnWvWRxwf+BpuCpUpjHI942Bs9rLVWH77/rDwvi+3GBgqrSE9XKyI1rBNQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:22:08 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:22:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] Drivers: hv: vmbus: Harden the ring buffer against a
 malicious host
Thread-Topic: [PATCH 0/4] Drivers: hv: vmbus: Harden the ring buffer against a
 malicious host
Thread-Index: AQFOJEjNF6VkbcuqUxfhl9QR1YCS0bgRFq9w
Date: Thu, 8 Oct 2026 17:22:07 +0000
Message-ID:
 <MN2PR02MB6863463A418F2CF1DE9A057ED4932@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: 2264a55e-be4d-4220-1576-08df2560ae4b
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|12121999013|25010399006|13091999003|31061999003|24021099003|8060799015|19110799012|8062599012|51005399006|15080799012|37011999003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WA1Cbuw+Edl+eKTkn0cyvlyfxAgsg31fVdO+gt5Afak+lwqr259RzJhvMGUF?=
 =?us-ascii?Q?S79m0og/oyjVq1oSEh9Sjhz8xRS3jqyuu8ZWI0uZd3lN8jht6j23oMCeQWa2?=
 =?us-ascii?Q?n4ngNi+wZL4qFB7M2DLephlR4CNwVCVE86W23yDlEFVSyTyWVq6H2tQ3uXXq?=
 =?us-ascii?Q?5Nm616CNK9+54E5H3ezo9WOLT+8FjaadDoTlH3YcW+m9GiFFpuuLVRJ4bU/6?=
 =?us-ascii?Q?CE+YoWFXGbaBodsesGHkfHoBMCqs8kwyWlWsPxCzNoH/GlCzm2AsOXbWw4/A?=
 =?us-ascii?Q?PAVMMV9E/XzbkI6PZ/ttOwDNK9UqLPJzFd0clegV+35L7fTD7MQe6mGht9xS?=
 =?us-ascii?Q?Wzl6+UNlgFUbQEFnEZXFQch6uSr1CJmdneXPcQM0hlg5f6GEYlLJ6kVlcBxE?=
 =?us-ascii?Q?F/R6/8Mx0Suc7si+9+/7gMexj8UE4dTRpL2gBJ2TR2nhZYtcYBXfzV+2wDvA?=
 =?us-ascii?Q?m0gNZ63jfmv/4FnQVqokM5beEqbUM29e4BV4cYuH+ZSfDVesk8QmhUkpQUBK?=
 =?us-ascii?Q?9XzEymxbIWYQYE7GVWoeRDnL76R/wsKH7XD2j5O9XhSKVCb9t3DFcHj4oCQn?=
 =?us-ascii?Q?kQ7zAUi72YmR4urGY6K9f42pwjQ/c8srjY9kBQM8iMNzeFfRgIg9vhXVArhc?=
 =?us-ascii?Q?MtZdqKVrucbsBh5G3jGF0OM4xdTcED1NeoOjzZ7F2o1sUdDDUZCbw/dErSZf?=
 =?us-ascii?Q?kaytD/pRRZpl6FTe//D8WsoY5TUblbZINIupfWaHbWXDQMzypfH9RAgkdlpC?=
 =?us-ascii?Q?jnytFzCxWqys9TnC6TBh6opnSrB7T1Q2SREA9Aw0cWDsE1m09wt34slVuEtI?=
 =?us-ascii?Q?ajqCILNGSJFHFrvRd3lK7pyFHsJd3cXGyKj5+sI2Ri5ssn4tPf2zSnUbQxXV?=
 =?us-ascii?Q?jSJtJ7hoFVn85SND5AAb9lVVFvzL17yPYC85oWcSkSxwxdrvRAKGfWc/iTuo?=
 =?us-ascii?Q?5XOauMuhaZVuwL/osR+cKS87SsA6l7C/8MJygfg4wBDmyZKQxcYonSPZIxw/?=
 =?us-ascii?Q?iBcuEm3fmmhD/gLABZmA8I5JXSa4Rfu+Gxocn5jiKPba33O6TF3g/EphHCch?=
 =?us-ascii?Q?C34BJhl2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3LRMobh+WZlWnMQ11mgeEi6xcDd7lYrCZ88GQUhngSY2XFn+XIHsf2/iklfv?=
 =?us-ascii?Q?olig/LDAHrzcU38O41B3uEnA8+dWJbO13RaeNyJASuzw130hORhPTn2o3s9B?=
 =?us-ascii?Q?bPfHOra+VzpsOCPs1YDXKo+P4WdMT3+Mus314QzXyBZGnZmmS8VXXE3+7nLu?=
 =?us-ascii?Q?vMJjeYRTsuAaKgJyk/0+my7RdD/qZfie9V9wU0UnVjc154bdYM4dPcPH+0U6?=
 =?us-ascii?Q?EnCIc5zMM5xTWyDyA2kv6Chf/HB6P0cJYmctUg3mjWR8+jsK8sevVyI2TCKS?=
 =?us-ascii?Q?ZGisG4jPskZvQ85epnd3vr/WIVq5+HFrtrbvkwvnHB8BDMO+EK3CSgxg6TS+?=
 =?us-ascii?Q?ts7beSSP0PUYAbnXmk/7fUcshgQ/41viQPULUv4Z1nPhBov30YN/f0NuvO8O?=
 =?us-ascii?Q?rneEnqQipriUl28FHL+4wN7U2tahIE8PJvGK++vMf97Po6NkjLuSBPyyxzeO?=
 =?us-ascii?Q?dJK96R/MukzupUF/qu5LTgff/SN/vyNCobJdQWTesldHPtFTQufsD4YA2P+Y?=
 =?us-ascii?Q?Pe64YBucZ0foHGEoyUFpkqNSTbHGLcNkwBZECxYx1CtaPT1BrhMlq6MbYEe8?=
 =?us-ascii?Q?ZC2/AAXPLqWcrgF4ktvCRcBxzHlME43IZNiPePChkeRHgQp70XFzomX2ITRC?=
 =?us-ascii?Q?7ejdBcSYWvVb2DTAsByxLBhwSPKyracOM6dazPQWJ662SRbkjopcCd5nXnMi?=
 =?us-ascii?Q?KPQCr5CmR+KKg7IXoWPBC3ttqIavz30EiUdnFhnvZpUA7Cbige1UhNGTTmH1?=
 =?us-ascii?Q?x9imUzMBQiW1JQUsSOmZC4jvRXFrvN6REkVLmFuy5ZYtrUbbZqQJYzqmRzLk?=
 =?us-ascii?Q?ks7NU517ONz0uAWWRjpRzfIiTm9aT8EkBC/NEtMdU+DD5PfHlxxyQCtXtt0j?=
 =?us-ascii?Q?OSd1nRzsLg4kpxSZIdce5grGh+EX41vjYChV5TKg0JOFHHHMFpmTPpdl2Lnj?=
 =?us-ascii?Q?v2yMZVUi7rRCfaCY2LEHWm1ue8PrIfJGLuY8Y9g2IYVrQGtl3X3lM2IQkH9N?=
 =?us-ascii?Q?ohFAF4/3O7kvOEJsueEkLAIymRD6SyYkboRQOYNznpz1y1oASwD/+doVi5sJ?=
 =?us-ascii?Q?tS24LB4OCqbo7hQvZCwcNgRbawlvXgmyOZXbLWqsddsAhc2WvUL24xiG7YSp?=
 =?us-ascii?Q?4OS6WAyZf1GF3qj6ToStYRkiORGDNIfZyU8GyeNLYwFoU3e/sMVHpimiCRp6?=
 =?us-ascii?Q?CjCzX8pjol5Zo1wJw4ZWLaWbER8OqdnoYsmlZ7+BHmIphKOtJVslEKv5PDCR?=
 =?us-ascii?Q?jyBkEcKXvN3hMrA6uJWc/uH3WOi3+6fcjM1G+T6HZ7YwOG5j0EU1mesgTDFB?=
 =?us-ascii?Q?EBFGr1OjSWMut9/2pXvXZUhSIQLiRyz4PsDusVLPyMXsi2Db01ZzM/EvKXc9?=
 =?us-ascii?Q?FJ5d6vE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2264a55e-be4d-4220-1576-08df2560ae4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:22:08.0802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, Octobe=
r 1, 2026 3:11 PM
>=20
> In a CoCo VM the host is untrusted. Since the VMBus ring buffer read and
> write indices live in shared memory, the guest has to treat both as
> potentially malicious and as changing at any time. This patch series
> adds bounds checking and reuses the validated indices instead of
> re-accessing them.

I worked quite a bit on VMBus hardening for CoCo VMs back in 2021 and
2022. When I first saw the Subject of your patch set, I was a bit incredulo=
us.
Surely we had not missed this rather obvious vulnerability! But we certainl=
y
did, and I can't help but be a little embarrassed. :-( Thanks for putting t=
hings right.

I think this topic deserves a mention in Documentation/virt/hyperv/coco.rst=
.
There's a section entitled "Guest communication with Hyper-V" with
this paragraph:

   Similarly, when the guest reads memory that is shared with the host, it =
must
   validate the data before acting on it so that a malicious host cannot in=
duce
   the guest to expose unintended data. Doing such validation can be tricky
   because the host can modify the shared memory areas even while or after
   validation is performed. For messages passed from the host to the guest =
in a
   VMBus ring buffer, the length of the message is validated, and the messa=
ge is
   copied into a temporary (encrypted) buffer for further validation and
   processing. The copying adds a small amount of overhead, but is the only=
 way
   to protect against a malicious host. See hv_pkt_iter_first().

This documentation is only a high-level overview, but maybe add a sentence
such as:

  Also, because the ring buffer header is shared with the host, the guest
  must validate the read and indices before indexing into the ring buffer t=
o
  send or receive messages, or when using them to compute available space.

Overall this series is well done. I have only a couple of minor quibbles
or suggestions on individual patches, and I've given my "Reviewed-by" on
all patches.

Michael

>=20
> Patch 1 contains the minimum security fix, and is the only patch in the
> series intended to be backported. hv_ringbuffer_write() copies into the
> ring at the write index, so a malicious host can make the guest write to
> memory outside the ring buffer. This is reachable on any channel a CoCo
> VM accepts.
>=20
> Patches 2 and 3 add READ/WRITE_ONCE annotations and refactor the helper
> functions to allow the caller to work with a consistent snapshot of the
> ring buffer indices.
>=20
> Patch 4 adds the rest of the bounds checking. The memcopy() in
> hv_pkt_iter_avail() can only result in an out-of-bounds read if
> rbi->pkt_buffer_size exceeds the ring's data size. KVP is the only
> in-tree channel whose max_pkt_size exceeds its ring's data size (16K vs
> 12K on a 4K page guest). CoCo VMs reject the KVP channel, so this bug is
> currently unreachable on CoCo VMs. The other paths patch 4 checks can't
> cause a bad access, only a nonsense byte count or a wrong signaling
> decision.
>=20
> Patch 1 applies cleanly to v5.15 and later. The unchecked write goes
> back to the original driver, but the host is only untrusted in CoCo VMs,
> which Linux has supported since v5.12, so patch 1's Fixes tag points at
> the original driver while its stable tag starts at 5.15.x.
>=20
> ---
> Kameron Carr (4):
>       Drivers: hv: vmbus: Bounds check the shared ring buffer indices
>       Drivers: hv: vmbus: Annotate accesses to the shared ring buffer ind=
ices
>       Drivers: hv: vmbus: Compute ring byte counts from a caller-held sna=
pshot
>       Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index
>=20
>  drivers/hv/ring_buffer.c | 112 +++++++++++++++++++++--------------------=
------
>  include/linux/hyperv.h   |  58 ++++++++++++++++++------
>  2 files changed, 94 insertions(+), 76 deletions(-)
> ---
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

