Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012054.outbound.protection.outlook.com [52.103.2.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF843148BB;
	Fri, 17 Jul 2026 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257121; cv=fail; b=qj1ZJ/EJWk8OFlEPNIXfI849vfP7eSCJ6zqc5cIOgqXjGC3EebqovrmvKKFkJ9imqlBUXuWJ5FjsPR2H1gP90mZO+Jnba13U5WbhvPQsoxI+wpeJDorgsdEkSQVPjXFLGeUWzVsxJmSUEB40gPxQd4bjLTZ719SsK68I4Qf5vKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257121; c=relaxed/simple;
	bh=022gookmoc3IAtNAWFLDujK+TUak3UpoXrHskE9Zbj4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IkYhuGb0NWKqJVPJCruBWLc1+h6XT2adKpP2daaBA9W5WWWofXjtDo+r4x9p+Fy46vnXTXxdaCiC03YO4a4hskFp9IQQbj7CUfU4Mcj+qQlaGjOOGfpaq5QDA3eCxIz30jxRjFWcpED6qEa8B8mHvJ6+Bv3taujnvnOmVOt2Fw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e2EfDLpQ; arc=fail smtp.client-ip=52.103.2.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e2EfDLpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUZVYNSK3piPtdzz0DlQQ6si8hxgYflmUtCYN8AOtUUjJz62FVlU+qknsi3ZxzeUtLxfJT+7Y1QnQ+qC34V1POYCWp4Xfo6SUF/TWgGPrDDXOlBLBSW6fQ9o3ZHP+4e1FORBYk088xg4ZHhvsTjNlHsUVNbrR8/th2JEQPW2uLA3NrootCo56vToTNUNDDeTSwUvyF+pwD2hH3IVPuHD5zJ/wgteDZzZinXYIGiqoJLEWh88/wDplbIu9fv67VtbfHgjUBFn1pVhlsIQMVDY2sGAG+mBDdi2RpVBlLt1CbpBE7iVyKADgVNBVz+S9jQy6Ld6VqI62EK0t4W/nsegTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88cvSeXgV1Kq21w+jRsFrf35zciMHRIU+F7dY2eyccU=;
 b=QHlj7pvg890CV7uuExxzNbWqSFFkkA53UtEmqjxihmU9QFYFc9L0bIS7rgrNXvZosKX1urfBdDOK5tr3LWc1BOpiKgNxEPDO6lvoEIotMHbIZV8P5oJFcz3x73IJq//nr4mSPlm6nK/LX2lxW8cceWwIfPJ4o+eZVRbKpoNC1j6Jb4Z2IgWCJ4KVbw19E32Pdf4Qe7YkpJqXWxZYkjfrffETmRiTA5tqNBtGjQR8V0fCXzNxyhJrDIrM4T/qSRC2riyfDwmkyiqhA1bBr8sgmfMwY1kdYGCZghKS/YpcGAVJXfyBJiFD346QK63Oj47adcB/PKf0XAykeV8XO4pviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88cvSeXgV1Kq21w+jRsFrf35zciMHRIU+F7dY2eyccU=;
 b=e2EfDLpQSemMAd38GUsBnt2CN+AbkeC//bZ5FAu+XmYghvebbvYX3p+U62jQc1gYKIlgCRuaX/zKvt2KA05CUO1D8bjewu5xtX8f3vv5hbuSGU45NHHiqipWVkblPz2kjMje8hcjv5rbfTdK83p+KiKKNh6Pp68swGkxzjNx5IPGRw7GCcYbv8jvEUNBif3OX1rj0rD4+bBPpHqqhlHXlhq2r0fryiCnjlBjxadKDo/ygurUBlEO2ZZdc1OkiT03UT5JovUzmP3DlaR54RjLTew5OOGA9YxsxI94OgyHZj9qFcIkHqKPAOHjF5xCBy+8L2OlAjz5bh6qKQJAwP7z+A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9226.namprd02.prod.outlook.com (2603:10b6:930:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 02:58:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 02:58:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hardik Garg <hargar@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
Thread-Index: AQHdFYHUnCHsJbzBb0+fazAB7+cNuLZxBUmg
Date: Fri, 17 Jul 2026 02:58:35 +0000
Message-ID:
 <SN6PR02MB41572AFD76A1C140CC466B89D4C62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260717001837.635756-1-hargar@linux.microsoft.com>
In-Reply-To: <20260717001837.635756-1-hargar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9226:EE_
x-ms-office365-filtering-correlation-id: 09cfc29f-22d5-4bd9-6e31-08dee3af4b14
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|12121999013|8062599012|31061999003|13091999003|24021099003|41001999006|37011999003|8060799015|55001999006|51005399006|25010399006|10035399007|40105399003|1602099012|102099032|3412199025|4302099013|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QK6KvredG3iuixKWOzVIntARPPBKfNPipRZ0ZC1uZTC57H+9zguSGKO/1ilY?=
 =?us-ascii?Q?Ql5q75Ho3gyBNt38Quhl5j/T19zmXoQYLCYtEylI67ERz2QP7YezB7OuXmsV?=
 =?us-ascii?Q?yhYEgiU5zDVJXjry2ngut1UearIb01q8AvzySWgpEm4qFFsbiPxXaHZd1e9G?=
 =?us-ascii?Q?BFwkkHqFua1AQhwHpBXzT9VNzVGkl3fc50sluthY1G5eojCVHRrJNPK7SIrs?=
 =?us-ascii?Q?qxSZlnivl+MbhMQnke1/MHpZBQJJwsdjHFDqUMMg9MvMChWbRGAJMKenTwNT?=
 =?us-ascii?Q?jDcxeYcUR4DOowPQf83FWZh4VIomB2c7NZswYu5MkhNSVpiFyr4i5IB5FDnv?=
 =?us-ascii?Q?3OnMEXMuy7hCvyYVxhHuGxYkbIASJK4YGNp80U/qX3hyxWXKFnJqthqLTpMA?=
 =?us-ascii?Q?I1suVF3CtT2VdhfdrrPSYER+yGPb0gOTPh1yXmi32/HgjAIT4hGFbHz99Lg3?=
 =?us-ascii?Q?48oO153ow6xTcew8Y5/lQsWX80kyGyhxs6Flm+BKrOx0zHadjY1wHpLgblRD?=
 =?us-ascii?Q?tfPXwM+fenSZQPAxOBLGHAusCGyEYOJgqwC6QPRfhocnM1MjljnKnu0uaAXT?=
 =?us-ascii?Q?twb7VNRT4lc6z6XZktxkHMTZnxwJaZ4x5V7oxerzwXhReYA3CelsweymnuH8?=
 =?us-ascii?Q?egrIqyy+Y5KIPdw0ZWd4jWSFPtkFNK4068cr0zGwK2OldsLcsNTEmgFuHYqv?=
 =?us-ascii?Q?vomgUw98XjYzS9UlkKV1xnI6Eoo2vo0fSv9dXKIH3zAjpXlunvLMTuO4DRzc?=
 =?us-ascii?Q?yzZxbvObuVf4iwEvdZxOC7wjJuNtwBpGKMj8yBxoG0UEE8HvlmwXq+qTbMWu?=
 =?us-ascii?Q?7c2+kq7jqBHq5ACVZAO6UTPzRAJR7/ay0oybZAuicj/wnRo5ixl3cBvMQlsf?=
 =?us-ascii?Q?6XBfRZRuVWCMtOEorIo2K6JudFgN53PsXqg2smMRzR7FyNonAuwpxH4l59T8?=
 =?us-ascii?Q?6vkWf3D9YvEhx3/STQMKBCuk+kadjuzJNV/quNCrW/rYYkzDB1pBpVp4L7wK?=
 =?us-ascii?Q?SEoFB7/H3YU8s/D8ux3xzP6RzLhXhHABd/zF030Twt6mxO0FI6LoXyLU+9kj?=
 =?us-ascii?Q?h6SZTWXV4TeCbywtpzG67/r93N9r1u/vgCR69mc6WwXox5NQGlsG9cyAcFcg?=
 =?us-ascii?Q?DMaz1T7Wva6f1VBGcDnyJryWJq2clan4FC7Bx0ohAqiTHIxVM5QpP/ThOjHs?=
 =?us-ascii?Q?WXaQs7FH5YGkEdnhbvcTaJU46cL4U2f77oVvAQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ye+R+L6YTz0L6Q6KlM+A34vuiQsX3jkBICVh46tflbq3vn69ztWCVP4qas+q?=
 =?us-ascii?Q?krS1jngfqp4OjvIJ0kZTXIu4W0HST+8dAI4qGJAsbwFE4rSBe3sBIoYCddb2?=
 =?us-ascii?Q?SZ43qtWFViz85H8QjSBS9/t9elx9Lj5q1MNR4h2Bl1fQyAcKpLXLaGFyeVe8?=
 =?us-ascii?Q?LpDOBJ3AwnpbYOgrlHVFLKOhpU/0DJJcdQhyF+A15PBlc7WDwnT8M4StXhOj?=
 =?us-ascii?Q?4bTK1aPsbDfvIMbd5QNR/yTLiLOturGyp2+fpBzkOdy0UL5E/7AB2maV7E+2?=
 =?us-ascii?Q?YMEhc6t+D3Slj87n+JaOBv7+OTDFgO0DqMaj09aveUQo7QC0cqheXzUaJnY1?=
 =?us-ascii?Q?4lnlxsxj4z2HW/xcTe2QRXGAmrbOth+u6zvLZVFqxKLLBhYGxUt93QAh7iqS?=
 =?us-ascii?Q?d1XFx3dhzjyjgRcH1VWLAKck+JOTPneRpymCnAjCtO/m0BDlAXNXM3+60B+4?=
 =?us-ascii?Q?rgIvlRaFHRjqxszdUo4UFnpyYB755wt4OS5w2Q4JknONz/DSp/5i3mvxOL7Z?=
 =?us-ascii?Q?1CIHqEcvxPsBuU2aQXiq/+ruvIkc000AC3wPvcKB2gJA85P6vFfimKEr4N16?=
 =?us-ascii?Q?IshTdHEhejWgGs5OEDaOXeqlxDqpjmf9/WufllWNsa0ZvR7EiRgp8Rx2bRKF?=
 =?us-ascii?Q?RMR7F27V8OGl2AushNBETg9+iveXTPvrQsbrKM/BWmMAihUB/nn9e9wC6J7J?=
 =?us-ascii?Q?Jy+cMrUUp8VysWx8/iKnHzpEKWmKD3DnCWU7Y2+xUpHT+ws42jC503UPdxWV?=
 =?us-ascii?Q?ozM5/nSW17HIxfFNj3tIF4QCbIaC0IfRLJ623cNPIsDa1K4mS8ENxKhfecrI?=
 =?us-ascii?Q?BvfI0JJiRULTpdP9+pozWfNoerNvojsP5WdlKM+s923P3ZBIenJb46uBF0yH?=
 =?us-ascii?Q?fM90lsEaptN/iQc1gNzrNVHHecjkqBNAFg6ejuuTe9WS2rZOdXsFldwoC3ED?=
 =?us-ascii?Q?T6TUryUm18bld5stlacoQuPuuXkiIyf7VR5CN/SszFf3/LOfRaYXd9ZKqYA0?=
 =?us-ascii?Q?9gUEQ8XZ9AVSOi57Uq6o7kpWv5QW+2C1WJy8RLPvlYJfsd+FI0xfaxJMnLTW?=
 =?us-ascii?Q?+SdKISBHIMQoBrsSxZnvkyKlCfPYhBRt74Yi53+r9yWHz8uYqwRQT+oq2Duz?=
 =?us-ascii?Q?FQmGJqi3cy/vgdCIQJaTZZ8PkIqBHAKHids73FpcyNnxL3tw4WxgwS58ZiMO?=
 =?us-ascii?Q?EAG3HiNAJ9aPVs7iYZ7Zj3RNOWDwzvU/RztsVejNugJkC7qVD2tw54SxWfKG?=
 =?us-ascii?Q?7xPj1x1VvZsPaO85KJZG/rUCLweqzxyxPFFHI2XBkcSamf1mVilpiwvkcsoA?=
 =?us-ascii?Q?NdvcJq9XBhfksZmqZfU0qvxHRH5kXby8bIWPrYAw7hrR977sBeZZBVwsrCpz?=
 =?us-ascii?Q?uTUTGwo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cfc29f-22d5-4bd9-6e31-08dee3af4b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 02:58:35.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9226

From: Hardik Garg <hargar@linux.microsoft.com> Sent: Thursday, July 16, 202=
6 5:19 PM
>=20
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
>=20
> For a VTL2 kernel using VMBus protocol 5.0 or newer, the host
> may expect INITIATE_CONTACT on either the redirect connection ID or
> VMBUS_MESSAGE_CONNECTION_ID_4. There is no capability indication that
> identifies which ID is active, so the driver must determine it at runtime=
.
>=20
> During VMBus negotiation, the redirect ID is tried first because it is
> used by VTL2 configurations with VMBus redirection enabled. If the
> redirect ID is unavailable, the host rejects it synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to the standard ID.
>=20
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. Preserve the existing connection ID
> selection for older protocol versions or when running below VTL2.
>=20
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>=20
> Notes (v2-changelog):
>     Changes in v2:
>     - Replace the connection ID array and loop with a single redirect
>       attempt, falling back to VMBUS_MESSAGE_CONNECTION_ID_4 only on
>       -ENXIO.
>     - Remove redundant connection-state and timeout checks and the
>       unreachable return after the loop.
>     - Simplify the commit message to describe runtime connection ID
>       selection without relay and message-port implementation details.
>     - Clarify the protocol 5.0 helper and VTL2 redirect comments, remove
>       redundant comments, and use an exact VTL2 check.
>=20
>     Link to v1: https://lore.kernel.org/r/20260714213838.3367103-1-
> hargar@linux.microsoft.com
>=20
>  drivers/hv/connection.c   | 47 +++++++++++++++++++++++----------------
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  2 files changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index b5b322ce16df4..0fd50d4cb5739 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -72,7 +72,8 @@ module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
>  		 "Maximal VMBus protocol version which can be negotiated");
>=20
> -int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
> +static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo=
,
> +				   u32 version, u32 connection_id)
>  {
>  	int ret =3D 0;
>  	struct vmbus_channel_initiate_contact *msg;
> @@ -87,20 +88,20 @@ int vmbus_negotiate_version(struct vmbus_channel_msgi=
nfo *msginfo, u32 version)
>  	msg->vmbus_version_requested =3D version;
>=20
>  	/*
> -	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we mus=
t
> -	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
> -	 * and for subsequent messages, we must use the Message Connection ID
> -	 * field in the host-returned Version Response Message. And, with
> -	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but w=
e
> -	 * tell the host explicitly that we still use VMBUS_MESSAGE_SINT(2) for
> -	 * compatibility.
> +	 * For VMBus protocol 5.0 (VERSION_WIN10_V5) and higher, use the
> +	 * caller-supplied connection_id for the Initiate Contact message so
> +	 * the caller can implement the required retry scheme. For subsequent
> +	 * messages, use the Message Connection ID field in the host-returned
> +	 * Version Response message. With VERSION_WIN10_V5 and higher, we don't
> +	 * use msg->interrupt_page, but tell the host explicitly that we still
> +	 * use VMBUS_MESSAGE_SINT(2) for compatibility.
>  	 *
>  	 * On old hosts, we should always use VMBUS_MESSAGE_CONNECTION_ID (1).
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl =3D ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
> +		vmbus_connection.msg_conn_id =3D connection_id;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
> @@ -165,6 +166,22 @@ int vmbus_negotiate_version(struct vmbus_channel_msg=
info *msginfo, u32 version)
>  	return ret;
>  }
>=20
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
> +{
> +	int ret;
> +
> +	/* Try the redirect ID first for VTL2 with VMBus protocol 5.0+. */
> +	if (version >=3D VERSION_WIN10_V5 && ms_hyperv.vtl =3D=3D 2) {
> +		ret =3D vmbus_try_connection_id(msginfo, version,
> +					 VMBUS_MESSAGE_CONNECTION_ID_REDIRECT);
> +		if (ret !=3D -ENXIO)
> +			return ret;
> +	}
> +
> +	return vmbus_try_connection_id(msginfo, version,
> +				       VMBUS_MESSAGE_CONNECTION_ID_4);
> +}
> +
>  /*
>   * vmbus_connect - Sends a connect request on the partition service conn=
ection
>   */
> @@ -457,18 +474,10 @@ int vmbus_post_msg(void *buffer, size_t buflen, boo=
l
> can_sleep)
>=20
>  		switch (ret) {
>  		case HV_STATUS_INVALID_CONNECTION_ID:
> -			/*
> -			 * See vmbus_negotiate_version(): VMBus protocol 5.0
> -			 * and higher require that we must use
> -			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
> -			 * Contact message, but on old hosts that only
> -			 * support VMBus protocol 4.0 or lower, here we get
> -			 * HV_STATUS_INVALID_CONNECTION_ID and we should
> -			 * return an error immediately without retrying.
> -			 */
> +			/* Allow INITIATE_CONTACT to try another connection ID. */
>  			hdr =3D buffer;
>  			if (hdr->msgtype =3D=3D CHANNELMSG_INITIATE_CONTACT)
> -				return -EINVAL;
> +				return -ENXIO;
>  			/*
>  			 * We could get this if we send messages too
>  			 * frequently.
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 05a36854389af..87f8aca1a9fb5 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -110,6 +110,8 @@ struct hv_input_post_message {
>  enum {
>  	VMBUS_MESSAGE_CONNECTION_ID	=3D 1,
>  	VMBUS_MESSAGE_CONNECTION_ID_4	=3D 4,
> +	/* VTL2 redirect connection ID for INITIATE_CONTACT. */
> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT =3D 0x800074,
>  	VMBUS_MESSAGE_PORT_ID		=3D 1,
>  	VMBUS_EVENT_CONNECTION_ID	=3D 2,
>  	VMBUS_EVENT_PORT_ID		=3D 2,
> --
> 2.34.1
>=20

