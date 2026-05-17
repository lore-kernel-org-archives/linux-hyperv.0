Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E3311946;
	Sun, 17 May 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027337; cv=none; b=hIRUwk8Yl4fcG7baSWjRtuWILWRd1afVNFAdeDJWb0O35Jy+ruY8nOCkQXKqHmFdOK/PJZJTj4/NzhcRtPVWNL/YYIFKdRk+v9X43tciXhA97jKqAcgCVlVbz6Os58W/4SC1vby7fthdrWWoVTgnY8b3LFKiPOkO/1x/a2LhMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027337; c=relaxed/simple;
	bh=fFB0FdHZ7J6jWG0D96qGbKUQ4VEQLudrPJuUMrSieBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHqaFodxDJoEXXfRjH+hMN57zPdWAz9DmY+3p8Qv2dXc0aJTa/NysP6oNFBm9J80dPNqI9ZY3ZrlugFYliXECW6sqZLUoofTW08pPCeOzEbjJcv2JCA8OgkxMAXdX8XaTzqi9LgpZ0xvES2nOZdULMxO5JS/N21Wy0HdHpmGKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=gZXHDU0h; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="gZXHDU0h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qMNdWleJAyyXRPfAgARUZHHfO8D6SfRFtzZ2O+6AJUs=; b=gZXHDU0h97/hJ0rt3WX8xMp897
	Yy8KVei6rnJ1XaNaa8cnORqUlvyflSUG5lgc2KIVNQp9GrFeOw4q0pKLEc7/C0PONysCPg5q810U3
	OPVcmMIb0gyGflWmIYdM/KOyd3I7iuvJnO07hfruO4LNpVo2Pwh2yuBzdyZYdutDhELApr5a3LCFz
	zArE+Mz8gvCIR0Ky2Q8twil6iFB4aQ0KoU9LXk1oTMVoHnn76EH5mzcq511DPH3HXsNAf6mn/AyWz
	uUJ7VQXwRvtLAVZU5m/Vw29x/ems4bv56mhqY8urXUXgYOHvYrzc46BgjO4vb9vvVJrMzQfZpDOvu
	KAvvdyYA==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcHC-00HFSV-2m;
	Sun, 17 May 2026 14:15:31 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v2 0/2] drm/hyperv: harden VMBus message parser input validation
Date: Sun, 17 May 2026 16:25:00 +0200
Message-ID: <20260517-drm-hyperv-cover-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517134926.B4179C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: git-send-email/2.47.3
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

v2 folds two further issues into patch 1 that the sashiko-bot review
pointed out on v1:

  1. The resolution_count bounds check in v1 returned -ENODEV, but
     hyperv_connect_vsp() only logged a warning and continued without
     setting hv->screen_width_max / height_max / preferred_*. That
     left dev->mode_config.max_width and max_height at 0, which made
     drm_internal_framebuffer_create() reject every userspace
     framebuffer with -EINVAL. v2 falls back to the WIN8 defaults on
     that error path, matching the pre-WIN10 branch.

  2. The three sequential VSP requests in hyperv_connect_vsp()
     (negotiate version, update VRAM location, get supported
     resolution) all wait on the same hv->wait completion without
     calling reinit_completion() between requests. A delayed
     complete() after a wait_for_completion_timeout() can leak into
     the next request and let it parse stale data out of
     hv->init_buf. v2 calls reinit_completion() before each send.

Patch 2 is unchanged from v1.

v1: https://lore.kernel.org/r/20260517-drm-hyperv-cover@berkoc.com

Berkant Koc (2):
  drm/hyperv: validate resolution_count and harden VSP request paths
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 32 ++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3

