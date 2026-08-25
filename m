Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022100.outbound.protection.outlook.com [40.107.209.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800C331ED6;
	Tue, 25 Aug 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690036; cv=fail; b=FxI0465OTbQOQXbYO+4flYRNOoYNnPSc1KOvXSLM9q6nXNIfnpz88uC5B6bNFMdoMf+dJWMkcRaVuqOWafzT0wqVxzajl6VrkkCORnhG9VGDnsCu9ePW1xf25apfzbEdQYc8LOV7waop7goufP2cMln2lS7r/FvOzhXERc0gFyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690036; c=relaxed/simple;
	bh=Avuxle7P3YVUl6R08sEiWWf7yQP35noNMZNW52GLEDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AIuSJnJP7IeWiS2Fx21vL6M9hYsINyyMvRJ+NnZAMEnX7mtsl2KKG+25EfZAnP7VDkKCS5mo66nTmIHpcp2mR63SE+Pesk+eZD18BpLHGcwgNIT51XDwE5of385B5rZx1UceBGRQfqLKNN/id82bmbGIq/q7p4q1a0UsM31nTVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CxJ92mbe; arc=fail smtp.client-ip=40.107.209.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CxJ92mbe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un5ZUWUXr/7+2pZvSYHOY2j4NddyIMz9gkrww6HZWlB4gGCucFyo/XqLvvXP14hTPOhjsxR0LdsDWCC9YJJCSYRd86Sz8SVbx4ICQ8eDSf96EDNfr8FjOC5h2V/HQmnCrg8saVwIPRsW9ZN3R/aDzw4Kow4j7NyATXMDOF97SeHAxhIPmswRtpWzHTer1QN0iqJmbdBuYOQ8AghKlhmK+lOOiRLaBCZ340AlGkqn2ZCoEhF0rwRwTpm5oKn8CDV02I0sRm98nHQw6vhNYEnAc0kRTI8VVepqwpQm1Ch9DbgzKEMB1IM4/6v++Q8jIhVPauyb9g37dsMtYHY3pfwF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rygH9ojXll4qntAAER+lLG28UnnjXtIoCD0G5iF2k4w=;
 b=Sm774QbjHcUvu2sYy1xKSlJmGne6vNehrMx6r4WaXjHBEdPk9EH2xcVnKKO4TD+2Ba/ZvXfJG+nvEkbiEyJWgV9PsbVqljSE5T0sPCAn5lvJ9ibhMJTz74OlSHLt1p4KHL8Vcq74sNwOemmS2O8A6OMcVLn2kniaSdtby17JaOZge1zL0lnulxABW0Gn+wjjSixDl2h+hucsuN8vYQossAVtIJpK27xgbjq9E6NtTKnzIvtXus15ezUGkoPkq33w4ALQeuci21bzd6lN9V+H8fyI/RaNkwXHP8hjbMnV9Mr8WiMqL1Z9MHungarJa0xIX4Wr3asXbWom1nJHZKpK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rygH9ojXll4qntAAER+lLG28UnnjXtIoCD0G5iF2k4w=;
 b=CxJ92mbemkoYupUjNpZhtZ/YnEW8uFUHNMtuvXWV2zc3AFgw5m4b4yraCU1p9wa6G3JzggkHtDo7jiTy94H/LjJg+hlrY3fyv8GBkPubtba9p4YmJpKxHugJ9fBob4sP2QAOczwZHGHIoBovf9UGOZs7Mm6orSU8gRVVw3eJgpA=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6369.namprd21.prod.outlook.com (2603:10b6:806:4a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Tue, 25 Aug
 2026 20:33:51 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Tue, 25 Aug 2026
 20:33:51 +0000
From: Long Li <longli@microsoft.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <DECUI@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT
 DRIVERS" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 3/3] PCI: hv: fix interrupt affinity change on
 the nested root partition
Thread-Topic: [EXTERNAL] [PATCH 3/3] PCI: hv: fix interrupt affinity change on
 the nested root partition
Thread-Index: AQHdMc5SlCkx6KRPEU6B9Whv5nLie7avOIZw
Date: Tue, 25 Aug 2026 20:33:51 +0000
Message-ID:
 <SA1PR21MB6683883CE3658A5EF7CB2402CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-4-wei.liu@kernel.org>
In-Reply-To: <20260822003623.2925128-4-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e7771a0-a067-4027-9cf1-6511888fae7d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-25T20:12:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6369:EE_
x-ms-office365-filtering-correlation-id: 0bdc8ae7-1bb6-4978-f83b-08df02e82cd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|7146999003|22082099003|56012099006|11063799006|5023799004|18002099003|4143699003;
x-microsoft-antispam-message-info:
 DAvtrBaJCgwZFzdnLYqm12BnO6Atj6/bMhdydIMs8bf3v7+8fCE9MgGET1Jica1iu37L+K/sy7nMCpGP/C29k58Z1C9ksF2oh3g3foch716UjB9tDgzW8ZZ0gn8/GpS+cOqRh9vFmVOM8sEeXnUPrrMX03T1KbBeNfjwBo3i8PCN95QHB9jwO5VNZQMaGbFQxTCgwBgZTSqWb70ZOZrx2n0N7mR9ODwD0oL9mXihTn9g9a08roMdHnJsN07E+lsR18gqGS19gpt+pE+escn/FT5dEI2SbutjMrN5A28dSVW1J9OkLVh9wubIF/rer2pYOvJBljA56zOfa5HSJFTJrLWwQoSJ8+YLw73JZW6gGzlIQZ4kmEcl7f2vDzX3Mzsz6kfCeASd9h9gPYmtc/t8emj2sXdBJ2lKq2J+7YR/ap/HdjDgbAmdCeJSzzBRqJ+zdkrD2MkgWN8U8GUS8Dzsuqziz3wL5HmcYwJE5FdyzitrXk3BAEnm6vL66gZ400zIYj/liPhQ6aL5quKPoZj+nD09aM53swu5rw3Mpc8r1nGt3pFiH1Q3r2//5vPxZzidRsMZL4Cj57IFwC2YU1aMSoh/oT5UjeBslCn5aUD/sRsXR1FrZD549/Y1OnYgBYSXwcIfOpnSIZlTP+JfyvzzrD87kxFN58u8uwT//ISMYdu/6l0wDUZFLdR3dA7/PTXANptx4kK2IMmcRwYRaUp90b6va5i/LRhJkS+sr8blaoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(7146999003)(22082099003)(56012099006)(11063799006)(5023799004)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?b3ud6aP84FILJMDFV1QsJX4z5GhQ7PdCJxzOWS6JaMlyS9kSp+r2urG4m/?=
 =?iso-8859-2?Q?dfeNc4jqhmtIffDxthEFnGa74P26kmYCFa4vK8PRTRQluIODoGnzZNxv92?=
 =?iso-8859-2?Q?OVBNN+2s3mqRNmR5rvBiqK4/QLy+6yNWoBHql9YJ8ouhUMBc5dDqKVEXTt?=
 =?iso-8859-2?Q?b4WibNPFZ1HtorTBgWSMlS1QZOFmgK67w0/hbHJiHzVSZHOb2m84gKcKkK?=
 =?iso-8859-2?Q?A46EdcMOKP7UOLbJPVXJvHf36Q6f64bZubhf+I2Ha6Qzv9N2Gmb0ThpGdu?=
 =?iso-8859-2?Q?RDMQRj+hzco9IE4Jh8GSW+9taHcnehtKwGYImqAM3PKqlArtFNvsFqBmP4?=
 =?iso-8859-2?Q?8L95flWVkyCPisDG0AJXcEqXHusWfD2f1dIzbRym4l8aYTJcchrvEKa3Rp?=
 =?iso-8859-2?Q?jQiE1gLCAvYLP6VOM0O+I0tpzaSz4r1OTD2pyqXnLJxZpYFLF0IUuWDv6K?=
 =?iso-8859-2?Q?dR9mbvnXATlOfJWYARnrgSqgpZC4nAV1yuvN2FhjlSU9aVXfEo0jc95Jp5?=
 =?iso-8859-2?Q?MNZympVozlzqDS4SihrZUn5Q1dbn8N/O4mw07iXPqsbDDTdnGSAkSmCnnS?=
 =?iso-8859-2?Q?qS4bocV4l9mqKEkppEvvrOVhzi7Yxq/nn7BhVZ2qGHqbdGL9lytsyML5Q3?=
 =?iso-8859-2?Q?rDVhtG6mEahzCAfbW/K4mlqpkefhVNB/w+4UTmdvgqoGqMv9CeCU+NfKh5?=
 =?iso-8859-2?Q?Fvr1+oioUXKZSRpmb/3Tg1baBeayC2OLHxe7CHp23MLtjKZctJuvwwxzS+?=
 =?iso-8859-2?Q?JgIHrFFHUOXhNZq+lik3UeHNkuX5SUcQw1sn5EB9Fi7dpXxiGftRsyqMgM?=
 =?iso-8859-2?Q?kyFKmRXTlEH3WLigm3QEKeJserBnvGfcdzzb58zCm6QpTBHY6osBIe2Ia+?=
 =?iso-8859-2?Q?1qFsYGKEt3siwGDdVkIm0rxpJa7qUnoB9c6rBKhF4fXTXDCJRRBtL45LWp?=
 =?iso-8859-2?Q?dpWgmr9nMYw2Kk35wa2FMR9iWKPXeX/0dY+7Ld3p2fzbOsWbXBX6S3UyX4?=
 =?iso-8859-2?Q?mTY09vx+DUJL+x9OSfARvxHcCg0WtFmauU2neCi+h0RNm30iVOicBdsPWL?=
 =?iso-8859-2?Q?odOP/H2nf3R/6AOyvvc2LS+o0PBT45acRFJyoAMv4wlTFJ374WAUOfaLIy?=
 =?iso-8859-2?Q?6kzLwS78ZJO7fLRdSBcpw467MF8LEA7z2cdz2kioulUi5Vvg2mw+pCs9g+?=
 =?iso-8859-2?Q?NZaCte3B9e1HNcPZZDDF8S+BpgJCkceHfOVxyTiG5gxT5xHZ9Fzo6/C9Rj?=
 =?iso-8859-2?Q?ViNIlM3NMQZzniPJzvVHHKhP2PDVnVX/XNZPwYVuS6fB13CV+mpYdan8RV?=
 =?iso-8859-2?Q?NwDLTqHiqPoBUgx6YDWTbqIgz9FZDZdAt5LKRVtiQ6ZeuBuIkKyWWGhGI1?=
 =?iso-8859-2?Q?HSlvZvz0Nqg5vXgfCrrme8VKLTvHdh/ICbVLELNZN/X8/K318b/LbrhVgC?=
 =?iso-8859-2?Q?MS0yzqRqLD3rl6+Rn+nC+R2APnWwAlmGtSdAK4kdPcnPoMwk3AhZu7dV1S?=
 =?iso-8859-2?Q?Xs5vsJkkQMyQ3NEgLR6h7S6UnkoCqUw3odMMX+klwsa4EJyP5h0yLE9Q9G?=
 =?iso-8859-2?Q?f2qSWd03CXWmVt5NaKPRBXz0tjEX/43jjF3OdU0LfRHZBL5Vxtbi9D/jfn?=
 =?iso-8859-2?Q?Ejn2lN3e6U70F32EeZ8jDE1lhsCKXR/yzf7XFQ0tra/Y8g7C/PRKO+y3As?=
 =?iso-8859-2?Q?yOfNHnIcHCt6U5tXo75ufOATYBY3Gwu0V6qGxTP9nO054QwvvYmvx2bY6J?=
 =?iso-8859-2?Q?4qh3D4FjD4JIs3JbribEPn0x4UNAZLHHgpoeVa2MiGms7Z?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdc8ae7-1bb6-4978-f83b-08df02e82cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 20:33:51.7341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tLhNO8/OJ0Hm71jSNeEhjfbBD8S7FVHyVKzxkoE45U/d8rpJY5Gqr7w9diwVOun65THDi0jjII0Sb79j4Bg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6369

>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> hv_compose_msi_msg() sends PCI_CREATE_INTERRUPT carrying
> int_desc.vector, and the vPCI backend programs the device with the
> address/data it returns for it.
>=20
> An affinity change only ran irq_chip_set_affinity_parent(), which re-allo=
cates
> the x86 vector and nothing else, and hv_arch_irq_unmask() then issued
> MAP_DEVICE_INTERRUPT for the new (VP, vector).  Nothing re-composed the
> interrupt, so the device kept signalling the vector it was created with a=
nd the
> new mapping was never used. This led to loss of interrupts.
>=20
> Do the re-target where the vector is known and the interrupt is quiescent=
.  If
> the vector changed, re-compose the VMBus interrupt for it, write the
> resulting message to the device, and only then map the new (vp, vector); =
the
> old mapping is destroyed as the new message is composed.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 41 +++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index 5a36382742bf..5acb8e41567e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -294,6 +294,7 @@ struct tran_int_desc {  struct hv_msi_int_entry {
>  	struct tran_int_desc		int_desc;
>  	struct hv_interrupt_entry	hv_entry;
> +	unsigned int			mapped_vector;
>  };
>=20
>  /* chip_data is passed around as a struct tran_int_desc *, so it must be=
 first.
> */ @@ -742,6 +743,8 @@ static void hv_irq_retarget_interrupt(struct
> irq_data *data)
>  			"%s() failed: %#llx", __func__, res);  }
>=20
> +static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg
> +*msg);
> +
>  static void hv_arch_irq_unmask(struct irq_data *data)  {
>  	if (hv_root_partition()) {
> @@ -752,9 +755,17 @@ static void hv_arch_irq_unmask(struct irq_data
> *data)
>  		 * RETARGET_INTERRUPT.
>  		 *
>  		 * Keep the returned entry so the mapping can be removed
> again
> -		 * when the interrupt is torn down.
> +		 * when the interrupt is re-targeted or torn down.
> +		 *
> +		 * This is also the re-target point.  The core calls us from
> +		 * __irq_move_irq() with the interrupt masked once the new
> +		 * vector has been assigned, so if the vector changed the
> vmbus
> +		 * interrupt is re-composed for it first --
> PCI_CREATE_INTERRUPT
> +		 * carries the vector, so the device would otherwise keep
> +		 * signalling the one it was created with.
>  		 */
>  		struct hv_msi_int_entry *ie =3D data->chip_data;
> +		unsigned int vec =3D hv_msi_get_int_vector(data);
>=20
>  		/*
>  		 * A NULL chip_data means hv_compose_msi_msg() failed
> and the @@ -763,8 +774,29 @@ static void hv_arch_irq_unmask(struct
> irq_data *data)
>  		if (!ie)
>  			return;
>=20
> -		if (hv_map_msi_interrupt(data, &ie->hv_entry))
> +		/* Already mapped for this vector, nothing changed. */
> +		if (ie->mapped_vector =3D=3D vec && ie->hv_entry.source)
> +			return;
> +
> +		if (ie->mapped_vector && ie->mapped_vector !=3D vec) {
> +			struct msi_msg msg;
> +
> +			hv_compose_msi_msg(data, &msg);
> +
> +			ie =3D data->chip_data;
> +			if (!ie)
> +				return;
> +
> +			if (data->chip->irq_write_msi_msg)
> +				data->chip->irq_write_msi_msg(data, &msg);

I don't see the function irq_write_msi_msg defined in hv_msi_irq_chip, mayb=
e not looking at the right place. Is this function ever getting called?


