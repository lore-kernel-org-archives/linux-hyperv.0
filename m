Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.18
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793900023;
	b=0gxEYyHIc3wLuINZ+WiKx1TQ6XMGfap8A3MlDIZ77Xvg0JpmqE1fBduVGZHiTWV/PHwQ
	 D3nOJqQ/LNVdbHsuGB4YNKKAXjioo9F5Kt+wBHUiNoTQ3L6R5V4whwRyXIiMNTC4V3wRQ
	 CkE4rue1+YAgDmYSq5ttZE4+1uSA/YUmfweU+H6n58Ji236wVbd0ti/1K09hCVkAE2/DC
	 VZPFBi2IlndSmdQXkMR2uMw+4WnTOq08o2P/boU6wl6U9UKeSZZAfuk6IQ/sAlV4ri1Lc
	 S1rNO+DFaf9YQGTf8vGCFpjDOGdwqKY+ZsDNFGE2cjRDAbawYqkJuO7oLK4wN+h5WTA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900023;
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
	bh=eTpVa0KXLbeyN7w0naRmQVXV/ayHx+u2by3c7Xc6o7k=;
	b=N6hL9VhoGLs/6q6V8yc9qz6e99X6QHRziGOtn/MVqY9O5qFStoXaWie/buw9GcCM5JuV
	 loLnYrE7eOXg903SfBVY3ueVYPrdeMPMdoy+siZey27frauqctr7bTZg1o9UnObs+aDZA
	 GaRjdxiWhUYdOqMAeh40y1+ic2OkP+H3H52rCkg4hN3xEY5iKvTMHx6eFrNrlBQq+f44/
	 czo+07whVgTUsxyFroV9wZT0VoPprVufyP18aQUuPA17X3nnFz1e3ugRJSICeTzTPOFOI
	 GL3RUOvY4v7H1ritEwfLGL0/Fs8aE36Vap7Fjh8OZAUGsNYOlenE/HcwKROzk+vD9oQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CaIAN5N4;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CaIAN5N4;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.18
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847D606A328;
	Thu,  5 Nov 2026 17:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A847D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CaIAN5N4;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CaIAN5N4
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mXG4kSQGTEH3swGQhEJHb0f/ckEq8/ezy6NyWb8GXpfA+ibROciibs4IE7E1Tqg7Qiut088qRoSY51ySVHf+2amyP6Mmrz1VI/V6QKxkslFOO9tqRbNhErH+N3fTw0RiAVCFJd1dnSRU/SbcFdplJkQAjeozkWKolIoAtrBFNJ+rIV+fuQ7pzuQv9XhPATTCBSqmwBchDEIjZfC7FVfAk/ZokPYP4KwfWmHkhD/xQuEKb2PkEjedu34cWaSbFARP5S7s1H7mGmHLqc5oXPYc5hKgKTJcc6frSQJRjK7Q3cuaM1LxRW/CeW7XiIUCUVfsoCl1xDDAHvJTtEBmPXX0fw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTpVa0KXLbeyN7w0naRmQVXV/ayHx+u2by3c7Xc6o7k=;
 b=fqH+9bIB0/hpHdoOW0P0ve8UTPUib9sKojWkiU9RBP2wqPHLzjakihr0rM8mLsbHGmuCptriNGgodn06NaMMuThiozxcqd06yqMh6EbnR5B78/Fm2RlAmkSWONeAhhcIBQfQjrqaFAdYyv5/CV1rrslIu1VVRhUwWhFy6qBlyjCkWEatVMPiuijCRsKNqkWHlG6mmTpDdka7OfsUViiajjCAfWe88VfcNTMn3pLIKiUABgWfYJCKXvPEWZ5yenenBvP0odwlOEEVAzPH15T+Ny1/KsB84SLFDZ2z7gVpWM3pczZ3IY4UxHWWF1Jm81AL3PSAnursQNwetZmsbLyeUQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTpVa0KXLbeyN7w0naRmQVXV/ayHx+u2by3c7Xc6o7k=;
 b=CaIAN5N4KxHcigNOYRbk45xUO2LtjBwP1RcO6UocUwkLmLngtuH1PFm1W9qK070H8wGK+EAIvCMy1FmK+zskIqBAKkq1NYRD5QCr8KNA3xlgrYx00+WqKHZJ58CIKLbEGAkmo8kXeQNKaP/QVgTyeLDwpYmBJ5kP9HAUZ3Gm4Ds=
