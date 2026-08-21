Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011008.outbound.protection.outlook.com [52.103.1.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007037CD42;
	Fri, 21 Aug 2026 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285599; cv=fail; b=Vdns+DBt7/3mulnIWC7tIjfYOIop8lS3yJIgWSqQm+sZRXpe890YJxiCGL6p1MiRTAfnFVBtdPTQC4ZG9E88/acbVYzf3zx75jSrTgb7fFOOE6eWt5MEIUfef7tR4mpFUofLnw/Si4vz31Y3mgVEJs1AXb5q9ZI//Vek4SQKUyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285599; c=relaxed/simple;
	bh=fmHzrWpLdbDAQBwNvkwXV7Cj760epn4TIgFQH/KVjMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAOllgUD0FxygmcJ2uKZKbebuArBZIWFVR5IxoPhlu67gQakF2gYbh7NGPDsIBqqs6QJCC1NB+adbeFEbopjVNPdqgCNLdEZQDl+1Po7n5zbbbV8gDTQ3L+uyF2ELbuOUuySaAVPeqOQj/G2Fq4OezRag88KBCDCJxpnburbhrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gpmox+Os; arc=fail smtp.client-ip=52.103.1.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gpmox+Os"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeJ5Ie0yhNhkGc1dLNyoJyARLXiXuwU/Y0sN3L89pgqqXs2gC3tCpc7ilPxKSNUvOBmepP54wv8Uhzj4uZ9Xki0gNgSCZNu0juYQGzoWM+1XM8AZrv9U19rTDqMLFVfPcDVKGUoYCyLvUac1mudyO4cbxgm+J0aAeT15zVgxMazF1pKGrSXiRRHnE82nI9pkLxX2bs3SkcCMO/BPBvQw6ZfgLyE8/aV4UDVIDwCkvg1Py3t/wmp2sPdm7jd2qVSBIhUmP4HHQor9GbyGdBZVmNtKTj7aPLVvDIxeKRlkR02Ht/as7/Dfj0O2SVB8Xhn13+t2Elu+G97IMyJe9wwmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9ziS7zOJcd+PCqe9TTsQa8KzQL3U23C2yqp8kJYC0Y=;
 b=IJy6Gd3utyQG2sqFj0pt41tm7HiPXuTaBvOiFmcg3NQInNw+acceCjSQ/CqMHTqqrNbc7+YgPpL2ExdG7++HDbf4DUFpqHHxn8ri5Vn2/aTt4b+3hw9bAlPFzSFhvhFMgLTc0rZkGdwUgOobgFpOzGkjvVUq8Wbpm8muu+SkpWka8m0T0TayZPq+AlKlPJ7DxosLm6N6koi6uqFlhIl7g4zTNMc9xlDqdMuPD2WgRn2bKTdxAEK3G7eXoxKlRCvVdxcKuV526niUm/mBNBXCoLCNRtsKNFDfKGJcqqO77qrgIKMk4ctNtalRavcIGBejqprjmb/OMTR79cE0BJLdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9ziS7zOJcd+PCqe9TTsQa8KzQL3U23C2yqp8kJYC0Y=;
 b=gpmox+OsBBOAZqFCDUxn21YW0wggdD7adld6m2Bm8eU3CCLNcK+2dUFeOcS0gXDQqxcvDoXvIPE0AWYHeVJyARFRlbnXVeoJgcWymgk3xwLH9yuv3dAs5PliMIORhtt0zpC3bzSl3Rebn8C82VNkJaNc7bWoaZRKn/hms9vQ4HXLF3oPD5v28nP1Qy4CuEkK9APHOk7syXDR9AStPOjNByqn8ZyEoLvjwa5xDbvV1IOYK/PnMR0bnZ7Z2l9ABs/2HAKGf4p+EDVJ7JO9abBc3gFvciUFQAfFsAFZ/b4ztplJAAJbJ4J91pddNuFcqok9NgleeYCXoqrlJN/0omTW1A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9758.namprd02.prod.outlook.com (2603:10b6:806:373::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 04:13:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 04:13:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Juergen Gross <jgross@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Sean
 Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
Thread-Topic: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
Thread-Index: AQINTp4TPtSs6ebCNDDLlaH1nXSnpAKWjN/ntjJFFsA=
Date: Fri, 21 Aug 2026 04:13:15 +0000
Message-ID:
 <SN6PR02MB41573E35611668E830B82A7BD4A32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-14-jgross@suse.com>
In-Reply-To: <20260819102314.1499258-14-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9758:EE_
x-ms-office365-filtering-correlation-id: ce65df62-7e61-443a-826d-08deff3a85c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|25010399006|8062599012|31061999003|24021099003|8060799015|51005399006|37011999003|19110799012|15080799012|55001999006|16051099003|13091999003|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AagXRPsrzvY35uKMPpXrixbIwNE6M0TfQ4cks0HmdQ3fvv33UybohQMj02Zk?=
 =?us-ascii?Q?HaZTRfuf66Q6l/n8jvJnSfZ+YQCWE9uCWtNe3s2ryH5xI1wL1jsNj/HFpZb8?=
 =?us-ascii?Q?ZunlSRuLmBnxKhwwRhjxFe4jNkamujo1Ihu/avrtXFwezy6FPZwwO2eJSaq6?=
 =?us-ascii?Q?b44MmWKReKl+eSS1fxAi+KtXqM4ZMADFz59xOfMhdDS4WiyFdx/XtvL6hzqw?=
 =?us-ascii?Q?zUgsySog05YyimlpP1Kz6DfSIKQ760oBf+L2XEHjv2+xYTnXfNuGLGd0EsIA?=
 =?us-ascii?Q?nsAyaj+WmxCjv8gnYvCui235PbwpR6DneoeTHp+4G8H7Sjhdqn+iNKM4Huui?=
 =?us-ascii?Q?KT9u0dUHsMyTevtCKULLfV7w0vsSIsnvGaMdgeRxcOdmZiBoFxNe+yRS3UO/?=
 =?us-ascii?Q?cHYfvKyfNBaTItGMLA9k+pKem1ZcUT5HUv6AOzCgqQ1Hz9Bp9Emh3iwUCB88?=
 =?us-ascii?Q?WFROZntbY1Py+LS44ajy2Zt41lEqeknegqcdYHZxtyeNeV++eB0+EM4aNErh?=
 =?us-ascii?Q?DUvvSMolOeKxolkifEIIVXt5VlKy9sEswp76aPmg9HtHLg94hXXjHRZAjQvq?=
 =?us-ascii?Q?tHGcV7OUu5PQEpMBI/sY9AccNBTWX9Nejm+GIl71OOc6/IMSlLpf+1i+ZPZR?=
 =?us-ascii?Q?9g0Hft2P4Dff6YyrVdEvFBwtEp05aglU5g6cXd8/pEh8b4IOt1PZP/Y6w5J+?=
 =?us-ascii?Q?o4SA/XuSvNkT5t2YV4Uxk47+c+faP5z2xgi8fEPTmCLFbgvTNO5EwSddXJ2r?=
 =?us-ascii?Q?CPOQOCBSyKp3Xm8cfn7mQmcjg0gRfd1mHbJVQB55WiZHOqfIGbKeQimsM3RH?=
 =?us-ascii?Q?njTZvmVGpn2FnvCQXkC/zK4V2EpKXJ8FYyVg/vkV6MzO3aaoezpEpt76ycZl?=
 =?us-ascii?Q?7+Kl6qia29fKCPWpnCdWYTVe/ZnKPsvoM8UNqga3Vz+9eF9HyWstmaBSPAH2?=
 =?us-ascii?Q?0brqRmM0SS6vL1Gfy4bqXyVKCYElrWUtI80MUotKqzuRIj/f1IX1HYqun+PF?=
 =?us-ascii?Q?x7Vv00hY1OENn6bViwWhMHVCj1w+JlEuxd1TIYX6KYrhvoXGCmZHE4/HuHo3?=
 =?us-ascii?Q?9VBDFgH+5Pdfoe9VdL9ZVJAVQi78Hubln18ccLovjRf6vo6yP4s=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rp4Vami0Ii0lEaDta26hJSl8/dp1+968UlgHYLWiJKUaKMY8IR0JGfwX01ad?=
 =?us-ascii?Q?jv9CE4t5ao0hwu5e/mXJvS2zrRWwmeWYlR96KLhiRziKU5K9aaW7TAm9Brqb?=
 =?us-ascii?Q?B0sXWezhJdW6YfhFm9l9oH8OfYakIPt38e7K20Q5CPwrInXX+lqhsnf/TdUw?=
 =?us-ascii?Q?ON2rifdM9YHB+YeDiRaE7fa0uww5ai5pe0jrFbBYzsiIRR1RyyVCShDwUwG7?=
 =?us-ascii?Q?8wnIR8KKqT8RbAAgFThQ8mMhAwwlBGMSwiKgu/gkhRfA+BjutLGNzE/f0mrC?=
 =?us-ascii?Q?VOHqY6kYlBO+RH3ldqC0zlQz1kN31kNvmFFSPmfPXt6ETFd3IMD+Kjut+3OT?=
 =?us-ascii?Q?DDGWudjvUNtOL1mZMvv8sUXhdFEtolekE2GcgpJEYs8g0N/pJCJYwvn58TK/?=
 =?us-ascii?Q?JUWaeLNtgMcVccGo3F8FDavRaSICxXOSSumDwhSTxm9PONxO7+6K4I+x1jub?=
 =?us-ascii?Q?9lS82/L9XFBahIq/rD2ZVXlaX2nLVjfC7ZsdwoZ8qz2bqh6zrjKJ5O7/mn1g?=
 =?us-ascii?Q?N7H8Fhnm6JJrmKAbYeIBMOEBQ1RG98kdZdHYPll+LIb8u48s55+LPd4/ecEh?=
 =?us-ascii?Q?bJLTb1W+ktO0pv9BJiEZkgswSagFG9nhoNrC1TRv2UM84CqbQSoAwQkSd9Ev?=
 =?us-ascii?Q?PRuiWjVycpE5dJkXrNUkeoohlHpx8B3T4BLxDUoSyukxGvW387YelfJHft1D?=
 =?us-ascii?Q?XdxKlm7Z+XBQS8MpuBg6ecmoHgoeb/oDszMF57QM93vfWTL5B0rVFhaXue0V?=
 =?us-ascii?Q?M/6/RE0BstZ8u8mIPnZQM4aS7818cnCSFP3BOj9lREEFY2BwhgwxdI169P4K?=
 =?us-ascii?Q?ndntnYtUz2YoorBgw6SrsOkcl8op3CvEXYJmSqqb6FpbR6YadND3IO1SJWNH?=
 =?us-ascii?Q?5P/YyrObUjSKJ6CdnvlS28hCain6mPZJ+vgRyaxdRTq5//pTFkCJJCeEyWu0?=
 =?us-ascii?Q?D/2tcOSeNJHLFjv83eQEn8iADfl8W54ZLn2QwDbEsDfYtx7Ir5SscHl0gfSj?=
 =?us-ascii?Q?GbZqT9ed4IALkGEwv9V0ugRk4CYjvffVnMR00TXD+2sNNZ/0IyP0E0FbP2tv?=
 =?us-ascii?Q?0SiU+WEqT7C9TLFQN4zgjjSuwiNoNWAs1kEXHzFdEpNKcWl5Gad0CfczLQO9?=
 =?us-ascii?Q?A7CPXFLNkBSZLuy/ol0iRKz4HfvpYsbdyFLJDtHgztnuAA4kAqxMBC4dzAJ7?=
 =?us-ascii?Q?qszrzNiVEIxdLQ5V6or+im5J+IVnRI04pbUCbRgmeES952opKJgpV9jgwanL?=
 =?us-ascii?Q?d4aK1is4FMPfystR8V9Oz7eB91NgdAgpk9Lb1/sppVlATFpMyKay8IfiAb1q?=
 =?us-ascii?Q?sNWRoZ9lJBYmbn8nt853z/rK7z0c2jmu9h69QbdVJvwAHbL4Qqy6cSLdyqU0?=
 =?us-ascii?Q?bf2vCjE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce65df62-7e61-443a-826d-08deff3a85c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 04:13:15.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9758

From: Juergen Gross <jgross@suse.com> Sent: Wednesday, August 19, 2026 3:23=
 AM
>=20
> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/events/amd/core.c      |  6 +-----
>  arch/x86/events/amd/lbr.c       | 12 ++----------
>  arch/x86/events/intel/core.c    |  6 +-----
>  arch/x86/events/intel/cstate.c  |  5 +----
>  arch/x86/events/intel/knc.c     |  6 +-----
>  arch/x86/events/intel/lbr.c     | 17 +++--------------
>  arch/x86/events/intel/uncore.c  |  6 +-----
>  arch/x86/events/rapl.c          |  4 +---
>  arch/x86/events/zhaoxin/core.c  |  6 +-----
>  arch/x86/hyperv/hv_apic.c       |  5 +----
>  arch/x86/include/asm/apic.h     |  5 +----
>  arch/x86/include/asm/debugreg.h |  6 +-----
>  arch/x86/include/asm/kvm_host.h |  5 +----
>  13 files changed, 16 insertions(+), 73 deletions(-)
>

[snip]
=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 4e30f9a11bc4..52ee8c237c2c 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -36,10 +36,7 @@ static struct apic orig_apic;
>=20
>  static u64 hv_apic_icr_read(void)
>  {
> -	u64 reg_val;
> -
> -	reg_val =3D rdmsrq(HV_X64_MSR_ICR);
> -	return reg_val;
> +	return rdmsrq(HV_X64_MSR_ICR);
>  }
>=20

For this Hyper-V specific code,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
