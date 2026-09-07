Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011026.outbound.protection.outlook.com [52.103.14.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B783845CB;
	Mon,  7 Sep 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810870; cv=fail; b=PSXzclJ8PSS5qvIISFktbb9aUSPbHKnTBrFoBnSNh/Tn4MaahqeIYMk11FHY//HWTYrm7bbtLH23pnuG6cwJbKmXL7cbqPGpZdpflVdlXBbP68s2ZvN95744A87jzT7TM3CyrS9Hi74iEA4isCV250j8sJTw/Kev4+v0z0CudVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810870; c=relaxed/simple;
	bh=bxS1NPFDVK+49LPDNxmf1QFPPxOpUIAVHtJLGObmbw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8O9eGOfssLIvK5v2icEymPcRG8H1WBcxYxnqJoA26en+wWRcI1XP0nD7MRNc26FHQcg2Yoi+EEYdgrbvNtSF32qhfurFmdDXcnNHU/zDlGKZq0ad8HjIQm7i1mjG7d46a64RrSQD/kJ3To9tSSpwTRibDe4hE2bbbCdhcir/vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fQVx7wTz; arc=fail smtp.client-ip=52.103.14.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fQVx7wTz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTC1RmBXEMLjUvFxx+Q7/Da1NhocJtVYHWJeL24KX0UFXSCV66GF7eHAN6zaKE+RYWBCiELd5/pV7CtSNyXrg4BIi1KfAJCo1P8iofl3wJ6h0oVUrdWZP/a/+5ZBa9BvQRRI/95/SJ+a7dWBs0wt4MlJya6voQ7/3NCOq1Y29ndX9RNekOPKLrxSI1+tHAUZzw5B/e9tND++UPTSC/SFd3/2911pqP1VzKqJOTALUaOwcF3s456B63zrnoK/2HXIwP87kVzMNB/9uB63AQZvgNErbpoZ1U8WWAVo6mhpKfn1yjKSN86rjqDCdc48/ERXlgnvSuVPTwpJgls74AEwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxS1NPFDVK+49LPDNxmf1QFPPxOpUIAVHtJLGObmbw8=;
 b=eY2UrTEoKU+fHW23wFPzCMqO9+5hadJuN0Qn8nLwBs7RQM/2xILVephEEpjblna+1ov6WXpA2bU7QyHsqLzYfMlfgMowWUo5w1Ru5G95UpXBpi5kylesxLplmdQFbU1MDe8fzoOL86smBgwJSl8WJCgi79qkzB4WucFacj+xTCHHGYZItle9d1pD8shoGkJnTlXHUoHAf33X3d7YD+BbYxrFVmEYQXDze2O+7NtbGH73nYZP/YiAhOEfmE+FX6Wdc64uylRvJsoCsd6rdae6sl7aLJybznJ5UoqWmhaBv5Ce6XBtDWhY/R8NantY5c16xlRf+2dVU0Z/cmmvB4QDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxS1NPFDVK+49LPDNxmf1QFPPxOpUIAVHtJLGObmbw8=;
 b=fQVx7wTzum/4l6mozAAadf/ymBUbRf+5tYmOj5ThhimQvcVwhfpDAVtdmyIHTAncmvy4Xl22yM0ok45yA8EdPASfoVUBau5gDvVpIuLXSzF+kRDq5c2ad43RCEKmI7JOtBkOxuQlClT/4CwffraHt+FImI/47sFSP882LtpeXHXrQOk7pKyy0GHZq3L5sQFnG7ZIIR6jfiE6+CwGeyToSdxwYpWUdEh2ubVTxJA0e/g9+95tLkmY1V1cE78rrVUzL+o+ELQEF02ga6MP89GSQ6uC4Qim+m0NTpzi+VL3E4BochOUZ1qPWGlmUOVAH5EWAUhFyPW6IXo1e/w4oG9RjA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6526.namprd02.prod.outlook.com (2603:10b6:5:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 19:54:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 19:54:27 +0000
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
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
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
Subject: RE: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Topic: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Index: AQHdPpVrA5DpuRN7FkqbtFZh0BHY4rbDiDRA
Date: Mon, 7 Sep 2026 19:54:27 +0000
Message-ID:
 <SN6PR02MB415704CEBA0F9107C37A009CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-4-namjain@linux.microsoft.com>
In-Reply-To: <20260907065129.269262-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6526:EE_
x-ms-office365-filtering-correlation-id: 0d1fdeee-b1c8-4ac4-0b2d-08df0d19d2f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|31061999003|12121999013|15080799012|51005399006|13091999003|37011999003|55001999006|16051099003|24021099003|41001999006|25010399006|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkdWZ2h0RkU4c2c1YitkRFFWUEJhYU9HY2lJdk1FbFd1TUR3QVVOZDIzREJa?=
 =?utf-8?B?YTFiOVN2R2J2bVd1cTRwbnBWSkJLNHRKUlloeUNnYmhJazZtRlBsTFB3U3pG?=
 =?utf-8?B?bEFDU3E5blp0d2h3S1ZhMUdpYitWbGlMZkhuSkVPODV4YWZGOVo0RWY3dTdw?=
 =?utf-8?B?RGVBRFpZK1p1SVVlRXZXL2FubXU2RjRNaEQzbVNxbVE1MFMvN0QxcFI3cWUz?=
 =?utf-8?B?bkMrSU5uUS84Z2FUVFE2Y04yUzc2eW5UNkVmN2JPVVFJWWNWODlndEJ4WCtY?=
 =?utf-8?B?ZFJaZ3NScFpFZU9YVTBJQ3c4dVZkOEgzcFRCNVpZQ1ZOQmJmbWpGSHR4a0I1?=
 =?utf-8?B?MVBRKzl4d01wZGxUdDhKM3NQY2R5YnlxYTEzdEpsSVBhc3pFZHVkaFpsL3U4?=
 =?utf-8?B?U0ZvWXd4REtYNDI0cUIySnhlb3BMamN6WmRLdEQ1ZnpHTThCK05ZUk5XeHdL?=
 =?utf-8?B?dDcxWnhLc3hCUFlKb3FocGtuZHQ3Z01SRXQzdU1CbWpVU2NRVWdpTVlNMzdK?=
 =?utf-8?B?TzVxbDBpdlpSamhwa2xXcXJjb3FETSt2UUNkMjlPRVMxSEtMZ2RjZzVIdGVP?=
 =?utf-8?B?NTFYdHJkWHZJOWhmNGRlR0liSHY4RGxKZC81cFFWQlV4VmVqdzZxeTk2Zi8z?=
 =?utf-8?B?RTVYeGZkNEg2NGFtUlBLUTc4U0Z3YTduOThqaG9YN3g4d0xSVXdYeUVjbG1D?=
 =?utf-8?B?bTBoSHhMemRxSjJRaHR2ZEhQYkhmTTY1V1F2MUdjZXA0WDg1WXlyTlI2N3U2?=
 =?utf-8?B?OHAxall3M0xvVWlpaGFmem82dWRCeDhUR1JwK0dqdmVJTEhsRUtNMG5YNC92?=
 =?utf-8?B?OGk2WEVJYnRqUVFwMUMzNGU3L1RvYU5udGRYWHZTY3VlVzkrdXhvQ3hOUWh1?=
 =?utf-8?B?UnVmYWY5eFprQldTcFBIVjZJeDcrZkVLYWg0N0J4alBUYm5YWkJPNWkyNGVj?=
 =?utf-8?B?OUt3VTRsYW9xa3pQK1lPSnN5OXlxSWQwSnFtTnNyWFE2KzQraTJvOUpnWnBw?=
 =?utf-8?B?eUtqMzlGRUhWSWlGSlZxMWFHMGF1VGZQdXMyTTFEa1pBcmYzMXRKVWp6U2NW?=
 =?utf-8?B?bWQ1V3FKYzdQTFdhdk9xWVZUdy84VDlMblFhcXY3VFNCdmk2NEo5Y1hpQ2FH?=
 =?utf-8?B?OHF3RE9CcHQ3Mkgwd3NWaWQ4MGNUY3B3ZWtQZU9BUktDMytvM1ZONzFTVUpx?=
 =?utf-8?B?QmhlZHdqU05QVzIwaXdldy90ZUlsOHljbFliaDFneGZRSzRhRkhWRWVyempR?=
 =?utf-8?B?Y3F4dnpyWjBPK3RSSnJ6Mk1rWHBmeWF1WFFlQ2RBL1NobzkxbUlrckwyd0M1?=
 =?utf-8?B?NUdMYStJN0JVeEpJVERyWGVLREtONnJjU2ZTVkFoMGN5T2J6RFlORFB6T0Vn?=
 =?utf-8?B?TnBXaUM0QitRb1BDRmxjVmtuMVVyVHY5aXZFZndua3pSN1ZqbU55Wm1PbzNV?=
 =?utf-8?B?amE0VVExY0lNalZiUVdVWUNUaTV2Rms2QlJsdW5LZExaRkg3Zm40Mi9jMnJB?=
 =?utf-8?B?QnFuVEZzWE0zZXY5RUU5ZG9HTjhnbTJMbnh3SzJFSjhzaEFnRktad0tjemps?=
 =?utf-8?B?QnVyQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzZDczYvRkFZWlk4QllLeEJnQ3VIYzd5RlBOSXRxNXRjc3E3M1huRFJUejFH?=
 =?utf-8?B?YjFuaG9Ndmw3Q0RBMGtIVkVKcVh2K0Zxc1llNEJIVnJoZEVrRGV4U2dQSEJy?=
 =?utf-8?B?SjVTeFR6ZkF2OE1UUmpZWkdaZ0U0enlrOW1keTRiS2ZYYmJqMTdGUTljTU1j?=
 =?utf-8?B?OXNsOUVNbkEyck9zeHZXYUhCS3o5d0NEM3lLa2dvTmdyYU5QR2ZqbldEMnl6?=
 =?utf-8?B?djZWUE1FTnJHaTRNVXB3clY3blprYVJ0NUxrSjgyNUQ4N01pZ1ZGaVk0M0Ni?=
 =?utf-8?B?TmRLZ1JBTHJaditBcXRURmJEaDRRWmpVdDU2VXVCYmZGamtpK0RkeE43dFM3?=
 =?utf-8?B?cEJ4OGN2UXo4QmMxQnkwM2dWZEhhWXAwMlArdmowRXJvN1l3L3Iwc1ZNeEdM?=
 =?utf-8?B?MjZweFBzazBJL0k1V2ZQK3d2dE9Jczltc25VNlZOMkpJaGc0alREMnNJZndN?=
 =?utf-8?B?Z0hnNU85YTlVejRwQ0YveFlqOUQ0WjcyRld0bWF1QTZ3UE9ESW9KQXFXQ1Zn?=
 =?utf-8?B?ZVZ3cForVEZWTnhTemhabGhyM05nWXlFVGM4ZGJuZFpGRGMxdGkrNmZTcFcz?=
 =?utf-8?B?RXR3ZDZkeVdSNTdjWlN5QkVnK0d0UlpITzJ5cnZwT2dMMXFBWStIS2cveXJ0?=
 =?utf-8?B?UVAvMWcxcjRpbVNULzB3aUQrVzdJTDRRUnJVYTlZZGwrUmluSktQZnFJQVhV?=
 =?utf-8?B?M1VmSzZ1Znd6NnZKSjJEVnU2M3VzZndhRm5STUx0TUFVVDdRZ1g1M2VoQUh6?=
 =?utf-8?B?cStNdDVxdTFseStDSVBWcHNWQWJseVdwbzRZL2NrYldFUDhWaHUrQ2hkOG1i?=
 =?utf-8?B?Z1Y4eDdSQ29MUVhxN2ZPeE1vQTJyK09FOUdvZjd4eSt4bkdDOE9oeTlrQlc3?=
 =?utf-8?B?OUhQQ0NwUW5IR2l3enpaWlV3V1lDeDVZaU5ldDR1UDdLL0pjbDkwc1hnT056?=
 =?utf-8?B?eVdRZk9TRWNFRm95Zlp0bm1yNkd6NHNVMkNDdmI0bjFPeDZucW9GVGNOQUIw?=
 =?utf-8?B?b1p1aDE2S01PekE3V2lOT1JpUDNYZzBJUDlwb2cyejJoUkdOR1p6UTdRejNY?=
 =?utf-8?B?NVBETUdoMDZjY2V1Z0drVU5Iano3QmNNc05XRGhhem9Gc0RoSGJVcHhLUExQ?=
 =?utf-8?B?dERlNnMwYjZ1K29sak52OTZqM21abDJPcHlkNWtrV2xOMnkyeGU5blBlRVdi?=
 =?utf-8?B?NzBRS0x5bUVPbGdJTmUzUExNdUNBaHE3eUwwSzlLWjgyeHlwT1JacUZBOEx0?=
 =?utf-8?B?ZVY4SHJjS2xIRVhvcXNNcHI1QjV5amd1Nlhnd0tMRHk4YVdFb3RpT0NIbG9p?=
 =?utf-8?B?SGd0YU9NVGJXVUVrNHd2NWVGY1JrbDNHb3p5WmVtUVlrdUpvUnNUOVE1dlFC?=
 =?utf-8?B?RUxuS3JZcjZWOE5CVGpSNzdRQW9rV1Y3MlErQU5SSWFuaTlaNzJFSVV4RmxJ?=
 =?utf-8?B?RmFVUzRPb0p4VG4wYms0UTR6TGpidm9HbDVTSDgzRDZJVFVjTU9vellzVnhh?=
 =?utf-8?B?ZEhsT1FxUzdDM3BLa2d5cXJFQUNRb0ZvaElUWFlsVzNqRWpEK3R6cTZ5VzFk?=
 =?utf-8?B?NDZjZ3VIOUZQeEV6Nk5hU3lUWWY0N3RXM3l2Y3V2Mko4Tld4MjNmdUVjWWFm?=
 =?utf-8?B?eE1WeEVXRWVLdDMwWjBRdVpEbkEvL2pTSWhMeGZSUXFVblB1TW5FUmhXTXE5?=
 =?utf-8?B?NlFvMW84TytGL0h1KzhZNlNJbm96OGtzRWpSRStmbVJ0bFRQZE1kWVdIOUM5?=
 =?utf-8?B?amFML2xMREVtR0NCZS9uc3Jsekp1Y2N2YnhYVDN3eDBVb0NCaVB4Y0pHbE5o?=
 =?utf-8?Q?U2bLV/QeI735eb9jUNjn7VMMcMWnXsgl/x8yw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1fdeee-b1c8-4ac4-0b2d-08df0d19d2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 19:54:27.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6526

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBTdW5k
YXksIFNlcHRlbWJlciA2LCAyMDI2IDExOjUxIFBNDQo+IA0KPiBXaXRoIGZpeHVwX2lycXMoKSBh
bmQgdGhlIGdlbmVyaWMgcmVzZW5kIHBhdGggKHRyeV9yZXRyaWdnZXIoKSkgbm93IGJvdGgNCj4g
ZmFsbGluZyBiYWNrIHRvIGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoKSwgaW5zdGFsbGlu
ZyBpdCBhcyB0aGUNCj4gaXJxX3JldHJpZ2dlcigpIGNhbGxiYWNrIG9uIHRoZSBvdXRlcm1vc3Qg
ZG9tYWluIGNoaXBzIGlzIG5vIGxvbmdlcg0KPiByZXF1aXJlZC4gVGhlIGhpZXJhcmNoeSB3YWxr
IHJlYWNoZXMgdGhlIHg4NiB2ZWN0b3IgZG9tYWluJ3MNCj4gYXBpY19yZXRyaWdnZXJfaXJxKCkg
Zm9yIGFsbCBvZiB0aGVzZSBzdGFja2VkIGRvbWFpbiBjaGlwcy4NCj4gDQo+IFJlbW92ZSB0aGUg
bm93IHJlZHVuZGFudCBpcnFfcmV0cmlnZ2VyKCkgaW5pdGlhbGl6YXRpb25zIGZyb20gdGhlIG91
dGVybW9zdA0KPiBkb21haW4gaW50ZXJydXB0IGNoaXBzLCBpbmNsdWRpbmcgdGhlIEh5cGVyLVYg
cm9vdCBwYXJ0aXRpb24gUENJL01TSSBjaGlwLg0KPiBtc2lfc2V0X2FmZmluaXR5KCkgaXMgdGhl
IG9ubHkgc2l0ZSB0aGF0IGludm9rZWQgdGhlIG91dGVybW9zdCBjaGlwJ3MNCj4gaXJxX3JldHJp
Z2dlcigpIGRpcmVjdGx5LiBDb252ZXJ0IGl0IHRvIGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJj
aHkoKSBzbw0KPiB0aGUgeDg2X2luaXRfZGV2X21zaV9pbmZvKCkgaW5pdGlhbGl6YXRpb24gY2Fu
IGJlIGRyb3BwZWQgYXMgd2VsbC4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVk
Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAa2VybmVsLm9yZz4N
Cj4gUmV2aWV3ZWQtYnk6IFNocmFkaGEgR3VwdGEgPHNocmFkaGFndXB0YUBsaW51eC5taWNyb3Nv
ZnQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jv
c29mdC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvaHlwZXJ2L2lycWRvbWFpbi5jICAgICAgICAg
fCAxIC0NCj4gIGFyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYyAgICAgIHwgMiAtLQ0KPiAg
YXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgICAgICAgICAgfCA0ICstLS0NCj4gIGFyY2gveDg2
L2tlcm5lbC9ocGV0LmMgICAgICAgICAgICAgIHwgMSAtDQo+ICBkcml2ZXJzL2lvbW11L2FtZC9p
bml0LmMgICAgICAgICAgICB8IDEgLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlw
ZXJ2LmMgfCAxIC0NCj4gIDYgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRp
b25zKC0pDQo+IA0KDQpbc25pcF0NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2Fw
aWMvbXNpLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBpbmRleCA2NmJjNWQzZTc5
ZGIzLi5hYWQyZjE1ZWIyMTc2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9t
c2kuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBAQCAtMTM3LDcgKzEz
Nyw3IEBAIG1zaV9zZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRhICppcnFkLCBjb25zdCBzdHJ1
Y3QgY3B1bWFzayAqbWFzaywgYm9vbCBmb3JjZSkNCj4gIAkgKiBJUlIuDQo+ICAJICovDQo+ICAJ
aWYgKGxhcGljX3ZlY3Rvcl9zZXRfaW5faXJyKGNmZy0+dmVjdG9yKSkNCj4gLQkJaXJxX2RhdGFf
Z2V0X2lycV9jaGlwKGlycWQpLT5pcnFfcmV0cmlnZ2VyKGlycWQpOw0KPiArCQlpcnFfY2hpcF9y
ZXRyaWdnZXJfaGllcmFyY2h5KGlycWQpOw0KDQpJbiB2MiBvZiB0aGlzIHBhdGNoIHNlcmllcywg
SSBjb21tZW50ZWQgYWJvdXQgd2hldGhlciB0aGlzIGNvZGUNCnNob3VsZCBhbHNvIGNoZWNrIGZv
ciBpcnFfcmV0cmlnZ2VyKCkgYmVpbmcgc2V0IGluIHRoZSBvdXRlcm1vc3QNCmRvbWFpbiBiZWZv
cmUgY2FsbGluZyBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5KCkuIGZpeHVwX2lycXMoKQ0K
aW4gUGF0Y2ggMiBvZiB0aGlzIHNlcmllcyBoYXMgdGhhdCBjaGVjaywgYW5kIEkgdGhpbmsgaXQg
c2hvdWxkIGJlDQpoZXJlIGFzIHdlbGwuIFdoaWxlIHRoZXJlIGFyZSBubyBkb21haW5zIGluIHRo
ZSB4ODYgd29ybGQgdG9kYXkNCnRoYXQgaGF2ZSBhIGN1c3RvbSBpcnFfcmV0cmlnZ2VyIGZ1bmN0
aW9uLCBJJ2xsIGFyZ3VlIHRoZSBjaGVjaw0Kc2hvdWxkIGJlIGRvbmUgc28gdGhlIGluZnJhc3Ry
dWN0dXJlIGlzIGNvcnJlY3QgaWYgc3VjaCBhIGRvbWFpbg0Kd2VyZSBhZGRlZCBpbiB0aGUgZnV0
dXJlLg0KDQpNaWNoYWVsDQoNCj4gDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gQEAgLTI0Niw3
ICsyNDYsNiBAQCBzdGF0aWMgYm9vbCB4ODZfaW5pdF9kZXZfbXNpX2luZm8oc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluLA0KPiAgCWluZm8tPm9wcy0+bXNpX3By
ZXBhcmUJCT0geDg2X21zaV9wcmVwYXJlOw0KPiANCj4gIAlpbmZvLT5jaGlwLT5pcnFfYWNrCQk9
IGlycV9jaGlwX2Fja19wYXJlbnQ7DQo+IC0JaW5mby0+Y2hpcC0+aXJxX3JldHJpZ2dlcgk9IGly
cV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHk7DQo+ICAJaW5mby0+Y2hpcC0+ZmxhZ3MJCXw9IElS
UUNISVBfU0tJUF9TRVRfV0FLRSB8DQo+ICAJCQkJCSAgIElSUUNISVBfQUZGSU5JVFlfUFJFX1NU
QVJUVVA7DQo+IA0KPiBAQCAtMzEzLDcgKzMxMiw2IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAg
ZG1hcl9tc2lfY29udHJvbGxlciA9IHsNCj4gIAkuaXJxX21hc2sJCT0gZG1hcl9tc2lfbWFzaywN
Cj4gIAkuaXJxX2FjawkJPSBpcnFfY2hpcF9hY2tfcGFyZW50LA0KPiAgCS5pcnFfc2V0X2FmZmlu
aXR5CT0gbXNpX2RvbWFpbl9zZXRfYWZmaW5pdHksDQo+IC0JLmlycV9yZXRyaWdnZXIJCT0gaXJx
X2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSwNCj4gIAkuaXJxX2NvbXBvc2VfbXNpX21zZwk9IGRt
YXJfbXNpX2NvbXBvc2VfbXNnLA0KPiAgCS5pcnFfd3JpdGVfbXNpX21zZwk9IGRtYXJfbXNpX3dy
aXRlX21zZywNCj4gIAkuZmxhZ3MJCQk9IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8ICBJUlFDSElQ
X01PVkVfREVGRVJSRUQgfA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2hwZXQuYyBi
L2FyY2gveDg2L2tlcm5lbC9ocGV0LmMNCj4gaW5kZXggOGRjN2I3MTBlMTI1MC4uMmJiN2E2ZjQ2
NmFmMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2hwZXQuYw0KPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvaHBldC5jDQo+IEBAIC01MDksNyArNTA5LDYgQEAgc3RhdGljIHN0cnVjdCBp
cnFfY2hpcCBocGV0X21zaV9jb250cm9sbGVyIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4gIAkuaXJx
X21hc2sgPSBocGV0X21zaV9tYXNrLA0KPiAgCS5pcnFfYWNrID0gaXJxX2NoaXBfYWNrX3BhcmVu
dCwNCj4gIAkuaXJxX3NldF9hZmZpbml0eSA9IG1zaV9kb21haW5fc2V0X2FmZmluaXR5LA0KPiAt
CS5pcnFfcmV0cmlnZ2VyID0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSwNCj4gIAkuaXJx
X3dyaXRlX21zaV9tc2cgPSBocGV0X21zaV93cml0ZV9tc2csDQo+ICAJLmZsYWdzID0gSVJRQ0hJ
UF9TS0lQX1NFVF9XQUtFIHwgSVJRQ0hJUF9BRkZJTklUWV9QUkVfU1RBUlRVUCwNCj4gIH07DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJzL2lvbW11L2Ft
ZC9pbml0LmMNCj4gaW5kZXggNDA3MjZkZmVmMjczMy4uYTE5ZTFmYWY5ODc1MCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1k
L2luaXQuYw0KPiBAQCAtMjQ3MSw3ICsyNDcxLDYgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBp
bnRjYXB4dF9jb250cm9sbGVyID0gew0KPiAgCS5pcnFfdW5tYXNrCQk9IGludGNhcHh0X3VubWFz
a19pcnEsDQo+ICAJLmlycV9tYXNrCQk9IGludGNhcHh0X21hc2tfaXJxLA0KPiAgCS5pcnFfYWNr
CQk9IGlycV9jaGlwX2Fja19wYXJlbnQsDQo+IC0JLmlycV9yZXRyaWdnZXIJCT0gaXJxX2NoaXBf
cmV0cmlnZ2VyX2hpZXJhcmNoeSwNCj4gIAkuaXJxX3NldF9hZmZpbml0eSAgICAgICA9IGludGNh
cHh0X3NldF9hZmZpbml0eSwNCj4gIAkuaXJxX3NldF93YWtlCQk9IGludGNhcHh0X3NldF93YWtl
LA0KPiAgCS5mbGFncwkJCT0gSVJRQ0hJUF9NQVNLX09OX1NVU1BFTkQgfA0KPiBJUlFDSElQX01P
VkVfREVGRVJSRUQsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1o
eXBlcnYuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+IGluZGV4IDg5
ODE2YTJiZDdjZDMuLmNmYzhmYTQwM2RhZDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jDQo+IEBAIC0yMTE5LDcgKzIxMTksNiBAQCBzdGF0aWMgYm9vbCBodl9wY2llX2lu
aXRfZGV2X21zaV9pbmZvKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gc3RydWN0IGlycV9kb21haW4g
KmRvbQ0KPiAgCWluZm8tPm9wcy0+bXNpX3ByZXBhcmUgPSBodl9tc2lfcHJlcGFyZTsNCj4gDQo+
ICAJY2hpcC0+aXJxX3NldF9hZmZpbml0eSA9IGlycV9jaGlwX3NldF9hZmZpbml0eV9wYXJlbnQ7
DQo+IC0JY2hpcC0+aXJxX3JldHJpZ2dlciA9IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHk7
DQo+IA0KPiAgCWlmIChJU19FTkFCTEVEKENPTkZJR19YODYpKQ0KPiAgCQljaGlwLT5mbGFncyB8
PSBJUlFDSElQX01PVkVfREVGRVJSRUQ7DQo+IC0tDQo+IDIuNDMuMA0KPiANCg0K
