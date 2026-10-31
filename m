Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793422058;
	b=maWFRPo/Q6sCJwt+UmbLIIrIZ+otr+/9eIJCvDA0YKmSjRIE3G25w2HCP6NG3XkaiVaO
	 cLbiCJiHtqlIH/R6DiWNg96xg8fzAnEdyrhcwrAMcfbgBnQ7/wvNxvqD7k6FgMh1MfkuJ
	 TFxE/PZrC658estB6jPBHsz/4qAj2N6ADxe2qSivQ58z4CCiiBrDRAbxo0K2UutcOBxGM
	 wrBn9ByG/D1gOXpTulPQtvn3FESak+8f+KWwnBac+GHhaEsD7ob+PiAhkhzWYyWxAqDWX
	 3TuVOxcgovzeK6uH8eZwnz2mD1vKSFg9VcrN2s1CzqiDK7YWafD9PKkmad2XWZjwBDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422058;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-traffictypediagnostic:x-ms-publictraffictype:
	 client-request-id:request-id:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EyVKiX3Xwg12sieDoZhVi4P4HaUlCJ8PmoiHWqwAA2c=;
	b=uP3A6Ar/puBnw92XK28pf3GTFAa7qmpSM4Akf2tCwzq4e2LpXEsGUGXzg/1ggIzOnD6N
	 KPAz0B8UdPWAcI3p65s+kiEFjwZvyhKRPIlsUvVQzN3ipYZQTRXjLmJ1/UJuJgK8V+hYA
	 RHaxBv3pNNVSbXwYJK1kMAHKCve3q0gR7z/WFEZsbRSg5aEPLguCgFCf0Qz4C3Lv6kjPz
	 ya6fddlU5j8HLUXaXDPDZwFjbnYxFphYaxKBvnkasoOJYiWFfTZD+KELe4tuJXSWqT9RT
	 d9t3riCWJaEzKFC0sDW1i4g2vH/UJ5SwH8rJ/raHpV65TBCAQoSXXS4F1PxwBXpw9Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=microsoft.com;
	dkim=pass header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=cX06smpA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.77
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022077.outbound.protection.outlook.com [52.101.53.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBF606A31A;
	Sat, 31 Oct 2026 04:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDBF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=cX06smpA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5A/j3pJB8svk+Oe9TCuFApWgjc5sideq1krLOmIggRlSj/DHUNjiioGaA0sMsdBzv1YK7Scn0QZA8saGB1oK2YGBcTsG4KVGW/c7DEEgu/5ojfFuIlDLQPxn7YomRc0vLbHX14abgm6ZbU3e2j8bocgX8+MGGn0PNVjDg3mmsn650Lxu7rzh+b6HeHituBPX1HpZY/GCzi3iemaLJ5s9mGrszimhQYsKVTAp/bomcq5MVXFzPNDX5Axxb5mPP7pdp3ZE+/Mki99P2OwHnO41y2TfGmIw9DK1zoRUReL3A8q4haMXnqX7DkgkFNnYZiY0NRZxq9wldWoNC7yGHZB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyVKiX3Xwg12sieDoZhVi4P4HaUlCJ8PmoiHWqwAA2c=;
 b=Rf9P58m2dYfwXP4HFhZldsJdWNSKku0/09EKhBTSBbf7drDNK3XNgTz3e7RPwgnMtB7a26+UqYbKtjJo/VweIlphFU1FbPddJJIy0KWoaMjk6V44o5Ji50gww6yU8nToOuZlHgEUMw3KZ+Ge7j1E3yJmO8Ywif7VfEgv88xqo54OLlGteKy1U9/r+BsW47ZM0U32ZsjKGe4gZTOnY+k7zFyBd3s7YCxFsVpTzhQlUsfuKjXk8y4b1kdHyEPqMKzv5oTXbfkfsXsaUITa4O7qVMs9Lwpwg+M9s7IGkP9mukqqleuOMtcBW/vJJO+RPD8ZzSZmPcY1F3l9IJAYVvlivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyVKiX3Xwg12sieDoZhVi4P4HaUlCJ8PmoiHWqwAA2c=;
 b=cX06smpAFREfM8fWbYURZne5DjTw805RjAqAC/Cz+N5ynEfUXc0Sy7vY0UMx72d7OSb1kdRJcd8fkLMz37swodpJZFZKAk6NpNXAWHu//y6gDLUxOVd273+mxRTd5Nb749/n9tJNh5tyWekYdLqidctWp3Q5s/f4Okmbb6C72+8=
Received: from CH4PPF0966F22FC.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::c44) by CH8PR21MB4863.namprd21.prod.outlook.com with
 HTTP via P2P; Sat, 31 Oct 2026 04:47:32 +0000
