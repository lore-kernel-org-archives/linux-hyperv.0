Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.69
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793900007;
	b=1NxCRStAQ9SNpJGL8c3u25DXnwudTk8SbpyRs6thgt11d6JI6JYLAF9QWqaQstj2dlOi
	 u8YZGQRXES11sdotto7K8jo+gK8UjtKSOcCMhM5LWsZHTVEMqbSiqNo3jZWSCr6oQSuoj
	 tJp3njwO0PevkConpKQWphiod1RXcaNkXWT3odZAvMEHGQvJ9+JGg/5TpV4bOW1K+X8d4
	 Q59NEtG44IwhtpoW4G1RHhXRwP5JEZ9t469k4qLSDmnvtmR4b+Wg6yv7FTW77xs9vojWt
	 PBYYN8E3lqxULlrQEkOXj8gR7AFPdxVI069xTHfrnZEy1CIP7/4fadpkYpYzp4DasPw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900007;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:From:
	 Date:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f/TaJi9SnqmwvhFyBrHMq9Y3vPQStOAFo/IUZNNvXGQ=;
	b=z6o2nRqy4VDXiPB+Tm/kjvBlrEgQcP4kTzXysgjlGW2ixJGocdnz3mTJEJE6GHSW2tj/
	 dJnhoDC3w10xjs6o5VMjm9qkla0EkiosjzYS7cJEpD3CjTPnen1L0jcKzJrm5YWm8iBsn
	 jFKgWO18WWMk+k70G9RTpb5ggpdGpARO+xzC+cRtlv37rcJaV52w5I3wZyP4Lri2q8ivf
	 ynJRFikZnhInySbb7hj4xNGK10Q1tZr2l4LJ7ur9n+xCg+rn279NR/NcjEy3ew021XCNZ
	 mnSYGW7nTPx7R2dkT1VK5phyMgQOLEWVm0Xx5y1fOOhBqC2QgXDcRmVqEP9gro9wOMQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FSAvztfE;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FSAvztfE;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.69
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DA606A32C;
	Thu,  5 Nov 2026 17:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1DA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FSAvztfE;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FSAvztfE
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AOjMsvO4uKTSLacUzdNku6ji/ZcBoIf/FpF4PG4pw7jfggoeqeE0OoPgxpVsCpJReW4aEtfc8SzInStyWOUaXIeyPvTbDok/RgEtZBm6ht2bbVmbB0B5WhF/T9JIMuzoDkAIJ64NQo0vOfpmBMN9WBJnX2vLKl37eKZM1+gE2MzRJFRniUonjE3mLrBKtI8SBKRvP40kfeuWWgCHIdPnVFOudxqUtekpIWJIwVKgi+qjgYSbRc3splajcwOV5U+EN8EqmmVLsuQXvDCRWjbHly+LInB1FZ/wHn2KfT9YWrIqRm9jvnbbw18c0pj7tVyxVx4T0sJKeV+1utj/kiI/3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/TaJi9SnqmwvhFyBrHMq9Y3vPQStOAFo/IUZNNvXGQ=;
 b=kGZkiAvS7ex6XGVmy0ZqDCSM7YjopYqkP047H3kQl76in7DMnlxXf26HuPO6/7NRVh6ssXAi00EweOWgW51MZvML9DhlpA2asqNgx1fg86Wg/BjQN2xAiey+4v+feYHu4KP53w6qrhkTJgAnuGS5qxWBTW07Op59/uFggM5BPxcC1wtfFiRnkAId50kFKRAIRIe2rD0bP14L7USZ3YgUA/ST7ncL77DsvdneIaKGPnsbQT4a6k2ej0RD5bg9Z9yDvflyUbJ6HLuGwrQJosIzViluS5z7/KZzfhPzXVrJiCPoHze79Ak4/syi5ZcAUPTkFIbIEmhRzf1MfCVHKuD62g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/TaJi9SnqmwvhFyBrHMq9Y3vPQStOAFo/IUZNNvXGQ=;
 b=FSAvztfEPnknaC/TMy3ESjhRBjjRXq/zp74UI0MrAnJj7FITg+55aSuRjoVG4owmEIiL0L3oE0wVskuug2uVtjVZjaEWIXiy0LgDR7UC1xFLYYON2o9oqNdV8uI1m8QGdPPKCWSgH/9fYPHdSEuApIdfPjc0KxYkFGmREC1m3zY=
