Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012072.outbound.protection.outlook.com [52.103.11.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630B3D5C2A;
	Fri,  9 Oct 2026 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524295; cv=fail; b=WBd6R60AF6+1nmq+AXFItjpHDcMksMRF+Vyn20CNYqqyOQ67yA9jY+lsOzL92o98yDgA5SLPYkFV5MQi+Tw9YgfrvtxgVL0+fjoVtgjskhdi32+h+WWtXp3pwq/u3zHF/26i36hmXYqw7miYYI1xeQ1H8LTimYBOZZJTI3VrR4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524295; c=relaxed/simple;
	bh=siY9to+oHvHaj8Yb73LoUSArXNKh+PUuPh73DRObeDs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgUjURJT8+5ldAWKnlEPMqaXPHYkOLqq0QJ8Ga0Gj5hn2XPCTz3xuWoiQqXf41i0QC/jUOXhMQuRjZtw6qSCEeEn1fJNai64C3GV3bzRxVhYsYtxlFtzTm0k5iqtg8tlCfVuQy0ydeCXc7L/M9BDTWAcE0amHWZKcnCi0qCyX60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LhS+03P7; arc=fail smtp.client-ip=52.103.11.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LhS+03P7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4LmCwWx/m+1MB0CmUhMWsK3fFKLxN23BcAwckf5FKrBwPgJWHrtXlMRJO9T+XT/Zr9YJJmKxH+XDx9ufS87K8fwm1BxkSD//twWrBDZ5VJe0v64CYFV1XdJ4PV6n1+TmIBgb6eOw1DbYi1oShonriccs/ekO23e5V/e1v4vBXye+EVnjduuhoIUDKN8CI88akI2VrA4qmvqoE36HQEMTZw7bRTFRcbYhB2ky1j3li0TisUEKVrT8vG48DEUYwv3NZOdWoThs6bWmhvlApFN2G+syTWYMLo8ng7wYjKIYEMYnD3MunrBZC6UKuRKC42jxdHZXdT0OiPIVGKD/pd7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9q3pSvyUY9geuT7NOesDqFC/AJyIjJuyyCIhZZfoKg=;
 b=CSSzKVn6nXmz/iKArnD6Yd+0MkjBVYazlYeunfok09pOqiT/iaqZBFKhuPuuTYoDWH89SLNXBzUPqVJrGu1tJn/DHKB0L5/+8hwlKd2CgfgABZKL6bKIcbkHaPEsTqaKEXcAKIGapeGclF7F8ETawohLo6tuHHIBpY+u8FtTt+ieEId4/hcSNLmngcus2r7rRsw8RnYkfdMGdDDo4d1m9c6rjJSeeOG8QqkxnMf+NbgWr3XOWiZZuldmddtZcTLngqxMjjduZLqc4Kjx1olCvOyTsIP/W2G0tvzgRBRUmqWeUS7ORkH5JDe0WY3P7kcDxcOm6/p17G+syknSv23rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9q3pSvyUY9geuT7NOesDqFC/AJyIjJuyyCIhZZfoKg=;
 b=LhS+03P7WpZhTElZB7POH6un6ak49Kw4xUeMeVb2FmpPtPdGpA7lVJEbqtzwHFI/o2p3h7Kx/Krui6udIEzgqG+Rwe5AxZysTEbNdt6KXQFkfCLsqPjZSfUXnhXcHgOH+yL6wRvbqQ/pWR5mvHiEgfOfHwRxbw/j4pTDsxo3T/iBx07TvODP6CZGuwgw30OIB1uKSojqUUrDKFwAJV5qXdbEzkw8KJSqmeiRiRW1HvejM2D3Oz/LdyaBLFyUWSkoaVtEWaHRnwzdyepKvUpcGw42hpQGfbRgud4GPuzL58bgWqph2PUD8aPfecPas6q0duW/iIrvQT6b8H/3sEWghw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DM6PR02MB6748.namprd02.prod.outlook.com (2603:10b6:5:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:38:11 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:38:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Remove support for guests on
 Hyper-V 2012/2012R2
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Remove support for guests on
 Hyper-V 2012/2012R2
Thread-Index: AQFEkpMUSn1qv+vNQ3m/jtMLya3HqrgmKwAAgAAQleA=
Date: Fri, 9 Oct 2026 05:38:11 +0000
Message-ID:
 <MN2PR02MB686331FD9FB26A23E1F01665D4922@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261009023437.3326-1-mhklinux@outlook.com>
 <396ae01e-c1c4-49f5-a9fa-6dc4430e8690@linux.microsoft.com>
In-Reply-To: <396ae01e-c1c4-49f5-a9fa-6dc4430e8690@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DM6PR02MB6748:EE_
x-ms-office365-filtering-correlation-id: 561fc055-c689-475e-9dd3-08df25c78197
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|19110799012|8060799015|8062599012|25010399006|13091999003|24021099003|31061999003|15080799012|37011999003|51005399006|40105399003|2607281247196008|102099032|56899033|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OhrgPOUj4o2mmtGGSJWR13n/xW1BymauqkMJDno+CT7FpY5w5Sz56ufGLZSK?=
 =?us-ascii?Q?XwSnYvI2ciVd6CLY2xJX4I376+g7XgWFGfdo4FuOkL20Jry8zkWfOIixEllQ?=
 =?us-ascii?Q?qnMGbrW1rk8h/DCWs+olNjnzdcDZLklrbAxJinm3gAGhPzEep6Vlit6msYQF?=
 =?us-ascii?Q?zxac3WchJAqMWkogOoFOH5a3+9X+xB+7HakUGoMUi7bJxsgCttadsQVWBTjS?=
 =?us-ascii?Q?fKB18bktbXJ/6J1GijRxDrJyaNiy38KduKAt0N/js6+PQBJwISk3NcGLDxxw?=
 =?us-ascii?Q?67lANKpRFsD9HTpeJNLcGORVg6VCY8Z/sPxTIsxisd1QkXCk8Iq48sw2QFpA?=
 =?us-ascii?Q?Je2AFR65uBmWki89Qq1yfbXcgXptV3IG97BIYyZjSaZh4Em+lTQAW+lVn5bF?=
 =?us-ascii?Q?b027Rjn9Pc//6V6UseVBXoYhZmUGe8hh1qj15ukxI4DyraC/w5yJFUQ238x6?=
 =?us-ascii?Q?GLGT1QvjvoGQVWzTPqBVICLB0xQW7tZ+WMti8PxNw/oE9C4Xah4e7Qa7vdh3?=
 =?us-ascii?Q?E9nFBBLKe7EWc8o6YbA6UmGn4ewmCmPS8qw6cIoA9cfI4C82rTgWslwWKio2?=
 =?us-ascii?Q?e6LluWPoZOfBj9FsIiNyVPoSbOBwslTZK/yiFW4gFZQxv0gdFK/z6rS6u8dq?=
 =?us-ascii?Q?Pq/LQosnYoIU+Ph89DnYVkEC23kXZGHB2YuVOAysrw40jH+gckZ2i+iYCOGR?=
 =?us-ascii?Q?+CLyY6PGKCNKH8cwJX9Gyatk6OMyHftxCuzGXgIh5RxLy+hbHNP+pFBePlTI?=
 =?us-ascii?Q?0ubeITqbCDDkjp0Q8IDievH9VzOYqsL4I4MfYtg2vYuhDbPpJa3p4OT0VQeO?=
 =?us-ascii?Q?/r/v7lDK8amZLEPB7xOmCBi8GLck8Y4j/6w4i0BaAKzzfzXfAPZ+GbndBCB6?=
 =?us-ascii?Q?/1uCeWNbgfCfYzSzvIKVQ01SJExZ1HUywMcibakCZNjbW8RGyKQinVeGjRYO?=
 =?us-ascii?Q?By/Gp48rJJCxVYEEVYEgOSaEMmt+2vhKKiDx4JBD6DjFfptxwkNa0MATr3kE?=
 =?us-ascii?Q?PS4YZYXQ4rhn3yF3Eb+SUGVEmL1yw+djMIDHI50AQcVwHzzA72q/hck4ymLi?=
 =?us-ascii?Q?Ttc9a8gi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bpsDqWS8Fd0c2X+MHS8wt3Xm3kSHEEI6x5NCA4vQabk9Ko6Ljtz/r7CIFq4A?=
 =?us-ascii?Q?3xP9jGSueTklgjzFg7xER4nB4/y5LySbZisPqZp81dN1L/uo5Ed3rzMNF/eK?=
 =?us-ascii?Q?a67USF2ZdJrm02LMD0qdaBC0KbIbxGwmeHb8+3DtYer5B+EPPWbOv9bPbO1Q?=
 =?us-ascii?Q?sIlaah0WJ0r5BMot24hbp5IeszWUD7xQr28zYQvUHpba7JDaFvI0oH7VjqNO?=
 =?us-ascii?Q?8x3O9yWH6ilcSBIi/H1i5pVCVHC+IHe0YivPOu/LJ2qHq7zEp8KAuzapSKc8?=
 =?us-ascii?Q?R8i7fUqqQoeaLlQHgHvFegv1kr6R1etxv33hfVpKbutTKhZnmOGQzUy6qE5U?=
 =?us-ascii?Q?2VvudAQUMNXQknAY0ptLQpUWKaDHstVs2LRDhyr6Uua4oYd/BeKIRgSOACe0?=
 =?us-ascii?Q?thIHt9OCYaLRsMVN7qmnpUT+6slvuTobYDo7nsRyLV8pY2Mb9GXPaTfVOYBh?=
 =?us-ascii?Q?H5Z3hlPbDpdQaphEZd+xzS57L6u8N3WTXxzGklSsOZ/qs/iKRTmdUEbbLHoH?=
 =?us-ascii?Q?xm+V1aRQQypPbJMB6brwoJ2+Df/sZPlFuAbOqF1PMg6g6Rn8m5Y60/YpRiaV?=
 =?us-ascii?Q?eHEpdQ5vDxg5Y3w7r5QAUrqJeK5Tq7asNyYQqSZK6KNLxR7Ln6jyYoP9r2H7?=
 =?us-ascii?Q?0djF9IFkHq8fNKyA5b91QecbC/xeET7clg0lzNqTAetzYk1XDYcl+K5GrJmg?=
 =?us-ascii?Q?9ffRrKnuw4ANHGRRVupwzl6Jn+6FNm7x3U7rL6QofSICxeC2VTox9Pq47cHN?=
 =?us-ascii?Q?k+m9apaairTI+vYO6lROcovlvpXm3Yw86tXNw53Wo1McO6LbFJJbus1Xh4rq?=
 =?us-ascii?Q?XHDQ1lvQ0WJUzhBOGVli2gRf0v3MkzS2bGI1D3Zalyu2k0xQeYRhxQNch9nW?=
 =?us-ascii?Q?CCWf11t6HSFfljuJmVB2bEdeLHZk+Bwq5en9HnoR6cNHZQ/eqgjRAY2OjP7K?=
 =?us-ascii?Q?WJqKD1p434yZwbg9jdA7gD2sgHZtGT9clDYnRqpwElPNNi9X9vodiEJhc7OA?=
 =?us-ascii?Q?QWqW+mmS9wVbmk8XtILavuNnjMkfgsQmjRYmCNWr6nCDCSDnWDEn09Rz/m5H?=
 =?us-ascii?Q?Uqr9vja9cZKGmDZbrSZRuh8kTKyIW83QCDznWTXLFxvvCE3QaODG6VJToxjY?=
 =?us-ascii?Q?JvLxTkRfeEOjuD6hN5uwRbVPeJarg7DReVOqVVCs15jr/pbAWwPRtQ/lJDw5?=
 =?us-ascii?Q?ohk/L1yEmp6bIZ3Z6Y/y9NLT1jru0pnwXfxVoa99tJ+j9luuhlJmsJd2PV7X?=
 =?us-ascii?Q?N/uYh2PTi5pk+yjYa4HLRGMLse4lMNJwUXPO5mqvNXGHWO1oq9IRJBzsjaCk?=
 =?us-ascii?Q?k4/rD9dfLqmH0KXskl0bexbHVk38cpNWC8jdwIq0HsRbc+Rehvcv8wMPC1gv?=
 =?us-ascii?Q?TLs/MVs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 561fc055-c689-475e-9dd3-08df25c78197
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 05:38:11.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6748

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 8, 2=
026 9:39 PM
>=20
> On 10/9/2026 8:04 AM, Michael Kelley wrote:
> > Support for running Linux guests on Windows Server 2012/2012 R2 Hyper-V
> > hosts and Windows 8/8.1 hosts has been removed, which includes removing
> > support for operating Hyper-V synthetic timers in other than Direct Mod=
e.
> > Update the documentation to reflect these removals.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > This patch reflects changes that are already in linux-next for merging
> > into the 7.4 kernel.
> >
> >   Documentation/virt/hyperv/clocks.rst   | 8 ++------
> >   Documentation/virt/hyperv/overview.rst | 6 +++---
> >   2 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/virt/hyperv/clocks.rst
> b/Documentation/virt/hyperv/clocks.rst
> > index 176043265803..9527e6073654 100644
> > --- a/Documentation/virt/hyperv/clocks.rst
> > +++ b/Documentation/virt/hyperv/clocks.rst
> > @@ -64,12 +64,8 @@ applying the scale and offset to get the constant 10=
 MHz clock.
> >
> >   Linux clockevents are based on Hyper-V synthetic timer 0 (stimer0).
> >   While Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
> > -timer 0. In older versions of Hyper-V, an interrupt from stimer0
> > -results in a VMBus control message that is demultiplexed by
> > -vmbus_isr() as described in the Documentation/virt/hyperv/vmbus.rst
> > -documentation. In newer versions of Hyper-V, stimer0 interrupts can
> > -be mapped to an architectural interrupt, which is referred to as
> > -"Direct Mode". Linux prefers to use Direct Mode when available. Since
> > +timer 0. stimer0 is operated in what Hyper-V calls "Direct Mode"
> > +where timer interrupts are mapped to an architectural interrupt. Since
> >   x86/x64 doesn't support per-CPU interrupts, Direct Mode statically
> >   allocates an x86 interrupt vector (HYPERV_STIMER0_VECTOR) across all =
CPUs
> >   and explicitly codes it to call the stimer0 interrupt handler. Hence
> > diff --git a/Documentation/virt/hyperv/overview.rst
> b/Documentation/virt/hyperv/overview.rst
> > index 77408a89d1a4..c4c262b77aa3 100644
> > --- a/Documentation/virt/hyperv/overview.rst
> > +++ b/Documentation/virt/hyperv/overview.rst
> > @@ -157,9 +157,9 @@ when accessing data shared with Hyper-V.
> >   Versioning
> >   ----------
> >   Current Linux kernels operate correctly with older versions of
> > -Hyper-V back to Windows Server 2012 Hyper-V. Support for running
> > -on the original Hyper-V release in Windows Server 2008/2008 R2
> > -has been removed.
> > +Hyper-V back to Windows Server 2016 Hyper-V and Windows 10. Support fo=
r
> > +running on Windows Server 2012/2012 R2, Windows Server 2008/2008 R2,
> > +and Windows 8.1 and earlier has been removed.
> >
> >   A Linux guest on Hyper-V outputs in dmesg the version of Hyper-V
> >   it is running on.  This version is in the form of a Windows build
>=20
> Thanks Michael. Change LGTM, but while at it, please add a similar
> change in
> Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst as
> well.

Indeed. I wasn't even aware the netvsc documentation existed. :-(

I can update the supported Hyper-V versions. But this documentation
has not had any significant content updates since early 2021. Haiyang
should review it from an overall content standpoint and make
appropriate updates. I don't have the knowledge to do that.

Michael

>=20
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>=20
> Regards,
> Naman
