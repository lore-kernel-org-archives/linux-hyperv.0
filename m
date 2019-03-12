Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0119C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0022077B
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rv815nAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfCLVmO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:42:14 -0400
Received: from mail-eopbgr720130.outbound.protection.outlook.com ([40.107.72.130]:38144
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfCLVmO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Mar 2019 17:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/xwWFzCTm8zs4Zm/kIDvgC3JrogRPd3uctWK3j2PwU=;
 b=Rv815nABS9C0EFOtZCcAeqQI45E5YtwhwGQuOKGsfT0htozWPIm6DJsWzP5Oqcv43MpxOWh0Xi6vedBuCMN9vcpItlqA6xPfYECNzuX4MPBLs+F6v8pD095FjvkyPwrGFBEPor0zHP+QeVe8BLSscfG5kkZ73OJL+07cyCq0euQ=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0689.namprd21.prod.outlook.com (10.175.131.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Tue, 12 Mar 2019 21:42:10 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%13]) with mapi id 15.20.1730.000; Tue, 12 Mar 2019
 21:42:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: [PATCH 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate
 clocksource driver
Thread-Topic: [PATCH 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Index: AQHU2RxyOTq1l4uiQEScYNos9n0rug==
Date:   Tue, 12 Mar 2019 21:42:09 +0000
Message-ID: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:300:ef::12) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.147.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae98febe-2844-4567-14eb-08d6a733943f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0689;
x-ms-traffictypediagnostic: BN6PR21MB0689:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0689F66240923A78C8F6BC7BD7490@BN6PR21MB0689.namprd21.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2906002)(6506007)(6346003)(7736002)(305945005)(110136005)(99286004)(6636002)(105586002)(52116002)(25786009)(4326008)(3846002)(6116002)(22452003)(2501003)(10090500001)(316002)(106356001)(386003)(4720700003)(50226002)(8936002)(7416002)(5660300002)(14454004)(53936002)(66066001)(71200400001)(71190400001)(54906003)(8676002)(68736007)(1511001)(102836004)(2616005)(476003)(81166006)(26005)(486006)(86612001)(81156014)(478600001)(86362001)(97736004)(36756003)(6512007)(256004)(2201001)(10290500003)(6486002)(6436002)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0689;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KnbdOnCgC2mUGbCv7u/f5ThRUkHwye5GIwoYKNzooxX68zJazJ0mjDZ0iKmiBdvERYdvzeG9d43yha0TjuhrtRQMkLPfd0e5SumUxToIW5rtC/FKe7jHrnvaRjGlY3XUKb2qtsKrksA0ebEANZupBDN2ySE4PRNdKF0FN9fB7LIoBR23mbh56bVeHnGyDPTSorVsIodpVoWlTcM0GW7VuB4GguhwZujRH1ACBSTXE6nnDv9deOt80Upsf1mIWeTqtEdxU9WL8zdaozgK9G3yTAfq4EZL9Lj9/5Yl5V1YtZeqJs1G/+PabjsVLtWX1VuwNxreWePnmxzaPmLaH+kRpZpwA71sm1FL/VThNUJ2BWpxQdoG1/TCo7YRnH7b+SDkNMx3RYGnFli7gTE3X8ohc1EqRNySrZOYgnu1Il/7t/M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98febe-2844-4567-14eb-08d6a733943f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 21:42:09.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0689
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series moves Hyper-V clock/timer code to a separate Hyper-V
clocksource driver. Previously, Hyper-V clock/timer code and data
structures were mixed in with other Hyper-V code in the ISA independent
drivers/hv code as well as in arch dependent code. The new Hyper-V
clocksource driver is ISA independent, with a just few dependencies on
arch specific functions. The patch series does not change any behavior
or functionality -- it only reorganizes the existing code and fixes up
the linkages. A few places outside of Hyper-V code are fixed up to use
the new #include file structure.

This restructuring is in response to Marc Zyngier's review comments
on supporting Hyper-V running on ARM64, and is a good idea in general.
It increases the amount of code shared between the x86 and ARM64
architectures, and reduces the size of the new code for supporting
Hyper-V on ARM64. A new version of the Hyper-V on ARM64 patches will
follow once this clocksource restructuring is accepted.

The code is currently diff'ed against Linux 5.0.  I'll rebase
to linux-next once 5.1-rc1 is available.

Michael Kelley (2):
  Drivers: hv: Move Hyper-V clockevents code to new clocksource driver
  Drivers: hv: Move Hyper-V clocksource code to new clocksource driver

 MAINTAINERS                           |   2 +
 arch/x86/entry/vdso/vclock_gettime.c  |   1 +
 arch/x86/entry/vdso/vma.c             |   2 +-
 arch/x86/hyperv/hv_init.c             |  91 +---------
 arch/x86/include/asm/hyperv-tlfs.h    |   6 +
 arch/x86/include/asm/mshyperv.h       |  80 ++-------
 arch/x86/kernel/cpu/mshyperv.c        |   2 +
 arch/x86/kvm/x86.c                    |   1 +
 drivers/clocksource/Makefile          |   1 +
 drivers/clocksource/hyperv_syntimer.c | 328 ++++++++++++++++++++++++++++++=
++++
 drivers/hv/hv.c                       | 154 ----------------
 drivers/hv/hyperv_vmbus.h             |   3 -
 drivers/hv/vmbus_drv.c                |  39 ++--
 include/clocksource/hyperv_syntimer.h | 104 +++++++++++
 14 files changed, 482 insertions(+), 332 deletions(-)
 create mode 100644 drivers/clocksource/hyperv_syntimer.c
 create mode 100644 include/clocksource/hyperv_syntimer.h

--=20
1.8.3.1

