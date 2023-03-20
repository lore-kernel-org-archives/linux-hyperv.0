Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D45C7618D
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Mar 2023 07:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCTHrw (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCTHrt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Mar 2023 03:47:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1199D125AB;
        Mon, 20 Mar 2023 00:47:44 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4284A20FAEC9;
        Mon, 20 Mar 2023 00:47:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4284A20FAEC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679298464;
        bh=4FMYgFngPsCYjftlQoUOLXjlLUIuzh3R5fN/lo5rhQo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZsbSHZVJy6lV9o3h1gc0pFly1b83s0GIjPS8J1O1F+b7GGqESOpDrWlw/3P8NcP8d
         dky8mTLBtrXkWFKgj2CMmrz5rw0cWWtz826raSUz1Jd+P1P5f2Y2SyIhDW/qsXfemj
         GZgtnh5ejgIO4av8KvU0uoFv/r37K7cDwjMC4tbo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: [PATCH v9 4/5] dt-bindings: bus: VMBus
Date:   Mon, 20 Mar 2023 00:47:39 -0700
Message-Id: <1679298460-11855-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add dt-bindings for Hyper-V VMBus.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/bus/microsoft,vmbus.yaml         | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
new file mode 100644
index 000000000000..a8d40c766dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/microsoft,vmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Hyper-V VMBus
+
+maintainers:
+  - Saurabh Sengar <ssengar@linux.microsoft.com>
+
+description:
+  VMBus is a software bus that implement the protocols for communication
+  between the root or host OS and guest OSs (virtual machines).
+
+properties:
+  compatible:
+    const: microsoft,vmbus
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <1>;
+        bus {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            ranges;
+
+            vmbus@ff0000000 {
+                compatible = "microsoft,vmbus";
+                #address-cells = <2>;
+                #size-cells = <1>;
+                ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 216a61805c93..3cfe67af51f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9540,6 +9540,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
 F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
-- 
2.34.1

