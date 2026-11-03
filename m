Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716814;
	b=OKF8t3VEmbrXFoGfrC3m4JlxqArUycyS8Tnkju2HY0YGFuXxocvvWBWjNMDSr8+c5c8T
	 uTrUfSyNefx6VAe/kCCxvNaGw0olD3dN0cA2Q7DDMhBv5wEmfBGMMI3zyxSuItgqgARUv
	 5e2PDv7fhIopneq78vM+8ycyMc8l6a/gnJyQLnG1QPDpcDa2WAW8esd4Wwf5oACJrWi+J
	 Q5MjPdNy0He8t3BgofuD9IUjAKiPITYxk7DEaIKNNw2mWIgq13wr6zCDMDn5bC2/MyvsQ
	 WvHNAskkQZFsa5S/X15FoYcKGIw2Wkp78bhcQo9xbXsXGsSztMH9omVVahntU37o29Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UF0GzqUufapZrE0IyDVIG0vsjoer8oICiJGSt0J409E=;
	b=ImRF7dHaXJvNf3+zx60MhB+IBnS4mB6oOOQBxHnJvcvVr6GpBdOpurRGPPi01F7+ibMY
	 XNOJ5kfIIn6KoG5eRzxQkupgp6Ai66NoTkVVEwkWAc1QnYRh6MOSNlXKaZk1wLNL4y0Al
	 TYWPzOgnTpC4MxzgKj/Fhwt2evSHAAnnEbvNPRtHbPVe33iD7eS9SkBrrWuUI0XXbi1ud
	 qLoX9yjzbjY45tZnIg8UPsPsaBcGlTZuimXAmMnGVRm6FE2JvItSpw/7ogjkZCSWh6i+Y
	 Gn0vin9ngeEoqmnNc4ie5JKkUWmzzmClaMCnBJ3uO5ZRCTu3o1DhkUgnn6VKuVc15/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QzTz96R4;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE64606EE9E
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 14:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE64606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QzTz96R4
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9f6a16aedso26038985ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Nov 2026 06:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716813; x=1794321613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UF0GzqUufapZrE0IyDVIG0vsjoer8oICiJGSt0J409E=;
        b=QzTz96R4bqPaqtq06FnUr+M4JSib5KzIZyNc5E4RvEkwqMNG0HFdqtpqn5YoNVJrEe
         640kPTvQ19xFE34cR00Mj6ATjcnHSDs9K6z+E5UL7GNuc92GIFUVDKjMxNlh7MDrFLop
         HDcuO8GhSmaM/5u7cFj5Y0E0qQZvJ929/bkF4uXj9cbK+C6zDUlxb0/pz/tGk5FuOay5
         +XpIzitPkyRvXQy50byfUlDBP5h/OOieCtMoQbfGdFc6lCQv4YMfo7+XLyHUtFkeFFYQ
         KRKBH0JSIUQj1GFHT5ISeFSvYk/pYggNxGi7Y643prbYwUAaqn95sLEw91D3Fb+41AIJ
         Fefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716813; x=1794321613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UF0GzqUufapZrE0IyDVIG0vsjoer8oICiJGSt0J409E=;
        b=Qyib7V1zLw2O/DNGZRvpcf4x90fktAD2e2/Wsy3ZoDLd6Dk2XMU0Y0TmOs2KobpYVH
         w09BjV5DLxMTrK6qLLV/NGm4UHps7UqQC47y/Wt7nrgfvFFW36BGxJldtwaRwLt1fFn4
         4fimRWEXCPrIZqzedq/TTEth4b0H2xS2DoOyi7nOyvhxKv80UXL9D3eDMzRzG9VTcI/L
         zmbw2MYIrFAAKmBwCZE0pVJN7tanRpKZ1JEBAnz+ewVL086BNUcwNugClxwmtTveV8rp
         HqMX0EyNXvDP3bgJ7NbHFb1bwjKlburtGAMAPyng1vegu/HCnGlYR+W/0HLma657PpXf
         kFQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpmMqkz9ivX1T08mLqR5oZ6ARu5TVLiMmLjarGUQC+VjPEa28uGs1aWqo0e2C8oupi9YwujPeXFNcceDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+goCu4m7KHG5QV0d4aNfNfdayYNpA7mwL/9pkDJrT/VL3N89XA
	MHLAG3NDk5rLkL1PwbPsQcnTtiPvRY+ICFGFZNTgS9SbuZe0tmHbMSc5tc1OR8dgQ7c=