Received: from CH4PPF0966F22FC.namprd21.prod.outlook.com
 ([fe80::d976:2d64:b851:4f61]) by CH4PPF0966F22FC.namprd21.prod.outlook.com
 ([fe80::d976:2d64:b851:4f61%8]) with mapi id 15.21.0592.001; Sat, 31 Oct 2026
 04:47:32 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Kameron Carr
	<kameroncarr@linux.microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"will@kernel.org" <will@kernel.org>, "Mark.Rutland" <Mark.Rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor
 via RSI host call in CCA Realms
Thread-Topic: [EXTERNAL] Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor
 via RSI host call in CCA Realms
Thread-Index: AQHdZ/h1dAYFfTv4ukq3KPjS0plBmrcXEWxw
Date: Sat, 31 Oct 2026 04:47:32 +0000
Message-ID:
 <CH4PPF0966F22FCAF3D8C6535743902930DBF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>
 <auPOnb_9Jfzh-oQE@arm.com>
In-Reply-To: <auPOnb_9Jfzh-oQE@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=df547bf0-d2ea-440b-ab5b-efedb2736535;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-31T04:31:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: CH4PPF0966F22FC:EE_|CH8PR21MB4863:EE_
x-ms-publictraffictype: Email
client-request-id: 6bdd9567-2fc0-46da-aafc-8497fb62a1c3
request-id: 9a3793a5-c742-4877-9e05-08df370a1366
x-ms-office365-filtering-correlation-id: 9a3793a5-c742-4877-9e05-08df370a1366
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|4143699003|5023799004|11063799006|56012099006|261009223027099003|261021135927099003|261021121427099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|7146999003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 QQ5FAmgtVz9CgbjAXQj7hCkxTIzDUSf9foKwaCYQiSQZkTTZEhD3YaHizSrHmm3axd0F/hegayxhjx+HdWQuFNpiTyiShbtGCBqFGZD5jtQiSrP/K3SJhy/HMCmSz5WTJBXXmD1PJH5/A6VpanrCv+rzSQ/fg9q7/cjFGDtJFOIp4Vg9kc37alI59JEu+qxHdtDntxEbbXwaomJ2NiJ7xM224c2tl0RPuS30CuiME22NJ1vlPbLoGlBg1mZAJO4fbU1O45zg/fNNMI6sBsDeGxzvXIFHdR11bbKznm1aUxl0hs7ZSht7tapn7EBdc9oS9rCN4ZnbwbLwFxpXXJC8udSicnn27R5fD2jdlWfsGfTusrOHaY5ILv43EuR/zNxqE/Cn5v1KMjgZqeo8sGUA5f2KDntVpI/d80jdDj19YaZ6sqYdFwQQqQUD3BwC0XI++eu5Kkqe/wECUrxbTJ03Gk0rEVMe0U8DP2kDsKGWfsr3fw8ODNRYwqhzqr3Ku8aHbLU6rjm2i1qLZLBNxGsr6gIApIl9YbOuV9jR16sLO9jPhwvqymWYdlZ3kT+XFh2jxnvUivCKx3MYyTGl+4jE8dwflv4mZ19+iB3cP7gr8eAs0C5mqc0R9bBrg25KNP32tZu8dluPgz+uS/lMv/PM/MaFJdkI4hGZl9rtnhOEp0fmJYIwb7T1bck9fPRHtrFw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261021135927099003)(261021121427099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(7146999003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+SaKRIp5oXLvX6cBfz7bpVkIhsBrNwGng26LcDqhyyHmy7vpM7+XtjV/KDgx?=
 =?us-ascii?Q?muA88/tEiz8BjAl8bUkBlB+hUpnlulVQ9ai7AehSBvAupGXvEQ0ySDzKNKSK?=
 =?us-ascii?Q?zJOZBWpX3QFzN6P9lcmX8fJJOrx2+DUvn5s4zoE+nUQoqBhY8b2au6Zbl9ks?=
 =?us-ascii?Q?/pycjh+4/n8TEDdL48adHOBVmIh2sKyoEaJSUxcDgpdY353chpto565q31yv?=
 =?us-ascii?Q?9Eq7tCxYKok2VT8g0sHRlAlrVdXyum9yd/wwdo8oudBL3D5EN7KwBL87hvlL?=
 =?us-ascii?Q?0es6Wq6wgBN0JUzVYnpyyJZmVFJLA1Vco/fBAOOci7bZgGu4LqfhFECtL8dh?=
 =?us-ascii?Q?evSpdNxjpRoK8QT5tSvgYawkJb8omG/xRNQLYYCw3ea9r2HF7DXhXTBNUPFk?=
 =?us-ascii?Q?TTaa1C6QFvyNPjCsraiiOknKmF/Z5ojyysd286zEGURPWiE3bJ27tl0T1RpD?=
 =?us-ascii?Q?5JCFzsJWFR3sSw7I4qbu3l3CX18jNU5+g4Z06b57YNUHFsd0s8yYk4Oh7dUr?=
 =?us-ascii?Q?C5/Brcqbb7NeCb0tNO+LsUHoGuQKbZUUOgr8m4+butY1GiPho7Mydp0c0G4D?=
 =?us-ascii?Q?1sLPl2+diR7sC82PAMKXhAZRG85MHYkIbKiITqZk3PIaJhN8LcGBpsbGVaa8?=
 =?us-ascii?Q?dxa2y2Lzp/G+PcEUWl4/69D5y0noYbnvMfv4VEBuauzs16mBYgN4eo80xC8y?=
 =?us-ascii?Q?jytYAS4TCU1HIlQ5t8WtDTYu6InPp4Pb1x39ZvQpKyENcp7RirlZ2SM6oaPu?=
 =?us-ascii?Q?QUjPoMHbnibLJRaypeH+ZorwBLP66MmfPayPJJszJkX2meDqfB4LQCgM5IoW?=
 =?us-ascii?Q?0oEDG7Ehxmh3A5EBgpJgNaBdLosk77UYFyhFn8etzMPYIBrkcWL5a9pUPUWm?=
 =?us-ascii?Q?o7AHqU/lTVktZyKBQpaX+se0IacEUYAIY6KH3O3GewtiKlcVHXkTrU6gh7WU?=
 =?us-ascii?Q?sOb/64tu77BG3qmiVH/R01fe+LYR46eWH8nkhFvZzs9V5GVNQdLvnjW+DFFj?=
 =?us-ascii?Q?3wKhenKLkpqC8N7vk/yibJfZHjHr7QRIC+OgvSRlDQWtK86IJQN35hxBGb4b?=
 =?us-ascii?Q?9zqN/I06hBtl7RJylazna405z248nO5uOqkRDnJgAiEHRtnXUDnpoXcWF1WT?=
 =?us-ascii?Q?Yu4V9xqtc5AglY7QP48PPPnCK9TDSOsnnfdX67ex/JljN2bsXGXYD4RWP2sQ?=
 =?us-ascii?Q?aDOawkqwNJXkj+ap17UATY65ZHEf3AYUtt27hKrg76l+hhwhmNwFkdmhla4a?=
 =?us-ascii?Q?uoyPBzI7fZFMXfo9BPQNl8gmzRv6rZ0zrlyf/vpyqXeAytHUBJP8IgYqhfP8?=
 =?us-ascii?Q?IYuqE5cedS9Yh5vzmVjKZyI79wdQxjaa1WXS8SqF8pLZFKZ2PbP+NCvLFbmq?=
 =?us-ascii?Q?28bsdFN3bnOJ5dVWaYqt6dTH4+84cACtkOn0eqWEkYWA9hsWMAKDg7GJq48T?=
 =?us-ascii?Q?A31QKf1oVKEoGx1SDOoGSlAdrBK2NEf68f6bI2s8Z7JD/aQlHbA4xhT+9/vj?=
 =?us-ascii?Q?ARayDZmE/C6nNCJ3l51i9U/xtlK0HDcuS38yM+NdVSe0K+Cce6RT6Wgx/Hol?=
 =?us-ascii?Q?7LR0Pqn2EBGvDd1/VEzSAXPmnI+ayN1SNMrHHuMConWf5SL8E6TzImJjHDGF?=
 =?us-ascii?Q?13PP+s5lLVbpdxFniJwo2yjRyIxAOCdUH43CoH2CMkcrl4JHJ8qHkLIBn1/R?=
 =?us-ascii?Q?6sUD0tqprftoWG1zuTJrzq1h6PlynUEQbt6aKzck6dR6iFKF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PPF0966F22FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3793a5-c742-4877-9e05-08df370a1366
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 04:47:32.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXZybXJRRpqtESDh3qO7S/zP5id4G6m0ANltDKfNbx/moM73wpDEeGIaNnuAvtfvYqUotI4ZnWZookPALlJ8sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR21MB4863

> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Thursday, October 29, 2026 3:54 PM
>  ...
> + Suzuki
>  ...
> > +static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res
> *res)
> > +{
> > +	guard(spinlock_irqsave)(&uuid_hc_lock);
> > +
> > +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> > +	uuid_hc.gprs[0] =3D ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> > +
> > +	if (rsi_host_call(__pa_symbol(&uuid_hc)) !=3D RSI_SUCCESS) {
> > +		res->a0 =3D SMCCC_RET_NOT_SUPPORTED;
> > +		return;
> > +	}
> > +
> > +	res->a0 =3D uuid_hc.gprs[0];
> > +	res->a1 =3D uuid_hc.gprs[1];
> > +	res->a2 =3D uuid_hc.gprs[2];
> > +	res->a3 =3D uuid_hc.gprs[3];
> > +}
> > +#endif
> > +
> >  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
> >  {
> >  	struct arm_smccc_res res =3D {};
> >  	uuid_t uuid;
> >
> > -
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC
> _ID, &res);
> > +#ifdef CONFIG_ARM64
> > +	if (is_realm_world())
> > +		arm_smccc_realm_get_hypervisor_uuid(&res);
> > +	else
> > +#endif
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC
> _ID,
> > +				     &res);
>=20
> Is this meant to be generic? I'm not sure the trick to pass
> ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID in gprs[0] and forward it to
> the host is a documented ABI. I think it even confuses other realm guests
> that don't expect this (e.g. kvm_init_hyp_services()).

