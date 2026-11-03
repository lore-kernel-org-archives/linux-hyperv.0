Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693037;
	b=fwNZ3nS7GprIacGpzvBIVk8CwspyWi3xAIdZ1nAJiYZWid41+L3tku4XdtFjVBzd5AWW
	 LJEMRcpH8xhEExJGCTo+pEzsRo+N0f+GbUzNeQWWtsK4qyqVCbGlbhXyFfhyu90PBqHgD
	 ON5oeLjCGfFMZjP0mCG+nyPFX8oKjHh5MUdcoKCwhzta/+3GaE9PrqB78J4bJEiKlgUxV
	 ikhOPLpd+BT28sXy+wLVT7TDxhPL1NHm5Pz28fJobwkDKxGWvZF2CwnAwMmu/q+bCy5J/
	 o1xNYVm9lQnlh57cp6TdhPI5mTzfaOGdFevazOmblsQ7EWa7mIbET6yzytrJePMC36A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
	b=XIsxgU/BiZtJdiVQsaK1dGdLrfW7o/gFOiksigXlP2ZleXB7aHHUzY2M0erCNcr72Oby
	 Gi9BfP9NuySjcZPRfqAqic0Eyy3kJgomV3TjW+6k/Y7FpLv/y1GtyfeCgVh7wXjKIyrut
	 lZxDC+WKPNYn7nZTMogpXjsD9OSMxwnjaRokSxaiINg+J3lEH7Y7OVu1Lct6M1lS/IRwu
	 861bJiZXJBveRmvTMw44BVXtKcvfCquu5vermdZRl+1PaqNqJYX09wQxedBOChzsGWfix
	 UOmF0cuZPehLm5wPCF+RqO4YGbozYtZ32ZDyybk2GGkC11fnKaEWHvIeiIRYQ6cKXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDNEu0Qs;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD48606A32E
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 08:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD48606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDNEu0Qs
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab41538192so3109001a91.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Nov 2026 00:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693036; x=1794297836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=YDNEu0QseFDDKOsEloJCR9Igt4kQC9ySzig+W7DHQGXaZYarzT+1a6Kxbwi7JUFKyJ
         LFhuFr/FCX/Eiob3g3SfhOwGbKPRgB55PQZIw9ex1A2UGFtnZRP4/Md82BjFrojjOvdO
         x2GpZ08C+XKpNqeaxunPskSVKHNHUDVOMe1APKiKAzDrnPiArh6fchaW9am+ficJ80/X
         3+SjASb1GeSoNpRG/4yqSZmF0eQoRPiAv83vHT/Lan5OuY6k4r2Zifo1mF8t5oq16v1k
         xHJpMWlWhwq41ib6SdACltbaMMarZAMIyLI9uQw4INca+Zv0pwTjyWcgXz+D+mhO97lO
         VLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693036; x=1794297836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gs5+MUVCUFpHGD304h1ti8CPR/+CDqRB4o1YL2rOSQE=;
        b=UYNX6KGrnlPRXyvPesOsbn6g54uiHtW4+WiRGBOHyuvQfaaMRDnwd+jrBQfT/UmRcf
         L7X9NmGfP9+w5BdgbypVSNuTClGmbijdMRS/WVBqfnpevO9GaZBoUczVD2pVsb2KGqnD
         VpmM+sOP0kSbB6hy8cGxa8Efqq4HtTsr0cqDZfx2VVgZhDnuKcKeXgjgcPsNwXbL7wA3
         CGDqWMldTkCvXuVy9RIkYdFh3YOwV3/r+/zMie+GUonm9N9Nv78ES1CuVVeZXaauEGrO
         f2+Aw0ZZrfg5+v9/FFUr/jXFlc64GfD9YMJ8b9D4XGzooQHsVP3f2+LZIvdl+USZlccg
         9F7g==
X-Forwarded-Encrypted: i=1; AKwUvBwqg7e4N/P9H5VHwh+K4v/XO9smv23pLPIksvu4hl9e8vcZG40xOW2vfFzxFoBMyEasm4xOnbceKWCIZRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hv5wDHoWzZ5oCQ691CDUQ0G3sFCx/b2VVow0HHQMaMM+/UOEV
	gCXBaqC23cLBW5lMeJn6LBzcD49VENkL/2er+hm/5miyMNRybT/t2cEq
X-Gm-Gg: AYBFou1Bi1UxPmHhANR0MzqtIu9UsGi7Nz5T7GA7yuBMmNYk59lDc8I0W3z/HYcArtf
	xH4sFOgeJcfEbdiAF7Eo6Aqc/YkGxl6Zy6z0P2tbLvqgK0zZ1O068d5dUS9puKCLOKN/NSFSJs2
	2SwPnPAVG6B2l849xhC4dS53MsU1K6QBeoM2VbTxCLtGLc1s/F81oD0mWIboLWfKOuHKXO4LsV0
	LoKQksAmCY1siwzKXR7X8m4lRA0kFUONCChbUPCINLM556XgpFA/duBwDvFbuq926ktBheSWSiM
	9ysF5hDj06B9X+cOqRDv+kgSaoTye7FjesDDe/fDr4/dTIgQQdV/hY9Bz/QJ0Fzh+xmo6SQrsM6
	+YU6PE7KgxdGZHIVXIbUJA0e8L/Wx6EsvV0ilshMXdAJVhKtdTcA9LN19xqg27yJcyNGxeP34wZ
	kXLonDKT1dd0wZse6rfYZ5uzhk4nAarfZTlOC6I1l+7ge0jFLpnq+O7LcTxxn0ne9JkZ/469BoN
	TMeu1s8rQzfx9a4aferHao5F3hBnIsPnYfvsFJHmaUremHvPn49H3/Q/rJPP8DuFMFtzsgTvCXJ
	BmvYzy5DRct3TXD7+H5/HWxOvegXz6nvcoDewViqwvW7gz/3b9RoP4BVd1yvRPWGos9RvjAxWWP
	K
