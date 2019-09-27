Return-Path: <SRS0=a8RD=XW=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BDC388F4
	for <linux-hyperv@archiver.kernel.org>; Fri, 27 Sep 2019 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E12217D9
	for <linux-hyperv@archiver.kernel.org>; Fri, 27 Sep 2019 11:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfI0L1W (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0L1W (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 07:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD24A8A1CA7;
        Fri, 27 Sep 2019 11:27:21 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-249.ams2.redhat.com [10.36.117.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2445D9C3;
        Fri, 27 Sep 2019 11:27:17 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [RFC PATCH 01/13] vsock/vmci: remove unused VSOCK_DEFAULT_CONNECT_TIMEOUT
Date:   Fri, 27 Sep 2019 13:26:51 +0200
Message-Id: <20190927112703.17745-2-sgarzare@redhat.com>
In-Reply-To: <20190927112703.17745-1-sgarzare@redhat.com>
References: <20190927112703.17745-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 27 Sep 2019 11:27:21 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The VSOCK_DEFAULT_CONNECT_TIMEOUT definition was introduced with
commit d021c344051af ("VSOCK: Introduce VM Sockets"), but it is
never used in the net/vmw_vsock/vmci_transport.c.

VSOCK_DEFAULT_CONNECT_TIMEOUT is used and defined in
net/vmw_vsock/af_vsock.c

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vmci_transport.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 8c9c4ed90fa7..f8e3131ac480 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -78,11 +78,6 @@ static int PROTOCOL_OVERRIDE = -1;
 #define VMCI_TRANSPORT_DEFAULT_QP_SIZE       262144
 #define VMCI_TRANSPORT_DEFAULT_QP_SIZE_MAX   262144
 
-/* The default peer timeout indicates how long we will wait for a peer response
- * to a control message.
- */
-#define VSOCK_DEFAULT_CONNECT_TIMEOUT (2 * HZ)
-
 /* Helper function to convert from a VMCI error code to a VSock error code. */
 
 static s32 vmci_transport_error_to_vsock_error(s32 vmci_error)
-- 
2.21.0