Hi Catalin,
Regarding the concern about passing ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
In gprs and forwarding it to the host via an RSI Host Call: if I read the c=
ode correctly,
this pattern actually aligns seamlessly with the current KVM host-side
implementation for ARM CCA (e.g., in the v16 patchset [1]).

In arch/arm64/kvm/rmi-exit.c, when a Realm guest triggers an
RMI_EXIT_HOST_CALL, KVM intercepts it and invokes rec_exit_hvc():

case RMI_EXIT_HOST_CALL:
	rec_exit_hvc(vcpu);
	kvm_make_request(KVM_REQ_RMI, vcpu);
	return ARM_EXCEPTION_TRAP;

Inside rec_exit_hvc(), KVM copies the GPRs from the rec run structure
into the vCPU registers and explicitly emulates a standard HVC
exception by populating esr_el2:

static void rec_exit_hvc(struct kvm_vcpu *vcpu)
{
        struct realm_rec *rec =3D &vcpu->arch.rec;
        int i;

        for (i =3D 0; i < REC_RUN_GPRS; i++)
                vcpu_set_reg(vcpu, i, rec->run->exit.gprs[i]);

        vcpu->arch.fault.esr_el2 =3D (ESR_ELx_EC_HVC64 << ESR_ELx_EC_SHIFT)=
 |
                                     ESR_ELx_IL;
}=20

