Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011025.outbound.protection.outlook.com [52.103.13.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B093822A9;
	Thu, 27 Aug 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804921; cv=fail; b=sFiMK4xTf4IJ20eZK6WtIY+eROaz7PR3pRV2sITenjgymBjxjAgJM1FCkL3HDpdlibwb2OnkqfFQt89+RB90ME3fBrO83G11CMp8HwTsddSxTGXlgNTvnBq+DOcTqdATM/pgYjxMQDl/IIJ8oWqLhDyHDsTsAp7MWreA+rPl/24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804921; c=relaxed/simple;
	bh=VmhEef9JI8bjC5ZVvANfHCTmymnPBuG1YoX4QflDLCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7QY3OA6gNHkYjaGQMD+lFAnfZITODxuroXYTvtEaPDeY5pgf4rVIrR6s352d+rL7gik48dbi0cTegiZKRbpi24VygsxAzvq6va2caRplzra3Ps/nV1xh6CFX1xLfre9hcaC4VjV9FUzaNDzxSQNl/TxpDYAfZ+nHWlq3t2YQdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J2ZrtMB3; arc=fail smtp.client-ip=52.103.13.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J2ZrtMB3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjDav9GUAWqyJQQti6AoSEolUzTecEnV7oFy9G9+Gye2TwioIZrNlsxWKyZAR8wEoxw+Yzb+zk9ta9aGN2jt0MSUOLBKexPWcxYXod8/w0Kcbsrj85mFtNydwJDnXJDO0ZpRsVOhyT/QHDCH2AoXL03j9oqmP8Bi3ykuG5JglsAlQ0UxcH2rXfBMfpX9f4TxoVHtQYP9TQIWHfh7MzcN69wJ43JPKz8UPyjvgIPH+Fz17QMOIIYD3Ndzo2LokhUxHFr9R8Bn4Q2ZlXqKnQX/wwK7emtpqMyCdQ7hk3XmmqQQRKet1Q0gdbN+nEBpdSZb09RxWsYDvGKYWE6DCkBEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmf8wmKUdfrJPNuff+aeSkEwVK4/n+P+0/pAHbRU29Y=;
 b=X2hM/nmfS8A4rufrtzAlQMHFuDy+XpaHv57jdn+qIqNWbsfk6r8MTSZzOg8KEia3rHcPCV9mgVjLjmGJKXPSRAp5ngIDv1eIB95fzn6GPwWMbyO6T3+gqOO3q0XibDa45pLWnx8CbYaVGLvfjMmUouhmarqPYKILj0dHEbosbeo8RdeNTy83pCT6eryk8H/hkmk1jtr9bVDPcqlH5FZ/hrKv1ctQ89wO61CpKy6TITszhH8T7FREys9rscPQViokxHAfrGSeCAKCyzBulABqYN9WtmN0ye01Ri7bPrXPMagz08JATzBrNFSbjF14Q/M+7JJl9ypKe57VLgnchGzO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmf8wmKUdfrJPNuff+aeSkEwVK4/n+P+0/pAHbRU29Y=;
 b=J2ZrtMB3g8IgLx1OJ16leGjM90+ASYSZHZ0wwaE2voL8U0tOJGJB9x1brYpJuM2LggPuOAhvSIpDJ+aPLd4zPeG+p71AXP/6H3+blnZA49GBMG0PmPkoU6LV2mGpSwLONyHrWPKDIVGMN67vW+KXq/biaJ7qBtqjWPbxBHvYPiegLZy2fmvaMo9MuyGWsQZoSo8Y3R8l07evL1RQboeLYQeDb3ej1ST3NylgJDaFDM2swsOgDzPFbC0H1Br9Dxpb3OjMO6/6k3obp8kXfbT4r3LfeZbaaRAdeu3w3nPjsvr/vLtX6Lhdvnlh/6qyyzfC7HgOz73aQQVPcQZdu1JNaQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7011.namprd02.prod.outlook.com (2603:10b6:a03:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 04:28:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 04:28:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "open
 list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
	<linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: unmap MSI interrupt on the nested root
 partition teardown path
Thread-Topic: [PATCH 2/3] PCI: hv: unmap MSI interrupt on the nested root
 partition teardown path
Thread-Index: AQKjGFGck1AJEvvCYICSEZT2NjuzuAI02fCOtRPOf1A=
Date: Thu, 27 Aug 2026 04:28:34 +0000
Message-ID:
 <SN6PR02MB4157B8B7D644D489D147ED35D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-3-wei.liu@kernel.org>
In-Reply-To: <20260822003623.2925128-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7011:EE_
x-ms-office365-filtering-correlation-id: 7b240049-c7ae-4451-6a51-08df03f3a873
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|41001999006|25010399006|19110799012|37011999003|31061999003|55001999006|15080799012|8062599012|13091999003|8060799015|24021099003|51005399006|12091999003|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?WLOPzW5TBK8+Ak7wJh6YV7lGojUsyL/WZFqL1/QYFRm9N3pEZ2iAplZGCy?=
 =?iso-8859-2?Q?CmdlDmabNLvx/gYZL3bVXEfpX+KhQ3k4JwMcKe+taE1JuW/MrPK9O37AIp?=
 =?iso-8859-2?Q?ZtRKkAhANbNCw5oc/Rm96F8ar1LyoZK/tyrvjl4ZSgQpjBa9a2TE8jn+/x?=
 =?iso-8859-2?Q?R/+jCmRhQB4KlBiuAQZXYgDeO0NR4oYyOcC18nU5ThrWMPJFHLLXUhKv3j?=
 =?iso-8859-2?Q?w0wV9rIT6Wnrt7V1HaW7nqWVPTmpiPWeYYO+PsqnUbgbI9QXRwT5iHs+lK?=
 =?iso-8859-2?Q?2P2eFczv/LzsrTSO+sN1vlwNSuRO7O8hdEhM/t+E+oVQ0VgZvGFqaHO5al?=
 =?iso-8859-2?Q?k8W4JWqecDaYiq5irN9eLQm+jT6yiWIs6NcyXpkJpqiFBcY5UN0ILocaJf?=
 =?iso-8859-2?Q?b27bk6b4oRm2f2kn7JtZFCvkyV8Z1q0HDgZ6xOwoZGxU7YeKEWBLA/FEA9?=
 =?iso-8859-2?Q?stEzX+mm67SNXljnJuEUvKiYsjvGEISfD/RHuhgYyHPS9yWg7yqbAyQxUq?=
 =?iso-8859-2?Q?3m66bXd+fZvILCfd1cM11DcB/GJIFlLVnVOE7VH7qFUR+QQKSWgQmOcW2B?=
 =?iso-8859-2?Q?lG7Dc5MOWi6HAfget8PiZLu4TnQ+rks3xWSK8Rzms5IncKzNV9+D/rH6z2?=
 =?iso-8859-2?Q?yrnAAcMwUEqnYkYEPy2406ABjMVJX+v41QA/ntDEE0QlRKRzAkyK2lRWwO?=
 =?iso-8859-2?Q?g+UZQDSY9jVOOHLdGrG2Qq07+JHPFg/pVr5ZZ9vyKHplHdRro55AKITnu/?=
 =?iso-8859-2?Q?EqsO10MBJJrlrXgb7K9C5HT6PV8By7izAxIW8PCOc9n2NqHGjOrYD9nQI+?=
 =?iso-8859-2?Q?occQ2b9l0eyxUxCqgxfvsQbFnFui/+iMs9FLDGiaMpcjkSeeS9YlOqLL+o?=
 =?iso-8859-2?Q?2wbUekM76IsMJVaiETLSmy6Inv1rSuDcD7724yo1ObMiBfXMSbu5As+kSe?=
 =?iso-8859-2?Q?v6RAdmeaBEgSGRq+hGAKVPP3PI0aB8yvJ2aAGmagxnkYEStyRraygoJpvp?=
 =?iso-8859-2?Q?ba9YZbbJU98nHeYksv6Cdzv/ti5dZDGRzqsZ7WEsKeJGWpdjW18xhsUB7m?=
 =?iso-8859-2?Q?2eS+rIx0QrfYuN7MMqwRYUdQOwuMH40fOIZpvNeAhyXSSTHHnvxh1zg+gH?=
 =?iso-8859-2?Q?KEgypNKTKs5lGT3ADGRdTVlEBDBskGYZu9lesowMRUt/zEzNQv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Q/oZeaWAT5Fl7a0k/ponvyM4rnLuctPSL279gMVTMteNd+9ZnWGB3A3PzS?=
 =?iso-8859-2?Q?Po8fJnOJaOb7hoSIAbcTyzsWgRBKWk40awLczaobWQH5TCNeeoh/0Zkwhc?=
 =?iso-8859-2?Q?tba8tWi9Y+N38+d8pV3LGXlf03BAKcqKBWbeo0ZVp7iNhCxgyzBosQpisv?=
 =?iso-8859-2?Q?AEdO813zz3V4b1kPHVNS9kyYjoRagi2h2bVdjQMxU+ywcoac3aLtamoHcv?=
 =?iso-8859-2?Q?lvR3U7n29P9OEbVjRxUrAEVWmZgMaZ7TPohDHCLATzjcEz5xz4JBWcZnZY?=
 =?iso-8859-2?Q?twgKA6zRq0NVWZZohzIXwNpp7wFhq2D3F53fzHf44he9DohINmGbstvXYg?=
 =?iso-8859-2?Q?iqiyAUhq9ca1sppnz848rE5chD/6lMrBLX5rgM2YMYRmAt+JeEgNkhPsE/?=
 =?iso-8859-2?Q?BoagUvPYL+WvmgEAO8p+fJjkPZNVloxUaSis095w2erfFjzG9dgsNu6w6O?=
 =?iso-8859-2?Q?t/qO62Vo6ePpShAwHjpddmPEbFyHhrmKFuXGZtuwdkSJWzsS7KC7K6p9h4?=
 =?iso-8859-2?Q?/lK8DfHjsT4oTboVoMELqPZVfCtqGxiqmIgWwG7Ed08U0JWuMSN94JqI56?=
 =?iso-8859-2?Q?gutpE+dFs89Vc4gkipcCzsssgTZEWXOcBhHwTreCypufb/4Xl/6c/LKlXv?=
 =?iso-8859-2?Q?hDtZSjcW4WHsD2Qpn1xoCGwneZiNsA+eaU3TsaVN0EJG7ITzVzPLrTobVn?=
 =?iso-8859-2?Q?FgjjOSMMpl0bjknSSXQW/vdHuFMS6hUnuNUv4pd1gd+34rp8KNlUVCdAXP?=
 =?iso-8859-2?Q?DWA9ZtMXE+OWPmKUNXDaI1pMhqDY1cXwrbE+UZbYxoJRlZrMCTwILeFRmZ?=
 =?iso-8859-2?Q?gpbZCYt108AcAx1eMjOfSQGveuJO5CVAqF7vgOF941MS5Nr9Z55e+xsIua?=
 =?iso-8859-2?Q?Js6c9Qi7dhZOEwKsqa8QMxgKjtZi1grqyXHAQwdnqUaWzpF+eshimidyBH?=
 =?iso-8859-2?Q?SqJbW4sdbsV4pbZCtfmaSCe7YSiVWausMMdy+3Pmwkp+JxZZyRGvBE+nbb?=
 =?iso-8859-2?Q?xEPflvKN2NjJFv6VuD9xLHF314R42fWKVtvJGoKomwmwaDNJ35ZciWd7UK?=
 =?iso-8859-2?Q?sMo+gffncBU74F04RBaokU8Dg+63CFeG9bLJeksfRmC0uqRACqWmnUrO+S?=
 =?iso-8859-2?Q?s0qCRGaAwdTxTk17bWvU/WJTsZ+v0QlFIBj+8hqzlAqD8UEejaIK6Koi8Q?=
 =?iso-8859-2?Q?FW4O/IslnsX3Dg8nbV1eeLClMkTT3BC3bXBBjyRailugtb6z2cWNitArc9?=
 =?iso-8859-2?Q?F5wKonVzAnxW7RSRl2bTaGeS1GKY7nZSoLulz/e3OLdVmEcTs9ooOn8Na7?=
 =?iso-8859-2?Q?nJBC9whulWhQ7/F6WkzR3dU+J7Q2T1o+9DKZMEa7aZqukeHqG4DFbV3J+y?=
 =?iso-8859-2?Q?C91v8ArBnVQTsa2obe++ugSyA87ZO53d2HFQu6UoNK89ofwNPvFoE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b240049-c7ae-4451-6a51-08df03f3a873
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 04:28:34.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7011

From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Friday, August 21, 2026=
 5:36 PM
>=20
> On a nested root partition the vPCI MSI/MSI-X interrupts of vmbus

s/vmbus/VMBus/   [and other places in this commit msg]

> devices (e.g. the MANA NIC) are mapped in the hypervisor with a
> MAP_DEVICE_INTERRUPT hypercall.  This is done from hv_arch_irq_unmask()
> -> hv_map_msi_interrupt() because the nested hypervisor performs the
> interrupt remapping and a RETARGET_INTERRUPT is not usable there.
>=20
> The mapping was never removed: hv_arch_irq_unmask() called

s/was/is/=20
s/called/calls/

The wording in this whole paragraph shifts to past tense. I'd suggest
keeping present tense for consistency and per general kernel usage.

> hv_map_msi_interrupt(data, NULL), so the returned hv_interrupt_entry was
> discarded, and hv_msi_free() tears the interrupt down with a vmbus
> PCI_DELETE_INTERRUPT message (hv_int_desc_free()) without issuing
> UNMAP_DEVICE_INTERRUPT.
>=20
> This has led to MSHV rejecting already-mapped (vp, vector) pair from
> being used. When this happens during early boot, the system hangs.
>=20
> Keep the hypervisor mapping in sync with the kernel's interrupt
> lifecycle.
>=20
> The mapping is only created on x86 (hv_arch_irq_unmask() is a stub on
> arm64), so the unmap hypercall is guarded accordingly.

See comment below about the x86-only situation.

>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 85 ++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad..5a36382742bf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -283,6 +283,35 @@ struct tran_int_desc {
>  	u64	address;
>  } __packed;
>=20
> +/*
> + * On a nested root partition a vPCI MSI is mapped in the hypervisor wit=
h a
> + * MAP_DEVICE_INTERRUPT hypercall in hv_arch_irq_unmask().  Keep the ent=
ry the
> + * hypervisor returns next to the per-interrupt transaction descriptor s=
o the
> + * mapping can be removed again with UNMAP_DEVICE_INTERRUPT when the int=
errupt
> + * is torn down.  tran_int_desc stays first: chip_data is used as a stru=
ct
> + * tran_int_desc throughout this driver.
> + */
> +struct hv_msi_int_entry {
> +	struct tran_int_desc		int_desc;
> +	struct hv_interrupt_entry	hv_entry;
> +};
> +
> +/* chip_data is passed around as a struct tran_int_desc *, so it must be=
 first. */
> +static_assert(offsetof(struct hv_msi_int_entry, int_desc) =3D=3D 0);
> +
> +static void hv_vmbus_unmap_msi_interrupt(struct pci_dev *pdev __maybe_un=
used,
> +					 void *chip_data)
> +{
> +	struct hv_msi_int_entry *ie =3D chip_data;
> +
> +	if (!ie || !ie->hv_entry.source)
> +		return;
> +#ifdef CONFIG_X86
> +	hv_unmap_msi_interrupt(pdev, &ie->hv_entry);
> +#endif
> +	memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
> +}

This function seems out-of-place, as it is added in the middle of a
bunch of structure definitions. There's large #ifdef CONFIG_X86 ...
#elif defined(CONFIG_ARM64) ... #endif block in this source code
file. I'd suggest putting this function alongside hv_arch_irq_unmask()
in the x86 section, which is where hv_map_msi_interrupt() is
called. Then put a stub in the arm64 section -- there's already a stub
for hv_arch_irq_unmask(). And maybe name the function
hv_arch_unmap_msi_interrupt() since it really doesn't have to do
with VMBus stuff like channels, sending ring buffer messages, etc.

> +
>  /*
>   * A generic message format for virtual PCI.
>   * Specific message formats are defined later in the file.
> @@ -715,16 +744,30 @@ static void hv_irq_retarget_interrupt(struct irq_da=
ta *data)
>=20
>  static void hv_arch_irq_unmask(struct irq_data *data)
>  {
> -	if (hv_root_partition())
> +	if (hv_root_partition()) {
>  		/*
>  		 * In case of the nested root partition, the nested hypervisor
>  		 * is taking care of interrupt remapping and thus the
>  		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
>  		 * RETARGET_INTERRUPT.
> +		 *
> +		 * Keep the returned entry so the mapping can be removed again
> +		 * when the interrupt is torn down.
>  		 */
> -		(void)hv_map_msi_interrupt(data, NULL);
> -	else
> +		struct hv_msi_int_entry *ie =3D data->chip_data;

There's the inline function irq_data_get_irq_chip_data() which seems
to be used instead of directly referencing the field (at least most of the
time throughout the kernel).

> +
> +		/*
> +		 * A NULL chip_data means hv_compose_msi_msg() failed and the
> +		 * interrupt was never set up, so there is nothing to map.
> +		 */
> +		if (!ie)
> +			return;
> +
> +		if (hv_map_msi_interrupt(data, &ie->hv_entry))
> +			memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
> +	} else {
>  		hv_irq_retarget_interrupt(data);
> +	}
>  }
>  #elif defined(CONFIG_ARM64)
>  /*
> @@ -1708,6 +1751,7 @@ static void hv_msi_free(struct irq_domain *domain, =
unsigned int irq)
>  		return;
>  	}
>=20
> +	hv_vmbus_unmap_msi_interrupt(pdev, int_desc);
>  	hv_int_desc_free(hpdev, int_desc);
>  	put_pcichild(hpdev);
>  }
> @@ -1882,6 +1926,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  	const struct cpumask *dest;
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
> +	struct hv_msi_int_entry *int_entry;
>  	struct msi_desc *msi_desc;
>  	/*
>  	 * vector_count should be u16: see hv_msi_desc, hv_msi_desc2
> @@ -1932,9 +1977,10 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta, struct msi_msg *msg)
>  		hv_int_desc_free(hpdev, int_desc);
>  	}
>=20
> -	int_desc =3D kzalloc_obj(*int_desc, GFP_ATOMIC);
> -	if (!int_desc)
> +	int_entry =3D kzalloc_obj(*int_entry, GFP_ATOMIC);
> +	if (!int_entry)
>  		goto drop_reference;
> +	int_desc =3D &int_entry->int_desc;
>=20
>  	if (multi_msi) {
>  		/*
> @@ -2184,9 +2230,34 @@ static void hv_pcie_domain_free(struct irq_domain =
*d, unsigned int virq, unsigne
>  	irq_domain_free_irqs_top(d, virq, nr_irqs);
>  }
>=20
> +/*
> + * Runs from irq_domain_deactivate_irq() during irq_shutdown(), before t=
he
> + * parent (x86 vector) domain is deactivated and the (cpu, vector) is re=
turned
> + * to the matrix allocator, so a freed vector can never collide with a s=
tale
> + * hypervisor entry when it is reused.
> + */
> +static void hv_pcie_domain_deactivate(struct irq_domain *d,
> +				      struct irq_data *data)
> +{
> +	struct msi_desc *msi_desc;
> +	struct pci_dev *pdev;
> +
> +	if (!hv_root_partition())
> +		return;
> +
> +	msi_desc =3D irq_data_get_msi_desc(data);
> +	if (!msi_desc)
> +		return;
> +
> +	pdev =3D msi_desc_to_pci_dev(msi_desc);
> +	if (pdev)
> +		hv_vmbus_unmap_msi_interrupt(pdev, data->chip_data);

Same here regarding direct reference to the chip_data field.

> +}
> +
>  static const struct irq_domain_ops hv_pcie_domain_ops =3D {
> -	.alloc	=3D hv_pcie_domain_alloc,
> -	.free	=3D hv_pcie_domain_free,
> +	.alloc		=3D hv_pcie_domain_alloc,
> +	.free		=3D hv_pcie_domain_free,
> +	.deactivate	=3D hv_pcie_domain_deactivate,
>  };
>=20
>  /**
> --
> 2.53.0
>=20

