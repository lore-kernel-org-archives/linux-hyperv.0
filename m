Return-Path: <SRS0=mRNI=RP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC833C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E6F2173C
	for <linux-hyperv@archiver.kernel.org>; Tue, 12 Mar 2019 21:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bWmMDSG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfCLVma (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:42:30 -0400
Received: from mail-eopbgr800129.outbound.protection.outlook.com ([40.107.80.129]:9555
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfCLVm3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Mar 2019 17:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/pA/XNlw9BQ4jkG5bhzrY0TkCqjlefzgzBKRhh3Ngc=;
 b=bWmMDSG8v2o/5CDxtKRhaDth0CWfuF9UOUXvgz9MJ9UKNgsjv7RO2GQgYBKo8zXjkEvi0NdpL/L6ePQyohF7lyBwBV5n8xyxgSFS27nCc7XohPr58WNfANIxJzmwqZ1U7MsfMegDQqTRS2TP+/peIl2F8DWjqApIxdFOIOvQGDc=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0689.namprd21.prod.outlook.com (10.175.131.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Tue, 12 Mar 2019 21:42:22 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::f458:691d:54a:b05c%13]) with mapi id 15.20.1730.000; Tue, 12 Mar 2019
 21:42:22 +0000
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
Subject: [PATCH 2/2] Drivers: hv: Move Hyper-V clocksource code to new
 clocksource driver
Thread-Topic: [PATCH 2/2] Drivers: hv: Move Hyper-V clocksource code to new
 clocksource driver
Thread-Index: AQHU2Rx5CheMg5nicUqlZN4Pn8rMPw==
Date:   Tue, 12 Mar 2019 21:42:21 +0000
Message-ID: <1552426813-9568-3-git-send-email-mikelley@microsoft.com>
References: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1552426813-9568-1-git-send-email-mikelley@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 23df197e-b7b4-4f70-42bc-08d6a7339bb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0689;
x-ms-traffictypediagnostic: BN6PR21MB0689:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0689B55D87EB336EA95392BFD7490@BN6PR21MB0689.namprd21.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2906002)(6506007)(6346003)(7736002)(305945005)(110136005)(99286004)(76176011)(6636002)(105586002)(52116002)(25786009)(4326008)(3846002)(6116002)(22452003)(2501003)(10090500001)(316002)(106356001)(386003)(4720700003)(50226002)(8936002)(7416002)(5660300002)(14454004)(53946003)(53936002)(66066001)(71200400001)(71190400001)(54906003)(8676002)(68736007)(1511001)(102836004)(2616005)(476003)(11346002)(446003)(30864003)(81166006)(26005)(486006)(86612001)(81156014)(478600001)(14444005)(86362001)(97736004)(36756003)(6512007)(256004)(2201001)(10290500003)(6486002)(6436002)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0689;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ASLjnuyLKdcdefILDxMNfEU4X70oFDwZxxstDSzerWbTvnTWncsbzoVLTTeX/6Ql1APEH8vSO82CFFduCFKeohw4pn2Pm1sLwLj+WhSbik+Yc9OaybuK3P8pYg8Ng2I8nSVJUUid/tMvhDiH5tdUx2qX25/s1U88G6ElU2f8TYte/0qId/nMXu+3NeR+NogKkBrRNzIJxxLoqQqfVZuXPVhOiYVkJkngBHjz41/bWlqpOiK2F6B1iUALG2JbU8+/Oxl91ypbagU+RdInHxE2G8SUpqak7GT0gmt3C3muX4B8UWJqKvSQD7RVF+GhzoqaNb7KtB60dZpZLygJ7eENKjksyGw5sY9vYCaYwcJlvJRiNjFxfOYIU+BUdiz/zzB34RCs7PLLsDoGcxKFbCLNvrxAHkky+uc4av/OTx7Wdkk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23df197e-b7b4-4f70-42bc-08d6a7339bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 21:42:22.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0689
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Code for the Hyper-V specific clocksources is currently mixed
in with other Hyper-V code. Move the code to a Hyper-V specific
driver in the "clocksource" directory, while separating out
ISA dependencies so that the new clocksource driver is ISA
independent. Update the Hyper-V initialization code to call
initialization and cleanup routines since the Hyper-V synthetic
timers are not independently enumerated in ACPI. Update Hyper-V
clocksource users KVM and VDSO to get definitions from a new
include file.

