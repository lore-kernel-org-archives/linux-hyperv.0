Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624861;
	b=0N2aikn/u+NSLGh+YhPe8aATZabjblfWiE2+KbHFSbwOttlK0PZmLbYwZAvnT7HTMgj5
	 KFucoudm0B1oAdUrXKyUkxRLTFS5BtnXBzRXIdKYmdOi0GU2Zi0IPVEx90JcKI7BnxFTp
	 xx204SI110pGZ15KbBhGSIkczbdPiZ3PjPY2VGzlvzl96azVh4MqD20knT2tYwJqJgRxw
	 9RTTnpNLKtsHTIB49VTz+JhVeh0ACcoEwQo30cp1TluemojeOkfWeouznb/6i+SbNBGD3
	 NCP9KLvYJkNtaoX+AXMbwHMV3oj5MwILMP5caRGtbfZxta4CFhGUQ7lKqixwm2KREVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624861;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tji9BpzfPpnGONOeoFM3l/SmwLFDtU7X5SHPN1igR+4=;
	b=HXzWFkxnfkQVcx6lQnoyrVya7FQL/LgsfF5G3AIUJ5lQ/9rs9HZD3lJh+Q+6bGaRbazw
	 wSfUkwx5PZUSQSMwZfUCB9sCZrnCEq12Y2M5yeXj7K5q9wVK9s83dP4Bz8SepHsKpMQQx
	 IxjLoKmNQEf7Uu125mFGTOiOnxwM66vLVx/NgPE25hi11bCrwrvbcM5aaCkCPqQtw3ldb
	 nfGmaZg0mb9cbWWXb02rcS+P6/WOEXmBNKsNumUlBTQaCfuAtEkmPNvBaNehXXJ+7w9EU
	 NIAs4N8hu21GG1j0auMrSahpitnQ1X0PvRBjf5vm6w8IonBK/jhU89srWw41HmUBwsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NlIPjgJY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F169606A319;
	Wed, 21 Oct 2026 23:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F169606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NlIPjgJY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuJBM9TvgXsIf3Ka7oJ1CMkL+Qwy/tmoOxiaIN/+KUqttZeW9phdfnUflB5P7i9BrHR4eO8scP2Hw5EhhyR21bAb85Uw4xvXsuY4uU8s9P+SK1vFLINcpoNAu7RviPOcr9KTSyOnYrreMwxMk6hSgIhqUFl5NlpjwnQl9/RLEKomPi6YpE1SZsSWVLTZuKBkeH2A0/OYAe3DN1PuMpE9Nd8p2wGvI6em6WuPgeqiIiuW2SzNApFGdjIKHzwjzWfgL3+9xXustIXEZCTX/HmAlSRvvT6ojcCx6IKKtmrgWEms/ZAI8G4cqv0RAlTZAmVu24on4P49kxt1U9kTLJd+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tji9BpzfPpnGONOeoFM3l/SmwLFDtU7X5SHPN1igR+4=;
 b=l0TKXfPPr5rKfTmo7PpV2U17EBxhJ1O4A7/9KfjtySrIaLtuJcX9J1AElnElsIkjNJxvMCkksKOGt6gk23kh+2zmPy7fqX739WTpZz4qC3s/9ZKokhyilZ/XVUmgionVGr35h/F+jY4M7uSwE5iEYymrGDXGGb0VPQNr/CfrNVkJhcQxFkxSNd8j+gv1Br3irSDM+17w9SRgbXTwwpoQRQPdBO+oKQQMSetvrKKJ/Fl0QPv9PLLAZOEvlnanrcw+pjrgTUxEeCG8PcRW9h0OTjmzMZhwn1J7XTmAUtHHIkWJGKoXTRoWFV84ATC9No7T1uS4x6JyhiurYI709FHzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tji9BpzfPpnGONOeoFM3l/SmwLFDtU7X5SHPN1igR+4=;
 b=NlIPjgJYT6gfpjhWZ3TcLVr+3XOYkZTrC7ROQhePiVt9RhX5ZFJ3D/cEDpYH+YxIaPdVFOQzecjqi9Wfz8T+tLw/VYa+Uh+NewC+fR9Ij/7Kg/U+TpCjBYn28qbKN0ZODFXpZNCcTOn9FD/SMaE1EUPlHR3RtoqbvukFF4eYdKxPaL3BkpPf1MV/4CeBarPVahdnBkNQ+cRaECckj7xkYCN2kbW2U2mm6H4PW+1wvA1fUASyC8Sv1hiSs+1kM4AC45YAmCiyeOWX7g5RMZJo9bibBJgxjrDMvVWOdeCX9EG3+9U3q2ymAeWBo3Z4uhMapHfX9cDvi3wy9EkadYBS7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB6696.namprd12.prod.outlook.com
 (2603:10b6:510:1b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 23:20:02 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 23:20:01 +0000
Date: Wed, 21 Oct 2026 20:20:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	jacob.pan@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	arnd@arndb.de
Subject: Re: [PATCH V2 4/4] x86/hyperv: Implement root partition IOMMU kernel
 only driver
Message-ID: <20261021232000.GW3008132@nvidia.com>
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
 <20260929223622.778617-5-mrathor@linux.microsoft.com>
 <c01d422c-5277-010b-ff14-dfe5fec6a7bb@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c01d422c-5277-010b-ff14-dfe5fec6a7bb@linux.microsoft.com>
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 00640d30-3cb5-43d9-16e3-08df2fc9d47b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kSSeT8vDX9I6F99uF7wu0ZfGz4qRSnans6JzZ6v6QZDzpxmeQ5vV9s8D01O9U1Z4SQ+oQtLFKp6E22v6AFjhsrry+3G+SELTor3AjsUHEYzgLBiK4PZosMHTYE33uEBfcu8W6lwJUvbA2VEW2ss0/M40bo1zm3HBLpAcmFl/lHV31F5gwJ4/2h+Ekpf8zjRO5ot8aM6Kwfv6LGW6QpObTlQkjg+ZRnpR4XnLX4n/iD9fIuuXzvAxL6QTbYPiEOiDmBVB2en+JXZKvh2MdIRYkN/gxalaET09tHvWrPu6/L0I4htXKlnhep2UgzS/tQvtR3e0HIng9Dtl8NIe7CXygs3Dtl27GYjRL5RJnoT2XPkdVjtqfuuNVdqZynGHdTuoCl5+nwOUFamjLcvJdfa1O39VRkvL5tVtj5pKiJmCTELZzhAQWJdKN4TLfzHSfJd0QZqjnW/KT1C4N9iA5KZYLKLQMqtcCERkJIaQf+3G5bAalEGdZHYRW3DzSXMhPy+Nsvqzywuyle2L3AWoh1Wffh5F1tRBc5Zx3yzpqZGhiY14QNh4XWXdBFqK5EWE5jL206qIhka+lr2rBbgH1sZvpo1BCzuioC29JHv3mSFT1adIdgve0FTaPm8mq7UI1sJIX6o4iF0K1wmHSe1sQGk2stZ9mjN0npULuymVjPUpYJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HFlbFaCix7a/5aTskLdOT+0BLpUbYduRQ91YoGv57ZVFqlCkiXufVRV6C/U?=
 =?us-ascii?Q?gdys8ws6lFH5ITz9sTd2eIWA1t2DNw9+1UVdEY3UYpxT/prZBrUEQJDBAAGO?=
 =?us-ascii?Q?43ll+/HSprDE+DWxAYhZf6Ih9B6S0m15BZrPfBhEpWJrRFUXU92KkcypmGaN?=
 =?us-ascii?Q?5Tt6iBJVcRFLN8SIM6Nnpil2Rqpdu4xEUEIQ9x7ZcfJEeuxNYTwhZe5Ox8ER?=
 =?us-ascii?Q?GjSpczobtvtBrm5ukIvKkE0toEfFzz1TS2Y6A+1lj75TVMkuTZwyDOUK8Pnj?=
 =?us-ascii?Q?R+34zWzw6NOaNTZCSOr6N9ai0CTlgRGc1oGY9OrlS5fO4O4PbciIAa61hMf7?=
 =?us-ascii?Q?gCInn10GTwC55xUf4WtG/hzh9oBQRMYHAGeibVQB+k0Eg1vDyjPrunxjvVSl?=
 =?us-ascii?Q?ZJOUose+v5Ujq4f6x0rbpXJrkyMnkZTqX7iqMzSOzuD+fCLF3ld83qPnnLYp?=
 =?us-ascii?Q?eFhjdr2yiSCJmjUEeu20RI0qdZGqeGNl6C2KCBP9rKVNjWHRV/qHrC6t2Gnz?=
 =?us-ascii?Q?0exOJ7J780LAUAkTAePu9bHJmPYG7di5WN/AuGrvoFJ0OV3K0vSVTztqFENc?=
 =?us-ascii?Q?TN6Q4qKDYJMlvgzCt6YhxTvC8piBmIu0tUrA5qWoyN/cYJQb4C3SvtJVKiTF?=
 =?us-ascii?Q?8ZTsQdOZQ23EmQT+T720t4fRrNRjW1ZU1MeqodeJHLXM8YNOF/XoeyOz7pSS?=
 =?us-ascii?Q?9jWke7CteZgFJdLLHlGFV2zd/KPzUnqbX8jNVF6V1axKrbQcPPX2Il4x2b3+?=
 =?us-ascii?Q?ZJS0J7piah4t8iH9lfQbRllFehRE5PUVa8ND6t5fERMFT4P5t0ZUfep1sdCY?=
 =?us-ascii?Q?ELyx4c5J5L1n2hEBpfyBMefmoXiDFLbiG27RxBwcKmwhZdmh1yrveynCURxr?=
 =?us-ascii?Q?uxu6dZz8isVPtgc2vWi1EmOyQ3xKiOvLXagbH5Rzc1ig9P/WGiDAxxgLa03g?=
 =?us-ascii?Q?09dw1tZDXIVn6Vlg1L+qzsBUe0Yap3eMlGIlk+Y0HmAMoRSueUHzZd2PhbfU?=
 =?us-ascii?Q?Bh4Rq9rfceMEQxclIrSzS37PV+zJHuMhU+wUni33GqLJ4IYAjJk22MUB55vZ?=
 =?us-ascii?Q?FsOCVA0KfT9X3a1+hhMu7giru94JQPKu1dOBmSq6DBPfbIHrEoNCHazHizYJ?=
 =?us-ascii?Q?L4Amx39e9vPE+1IumokM7o1zPiJ/34Z2Behs2V643OFkUvE4ZgZYmm6A1Wnq?=
 =?us-ascii?Q?5Yb5GomJvT3x1Kdm9PFaa3ftvbGeS4vwn4OzN8JoKlKTf+F5Y9k9kZ0R4Qs0?=
 =?us-ascii?Q?tRJ6uxOaHfjRxmXSSNpknmj5AgIRaxvkFut4cHJmKsJtjTsWNH0NAyOarBdc?=
 =?us-ascii?Q?wAAcgPKffNPhKzhb+4ewAs50TOCawm46FJWNTFTHpqG2W9tHR5Yo1YMV2dnU?=
 =?us-ascii?Q?Kbnk8VHVYfZqrrr65LIXVzewuAcxdd8kS9OjF1v4JkVP5ZGHBjeAtEhomc/S?=
 =?us-ascii?Q?DmJD25mtBaU6kJjullGVck35M3yBvJkqUqPV6lvSBZVRbHnzYEO8Ix1UmbC4?=
 =?us-ascii?Q?Flba9tB6ewsWD4i1s/1eORbqAARqPllwdx3/C7/Cm2NQ31gs4kvNpUQ4+y2i?=
 =?us-ascii?Q?9qIq2Wj4vhZoE40gqGenqwD+kvkxSTEA9BPZFsw+CgCqCcVYQTyBEIcrdhbR?=
 =?us-ascii?Q?WV0fWKoLhzIQIBXoFiFXcj9mcesz27V0nES85izijTamtkpAj4oqjKhFYu4Z?=
 =?us-ascii?Q?jgy5XNGaikSa0eEFQ0FDpx9jE/MaeFOS8g/vw/wUfYFlviNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00640d30-3cb5-43d9-16e3-08df2fc9d47b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 23:20:01.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax3yk9n/sXVbi5mafITIr4C9/vDVh3ZifqJqNPy21UiJJcuaz29Ye8HcsRR/Zxoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

On Wed, Oct 21, 2026 at 02:36:53PM -0700, Mukesh R wrote:
> Hi Jason and Joerg,
> 
> I am going to rebase due to all the patches that went it and crank
> out a new version. Do you have any more comments/concerns, I think I have
> addressed all your concerns. Pl lmk.

You should wait two or three weeks till rc1 comes out at least

Jason
