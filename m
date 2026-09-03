Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023108.outbound.protection.outlook.com [40.107.201.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7939E190;
	Thu,  3 Sep 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462603; cv=fail; b=dqespJYhgph7g2AB9i0zFoaoIAEQDN9db5yW69WUnIz19JhIoYcsaS1clqR8mz7wV4FDR7vkz8HcUe/qIfesgChQfNag2rZvP8bpiRVusR1oAOlddHJHO5IJPpjxScp9scddZ36BcVq2R8rMxnZ4zpCezp4XFdhU0ZX+rooHc1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462603; c=relaxed/simple;
	bh=xbvHmUNc5QSzpGXePxxIGTMA1y3z4yQjmXpgUqs2Z+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YN4bF1Ov5BmBR9zB1+8tADJp8wTHuo/9utBCXqZCEBgizWRSPjE8d9izqZha/rii0bUjWTxhfLF/Dm9NqHY/o2ykeiu+SBwg90rm5LF9+Eq43EF7RbWi9yUwK/pSuStPkaruVQ1yCb/nCGI/ZFrqRrqhp/vSvpngiOk76m5EnGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SwZMmhyh; arc=fail smtp.client-ip=40.107.201.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SwZMmhyh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChkXXJEG6j/3ucoCTX2q9SqZkSdyyVE5GatS72wInMFHhX6+qVduLWSTclqcHfvNeEk7d0T1ZhqtWKmNOc3PebJMcs4zGFzZYIAsmAqU35lcKa+ZjMS0AJDltSJgoDsf0J9RGPuYfAVDXBuMcw4QIOF3NTbuPFGF5obTGheHIR9jvJUx25SD4X+DqobC9Jjn2EWGrVpOOveA3PfhlAZbSCoXOiR1GtsvbKfZm9+JePUElS3tMrL/eQOAL5vjfMUS9kSMfffF4hYk7xGRlYMcKHiuoGUdMXB1FVWmTj0Yl2bGVejjOkUtJIhqiuYBjdDguasewMm34fLeo99kXp3aQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbvHmUNc5QSzpGXePxxIGTMA1y3z4yQjmXpgUqs2Z+Y=;
 b=rGmJG7wO7udac4hSWxmmTGF/CZu0K8e9anXmJqThqCNAuxf47RPnGJw4KLSkIJE9GA8u2EhP+PWKmrPZPLH5brc0Kd7a7qliVDOxAK8DWcueGqd1K8sYFNw5n5bXfABbKrgoyZoRewhmawaf5Om/ofyqU6C2cih2eM8EmhsD6+B00WBKUUhSnz5io+QI81d9gwWPMDm4V3AO+o/w1FUtaNlKkOrEoHDBcPULEx9LdG6F7m+HslsYiw1WAu4meK76EYzTn7qOf9ReqKG2a6Le+ZcNM6UKMVjoS6LuHYEOBt/fyp10WE8f96FeHV61Qlfltdd84M3ve0zsfO8CguQf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbvHmUNc5QSzpGXePxxIGTMA1y3z4yQjmXpgUqs2Z+Y=;
 b=SwZMmhyhqEpL5LM8ae6f5/IjmFPk0c6ei7TqPZW2qSEjK3MhagvNwLQ2bzXj8Ki27Q0kT4n9+urNwf0WCywlcmtxEEl1/F6fC9iVdXoSKm479P7mCuS/vC2ZgfkRClTKFlYjh4QxmKyVtg4h7afcMDIQi8Az/1y92UXrZ8AJWFc=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV0PR21MB6354.namprd21.prod.outlook.com (2603:10b6:408:332::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Thu, 3 Sep 2026
 19:09:45 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%3]) with mapi id 15.21.0406.000; Thu, 3 Sep 2026
 19:09:45 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Manish Awasthi <mawasthi@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "gargaditya@linux.microsoft.com"
	<gargaditya@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "kees@kernel.org" <kees@kernel.org>, Paul
 Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
Thread-Topic: [PATCH net-next] net: mana: Use the HWC destination queues
 reported by the hardware
Thread-Index: AQHdO9PN33CeLyVpOEO0+MXxUWNVFba9N6Fw
Date: Thu, 3 Sep 2026 19:09:45 +0000
Message-ID:
 <LV5PR21MB4704A903574D88C6591CCFC3CAB62@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