No behavior is changed and no new functionality is added.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/entry/vdso/vclock_gettime.c  |   1 +
 arch/x86/entry/vdso/vma.c             |   2 +-
 arch/x86/hyperv/hv_init.c             |  91 ++-----------------------
 arch/x86/include/asm/mshyperv.h       |  80 +++-------------------
 arch/x86/kvm/x86.c                    |   1 +
 drivers/clocksource/hyperv_syntimer.c | 122 ++++++++++++++++++++++++++++++=
++++
 include/clocksource/hyperv_syntimer.h |  78 ++++++++++++++++++++++
 7 files changed, 219 insertions(+), 156 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vcl=
ock_gettime.c
index 007b3fe9..b0de2a2 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <clocksource/hyperv_syntimer.h>
=20
 #define gtod (&VVAR(vsyscall_gtod_data))
=20
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index babc4e7..8b81c91 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -22,7 +22,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
-#include <asm/mshyperv.h>
+#include <clocksource/hyperv_syntimer.h>
=20
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled =3D 1;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e..eb80f65 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -27,64 +27,13 @@
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <linux/clockchips.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-
-static struct ms_hyperv_tsc_page *tsc_pg;
-
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return tsc_pg;
-}
-EXPORT_SYMBOL_GPL(hv_get_tsc_page);
-
-static u64 read_hv_clock_tsc(struct clocksource *arg)
-{
-	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
-
-	if (current_tick =3D=3D U64_MAX)
-		rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_tsc =3D {
-		.name		=3D "hyperv_clocksource_tsc_page",
-		.rating		=3D 400,
-		.read		=3D read_hv_clock_tsc,
-		.mask		=3D CLOCKSOURCE_MASK(64),
-		.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
-};
-#endif
-
-static u64 read_hv_clock_msr(struct clocksource *arg)
-{
-	u64 current_tick;
-	/*
-	 * Read the partition counter to get the current tick count. This count
-	 * is set to 0 when the partition is created and is incremented in
-	 * 100 nanosecond units.
-	 */
-	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_msr =3D {
-	.name		=3D "hyperv_clocksource_msr",
-	.rating		=3D 400,
-	.read		=3D read_hv_clock_msr,
-	.mask		=3D CLOCKSOURCE_MASK(64),
-	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
-};
+#include <clocksource/hyperv_syntimer.h>
=20
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
=20
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
@@ -349,41 +298,11 @@ void __init hyperv_init(void)
 	x86_init.pci.arch_init =3D hv_pci_init;
=20
 	/*
-	 * Register Hyper-V specific clocksource.
+	 * Register Hyper-V specific clocksource. Pass 'false' as the
+	 * arguemnt, indicating to not register the clocksource as the
+	 * sched clock.
 	 */
-#ifdef CONFIG_HYPERV_TSCPAGE
-	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
-		union hv_x64_msr_hypercall_contents tsc_msr;
-
-		tsc_pg =3D __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
-		if (!tsc_pg)
-			goto register_msr_cs;
-
-		hyperv_cs =3D &hyperv_cs_tsc;
-
-		rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		tsc_msr.enable =3D 1;
-		tsc_msr.guest_physical_address =3D vmalloc_to_pfn(tsc_pg);
-
-		wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		hyperv_cs_tsc.archdata.vclock_mode =3D VCLOCK_HVCLOCK;
-
-		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
-		return;
-	}
-register_msr_cs:
-#endif
-	/*
-	 * For 32 bit guests just use the MSR based mechanism for reading
-	 * the partition counter.
-	 */
-
-	hyperv_cs =3D &hyperv_cs_msr;
-	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
-		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
-
+	hv_init_clocksource(false);
 	return;
=20
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index cc60e61..9326689 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -105,6 +105,17 @@ static inline void vmbus_signal_eom(struct hv_message =
*msg, u32 old_msg_type)
 #define hv_get_crash_ctl(val) \
 	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
=20
+#define hv_get_time_ref_count(val) \
+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
+
+#define hv_get_reference_tsc(val) \
+	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_reference_tsc(val) \
+	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_clocksource_vdso(val) \
+	((val).archdata.vclock_mode =3D VCLOCK_HVCLOCK)
+#define hv_get_raw_timer() rdtsc_ordered()
+
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
 #ifdef CONFIG_TRACING
@@ -387,73 +398,4 @@ static inline int hyperv_flush_guest_mapping_range(u64=
 as,
 }
 #endif /* CONFIG_HYPERV */
=20
-#ifdef CONFIG_HYPERV_TSCPAGE
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *ts=
c_pg,
-				       u64 *cur_tsc)
-{
-	u64 scale, offset;
-	u32 sequence;
-
-	/*
-	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
-	 * Top-Level Functional Specification ver. 3.0 and above. To get the
-	 * reference time we must do the following:
-	 * - READ ReferenceTscSequence
-	 *   A special '0' value indicates the time source is unreliable and we
-	 *   need to use something else. The currently published specification
-	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
-	 * - ReferenceTime =3D
-	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
-	 * - READ ReferenceTscSequence again. In case its value has changed
-	 *   since our first reading we need to discard ReferenceTime and repeat
-	 *   the whole sequence as the hypervisor was updating the page in
-	 *   between.
-	 */
-	do {
-		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
-		if (!sequence)
-			return U64_MAX;
-		/*
-		 * Make sure we read sequence before we read other values from
-		 * TSC page.
-		 */
-		smp_rmb();
-
-		scale =3D READ_ONCE(tsc_pg->tsc_scale);
-		offset =3D READ_ONCE(tsc_pg->tsc_offset);
-		*cur_tsc =3D rdtsc_ordered();
-
-		/*
-		 * Make sure we read sequence after we read all other values
-		 * from TSC page.
-		 */
-		smp_rmb();
-
-	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
-
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg=
)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
-}
-
-#else
-static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return NULL;
-}
-
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *ts=
c_pg,
-				       u64 *cur_tsc)
-{
-	BUG();
-	return U64_MAX;
-}
-#endif
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 941f932..4f83437 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -70,6 +70,7 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/intel_pt.h>
+#include <clocksource/hyperv_syntimer.h>
=20
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/clocksource/hyperv_syntimer.c b/drivers/clocksource/hy=
perv_syntimer.c
index 7276308..57e10bf 100644
--- a/drivers/clocksource/hyperv_syntimer.c
+++ b/drivers/clocksource/hyperv_syntimer.c
@@ -14,6 +14,8 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
 #include <linux/cpuhotplug.h>
 #include <linux/mm.h>
 #include <clocksource/hyperv_syntimer.h>
