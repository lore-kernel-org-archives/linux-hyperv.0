Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793328000;
	b=pOIxDpLg5VavQfso6RehDUR/Hirf1+DiKk4fy9QOLDc8I0neoRO3OlkbaW2VCDUmm6u0
	 KitfPVm1X1gFFJDb9nfTFBq7RG5V2goDygy/5ESugp2NimYG/6ujaFUsXPN4wUfDwSFXC
	 6rDKOyfTJr8F8EG7x8x8mLAMuC+XS9+tJU7tHBPB634fv3HDpGib85Jbzflv2sOJH6BB2
	 KdHH4EhkRgRySlfoIAq5bl9Rxy0I2fEivpT+VVynUJTiFeiyBaFu93O0kTPvod8afB9GB
	 Kpal6bvvb0l1wD6s/Q1dN1d2SF4Xr3zUYLSwc8TUH5+ijLB2TR7AeD60kgVwTH4qXfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328000;
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
	bh=s3/78W8nLX/o5oQpV8JnLq8z8GIzUpZzdUrgdF3yQ8s=;
	b=zkyEjrujBnhM/qpEGboGiZNMEwOvmAesk+DAsORJGAfWkKnbLgIaozqvlxR3M35TJ50p
	 zwrjKzEkDxyhpwn1IIp1m6oxpb7MOda8JdwIS+Y+Ow7DDLQWqvPMdF8JbZ4/mHjJ3scl7
	 4MwOOPy6+402Cd2TNWH6az9sKCZsZdNktUD8/5lMmCl7BPo/i8BvGNnNyAQQ3VfV0Mf8+
	 RnhE05Ew0rhG2jgN5jOxvBpVQ3vie5cmReRB12kQC29NNC5FTjnj76V6PEtktdVCC1G7O
	 BK6B9Vs4/Auq+maorYglpTn1yOmUxmhjuHr81sC2AUc49ZPoXcm+wyZG/Bq1sPzt6eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=P67ZiEWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F04606A31C;
	Fri, 30 Oct 2026 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=P67ZiEWb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOuQ6q0z5V9tpxUV645tqGk88MpCc68/aydR5wA7jucUhCYLL9bZkGqTSzAtkPG7n2Rzc+xgUJZ5kNls1bIPpi132Wac3wbEtBykN43FnMxQeQbSgq+1FpQe8Tqz71uwAu7TdRdsi/zJb4TwfbNB8qvNVE6vm0VwfI49SoFJt34EzcGUGMIZW0PkN6aNVfGAKMfUkerSbhd8P/55M7nYgTxJTHRNzZBHMjcbmw0BWvfnXrNS2vCwcB79lrTGfafm6VYmKTs79ifUNvlFFUC7PjVYnUPzoiPp6mS2KOdAfKm5VZGd+k9jg9dGDM8o/KvIrDl5QDLSDITQRXcyicUFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3/78W8nLX/o5oQpV8JnLq8z8GIzUpZzdUrgdF3yQ8s=;
 b=SbbX4i21ZZPdsSlyS9CQnK5Gw2NPqsv0XU5qf1+7rzU5r7JHvg3aZT65KyoesFOCbGa9IFVIBDxU7BUuy2GjWdwkeRaKjUupj+9rm12UjKtsFkjxqLPJnzXLn0nGaFnzpU7G1JxoK/ts5PmeXu+BJHRjV3a2GJfiM55WMt+QjncOczSsdJXavOYcqJRRKYvAGYKeB2NLjFXFhF24vb3edzbwjLeb258qRY4uraewBzI4ysw6bUDPamiTg1MqN3sXaNJUe969M9rR9Sj5XyJC6LNy1eR85tnwSYKyQxF1LlhvuRbBvg1EZQEz84toS2vUZpx2aFv0E2NFQ96chZjlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3/78W8nLX/o5oQpV8JnLq8z8GIzUpZzdUrgdF3yQ8s=;
 b=P67ZiEWbaFHzOhC8TwjOvZ9Z/XUuy6pLftjrAOqwfJKrfw9D4Ml61ZQJqO2tKi6Q+Yl6V5yqYoCan8x+qXuZYXdQ7UBvGUPqWTBORh9tBzW0uGVmGYI0PJIDbnkY7Ddunbg5mj/ihgaqFOyJI+FwhTMplK5Ed3obIMWud5s5em75aQCplVzYwd5d+L+ZWctv+s35OcnQM9CJIuPiHud+7T+NFmbxkk3fiJ33seDDSssc+imr7yq8S6K7ANRoGVW5Fjwu1sqOxfVPmas+XpI5J8zmafMBNs3F6I9hW7hriBjNATRzdGvmmpsDi+s0EzrpPLJ10oqqROV27osyXfYrHQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SA0PR02MB7210.namprd02.prod.outlook.com (2603:10b6:806:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:39:55 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 02:39:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Account for lazy mm_cpumask maintenance
Thread-Topic: [PATCH] x86/hyperv: Account for lazy mm_cpumask maintenance
Thread-Index: AQHdZ3C2Be7Y2HjmoE+0hlCk1ld9dbcVYQBg
Date: Fri, 30 Oct 2026 02:39:55 +0000
Message-ID:
 <MN2PR02MB686397041FA339BEC423FBB3D46D2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261029064234.362385-1-namjain@linux.microsoft.com>
In-Reply-To: <20261029064234.362385-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SA0PR02MB7210:EE_
x-ms-office365-filtering-correlation-id: c7773c8b-823a-4214-5271-08df362f150d
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOdJvhEM5X11ZPKjwoWdHCGEIMfIEbHIIHy4PbNqgagq/p+8XQQyPAyYIOCMcJPdZ/njDXXUkvJwc/YWzQquk39nWpf41AYAopHwUYFAX04ahkRDgQUiHpFw4d9dYOzx+QV0P4pZWbzsgUtgK2PL6CX/+FnXYVzI1prhuBezP7w/F0HHbXCcs4JvbEBdCR4FZmlBzifakhdXOTSIlkMcL/W2RFv8J0FGyBTQF6OCY+kW+Ggbb2PWCQFyVLMnB0rWRcpCmxDALtwRrxs1WeeZDRhRltqwsloXOTnLqqazeIlHH2+iChujth5wy6ewTFESuXb9FKCD6umzOBmSebbZtKZwlimX86CMULAOAFeA14fPbLbo+TOuYRT/0cMgxW8GsXGcA7MlhijZBZCmFbCBvO1L4ywS31xzNutjjUlcY6FjBl9LMix1jwZA+TyiBnTwCVBRAKRHPxMQonl9AOBKNFwn+L3A7gmk5WwmUaRviuCMrILHvWVx4JFhV4nrkfZbjqOSuTE38vKo29J8Q9O7s98YnSUz6l0mBYRYdnTyhcbpoX1mQKsGPWv4L/nmqXSUHObvdhwJR6Dhw0Z7THMfPRuh/VQP2zZvgkKjIza4u6pofUwdOapcbT8AqCDXicLlzykQB4HlH3euy9b2RniVRzUaqgHUu7It9F5x2Dp3JxKDp+kpnmp28UHPzmZ2uQKq1Fxihnl/wwwWkWut3T2UtFZeUHZ26Wzrh14FSqXMwsqwU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|11091999009|21061999006|41001999006|37011999003|51005399006|19110799012|25010399006|12121999013|8060799015|8062599012|13091999003|31061999003|55001999006|24021099003|102099032|440099028|3412199025|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YKROsxC9Nu9GCo6J32lf8VP8xbtbx0pO2Dr+HU3VdZIbZpqqk9KgtC7wNYby?=
 =?us-ascii?Q?LS3MmLGxZOBtNz0oyV3LYxtEh3yaFOxfFxb4ZGo7GzNrBSVEsmZCD9ShsIZk?=
 =?us-ascii?Q?fviQzvzQcShSWtv+gmeOcMFbGi4ikrzRxS2nCC2thb0zBkwM/MTYohpgx21g?=
 =?us-ascii?Q?qpuPLOwILVvC0/DnGMOvx/TdrsCWnN3irZBN4VnxYGn8r9HGPQdIGyQw0Ys8?=
 =?us-ascii?Q?fZ0rCWSBfm8w6zmQ/IVu0XebT2ItJHftKP9hTaKDtRiEacJ39llHOAMdu9Vw?=
 =?us-ascii?Q?awgD5xtIwPymVxZugWczTszrb4sTHghyu8Z5yz+1XP54BnxhY5bkT4tGrD3W?=
 =?us-ascii?Q?r3AhImmjN9J2CTRZrVVKZJvyH8MUpkUxLaqzF2zgL8xg2apv+/lpddw9qIDX?=
 =?us-ascii?Q?zQx1Axgt2/+EXqhW5DSYyAkq9HuejlVqnArllfU9QySVQv2BlgLyN96l5ZCa?=
 =?us-ascii?Q?6n9BNPTPLRBHlG6U8+ptEp9C3FDJNQ9p2l5snXLTBjrO7QIK+AftXxp1aYd+?=
 =?us-ascii?Q?kj3Yc+PF/5ECn1mQr6HP4+LrFdGcDU+3LZAs5gyccKTKZ10WqFwIm37Q45ii?=
 =?us-ascii?Q?MrHvJAdy8GdYv5kIgAHsCi3tuT0nPm4FzDFHTpgUvzTM5bLNRWM/O8doEW/6?=
 =?us-ascii?Q?aErXW/NZPSiMeSMz4E7s4LOW/iMi1DPJDT7gTjouKCCxwLeH0P5hK652Vvfo?=
 =?us-ascii?Q?nxTMazMjeHI5e3km5HxtR1KetSoyz+CzMVFBofv6eAWJQXgVyyEpsl9/DME1?=
 =?us-ascii?Q?EYiA/qb0FpUFhKAZIHGfEX+TNEyRyZMe/CdOI9zUSu+FzMV/NYG4tHkTpnWs?=
 =?us-ascii?Q?DQI9/6Xq/uEbZGKxPJQzfLW4w/pyc5IdpEy/dLfiP0ZpVdw5umJSeRsgkvkb?=
 =?us-ascii?Q?C6+9q0bFktx4DUctCS1A/5xu8o1+//awVLbC9/uyh9o1CYAaXB3EiPEvKLwT?=
 =?us-ascii?Q?WC0LXXjvGDLGNZ0mOPbipb691wE5qONqeShkpSFIbOvIEDDWQ0UDpTuvsqq5?=
 =?us-ascii?Q?yZuKviB4nQd7Z/3i8srCEwLHkV/zgO++Bql92C6qf2mslFVdeELrSYUENE0Y?=
 =?us-ascii?Q?kBjhx6xFfaPcVQC/1y3GFg8sUdbF5FiJf4lyNnJ6rApsWX7WbnTar7nd1QjI?=
 =?us-ascii?Q?3Vnq8t9BDTEH5cqRwQAEY6kixhJODCq6tfskzInkrZdBiLVYlUgKpNxQ3UAW?=
 =?us-ascii?Q?tVKoVQ3QVzCVzvH+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xc3WgY3KHEkoqXDelbJLlBt+Cg3fSNg7EzG7JCikPbZb+LnHBg7+oMsEYmCj?=
 =?us-ascii?Q?+wEyCjAM6SBNQtR7nthTxOBnV7cK7+qytUbcQlt3d+Wl0YZ+ZUd7TM2ruZpH?=
 =?us-ascii?Q?AV3aneGVmRCj6/lKIuEQV1yiNEtwdwCUsL43Z4a2/Jd7UUkM9iXHtBmRNOPp?=
 =?us-ascii?Q?u90LloubGWroL/dQFZMqqSO1KV3C9AJatTuVYif46580kmX10wSfTvREE8e6?=
 =?us-ascii?Q?ZuuR8l/IzVwq1ZLFif+P09/C454CsulcKr4lnqsTH/GRFBXbfddbSJOX07oj?=
 =?us-ascii?Q?72/Z4dBfh8qxZmz7uqo0xT8esdNoAGJ+LKbr53XOW6bK/5o7ZMzIqREk6FC3?=
 =?us-ascii?Q?vfV1YB1ANNbKokRuj63aPoOB3gYRBiDnMMoakexTT3dFMoJ7c8HRCv+iWWDX?=
 =?us-ascii?Q?tpyvmWNeHskjEye7qinW5bGg7zB6Ly55El2vm9MNaH/9WWnXPOKjqeWBxgx/?=
 =?us-ascii?Q?FvkeUT7c9v811JflHAZbpGnPFsw1qedW0WIiUgHrPohUfVeZW17yDPG9x/ms?=
 =?us-ascii?Q?5DNwT8JWE07LOp3zmrueW26BRgYsKD69B23/Ua7VCaMRJXsJKd2IPi7PHw/A?=
 =?us-ascii?Q?rxLK18sBEMWbWgTMffS1EgC0/PrydaaaV2ZFO7GQi1f+Yic8EMQKMbGGxe2c?=
 =?us-ascii?Q?iY27JJ/eRJZ6hM/eHEshpNVNVMHOucz51jd6VLXJIW6FzVbUcU4UJAmH19c3?=
 =?us-ascii?Q?IbOOZ8wb2lz958RFSEMp3RiA7MLS6U2mmhLJWRwNs7I9AqvZnr/zZPvNZ+0s?=
 =?us-ascii?Q?Q2Ckxq25TW7bmPrBUeNYLdYbYNPqzKEm3cOH1gHP9TYeXYBZXaNdnCv2vcCE?=
 =?us-ascii?Q?rg8fRY+jyjG+31HG/01topqCWToY+YYzb1ajwGmfgBnBYDn9fgPN1RheVh4W?=
 =?us-ascii?Q?CTbLW8nJu8k7d2p5+FOYhv1MvuFEr7S7XoRrmLqqki3ccUg6Qn5wEjXbo7Cy?=
 =?us-ascii?Q?GZ0qNegkcKBkAekE0hdKSWma0i6LX/B792ZbaNNlrJ3vynKn+bzCIfEdUNRG?=
 =?us-ascii?Q?i0/Rsvi+xhTDptqTT+tu/phbQbQUj9DxkWyL0YNWI0mQA/Dit8M1zYF/WN61?=
 =?us-ascii?Q?Jjjm3bW+uFg70oPdnFUJR7I3xxIOcj2hVyw6X87aMU9Ptl/g74MjOZyTZ79Z?=
 =?us-ascii?Q?JkN61SzVnzdHGRB4w7ksDXpS2IZ1P1QmPbj3mCBEXIeL1TfN35p3o+jjMrEO?=
 =?us-ascii?Q?8Yj+dqb7DH1BBp8wky0aTENSq6MHSs2ryYtFIMUZ6/uw+KNJN1XesfC5CI3Q?=
 =?us-ascii?Q?SfuPdjOTr/31RCoZSxKLqaBwUYX1p4vCQcr13RzlWEgrbQFRi9cktkrYjc9l?=
 =?us-ascii?Q?hDFb8A6HhBfNFI7CrJC1hi0EXyyNTuJX3EnbJVYMLcGLs+lohF4pYMchHzmW?=
 =?us-ascii?Q?cBZd6PU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7773c8b-823a-4214-5271-08df362f150d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 02:39:55.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7210

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, October 28,=
 2026 11:43 PM
>=20
> CPUs no longer running an mm may remain in mm_cpumask(). Hyper-V treats
> these CPUs as flush targets and bypasses the native callbacks that trim
> the mask. A single-threaded process can therefore keep issuing
> all-processor flushes after visiting all CPUs and returning to one CPU.
>=20
> Share the native target predicate and filter the mask before building
> either hypercall format or selecting HV_FLUSH_ALL_PROCESSORS. Preserve
> lazy-TLB exclusion and unfiltered page-table-freeing flushes, and use
> native callbacks for periodic trimming and ASID transitions.
>=20
> When no remote targets remain, request immediate trimming through native
> callbacks so stale memberships do not unnecessarily prevent later
> invalidations from using the local fast path. Leave lazy CPU-mask
> maintenance during context switches unchanged.
>=20
> Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

I've read the commit message but haven't yet delved into the code for
this patch. But the commit message feels like it is missing some context,
particularly with the "Fixes:" tag.

I recall the last significant change to hyperv_flush_tlb_multi(), which tak=
es
CPUs in lazy tlb mode into account, and thereby avoids unnecessary flushing
(commit 493cc07385cf, made in March 2023). It was a case where the
native x86 flush code had gotten smarter, and the Hyper-V PV flush
functions had not been updated to be smarter in the same way. Against
that context, what is the situation here? Commit 209954cbc7d0 came a
year and a half later in November 2024. Did it make things worse for the
Hyper-V PV flush functions, and hence is deemed to have "broken"
them? Or is it another native flush improvement that the Hyper-V PV
flush functions just don't take advantage of?

I'm also curious how the issue was noticed. Was there a real-world
performance problem, or is it a case of looking at the code and
noticing a native improvement that hadn't been applied to the
Hyper-V PV flush functions? The scenario of a single-threaded process
visiting all CPUs and then returning to one CPU seems contrived,
particularly as CPU counts get large. It may illustrate the improvement
that is possible, but to me seems unlikely to be how the problem was
originally noticed.

I intended to review the code carefully, but the additional context
would be helpful in doing that review.

Michael

> ---
> On a 32-vCPU Hyper-V guest, after a single-threaded process visited all
> CPUs and returned to one CPU, the reproducer's median time per iteration
> (two mprotect() calls and a write) dropped from 17.235 us to 1.622 us,
> a 90.6% reduction. This could be more on higher vCPU VMs.
>=20
>  arch/x86/hyperv/mmu.c           | 62 +++++++++++++++++++++------------
>  arch/x86/include/asm/tlbflush.h |  6 ++++
>  arch/x86/mm/tlb.c               |  8 +++--
>  3 files changed, 52 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index cfcb60468b01c..128ad3ce8c24c 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -1,6 +1,7 @@
>  #define pr_fmt(fmt)  "Hyper-V: " fmt
>=20
>  #include <linux/log2.h>
> +#include <linux/percpu.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>=20
> @@ -16,6 +17,8 @@
>  /* Each gva in gva_list encodes up to 4096 pages to flush */
>  #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
>=20
> +static DEFINE_PER_CPU(struct cpumask, hyperv_tlb_flush_mask);
> +
>  static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>  				      const struct flush_tlb_info *info);
>=20
> @@ -51,23 +54,23 @@ static inline int fill_gva_list(u64 gva_list[], int o=
ffset,
>  	return gva_n - offset;
>  }
>=20
> -static bool cpu_is_lazy(int cpu)
> -{
> -	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> -}
> -
>  static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>  				   const struct flush_tlb_info *info)
>  {
>  	int cpu, vcpu, gva_n, max_gvas;
>  	struct hv_tlb_flush *flush;
> +	struct cpumask *flush_cpus;
>  	u64 status;
>  	unsigned long flags;
> -	bool do_lazy =3D !info->freed_tables;
>=20
>  	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>=20
> -	if (!hv_hypercall_pg)
> +	/*
> +	 * Hypercalls bypass the callbacks that trim mm_cpumask() and complete
> +	 * ASID transitions.
> +	 */
> +	if (!hv_hypercall_pg || info->trim_cpumask ||
> +	    mm_in_asid_transition(info->mm))
>  		goto do_native;
>=20
>  	local_irq_save(flags);
> @@ -79,6 +82,30 @@ static void hyperv_flush_tlb_multi(const struct cpumas=
k *cpus,
>  		goto do_native;
>  	}
>=20
> +	flush_cpus =3D this_cpu_ptr(&hyperv_tlb_flush_mask);
> +	if (info->freed_tables) {
> +		cpumask_copy(flush_cpus, cpus);
> +	} else {
> +		cpumask_clear(flush_cpus);
> +		for_each_cpu(cpu, cpus) {
> +			if (cpu_needs_tlb_flush(cpu, info))
> +				__cpumask_set_cpu(cpu, flush_cpus);
> +		}
> +	}
> +
> +	/*
> +	 * An effectively local mm should not keep taking the remote path until
> +	 * the next periodic trim. Let the native callbacks prune stale bits.
> +	 */
> +	if (cpumask_any_but(flush_cpus, smp_processor_id()) >=3D nr_cpu_ids) {
> +		struct flush_tlb_info local_info =3D *info;
> +
> +		local_info.trim_cpumask =3D 1;
> +		local_irq_restore(flags);
> +		native_flush_tlb_multi(cpus, &local_info);
> +		return;
> +	}
> +
>  	if (info->mm) {
>  		/*
>  		 * AddressSpace argument must match the CR3 with PCID bits
> @@ -93,7 +120,7 @@ static void hyperv_flush_tlb_multi(const struct cpumas=
k *cpus,
>  	}
>=20
>  	flush->processor_mask =3D 0;
> -	if (cpumask_equal(cpus, cpu_present_mask)) {
> +	if (cpumask_equal(flush_cpus, cpu_present_mask)) {
>  		flush->flags |=3D HV_FLUSH_ALL_PROCESSORS;
>  	} else {
>  		/*
> @@ -107,14 +134,12 @@ static void hyperv_flush_tlb_multi(const struct cpu=
mask *cpus,
>  		 * must. We will also check all VP numbers when walking the
>  		 * supplied CPU set to remain correct in all cases.
>  		 */
> -		cpu =3D cpumask_last(cpus);
> +		cpu =3D cpumask_last(flush_cpus);
>=20
>  		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >=3D 64)
>  			goto do_ex_hypercall;
>=20
> -		for_each_cpu(cpu, cpus) {
> -			if (do_lazy && cpu_is_lazy(cpu))
> -				continue;
> +		for_each_cpu(cpu, flush_cpus) {
>  			vcpu =3D hv_cpu_number_to_vp_number(cpu);
>  			if (vcpu =3D=3D VP_INVAL) {
>  				local_irq_restore(flags);
> @@ -127,12 +152,6 @@ static void hyperv_flush_tlb_multi(const struct cpum=
ask *cpus,
>  			__set_bit(vcpu, (unsigned long *)
>  				  &flush->processor_mask);
>  		}
> -
> -		/* nothing to flush if 'processor_mask' ends up being empty */
> -		if (!flush->processor_mask) {
> -			local_irq_restore(flags);
> -			return;
> -		}
>  	}
>=20
>  	/*
> @@ -158,7 +177,7 @@ static void hyperv_flush_tlb_multi(const struct cpuma=
sk *cpus,
>  	goto check_status;
>=20
>  do_ex_hypercall:
> -	status =3D hyperv_flush_tlb_others_ex(cpus, info);
> +	status =3D hyperv_flush_tlb_others_ex(flush_cpus, info);
>=20
>  check_status:
>  	local_irq_restore(flags);
> @@ -197,9 +216,8 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>  	flush->hv_vp_set.valid_bank_mask =3D 0;
>=20
>  	flush->hv_vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> -	nr_bank =3D cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
> -			info->freed_tables ? NULL : cpu_is_lazy);
> -	if (nr_bank < 0)
> +	nr_bank =3D cpumask_to_vpset(&flush->hv_vp_set, cpus);
> +	if (nr_bank <=3D 0)
>  		return HV_STATUS_INVALID_PARAMETER;
>=20
>  	/*
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbfl=
ush.h
> index 70098d448e999..e1e05cc867d5a 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -264,6 +264,12 @@ void flush_tlb_one_kernel(unsigned long addr);
>  void flush_tlb_multi(const struct cpumask *cpumask,
>  		      const struct flush_tlb_info *info);
>=20
> +/*
> + * Do not use for filtering when freeing page tables or during global AS=
ID
> + * transitions.
> + */
> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info);
> +
>  static inline bool is_dyn_asid(u16 asid)
>  {
>  	return asid < TLB_NR_DYN_ASIDS;
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 0c4da320831cb..f2f40928d56a4 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1273,10 +1273,9 @@ static void flush_tlb_func(void *info)
>  			nr_invalidate);
>  }
>=20
> -static bool should_flush_tlb(int cpu, void *data)
> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)
>  {
>  	struct mm_struct *loaded_mm =3D per_cpu(cpu_tlbstate.loaded_mm, cpu);
> -	struct flush_tlb_info *info =3D data;
>=20
>  	/*
>  	 * Order the 'loaded_mm' and 'is_lazy' against their
> @@ -1311,6 +1310,11 @@ static bool should_flush_tlb(int cpu, void *data)
>  	return false;
>  }
>=20
> +static bool should_flush_tlb(int cpu, void *data)
> +{
> +	return cpu_needs_tlb_flush(cpu, data);
> +}
> +
>  static bool should_trim_cpumask(struct mm_struct *mm)
>  {
>  	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
> --
> 2.43.0

