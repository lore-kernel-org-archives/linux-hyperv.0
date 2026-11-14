Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794693844;
	b=yEzwq8Vv4OlqpXMcy2Oe7N1Gq49GYknCmhN6o4q4G5WFfEWWLgCINna3pkcYDWLUIX3H
	 bjZJmcuBOeBCJFyZ5KMrr+I5xq46JUqkKQG+gweC3tPf4aDL/C/EBTxJ1M+InShPH6/iP
	 2rBIOxijTtINj4Va1gzopOIE8IZVfsAmCU+wWFxvz3Av0cuq9g/FNpeF5Kid4VK5JTwsK
	 aw9ze5TjePC9HSUNZibPbxlBsONK6A2BAwmcQ1b/6QKW9PVdKmjcY7Hn6Rd52NPwMxDI+
	 Zr9K9/yqhhn5mqupl4shIoIlH4fZxCwDlbZHJtXmfa4Z1oiB+uOOKqNvECL/OOve4dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794693844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vh5zy+jAqMHm/c0Wtk9LMwZdvGBT6DeyQEytCGNCC3Y=;
	b=5Oc4pjvxg0Z0yg151kODOuxqv43hKz3lZZk87IZBMy0UVNW6XVe9gPgNSJ008RBZnz9B
	 aoyeu1XufWEHHAJbaol/rDnIEquxR23GKbefVM+5SgL1lqE8GCfeey/XVgtHEINQfKN2Q
	 jGgjbf9uD5AkmkCMd8xM04gx2719xG5WhPNh5SISJ/HEme8nobU07XmTK9BCbtJyTwB8/
	 wDoRYQW1Vq1rYoiy/DyS09b7JWVorAG1O7SkAemxcuLoTsfEGm8tti44JN+BwUT9FhEW0
	 yaDNUFzSx/bZAaYhbE4W9OhxInIKIH8AUPhcBd/mp6uJH2HJQyG4XjVny54Pkryshyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=hStfYJU3;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC52606A32E
	for <linux-hyperv@vger.kernel.org>; Sat, 14 Nov 2026 22:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC52606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=hStfYJU3
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so166788366b.1
        for <linux-hyperv@vger.kernel.org>; Sat, 14 Nov 2026 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794693841; x=1795298641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vh5zy+jAqMHm/c0Wtk9LMwZdvGBT6DeyQEytCGNCC3Y=;
        b=hStfYJU3y7r+9Yp9LBu18f5vh08zZEsVnRNn67+kGftdxVojSk7EtgSPs9zUtV4TOo
         dzhs5VIIHB8+sPKLVM20OeuAg/mVLj0yKd0n4eib/kYQaZDb25P05NJJGyNHTZtMThsl
         +XwQ/ps6BLQFWtexS9TZ2FvmxUEEwkvcA6X7L0kpwND+pAxiiMtXGnnyOfuHnhALdY3u
         OH5b/nvatdrlyrCQ5RD6qaFg/wl+5YdMMKTbED28+HMFqarDogbWg6gsl1vjo0QiX9dA
         3S6qvzL/ejK1BEVZJKqhbo4ijx1cLDvnXZUjq6tnhnBJRd/MaD+v6AYzGPgzbsvi7tMf
         179A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794693841; x=1795298641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vh5zy+jAqMHm/c0Wtk9LMwZdvGBT6DeyQEytCGNCC3Y=;
        b=mF6OsV/jQ4UlpmT64yRfAYZ1YoMs75EN6+gUo2UWy4vxTueKPQ+5GrkoW0JJ3azYWT
         f+RaPT4L04WkD8HlObxKr6KboGkCCl2F9ctnRx5PUtUjmO4Nb2WHyIz8fGLrevhFoXtd
         b+yc2OYGgXwLx6Wix/EhRa3xg6qaENq/l+AW6gXh8HYBky+qY5yetSRLHSt7qBX7zfvU
         f91UEXFbe9KM0rptAhcGoAJgdKAuC7NKrLpyJmTfn5uB1iOtKSF9qIcj19wdAUk3BTgR
         YsuRK+DQmxPP8R2shKM0aIc6wn+ejZZoA6+805ZMFFKtYd10vaXrC5LaX3pUfFPOZJyi
         rpxw==
