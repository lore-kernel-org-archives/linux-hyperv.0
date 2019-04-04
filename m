Return-Path: <SRS0=ldGZ=SG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F1C4360F
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0E20820
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 00:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDDAiF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:38:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:30418 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDAiF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Apr 2019 20:38:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 17:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="scan'208";a="220358449"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.7.189.89])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2019 17:38:04 -0700
Date:   Wed, 3 Apr 2019 17:38:04 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     linux-hyperv@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, shiny.sebastian@intel.com
Subject: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
Message-ID: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Thread-Topic: nvme hv_pci dda: request for interrupt failed
Thread-Index: AdTqewKw9ZFXkHiTTdS6NKeOfxDFoA==
Content-Language: en-US
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGJkOWYxNWQtOTg5MC00YmM3LWI3NmYtZDBmOTRjNWRkNDU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibkZHejlHTzlGK1pWRnZyMUswSDM3ZE9XdEpEUjA2eDlyak1kNTlSR1wvQUh3cHhVcUFKWjhyaEFyYXF1UERxNWgifQ==
x-ms-exchange-imapappendstamp: FMSMSX102.amr.corp.intel.com (14.03.0399.000)
Content-ID: <1EFB2C0359704549905C8C49C5E90B3C@intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When two nvme devices are discrete-assigned [1] to a linuxvm on
hyper-v rs5 host, it fails to initialize both.  It worked a couple of
times and after some reboots it failed. `dmesg` shows:

[   13.941971] nvme nvme0: pci function 82c6:00:00.0
[   13.942802] nvme 82c6:00:00.0: can't derive routing for PCI INT A
[   13.942803] nvme 82c6:00:00.0: PCI INT A: no GSI
[   13.942844] nvme nvme1: pci function 8f8d:00:00.0
[   13.943397] nvme 8f8d:00:00.0: can't derive routing for PCI INT A
[   13.943399] nvme 8f8d:00:00.0: PCI INT A: no GSI
[   14.099310] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for interrupt failed: 0xc000009a
[   14.099353] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: Request for interrupt failed: 0xc000009a
[   14.119391] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: hv_irq_unmask() failed: 0x5
[   14.124416] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: hv_irq_unmask() failed: 0x5
[   74.932888] nvme nvme1: I/O 7 QID 0 timeout, completion polled
[   74.932893] nvme nvme0: I/O 3 QID 0 timeout, completion polled
[  136.372890] nvme nvme1: I/O 4 QID 0 timeout, completion polled
[  136.372892] nvme nvme0: I/O 20 QID 0 timeout, completion polled
[  136.373280] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: Request for interrupt failed: 0xc000009a
[  136.373432] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for interrupt failed: 0xc000009a
[  136.376262] hv_pci 092472da-23bf-434f-8f8d-cc7546cf6cc1: hv_irq_unmask() failed: 0x5
[  136.376906] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: hv_irq_unmask() failed: 0x5
loop of 'interrupt failed' and 'hv_irq_unmask' calls
...

Device is intel ssd p4608 pci nvme, that consists of two nvme devices
as seen by linux (5.0.1-rc3).  Some info from `lspci -v`:

82c6:00:00.0 Non-Volatile memory controller: Intel Corporation Express Flash NVMe P4500/P4600 (prog-if 02 [NVM Express])
8f8d:00:00.0 Non-Volatile memory controller: Intel Corporation Express Flash NVMe P4500/P4600 (prog-if 02 [NVM Express])

Let me know if other info/logs are needed.

[1] https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/deploy/deploying-storage-devices-using-dda

Thanks,
-Solio
