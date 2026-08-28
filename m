Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462E397B0B;
	Fri, 28 Aug 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937775; cv=fail; b=J9XvEyoQpqI5WxgxxtH11/COQMSTNxyxPHy1t+LSibekLM6RFt50U/EOH5BfkxXl1g9QGGuKjKXjKIrHYc66XzceGV+m6L0Irc8hBisTSjhdID63HyrArYn7S/PbKusVJobZ3AKj06oklcsJQ4brwv1cdC4m5WGE1j2yWb6BsWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937775; c=relaxed/simple;
	bh=/2PO7dIrFFNmUxElmxw56Xmkxukyp8mpxixznM/nfUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=raem098uzBN5FWrd1UYBp+BgYQf7KWouw6e8I8EY/twmXTImQVFI+tdM+rkYRPVMVdA9D101JoAhBJvwoUhga/Mm5p+h/3H1UQwZ6Np+HDnSxtRT+uS7Kw0EdpqhEfSB7q/szHfSrkcQujlsmRZVrdbC8iLhs+M+pc6LKevSxGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WFY2tnfl; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WFY2tnfl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrhNc0+El7Qma56cXomtFp5nWKeGP1EjgsSJk3GrvhFp2iqOynKM5DqSmsFIQeFdyagyVLQZjzFunuPpSm18Baf29M7YTKVY24bvZpOx4UO1qXZl6FocmJqaWDeqqlnJvucr413WJvtnM4Y74ZHbfWJKABzOI5k6d8JTZ39spQ1AoQhBZzp36reAUiRCzBgfi6Kx6KzPS8GzZu2WF1VeyxTcjb3YOaFnsXjxPPx/+uLG7Rsnque/fkU8Nnwe5aps41wpSR1M3NL9izm4obr+dhlxLAOwfer8l6OpTQ/wfSGknl9S0kL2EibekNzx9y5CVGsFVDt5B+5WFMJFWd9xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aobN7h+SpjCPLr1Vpdvx8oFzIlhmiORZQfm/mMo0GO0=;
 b=jtH2qVSaHkudhtg6KQRJnGkaPFOCvFhf2Q4oe3Ux9gLgWCgaidz62Rh+6NpTxxyJClqsuyIL2YzSWwvHLyrW7RG6OrLrA4cODQC6iHBchnKAX2jRFY9BkLsvsYRPDjNetE+FI+vSw0g13HjQhNw1VIWNlHyKOE5sJYJJGIK6/L1rg3DzVI+al0Shs4jLANAJF1QEVYgDnLyr7V6Ec43I6MnFgAm4fHHnteMwVM77IDjM+7bS0QFMBCXjggYSTWsh4/tBVo427tQSHtBGhpnDWSX43KAlPSlsQZKzMCD6h+wcxzHaBtW6xjnOVmL97FgI7mFpza/8ybMn/0fk2c4Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aobN7h+SpjCPLr1Vpdvx8oFzIlhmiORZQfm/mMo0GO0=;
 b=WFY2tnflPcPzIiZAcE76d48cKrze5fGnATJWz5rejsmcAIxuvj2Aq0TjhftA035pADZRqx+XFJ3Z+ZFeBmIs37QYN9RrgpnDHZe3YKcU3v/hrl3SggGeOaRmOne+8SiH5IMkvonS1pnovFVKE/cQOPlkYquVVE8rqqeJ7EU9okUfmvruqIEJ7UYZ62VzFWdimeJGhVDWL5SlzLX5QKaBEhfYmBb7UrYiVgU30Xe7UiWu2u4x0L2WPwbUeiNpWkixVKiblKFXBS0LKY21BUocqU1XZGUsJxiIySlYz3tFiHvNnBrrhEFVHZF/8BQIFHx8iLqIyt5c9eMJz3tRAn1SfA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MW4PR02MB7185.namprd02.prod.outlook.com (2603:10b6:303:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:22:50 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:22:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v4 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHdMXDUhW3KJJoFcEuu7XfjPh6YlLazwM7Q
Date: Fri, 28 Aug 2026 17:22:48 +0000
Message-ID:
 <BN7PR02MB41483DDDB70A211BC320BE03D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-6-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260821132654.211730-6-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MW4PR02MB7185:EE_
x-ms-office365-filtering-correlation-id: 9d992b06-f243-43a9-c025-08df0528fb94
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxO1AdKS4dhipfzuxlcEYtiLQHPyLMNS557oG5hwJaP2xYKiQw/q+6xylC1T3ObUvll9u+a1TnaYudca+K29o3+5p1GXclJJCxmwtJWqJO9AjvFoQ9lj4sf2RuMiGu0xOygzbzS4mzmo+D9rDS2IxUWBDRECIgSEUuN+vYJEtArJxqXSowlgTAJDU9VUYx0qaYMB+NKFhsUIVvRrUTRzXvKBGVyXGHfR3yrN/I9tfyjpvfjClLLdiWRujDCq59To5ldl595JbBgA+SWH+yYM7WwL2K6I83nCRfvwI/EzNEWWZNDMwdseHph/9HneeY+1zNpq+6f8m8AJcaKwr92fGf2pTEFptMPOu44QKIJa/EEUKP8fByxf0pS06gjJ1h6JsTqPpxp3Nkorj9TLBX9ZpxIHV/Agrh77PGKeUuosSuIXRQVlckqK/VlGZRKECi+OD6Efogy6eEdvM5pQ/qwFoqOa5lgCZFpWVvy2V1+/wjhz1/mJt8AZF366yhH7Ng92C1gG1LK5ZjyYmUvKYGZ4qm4c2cOM7rFsFJNXv5XtvfxzXhzguFkKAf5trQW9dFBCZTadHc3WEzK2vHTYmBP/sDSfue1/M8lGM/gJkezynH7tAZL78jAWfqnvnCyO6EIpuPoZHTyWmDUjyEfPeapH4mI2fECLdHWtC+2vNajtz+2DPEixGm+mD2MHJLy/rNSW3kVcgQ8gy2MObYMOKPzz4gQIDOgrFM2FAcAi+g4ME3W7Ek=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|55001999006|25010399006|16051099003|24021099003|15080799012|19110799012|37011999003|8060799015|8062599012|41001999006|13091999003|704163111799003|2604032031799003|51005399006|12091999003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xZNEFouxH88hursqDCSmWuH+7Qy4JPPjBxw+gq/id3+Aqfd0SJxvDDGFkOjJ?=
 =?us-ascii?Q?WRPsCAHOfmBT5n686nc5xmNVcbK2LyWc3MFq3mPQSRR5E8AczKPXWHBZTWpb?=
 =?us-ascii?Q?kp2SxMzWUhzSHMyNGoiIRMZkVI898lR9eHskb5zl2zTi7zBGwojpCZgwrfh1?=
 =?us-ascii?Q?/cLAFmuPJo8g6NSOPGSe3tp2Yis7/4H2ClzfmwRGokqkbwVzexcVp+zk/eCr?=
 =?us-ascii?Q?XmDbaeotLx35T1n8Idmj0PlsxXnTwOPbJmEWwXgmyyfRSqI0RdxRrY7PoD0A?=
 =?us-ascii?Q?Px5IUHNCXEyjkF+3S1WyrBeS55vRmJdTgT7hM2PGZnGHcpjSMcB0VlHPfpTS?=
 =?us-ascii?Q?wadwCJ0sXNTg9gcRwhLvM6PGGH2PdPGp9ZTUueo7jiGEqwroJNyHjJr3HA6l?=
 =?us-ascii?Q?b/545ZrYIGLJgrsS517RjY1eBKVkLAMt0v7z+sTNoDNAjqZuwBa7/n4lXNiH?=
 =?us-ascii?Q?sI9WtHUSjhuoQlc9lkUyiGyb2gJytNqdtoXzQ1uqYiQXjhmwoN3HOTEqKPye?=
 =?us-ascii?Q?Q+SBpVr6J+rDYJ4yM7Y+i3pK8CBdMmNpEgQGc7N7WeaQiVdyTt6xNc6U97eP?=
 =?us-ascii?Q?IeEBVLASVt/TPc8ttBNHtF16dM6QvwyYN7CS+ZvUgkLuzNeo5yjseg+GyVrr?=
 =?us-ascii?Q?ET3omQAEhb3YF2Kux/+/wSUgFgpZyNRFPKjFypwGYDfIbidsMBRMk1U1uJpp?=
 =?us-ascii?Q?5kINmkFwQGurlLONX0rHqBpXXX43Tpiml4Do+QJcZXBiUDrENnSQBLGoINKD?=
 =?us-ascii?Q?b3o3zAL8Eb/Z+4vi3QCckFWTm8N+ghVjeIc+Zy/EaRj3RH9hlDOu/EQWmoOm?=
 =?us-ascii?Q?m72vb+Thh2qNzs0BpGkCOQCLdtwTNujfWedk3jx/NyIS5bchEekl4nxZT57h?=
 =?us-ascii?Q?jUgw1dkkw6DOsayJzFy8d9/7TcuprqG8LVv0Dw3EZvT7qwdCtkCUdrsxPm0s?=
 =?us-ascii?Q?+YX3CnOR++sD++9Vt1JQo0vFcobRIJbB26c2eDOtAxIhG5B4QIWADJmeIH8Z?=
 =?us-ascii?Q?aGRjco8P0zHN+eVEhSVz0sK1F+PZ6HXsoz/5nSJxQq2/dSrydTUr4cpg/FM0?=
 =?us-ascii?Q?eWJ8iZfZbmecrT0Aj18g01BpWPlaUc1m3Z9JzI/pXNdXHSNeiUTWwgKjGBeb?=
 =?us-ascii?Q?SGtSYEVxE0W7/LNTiZ48J+WstFjrMnsB5Zci0k/nw92WdQQkqF+JvLttAJn3?=
 =?us-ascii?Q?2Nuk2VcD5wegl2Pz0yp/qrxmsuLcd2x21AEd0Jc/ewxhl9DYaCy7Np9dzwAC?=
 =?us-ascii?Q?3cvOoxVV5Chv52YqH6fZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?or4TgCglNFbTb3J32Fm7Lm8oQ2ojPTMYjq634z+/qLwIsRnkN1ht7f8rOg9i?=
 =?us-ascii?Q?CklyOicPXmPKgxywko3+YToiGdGnM4LU4+GJHKg2ddcHU0fpgBFTXlenW4Ed?=
 =?us-ascii?Q?WEIWn9vjvQIQ5R9XejE4mKEDv2cncsm5j8SoiOlE4Hsl+0sEcfDV6BagAO+8?=
 =?us-ascii?Q?1SXXcMMeuTS/Hk1LhS883yY28Ud+CwxX/MmTqEriB3zcb5xaqicIpPMY4Uu1?=
 =?us-ascii?Q?by5MaYnXLXnTfcc9u6YOxM5oiaZCLyCta7Tuq0pUTBhz7ADZW+1ga+/sisOz?=
 =?us-ascii?Q?9ogrYhPKhBjueQ4MGRsAEWDrtmrvMIo2r/q+9VdXA+dW+yAwliElewWv9+ug?=
 =?us-ascii?Q?9mKFRsKO0jph376p6P3QECpVPnmRFR1Q7wGL/0wiwuoLcEdlYQ1flhEjO5SJ?=
 =?us-ascii?Q?6OiAtCp2uRCuzfm62e+izOWf50+XCn2sGoVqZN2OsIJMPsLoBrUNjN6po+82?=
 =?us-ascii?Q?Q8H6+l8W4pcKP1wtaO6xo31ZhYuhthTFfDiwRckTKqos2L1YZTyk+2SnD34T?=
 =?us-ascii?Q?MVAEUphiBJJzeaXpRy60WnwS8Q0Jznv+5WfW6nMquK4DUqi9jAWyt8BrxEh7?=
 =?us-ascii?Q?lBJ/37SQsAzJDaE4sODnAtXWAUg1Z6VB6JC/hhk73PlyUF4Jdj54lnhKHFkZ?=
 =?us-ascii?Q?FKAgNG/e1MfwJTmDpFJEMaqrPUyGzaHxwEz1CuqOx2I7bDE1HN1XtvMKEibA?=
 =?us-ascii?Q?4ii5UjU8C1qzfe6senj3rLohj2JVPp60C34Q/yYeHjpouUimRR2IiQwMMZLP?=
 =?us-ascii?Q?/IInipL87wPVAQsrWEpGCNl/uWNCL3H+GTWEhWdjc59URUgDt92VhjR66eXu?=
 =?us-ascii?Q?5I3vonVNoA+PAEYUZzaWgm9dfEOlfES3qAVmlpQZylj2rym/TXZz61AvXv4p?=
 =?us-ascii?Q?1DmsSi3tNVTcO4ytEjmx31Gi/cckvH+qrDkyt72yQxdAsCLyUDXDMl9EHdRY?=
 =?us-ascii?Q?s+AyqSDG3Ccn1J5gz/zw4N3QRpxFb8lQQ4hJQMQRCcavLC9QxKRj0rGGZAak?=
 =?us-ascii?Q?aTMgCvlo1JFFMyI48lSqlV1a3po90FK36c7KxA+zabNkrNovP63Hr96TdUus?=
 =?us-ascii?Q?1Bo6cY2UbZ8mRX2FWsY8HUB0l5LnFKbfTe4vPGTEvAJZFXJzj4huKGQOOX+N?=
 =?us-ascii?Q?Y7CLhiwudr4/slk8VWcZcDdT4QbAbW+qgD1Q9+zBpmm2dyk+9x6D7knAR9ko?=
 =?us-ascii?Q?NikG6gMtr2fk9pqZbU1lVOLoqOIt7DppLCCwHwnvp4Er2Ee5jmvh5Z+n7fwn?=
 =?us-ascii?Q?JWZxfu5j8A28nheH8I3244B1TnAiHO1DCrTwpCV6PQ4sFB5V9T6HzlnrmoZO?=
 =?us-ascii?Q?/cuxtZmPw9VBhwQxURJbNhTjXHZf+w8cXglEPFMzYfTWmmIVjUeHUeX4q+dD?=
 =?us-ascii?Q?0C6HqiY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d992b06-f243-43a9-c025-08df0528fb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:22:48.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7185

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026=
 6:27 AM
>=20
> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 76 ++++++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h           |  1 +
>  include/hyperv/hvhdk_mini.h           | 18 +++++++
>  3 files changed, 94 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv=
/hv-iommu-guest.c
> index 2169333020f4..3e38046bd998 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -396,11 +396,84 @@ static void hv_iommu_flush_iotlb_all(struct iommu_d=
omain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>=20
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, =
end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligne=
d.
> + */
> +static void
> +hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +			  union hv_iommu_flush_va *va)
> +{
> +	unsigned int sz_lg2;
> +
> +	sz_lg2 =3D fls_long(start ^ end);
> +	if (sz_lg2 < HV_HYP_PAGE_SHIFT)
> +		sz_lg2 =3D HV_HYP_PAGE_SHIFT;

Use the max() function here instead of open coding it?

	sz_lg2 =3D max(fls_long(start ^ end), HV_HYP_PAGE_SHIFT);

But maybe that's just more obscure. Your call.

> +
> +	/*
> +	 * A valid IOVA range shall not span bit 63. Use the maximum mask
> +	 * so the host can safely perform a full flush.
> +	 */
> +	if (WARN_ON_ONCE(sz_lg2 >=3D BITS_PER_LONG)) {
> +		va->as_uint64 =3D 0;
> +		va->page_mask_shift =3D
> +			BITS_PER_LONG - HV_HYP_PAGE_SHIFT;

This case is handled slightly inconsistently with the main case.
Here the entire 64 bits are cleared, which implicitly sets the
page_number field to zero and also clears the reserved field.
The main case sets the page_number but doesn't clear the
reserved field. The memset() in hv_flush_device_domain_list()
assumes that the reserved field might not be zeroed. I'd just
suggest making everything consistent and not doing any
duplicate zero'ing.

> +		return;
> +	}
> +
> +	va->page_number =3D
> +		(start & GENMASK(BITS_PER_LONG - 1, sz_lg2)) >>
> +		HV_HYP_PAGE_SHIFT;
> +	va->page_mask_shift =3D sz_lg2 - HV_HYP_PAGE_SHIFT;
> +}
> +
> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	/* Clear the fixed header and the single range entry. */
> +	memset(input, 0, struct_size(input, iova_list, 1));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> +	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
> +				  &input->iova_list[0]);
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> +				     1, 0, input, NULL);
> +
> +	if (WARN_ON_ONCE(!hv_result_success(status))) {

I'd suggest having a message here with the status. The list flush really
should not be failing, so outputting the status might provide a clue
as to what's going on if it does fail.

> +		/* Page-selective flush failed, fall back to full flush. */
> +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> +
> +		memset(flush_all, 0, sizeof(*flush_all));
> +		flush_all->device_domain =3D hv_domain->device_domain;
> +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> +					 flush_all, NULL);
> +		WARN(!hv_result_success(status),
> +		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also failed: %lld\n",
> +		     status);
> +	}
> +
> +	local_irq_restore(flags);
> +}
> +
>  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
>  				struct iommu_iotlb_gather *iotlb_gather)
>  {
> -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
>=20
> +	/*
> +	 * The hypercall also invalidates non-leaf page-walk caches, so
> +	 * detached page-table pages can now be freed.
> +	 */
>  	iommu_put_pages_list(&iotlb_gather->freelist);
>  }
>=20
> @@ -452,6 +525,7 @@ static struct iommu_domain
> *hv_iommu_domain_alloc_paging(struct device *dev)
>=20
>  	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
>  	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.common.features |=3D BIT(PT_FEAT_FLUSH_RANGE);
>  	/*
>  	 * Hyper-V S1 domains use a 4-level root for IOVA widths up to
>  	 * 48 bits. A 5-level root is used only for wider apertures when
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 5d1338197eee..966945f0504f 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -497,6 +497,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>  #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
>  #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> +#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 7b9f43b320cd..57b70efe60d4 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -685,4 +685,22 @@ struct hv_input_flush_device_domain {
>  	u32 reserved;
>  } __packed;
>=20
> +union hv_iommu_flush_va {	/* HV_IOMMU_GVA_RANGE */
> +	u64 as_uint64;
> +	struct {
> +		u64 page_mask_shift : 6;
> +		u64 reserved : 6;
> +		u64 page_number : 52;
> +	};
> +} __packed;
> +
> +/* HV_INPUT_FLUSH_DEVICE_DOMAIN_LIST */
> +struct hv_input_flush_device_domain_list {
> +	struct hv_input_device_domain device_domain;
> +#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT BIT(0)
> +	u32 flags;
> +	u32 reserved;
> +	union hv_iommu_flush_va iova_list[];
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20

