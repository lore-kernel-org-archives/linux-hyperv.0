Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012017.outbound.protection.outlook.com [52.103.10.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8413AA4ED;
	Thu, 16 Jul 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221410; cv=fail; b=n2kShvKcaTnfh504LRdSxFDn3n2B+6nm2o7nIXXOupr08aEg5hKgIroF98VwctJs9xeYGKSOdz2z0Loc6ka8b0RJQTPSoMHBIUOeBOQXdhhge0ulqIb7riZu6+GoU02EDH9oI84NPpV+cTHnf1AHBmNGAtI8h3WZLEFfli64Xgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221410; c=relaxed/simple;
	bh=sQHHIAqIAY+r0FzBbgBAHWnAlGsssyakeJi0CJiHf0o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DfnpMKCD6Sn4fc516Guey690tpoLXccPSaoE+DZOhi+Jt8PcS2cb2udeE8PPdNfTz6e4ukPAz6X4INdTb2uZKn6sdW57tPrOVKYfFxbvz/Dad73Q3X5iS15SMj8n7FsELoMreKYNybokcflKe6q6Ux8ypi1N0MNuSZJSz5Iweu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZD41jBZL; arc=fail smtp.client-ip=52.103.10.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZD41jBZL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO7gJ+oMS6rAbFlzZdq16EBumSMETJoDiNwfav7pQU509RQZDq9CSAL8kzLgYAvEuYNaa67DtUi/oBImVcUNTOb3XJldAqfq7URMAvm/3nCmM7VIzgJdcQEEfF1NGrMZ1jUX9nIdGmQgy4w1umOZaEPavcPXXLWKuYcbK2csVqSIT9tpAaQ9cEihjpbKP6zn+8qq6Y9svXcqBqQWI3/jNC9lHZ0iWVUYz2zaN91zNpK0tWYTQFdqzuiLJbCbQwr2jIhYV/Ldi8pnxSu5RA6l5xOV5zb4oey6gkWDPk9+SNyYkvef61hjP84/cxSUIWu1AqkRqiWbKH8QjVG/qvHo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuPWWnUZfHfQ/LBhu+VhZinn8O+v5da4a+T5fRYZBQA=;
 b=tmXiCb9wcE5JtfIVDhKKRFmkrmR2GdVRN0j7TyzLhkJq8xTKuurRSr6MxTmxpAsAzoJ1icC1NdubVHLLQN0oVd4m4pi/P3yo/x9d44simha0847DE7p0DYBhBe3vodlzGemlwhZmB6Pwmlq5sYMI0ohBgoX/DyN1AxrycIzDu+h5cK4SNc2fZOyjpZ7SqQd/1jtqIEN++zz52ZzRsuQvJOcp10lxlYL+TgS919anY0I9r5qZGXWqyHuouteTGRBe/HbsCu8rdn2G9JuB4P2UbRwj/CEwdDT3dgSpSraLcMIqG1SORvWm9wnVYqfpnE5R9I/rxDYSUO+zP+A3ojMNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuPWWnUZfHfQ/LBhu+VhZinn8O+v5da4a+T5fRYZBQA=;
 b=ZD41jBZLEdAvwZLzSlp74sB8AGHbh8sVWNZO9SAWDxAuhxlHmimr5hxGVb0kGU5uVNzrL73x46RzSa3LnOD5v8CMNz9G1CKF1pdkRMIPh6l5JQ4yHKxD2zeXNDtMjmeCpNtLvZ6fAEbwcQuw6fZM70ovjFBGS70H2TrCSk12mxN7SNJhp3aaGF2qdayrhZQD342zkZ871sNuiGnzjVvlDURqUPV2LyJe/3eqWqbXIJMnutec/vNiFRNBLrxdHm4KInLeNro+mtQE7aNu62ioIPbix7Ki9v7hHe1DR1nRMKGS29daCRhqYkWX5mgWC+aKOSyBonR0mecV4E95VP5GrQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV4PR02MB11002.namprd02.prod.outlook.com (2603:10b6:408:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 16 Jul
 2026 17:03:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 17:03:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hardik Garg <hargar@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: add VTL2 redirect connection ID
Thread-Topic: [PATCH] Drivers: hv: vmbus: add VTL2 redirect connection ID
Thread-Index: AQKcg2BY/mm1TXQy8iVBNP0RmAL3mbTxeC6Q
Date: Thu, 16 Jul 2026 17:03:23 +0000
Message-ID:
 <SN6PR02MB415769F6F2645260C8D5778CD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260714213838.3367103-1-hargar@linux.microsoft.com>
In-Reply-To: <20260714213838.3367103-1-hargar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV4PR02MB11002:EE_
x-ms-office365-filtering-correlation-id: eeb430a0-509d-49dd-ce35-08dee35c257a
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799015|13091999003|51005399006|19110799012|25010399006|8062599012|31061999003|15080799012|24021099003|37011999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KnBSpa5BTDvXt35qx6v8yP3SKuWoulq5mJc3YbYWEoNYpJthIzJoCRu4CsJX?=
 =?us-ascii?Q?D3VYm+QZIsZ67DSBHGPpHln6DWBYdypnmvLPfnGSBnkxqgEeVhnDi8BqsGT2?=
 =?us-ascii?Q?O4fmMC9+CSQ2EO4z+AknwU5DmzXXcylLnTK/S1qF+DF+c9FF56qlNEuqUReh?=
 =?us-ascii?Q?fTI11TSiqK4LxDSRLzbiTqXg1Glzukl+P0vclf+JXilyStpZn+GQOOThxlQP?=
 =?us-ascii?Q?n2zy9+n1MSMj0mC3HwVB2QMFTdbJx6fRWq90bQCjZ4ETddTcm8Wt2mKUMDXb?=
 =?us-ascii?Q?3FHH0DI91GJyzlPZRQ6FBoZxjW3zL2p6C0J88BGnvAG8JzOaIdcXmyn5Rg5/?=
 =?us-ascii?Q?Gtev1t06e6JinfYlWNn/efSSNRwiu2ZuualWaUF8GQNq7IoeosqrrpYt63nx?=
 =?us-ascii?Q?7mEsdXhXk5Vc/5KTRQdBdcOdjsxcW5d0hMoGjEAi/OC05HqZxHmvhK7h4kTj?=
 =?us-ascii?Q?xf6G0KkUWOhAy8CzQHfzt+z0VjhEe7SUBfCR9BIr2u8bFb1qD8fExo/icA6t?=
 =?us-ascii?Q?8NkUINnX/3SnuNB6Du1xxA4OcBzVYyvGhjcjekW1Mz86IY1oeONqRIfHgl+x?=
 =?us-ascii?Q?akKPxjICXjWKhDD95rgB3/zwz6ndcVW8rEv3j4KMrne2+hplC1COKfRykPhc?=
 =?us-ascii?Q?KxEC9Q/oRt3s186s8DG3vHUCvIAalxqOLKP0p/glJZu9NMZQNw9QN2g+jNwd?=
 =?us-ascii?Q?dCmw5/7+Yl6nITFCFEjhIs3yybstjxqppp8Z+wFAefAnwbpE1lxBQ+LJU4A1?=
 =?us-ascii?Q?cYu/4zIPsF7KxaXjYM/rVr/9nLcjDAVYLdv5NmcAOZvn0asYeMPIb1Edf64P?=
 =?us-ascii?Q?su4AR5i1RFZfhqVDhGQHmrg5ZcxKY+0rRV2jYBRyb4uec3DyVLqIG15fFvkZ?=
 =?us-ascii?Q?Y+HXc0d8RWc8REO6hcNdqjZff89eZHnJwkWA8wundPSDaGJK4CNmZmSb1FHD?=
 =?us-ascii?Q?8TfSIBvDjdwUZfesNLxPuwgOSv+A8ReKyNhDgfqF5Z+ADrBti3Y0PQl7GRwW?=
 =?us-ascii?Q?HBFChGDJd85zcM0IGohcBYDDuWlaOKcYtT+nvKZIWuuyz9Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5WdaEMGQ1WhzJSTDaTBdH9ewZTm4Vc1KiCQrZ5vYgnOegUBbmxSqodxPr/FL?=
 =?us-ascii?Q?73gaIiWCeBRiOjjqL7FseqQ3I/9vJiX9V3J9fE98SOZV8h1WoA1gYmG6Y+Ux?=
 =?us-ascii?Q?DYnVwHVoqdelbVc2Tp0NpNQAA8XjbPpso7gT8piaf0oR71s4XLWJjV+tAEnk?=
 =?us-ascii?Q?K5DtLOQlELbMjJ0w3p3yVgSJ5HPoRhhUcg8nLPVJEFAn49PUwPxOaSx/pRgC?=
 =?us-ascii?Q?U3hUTPp6QhXGInmTY/WuAOZPYVc81CtD0e0Lol4VDU8X2BA/zITDBqtyia4D?=
 =?us-ascii?Q?NyLoj+QmldFE2KcF6QzSEVbhg5+vX5qrA6LsDbqutRL1S6E/XZJeWjSgYW3q?=
 =?us-ascii?Q?SxPhGsWpyafmbsyK/MovJnM+FXPtLrBmKvj4pYSah1JFJ89fqUB7zXLDuhTv?=
 =?us-ascii?Q?XqXfnDE6PkeSJ+k2oiyj5V4fMDIyP/pBdAzFgFxYrS7ndQ0Ap1dDKWPr4rwn?=
 =?us-ascii?Q?euQjxbEhQ9Mm9FNEFA/lXrb2hXNIprDFKNVk87zO5DS5N5jg51ZbMkKPZvzi?=
 =?us-ascii?Q?saX960uhH/qVYwA0lySj9FJzGYn8CA4Kwfol4VjevaVTSHiMwCseVi+Lc0xD?=
 =?us-ascii?Q?yRJET9oJvdWHTUJpnmLRJGHgSeyAIjvkvQEEyAhRMO+Tr//MbRb2YSnIVyRO?=
 =?us-ascii?Q?a07G61PD4KH6mmcbOWqOLqDPXz6BGVjqxPTHmjNhVz/5lrmzJA+LqPYDUR8t?=
 =?us-ascii?Q?YLoxcig2zppqcHWJdD2Qy/u+8PQ2TxL07hDbItnyAKTrCQw31M61W/HBXwzV?=
 =?us-ascii?Q?n7tZynZOcH9BhrN9iSUFOgqovytYCKLpXprRfOLBgoDopB6qMjC3vel+b1a+?=
 =?us-ascii?Q?pYm4k5JASoRnV6HSecbKVYONqU+TUZuWwfr5I2sL/0DJYf7f+uJPWUt49NW4?=
 =?us-ascii?Q?6cpfPRMpgkPATBtJJ/3CjWj23KbyDgmCVfQue2eoPjXIycC76R3zZi2hbJcU?=
 =?us-ascii?Q?o35I1ILAATdg0KXMd1F7Xuwb4a2f8YUddpebYSEuFnY5yn6xY3OHTsCedIaq?=
 =?us-ascii?Q?ffS2+91cdE9s6ZoTNRAve4UKa5Ap8tp/FFOUjmHCoXeb3i+F+FkZ0j7gzlDg?=
 =?us-ascii?Q?XULOChcYkozskVvn3/hhm8ZDNiya0r0iA8a8TBmiQNlJOSpBUVsXHyMQozfy?=
 =?us-ascii?Q?6tnU3AV7HQQEHQug3p3en6mbYEb9a7D8FtaxjZUScKJevYJa5FzTB3eRn4OV?=
 =?us-ascii?Q?xsMzJWViRcj/CX5B7Nq7xDAIZbNJ14rnaSAcXR1G54DLyaGWxNSIKc+Cspdy?=
 =?us-ascii?Q?8EgxiJ/zt9Wigg4oWdSL5cR+MfKpjzHVTAniq4uXcVWHZWqivCDv0FC7LVge?=
 =?us-ascii?Q?LvRcFKYiKjVTSbGybbSiRI04xVRu8VyCHZgeT3vP8YTtB+fAD2C6VdCbenhH?=
 =?us-ascii?Q?Wt/I8hg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb430a0-509d-49dd-ce35-08dee35c257a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 17:03:23.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11002

From: Hardik Garg <hargar@linux.microsoft.com> Sent: Tuesday, July 14, 2026=
 2:39 PM
>=20
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
>=20
> When the Linux VMBus driver runs at VTL2, the VMBus control plane may
> be reached through a VMBus relay instead of the standard host endpoint.
> In that setup the relay listens on the redirect message connection ID,
> and an Initiate Contact message sent to the standard ID is not delivered
> to the control plane.
>=20
> The connection ID selects the Hyper-V message port used to reach the
> VMBus control plane. If Linux uses the wrong port, the host does not
> receive the Initiate Contact message.

This is a judgment call, but to me the previous two paragraphs are
explaining VTL2 implementation details that aren't necessary for
understanding this patch. Yes, in earlier discussions I asked questions
about "why" all this funky behavior with connection IDs, but that's
just me as a former Microsoft insider. :-)  Details about VMBus relays and
message ports are fairly obscure for people in the general Linux community.
It would be sufficient for the commit message to simply state that VTL2
may respond on either of two connection IDs. There's no separate indication
of which one will respond in a given VM, so it is necessary to try at runti=
me
to see which one works.

>=20
> For Linux running at VTL2 with VMBus protocol 5.0 or newer, try the
> redirect connection ID first. In VTL2, the redirect connection ID is the
> VMBus relay endpoint. If the relay is present, it accepts Initiate
> Contact and completes the normal version-response handshake. Systems
> without the relay reject the redirect ID synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to
> VMBUS_MESSAGE_CONNECTION_ID_4.

Is there a reason for trying the REDIRECT connection ID first? Or
is the ordering of trying arbitrary? If the REDIRECT connection
ID must be tried first, state that as a VTL2 requirement.

>=20
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. For older protocol versions, and for Linux
> below VTL2, keep the existing connection ID selection.
>=20
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  drivers/hv/connection.c   | 76 ++++++++++++++++++++++++++++++++++++++++-=
------
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  2 files changed, 67 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 1fe3573ae52a4..eb871f87a819d 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -71,7 +71,19 @@ module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
>  		 "Maximal VMBus protocol version which can be negotiated");
>=20
> -int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
> +/* Connection IDs to try for VTL2 VMBus protocol 5.0 and newer. */
> +static const u32 connection_ids[] =3D {
> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT,
> +	VMBUS_MESSAGE_CONNECTION_ID_4,
> +};

