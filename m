Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612848;
	b=L9pWqcpIApRSg3LbrYI729WhIn+8LVkYZZe0CFph2Xa30you+G9OGr3B4mK8IXP1OTyz
	 8N6ysOo9z3zBcUYWCz1hVBNZ52HI+fPbtwxbhIxtpifxfV7Xpz4T1SklykL+rCcGfYL6G
	 xWMgJMWaxvtjELHhTxLWTsh8aJDfCfN34uWLgqjXkEuHSwjonaWmbqe40fiNOxDnAhQjd
	 eATUIml8LHGbBcQal27FzUHQubmoyEjB1n1DL83B/Dvh+WjKcb2IQNjnk4alL1LEYqWd1
	 PpJKmELvB4ULkX/8kJBgPVn7Vqm5vIb1xCNOzr3OW62HtIGSv+g0Ccpw21/7CQEvfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y3+gPSeYwDPGYWTnElZIx43Pcw1WxgOGBpOWJAlZDg0=;
	b=IjH7ji+f5P3dUn/ekhclMeT4SXSB9kjBIpNl9RLZcEyvFYTq+hNWjQe1RWdmmQHpejeU
	 vofSFsS+vqWcaEJFJMpqUpPQgmU/1n4x+5xQ5JXpkqtgY2g4oUSTT9ojeuBuWIvcAIphF
	 9caeJI7n6ZMpDWnyAX012wAAnWHfF+0JptIDP3R5fk9KevPqMpgMc+CztAVsSlQwYe10s
	 fQynu6pmSN0CZxmXd1X/wdNIh+RUAGGohYdMf6ceA3KLPPCGKDv8jeUQIk68KFo5nLOZZ
	 smaIjvqCkO6XExhxWwlEmiZbfG+8R3b7sXkz3sJP0vB24VQGEiwEHuy6wmbh5IHvkCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jW5/pw6s";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84C60A2612
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 09:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D84C60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW5/pw6s
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a60f90a924so888142b3a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Nov 2026 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612847; x=1794217647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y3+gPSeYwDPGYWTnElZIx43Pcw1WxgOGBpOWJAlZDg0=;
        b=jW5/pw6s+475EzX6+ac9QfNwT9Hbc1xdssMVii92Mo0bZLlUep30yq7pBXEH/ntmKB
         QTRNV+NHNX4eXR2UEPmSopl64jgeWpa5MI1i/0EruT21jNw33QD6dmqJM8s+diHA0SXF
         4TEcz0HJKxC6zPEThoi2P9ZahJMoTRf+yyaEqQPWVDK3DNAsazgFxqQoVR9zoJMSs5RH
         jrweA4f0kZSQVDw5b1LPjj13pW1UrgysZzG4qSu2izUrZVZpwCOGGnb8y68FYePCZ+m6
         zX7WWNFyk+XUdS8XrjRlrg5t1RcnitTJAE8lO78vczZ5aH/BB3dzse8fNGBjQktDVtpa
         oyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612847; x=1794217647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3+gPSeYwDPGYWTnElZIx43Pcw1WxgOGBpOWJAlZDg0=;
        b=BzJh+HLCHfYqdN+tvaI2CHpWckh6BTst2WG48mM8FkzP1nJoNM+VN+pvE7P08Sbzih
         SjRT4qkZ9dnd0XXaz1eVl7ZQLHGfLcZskxlmcP/4n73sjZjytqP1PQJg1YlLfEzpRWGT
         a3Ctr+aRnBiZzI9c50HcCgEIZN8lqOhZLjlAXKEOXTIMZlxvpIXLUVuKP88CbFepfmRd
         tCK7hlQ+zH8L3NhPqISKXn9GInJmWjBcqhymCwj9xOG6oaN9M14LKnA6Kgikz+KjxSu0
         EDqUI4Q8GU/ZuunkKqsA+VYebph0K5qNP810tgqrHEITjmFFyu4PtycAwABRSrk/7UgU
         pQmA==
