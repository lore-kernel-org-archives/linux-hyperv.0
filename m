Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011025.outbound.protection.outlook.com [52.103.13.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7BB3A255A;
	Wed, 23 Sep 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174005; cv=fail; b=mXewj2Npb8/8Bri0A4gd4vvZo8PNlpyeyP3aBE+6oIDbGKsD/HOrBnAtsa7WjzWFZaJUpT7nOJAYd6HLMtPo3Ahk+9qwJMzxEmscSd0SZYtBfl6WXRsFkQb5eGeN7WUe6gyw+wtYoY30dL98lIDHHhB/S5CMabXLHIPNa1YDdnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174005; c=relaxed/simple;
	bh=0526UyRy2ztBut68mcGo/yJwVohM23RFsJX9pywgkmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mYkkOng3xvXRAeJckoGJUr9LXPx0neg6Pt26MX1/lubrxqEBHyyY5mtMbXrZofYvpWFPRXMz8cGad40VMy2iKjKGttfYhB2SJLQDtl60LXHYWYs2tsp994zVLe5hmeHZYPqATijTVzy6kqPUcMoa8xxB8MK1Rr/mvezgpy55JqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bkqKHSPu; arc=fail smtp.client-ip=52.103.13.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bkqKHSPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNOKvxazFqhr7VJS6qwdKpLI3vjRSWPlVOPdmDP8Z2o5h+Q5a+665JBT4KzUJuRO3jTc4Xt7b9j1JU7CcxPSQlhaL8vsjyZJHnCKxd5HIo1/tZ1AsJULXaZ4abAEzL6efrd6e4bY7WWqDIlx6jWinbYHa1i3bmZymfq00tCWXIWaZYaUIFlBFw4hRqLQBhSlEpz2HDFN4PRbau/8yEDRj71vtsc9OSpKn8s/sf0CHpK3ZeIp2w+f9CjcnOC9407MCcpnr2GhAkOhoOA6PwIZwTaATdE6vlsbIGNi8GwgxYqyi9M3y/Pj6bLvgIrxmkMQ1xlYhEmyGm4JGjlsrPQSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0526UyRy2ztBut68mcGo/yJwVohM23RFsJX9pywgkmw=;
 b=o6e0yOmzrGMfIDgLje5i/HACrFCS/ebdQKgIABOshJCamu4PqZ3TbFFI5h8SyFrjsstmXOZcmPXTgY6hDBGenTLBpwOum4B5E+ZwFipdZXNXi5yn9QkU89USkB2ptKILEnE6xoangaU8bmrNkAKG/cLVPVn197k7y9ll5HEXTfz4aG9ZODWnYDPG05TzK3IskXvAvwmTHa1t9IOt+c41VSWXwlvmjMsx91zGt8yrsHDXQ/grtv+P0aBYgsz7vtisCGEGIrzZLfQphSzwAtoE8VWdoWYkobHrobyDQP7Y+1x5L6/MIVww0tw1Fc4yH6a3P/jrBNEs/e/1+bIPcDZFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0526UyRy2ztBut68mcGo/yJwVohM23RFsJX9pywgkmw=;
 b=bkqKHSPuNkxnDhn/RPKqin50m91dnBxiOVtvcvINNTZHa8LTLCIzfMrY8T5sSPCSQ8aBK6/IAoubCwAXrKQTz2nxv113S4bmy7Aq+PQNSCwPK7EQnfbjt5vnOhXsgb3LhD2LkonNzkxG/MQ+bCIFN3HiuouEzZGUAIHv4kAsEz0okTgqmvggUBiVx/iQlrrQfCw1hIyJT1rNQNyhJYJuwfPMvWN4Yf+76b2Lu5qVDO/NWiwiGwKeC4gvoBFAxoJ5prxd/Mf3zO3ECOYgTIDzjQwq6/nZB0Tl8Jqjun8jOQneyQgfRxacIHMTbW/X0TF6D7/9ujzMxicBpZx2dAVegA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10163.namprd02.prod.outlook.com (2603:10b6:806:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:33:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:33:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Wei Liu
	<wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Nam Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
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
Subject: RE: [PATCH v6 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Topic: [PATCH v6 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Thread-Index: AQHdSxRgSMV93Wah8UeJDMFZyXK4F7bcOrTA
Date: Wed, 23 Sep 2026 14:33:01 +0000
Message-ID:
 <SN6PR02MB41575EBF93A8C1DD8144F5DFD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-5-namjain@linux.microsoft.com>
In-Reply-To: <20260923043023.3150498-5-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10163:EE_
x-ms-office365-filtering-correlation-id: 3a81277f-f346-41a5-70f1-08df197f9261
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOt/PRcfPHcKa4eatUDZJoq1l7e1DGWkBtPSHbUWR9gdYBmzMT1f95dR+wPqV+f0LmDnoHIlp0iEmXC9mvuMDSmgjQobWe99unGS6XHQ/ZOPGYeqDMGls9HXJT0+aiCXK3tzS2/YaW9tYVOrEb6VFSkiHmpMByjsW3lDgFUKJE5mjaPtRQvwv0iQsHpz49IyPouDTg0PPsNFPXppzideRVwEyMut+bpd808A8dEU1zlkFv7CKILYsGQydKBCy54991b2eLvMSyjqy2q1WNQP9N6acJXGs1ALlKzE7Z6U5MHN/eC65YXoBr/pf7+cU74bXwWIbFYmiw/1gTB6jcz9ewcq5dPVLTyMhYZW7uCJ5e1n3Tpl4mwQ/P7j2sEfjWA+09eJUclT//kvLay3IHL228UOzTvOcvcVFJha8uX4fvZGHCm4lqE04QNRXypAAAEcmfzomoBgUN8w5gR8Jg1EE8Plruefba90n2CWPkdK1sI9hu6IKkBuAkbjwEYLY7wp+aMGNF62ruxRBBKWhrw0X+aJjNegfMMSj/vtG3S2wsZV/unQGx+JXhLtrQN5nvspi9tp4McO7fLs/Wimj0phRRW5NZFJU9qAQHq4Im+b+mlVKUt5x8j9szESoCLe8TlQQpW0U2BEwkaJJv3lbDFRrHRqh7i6FsGBoARQxO2dIIbmXutEX8qhISRV6O9gkRHTMvNaNrytnFsri90mRb5SytdO9OjN6Ed7IQfcpkmPH6qHs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|8062599012|8060799015|51005399006|25010399006|15080799012|19110799012|55001999006|41001999006|24021099003|31061999003|13091999003|3412199025|440099028|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEZrdWZrbDdqVitYdnV6WmpVK2djWWxVQkk0TWh5TzJON0kzRGJtTGFSSXN3?=
 =?utf-8?B?bDJ3OC9UVThJL2daSnRoS3dGZ05FSUNTS1BvVHRhNWhPcFpQKy8wdi8vbFlj?=
 =?utf-8?B?Q0dRR3pXK1AxTWlpVi9Ic0ViV1ZmeThDTklxWmhaZDNXRkFLeXZtMy9ZNlZt?=
 =?utf-8?B?czdYblljT2FvUm5RRW9xdEpyaElRTmN4cTIxRE9SeERnZW9uVVZWazBIdjJL?=
 =?utf-8?B?WkU5VzJ3WllIa3o3aVBGTC8rNWQ0SWtOMmFpQzlsQVNOTzA3TUFEV01ZeCsr?=
 =?utf-8?B?a2NicTdmMHRxT0g0cmpzaVJhaE5GZ3JVd2diUUIxQ2ovTG9LaVhGWUY0bmps?=
 =?utf-8?B?MVQzWkdXY1htN011ZXpSTHFvcnlyZE9zT3dCbEFoczRsWXpZZ2dlQTY4c3U5?=
 =?utf-8?B?WEgrRVcxK2R3MTh0bFdVVkxtb09wUjNGMjBEVXpvcWNxQkh6c2w3YXMxQXI0?=
 =?utf-8?B?NGRlNHNFMEttZVo2WURuMFV0RkZaamFPeWlSOHZoQXhuOTZ5WVg3d01QY1ZR?=
 =?utf-8?B?TGM4L011d0YzMkJjUFdUcUlGczNjWU1BdzUxbW4reVNRSmxaTUhKYVQ1RlhE?=
 =?utf-8?B?YWZ2TTViM3MxKzFHMWJ6MTdYRVBLb2NkejRNWkt6RzFpbmNncHJ3dXpsbDR6?=
 =?utf-8?B?Q0orN1NFRkdoMVRQZEVOMVNoek9QbjFCUGxqY1ZVbGNIWUMrZXJhbUVuOFUz?=
 =?utf-8?B?VjFEMHl6dlppR3BZMTB6KzE1VFBwelJIUFBXejA2MTFVOVhUaGNiWjJiQkQz?=
 =?utf-8?B?SHUrUG9xcUpBOEMzck0wd1h2WUJNbVZDcEc5MXpTdlUxY0ZuZ09GTWRROEVt?=
 =?utf-8?B?LzZaMUwxam1EVUtSbFV6ODh6RU51OWlkZTMrbld1UTYrUGU5ZHBTcDNzUHRs?=
 =?utf-8?B?S1dvT3JQOGFCSEhMZnpvYXM4elVOQkV3eFJ2dG5MbFFjZjhod1YvNm5ZQkxw?=
 =?utf-8?B?bHJxcS85YWVDcDJkakk1QmtOYzRKdCthMjBVZHJnSjNPTjAyMkNVbG9FcWRP?=
 =?utf-8?B?NVV5WU1aQ1BscUt4eDRiUjRBVTQ3TU1kbTdQaDVqckZKdGpKbi96WW1JSDdP?=
 =?utf-8?B?MjBzRE1nUUY3V04yRkxYWEE5Zm5KWnNsNmM0SnRQSHNhR2xJdUtnOVNrSG5w?=
 =?utf-8?B?N3p1Nk96MXpPRk5FQzNieCtvNWROdFlPdWhQanUweXlvQ0w1YmZ3UmNobWFr?=
 =?utf-8?B?M3RLQ3NxWWlnS1RCQW9rVlh6L3ZSNzI4Ym4wUFdaK1FGSkZ1djRSZ2hZZUY2?=
 =?utf-8?B?NzNnaFdZZXNLYVgwMjdLcGtUNU5MTjhicklWQTlGZ1FYUXlRdjgxWUpjY0tw?=
 =?utf-8?B?QjN1WW5hYkNpS3BQQ1NnelN5MkdudlZLendOSEEwQUZCMkdGYVZjVmRIRkMv?=
 =?utf-8?B?Q25XWGRDeFl4bmhQcXV0ZWFLV0RKQmdLV3FROWdDSUZZTkxJOXByY0tMdXNR?=
 =?utf-8?B?QlZ1Y3BxbndkOUVyMlpLQVRwZCtwTGNtcFc4YWF3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2RiUmcyaE8yZytKR2JTY2dkb2FYR1dSczdNVVMwdUdiT0FUTktTS2xRY05I?=
 =?utf-8?B?OFBBeDVUZmk1b2hHdGVaQ2E4NEI5Z0JLMHRZdm5iSzJyazFXQUpFaDZjWmRi?=
 =?utf-8?B?L283ZGlRaVlhT3liT08zU3BzTlBCdlp2L1ZQWCtZNitXQnluQzlCajhpdHRo?=
 =?utf-8?B?SnRZcjF4RkVWLzBRRFdSQzgyWW1KRVk4cjJqaGI1bzZnbmp6djJSdXUrQnBm?=
 =?utf-8?B?ejI1NnBsQnZTbzhmbHE4SlNCSEpUQmg2OVlhUlNUUEpXT3VrREtmVlV4TEZt?=
 =?utf-8?B?Zjhsb05hb2tjZjRxeWI2ZlFNUkxyMEVQMWwzSWNROVprLzFzT0wzeW9zM0lC?=
 =?utf-8?B?V0dJNUlEY2RuN0FRalNnS0tPZ21hRkk4OWFTbDBzZFU0SGRyNUlrREpxZzk0?=
 =?utf-8?B?WnVQR2ZsYkE5Ryt0TGk2dyt6RnNYZkY0ZDV0aHdFUy9oRS9xWno0M0dKK3Br?=
 =?utf-8?B?NTBWZGZoQUR6SEZ6QlNROWJXblZVSGY5Z3lsS0RqUGlOU3J0a1FzMUNIWnRo?=
 =?utf-8?B?QzN6YURmcENacExIaW9FU21jY2NmU3VrenA1R0lvRnNsUUlnYnIxUndXWjRi?=
 =?utf-8?B?dm5Faml1TDlveU53WmQ3N0ZDbnJvL21leDdMRHhnNC8rMXcxOXRYMW05UFJv?=
 =?utf-8?B?aUwvM2IzRVFMdnJha3BhZ21YUzdWTUlhQ0c1WTNvWmMxSHlrQW00d0xXcmNH?=
 =?utf-8?B?b3JaWGlqYWZJNG10L3Y2SndoKzVzUlVnT1hLeTlhYmIyeGZidHNlYmM5MW9E?=
 =?utf-8?B?cHBKMGJRMThUdCtmL09BbS8xeU8vQkVraTFGZUdxcnpiOXJDSHovSktYdys4?=
 =?utf-8?B?Q3BHU0ZXd2dWbFduWHVPbzdBTzJNOWpMblJ1WGEwUUJUc2g4Z1ozZE1mVmdk?=
 =?utf-8?B?U3ZHTzdET1BnVVpNaWRseldxd01RWjBaSGNZMkFUeFk2UVdDYmp1Sk5TRmFG?=
 =?utf-8?B?eGlVRU1wOGs5c1krVmZ6UDRQYW9VV085b2lSTFJzRk9peDUxcStkRE1zZjhx?=
 =?utf-8?B?Z2l3WXBKK1g5YjFvRHdEWFptQWU1R2FvRi9YOUo4Tlh4QWR5QTF6WTZGdWhK?=
 =?utf-8?B?ZGVDK25SSWNqeHdkakhYWWF6MWFpMmlMaDQzWklBeFhGRitaNDNocDNEQVE4?=
 =?utf-8?B?UnlpcDhBRlF5TWQ5ZjU1RHlvWEMwVWU5TWdSaFVKdjczenVEYU0xZkdNNDc5?=
 =?utf-8?B?TTRDOWIvS2ZzUVVZamRtZU9YeWIycVhiTzBacHhGSUtvZ29tdFBNdkU4Wm5U?=
 =?utf-8?B?T2pUcVFCZkJkbUVRWTRxKzFPNlkyZ3pSS1VtTnBTamRjeEQ0VWFSYXJVODN2?=
 =?utf-8?B?WVpUQXM3dVRIR1Axa25NM2g3Ly95MDk4SVpPRWZTQm90eWNWUnVWV3hPY3Ft?=
 =?utf-8?B?bG9QL2dNZDNkdXNYSVZDWWFxQVVHS1lTbXBTUS9kTlZ5L21ESG85eWtiYWZh?=
 =?utf-8?B?eXZSQ25FaFh6TmRvY0crOE96RmllUHhCcEdKRE9QbCtKcFpySmNjMUVlYXFL?=
 =?utf-8?B?a1I3QmlWM000Rm0wKzhYK1gzZ2VwOWxVTE5NZVdialVVTnhkRlJZbmRvWjdz?=
 =?utf-8?B?RThjMkxXSW8wU2JteXUrNCtOYlMzNW11ejNxalhXOFJLWHhELzVZWjkxYnpL?=
 =?utf-8?B?TEREQ1hGSXJhdE5Ma1RwSUkwM1U0N3pHSUNRVzJvR2FTQnoyL2J5b3FxRENx?=
 =?utf-8?B?TThvbFRDYU9CN3VXeXkrL3JpaURzVC8yR0U2TVkyRGVlZVRJa0RuZy9waHRG?=
 =?utf-8?B?a3Q1SzVTdG5BTmNlQ1pRQ3FHQ05LVlhLc05nQ24zRDNvMHdzK0hYN1p5UVVE?=
 =?utf-8?Q?eu3lmZgeyp1ipT9Fx9Yya9O5G23YS7N4434lM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a81277f-f346-41a5-70f1-08df197f9261
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 14:33:01.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10163

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjYgOTozMCBQTQ0KPiANCj4gV2l0aCBmaXh1cF9pcnFzKCkg
YW5kIG1zaV9zZXRfYWZmaW5pdHkoKSBub3cgdXNpbmcNCj4gaXJxX2NoaXBfcmV0cmlnZ2VyX2hp
ZXJhcmNoeSgpLCB0aGUgb3V0ZXJtb3N0IGRvbWFpbiBjaGlwcyBubyBsb25nZXIgbmVlZA0KPiB0
aGUgaGVscGVyIGFzIHRoZWlyIGlycV9yZXRyaWdnZXIoKSBjYWxsYmFjay4gVGhlIGdlbmVyaWMg
cmVzZW5kIHBhdGgNCj4gYWxyZWFkeSB1c2VzIHRoZSBoaWVyYXJjaHkgaGVscGVyLg0KPiANCj4g
VGhlIGhpZXJhcmNoeSB3YWxrIHJlYWNoZXMgdGhlIHg4NiB2ZWN0b3IgZG9tYWluJ3MgYXBpY19y
ZXRyaWdnZXJfaXJxKCkgZm9yDQo+IGFsbCBvZiB0aGVzZSBzdGFja2VkIGRvbWFpbiBjaGlwcy4N
Cj4gDQo+IFJlbW92ZSB0aGUgbm93IHJlZHVuZGFudCBpcnFfcmV0cmlnZ2VyKCkgaW5pdGlhbGl6
YXRpb25zIGZyb20gdGhlIG91dGVybW9zdA0KPiBkb21haW4gaW50ZXJydXB0IGNoaXBzLCBpbmNs
dWRpbmcgdGhlIEh5cGVyLVYgcm9vdCBwYXJ0aXRpb24gUENJL01TSSBjaGlwLg0KPiANCj4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2hyYWRoYSBHdXB0YSA8
c2hyYWRoYWd1cHRhQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFJldmlld2VkLWJ5OiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFpbiA8
bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPg0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxs
ZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYvaHlwZXJ2L2ly
cWRvbWFpbi5jICAgICAgICAgfCAxIC0NCj4gIGFyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMu
YyAgICAgIHwgMiAtLQ0KPiAgYXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgICAgICAgICAgfCAy
IC0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvaHBldC5jICAgICAgICAgICAgICB8IDEgLQ0KPiAgZHJp
dmVycy9pb21tdS9hbWQvaW5pdC5jICAgICAgICAgICAgfCAxIC0NCj4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWh5cGVydi5jIHwgMSAtDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDggZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaHlwZXJ2L2lycWRvbWFpbi5jIGIv
YXJjaC94ODYvaHlwZXJ2L2lycWRvbWFpbi5jDQo+IGluZGV4IDZkNzkwNjM2YzhiOTUuLmIzYWQ1
MGE4NzRkY2EgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYw0KPiAr
KysgYi9hcmNoL3g4Ni9oeXBlcnYvaXJxZG9tYWluLmMNCj4gQEAgLTMxNiw3ICszMTYsNiBAQCBz
dGF0aWMgYm9vbCBodl9pbml0X2Rldl9tc2lfaW5mbyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBpcnFfZG9tYWluICpkb21haW4sDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gDQo+ICAJY2hpcC0+
ZmxhZ3MgfD0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwgSVJRQ0hJUF9NT1ZFX0RFRkVSUkVEOw0K
PiAtCWNoaXAtPmlycV9yZXRyaWdnZXIgPSBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5Ow0K
PiANCj4gIAlpbmZvLT5vcHMtPm1zaV9wcmVwYXJlID0gcGNpX21zaV9wcmVwYXJlOw0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYyBiL2FyY2gveDg2L2tl
cm5lbC9hcGljL2lvX2FwaWMuYw0KPiBpbmRleCA3ZDcxNzVkMDEyMjg4Li4xOGY0OWEyNTFmMjNi
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMNCj4gKysrIGIv
YXJjaC94ODYva2VybmVsL2FwaWMvaW9fYXBpYy5jDQo+IEBAIC0xODU3LDcgKzE4NTcsNiBAQCBz
dGF0aWMgc3RydWN0IGlycV9jaGlwIGlvYXBpY19jaGlwIF9fcmVhZF9tb3N0bHkgPSB7DQo+ICAJ
LmlycV9hY2sJCT0gaXJxX2NoaXBfYWNrX3BhcmVudCwNCj4gIAkuaXJxX2VvaQkJPSBpb2FwaWNf
YWNrX2xldmVsLA0KPiAgCS5pcnFfc2V0X2FmZmluaXR5CT0gaW9hcGljX3NldF9hZmZpbml0eSwN
Cj4gLQkuaXJxX3JldHJpZ2dlcgkJPSBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5LA0KPiAg
CS5pcnFfZ2V0X2lycWNoaXBfc3RhdGUJPSBpb2FwaWNfaXJxX2dldF9jaGlwX3N0YXRlLA0KPiAg
CS5mbGFncwkJCT0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwgSVJRQ0hJUF9NT1ZFX0RFRkVSUkVE
IHwNCj4gIAkJCQkgIElSUUNISVBfQUZGSU5JVFlfUFJFX1NUQVJUVVAsDQo+IEBAIC0xODcxLDcg
KzE4NzAsNiBAQCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIGlvYXBpY19pcl9jaGlwIF9fcmVhZF9t
b3N0bHkgPSB7DQo+ICAJLmlycV9hY2sJCT0gaXJxX2NoaXBfYWNrX3BhcmVudCwNCj4gIAkuaXJx
X2VvaQkJPSBpb2FwaWNfaXJfYWNrX2xldmVsLA0KPiAgCS5pcnFfc2V0X2FmZmluaXR5CT0gaW9h
cGljX3NldF9hZmZpbml0eSwNCj4gLQkuaXJxX3JldHJpZ2dlcgkJPSBpcnFfY2hpcF9yZXRyaWdn
ZXJfaGllcmFyY2h5LA0KPiAgCS5pcnFfZ2V0X2lycWNoaXBfc3RhdGUJPSBpb2FwaWNfaXJxX2dl
dF9jaGlwX3N0YXRlLA0KPiAgCS5mbGFncwkJCT0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwNCj4g
IAkJCQkgIElSUUNISVBfQUZGSU5JVFlfUFJFX1NUQVJUVVAsDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jDQo+IGlu
ZGV4IDkxNjAyMjdiOWIzMmEuLmFhZDJmMTVlYjIxNzYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9hcGljL21zaS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jDQo+
IEBAIC0yNDYsNyArMjQ2LDYgQEAgc3RhdGljIGJvb2wgeDg2X2luaXRfZGV2X21zaV9pbmZvKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwNCj4gIAlpbmZvLT5v
cHMtPm1zaV9wcmVwYXJlCQk9IHg4Nl9tc2lfcHJlcGFyZTsNCj4gDQo+ICAJaW5mby0+Y2hpcC0+
aXJxX2FjawkJPSBpcnFfY2hpcF9hY2tfcGFyZW50Ow0KPiAtCWluZm8tPmNoaXAtPmlycV9yZXRy
aWdnZXIJPSBpcnFfY2hpcF9yZXRyaWdnZXJfaGllcmFyY2h5Ow0KPiAgCWluZm8tPmNoaXAtPmZs
YWdzCQl8PSBJUlFDSElQX1NLSVBfU0VUX1dBS0UgfA0KPiAgCQkJCQkgICBJUlFDSElQX0FGRklO
SVRZX1BSRV9TVEFSVFVQOw0KPiANCj4gQEAgLTMxMyw3ICszMTIsNiBAQCBzdGF0aWMgc3RydWN0
IGlycV9jaGlwIGRtYXJfbXNpX2NvbnRyb2xsZXIgPSB7DQo+ICAJLmlycV9tYXNrCQk9IGRtYXJf
bXNpX21hc2ssDQo+ICAJLmlycV9hY2sJCT0gaXJxX2NoaXBfYWNrX3BhcmVudCwNCj4gIAkuaXJx
X3NldF9hZmZpbml0eQk9IG1zaV9kb21haW5fc2V0X2FmZmluaXR5LA0KPiAtCS5pcnFfcmV0cmln
Z2VyCQk9IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHksDQo+ICAJLmlycV9jb21wb3NlX21z
aV9tc2cJPSBkbWFyX21zaV9jb21wb3NlX21zZywNCj4gIAkuaXJxX3dyaXRlX21zaV9tc2cJPSBk
bWFyX21zaV93cml0ZV9tc2csDQo+ICAJLmZsYWdzCQkJPSBJUlFDSElQX1NLSVBfU0VUX1dBS0Ug
fCBJUlFDSElQX01PVkVfREVGRVJSRUQgfA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2hwZXQuYyBiL2FyY2gveDg2L2tlcm5lbC9ocGV0LmMNCj4gaW5kZXggOGRjN2I3MTBlMTI1MC4u
MmJiN2E2ZjQ2NmFmMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2hwZXQuYw0KPiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvaHBldC5jDQo+IEBAIC01MDksNyArNTA5LDYgQEAgc3RhdGlj
IHN0cnVjdCBpcnFfY2hpcCBocGV0X21zaV9jb250cm9sbGVyIF9fcm9fYWZ0ZXJfaW5pdCA9IHsN
Cj4gIAkuaXJxX21hc2sgPSBocGV0X21zaV9tYXNrLA0KPiAgCS5pcnFfYWNrID0gaXJxX2NoaXBf
YWNrX3BhcmVudCwNCj4gIAkuaXJxX3NldF9hZmZpbml0eSA9IG1zaV9kb21haW5fc2V0X2FmZmlu
aXR5LA0KPiAtCS5pcnFfcmV0cmlnZ2VyID0gaXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSwN
Cj4gIAkuaXJxX3dyaXRlX21zaV9tc2cgPSBocGV0X21zaV93cml0ZV9tc2csDQo+ICAJLmZsYWdz
ID0gSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIHwgSVJRQ0hJUF9BRkZJTklUWV9QUkVfU1RBUlRVUCwN
Cj4gIH07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJz
L2lvbW11L2FtZC9pbml0LmMNCj4gaW5kZXggOGE0MTBkNGFhMzcwNC4uMGQyMjMyNDU2ODkxMSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jDQo+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvYW1kL2luaXQuYw0KPiBAQCAtMjQ3Nyw3ICsyNDc3LDYgQEAgc3RhdGljIHN0cnVjdCBp
cnFfY2hpcCBpbnRjYXB4dF9jb250cm9sbGVyID0gew0KPiAgCS5pcnFfdW5tYXNrCQk9IGludGNh
cHh0X3VubWFza19pcnEsDQo+ICAJLmlycV9tYXNrCQk9IGludGNhcHh0X21hc2tfaXJxLA0KPiAg
CS5pcnFfYWNrCQk9IGlycV9jaGlwX2Fja19wYXJlbnQsDQo+IC0JLmlycV9yZXRyaWdnZXIJCT0g
aXJxX2NoaXBfcmV0cmlnZ2VyX2hpZXJhcmNoeSwNCj4gIAkuaXJxX3NldF9hZmZpbml0eSAgICAg
ICA9IGludGNhcHh0X3NldF9hZmZpbml0eSwNCj4gIAkuaXJxX3NldF93YWtlCQk9IGludGNhcHh0
X3NldF93YWtlLA0KPiAgCS5mbGFncwkJCT0gSVJRQ0hJUF9NQVNLX09OX1NVU1BFTkQgfCBJUlFD
SElQX01PVkVfREVGRVJSRUQsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaS1oeXBlcnYuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+IGlu
ZGV4IDA1NmQzNzliM2NlZTQuLmEwMDRiMDhkNjhmZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLWh5cGVydi5jDQo+IEBAIC0yMTE5LDcgKzIxMTksNiBAQCBzdGF0aWMgYm9vbCBodl9w
Y2llX2luaXRfZGV2X21zaV9pbmZvKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGlycV9kb21h
aW4gKmRvbQ0KPiAgCWluZm8tPm9wcy0+bXNpX3ByZXBhcmUgPSBodl9tc2lfcHJlcGFyZTsNCj4g
DQo+ICAJY2hpcC0+aXJxX3NldF9hZmZpbml0eSA9IGlycV9jaGlwX3NldF9hZmZpbml0eV9wYXJl
bnQ7DQo+IC0JY2hpcC0+aXJxX3JldHJpZ2dlciA9IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJj
aHk7DQo+IA0KPiAgCWlmIChJU19FTkFCTEVEKENPTkZJR19YODYpKQ0KPiAgCQljaGlwLT5mbGFn
cyB8PSBJUlFDSElQX01PVkVfREVGRVJSRUQ7DQo+IC0tDQo+IDIuNDMuMA0KPiANCg0K
