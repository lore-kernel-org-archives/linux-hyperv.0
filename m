Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3016483BF0;
	Fri,  9 Oct 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570120; cv=fail; b=r13blyw7yLSrgMlN345EakMhMpFv+8R6fDLnX/2jHsJ4HEreIo2NU0uH7gsDbHSbXcgLRqOaVwY6k/o+xIYPNYHGcxdclAj2kSWGal2h1Ssym6xKGUhATqYqb9shcj+T3UwF+ytRcVzRYHy3I/qYJ+hmqL3nQDcu4Alg+dRxELo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570120; c=relaxed/simple;
	bh=OHi5sjObnAK5lr79s+hMr+tF0HYBXGfUN/QFzFS1fpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoVSNgyU/sDeF06oyUgvtVkYp96y2D8NhABt4AhBc1E1ho+w6SwyZW6mniQ2cnPI7UQr3Al+onltRrXdpoGla5tOPJK0b1QNp+DkBbe/wOoqf97wajgjvChraENMlza3KPEJExQeM2xzifgCrLyWDhZU1HM+9HeTeXP97mpU7P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPD+wVMg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPD+wVMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791570119; x=1823106119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OHi5sjObnAK5lr79s+hMr+tF0HYBXGfUN/QFzFS1fpI=;
  b=TPD+wVMg7kkUvG8Lyc9eaIvzu0P0td6b2Eo/owLNsRf+Cw/9K7KpGP8i
   vMYbSrDy0/OvDuglX8icxgpj3Bc0yPBZk3OZ02A3XrqRTK15Bqe58BWE4
   vrszibKkCST3tiQQYOdWdzVj/KOmKQKc6yGM2rvP/d29MFfSuyz9CCA4d
   jLeLPZ1dNBCaUEOSDJ+/OKtDxBiEdem/sRj3SLyBq4WJGRER49KI99PDl
   h5W2Lnm+mf1BlMxn39mgPReP+TqolL8K2VsC3DwzsEDYFKK43epKxE/Vk
   u7MnkvJPzvDL/PLIE0HRlBRpzTTFnrRS7iPVRZIj/heKgzhGzEzlaiHqa
   g==;
X-CSE-ConnectionGUID: 8vOENXh4SKqOexe2QmULqg==
X-CSE-MsgGUID: s4geVZPgQoa7VsD4SLfoOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="260461"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="260461"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:21:59 -0700
X-CSE-ConnectionGUID: dWxU/NViTs2EENbPERaTBQ==
X-CSE-MsgGUID: CjEBWy98RAazFIdF4yrh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="340590"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:21:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:21:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 11:21:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTEXBUWSfcrSSwUNIAehBZ9EGNqyKjuJdHbhnpL67jjzm7J1TS3jSVtoz6GsWfWxBV0Y/lx6H5wdX9RuBRmnS+KK6JWCLDDs2WmB5qoQ0baXS+D132d5Dl5tkTaogYYkcmCD4h1q3nCp9bbOdtFtHynSxrBpNzJ2E3bXVPGj8Occs82lhRBhBzGmE+lIAte+6Ue4BkZt3pTwJJznI5kU/LifQsxupumSJHFbJfV3nI0rAQEtCJwOtpx3sgu8Cb9TkjS4zmpeb/s4bfal/N4CYM/y8cEskuKAIfPH/fKe0meHVUdgDy7de0qWDYV6pwQWHCZtJdi0qO94SbA7QuG1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYlBa32ydlK+0BHcYJIuyu88blqGR4qlCzFzBVVLf5E=;
 b=Ns5Tx+KWIoMgAI26f5JtXS1aO0bBmpuRATdmPrxR6LqCrR/sOrSJ8iU6gYGBNks9syQVYQpAc3mfBO4y7AcrmZsFgj4mSeJjFqXEo1fzvqzkGN6c8frjsuKCAFI0Uj0wRjPyrkCPplBDJok8mNGBP4yGBR/Ewu1CISlPjuDd9Gk+hjzf4wrO3IFg32dZ2/p85NlH92uKkI+r3KmmJmx2A58aAYj0wSX0HauMXmR7H83Xf/EpL33id7AlX72kO97UQf5IMry1IbWSY4K1Y/bLwuMnnJqjCy+4frYGMGcBhjaTSYxqYSdaHDxyCiYRRiKyd0JGEoXQgZFW0RnWvZuXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:21:50 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:21:50 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Jim
 Chow <jim.chow@broadcom.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Radu Rugina <radu.rugina@broadcom.com>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>, Lukas Wunner <lukas@wunner.de>, Nathan
 Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests
 on Intel hosts
