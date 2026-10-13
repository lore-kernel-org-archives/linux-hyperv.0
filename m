Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3625B0B8;
	Tue, 13 Oct 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.64.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891185; cv=fail; b=LWXxVTuXcF6OiQERReWxSet/svKkiGSOEDFOODsIKxwJeXeRjxZaTAvz9HRmT8Lmcv/TRzoOR0dHHdO3C8Mq7g+Db81k5fgg22uEE8ctL/SS1i5ekx5FnIC/eBPOTpauLFs3ct1TOxx/BLHHPAaOLUWfiikhBCiIowjVJdoIprU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891185; c=relaxed/simple;
	bh=Cdm/yIMWJJpsi3ZXiO2Yau2OgmmI2sd5OxowXOyZ5tI=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=ExfhFDGYJEYruBhPOu/Db7eA9LYN9B1xsH/b9aj68K4+FDdtTB002lco03rylcK9sXeHGkapfXlV3r3wMZmXNmdfS/wv80Zaz8E4N0vucxRpJZbnT0sW1foF3L9cYkJofpkwliBKZTsYH3IOLsX5HdrIgzCigKFRvkLxFSaEfmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=XQvi+fFz; arc=fail smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="XQvi+fFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791891183; x=1823427183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=HG4EmVN/VEQb/DaifMJfAG2t5WnygxfdaH96Dt86mQI=;
  b=XQvi+fFzKmBvktC8b9lail/978NALyGrPHWDaLbu/+WjczUFYz631z8D
   A6f19Nj2yzeWv+xw/aoALF+M0HjS1S2yRX+bJ8CMDxCx0v3TgqzHPg26d
   BJPPhT1Lqb0vlhg4/8+ZD0VpV6acUPBxIxrpKWtCh0kNIzE6pzYU2PDaM
   CTTdVy3Hj8zat8xZob/7YVl3ilhSKzUdOOfzym1bc/lfglUPGBkojNlmD
   xI8jy7Ohog0Av6NLcsr5RvE+lDnCAj2Yd8+vZSIue1Jb6143UgpPPRXPT
   LmX0SkGJOD2ta3+RhMxa2QhugepS4A9ClvojH5iiwcMtpyNDr5ORQsH6a
   w==;
X-CSE-ConnectionGUID: 3t2KnsTRRRm9oTtPzbEbwg==
X-CSE-MsgGUID: W4CPaQxWSEew6ULIKjpVoQ==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; 
   d="p7s'346?scan'346,208,346";a="20983372"
Content-Type: multipart/mixed; boundary="===============0713323634469663090=="
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:32:59 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:2996]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.5.86:2525] with esmtp (Farcaster)
 id 752d4e47-7973-45ee-b2b3-4ccc80a1e894; Tue, 13 Oct 2026 11:32:59 +0000 (UTC)
X-Farcaster-Flow-ID: 752d4e47-7973-45ee-b2b3-4ccc80a1e894
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 11:32:58 +0000
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 11:32:58 +0000
Received: from LO3P265CU004.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 11:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKCxIhbmtJzh2LsoWQh1kc6aSBJ44NRKzJClBmA0kl+pumg2oKGPE93kw6evRjwjJPsU64gFtlEf+IVdjz6zar2j2bYMQFj4cY0aIx2VMr+vZW4pkhj6vsWqDGhgb1u+uyFaHBL8nsF8UENzaVnMNiydbuy1iSPBy+wWC+NynjkomSHvQfLXrlEelYqF5UgKi6TLACYbjY0/noc00naugDnH3sRsy2c9BEODfariallzlZXfdI4AXrZ75/Ye7+kKFDJMjQw4G0j9D77VrBETnCpVuhRhxK1GpkuEAM54i0ITXdVAmd8NOvuB1ylrCU/L0es9KsihHCoFxUHC7GQIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=N+RO1jnON7ekBazv3XmRcpy6lHjJl5zSrA8rPv7pJzs=;
 b=RNz61Hf6Dj31If7dMhENdE71EosKUPXM2Ef3xFDfeWx1Txxn7Msi8iSNdb46hD52gDYYj9y7xXhE4vbx127YuNgpn8CzECq0MgewcMFoDmv916s6STswcCzStiOcaS3V1FISLb2pLLpmPtRM098ZbfDH58xiDzd0LnRgRjwruALsCS3urqfOfIoohtgfvUeH92KgBEnW4CdYTx07d8XPaWagNgzm+EQfbmjJczgFExHIfd2wPOgzFg+3+1kUy1ayWcGeVzNh5alO04Y+znBuUtuPP0PnY+cECuZI4tSYlatg0AmLyjJitF7PsRV4sjQJfdRH3Hg9SiUrh1rO3Yp4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from CW1P123MB791400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:283::10) by LOEP123MB021225.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:503::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:32:55 +0000