X-Forwarded-Encrypted: i=1; AL+hErEhO1gFFeCRiL8vGK0bgKOqm94w/sOBuopkUDxvvT+RJXTq0ArcKwGIFqOZgP1zbCqZ5QoCGuyLgGvxVfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X8f3t10nq9+lkhsEieYm2+dMbU8dSYHg6bNuxwxqOWOoVL8Xe
	wIG6hzXAYb/y0TuudVcCmH7tMb34kSTzJ5zNfegrZIfNf131JuCRGEW7jJ37sAzgwg==
X-Gm-Gg: AYBFou2a7q8aqkjblAXUKGHDX0wM+vRvZp9Ru6ub4I6xbAbXRCilAgtOk5J1dk/uAi2
	0I8GxYg0ENFedbVenSt0ydnWm42PqjV+1fNzJmJOzyfu3OrKamhY2JMNpBNzbNT+BWRQTlAawWI
	UhkuR1/dsY0Q1XMXduIoEKRFpjgKIFP0PM7yc9VeTVOO6FV0urW/cP+HL50SXYeqQWhBiu3d/WH
	PbDInZrVZgXIj4icm9331joakTiTOgg78plFT0sd/d32FXU/5TWiNoMHRBRblD7DJ0COgdm9Bxy
	sStM/JD5EVlTu7FwGClE4d34DYlmEBjF+U+NssLdgheYSjy+cy0+1VibbJ458lveOKA0fg+9JHm
	UcTkRSc81ZJd4Vyco3Zm3RTIZcBZU/iNOxtDEJ9Tdq1Nolmpxnp1EK88c1Au8eaLIJupQ2r5Zc4
	vONusRxJAANmj3hDCPJnXu8Cf7PlbTzaRQhW+m34h49YNDYlkhnc6oTz475fkwG/0Gh3qOR1GCq
	sLHWgHkBMOjKIVDOTRJuA+fuwkn5N/0fdUdMcEriusJEYQS2lkGAoIavi5oMk+jCX66372Chmt8
	tqxnC2cgi7vrHb5v2jC6m//uyGyZgIIw+fiK8iuOtKWRVnvIEF58FlysiJRnn9tDBwqWV45xywf
	GRpv/PVdF7QpdwnB1G2C0v+20OC3tlaLGjdOu+Tai+B/ae9nLwUdmlwu62SxL33BgAxRb9UBCgp
	GOtADUxS+gBaHTR6aa7U3WTkLh7Ph6l/uUd/obxsGq4080Hmnyb+lvCalV77a3BPCmuUErlkEFj
	PzYhye84DwDshvCUEcB6+rK05aPnI+yF4ltpiuJD9QNYZ+JMiO2i0jPVAmYoLsfqK3PiN5oG3si
	gwk=
X-Received: by 2002:a17:907:6e87:b0:c41:1750:59a2 with SMTP id a640c23a62f3a-c50963778efmr537828166b.12.1794693841497;
        Sat, 14 Nov 2026 14:04:01 -0800 (PST)