@@ -204,3 +206,123 @@ void hv_syntimer_global_cleanup(void)
 	hv_syntimer_free();
 }
 EXPORT_SYMBOL_GPL(hv_syntimer_global_cleanup);
+
+/*
+ * Code and definitions for the Hyper-V clocksources.  Two
+ * clocksources are defined: one that reads the Hyper-V defined MSR, and
+ * the other that uses the TSC reference page feature as defined in the
+ * TLFS.  The MSR version is for compatibility with old versions of
+ * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ */
+
+struct clocksource *hyperv_cs;
+EXPORT_SYMBOL_GPL(hyperv_cs);
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+
+static struct ms_hyperv_tsc_page *tsc_pg;
+
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
+
+static u64 read_hv_sched_clock_tsc(void)
+{
+	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
+
+	if (current_tick =3D=3D U64_MAX)
+		hv_get_time_ref_count(current_tick);
+
+	return current_tick;
+}
+
+static u64 read_hv_clock_tsc(struct clocksource *arg)
+{
+	return read_hv_sched_clock_tsc();
+}
+
+static struct clocksource hyperv_cs_tsc =3D {
+		.name		=3D "hyperv_clocksource_tsc_page",
+		.rating		=3D 400,
+		.read		=3D read_hv_clock_tsc,
+		.mask		=3D CLOCKSOURCE_MASK(64),
+		.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+#endif
+
+static u64 read_hv_sched_clock_msr(void)
+{
+	u64 current_tick;
+	/*
+	 * Read the partition counter to get the current tick count. This count
+	 * is set to 0 when the partition is created and is incremented in
+	 * 100 nanosecond units.
+	 */
+	hv_get_time_ref_count(current_tick);
+	return current_tick;
+}
+
+static u64 read_hv_clock_msr(struct clocksource *arg)
+{
+	return read_hv_sched_clock_msr();
+}
+
+static struct clocksource hyperv_cs_msr =3D {
+	.name		=3D "hyperv_clocksource_msr",
+	.rating		=3D 400,
+	.read		=3D read_hv_clock_msr,
+	.mask		=3D CLOCKSOURCE_MASK(64),
+	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init hv_init_clocksource(bool reg_sched_clock)
+{
+#ifdef CONFIG_HYPERV_TSCPAGE
+	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
+
+		u64		tsc_msr;
+		phys_addr_t	phys_addr;
+
+		tsc_pg =3D vmalloc(PAGE_SIZE);
+		if (!tsc_pg)
+			goto register_msr_cs;
+
+		hyperv_cs =3D &hyperv_cs_tsc;
+		phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
+
+		/* The Hyper-V TLFS specifies to preserve the value of
+		 * reserved bits in registers.  So read the existing
+		 * value, preserve the low order 12 bits, and add in
+		 * the guest physical address (which already has at
+		 * least the low 12 bits set to zero since it is page
+		 * aligned). Also set the "enable" bit, which is bit 0.
+		 */
+		hv_get_reference_tsc(tsc_msr);
+		tsc_msr &=3D GENMASK_ULL(11, 0);
+		tsc_msr =3D tsc_msr | 0x1 | (u64)phys_addr;
+		hv_set_reference_tsc(tsc_msr);
+
+		hv_set_clocksource_vdso(hyperv_cs_tsc);
+		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
+		if (reg_sched_clock)
+			sched_clock_register(read_hv_sched_clock_tsc,
+						64, HV_CLOCK_HZ);
+		return;
+	}
+register_msr_cs:
+#endif
+	/*
+	 * For 32 bit guests just use the MSR based mechanism for reading
+	 * the partition counter.
+	 */
+	hyperv_cs =3D &hyperv_cs_msr;
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE) {
+		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+		if (reg_sched_clock)
+			sched_clock_register(read_hv_sched_clock_msr,
+						64, HV_CLOCK_HZ);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/include/clocksource/hyperv_syntimer.h b/include/clocksource/hy=
perv_syntimer.h
index 154138b..8ce351b 100644
--- a/include/clocksource/hyperv_syntimer.h
+++ b/include/clocksource/hyperv_syntimer.h
@@ -13,6 +13,10 @@
 #ifndef __CLKSOURCE_HYPERV_SYNTIMER_H
 #define __CLKSOURCE_HYPERV_SYNTIMER_H
=20
+#include <linux/clocksource.h>
+#include <linux/math64.h>
+#include <asm/mshyperv.h>
+
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
=20
@@ -23,4 +27,78 @@
 extern void hv_syntimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
=20
+#ifdef CONFIG_HYPERV
+extern struct clocksource *hyperv_cs;
+extern void hv_init_clocksource(bool reg_sched_clock);
+#endif /* CONFIG_HYPERV */
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *ts=
c_pg,
+				       u64 *cur_tsc)
+{
+	u64 scale, offset;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =3D
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			return U64_MAX;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale =3D READ_ONCE(tsc_pg->tsc_scale);
+		offset =3D READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc =3D hv_get_raw_timer();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg=
)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#else /* CONFIG_HYPERV_TSC_PAGE */
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *ts=
c_pg,
+				       u64 *cur_tsc)
+{
+	return U64_MAX;
+}
+#endif /* CONFIG_HYPERV_TSCPAGE */
+
 #endif
--=20
1.8.3.1

