Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010040.outbound.protection.outlook.com [52.103.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D783AAF5A;
	Tue, 18 Aug 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029859; cv=fail; b=lYkQsxlkfniz0zNxXw38CXver8/HCERl1qrr5nhsmX7xSJFbnwlDS+m19WZ4K08IO0/DYaEGzEitLKxkv7b1nl1IrQpHlsCDPKfcT/MAhR+1ZJRfOLDikj2VSbh/gu9oDKh4IO1XTaQKaCUUITdnW8sqIeDYbW/6oUjmXxXGQYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029859; c=relaxed/simple;
	bh=une7FYVVCwa+USM5BOl08SldhbvnfW8LzECGddhkV94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gr+nchWveWf+w3g3Dm5jLvHg3o7XwtOPRyBPzKckimAO6NOa9X7bq8H/oEsWhoNIPBULCt5cLACtKR/F3UolfZoC5iTz8ySeUKSsba3DoYGIYwwXErAAt4mO5jjgiXSXG6TjRin8fDvKGaqxK70UDUelN4lCgYI1PiYVV58oRqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IKnc4k1n; arc=fail smtp.client-ip=52.103.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IKnc4k1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slcW0xj5+O61HQoKkIHL3Ibu15tdTIsnePOwOO3sROL2jboZCUIHIFjb8Blid+g0QtFzU+QUhLQPGJKi3fnjgmlrYgvHvCn9OjZ5YXmm0XkWCXMUJs7KTwVH2OMsjww2hoR1KcGuYzNdx3lLEOhI8mOV+c9rmLGCn0ySnK2O38QaDEi/sY0VCk8M5qiO2rxSkFKLYGPny7sPqb4kXr7ipb6uFWzvTYI2WAtYhZdjmSrbGrH79FC3QRLdWC6w6kaSrmeNzUpx5WBFM5tPxrmvF8L8DIhMKCdG2vIFBbqURP/fd6+t3YLa11IyCA0LZnjMggmhRQdN2P6jDiC1ruZWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbHsUc+iXRc31/taS7TZ1Tgv8Riv/7EZg9hxCQ66ZOs=;
 b=Z6VqGKEGGP/WWbANhefLkj3TR6up/9s+gD1ko4BtQtYu2qqaRUXoaN/0ZW6ucaYYLN0W6l4yN/1PENUO3QEsFNsD0FrKpHH4dOB/U9k7n2ge7ByH+Czn/gYe8moVxZP8wbMHVHKjFdaiqRZVwAzLDp65yGQTzEn4Wm7Sr52HYbMViERRGKMbTx7Z2YIoZmvewSNpz7odP3TDykZwoSW6jTKNubaEg/804r6scCJbYTP4zHINPabf384EcvRjNzqnYbHOYVaQnC+VEWNACwsQJT8IkdcAy3gU1Vz/5aFZPLKp7frybZVciiFEwsR40Cm/7VGOcLGEdQaiG7ddE4moyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbHsUc+iXRc31/taS7TZ1Tgv8Riv/7EZg9hxCQ66ZOs=;
 b=IKnc4k1ndxzGNkJ5B8WiKj/k3ltcMr0mjl3QgfJmALoca8OvzRQwPVjcMCoVYRlcCex3nKqKLml6GpE+zvwNuDSv4CeP8Uuzk3ldogjJCrSxZKBvoNkmtVKp/OY6VjfzaR4OLW0trcSijuET02xXerGW6ZN4qVgHoQ7Az2m2/CiRwoQwlLCZwB7/jRtXB9Gouwm4N9QsuCk89NPOkFeFCLPkmXFf/Wbc0v4L8BdwB/iRbuZ+dgKWgkxY7H/xvnaLN17TbruGhpzLylWojlo4cVQsNeXlz1hKyeYX1MW9+/qczww9oH3zlt33saUCQ3wpBr2NvR83OhYYkS4egO5tug==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB11185.namprd02.prod.outlook.com (2603:10b6:8:333::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 05:10:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:10:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Robin
 Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Aditya Garg
	<gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Thread-Topic: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgI+SZDwttputzA=
Date: Tue, 18 Aug 2026 05:10:52 +0000
Message-ID:
 <SN6PR02MB415737853F902BA2FFD72719D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com>
In-Reply-To: <20260810090716.2325295-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB11185:EE_
x-ms-office365-filtering-correlation-id: fdf26026-f161-4de7-3ca9-08defce713a4
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|16051099003|37011999003|41001999006|2604032031799003|51005399006|13091999003|31061999003|19110799012|8060799015|8062599012|15080799012|25010399006|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?g/2+UtVinOSgLfpXIVO7DdLd0ty6QcxoU0CvA0cNXFpVHknA09A0BD88WG?=
 =?iso-8859-2?Q?kSVHTtGJQ+jT4S/bCwPld2INHj1mhuNkb9FSgbSe6GDHXL6iX7SiTX1eKl?=
 =?iso-8859-2?Q?1SJVrt12tZKgNgS+1ZuL4VQSx6dWwdBdpnK4R7+YGJjCrEMQDmYoG9j1MZ?=
 =?iso-8859-2?Q?kqjwi3O7mFEy52wYUujDapVBmc1hMm3k6c2/SvNmySe5BLjKSNsQRJWtV/?=
 =?iso-8859-2?Q?0fn3TxAbx+k3bF2woHMFzX1H7XUvlMc4jx4dfq6IjEERd9ChPlPBXlDFGh?=
 =?iso-8859-2?Q?EGR3ucScE9WgKhmXv311up50GrgAtJtj/nynEFqHkYAtzTGMeS650KnYzw?=
 =?iso-8859-2?Q?QOfBqNbUq9xa4LDJQlwOMcyHH2NmxPOTord6LzFNsZkXJrTWOeQI5skYP4?=
 =?iso-8859-2?Q?SnzPda/vid1wK0wxTHhMMS16SuI32dw7WtvS3Sq9f9q3Nhl5s+MD1WIxrJ?=
 =?iso-8859-2?Q?zFJuMWBMXOOGalxgMnIVo2waLliLebA3PkZsFFrB0npkm0Ukrwvu+7w1tf?=
 =?iso-8859-2?Q?iAJXpCE0SCNPYMX8Fgsc9oz1wTehlOMcazk4djS5XDSTDVFEoxwbx8L2mN?=
 =?iso-8859-2?Q?hE8Q37JIbMZQKJx3L4plh8K5Wp3UWb3Xq5eTIrL+SiRrplCjt6BTVEoCGl?=
 =?iso-8859-2?Q?yHoHnCi4XfmFWFbnrOfrani7JUIqY6z4v9OZy2pT7RmuTCSDA5eec20qYH?=
 =?iso-8859-2?Q?2yyBXa7ebuY9ChPc2wxNztOYR8Lws058JZdsdupn8t+okbrtVoXpHwjZqd?=
 =?iso-8859-2?Q?hCnuPJFfmh7BTy5sa3ImS0LQNLcQLYIC/BpcX2qMVUHHQGX66eEkfe6ODy?=
 =?iso-8859-2?Q?DDmwTP3f3Z/dAMKYfknQh0eSrlKix1c3JZI8jjMCd1W+0IUsq7D82H20CI?=
 =?iso-8859-2?Q?wWOmOfIyp/+Mcw4LjtvXhpxgmTpeX1dG3ZyQAVptd0n4dTsPg2bynchia/?=
 =?iso-8859-2?Q?6GHa4MSkG9T5GU14O1WbdSoB4T2WO1LGvrnH5JEd6MQiJR/aCrLHBduSjN?=
 =?iso-8859-2?Q?KuQSO8LtpI2ACPu+OXrUCO0YKSBorCbRZEVuOVUv1gUyFbRR2RyPyW/71T?=
 =?iso-8859-2?Q?CVLJIeIgzwvSFbZREgNHxil8na4szN7xIjAPBBtThwnM/XyzQLybLPOAnB?=
 =?iso-8859-2?Q?68v8qQXJbPh9l+6gmj/fFNg247LnZtZ2cEk6Rx0EC3JZB7IC21fKVWY7rO?=
 =?iso-8859-2?Q?39ImeKqbEA575A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ldlDEbG37sCo0Q/7qNCBUCUjScsGSxk6t/WgFsYyeGcitpvunJK+uxb1Zg?=
 =?iso-8859-2?Q?mLljZT1pGf+u/Z5LMHyMOlrJrAWHPjd6RgIzKCk3GVdl6XbblDcPqbA+nZ?=
 =?iso-8859-2?Q?DvG1v0koEC6ePuDa1Ydqe3sRFrGABX7xDqvn0fKCsWRyxJBCTKdjgGdkVv?=
 =?iso-8859-2?Q?8VIJLUHI117D8FYcOv+leh3i/IF02Mhe/YBWoB0QhQbccNULhVxmkpAyhy?=
 =?iso-8859-2?Q?w2IJnBjtGY84uOC1CRqIAoDd4lb49bxHEyM7sf4EyO41CrE59boUtXOOSA?=
 =?iso-8859-2?Q?cJvfDmhbaFfH09iOFwkNA21aEvVegToaKLteC0uK5Z/1WpVlAfiy5XapKy?=
 =?iso-8859-2?Q?UJ5jRxzcSMjmFcg48UrYlqSzYzBVGz8ALObjK5ZkglUV2CrEHiJbgZpbZF?=
 =?iso-8859-2?Q?jChVdD5LhM6Rwv7S6+zhxf0Yhs2MhKpvWNesJRRyy6CVAJec1XMdUa7cM3?=
 =?iso-8859-2?Q?t+dicgRzK4QJ+X7AAQTRikzbE1o3GW7BFWFQFI0RGnngsRkMlgQcuIPQ2F?=
 =?iso-8859-2?Q?jDBlvWwKDbp1XwOuQXv/XCWMJx3dm1gTRIs2lEOqKOvn9EOCpvux/vRH3F?=
 =?iso-8859-2?Q?G3JPsRoC+m1NyiiG5o/KQjMgRy5Lfs5J7F9ac3PrsslJ5qoHfElByW11Mz?=
 =?iso-8859-2?Q?1zS9o7CsqQoY5ROWWTjsfTg9RX39DtrlaSBIfBrk1tc1TCcYYmbwjAyweB?=
 =?iso-8859-2?Q?Ebdcb6usHHo7mAJVI2G59ZzNqjWU5Rev9yKCtd4UByrBYjtazopmZt1/3Q?=
 =?iso-8859-2?Q?aq3/EZNhcpRLQ/lcA9m/wsmwylcb+3jbnqDP1Mo6UBlJByx0BFuvibfpZt?=
 =?iso-8859-2?Q?obMUzmd2stjQHrULW6au3R+89jQQaqOxno8Bqp3DzF1VUlMxhKIOqBsunq?=
 =?iso-8859-2?Q?JjGNNOcSPEdJ8IZfBBq1g1D2iWHisttcCAhpRCbMWA4NYKSBo6U8kWXHbe?=
 =?iso-8859-2?Q?D/fABY234b/7+hjk9zcR4QWs6HEqn6D5zKAvJuIxAhdv3mVKr5BkAbCd/y?=
 =?iso-8859-2?Q?kGa9XzO6y9rAC8kPzxVQExgjCF2i+W1sP8hgUo9jiiYQDPr9T1cZzRt7Gl?=
 =?iso-8859-2?Q?qgGjwQ4Z/7C56B2EOBzMY4BvRnoC8eRKiHcllmY/gGu0SLiPqKiqdLGydB?=
 =?iso-8859-2?Q?0l//iMmdE/SIU7EvQAhNrSAsXeFP9zBQ7cFxFx5puHMQt8m+hZY/sAY1Es?=
 =?iso-8859-2?Q?RuObVHUwn/Lmpyl12f4Mlqf7lUSgEjZt/ahZ/zBCL+YY8+45X9WDabtQlX?=
 =?iso-8859-2?Q?BJtST/GgEASfFUYQgh1bKr6+UhWOHlKH51B2Lhz/ll8phUqNS9FlMz8RpY?=
 =?iso-8859-2?Q?lfvTv9seFnrV3VMdNqh1fw6aFDt0jcp7LzU+/+bVuyT+t4SCTzGnymxxii?=
 =?iso-8859-2?Q?TClbLZyrTf35S9GwsdfKGzOWt/5klyy9TayDkXoT2W0axXLMsK4KE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf26026-f161-4de7-3ca9-08defce713a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 05:10:52.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11185

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, August 10, 202=
6 2:07 AM
>=20
> With fixup_irqs() now using irq_chip_retrigger_hierarchy() and the generi=
c
> resend path (try_retrigger()) already falling back to it, installing
> irq_chip_retrigger_hierarchy() as the irq_retrigger() callback on the
> outermost domain chips is no longer required. The hierarchy walk reaches
> the x86 vector domain's apic_retrigger_irq() for all of these stacked
> domain chips.
>=20
> Remove the now redundant irq_retrigger() initializations from the outermo=
st
> domain interrupt chips.
> msi_set_affinity() is the only site that invoked the outermost chip's
> irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
> the x86_init_dev_msi_info() initialization can be dropped as well.
>=20
> No functional change intended.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/kernel/apic/io_apic.c      | 2 --
>  arch/x86/kernel/apic/msi.c          | 4 +---
>  arch/x86/kernel/hpet.c              | 1 -
>  drivers/iommu/amd/init.c            | 1 -
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  5 files changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_api=
c.c
> index 7d7175d012288..18f49a251f23b 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1857,7 +1857,6 @@ static struct irq_chip ioapic_chip __read_mostly =
=3D {
>  	.irq_ack		=3D irq_chip_ack_parent,
>  	.irq_eoi		=3D ioapic_ack_level,
>  	.irq_set_affinity	=3D ioapic_set_affinity,
> -	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
>  	.irq_get_irqchip_state	=3D ioapic_irq_get_chip_state,
>  	.flags			=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
> @@ -1871,7 +1870,6 @@ static struct irq_chip ioapic_ir_chip __read_mostly=
 =3D {
>  	.irq_ack		=3D irq_chip_ack_parent,
>  	.irq_eoi		=3D ioapic_ir_ack_level,
>  	.irq_set_affinity	=3D ioapic_set_affinity,
> -	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
>  	.irq_get_irqchip_state	=3D ioapic_irq_get_chip_state,
>  	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 66bc5d3e79db3..aad2f15eb2176 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct =
cpumask *mask, bool force)
>  	 * IRR.
>  	 */
>  	if (lapic_vector_set_in_irr(cfg->vector))
> -		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
> +		irq_chip_retrigger_hierarchy(irqd);

Again, this will miss the outermost chip's retrigger function if it
is set to something custom.

Michael

>=20
>  	return ret;
>  }
> @@ -246,7 +246,6 @@ static bool x86_init_dev_msi_info(struct device *dev,=
 struct irq_domain *domain,
>  	info->ops->msi_prepare		=3D x86_msi_prepare;
>=20
>  	info->chip->irq_ack		=3D irq_chip_ack_parent;
> -	info->chip->irq_retrigger	=3D irq_chip_retrigger_hierarchy;
>  	info->chip->flags		|=3D IRQCHIP_SKIP_SET_WAKE |
>  					   IRQCHIP_AFFINITY_PRE_STARTUP;
>=20
> @@ -313,7 +312,6 @@ static struct irq_chip dmar_msi_controller =3D {
>  	.irq_mask		=3D dmar_msi_mask,
>  	.irq_ack		=3D irq_chip_ack_parent,
>  	.irq_set_affinity	=3D msi_domain_set_affinity,
> -	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	=3D dmar_msi_compose_msg,
>  	.irq_write_msi_msg	=3D dmar_msi_write_msg,
>  	.flags			=3D IRQCHIP_SKIP_SET_WAKE |  IRQCHIP_MOVE_DEFERRED |
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 8dc7b710e1250..2bb7a6f466af3 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -509,7 +509,6 @@ static struct irq_chip hpet_msi_controller __ro_after=
_init =3D {
>  	.irq_mask =3D hpet_msi_mask,
>  	.irq_ack =3D irq_chip_ack_parent,
>  	.irq_set_affinity =3D msi_domain_set_affinity,
> -	.irq_retrigger =3D irq_chip_retrigger_hierarchy,
>  	.irq_write_msi_msg =3D hpet_msi_write_msg,
>  	.flags =3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
>  };
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ea3377e61aa5c..0c362e86a09d9 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2468,7 +2468,6 @@ static struct irq_chip intcapxt_controller =3D {
>  	.irq_unmask		=3D intcapxt_unmask_irq,
>  	.irq_mask		=3D intcapxt_mask_irq,
>  	.irq_ack		=3D irq_chip_ack_parent,
> -	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
>  	.irq_set_affinity       =3D intcapxt_set_affinity,
>  	.irq_set_wake		=3D intcapxt_set_wake,
>  	.flags			=3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..cfc8fa403dad6 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device=
 *dev,
> struct irq_domain *dom
>  	info->ops->msi_prepare =3D hv_msi_prepare;
>=20
>  	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
> -	chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;
>=20
>  	if (IS_ENABLED(CONFIG_X86))
>  		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
> --
> 2.43.0
>=20