Using an array of connection IDs to iterate through matches the
design of how multiple VMBus protocols versions are tried. But with
only two entries in the array, this feels a bit over-engineered unless
there is reason to expect that more connection ID values are coming
in the reasonably near future. Absent an array, the code in the
vmbus_negotiate_version() could just hard code to test the redirect
connection ID first if running at VTL2, and if that fails with -ENXIO,
fall through to the normal case.=20

> +
> +/*
> + * Send one CHANNELMSG_INITIATE_CONTACT attempt.
> + * The caller supplies the message connection ID and owns retry/fallback
> + * policy.
> + */
> +static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo=
,
> +				   u32 version, u32 connection_id)
>  {
>  	int ret =3D 0;
>  	struct vmbus_channel_initiate_contact *msg;
> @@ -87,7 +99,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginf=
o *msginfo, u32 version)
>=20
>  	/*
>  	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we mus=
t
> -	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
> +	 * use connection_id for the Initiate Contact Message,

This wording of this comment now feels a bit awkward. How about:

"For VMBus protocol 5.0 (VERSION_WIN10_V5) and higher, use the caller suppl=
ied
 connection_id for the Initiate Contact Message so the caller can implement=
 the
necessary retry scheme. For subsequent messages, use the Message Connection=
 ID
field in the host-returned Version Response Message."

followed by the rest of the existing text.


>  	 * and for subsequent messages, we must use the Message Connection ID
>  	 * field in the host-returned Version Response Message. And, with
>  	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but w=
e
> @@ -99,7 +111,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msgin=
fo *msginfo, u32 version)
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl =3D ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
> +		vmbus_connection.msg_conn_id =3D connection_id;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
> @@ -161,6 +173,51 @@ int vmbus_negotiate_version(struct vmbus_channel_msg=
info *msginfo, u32 version)
>  	return ret;
>  }
>=20
> +/*
> + * Negotiate the given VMBus protocol version with the host.
> + * Protocol-specific connection ID policy is handled here so the single-=
try
> + * helper stays simple.
> + */
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
> +{
> +	int ret;
> +	size_t j;
> +
> +	/*
> +	 * The redirect ID is not a speculative endpoint. If the VMBus relay is

What is a "speculative endpoint"?  And per my comment above, I'd drop
discussion of VMBus relay, and just phrase things in terms of trying the
REDIRECT connection ID, and if that doesn't work, then try the normal one. =
=20

> +	 * present, it accepts INITIATE_CONTACT and completes the normal versio=
n
> +	 * response. Systems without the relay reject the ID synchronously, so
> +	 * negotiation falls back to VMBUS_MESSAGE_CONNECTION_ID_4.
> +	 */
> +	if (version >=3D VERSION_WIN10_V5 && ms_hyperv.vtl >=3D 2) {
> +		for (j =3D 0; j < ARRAY_SIZE(connection_ids); j++) {
> +			ret =3D vmbus_try_connection_id(msginfo, version,
> +						      connection_ids[j]);
> +			if (vmbus_connection.conn_state =3D=3D CONNECTED)
> +				return 0;
> +
> +			if (ret =3D=3D -ETIMEDOUT)
> +				return ret;
> +
> +			if (connection_ids[j] =3D=3D
> +			    VMBUS_MESSAGE_CONNECTION_ID_REDIRECT &&
> +			    ret =3D=3D -ENXIO)
> +				continue;
> +
> +			return ret;
> +		}
> +		return ret;
> +	}

Per my earlier comment about not having an array of connection IDs, this
code could be as simple as:

if (version >=3D VERSION_WIN10_V5 && ms_hyperv.vtl >=3D2) {
	ret =3D vmbus_try_connection_id(msginfo, version,
				VMBUS_MESSAGE_CONNECTION_ID_REDIRECT);
	if (ret !=3D -ENXIO)
		return ret;
}

> +
> +	/*
> +	 * Non-redirect path. Protocol 5.0+ below VTL2 uses the standard
> +	 * v5 connection ID; pre-v5 ignores the supplied ID and uses the
> +	 * legacy connection ID.
> +	 */
> +	return vmbus_try_connection_id(msginfo, version,
> +				       VMBUS_MESSAGE_CONNECTION_ID_4);
> +}
> +
>  /*
>   * vmbus_connect - Sends a connect request on the partition service conn=
ection
>   */
> @@ -455,17 +507,14 @@ int vmbus_post_msg(void *buffer, size_t buflen, boo=
l can_sleep)
>  		switch (ret) {
>  		case HV_STATUS_INVALID_CONNECTION_ID:
>  			/*
> -			 * See vmbus_negotiate_version(): VMBus protocol 5.0
> -			 * and higher require that we must use
> -			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
> -			 * Contact message, but on old hosts that only
> -			 * support VMBus protocol 4.0 or lower, here we get
> -			 * HV_STATUS_INVALID_CONNECTION_ID and we should
> -			 * return an error immediately without retrying.
> +			 * Let negotiation distinguish an unusable
> +			 * endpoint from other failures.
> +			 *
> +			 * Other messages keep retry behavior.
>  			 */
>  			hdr =3D buffer;
>  			if (hdr->msgtype =3D=3D CHANNELMSG_INITIATE_CONTACT)
> -				return -EINVAL;
> +				return -ENXIO;
>  			/*
>  			 * We could get this if we send messages too
>  			 * frequently.
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 49a72a4f3f6a7..951bdebdc0526 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -109,6 +109,8 @@ struct hv_input_post_message {
>  enum {
>  	VMBUS_MESSAGE_CONNECTION_ID	=3D 1,
>  	VMBUS_MESSAGE_CONNECTION_ID_4	=3D 4,
> +	/* VMBus relay port used for INITIATE_CONTACT probing. */
> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT =3D 0x800074,
>  	VMBUS_MESSAGE_PORT_ID		=3D 1,
>  	VMBUS_EVENT_CONNECTION_ID	=3D 2,
>  	VMBUS_EVENT_PORT_ID		=3D 2,
> --
> 2.34.1