Thread-Topic: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Thread-Index: AQHdWASZkl/0se0hWEKzOo9DW5a5oLb1bsyAgAATn4CAAAJWMA==
Date: Fri, 9 Oct 2026 18:21:49 +0000
Message-ID: <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas> <20261009180847.GD11438@unreal>
In-Reply-To: <20261009180847.GD11438@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: 79948d41-d374-48b0-47b7-08df26322faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|10067099003|18002099003|22082099003|38070700021|5023799004|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: b8hIIRv83veFSLoXF/RnJuEB1OA7R5b3Ft/vsCBqofW/tx+rL3D16qtJ5rQjSOmMgk3kgj05aO8m9tVy8/N6cBdmGDye4yvvwjij3Qg6R2FKDneWR1xb+Xu9vq8hT4tOTkPwc3qWKF//y58bUfJXU8qCYLLxDQfeMJsCqdREA2FR9eBhCbM5rQ0wfHtkxgKVQWbIYq6/qlRYZ83OCGSwSTbyZhOCdLKQDRleFcDEzgrTJ4ONoWjSLhqWgJ3Rsz12vTWqVJrBVb0SqRFIHaQ6H0f8nkhBdw/QIGe7yb9FwjembvVBhn90ItJ+zmZtIUx5unNQtl0EClNpwdA415BZT2qx3BKLUGOSYNhRJB4q/Tfi/F3NtPL1hZ6/VMdPQLp4Anw7b+g/Oq9r1qpsY3Pdx7yZaGdWOMLTAYEOIXSGVemznYY4uSg//nCOxCfdF3L+NGi+QpfMRjZUzxx82aVLkYUalRgE2EoqMBJ2dkAH9FCjEEJ489wGkZtsGdUWUKPl5p2U3iMpgaWnkMsdV11fl1CgJNtPAV9mga5jQkcG8++THTYe43tcSKUxpU/N3TZHcYMj+DLvp8tvrOK+fZ03b7xdfA6Bwodl+vrCGzWDX4k1+H1F8Hqq8j50PgX2qq8YrTUezr7VMk4uN3rGiQpXiafOJUztJBkmi6dUSJm5RIMKeSwDgBtZAORxqsSsevv+yhu7ARfdQOtpIZDhM9P5GY7XhhJ6Yrxite/csptx20w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(5023799004)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wWrQ4uFK+pMM7wnsw8yHUQ3cfWwHNCm8tcwR8cOfYhMjTTdok2KrZHQOacpH?=
 =?us-ascii?Q?sfcRTLjAoYlFCcHMxccmxqEUhm62nc+yHC++kJpGP0Cf2/JZpKSM10x7vB7Q?=
 =?us-ascii?Q?7MUET0EyX9RknxaYFFM6C7lp1SPqHV+YSb73dKCF04/HPeMlkaZJQEkOHred?=
 =?us-ascii?Q?Plr9VBuL+ac55ZThLYA/GwLaeVUNzD8VTgTTo6S5e3fnqE1PfHkP0mXDR2+f?=
 =?us-ascii?Q?THJ0U78KRiZR3oO9bPEEO7sY1dUDVR1NnnoRjqJTJQDGXtOZYUXytShCB0LE?=
 =?us-ascii?Q?fGqwdqSVNRyQcWPRQVF7hkBfeEzti3VWbifeJTMGxVeX2kG3uLVCmkG2WmpS?=
 =?us-ascii?Q?vOMauO0x6GAqmpFJUi0Aqy5TIWj5YCnYHEPzoM0/KGLJauk+aGaTAdno5uyn?=
 =?us-ascii?Q?8FrC62zq60W/wtKiCKUpe1/+LJ5Ypg8JQJdzO0TUs5qbDWKOwMG7j3d9auo4?=
 =?us-ascii?Q?f6jIUpTg9cWHjpHi5ZDBoT6y7glJuzWqp/zRZnUCMeNhmRSojy66FX6soKhO?=
 =?us-ascii?Q?0YMhNcX/qJEOwuzO7WxmlaSLBzYvPp03g91ef7LZ9+5zBXI9jAB2cpGWVHDH?=
 =?us-ascii?Q?DWiYIhmAC+60vGfhkwJNbFi73ErLKBpPMVgXCd6nG6PeR058yk9I2QU+m3mw?=
 =?us-ascii?Q?ZDv3rXAlIhSaVMN/i4B+d6cmLbL+BNKsoAJihN0Ytwfu/EWSCi8704L8KMC2?=
 =?us-ascii?Q?u0ciuSypahHwMDACca/wGqIMAMKqUTkBYkT++Ka89h031SOVxpjzC8043fCO?=
 =?us-ascii?Q?xDuU722Fq1VadIBLpoLyVlAVpuQ+64IxE7wFBbjRMI+ogayDxMf4VUIUMPck?=
 =?us-ascii?Q?7fYGswoAcldHqkiM0L5K1LKF+RJKWPRGXBKN0a/e3mA51bja5JjiFWTu83eX?=
 =?us-ascii?Q?kO6qKWMFQ1kOxB5MXb5VPUonRBr2MtPNfb193VNtjsxinIlrH+vL62buOrMj?=
 =?us-ascii?Q?ZX/y+ip0wSXdr6wmMmhsr204odwtZpKusCOTnI2fKDKE2jE/cA45IEV3ymRv?=
 =?us-ascii?Q?KQFf3XIX69jE6EpwCH6jyLyR2B5Srl6I5rdmsMsXsj4Yo3sKeNFdeWDWr6+r?=
 =?us-ascii?Q?raoNGbxAfXNUzrTSlwwFO32DOTzlfKyR7AbQG/UwEU9uytwk0vShtbY6chR9?=
 =?us-ascii?Q?bI1UgF/Q8FdUSAMzSK9MmzmyNi7ixn9b/6/Wox23JFcxx4InayKzyqMIwu/v?=
 =?us-ascii?Q?naYCC9gZ1Y479pq02jT/5Bfp/xbDYXNzjBNzdCj9g13oziPhxzVwHfMsfZUo?=
 =?us-ascii?Q?zK4VSOi5LaEcOttRcAqHMkTGEKQoRHgLwaGzakxZ169sO1k2RQKmu9EKzdAg?=
 =?us-ascii?Q?z+KgPF6r6zGhhBZL/punufuhXSayu7bk8ADRCjj36uKLZRWZd9dhULZnX2cG?=
 =?us-ascii?Q?+r1qBBUs2/i1Ts49kxAGDw1QuHTCPY6uZPYkaEINQ96yTeTt2CRTwERxfZZJ?=
 =?us-ascii?Q?N+qwUz8qRfATe27i96OrrsCSu408RYU8QiiwBhTEVral0CPX36zhXYdOb2FW?=
 =?us-ascii?Q?fSnGBSUsDTAGmGN+S7kTLyfxLNHGaBmSfG9CuPWNjKSoM95ucr4k2lfuaCNj?=
 =?us-ascii?Q?f8DDteXU1cJns5t3htG1y+jKuvICdv76G9Un4Y8S19IGVBt0CZQplYczc946?=
 =?us-ascii?Q?IWqc0dN8yaglBwNcY54KRhbLfkHhDE2y9XkIgx/HPXhuNed3qTzxOge/QgeN?=
 =?us-ascii?Q?dwEwwal5tATOJIFeOhNWqW5IJwmhVcPoOn3SSsbyQ2GRwQQONAU0hAB/7xhQ?=
 =?us-ascii?Q?XkPtfeLUJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MzNktE2qUCiz/om8KA1HMv6s+EPXIyz4XDQeXlQFIhkq8tIZwv/83I0r21FNrDOXBJmLfW9CBEd7fkZFA2wPiFHHlReWNj7Rln06qpGv5xJ2BsbjHqJHmAj6AhFnnggZ7RsuYy4HG2GNAkxN6uRRTf3BqK2k9xJYPBYn3HeVZkDX/qo5ixZNuRjHsq+CN8jMLs+JCtHtbruh7KZmiSIIlKGbO3hKuNz4/9jwqlscEJswNLLQ/DGDFc6/RXYTDx7IhTp3QO60NIHmLVwVGuk5VjTF67RwEm/3my6re7dH5VbanyzvQ9gcS3TZdYX4lJGO/AOhun+xnJbThBSzeKvcew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79948d41-d374-48b0-47b7-08df26322faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:21:49.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5m1Szr83ONvFp02TYy766H5pKylN4sr+m+S7WkrzhBJ5J1/py8TykMPrjPGHQQde7IGmJ1TTBM6aWmBqsp7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com

