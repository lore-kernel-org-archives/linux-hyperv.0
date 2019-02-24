Return-Path: <SRS0=i+7F=Q7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436FC43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 16:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830B205C9
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n5c709KL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfBXQxI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:53:08 -0500
Received: from mail-eopbgr750101.outbound.protection.outlook.com ([40.107.75.101]:4096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbfBXQxH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Feb 2019 11:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoLCbI+hGV20QxSet2LXu1xmfBX+egblzUN+mCLtx60=;
 b=n5c709KLX6lvH+KvvQlzl2npZhZqgJWZKDiW48Uowve442BR4EQhaHvmG0eHy++lUNdfK8ckomZBlssf3lUrVHqdL+cHayBJpaghe4q0UJHnmjFbaZNk1GrYUKEzv32EE7dGNm1Mx1T1Lp9nv/TOwAW0vc0eUlBEfnrWwYIz540=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1030.namprd21.prod.outlook.com (52.132.128.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.4; Sun, 24 Feb 2019 16:53:03 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%8]) with mapi id 15.20.1686.003; Sun, 24 Feb 2019
 16:53:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] Drivers: hv: vmbus: Add a channel ring buffer
 mutex lock
Thread-Topic: [PATCH v2 2/2] Drivers: hv: vmbus: Add a channel ring buffer
 mutex lock
Thread-Index: AQHUymFQBaxVFlAv00Op8wCtCgr/TqXvKUmQ
Date:   Sun, 24 Feb 2019 16:53:03 +0000
Message-ID: <DM5PR2101MB0918921A96F16D862BA2AF0FD7790@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <cover.1550806305.git.kimbrownkd@gmail.com>
 <c18bc31987ba67b8418fa2118f65bb258cb8899b.1550806305.git.kimbrownkd@gmail.com>
In-Reply-To: <c18bc31987ba67b8418fa2118f65bb258cb8899b.1550806305.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-24T16:53:00.2768187Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e6ef1a3-0d56-408d-9341-bbf11f0b70ca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa0515dd-8e9a-49b6-cb32-08d69a788ae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1030;23:nBcAlcxnUY5Nm536FT8MyraxGp9z8x9zGo510OW?=
 =?us-ascii?Q?TBZbg7jKyBcJCxu48REhfHxaIcrh5kq4ozKrhvlb6HrUvmYd2/MMLVGD+hBb?=
 =?us-ascii?Q?xzr7nHk/BT1suHgCUly7cChYFFPf0VNxNhm1Sn3Mbme0B3Hr1mgUfpDFPu/a?=
 =?us-ascii?Q?WRtMK1fWQObijNPJaVrVk7fgf8QtyjxfO7zEyZJ5MMU+oVgIBACraNiNEb+N?=
 =?us-ascii?Q?/J9k1rJuXuY18L7DPOv6Cx0il14qGT8Af2xvLvdgegsV2fjqHaPoy+UQru2/?=
 =?us-ascii?Q?T6Ii0/YDayBX0u/IVuoa14sTZoTxTl6pcnu3k4EduOyO4SVocgJKPHPVYNll?=
 =?us-ascii?Q?q9HGgADrZ3kRhclmubnzODcBEc3pvpozOiPskIZ+8v969ES9h2H0/3ITa0ar?=
 =?us-ascii?Q?mCCYwYZrQDcLWbrHzr3oDVCNR5Q7ij+Qz2Lbu8UjR2AaZ7cwLjnaFBlNGh+W?=
 =?us-ascii?Q?ZiaUcA7cqR/XbEZLtC1IMmP+VC+jAVdG6BI8yILpg3HsVVoGNtBliedQ0oIS?=
 =?us-ascii?Q?gRNCyMQr/fIyiI7ecqFUphSyM/ann0uQ058Zi2aPxZ506PobgxtkVANHvExy?=
 =?us-ascii?Q?6hSjtZxqYhIQD9d4Ihvd8ttYuhK4LYXkpoG8EejCwdMFNnKtSP+CVby6DHID?=
 =?us-ascii?Q?oKMa2w1UPsyGULBSlCViWCzQ5nQ16RD0tPi2DgoYTsSCzI1RVbHRHGWUCzk4?=
 =?us-ascii?Q?jRAHH8ytiN6ob4eCvALGNQ9DyYiXWBh2LdCti0n3hoaXXdDLy+I62cwx05as?=
 =?us-ascii?Q?S0ZSl7QEGHIZufwZmHZ1rwPU9Vtq01UiuqCKifLB1Q7FvaNT5njlie05Ik/p?=
 =?us-ascii?Q?JLbfhZ0UBnRgMyGYdNnNauh84+glJ4E0CTtqDOZkOOD7ZiuOxrx/Q/lSq1U7?=
 =?us-ascii?Q?MrwqLl3BTDhRF63VZ4nbRnXn7ydNjQV1XJgQPskzFlm+ksMuKhjGzDZ51g9T?=
 =?us-ascii?Q?P4BWFy1dm9sobxE2Xs0D1jSfamqk6v1re7J4cTboiA7b5iScOYpV/Z6Zy4QW?=
 =?us-ascii?Q?j5f00eCrfonbVeeQAJa7p5XOW2xrgpxtiZsMkbxvNsOMiBZjFbEcEG0mPpzU?=
 =?us-ascii?Q?zU77nyNGHfKXWno0KjJirAN386JqiYwwhbzgBAiWWTIgirAsyb3rhd/TjZ+3?=
 =?us-ascii?Q?H5Jebv3NL0gx0xyDy6DYg8NenEJ5f4Mqopjwm1VqlcA8+GgZN7Wf/CDwNsIl?=
 =?us-ascii?Q?QLFwHuYRQ0iIR8WEOYu5TjFxvOaNvYPSnxnFi5zPlCMVm0W1d/Sd2b+kmoHN?=
 =?us-ascii?Q?JEdaz+cQY98hABadr09m4r4k+hjhQScvXHmsHNNK31IHzs+ChbSiUGiPHd1P?=
 =?us-ascii?Q?1N2C4tT9pVgfnWKmfAEUlPlaJYS+gwFU7SSkLEDEgG2ql+JwNfwPVw2ZX8zr?=
 =?us-ascii?Q?tNW55uVadDOXzvUZyfcl6SL4TLmcFyUpS08w2HV5eXzyK5QGTy5UkbQFx+hf?=
 =?us-ascii?Q?jNwCQLyVgOuFD9u1/ihNllhFUOaEqWJI=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB10300582336CCD3371AA69B1D7790@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(8990500004)(4326008)(186003)(1511001)(74316002)(81156014)(54906003)(97736004)(110136005)(7736002)(305945005)(8676002)(81166006)(6436002)(33656002)(256004)(229853002)(102836004)(14444005)(6506007)(10090500001)(26005)(316002)(6116002)(3846002)(2906002)(68736007)(71190400001)(6346003)(9686003)(22452003)(71200400001)(86612001)(966005)(25786009)(7696005)(478600001)(10290500003)(476003)(66066001)(486006)(6246003)(6636002)(99286004)(86362001)(8936002)(6306002)(76176011)(446003)(55016002)(11346002)(53936002)(106356001)(14454004)(105586002)(5660300002)(52536013);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0E1l3KrvqLTu8xYFfHwtHkdr1SuUqhDgjK8LqVfNXr6oY41XBz6APv+BUQRZihXdF9Ip0eemUFC/ESSHuSw/h7JG2RkkFt2WtDbNx8JQFzq6e6RBwTdmlQ4RcK1NEWn/BrSFun7EL0n7+py0uMN84aznedkNDPsKf93AmLeUmMhv6TX009smtkWKutEpj1GkHuxsbGkz4uS4+m6LQ+xyENZo+ClqNpiPJ4UAKOLcMIeM51oYzU7emsLdJIxtJa3+IIv5mrX4F+sMXovTHVXk2HL+DiTw36+lcRYRmBt6sb2fzLJx3ZegvOgZb5HaGPLOHkGsmqOv5lBzA/g1SopLwlkYP7QNQgfdVqroYOunNxIi13shM3bW7dgCQ7IUu1H3i22GZW0FggNFK5Th3NxtUwOQ33tgIoI67FgY5L9+YhY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0515dd-8e9a-49b6-cb32-08d69a788ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 16:53:03.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Thursday, February 21, 20=