X-Received: by 2002:a17:90b:4c85:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3ae89574db4mr9347219a91.1.1793693036031;
        Tue, 03 Nov 2026 00:03:56 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5814basm3316347a91.2.2026.11.03.00.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:03:55 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Keep the channel when vmbus_add_channel_kobj() fails
Date: Tue,  3 Nov 2026 16:03:46 +0800
Message-ID: <20261103080347.90310-2-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080347.90310-1-izaiahsun@gmail.com>
References: <20261103080347.90310-1-izaiahsun@gmail.com>
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

The channel is freed by the release of its kobject, and free_channel()
drops that reference. Since commit 8bc69f86328e ("Drivers: hv: vmbus:
Fix memory leak in vmbus_add_channel_kobj"), vmbus_add_channel_kobj()
also drops it when it fails, as kobject_init_and_add() asks for. That
frees the channel, and both callers then go on with it:
vmbus_add_channel_work() unlinks a sub-channel, unmaps and releases its
relid and calls free_channel(), a use after free and a second
kobject_put(); for a primary channel, vmbus_device_register() unwinds
through vmbus_device_release(), which removes the channel too.

The kobject is also only initialized in vmbus_add_channel_kobj(), so the
error paths before it, for instance a vmbus_device_create() failure in
vmbus_add_channel_work(), call free_channel() on a kobject that was
never initialized: kobject_put() warns and does nothing, so the channel
is leaked, and removing the attribute group from a kobject that is not
in sysfs warns as well.

Initialize the kobject when the channel is allocated, so that
free_channel() is the one place that drops its reference on every path.
vmbus_add_channel_kobj() then only adds it, and leaves the reference to
its callers when it fails. Remove the attribute group only if the
kobject was added.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Fixes: 8bc69f86328e ("Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.

 drivers/hv/channel_mgmt.c |  5 +++--
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c42def04ac41..cb1d8d76928f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -367,6 +367,7 @@ static struct vmbus_channel *alloc_channel(void)
 		     vmbus_on_event, (unsigned long)channel);
 
 	hv_ringbuffer_pre_init(channel);
+	vmbus_init_channel_kobj(channel);
 
 	return channel;
 }
@@ -663,8 +664,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 			mutex_unlock(&vmbus_connection.channel_mutex);
 			cpus_read_unlock();
 			/*
-			 * Don't call free_channel(), because newchannel->kobj
-			 * is not initialized yet.
+			 * Don't call free_channel(): newchannel was never
+			 * added, and its kobject holds nothing yet.
 			 */
 			kfree(newchannel);
 			WARN_ON_ONCE(1);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 33923621a5a3..7865a519dd7f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -408,6 +408,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 
 int vmbus_device_register(struct hv_device *child_device_obj);
 void vmbus_device_unregister(struct hv_device *device_obj);
+void vmbus_init_channel_kobj(struct vmbus_channel *channel);
 int vmbus_add_channel_kobj(struct hv_device *device_obj,
 			   struct vmbus_channel *channel);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4692687cdbf3..fc0f16f51266 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2084,6 +2084,15 @@ int hv_remove_ring_sysfs(struct vmbus_channel *channel)
 }
 EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
 
+/*
+ * vmbus_init_channel_kobj - initialize the kobject that holds the channel's
+ * lifetime; free_channel() drops its reference
+ */
+void vmbus_init_channel_kobj(struct vmbus_channel *channel)
+{
+	kobject_init(&channel->kobj, &vmbus_chan_ktype);
+}
+
 /*
  * vmbus_add_channel_kobj - setup a sub-directory under device/channels
  */
@@ -2094,13 +2103,14 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	u32 relid = channel->offermsg.child_relid;
 	int ret;
 
+	/*
+	 * On failure the kobject keeps its reference: the callers' error
+	 * paths drop it in free_channel(), which also frees the channel.
+	 */
 	kobj->kset = dev->channels_kset;
-	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
-				   "%u", relid);
-	if (ret) {
-		kobject_put(kobj);
+	ret = kobject_add(kobj, NULL, "%u", relid);
+	if (ret)
 		return ret;
-	}
 
 	ret = sysfs_create_group(kobj, &vmbus_chan_group);
 
@@ -2109,7 +2119,6 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 		 * The calling functions' error handling paths will cleanup the
 		 * empty channel directory.
 		 */
-		kobject_put(kobj);
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
 	}
@@ -2124,7 +2133,9 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
  */
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
 {
-	sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+	/* A channel that failed before vmbus_add_channel_kobj() has none */
+	if (channel->kobj.state_in_sysfs)
+		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
 }
 
 /*
-- 
2.53.0

