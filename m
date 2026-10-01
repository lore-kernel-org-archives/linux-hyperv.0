Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011010.outbound.protection.outlook.com [52.103.1.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170F53A381;
	Thu,  1 Oct 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871269; cv=fail; b=mlKnFsMPPQvOlOGsbC5MNDguKX7GAAD1UI4XPWKf9y3t+NjrghH560yi/triCC7Rzcy3Q2MMDZlsL39Dgg4Iya2cAM+4yUBW8eqSl3mPR0wXlPK1Yy4gBzqkkW4JI6j9/tE7/qVFgapfrS9Ra5Zq/MOevmjZdo1AMXOmpY8aN5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871269; c=relaxed/simple;
	bh=DAvL8RgUEhBj58nCQi0BR0pwqV69AvpmG2o/gCXPxE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMMQ6ah/AcSVpKIv6l/VU2wVl2Qtl2plgKKmkdtYZQla4nQPvui2Jxmzb0/cuXTKID64NSiOALf/y1F1DC3+loS6DSkVSiAz4EAHnNeXkptFqaavoPm/wK2nnKDK0Uk8kr6oqoyHGHUNKgGRMxsrCvmANYCZJCZ/kd8KJeysGIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EWbDsIVd; arc=fail smtp.client-ip=52.103.1.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EWbDsIVd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyAJSZMhXYe4ue1SeJTt3GxliRi3gJDIFuZVOr/Rp3U3n8heihv/z6QoueoZ4gpMSZZhdjGjpuNHrkqbqjmcT1OtzaMyWHK+mqhGFT+RAQYumFL8Vo4FO0H3a75fIdwy/0LdD1v5nilsTdu2425Aw4IV277tRVVGtRqhtQvUS51M1QK+vI7pY77DTxImQU2M+QI11HPwtqeVFc9Vk85Nx6Pa/ubzmylU2b7BewupL2pKMB+IJUzTMu+1tGMO8ZCldoXKkGcn4tJQcm3K5ZAqs/UAh094KHJSdSPnB6Te1FUSHMx4fSUAkNN7WFAtk/Ab8AuS9C/7WI7BnDSh/bxZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss2pwsgwPq54TdYPUPk2EVXMIWwapenzI4+5XkJJTKg=;
 b=RLm4hHTMPuwUnVAK2vmDbv5VNRetM+BLjZMTAylZk1q4qxLDdkYZIzezTECMem5cKpJ/Om1bwedliJGkx3vMKkPXp17Yr7ATNHvp0g3bUPduhjUvXUY0JG3T/UHW7vTl+P+l+xulAgSutm/XA7sRbQMB31JO/YW47g9udAj09padprRniBpuAIQXz35gwP2LAVFYJkkTqsKlA5L+tokgnHm6AGxkPN0yTcyFCOmsu6/CRGA4keSBB5A3YD88kC9VaaUMOarZmJYin1mjHpZwY8C1WTLrZLJykmRpAV6c126wNqZ91xvhE7XXaATUsNcF9mBZw3hj0W9mVQxHGXR8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss2pwsgwPq54TdYPUPk2EVXMIWwapenzI4+5XkJJTKg=;
 b=EWbDsIVdsy1ElKLleUZ7a3nA5LyHNtCGLXg5RXESPelxUqtxt16QsVYcQQJVYnbZbWzlAu2yP0E01+T6ADydTluaoUhdwjRmzNKe2DsFJJoLb2QQfvcgCy+RpJIKn6oMEZ2+CfCFvb65rUKWDo8tWDwlAqFyVyIxUTqSUzq9AGExYyGU1sh2UpXV2cI0C35uXchelMCMaGnOx6qphRv5YA5DT/8wZEXeMpSHQ5+YFuuxkGMUDKcyyKRhV5ciEabz0qRbJARsDw13BEwM7OY89/IDNTylRFfSwyA1miCUYTgjAZgqowFMqnx+hEzDUpXnzDVWXHq1VDV41t+XDp4G0A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6612.namprd02.prod.outlook.com (2603:10b6:a03:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 16:14:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 16:14:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Baoquan He
	<baoquan.he@linux.dev>
CC: Will Deacon <will@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav
	<pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Thread-Topic: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Thread-Index: AQHdUafu8BdwG959PEWeGxKlWV317bbo3Hiw
Date: Thu, 1 Oct 2026 16:14:22 +0000
Message-ID:
 <SN6PR02MB41578FDB019EE76576C612A8D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
In-Reply-To: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6612:EE_
x-ms-office365-filtering-correlation-id: 932b3aaf-da10-4f90-face-08df1fd70e17
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|24021099003|55001999006|13091999003|31061999003|19110799012|8062599012|8060799015|25010399006|37011999003|51005399006|102099032|440099028|3412199025|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U0IISlEIWPghFh7WtxG70LW3ef3AuboU9jiaYzI2JWC12XUwWchvhxNHil3F?=
 =?us-ascii?Q?3N0UPLXZQ9xBC9ryAMLGl2mxQRbQCdUdjhWYwkPT4lRRJ0EcX91KOhp8qrvF?=
 =?us-ascii?Q?Q3c8HWKctZD3ouPPxBrs9uqEHq7ZFrMPW41zo6fqCHS7PJ/csjA+3sN6Blek?=
 =?us-ascii?Q?9crKTm21BGPDY8HNx0BSK4jTXLH2cMBM1CjkXaVqaK7Ck+itrIjXJjKM1tK2?=
 =?us-ascii?Q?TMJUd2KSF2FxBfapqc/AcorY9+7Ae8FpvZgFuep1/qx6uDBc9ZW/LRPs9TEm?=
 =?us-ascii?Q?UoNseBqXlJSeEUh4bIlYpk5WzmmGfwD5TtfwSOByddVdJKIgl4lEQH0YV3aX?=
 =?us-ascii?Q?JAhSZYJIQBFg64uAtoaIc87ojkxWSQBnmdv07Z4HiCQAuVxFj9mrLg4aYs8N?=
 =?us-ascii?Q?k3Ybbh2FCKmWvkbKFWT1n7yg3PXYoWlSNQ8NUbM4R3tb9hRVL4EE7KJ4gfoD?=
 =?us-ascii?Q?kLS9RqRD4pXo1SySOe7hm+1qQ466TdJDEGKXCQsTL7uZJMh1lNFqUi+8PfDa?=
 =?us-ascii?Q?TxYelNZSlgEYRNdrTWG+YgXGzMNqhv5sbY7VhXMGP9q+8uG7N1NyP1jcMvvl?=
 =?us-ascii?Q?rU6gvZRnHcxy2xU/Do5/8NkdsE58lOtFTovrMv2AYbvhrkaL/XYH5WbDQZcS?=
 =?us-ascii?Q?5g8nqDb8HVcjTfBu0gzTCWcKlHuu9Bj0byV052JjsQanV6UbOZuqkX73A/Gs?=
 =?us-ascii?Q?pUq83Joa1gJEyu6VQ3YRo2STa4NKPbIgQ5edJyo7gq/nKBg+Oa7A9OPok9cQ?=
 =?us-ascii?Q?fsxRluPKa33ZrYaixS6B6P/yJgpOLdFscYTR0CuyMJCL/Wlb9mrTPFfketKF?=
 =?us-ascii?Q?s7DRgsxAcIuIiOiYwqF9j7URp50UPchH/RUAdwLFZ3dh1VY74XKywyFcWMTi?=
 =?us-ascii?Q?d0r+Kd5mBPTVm3p+YdZ7Hoo/nV7dJ1G0ZRUseTN4AnwfZDly4Aw1iTL3lkpF?=
 =?us-ascii?Q?csAiOtTPHqaes95LPMSzCo5qo4Q0yWg6dWV1GMbeGAOaUIf5JGozHUU+Q5QK?=
 =?us-ascii?Q?NT+mYxSUhUvp4vCsRwl3CLYgHP7cYvhwgH2+WuIGag0T6SQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XMM3CWeqEBXCe1KHZQkjhgTlrYY/RYuJEM+3g8fHohkex5bRji9MbZRzX1Yy?=
 =?us-ascii?Q?TTHWimLjM9+BA5j3Q5VEDW1gE6sK5JTSTKhe7Pm9qRE152TiXuoRCKrPnz2E?=
 =?us-ascii?Q?KjvpQ6SPgYoicms+YWe34XJq4B6FgYDg7Fxh1f5pNMC32O4DyvtXcKxlcMNQ?=
 =?us-ascii?Q?Sje7e6sGL2+ZchO2wz3u5ICWpHyXjJKFbbenj5gOY5mlDDF8Ux8jXN5wWo2j?=
 =?us-ascii?Q?Sjt0Zrr1qfyxDTvF088lpFFKF0CC+VKriowWbZFhPpehCKxF71N0Z2LvD0yp?=
 =?us-ascii?Q?/jGzV1T/rTbpKqxFKrG1DNo4wgQf+kDgJYnxg/7ZDJIBhjoch+ljAsF1vXTY?=
 =?us-ascii?Q?G5w0H//sQBguS2c51dkfbByvQ6F33VKH+dyi9+Y1y5hd8sr7lIpJwVc9TlkX?=
 =?us-ascii?Q?P112GUmRvnXiOvIjvZ6SM62uo+GEQEt/EYGIe7yFD5G2fy5Pn+YNIHOar5pW?=
 =?us-ascii?Q?P/DfeL0MmQxXT9jn/dDOZOkvnm17q46VRWUuMEVkrvZqDdEYDfcRPfKKYt4g?=
 =?us-ascii?Q?bmXAODDfMKzJMx1ZX/UNh5eU2iMUdxKAdlZPTw6zvpAshq72ENknHwuc/TmM?=
 =?us-ascii?Q?J7q+OB/8k4m20XxsPFQ3Yt5HnWWhCHoEH4M1lvuOXPk7htZ2D/n7SYTQH1bm?=
 =?us-ascii?Q?UXh7z3HUvAbSSMe2Mn1MHvV7q9/Un5zZM9cd6PVSG4fgDGHBCcflkkTW9JFf?=
 =?us-ascii?Q?n6Ny14QN+DQIemgIhbyKTjtkuiLjAGTclR/9eU7q575payg6cHiXLZmInEE6?=
 =?us-ascii?Q?GnFwd2caRhb3PpGZ24oFljkizyyYem1RueIN0gLw9XzBqL39TjT0r4XbBCbX?=
 =?us-ascii?Q?9jSIeO7/b/GoHUXTH8aOHU/wIj8psL/yVlFG0OA9Mei4991nVHGqiAwGWY0y?=
 =?us-ascii?Q?7Y3PpSJKcqK0Q+4c6fd77o0UfALdDLy+BPVywzkN7xP1xw9ZtOtZ3SgXaIki?=
 =?us-ascii?Q?MH9M9emeqygHqGlj1NidQUDj3+1+rJ39/rYqCgahBF4sIKtQPSE05/8BOJu1?=
 =?us-ascii?Q?9HpZUwPeJVGjxW1Dn4l3KEmzv0d4ssOqZqtBaH7T0hJvFi/fGaYVEj6fCT2B?=
 =?us-ascii?Q?Q+Gr+CngbuIiPSpSiZKulaAO3HpkZWT+DovsfQiXW2+WFYoIHS8XbuY4Moxe?=
 =?us-ascii?Q?i3H/t+Im4SWoTALMGUzY2BGDPT5h8KGeKECBcqH0Div0Wq/tbzMegipkv2U2?=
 =?us-ascii?Q?/gp0mUk+mg3J0oFXssN8x0f2bx5lQluKzxrBs6ak3Lh9zaXgoCDtRCE8ovj7?=
 =?us-ascii?Q?iZ4n/6fJ9o9lRcKDHxzX0WUXCloeNO18vAb2xZcRLp0Ao4slJB/pA/cduByA?=
 =?us-ascii?Q?/vAdE2jw6nfMW3k36sRTOME3dtuuubqlWEvOVL1Q8nzxu37fpuikxGBd4TRR?=
 =?us-ascii?Q?qPVShYg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 932b3aaf-da10-4f90-face-08df1fd70e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 16:14:22.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6612

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, Octo=
ber 1, 2026 6:21 AM
>=20
> Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
> connection and SynIC CPU hotplug state are not torn down before the
> secondary CPUs are stopped. The kexec kernel consequently starts with
> the previous kernel's VMBus state still active.
>=20
> The previous version added an ARM64-specific syscore shutdown
> implementation. This version follows Michael Kelley's review and moves
> the cleanup into the existing architecture-independent VMBus syscore
> operations. This removes the separate x86 handler dispatch and gives
> x86 and ARM64 the same ordering:
>=20
>   device_shutdown()
>   syscore_shutdown()
>     VMBus UNLOAD and SynIC CPU hotplug teardown
>   machine_shutdown()
>=20
> On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
> This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
> Remove support for stimer interrupts in message mode") removed the
> VMBus dependency from synthetic timer handling.
>=20
> Patch 1 adds a read-only helper that reports whether a kexec reboot is
> in progress. The helper is exported because HYPERV_VMBUS is tristate
> and the common syscore callback must also link when VMBus is a module.
> Patch 2 moves the cleanup into the common callback and removes the
> obsolete architecture-specific setup/remove interface.
>=20
> For stable kernels that still support message-mode stimers, an
> ARM64-specific backport will be needed to preserve the existing x86
> ordering.
>=20
> Changes in v3:
>   - Use the existing common VMBus syscore operations on all
>     architectures, as suggested by Michael.
>   - Remove the x86 handler pointer and the weak setup/remove interface.
>   - Add an exported read-only helper for modular VMBus builds.
>   - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
>=20
> Changes in v2:
>   - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>     suggested by Catalin.
>=20
> Shradha Gupta (2):
>   kexec: Add helper to report an active kexec reboot
>   Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
>=20
>  arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
>  drivers/hv/hv_common.c         | 10 ----------
>  drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h |  2 --
>  include/linux/kexec.h          |  2 ++
>  kernel/kexec_core.c            |  7 +++++++
>  6 files changed, 24 insertions(+), 36 deletions(-)
>=20
>=20
> base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
> --
> 2.43.0

Nice! Net impact is to remove 12 lines of code, instead of
adding 40, which is great. And nothing under arch/arm64 is
modified.

One minor point: In hv_machine_shutdown(), we have two
sequential tests of kexec_in_progress. Given that you are
removing some code under the first test, I think it would be
fair game to do a very minor refactoring of existing code and
combine the two tests. It just looks a little funny to have the
same test twice in a row.

But regardless of whether you include that change, for
the series,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
