Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240011;
	b=xgb7+SV5Wlu+vPAlfnripibo93qwiYMer2UQL1wfOFuzZDIWCBA2ZiULg1H3ju82Dn9Q
	 /tQnA+JMRMyvkxD98mdW6+GHWoB/8/WoEKzuUKxrWSBAm3mdtuxzutH7+UcDbXeSVkzd6
	 DGwZDS3sIbHSywBlwRo8B/MeSyhqgQ5t9w8FkJrQtTp9l2KBoMyFElY9rNem2o8EI3svy
	 9IjkZAZ3J8Dqj5SkR5F+RcuiELdCSraD0Zj+kxedy0HHrSwSVK6XTgj1D1id652LTVkFO
	 vJAqC3hdVdGXePbYiEF2H+PAw/rPEum4Mc6YgaRcXMvGMTTFm+UxVCC/t0ZoJhJI1jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240011;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cs2lqF11RzOrHVpmwFStyy5G5LKigZcq3ui+D4iT+2E=;
	b=OUeDwWpGhBYlu29oEkAhGFVm7UphEueZgTKV8DfQp7HwBWdWDxBfZh4hc4AhsnnHYikg
	 7KkXs5b8zq8r48jqheqKNriYoRVZfArlhoMttyI59cNpZsXZ37MblGLslGVnMUb71xpo8
	 y3jbCl5M17wc7H41ou3lU8SEUaviOYsTEzuxm3Nu4rcxeb5XLADpL8MfknC21bPYrKuWC
	 4jrZ4nsM8BIRg7Qy9LhxZGSx5THSebEok8qIeu0vvGQoONANPWvgnnlGPLn4PkmIM8LDt
	 YPbRh7LkWEpn7MCW8jkUlSEV/0jbmaX0YFgQQjmyFonDQthjncaks2EWh7c8rNt95Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q+UMHwju;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B78606EE96
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Nov 2026 16:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B78606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q+UMHwju
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A0ABB20B7169; Mon,  9 Nov 2026 08:00:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0ABB20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794240008;
	bh=cs2lqF11RzOrHVpmwFStyy5G5LKigZcq3ui+D4iT+2E=;
	h=From:To:Cc:Subject:Date:From;
	b=q+UMHwjuxbOZmJqPztrqfb3K03CpCctIFwk9zSysiHW2ktSHzuFaeqwM7x94DrtDb
	 pEC9fP1tTzVz4/VpkcIFqFNWXBPe8VT40v6+LrVG9g65ib7Fv1wDymPERrAUX/GSdV
	 y6jjktuneaUdU4iT86vyr+itST8/OOfBUWUhFARU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V DRM driver
Date: Mon,  9 Nov 2026 11:00:04 -0500
Message-ID: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

I have been informally co-maintaining the driver for some time now,
so make it official.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c10342aa32f3..63b70f3da896 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8359,6 +8359,7 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
 
 DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
 M:	Dexuan Cui <decui@microsoft.com>
+M:	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
 M:	Saurabh Sengar <ssengar@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
-- 
2.56.0

