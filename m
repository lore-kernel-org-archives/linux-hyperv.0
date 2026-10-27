Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119663;
	b=yGS2pbZ/cLf6LbYcPE972jZIovw2Kg5J6pgWeyrKXV/CUjSUEV0dmGukKjvB7R3pFrvT
	 W9DdhY3GRnmCI445fe6y2vVuUeNmt3ScQjBv9R7bPAme7D3CVm+iUD2Cn8og2JhwUe52Z
	 8ivqSoz7LIcAObkHlzvZj/K+yJYi6iCbCpk0lFX4ivTvJKCzfPEygur5ewLcYW7zqofuX
	 3EUoEA7D3FOSW5ciLUMmLKb+mm6pH1R7LuXvUSZ0Mtq6MMif2DZo3n4Ej/tH120qlDIBT
	 ukexsKgs/mIMRnCz7xxJGE65T1nzxgKXD2bmT0pn5rU2k77sb18xGDWyZLaR/r3dd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119663;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m/2Ts66a5u4FX+7zqnc7Voow1WkE+bXtztEL+Nbsbm8=;
	b=L+wtcsrws4niz4LVKsQhK+mG7/XrZrVeHrutW448ysdHQDzsVucbOogo0UKw3IccaGdm
	 VsHdb3j/a7ZRe2mYKwUq+uic16wMCeu1JO/7qVEZFyGMk0hhupP+7BrQBZruNKUb3S3fK
	 UTwFULBrXtrKTCQgaA8B3+Zg6XERqK938lJocmZXwsS1lOSZYlrR8rwT7IRMDp+3CthlC
	 svKhQrOaW6pgCYVbrIlVOUgiQX6DUGxokRcaKJXb/4hdMexFv+OS9BWOu1vpsZnpiKsH1
	 lzFT+DLnI7PdMprXM0lgSJTKhQXLF6otGy+ChAH7xDuSRS/1qayxGZVRJKparwBIzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Gi4tZAQv;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC8606A31A;
	Tue, 27 Oct 2026 16:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5CC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Gi4tZAQv
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 973C320B7166; Tue, 27 Oct 2026 09:47:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 973C320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793119651;
	bh=m/2Ts66a5u4FX+7zqnc7Voow1WkE+bXtztEL+Nbsbm8=;
	h=From:To:Cc:Subject:Date:From;
	b=Gi4tZAQvosiqU8lFHJR/9opedZiDwPQe28RMz3rx/liA/YCiaJdgd0kVh3Pv+p8WX
	 PTd+l1u/HCDo6xAXr6UwT4bEDij6MRkqJQ8Y6dvm/J4gtwZYy8NuRaDSkfCTVUkSNM
	 0pX/psfTi+ox78h5+wEFBpWHZkPHrp6Uq9Lv3UHs=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	lkmlabelt@gmail.com,
	parri.andrea@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Wei Liu <liuwe@microsoft.com>
Subject: [PATCH net] hv_netvsc: Stop PPI parsing on invalid metadata
Date: Tue, 27 Oct 2026 09:47:22 -0700
Message-ID: <20261027164722.3393397-1-ernis@linux.microsoft.com>
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

rndis_get_ppi() uses continue when a per-packet information entry has an
invalid size or offset, or cannot hold the requested metadata. However,
the remaining length and entry pointer are only updated at the bottom
of the loop. Each error path therefore retries the same invalid entry
indefinitely, repeatedly logging the error and preventing receive
processing from completing.

Return NULL on these validation failures instead of continuing. This
terminates the lookup when malformed metadata is encountered while
preserving the existing behavior for valid entries.

Fixes: 44144185951a ("hv_netvsc: Add validation for untrusted Hyper-V values")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wei Liu <liuwe@microsoft.com>
---
 drivers/net/hyperv/rndis_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9b6c44979b4e..2c30abf9faf8 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -401,12 +401,12 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 		/* Validate ppi_offset and ppi_size */
 		if (ppi->size > len) {
 			netdev_err(ndev, "Invalid ppi size: %u\n", ppi->size);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->ppi_offset >= ppi->size) {
 			netdev_err(ndev, "Invalid ppi_offset: %u\n", ppi->ppi_offset);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->type == type && ppi->internal == internal) {
@@ -414,7 +414,7 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 			if (ppi->size - ppi->ppi_offset < ppi_size) {
 				netdev_err(ndev, "Invalid ppi: size %u ppi_offset %u\n",
 					   ppi->size, ppi->ppi_offset);
-				continue;
+				return NULL;
 			}
 			return (void *)((ulong)ppi + ppi->ppi_offset);
 		}

base-commit: f71ff7d406523748bfb8236830c7eaa6a308aaa1
-- 
2.34.1

