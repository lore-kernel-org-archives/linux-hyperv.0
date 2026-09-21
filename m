Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010016.outbound.protection.outlook.com [52.103.7.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40355172C9;
	Mon, 21 Sep 2026 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024463; cv=fail; b=uBBqB4gYtAL+s5IUE0YEMw87/y79bPdinaPF1tg3brHcwkF4f6UT9ulkA9NjP+IUTCwep0AeNCMZVTVD45Udxntp2PckfLJ4RuZ1yBhtRNa71yeLGgtR9t+0zmgSdk24SNAi0JATlV45yXF7VfgbLzndqMVH7v1MBV/HF4GtsFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024463; c=relaxed/simple;
	bh=bNlE4LZltsGQ8FXoJwy3KhbnlclI4Xlf1FOjKl4Xj3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=traUXzW4qvt9664dzoVWgBYODoQBRWyeVa9+2VIX6I8heb/20yIQRsyj2RbMlNQxXubxOt8TDSfVawWSKixFqAE659zl5EZjrJH+qrIuNLhwSqtCnnpoltyLU6aKo0tiUGD6fsl8MDQcjEIV1VJPPrs2Z+PDWnx78qXNDGV8to4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iWuDBaBf; arc=fail smtp.client-ip=52.103.7.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iWuDBaBf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSCzwBrUiwIii/wmEihDd89UnQUgZhXnb/LnL6rvBjX8hei9h7WJZNvCJyb6hfWBx759zLy+Zoi4VxUqhOUi3g3pnoUhhNlhe1RdL5CM86MZmh6BF+zw9bVXpTzfh9CTHJOEKqXzYX/IeLrcQAr2lEYrKPdnZ/n+c+w0919ETQ/zFsEY8slw5SglG0AlQqC0NzvIxCDcbh+Z7SV5t76baaZdWyk0OalY6CbqQqK16UNa6ELXCUjZXhi/dhLJiH8VmtMdWwF6zRCKuGDmJpIL6AKZSJKnvzdo/Xth6Q7DjdCijX6iz4L1w2cBxuGu0vbMt17fLQgbL7s0bASiWy1VPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDUdYglEw4voFU9liO1TVxPWx7/gv+xVSQsxdX/Amnk=;
 b=iJPER+n/eofIA6YNcgt1YmTO6VA6lN4gEIXVwfIONluqSKn1vpOw/JK3J4AtXqm4tQ7RLl+8LuCO/FSR6terhTZLHzc6tp1BCpmFAuONghZ/YC3rmWRH8Bd0JHMOPuxw1fkgWQVpbeZLp+cuNRA3rmkJetQGvuCflK10KYWcAE2PdZf7QQptnBIi7VfztwEgLqzP5S2nilKt/USkRHkZPXizd//R5SIirw39QyZTJo8KtP3SGb8T9eDoa0CkheWUd4ZZONJoRrwLZ6Oixv5oi749aJx//hwMeAtXzYB9KsiD4aa11EOfQvoXmdYYa5Chn1Spl9mzfPGlTwylFQm2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDUdYglEw4voFU9liO1TVxPWx7/gv+xVSQsxdX/Amnk=;
 b=iWuDBaBfwUI64YtUMDy3nWQ2qHmGdWCxQARmkbbGuJ7kgx2CrKiDxGDd8wRWmtEp7v+o5FxVJmHoYnw/yMlvUO09e/kb5VrYkf1GfA60JsDBS/M+9gqzJbXQRF/YUuOjxO33aiO0BKqxitkgEXh7QTildtye8KvUG5uvvxgQpOVPazsB852pytHQUB/HlWtuzytAY3X1giLLZi2CtXKtJul3rKMhq0NOdMFAdyUih2BcRKcDFJdoLZy2l/1VEAUqCs9WbQVZdzO2QFdD4cVinQuFitIEIv/uHwwyIstNF17tj4aEfVLbFDsQ9TtjCOUryAwwmNvDwbUqDfnbCHj7bQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB914464.namprd02.prod.outlook.com (2603:10b6:8:359::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:00:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:00:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Wei Liu
	<wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Nam
 Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Kees Cook <kees@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Radu Rendec <radu@rendec.net>, Sean Christopherson
	<seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin
	<d@ilvokhin.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding
	<treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>, Daniel J Blueman
	<daniel@quora.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Thread-Topic: [PATCH v5 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Thread-Index: AQHdRDrm5AgKJ8CtT0ib2GFTADoC8bbZkBVA
Date: Mon, 21 Sep 2026 21:00:58 +0000
Message-ID:
 <SN6PR02MB41570F45986408BA60D75A3CD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-4-namjain@linux.microsoft.com>
In-Reply-To: <20260914111836.2119301-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB914464:EE_
x-ms-office365-filtering-correlation-id: 5395d706-5eb1-4c1b-30bf-08df18236f8d
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQkGaLwEdeYxLY7yqos8lGqVczr5qfg1JLwEvbUu/yjS0QuZE7mlQm0BStxz60/7DeFRFybNIQbxr3C/p2PgW/IyRl6jMWtNqo1Gk8LQ2rLvX1E6g1ZRgqeKtKXvFzCCI+K/hpwZAfFY2kueCGP9rCcr69gQdC16KF+wgYmHRD+fICwOvWcxRXIS90wJ3TvrJLdJ3jYnxsfzyspiXY9PPZy7ijsajo0gpLMGsRFQyLk4eNTCfyPAlVUNFccsWJ97oFI2BmO2gNR6I+hxIzX7BkBBM7GMNI44yYfWXdgrPE4eRgDltaL95rNDrOd6z9z5y7Gx+vIUI76pIN4v3rUUjCgCsAQkQ3+yZyk72xthua/G9lNpBsZas7rZor/6QEC/Sd0r7m3bxi/sHR4zPt+E+n206kGqYiaMNTLv0W6S3pnTgUcIdGN53UJ/ovKXEJLDWY+IiDJkI626mdeHyqvzWIyr2/d/SHeK8PI6rGMnguVdNyjSQ84i3+oAbsPoma4O5kJdHcTfPfyHAfoI9f9lU2Jn0QlmrWv9EMvSnTDvI55pY7xWz2X7ASUXAmPvpDYS+VairZAazlPmvCclq2V7Onx2XtMFUy5/pZSD8dCXkWhNDd3Mnlf5KJfZ8D9XDQjdtYQWPzYxzy09kP9clnir0HG8HJsYwHMASk3IzztxCgEr7q7/0cXsvqUHC6gW7Y8VIBvq97EW0FLX3Gutj6cvHZU8MF37InULJ3U=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|12121999013|25010399006|55001999006|51005399006|24021099003|41001999006|31061999003|8062599012|13091999003|19110799012|8060799015|40105399003|2607281247196008|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?5mVMdToaRtXYajFEl/DrrdiS2o8RvcwafPHeo6iBelVljsPbWYCC94NSIu?=
 =?iso-8859-2?Q?VFHD8nUM6H6uIoH4MCTekU/cDKHJSsV9pqO8a22T8mHlLouBaBQxEkXbLh?=
 =?iso-8859-2?Q?QovWlvUtDDy3p92RrmcwUOhVbWDYHAtHHqkl4bJabJpHYyFqmxCWMaZ5hb?=
 =?iso-8859-2?Q?D9H1HCzg2mDJ2p09emZlFKqOl7f2avM2QEcyFyQQfMnsSKy0g3QIhkQ6y7?=
 =?iso-8859-2?Q?7xJ1r56X7FjabNmJrwuaSD5YdKRFb8Fq1P7AeE89BxC3lxKnwCVCrwqaGc?=
 =?iso-8859-2?Q?T6OZip80r+jCbr9zHktMG7OMtq0YH23qhrIr9+Zi5AV86DlFWVJFAHTC6l?=
 =?iso-8859-2?Q?W7sMTIEj9xyD3u+g+Y9MugKZz17RDKST+VbEaPozP+EhiGFPZhMxIdM5Av?=
 =?iso-8859-2?Q?bUYck+40NYCU33uZ/Jkc/TAWIZ7IdB1tpbwoD56l7eTSrU2WIW0Hs6cSZh?=
 =?iso-8859-2?Q?gHolZ501JNc6s5QAOQPufl2R8k2VEDa6kniSXbAq6a+C5wG1i7Iguj7s96?=
 =?iso-8859-2?Q?RN3//AyTR9H9VTuuVdfGGqeFlpXK//4EWUTXh7odvufzHZ4v5l2sU1ViBf?=
 =?iso-8859-2?Q?lqME6GEm0y6fGUmR6MnMhIK/y8AVp9pa9tD+RLFxcDjYQ/yraYK/RtrBht?=
 =?iso-8859-2?Q?p3NudGpeX0W6Cp8uQnhlcrLifuVB9lp+vREIbtGl+QVW3ytepoJXA11aLN?=
 =?iso-8859-2?Q?S+mshxiE5P2CEMeYXy30lVAkiOJk6Vj+CINFjyvelThY40tNKyOJTvwJ0X?=
 =?iso-8859-2?Q?iU2M2HU0ucFcOcRmaCjSg5uQH+ZxeT7+ZfZ8Zk9d+QHXFDLhlhvI0pcO/z?=
 =?iso-8859-2?Q?luMrLL1F/hmY+jFgpo2SwPEPyHKLIk266PhsiWIBYinehEB98Eyq7B6rPj?=
 =?iso-8859-2?Q?cr91p6QYwXuSHPCq3IepJK5PAcZpQcLALBMFtMZElgsj2M/gkty7SqBC9e?=
 =?iso-8859-2?Q?oJLRkLBF9hkjaQVHq51iRz5K6zFk/xrb1jnd9K8UkTqYksxxRbRuB0Ike5?=
 =?iso-8859-2?Q?4I2bdr2K97i0o3Ak5Y+dsnltATnpwbrJ/3o72k1MsW6gtjgpv3VtffzTHa?=
 =?iso-8859-2?Q?PJhaMJDCrqWWo8baXBd7nhcYc1Y5z41ptt9l9/moViB2/OI065KCV/oLhh?=
 =?iso-8859-2?Q?xk90U7H4mGYK2ULOxJqW23IqjWBjQUTrpbaUC6qPdsuTVdJF1h?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?eOq3E/0/kLJ06MXuRR0uUdkUL5n8WM+igGfCW/XkkmbJduy5QGnaj2XvqS?=
 =?iso-8859-2?Q?AqsdGCCDGBe/0pys8D4/83smWeelDPKEjO3BkoyZqIFlyEl1ReurVN1HpF?=
 =?iso-8859-2?Q?ccIOojbSUw6UfEW+ODIYiSOO1s9vV4/6NkrsG/Rg4lrJnQpDQWCR6DHZZ6?=
 =?iso-8859-2?Q?3v4zyjljzsFRrt9+tzWRFTcdjmEGkDLfmWxNq/0Z904bj2aG9hE7KGy2ls?=
 =?iso-8859-2?Q?6nkdy5dx6Wc4L/ubBVyaSzR53jkr6tS/184x9PtIWYgCUw2vTeC2OHdhzH?=
 =?iso-8859-2?Q?FQxLD9bqhm/aQtSOmCg5fr9RmCtFG6dug32esdJeRIS7A6bSqKC3UKmeIQ?=
 =?iso-8859-2?Q?J73B52G6YHOWg/E8CqMG0BIm5hQhFXAa96EnlrxN8yTikXIVcSYu4juNSx?=
 =?iso-8859-2?Q?1IhVx7iJZUnguErXQu1Jsc/zCexTVhumHrtgd7BwufnqdMMnwhdfsEyqdm?=
 =?iso-8859-2?Q?h5ijuTsITaj1O4dB9hKG1r4FIXyDBxRWBE+rkZPNP85hKila+QE7SdLOXi?=
 =?iso-8859-2?Q?fAzOtdWKcDauSTbthjgOc+2WNIr86rg4aR9t9FfjZH462sEGThogt9vn32?=
 =?iso-8859-2?Q?/f8QYV1OKoQMtg+zRTln8K4GRs6bQFvlAvBtDoV/Hg04J47Pi/iYQxD3CD?=
 =?iso-8859-2?Q?wgFMVXg8HHpaweTU5ASWUHyPKMyvU3RtGYUUWLdQQ85KpooRAdz7+MZje3?=
 =?iso-8859-2?Q?grreZMYGFxiyaJs0cS55wtFMMFwrQZ8EEKNq1rtrX5mcCZmEcbe07du2zV?=
 =?iso-8859-2?Q?58seClc1LxwnzDQVypMUqxC/rvjRf7jXez3xr3LvXJ99XyLlOCCwcjvM3H?=
 =?iso-8859-2?Q?k2DJwQKMuqFf+pDoe1sgB9TQeRL3mocBgT+ufsD27iqe4B3zZp45gJ6x1x?=
 =?iso-8859-2?Q?wh45vyl9TxvAMXcsOblQ3voksjjYcOxFu8bD6MbtW2hGsAec5xJ+3WrcTr?=
 =?iso-8859-2?Q?gP1P0wgcmXlQdsjS3h81k6SKGf1mahmUf2G08qe0HAhDytTeLCn9HE8LZD?=
 =?iso-8859-2?Q?4Nvs4W4w+dKQR+WwfZVeBSjaTUWuHf/H1vJrSSdq5zfBBPZWi6X5lJwULN?=
 =?iso-8859-2?Q?YjlxLf+ZE0ujgQFdxTivu+XFG/ACFwV3dZ+RHE2A/eQcj/h1Xy/BZK+6KI?=
 =?iso-8859-2?Q?ve02emIx3eBhRDyG9JttHKFErGiFlL9Giuachb98HRwPh0CblQV99hAboq?=
 =?iso-8859-2?Q?JRF7Cf5RKtHOFg0WT7vzGk6MB1grMyZ/pUEGVB+Iu9lVbLiD9xbHN35mKD?=
 =?iso-8859-2?Q?pqnEgoLx50LMssTyriF/Rrn1X2qcMflJpRZWfpWXH71xzRY2bfuPZYoajb?=
 =?iso-8859-2?Q?uuoo2XPxAs7nuCw/LGKKWdf78j2AHCzpt2MM47WlgtjPutxixv8lo3fK9j?=
 =?iso-8859-2?Q?eJyAIK9pyqUDAarpq/gloictt0nZOfWMZknA6+vFqd51Q801chhhs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5395d706-5eb1-4c1b-30bf-08df18236f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 21:00:58.4137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB914464

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, September 14, =
2026 4:19 AM
>=20
> msi_set_affinity() re-injects a pending interrupt on its new target by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback. Since this mirrors the behavior of
> irq_chip_retrigger_hierarchy(), use the helper directly instead.

This commit message glosses over the key point. I think the full
statement is that in all cases where msi_set_affinity() is called, the
irqchip's .irq_retrigger function is set to irq_chip_retrigger_hierarchy().
Both are set only in x86_init_dev_msi_info(). So it is equivalent to
just call irq_chip_retrigger_hierarchy() directly.

>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/kernel/apic/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 66bc5d3e79db3..9160227b9b32a 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct =
cpumask *mask, bool force)
>  	 * IRR.
>  	 */
>  	if (lapic_vector_set_in_irr(cfg->vector))
> -		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
> +		irq_chip_retrigger_hierarchy(irqd);
>=20
>  	return ret;
>  }
> --
> 2.43.0
>=20

