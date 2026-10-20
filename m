Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792536198;
	b=XB7kr4Eepl2qGKmhZpaLJ7B1e+Z3s9a9YTyPMyTXuHnV51RFgn7H7iXl2eyoJJyeDtfa
	 sDFd3tgziGAsJ2rZZuxySlGIrFohBRkLKysYXSO1fz3nRyjbwwlC1AdLl+f9E3VTMbEAJ
	 f8WBi8ApbEd/u0SPxOGTKTSjNnE/BAtRsNTwHb+1VV7PGq471iALCjbJPXDyTkoQ4OIVW
	 vRPgIxw61jWyNgH0e4v38bmBUAriEphKpvyCLioRt9k2W8FJJ9oSXtSK45PbSnzMlD0rK
	 b4RdWWfRqDCTH9YZnnXhh21XhPUjK4T2wREFW2UBBuFsihlcDYUaRCczCJlfvAPs+IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536198;
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
	bh=pvPHe/zCamIdVj4Frx7gW/Bx2Op7Npdhr434BHUKWHY=;
	b=i5SX5seG4wuOqD8sVYIfxO+5j6txkv2VSqpCHabqHYjTBLBhjEh9BI1QZSRdL3YHTOFw
	 Itq3wk+Qs5BnTI0xKc2pABxnAoh5y6xEbXNNZO7Jlpf9g+5gyydA86Nj4VoG5IBjfU7XB
	 /abuAeGLYd6CP20ibqqKqGN9wYOhOUpwHIAcLKxx11kjN+bN1NDR280sfjUbdiyz3OEgG
	 MK5ovn+idaGK0LGgwsiTUnuNq8gnMKeR0FFo5toh2+SCkCgBBkRAIsRGHKcfOkAx+aw/m
	 esvfRVUCE18iIB5We8BLI4ihPXwcArtg/8QxYOe0KLlxfWBuie226S7KH+a98w5Mn4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rl204Ky6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.15
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011015.outbound.protection.outlook.com [52.103.1.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59B606A319;
	Tue, 20 Oct 2026 22:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A59B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rl204Ky6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5neX+2jBcJJjo4Y/PPMkcjr9OM5LOcyWQPgWg4n9MKOx+lO1alEVxcG1lB76Brm50SBrDHlUC/xJc4ILkdlVyUKviPKHnk55r8udkDvVWVzTo/dbKHzEMrkn8X7ETo8neFVNjz9P6YRuNqabnl/5zsU7+3ncp8qSFcrWJxBrfkPx3r5bjRfsPpOoWaTfjUgXfKmgP0x1pSfdO9mqX2lcAHio4hIgQaxsDpzlpWGmZgvS033bVHxj3ZD1Mg12qvdkDPRMOCpXxTUqLoYu19yAyWZjF8C82tdolNTdkDYodUE///O0ly5PhgxLuYVes6e4ykODySVNCxo3NsdR5Dzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvPHe/zCamIdVj4Frx7gW/Bx2Op7Npdhr434BHUKWHY=;
 b=d1YLoUmOefAslQD41cK49ajGjWAgouxXEBuvCcF9JW0nvbIHfo+y+x8PDNUbGZ3Yxug07a/XpuiWGTqWZ8pQDq76Tk6Tb7jt1V5lHM1gPYaMCYxd6otMWkNaUtxqnuoVd9OuNQxCgTakQLDewiSfKcOxsPsrM+QeKgyMU3LzKq77CZCR/LrEykmSdaNDvXFFNE5+3Vba/D3+MICOeP7Gka0X2g3IbOxvE/SF5b8kM/yaFq5GMCPYPOAtyU1CTT4cyPt6i7hu/q/NXn9bxqZbCSn0XFnRm5fuKDwsbOG/wMPnogQw3zt6E8r77PbqUL4BpbbEU5MyOqF27Y7RKj6WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvPHe/zCamIdVj4Frx7gW/Bx2Op7Npdhr434BHUKWHY=;
 b=Rl204Ky6z7tHXQV/+fuoWzsjlrDe4GG2j6aBaWLHRcGGwX4i3Fbiye/AK0pScWybq0QrxJXlfb14sZ6Ed+c0qix6DX/pw+pBOY1IwxddykTEGXVATgrCqsNvlZ1CAxFZxqDpX1VdLH2dxJ/sBw7Q6r8QN+tR0ZIW3DFGWuBEVjekxbjV9DoMqTCLkU37ysGuj1C4R6VoHYGendi+EisW+VQxfgM0ODsVl7nHJYKr/q5IiQeORKr5NuzH33+CsjUYE7fOtHw0DCIZyd4H1M5W40hQv0QtbhEVCJXEgStuq6T9HTyCbI2uJYFDGdmYT+0L+nD+aLTBaTGBYhKFF0xeYA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SA6PR02MB10792.namprd02.prod.outlook.com (2603:10b6:806:434::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 22:43:14 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 22:43:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Topic: [PATCH 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Thread-Index: AQKiU2Lgi+7G1r+Syuirp5hWzTTj9LV835CAgAA9bOA=
Date: Tue, 20 Oct 2026 22:43:12 +0000
Message-ID:
 <MN2PR02MB686341E9C02FDA9A7615AD4CD4672@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261020182433.336637-1-mhklinux@outlook.com>
 <sashiko-outbox-179492@kernel.org>
In-Reply-To: <sashiko-outbox-179492@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SA6PR02MB10792:EE_
x-ms-office365-filtering-correlation-id: 9d9aa633-e246-4e4b-e334-08df2efb85a9
x-ms-exchange-slblob-mailprops:
 wzZnFI/JsIjEFWbiivP8ClEfvLEOQFGzLGJYN1TOvbLbPbAr5GveGNsHGpxtojdTHOCb8jLT+6JMbAq0EDG+D5+kk9dOuILIAoKgpRlfSJZPXnzuyiINjIJObZGY1FakoqIL18zrBJNA6EZcEA/0tGQMm6R+T3Pc9Ot5018p9RdfGggzxMImwmXyHFF9c24cTxYNC2GglWA9z7T/5sRGJ7QcCApC255pn77Tw5IB0xFGcSHQ+kjHs2Sh9SivEAZf6dQTLWZs3qyhIy7HARiW8G1YraQCRVJ69Dctes2OLhbkyvHCVjVlaMMZsJuM+AdIPAwA2uTLdewyegOWtSPHsRfmO2MKTgYDNZsh1ocEALzHd4LgYjN5dKuGrpF+dyEzb0ydN3xvfOYjW3B7fFN/Yw8X71wJqS5JT9V6tw8o/mXKavgN1Pl3BVVlg5vgoUx48U6awJOBM1pl3HyKYK5ATQca0Z/q3DLI+1+783gDJPkWLEaKgR6HrMJrHd02XdjpOmaz49mYk4OdLG60Gg0bOxB/Wj+brAWnYoiW4ScPhn6hbCyNWuHsfAwnSwFjhk01aTQsKUhwO6toegQZZc8As2nDWTlmn8WFzqgb9tuRRchlqNMDuiK0BQGv37EoL0WsdcDr1YpeBj3KeC0jXqKBL+siV2XHPgOO3BNYe3CeuD9Zei452iqALujHYyYotwz9j94IQFwVctqIFGsz6A0jywazCfm0dNeC3W9DdQzgxRTwPzzVoY1r0DfxzAvkxPOnFJ7AqMWrgrIWkpXIo3tX8ko9PmR7dA0lppzoXrNUFWlYYDMkFq/mlsjWSpzkcR+ecBTovxB+fzA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|51005399006|37011999003|41001999006|13091999003|55001999006|8062599012|8060799015|19110799012|13031999006|31061999003|24021099003|25010399006|102099032|3412199025|440099028|4302099013|1602099012|12091999003|40105399003|1141799003|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UJsH00FEy/+2/80WEJcJM2MrAtkBwToRnOC49UvX20ALoeQmBMkcBunsmgQB?=
 =?us-ascii?Q?7W29guf7G1x0Rs5LWgLk7kmlD7srFqlu/jIh+tFeg1gtGermb/WZKwN0ZzfL?=
 =?us-ascii?Q?BAK75LPzk7sdlGmJzCnGoQNANc/bJShWjJ08fj02av8mWrIa8QEjKpYV79Y3?=
 =?us-ascii?Q?23hRY4Zpv/AmK7Ateu5cTu1ePh4yAPGtS28id1dB6PeSpp7y12afbKPpGqub?=
 =?us-ascii?Q?6v2eBkEKhjk6jwDB8AJL6YqLdq8ZtMBSqY+8JYfCWqXy4NsHcI4XTaxsIdEr?=
 =?us-ascii?Q?gcT/fDD/HTbR6+t/Gy2+zK4nI2ttmlrWsFsPgGJWSpsHqI9hM0HIuBVVF/QM?=
 =?us-ascii?Q?EavyWqUBDatp7MgybWbWHo7G+uaRvMpatVFNFgPUlFo1b0nLZNzsQi664Cnl?=
 =?us-ascii?Q?TurbghEcNZtxa7tS4WzadMSQmZtnvdyAStssJPeB4Taf810RIwVYo5rsZvlH?=
 =?us-ascii?Q?VslMnt/JgLNrtcydieHHwZSUHFjF5DFQYTHTrtQaTDwTrhTtqKsrowZMTtvO?=
 =?us-ascii?Q?G2B/HFJLC10+Afqa24tMlQDCMZmczWnNaHsQyB7veoj6fae0wfNCY2ZqW4TI?=
 =?us-ascii?Q?/srlr8JY8kNRPN3WCuVz7mIyBgeHVPXAC+/S6WftwSMfK8mFWru8AJmzg3Rn?=
 =?us-ascii?Q?aYbUSmGlTfNFYRiOOqkNa+Q9vreeMZvMhF8AWuAV0mie+t4oSq5wWJ2pZmvH?=
 =?us-ascii?Q?gdjfUoa75w5TwbLw+I51c/sm7PLUx5sxl0wTRiKB3oud4gZhmy49+EJePOI4?=
 =?us-ascii?Q?equ2rWLIwEMnCxQiWkDum62yRhtCzGWawCEQ03Ec4BLalVB9D9laG/hMqDOm?=
 =?us-ascii?Q?ezxIPECjVWV3mXzgR1IrNqVAteVpUFg3zFsLUBaImJ7QZRT0V2vEOEWDjz1L?=
 =?us-ascii?Q?tvcspEuqwXX+nitfh0JhNfGzVt0/ljCtK7GoQ+HjyodRw1Q1eiQIvNtuvTkC?=
 =?us-ascii?Q?tEj6BakB2fCuCQKumrgcfL2elHiCK1vC1wPGetURwsajvLkx3A5yHPqo7mLa?=
 =?us-ascii?Q?4Do+6Ok0vuZckTqCG9gs4hwXpACoYzc3bbZ9ydtlwPJ6IIrbx5cLiBVfsuZY?=
 =?us-ascii?Q?glNp9OPxcrv7ugSVVDD+V55hrkv7iEDkHR78AXaBxXE5NPrNzLeLl8+EycaI?=
 =?us-ascii?Q?vzvor6MG/Tdl+IuZKQoQkFPUPTn38vcfYluA/CB+OQ7FVWSD9GHDVxAKhTGI?=
 =?us-ascii?Q?1mrR66Vyc9TN6CPr?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xzS9OVjT/SHmOygk02lBqrxRQg4KvccNsvBBSMxX6EGJINMqASfTtEwb8dVN?=
 =?us-ascii?Q?GZcWbVzMeygYsuAHL+BOMaOA5D1iHdYxbOQPTCKVLobVsTxdHKoJrtnk6LyZ?=
 =?us-ascii?Q?WDSp0u+3N+Gwx0FUHyb0Io7eVqMQYgwjFx1LZ7JqA61FQ0s0q6Ou61LHGsO2?=
 =?us-ascii?Q?GJNelgKpFvHDLFcHaNBnvdl/V0/WMrl2XKhzpe/3tTSghZxWrQjf1v+XgwF5?=
 =?us-ascii?Q?JXjMrWud0kfenictByVXvnP5jnRGQlClx82YcOoi+KyG74KFu/I2viI4+sH4?=
 =?us-ascii?Q?jWvyz4lPhyU1EZkkAAeDGPbrUB3EtUe6nATk47bDJ/gWpyu2KbIkSatbw0VY?=
 =?us-ascii?Q?JS35GalXtxh32di9ENUBJ7LtZHvq9MY4R+XNoSBgMPk3nClNJd5A/P8dVF9n?=
 =?us-ascii?Q?vTirBafcWxuXqVBeE5vInA9VSadQHmIl5VQT8tr1aD1B1zya0bLctf7jdDY9?=
 =?us-ascii?Q?Qhk4/dNRplhamQAm1SCXlQiKRkQn4CcmqPvs7ozH6/YIjUVwHPnJOAdrHNj+?=
 =?us-ascii?Q?ITqV3zC65mfjmi9dvSLvGEZbCCl5FEHKGGdXEpqRa5YTqbPhWwGY84AhKyjl?=
 =?us-ascii?Q?Z5IsYo/+xcmdRtFp26fm28iwqSEET50IeFKNmcGHcoam2wzHA0nj7M0453Gq?=
 =?us-ascii?Q?KkSwAMMM0yipq/N0S7mLh6J8fVMdZHMeoarVhgvU0Tar3uPrRlE8PqYMocqi?=
 =?us-ascii?Q?n4sCuQ3Fa08TBmpLOuz3uO7savUbmybEdhLjnyigOAPLePR5uvV8nQh+Oezz?=
 =?us-ascii?Q?J1NK98rW5EcNKEUuTxPMvgecKi8YJ0RxNrA4j/F99FsCRSmHE8X7TxWi39FN?=
 =?us-ascii?Q?oWYq8jIi0FFqxqO12jzTPkYzbOjuIGxEDPqBP5fMd9knLY+vkr72Y/KwAYF9?=
 =?us-ascii?Q?kWKSYNOyp6X8aGThNdbKxO8Elq2GgIvlwQIGqGiksZ80wsLFUyLMHLBENw+a?=
 =?us-ascii?Q?nOP9BQAv1qiFRWS7bI4bSim0dQ4NalMgvKe3jnGKtJRc4cTn52XRnhvr30dR?=
 =?us-ascii?Q?qGMBmSi3NnSazi3/RiOz4lhO8/JbHgvJN3u/gDxwbVlD21+R7ztoySSMbkCC?=
 =?us-ascii?Q?ll2hS5Z0EEj4Ie4V4h7x9FZ2FWkhmMqv3GH3gHzVNNyMB/ifZl3RsiXUKdJZ?=
 =?us-ascii?Q?OrTk2Kgt9CS60mCl+hi9ZSm3sfMOb9Z2NlLPgwKTbPvqITf2zJnpKAZTDyGx?=
 =?us-ascii?Q?FCpBbVAVbKuVEAqhBp8oL07QTjKsjlYbXfTg7P4xH3qPIzei/cP8eW5WWIR6?=
 =?us-ascii?Q?IxU7nOmjnruaBCvkcOP9fLSWMRXRXheIy/3RyJpoDoTEOXPTvryw0OKy94c/?=
 =?us-ascii?Q?Z0gFm73MQwNgVwKj1nONEhjroHsFHZzKl92Tdeq34pdc8+mohjPIAYfdjX1P?=
 =?us-ascii?Q?0Pavf0s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9aa633-e246-4e4b-e334-08df2efb85a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 22:43:12.3924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10792

From: sashiko-bot@kernel.org <sashiko-bot@kernel.org> Sent: Tuesday, Octobe=
r 20, 2026 11:45 AM
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to
> consider:
> - [Medium] PCI: hv: early activation in hv_pci_vec_irq_domain_activate() =
skews CPU0 load

This was intentional, and in my judgment, it's OK to skew against CPU 0.
Low speed VMBus devices (i.e., not storvsc or netvsc) are assigned to CPU 0
outside of what pci-hyperv.c knows about, as is the emulated PL011 UART
for the VM serial console. Even in aggregate, these don't generate a lot of
interrupts, but they could still cause some interference with a high-speed
NVMe completion queue (for example). Ultimately, the spreading is just a
heuristic that is set up to be helpful in the all the normal cases. But if =
there
are edge cases where it's not perfect, that's OK.

I'll add a code comment in v2 describing the reasoning.

> - [Medium] PCI: hv: cpu_spi_count corruption in hv_pci_arm64_set_affinity=
() when inactive

This is a good issue. It's an error in the tracking that can easily
be fixed. I'll fix it in v2 by setting IRQD_AFFINITY_ON_ACTIVATE,
which is what the arm64 ITS and x86 VECTOR domains do.

Michael

> --
>
> commit 9d112d599453572154cd3fbc90e3b6ea7dedf0e3
> Author: Michael Kelley <mhkelley58@gmail.com>
>
> PCI: hv: Spread load across CPUs when selecting effective affinity CPU
>
> This patch extends the arm64 Hyper-V vPCI MSI irq chip to track per-CPU
> SPI assignments and select the least-loaded CPU from the affinity mask
> before forwarding the single-CPU effective affinity to the parent GICv3
> chip. It also updates the domain activate and deactivate callbacks to
> increment and decrement the per-CPU SPI counters.
>
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-hyperv.c
> > index 824cf27e85e67..7c293e39c9208 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
>
> [ ... ]
>
> > +/*
> > + * Track the count of SPIs assigned to each CPU. Pick a single CPU fro=
m the
> > + * affinity mask based on the SPI loading data, and have the parent IR=
Q
> > + * chip (should be "GICv3") set the effective affinity to that single =
CPU.
> > + */
> > +static int hv_pci_arm64_set_affinity(struct irq_data *d,
> > +                                const struct cpumask *mask_val,
> > +                                bool force)
> > +{
> > +   unsigned int cpu, prev_cpu;
> > +   int ret;
> > +
> > +   prev_cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d))=
;
> > +   if (prev_cpu < nr_cpu_ids)
> > +           hv_pci_dec_spi_count(d, prev_cpu);
> > +
> > +   if (force)
> > +           cpu =3D hv_pci_arm64_get_min_load(d, mask_val);
> > +   else
> > +           cpu =3D hv_pci_arm64_select_cpu(d, mask_val);
> > +
> > +   if (cpu >=3D nr_cpu_ids)
> > +           goto err;
> > +
> > +   ret =3D irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
> > +   if (ret < 0)
> > +           goto err;
> > +
> > +   hv_pci_inc_spi_count(d, cpu);
> > +   return ret;
> > +
> > +err:
> > +   if (prev_cpu < nr_cpu_ids)
> > +           hv_pci_inc_spi_count(d, prev_cpu);
> > +   return -EINVAL;
> > +}
>
> [Severity: Medium]
> Can hv_pci_arm64_set_affinity() corrupt cpu_spi_count when affinity is
> changed on a deactivated interrupt?
>
> When an allocated MSI or MSI-X interrupt is deactivated (for example, whe=
n
> free_irq() -> __free_irq() calls irq_domain_deactivate_irq() while MSI
> vectors remain allocated across ndo_stop/ndo_open or queue reconfiguratio=
n,
> or when migrate_one_irq() calls irq_shutdown_and_deactivate()),
> hv_pci_vec_irq_domain_deactivate() decrements cpu_spi_count for the CPU i=
n
> effective_affinity and IRQD_ACTIVATED is cleared, but the old CPU remains
> set in the effective_affinity mask:
>
> drivers/pci/controller/pci-hyperv.c:hv_pci_vec_irq_domain_deactivate() {
>       cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(irqd));
>       if (cpu < nr_cpu_ids)
>               hv_pci_dec_spi_count(irqd, cpu);
> }
>
> Because hv_pci_vec_irq_domain_alloc() does not set IRQD_AFFINITY_ON_ACTIV=
ATE
> (unlike its_irq_domain_alloc() in drivers/irqchip/irq-gic-v3-its.c),
> irq_set_affinity_deactivated() does not defer affinity changes on a
> deactivated interrupt:
>
> kernel/irq/manage.c:irq_set_affinity_deactivated() {
>       if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
>           irqd_is_activated(data) || !irqd_affinity_on_activate(data))
>               return false;
>       ...
> }
>
> If irq_set_affinity() or irq_force_affinity() is called while the interru=
pt
> is deactivated (for example, via /proc/irq/<irq>/smp_affinity,
> irq_set_affinity_hint(), or irq_restore_affinity_of_irq()),
> irq_set_affinity_locked() -> irq_do_set_affinity() invokes
> hv_pci_arm64_set_affinity(). That reads the stale prev_cpu from
> irq_data_get_effective_affinity_mask(d), decrements prev_cpu's
> cpu_spi_count a second time, and increments the newly selected cpu's
> cpu_spi_count while IRQD_ACTIVATED remains false.
>
> If the vector is later freed via pci_free_irq_vectors() ->
> __msi_domain_free_irqs() in kernel/irq/msi.c, irq_domain_deactivate_irq()
> is skipped because !irqd_is_activated(irqd), leaking the count on the new
> CPU; or if the vector is re-activated via request_irq() -> irq_activate()
> -> hv_pci_vec_irq_domain_activate(), effective_affinity is overwritten
> with cpumask_first(cpu_online_mask) without decrementing the CPU selected
> while deactivated.
>
> Should hv_pci_vec_irq_domain_alloc() set IRQD_AFFINITY_ON_ACTIVATE, or
> should hv_pci_vec_irq_domain_deactivate() clear effective_affinity?
>
> [ ... ]
>
> > @@ -885,21 +1007,39 @@ static int hv_pci_vec_irq_domain_alloc(struct ir=
q_domain
> *domain,
> >   * composing MSI from the hypervisor. GIC will eventually set the righ=
t
> >   * affinity for the irq and the 'unmask' will retarget the interrupt t=
o that
> >   * cpu.
> > + *
> > + * The first cpu is always used for initial activation because spreadi=
ng the
> > + * initial CPU would have to be done without information about affinit=
y groups
> > + * that may exist. The resulting assignments would pollute the "least =
loaded"
> > + * data for making the final assignments. Everything would still work,=
 but
> > + * the spreading would be less even than it could be.
> >   */
> >  static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> >                                       struct irq_data *irqd, bool reser=
ve)
> >  {
> > -   int cpu =3D cpumask_first(cpu_present_mask);
> > +   int cpu =3D cpumask_first(cpu_online_mask);
> >
> > +   hv_pci_inc_spi_count(irqd, cpu);
> >     irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
> >
> >     return 0;
> >  }
>
> [Severity: Medium]
> Won't incrementing cpu_spi_count in hv_pci_vec_irq_domain_activate() skew
> the load calculation away from the first online CPU during multi-vector
> MSI/MSI-X setup?
>
> Because pci_msi_template and pci_msix_template in
> drivers/pci/msi/irqdomain.c set MSI_FLAG_ACTIVATE_EARLY, allocating N
> vectors via pci_alloc_irq_vectors() or pci_alloc_irq_vectors_affinity()
> causes __msi_domain_alloc_irqs() to activate all N vectors in a batch via
> msi_init_virq() -> irq_domain_activate_irq() ->
> hv_pci_vec_irq_domain_activate() before returning and before request_irq(=
)
> is called on any vector:
>
> kernel/irq/msi.c:__msi_domain_alloc_irqs() {
>       ...
>       for (i =3D 0; i < desc->nvec_used; i++) {
>               irq_set_msi_desc_off(virq, i, desc);
>               irq_debugfs_copy_devname(virq + i, dev);
>               ret =3D msi_init_virq(domain, virq + i, vflags);
>               if (ret)
>                       return ret;
>       }
> }
>
> This increments cpu_spi_count on cpumask_first(cpu_online_mask) (typicall=
y
> CPU 0) for all N vectors up front, inflating CPU 0's count by N.
>
> When the driver then calls request_irq() for each vector i =3D 0..N-1 in
> sequence (such as in nvme_setup_io_queues()), irq_startup() ->
> irq_do_set_affinity() -> hv_pci_arm64_set_affinity() decrements CPU 0's
> cpu_spi_count by only 1 for vector i, leaving CPU 0's count inflated by
> N - 1 - i from the remaining unstarted vectors of the same device still
> parked on CPU 0. When hv_pci_arm64_select_cpu() selects a CPU for the fir=
st
> queue (whose affinity mask includes CPU 0), it sees CPU 0's load inflated
> by N - 1 and avoids assigning interrupts to CPU 0 for the first N - 1
> devices probed.
>
> Furthermore, if a driver allocates M vectors and only calls request_irq()
> on K < M of them (or defers request_irq() until queues or network ports a=
re
> opened), the M - K unrequested vectors remain activated on CPU 0 and keep
> its cpu_spi_count inflated by M - K.
>
> Could hv_pci_vec_irq_domain_activate() leave effective_affinity empty and
> avoid incrementing cpu_spi_count until hv_pci_arm64_set_affinity() select=
s
> the actual target CPU?
>
> [ ... ]
>
> --
> Sashiko AI review *
> https://sashiko.dev/
> %23%2Fpatchset%2F20261020182433.336637-1-
> mhklinux%40outlook.com%3Fpart%3D1&data=3D05%7C02%7C%7Ca9adc6acf8e34ef04
> ebd08df2eda50ac%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C63928118
> 7342913040%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
> LjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C
> %7C&sdata=3DnT7Wvhc6rrXjaC%2FqpvQj99H2cNbdzGmYWs4AeKb2jlU%3D&reserved=3D
> 0