After doing so, it returns ARM_EXCEPTION_TRAP, causing KVM's generic
exception handling loop (kvm_arch_vcpu_ioctl_run() -> handle_exit()) to
route it straight into the standard handle_hvc() ->
kvm_smccc_call_handler() path.

Because KVM deliberately unpacks the RSI Host Call structure and pushes
it down the traditional non-CVM HVC servicing pipeline, the guest passing
standard SMCCC Function IDs inside the gprs array of an RSI Host Call is
exactly how the host expects to handle hypervisor services. It shouldn't
break or confuse other standard realm implementations since this exact
emulation block translates the RSI exception back into a generic HVC
abstraction for the hypervisor layer.
=20
> I thought realms should stick to the RSI interface and not try to guess
> the host hypervisor. But if you do need this, a better fit would be in
> hyperv_detect_via_smccc() (if realms don't boot with ACPI).
>=20
> I'll leave it to Sudeep or Suzuki to comment further.
>=20
> --
> Catalin

As I described above, this patch from Kameron should work fine.

BTW, as Kameron mentioned in another reply, he better organized the
code by moving the code in this patch into
arch/arm64/hyperv/mshyperv.c: hyperv_detect_via_smccc().
(technically, IMO this change is unnecessary)

Thanks,
Dexuan

[1] https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16
[2] https://lore.kernel.org/all/20261031001412.4150488-3-kameroncarr@linux.=
microsoft.com/
