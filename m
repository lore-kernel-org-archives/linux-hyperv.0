Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607159;
	b=H1iROuQEde/fg5Z+wGi92IvpndzX/s1sR+mlN2oE0FUVreW/r/lfzlojnQ8uebEUueGx
	 WRhYYpPJMN7nPJELoY9/pXhxvdEdwC0LkGGP7UyQZDSlP0F1Jco8ZWwMHvOOvn+gebE6N
	 6OJsR9EtCNZAPtPxNfyYEs1I3N1GGG3QoTyvbD8Gbmh/ocmmqhrQvnJdv9LPDsRkYVE0T
	 4LA+yvOViHq5CECwr/XWPMdO7sf3pAiwzWXT79wdkqdtoAsaTExmiBknhZF/kXp1xgQAD
	 Jk8rfc+aqwBxUciVDwhNUslBLIxP37BOSu/G4+JgarUOlzBzoszfW4Kfne9jlG1xOhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607159;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9q36xcqcPHv79osOmUzmklHxC1KdUdQyrZQoKuIzqPA=;
	b=r3kdtiLMiyqrhMBaoipNSm+1gybQ8XbYklZnEMcrwUjhI45EMWtbCnprQ3nzgichr6Kd
	 v8HSP0IE3o8cWEgbqYPk78y+B4ADH61Y3wnpyXYZyZ5rSPxk5IB23MlkwrE7uEYXUCWt4
	 otGENcvmm2j5CSU/0i+MU8Iy9DU7L07ZuUVqsdo9slF3YQqIU4c7rV4tbdZOQ4m/SvGn6
	 Y5iJIZnV8F4nBPAp4HIm9YZ9UqtifXrG5sGTmJYqBC0VUGiqMzyehLi7L9IZVZXRfPpcq
	 M32iShhOQbUisc8mUwpjOwlO7ec8O8crdvLJpkxC1zWbR8WS56BiKpyIZmDkzxtuQVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K86REYZd;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A6A606A338;
	Fri, 13 Nov 2026 21:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A6A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K86REYZd
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6039C20B7166; Fri, 13 Nov 2026 13:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6039C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794607154;
	bh=9q36xcqcPHv79osOmUzmklHxC1KdUdQyrZQoKuIzqPA=;
	h=From:To:Cc:Subject:Date:From;
	b=K86REYZdGEcMQ9Wu/gsmiej5UcvfsjLHYNPn5tkQMZa1CFLWKuo4yU7x1W64msWxs
	 lAj5Po9k6Pu1DDe+TmIveFD8Aa2rq37ue8JW2OHlIX89PAg2nS6rysH9bipz/IRHLo
	 fn9y8Hou3ESUkUDc/Evgc4/2kC1X3/MaZprWRynY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Date: Fri, 13 Nov 2026 16:58:41 -0500
Message-ID: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
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

I was doing a deep dive into the host spec and noticed some gaps. So,
I went ahead and hacked together the patches in this series for items
that seemed worthwhile to address.

Hamza Mahfooz (2):
  drm/hyperv: add modes for all resolutions offered by the host
  drm/hyperv: batch dirty rectangles

 drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++-----
 4 files changed, 110 insertions(+), 20 deletions(-)

-- 
2.56.0