In-Reply-To: <20260903184104.3194819-1-mawasthi@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=97933465-fd28-4dde-804e-dc7ff8e4993a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-03T19:08:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV0PR21MB6354:EE_
x-ms-office365-filtering-correlation-id: 26459b7a-130b-46ef-dd42-08df09eeeaab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|38070700021|56012099006|10067099003|7146999003|921020|22082099003|18002099003|7053199004;
x-microsoft-antispam-message-info:
 wCth6FfCp9nXV8vhPlx9cE7J91q1bd1/eUcmrunHRq/hf2LDXPbFp5BG9jmGRRKp0YPE5uCxYL+CewCxKRY+7BZRwq9ZSp6cQHbVm83hVIayh1M8+MjTy9381lkvZzzQyx5xrN07bkM3IhkoHYK0DhEXqxKgPCVAdhZlf8bEhlXBnYfJRaYBOceMbzncqOGlvptlCHUt1JOJ/RT23POrXYD1/18kqC7+7ro2nJpSQdF7GIBD+aeWPBwXlxO60cS7tgG06IbyTkU68yvq9x3PsSwoVDKHfV42MGGUrr+HcXOI6ySBu8WbF9TMvSLpz5+RXvYQpS4FaZxIdeBZbrQbS6+wQjpkAvfjJnrxUlNnxsltXsE4V6rs/TL4HdlDnOIc0WIW4tcl8HgSGJoKt1hhHfF9HabA4vqN04O7ihRv+N4Vjkwnblt9pS1HXlcX8w/szmGS6rh4FQ43Fv1V3UrIoEXKU1yXtTnLuO3tmQVdVW7wappjszvdKN0Q7EkEYOQtbyamUTueLGs5mC0YRnL7Q/p6i3H4QEx5Lfp6jk7C7jBWABkI80jLBaaD1EvW04oE26YlP8hLfOHxb2qSObNqoUCJEV5kUDRO4q7KOFZc4dqaoZOi11CJKLU6JNjyj7iD9MZ08v74JbpM/beqNkuWFcHpebCcwSRw7zyDiDb6OwEc8yPzNNTwGFeeKMOOHJf049mPSR1mCqKCfX5NAF3AXI35JhK7g+Uy77JAWmLyZFun1z7rs4jaTobuzRy/3xRP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(38070700021)(56012099006)(10067099003)(7146999003)(921020)(22082099003)(18002099003)(7053199004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3sVnQRN+NYx/jsk1lpolIF+GasZv0wsLuwebFgFKBd9gHAaOHAHhIkTdB0zC?=
 =?us-ascii?Q?Ip71i46tuczSa0P3bn1qcLTDKbOSr8A8SsmQroQdqRnq3muNbDXgrBTe+VP4?=
 =?us-ascii?Q?96UIVOC1RX3iYTNB2wt1HsLo49UlB+6/+w7wJ84t0fHWcbLqSI0K/wXlvizG?=
 =?us-ascii?Q?bIuHmUxL/1CJVWqKSvLh/eML5KTqg4dGBZw1aTjVLFDTH9RXZuB5TfDqmPV/?=
 =?us-ascii?Q?Q9lGll/NjBZm1bOYcQkbHjxLH7a6lw+UvEHq/RimZpDCPdWg5bGYtptFPnNP?=
 =?us-ascii?Q?mX6Yb237c5SCA4ZOkDRhI3CzptNOJPlOwywFDeKG2iFU5cQIuONQ9PTzJTPZ?=
 =?us-ascii?Q?yt097tztnr2gXmw5KVSJdE5Zoi2IpW1j1rIed888JOo63vJPVi3oFvdjcza8?=
 =?us-ascii?Q?uwB3uvRjKPxWHrKmQs16Os963vRD3z1F5QVCKZ8uoZWwkFE4Ex1PqhhGKuIv?=
 =?us-ascii?Q?xRVp6zI00T6qetW606OA3j73V3euarYY62YGVs9lzLDvPdLS5Jm1ivy0C6hJ?=
 =?us-ascii?Q?dhw+mV47jE1/hFJHasWA6mkCMPNp5V/mBT12P2aicpNmbk/NYj+uFP2lpyen?=
 =?us-ascii?Q?meyg/X2C0ddKE2cS1Cn/m7KafpTKvtFRwO9ZIsgyjjJcdxyjAAsc9sgrOHV1?=
 =?us-ascii?Q?uYkcOyKvLOGMg8D3YF97tqMKaIqby2ihHzUfViWZczt4/FA0powGFmZxpZrm?=
 =?us-ascii?Q?mprW6wQLqjDirs8X4Y9lsNMfAPF17bJb5YqOMUCbJyTlVE952R0nuTkGCcpC?=
 =?us-ascii?Q?E49OGURzFoQuu3oThx15tzu5WGEqC86VUrQFuH2HGMqGDeKAsh+aTZfRAMlU?=
 =?us-ascii?Q?tgYReHC847O59f5Hlt44n4FhEZb7lS1L/gAnCGN66/kUOewL18IvPaoZdvRi?=
 =?us-ascii?Q?0SGxLrjw7u0Qkx9bfdMuuPHlUhPJ/YlKFd5vYxrQjpDdY06RurGjSsRgL3tz?=
 =?us-ascii?Q?Diy+M85JgLdQIzoWyGi9Wf5/IOgqldDmUj9E1zMexoOYa+JvZdZjSHBMJgSc?=
 =?us-ascii?Q?rMLGrjKE/CBuHqhmPBXZ/fzkhNsyscOsS1YxRomFjii/SCZPnI4ZtsXmfzZi?=
 =?us-ascii?Q?t4lb+8JVyBIQscmd5X155pNJa+szQczKidz0L0KVx40TobZcNiRzdgvNUT5P?=
 =?us-ascii?Q?wvZtk0Rj8rD0ePPqiCwoPyTIL2UhKIgT1dJYadm2m13at6Kwrdb7luHkNPD2?=
 =?us-ascii?Q?5VQqiKFtU+s7iLa0NfD1H5D7v6Faay/AX2kduGcTNPLRnobrICb9wjYsTS4j?=
 =?us-ascii?Q?dOWGE2+vniEUWHOoYuR54SXQBybn8BSdhM8nmTQvLmJXq9AinVrB/3iQseY5?=
 =?us-ascii?Q?HGnPxCX+NAX0TYrcjh2F085HtvIsa1vX25FDy0D6Pk0c3xOw1k0KC7PaCDC8?=
 =?us-ascii?Q?zfTx5JHuuQUdY17cCQXklVJp8qGdY76tM7lPiMnpZJIPYUyEq1LWKf3QtePj?=
 =?us-ascii?Q?Ko/K0Y+OBJ9nI6MhwgOaIjwHzENpbuvOZo1ZEGKn20GUHM2m12eF8PtVxo5J?=
 =?us-ascii?Q?lBUytUr/spZhvakwpxDWwBpNNWEpFoqedEfM67Ihw0nxwFzHxqz9Mdv0FOTL?=
 =?us-ascii?Q?CkG+SmUqh0Kezs7HW0XHdY6j1pEgbxAuq7heTzSIyhLruPJDz/hkHQlvOaqX?=
 =?us-ascii?Q?q3dspFCMH9ouzk19df9X0kKO6WSDIYmXbs/qBhYj4tEhrCNJjQjPmwDNgXFO?=
 =?us-ascii?Q?pcngZGIr875hvwOFULWfWYR3w6RBGtYqfm1Opgr7UGeu977gi72H33w4C80I?=
 =?us-ascii?Q?e9RL9nXI8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26459b7a-130b-46ef-dd42-08df09eeeaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 19:09:45.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7sg973PVhcfv17NDkz0YTl4u5DxpO2ZZHZoG1UrTe9KGhlZKrC0foXFEmVu93lJ6XUKR0JyQ4vPixZngr2zmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6354



> -----Original Message-----
> From: Manish Awasthi <mawasthi@linux.microsoft.com>
> Sent: Thursday, September 3, 2026 2:41 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; horms@kernel.org; gargaditya@linux.microsoft.com;
> ernis@linux.microsoft.com; kees@kernel.org; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: [PATCH net-next] net: mana: Use the HWC destination queues
> reported by the hardware
>=20
> mana_hwc_send_request() gates the HWC destination queue IDs on
> gc->is_pf, which the PCI probe derives from the device ID.
>=20
> The gate is not needed. hwc->pf_dest_vrq_id and hwc->pf_dest_vrcq_id
> are only ever assigned from the HWC_INIT_DATA_PF_DEST_RQ_ID and
> HWC_INIT_DATA_PF_DEST_CQ_ID init events, and the hardware always
> reports values that are valid for the function it sends them to.
>=20
> Signed-off-by: Manish Awasthi <mawasthi@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


