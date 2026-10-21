Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593252;
	b=ydulV2j5/W3eI1xxHpPyaHT+dQiMbT5WznCAz03rnF3pjRWKu4V82lhvXQr/CFCwwR9U
	 YTWuyenMcL76a/Bor2KUCyjZUquvqKI7510bdcq+uKj5/oACNbOMLo9Tu8Hj9x7WPhcD9
	 M+95oys0lVY0RPBEa9rDP7ap2kkBEBeSK7i6NC3IQf7vZIQ9zA3mEf4uXjSnK/xCCVzE9
	 DNIbnq4/u/HBUp7BsakCYyne9eIfhuTuI6LbUIx1L6yr1XF0FsF3LHT5LZSHkozanGgeO
	 RQLe9GsI2JJpiakaPWyswyKhOwHTIzlv38pYAmF6e4MfypHf2gfYG4kjuZWDN2ZX8eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593252;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Nx0qgkybsNE9yscBKO0SArCQmcvq4TeybQ4JjP3eo/k=;
	b=LSrjrugmXybmV6gGs9hRCrWQcmSPYnz2BFCF5OfSTE+6gjzYKoUHGnn6x52rzl5UMySP
	 iKzPFd+/MVxEN/GtjKRKPNuM3RIdFeUwSkEpkO5W5YfsilnhnOfYL8ZYmx8HsGM1MPffU
	 hLSQAsS+hBfVwLgJcvsnuora38xFNOidRyArCibDO7Edtn1vCa3JKVJpOcp9nog0q85H+
	 4tfzZbow7w0gMCyvazaLqofrQoWq4UE/dmV3OS8tdWtLUwkl0aP5v0rxK0zhlywOAiq8Y
	 NjDQeIqvxi3Oq0iucs55aPqvdiHTTLqkXq1arXeUs4ac90d0yCTE3jhU2GA0B0LEtLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Yj4k43eR;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47A606A31E;
	Wed, 21 Oct 2026 14:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE47A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Yj4k43eR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nx
	0qgkybsNE9yscBKO0SArCQmcvq4TeybQ4JjP3eo/k=; b=Yj4k43eR/MlvxD/9oX
	tZOIcoANaG2nTTdf2s4XxyTZ+vzHT4lwdnREOg32iWUijZ75RZbjtBm7NjSFRp6G
	Skv1sEwEUd3nR3ta77HIXlgIdMy5U32+P0FQn5WWBWtlDsPFHsd5MBCEEGCAAB8/
	nFAjlhAt3AZC0D0kkXnRygaZQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHt6Uzzdhqp3_gBA--.20120S2;
	Wed, 21 Oct 2026 22:33:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: fix dynamic ID races
Date: Wed, 21 Oct 2026 22:33:21 +0800
Message-Id: <20261021143323.338146-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PygvCgDHt6Uzzdhqp3_gBA--.20120S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfKFyDAw13Jw4kZFW8JFb_yoW8WrWDpF
	saga43ur1kJryxuanxur10gFyruFZ7JF47XF97W34xWryUZF13XrWIvr40vryrJ39a9anr
	XF40qFZ5WayYyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpKZAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhdRi2rYzTcWEgAA3P

VMBus dynamic IDs have two races with their sysfs add and remove paths.

First, new_id_store() checks for an existing ID separately from inserting
the new entry, allowing concurrent writers to add duplicate GUIDs. Move the
check and insertion into one critical section.

Second, matching returns a pointer into the dynamic ID list after dropping
the lock. A concurrent remove_id write can free that entry before probe uses
it. Copy the ID while holding the lock and reject probe when a dynamic ID is
removed between matching and probing.

The series was found by static analysis and checked with checkpatch.pl. Each
patch was also checked individually and in series for application to the
base commit below.

Jiale Yao (2):
  Drivers: hv: vmbus: prevent duplicate dynamic IDs
  Drivers: hv: vmbus: copy dynamic IDs before dropping the lock

---
Changes in v2:
- Split the dynamic ID insertion TOCTOU into a preparatory patch.
- Reject probe when the matching ID disappears before the second lookup.
- Preserve the ID-less hvsock probe path.
- Use scoped locking and memcpy() for the dynamic ID copy.
- Document that the device ID is valid only during probe.
- Cite the corresponding PCI and USB dynamic ID lifetime fixes.
- Add Cc: stable@vger.kernel.org and use the VMBus subject prefix.

Link: https://lore.kernel.org/r/20261019085544.1834700-1-yaojiale02@163.com

 drivers/hv/vmbus_drv.c | 56 +++++++++++++++++++++++++-----------------
 include/linux/hyperv.h |  1 +
 2 files changed, 34 insertions(+), 23 deletions(-)


base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.34.1