Received: from CW1P123MB791400.GBRP123.PROD.OUTLOOK.COM
 ([fe80::7116:15f2:3ab1:a618]) by CW1P123MB791400.GBRP123.PROD.OUTLOOK.COM
 ([fe80::7116:15f2:3ab1:a618%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 11:32:55 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: Jim Mattson <jmattson@google.com>, "Hussain, Mushahid"
	<hmushi@amazon.co.uk>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, "K . Y . Srinivasan" <kys@microsoft.com>, "Haiyang
 Zhang" <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"mushi.shar@gmail.com" <mushi.shar@gmail.com>, Todd Frederick
	<tfred@google.com>
Subject: Re: [PATCH 3/3] KVM: x86: hyper-v: Implement
 HvCallRestorePartitionTime
Thread-Topic: [PATCH 3/3] KVM: x86: hyper-v: Implement
 HvCallRestorePartitionTime
Thread-Index: AQHdVP+lnGFywklzp0mbkGIJs8AnBrb6dcUAgADtaYA=
Date: Tue, 13 Oct 2026 11:32:55 +0000
Message-ID: <23274a3d540e4bc36a88262c06adc7b16eaa7a3f.camel@amazon.co.uk>
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
	 <20261005192431.87317-4-hmushi@amazon.co.uk>
	 <CALMp9eQz2ouQvFhBYv_R33_sUQ+ehxv__-f5iZ=_3aA2Guwy5w@mail.gmail.com>
In-Reply-To: <CALMp9eQz2ouQvFhBYv_R33_sUQ+ehxv__-f5iZ=_3aA2Guwy5w@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CW1P123MB791400:EE_|LOEP123MB021225:EE_
x-ms-office365-filtering-correlation-id: 4472aefe-bdb7-462d-8874-08df291db962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|23010399003|376014|7416014|366016|1800799024|38070700021|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|4053099003;
x-microsoft-antispam-message-info: X71/PQPvWMrfzBShgtkVSvz2wq7E/xS+qOAAq5rEMjh4ZpNOC2WErujkxZgH511mX0tqbTTOq3yzhl3v/IQUMKV6fL3VnFQbilPt9Msh+R2KQKbW4cpzFtf+fRq0l7xk92EmmKXooB7ZONbvEI67R7hLIgAMQYmq2HnGFoagalz5LNL8TkHVSqsWlQYvShA69eKza+oxjRydq79+9Yn/9782Xw2OxLVEuThHuctP3LFtHCZuP83cQKgHUGMYfqSMFVQirnN9eLptitA+vUJqyKtES+BcthParL2JF5VRyACOgQ7RhndvXA5HZwc8O9jgxcnnIbh3o78IZPxg3oQysa+H14P4u7qh3tqLlVprMeaUbyc0ikQ3YF6WLkxrFcocpPO90gRFPytzdi8RVBlYWsa3l4kLdKqVIlOr7RoEuS+ygqfi2SXZMfQ6wuQBQFSs7YUnrfS/k0lccDLvG/VZa/ZLniEhB0Juooxm6YWi543BVbz9tHSctxMdTyq9gWO6SPk0WpIsq5OU6V8OmVPMmBuO5sY1gfTRfCbkzDSvUqEMdgobvqRLoNMlkOqStqZCySvxp/hh7rKY//ydEfyWbzwWJzldpAfPRuY1ChGmFdC3U4HeBAv9ys6fD854xQ6m6tligbRiUNUnIM7U5KDw3rr0pd/opMF7iyAgNk0r34Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P123MB791400.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUM5LzBqdTlSeHprNVZCd3JRQmhkeGtTYkprK0lDZDl2RmdzSyt5RUlMaHI0?=
 =?utf-8?B?M0E2UEVtTU5aUW53YWRBWGdGSG4wVkplVVM4MEVPVlNaT3NBMFgyejBUQith?=
 =?utf-8?B?RWxwbEljVU5VbTBCYytTSlZuUTl4bGdXcVRBcitKL1dCaWJGcit5SExHa01K?=
 =?utf-8?B?M2x6cE9BOEhhUkVZY1ZCOFJObFZkRUlEUkpmSWxWZFprOStaRExNempBOGg4?=
 =?utf-8?B?T2N4RnRBRVZDQUVZNmRCUmVlY2FCVE0vUE1EKzIvcXhMd1JwYWI0U09SZVQv?=
 =?utf-8?B?TGh6WlNEY2NDdG1mMHJqYVZSc2pFc3BQNk8vRFh6bUtlaXpzVDVxQmV4Y3ho?=
 =?utf-8?B?NnMxT1I5UHhpQ1BQZ2QrcGJ2cmEzWitrdFJSMGdDRzJMdk0zcktpaWZ6SkNq?=
 =?utf-8?B?ZnNKd2hGU0M1YUdpUVNlTkRRK0hMeXArS2l1VE9oVnBDa3d1Zy9ZOUF2Vm1D?=
 =?utf-8?B?eWpNejFqVmlnRm9ZN2l2UEtYZTNhbWFwYnhrWDZ4RXppM1puOTZYMmtqS0dj?=
 =?utf-8?B?OExmNTRaQlBoK2I5TVVqRjgxTG5wYi9xZUpwME8zZXowc1NadEFVclRpem5l?=
 =?utf-8?B?V1NaV2l6QUNxUjZHcjV1RzBRamczaHNBRHQzUmhoRGdUMEtMeWxnbkVRdFlD?=
 =?utf-8?B?VzF4cUFvRG1IUDZyOFFOOU5FSnhldVVINVE4Qnc5T0dnNk5mUENnOFB0YlRC?=
 =?utf-8?B?VmlSR3hTd20rYmZwZHNqTlFldTBOZlMyZXRlY3dBbkIzdXArWmFSUTBWYnk0?=
 =?utf-8?B?YTROQVdIRDN0bjBNdTI4dURoV3JISGROL2VTa2RLSzNiZWgwemFYb2YxNnQx?=
 =?utf-8?B?NFMvOXA2clhMV0VpdE91dDNjcXhabFd6WmRDYTVVcndQcGdzV3VWUkdHVnhx?=
 =?utf-8?B?YldzTXpVbDFXMUt0Zk96Sm5jUndnZVYxcTlnSjgxOFNvQUxoYjFDN2tKUkpt?=
 =?utf-8?B?a3FmUVJPTUJZRnZIWCtFTS9HM2N2SHI3V0FKOEtTRzFTeElrQVNUako1bHFG?=
 =?utf-8?B?Ukh6aGRZczBmQThkblNyZEZrMndydnYyQmc2eS9aRGxVQ0xYS0t5ODBHL0p1?=
 =?utf-8?B?OFQ3cHhNNmpUYVF3RWtocDBLRkpqaXkyaTV0S1BlSDVrd29qZkU5V1VZNy9j?=
 =?utf-8?B?dlN5djNBUG1xMkk1R1h0bHZxalZBbldqaldsQXh6THhKaFEwNmcydW8wWk5Q?=
 =?utf-8?B?QlFiVzlxRUVJMy9zblRNQ1BkemxkN2dCRUFmR1RpbHJEajRtRDRydWhKNXc2?=
 =?utf-8?B?NTdTSzhrcjJGWXlsWGhvZnVTdDdlVEs4LzV3dFdxK29uV04rVC9qcjlzeFdm?=
 =?utf-8?B?Q0c2WituSVhMdFNKaXBmcmtTQWR3cW1leTBnT0hGcHpGZFc3WElLTmFCN1FO?=
 =?utf-8?B?bkVqWWtEcyt0ZndjMzdjMzlFejNPQ2llN0JDMzVXa0tpT1oxbzlST2FqQ2or?=
 =?utf-8?B?dm81M0VSenlyRm1MNVB1OTdwRnJ4aU5HSDkwUUZhZzNTWlFMb082TnFUd0dq?=
 =?utf-8?B?VVp1NjRwUXkrKzFrenUzZU0rWjBvOFJ4RkovNmhCaGFFK3I1Z2VjTXphNjlW?=
 =?utf-8?B?eG1tcmxzM3U5eUl4bWlJalZEWmxYY0xvZzB4M3VqQmNTODU5OEh1aXlmZlZ0?=
 =?utf-8?B?Z2d4cVd2VUUrUU9rL2RLb3c2dU1LSmEwZVRjbytrYnJvWGdMeS9GWG9JS1hv?=
 =?utf-8?B?aWNMWC9sTUZwT0hPL241ZmxpTzFmV1pLZnduL0N6eUZLLzBOYVJldkh3eW1k?=
 =?utf-8?B?Q29lbDhNUUVKaXpOQXNxWmZRK09nRmhyMWRKandPM2x2Q3grelBudjE3Z1E5?=
 =?utf-8?B?R3RVb3l5WEU0TXVuRWZBa1g5K3hPRTMvVmg3SzJnS0VxbjdERzBlMnNOWEk0?=
 =?utf-8?B?SGt6QkpGbFR2YjNvRysyL3dhV2Z1LzJOck5QZ3pEd002Tm9TUlRFcTVPZmxJ?=
 =?utf-8?B?RTk2S3RNS3JGdmM5TU1VRVhVd2pOVjVsRlQ1dUVmb2xjK0RuMXM1b0tuTm9P?=
 =?utf-8?B?eVBNTEFaSWZSMTQ4MmpxblV6cGJmZm9FSHFSblJaOUlGZzVuaVJ5TzdoVVJ2?=
 =?utf-8?B?UmU2eElUbzhnT2JNZGRXclF5QThFRW83L1czd0VNTW9LZkhEK2d4Umx6WVIx?=
 =?utf-8?B?NTNOYStNeDF4d05yOW0xSXNtNmE3SGhNa040KzVyUEJDdTREWWg1NDVvQita?=
 =?utf-8?B?YmlqeGI0eEV4dmI1NWFhRTRZVHAxVGpFZG0zd3IzVUVMcERzNnNrcm44Vnh5?=
 =?utf-8?B?UnFEeWE3cHFjZ01hcmlWS0E0YmpadEhTQWhWMEtwT2JSZDJxZE81L2lXN00y?=
 =?utf-8?Q?huIK+QH1wiKUbMrdzh?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pgX4p7gO+hIzJmp9d00gnQjTwKO9NH32mpGcTopmytcOAUqLRAksWi6YUCxjSY9SGOdkfhRtlXT0vksILf3Q7mCQINzGx1jPVhrtCcMCAotALVgUfmQ8TgqBQjOlQjb6q/u5fQ/33pSWZ1UcPem/Dra7Hxfx/NJDQ4uHKBWyU1Mv7N8ipJukYmsUEIIanCuPtdVsSmNetT3gI0b3r9ZRMe1l/TWWNjJL1Noyo8rGA4p7SY36Htb6qhv/0PB91yP5sM+cTzpnNKjTGxRKHA7+HZfqPnYMmmiefYrzqka1IKfa2juzHM6ourWZFr3tUP1UvSroTKC1G/nYMLG1Qgd7sw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CW1P123MB791400.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4472aefe-bdb7-462d-8874-08df291db962
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 11:32:55.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X24iYMGh0i6tHCKVwRx7Ad/FqQxfwgeBHpRbPptJlWmiK14XrS1Mkr0uBWSGdMpIHhLvuH8DaKqX9fCsAwPcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOEP123MB021225
X-OriginatorOrg: amazon.co.uk

--===============0713323634469663090==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-8pxvU7TlIt5Mcz3u6NMM"

--=-8pxvU7TlIt5Mcz3u6NMM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 14:23 -0700, Jim Mattson wrote:
>=20
> I think there's a window here in which another vCPU can consume
> HV_TSC_PAGE_GUEST_CHANGED before kvm_set_clock_and_tsc() steps the
> clocks. If TSC emulation control is enabled,
> kvm_hv_request_tsc_page_update() won't invalidate the resulting stale
> TSC page.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_set_clock_and_tsc(vcpu->kvm, =
in.reference_time_in_100ns * 100, in.tsc);
>=20
> When stepping the reference time forward, don't we have to recalculate
> the hrtimer deadlines associated with armed synthetic timers?
> Otherwise, those hrtimers will fire late.

My understanding is that Windows only does this at resume time when
nothing else is running, so it doesn't matter much.

Either way, I don't think we want *any* of this in the kernel; we
should just pass the hypercall up to userspace and let userspace handle
it.

There's a commit somewhere in
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/vsm
which does that; I'm working on cleaning that lot up to be postable
this week. (s/linux/kvm-unit-tests/ and s/linux/qemu/ for the other
parts, if you want an early preview that actually boots Windows guests
under KVM with VSM support).

--=-8pxvU7TlIt5Mcz3u6NMM
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDC0w
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhUwggT9oAMCAQICEFQru/eJkU7BxeS7T6sWKmYwDQYJKoZIhvcN
AQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjQxMjE1MDAw
MDAwWhcNMjYxMjE1MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANhjs6T4tJ0lcw4+6sawEn2FowmhunUBsnSV
ccB+aA7s3Zd9PZV46CU6phAlCWpKk1yFVcD1Rnc4ux17o4LbUgFXiKrORS0jiF/5Oa0rXG3FISG1
Xdjt8oPKIq+9Z1s2e7Ipi5WWj4AG/xlkH/YMMctL9O8CCRHSrhiChbE/gR57x9PAnt5aeZZ2YWza
GOOeceaZe+u6vHCHITRmknSAnAX/aNoNJNsQCGcfrE83y9iHmP8BFrSRZqajBKlKq8tyJd5FnSwP
H3kSUcQlHOwiIfCRFXP4rpXSZ7nKOEZr3SXH06ADY9gZtrSpwBbuzKWDPGWMRuRnz8ogj/Y6DeU4
2zB/ZAIi5b0BzWf4u0rBEQD5xtpOCxYHc2nXQaFSWu36kP1JaNqElE51OQ92EyVKfW3N6qZcKiBr
VijXY2EtR+/5W9ixRFnEs4nIeb94Sf92UMEeG9ew2yVvcYXXNPaicGnrkESNC19/a8YXxQEZfrmB
eAPT9viQJhn3O+sD4pP0Ss3SjVZc6EO7vfoP07bt2n9YE08XSPkxcyb1J/4t/+AskkKeYFBGdpjg
xd+iLFxjSwBytZuh3+7DuHUfg876WA44ieQDrhHSjuvuAZ1Wb8WUsrpzrcLoYjqFmb/bf6/yyoxl
t31mdgPC+FLc+Yu1BQwXC3JMbrvbFBVTtn5X2EKDAgMBAAGjggHQMIIBzDAfBgNVHSMEGDAWgBQJ
wPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUWvtA1XsSV8xjgfFQL/DUTNIbJu4wDgYDVR0P
AQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwQwUAYDVR0gBEkwRzA6
BgwrBgEEAbIxAQIBCgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zZWN0aWdvLmNvbS9TTUlNRUNQ
UzAJBgdngQwBBQEDMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUF
BwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28udWswDQYJKoZIhvcN
AQELBQADggEBAED6T+rfP2XPdLfHoCd5n1iGIcYauWfPHRdZN2Tw7a7NEXIkm2yZNizOSpp3NrMi
WOBN13XgqnYLsqdpxJhbjwKczKX50/qfhhkOHtrQ0GRkucybK447Aaul80cZT8T3WG9U9dhl3Ct/
MuyKBWQg3MYlbUT6u4kC9Pk8rd+cR14ttYRUWDKTS2BrL7e8jpNmtCoEakDkMY4MrpoMwM1f4ANV
qZ8cnDntwXq5ormZIksN2DqxsKLmrFyVAONhqSST72ImBfIVWhFRTCF9tTcI5wE/0Skl25FZmSsB
B2LUgecgK7MZyw9Do/b0sYS+8YmA/ujUCqNb0fPJBE/B9vBomhsxggNCMIIDPgIBATCBqzCBljEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQVCu794mRTsHF5LtPqxYqZjANBglg
hkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2
MTAxMzExMzI1NVowLwYJKoZIhvcNAQkEMSIEINOUdSfNT8f3KC6+SwpuSPYwLbrzgIYxntRB5ueZ
3vyrMA0GCSqGSIb3DQEBAQUABIICAMB3erL9MeMRV1AUHSymzBh4eChxfy4pDnuQ3QxlxGVPB+tG
BJ17CKIIU1G3wxQU2/HdoRaUK4ICT4dbOxHtUAKsxM2JYbsMmuaBP60kkc8AvWrD+qfjIKGoD9As
D7hpdF7UhVvmUCp0Hh2005+SNpCc7bm1m5Zz58gBmIgfeI63BTLW8HlrMW9fx+Agobwop0/ky+Or
KjG0p4rP0YdjWiXOtFRQoq/gE+aVpEw+HdDltVqLUyWfawz1NvBEscdma+1bVFPPX6QzHSVFuG0H
09ym4nwMjvYlwgsbg0zTyU3+oV2W+V9ilDuWC8JCvYtgx7jGIWThmS5ibSvk5skCOwRrD+kSWfQf
0nPtEY2iZgwVuzBl14xwU3xPpkf/aH2PIScq61JF7SQSpkBSPePTLVB85xwoQrjtPApwT4AjFd0v
cJnpnRqHzyAlYfzA974Gu5GaRBhK12azLPaSHCMDvO6fr5ThyBZ0ebCV1XUdoem7DvyvI6qfUk8Y
LpnbrQ2fYfidtW4HBEXhG7NkELNv79+yUby3l06ZD4gexIXInJbPX4/PWbtaSrBkW5i61uQCgTn7
tG4v/OKOyvVQfjp5XMujrOL15Yo8b+dNs5Y0sg+o68rJFyqnJjWktHsoLJmy049hT4im36HdaE03
ZjEiO5b/l8P3PL/fuGVeuTY2TJ8QAAAAAAAA

--=-8pxvU7TlIt5Mcz3u6NMM--

--===============0713323634469663090==
Content-Type: multipart/alternative; boundary="===============0548153028524763009=="
MIME-Version: 1.0
Content-Disposition: inline

--===============0548153028524763009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============0548153028524763009==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============0548153028524763009==--
--===============0713323634469663090==--
