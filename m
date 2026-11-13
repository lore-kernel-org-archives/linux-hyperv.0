Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.10
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794586966;
	b=P1bdP60B8whS3WCMvffHfdSWDCIVuotaIwriFUt7KZCE4t0pGJjlOmx5C2hOu9dSZh0b
	 Nsp0HOMGPN7jTEgTa3EYmSGfVSKmrWkZps0xAZ98hgJ52KBwT/G7vWroiQWy+xeZ1N4Nz
	 94NHyljODBbvkaZlvJSjowi+8pTF8/LlnyaKt3qr9RKAt9hB0NbNtKskaUoCcIwmgzc3Q
	 rx4/teYHs6sFUEWtjJpDwG0uk7LP1dWsr7F1LbFVkNetWsMh/qI7llDFrIg9BaX3CodD5
	 LDB1/dbkrCVi9FlWaRLJ1/eeqY1l8b5vaNypN7h38oPmnUZAp8RGaKnRHHdVZN+4kYg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586966;
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
	bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
	b=b5vfne7qkSIDVlvjFvWI90DqVnr5YTDMKBbqDJN698rxS3SO8GcoO6DmtZGfis7S05mb
	 ozYcEZqfFvm7bG5zBjCfk08nrLLeI7JaOCG+jlDyQTs6a/cSh/yrt3+1Vv8s+5EIKkh0k
	 klsJq9V+ATwj44vIpuRZLc1YMo7QcAA426Dk3FtmCARhP7L0XlMyZZMTVuNj7lWmmIERR
	 e+p7yzmuNJ0QbD0gDZVDxLKNKCXVsdxJ46bZLEXCCmub780x2MvCgpeawLvjesABFjN+b
	 rwDaX8xfQaKBq6k65xzyg7QVhoK11rltPlKKu+jM6aTbGHkk2NrW14nsLw41enloY4Q==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NvZz2bE6;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NvZz2bE6;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.10
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E09606A88A;
	Fri, 13 Nov 2026 16:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E09606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NvZz2bE6;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NvZz2bE6
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lbHKdDKBMT8Ybl1vt42TxvAgzo0AnKM2nEABToCvTw9J+TO/B/Rtvyp+FEgffPY9UbgFabK1RFH3h0tAIMsFSZFHt9w/SMFwKTxll1QrCPVMl/bd62AZPxw7+HgCFRZuhHFeM7c5V6Hm/zg5Kyad8UrWqpQM/NI7U0eUZCEWaBK3lNJ1GfpGr/b0F1g73MVt9h8PnYnsXaIsEDEXyoZNVMItm/+/KNAiRuDrPxN6MmuN8hSRl0zDDGdfZVrlYnHI1//3Gz+LLeQlBL65+KimKWuNr7W4tXhj9Ln1rvqWGLGQ04yeGFUS5lYuxM0+44bvTYZN1TjroPjAorrPtOeJ4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=GjIljsPAIS8bJBCaD+Eo7McbVnlTFIQlwHZjNAnoJOHC1RuR8uII8ZxJGABrUpYU5Xyyy26BjksEdXEbmkqmiknjaO9pJh+oPROpAIzPnCDxR5Yxs0OmHN0Z3t4YBUIAxcfPGQfIVqq4EgXaiUd1WPbZ7DEqwx6MT1GFlMx0beUxzAT4ccfjAaVRwAgeyE+Jw2bya3jylOh8a//NWP20kszjoyF0EroFv1/6uR1gdvO7ua9hr8mnmb5ceQ6IYp9PP4TG0ClvS12ZZOXe96H5JHPJWortLQg+jNlu8e0z5fe46+w+PEgtTGCsqOOVAasU6hJfVQn30uqry4QFrdtodQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=NvZz2bE68FZnYatQtSACeOS5Vf1XGXRSgOAeKuDs3WLKZCtCsZbP4In82MAErAhWpj3/lJppphRrZQHf7Ttc69/84thKRRRuIFyrSvZ4EGayUUn7T0/3EM4uA4XlMCYsv8FLWLq8H9lbmw6XCpVIQv+5VjnLDqIxvN19lW3NYcY=
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by PAVPR08MB8823.eurprd08.prod.outlook.com (2603:10a6:102:2fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 13 Nov
 2026 16:22:36 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::1d) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 16:22:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 16:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIevjqXP6rqYn6SPz/EzFNTbRKsy0SWeA89BnxWfAMIKKJ3FwLOqxZZ9Gnb1vvKb37qVxQzJa2beOCjMQIQDT8x1ZdNrQhnyGjpAR8zPIUXsSwFU7N5ToD313A+PVCATf9BceQTJWVExDu9VVMaTvNxVp9IutHJtBM+e7d3ZE24KjgObHWE6kR5KNY4g1j2K9onHYy42eScACE3avCqdfg1hTGibAf4d/q11jjwkh7/KKtouzJKPI6H73yxG6xfiFAO1oGNg6olgPHqaXyOODECq4wqZGSiRwUu5/uGhXm0Mi2yF5HWi34vF7lKz3CQPAOHfFkcN+SwRUrmS+RUEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=rCg3K/UFSaOgX9MfvXQGt+lt0YOpiPVwf4tM2itV4wB6kwymPdBW8gs4Eygt/WB8pwnWym/8bGCgApEnlF2EnO1K59LHQ5II3af2p60Ji4Ur30/TFJ2pqGVBCZvxZjUl2SKpNmLKDJYNS2VzkgrFovCnURciDnTVgZ3bDIhB3HMYl3fxZUYFtSbtOZKndquiAU8zj1BzM7cQFLRNhjzERA62ZPUm3/ySrhtM8fyVEwZUoX31m+GTMnV9NxotomcqQbPBFEmAn+z+7E6d15ej2CpH7o/BX2b8l7KwNG9Mi4j7yw3CLCP00//SHeapJn9H4kvk5ir5f2LCXq4fmu4J1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=NvZz2bE68FZnYatQtSACeOS5Vf1XGXRSgOAeKuDs3WLKZCtCsZbP4In82MAErAhWpj3/lJppphRrZQHf7Ttc69/84thKRRRuIFyrSvZ4EGayUUn7T0/3EM4uA4XlMCYsv8FLWLq8H9lbmw6XCpVIQv+5VjnLDqIxvN19lW3NYcY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by AMDPR08MB11367.eurprd08.prod.outlook.com
 (2603:10a6:20b:717::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:07:56 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:07:56 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Fri, 13 Nov 2026 17:07:31 +0100
Subject: [PATCH v3 1/2] overflow: Add offsetofend() variant of
 struct_offset()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-offsetof-v3-1-714df7053893@arm.com>
References: <20261113-offsetof-v3-0-714df7053893@arm.com>
In-Reply-To: <20261113-offsetof-v3-0-714df7053893@arm.com>
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
	AS8PR08MB10291:EE_|AMDPR08MB11367:EE_|DB1PEPF000509F8:EE_|PAVPR08MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: be75a0c1-b71e-4dc5-6eab-08df41a2540f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 cgohRSNMpMKBbobTSm55F8mEQA0JGbcOuUJWYft1s5vIZRQYAyUnlssiqYW/Y/8/IP3EaqTkHT0u1ZY7MQ0Gpvp0hAM6uI8qulrClo/dWuKA9rYWaQoZUgHgRV3OqUZozidtIpexh0jfGn5e7P0ZRH6AzvyfYWgxcbOMuIgHHQoWv8qIHw7RbN7r21TI6TgBlRGp0622nz5d74Q2B07zuEXSd08DyY7wWph1PZuK89e6fhs6I4zPjS8j0HoOk1jj7vC0DpIM/xIjdoyLLjPTXZBpSqKNbRL0XibZg56oPfQgGnlD3H3BrTfssvZXt9Lt6LwFPQDtB5a6Jf3FtoUZ/gBw98e67PK2V83TvNOXFGKOQa+MkqZApBtKWudN37GcI9m9M6bVieuMlGvNvSwQyUJo4wnvayBn2yBiKl5qvzubksMP77hSJR2LchW3tFzRl4UYrF0QhHaQ0IAKjl/JvSdLtWwuu+PuMX2HOH0edazkVmY6Ll9nZXJ1ndR8WIhnhInRIumNNRaQwAHjv2te9ic6d1ajeosK7CGKlwdNdXhiqasNYXJDr4wXB9H2+05MC1C793P23RQZPL+HbeU3RkVCiOwO4xeCOpN6R1DlmWOf5p3vHDstMZCL+GUO3ycfk1tPFZVkueBjYw+U+BZeViIDXytKAL3ImaYcA7rX7ty6dpdXxoVWOQfKpgBkaXmty5UNM9psNvVrhzzCDxiKhw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Aeso0tWjR1NsAQGcOTTwej4iNXR1YuqhFw3PAejSIEQw4yJJoNiRcwxWjpbMmJIFJSsUQvz6pGmFneue8MkPridAuIaHhdkRxwbajg5UQWcEeEiv2HPqqs/Hz1MNFQHcH9yq0qxbFoWMPECJNr5lThj/IqhXYdQS9VnevjLGvVtGDyh8gw0yLAPDbMiWVyBWoWlZy7HjX8Y54BhFRl8x9/+9Zt3pSFY0dMxwsWIbgflQVr64in3i+VWFiSGTr/DL+pB3IyzkAYei+90blv9pnTC9HRpGxmb/rYybsyjzpPyBb9xnad+nvHLo7Z/Zhs23ftQjsKZlOLGCGjTKOZ5JYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bca17853-6648-467b-4fd7-08df41a047f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|36860700016|82310400026|376014|14060799003|7416014|1800799024|261022105027099003|261021121427099003|921020|261026140227099003|261028144727099003|261102123227099003|56012099006|11063799006|10067099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u9yB0c7nNv7J2OlNWpLkgHnWE6AH5pDWA6rRJyulDXpbo4LM5bAiFIkxVK2qkEMroXIrVZrR9E9BchuUJ8rOeocFe5ihSjjD89zvB+pJyD1li+JobYJLfrpMugcUM5aVLpdX+ZVqTvKDT/tB17FqdniwBJhdhIaOsRlMze6Go1mU3Ticmax3QWet5V0ualCa68jii/lMGWTas3h0A/NLuHJq6/Idx3DecdrLV2gCazNvbVmRVYeI3+YlF0gCKm994ZWuBJVLdM+2DQGSdWkBUUitWuXhi5nUkebdswVwAZId9vBdt3Oq5MjC9/3WZ1O2PMJKEVjKtSe9ABeRt66UF87iLD2gn+q5PViIaJ26E934fd6O/EKm1u1kvF2bQPGyqJOTEVFgH27+hZN9zH3hbClsnPWBmRh+93oFYMB3W5XBaG15dRUU4wuj/sX9tZYVLmQyJYbLBRY9rtvUsobw9OrloO7x+pFg8TvWXTDMH8Sfc8nDl6pLYRo2PFfx+fwT9SXw2vxrcC9POpyR2esSYAaRc5So8Kd3vDpxk3PkZNWR7G2akNBqhDvoKe2hBG4ZyXiZ7k/Ke2gjH0awzzvxFnOB76MPbPWjKtDygzX4mVOarCY0g/Wv5T0hjpXp+NSq6P8lopXPy4j/BLhTq6FrDM9Guh8feXw/GBesxhs0Rz7FM1G4CQsCVfErJUe0Zbt8HpqNcMyRpwNcaZ2pVtgpxjX+ZG27pE3fAmU7fASna/w=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(36860700016)(82310400026)(376014)(14060799003)(7416014)(1800799024)(261022105027099003)(261021121427099003)(921020)(261026140227099003)(261028144727099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YGqoS+yle8yzwWauMxhRrQm7kUlLyqpCwAqX5nr9NTm/otLXvOo+jfiuA0H7NxfoOZ0iQGi5qYNI5hfrqrWNZw4Sr6J4tzWnu8oKGyOdnyMLA61vyfsJWgagY9EwIf3X9U9c94gE6Zqz2EBxNgkmbDcWQQ0pCU3hGIEdXzYRJub6a9GJwWgzxbndMH6WG8/yHUl0LlsJemRSy+DpEjPKzqnd1Xf3nrQwX2jeJ87HvOptcCsfRhDq+fJQw51BXU23Kkizupy39Yw8hayhJltkmSLQgf1k8jhAH4hi9DJ0W1pybXxl2xjOluOeLEqujOuXhnp9dKkM3nEvNu8CcLwTQeTYoX0wjdL9oEiPKcOcFOfxrCCCssx9ynLVvFRd2ZsneKWy67MkcLu3T0bT7elH0yWEnqvMymCVCRL/EPovBLgyeAeMVedorGTQgN8DP+dE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:22:35.8207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be75a0c1-b71e-4dc5-6eab-08df41a2540f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8823

Many call sites of offsetofend() use it for the purpose of pointer
artihmetic. Thus, a common usage pattern is:

  offsetofend(typeof(*ptr), member)

Capturing this in one macro helps keep lines short and terse, while
still making the purpose clear. It also helps discourage spelling out
the type name on every callsite, leading to more maintainable code.

A similar struct_offset() macro already exists, so add an offsetofend()
variant in the same spirit.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/linux/overflow.h                     | 12 ++++++++++++
 scripts/coccinelle/api/struct_offsetof.cocci | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index d0f04436343e..c029d68daeca 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -464,6 +464,18 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
  */
 #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
 
+/**
+ * struct_offsetofend() - Calculate the end of a member within a struct
+ * @p: Pointer to the struct
+ * @member: Name of the member to get the end offset of
+ *
+ * Calculates the offset of the end of a particular @member of the structure
+ * pointed to by @p.
+ *
+ * Return: number of bytes to the end of @member.
+ */
+#define struct_offsetofend(p, member) (offsetofend(typeof(*(p)), member))
+
 /**
  * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
  * Enables caller macro to pass arbitrary trailing expressions
diff --git a/scripts/coccinelle/api/struct_offsetof.cocci b/scripts/coccinelle/api/struct_offsetof.cocci
new file mode 100644
index 000000000000..6cbc5596d673
--- /dev/null
+++ b/scripts/coccinelle/api/struct_offsetof.cocci
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use struct_offsetof() family of macros
+///
+// Confidence: High
+@@
+expression ptr, member;
+@@
+- offsetof(typeof(*ptr), member)
++ struct_offset(ptr, member)
+@@
+expression ptr, member;
+@@
+- offsetofend(typeof(*ptr), member)
++ struct_offsetofend(ptr, member)

-- 
2.56.1