X-Gm-Gg: AYBFou0jCreRFkOzxO8Ae35fmVqH7mu8Bd8Wg1v24tjfHl8/FrJxmJ+nrzaszNks+sl
	BJJ6Ghtr1P0s2CMXyuKX8wC0lzXDWJ1qNgSZVMVyD2AhNQOm4B5vppk26PzU0t25cFZvwbljTU9
	cR6Djp+sR3/KzNTCIOaNaH+w7o3M3AgSd4W/LFHNc5/PTvRSKc1Jt4hob14JhZ+5GdrZkuAQX+m
	Yjoz32uOYSO8LmbJ2dCD1sAmnDk6dbyYD4IxvsPfFuUtRlClkc/04ueT2L+2pkfGIav0ol2WvDm
	n1eABL5dTf/BgaDi7ytRV4NJB9XzhHcIWb4wzNDWre0P4XnRwVEu5HIXCaaNTTyWyRu/qqMX3rG
	wBsFcRBVUzFV2yytvZPpMhL6yf/jp5kIe2nM4bsfHI9aGquH15uqe89QKffSYkotrwnFmXHSr5D
	XeojYodaTiA8LBJfArUoJh5CZSOKrkVIL0vo64HWkQ554nRjB1frI8ljVWwBmnwJERhF1Yf8IFF
	cng9Ko6DcPOf1Ml48c6Dvt7+bM4HM5S4dDm1wzkd5XdH4LUfqZ5YWvdZ59K6jAws7tKK8bKcSHb
	alZl/Xs842lzvMpGIxgL9Rbxiy5pArOIqq0XTPfplyxhiQXDTUc7l2+tiBLn+7F8
X-Received: by 2002:a17:903:1251:b0:2e9:970c:2c9 with SMTP id d9443c01a7336-2eb364704bfmr129611875ad.42.1793716813250;
        Tue, 03 Nov 2026 06:40:13 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:314f:4575:be3:a064])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052edasm42898465ad.4.2026.11.03.06.40.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 06:40:12 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Drivers: hv: vmbus: Fix the error paths of channel setup
Date: Tue,  3 Nov 2026 22:40:04 +0800
Message-ID: <20261103144006.69857-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When setting up a channel fails, vmbus_add_channel_work() and
vmbus_device_register() do not agree on who cleans up:

- vmbus_add_channel_kobj() drops the channel's last reference when it
  fails, and its callers then use the channel and drop it again (patch 1;
  this is what our static analysis reported, for the sub-channel path).
  Paths that fail before it put a kobject that was never initialized.

- When vmbus_device_register() fails, the device's release calls
  hv_process_channel_removal() on a channel that was not rescinded, which
  hits BUG_ON(!channel->rescind); vmbus_add_channel_work() would then
  clean the channel up a second time (patch 2). Patch 2 leaves the
  channel to vmbus_add_channel_work() when device_register() fails, and
  keeps the device when only the channel's sysfs entries fail, since a
  driver may be bound by then.

Changes in v3 (patch 2 only, after the Sashiko review of v2):
- vmbus_match() reads the channel under rcu_read_lock(), as it is freed
  with kfree_rcu().
- The channel no longer points to the device after device_register()
  fails and the device is freed.
- A channel of a device without a channels directory is left out of
  sysfs instead of being refused. v2 refused a sub-channel offered while
  the primary channel's device was still being registered, which could
  leave a driver waiting for it.
v2: https://lore.kernel.org/linux-hyperv/20261103080347.90310-1-izaiahsun@gmail.com/

Changes in v2 (patch 2 only, after the Sashiko review of v1):
- vmbus_match() skips a device whose channel pointer was cleared, which
  a concurrent driver_attach() can still see.
- Failures after device_register() (the channels directory, the primary
  channel's kobject and its sysfs group) no longer unregister the
  device: a bound driver such as hv_sock, or one that opened
  sub-channels, can keep the channel past its remove callback unless the
  channel was rescinded.
v1: https://lore.kernel.org/linux-hyperv/20261102094719.35760-1-izaiahsun@gmail.com/

Testing: QEMU (x86_64, KVM, kvm=off with the hv-* enlightenments,
vmbus-bridge and hv-balloon) with KASAN, hv_vmbus and hv_balloon as
modules loaded from init after failslab is armed, on mainline
d135ab453a74. failslab is limited to allocations under
vmbus_device_register(), and fails the N-th one when the hv-balloon
offer is processed. Without the series, every failure hits the BUG_ON.
With it, for N = 1 to 95:
- 53 failures in device_register() leave the offer unbound with
  "unable to add child device object";
- 31 failures in the channels directory, the channel's kobject or its
  sysfs group leave the device registered and bound to hv_balloon, with
  the channel missing from sysfs; unbinding the driver and binding it
  again works;
- the other runs fail an allocation whose failure is handled, or none.
No run reports anything (no BUG, KASAN, WARNING or refcount_t message).
v2 and v3 give the same results.
The sub-channel paths are not covered: QEMU's VMBus offers no
sub-channels, cannot rescind a channel, and hv_balloon cannot be
unloaded.

The failures need an allocation failure while the guest processes a
channel offer from the host.

Yuqiang Sun (2):
  Drivers: hv: vmbus: Keep the channel when vmbus_add_channel_kobj()
    fails
  Drivers: hv: vmbus: Do not remove the channel when device registration
    fails

 drivers/hv/channel_mgmt.c | 12 +++--
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 97 +++++++++++++++++++++++++--------------
 3 files changed, 71 insertions(+), 39 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

