Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479396;
	b=Vcu+0CgdVas3GWl5Fz/9Dg7jSP58/3mZEyZEcHq7KufrLeGwo3LjqDWBvhoeWjTpG/Dl
	 GLAJSGLdFKG6RfvxQmFi8+aqzhcojXLP49A3kOFG40Eds22ker1HWndSc8Ex3sQWJf3vX
	 Ko2jf9XB3Zb854UmiKNMCqFFTVvJzVvLK3Rr42KfppoDBAJnhuComABpgxO2qfcwNHrA5
	 3G917gphmJ/0VXp/+iZLLMNI06RHIB2Fm/YWP186AYlqT+r03rkStqznG5kr+hbo3rwmr
	 sh/weN543YCGSHsUOYUdm/Y9wRT/p3RZ7OfKPLjeZOIVJwC0pHgvlgE0U6weCATBPsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479396;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NmlzWjICjdX0r+qlezbTOwaS4JEHp4CnT+VggAtvTq4=;
	b=jhm6fhJ8fguJjZ2gnQKkSvbZO6mz+QDWi+giex7i29hpeLLgBZNQe9+aQk9QPvCcWhJL
	 8jPKc4KCWT8WQvNdf8GyxOxLNkrwzsordO1jdFVshMJB8shqSJHxSEMs1AnB3CeZapqmY
	 GityRSy+DW5m5Vi061ZCRjQBogjtM4DaYTvTzQNVPTVJzX4Gz7wmOmxfNhC4zQoxoDZZw
	 DkBd2C/ShaSiadYuDTS8G/J9bAKzpT+G8RwErv4Q30OUqa8tXrRV49eYPTbCMEhi3fQGS
	 tc4y7EyFGc1pUOeZErCrJnTSonhVhFYgqICh5WbvoKkandJdmAzJ6l1X9jbBrxQtRQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=vMtGokmV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.17
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010017.outbound.protection.outlook.com [52.103.20.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0ED606A321;
	Tue, 24 Nov 2026 00:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A0ED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=vMtGokmV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT72CLURF5Jg+ip1Qlovd+3uE4BIjOgAPJn8gX273SFjj4JSUsPhbV5hWBaPya8aQOyen6NNfHLJH+Uwou4szIqS16DpS8qz1GngmZgmvGDjyZQ8v3SnsN2k/N0/+hoPLxE7FBz41e3RCdb/7xvfbc8WnktOT3NkLLNlbh7gaCfOwW/SaHRdT6hCrweb6rq3rsD5sEhd6be9astoXiCb7edeSD8LoGMUcZsXwer7BfeBqmYCQsHpqShQSQvEYGPKQuyzDuFdHwLJlKnwWnXCM4CS1SIHOEGXUb1qE/MByiJruh9WZC9q4LrW0q1zZLmSq5J5vp3mYnveLc4ix9UB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmlzWjICjdX0r+qlezbTOwaS4JEHp4CnT+VggAtvTq4=;
 b=s3lvhJlP9HXPyOQuV9wi5Wnz5nRhRy0GECtIaY2NfxzRH0uPZJWfQdXZGvD96J48Ai2dkhQsnkdAqFoTvzIHV7487p4lvWCMljeMM7WF3VnGUXfyla+FyAYcZHbxhY1B22ytPi/TQ293M4agf3C9GDoTyrpP5oeKgHtPLmC80FsA+C+X5at+7/iej67zXwO5ggiocCSflTlU2Gm6LBjBGrtcBQR0yE5Hc2fnbqTaxCkBA76y7mOrMREFXs6JL6x3BYQSHS+kvub83fdh3ypTBfA1xzwbcbas8Jhjde0rTYrfmVZjE6WAzZWTAnDlcSzv8zVBASaEE1hlGSLu1/1LoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlzWjICjdX0r+qlezbTOwaS4JEHp4CnT+VggAtvTq4=;
 b=vMtGokmVcHS7+55Xwwxl3wtqq8Pu+ReDRdtlRqxT2LXE3H0oGCtepYEnBomvBl8m4fV408mSQqGzyHNOXfjspuxRXVXrGIbr0saXnwAgC2K636uJIURzd4gVwR23aPDmlOlBXrIx+XMrfDPDDhBvFj56ibH65+CoYwz59IFtr7jRESgx1qniFYWak3XQSn0S5tzBXXxKfibIGU0byfcUQLGKPGYrSSxwfdp/VRcpgoMouq+23+wZ+eF9HzZ6zyFwDYFXRP6w4GUiQ9posDFDFf3Z4lkqXFmRiVz+aRxxdnz4H3aJgR2kypd9o691MvziKrktsoLxTeYBKmyC3RD7sw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA4PR02MB349042.namprd02.prod.outlook.com (2603:10b6:207:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:16:33 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:16:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "zhouchuyi@bytedance.com"
	<zhouchuyi@bytedance.com>, "houwenlong.hwl@antgroup.com"
	<houwenlong.hwl@antgroup.com>, "qq570070308@gmail.com"
	<qq570070308@gmail.com>, "bastien.curutchet@bootlin.com"
	<bastien.curutchet@bootlin.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "jgross@suse.com" <jgross@suse.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and
 ASID transitions
Thread-Topic: [PATCH v2 3/5] x86/hyperv: Use native callbacks for trimming and
 ASID transitions
Thread-Index: AQHddnQ3HT/Qa1jABkW3CW1Fxm9bUbc8ZTUQ
Date: Tue, 24 Nov 2026 00:16:33 +0000
Message-ID:
 <MN2PR02MB6863881EE9A8C2A04604652DD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-4-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA4PR02MB349042:EE_
x-ms-office365-filtering-correlation-id: 8ebdfa67-6cdb-4a29-7cd3-08df49c0325d
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOpTtriCxvJqT5sF95cP1zAF+ZvOdJlQttRelLjrIUQRoHa8w89SYCLJONkP53NJZ617ukQGwd0nxc5DEiJVcw893TqjpG4DWmHCdYUHS9VwIbzecfnMZ+DKSgKmsK5vYEE2s7iAljQSzIHrWLIsyEDcbJgnr49w5PmtTGRjlGyZ/2yFObJjINYoiw6JK4DC9gflGFGDM8dgbRr2PWV7sDyDTLAU38llvfIAIguiIwUc5lHx+goOr7aaLHI16mo5E+8wA8WRGmwfuJZ26LVj+wft9/S7wsE18i/VbfSmpszmE66h1HNHVgJ9TOcEuqJ6xnsJ7cv1qW0DbArUlRgP0WM/bTPtr8JEGvavq4abaEpYykKP+Gm7sN5AJtWDyeEzL1SMEa4FyCrGtaaCw+Heo7nMtrxtHWaEZ2OCIzuUR8c7nkfGBDx2pn4eZIW6qmqSzEikOh32Mo7SwAjMYspHnc2dXgHynyi5Ay3Hzkr6y4ebiryqeqRXagrmWq/0Rm6OGgm09RtSaDqDE6hP+PHA73ipbPk2G0Ogritd8jZY3VAqXe5QT8mKUb6w0yWDal0hVa0TV+Hq6W+zj7YwGtkEiD0sZuTz20EVOmfJ6iGbfZ0z3MtxN2jiLR+tZDlXpo3fRoYatgvHELNRQFHbPRzYmGW/yrzxi4To31ivUHIotCogxDWvQVYJjww1JZrmWclRUyT9cY7K+RBeCuQjAM4RPnk2du9Mm9BrmefzL80ZFlsds=
x-microsoft-antispam:
 BCL:0;ARA:14566002|16051099003|24021099003|55001999006|12121999013|13091999003|25010399006|51005399006|15080799012|8062599012|8060799015|19110799012|37011999003|31061999003|12091999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bcx7CTukNZirb9sWWUafBn3SBj15dtbwtj2wOyyV+iz8b4V3yIHXvLmKN12q?=
 =?us-ascii?Q?/N5AjSu55vKGTXbw0uAh6DNgsBCK2Hfl1tYDIHUmqOrQycjlOj3mSQLMRvzU?=
 =?us-ascii?Q?fy0rI1sv6UvOqlhrZ/Z1hRKUpdhKDg+/1jq+RioVTaeFpq01FKlXTIj72PL7?=
 =?us-ascii?Q?er1k6jJNWUWD7BbMDXECTCi4jH1ro0MY8v2YqjQT0eHvRqQgua40bwa2sm7X?=
 =?us-ascii?Q?1PLmYKIDBn1iHzTGfWk+k+gc6HtBr6fI75dktBJxZDQQ0QBud0Hvtk8u9fmg?=
 =?us-ascii?Q?eLcFdqLENKnjz+JtIbDmnx4A3CE3rg9zn8wO2vPzYZivESE6ryL+tYZ4Qy+s?=
 =?us-ascii?Q?W9unEQLBlPkGdo28pBt0RMh69zkdyYOGbRrdSQ/FDA8i9s/lgVXryXB6nTGR?=
 =?us-ascii?Q?pb3gpCZQdm5/CEvfTM1qcnyz6oP/v0DZvWohUEDSnm0KKDCUE0qlfuEJ7pDY?=
 =?us-ascii?Q?KCufdo0J0OoxQoalZUFI/svjL5t3imdkSpIapqXOutqA/Bw67ohOAReXNwGq?=
 =?us-ascii?Q?yUuygFeYY7SCMfVwiW5BO6wAs1KjAsxddvmQdJjYjIPRKnjIe49WPVQgFQCi?=
 =?us-ascii?Q?VXIzBXzFjixdNyKofRd02j8SB+ig2/KXC5FXuu1hn/Zcgv+EKrSczLjMex66?=
 =?us-ascii?Q?2wLL9N7Ejj6ozPuFCFkIt4AQXwniiiZghE6i23oQ/OqTej+qCCZtnPqRMPOW?=
 =?us-ascii?Q?KZzP2KBriaU993/H+7ppTyAWtKyxi5QSN3t6k51KW0bZj3eFyT4K0U5wFuui?=
 =?us-ascii?Q?9rEIKDPJKeMtRVS9TGrxCJJ4Ew85WVxRVpW0OTjucywHWVgwkKp0Ci7ATsju?=
 =?us-ascii?Q?UKxIDtXjUOEwAhlc61dbxMc3F/lxJVZoB0aZ2W891Dt9fWScv5Agp0uVZA6O?=
 =?us-ascii?Q?KUHGatUuayqOId+FtYiIZaKTqqK1zKCbV09lj1vzzj6U/qu1gGKCNDdyOw3K?=
 =?us-ascii?Q?vyOlgnNj1sWOhKedLdLhiI+2hNv0cOgcsoT0uWT8IcTA+c+HQJQg06oDlom+?=
 =?us-ascii?Q?ySadC8RmdbEzm60dFuxnnGxx6xFB7iZzq2PgfF2Cm8OqrYaksr8dAc8xEAb1?=
 =?us-ascii?Q?iFHFsna/FSn5F1wu3Y8pKBUe1klsvoH7jL6NmfpRRw4Zy2ZLyln3/vxCIRtN?=
 =?us-ascii?Q?al8LA/Wn/wP3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O8ZnVNV3LMGw0TNtPc9ixbQla+Z1KmQbjL0opEW0QPjKr21P9J8pDfcsjl2B?=
 =?us-ascii?Q?6/XF/ohZtOELtW/WZUqeq07kxatbwsDDTOP32vFy5sawc7qp8zn5Vx87qYtZ?=
 =?us-ascii?Q?ktDW9gR+cnzhz7eIUC8FbygWd8o36n8IjW4vWE8bFbGD3TxFfpV5R1/4pUkl?=
 =?us-ascii?Q?Dg7mJt7DJ8NkTEnvHHpOTYThXO/SHDu0soKXze2Ikx3kY5aRs1lusWWX7wt0?=
 =?us-ascii?Q?eFOWEWrBfiRSeZ28uL/wgL1lD7QON1xYHQOq+jb+2MRs9iC3D//Ah47eC19Q?=
 =?us-ascii?Q?ci//93HpqpbG5R5OufOwG/0+otxOgqiq2XPE3qSGB5F00fYDdjggHeGztGD8?=
 =?us-ascii?Q?h+1ywaK7kYzaoUK0b4DeAeNTv5bcI+aisIYCMFqEbE0QHdBwjgN/nv3pfy9k?=
 =?us-ascii?Q?ynf66nDKKF+pBjbCuyA2AFw/cG/0laHQMxu0kz+ZJNu4Vp+Gh26slhyOXtwT?=
 =?us-ascii?Q?vgzRO9Gd6yspIn5moesbvHYAWN5HTZlthdtPyTCwiMo3SvDtYCDMic/DIFnr?=
 =?us-ascii?Q?TfE8xvGuayI2Y5NUVsxJeIXv3wKrMRNw/gp0/m79iwB+SReOMwWvD9fye055?=
 =?us-ascii?Q?LqpEV1n1hZCDfxQbascYAeNTucej9ORaP9RitK/XqNdmbEN5VmZBzHeuRN1B?=
 =?us-ascii?Q?Y1HBlJLNam498dWzPBHLq9l0TH2e8Q/JlWivUaho4L6T4auSjI3wyEc6Vv9t?=
 =?us-ascii?Q?AYiYqg7Q7/zFXZy9jR5Mpz6OWjlCXnY8e4If/EgKD1zwmG3ODQMLnPpAva/p?=
 =?us-ascii?Q?nKe/PRif+87OHYk2dUJYYP1QmpXhH7bZkSOelZYZwst05un7A4MWuKeuirDc?=
 =?us-ascii?Q?Zf8dawCbXcheTbN7ZnCXBfpKRwoKoNW8SH0OusHasOJIjxLImGy75j/lziaG?=
 =?us-ascii?Q?XLCJRqTrA9C3A25skntJGJNknZV0S40m9V2bkIJ+Mr/Zbf49sezA7L5h2qJh?=
 =?us-ascii?Q?2KqnPJBGnU339uRHPkQb78p0pfFzAm4dYRxBALZp/WJgAo4XRdwa/eFrlYwi?=
 =?us-ascii?Q?MXXlccAAToYpbmHP+l2mZU9+QjMFwuOue1IqS1NUIbG4sV6SpJsLogveSEYI?=
 =?us-ascii?Q?WQDOAjVuq0Ct9ALSIQbVfNm5gdZ/phprF5+bJ6kAbiLkAhkDkPoP2pVXqfHp?=
 =?us-ascii?Q?xHxSaN0UvNqfADRA0WuccFFUGCj0KswFmfCm7jfKH366gE7dLWDLtQQoGr32?=
 =?us-ascii?Q?TSQ3Pcl6Yi5gcXS7wyvLH+nvYU33/ECnyLzrmFz9JDADbDIJsqQFOS9q5+st?=
 =?us-ascii?Q?R4IqhMdJz0keY2kKlfKfcXg3M+vWTmyA8CkBZuAK8JH2S96HSYV3xagz3tSH?=
 =?us-ascii?Q?Jm573gIjy49+jY2b+Caj1p8eFOY8osy0XG2QmKwIlIr4Ucz1RFLx1YYXyU5q?=
 =?us-ascii?Q?8tA8TuU=3D?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebdfa67-6cdb-4a29-7cd3-08df49c0325d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:16:33.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR02MB349042

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
>=20
> Successful Hyper-V flush hypercalls do not run the guest callbacks that

How should I interpret the "Successful" qualifier on this statement? It see=
ms
a bit spurious since unsuccessful flush hypercalls don't run the callbacks
either. But maybe there's something I'm not understanding ....

Michael

> remove stale CPU-mask entries. Use the native flush path when the common
> x86 code requests trimming.
>=20
> Global ASID transitions also need these callbacks.
> finish_asid_transition() requests a flush so that CPUs still using local
> ASIDs switch to the global ASID through flush_tlb_func(). Use the native
> path for these requests too, without filtering the supplied CPU mask.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 1ea57d642faa4..375f23b157ab3 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -70,6 +70,14 @@ static void hyperv_flush_tlb_multi(const struct cpumas=
k *cpus,
>  	if (!hv_hypercall_pg)
>  		goto do_native;
>=20
> +	/*
> +	 * Trimming needs callbacks on stale members. Global ASID transitions
> +	 * need callbacks to switch CPUs still using local ASIDs. A Hyper-V
> +	 * flush hypercall does neither.
> +	 */
> +	if (info->trim_cpumask || mm_in_asid_transition(info->mm))
> +		goto do_native;
> +
>  	local_irq_save(flags);
>=20
>  	flush =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> --
> 2.43.0
>=20

