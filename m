Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012019.outbound.protection.outlook.com [52.103.11.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15B4E56F7;
	Thu, 10 Sep 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066326; cv=fail; b=CZchROOTWX/JnfZT1gOmlV3v4GUQTMbjA3QlnSc1cQhc/+fQT9jvLVasL1cAAliepsqce2W5mYVlnS0xnPPGXN/AWu5qpKY8kOIc461Wuli9B22deVyW9hIsLYuz24ZP1WNsIeKChju9FmDrK8CTsU7eFniDdcLMQ61d4rudWpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066326; c=relaxed/simple;
	bh=uAO2edm+QO0UhoUDoUa4mdjJMN/4S0+5II5+d/YQjdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcAQba6MNAc/kFhkkMlmxwVyud6SyiGRrA8EUpr5L9yEzQlIUHzlo3n2UAO9LuvCLZo9RbLWE8lnLSZajoZ2eZf2xEQYsVPWs59uz4yJnJPlAzdhuVbvXAsW1NeW1W0MyAntKgh1UkLyhdWLLnKlo83zyRqDRdZ4p5RfF9Qr45M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BxMTANyi; arc=fail smtp.client-ip=52.103.11.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BxMTANyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP3QA3ruUisQ1CMR/kU/r8eAVsU9MKGdZ+QWYVFG9XOAkaorv0RUit0+WBQGkLf3/eAjEHRyLDs78E4IhuR/4bRDJlTXaKKM39feWKWjGYsWkL3XMZoQA8zQ5K9nfJPvyXFZpzYWVlyvYV2LxQBHW2VAvRNwQFXfjHVvPmXCM2lummQS9qR+DgNPlZscSrtn6j+LrSdSmi/6g1fhn+EFMaEGtJ/I4fZMSMpn362gujkDeOvyHmwO3i5nkAyYg1XD+GrVGA0kCka+lLahSATD+/F+Cl+B75JZaR6qqNgq1mqJrQH0ktLqv0GcQdREW+QzMwpgIH86li50YGC3ijwrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAO2edm+QO0UhoUDoUa4mdjJMN/4S0+5II5+d/YQjdU=;
 b=je9AYZUFjhba2Ey7sWV0E92/5Z4QcFbrU4wiRG7QX8s4KkpEVIwIbqGWfVD7umCtAXla8GqYby/AXBbZjllEf+yWdbmhhOQYFHEhsQ5rQnaeFTTB2nT8P5nFPn13apyuk37Khod6xYuPobICT7miAscOvuf+wUCL1Nye2FWr45oXg4H7SGoW/EoVewvNYIeVitfOigYRfAQi3fYiF0frxv7vk91KoHQ26p3gmZOOwqzIn6hG28biNrCMhhuXV2P5VtBLmCaqzpvKvTSHR83y8aX0+BXQf9hs/uwOdbS94PrObAAPT4nNvIrqfPwiBJZHDhBEQSH38WiZEE/U5lgWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAO2edm+QO0UhoUDoUa4mdjJMN/4S0+5II5+d/YQjdU=;
 b=BxMTANyiU4Lj7Zk9QPezg4etym7bd096qchyQujpXX5+ZiNMG1592y7zCCb4eMCzZtxf6ACo0I+uVAcoKu46uzJ9hDbIKH5+4NjiNxUR1ZgcYbbMTdSatrxLdtHVA5BlouJJlKJb/tpdGIUUKSJBP4RpLbdZ2gg5QpXxTpAf+9Xeb6YIphrs803mZPWXfUOc9xM6fLAi7VKygApWgni/iZUFrEw28omg0FdmKB+dlwtK4ZRRuGpaXFgFtvWT41qIUz6K7+gfycHtfNGiP8sD61DO/f/ccNDxKpzLm7wOZ9021lJkAMF6DHoGwt0lvS5bHyCGl2ZSkTIIfdx7DNHx0g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH8PR02MB10887.namprd02.prod.outlook.com (2603:10b6:610:26b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 18:51:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 18:51:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@kernel.org>, Naman Jain
	<namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "namcao@linutronix.de" <namcao@linutronix.de>
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
Thread-Index: AQG4lIWg1CA0E9n3RBnld28Zsf/qhgI+SZDwAUs2C3e29R/3QA==
Date: Thu, 10 Sep 2026 18:51:53 +0000
Message-ID:
 <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com> <875x0e204j.ffs@fw13>
In-Reply-To: <875x0e204j.ffs@fw13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH8PR02MB10887:EE_
x-ms-office365-filtering-correlation-id: 803461c1-a0e4-4d70-acde-08df0f6c94dc
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j2981iOqa3TIFE7v3cGH1r/4jGqv/3Mn1zxIfSJb3FgnZXTDfJ08uoTz8hB9zrSIeTZ9cRN3XjhjS0dhk6DpjAWJ8152qYZtCyLMPKXUtq7xqeq2BNZfvczX/AzZ3B8/BMD0oL9g130/c85kFXPwCbTvR/yTqnUeJ09KzWz/RoquL3OWnho8VsRWP7bMPvzVfw+TWsU7Op5+JaBNfHNppyxicaHgG/nsGSpP2t9S0rjBqkWkHS5NhrMRzf1lerrB7TztgE4aCs21xqye3Y4TiiqLBvJbYDvRsRCPSGzOZMornSA/Su+x6Mi57fpWhdqHe1xWLkvUmqjaq53khRYGp6bCSsotB5VJK2gkKbu7ZHlkYGqgxQef1/uUiW6bSji3VGUT0WlyO4eoy1KwvCOXhaa/mdhm1KCbYShJxrep/bT120D8hZxFO+X4Jkqw/z82l5IVhrIDvPzlBGdzt8NflyuGzH1t3Y7u304ZC91BsLDL9e+0yWxKaZSzibGW05rtnuG0Nt2QNs2lqFTN1qPBEH3psdZbdSlz12fTz6R8v/IGdNjLYQft5Rn+NFyQAsllmSXppTs1fSgyoNeljMTGojIarzAT8T4wTB7ukTiwyI0TuYs4xYmWh4yRj/DwiOOOP49QdiUm8PXm+vyiUI0f6s4Rk6e3L3xB1E4jadryudqN+zzYHe2ztBz2602Ymix8pjV4h4V+k9uYMNCC4RWcmWpLH9GY+5DtJx9yeX8n72Yx7x9wpjfvCdZ5Pbd2jMTHmc6Wsw0cre4scy1gDgLnrhgMlNGhSnewU895r0TJXtr4bkfxLkjEKKSu
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|8062599012|19110799012|8060799015|24021099003|55001999006|37011999003|13091999003|31061999003|15080799012|51005399006|25010399006|40105399003|1602099012|10035399007|2607281247196008|102099032|3412199025|440099028|4302099013;
x-microsoft-antispam-message-info:
 =?utf-8?B?T21EUzgwWkhWNCttRFBrcHVLSUl5VTcvVUVZMlpiTnJLaU5VMXkwRGEzU2hM?=
 =?utf-8?B?MmpTQ0tVWkVEYlhWUW9FZENRT1lEalgxOUxOdE5mWDZEcFAzVHhqNkhhT1du?=
 =?utf-8?B?ZU1kLzhNSDBubmxtNnRRNjRTVjNoL0NUdTZkWGFrTngzMG8ycVZqdnlJaGlF?=
 =?utf-8?B?cU9sOWtMRWxpRkFFWjBKSUlpb3RPendDREVWaUNmK3crWU5EcTBDS085bEZV?=
 =?utf-8?B?K1k2T0hiYldXS2NtQVFsenVJT0xGMUY4SFc5RkNTVmpUaU0zVVZpL0ppWGNs?=
 =?utf-8?B?UmhPaFNxUGNucHljMFlCcStNM3AwMitjY2t4dUdRTCtiUFBBRHN1WmN4VVNU?=
 =?utf-8?B?cThZZ095RzZnaXlaZzdWZDg2S214d0R3M3VGNUZrcTlWbUxaK1lWS2NzOTBJ?=
 =?utf-8?B?ZVI4dklOY1ZIMFhXaUNJYVYrdHVTVnRtV0RGQStTYVJUMFMyNi9BcWRQanQr?=
 =?utf-8?B?WXRpYnBBOUFzRVN1WlBWQWlWNmZUYTlvbGRoM3k1RExkQ3duY2JoMWRUVUE3?=
 =?utf-8?B?QlU4L09ONUEyUS9DR21WZEZWQktiRXJUc0lMWEVTUkxLVE5BOTU2aDc4RnNY?=
 =?utf-8?B?blFUNS9MOGE5MTNOVXFTdkNGSmFrNnVSSlFhakkvNC93djRvckdxMnhSTVNo?=
 =?utf-8?B?SnR2WllCRW9OVm9xdW1oa3Y3U0hpSDZOZmxpMGlhNFR3OEFDYWdpKzlsQXA2?=
 =?utf-8?B?M0ppYzQyRGJMeXVxVkdQYnJTZHN0bE9iSE5NT2x3RHEybFB3TWlvNE9zQlBF?=
 =?utf-8?B?TnJTTkF4QlBzZ085eGRWbENtYW12UUlETThrZExFN0hsVXFEdnNtOVpYVDdu?=
 =?utf-8?B?TnAwNnEyR0k3WklWQU44Nm5jM0Q3dUZ1N3dQcnNOOEJSRUtZOUo0bGhONG1k?=
 =?utf-8?B?czI1SlJHazc0NC8xelg1amFuaHZtSzMwRW1xL1NCYmY4SWtKRWJ1eXAyZGEr?=
 =?utf-8?B?KzBIT1A4bHlENmVPaXhIMWNMN3A1TWFGSzVrZ2x6dGpGMmlxYW85U3BxNjZC?=
 =?utf-8?B?SWxqc0VnQkRaOXIzelN2QmxadWIrOWhhSGR2ekVUSUhjK3pjU3NhTnZmMmhU?=
 =?utf-8?B?WVVXOXNIVFVQT0d5bEVoK3RKL1plWTZ6QjUrU3czODdiZi9KSi9DTDJUUGVm?=
 =?utf-8?B?SHJaTng0T05qOE9URGpjZHgrWDVxKzlpa3BoaFBnb0l6akkrSkJRMHE3cWlQ?=
 =?utf-8?B?cWRUWjdIV0VNNXhjYjcrZEJrZkFxTkJoVVZiUUpBU280T0lSdmNWWE9Jcnlp?=
 =?utf-8?B?WEtiVHdJNlIwbjRmSG51a2I5dUxMR3NmK2xUQnNyUnhVem9qT1BuU2lycmVH?=
 =?utf-8?B?OS9YcnpobzBkUnczeHpsRWdHYlRaTVpSUXlXRG0vUndoeEZMUUs4MHJmS21q?=
 =?utf-8?B?NlJDUWozcU1aTVlMbTVVc25OMHB0a2N0Y2hEUFF0Qlp4VmV1QUdXaHNQZDFO?=
 =?utf-8?B?RjU4dXlqY2ZXT0cvVks0ck5PWi9zdm5NLzZhT0M5Y2hiU1lnajVnbEQ4YzB5?=
 =?utf-8?B?V21xbXBtemtKQU9YU1hVY3hIbStJa2l0UTFKYWFqZlNvT3l1Z2oxMzlpNE85?=
 =?utf-8?Q?oZ4GcUEWm8YxictgffJp+pX9g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUZhcERyaGJLN2hYbmhqaVdyMjdhenVQd1ZCMVF3R3ZHeVlxNXZJN2UxLzlE?=
 =?utf-8?B?TXJvOVlLczcvVE1kbGZwckVMdUYybklaUzhjcDlTWmlpaHpBZ0UyRTEybjFZ?=
 =?utf-8?B?OHBBSnNmc3hLTzFwcm9udVdmazBBeHRtTGFCMmkranpMN3ZEb3l1ZWN5blFk?=
 =?utf-8?B?OTRVbFBteC9qZUhQSkc0TWplZWhwWkduQUlhSFVBQ1djVEcydmQyWm1iZVJL?=
 =?utf-8?B?R1BFaVJINnVmdjBVUkhtUmZqWUdWa0xpQXpBY09DYUZrSlJjR3N1cVVTM1k5?=
 =?utf-8?B?c3JvdEY3QXRESzQyMW9VWmRKYmdRblJPa3dyTkJaU0h5L3p0VXFpZStJdXFk?=
 =?utf-8?B?MWFVOGp0bTlDdi9KckpvTWlQZkdnekxxblV1dzFJUXk3RFY5eTlwbnpLbWMz?=
 =?utf-8?B?UjBEODQ1K3NKYmtCZzhQZGFWSnlWcjZ1MUlNalVXZVNRMDk4alpRSW9ibWpL?=
 =?utf-8?B?eWlKMVFoSXcxa3VkUEJ5czFjUXJQbDZ6MzNtUFNINDljcUdrL2J0R080cU1U?=
 =?utf-8?B?Ymk3Ly81OWtZLzg2d0lhTDVxckRpeVJ3T1htMVRYS2p5UmdNbjdQajlmWmFo?=
 =?utf-8?B?T0lRdUlRQnAxVUJRMFZlcGZJNEpjcFBuM2RGWjlDRy9nRThuVWZpTHI4V2xV?=
 =?utf-8?B?d0NOdnEycEphVHFTd2tWL3kzbFdwRnBOTE90UVhQc3BBeTd2cDZOMEdoWkw1?=
 =?utf-8?B?SmpaWmE5TmRjdDQ4Wlh6RVRPSUhqTzRkWWR1ZXV6WEdLTC9XWkZxM2xVQmdI?=
 =?utf-8?B?QlhsblhUUnB2MDYrNmxMZWp1dHRwRUV2NFNON3hWbHJtUXQ5UE9tbGFwTzgz?=
 =?utf-8?B?K29Ud01VS25uem5oc3VlM3NleVFGam15VldjV2FWNWFPaDlQOXBweElkdTQx?=
 =?utf-8?B?eTFhdW9wRmJyL3NUZG1HL3ZvUXpBTEVDdWxENmRYcDBuOEtCZmp1amlGdlQx?=
 =?utf-8?B?OGpiS3Q1KzJDZzNXOHhTVzVPU0x4YktLRkN1aUxlQ1hGUk9XbFp1VU8wdXIv?=
 =?utf-8?B?ZHJ0OXFqc3F3TWF1dTlicERjaERpYjdpVnlUMzJRa1dQYUsvVFhmTjB2dDA3?=
 =?utf-8?B?b2lEOGJUbk1uWDJVWlYzR3dzSU96QkhmeWs4dmplNStHNGc3L2RabGJpUjFB?=
 =?utf-8?B?K012eHlJWGNQV0RqUm9VVVJGSitvQ2pzSXFGL1RPUExwY2w4VmNYOE5qdnp3?=
 =?utf-8?B?TGJnZG1HTVVlbG1lczZyVzBhUm5pb2x5TW5NdC9SaEh3ODRUc0NYaUMwajB1?=
 =?utf-8?B?bWhxWk1rTmJhbkxCVG9hRE1oSTdUNkJYU2IwZkRKSjkrUng0Q0REdDZDZFNi?=
 =?utf-8?B?QXhlUzRiNCsvWkRoVGZqUllhTVI4Skx1SU9kQkpJaldLa25MNHJsWkx4ZWdY?=
 =?utf-8?B?UEFkYkxIK0N4cmJZcm42dUd3cWtzb3J1UDNNQktscWNXVXo4Um1ueFM2dmsx?=
 =?utf-8?B?NEp5S056TlhuNXBweDhwSTRjQWtTMEZvUlhKcHpDbExVV2FuQzFRN29rb1RH?=
 =?utf-8?B?bzBvR2tnTC8wMDQ4ODA2US90QnN6bFUrdkRTdGt4LzdpZWQ2NXpDK3I0R0pq?=
 =?utf-8?B?ekYxQzgwaVg5RjJLbTV2Znh6bXFXKzd2VWRzWDJZaWx6OUg5Z1JSbExrdURx?=
 =?utf-8?B?cU0vMDVYVXBmYk1tNUF1cUN1TG9NM0FoajVnalZEQXNGTE91YVpTeFNZcTYy?=
 =?utf-8?B?RWc0dXkvTjdBWnlOK1ZRQ2VTSE5rQ2N2dmw0SVk0aWpSZDlZRGNWWjVjZ1Jz?=
 =?utf-8?B?WlMrNU0vNnBENklYSzlUdm84cFpMdUduRmVZN3NFTUxjaVR0MktTTEp0REVk?=
 =?utf-8?Q?oqCwnWdLit9S3ypiVCiK5oMWZSw9HwBO2qvzo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 803461c1-a0e4-4d70-acde-08df0f6c94dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 18:51:53.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10887

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGtlcm5lbC5vcmc+IFNlbnQ6IFdlZG5lc2RheSwg
U2VwdGVtYmVyIDksIDIwMjYgMzoyNCBBTQ0KPiANCj4gT24gTW9uLCBBdWcgMTAgMjAyNiBhdCAw
OTowNywgTmFtYW4gSmFpbiB3cm90ZToNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9t
c2kuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jDQo+ID4gQEAgLTEzNyw3
ICsxMzcsNyBAQCBtc2lfc2V0X2FmZmluaXR5KHN0cnVjdCBpcnFfZGF0YSAqaXJxZCwgY29uc3Qg
c3RydWN0IGNwdW1hc2sgKm1hc2ssIGJvb2wgZm9yY2UpDQo+ID4gIAkgKiBJUlIuDQo+ID4gIAkg
Ki8NCj4gPiAgCWlmIChsYXBpY192ZWN0b3Jfc2V0X2luX2lycihjZmctPnZlY3RvcikpDQo+ID4g
LQkJaXJxX2RhdGFfZ2V0X2lycV9jaGlwKGlycWQpLT5pcnFfcmV0cmlnZ2VyKGlycWQpOw0KPiA+
ICsJCWlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoaXJxZCk7DQo+IA0KPiBUaGF0J3MgYnJv
a2VuIGJlY2F1c2UgaXJxZCBwb2ludHMgYXQgdGhlIHZlY3RvciBkb21haW4gYWxyZWFkeSwgc28g
dGhlcmUNCj4gaXMgbm8gcGFyZW50IGFuZCBub3RoaW5nIGdldHMgcmV0cmlnZ2VyZWQuDQo+IA0K
PiBMZXQncyBsb29rIGF0IHRoZSBoaWVyYXJjaHkgd2hlbiBpbnRlcnJ1cHQgcmVtYXBwaW5nIGlz
IGVuYWJsZWQ6DQo+IA0KPiAgICAgICAgICAgICAgfCAtLS0gW0RNQVJdDQo+IFtWRUNUT1JdIC0t
LSB8ICAgICAgICAgICAgICAgIHwgLS0gW0lPQVBJQ10NCj4gICAgICAgICAgICAgIHwgLS0tIFtS
RU1BUF0gLS0tfCAtLSBbSFBFVF0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAt
LSBbREVWSUNFIE1TSV0NCj4gDQo+IEFsbCBvdXRlciBkb21haW5zIGhhdmUgLmlycV9zZXRfYWZm
aW5pdHkgPSBtc2lfZG9tYWluX3NldF9hZmZpbml0eSwNCj4gd2hpY2ggZG9lczoNCj4gDQo+IG1z
aV9kb21haW5fc2V0X2FmZmluaXR5KGlycWRhdGEsIC4uLi4pDQo+IA0KPiAgICAgaXJxZGF0YS0+
cGFyZW50LT5pcnFfc2V0X2FmZmluaXR5KGlycWRhdGEtPnBhcmVudCwgLi4uLik7DQo+IA0KPiBJ
biB0aGF0IGNhc2UgbXNpX3NldF9hZmZpbml0eSgpIGlzIG9ubHkgcmVhY2hhYmxlIGZvciB0aGUg
RE1BUiBkb21haW4NCj4gYW5kIGFsbCBvdGhlcnMgKElPQVBJQywgSFBFVCwgREVWSUNFIE1TSSkg
ZW5kIHVwIGluIHRoZSBSRU1BUCBkb21haW4NCj4gd2hpY2ggaGFuZGxlcyBpcnFfc2V0X2FmZmlu
aXR5IGFuZCBuZXZlciBlbmRzIHVwIGluIHRoZSBhYm92ZSBjb2RlLg0KPiANCj4gSW4gdGhlIG5v
bi1yZW1hcHBpbmcgY2FzZToNCj4gDQo+ICAgICAgICAgICAgICB8IC0tIFtJT0FQSUNdDQo+IFtW
RUNUT1JdIC0tLSB8IC0tIFtIUEVUXQ0KPiAgICAgICAgICAgICAgfCAtLSBbREVWSUNFIE1TSV0N
Cj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgdmVjdG9yIGRvbWFpbiBpcyB0aGUgTVNJIHBhcmVudCBk
b21haW4gZm9yIGFsbCBvZiB0aGVtDQo+IGFuZCBhbGwgb3V0ZXIgZG9tYWlucyB3aWxsIGVuZCB1
cCBpbiBtc2lfc2V0X2FmZmluaXR5KCkgdmlhDQo+IG1zaV9kb21haW5fc2V0X2FmZmluaXR5KCku
DQo+IA0KPiBJbiBhbnkgY2FzZSAnaXJxZCcgaW4gbXNpX3NldF9hZmZpbml0eSgpIHdpbGwgYWx3
YXlzIHBvaW50IHRvIHRoZSB2ZWN0b3INCj4gZG9tYWluIGFuZCB0aGVyZWZvcmUgdGhlIGV4aXRp
bmcgY29kZSBpcyBjb3JyZWN0IGFuZCBjYW4ndCBiZSBjaGFuZ2VkIHRvDQo+IHJldHJpZ2dlciBo
aWVyYXJjaHkgYXMgdGhhdCB3b3VsZCBzZWUgaXJxZC0+cGFyZW50ID09IE5VTEwgYW5kIGRvDQo+
IG5vdGhpbmcuIE5laXRoZXIgd2lsbCBhZGRpbmcgYSBjb25kaXRpb25hbCB0aGVyZSBkbyBhbnl0
aGluZyB1c2VmdWwNCj4gYmVjYXVzZSB0aGUgdmVjdG9yIGRvbWFpbiBhbHdheXMgaGFzIHRoZSBy
ZXRyaWdnZXIgY2FsbGJhY2sgc2V0Lg0KPiANCg0KSG1tbS4gSSd2ZSBiZWVuIHN0YXJpbmcgYXQg
dGhlIGNvZGUgdG8gdHJ5IHRvIHVuZGVyc3RhbmQgaXQgYWxsLA0KYW5kIEknbSBub3Qgc2VlaW5n
IHRoYXQgJ2lycWQnIGluIG1zaV9zZXRfYWZmaW5pdHkoKSBhbHdheXMgcG9pbnRzIHRvDQp0aGUg
VkVDVE9SIGRvbWFpbi4NCg0KU3RhcnRpbmcgd2l0aCB0aGUgbm9uLXJlbWFwcGluZyBjYXNlIGZv
ciBzaW1wbGljaXR5LCB0aGUgb25seSBwbGFjZQ0KLmlycV9zZXRfYWZmaW5pdHkgaXMgc2V0IHRv
IG1zaV9zZXRfYWZmaW5pdHkoKSBpcyBpbiB4ODZfaW5pdF9kZXZfbXNpX2luZm8oKSwNCmFuZCB0
aGUgY2hpcCBpbiB0aGlzIGNhc2UgaXMgZm9yIHRoZSBhYm91dC10by1iZS1jcmVhdGVkIGRldmlj
ZSBNU0kgSVJRDQpkb21haW4uIFNvIHdoZW4gbXNpX3NldF9hZmZpbml0eSBpcyBjYWxsZWQsIHdv
bid0IHRoZSBpcnFkIGJlIGZvciB0aGUNCmRldmljZSBNU0kgZG9tYWluPyAgQW5kIGluIGZhY3Qs
IG1zaV9zZXRfYWZmaW5pdHkoKSBjYWxscyB0aGUgcGFyZW50DQouc2V0X2FmZmluaXR5IGZ1bmN0
aW9uIChhbmQgdGhlIHBhcmVudCBpcyB0aGUgVkVDVE9SIGRvbWFpbikuDQpGaW5hbGx5LCBpbiBl
eGlzdGluZyBjb2RlIChiZWZvcmUgdGhpcyBwYXRjaCkgbXNpX3NldF9hZmZpbml0eSgpIGNhbGxz
IHRoZQ0KLmlycV9yZXRyaWdnZXIgZnVuY3Rpb24gZm9yIHRoZSBkZXZpY2UgTVNJIGRvbWFpbiwg
d2hpY2ggd2FzIHNldCB0bw0KaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSgpIGluIHg4Nl9p
bml0X2Rldl9tc2lfaW5mbygpLg0KaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSgpIHRoZW4g
ZmluZHMgdGhlIFZFQ1RPUiBkb21haW4NCi5pcnFfcmV0cmlnZ2VyIGZ1bmN0aW9uIGFuZCB0aGUg
cmlnaHQgdGhpbmcgaGFwcGVucy4NCg0KSW4gdGhlIHJlbWFwcGluZyBjYXNlLCB0aGUgc2FtZSB0
aGluZyBoYXBwZW5zIC0tIHRoZSBkZXZpY2UgTVNJDQpkb21haW4gaGFzIGl0cyAuaXJxX3NldF9h
ZmZpbml0eSBhcyBtc2lfc2V0X2FmZmluaXR5KCksIGFzIHNldCBieQ0KeDg2X2luaXRfZGV2X21z
aV9pbmZvKCkuIEFuZCBiZWZvcmUgdGhpcyBwYXRjaCwgdGhlIFZFQ1RPUiBkb21haW4NCi5pcnFf
cmV0cmlnZ2VyIGdldHMgaW52b2tlZCB0aGUgc2FtZSB3YXkgYnkgZ29pbmcgdXAgdGhlIGhpZXJh
cmNoeQ0KdG8gVkVDVE9SLg0KDQp2NCBvZiB0aGlzIHBhdGNoIHNldCBpcyBoZXJlIFsxXS4gSW4g
UGF0Y2ggMywgaXQgdXNlcyB0aGUgbW9zdCByb2J1c3QNCndheSB0byBpbnZva2UgLmlycV9yZXRy
aWdnZXIsIHdoaWNoIGlzIHRvIGNoZWNrIHRoZSBjdXJyZW50IGlycWNoaXANCmZpcnN0LCBhbmQg
aWYgaXQgZG9lc24ndCBpbXBsZW1lbnQgLmlycV9yZXRyaWdnZXIsIGludm9rZQ0KaXJxX2NoaXBf
cmV0cmlnZ2VyX2hpZXJhcmNoeSgpLiBXaXRoIHRoaXMgdmVyc2lvbiwgc2V0dGluZw0KLmlycV9y
ZXRyaWdnZXIgaW4geDg2X2luaXRfZGV2X21zaV9pbmZvKCkgY291bGQgYmUgZHJvcHBlZCwNCnNp
bWlsYXIgdG8gdGhlIG90aGVyIHBsYWNlcyB0aGF0IHNldHRpbmcgLmlycV9yZXRyaWdnZXIgaXMg
YmVpbmcNCmRyb3BwZWQgaW4gUGF0Y2ggNCBvZiB0aGUgc2V0Lg0KDQpUaGlzIGlzIHdoYXQgSSBz
ZWUgZnJvbSBsb29raW5nIGF0IHRoZSBjb2RlLiBCdXQgSSBkb24ndCBoYXZlIGENCmJhcmUgbWV0
YWwgeDg2IHN5c3RlbSBydW5uaW5nIExpbnV4IHdoZXJlIEkgY2FuIGNvbmZpcm0sIHNvIG1heWJl
DQpJJ3ZlIGdvbmUgYXN0cmF5LiBJbiB0aGUgSHlwZXItViBndWVzdHMgSSBjYW4gYWNjZXNzLCBk
ZXZpY2UgTVNJDQpkb21haW5zIGRvbid0IHBhcmVudCBkaXJlY3RseSB0byBWRUNUT1IgdGhlcmUs
IHNvIHRoZXkgYXJlbid0DQp1c2VmdWwgdG8gY29uZmlybS4NCg0KVGhhbmtzIGZvciB5b3VyIHRp
bWUgbG9va2luZyBhdCB0aGlzLiBBbmQgdGhhbmtzIHRvIE5hbSBhcw0Kd2VsbC4gSSd2ZSBsZWFy
bmVkIHF1aXRlIGEgYml0IGFib3V0IElSUSBkb21haW5zIQ0KDQpNaWNoYWVsDQoNClsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1oeXBlcnYvMjAyNjA5MDkwNjQ0NDguMTAwNC0xLW5h
bWphaW5AbGludXgubWljcm9zb2Z0LmNvbS8NCg==
