Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084230;
	b=eugILcwFIT5keE3LnAUyyt7JDt2//jb3YztPxrZPI1ooUmoXyNir8eLUTln+JSmm7irE
	 O4YLBOIE6+o9mb7Gxe9xPqjC/IeBBGgJwGMMI/HdgIH+s31JXW8MqUXqXJzxuF3SNCjst
	 49MdCbrh9HiWYJUKFQ9i1UmhxW3ue+FO37P3M2EmG1B29rP9phAwQVwWnvAQWago97KO/
	 gfgVojBKce13lAHEJpOL4triFmZ9831srGocE0Is3q4Ejp6Q04pdNoIVwnPd4jyrLO551
	 A8Y0apQLYwZD8fMm9jwkrBJ2U9ygTAA2p1VJEdiW8b8ONJEGTpLH1J23phBuVu+xpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084230;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LiPMu52CARY7rVKxuDidMW+6zVtB1pO5GM/YkydEYdY=;
	b=BfpARnFNFhrA5RP+c1Lj+fcgoizMmFSmQDvO0upS6MRXHOQmhORGgxUKASSle1wzL8aQ
	 AtYAjpcXNmGxBZWnYhkHBuFgouw358fInXKwaC0ebP74iGLPdCO9Lbs12l0MQAls3/QNH
	 cFT20cXpxVqpqUG9lovFxJaZIofkmry59iWwkaW3sCj1Y1iIB06bzpunjAP4Nirbsxarh
	 WKRP4a/0HDYouk/lW3M0yAHXxYy5G6rJ/64X1AhgWsE7cRc0W+3c9ojjpO5e+vbCED48i
	 FhohXonU/vIm9z06SoZvVXDA+1mqTORYMK2Lle5Yzne50iHdnfnKX0+pQstrOGYoDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F5QvFFWf;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DA606A321;
	Tue, 27 Oct 2026 06:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 417DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F5QvFFWf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Li
	PMu52CARY7rVKxuDidMW+6zVtB1pO5GM/YkydEYdY=; b=F5QvFFWfmw+vvlrsJz
	G8s3IqLlZeczdl0gX/eVi34pVMcmHoE/A4I90MRzoU3D002AKgJKcvmzhAOtfm3Z
	UtuHBivTUL1u31mJDOK/8i9E9pVPvGlKOS9Cux5N6cc1FPHyPxOZuxhBi8H8Ck6C
	T/4TdL+GPesxFyW6+XyT16uw4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3f3srS+BqJPR6DA--.54486S2;
	Tue, 27 Oct 2026 14:56:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Drivers: hv: vmbus: fix dynamic ID races
Date: Tue, 27 Oct 2026 14:56:40 +0800
Message-Id: <20261027065642.2280297-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3srS+BqJPR6DA--.54486S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfKFyDAw13Jw4kZFW8JFb_yoW8AF48pF
	ZagFyakr1ktryxua9xuF10gFyrAF1fJw42gFnrG34xWFyUZF17XF4Ivr40qry5J39Y9Fsr
	XF10qFZ5WFWYyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHv3nUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgyw6mrgSyylyAAA3Y

VMBus dynamic IDs have two races with their sysfs add and remove paths.

First, new_id_store() checks for an existing ID separately from inserting
the new entry, allowing concurrent writers to add duplicate GUIDs. Move the
check and insertion into one critical section.

Second, matching returns a pointer into the dynamic ID list after dropping
the lock. A concurrent remove_id write can free that entry before probe uses
it. Copy the ID while holding the lock and reject probe when a dynamic ID is
removed between matching and probing.

The series was found by static analysis. It has been regression tested in
Azure by Kameron Carr.

Changes in v3:
- Keep the original declaration order in vmbus_probe().
- Add Kameron Carr's Tested-by and Reviewed-by tags.

Changes in v2:
- Split the dynamic ID insertion TOCTOU into a preparatory patch.
- Reject probe when the matching ID disappears before the second lookup.
- Preserve the ID-less hvsock probe path.
- Use scoped locking and memcpy() for the dynamic ID copy.
- Document that the device ID is valid only during probe.
- Cite the corresponding PCI and USB dynamic ID lifetime fixes.
- Add Cc: stable@vger.kernel.org and use the VMBus subject prefix.

Link: https://lore.kernel.org/r/20261021143323.338146-1-yaojiale02@163.com
Link: https://lore.kernel.org/r/20261019085544.1834700-1-yaojiale02@163.com

Jiale Yao (2):
  Drivers: hv: vmbus: prevent duplicate dynamic IDs
  Drivers: hv: vmbus: copy dynamic IDs before dropping the lock

 drivers/hv/vmbus_drv.c | 52 +++++++++++++++++++++++++-----------------
 include/linux/hyperv.h |  1 +
 2 files changed, 32 insertions(+), 21 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.34.1

