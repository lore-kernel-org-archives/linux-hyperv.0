Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011034.outbound.protection.outlook.com [52.103.13.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E32E7367;
	Fri,  7 Aug 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115540; cv=fail; b=D15blOuiHnQR+6mcfav5XEyBC1xNn/FHJ0hIjJGNaH9shili1tx7QXlAha7UPgCasImRS8seEs6OSsodNMDlC5FO2yvj9oEQ0o86WjQQNlux3cmkP898HMvM74XtMtnWh/lmlYwwFtUQj0XLYMpXwiXlyeSM9vU7twKiFk+Ocu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115540; c=relaxed/simple;
	bh=QRMlAdvS9yLNamSGABYhUhiQv7q8101kZQH3lhXcvug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4Je/8qiDG8tCnMx0/j5eokYYFPdScu8HIkK6ud/qTR0vSZqbH0jN/ENl7OkzVmdLetjhDixscsI2EjCxG0ge6zkWM04nnY2D7nZG1OR95qu2AF4VldGECgImxuppq1FcT8LtIqYvcMi5FtMl3ZeNFYpTCh8C/vPBrkotRQGfXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qjjQ6Qr1; arc=fail smtp.client-ip=52.103.13.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qjjQ6Qr1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPd2sVkp3uH049WGjXibO/lmJ8kJ5Dv1OJ0qj7KNdoPPFitd9KAgQQVxTdRYW2m7sfvw7gvny5mZWcTdgrWcaUZ5G7hSz9KLvMzzFTaiXadNkmMRIJbcJc6h9NvRpMC7DJwGfL1aQ4liIZF05uvMBs5lQQ4PzK0HGhQjfCU6ATWAg/JPOzF4gdZzT9nxwyxKdNpQuv5w2o0TVTvUmhW1arCvamH7AHPqJyiWeg5pb/1V5dKM0IRp9DhgELp2o3dF/ler9dNXhWukR2499B3shrjkcF5RHCu6R0sVe4PgE1lLPjHCbhWLM/S/pLYkXElal78yaU+YnkjM73lYoE1Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwrkvCwhaiWzZz2UumVwHz8PSzPS7P+6AqSeqN+1M80=;
 b=QKpcknMDEIZjuC3X9BjfCG7FOpEMaksr64jiVJLPGwJOh9FD1vOqaFfXLz82K4V2R86xVsLtDW53tz8bvr5qI1i4ePBc1K5ICEMK1Qq7OL4M+46HiYpYBG2wjDuIxwmBDvauRZuEfDXDJDt8Dq9xxjLPVwwN8vn4BSyYuSPIbZG/S5Pm95KSrp9LjcKtUVGfI+wjGbKYGwbETpBurpdDeMCSAdGSYnrOaQsBF3IUBASiEOvprtdxnZlQs45QC78uEq+qNtOZGJhXgE9/xygaXAClXWHraUyZVW0+FchCC2X9FIRBG7/zaNhr5A3IgW9kf+SvvIi2ieqE3IeVAYPuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwrkvCwhaiWzZz2UumVwHz8PSzPS7P+6AqSeqN+1M80=;
 b=qjjQ6Qr1vqYW76qlwUZ16CEX+cklb3RwE7BkLqzsR3jXZgF2RwFtSh6s2FIvQ6WN6gQJ/BYyobSazHLyQia2mQipVoxci4Ga0o520DyBXgy1geU4B5NebT2jpELbxAXVWcaEQNS+NrYgJDazWIfrGGOvdGKLBh/9Iw5dNs3ISejb6nECvmM4oPg8kr9Vwy4Ku2YtNPkL6xjxgW19/FIn5lR1VQ0kKe3K9zzWzuOEd+d90ol15ZFY2uLptLyWhhEa/pA1FIT0VZy+FyiTI/4NpldfvRhvF2mZ0P0Pj9O7o+7QAMUJV0I0r9T5Dj9V8qTq8IxWTBhDWfFGF2vd18ASAw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:12:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 15:12:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Michael
 Kelley <mhklinux@outlook.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] hv_netvsc: Allocate host-visible GPADL buffers
 using vmbus_alloc_buffer()
