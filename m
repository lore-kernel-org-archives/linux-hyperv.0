Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010018.outbound.protection.outlook.com [52.103.2.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE5514774;
	Mon, 21 Sep 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024489; cv=fail; b=XoRZqge3siAJJM5q7jhIFbtBBMW0KPa3+fATnLbvE1qHo3hiVpjmW9YyBw0lVRSqPmMGBhHq7TSUFDSznDOkchJw7naC6a7Ut5wIoEazHLK47sCrsAS5bRGokVuMIsfwqCpDP8CPAUwLEJE28yc2Ad2InXhXT7oEyokCmMute5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024489; c=relaxed/simple;
	bh=D/CChMOT2KOyxLsRLuyQKh+4x/QB8FqMPvp34eQRFWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rjGckADOeDGvVLcWGUO0t6UYt9IdL9GTrrQLKYjjvtBvrOPQRHRMYxoP3E+1y0dh0x1EOJzrMWVSmpjeHOXozmyIr3gqZPm6nNMbnbRiHnyJurmLDIy2isxkp9wYG7MBk1HQXIPYu8YQU43bW+d+OGw+CmYHg605ZhaJh9zBoKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y9TkJEoN; arc=fail smtp.client-ip=52.103.2.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y9TkJEoN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnKVi4j7KV7mntBwFmcuEaLlN00NhqaLQWS9SOaKnnJq/2p4Mc6lOa+dxp5zwNqCdvoSKDLS34RQLPOZOllxfpVmylzj6+1cJ1Yfx+lNk4JjjABRC29QgJYitdKVPe+gIiHUS2C96HXIlYgOZOQNB4zCpNULHAbZggUKd8RnnybY7YriCcgfJ0HB959I6/umrXPuTWFay1B3srCis9YBWu5oy/VoVEgDsAooNnXJk5Xa8NXX/UnEnxYg404krenkNo4Q83zpT8ym6WTGPOQFbEs0cY245EvrmUY6MPG6LB2wDPI7tQl2csNMJ7/mSzYi7FRcun9lz5gvJY80/PGvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/CChMOT2KOyxLsRLuyQKh+4x/QB8FqMPvp34eQRFWA=;
 b=wTSz8hIvQzmmu+L2a1YzYAEGdsrQ/oRoGMPMzwnkzvUC7svdP3ibmQwto/dW1JZ+ILZIg0FHm96mcKLL8FfmxKCVo3foxWtkH6/Vx3uexeWo/DG9e5y2YplW3rkL/mucu3p/pTATw05tMnqJi7nqdCTjhOfxJz5rtU1NHb+Ma4s5Xp9Gk00Il1KO1T8o5I2Bzlk9zTQhnjxMzMdDzgM+ttrB4E7P2Hr2GoKdEbHwYrQnUimZuemf4SSec1N7bZD8mnvWND8IpxbYdD7GTuYyCy9TckyDe0Ba/bkaeUUiAP9K0ex6hberhnD+J5hf7nllSPkLlwZ/a6rEShL7Wljmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/CChMOT2KOyxLsRLuyQKh+4x/QB8FqMPvp34eQRFWA=;
 b=Y9TkJEoN6TZdMWDiBmEWJfgGN3RRVbGReMAnjSjHt4+vHC6ToeVwtkP63Uf/uxvF1cjlfPdIn6sEtPBf+TBtvv+E1PFwnKinAliIAi97TQCnmuIDqC9q8Mjp5LuS3XWHKez7CV2+QUzH2WRlf+u69HxfIlDragNzJXbOYDGnqzS8QEds4HVp1NW8r8tJn7yvHuH0jlSPnsDAWYrY95R/V+M0d3xNzF8w9iaiMkMu5eH6RTAOlUZKibOPWnI0N9UjdMt66g5oh+fr41geaHH3zUOIYFXCk8c8/5sb1x8OsI2DohQInPZgjdDDnr0vHU7KKAgEZWSQrXVwEpO/ITpWPA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB914464.namprd02.prod.outlook.com (2603:10b6:8:359::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:01:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:01:26 +0000
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
Subject: RE: [PATCH v5 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Topic: [PATCH v5 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Index: AQHdRDrrqOsRiveFoECQOD7w6Om017bZkENg
Date: Mon, 21 Sep 2026 21:01:25 +0000
Message-ID:
 <SN6PR02MB4157B6AAECA10E13072B727BD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-5-namjain@linux.microsoft.com>
In-Reply-To: <20260914111836.2119301-5-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB914464:EE_
x-ms-office365-filtering-correlation-id: f0189137-cc98-47ce-da0f-08df18237ff5
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOt/PRcfPHcKbLSvSNpr4iV59vnJeSlp5Akxbx72lDBKzOOa/dkQdyv7v+CwQ/9wjNw0pgbK/odluZZ1Ar3gN5Oiu8UrGFOoTqaNZtLAaUEJveLocYqSXTpwokkfTxEoIx16VJxdHrMWMSBON+LP9R8u+YXiE42m4/qDYwOPUkbtaPb6XdNB3MhXk2dwGKgykBQZCc6LV/TnbZBjffMKU8Ip6HeX4MUsl3gdZmMX/cDtuRZkPfeKPSymMabvxtllvsCSFTmbw5M2vqqW2HLe5eQkKl3VfkuXMptdCFIeaULY409KjOIN0qHgyuU/GrlbFW8bqczShNz7KURKFu78B4olX5GjplsqdzhoOH44AigCk9LwyKHajHzJmaTDPBh2ciUSYTFKNHoCq/0Id3XuGqLxkaGdZpg90oObnFmogWnRGxh2TiDOi4RnaNQ/SWbh6gsTLOG5xtBEEMFQFofMf7tgRd70Bp0gAtw/mvCJdtCTr/OZvmEz0BSkOJSYbWq15bcAlgeTyn9zoZXuGqWrDeR9+bhWK2J+45zZT+o5grgrgNwJrIqCpQdUFroaR/x/pNk9qK2qM9AAXPsx3NS4ksFhv4ILL8IFky5aNBB30zpCm1+Yv1bIq7+5U0Fm6kD2IVAcRmd9juxP/hRQmAdNqukqFU16Qi2d0+8yitJViKEL3I5etTYxvNNAPMJJ3WOvAzYcg8yCL59LAtYSqmCLShJw9gqop+TtrqRuSHYjEbLB4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|25010399006|55001999006|51005399006|24021099003|41001999006|31061999003|8062599012|13091999003|19110799012|8060799015|40105399003|2607281247196008|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wkx6d0dqSVpCTEh3MzdXVlZ4R1NKdWlDYkJtMWIrVWYxVjZ4Q1BzM280a0E0?=
 =?utf-8?B?NEZNcnlrampqbGpYbFh5aStLV2tZV0pTUVJQZW9Wek10SHc5NjlsVGo1SHZF?=
 =?utf-8?B?cGFRUFhuUVh0OVJveTNGN0oxODNHVHZnV05TR2RmYWdpZkFUWDJ1SFIwQ24r?=
 =?utf-8?B?d3Q0UXJ5YkNQS292a2dvNGVLRnR3UW5ENllob01VbnhOVmRhWDhVWGljQzB6?=
 =?utf-8?B?aS90QjFKSFlXK2g4M29PeGRNZ3NSQmJXYVoxT2NNa1BKQ1M0NktyQ245SHQx?=
 =?utf-8?B?bndReVVDMDhSenMybXNQRktudmpZdlJQa0JObSs0ZEhjb05md2ptYmNVdFlq?=
 =?utf-8?B?QjFrR2pnRXhGYW5PcytoaHJhQUJqZnZGaU1FSWsyWXZwYmhEbERaMEJacVNQ?=
 =?utf-8?B?VVlKcUo5VFkzMUJiaUN5bWFRWFFBZ1hRWlg1dTFzV2JSOWxMRlAremhMMmg0?=
 =?utf-8?B?cnErcWJ1cTdTa0pDam43eFUxK2FqSWo4azBtZVFmdFN4WU5veXRsOTJINnJ6?=
 =?utf-8?B?cXdZUENudGVtaVVrUGthMTRxc09sdTN2OVRpbFlaNDM1Z1lMTndOTUV5Y0JJ?=
 =?utf-8?B?eXNVdTE3a216VGJMdWphMXQ3QzM5eUdzSlp4c3BIdWZFa3FsSjc5SFBDblVF?=
 =?utf-8?B?N1ArQmd5VlpNNVNQdGxWeHZvSnlYZlJkc2xLQllObTMzWmRNaUJkRWNhVUNw?=
 =?utf-8?B?NUJPK2tma3VWYVFaYmZBcFpaUHpDL2NNKzl5UjgrODlzbGN3SVdXUUlBay9H?=
 =?utf-8?B?cGM0QklzdWkvSTJVRkxLVDVpSVZ3MThoem9iRVBoT2hjYVRpSS9GUGVrL0tF?=
 =?utf-8?B?d0VlemFxR2hwMkJQV0xpdFd3STdUN2JDcUJzTkhIcTRMMGE4RjBNTTRGZ1lU?=
 =?utf-8?B?VDFNSXM2aG9FQjZPQllEa01iRnFKWEFEbTZ6M1dJWVovcG03V1drU3dUb2w5?=
 =?utf-8?B?RU41SU9rUUhTZ1ByVlRyWTgyQy9uck0rL0VIdWRKTTZuelNkZkhFWEdxc0Ft?=
 =?utf-8?B?ZWZNYVMxZ0NSNkREMmFGcXcxZ2xmd1ZGSmo3NjA0NWZSZDU3UHJhdEh2OENO?=
 =?utf-8?B?S21ISUJYWmtjbFZsMWFGVFNrTVFhYWkxS2UwQWRuN0cyZjVQZ2ZYbmRHK1dq?=
 =?utf-8?B?NVlzLzBCS3lHbUtwTklKRE8rQllQT1lJd0t4WTQ5WGswYk9VNGRqNU1NUjNy?=
 =?utf-8?B?Y1pSeldlU0pTeVlPR29PZ292a1hZUVc1WjFhMldBK0l3cGJCa3VDcUo3dUFJ?=
 =?utf-8?B?VFY3YUxCem1NWDZDcVBaQklxUC9Vbm51RzlaNDZsMGVUSlNqMTgrRG9DYXZ1?=
 =?utf-8?B?bm5XNkowUnJ1RUVLRnhPdGUwR29XT1dwNHRlTWRsOUI1eXBIcTJXQytuYklh?=
 =?utf-8?B?a1dyMWUrRmY0elR1aXk4WDF4d1V1dEc3T0ozK3Z4bDU1RDR4Tjd0UTlzeXlm?=
 =?utf-8?B?amFJNHE3Vm9SRU1zVE5pWHcyZHZZYlpGT0dQQi9RPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anBQNzhGTzdoWG5CV3dYenI5R3lzV0VJc1JqYlZxVm9LTVNFaC85RGV3MGVN?=
 =?utf-8?B?S2drUGx0YWNrVCtoRG1tMDlFYUxLcThDdjhVTzMyeGg1VFc4a3FLbDRtTnll?=
 =?utf-8?B?VmN2Q3ZPd05qM0lhQjFHUFlwQ1dUTjJBbDQ1NEtUeVJlMmwrTGg4UWswTTZu?=
 =?utf-8?B?KzRLUXNKekxPZFo1STF5NXVTQjlEa1RZS281blMrVXAzT0FRN0lzWnEzT3hG?=
 =?utf-8?B?K0VZc2VobU5JUWl3MVNWWFJ6MGZPQ25MWHVQZCtTN0xyNnBlWjJKOG5hc2VF?=
 =?utf-8?B?Q0syQVVUYm5DSWJhSlpicHk0bzhnOE0xd04vRzFoZkhSNGNZZ3Qycm9YWEZO?=
 =?utf-8?B?QU40UStLRUVwOGZHR1U4ZEo5YXVXdEtSbGt4Nlo5UzhVUkZ3d1lieEQwSFpR?=
 =?utf-8?B?VWRZYmNsK21BVUxhOXdjcHNSYzBHOXA2VTBkUVREZmxicTc5dCtHMHFXRWIw?=
 =?utf-8?B?eUtQNXFpa2JEQTA4RUJmWm13WU1jSlp4N3JGTkI1aU9YTFI2N3lNVzM0V0xV?=
 =?utf-8?B?eVM0SUdmNFRCNnJ2SUlqTVJHYnhtZWdEWWxwMzdZbnRpcE5OYXBIeDZJL3N4?=
 =?utf-8?B?U3BXaThxOE9IUVR4QXIyMEVYMUlicXpVbStOUGRxM1gwbGdOS1kvV1JxUWNl?=
 =?utf-8?B?R2lyK1ZaQnRiN0c1S1U3ck1GQmFBekROeS9xMHVEdzlOSGFlQ1dwOS9rWXFi?=
 =?utf-8?B?SkhKRDVqRVhLanRkdm15bFNocWhQajU0OU0yb3BUaHZXWlV0NEhVNWR3eW11?=
 =?utf-8?B?YUdFeVkzTkprWUNQNkw5dUY2OCszMXk2OGRHbm1HZGdwN3hMb0RBK0VNSG5v?=
 =?utf-8?B?ZThXSzRsb0xacFVIOGU0azJoMnZoOVpRdWYwOC95THdmejhhRmIwRWMzWnJN?=
 =?utf-8?B?cC9CWmUxSFdncVNIOHM2bXRQOG91NkZtTmJ2UVVPWkV1WDRYam5JN2Mxd0U1?=
 =?utf-8?B?Y3Zhd240K1RLTnFkVmNZbTJtN0Q3a2luN056aHRsMWRpQ2NTd2RsZlJ3RS8r?=
 =?utf-8?B?emVYdm51Qzk0akI5dkN1eERrZ0hodmFFWXM0OUtyem81VWpwbytkNmNMWmxh?=
 =?utf-8?B?V3VPZkRjM3Rtc05tWmNlZDF3dUZmSjlFbUNuYmVCMXdOWWNTR0l1Tk9rSkhD?=
 =?utf-8?B?L2k1dkV0ZTNxTllEQnd3QzVXNkhmWDdheXcxTlpVL1loSGpuN1JkUkNoODg2?=
 =?utf-8?B?NDQzUWZvWkNqU2ZybzRYTFFzM1plckUzUUhrS3d4S0JKamF6RUdwelp2M2NZ?=
 =?utf-8?B?OSsraU9XUUxSd3FqUmlvSnIwdEcvVm1mMzBuNnlpY2VneDdKTGU4M1lMUlVm?=
 =?utf-8?B?MjlybmNxRHQ4eVZJUGs1TFI0c3M3WDRPaDdMQVpNNDJHV0xJcUl3T05HVGFr?=
 =?utf-8?B?blZMcmE4VFBuOGlDaE9WaUszYmdrWVBjVXdGSG9IOStPZmcvc3JrWnl3ZjJi?=
 =?utf-8?B?RFJJYUdDb1N5WThxb1ZuOXNDUFFWVExZUzVPM1F5dWtwNkxjUTBUdmdrTk1O?=
 =?utf-8?B?V3JIZVBzMG5MK1l3cXkrajQ0NXY5RDFkeGV1WDl3cjRjWEsvWGxFaUVRSmRF?=
 =?utf-8?B?UG1tNFhubENYSTZUYTNTdXlzczBwb2xoSEFRdkdaejhTZjFrdFhxc1ZKd0VL?=
 =?utf-8?B?eTdXbnVMNEtGQXlRWkRvbXV5UnNwZnNlKzhmWUlyUDY3OTh1YSsybUcyWVBh?=
 =?utf-8?B?Y1Qzc1c0eG1CdktqKzBBMmwvQmxRVFdTYStTMmtodEdPSFVxbUZoeW5NMDJI?=
 =?utf-8?B?L1pMODVleWlnSUZrQnNiN0NEOWxLWld1bnR5MWl1bU14UzZMUU85bmZlLzRl?=
 =?utf-8?Q?Lfq68CX6R6fboSvHytQY1a1jGkRfJNQ3lS75w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0189137-cc98-47ce-da0f-08df18237ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 21:01:25.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB914464

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIFNlcHRlbWJlciAxNCwgMjAyNiA0OjE5IEFNDQo+IA0KPiBXaXRoIGZpeHVwX2lycXMoKSwg
bXNpX3NldF9hZmZpbml0eSgpIGFuZCB0aGUgZ2VuZXJpYyByZXNlbmQgcGF0aA0KPiAodHJ5X3Jl
dHJpZ2dlcigpKSBub3cgYWxsIGZhbGxpbmcgYmFjayB0byBpcnFfY2hpcF9yZXRyaWdnZXJfaGll
cmFyY2h5KCksDQoNClRoZSAiZmFsbGluZyBiYWNrIiB0ZXJtaW5vbG9neSBpcyBub3QgYWNjdXJh
dGUgaW4gdGhpcyB2ZXJzaW9uIG9mIHRoZQ0KcGF0Y2ggc2V0LiAgUGVyaGFwcyAiYWxsIG5vdyBj
YWxsaW5nIGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHkoKSBkaXJlY3RseSI/DQoNCj4gaW5z
dGFsbGluZyBpdCBhcyB0aGUgaXJxX3JldHJpZ2dlcigpIGNhbGxiYWNrIG9uIHRoZSBvdXRlcm1v
c3QgZG9tYWluIGNoaXBzDQo+IGlzIG5vIGxvbmdlciByZXF1aXJlZC4gVGhlIGhpZXJhcmNoeSB3
YWxrIHJlYWNoZXMgdGhlIHg4NiB2ZWN0b3IgZG9tYWluJ3MNCj4gYXBpY19yZXRyaWdnZXJfaXJx
KCkgZm9yIGFsbCBvZiB0aGVzZSBzdGFja2VkIGRvbWFpbiBjaGlwcy4NCj4gDQo+IFJlbW92ZSB0
aGUgbm93IHJlZHVuZGFudCBpcnFfcmV0cmlnZ2VyKCkgaW5pdGlhbGl6YXRpb25zIGZyb20gdGhl
IG91dGVybW9zdA0KPiBkb21haW4gaW50ZXJydXB0IGNoaXBzLCBpbmNsdWRpbmcgdGhlIEh5cGVy
LVYgcm9vdCBwYXJ0aXRpb24gUENJL01TSSBjaGlwLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFu
Z2UgaW50ZW5kZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBr
ZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2hyYWRoYSBHdXB0YSA8c2hyYWRoYWd1cHRhQGxp
bnV4Lm1pY3Jvc29mdC5jb20+DQo+IFJldmlld2VkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
a2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5t
aWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYyAgICAg
ICAgIHwgMSAtDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMgICAgICB8IDIgLS0N
Cj4gIGFyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jICAgICAgICAgIHwgMiAtLQ0KPiAgYXJjaC94
ODYva2VybmVsL2hwZXQuYyAgICAgICAgICAgICAgfCAxIC0NCj4gIGRyaXZlcnMvaW9tbXUvYW1k
L2luaXQuYyAgICAgICAgICAgIHwgMSAtDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1o
eXBlcnYuYyB8IDEgLQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYyBiL2FyY2gveDg2L2h5cGVy
di9pcnFkb21haW4uYw0KPiBpbmRleCA2ZDc5MDYzNmM4Yjk1Li5iM2FkNTBhODc0ZGNhIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaXJxZG9tYWluLmMNCj4gKysrIGIvYXJjaC94ODYv
aHlwZXJ2L2lycWRvbWFpbi5jDQo+IEBAIC0zMTYsNyArMzE2LDYgQEAgc3RhdGljIGJvb2wgaHZf
aW5pdF9kZXZfbXNpX2luZm8oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gaXJxX2RvbWFp
biAqZG9tYWluLA0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAgCWNoaXAtPmZsYWdzIHw9IElS
UUNISVBfU0tJUF9TRVRfV0FLRSB8IElSUUNISVBfTU9WRV9ERUZFUlJFRDsNCj4gLQljaGlwLT5p
cnFfcmV0cmlnZ2VyID0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeTsNCj4gDQo+ICAJaW5m
by0+b3BzLT5tc2lfcHJlcGFyZSA9IHBjaV9tc2lfcHJlcGFyZTsNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9p
b19hcGljLmMNCj4gaW5kZXggN2Q3MTc1ZDAxMjI4OC4uMThmNDlhMjUxZjIzYiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2FwaWMvaW9fYXBpYy5jDQo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9hcGljL2lvX2FwaWMuYw0KPiBAQCAtMTg1Nyw3ICsxODU3LDYgQEAgc3RhdGljIHN0cnVj
dCBpcnFfY2hpcCBpb2FwaWNfY2hpcCBfX3JlYWRfbW9zdGx5ID0gew0KPiAgCS5pcnFfYWNrCQk9
IGlycV9jaGlwX2Fja19wYXJlbnQsDQo+ICAJLmlycV9lb2kJCT0gaW9hcGljX2Fja19sZXZlbCwN
Cj4gIAkuaXJxX3NldF9hZmZpbml0eQk9IGlvYXBpY19zZXRfYWZmaW5pdHksDQo+IC0JLmlycV9y
ZXRyaWdnZXIJCT0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSwNCj4gIAkuaXJxX2dldF9p
cnFjaGlwX3N0YXRlCT0gaW9hcGljX2lycV9nZXRfY2hpcF9zdGF0ZSwNCj4gIAkuZmxhZ3MJCQk9
IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8DQo+IElSUUNISVBfTU9WRV9ERUZFUlJFRCB8DQo+ICAJ
CQkJICBJUlFDSElQX0FGRklOSVRZX1BSRV9TVEFSVFVQLA0KPiBAQCAtMTg3MSw3ICsxODcwLDYg
QEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBpb2FwaWNfaXJfY2hpcCBfX3JlYWRfbW9zdGx5ID0g
ew0KPiAgCS5pcnFfYWNrCQk9IGlycV9jaGlwX2Fja19wYXJlbnQsDQo+ICAJLmlycV9lb2kJCT0g
aW9hcGljX2lyX2Fja19sZXZlbCwNCj4gIAkuaXJxX3NldF9hZmZpbml0eQk9IGlvYXBpY19zZXRf
YWZmaW5pdHksDQo+IC0JLmlycV9yZXRyaWdnZXIJCT0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJh
cmNoeSwNCj4gIAkuaXJxX2dldF9pcnFjaGlwX3N0YXRlCT0gaW9hcGljX2lycV9nZXRfY2hpcF9z
dGF0ZSwNCj4gIAkuZmxhZ3MJCQk9IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8DQo+ICAJCQkJICBJ
UlFDSElQX0FGRklOSVRZX1BSRV9TVEFSVFVQLA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL2FwaWMvbXNpLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBpbmRleCA5MTYw
MjI3YjliMzJhLi5hYWQyZjE1ZWIyMTc2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
YXBpYy9tc2kuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KPiBAQCAtMjQ2
LDcgKzI0Niw2IEBAIHN0YXRpYyBib29sIHg4Nl9pbml0X2Rldl9tc2lfaW5mbyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdA0KPiBpcnFfZG9tYWluICpkb21haW4sDQo+ICAJaW5mby0+b3BzLT5t
c2lfcHJlcGFyZQkJPSB4ODZfbXNpX3ByZXBhcmU7DQo+IA0KPiAgCWluZm8tPmNoaXAtPmlycV9h
Y2sJCT0gaXJxX2NoaXBfYWNrX3BhcmVudDsNCj4gLQlpbmZvLT5jaGlwLT5pcnFfcmV0cmlnZ2Vy
CT0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeTsNCj4gIAlpbmZvLT5jaGlwLT5mbGFncwkJ
fD0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwNCj4gIAkJCQkJICAgSVJRQ0hJUF9BRkZJTklUWV9Q
UkVfU1RBUlRVUDsNCj4gDQo+IEBAIC0zMTMsNyArMzEyLDYgQEAgc3RhdGljIHN0cnVjdCBpcnFf
Y2hpcCBkbWFyX21zaV9jb250cm9sbGVyID0gew0KPiAgCS5pcnFfbWFzawkJPSBkbWFyX21zaV9t
YXNrLA0KPiAgCS5pcnFfYWNrCQk9IGlycV9jaGlwX2Fja19wYXJlbnQsDQo+ICAJLmlycV9zZXRf
YWZmaW5pdHkJPSBtc2lfZG9tYWluX3NldF9hZmZpbml0eSwNCj4gLQkuaXJxX3JldHJpZ2dlcgkJ
PSBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5LA0KPiAgCS5pcnFfY29tcG9zZV9tc2lfbXNn
CT0gZG1hcl9tc2lfY29tcG9zZV9tc2csDQo+ICAJLmlycV93cml0ZV9tc2lfbXNnCT0gZG1hcl9t
c2lfd3JpdGVfbXNnLA0KPiAgCS5mbGFncwkJCT0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwNCj4g
SVJRQ0hJUF9NT1ZFX0RFRkVSUkVEIHwNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9o
cGV0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaHBldC5jDQo+IGluZGV4IDhkYzdiNzEwZTEyNTAuLjJi
YjdhNmY0NjZhZjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9ocGV0LmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2hwZXQuYw0KPiBAQCAtNTA5LDcgKzUwOSw2IEBAIHN0YXRpYyBz
dHJ1Y3QgaXJxX2NoaXAgaHBldF9tc2lfY29udHJvbGxlciBfX3JvX2FmdGVyX2luaXQgPSB7DQo+
ICAJLmlycV9tYXNrID0gaHBldF9tc2lfbWFzaywNCj4gIAkuaXJxX2FjayA9IGlycV9jaGlwX2Fj
a19wYXJlbnQsDQo+ICAJLmlycV9zZXRfYWZmaW5pdHkgPSBtc2lfZG9tYWluX3NldF9hZmZpbml0
eSwNCj4gLQkuaXJxX3JldHJpZ2dlciA9IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHksDQo+
ICAJLmlycV93cml0ZV9tc2lfbXNnID0gaHBldF9tc2lfd3JpdGVfbXNnLA0KPiAgCS5mbGFncyA9
IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8IElSUUNISVBfQUZGSU5JVFlfUFJFX1NUQVJUVVAsDQo+
ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIGIvZHJpdmVycy9p
b21tdS9hbWQvaW5pdC5jDQo+IGluZGV4IGVkY2MxODdiOGYxNGYuLmJjM2RhNWIwNTc4ZWIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYw0KPiArKysgYi9kcml2ZXJzL2lv
bW11L2FtZC9pbml0LmMNCj4gQEAgLTI0NzcsNyArMjQ3Nyw2IEBAIHN0YXRpYyBzdHJ1Y3QgaXJx
X2NoaXAgaW50Y2FweHRfY29udHJvbGxlciA9IHsNCj4gIAkuaXJxX3VubWFzawkJPSBpbnRjYXB4
dF91bm1hc2tfaXJxLA0KPiAgCS5pcnFfbWFzawkJPSBpbnRjYXB4dF9tYXNrX2lycSwNCj4gIAku
aXJxX2FjawkJPSBpcnFfY2hpcF9hY2tfcGFyZW50LA0KPiAtCS5pcnFfcmV0cmlnZ2VyCQk9IGly
cV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHksDQo+ICAJLmlycV9zZXRfYWZmaW5pdHkgICAgICAg
PSBpbnRjYXB4dF9zZXRfYWZmaW5pdHksDQo+ICAJLmlycV9zZXRfd2FrZQkJPSBpbnRjYXB4dF9z
ZXRfd2FrZSwNCj4gIAkuZmxhZ3MJCQk9IElSUUNISVBfTUFTS19PTl9TVVNQRU5EIHwNCj4gSVJR
Q0hJUF9NT1ZFX0RFRkVSUkVELA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiBp
bmRleCA4OTgxNmEyYmQ3Y2QzLi5jZmM4ZmE0MDNkYWQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS1oeXBlcnYuYw0KPiBAQCAtMjExOSw3ICsyMTE5LDYgQEAgc3RhdGljIGJvb2wgaHZf
cGNpZV9pbml0X2Rldl9tc2lfaW5mbyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBpcnFf
ZG9tYWluICpkb20NCj4gIAlpbmZvLT5vcHMtPm1zaV9wcmVwYXJlID0gaHZfbXNpX3ByZXBhcmU7
DQo+IA0KPiAgCWNoaXAtPmlycV9zZXRfYWZmaW5pdHkgPSBpcnFfY2hpcF9zZXRfYWZmaW5pdHlf
cGFyZW50Ow0KPiAtCWNoaXAtPmlycV9yZXRyaWdnZXIgPSBpcnFfY2hpcF9yZXRyaWdnZXJfaGll
cmFyY2h5Ow0KPiANCj4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkNCj4gIAkJY2hpcC0+
ZmxhZ3MgfD0gSVJRQ0hJUF9NT1ZFX0RFRkVSUkVEOw0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNCg==
