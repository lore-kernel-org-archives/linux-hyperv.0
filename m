Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021072.outbound.protection.outlook.com [52.101.62.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCB488233;
	Tue, 25 Aug 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678761; cv=fail; b=okRd8RYPQ8vtA5fy9nb+9GUq5KTmPPwJGhN3Cy3LT5TqHzkhx3i+ZzGu5dwyjcWtnLvIUDtNZC695PZmJIPz4Uh6YqwxgqQKkJ0lB++lmmAyoVAqr8KaDKfIAYILCc7Yy7PO4D7xEt/+rOh0/sz/PDi1l3ktWSY9kqfeJTQFQds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678761; c=relaxed/simple;
	bh=570vuBFTcKAaTiejmj6rL9cBFLK1zoT99czhYo3GGDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D8JK2+qN8xoIJweS7JXgRrVZ/qfyd4OCJbHWtUqy2rTnLk0jHZXSuTwb+El7whZlvEe86edK7ylCvNjEpFv7hh7PnXicAJ/0fbCfEujYf79c+jKEpJciz1PJBLSHco/swsfp1PrHGqf14WBHVmu5B1kxEdr7+j9X9c1k+4hqISo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LK/SgVAw; arc=fail smtp.client-ip=52.101.62.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LK/SgVAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyrQE4HxD2j6VYMoIfxVbEzM3Y2d665j82yD72yK9rzzw69tUkr+2b+Yp7Bbc2EWA0uGW9Em3hb6t41dalQjOIuP9ni3+24C5ttBKSU0oNycjWenJJBNWy8RGqHn9CJeHbQTwDI++lRXrXVKpFY05oBlELgKln7LDt8+p9jQ1hN37AU7x5oYQT90ZgjkhyXm9YWPs+IZImgc4TUWOQHi7R058DSza0SXYeKgKR44R8bIutQKSiuiSbAZm5e7OgqBeOXlDyswgLpbxGbaZ4fd0VwdwiXIjmI2BsWfzZAM/iEdFYn9XPd2XcCVnuMEZ6a44Z49Cq281e8fO4+d0wXsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr7exrKf88cnXHnSoz03raCfdCHh1kBi0DgZYAaD2EY=;
 b=WUxxzwv2B0OYQ5PNMytqq7a+aNub60fTqAnlQ38aAWvOHs754eg1n93L7+pwO4YVSriwEvf+ZKAjeswyCI1yXeHED4euENQnhLnRwPnZtWZhEktMJJgG9kaqmywkteX8YdFSgWvnk76IefPo8MoHFRDsyJdAvL5qJiUJKTCcz1ucBLewyTvkn/cu6Oq5/btcIGmz74jkCBqLl4UO8UM/mR1+SqQkYdHvkgSexQk4ZHo+PYKobtFwpGzL2amGGIE1wKnHOKMaVRp1kcNQcShafcbeRxvnaCqKhpp0DGesIr7NP+JqWLU/2Sx1CMVixMoPPh7ukzxVxU33cFpEbjJTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr7exrKf88cnXHnSoz03raCfdCHh1kBi0DgZYAaD2EY=;
 b=LK/SgVAwBg8NXDm9FFXB5x9p4EKNQw0QUME0wlN9LWmClrhgBcxAiDxjLd6e0sKY2q3X3x3sAIREIRGP22kkVdziUNZljga4YcdMBx/+ALx8G+RyRTJpv4Alds+MPQXjg0LNWw01FLSnifUkMA44Jo3JBRD+aZYc0AJYQn9dgLo=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV2PR21MB3085.namprd21.prod.outlook.com (2603:10b6:408:17d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.5; Tue, 25 Aug
 2026 17:25:55 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Tue, 25 Aug 2026
 17:25:55 +0000
From: Long Li <longli@microsoft.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <DECUI@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/3] x86/hyperv: export
 hv_unmap_msi_interrupt()
Thread-Topic: [EXTERNAL] [PATCH 1/3] x86/hyperv: export
 hv_unmap_msi_interrupt()
Thread-Index: AQHdMc5PsIcHTSlmJUi+K6XKisTFbravCd1g
Date: Tue, 25 Aug 2026 17:25:54 +0000
Message-ID:
 <SA1PR21MB66838DDB49E921DA1C580883CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-2-wei.liu@kernel.org>
In-Reply-To: <20260822003623.2925128-2-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d897081-5440-4b33-905d-899ddd8d47b6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-25T17:25:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV2PR21MB3085:EE_
x-ms-office365-filtering-correlation-id: dbe582ec-131d-4fa8-a458-08df02cdeb5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|38070700021|4143699003|10067099003|7146999003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 c83fwMBAe9L2ot5IxccImNTXaaFnoWw9PTmygl0DfKAcoLlena6xbyy9f3DQHSfhI5VjdR5RIW0Sn6EazH87kE8+2PAWUQU51mASB2vmYZZJpjKFvJc/34yoXH302FuqmCxnjUrE2V01DHhw09w0kN0xmxVUoR88m0zJk1gU2dst6aHTnoZX7L1DEilAA2R8mplYHWMZ/75ie8HQGt5dN4UVVTATrY+lYnzUkhWqvV5+oY436aK758B8K4S9tfH2tyWcgyWPmpJyeTezOLQiEVZRigQ9UpqI0awYo1Jq+0oSM20mnhF0JA92X1imemrETQrpEfwG9zNe2eeVwH6P+EuDxblKjduqd4MXvW8YH8sNEwSFwXdijqu08p3bTVlrtrJ/XvUhrysl+aQHt0bhhL4X78ofOUTjSrFp3O1GhQN43KHdFv/dHyYTiuvfoJ4cbOWZK11lIncXs04PTi7IjN6MCtYn95OfIXDpsks7s0/6EmtGhEZA9pQmwMqVrN/IwDBG+Wgk5jvzqjHclLjYoTY4SRdOTpQJ+KmNI+DMDlD6p5b6lr1o11T5fOiv8SKi8J51Nys3XWEnDqSyGAq43jmLpy+4nk2VVzC0w/stBjKUO7waeqcBPccQEZvoJlUEQjqPXzmxXgezOA48ur/cq9eVwJ5Rq9lT/IAyN8lXkya9T71HL4FvNAggG9qliRRqBAhwiSx8K1JgZC01RA26pw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(7146999003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?St8NEMTBcYZ7K6eVdiOeBfvZIvCYNAkhQHNFbLwPHJ/JWXTuGWa2eS4TI9M2?=
 =?us-ascii?Q?UY54gYgAtoBBvyytuSvoY4Rix7n4+2tEeySx0ppVgpYVKZL1DsxlIdtAesq1?=
 =?us-ascii?Q?cx8E77CfQ4qysXsKZi26Y1Bc9HRb9v/I1WDo+aKM2N3PGm4gP1ph4g8KaWWC?=
 =?us-ascii?Q?bu4BcEOWh+YaBgaiPo+dbWfNP2hcplgmuFOv13Cc6HeK+gBtulT+RQWpSIOs?=
 =?us-ascii?Q?pltKOH6xyiHPRvQbqbwS5lcH/7LcS+xjhQXcM0fIKptl+ygqzW+3ioHYog1L?=
 =?us-ascii?Q?pTPC02e7eEHidFLqdnQlL2ottSY5Eo27cjNkkCwbJIps2YAYI0cdLhl6NbLx?=
 =?us-ascii?Q?HcaWfM7/W1OHZ6ZZ4Pe/wLE7xQS/9FHF8Pxn2jd1i6HXB1cNO/LZ549ptXCV?=
 =?us-ascii?Q?iOTAiSxwcn5eT8WyN+WdZ5q+LijPnDYk76DE39JPGM203Aeb97kFdw5/Krn+?=
 =?us-ascii?Q?7A5t0Tg011ZuZijr8jaFYw/uN/8XbTB7pvAhNNdZY460E39AWiWF8m4INkJd?=
 =?us-ascii?Q?Q8f2eUbG9otNZlRKX5IdLS5IKUoStq5o1t3smplfJUGp/H6XOJyBPrKyhp4X?=
 =?us-ascii?Q?toKXGQ6fegpN35N4UeRKy6ABuJ+6yNVBu1O5TWlhZKx/rBlDsNsrt3yPa2Av?=
 =?us-ascii?Q?HyWz055WvUBG1lHYFkRX2TGXgdffM2dIlW74td1K8odaByCt6CJHQhO2kFsx?=
 =?us-ascii?Q?zVgdh2lmuRY3KTJ9CS3DXlGz+1i22U5wm5ejVs6aXJDR5xOa2nY0mIiqxohV?=
 =?us-ascii?Q?I5OIQymcKUvZlCni4+SnYa4VnTwhwbjCnTlKmfspnbU2CKA4noRkZs7XAOF6?=
 =?us-ascii?Q?UudJtU8nd5rsp8ZTSDhr9nAXeknvl8jPSxZ3RT+vVyfj6MqQHtvfC+V66ta4?=
 =?us-ascii?Q?lFi1zHhzyhSebuudBXRJwzPsQkmkBjGioiP8FNl/OqtaVDhGco+7YIu6lp2k?=
 =?us-ascii?Q?p0Ca6OG4hsfGSCkwvXKV0FppusuPUp4nVJ2rb7XnpgKAsJlgAdJoane8vRd/?=
 =?us-ascii?Q?I6Bafc9jt1IifaQ0WsD6EtZbX8VM/QuWZeNuP44uYJMRTEl/2aWHTGGjrYYu?=
 =?us-ascii?Q?0faRhszS5gms1XnvHT3B1BQXZyo9vCFybovDoNfONI/bpS5LhGkvewDASgum?=
 =?us-ascii?Q?nCtqeHb6snDbqWnIVIZjnXetNi1efHHx0eikbLXVubs9Zs4uM/gySd4j+RPk?=
 =?us-ascii?Q?g4k+D6T9tiZgVTJg/6eeGUmOOB82IeouAzjfx3/ulZ+XjyI1pJArX7c6QUbn?=
 =?us-ascii?Q?pKZxuag2aWglb8ToLEn5lY32f48hLW2padZ1WHr5EBeKfYt+fsrKjZDg/YOY?=
 =?us-ascii?Q?bvhg8jmXPOEFOAwz8tBiJHkZdBwGxrfxz8kcpEtt9y1+euV+vM/cdhWSFRRO?=
 =?us-ascii?Q?762nx2lV5VnZWvYe3xKp15In5zFUXeqU5wkG2+YGvUz+X7b382pfvk5kYd/F?=
 =?us-ascii?Q?GZiu9xMKKnNXhKACgcFL0eNBChLk8V+sDNfgkK73/zAof0lHJndAmr/DE+Uw?=
 =?us-ascii?Q?gd+1a2s6nVzGV9J/rH+VqnyD10D/YZ1DaYNw7t6Mqvp2lBn6diKbP8xSXEIP?=
 =?us-ascii?Q?kiLvTTwdJzy9qczwPlLBgocSDN9aLhdZceavghAK+686fgZVq1MowkuQXEYQ?=
 =?us-ascii?Q?ReZNJqfOIuNH9mlTyxTLGs/FQ5ZX85MGrlmo3d1KbEE/UuTNEXpv788xTq2X?=
 =?us-ascii?Q?9wfQYZKgZiL6tZ9IV/SWohIhPgTScb0Yc7eTAti4aX//f1qr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe582ec-131d-4fa8-a458-08df02cdeb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 17:25:55.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xibTdPDWsO/djW8J5HbkRRqZik+TZjIakTNCOXZ8tFqWLoXOdHmxrkRFyhlpoahMmLnkmmWwgatvpUMfrU9FyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3085

>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> hv_unmap_msi_interrupt() issues the UNMAP_DEVICE_INTERRUPT hypercall
> that tears down a device-interrupt mapping created by
> hv_map_msi_interrupt().
> The latter is already exported and used by the pci-hyperv driver to map v=
PCI
> interrupts on a nested root partition; export the unmap counterpart so th=
e
> driver can remove those mappings on teardown.
>=20
> No functional change.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>



> ---
>  arch/x86/hyperv/irqdomain.c     | 9 +++++----
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dc..ecd18e9a97d8 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -213,8 +213,8 @@ static void entry_to_msi_msg(struct
> hv_interrupt_entry *entry,
>  	msg->data =3D entry->msi_entry.data.as_uint32;  }
>=20
> -static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
> -				  struct hv_interrupt_entry *irq_entry);
> +int hv_unmap_msi_interrupt(struct pci_dev *pdev,
> +			   struct hv_interrupt_entry *irq_entry);
>=20
>  static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg
> *msg)  { @@ -266,14 +266,15 @@ static void
> hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	entry_to_msi_msg(data->chip_data, msg);  }
>=20
> -static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
> -				  struct hv_interrupt_entry *irq_entry)
> +int hv_unmap_msi_interrupt(struct pci_dev *pdev,
> +			   struct hv_interrupt_entry *irq_entry)
>  {
>  	union hv_device_id hv_devid;
>=20
>  	hv_devid =3D hv_build_devid_type_pci(pdev);
>  	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);  }
> +EXPORT_SYMBOL_GPL(hv_unmap_msi_interrupt);
>=20
>  /* NB: during map, hv_interrupt_entry is saved via data->chip_data */  s=
tatic
> void hv_teardown_msi_irq(struct pci_dev *pdev, struct irq_data *irqd) dif=
f --
> git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f64393e853ee..7c84e27d777b 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -191,6 +191,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
>=20
>  int hv_map_msi_interrupt(struct irq_data *data,
>  			 struct hv_interrupt_entry *out_entry);
> +int hv_unmap_msi_interrupt(struct pci_dev *dev,
> +			   struct hv_interrupt_entry *hvirqe);
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vec=
tor,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry
> *entry);
> --
> 2.53.0