Thread-Topic: [PATCH v3 3/3] hv_netvsc: Allocate host-visible GPADL buffers
 using vmbus_alloc_buffer()
Thread-Index: AQHdJetWKi6adkjYnkWK5oSE2wzG4raSsmOA
Date: Fri, 7 Aug 2026 15:12:09 +0000
Message-ID:
 <SN6PR02MB41574CBF5814ED5855924E99D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260806213326.1425848-1-kameroncarr@linux.microsoft.com>
 <20260806213326.1425848-4-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260806213326.1425848-4-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: 2e43be7d-1329-4ea5-8887-08def4964099
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|31061999003|51005399006|13091999003|25010399006|24021099003|55001999006|41001999006|8062599012|8060799015|19110799012|12091999003|260806224601699003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+nO1tTe5XFPiRwDzwwFfSNxTKWvugMKBpL4754Z7rlHy14KFhQadKFW5HBgg?=
 =?us-ascii?Q?++cL8qY3alcbttH5q9ndq1ZexDymQQDn9sUFYvRe99F8juHzX+NbZZNjrctX?=
 =?us-ascii?Q?jiV/flmu6BOMOPkf7sOfGdBLj4VbADIyD8bIrlxw1j8smuzJWTc6ZJRBv5WW?=
 =?us-ascii?Q?IFuEPlg41rcp+YpTNR3ljKALSxopbag9oABtxl2xB0tXrD6PNDq+OphvGCaw?=
 =?us-ascii?Q?UKsGdMidXCdtYzhLn+gBX/Bw9XZh1EBEm/jKPdk46R4pZWJt/uDXYXlawOzo?=
 =?us-ascii?Q?JJKSB0RPrMpSOr9GzA1TgusCPmW402Xphf5khg4P0Y05E0P5IgeB2JkF0HAR?=
 =?us-ascii?Q?oszbtGERp/9iUtPGVCyLWA4JneDWy8w4gnUgFpVJWeYz4Br7dqeCJTYj/FJa?=
 =?us-ascii?Q?UU35QYmFL+cBk+rtFsru8swAY4UfCnqr44Oky0f/O/hl/Va3L51V3+wwOxn9?=
 =?us-ascii?Q?UoCshuTcNaW+KcTAE9GAvPT7Mz9w4ybqtLhSBxs018pzDUMZK6I59kYt34h0?=
 =?us-ascii?Q?bzvw1D0S/LeAvNJvX6YF7LCRHzr70vl/1PT4VRd6GeQObaW7vnA5LV0yKnK4?=
 =?us-ascii?Q?2Yi5BRfouKG8A/SLNMJpJ5EDqZ5w3tMEqknnBZ7kbRjMpAgLEz3PHNRA+35T?=
 =?us-ascii?Q?FvjWxtVCX1ihqff7PEBwGEPVXBJrgXiCEbM8cI85QmK0TfCbYVaVW8+5QKXr?=
 =?us-ascii?Q?pUBXGaQymtEkUX3xN6uNuO3Dkl7THB+ycd4b1pzkWw+qlQDVF+TjOVlYW3jw?=
 =?us-ascii?Q?OIV/qxn/saaojxm5IkN0ZxNNWmUsPAz+rquMEBviPhR1eCeT6RLa0hYb6yZU?=
 =?us-ascii?Q?skDs+Ahsl3l9g4v5+/A/oT5iXNSM6+D6C+Bf/tx6NdoowR3UOE4WFYht4zCB?=
 =?us-ascii?Q?7WKnrYAy5GZP23/xDFrf71mwfTdSQNY/Tud5ueHwzhGOdvEr4wSbi/ivnXbF?=
 =?us-ascii?Q?tZooY1Ktprl14vnuICgLLhzg0YBymcPMFdNFjpjIkZN3yJV8lWE8qZXNQuRj?=
 =?us-ascii?Q?fQ5hRJy4myfY4HdqaiU0t2Tr4uW1/u4NvZRNGkNcivjKv8t51XLJ/nvkzDgY?=
 =?us-ascii?Q?fpAwfjCsLcI/bMZudYvo7ZSC1pLnJ453ednUA2rbissESK2ugtdicQiIRsnw?=
 =?us-ascii?Q?Y7CB8BgTKTBmPxce1+gVFiBC232zJB0Wkn/SSkYLDuK8z7XCIGYQroM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hkexx3SR20taKGwMyqyQneWVNgjWIIo6M1z9W0nSNXqhN0dExLn1hVHs0huN?=
 =?us-ascii?Q?tFJKrAboFJZu10CDTyS2nhcXcRcNK+LwHOz3qWucXB29tUKJDbas5EKM5I5/?=
 =?us-ascii?Q?wr89CMaeLVNk8j7vuXRWh9d2ibnXieYDQ6jXmmeKxoWnfxknXOlo+vAGT0Z+?=
 =?us-ascii?Q?cD0cvX0KSHWDLiR9mViXi0YjvGOzrrIdqO8VElOPPfIQvsjf5oGRDrcfsmdR?=
 =?us-ascii?Q?TsuE37UY/SrOmTGTtqoesQUmqMTgyX7VPc5Uds7JBJiojZnrFCgyqYISFvNy?=
 =?us-ascii?Q?rrmKlPU4dd7pXZTHPMljsdqhOqpY6nrKg6zTN0Ro2YwJcJ9NvK6OVJgDFVf9?=
 =?us-ascii?Q?XKQBPv7fbQgZbSCm4dYCgS1Ac2VMmF4mbHpDoM9lTkcF8Y+hyKFK/MIw/uWj?=
 =?us-ascii?Q?jFR6V+l+SNSc+XOi9IQrxWMZkUbNnl94UtaIfw4P7E201AK2qpvQhIG4y1bp?=
 =?us-ascii?Q?c/2dCt18TwejnQKFahY58KmOAnXq5L64YMcLfNm0hbU4sEQVl2ZZPNscAihk?=
 =?us-ascii?Q?IhDDcFoiq8YkVkJX64CqldOAkdIKy9iuNu/qKDqY+oCq2YnRQOpvo25ooGgE?=
 =?us-ascii?Q?lDFseDmPwsI0wedyhZFshV5/lzHyAwfY7IV4IFaUpiIDnXM77/1BN6MZJ0nZ?=
 =?us-ascii?Q?Mp9KHW8D4yECoBZPVQ/cvKoFxZY63Ir3mfoj7XCeWcziMDSYFRGMcH2kKt6i?=
 =?us-ascii?Q?1W1wLoly3PBnuXCvIJeT23Xg+rvX2oUc16NNaEVYW/6haM0acOQ3m/Qhlh54?=
 =?us-ascii?Q?w4rzMzEayzU+buQIFKip2vu/dG2HHVlEIDWDMRNgMrz3s/bs6SjtolSaacM5?=
 =?us-ascii?Q?lBGytsOQyq8yiR0X0oGzIg/ZK+pnsnTck/+wKlMwi/keF9eX5aJGSwNCDrAu?=
 =?us-ascii?Q?KOfm8uWvt5TYLsT/eMopDSUYHe+RQVvnRbUa0PNHhnhONMGmblmiMdxuiNnc?=
 =?us-ascii?Q?koGYmCyLm/XPdihlSAVC7kXAgIsDCl5ldcM+eZLucPt6007kcK20vW6dixs0?=
 =?us-ascii?Q?XWc6x+Jod7CCxXeJ0AI4u+5dyu3B95/E6W86DOCM8x0iwuzTy65wdfg6LNkX?=
 =?us-ascii?Q?BBd9mwu+TB6n7icaGu+GUUiVIUvHviH3lmIItQCFq52Pk2mooOlb4YRUTroy?=
 =?us-ascii?Q?e+1gCV3R5fU/p4foDSepUWR0JFKqhez5idVkVAAQerQsFswPzFP2InRug0Ro?=
 =?us-ascii?Q?JOTHe/Cbkwj0Y8q/v0q3JUpiynQsOdYY3jV1tqkA/hJOtES3+Rjp0S5Blmr8?=
 =?us-ascii?Q?LEOYrmokixUZHp3fsUgUG884ZuJ0b+jgWkQWmMxkRNkvoev7cZidDwijXlBh?=
 =?us-ascii?Q?pwjv1Jhtnwt2XVRpzXx11RJQo9llvBV0U/fdGXHfBz8C55robeJZZSIlaNPR?=
 =?us-ascii?Q?pyDoNIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e43be7d-1329-4ea5-8887-08def4964099
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 15:12:09.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, August=
 6, 2026 2:33 PM
