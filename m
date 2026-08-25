Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023127.outbound.protection.outlook.com [40.93.201.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871D34A773;
	Tue, 25 Aug 2026 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688758; cv=fail; b=kRj59VX1A8/w00Dzc5XxuOWzZ6C8Fa4HREzun587hQnw3msnQPu72Dw1JUUqL5jWDsu9ovsRgRb6rRCUScRCKN30K4hi3r3KKxq85dFlSmGltFWRWtgM/sh9uQd5ZzXN/c+sbaAO5WhIFrjXa3VFsEUeLUe8VH02CA4xhK6xCUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688758; c=relaxed/simple;
	bh=vWXCE+kU3vkUXQoz+lmMcrr9yJ2nX92DLyx9zkQP4H8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKvW7VUxp7i2WU1cvNuAJsf+m7fvC0TFzuXVSPV/rtXm/1cicC0GF4iGfqO6A1ku45dqYJsYPkZkvERQHmWAerbZU6GNrjI+9rWm1GlN5D5B/2Scs70MrIlLs6ASLEjpjq23XH8KX2uHCRzwlhITWLfX5TuYoyd4fvtHcxJI9UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NHDuBNnd; arc=fail smtp.client-ip=40.93.201.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NHDuBNnd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfROKtWXsNOsFTT0uqJ6mBDpmWpdvwMBXz/FmVCjK4RvqwJMn7HQdwQxlbE6829dq318HrRnnK9TbJ3pZUIcZhAse2QlA7lQQT/1iPlLdWdg7N3tvpbauOKt4xojn62wVEAu812HeoG+avH7BljB6df/NkNz2LDCIJP0tnDPvi31gDKMQ2Jd5c9HPMEE0feL0iBG5pRhoSRUUhuF/jxk/VNlWMnXHD3v1Ml4c42OIvDIAskCAFqTcSOB4ZqTFus3j2LG8OdF6uGtcU3vcL/PyRYXpgaR8YUTQbhVxX2bbGxScsfaKe2o5k4m+ALfXtRk5+nguuBzM/5uGdlTnyuKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzOT12kfFHuMMLksFFWy8tnEAq6s7KAPfRi0H9xcWGw=;
 b=wL/agGEhzH5xYR6wx7Z6NV0oQwZypmF1ZZWrCdmvgMLCTE32cmViMNDvUxn+DxxUnkmuZSPMV9Smz/rsF46jwCmN74P/E72GAg2qpmi+TJ4NZ4LRf9SaBa7snt2jkDz4rxrUQf7IMP+wiHtYF/23ucjGUP+usEG6rs90aVIeDLaa0i1HWuZQf5ye9StJBdGIQdwd9dk5hIdomR9iZcFEJnlJoAmBD1XxQYMxIMrggXohIqGT9ZJk3XM0v1Q4xGiNJV7SdS4kAjILN4degyAMEOVRFcpyGC9dCa7roDrxCxOnY0xpe8ZZNiIVW/8ovM/0yeoqJcPHYceB2DtLFlzShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzOT12kfFHuMMLksFFWy8tnEAq6s7KAPfRi0H9xcWGw=;
 b=NHDuBNnd/P4rrElAnEMnInoHVv/q6pgxBsyg+In8km6UQt1WqlwsMnXV3GhxpzZ5SN/3sD1/zs40ElXbGlMPtvlhtODCNrTauLoptz7GARb6ANMzygGYVhEnLVN170+GmfF4/4QT2Ps3YADCGysVe7UO/XrXrkaO1QQ/V0GeXt4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6898.namprd21.prod.outlook.com (2603:10b6:806:4a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.4; Tue, 25 Aug
 2026 20:12:34 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Tue, 25 Aug 2026
 20:12:33 +0000
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
Subject: RE: [EXTERNAL] [PATCH 2/3] PCI: hv: unmap MSI interrupt on the nested
 root partition teardown path
Thread-Topic: [EXTERNAL] [PATCH 2/3] PCI: hv: unmap MSI interrupt on the
 nested root partition teardown path
Thread-Index: AQHdMc5R+BB9bhuoCUeGE9cm8D/Y/7avNeXA
Date: Tue, 25 Aug 2026 20:12:33 +0000
Message-ID:
 <SA1PR21MB6683F98FD2FF83D39F93B473CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-3-wei.liu@kernel.org>
In-Reply-To: <20260822003623.2925128-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6acd8a81-e48a-43b1-9562-c4d2a95d44a7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-25T20:03:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6898:EE_
x-ms-office365-filtering-correlation-id: b2758b1b-b890-4236-d1e3-08df02e53300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|7146999003|10067099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info:
 ruP7xI3pzphJb4agV36V8uJwHwzpP9kfZUFMxmNi7rsHC9yhxMst0H6yhw92zJXv28X7sDSBdF9MPNg1pEsmqLSxCrK6EoWM3WgPTsAdzkFuQRgE54hBlLVXyOfNxdTfBq8y/ArtsRJVDOdZVPaSuBoOHohY1bNiIgAlCz0/KX24QPOCOZJhSqYH2hWkhZ87n1N2rW3OjRCYO7imX16klglrtfXJwIyDeulS7EmYWz+JPYLDhs0n1vEuHgdFg1I0SFTwBxiFHKItJnGHkWwr/oQDLZKC5Qom93rVoVAixGx8dnmAj8r8ls16Ywu87BpypzYRPXgGxcU4Rm9pJTYeqUdYGJuJlDxHeHX0XZOelOl1jms+g6wOOEjvf+bfYxq9JgJxdhGVB5CRC8fCNpNr2aWVHtbSx+Lchx1QKWb72TPChV4U4tocUxUElzmIbjZrcpPyjH5iwKcXX6rJ7Paq1MWIx+lKjul5zlnswFaQ/zQ4iuyYTBlm5qMFEQ8hkw2cBx4EL9LBPyjZFzase9hsluYPX95eW4Z56YL4dwusGDR1+W1j8RXQpHU7SeLUbKSVRo2l7JUXBGFq/s0KGgEbWMif/mVgGKzfiamXlSdMK33vIiw6qE0hm06DMdCX3paUZ0e4p0sq1DHYI/foTrVuT8LP8w8jsoanJBrVHlJFLvmtKLoCCbCLsbl/sYe+enunCtG3eI8cd16DCSJfYsBIkM+oN7975SW8ZQmzPqj83OU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(7146999003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?RU/nt2qSsVELrk3sxEJBc0iLib9CyyifbUaMuFLkqnCbTKex9pL1hxXnx3?=
 =?iso-8859-2?Q?pMU6+gF4eYHiiJ/tp9NyvnXwvZMrYd9aHyTIfHTp7DGwEPO66pAWA+Tctx?=
 =?iso-8859-2?Q?qTGXOnLHgNoJIqGMmZAjZaDTWB8kWHWL+/dUD3M4pBP8wq23eRY4HbV5EU?=
 =?iso-8859-2?Q?WOKooOXKBWSImVljWbgq41ZELFyX8rhL0gQUIbuD22PWJ+/N7/hsfMinZv?=
 =?iso-8859-2?Q?W1piV6W1UFvbGhLfqw/FuAh9F+tEtWaQ6pIwc85tNbFEdKjw7qHh8DkkXv?=
 =?iso-8859-2?Q?nUEL878HvsJEUYU+5h+bfoB50Iq9QbN7++KkGomndQrHBZDXeG658dHx4M?=
 =?iso-8859-2?Q?lHJy0M0LtrYzaaZS1ljxvqokqk3fExnUjvZpxYlwqinfT4MKQn/C7Vfs3+?=
 =?iso-8859-2?Q?BBXJ5813sE5nuiM4qzQ7YTu9NR2306p6bIAbjRaldkz0qdLzMq3eAtI8ol?=
 =?iso-8859-2?Q?LxuD7D0YzlgQ56frR24EXCEKBejVDYT8LDM13xpXbqxtGhCLc49PIHKkpm?=
 =?iso-8859-2?Q?+Wos4zJBpe3JcaBRRRsxldIRVLfU58Y5cA/SWFvh2Q79hNC3FzS68vDxoK?=
 =?iso-8859-2?Q?M0efYG7Qrlz6VtUJxChwHzAGEx66Tn7FHb5RE49IkEYKz0GIyyPJVXZbnM?=
 =?iso-8859-2?Q?JGWeEd5bmBklYNM7VjFOpsrvC0wZj68You42G3cbvT84BnnYkmmAWPToep?=
 =?iso-8859-2?Q?U+cnZ1cHMsdQbXgdRljq2SrofAmnx85sOZtPTgE8W4Fbm8PdQQmo1XtmZp?=
 =?iso-8859-2?Q?w50SzLDjRZ13Wfpt7MABx2o7XzwItGWpAzVZ5Z3XkIHUXzNJir1Pnl7FMD?=
 =?iso-8859-2?Q?o2obkosjo8kkLwIZK+FuE/9273EnmlCMYVL7mJK1bnI7PaBssWzcwFNtBZ?=
 =?iso-8859-2?Q?eabagn5CWiYd974DazopavPrk3AChej/+/+7HcxKPVXIgHrsK2gXpy2iW6?=
 =?iso-8859-2?Q?tbH27AcqUPyzEtwAOLbNFdZvA5AexdNXdmzjLrhabNy0CQs7txyXWSiFDv?=
 =?iso-8859-2?Q?1Bc9jIoDYPxidl2jO7/gEq0s+4k76JSbqwAksX8+blXKc1pGgNUAC0xreZ?=
 =?iso-8859-2?Q?QA3jrBSbM4JoKdJFvXTRu1c2NXilEK2IeiJt586VqM3SPgf0OCurj0RnrZ?=
 =?iso-8859-2?Q?vmjbcjsxx2noqgotZCkFUQRPavQcwUCfLFFfuhGHbAdFbbKn0vPPBFkpIu?=
 =?iso-8859-2?Q?Xl5YSKCZl+Wn0kUkbELWy5mKlQLixdBqejPwz4+d0r3AEAn1RzSfs+XPNd?=
 =?iso-8859-2?Q?21nyDWlldavzqxUwu5FgjDU34VO4tUIqe8V88Cao5c5GnQwskThkKTe94y?=
 =?iso-8859-2?Q?AXBLuStDETcwjh7S/QoJOxkPtLQ7yHPND/TNW8amzTWWpdmZ9eOQAqr1yQ?=
 =?iso-8859-2?Q?9q+Oo4UDvXzWro6gS7AjBMOiGY/qBSc/LijlvXg4rd7W5cQCCbTmU23hHZ?=
 =?iso-8859-2?Q?qt5Z1ulb/gdVyx1gQ8s9qXUkbdI+T2qmqAXbxtLy3UYRbv8487Q+S8xsKj?=
 =?iso-8859-2?Q?KXZ919ZOSYVeOYRhfehbg2wLgtEXyymOQTqUeZDjbeFVHHbJqoNcKTSfno?=
 =?iso-8859-2?Q?H+LUZy8oD7PWLC1oEgWVn8KSzN30SHNXsV6ts5SmxY7V5f/f71R66DxaD0?=
 =?iso-8859-2?Q?nZ3D+/YdFJ7gJQASG2+ii1F2+PRw7N0m5/7+nQvXgw48IZcLQmUklqAVye?=
 =?iso-8859-2?Q?d7oy4YfQ04m4OfsIp81TEHEVEhoVyS7xBo/i2eRt4uwu2DmxitQX5VyiAw?=
 =?iso-8859-2?Q?Rw6Vjx4IQ3vQTffuuKoWS58gtODS/R9Ve0PcdQ3k4CbMBt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2758b1b-b890-4236-d1e3-08df02e53300
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 20:12:33.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUkwQ7d4GI+3LT/kc2uPwKh0w2PsComQcnWPPDHMmnQeFl5Ke3h4GPiRYM0sex/PF8MA0K6mSt3gz9wHg78dfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6898

>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> On a nested root partition the vPCI MSI/MSI-X interrupts of vmbus devices
> (e.g. the MANA NIC) are mapped in the hypervisor with a
> MAP_DEVICE_INTERRUPT hypercall.  This is done from hv_arch_irq_unmask()
> -> hv_map_msi_interrupt() because the nested hypervisor performs the
> interrupt remapping and a RETARGET_INTERRUPT is not usable there.
>=20
> The mapping was never removed: hv_arch_irq_unmask() called
> hv_map_msi_interrupt(data, NULL), so the returned hv_interrupt_entry was
> discarded, and hv_msi_free() tears the interrupt down with a vmbus
> PCI_DELETE_INTERRUPT message (hv_int_desc_free()) without issuing
> UNMAP_DEVICE_INTERRUPT.
>=20
> This has led to MSHV rejecting already-mapped (vp, vector) pair from bein=
g
> used. When this happens during early boot, the system hangs.
>=20
> Keep the hypervisor mapping in sync with the kernel's interrupt lifecycle=
.
>=20
> The mapping is only created on x86 (hv_arch_irq_unmask() is a stub on
> arm64), so the unmap hypercall is guarded accordingly.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 85 ++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index cfc8fa403dad..5a36382742bf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -283,6 +283,35 @@ struct tran_int_desc {
>  	u64	address;
>  } __packed;
>=20
> +/*
> + * On a nested root partition a vPCI MSI is mapped in the hypervisor
> +with a
> + * MAP_DEVICE_INTERRUPT hypercall in hv_arch_irq_unmask().  Keep the
> +entry the
> + * hypervisor returns next to the per-interrupt transaction descriptor
> +so the
> + * mapping can be removed again with UNMAP_DEVICE_INTERRUPT when
> the
> +interrupt
> + * is torn down.  tran_int_desc stays first: chip_data is used as a
> +struct
> + * tran_int_desc throughout this driver.
> + */
> +struct hv_msi_int_entry {
> +	struct tran_int_desc		int_desc;
> +	struct hv_interrupt_entry	hv_entry;
> +};
> +
> +/* chip_data is passed around as a struct tran_int_desc *, so it must
> +be first. */ static_assert(offsetof(struct hv_msi_int_entry, int_desc)
> +=3D=3D 0);
> +
> +static void hv_vmbus_unmap_msi_interrupt(struct pci_dev *pdev
> __maybe_unused,
> +					 void *chip_data)
> +{
> +	struct hv_msi_int_entry *ie =3D chip_data;
> +
> +	if (!ie || !ie->hv_entry.source)
> +		return;
> +#ifdef CONFIG_X86
> +	hv_unmap_msi_interrupt(pdev, &ie->hv_entry); #endif

Since you don't want to check the return value from hv_unmap_msi_interrupt(=
), add a (void) to the front to prevent some tools from giving warnings.
