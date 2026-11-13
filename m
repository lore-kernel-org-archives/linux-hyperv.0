Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.66
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794586122;
	b=Zjt3CUc0cjricE3R2VFWsN/kPzcWO77hJDVGmoJEFOFaVHk5t+G4nWb5QTWmL1BmM8+z
	 mksrqOTm0uR58ZCo+qcsbivVQ6RGBiBkj0lX2toIJRORkHEWTw/GxiJ6sraUAaReRtr+J
	 a3k0NEVLvhC6uE/PSj1JC6tH8qe0wH6elTBUCa1YlKGz7dHDKl3d03z7veiK6WsheJRIT
	 LsOpzUJmi109jFWu2W/0kuBG5rQp0W/dY8iH3mLhrTWLM5X5k/Bd2irVlrkQeb89+OQqu
	 OFFaaKWIvzehDJgukZ9W1ek49h2SlkU6FBuZXJcJEtvppQL7GeUmlUJ8ZgReBB+UWuQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586122;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:From:
	 Subject:Date:Message-Id:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
	b=K9rmOjZ2lH9Lj0fqLRZTlp5NzxRGYEG5x49rJ3qUbG0XJkWupRglCJXfhSRP2+oDDL3d
	 hj3FlXKmpSPPrqaMznPs/2HQwVhy4B/dVneClIE9z+DtL4KOR9K4PyZNAWMs5xTQka8n1
	 I5BQexnsFsh3YWXiVUATXRgmSTw5bMweVffj+jTCgBriAgbOA6amAFpIz5osHAQdeUJrj
	 M2ss1U6uOxJv+i8S60ZKgAIvOL8qGqiU4WQ3SUye0TWiEOoM+2nLctzrAfAUOFDGRZmGa
	 vdaRGhChR9+BhRalrNLRP1hoI7FHRqw9IwOm67SCQncpyopIlSHXmQ9RXQJV4KaDNOQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=V0KNpKp9;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=V0KNpKp9;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.66
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632C606EB8A;
	Fri, 13 Nov 2026 16:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E632C606EB8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=V0KNpKp9;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=V0KNpKp9
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TWDjek7VrGDBIUujAvKKexvhPHKFTeP9UhA3QUjxMiSWNDx/5RLCJIqgCqMKdngLtKHcIPDez2gAZs9A78nhjg8FhOjKsV6xJOhBAZEolHTtAUcEFAKVrEyj2P3+ua6NXRMiVoKNiXJ2xkOSfYN1WuOUm49rgYmc67qd8i61vURzAfaCFTjGAENHvuKLtb62FZxG2WI//OrvKIgBDtvmNanMnJeAObLbZ+2wEKMtJb0/2myg/9hOdY99JxLNzw3anaf+ewfIRlrEM8sXvTgEg70NSazGMz6yXEvoSK9WyftgaGL9yHWnbkjoR1zZ/b+V32vABXaZEqqk8nK4UhHTMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=xNFxzJZL+MqwNDajF4Y7nVbkK47wA6gfbJ/kwjJEUKW5Dc9oq0aCLV1AisZ/Pz+D7gnsSEsRBmjrKCj0xgajaiyK7TYwPaYA7GHcpUtepjOX5mPDAmQsJlGBPyYjwdMAE18cDakxzfDal7HOzFGZvshf/nJ2XiourQQdEyiDdYkaRToJLpLz9ZIqytthN+ANJ2ZN3XuiunnDYxG0QDXJptF4jHBaN0icnD7ke2L6j3txhaZlIFs+4eg0hFDR/lQQ4PNcnAiOSFyS3/CHeZkmLnnmVFSL7R9BEWnOjKAzLizieRdV21qq2RYy7ACQ/d15qBB5SKZkPcbTRzaKYsvj7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=V0KNpKp9YDXoO4hcPUzkAzn4mU0IaE7cZ9DwqkMGO/QzNu0zlNPt3XtOGsLCgC9R8vd0r5DMTEhCVP+xMssXnFnWTwVkNkJKpVKIVknhxgSOITMm3Pjh1S1+n+umLLjRBD6RCu5fbE/YdmJllzJMYLuD9FE060RPewaSMJOmKH4=
Received: from AM9P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::27)
 by PR3PR08MB5580.eurprd08.prod.outlook.com (2603:10a6:102:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:08:33 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21f:cafe::8) by AM9P195CA0022.outlook.office365.com
 (2603:10a6:20b:21f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 16:08:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0
 via Frontend Transport; Fri, 13 Nov 2026 16:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFlJHGaiadeYi1AaoHU+Iq3wVZrYNzIJ0XxGvoejgZkFz3ZVzQoGPXyvbK2ijab6ldLR2zImB2eRlNqH0QteNpg3Enff7TLuLhwRoV0pfydSg6CMun7gqOgmJy5RiW8cq9sSR4v29g7EUqyOcn1t7ox6ICJjrTTPl+Wictb8ymmCn7AqXd2L6tKmmywwoguwy93EGlz027W3jB+s9RYQzn2PRADxojpJN4+O46Y89LSwhBaZ+AVEkY056p/HLwiJpWHJycOj6LEIZxrndFGoDl8ANnaQlgZzBXHwnbRAUJAbpQsuSLAAYGJsMqBIfqIWRsH5HiKtBcRlvIxQkGYSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=lCej6tIo2YqzNd0clf1CEytJ24wKPpjXuRNooMomUz40WSi/cLUgz7N6l6LvbHqiFmX7MProPiWmy2WC9hbD8aRhfKnQQkBdSXD4eG54eSh1gPyUfWSmRdRR9Ip6SBXlVLbR6SaC8Nlf+dA1hZMbRGmCL69w104LeljiJpKCEN6UfoZ/ax1dZK0lM3D24FZLxtJHe5AVv6NXwhXuLzb5o43qqHqeGm75DpOjGDDDFBZkG8cMEgprachpvDR67HhS7YrxgtZ2JY8o6jPJLqzy6KIt/z3o8GVLxhb8f3dX0aJq09rVjhi4UwPdvnq8lgK0ecIa9RjivITrwlBw4WfYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=V0KNpKp9YDXoO4hcPUzkAzn4mU0IaE7cZ9DwqkMGO/QzNu0zlNPt3XtOGsLCgC9R8vd0r5DMTEhCVP+xMssXnFnWTwVkNkJKpVKIVknhxgSOITMm3Pjh1S1+n+umLLjRBD6RCu5fbE/YdmJllzJMYLuD9FE060RPewaSMJOmKH4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by AMDPR08MB11367.eurprd08.prod.outlook.com
 (2603:10a6:20b:717::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:07:51 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:07:51 +0000
From: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH v3 0/2] Add struct_offsetofend() for pointer arithmetic
Date: Fri, 13 Nov 2026 17:07:30 +0100
Message-Id: <20261113-offsetof-v3-0-714df7053893@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMI192oC/22OzQ7CIBCEX6XhLIaflraefA/jgcJiMWkxgETT9
 N2FerAHj7M738wsKIC3ENCpWpCHZIN1cxb8UCE1yvkG2OqsESNMUEoa7IwJEJ3BRjApBa87QzT
 K9ocHY19b1OX61eE53EHFwhfHIAPgwctZjeU0yRDBl8doQ3T+vY1ItAT86UsUE1zThptGUQJan
 aWfjspNqLQltsMo22EsY6wVoKHjfS/aH7au6wfYxw++AAEAAA==
X-Change-ID: 20261105-offsetof-f62aa6348f0d
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
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
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Nilesh Javali <njavali@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-scsi@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR3P193CA0037.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::12) To AS8PR08MB10291.eurprd08.prod.outlook.com
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
	AS8PR08MB10291:EE_|AMDPR08MB11367:EE_|AM7PEPF00000054:EE_|PR3PR08MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f94a5f-ca65-427e-c2bf-08df41a05ce9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|261022075727099003|261022115727099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|261009220027099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 0GqxmAlMIXtyeH7PxXVmri8kRG8z7DrPE99+VFM/M9YhLgxgI43m+DCi64tgSMBPy7Khu2V1mDmNEdB8ylSBOv3lk8ruIJ+kvIBnz01NT42ALaL3J+REErLpZWjD3HckeOOCEY1ZYJGFME3HnlBWnXp5At09pSj+POqMUxC0Ya8pNAcNi867CAU0q2Qe9aQErK1nDs4PceazVWxuHjl2JJvctu5mos/DE+ByBYKzk3KlTvNAMD5BZ4LZ354sJehIjweohNSqA8kutEqLnfb6OUfAeMSgXtG6LYCKnVIO7h0M0uvYR6rIz/+Y+edm3xSYsbfQ4QqA6glRkgo7f4q2LTcBzt/EJCtgopGS/OM2Hf2WeA94XO0ZWxt16X49OehRMM1RSuIgxH3JIXeEZvy0JzbRSazRkQMyoS9n6UaQJtzpClApOpilpc4XMXzAJ9btC1dr+Kog24iZZIj94Z+QLzrCZIrB1iQtqNgNPsb9uLgKjdX/LGjwucbtTgyKa6cOuQV/rbQT+EmTh+ZYI3vzezl5F3j68gzUG8x4C85Yph9rTj4jzqbVM9McUAY6DykP2nRD8JHgNodU5NDhg4MwhhPOSc8gGx9sEG/x+E814i4kOcLpz/lMIF6nUPFENXZDbuVTUQOkITqwcG/TIsZtvmpkmJ9vBmAs/GDmP5doLRg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022115727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009220027099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pxeCfIZBP1VabGwKwB+kksErX+diPKbSFzRb8XWSnkwcYzMkMnS4wLOc6dAqNnnP4HJWUR9wPTF0Ln4CSvbdDYVqvSRH0Q5rZQM7f3J0JEfEKj7tPBQr1B3rBXOiZrTnjTzzuKYLtcQX2rC3TIK1F5rt1HM3iTtqmjl8YgmM4ixsOwNvNOwFoAqkIth2v7Hgcg9wKQecIvO8jmHdRU0P8vcvfaK1XB2ug7DzqhkI8bJ+9xKrJTLHriXqTtyR37XYD+BMerb4qX9wFxpLdtM3c/d8sFFc2rZzKgDH2j/psOHi8Ra4Xj+WFglN2eBk9HnuZQdiee3Hy93cO+euuaFq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9cb5beae-4aae-4c78-f29b-08df41a04471
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|7416014|376014|35042699022|36860700016|23010399003|82310400026|921020|10067099003|11063799006|56012099006|261021135927099003|261022115727099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	4FqW7Ed4WCxy2wfi70Swd7wVEk8I+1PL5BUOPT3HQBRRFKd7/GPGNmn4ySptpOUnd9gZcYsXlrtU1qIaP6GeyGQ3ZRecS4aFJCi5GzmLbXAlfunTqGCLkihDi6ZxjfAiwGq0OOv5iFUsLlVe1QTt2vqn3EcfZjdnS3EQPdpH2e+SX25b4PMi9qRHm7GNvH9oMMnqDs2ogVyKMzRAvRuRdwbtCZub8mIVBHLZSe/Vljhxvmx087KkHGpWIV96rkVZcuNNsCKE99zr8ytpC2q+CTMbSjf81vIJWqiiU6Qz5wI0u41WLgkBH9IqTbdZ5dybDpfhHqiaNV7OUwUDdzhPvsDI9el6vHvAF7GQ/h7QNdEWKFOzhdOamDH6CgecsPOUGnk0LtguxvLtjxWSsQu19Ddbz2Ta6ZjDsrt03Z6N94rDVrgJo83XOQPWOsgoBG9zkUXKCIaE6JXzG1+MK3UpcavQOh4MFDG5H4az+2PklBPGDgAJwmiAJlOTspmUmuR4QjqmCrMD4DZ8r1SBYwmZIB+iZ6M6LIfUET4bMob6NzJVYLIuZeVelQXtHNbft6v8W32xEY5bxuzfL4Hr8dn8in437tXATlQCbPMjisZkmhSrVo9K/NB68A4tL0yZoWMlkszTnFAV3orB9P4QJ3WzgItDq4J1tO45ZjCQax+pf8ZoGAb32tkg6sP4Xp/UcowdHpWaeiTn//5NzW+jO+Ef3A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(7416014)(376014)(35042699022)(36860700016)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021135927099003)(261022115727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BbPnTU1BiPykaUsQkAF1l0r2Trnk+ZBHkf+4OFC8zdWbxOdliNY/WcPYwBrst0uhG7XgI5wfaOvUY33XjMtyf6B9z8r0TSafiFONulT7zEqI06LKthqCY1izISdvAb+L6yjGuuzmlMNK6TAfI50FFlrBN1wC7FT4Gybrayvzu9gmgLuxbYs/XGAptJCPBnwrTr0xy+FGu5YZqVEbJnucKOKXDgQjmR9oQVnv8hzcc+xalsSsGvdRxwm51/xhxv1yvCt1HXG98emDGiYv9C9W6UDcI7EjBR3uH557IWMxH7hK17GrHSX/HSifNH72G9LCUdHBLylbBNwhZOeT1gl2qG8EHixUOkjZPAuQvBgP8BfKTNs6r86eG50pwKamBdOb2m4eOtUzCCl/WrbuzeUBrQApgK8krz1v23WMCRfWkMcm7c57RpHbwpPTvQk/N6f4
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:08:29.7288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f94a5f-ca65-427e-c2bf-08df41a05ce9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5580