>=20

Nit on the patch Subject: I'd quibble a bit about calling these "GPADL
buffers". The netvsc driver calls them send/receive buffers. A GPADL is the
mechanism by which the Hyper-V host is told where they live in the guest
physical address space. I think a more precise Subject would be:

hv_netvsc: Allocate send/receive buffers using vmbus_alloc_buffer()

Your commit description describes them correctly.

> On CoCo VMs without confidential VMBus, the netvsc send and receive buffe=
rs
> must be made host-visible by decrypting them. These buffers are vmalloc'e=
d,
> but set_memory_decrypted()/encrypted() do not work on vmalloc'ed memory.
> This use case is (so far) unique to netvsc, so solve it locally rather th=
an
> changing the set_memory() or allocation APIs.
>=20
> Use vmbus_alloc_buffer() to allocate the send and receive buffers, which
> will make them host-visible. Store the list of memory chunks in the
> netvsc_device struct so they can be individually freed later. Use
> vmbus_establish_gpadl_caller_decrypted() so there is no attempt to decryp=
t
> the virtual address.
>=20
> Appropriately free the buffers with vmbus_free_buffer(). Because vunmap()
> and set_memory_encrypted() must run in process context, replace the
> rcu_head/call_rcu() pair used to defer free_netvsc_device() with
> rcu_work/queue_rcu_work(). This also fixes a small race condition where t=
he
> buffers may be accessed while being re-encrypted by moving the
> re-encryption after the RCU grace period.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Modulo the nit, looks good me to.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/net/hyperv/hyperv_net.h |   8 ++-
>  drivers/net/hyperv/netvsc.c     | 103 ++++++++++++++++++++++----------
>  drivers/net/hyperv/netvsc_drv.c |   6 ++
>  3 files changed, 83 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index 7397c693f984a..4841367fdab2f 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -220,6 +220,8 @@ struct net_device_context;
>=20
>  extern u32 netvsc_ring_bytes;
>=20
> +int netvsc_workqueue_init(void);
> +void netvsc_workqueue_destroy(void);
>  struct netvsc_device *netvsc_device_add(struct hv_device *device,
>  					const struct netvsc_device_info *info);
>  int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_=
idx);
> @@ -1158,6 +1160,8 @@ struct netvsc_device {
>  	/* Receive buffer allocated by us but manages by NetVSP */
>  	void *recv_buf;
>  	u32 recv_buf_size; /* allocated bytes */
> +	struct page **recv_buf_chunks;
> +	u32 recv_buf_chunk_cnt;
>  	struct vmbus_gpadl recv_buf_gpadl_handle;
>  	u32 recv_section_cnt;
>  	u32 recv_section_size;
> @@ -1166,6 +1170,8 @@ struct netvsc_device {
>  	/* Send buffer allocated by us */
>  	void *send_buf;
>  	u32 send_buf_size;
> +	struct page **send_buf_chunks;
> +	u32 send_buf_chunk_cnt;
>  	struct vmbus_gpadl send_buf_gpadl_handle;
>  	u32 send_section_cnt;
>  	u32 send_section_size;
> @@ -1193,7 +1199,7 @@ struct netvsc_device {
>=20
>  	struct netvsc_channel chan_table[VRSS_CHANNEL_MAX];
>=20
> -	struct rcu_head rcu;
> +	struct rcu_work rwork;
>  };
>=20
>  /* NdisInitialize message */
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..c59f2a44badf0 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -28,6 +28,8 @@
>  #include "hyperv_net.h"
>  #include "netvsc_trace.h"
>=20
> +static struct workqueue_struct *netvsc_wq;
> +
>  /*
>   * Switch the data path from the synthetic interface to the VF
>   * interface.
> @@ -125,6 +127,47 @@ static void netvsc_subchan_work(struct work_struct *=
w)
>  	rtnl_unlock();
>  }
>=20
> +static void __free_netvsc_device(struct netvsc_device *nvdev)
> +{
> +	int i;
> +
> +	kfree(nvdev->extension);
> +
> +	vmbus_free_buffer(nvdev->recv_buf, nvdev->recv_buf_chunks,
> +			  nvdev->recv_buf_chunk_cnt);
> +	vmbus_free_buffer(nvdev->send_buf, nvdev->send_buf_chunks,
> +			  nvdev->send_buf_chunk_cnt);
> +	bitmap_free(nvdev->send_section_map);
> +
> +	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> +		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> +		kfree(nvdev->chan_table[i].recv_buf);
> +		vfree(nvdev->chan_table[i].mrc.slots);
> +	}
> +
> +	kfree(nvdev);
> +}
> +
> +static void free_netvsc_device(struct work_struct *w)
> +{
> +	struct rcu_work *rwork =3D to_rcu_work(w);
> +
> +	__free_netvsc_device(container_of(rwork, struct netvsc_device, rwork));
> +}
> +
> +int netvsc_workqueue_init(void)
> +{
> +	netvsc_wq =3D alloc_workqueue("hv_netvsc", WQ_UNBOUND, 0);
> +
> +	return netvsc_wq ? 0 : -ENOMEM;
> +}
> +
> +void netvsc_workqueue_destroy(void)
> +{
> +	rcu_barrier();
> +	destroy_workqueue(netvsc_wq);
> +}
> +
>  static struct netvsc_device *alloc_net_device(void)
>  {
>  	struct netvsc_device *net_device;
> @@ -143,36 +186,18 @@ static struct netvsc_device *alloc_net_device(void)
>  	init_completion(&net_device->channel_init_wait);
>  	init_waitqueue_head(&net_device->subchan_open);
>  	INIT_WORK(&net_device->subchan_work, netvsc_subchan_work);
> +	INIT_RCU_WORK(&net_device->rwork, free_netvsc_device);
>=20
>  	return net_device;
>  }
>=20
> -static void free_netvsc_device(struct rcu_head *head)
> -{
> -	struct netvsc_device *nvdev
> -		=3D container_of(head, struct netvsc_device, rcu);
> -	int i;
> -
> -	kfree(nvdev->extension);
> -
> -	if (!nvdev->recv_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->recv_buf);
> -	if (!nvdev->send_buf_gpadl_handle.decrypted)
> -		vfree(nvdev->send_buf);
> -	bitmap_free(nvdev->send_section_map);
> -
> -	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> -		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);
> -		kfree(nvdev->chan_table[i].recv_buf);
> -		vfree(nvdev->chan_table[i].mrc.slots);
> -	}
> -
> -	kfree(nvdev);
> -}
> -
>  static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
>  {
> -	call_rcu(&nvdev->rcu, free_netvsc_device);
> +	/*
> +	 * Defer the actual free to process context: vunmap() and
> +	 * set_memory_encrypted() cannot run from RCU softirq context.
> +	 */
> +	queue_rcu_work(netvsc_wq, &nvdev->rwork);
>  }
>=20
>  static void netvsc_revoke_recv_buf(struct hv_device *device,
> @@ -351,7 +376,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  		buf_size =3D min_t(unsigned int, buf_size,
>  				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
>=20
> -	net_device->recv_buf =3D vzalloc(buf_size);
> +	net_device->recv_buf =3D
> +		vmbus_alloc_buffer(device->channel, buf_size,
> +				   &net_device->recv_buf_chunks,
> +				   &net_device->recv_buf_chunk_cnt);
>  	if (!net_device->recv_buf) {
>  		netdev_err(ndev,
>  			   "unable to allocate receive buffer of size %u\n",
> @@ -367,9 +395,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->recv_buf,
> -				    buf_size,
> -				    &net_device->recv_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->recv_buf,
> +						     buf_size,
> +						     &net_device-
> >recv_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			"unable to establish receive buffer's gpadl\n");
> @@ -457,7 +486,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	buf_size =3D device_info->send_sections * device_info->send_section_siz=
e;
>  	buf_size =3D round_up(buf_size, PAGE_SIZE);
>=20
> -	net_device->send_buf =3D vzalloc(buf_size);
> +	net_device->send_buf =3D
> +		vmbus_alloc_buffer(device->channel, buf_size,
> +				   &net_device->send_buf_chunks,
> +				   &net_device->send_buf_chunk_cnt);
>  	if (!net_device->send_buf) {
>  		netdev_err(ndev, "unable to allocate send buffer of size %u\n",
>  			   buf_size);
> @@ -470,9 +502,10 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
>  	 */
> -	ret =3D vmbus_establish_gpadl(device->channel, net_device->send_buf,
> -				    buf_size,
> -				    &net_device->send_buf_gpadl_handle);
> +	ret =3D vmbus_establish_gpadl_caller_decrypted(device->channel,
> +						     net_device->send_buf,
> +						     buf_size,
> +						     &net_device-
> >send_buf_gpadl_handle);
>  	if (ret !=3D 0) {
>  		netdev_err(ndev,
>  			   "unable to establish send buffer's gpadl\n");
> @@ -1863,7 +1896,11 @@ struct netvsc_device *netvsc_device_add(struct hv_=
device
> *device,
>  	netif_napi_del(&net_device->chan_table[0].napi);
>=20
>  cleanup2:
> -	free_netvsc_device(&net_device->rcu);
> +	/*
> +	 * net_device was never published, so we don't need to wait for an
> +	 * RCU grace period -- call the free routine synchronously.
> +	 */
> +	__free_netvsc_device(net_device);
>=20
>  	return ERR_PTR(ret);
>  }
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index ee5ab5ceb2be2..1d43c73fd73f1 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2867,12 +2867,17 @@ static void __exit netvsc_drv_exit(void)
>  {
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  	vmbus_driver_unregister(&netvsc_drv);
> +	netvsc_workqueue_destroy();
>  }
>=20
>  static int __init netvsc_drv_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D netvsc_workqueue_init();
> +	if (ret)
> +		return ret;
> +
>  	if (ring_size < RING_SIZE_MIN) {
>  		ring_size =3D RING_SIZE_MIN;
>  		pr_info("Increased ring_size to %u (min allowed)\n",
> @@ -2890,6 +2895,7 @@ static int __init netvsc_drv_init(void)
>=20
>  err_vmbus_reg:
>  	unregister_netdevice_notifier(&netvsc_netdev_notifier);
> +	netvsc_workqueue_destroy();
>  	return ret;
>  }
>=20
> --
> 2.45.4
>=20