X-Forwarded-Encrypted: i=1; AKwUvByTAVk1ks3IRrSCr6vHT0WRFUhYIOOZjXfKnNLIBXupeToaOuFk3cojiBr7qhpg+EI8ZtRMmG2kfXfnnHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqE7KRKw3xBrBkUu1D6B1V+hTsgMcgZmxZ3VQBOjy4z7NF/ixH
	1XZkL5sTTsSoEocaJMyGqGBQoEaU2Mu2P/A41fbmcueKcWkAFC4qp9yl
X-Gm-Gg: AYBFou3ck6auv20xP6Cl3B6zud8nfh6K59R15ubgomaJxQVesc+ZhSNFj68ziZamjut
	pAcVyh5sS2fk7OVihnCcoArm2S5IbWf8JEpChyTfoToEpfQQWvnGFntYLy6/pxfl+jZ6W1qNtHz
	0FGGn09lLl2+mMHPf30b6w4eZJROpbyBEUWLxqQgtxK6MKVkyj0ae9Ugh5C1D9x1p/JOgpC9ysq
	1ulP+vDRYgV2cNeGlpRBlAjcPq/tVT76ZeHbFjRPdI40iJEl+Ei3BnvXGqszT2J2dFuF/o8p0IP
	QFU+Yoi6/XqK2Vpw0sI0oxd6fpEVJQiMkV3ezBlCRhzXSXyzPP+TZOymZOPoQxgVHcrR2iltxUc
	GxR2gUoDEnGu0wb72wUyixBeh9hueLRyoiR4zyIE6KHcmzooQNxVkllC21j07FzETFxQdaHuiyF
	MbIO4vnMoZkuAOp66c/AalMUgMcLGchThL5XGhHG25VgGbu1gGsmE+2NX3i6dazxJfgNaqoGk9K
	2neF6TpLGpHMm6F5rHTwDnPz5nlvFyZNwfxiGxvDnKxpidDouBvD4+TCNyKMESzlzFr+kriIurz
	hn9lZBwvZuHrMblf4JWOp4FJFXvptaHpPp5x2CUUcZ3j54n8zTUkn1I=
X-Received: by 2002:a05:6372:a745:b0:3dd:a195:fa25 with SMTP id adf61e73a8af0-3e929074329mr6370502637.74.1793612846659;
        Mon, 02 Nov 2026 01:47:26 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm1802116b3a.39.2026.11.02.01.47.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:47:26 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Drivers: hv: vmbus: Fix the error paths of channel setup
Date: Mon,  2 Nov 2026 17:47:17 +0800
Message-ID: <20261102094719.35760-1-izaiahsun@gmail.com>
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
  clean the channel up a second time (patch 2).

Testing: QEMU (x86_64, KVM, kvm=off with the hv-* enlightenments,
vmbus-bridge and hv-balloon) with KASAN, hv_vmbus and hv_balloon as
modules loaded from init after failslab is armed, on mainline
d135ab453a74. failslab is limited to allocations under
vmbus_device_register(), and fails the N-th one when the hv-balloon
offer is processed. Without the series, every run hits the BUG_ON:
24 of 24 with the failure in device_register(), and 30 of 30 with it in
the channels kset, the channel's kobject_add() or its sysfs group.
With both patches, all 54 runs leave the offer unbound with "unable to
add child device object" and report nothing (no BUG, KASAN, WARNING or
refcount_t message). The sub-channel path of patch 1 is not covered:
QEMU's VMBus offers no sub-channels.

The failures need an allocation failure while the guest processes a
channel offer from the host.

Yuqiang Sun (2):
  Drivers: hv: vmbus: Keep the channel when vmbus_add_channel_kobj()
    fails
  Drivers: hv: vmbus: Do not remove the channel when device registration
    fails

 drivers/hv/channel_mgmt.c |  5 +++--
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 43 +++++++++++++++++++++++++++++----------
 3 files changed, 36 insertions(+), 13 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