Received: from GVZP280CA0033.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:276::10)
 by CPHPR08MB883815.eurprd08.prod.outlook.com (2603:10a6:380:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:33:21 +0000
Received: from WA1PEPF00009B3C.eurprd05.prod.outlook.com
 (2603:10a6:150:276:cafe::3f) by GVZP280CA0033.outlook.office365.com
 (2603:10a6:150:276::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 17:33:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B3C.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Thu, 5 Nov 2026 17:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylgddM04/VpwnH9LjtAmsAH9Y8XtIOv3v882jdIzqIFg288FgiJWlYx0C8n3SGvCiRsqR0sxvX4K276CApFuox/5K5cH2L4igyP1FnF+QUqDRyd7h9/aYumPr9sQdWtU3uzKfx/0dNhuYDkNbvv0qnmBfbWnfgtRDYVnzAm/1k4uSHyDuw6WVcp8laiZUxT5A9t5Z29Y5xvSSfNrf0c3BG0eZhY3SEbdZTNdvWSLUlLhgr1XbTqZa0VLWIExoCxxIgefTOe/V4ZIPDC0oZcq4zlcioZAXqjJwiQsca4dn/9BeSL80tKS6mfrSLfXrkIRJ446uupm6/aFC5dLDlxerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/TaJi9SnqmwvhFyBrHMq9Y3vPQStOAFo/IUZNNvXGQ=;
 b=XuwnLGQDwL7b0bd9imEGYO+LROwrlwX68atkLYWusea1mgDRNtXFGqvpom8Q3zP2/OaL9Njkppu13XdpwEwiPewguLwDVeBPzeeBQlGS89/R2AAs2nQZ4jlq6UFbkW8WKXWE4oAtQg59bbsp5Dul3XAG4onbNnfF0wV85ODW600rM+CvAx1iL+x0M2tP5J3av5KX9H73M3JWBWwPNrKsoGWo6GFLRRTYDUxpYe6JrEVoAwSfpOpI6FvDwh4f5vvrN7GAJSVmBM5wYQ4i+n/HquK41ppHRczPar2uV4NwnA4KoCTngFbMHCQLWcNPX6u8+zXCdLD8ECQbe5KJjxo3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/TaJi9SnqmwvhFyBrHMq9Y3vPQStOAFo/IUZNNvXGQ=;
 b=FSAvztfEPnknaC/TMy3ESjhRBjjRXq/zp74UI0MrAnJj7FITg+55aSuRjoVG4owmEIiL0L3oE0wVskuug2uVtjVZjaEWIXiy0LgDR7UC1xFLYYON2o9oqNdV8uI1m8QGdPPKCWSgH/9fYPHdSEuApIdfPjc0KxYkFGmREC1m3zY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by PAWPR08MB10897.eurprd08.prod.outlook.com
 (2603:10a6:102:46a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 17:17:07 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 17:17:06 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Thu, 05 Nov 2026 18:16:16 +0100
Subject: [PATCH 1/3] stddef: Add offsetofp() and offsetofendp() for pointer
 arithmetic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-offsetof-v1-1-4153f5c10edc@arm.com>
References: <20261105-offsetof-v1-0-4153f5c10edc@arm.com>
In-Reply-To: <20261105-offsetof-v1-0-4153f5c10edc@arm.com>
To: Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Vineet Gupta <vgupta@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Nilesh Javali <njavali@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Carlos Maiolino <cem@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-wireless@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-hyperv@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-xfs@vger.kernel.org, linux-sound@vger.kernel.org, 
 Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PA7P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::20) To AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB10291:EE_|PAWPR08MB10897:EE_|WA1PEPF00009B3C:EE_|CPHPR08MB883815:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b1b557-50aa-4782-79ba-08df3b62e23f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|10067099003|921020|11063799006|261028144727099003|261022105027099003|56012099006|261102123227099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 mr5OB7YJkX4sA+UAoD5rIJy3VTvVYYdViPg9GzAW7Tq5jQNBv5IpbZJMaV/vr4lw6bNREXCtAuvO23wv5lboaGb2iyHxKueczHoZaLQruXjnJ4YsCWbLpTEYbaLN2b3JvrgYbeggZrgBqdNLIpGvM0KDUI/1Y2SuF4oHsDFUPNwtOd/2FLXh1QbEv73jXLyrVk7IWKQRsxMQyKYZF5QyCPh2HS3n1cmt4i6rX7DLoZNf9ln06GSM9GUJZzgZ9bqKU/aX5Y7Kop665I4/c4mR/yqeN6QA/MtQ4AHgb6wdpXFSZyraqBC11X7fdax/7ceQntHlN9bu9h0G4M85891n9S/oHiGnfiA+SwRWOJIEYH9ht3/94aPp8GdFObuFMlJjR9WRsVwhddQCTzRxi6NoJYQPREiL0F6SmYlaL5uwXNcrhzCeKzLeUTKfj4Fw3AL7XHfiCwpX9Jf/ZHlovSnr6Kg8NeVaS1won8b6DFaSYRRFdbvViur7VcgJphgovJ5nBuCAkXqOE0Z4lMc09/q5khyBH98Zu4ffavRIyp5gqu/c0oWEcxjDv3FpUyVNkzPANuxvwxTF6b2vxulqsbgGivqeVmRNSqfUlFyr7hL3hNZbvJums5toHYZtNQYVdZFx5mbIctvTAZoX7OmZbmBex426aM+aO0s8jTJNsdnA5fLXxFg2wvIN0XC1qJh8+wQi9EH5FRzWFRAL2zpsu+jvug==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(11063799006)(261028144727099003)(261022105027099003)(56012099006)(261102123227099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ET/QPDjVBSYkB8BUfVvcUDBeNRCOk2q3Cf2mO3C0HiuTAFVggj+y8VTqq6VaDo9mhlFYEEM4ZKPI5OCip1bcAZaPjBdAfEGNZKkBeeI4/g8jDco4K3dFDZ68IgTGyXZFh70/3fz4tfUqbMN9OLpR6s0kwCdHgaYyHjyJMJCqjFHz6mwxuLnanowdZomKxYxXNMKPdIdVgT0/PowPWsbP+M//dYvR2MIfHFaoeRUHiZaHcXqhixWJvo57kZjhyJCpZrE1WXDjjIhOHdXt+iT+2cpJ7P1DskNvUgaqafnjFSIhNLZNth9Z36G1pOdK2ZnP9Yx46uPe5cq4WiF3Rdz5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10897
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a755c22f-cf8f-446b-21f1-08df3b609e27
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|14060799003|1800799024|23010399003|35042699022|10067099003|18002099003|22082099003|921020|261028144727099003|11063799006|261102123227099003|261026140227099003|261021121427099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	G6EUvo2R0t/c1sn8bwScVgpc/UN2HjFeX3ajjJLHdxQenotrWLn+Ga/JRDyQl1bicDTkD/BfwnWYFtlrGCsuU4yT/LQsgB/EcH+KhsYHn66IWgrpfZhEVv7x/vlM9aN4Zn8OnT2tjE9mJ9RLYmua2/FHwUidtYoU1CVmUIaV5XzDQ/lhobD0ddopVgGSr0xdfRMQF8Do+KhRGiTomem71Jl66p+eSASlTlh7MioDcOG8dgQjx1iBssiyBQbkxljv60QjEVO0dr8BeGz1tiH8xvqLx2xAk+QFeKSaQdRKuUYzPz4YPqJN03lD/P/o71xrwifNaYm06HXdpLOjIYXWHiiZWyzF6CoM31Y8BWDewE+0ZWGxV9FMhxWCFslxrYHpMbj/gz2jUsZdNODVJa0Xy2898tmzPYUsJJAsWyaj17tTHgpGUB6QPhlkC284OiBHJASB9WUM/J2+rScrO7ZJw/Jr7WA/1XF6JFblFAEXzCmVH3xGVOGsv7z514MYGCAMWAtw7mc02do81cMDV2Z4KHRJo93UV9EaFIOkEgunTMPidTK1odKA6yMm5Uw+rg3ZBMkzxd/g4aYt23qFq1G5RZ/tJcXinWk89/1G/tgWCW+P/XsHnFKMPCppG63yMVRZbxcgycy1OfoQeEJ3Ga4Bsf6gD+sbqRjKDq7Rsq3qEXLCDV6tFA5BVUmK1N0t8cz8YLKnCmBgLgaXUvvvIdvc3hDQGsBEFMcgaBoCjKR4NxADNLiyPrG/GnsiajSNoe7H
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(14060799003)(1800799024)(23010399003)(35042699022)(10067099003)(18002099003)(22082099003)(921020)(261028144727099003)(11063799006)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I+2nup1S4BAyjP7VTP8//SY4gMwXlu/3c+QtZgmizgo6m9w1s1TfnU2XKh/PkEuJZEYzmRxB4fsum6qXMRtyuz61uo53298wIK0fPcZgzzgXY0eesB6LAin6oekz2dk5SBPSj7k6nuZC/lgXPo4fe2AI7//ZeodVQg5uOPzEdHfdyJnbWtYq05pV+UVmVaq8J48wQFbZgpJLlHL3nFlyMcgG1uDVqBsPeh702TUq0cbYxl18LIKklvOo3FQfm216qbHmqezTbwCvKQmPv9tF+Mz7Xzn7J/K6IXiPqYovnUmd9sGE7zApDiDDNJ16fOh3IafrK7CZAjqU8QBVixNDKnQBCVJ42EgYHF71QhA5AaqBYqes05U21lQYhihBzC6lBvbqwUR3b6AiSkT5JS8gQfXbmS4ZthUMsLjo0kEToOtsj0H049hz8G04wzlkcOz5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:33:19.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b1b557-50aa-4782-79ba-08df3b62e23f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR08MB883815

Many call sites of offsetof() use it for the purpose of pointer
artihmetic. Thus, a common usage pattern is:

  offsetof(typeof(*ptr), member)

Capturing this in one macro helps keep lines short and terse, while
still making the purpose clear. It also helps discourage spelling out
the type name on every callsite, leading to more maintainable code.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/linux/stddef.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..87f0e131d235 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -32,6 +32,22 @@ enum {
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 
+/**
+ * offsetofp() - Get the offset of a struct field from a pointer to the struct
+ *
+ * @P: Pointer to the structure
+ * @MEMBER: The member within the structure to get the start offset of
+ */
+#define offsetofp(P, MEMBER) offsetof(typeof(*(P)), MEMBER)
+
+/**
+ * offsetofendp() - Get the end of a struct field from a pointer to the struct
+ *
+ * @P: Pointer to the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofendp(P, MEMBER) offsetofend(typeof(*(P)), MEMBER)
+
 /**
  * struct_group() - Wrap a set of declarations in a mirrored struct
  *

-- 
2.56.0