Received: from Desktop.fritz.box ([185.181.130.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b236edsm255946566b.23.2026.11.14.14.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 14:04:00 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	stephen@networkplumber.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_netvsc: fall back to one queue when a sub channel fails to open
Date: Sat, 14 Nov 2026 23:03:58 +0100
Message-ID: <20261114220358.5429-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_sc_open() counts a sub channel in open_chn even when vmbus_open()
fails, for example when the order-8 ring buffer allocation fails in a
guest with fragmented memory. The channel stays in chan_table with no
ring buffer and a disabled NAPI, and rndis_set_subchannel() goes on as if
it had opened.

The next netvsc_detach() or netvsc_close() then hangs in
netvsc_wait_until_empty(), with RTNL held: napi_synchronize() waits for
NAPI_STATE_SCHED to clear, and a disabled NAPI keeps it set.

  hv_netvsc ... eth0: sub channel open failed: -12
  task:GnsEngine state:D
   msleep+0x38/0x60
   netvsc_wait_until_empty+0x49/0x100
   netvsc_detach+0x135/0x1b0
   netvsc_change_mtu+0xb9/0x120

netvsc_device_remove() would also call napi_disable() on it a second
time, which never returns either.

Check after the wait that every sub channel opened. If one did not,
disable the NAPI of those that did and return an error, so that both
callers fall back to the primary channel. The fallback in
netvsc_attach() did not delete the sub channel NAPIs and left the real
queue counts of the previous device in place; do both, as
netvsc_subchan_work() and netvsc_probe() do.

The device keeps one queue after the fallback, also across later
reconfiguration, until the channel count is raised with ethtool -L.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Link: https://github.com/microsoft/WSL/issues/41622
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
Tested in a Hyper-V guest (WSL 2, mirrored networking, 16 vCPUs) on net
aa40afa831ebf, with fail_page_alloc limited to vmbus_alloc_ring() so that
6 of the 15 sub channels of a netvsc device failed to open during an MTU
change. Without this patch, the next MTU change hung in
netvsc_wait_until_empty() with RTNL held. With it, the device fell back
to one queue; a further MTU change, down/up, ping over the device and
ethtool -L back to 16 queues all worked, with no warnings.

I used Claude (Anthropic) to help write these patches.

 drivers/net/hyperv/netvsc_drv.c   |  7 +++++-
 drivers/net/hyperv/rndis_filter.c | 38 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d43c73fd73f1..ffa5999dc576c 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1023,7 +1023,7 @@ static int netvsc_attach(struct net_device *ndev,
 	struct netvsc_device *nvdev;
 	struct rndis_device *rdev;
 	struct bpf_prog *prog;
-	int ret = 0;
+	int i, ret = 0;
 
 	nvdev = rndis_filter_device_add(hdev, dev_info);
 	if (IS_ERR(nvdev))
@@ -1034,8 +1034,13 @@ static int netvsc_attach(struct net_device *ndev,
 
 		/* if unavailable, just proceed with one queue */
 		if (ret) {
+			for (i = 1; i < nvdev->num_chn; i++)
+				netif_napi_del(&nvdev->chan_table[i].napi);
+
 			nvdev->max_chn = 1;
 			nvdev->num_chn = 1;
+			netif_set_real_num_tx_queues(ndev, 1);
+			netif_set_real_num_rx_queues(ndev, 1);
 		}
 	}
 
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9622513275069..fe5acce0bb06b 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1278,6 +1278,31 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 		wake_up(&nvscdev->subchan_open);
 }
 
+static bool rndis_subchannel_opened(struct netvsc_device *nvdev, int i)
+{
+	struct vmbus_channel *chn = nvdev->chan_table[i].channel;
+
+	return chn && chn->state == CHANNEL_OPENED_STATE;
+}
+
+/* Disable the NAPI of the sub channels that opened. netvsc_sc_open()
+ * already disabled it on the others.
+ */
+static void rndis_disable_subchannels(struct net_device *ndev,
+				      struct netvsc_device *nvdev)
+{
+	int i;
+
+	for (i = 1; i < nvdev->num_chn; i++) {
+		if (!rndis_subchannel_opened(nvdev, i))
+			continue;
+
+		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+		napi_disable(&nvdev->chan_table[i].napi);
+	}
+}
+
 /* Open sub-channels after completing the handling of the device probe.
  * This breaks overlap of processing the host message for the
  * new primary channel with the initialization of sub-channels.
@@ -1329,6 +1354,19 @@ int rndis_set_subchannel(struct net_device *ndev,
 	wait_event(nvdev->subchan_open,
 		   atomic_read(&nvdev->open_chn) == nvdev->num_chn);
 
+	/* open_chn also counts the sub channels that failed to open. They
+	 * have no ring buffer and a disabled NAPI, so fall back to the
+	 * primary channel.
+	 */
+	for (i = 1; i < nvdev->num_chn; i++) {
+		if (!rndis_subchannel_opened(nvdev, i)) {
+			netdev_warn(ndev, "sub channel %d is not open, using one queue\n",
+				    i);
+			rndis_disable_subchannels(ndev, nvdev);
+			return -EIO;
+		}
+	}
+
 	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
 		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
 

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.53.0