Received: from AS9PR06CA0263.eurprd06.prod.outlook.com (2603:10a6:20b:45f::17)
 by GV1PR08MB10838.eurprd08.prod.outlook.com (2603:10a6:150:16a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 17:33:30 +0000
Received: from AMS0EPF00000569.eurprd02.prod.outlook.com
 (2603:10a6:20b:45f:cafe::a7) by AS9PR06CA0263.outlook.office365.com
 (2603:10a6:20b:45f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 17:33:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000569.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Thu, 5 Nov 2026 17:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEZqCzho2/q+WM4A/n/O5lZPad5M03fWy6PydBnZ+pgD8xakqpjqKQ6yzLSqS9y1voz9C507lcDMwxeFMrZqYVA9Y4uxrld5ti01yE8ZMNkbbCd22kFKAy8CQbf0RXVo2BwPcwBX6ddkjgNINH3xiS3fhu7+Y4BnGPKZ61ukK31rrhDPeStjlKxEd5wwfYIZdto9ZqhnuyeKaZA/75PveSmb2cxOuRXr7L7sTPtX5kMapSYQ1d1BVkF8oOKJ5MVvk6ZvdWpLly4n6t8b5mu9U/Inzq06hBTh00rOMrwCa2/IhYypvdQ3fCeO0lchqdGchcHNya0LH1g14nFz+cQSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTpVa0KXLbeyN7w0naRmQVXV/ayHx+u2by3c7Xc6o7k=;
 b=cKmvEXKhg2kB4cgWM1cpqYzakFjRONndSFcXHpgnMGuwnfzUv/M2tx4fHwtGpMYEQrc1CJaVjdLszML62Xnh7RioTbXTZg3WfmVbj5+FYwXAiy6VBLWdKMWKlt7diBrXfStOI1+aLZAXIQBwl82A0KCpj6hA3RHcbX2tA3tZFGGijFRAoEbBypnHobn4JE6+bb+fOF9WRg6ssIspwaDJn/b2WUTKNOEeW/X3u5taONOZIeJlq66U4NQDi+Ru80g4kX6odBHezS/tEVY9iEn3A3srZlTIWpWv+r1k8GguIkQBUEU5cZVI9EOFNdngJ9r/+nf9Mysywjxr1kl/jfTTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTpVa0KXLbeyN7w0naRmQVXV/ayHx+u2by3c7Xc6o7k=;
 b=CaIAN5N4KxHcigNOYRbk45xUO2LtjBwP1RcO6UocUwkLmLngtuH1PFm1W9qK070H8wGK+EAIvCMy1FmK+zskIqBAKkq1NYRD5QCr8KNA3xlgrYx00+WqKHZJ58CIKLbEGAkmo8kXeQNKaP/QVgTyeLDwpYmBJ5kP9HAUZ3Gm4Ds=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by PAWPR08MB11487.eurprd08.prod.outlook.com
 (2603:10a6:102:509::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:17:02 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 17:17:02 +0000
From: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH 0/3] Add offsetofp() and offsetofendp() for pointer
 arithmetic
Date: Thu, 05 Nov 2026 18:16:15 +0100
Message-Id: <20261105-offsetof-v1-0-4153f5c10edc@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+57GoC/yWM0QoCIRBFf2WZ5wS1kuhXoofRnWknSMOxCJb99
 7Qez+Wcu4JSFVI4TytUeotKyR3cboK0YL6RkbkzeOuDc/ZoCrNSK2w4eMSwP5zYztD1ZyWWz+/
 qcv2zvuKdUhv9MCIqmVgxp2VMD9RGFbbtC8SiO6aFAAAA
X-Change-ID: 20261105-offsetof-f62aa6348f0d
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
	AS8PR08MB10291:EE_|PAWPR08MB11487:EE_|AMS0EPF00000569:EE_|GV1PR08MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: faa86ff3-27f0-4743-2be9-08df3b62e851
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|921020|11063799006|261022105027099003|56012099006|261026140227099003|261021123027099003|261009221727099003|261009223027099003|261009220027099003|261102123227099003|261009223327099003|261009221227099003|261021121427099003|261028144727099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 VVFJelSxgClgHU9Gtoq4Np58blMsVJiYNVkaIgBD3Kda8p7uFES7uDdvskqBfhvNllgGw/qAtW12NPqaBVdvk4ZYFfnQe8laSo4WN2wZcLuV+6Ls+MvKPlHwMhcfL1RbKgblJo4i2rUS4jjtMhyz9qo2xvragkBFn34kbxM0iTHnsaN+gPhD67b/IcF3r6HVLcTNOnHRFMUpcf0+iLjkpRnYRUbrab/PHeOmbGtNro95TN9UsPvdhO6PldzlHPKf7ZZNJlpOSOh7OwLdtD0zysxFHY/C+b+ylXuYjsxqMQp9b+9BaEY0xf0L/3c4iA24o34oyh+UQi6dBvRJrDf6sW65Bz+VcdQqeUAkV0fGA6G10BtY8jy14IU1qHwZRGJm81pK4CX/E/o/7Amv2GxssrvtcJxbffPt37eOt+KSCMhp2CiUH5XN1+ZBilitXmoJivb5+2OWAoS6HLj95IdkmifoK+ovvckzuZXk/tavkwbXj5IakXLNZKy0L0r8lbrSQHC1Jy7nsmCQzJ2YWOamUbE8RA1sTgFPOpaCWWY5f1bL+jIPUHlEJpp791vLT/aQpcpVxHyR3vrpDYKvtgzfMu9aQaV+owbl9mB/ToTaBlQPYyEwiDcHLU+UHpbFGGdh/O1LYM9NItuCQfFZYumxpmoXSIDncDmWCUStHnEWJgFdqQxNQg1EcyeceAdb8xthdWSjR5qTTNbbstdKE8Al0w==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(921020)(11063799006)(261022105027099003)(56012099006)(261026140227099003)(261021123027099003)(261009221727099003)(261009223027099003)(261009220027099003)(261102123227099003)(261009223327099003)(261009221227099003)(261021121427099003)(261028144727099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 i5Kdf4NVZB3qcEAKDEN8z3u/rEwYL5shrfrJ1u4X4MdMG+lv2DetnqLTnq31fZAnRYwiGzTgsf1oSpi6saZ75HkcUyx/3h98hXWOJlEPjrXUxg3OOBcysY7P3N55lMhG1Z2fNqG6Lak8blwYov+ix693fusE9l2kYOOApblXSbjK2x9WPTbcqM3wNFzOHQdk7H40neNVxiHnw60Ipx4+wODymJasqclub/qBHqK5Ml65fFKx36twCtDVU8LAtOt18dKbnZ0OUi7tvrv1F/Lty2sqVckwZdsOrP3RcW2owtVjVO0adkKnEIafdOw9MKYaTfJCIErf6dFsSeTV9WbIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11487
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000569.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3915e4d8-3158-4aa3-5d0f-08df3b609ba5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|23010399003|7416014|376014|82310400026|36860700016|261102123227099003|11063799006|56012099006|261009221727099003|261009220027099003|261009223327099003|261021121427099003|261009223027099003|261009221227099003|261021123027099003|261026140227099003|261028144727099003|261022105027099003|10067099003|18002099003|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	TiC57Jp1OiF7musqhydqmi8Oi2+2zKmDGjKLJetYzaPgbv+lD43Rn1mjloNe6QgPqzmVjl8hXEUT3JlaI2ggAHBjD3xM+Xoy7dhTJduw9FEPbO3MvfVvSXQA6RXLfUvrnUZ7a7MQVJaz6TxnheumbdO0yIBy/vKyC7Jd/PowNBazkK7xHm/hg4nOHLZu5G3LX11VVqHxWjDxhUm0mXIQ8b5lr7QUUEXah7ktfF/yCS/PuKNlmAsqXf+qRUn2JugMEfFg6zhbjbBKPDMJplm+jLGgoRFw8lHMxWymVAWJ0zURkEOF3aXWsYR4nJML0g61Boe7No6xW/Y+ZCdkTS27xZ+fHZRmVomeq98cQmYH1S8VaTHlnvA77db9QMNzKmhA/GbPCxPZ3wAiS3KobkO+esOsOMgMrPOjJXJK1mBuBwFtcB69d4jiXa7QdKhfLGsbzMcNILh0XXI16CPQ/8XOROt4AQk4n5KeEse6TpJxZpSXfI56aDxYt0psG4IVDBBfAsM+Cx5/+uDOxNJNFhpNBTz6gdvP5+6PVjN0RGNMjRZ2V9dGpdE9qtVXQ2ND43hqrZ9Q/WvWDjFrWER7xCJgx8aOuVG//x5J6SoyrWmc7zT8eBV84ldU1VNbKwgwy1A934KUTPG0dqSnNNszKO/EmaQc3ZbUAF4ORosrHtYh5ioAhr2qnpb5H5dnEdKL6L57luOMTnsWqX5Jzxl98z9ZKArZB1II3R7qibwJUTEIisY71N4QWx39BSCxJR2sE5uk
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(23010399003)(7416014)(376014)(82310400026)(36860700016)(261102123227099003)(11063799006)(56012099006)(261009221727099003)(261009220027099003)(261009223327099003)(261021121427099003)(261009223027099003)(261009221227099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(921020)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FjljGvFdDw2Jwzqeu1MA55V9hP8p5UO5QuV5ikByrZ4os2BxZ9QEbok/YJzGlwzo7P2IuLEpttPoE3ollD0qdkhopi0VUe3VLBHiDGiKR3lExI4NlS5cCtoKYDV3/WzXX2pEkq80o/VefEUBV/5So0MjPreGe1Wb41EylLdI1jjVRmPMWx10B2NuyHOawNWkqWikVsfyCdQWaas+o+fVUElVI+pwOSaSFmcp+cVG3nrgseqhKF3C4LVcOZzTkd7XlD8xv4EMBsAhWmpKnuaapHaYDERZ5dHBoJtXFW4UO44Mx/jVGHfphNehP/Sh5Eoqkns1mBa8PFTkALCyb/1vqkVB5+iagPQ/p7eqaaQV6gPWkgQTqDp/M1YDeEpoY+mi3TQNQMZ/iVZWnqqOu2PK9P2jyljbnthWCmSvZXheYdoa2oS0r98jRzMAMF1qLXMt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:33:29.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa86ff3-27f0-4743-2be9-08df3b62e851
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000569.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10838

A common usage pattern for offsetof() is the following:

  offsetof(typeof(*ptr), member)

Condense this operation to one macro for a more maintainable code base.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Bence Csokas (3):
      stddef: Add offsetofp() and offsetofendp() for pointer arithmetic
      treewide: Use offsetofendp()
      treewide: Use offsetofp()

 arch/arc/kernel/unwind.c                           |  4 ++--
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
 fs/readdir.c                                       |  2 +-
 fs/smb/client/cifssmb.c                            |  4 ++--
 fs/smb/client/reparse.c                            |  2 +-
 fs/xfs/scrub/attr.c                                |  4 ++--
 fs/xfs/scrub/attr_repair.c                         |  4 ++--
 fs/xfs/scrub/dir.c                                 |  4 ++--
 fs/xfs/scrub/dir_repair.c                          |  4 ++--
 include/linux/stddef.h                             | 16 +++++++++++++
 kernel/futex/core.c                                |  2 +-
 net/bpf/test_run.c                                 |  2 +-
 net/ipv4/ip_output.c                               |  4 ++--
 net/ipv4/udp.c                                     |  4 ++--
 net/ipv6/udp.c                                     |  4 ++--
 net/key/af_key.c                                   |  2 +-
 net/mac80211/agg-rx.c                              |  3 +--
 net/mac80211/agg-tx.c                              |  3 +--
 net/mac80211/parse.c                               |  2 +-
 net/mac80211/tdls.c                                |  4 ++--
 net/wireless/nl80211.c                             |  2 +-
 net/wireless/reg.c                                 |  2 +-
 net/wireless/scan.c                                |  2 +-
 security/landlock/net.c                            |  4 ++--
 sound/usb/mixer_scarlett2.c                        |  2 +-
 53 files changed, 113 insertions(+), 100 deletions(-)
---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261105-offsetof-f62aa6348f0d

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

