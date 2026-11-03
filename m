Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693034;
	b=UiQ5KSRI1AkH31Lv/x+WjAYZdoZwjp0Wo2OPrjy5rxx8i0ir1c4cJiksa/UgDicJjim5
	 FUVQdysUHkUyDtCOIc8tj3ehLCcmTxPqWnQNrus0o7Tg3JtcyH2hyYoTpzaDZjhf3Vmr6
	 GafvdCSBUDx/3NVTYIP1Yxh5S+/buC2KxRyMXnK7rQsZfwkduQMFGt1AHPVnGSF66IRlc
	 BTx7q3dd+YNEuMB5lCsttMgW/6X/vTgNfjTYrML18nA/DnJQHy7uiM1myZLO7i3CKRiX0
	 lcwIaeuf2P9BzeQ9JouldNC4AYELBr8iVUkVZ4FID/POjUyaZL0D0VBkG6rdsHu0TNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l0oN+XMjttu7u+qY1h/LMatbQ4tscjSIcI7cSuVtBZ4=;
	b=KGmWGsF1gntySWo3rb8fDFrKknDREdzoll2h25QiumeKfn6e/8Kgpd7mJ4kXy7kUbA3A
	 +EVSXOMT5GgSVUl+LZKBLILMnMFxLny5o1pDcC1sAgzmWgjGWX6Md6nXIr/pH2mGUsFc8
	 UYv6/mEr8FmwwsW7RnwxdgzEjPCyXDP1WDtLdDnio3Q5ZdJFKD3PwkhD+3eFKjHht9rP4
	 7hUy3aOq3P3BIoQN8san7ZEioz1MGCpjtWAkWXCandKXELU5JaDmv4uvC6zypBdxo/qTZ
	 i0P+zgVopyjA3rsQVnD3pi/IhC23hRusUPAjNG/ghtgR+eG8BWSd/738Kajzinx3XgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrVGbqDA;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478A606A32F
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 08:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B478A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrVGbqDA
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso2328332a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Nov 2026 00:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693033; x=1794297833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0oN+XMjttu7u+qY1h/LMatbQ4tscjSIcI7cSuVtBZ4=;
        b=QrVGbqDA7blWhqsVvYV0d54pyJP379JBkJc79mkCztb6PN6OJPGU9YEzwMKPHPeexk
         KAXrZh4mRJlZ2D/0/xP2wuV+acLGdTj+aDfX9vTdxk+2Ae/aoB+lKLb88wi/xM+vS49q
         dRQ2b7Hwj3ndgshLNm7b2CkI3eR0sD1Devwp8IoiWqjeQU90dR34vzOE9Nr5cQy5d0L9
         ls5lKYhIpnVPmVYsvZrdUMN5JFehouYMDZCcTUpwjSAytBRh1uhZe6hQV9UXvB6XrBTT
         8QBBmHHClqzzgYpUO+OlB2q0Bs3/v29bC463crvaXK19+4C0F/jA6OLcTFQu3NYvTAZO
         S3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693033; x=1794297833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0oN+XMjttu7u+qY1h/LMatbQ4tscjSIcI7cSuVtBZ4=;
        b=ziali20NvypZ5IU9rdkxhzUEMiY23EhBssS+5B6GZpqWHjkDXZyvJjMfpoEPDPojYg
         CWR0joJZNcVK5nCebWpQj0fATIkeoB5ZVBgzHGLXfXzhoKcwWkjfJLz3rd6a1LsX9N9K
         J8NSnJ2VsrG+1iPz5OaBICfT56v0UnKth7qInpYSNn5i5f2sdBIl1asmyzDQJ2msuLIl
         Jc5X+GI1EKF+NR3AHdFp7cBn4DBL1UOvda1YyPk/YzfbQsdZ7ZqXZkw4veMRpvdhnltB
         /snFaqDe65XCC/wiHhkBLvs1EkkGQ7kmy9rhZTS7PJQgn9AmNzp9S9hLv6t3p/KsAggD
         gdFA==
X-Forwarded-Encrypted: i=1; AKwUvBx+mWrBKq7QblzE3DYGjTyumS/0ace/FVQuHxQ9B0+MI3tm5BoA0kdinK0Q+UtVdHkBMYsRaL12it3rvoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S98oonTICEWYEIW2AKchNakyyqR+Bpr5z4Wz3/SvzBVYFDebx
	NFSD9EbbhVHYVJBYBBQdUsfglAPFmWDgBzwCnFiFA1WqnB8ppmhtaCYY
X-Gm-Gg: AYBFou179O9Wku7YmdCty0vslyeNSj7Qt+jxQaGZfoOUZ2ku7oyxGYgdkKHLcqLt25e
	PfJkCbJ2DUMyGXRbIADTomp7NtAdZLETpF7+ztMAWhJnaT7IVDYY7xIMabk9K1ZRDtVmhUwAjPt
	kATqJhfWuPZ4Q6OOLFNgyWSZ7N2CbCWBv/wGCByfl9O7uRex9zSO4n49RJ4OdpeLriYR+LsiVVj
	MkWusgllpseXx/Lw1SbLS2IHbtSUkPKRzrY6npGBA336YII4ApE3qKAiuQlWC0V+ss/kOzwUkeI
	FZ7vCT133u3f/5os7JFxI2OPgrinKPTX1nEBvASsWTUI+4kEAwSZtEDwu8lPNxsSnbo9FgBlw59
	gqGYJvCCVkzZoe0G9jg5TAZHKhoz7i1wWEPSc6hF13+C+FZzyVFHopB3nJPLSZqH/XNCdzXQ0XG
	wCaqsqOZ5JJGBS1L/0jpsSYoO5ml1QcCSeY/aRseU3aVapNWI+VBHH37Id2Vffw6c1imi10hnnM
	UDatjsZ9eXU551B15VjQ/DCUWDMw5PFAX8ZFt5Om7Onz3NtZLNejTgmDxLVRE8/v2FZkEVttI6a
	5ZRIOiTlkiuqoqssakf8rLJYx+APBoQcMuMQMwpTgjt65SIIYUek338=
X-Received: by 2002:a17:90b:264c:b0:3ac:9463:83e6 with SMTP id 98e67ed59e1d1-3ae896f8520mr9353815a91.10.1793693032938;
        Tue, 03 Nov 2026 00:03:52 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5814basm3316347a91.2.2026.11.03.00.03.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:03:52 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: Fix the error paths of channel setup
Date: Tue,  3 Nov 2026 16:03:45 +0800
Message-ID: <20261103080347.90310-1-izaiahsun@gmail.com>
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

Changes in v2 (patch 2 only, after the Sashiko review of v1):
- vmbus_match() skips a device whose channel pointer was cleared, which
  a concurrent driver_attach() can still see.
- Failures after device_register() (the channels directory, the primary
  channel's kobject and its sysfs group) no longer unregister the
  device: a bound driver such as hv_sock, or one that opened
  sub-channels, can keep the channel past its remove callback unless the
  channel was rescinded. A sub-channel of a device without a channels
  directory is refused.
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

 drivers/hv/channel_mgmt.c |  5 +--
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 71 +++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 31 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

