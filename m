Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E43303F;
	Tue, 15 Sep 2026 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446721; cv=none; b=uWHLLHr493lwT0aLNPifi06S6NsXbuiHfSjQBcfqfOdUAkmpe0qg7SGfsOxyhv00vPqRyX5csnjliawOyNYw/8LXzVHgQne25PuWu2P0RXk1pjmQEW3ECMRxvJ2Mk2wCw4VjvyQc0Bfgj9fdNH4a7rsRX+d7MXnjL7n9gHACIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446721; c=relaxed/simple;
	bh=xSOJF7tiGkI6PdJW59IFPB02KbCFGmrVkOZnTd2e5Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYpWWB1PMqdnqMWzzUeYq6Atykdqyo8m6xS6T7BVbQBMAmoUxsHu34G2MzLJsW1265ToCddbqIhI3tu22tkLE9UpIEqQeA3185LwHjOlckiPeFHSUsUne+OuIow357A7o31HUfEHnG7ywhNZ+ZIz+ThLYaqhzdIAAKxz69rjaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvOp036C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvOp036C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905751F000FF;
	Tue, 15 Sep 2026 04:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789446712;
	bh=T0CVGKLgiIv6P0wOTqNaS63DygnR5tJwVWFpbGJX3YQ=;
	h=From:To:Cc:Subject:Date;
	b=dvOp036CuR+M7KMMWtke0gib9BPx5QuCIaDjAvjy3Q9pfT08RVeJo8YVPkNHdE1Jv
	 cHyOTUNAFi/k61+BV/0MC9IsQ+hNbyTYrHk7iOL72AL7YabKnt1x32vgrS0I6zaziv
	 1zvqMiA97xRhHFMBfoieddWHanmRl2Z/O+qQxYs3hSJLmaQJRozfXQUrT3GKvC1jg7
	 VMS4il4dtrRxm9rVyIIYvsScMDom5crWl2JHYqmMPCrBeHcnUKJm/YSBF/r5bf3xqj
	 sH3tLd+iUtcmDy6kRAHKkcHrSN2BzDP/1YlE9wQioFq2Wrof/isLztyl5Cbt68kxoq
	 rnF/tpN18vqYQ==
From: Long Li <longli@kernel.org>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: ssengar@linux.microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@kernel.org>
Subject: [PATCH] MAINTAINERS: remove myself from the Hyper-V entries
Date: Mon, 14 Sep 2026 21:31:50 -0700
Message-Id: <20260915043150.10521-1-longli@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am no longer maintaining the Hyper-V/Azure core and drivers, or the
Hyper-V synthetic video DRM driver.

Signed-off-by: Long Li <longli@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee9328178..7df36a2b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8168,7 +8168,6 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
 
 DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
 M:	Dexuan Cui <decui@microsoft.com>
-M:	Long Li <longli@microsoft.com>
 M:	Saurabh Sengar <ssengar@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
@@ -12162,7 +12161,6 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
-M:	Long Li <longli@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
-- 
2.34.1