19 7:47 PM
>=20
> The "_show" functions that access channel ring buffer data are
> vulnerable to a race condition that can result in a NULL pointer
> dereference. This problem was discussed here:
> https://lkml.org/lkml/2018/10/18/779=20
>
> To prevent this from occurring, add a new mutex lock,
> "ring_buffer_mutex", to the vmbus_channel struct.
>=20
> Acquire/release "ring_buffer_mutex" in the functions that can set the
> ring buffer pointer to NULL: vmbus_free_ring() and __vmbus_open().
>=20
> Acquire/release "ring_buffer_mutex" in the four channel-level "_show"
> functions that access ring buffer data. Remove the "const" qualifier
> from the "struct vmbus_channel *chan" parameter of the channel-level
> "_show" functions so that "ring_buffer_mutex" can be acquired/released
> in these functions.
>=20
> Acquire/release "ring_buffer_mutex" in hv_ringbuffer_get_debuginfo().
> Pass the channel pointer to hv_ringbuffer_get_debuginfo() so that
> "ring_buffer_mutex" can be accessed in this function.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

I've reviewed the code.  I believe it is correct and fixes the race
condition.  Unfortunately, the code ended up being messier than I
had hoped, and in particular, the need to pass the channel pointer
into the ring buffer functions is distasteful.  An alternate idea is to
put the new mutex into the hv_ring_buffer_info structure.  This results
in two mutex's since there's a separate hv_ring_buffer_info structure for
the "in" ring and the "out" ring.  But it makes the ring buffer functions
more self-contained and able to operate without knowledge of the
channel.   The mutex can be obtained in hv_ringbuffer_cleanup() instead
of in the vmbus functions, and hv_ringbuffer_get_debuginfo() doesn't
need the channel pointer.

The "const" still has to dropped from the channel pointer because
the hv_ring_buffer_info structures are inline in the channel structure,
but that's less objectionable.   The extra memory for two mutex's isn't
really a problem, and none of the code paths are performance
sensitive.

It's a tradeoff.  I think I slightly prefer moving the mutex to the
hv_ring_buffer_info structure, but could also be persuaded to
take it like it is.

Thoughts?

Michael

