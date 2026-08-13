Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021110.outbound.protection.outlook.com [40.93.194.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAD3B0AE7;
	Thu, 13 Aug 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657253; cv=fail; b=YjYPGm1ZEsfVt09ssLeTgCI+vVXQPvKhP/SZzIHv7Z3T4/7rgM+lo9hSDd2RzfTjDec8Y+cO7bzyG3EgIGLAlHesG6KqG8d5VyKnoosEXbhyOUZDiHwEgu1hDiukp2JgqQEWXNewloBv8azpqlMM9oXhlqc+xRezD1dUEntQ1E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657253; c=relaxed/simple;
	bh=e/6EBbYDKz03fqinZGpcpDwiqDKlCIWM/yrpvavMCLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhOuz/Ym0iVtfnV8pVYnUgqIjlMrZneyzsZxWfXava+w8rNa/Mp+Quu7EhAG3aFfBMEwWvHRYr6TyZ0QZG6c07G8vWRTVkh/WnxCvotMq+d+RErougSTYAWlsR33soqie/cQ81gL8BBcPRK9yceR64Zs8I7IFwgrvPf5BuBSO8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SgXBRW78; arc=fail smtp.client-ip=40.93.194.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SgXBRW78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1Zzjd6C3W0saspAdahbO8tvJ9ud2LG2pxtDkN38fr+TLgk9ljRQCizfDUiwsNvGF+MJ27IM917jAhV/YoQVegPGyCVhP3i9nVQXmG7vGyDluAI2+/9y/nbvIGq6HrnBdlDSBWtSvBR84qFwAI2WeqX0UarapXL/BlGqlNEramZcK4V9VCBeJUyoiDRmdXjfmjoyS0spmqtPsOwh+q0bvRZPZU7MOmkOSL6XoeJF9PAqomcFP+0WbqDKRhvJ0kw1gLIx3XEUKAXoETykJqvsjwowK4QrKjSncwdNBaiXsHDB/askWyn4Eu3HYvXzbsif6gNZfQ3EM8mL7GEm7SqWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iso9rbTdPWot2xyIlj2eaFytS9x3AyWwJuJQY1HMk0s=;
 b=AXGOyHd7Ys7kQKNmTG1PQprYgY4jC93oJieggGC92a6oH/7FHouIP/vKpQoThF8O4kYqTy7U98MbC1wuDRZ5GzoY5dc9B5TdRoJAi0mAMrG9tcYXHKSuyd5nUucbl/0u43hDQQAPxVQJ/6uWtkLszwPTmVmGqMybIjd1ksi1ruqRHhe0u9GswUXbB4JcfbGd7gG8HkRiauQVQ11saWfqq9SAg5sMVQlALxh085KIcoZ0nFJkz/l8Ohhqd4mUKxVC/ZaihJRWIPl1uERtSfV173tJZ16nR8VbaY80N1qzHnpkbvtl+Halw7iMfp/bvnMSLp//VA0LvfRSgaYOm1LO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iso9rbTdPWot2xyIlj2eaFytS9x3AyWwJuJQY1HMk0s=;
 b=SgXBRW78PFiG0qBVSbCSX2X1gZj9DTZCXH9nuFYAB6S4KRtMmT2yjnRKTqrAWyZfapuj1I/j2k5By72fY06OJ+f+1Moy86Zfjnia99G28iA8qpcagXsOwhQj6S+Lif4BTm+9980FCx6PEUr5TgYJwG729uqEiO40xvR2/M2E3iM=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6755.namprd21.prod.outlook.com (2603:10b6:806:4af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.9; Thu, 13 Aug
 2026 21:40:49 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 21:40:48 +0000
From: Long Li <longli@microsoft.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <DECUI@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
Thread-Topic: [EXTERNAL] [PATCH RFC 2/2] PCI: hv: Add vPCI device reset
 support
Thread-Index: AQHdG8FlMURpOa52y0SiaFGkYVFQK7acoTlw
Date: Thu, 13 Aug 2026 21:40:48 +0000
Message-ID:
 <SA1PR21MB6683A0687C14475889222AACCEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-3-wei.liu@kernel.org>
In-Reply-To: <20260724230844.3259741-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b83fdbce-181a-403b-900d-56cb950488cb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-13T21:40:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6755:EE_
x-ms-office365-filtering-correlation-id: 26cf5477-a428-4b19-07de-08def9838a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|10067099003|7146999003|6133799003|11063799006|4143699003|7053199004|18002099003|22082099003|56012099006|3023799007;
x-microsoft-antispam-message-info:
 9RkOctgXHL9MBxpqoBCNQkOx6o7zkeH0tqnG7HeLKACtyweCl0zvP+XD6xNyQuJql7+BF7PNKpPZzZIOGqL8et8P5oqHsxu6dwZMVru0lHzVH5hF4Oagm7dEn7X10X0bx4MuHz/XDQxUA5qi2vXxCRVgwPyy9kEKvhZ0PJUijHWF9qFaTkQqpUmh+dIDXunh/2d/K9CCPl38a0OtceyOmOdkBQTgkhelwNXnPniZStjdAC5RarjzPX93Q/9IDv+DAsr6foTZM8IDxrEDWn6jcjaWdWfLWMISPojC0TMig96zywqbOPdBDOwvcc8/nmkEfZO88y4B2zsCvNAjXUvf87xWl1prMCxPy5/H9cDLUGWt4xf23tByOpH0xCkYEKbJTN0/qQ53IFeoNCJschvdC6LLodc4bEyrLqsWuwEfnh5zA8iU9cWly4pwechWxpG8t5kn3RkDNJbvQ1F2HVoQJKGbFjPK0kHhzdZxDFjz+yUg18D7SMXRqaur1Ensl1D9dAX9QXIQhSz4porYKL72LQQzb1L7E8cTDbvZhwm9OyIU8b8e2XVwvqJOkq5508rDyiJX/RD+SGI616pH7StxabLLlu2+5sJ6lmmE+vuE0S9ceA9O03G829uUCaSLI0o38mXQIdbiiEAFD0+GKtGzviF6b7Eojml7G33MSxfXBf544cOf2TGz7SLngZbQpGNhxRB8zIXCL7mUqGrgxV+KlE/pw9FTZMam7qG7U4ecU9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(10067099003)(7146999003)(6133799003)(11063799006)(4143699003)(7053199004)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?jmzHtT9rQsaKU+p0C6GHv3tPRZ7ZfVOWMPeMHiR2xQGbvHJENwEJpSSGLn?=
 =?iso-8859-2?Q?CXp7By842MPONHh25u1McxvFqHyR3Rlt4PITCBWZpjagngYPUWNa0eZcmA?=
 =?iso-8859-2?Q?72lhe90fVH0NG9zPKaaaO40Udv5ExZUH/vqcmAwIED9GY5oCSBGoIQkOwb?=
 =?iso-8859-2?Q?EBHuXLWt8Y6LSIxX1O/uRaGx43nZKn0Drwjwv/jRj/9Ay7jsixQlczE4zH?=
 =?iso-8859-2?Q?hzCSU6sw+ag6K4yRsr/PXAZPba29h7laEExOVhD2Tj4pDI8tvhIUCCv15a?=
 =?iso-8859-2?Q?SE44rWz/IrHsnxx9QOFjNdSgGjYTdbI66HzcOAC9BJVV4N5PwBfmCbuxzK?=
 =?iso-8859-2?Q?xMK44qNmwLlUpGRYaxIretGYIjvLyFoKmYA5H5fZ/rHBmTYk2ruifhw9nH?=
 =?iso-8859-2?Q?4qVcHDaXX/ZSTvo4HLrtaQn4oqDWwW7jSh4keZQgmlyExSfzcjR4WK0FLO?=
 =?iso-8859-2?Q?pcMnlDw4TTG/bm8Jb8A4k2CTPwjxgqg13TajVxwF9pQyLZOMTVXy/z6ass?=
 =?iso-8859-2?Q?entNTwxysde71uVnXFLByCTGZq4GaDlrvZH8N74mjcbQxZJawley40tPhd?=
 =?iso-8859-2?Q?kHo4XhcBc6Pm9wZCFSWhbnkATOca2TjEnWb+bGCehvaepNOZtSTFIhK0sj?=
 =?iso-8859-2?Q?B+L+/ldFHt1x7WP610+crHHwXCRvshusqtdmMpNb4Pg8SCnOGkbVYUtsEf?=
 =?iso-8859-2?Q?uAKBgnaZAu/xBhpFSEgpKzBvpXAr2qBy9bNJmAojn+7DaYpVdlM7cRFGPn?=
 =?iso-8859-2?Q?N6B7cN2WWT3rVwsYhTioPc4wMm+J8no3SFnn2A8PXOqfAY5uVd/0EigKq6?=
 =?iso-8859-2?Q?ylCaZ4YuYvGQEi57b6VPuMGeqxze2btY6l2mcE+0OQwDocblTf9Yv5pQFL?=
 =?iso-8859-2?Q?MzOjo4pcR7+z+bsLoRzGe+tuzsp5Kwr24EHz3OYihP9LBaPGhTqYGBzUky?=
 =?iso-8859-2?Q?FYO6OvJZbKrF/0fW7hh55OYXHh21kQi513V9yWzA1YWuShM3S+UABj+uCC?=
 =?iso-8859-2?Q?uP66OWDKgH7+b9js7A8a/s9xQcvssrXKez7J4UX97oE4u00jgFnRokIzSM?=
 =?iso-8859-2?Q?BWkHEeqNx7BALJifJQ08eki48swmgEEMsm8zNUA5VIu/KfVhQ2qSg2xIA9?=
 =?iso-8859-2?Q?2X7+2OcNKbw/w1/u2Eqp9Y31xA7+uSEjJbjXpunDPuMZ0AaiBQhVGG8RyY?=
 =?iso-8859-2?Q?IPeHSMzdSXVKJT2+YB5Kj2hPDE+oteYpz3FinhGZhAPh6N9SnbAywO3z2v?=
 =?iso-8859-2?Q?iU/ilfGPDopDUAdj+whksxFtOaDFORFo45822Jj2iegIQfZIjSQ6t+qcA6?=
 =?iso-8859-2?Q?rIVcjIohEYIVdV08xRuamdEcOjwngwPYCiNNJdcQjdaFvshP3VBslbPNmE?=
 =?iso-8859-2?Q?PDVRBejn2dXya2ffJ0CdySP4A/9xK43NJt33OV7PI2yDrDkjny/2ZDx6C7?=
 =?iso-8859-2?Q?LXDEKmD7Q/ETUBH/JArtI4/O7OzMfB5r/RMlQfReJY/YBnyD4dwFDCRFkS?=
 =?iso-8859-2?Q?BtWRUxxR/n+emjtbRxA+86UuoQy9EdwGf9KVRQltfK/VyT5b+XKlK1ot9g?=
 =?iso-8859-2?Q?EoDk631WzNqg6YyVHMgizne4uL+/26tcqTGPgc32+wWqXWdysoikJN2qRa?=
 =?iso-8859-2?Q?F8k03sEubiAyfIOEe8RlHkngmCZJECBYeeTvcBBaxOMvflCUdQnqF/ITS5?=
 =?iso-8859-2?Q?mC+gOAT5dmRfyVlOdfLt51Pq2ZE62Xanl0PZl8/uLqLW3lSOMVYs0s1BiW?=
 =?iso-8859-2?Q?5F2HmibiFdv3FDs4JI5s+1HOQrSz98CNNce5XddJSMuI6D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cf5477-a428-4b19-07de-08def9838a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 21:40:48.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld8n7LvliIbyppH8gxDyFSuKm1Zc13ek9rD4YU+BhE8mn1FfPJYapjYQAcxPToiaYjQ9rR9WE+0etyptoezApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6755



> -----Original Message-----
> From: wei.liu@kernel.org <wei.liu@kernel.org>
> Sent: Friday, July 24, 2026 4:09 PM
> To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>; linux-
> pci@vger.kernel.org
> Cc: Wei Liu <wei.liu@kernel.org>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Jonathan Corbet
> <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Lorenzo
> Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski
> <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>; Rob
> Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; open
> list:DOCUMENTATION <linux-doc@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [EXTERNAL] [PATCH RFC 2/2] PCI: hv: Add vPCI device reset suppor=
t
>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for project=
ed
> PCI functions. Negotiate the new protocol version and issue the request
> through the vPCI VMBus channel from the PCI controller reset callback.
>=20
> Use the existing VMBus response path. Return -ENOTTY when the host
> reports STATUS_NOT_SUPPORTED so PCI core may try another reset method.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>





> ---
>  Documentation/virt/hyperv/vpci.rst  |  2 +-  drivers/pci/controller/pci-
> hyperv.c | 61 +++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virt/hyperv/vpci.rst
> b/Documentation/virt/hyperv/vpci.rst
> index b65b2126ede3..6bfee7225c14 100644
> --- a/Documentation/virt/hyperv/vpci.rst
> +++ b/Documentation/virt/hyperv/vpci.rst
> @@ -65,7 +65,7 @@ exchange messages with the vPCI VSP for the purpose
> of setting  up and configuring the vPCI device in Linux.  Once the device=
  is
> fully configured in Linux as a PCI device, the VMBus  channel is used onl=
y if
> Linux changes the vCPU to be interrupted -in the guest, or if the vPCI de=
vice
> is removed from
> +in the guest, or if the vPCI device is reset or removed from
>  the VM while the VM is running.  The ongoing operation of the  device
> happens directly between the Linux device driver for  the device and the
> hardware, with VMBus and the VMBus channel diff --git
> a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv=
.c
> index cfc8fa403dad..d3c0fd5e1d8e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -68,6 +68,7 @@ enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/*
> RS1 */
>  	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/*
> Vibranium */
>  	PCI_PROTOCOL_VERSION_1_4 =3D PCI_MAKE_VERSION(1, 4),	/*
> WS2022 */
> +	PCI_PROTOCOL_VERSION_1_5 =3D PCI_MAKE_VERSION(1, 5),	/* GE,
> device reset */
>  };
>=20
>  #define CPU_AFFINITY_ALL	-1ULL
> @@ -77,6 +78,7 @@ enum pci_protocol_version_t {
>   * first.
>   */
>  static enum pci_protocol_version_t pci_protocol_versions[] =3D {
> +	PCI_PROTOCOL_VERSION_1_5,
>  	PCI_PROTOCOL_VERSION_1_4,
>  	PCI_PROTOCOL_VERSION_1_3,
>  	PCI_PROTOCOL_VERSION_1_2,
> @@ -90,6 +92,7 @@ static enum pci_protocol_version_t
> pci_protocol_versions[] =3D {  #define MAX_SUPPORTED_MSI_MESSAGES 0x400
>=20
>  #define STATUS_REVISION_MISMATCH 0xC0000059
> +#define STATUS_NOT_SUPPORTED     0xC00000BB
>=20
>  /* space for 32bit serial number as string */  #define SLOT_NAME_SIZE 11
> @@ -136,6 +139,7 @@ enum pci_message_type {
>  	PCI_BUS_RELATIONS2		=3D PCI_MESSAGE_BASE + 0x19,
>  	PCI_RESOURCES_ASSIGNED3         =3D PCI_MESSAGE_BASE + 0x1A,
>  	PCI_CREATE_INTERRUPT_MESSAGE3   =3D PCI_MESSAGE_BASE + 0x1B,
> +	PCI_RESET_DEVICE                =3D PCI_MESSAGE_BASE + 0x1C,
>  	PCI_MESSAGE_MAXIMUM
>  };
>=20
> @@ -1397,10 +1401,66 @@ static int hv_pcifront_write_config(struct pci_bu=
s
> *bus, unsigned int devfn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>=20
> +static int hv_pcifront_reset(struct pci_dev *pdev, bool probe) {
> +	struct hv_pcibus_device *hbus =3D
> +		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> sysdata);
> +	struct pci_child_message reset =3D {};
> +	struct hv_pci_compl comp_pkt;
> +	struct pci_packet pkt =3D {
> +		.completion_func =3D hv_pci_generic_compl,
> +		.compl_ctxt =3D &comp_pkt,
> +	};
> +	enum hv_pcibus_state state;
> +	int ret;
> +
> +	/* Device reset was added in vPCI protocol version 1.5. */
> +	if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_5)
> +		return -ENOTTY;
> +
> +	/* Hyper-V exposes projected functions directly on the root bus. */
> +	if (!pci_is_root_bus(pdev->bus))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	/* Do not take state_lock: eject holds it while removing/locking pdev.
> */
> +	state =3D READ_ONCE(hbus->state);
> +	if (state !=3D hv_pcibus_probed && state !=3D hv_pcibus_installed)
> +		return -ENODEV;
> +
> +	init_completion(&comp_pkt.host_event);
> +	reset.message_type.type =3D PCI_RESET_DEVICE;
> +	reset.wslot.slot =3D devfn_to_wslot(pdev->devfn);
> +
> +	ret =3D vmbus_sendpacket(hbus->hdev->channel, &reset, sizeof(reset),
> +			       (unsigned long)&pkt, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event);
> +	if (ret)
> +		return ret;
> +
> +	if (comp_pkt.completion_status =3D=3D STATUS_NOT_SUPPORTED)
> +		return -ENOTTY;
> +
> +	if (comp_pkt.completion_status) {
> +		pci_err(pdev, "Hyper-V device reset failed: %#x\n",
> +			comp_pkt.completion_status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  /* PCIe operations */
>  static struct pci_ops hv_pcifront_ops =3D {
>  	.read  =3D hv_pcifront_read_config,
>  	.write =3D hv_pcifront_write_config,
> +	.reset =3D hv_pcifront_reset,
>  };
>=20
>  /*
> @@ -1996,6 +2056,7 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>  		break;
>=20
>  	case PCI_PROTOCOL_VERSION_1_4:
> +	case PCI_PROTOCOL_VERSION_1_5:
>  		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
>  					cpu,
>  					hpdev->desc.win_slot.slot,
> --
> 2.53.0