A common usage pattern for offsetof() is the following:

  offsetof(typeof(*ptr), member)

This is exactly the definition of struct_offset(). Some call sites use
offsetofend() instead of offsetof(). Add this variant, then replace all
call sites with the corresponding macros.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v3:
- Add Coccinelle patch to tree instead of just the commit msg
- Fix Sashiko issues in prefix, commit msg and doc-comment
- Link to v2: https://patch.msgid.link/20261112-offsetof-v2-0-276ede839967@arm.com

Changes in v2:
- Use struct_offset() instead of reinventing it
- Rename offsetofendp() to struct_offsetofend()
- Merge the two treewide patches
- Link to v1: https://patch.msgid.link/20261105-offsetof-v1-0-4153f5c10edc@arm.com

To: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Philipp Stanner <phasta@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
To: Chengchang Tang <tangchengchang@huawei.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans de Goede <hansg@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: Jes Sorensen <Jes.Sorensen@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>
To: Benson Leung <bleung@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <groeck@chromium.org>
To: Nilesh Javali <njavali@marvell.com>
To: GR-QLogic-Storage-Upstream@marvell.com
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <mkp@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
To: Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: arm-scmi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: intel-gfx@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: chrome-platform@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
Cc: cocci@inria.fr

---
Bence Csokas (2):
      overflow: Add offsetofend() variant of struct_offset()
      treewide: Use struct_offset()

 drivers/bluetooth/btmrvl_main.c                    | 12 +++++-----
 drivers/dma-buf/dma-resv.c                         |  2 +-
 drivers/firmware/arm_scmi/base.c                   |  2 +-
 drivers/gpu/drm/drm_edid.c                         | 26 +++++++++++-----------
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  4 ++--
 drivers/gpu/drm/i915/i915_active.c                 |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            | 12 +++++-----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  6 ++---
 drivers/media/usb/uvc/uvc_v4l2.c                   |  4 ++--
 drivers/net/hyperv/rndis_filter.c                  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |  5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  2 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  8 +++----
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  4 ++--
 drivers/platform/chrome/cros_ec_lightbar.c         |  4 ++--
 drivers/scsi/qla2xxx/qla_gs.c                      |  2 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  2 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |  4 ++--
 drivers/scsi/scsi_transport_fc.c                   |  2 +-
 include/linux/overflow.h                           | 12 ++++++++++
 scripts/coccinelle/api/struct_offsetof.cocci       | 14 ++++++++++++
 31 files changed, 89 insertions(+), 64 deletions(-)
---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261105-offsetof-f62aa6348f0d

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