> 1. Note where `hypervisor_supports_p2pdma()` is called: before
>    `host_bridge_whitelist()`. This means the code ignores the hypervisor
>    topology. The claim that the VM has a virtual bridge, causing
>    `pci_p2pdma_whitelist()` to fail, describes exactly how P2P is expecte=
d
>    to work today.

It does not ignore the topology. The check is reached only after the
common-upstream-bridge walk and the ACS checks have failed, at the point
where the host bridge allowlist is consulted. It skips that lookup on
the matched hypervisors, the same way cpu_supports_p2pdma() already
skips it for AMD.

The lookup cannot work there because VMware and Hyper-V expose no host
bridge device at all on the root buses carrying passthrough devices, so
pci_host_bridge_dev() returns the passthrough endpoint itself. That is
described in the commit messages.


> 2. We are not developing an alternative solution. This is the right
>    solution, and there is broad agreement that it is the only reliable
>    way to enable P2P in VMs, for ALL emulation software stacks.

Agreed, and the cover letter says so. Our understanding is that HMAT
becomes the primary source of P2PDMA information and the allowlist
remains as a fallback; the hypervisor check is part of that fallback,
not a competing path. When the HMAT lookup lands it takes precedence in
the same decision path, and this check only matters where no HMAT is
exposed. The adoption timeline of HMAT in hypervisors is uncertain, and
guests on existing hypervisor releases will not get it at all, so the
fallback is needed for both new and existing deployments.


> 3. This problem has existed and been known for at least the past eight
>    years, since Logan upstreamed P2P support. The claim "we need it now
>    and ASAP" is not valid at all.

The problem is old, the demand is not. Passing several accelerators
through to one guest and expecting them to talk to each other is a
recent requirement, and today P2PDMA does not work at all for
passthrough devices in VMware or Hyper-V guests on Intel hosts. The
series does not claim urgency beyond that: a working path exists now,
HMAT does not yet, and the two do not conflict.


> 4. The proposed hack does not solve the P2P-in-VM problem; it only makes =
it work
>    in some random cases. An HMAT-based solution will still be needed, eve=
n on systems
>    that use this hack.

It makes it work on Xeon Scalable hosts under VMware and Hyper-V, which
is where passthrough accelerators are deployed today. Nothing more is
claimed. I agree HMAT is still needed on top for latency, bandwidth and
ordering attributes.
