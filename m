Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479460;
	b=2/SMA6+5DEPsMHhlreFvoo17bpGisVNpSPqZ7lmg/28a4S9qJ16sIVe6+qe0z9eC7es+
	 CDPTyJfFmq1dRqKD8uOFgIgQjgL9PC4U4jdKrskQcVw6dc09dDGTbR6dGVs7kJn99huMa
	 HIAGGLVQ8Q1dCRRLubL2IO4VRM0n72v1s5L28aXRIzQ6YC3wyqxqwjAuzQqj0yWdGI6Tb
	 u27vbStV0DmuwTXJBPDDfWqAM48/z5LJIQ78RFcFjHnGA40FWeuvopsSJ6WFmLJ9ROXvv
	 aml1/0+UMB9gT0t34G+Cp2XRJuh4DybgYPmhUBECnSfj6dkL+S9FfGGyU8ru/R8tUzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479460;
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
	bh=7guf5/ZgYpvce0kK6xSDUAsPUjutv7rU4STTSaDROWg=;
	b=AMlnUxviCNYnypnEFIhJTlLWYIx9wtJFrvMBK8lTPPqKUrLnQhp6Yl4PgBIJb2AUTDXD
	 Uk5M+gjV/6KXbweWhIDtO6OeObhK2/3gHO5QrE1xEutKhxw9OJLvJhlK+GcKrhZg+ZB7A
	 kMWhCpT1DW4fMx0PE6+abPysjIxiAodUEx4KsZ4ytSGRby1vzku1yeIVUa1Zjb0DcV6is
	 M56VbljnAodVOzLJimRSJ+QqqDcJeJfzjMltuUUI8tTnCbd9n+TX/aFo0L3gXOaNttVGp
	 /n5IN1j1+2Kat5Yemshze/9IeR5B11eOcvFst2OxCeWxqVavAakzOZ8kKsILLXkzPiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=oIxO7M48;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.93
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010093.outbound.protection.outlook.com [52.103.10.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA37606A31E;
	Tue, 24 Nov 2026 00:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA37606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=oIxO7M48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtHSiwAgNY/5lKW5qLRFwXtvNJ6lg36t+nOp/pTDT5Bw+D6EpagwWIBzkbmDeoT7bChgFfehC0bB+3eRnWnehwDwyqsJpEF41UkC5kR8iLg1RRGleUKAKpEhODUwF06PTCfVTENCG5kcNAZHIJBNcgB35SSa2b+6fIQfkI1xGs9zBMqVLGEf33PBxLaH4L3NI0Z+yJR/NJhU7NA6YBWaK1hEAqjLuSDeFTxxmjPZ1uk5kXpq+G7Gy6RyTZll+2SJ51hoyXuz5ZdQu4zY5cb/kOz0a9RkH4iUhNowT64T2M80xucKS3ak65hKhqmgFqSWObUse1psY+uQrs6WHoq8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7guf5/ZgYpvce0kK6xSDUAsPUjutv7rU4STTSaDROWg=;
 b=LmT+kniueZJ6Pc+tShmRoL1NXThyeLXlKkRXucGclIFdozQ/OJvL7bEE9w8ZWlelFQ0LFcqXUd6rqYEwwSGoaRdtb2CcnPfWTP0haDW8TOuIjMGjitQqy4MgvwzV+jM1RAe42pnhBdXrCdfCPNxS6NbaRo6ryqtPrliy8s3j7xYynmGrI5nAUy9qWnem+ariuY0WsSu5tANAsGASMODjPV8SWT/1UVa2Z/QMB/WXshByXAeRe6oRFxpaeu1z2ExPfxYGQt+kBX88cE2HPGQQcz+zgdUJz6bhsbcqJ8i5voJCIouN/f5HePaBB6GtAqNniv8Hcq/FkdCYOjcHZYjDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7guf5/ZgYpvce0kK6xSDUAsPUjutv7rU4STTSaDROWg=;
 b=oIxO7M4847LeeT8uXIEZF3oMJykLAj3CNgx8lT9QaETNpHU4viD7HfU+DZnIBDDYf3yUnwRLaSLtMKfYdg/8NEWg3tUSA7SV7YoDvgONKaPAS7T45NTZHf1pCnNyblUfmrYlQswXDtychgCmS6aztWQQ6Xbskt3WOBFtQhCKocZjoAOH1d3fMR2y7sXWHkfSvzdgNW2fBzi2ETMBUI0JoVNLYpHwuDWlDJ3FUQDxz9Fw6NHO50U+6MTCAxQKuabCZOSUrYyUb7INAQiimG+ySI9W/40BS7k7qZWL+rkTlYG97ib2/J+AkFs4eHw7XwLyTpre9otfmoq4FfAHv8jTAw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CH9PR02MB12077.namprd02.prod.outlook.com (2603:10b6:610:355::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 00:17:07 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:17:07 +0000
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
Subject: RE: [PATCH v2 5/5] x86/hyperv: Request mask cleanup when no remote
 target remains
Thread-Topic: [PATCH v2 5/5] x86/hyperv: Request mask cleanup when no remote
 target remains
Thread-Index: AQHddnQ+yJ/grvkSsUycz+y1/FjUO7c8ZV2Q
Date: Tue, 24 Nov 2026 00:17:07 +0000
Message-ID:
 <MN2PR02MB68634640FB1BAE74B2A5DBDFD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-6-namjain@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-6-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CH9PR02MB12077:EE_
x-ms-office365-filtering-correlation-id: 12d46c55-a3f1-42dc-5335-08df49c0464b
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOXFa+/SABhfvNnZr2GNjfahMCj8f5bPeSrYo2HKZb59K/Zcb9FgctOCStxXzYtN1N2Gb4K10TsHc/kqd0zfvMDB2veiIghNprHz9lbnkR/8gUzbAGyEvswF4FXiGa/kOQ2ncgl7eFWbkfpoyrc+9z93v+sDf3/Fb6gWn7gdgZyfnUBT5APKAR4T0318yj+aFxar2vwr82AP9TJI0A2eAs2Lxy0QB7ndUm3tr3v7bou4zQk+3lSgRavasjvTDtwdoQPOizlvE3pXtiA1cX0GT0C0UtUVipZfHZMS7LZunhW5JdnRRA0GCHhBE9Wvttywo5s5fupzm+aliRNvdgFU93cj/pb6JFLz8LX3UjSbrCb+96iol+gp/tC9H+0Vin3VseIJwvStUQAQlLyCnFN5+G8Zyt19iUdf5OMLMo1IkTi3ui6tlFzLegX7JTH+Evj8CYXMrX/Te8mT0xO+iuBW54LngOgq2VF8u13AiDLSPZCNtb2WLbiIJfRnXRwWxY933/PIYyyDUx3jtgcuz2QAHeVe0kJ+I3chJlBG4HHdUDQihc44mCez29XIko6BCmwLXbyZgAiIOw2DTzyi/QperdEuiTwM2tNL1B6+MKUxhScOpRlzimI7GU6UxqRty77sC3eKb4QjZgCykHUGwMaOvBHTPOVTXqnl8saU7vZeECUCDn83BJFxO4HkkUPjS2lHT8s13oFWAe1y9Pu4H8D10lduP9+pFIiaaGy+vXpHpx+B0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|16051099003|25010399006|13091999003|55001999006|24021099003|2604032031799003|704163111799003|31061999003|51005399006|37011999003|41001999006|15080799012|12121999013|19110799012|8060799015|8062599012|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DuXp3Vsiw0rou9AlhMZN8z7tw/8cpGUjwpHD9xnCAU9kC6Qbg/TNL2W29V1k?=
 =?us-ascii?Q?D4f/2uZiR0zlkI8T1DNmPdByO7YiJvvPZPaRpp/Kwt6XGNtzw5RSve2yTiFe?=
 =?us-ascii?Q?a+Mk3x83kAhxKz/WngfIU/WsOMOBTqlEYGsUCTePsmngc04k95sja1A8Sa31?=
 =?us-ascii?Q?EK1y8mcaX+MBEu7F/fC7jkVGPpYgUPRQGclrRiFF5wuzKM349Lgg9f8+LBDP?=
 =?us-ascii?Q?h2iuYbzaBiBxNiRbXXW43NEaq1fj4xVQaLb43h3xHbAq5q6y3lIOyKOIlUSe?=
 =?us-ascii?Q?XZzqz+1yndJUl9oXWQ0Hrbcnlf4BCmK+lhLlHw9sssmDOMYwI7Wlv9xgw2++?=
 =?us-ascii?Q?ouj7pDBcm27R/8AGYC1wAuxI07jprHL5vVQXbnR5QbHYO+ta2fhAG+JHtM7a?=
 =?us-ascii?Q?CtQ0vhofcWYKnTU3NomleTJ7zv2RgjaSyVeUFIq/m7Ibf9NJdrsID0K4qz1s?=
 =?us-ascii?Q?9T8vWVtJWF1nJ7773wpl0Uw5WMVUbPdqOKuDBXCMiOC2tptVG2JYPOo1j+Cu?=
 =?us-ascii?Q?sXFzRFqKI4A5kZBp0/m3biMHMq2i8An7R6t6rLvpY3DMUzR/3LwK3ETHArLd?=
 =?us-ascii?Q?s8UzoODPJMubhEUQm/T4M628XzB2iEVUc4XG5Hd8dUbYikmjw+S7gFo3pF45?=
 =?us-ascii?Q?DkjAM3bnRQlg4MkwcQchu7R9nf7s4KoOfNAwdZyxKPxxhaSg1D+hKcn41C6/?=
 =?us-ascii?Q?aQ+yGRJYeqlhO6uvrcYhBMuZ1zhAzW1aVWeDPtDk/1QlDXYU1xzaLLWG1WAD?=
 =?us-ascii?Q?Jd/fbN5vOyWjIkNV+KD5qWNt12Q+udMz5qJAVHn/Kb3Px0rpq/Ve42UxveY9?=
 =?us-ascii?Q?ZG0sDylGSTOetaLO0rBO5KnLe48r4FED3sHflrbmr1jsUeIs5ugO4QGKvZUh?=
 =?us-ascii?Q?RJE41V82JSackRCHD+euDTaJyYy8KCr2KgqwCU8HyVomoY0lNLzeb9AYx9ii?=
 =?us-ascii?Q?2NS7AroVq+he94mg2nPrAxXaGP2oF6H68KbI1tOPs4tYX3uWXonhRpxOBszO?=
 =?us-ascii?Q?wgJiGGtaRzWao84uvMnuxAGEe0+MaIdMeh4U+amHs11xab3C2b/EwWc+VcVb?=
 =?us-ascii?Q?HXlg2rRkUl3JEmBeNvFk0wIJv+A09HpDBL3Mtu9ohsD/diqTAn7KEAnzwosl?=
 =?us-ascii?Q?H5DvY3VVzfLeqiwXB9bRUTUObrsrJ9niE5uJLsclxaAZ8KiEead0ISMvXOKF?=
 =?us-ascii?Q?aOAZpO8sLGl1HWhdm94+5QpLR2ppgGjLWUHszQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0l7X7AplZ6D/XSvYIKaMS/v+hAj79Im0SE+4j/k2AZVExRGmiBijHwZWz6hy?=
 =?us-ascii?Q?P7+ScJCHpQo17cOaCpFPJgsCuHR8PBZ4jbcV8vi2YYH3+gq/Vcw0+x/wL1LC?=
 =?us-ascii?Q?dmH+2rBtGqE1d8mgM7lfrIGBmUuG0rVoL85lCEFuhmh7dYauwJ2upcCn8/iH?=
 =?us-ascii?Q?a2Bt2WGAes21bonN2xQd5s0BQPQdS6F7DyErFPrkQi4yxgmF2/BtX6m4Q9H2?=
 =?us-ascii?Q?Dy/89IwY9ZvHomLlEnLghU63t7fe1CQ9CwlHU/htwpnZwj8q04eIt2+A13vm?=
 =?us-ascii?Q?0Ne2oPQ6DQ6CLbirLucD1FryDZqEsZP/VUpaAhh59E3FUaCkLzqQuxAby0Ll?=
 =?us-ascii?Q?EA1qCrm5xX6NQmAO05JO8XWnSVYndsMPvMAph6FpTKgZObF9CCnF6tjuufeN?=
 =?us-ascii?Q?KpbtveMq1Wcb6LA3SolIgptYYWY0weKkFNPPQWdO65sLWfAtk+mNpdq9ntc6?=
 =?us-ascii?Q?YtJeAkankpTxZwm7XJPhVtUVOrbU2HqrnG0JwO+vTO7qsvdx0rXvTcAVlumZ?=
 =?us-ascii?Q?fb1j/MjMIcTnNIWdEk+Sq9oLNLWOTaZWW+qJp/OqhAjlMsKqytmUyAKGMZNz?=
 =?us-ascii?Q?podutrcPcIJjsEzcWNi5eoITRM3Fg14wq6Vh5mYImY/Z4+61YppUdoInsOO8?=
 =?us-ascii?Q?tbRWkG7P0VzhieR+3zWOWpATTAp1eOhWDTykngEO6NmZZ6mFAgkFkauXFQfm?=
 =?us-ascii?Q?52lreGxt2vN7iS3sZUfBwWPsmyNSs8taspw8hvYjk9gHgz1BpwN6vIq4V4wM?=
 =?us-ascii?Q?2wCN/5Ln54JOVoOoDW9nQgD8qeZYmlAQNTDuGhDdLp1AUcNavSsmGjaPVfCl?=
 =?us-ascii?Q?lfuOC7kxHLEdf19Ahg33exrYThqkRa8a5ef5EUwxrNSQJc5EtVAAg3JYK1ml?=
 =?us-ascii?Q?/JM5fMXXLtGnFCqMiGk8wtbM+KtIRkcH4TVwufwfcQE5HUQZuhpN0a7TJRYv?=
 =?us-ascii?Q?NHPhYnW65vkF49nHDIKTyvd5XKOAlY0ZmYAq8NPY6FMzg9iuNV0rB9kvEH3S?=
 =?us-ascii?Q?XaHtk6QqfVI9OAxVOihcdej+SS5PPQ5Q8vN4X1z2USXcvru9GqiRd9Ik44Hi?=
 =?us-ascii?Q?BNGa1nvLdhAuI4a9KvHyqLbOk/eivnEcfXq0vgJj530Yg3eoz4Z2uwiAyoWi?=
 =?us-ascii?Q?2j/WEg2GL9cyl2qvUvIvo174bS8Xxv27KlFeiE4IBIE/uwr+AvsBpB2nB0N3?=
 =?us-ascii?Q?cTgDFxUCSVWDrG/DH66+4mYmGTySyJsMn7p5OCcW79rhislqA9HIonP83IAZ?=
 =?us-ascii?Q?88KAXe4XKUMedlnK4QawJv2zlkwwzj7OXkeRLt+ro/2FCK2cQ/cwIV0UP5ic?=
 =?us-ascii?Q?rVcurFK5jE0sEDSry9HWm1lXfwM+djpVsp6EPzktdLX7z3VumriZGLIWc2dK?=
 =?us-ascii?Q?guXvVuw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d46c55-a3f1-42dc-5335-08df49c0464b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:17:07.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR02MB12077

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, =
2026 1:15 AM
>=20
> Filtering avoids unnecessary hypercalls but leaves historical CPU-mask
> entries in place. These entries can keep later flushes on the multi-CPU
> path even when only local work is needed.

This needs some rewording.  Something like:

Filtering avoids flushing on CPUs that don't need it, but the filtering
doesn't remove any stale entries from the mm_cpumask. These stale
entries can keep later flushes on the multi-CPU path even when only
the local CPU needs to be flushed.

>=20
> When no remote target remains after filtering, request native trimming
> of the original candidate mask instead of waiting for the periodic trim.

And maybe substitute mm_cpumask instead of "original candidate mask"
(if that's actually correct).

> Copy the const request so only this call requests cleanup.
>=20
> The native predicate still skips lazy CPUs, so cleanup may not leave a

Again, be explicit instead of "native predicate".

> local-only mask. The new early return also makes the empty basic
> processor-mask check unnecessary.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/mmu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 833eaea1d3fa8..545a25fcf6c34 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -102,6 +102,21 @@ static void hyperv_flush_tlb_multi(const struct cpum=
ask *cpus,
>  		}
>  	}
>=20
> +	/*
> +	 * No remote target remains after filtering. Request native cleanup
> +	 * of stale, non-lazy memberships so later flushes can take the local
> +	 * fast path when possible. Lazy memberships may remain.

This comment reads like an assertion of the state of things at this point.
But it's only true if the below "if" statement is true. Reword as "If no
remote target remains after filtering, request native cleanup ..."

> +	 */
> +	if (cpumask_any_but(flush_cpus, smp_processor_id()) >=3D nr_cpu_ids) {
> +		/* Keep the caller's const request unchanged. */
> +		struct flush_tlb_info trim_info =3D *info;
> +
> +		trim_info.trim_cpumask =3D 1;
> +		local_irq_restore(flags);
> +		native_flush_tlb_multi(cpus, &trim_info);
> +		return;
> +	}
> +
>  	if (info->mm) {
>  		/*
>  		 * AddressSpace argument must match the CR3 with PCID bits
> @@ -148,12 +163,6 @@ static void hyperv_flush_tlb_multi(const struct cpum=
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
> --
> 2.43.0
>=20

