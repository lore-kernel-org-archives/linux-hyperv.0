Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013087.outbound.protection.outlook.com [52.103.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7E3890EE;
	Thu, 27 Aug 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804940; cv=fail; b=aVaZ+xCqpUgbCOu903YHnrrxF0Bl2+OzH9rmixgqziGrBTH1SIczp5svFj5iB5Zla3veIlxzSFfCv9+tH9z41xuR4MN1oIx6EmKGeq+XPeyK9i3kw4cjdFfahbsamt2t965ZUPpuxJTgas9nlA5odYiJfAgFXDWDrCDpAv9A5NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804940; c=relaxed/simple;
	bh=3n1WaNw/r8dScV3PIa7BG/WQAcks3dK3IYlrAkGLfKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8BzPp58HIY77UuWLWQk70CxGHDa2VHvoKhCYAwzcvNG7yan/LjUobgBkp2MW/i1D4CRG5o7XjmBLW8wBAp0WHbqBMuDfwfFttWaPw9Aick3ESuTGVboiK4W2jdXePZSWFPhd0kSjLYdOaNTmv1ixiXxyEVoqqNJKJCgLvaDHt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kneGZaep; arc=fail smtp.client-ip=52.103.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kneGZaep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOwH/kmxNvjiRfejrjpTlEvIDgDHhZWzj655HJSChp4wU2fH9sazOcUxTwu9LY7QqOoHHL07twssGonU3NgUyr9/r9JuxDcGeVZ93MUzSQ4ntmucK+ufiK7ghPl7QXa412GnpXAi+zEfbmKClpOqEryDmbqLGxMRrggQrNXUi94ctCFyCwkD+u9g/vwye3Jup9cQNuEdv3eXHlNDgY3jJgXaQeCSvGUeSymeOAEfFZ7rNySv3ot5IXtG0yIXIxVHwWocHQAfWDXhENA81B55Jvo9xqd2O4AO83Exfaa6QbzT2yrLEUPk4aah3GWvlt9kpMzus1cdcFpEG6MG9mHFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFCfeezYd/s400fhG1VyXZet3oxuGdJ/wRjS+JD7oCo=;
 b=yl30Ilpf+/QGB67eoLBKKWIAD3R/bFSr7am5QZRdgYHC4DHuZp8G2o7ClmAlL/6U9M5h7UqvZdGbpmupqH80KkZ9AdWcSAnpiX6Rl+oZD4BcM7zPYh4fdwK1x8O3PEPp0gjwB18bY7cpp6tE9VQXrFfLBDiRbIBO6f4yKCVrSfiWdkdNXVi7iktLO/sAfD9SqGCkbDlaf5Hjm8WKaGHDy/yypLll2cEkTM+yykDWrpcnkVDUAgkrmQMXvSQ2RrSh14Qt7YqX6hFuFUePOwpvOqDISFyZrZAqihillN8FKNJYA+C0yM/HqC7mBf6+w7KbZl884weD+MLME8B/fFei5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFCfeezYd/s400fhG1VyXZet3oxuGdJ/wRjS+JD7oCo=;
 b=kneGZaepqpYa1Owm2/4cSmw0kfHD/fzLtHYqW4KdUq2vy4lTDacE/BtgK6CQFSac6pCvZADrvi2cuRy15D59WpuMxQdV6YY5OP/NjPJenGapEiqgQ40WHCQJiTllz7sKVh2rg0nE1R4sSat3DE07/X+hNA6JHXvDHJZt8xmfE0zyqLvYOZ2aLUqQAUEIOfXXW9UYRtaCtbPBU5tNd12AV+mXfiPAEcPwesp7feK5EeYn+y9L4WTpcih9osrHfq/H00NxRCNkzpvJGpnFhPGWl4VX/O8HoBme7uwrakpUDorArwcbpjHRRBL27hiyJvHx+UCejuYIVxqkx0Z6WGGWew==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7011.namprd02.prod.outlook.com (2603:10b6:a03:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 04:28:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 04:28:54 +0000
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
Subject: RE: [PATCH 3/3] PCI: hv: fix interrupt affinity change on the nested
 root partition
Thread-Topic: [PATCH 3/3] PCI: hv: fix interrupt affinity change on the nested
 root partition
Thread-Index: AQKjGFGck1AJEvvCYICSEZT2NjuzuAEnfXj0tRxDHwA=
Date: Thu, 27 Aug 2026 04:28:54 +0000
Message-ID:
 <SN6PR02MB4157DDA074C9080EBB7A79D8D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-4-wei.liu@kernel.org>
In-Reply-To: <20260822003623.2925128-4-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7011:EE_
x-ms-office365-filtering-correlation-id: 5ff29cb5-b006-4812-df03-08df03f3b469
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|41001999006|25010399006|19110799012|37011999003|31061999003|55001999006|15080799012|8062599012|13091999003|8060799015|24021099003|51005399006|12091999003|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Z5o0EE6EkNS2tQ4nRKAEJIqU7nUOrre9iFk+CIcDQae/BanXeDQOOkszoZ?=
 =?iso-8859-2?Q?kEphpy2tDMVFD+GiHTHhW9yTiyNNoKZkLwtZ7Q7ygrSKmHrUgdoTC4JoPV?=
 =?iso-8859-2?Q?bL/1FoIPi6Yvl8gcW9W8u0I8CvXwkvwKJXi++Ct8qSaMaac+30wHSfZgw5?=
 =?iso-8859-2?Q?eJSP5BiqCXaTIluNK0mbE5062B7heAkeM64XFnLb6n5BXWvFebx7VeXxM2?=
 =?iso-8859-2?Q?hZEjxVbgLMnwJp1Rr80sYhhdsCqSANdD5jIheHLdx7RRy97Z6jFKY+6PVS?=
 =?iso-8859-2?Q?yUtphzwZAeDf/LAXrb1yPVIi3Kned8aZ1SVriiMBmZrH33Y3fuHtdQxzvF?=
 =?iso-8859-2?Q?lah8T42Ki/3Sd7IVQ2QJ40GBjSa/S1mkOBhtkWFTH54jc07JeHway20Nka?=
 =?iso-8859-2?Q?L/JThDJpwQ7EuLuEvBhQONZLdJVtIkAJegK59+uyrtTTyTeWGiLe2lIbbk?=
 =?iso-8859-2?Q?jeo8QGcA7NLQM6kTCEYYVO4B0bTDI7Jg/kEJz7A4arfxYk+ysQxXQC6mFw?=
 =?iso-8859-2?Q?PqxSLpT3ULOtxSoaIK3LHLI/gD50JbAK4/yxp9qYnWrqDv1NxS4mrJMQC1?=
 =?iso-8859-2?Q?anWu7bb8LyMdh8QOZEc0YuMTrfns+o9RkKP/i3vyNithxBLrPhkd6S4Xjm?=
 =?iso-8859-2?Q?qJOx9TnxaO/C3ubyZ2NzxozrMMhimq1nyEizLJAW+FsneyjSdM+aDFq0qD?=
 =?iso-8859-2?Q?DwuWeAmpPojYz8+P76euI8siGGcxBCE+/8sA6Vvos1E5gUdDcnM7NMh5vC?=
 =?iso-8859-2?Q?cYBeOxI+RbthvyVZt3xiRKLe0gJqUJz3T0kfWv9EoeaGmwj2f35NG/y3Ar?=
 =?iso-8859-2?Q?xSHrdgsBRYtUu86sZ2VHe+3WYIuTsITInYupxILMBBjMc8pADKKfyVNAyQ?=
 =?iso-8859-2?Q?ahiydVvkUqIgOfm1mN9TnOwsYDA1hW74HCQG7e9qR7TikDyuV9YKThunLu?=
 =?iso-8859-2?Q?24rm6lyjV38BBhhfsqdd+C9RcBc7D9GLL2wZGcULzJEAkaireVb8owy8OO?=
 =?iso-8859-2?Q?qAKgDwOvx2QexVQgwEwniggGQJnz6wAnWqq266LEMyuXz754WiyHkBKM7C?=
 =?iso-8859-2?Q?DQTOfWvLON7ZjuZ2F6yOkiL3i02K3o5WMX/8Oj+b5WKWMPz+fo7lde/Ret?=
 =?iso-8859-2?Q?fTyGIKjhHxWmc4oUsKxOkegxafezb4Bkm+jif1f9/8RoQQ+qtZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mfeqAakQueqEe2XM1n06xhXv20RVI8k8ijDO69fV3zJCsnF81cOYqy0VDi?=
 =?iso-8859-2?Q?7sB/WMA47f/VrrzOEJEWuluh3LWO1uitnUCOpPxgHEcIuOq/238Q3AwsO3?=
 =?iso-8859-2?Q?Ke8TMCGzMpgiuRJEX5avzcP8nX8xifapPEgkxsCrHP0sYSsF/fDZxnyouZ?=
 =?iso-8859-2?Q?gqn0u0j30uyA6kBmttbiWAm4fmqCODfYo2VjXMNg0F23Z7+Lt0yAk9HBf4?=
 =?iso-8859-2?Q?fpJ0xE4uLnIqDNgdoLwxqxpk7xt36EtkIBOJbcK0N7pzQV2nqGJEcsIG54?=
 =?iso-8859-2?Q?ydqDivzbdA7CScIZjxWqtu2Q8hLJolbBroaVv9QJquNQfz0/PKNDcmqF5L?=
 =?iso-8859-2?Q?I4mcR0vwekzEjZBQNNi2DtfDm+6Q2Fhrs2Btd5pfG3PJriuM09zBbeAsC0?=
 =?iso-8859-2?Q?Dwl6HZICmb7MR/Kiw/lI760UYSdhCwiHi0m3edhJvs+iAg+cZEXloFsEZS?=
 =?iso-8859-2?Q?cQi6nR8pzmq/687h5VBRR2fzdqsOy3rAK++jY/l6fd/lbwJ+c/HJXp9RSF?=
 =?iso-8859-2?Q?yGztspVaTVWDUrcvzGNdEL69c2TNIIlcg+bOwGV9QFi+6ttb3bLr5hoT1P?=
 =?iso-8859-2?Q?y48VmvNOkUR8FETQy8zqYXnvawgjiCmQVTX+y8JvlDAiFpO6GcksqgMizu?=
 =?iso-8859-2?Q?xjX51mla3WfLd0VtwH0V+24lTBqEd7UNq55ObfMcUp86vGh9ITzCFHjjfo?=
 =?iso-8859-2?Q?KxBvp8ZrCs5MWCwNt95HtKVhX3PBO2gCD0TaGb1fwT+yH//bqUhWr+mMv3?=
 =?iso-8859-2?Q?RIvEBGWBXQNp5KKOj17RlXdPheAOf+rArosmi1P5nR0hbUucSlnLTP2n86?=
 =?iso-8859-2?Q?mHpY78NWoRKwt6C+95WKtEfZWTxiCptJcBVoOQb7j9utF1Wrjp7ClYxHsH?=
 =?iso-8859-2?Q?DEtcEabepRGxhKom0MOm0a9DIgHRmPQjk3Gn5dnb1c6RhornGTJgwF3O4f?=
 =?iso-8859-2?Q?ke1EV32t++Bj2io6j298eN0xlYBNblozsED9tSIQle7r52yh872t1SG8Df?=
 =?iso-8859-2?Q?9dnkAEgrnsEjI73JSfch9IFthazSzKwAb1f7kuOYYWv+y5p1mLUW1TzShL?=
 =?iso-8859-2?Q?xEIbkORTaoFkQFnSIBSt/uY8hKkZH/MKChY18zQ8NkVyOPo3Q8ejBg96Jf?=
 =?iso-8859-2?Q?Ez4j1lpU1qpHS9KbhTPxalBRFDgxD+LJbXgz9bVDWek6nnIhxptoCjS/2x?=
 =?iso-8859-2?Q?gyj4c9Y4ipEJkB0746uXKQONi57vVSfv3/7rW8yjGbh8cZPYWe/sW5I+Uq?=
 =?iso-8859-2?Q?QPIvWTNh0rtgzJy/HewCSH7nsTeriB6Ppk2WsMn4EI1Nsfe8M5J/4acdjy?=
 =?iso-8859-2?Q?Meou9vdvLx5e5mK/OWt14bp8qtfTFlp/o/NLxPJpJvMS8o40oLoiKRc1H5?=
 =?iso-8859-2?Q?w9VhMNxlQhRiEW6/iCH5MLBwwhDcmsMAxTTAfPiULuk99160i06U8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff29cb5-b006-4812-df03-08df03f3b469
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 04:28:54.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7011

From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Friday, August 21, 2026=
 5:36 PM
>=20
> hv_compose_msi_msg() sends PCI_CREATE_INTERRUPT carrying
> int_desc.vector, and the vPCI backend programs the device with the
> address/data it returns for it.
>=20
> An affinity change only ran irq_chip_set_affinity_parent(), which
> re-allocates the x86 vector and nothing else, and hv_arch_irq_unmask()
> then issued MAP_DEVICE_INTERRUPT for the new (VP, vector).  Nothing
> re-composed the interrupt, so the device kept signalling the vector it
> was created with and the new mapping was never used. This led to loss of
> interrupts.

Shift the wording in the above paragraph to present tense.

>=20
> Do the re-target where the vector is known and the interrupt is
> quiescent.  If the vector changed, re-compose the VMBus interrupt for

I don't think of this as "VMbus interrupt". VMBus interrupts are
channel interrupts or control message interrupts tied to the
HYPERVISOR_CALLBACK_VECTOR. I think this is just an MSI/MSI-X
Interrupt from the guest's standpoint.

> it, write the resulting message to the device, and only then map the new
> (vp, vector); the old mapping is destroyed as the new message is
> composed.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 41 +++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5a36382742bf..5acb8e41567e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -294,6 +294,7 @@ struct tran_int_desc {
>  struct hv_msi_int_entry {
>  	struct tran_int_desc		int_desc;
>  	struct hv_interrupt_entry	hv_entry;
> +	unsigned int			mapped_vector;
>  };
>=20
>  /* chip_data is passed around as a struct tran_int_desc *, so it must be=
 first. */
> @@ -742,6 +743,8 @@ static void hv_irq_retarget_interrupt(struct irq_data=
 *data)
>  			"%s() failed: %#llx", __func__, res);
>  }
>=20
> +static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *ms=
g);
> +
>  static void hv_arch_irq_unmask(struct irq_data *data)
>  {
>  	if (hv_root_partition()) {
> @@ -752,9 +755,17 @@ static void hv_arch_irq_unmask(struct irq_data *data=
)
>  		 * RETARGET_INTERRUPT.
>  		 *
>  		 * Keep the returned entry so the mapping can be removed again
> -		 * when the interrupt is torn down.
> +		 * when the interrupt is re-targeted or torn down.
> +		 *
> +		 * This is also the re-target point.  The core calls us from
> +		 * __irq_move_irq() with the interrupt masked once the new
> +		 * vector has been assigned, so if the vector changed the vmbus
> +		 * interrupt is re-composed for it first -- PCI_CREATE_INTERRUPT
> +		 * carries the vector, so the device would otherwise keep
> +		 * signalling the one it was created with.
>  		 */
>  		struct hv_msi_int_entry *ie =3D data->chip_data;

Use irq_data_to_irq_chip_data()??

> +		unsigned int vec =3D hv_msi_get_int_vector(data);
>=20
>  		/*
>  		 * A NULL chip_data means hv_compose_msi_msg() failed and the
> @@ -763,8 +774,29 @@ static void hv_arch_irq_unmask(struct irq_data *data=
)
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

hv_compose_msi_msg() sends a VMBus message, and busy
waits for the ack, which is really ugly, but necessary. I have no idea
whether it's OK to do all that from the irq_unmask function.

> +
> +			ie =3D data->chip_data;
> +			if (!ie)
> +				return;

Setting ie and checking for NULL appears to be duplicative of code
above.

> +
> +			if (data->chip->irq_write_msi_msg)
> +				data->chip->irq_write_msi_msg(data, &msg);

Is the irq_write_msi_msg function defaulting to pci_msi_domain_write_msg()?
I didn't go follow all the paths to see how this function gets set .....  I=
s it
even necessary to check for NULL before calling? I don't see such checks
in the few other places irq_write_msi_msg is invoked.

> +		}
> +
> +		if (hv_map_msi_interrupt(data, &ie->hv_entry)) {
>  			memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
> +			ie->mapped_vector =3D 0;
> +			return;
> +		}
> +		ie->mapped_vector =3D vec;
>  	} else {
>  		hv_irq_retarget_interrupt(data);
>  	}
> @@ -1974,6 +2006,11 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta, struct msi_msg *msg)
>  	if (data->chip_data && !multi_msi) {
>  		int_desc =3D data->chip_data;
>  		data->chip_data =3D NULL;
> +		/*
> +		 * The descriptor is about to be destroyed, so release the
> +		 * hypervisor mapping that belongs to it first.
> +		 */
> +		hv_vmbus_unmap_msi_interrupt(pdev, int_desc);
>  		hv_int_desc_free(hpdev, int_desc);
>  	}
>=20
> --
> 2.53.0
>=20

