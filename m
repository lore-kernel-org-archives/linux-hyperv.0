Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DD344D8D;
	Fri, 19 Jun 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848440; cv=none; b=knRDxJ2Qdtm4BRyRqjPCoCy8mjpXYO8Dbck2fmeijyrtfBSvg+nApQnWmUvpG3t5XlIwKF2JsENqJHa2cX8h4Y8IMUVi5fn62/KoWc/qWTHJ6BjgtWqO//waFWuPDStwVsrAvlHjjG76uQHxqSCFijBVZ3FPv8i8aze5fvipvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848440; c=relaxed/simple;
	bh=/GYwtyj4OiwSnfQ1NkHHQpVoUWEX0p5XIzUtXUf6Fgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ijG1aRlm2p9kO6V/SYSfTUeMa1pf5wuxIDxQagb18sUZUfcaG2xVd0MyHuOi9iE/mK3FABmWo0lZ025WLaHwVD9EuOhfpTqB/uQ7I5DhMwN4rKrJIUIoFn+0AioP5E6w02jHSiDwHHzGXozL55I/1tXKoOa6x9C/lQwcwf36T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CVomVZZI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CVomVZZI"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7786820B7168; Thu, 18 Jun 2026 22:53:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7786820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781848432;
	bh=djzZlvhhSVxdzxt5Tfjo+wj0N0UWQ5SDaG8r7yyi7oQ=;
	h=From:To:Subject:Date:From;
	b=CVomVZZIgStxfhkcyelsx9ZfoAg2ofDMrPEhYWSHWom7owo3p61oBd2gr0gP4/nL/
	 WgrexreV8oAx/lrUxeSAH5kloCBvk+TwuHrnTu9RLDrqbsm3LRYhEtoY/dORLIV8H8
	 pEN93sDZvrjyJvXoWBx1Wl4EmWpPMI2JXwzNL/UA=
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
	dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	jacob.e.keller@intel.com,
	ernis@linux.microsoft.com,
	horms@kernel.org,
	gargaditya@linux.microsoft.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0
Date: Thu, 18 Jun 2026 22:53:38 -0700
Message-ID: <20260619055348.467224-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d7709812e13d ("net: mana: hardening: Validate adapter_mtu from
MANA_QUERY_DEV_CONFIG") rejected any adapter_mtu value smaller than
ETH_MIN_MTU + ETH_HLEN, including 0, returning -EPROTO and failing
mana_probe().

Some older PF firmware versions still in the field report
adapter_mtu as 0 in the MANA_QUERY_DEV_CONFIG response. With the
hardening check in place, the MANA VF driver now fails to load on
those hosts, breaking networking entirely for guests.

MANA hardware always supports the standard Ethernet MTU. Treat a
reported adapter_mtu of 0 as "the PF did not advertise a value" and
fall back to ETH_FRAME_LEN, the same value used for the pre-V2
message version path. Only jumbo frames remain unavailable until
the PF reports a valid MTU.

Other small-but-nonzero bogus values are still rejected, preserving
the original protection against the unsigned-subtraction wrap that
would otherwise let ndev->max_mtu underflow to a huge value.

Fixes: d7709812e13d ("net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c |  3 ++-
 drivers/net/ethernet/microsoft/mana/mana_en.c  | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index b5e9bb184a1d..53308e139cbe 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -237,7 +237,8 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 	if (prog)
-		ndev->max_mtu = MANA_XDP_MTU_MAX;
+		ndev->max_mtu = min_t(unsigned int, MANA_XDP_MTU_MAX,
+				      gc->adapter_mtu - ETH_HLEN);
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 87862b0434c7..7438ea6b3f26 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1233,12 +1233,24 @@ int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
 	*max_num_vports = resp.max_num_vports;
 
 	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
-		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
+		if (resp.adapter_mtu == 0) {
+			/*
+			 * Some older PF firmware versions report an
+			 * adapter_mtu of 0. MANA hardware always supports the
+			 * standard Ethernet MTU, so fall back to ETH_FRAME_LEN.
+			 * Jumbo frames will not be available in this case.
+			 */
+			dev_info(dev,
+				 "PF reported adapter_mtu of 0, falling back to %u (jumbo frames disabled)\n",
+				 ETH_FRAME_LEN);
+			gc->adapter_mtu = ETH_FRAME_LEN;
+		} else if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
 			dev_err(dev, "Adapter MTU too small: %u\n",
 				resp.adapter_mtu);
 			return -EPROTO;
+		} else {
+			gc->adapter_mtu = resp.adapter_mtu;
 		}
-		gc->adapter_mtu = resp.adapter_mtu;
 	} else {
 		gc->adapter_mtu = ETH_FRAME_LEN;
 	}
-- 
2.34.1

