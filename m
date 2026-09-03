Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA8364EB8;
	Thu,  3 Sep 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461339; cv=fail; b=ej5u80QknIbOeijRecmF+DWMSimQp2WxVpVDP4Ln2ArJsLBkX0iWBJ7q24eQHy6NJyx7Hqe5qBMCVD+RmK+FK8Ow7S4iphoKDlkerpwHKZJx9KpfNSiQ7HcEeFZmmndZzgcEVPEWyCtP/G+oIoAyv+IlEMmxTDqvTa4sEBP+EQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461339; c=relaxed/simple;
	bh=m5FxgVAm0bj3ZXpVJWKPHrrJKMNByuW508IFSFiU098=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsSC2gPwB1OdTPKk2UlOrMbot+N7bhGe+Euc8N6iFWjkU9zR0pk5MMI5GiF9/tWpD2QxEX7RaidX4pOQW2uszMY6LKB9VtvOReiOID8KTdLqvl4Mko+MFQ6LYNTMWiLhb+mxd9cu2dz3K2C4BhOmYwHC9sb0kyPye43jzOxSg1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A8QzXI9w; arc=fail smtp.client-ip=52.101.46.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A8QzXI9w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUcbqU5KpSqTHOcSk14wyEkcOrSQ+N+oAor+/ZH8rZdQyMfieP23quiJ6GzWni5Caim9dQ4M9jQo+WZLW8D8n44aLtmdOnmmETQeZxwTKwkBpp2EvAJ5G0qulnwqZMkHz8wUL7jG0RGVFiju+eDVOuEDPYpE4OK4SR6M86aJtAICqydaY0mh3QwJmJ2N2x5jf1BgkfYRQ/ca3lzR3Ty65d8S8lFsITclaBI2z9eHbYoLAopWxmwJYSwhjo/Ew5dfipK3jzIKqXwxcaHluo9/FmqwwIXafpynvdOetv+IudGS+UaPW6jrgp7olfB0DUu7KdLoBDPA1qs8XIiONwJ49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDPSCVS1zmNluNYT4E9Z9GeKJa63Ki2jhW3ayqVTrvo=;
 b=p3Eb8PqfARRB1aeKR19DWIh0hhAj05dBOKl0PSCo5++VdoF7uPQh2Yp2eBpqYaTyq3LvVaSmS13f39exZuhf2nR/hNf/0N4r6TNvJ7p6X9t1ySTKIM2oQVNiKUfwSjjRpZHWbb7tJcVV4UJgXi4Lkxt1+dStXSENiUulV21Aklb3QILs5ijDqN1M/keZvcOe2WlZqcDmNRCqfK/seKVl3hr8GlPxbwlVKVYrvHJ/nKTpetJeDJDPBSNDWM8HZoMCV/2XVcW7M43zW8R/ZFTlYfJK+l+mnXjPkyZHYGLvFtjWfE28i0Nm8t0b0Hrsrqm3JqGJwe05JP7CZNhhMOFG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDPSCVS1zmNluNYT4E9Z9GeKJa63Ki2jhW3ayqVTrvo=;
 b=A8QzXI9wUuzyCxXxc9xQsZ/DQ+J0fF7lsER5Tp7piQqnZqtqH+XjTtWoXQbPxdRZzxcnKqFfMO9Ao9XLWBYUnmqaukIaqsSz7AQBnnsZE4PF3Xe7KOuzBRjl1NBKZw732TzwODODXxGC6h1szjyhg/YyPephR8PgWI+5uzaShAs=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6320.namprd21.prod.outlook.com (2603:10b6:806:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.0; Thu, 3 Sep 2026
 18:48:53 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 3 Sep 2026
 18:48:53 +0000
From: Long Li <longli@microsoft.com>
To: Manish Awasthi <mawasthi@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "gargaditya@linux.microsoft.com"
	<gargaditya@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "kees@kernel.org" <kees@kernel.org>, Paul
 Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
Thread-Topic: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
Thread-Index: AQHdO9PNz3ZVfHQbbEOumL2rzaKMR7a9MPbQ
Date: Thu, 3 Sep 2026 18:48:53 +0000
Message-ID:
 <SA1PR21MB66838C5E837A31E5122247A5CEB62@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
In-Reply-To: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1921503f-58f1-4eda-a5df-c171bf4955dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-03T18:44:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6320:EE_
x-ms-office365-filtering-correlation-id: 0bdecd8d-bff6-4028-99a4-08df09ec004f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|22082099003|18002099003|11063799006|10067099003|56012099006|7146999003|38070700021|921020;
x-microsoft-antispam-message-info:
 2wVJVSxgCxLX95IBiuM3/E2oBIiK9jUTMCD8qSGLE0FTD202sqKKaOES6BhEyMhXpRbPxeMpUevgPkqlRiX7+82qI5CLYvP2ePi0zXgpaIdFIXRz7ZFoY/O71rUgWIS/PMmMoGYnln11lKh1M7E6+CIoMFdwCd3UezZWInS2wkeY9nIOdyW9G+j3LOWX20Y+7/qrcA6qo/2kHCOotkCf/+MzgtwJFMd0BZwtbdku56OFHqyZPhCEZClzmwWUOYfT4g1f2bCWh8tAAs41RQZyZO0/KTg2RVcbPD4wAJfYKHmnPNefO5vW9hMQ3/uuZUZUByZDzydte/UsBMoqbMeI0M6CNMBZiUc15yR8lyOj/mIvrG1cd2rBR+l4N+BdKdj2gf8rV/J69nW5aiXeoeRuP3FqfK9QN7Kw5CKka9nFes3PHeERpo6WtjU7SBZWR6UdJ/Ac69i/sKC7Sw2b2kGaYiK5+ypXS6zNwDLXoi1M/jMdflPnYA7gM4vihr4Ps+aARVvTGqFXa3ZpZJ/CYDAREkpGx7pGwFpH0WdAcd9m8/HqX4JOZNIF7btdU0/346juhxqdG+O3sqBWdbwPftg2kcVR8n71jyfCHH4VFHyYVc6NdRt7m39wwuSsDD9IfHNSmvpk8y4pXv0AWOQLNWmniKntro9RGB2lUWodGQBIPfB+seUoRPPn5gSKD4HKtGTa+Q3xYfpkNn4QaOfurVaOTEtvLUb7A/ug1oZU5izargaDU1Rb2jHM3UcMPsKUXlqZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(7146999003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v4YXDsPSVt9hJHKPUUbK/SxoR/bfV4iSPeG+sSjJ0akQ2CmeCpllQ3AXcfNA?=
 =?us-ascii?Q?ESc9pRIF98jNXsYT+j7FR926FNkMg4ip7fbjvIDBcMRL4GoqWRnTIBGRO9Qv?=
 =?us-ascii?Q?eqe/OZRTWXJuykrgX61na/xuLgTLE9VDgKmK8gEnftg7q7sa7hgkgxlNoO6A?=
 =?us-ascii?Q?eOlnkhgCS7VO1CFdBKgOyIHlZRM6OJb+sdLMjqbQOVggICDnPy5x4QOPOguy?=
 =?us-ascii?Q?7CuXM8bholt/lzFTqJmDfw/sKHBs/UhcMzpPX+96YtC1rqSbIpIQ1gdnDNqm?=
 =?us-ascii?Q?bmQZC4QyaP2VY+jaDbNt9H19WoMETeyoWexBr4gf/zIr7+9o37o1sw+xlXdh?=
 =?us-ascii?Q?ixpZGXbDuz+0EEXNzWuc+OKwGVcJiadhWvrgFhw6cSRbYvRfydDTo1Bhu2pj?=
 =?us-ascii?Q?RpqmsPzeOGYvJFMjAbw/X1gAN0/qB+q0wxiIwPD3q2Aw9cYQZFIWu1J8+AjP?=
 =?us-ascii?Q?bQZMkBDq1FddGzBmVC4WndVHvsfMKAczZA/VVmcOdDg3r8019XxUR5IDmeid?=
 =?us-ascii?Q?EoJG/re45sVugn/68/tjqSD9yZzJmm7V60gQqNW0GY0dQL62R5PNQqZjfok2?=
 =?us-ascii?Q?1LcJYzS/BwHGY7sBeReNJf/tUFj+SIj57EPPkp6v+TQCrvFUABNx7GjHSkWJ?=
 =?us-ascii?Q?3C0vcl+DVSlUVBWgu5POfzi5p/ubPkyJDfqJEzJ93SyCU2SMGbmo2WW6nIdq?=
 =?us-ascii?Q?3gbdA0DAcf3PWwPLjp9Gmlx7+QIS64dsfnkvD7m+/3Hjh9iVkVjQseb+llQE?=
 =?us-ascii?Q?l7FrjsIbQLKdZ8tyLh6JY29jfouoX31loFmRJ9M4aAk3rcgP1ze5YGgFC7Ns?=
 =?us-ascii?Q?kWj15ApaVvQ49T2c1T8HhtmJmbb108rEARTaiA/ait920MapL/HGUm21JKea?=
 =?us-ascii?Q?VQGh6uXO9IVvKX1CoNypm83JOQ1h7fpyJo1nUZIyfe4Z95LsEvYclXJ0LV6i?=
 =?us-ascii?Q?yxlZCckmGnmfe2C5AeWKKnREWcw8nN85TejgdyNHX701AKfUn0c41cCZpygI?=
 =?us-ascii?Q?N1uFf2644bhX6b9Fx2TQpRKw03Q95TDSIQFujqkU5hnAZ9ZeusE6OFEc4+W6?=
 =?us-ascii?Q?gR63MXsOdh9OaCdA91CBLeF3UoK650V8/l8lGb3vdTws76x6KYPAJ51gDQHN?=
 =?us-ascii?Q?zOhGSm4Sz8SgiI8pvBnYNwASiryzx9RalvcuTuTZh0AaDfqhOiJMod1o4u6R?=
 =?us-ascii?Q?sBJd9O9ipKXHP0b5xGsrFqtiQdcyxgMXfcJUacuBjGAlU4X/HtE7HOsHsna9?=
 =?us-ascii?Q?6rTSdqIVvsWjCebJWUdEDKT57CAnakBMcCo1yM5SYOkR+Kf9flyLSROtI8Dg?=
 =?us-ascii?Q?f54HyikuHID34UR9IXYgAYPeNbOaehOF3lWCrnGzENvoMRWpsxgPnvRxuwPP?=
 =?us-ascii?Q?bCLJfCu/E6/vn8yDAKRvyYzKcbOfn2xHJvCcS4rcqci9oKznJb8fxKpqg3m5?=
 =?us-ascii?Q?eQNmkJ4/7A8cq3iioSQ65gSw/3CTO4K5VsuBd7EZNMSEwXs21h7rXY3mndYx?=
 =?us-ascii?Q?fJsOBpcpYlbFcawdIG3hbuB+VeAKsO5QH/5YFWJpQgfugfGoX+QZusQe2gcr?=
 =?us-ascii?Q?JTb9xytK5eHDNGUNvE8FTz2SiCX5/MhGStMlg3fsrvW3/NPRPHgWkcL06nfx?=
 =?us-ascii?Q?LskoNaYAAqEjtmCQYCNReIle8b7oTGvQL4sRqzL038WmNw189olmlj7OfLpB?=
 =?us-ascii?Q?J7TF9jMOQyWoBRBJN1hX5aDekbq+bR2Xso8kQMeRrVILKm0f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdecd8d-bff6-4028-99a4-08df09ec004f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 18:48:53.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQgGTdOxiGPVaml5nXK4Ok6qx5OxwOL7no5bO1K5PY0Bg5fl2i/dygwIzDgrQK3H1c3M8FMZyv5oH9/i9NebIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6320


> mana_hwc_send_request() gates the HWC destination queue IDs on
> gc->is_pf, which the PCI probe derives from the device ID.
>=20
> The gate is not needed. hwc->pf_dest_vrq_id and hwc->pf_dest_vrcq_id are
> only ever assigned from the HWC_INIT_DATA_PF_DEST_RQ_ID and
> HWC_INIT_DATA_PF_DEST_CQ_ID init events, and the hardware always
> reports values that are valid for the function it sends them to.
>=20
> Signed-off-by: Manish Awasthi <mawasthi@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>



> ---
>  drivers/net/ethernet/microsoft/mana/hw_channel.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 263e7c4e2934..5d75c2478a8a 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -855,13 +855,12 @@ void mana_hwc_destroy_channel(struct
> gdma_context *gc)  int mana_hwc_send_request(struct hw_channel_context
> *hwc, u32 req_len,
>  			  const void *req, u32 resp_len, void *resp)  {
> -	struct gdma_context *gc =3D hwc->gdma_dev->gdma_context;
>  	struct hwc_work_request *tx_wr;
>  	struct hwc_wq *txq =3D hwc->txq;
>  	struct gdma_req_hdr *req_msg;
>  	struct hwc_caller_ctx *ctx;
> -	u32 dest_vrcq =3D 0;
> -	u32 dest_vrq =3D 0;
> +	u32 dest_vrcq;
> +	u32 dest_vrq;
>  	u32 command;
>  	u16 msg_id;
>  	int err;
> @@ -890,10 +889,13 @@ int mana_hwc_send_request(struct
> hw_channel_context *hwc, u32 req_len,
>  	tx_wr->msg_size =3D req_len;
>  	command =3D req_msg->req.msg_type;
>=20
> -	if (gc->is_pf) {
> -		dest_vrq =3D hwc->pf_dest_vrq_id;
> -		dest_vrcq =3D hwc->pf_dest_vrcq_id;
> -	}
> +	/* The hardware reports the HWC destination queues through
> +	 * HWC_INIT_DATA_PF_DEST_RQ_ID and
> HWC_INIT_DATA_PF_DEST_CQ_ID, and
> +	 * always supplies values that are valid for this function, so no
> +	 * PF-specific handling is needed here.
> +	 */
> +	dest_vrq =3D hwc->pf_dest_vrq_id;
> +	dest_vrcq =3D hwc->pf_dest_vrcq_id;
>=20
>  	err =3D mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {
>=20
> base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
> --
> 2.54.0

