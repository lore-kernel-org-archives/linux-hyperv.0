Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011026.outbound.protection.outlook.com [52.103.13.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE78379ED7;
	Thu, 27 Aug 2026 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794067; cv=fail; b=WvlK4epQsPhMwwF6iQEHQlq25tO0hTocl9Hgd3puWLVFVrNIyPsyxu95mFpSxu3I9ncsFuB9UazVuKP5hSLalZwyqwVB7r234sHDl8tZSU2FNC9LMfhs0lJmuRFAzD3+c05y4BMSAO3EX4XAqdI84zPR063jf8VYxD6GFgwpUNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794067; c=relaxed/simple;
	bh=iEj9m25Pl3hRzFM7f5AmB28pWjG7Tw2sji+VTYqzlhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ux0ulYDt4kk3XdpUkVUwsuZp0Ad2ApcpcFGGuUZS2V4GRq9eFf/1JiSmfj2GBTiqo8f/mb/It3eLrlT5Ihl1vWaYwtcBnTW0WMDPHuMAAymat+6xlqCPjlYaz/HybzFBaTNZD9Sqxr+1KEWWNO8JgahZkjC3UhEyWDFsyjtnE3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z2zbOIil; arc=fail smtp.client-ip=52.103.13.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z2zbOIil"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL4Za1LfFsNNwzYSgYY3fP2YSlTDg0Ao8EiaqDUkk4R57ba6USV/+me6zR4Wxtp0V/ebXC/4+4AzQouCdgCTmX+pppb2H36/thyif6a2t/f1x6Ow2gngLbh0A1mwn/7pd0JxrFDdg0/d3SWrVcwVzmIweYBdZOPgdAHpzLrD6AUKbKqzwoDXN+NJsMouWIhU7FuxzrDTp8zUw/EvGX+NBt79qzf00rILd0/Ep2xvZIvBdSfsM6qEIet39gteFH6jHp+ZSYJz4jpcbpKeSxkPa+vEyKFGVI7zefhBI7SMAPnHZpgHQ5nUxuyYkhppIQgov0lZAC/C0cWHQe0ZA5OJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6fgpKsFU7Mdw69G8VDMkRBG/78wo8k7TDtDvNEBIro=;
 b=R2EJ75iXOe90mvn7mf8WTGjROaEYfVkscrrDEv0GVbZRbIqTB9sVoP3mXWEEVekf/dYCmyk55Cir2J6RSHEHnjgb7d9lbd4TAq0LGfKheQO/GmJbOxNhm6BWPu4ApCPEl1kxq5szphpZFR6/1KEcNDEvTCC/8EGGGX4hZLMU4aVOUEJj/sarJ9ZGjaQcQkfaZU0KzzFhLhnYytZbF3ARJlsWQvJhRvvuzHpGh2wSoc4tIsrDPZVB+sHBZyn5XhNW3eNfvkqG7eYNI14TeqjHTJJLYr7HKyqb1WwK8V6ZDZQrrNF3nlmDpDEMAPWgR0cfWgUVLP3ecdJys1QPQr9RyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6fgpKsFU7Mdw69G8VDMkRBG/78wo8k7TDtDvNEBIro=;
 b=Z2zbOIilyXnVDx9A3KASJRF2nNB38K0vJJ2RVDFW9hUShsCWIAegY77UZ1DjdzWQfgkd3SOnzQ8SEh2y33i3PGxIA0LsAfwCoVBzabu9+dD5M136njZ25jmlBrvgHFk7NG12HSxb9RPRSwWCF2ayXCOtfMI7JgSFEEvbF9O63xPR/ITkIiBaFm9w4fug57FE2W2sz3n8bWgOF8p1bn06tiT12c6X9TCwxG3VZMY7DdViQYuaMWAOrfsolhHPfCrlSF0D2SumRGzQJWJ1AX5UBIuknna8H4cso8dIGNcQFWZtCmMZHGBxdZsf+SXJ7bhaG2KWJaVKboLJmFInUj3fYg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB8922.namprd02.prod.outlook.com (2603:10b6:208:3ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 01:27:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 01:27:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Waiman Long <longman@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mikelley@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Topic: [PATCH v2] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Thread-Index: AQE7w5fZMzVdfDN+OK0VQkM8ysSdk7fz6X/w
Date: Thu, 27 Aug 2026 01:27:41 +0000
Message-ID:
 <SN6PR02MB4157DA1235176B70C4E542EED4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260826192509.529838-1-longman@redhat.com>
In-Reply-To: <20260826192509.529838-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB8922:EE_
x-ms-office365-filtering-correlation-id: ef1a6cc2-5a69-4b5a-8e4e-08df03da63a9
x-ms-exchange-slblob-mailprops:
 obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2qt9d2MohOOkGQhLzlUQfKZiBuLWH3bcKH+2RK0cp46IYdioedEWm7xEyEWmdGfbCkzJhPX7dxrHK2315JTq4vioMrmD7/uD99NkdG5erTGAv4mZeLfUnx7duSJfyOC1FQzXt0bC9wIjA04HHmIIvbwB0dCV916yPE70H2z2/0gXt2v/ndmlSr3SSQBozh5xVuJloGnEpKn8Bl37ytbct7MMKi3TItbq6k6ASPyUzXt6rwiVJfVlSQufm2Yo1Fa4LuV52RGrF7O2lPZamphR6gWHYEQ70W8tdyXzKwaCaVOkz3YiLVEwgT+DUELPKIqmJr0LkvT9ZLQ+guRvJFZr561kiZm4OukrKXlyFbnAKepPIrK4YQN99Nu4mOgCE6dxuflbhOZ36XKKSlUCE6xajsFikhmyz/kprJkM8sLY+6r/Um3Re5A4A7AenH15ILWX1wrg6IXGmAcTchGCOnI+v6Smt8RGReDUZhnfaYN+uOuLzHc39ISIK/QlP5Vhje8OBaEqaGilPrANjwRivF6dkt8g6fqgmq6vlSAtBHpjG3ThBt8+6Uk7HujK5jqOdn7qEF5LJbFUAWBhnrMSgi8Qk05/npL+HY7sbDI9tqmeCj8UWUZ1HqLvhVsgeXVJLiLi4j3pSOBt/+IhoTUvCFytmB8/ge2WKiYb2n8n3EIxEg8Bv+Xw2hiPoMDLwIu/t0O+8SNYsMzSBAXW1kowzQyAUEiNfkwWQT/eOf3TZtmK8GYG9IaTvq4fUSpde5zBaLiSe46A+1b+9v65I5ydXCtui5VrLwP5+SN2j
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|31061999003|51005399006|15080799012|13091999003|4140399003|37011999003|55001999006|25010399006|24021099003|40105399003|1602099012|10035399007|1141799003|2607281247196008|102099032|440099028|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CW4n7EFlx8ASbR5NySZWF7WFoQ3Nbmm65Kmm8FaU/uw2V2X/6kR359jgjd0a?=
 =?us-ascii?Q?YFTYuXGImTkAPFDR9y0NGqVMtiKIT+blTYfBKTsZxXFfBDfruzoHQPvAPyLk?=
 =?us-ascii?Q?1/44JTVd0PYumDI3AMDfhn7McyvScbHZ1a3lXzUpZOtHBfXPn1lFqKJFu5re?=
 =?us-ascii?Q?6b4s+EPeq1zKY5ADXnNpMDBTt4Ci2nAmKrLC8J1uET9vHbwL4j4jQHkiw+rk?=
 =?us-ascii?Q?7o9W7uvoONTjOQ2HlFEkgPm9xZhBIDr2dco0jOu5QLIFNS/Wfg6946/IirCT?=
 =?us-ascii?Q?DlrW5qW0Y9bMdV1Ol+GmwaPwLpDesfnPSEUC11Fp1FXFYJgZftecYzInYW1S?=
 =?us-ascii?Q?vMxHUJ9NPDSZNdQ6xF61AHK9ZSZXlCn8th4/d1sAZu7rHsNMnCBLPMVvVhO6?=
 =?us-ascii?Q?mlLph6/9kFWa2d0h9EFI61LcIqCiEsOJ1+kEwwXVtlnyINSTXCCsauAYYvJ1?=
 =?us-ascii?Q?Pw97F5xS612qWFnhdbjkSFkATdLL0U4uzPw1hZselJ/xFx32/Kq7CPkE/i1x?=
 =?us-ascii?Q?yZUb5WdYPsCFgBDXn6FFq0Lc0+auTWg1gNo1Zw7V/fRdUBXTSDKZkmhEkIFk?=
 =?us-ascii?Q?UFxUXApbFy4vip7o/6+bgnLCWsOWqAJ+PbLvKuU7ZYTtd0LIakB1XqRXw/n6?=
 =?us-ascii?Q?PzgKYS/OzDdc3ZTAbgPn9zvXXLdWJpUXpvuKVYq5QpneU5s/CVyTrgKgWnoO?=
 =?us-ascii?Q?mHsFC8eteZSoKhYSH2wqSOlTt2KXsc8/flahzhcfxL3aXCtBp+byj64AOexR?=
 =?us-ascii?Q?LsBx0j5foH4oTfnWMNVgc01WRM2P0FsGUQ06uzmUcNRXOSOvNmiSFLkgseoV?=
 =?us-ascii?Q?BgSloqpgFUOPIOpOQ4zteEMBzJluNXmUYMgStP3Ei6W34mx7BXj0LgzX5lrc?=
 =?us-ascii?Q?BfOv9PaYyO70ggQNXBMXwtltHp/xiOm1A5ckPUydimmeWpEnu2+Dhyd77J/X?=
 =?us-ascii?Q?Fn4LRMYTZxsZzk85aMxxhpl9FH3ARkRry7ESnU5IjSCkV9R/2IBgi0ug/6aV?=
 =?us-ascii?Q?Gzq2pXsfBnZsf9r4i6a4RJKorGug7hRC7wCMi/CB6CXMvmGdYJdvCP2UFqtt?=
 =?us-ascii?Q?c1M0oFYPLriedqI1Su/e1UN3sFhbWlWyFGwdfigtcd2ak4oAf2c=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6YeMwJ6LzDaKHfCv6yQy3bc/gN772fTcB+GJqi+sVx4F1ptA9+P8vDj3l0/c?=
 =?us-ascii?Q?Qw14RN+ciFNCSIVr1nOM/jSiosEQwaXjp/N06tDSCs184K9zOxwk/idkLdNH?=
 =?us-ascii?Q?xlTmEjmfzfjBRHRVkZSaUVk6Z+Dj0tCMgFtklawQ/HSubdAZtogB/9U+cSmu?=
 =?us-ascii?Q?lHg27ojMYUh+rukBIQa5Vhrr4qSd0tcvi5kl9khZ9pZfcSbBhWlBaeX3cMS8?=
 =?us-ascii?Q?gJwk9vvYYUY3bN7TA/aeY2zgfEWoulHkP7wsjbQpvJ3UYIavM0txPDt8PUkt?=
 =?us-ascii?Q?H6dtpOQdF/UJmNoeSRbLbgfDgwnVVzz3a7wWT+76238+pb9yvOz/rADto9gm?=
 =?us-ascii?Q?ljFRoBYTO7gw0nCeKEvEk58dV4peEJq6xSOHvrlq95mbyeLi6eiYg5Ccuolh?=
 =?us-ascii?Q?7EcXdmN8MzXuuadRTi1Uk+41Dc8eLdGGoejftIOMzoAX1zKS5u8pr0/ONMrR?=
 =?us-ascii?Q?UhP2B9q8iRAeDDqt/ygwexKNBldpNJ1JhTNQ6lXBa6ndfmtYVZi3+MKb7Wej?=
 =?us-ascii?Q?pcWWa2wn4KRGbkaQmJVKlQm5PH0kFTy4VG3X23nsjEGLgZzDiR2HzsVlzmdn?=
 =?us-ascii?Q?dnUqgqtvVo4D90yepK8rblddKMc5xRnoMKKiR/0vXqYvuEhTmqeZbWD55wQn?=
 =?us-ascii?Q?cf9bY6wPnNYiKCfH+qhusSKgBa75bkk/LeFx+DN3W3dX686VZ29GwoizL7cI?=
 =?us-ascii?Q?DDLV3XOS6HHdM9hmead+nSTWpBhNtw39cizK3K1/W0zJ9MR8Fl1sLAYazkr/?=
 =?us-ascii?Q?6V2y6gh0AgVlTikWmf/2gv29+GvEysHZxIXJ59e29XWs06ZMWO6sNsug1xYc?=
 =?us-ascii?Q?Lx4gA/qaPDfOHX5LY6OPEgKs7W4qlggUIFp7zsNXHTnaanlim7Qip0IDjfeb?=
 =?us-ascii?Q?iRDNkJFl9peRZSj2svCfUiRmexIUtpwTzjrxXkee7fztKlkrNaU1F3Jq8o5Q?=
 =?us-ascii?Q?8LmDwymROro3Jms3Nxk+dNAHc8X/Fv5AuH2PQ7JWkO7RuOY4HRiYLRDCTA3U?=
 =?us-ascii?Q?lrN0oWXniTYo3mw/UjWuXjrEX4HX20IB7Dm/dUuRPAlftrpQ4Vbs51i6xWXv?=
 =?us-ascii?Q?izFo5aZOZOoYK+6iSSf9azxfDG6Fpvs/lFGzWGkGLs7xoW1QWFf/UkKdXyG9?=
 =?us-ascii?Q?vhZFdNNco3pWoLLYOUcdi6+NcAbC++CCF1NCKFTMklnf/UimQ7eLu+IojPnq?=
 =?us-ascii?Q?kDTzRW6SIZ1wJuAvn9yCWACHFEpBr1mPLYrAKMFG0dIoudhBe9YatEJAVI5M?=
 =?us-ascii?Q?GhtGtl5kjx1Q+E8EneHRHWB/YVEjM1kwIXt5cux0ehR4LK0BTtEM/+Wsfpjw?=
 =?us-ascii?Q?c+Ysa1uE7al0PGRoC5gi3xW9/9XNWByUSl+rLlUWxlOhnR9BwoTJ3cyhrGGr?=
 =?us-ascii?Q?IRzQHpQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1a6cc2-5a69-4b5a-8e4e-08df03da63a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 01:27:41.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8922

From: Waiman Long <longman@redhat.com> Sent: Wednesday, August 26, 2026 12:=
25 PM
>=20
> There is a retry loop in init_vp_index() where the CPUs from a certain
> node are stripped out if they have already been in the allocated cpumask
> or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
> CPU left, the allocated cpumask is ignored and the process is retried
> again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
> out not to contain any CPU in that particular node, that will become an
> infinite retry loop.  This particular problem was reported by sashiko
> [1]. This should rarely happen, but we still need to guard against this.
>=20
> Fix this infinite loop problem by skipping to the next numa node if
> the allocated cpumask has already been cleared before. Set target_cpu
> to the default VMBUS_CONNECT_CPU instead if the for loop is ending.
>=20
> Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.ker=
nel.org [1]
> Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel inte=
rrupts to isolated CPUs")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 89d214dda360..e80ac9fb5ed3 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -793,10 +793,20 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  		if (cpumask_empty(available_mask)) {
>  			/*
>  			 * We have cycled through all the CPUs in the node;
> -			 * reset the allocated map.
> +			 * reset the allocated map. If the allocated map
> +			 * has already been cleared, we will try the next numa
> +			 * node. Set target_cpu to the default VMBUS_CONNECT_CPU
> +			 * instead if the for loop is going to end.
>  			 */
> -			cpumask_clear(allocated_mask);
> -			goto retry;
> +			if (!cpumask_empty(allocated_mask)) {
> +				cpumask_clear(allocated_mask);
> +				goto retry;
> +			}

As you describe in the commit message, the core problem is a NUMA
node that has no housekeeping CPUs. But rather than add a test
here for that condition, consider that there is a "while (true)" loop a
few lines above that cycles thru the NUMA nodes and already skips
NUMA nodes that have no CPUs. What if that loop was enhanced so
that NUMA nodes with no housekeeping CPUs are skipped? Then all
the existing machinery just works. I think this approach also
addresses the two Sashiko comments.

> +			if (i > ncpu) {
> +				target_cpu =3D VMBUS_CONNECT_CPU;
> +				break;

Can this condition really happen? Won't the "for" loop always find
a housekeeping CPU in some NUMA node? If you want some
additional robustness in case the "for" loop doesn't pick a
CPU, I think initializing target_cpu to VMBUS_CONNECT_CPU up
in the local variable definitions would be sufficient.

Michael

> +			}
> +			continue;	/* Try next numa node */
>  		}
>=20
>  		target_cpu =3D cpumask_first(available_mask);
> --
> 2.55.0
>=20

