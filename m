Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB613A1682;
	Thu, 30 Apr 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538220; cv=none; b=JVmqZpfedTPZjpCH31+GBVPFFbi1TEpuYIaIv3VtJUoPmwSqN7LtcKz96bqPo8lFHoxTt9NIPzDY/GXyp/BfcBJAR2xZYHO9u/N3ieNOe6YPfBeBdhSh/4eBqSanzQcwiLuPIV/I8ylTCEY9bGzsQpcOusS/oFP1jts5noHFToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538220; c=relaxed/simple;
	bh=MozMMJs8fS8PLP0Djdx/pRPBejh+q+ODpmtZRJFKZ6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQKqHy9Gkjpnhqqvou8V0ywvj2+gWPSFRGOa4n/yORs/SqCEXTsSo63iJ2VkLNuo+BrusCMdL4H3cJV4EMIOLDxm9rdi9JloQ9st+P3ERg0GnPcXWj72wPDaHgkvFWpgZQFHR14Wx+V5fL5ofAo1D03Dil/D/JsHy+flSdGwJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f5TZtCI2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f5TZtCI2"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3A36F20B7171; Thu, 30 Apr 2026 01:36:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A36F20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777538219;
	bh=BXdR6zC2INdeS+kRaeghfM0RXrRs2D/9qDuarIYdiho=;
	h=From:To:Subject:Date:From;
	b=f5TZtCI2hhRZNrZ4OBSKg/y0SiDVtVqt26BEU3B2VD+St/HbEmLewaZzRTKKW9l59
	 kE1Wm0l/17nGpK/QwS88zCJLDqv+TgbuYaFhnhdGzfGDlQY/GvaroQSxYZYIPavOer
	 RookomLwPyjQ9MAk/OLz8UMQ9AsJROBbY7pQ6XGI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: hardening: Reject zero max_num_queues from GDMA_QUERY_MAX_RESOURCES
Date: Thu, 30 Apr 2026 01:36:21 -0700
Message-ID: <20260430083627.1873757-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a CVM environment, hardware responses cannot be trusted. The
GDMA_QUERY_MAX_RESOURCES command returns resource limits used to
determine the maximum number of queues.

In mana_gd_query_max_resources(), gc->max_num_queues is initialized
from num_online_cpus() and successively clamped by the hardware-reported
max_eq, max_cq, max_sq, max_rq, and num_msix_usable values. If any of
these hardware values is zero, gc->max_num_queues becomes zero and the
function returns success. This leads to a confusing failure later when
alloc_etherdev_mq() is called with zero queues, returning NULL and
producing a misleading -ENOMEM error.

Add an explicit zero check for gc->max_num_queues after all clamping
steps and return -ENOSPC for a clear early failure, consistent with the
existing gc->num_msix_usable <= 1 guard.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Rebase to latest main.
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 098fbda0d128..f3316e929175 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -194,6 +194,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	if (gc->max_num_queues == 0)
+		return -ENOSPC;
+
 	return 0;
 }
 
-- 
2.34.1

